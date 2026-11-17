<?php
declare(strict_types=1);

require dirname(__DIR__) . '/app/bootstrap.php';

$pdo = db();
$pdo->beginTransaction();
try {
    $username = 'smoke-' . bin2hex(random_bytes(5));
    $pdo->prepare('INSERT INTO users (name,username,password_hash,role) VALUES (?,?,?,?)')
        ->execute(['Smoke Test', $username, password_hash('temporary-test-password', PASSWORD_DEFAULT), 'Viewer / Management']);
    $userId = (int)$pdo->lastInsertId();
    $testWorkbookGroup = 'Smoke-' . bin2hex(random_bytes(5));
    $pdo->prepare('INSERT INTO workbook_groups (name,created_by) VALUES (?,?)')->execute([$testWorkbookGroup, $userId]);
    assert_true(in_array($testWorkbookGroup, workbook_groups(), true), 'New workbook groups should be available to the system.');
    $pdo->prepare('INSERT INTO user_stage_access (user_id,stage) VALUES (?,?)')->execute([$userId, 'bac']);
    $assignedUser = ['id' => $userId, 'role' => 'Viewer / Management'];
    assert_true(can_access_stage('bac', $assignedUser), 'Assigned BAC permission must be granted.');
    assert_true(!can_access_stage('ors', $assignedUser), 'Unassigned ORS permission must be denied.');
    assert_true(stage_grants([], 'Viewer / Management') === [], 'Viewers may have read-only access without workflow stage grants.');
    assert_true(!can_access_stage('bac', ['id' => 0, 'role' => 'Viewer / Management']), 'Viewers without stage grants must not edit workflow stages.');
    try {
        stage_grants([], 'BAC Personnel');
        throw new RuntimeException('Non-viewer roles must have at least one workflow permission.');
    } catch (InvalidArgumentException) {
    }

    $pdo->prepare('INSERT INTO transactions (transaction_code,worksheet,created_by) VALUES (?,?,?)')
        ->execute(['SMOKE-' . bin2hex(random_bytes(5)), '2026', $userId]);
    $transactionId = (int)$pdo->lastInsertId();
    $pdo->prepare('INSERT INTO purchase_requests (transaction_id,pr_number,particulars,workflow_status) VALUES (?,?,?,?)')
        ->execute([$transactionId, 'SMOKE-PR', 'Temporary test row', 'Not Started']);

    update_transaction_progress($transactionId);
    $record = transaction_row($transactionId);
    assert_true($record['status'] === 'In Progress', 'Recording a PR must not complete the transaction.');
    assert_true($record['current_stage'] === 'purchase_requests', 'The first unfinished stage must be current.');

    $pdo->prepare('UPDATE purchase_requests SET workflow_status=? WHERE transaction_id=?')->execute(['Completed', $transactionId]);
    foreach (['bac_records', 'purchase_orders', 'ors_records', 'iar_records', 'dv_records', 'jev_records'] as $table) {
        $pdo->prepare("INSERT INTO `$table` (transaction_id,workflow_status) VALUES (?,?)")->execute([$transactionId, 'Completed']);
    }
    $pdo->prepare('INSERT INTO payment_records (transaction_id,workflow_status) VALUES (?,?)')->execute([$transactionId, 'Completed']);
    update_transaction_progress($transactionId);
    $record = transaction_row($transactionId);
    assert_true($record['status'] === 'Completed', 'Every explicitly completed stage should complete the transaction.');

    $pdo->prepare('UPDATE jev_records SET workflow_status=? WHERE transaction_id=?')->execute(['In Progress', $transactionId]);
    update_transaction_progress($transactionId);
    $record = transaction_row($transactionId);
    assert_true($record['status'] === 'In Progress' && $record['current_stage'] === 'jev', 'A reopened final stage must reopen the transaction.');

    assert_true(normalize_value('amount', 'money', '123.4') === '123.40', 'Currency input should normalize to two decimals.');
    $trackerColumns = tracker_import_column_map([
        1 => 'PR Date', 2 => 'PR No.', 4 => 'Particulars', 13 => 'PO/Contract No.',
        27 => 'ORS No.', 33 => 'IAR No.', 39 => 'DV No./Control No.', 50 => 'JEV No.',
    ]);
    assert_true($trackerColumns !== null, 'The source tracker column layout should be recognized.');
    assert_true($trackerColumns[7] === 'amount' && $trackerColumns[22] === 'po_amount'
        && $trackerColumns[30] === 'ors_amount' && $trackerColumns[48] === 'payment_amount',
        'Repeated Amount columns must map to their separate workflow stages.');
    assert_true($trackerColumns[5] === 'quantity' && $trackerColumns[20] === 'po_quantity',
        'PR and PO quantity columns must remain distinct.');
    assert_true(convert_excel_value('pr_date', 'N/A') === '', 'N/A date cells should import as blank.');
    assert_true(convert_excel_value('po_released_time', '0.5') === '12:00', 'Excel time fractions should convert to HH:MM.');
    try {
        normalize_value('pr_date', 'date', '2026-02-31');
        throw new RuntimeException('Invalid calendar dates must be rejected.');
    } catch (InvalidArgumentException) {
    }

    if (class_exists(ZipArchive::class)) {
        $xlsxPath = sys_get_temp_dir() . DIRECTORY_SEPARATOR . 'ppt-smoke-' . bin2hex(random_bytes(5)) . '.xlsx';
        try {
            create_xlsx_fixture($xlsxPath);
            $preview = preview_workbook($xlsxPath);
            assert_true(count($preview['rows']) === 1, 'The XLSX preview should map the sample transaction.');
            assert_true($preview['rows'][0]['worksheet'] === '2026', 'The XLSX preview must retain worksheet classification.');
            assert_true($preview['rows'][0]['pr_number'] === 'SMOKE-XLSX', 'The PR number should map from its header.');
            assert_true($preview['rows'][0]['pr_date'] === '2025-12-09', 'Excel serial dates should be converted.');
            assert_true($preview['errors'] === [], 'A valid XLSX fixture should not produce validation errors.');
            $groupPreview = preview_workbook($xlsxPath, 'Smoke Workbook');
            assert_true($groupPreview['rows'][0]['worksheet'] === 'Smoke Workbook', 'Imported rows should use the new workbook group.');
            assert_true($groupPreview['rows'][0]['source_worksheet'] === '2026', 'Import preview should retain the source worksheet name.');
            assert_true($groupPreview['workbook_group'] === 'Smoke Workbook', 'The preview should retain the requested workbook group.');
            try {
                preview_workbook($xlsxPath, 'Invalid/Workbook');
                throw new RuntimeException('Workbook group names with unsupported characters must be rejected.');
            } catch (InvalidArgumentException) {
            }
        } finally {
            if (is_file($xlsxPath)) unlink($xlsxPath);
        }
    }
    echo "Smoke tests passed.\n";
} finally {
    if ($pdo->inTransaction()) $pdo->rollBack();
}

function assert_true(bool $condition, string $message): void
{
    if (!$condition) throw new RuntimeException($message);
}

function create_xlsx_fixture(string $path): void
{
    $headers = ['PR Number', 'Particulars', 'PR Date', 'Amount'];
    $strings = array_merge($headers, ['SMOKE-XLSX', 'Temporary test row', '46000', '123.45']);
    $escape = static fn(string $value): string => htmlspecialchars($value, ENT_XML1 | ENT_QUOTES, 'UTF-8');
    $shared = '<sst xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">' .
        implode('', array_map(static fn(string $value): string => '<si><t>' . $escape($value) . '</t></si>', $strings)) . '</sst>';
    $makeSheet = static function (bool $withRecord) use ($headers): string {
        $columns = ['A', 'B', 'C', 'D'];
        $headerCells = '';
        foreach ($columns as $index => $column) $headerCells .= '<c r="' . $column . '1" t="s"><v>' . $index . '</v></c>';
        $record = '';
        if ($withRecord) {
            foreach ($columns as $index => $column) $record .= '<c r="' . $column . '2" t="s"><v>' . ($index + count($headers)) . '</v></c>';
        }
        return '<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main"><sheetData><row r="1">' .
            $headerCells . '</row>' . ($withRecord ? '<row r="2">' . $record . '</row>' : '') . '</sheetData></worksheet>';
    };
    $zip = new ZipArchive();
    if ($zip->open($path, ZipArchive::CREATE) !== true) throw new RuntimeException('Could not create XLSX smoke fixture.');
    $zip->addFromString('xl/workbook.xml', '<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"><sheets><sheet name="2026" sheetId="1" r:id="rId1"/><sheet name="SPLIT 2026" sheetId="2" r:id="rId2"/></sheets></workbook>');
    $zip->addFromString('xl/_rels/workbook.xml.rels', '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Target="worksheets/sheet1.xml"/><Relationship Id="rId2" Target="worksheets/sheet2.xml"/></Relationships>');
    $zip->addFromString('xl/sharedStrings.xml', $shared);
    $zip->addFromString('xl/worksheets/sheet1.xml', $makeSheet(true));
    $zip->addFromString('xl/worksheets/sheet2.xml', $makeSheet(false));
    $zip->close();
}
