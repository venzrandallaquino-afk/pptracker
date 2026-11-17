<?php
declare(strict_types=1);

session_name('PPTSESSID');
session_set_cookie_params([
    'httponly' => true,
    'secure' => isset($_SERVER['HTTPS']) && $_SERVER['HTTPS'] !== 'off',
    'samesite' => 'Strict',
    'path' => '/',
]);
session_start();
require __DIR__ . '/app/bootstrap.php';
require __DIR__ . '/app/dashboard.php';
require __DIR__ . '/app/modules/register.php';
require __DIR__ . '/app/modules/transaction_form.php';
require __DIR__ . '/app/modules/transaction_detail.php';
require __DIR__ . '/app/modules/workflow.php';
require __DIR__ . '/app/modules/reports.php';
require __DIR__ . '/app/modules/users.php';
require __DIR__ . '/app/modules/activity.php';
require __DIR__ . '/app/modules/import.php';
header('X-Content-Type-Options: nosniff');
header('X-Frame-Options: DENY');
header('Referrer-Policy: same-origin');
header("Content-Security-Policy: default-src 'self'; base-uri 'self'; form-action 'self'; frame-ancestors 'none'; object-src 'none'");

try {
    db();
    install_schema();
    $userCount = (int)db()->query('SELECT COUNT(*) FROM users')->fetchColumn();
} catch (Throwable $error) {
    http_response_code(500);
    error_log('PPT database initialization error: ' . $error->getMessage());
    $dbError = $error;
    $userCount = -1;
}

$errorMessage = '';
$action = $_POST['action'] ?? '';
if ($userCount >= 0 && $_SERVER['REQUEST_METHOD'] === 'POST') {
    try {
        if ($action === 'setup') {
            verify_csrf();
            if ($userCount !== 0) {
                throw new RuntimeException('Administrator setup has already been completed.');
            }
            $name = trim((string)($_POST['name'] ?? ''));
            $username = strtolower(trim((string)($_POST['username'] ?? '')));
            $password = (string)($_POST['password'] ?? '');
            if (strlen($name) < 2 || !preg_match('/^[a-z0-9._-]{3,60}$/', $username) || strlen($password) < 12) {
                throw new InvalidArgumentException('Enter a name, a valid username, and a password of at least 12 characters.');
            }
            if (strlen($password) > 1024) throw new InvalidArgumentException('Passwords must be 1,024 characters or fewer.');
            if ((int)db()->query("SELECT GET_LOCK('pptracker-first-admin', 5)")->fetchColumn() !== 1) {
                throw new RuntimeException('Administrator setup is busy. Please try again.');
            }
            $adminId = 0;
            try {
                if ((int)db()->query('SELECT COUNT(*) FROM users')->fetchColumn() !== 0) {
                    throw new RuntimeException('Administrator setup has already been completed.');
                }
                $stmt = db()->prepare('INSERT INTO users (name, username, password_hash, role) VALUES (?, ?, ?, ?)');
                $stmt->execute([$name, $username, password_hash($password, PASSWORD_DEFAULT), 'Administrator']);
                $adminId = (int)db()->lastInsertId();
            } finally {
                db()->query("SELECT RELEASE_LOCK('pptracker-first-admin')");
            }
            session_regenerate_id(true);
            $_SESSION['user'] = ['id' => $adminId, 'name' => $name, 'username' => $username, 'role' => 'Administrator'];
            audit('Initial administrator created');
            redirect('index.php');
        }

        if ($action === 'login') {
            verify_csrf();
            $username = strtolower(trim((string)($_POST['username'] ?? '')));
            $attemptKey = hash('sha256', $username . "\0" . (string)($_SERVER['REMOTE_ADDR'] ?? 'unknown'));
            $attempt = db()->prepare('SELECT count,last_attempt FROM login_attempts WHERE attempt_key=?');
            $attempt->execute([$attemptKey]);
            $attemptData = $attempt->fetch();
            if ($attemptData && (int)$attemptData['count'] >= 8 && time() - strtotime($attemptData['last_attempt']) < 300) {
                throw new RuntimeException('Too many sign-in attempts. Wait a few minutes and try again.');
            }
            $stmt = db()->prepare('SELECT * FROM users WHERE username=? AND active=1');
            $stmt->execute([$username]);
            $account = $stmt->fetch();
            if (!$account || !password_verify((string)($_POST['password'] ?? ''), $account['password_hash'])) {
                db()->prepare('INSERT INTO login_attempts (attempt_key,count,last_attempt) VALUES (?,1,NOW()) ON DUPLICATE KEY UPDATE count=IF(TIMESTAMPDIFF(SECOND,last_attempt,NOW())<300,count+1,1),last_attempt=NOW()')
                    ->execute([$attemptKey]);
                throw new RuntimeException('The username or password is incorrect.');
            }
            db()->prepare('DELETE FROM login_attempts WHERE attempt_key=?')->execute([$attemptKey]);
            session_regenerate_id(true);
            $_SESSION['user'] = ['id' => (int)$account['id'], 'name' => $account['name'], 'username' => $account['username'], 'role' => $account['role']];
            db()->prepare('UPDATE users SET last_login=NOW() WHERE id=?')->execute([$account['id']]);
            audit('Signed in');
            redirect('index.php');
        }

        $user = require_login();
        verify_csrf();
        if ($action === 'logout') {
            audit('Signed out');
            $_SESSION = [];
            session_regenerate_id(true);
            redirect('index.php');
        }

        if ($action === 'create_transaction') {
            if (!can_access_stage('purchase_requests', $user)) {
                throw new RuntimeException('You do not have permission to create purchase requests.');
            }
            $sheet = (string)($_POST['worksheet'] ?? '');
            if (!in_array($sheet, workbook_groups(), true)) {
                throw new InvalidArgumentException('Choose a valid workbook group.');
            }
            $values = [];
            foreach (STAGE_FIELDS['purchase_requests'] as $key => [$label, $type]) {
                if ($key === 'workflow_status') {
                    $values[$key] = 'In Progress';
                    continue;
                }
                $values[$key] = normalize_value($key, $type, $_POST[$key] ?? '');
            }
            if (empty($values['pr_number']) && empty($values['particulars'])) {
                throw new InvalidArgumentException('Enter a PR number or particulars to identify this request.');
            }
            if (!empty($values['pr_number'])) {
                $duplicate = db()->prepare('SELECT COUNT(*) FROM purchase_requests pr JOIN transactions t ON t.id=pr.transaction_id WHERE t.worksheet=? AND pr.pr_number=?');
                $duplicate->execute([$sheet, $values['pr_number']]);
                if ((int)$duplicate->fetchColumn() > 0) throw new InvalidArgumentException('That PR number already exists in this worksheet.');
            }
            db()->beginTransaction();
            db()->prepare('INSERT INTO transactions (transaction_code, worksheet, created_by) VALUES (?, ?, ?)')
                ->execute(['PENDING-' . bin2hex(random_bytes(6)), $sheet, $user['id']]);
            $id = (int)db()->lastInsertId();
            $code = sprintf('PPT-%s-%06d', date('Y'), $id);
            db()->prepare('UPDATE transactions SET transaction_code=? WHERE id=?')->execute([$code, $id]);
            $columns = array_merge(['transaction_id', 'updated_by'], array_keys($values));
            $params = array_merge([$id, $user['id']], array_values($values));
            $placeholders = implode(',', array_fill(0, count($columns), '?'));
            db()->prepare('INSERT INTO purchase_requests (' . implode(',', $columns) . ") VALUES ($placeholders)")->execute($params);
            audit('Created transaction', $id, $code);
            db()->commit();
            flash('Transaction ' . $code . ' was created.');
            redirect('index.php?page=transaction&id=' . $id);
        }

        if ($action === 'save_stage') {
            $id = filter_input(INPUT_POST, 'id', FILTER_VALIDATE_INT);
            $stage = (string)($_POST['stage'] ?? '');
            if (!$id || !isset(STAGES[$stage]) || !can_access_stage($stage, $user)) {
                throw new RuntimeException('You do not have permission to update that workflow stage.');
            }
            if (!transaction_row((int)$id)) {
                throw new RuntimeException('The transaction could not be found.');
            }
            $values = [];
            foreach (STAGE_FIELDS[$stage] as $key => [$label, $type]) {
                $values[$key] = normalize_value($key, $type, $_POST[$key] ?? '');
            }
            if ($stage === 'cashier' && empty($values['payment_date']) && empty($values['reference_number']) && empty($values['amount'])) {
                throw new InvalidArgumentException('Enter a payment date, reference number, or amount.');
            }
            if ($stage === 'dv' && $values['gross_amount'] !== null && $values['tax'] !== null) {
                if ((float)$values['tax'] > (float)$values['gross_amount']) {
                    throw new InvalidArgumentException('Tax cannot exceed the gross amount.');
                }
                if ($values['net_amount'] === null) {
                    $values['net_amount'] = number_format((float)$values['gross_amount'] - (float)$values['tax'], 2, '.', '');
                }
            }
            if ($stage === 'purchase_requests' && !empty($values['pr_number'])) {
                $duplicate = db()->prepare('SELECT COUNT(*) FROM purchase_requests pr JOIN transactions t ON t.id=pr.transaction_id WHERE t.worksheet=(SELECT worksheet FROM transactions WHERE id=?) AND pr.pr_number=? AND pr.transaction_id<>?');
                $duplicate->execute([(int)$id, $values['pr_number'], (int)$id]);
                if ((int)$duplicate->fetchColumn() > 0) throw new InvalidArgumentException('That PR number already exists in this worksheet.');
            }
            db()->beginTransaction();
            if ($stage === 'cashier') {
                $columns = array_merge(['transaction_id', 'created_by'], array_keys($values));
                $params = array_merge([(int)$id, $user['id']], array_values($values));
                $marks = implode(',', array_fill(0, count($columns), '?'));
                db()->prepare('INSERT INTO payment_records (' . implode(',', $columns) . ") VALUES ($marks)")->execute($params);
            } else {
                $table = STAGES[$stage]['table'];
                $values['updated_by'] = $user['id'];
                $columns = array_merge(['transaction_id'], array_keys($values));
                $params = array_merge([(int)$id], array_values($values));
                $updates = implode(',', array_map(static fn(string $column): string => "`$column`=VALUES(`$column`)", array_keys($values)));
                $marks = implode(',', array_fill(0, count($columns), '?'));
                db()->prepare("INSERT INTO `$table` (" . implode(',', array_map(static fn(string $column): string => "`$column`", $columns)) . ") VALUES ($marks) ON DUPLICATE KEY UPDATE $updates")->execute($params);
            }
            update_transaction_progress((int)$id);
            audit('Updated ' . STAGES[$stage]['label'], (int)$id);
            db()->commit();
            flash(STAGES[$stage]['label'] . ' details saved.');
            $returnPage = (string)($_POST['return_page'] ?? '');
            if ($returnPage !== $stage || !isset(STAGES[$returnPage])) $returnPage = '';
            redirect($returnPage !== ''
                ? 'index.php?page=' . rawurlencode($returnPage)
                : 'index.php?page=transaction&id=' . (int)$id);
        }

        if ($action === 'delete_transaction') {
            if ($user['role'] !== 'Administrator') {
                throw new RuntimeException('Only an Administrator can delete a transaction.');
            }
            $id = filter_input(INPUT_POST, 'id', FILTER_VALIDATE_INT);
            if (!$id) {
                throw new InvalidArgumentException('A valid transaction is required.');
            }
            $files = db()->prepare('SELECT stored_name FROM attachments WHERE transaction_id=?');
            $files->execute([$id]);
            $storedFiles = $files->fetchAll(PDO::FETCH_COLUMN);
            audit('Deleted transaction', (int)$id);
            db()->prepare('DELETE FROM transactions WHERE id=?')->execute([$id]);
            foreach ($storedFiles as $storedFile) {
                $path = __DIR__ . '/storage/uploads/' . basename((string)$storedFile);
                if (is_file($path) && !unlink($path)) {
                    error_log('Could not remove deleted transaction attachment: ' . $path);
                }
            }
            flash('Transaction deleted.');
            redirect('index.php?page=transactions');
        }

        if ($action === 'save_user') {
            if ($user['role'] !== 'Administrator') {
                throw new RuntimeException('Only an Administrator can manage users.');
            }
            db()->beginTransaction();
            $id = filter_input(INPUT_POST, 'id', FILTER_VALIDATE_INT) ?: 0;
            $name = trim((string)($_POST['name'] ?? ''));
            $username = strtolower(trim((string)($_POST['username'] ?? '')));
            $role = (string)($_POST['role'] ?? '');
            $password = (string)($_POST['password'] ?? '');
            if (strlen($name) < 2 || !preg_match('/^[a-z0-9._-]{3,60}$/', $username) || !in_array($role, APP_ROLES, true)) {
                throw new InvalidArgumentException('Enter a valid name, username, and role.');
            }
            if ($id === 0 && strlen($password) < 12) {
                throw new InvalidArgumentException('New user passwords must be at least 12 characters.');
            }
            if ($id > 0) {
                if ($id === (int)$user['id'] && $role !== 'Administrator') {
                    throw new InvalidArgumentException('You cannot remove your own Administrator role.');
                }
                db()->prepare('UPDATE users SET name=?, username=?, role=? WHERE id=?')->execute([$name, $username, $role, $id]);
                if ($password !== '') {
                    if (strlen($password) < 12) {
                        throw new InvalidArgumentException('Passwords must be at least 12 characters.');
                    }
                    db()->prepare('UPDATE users SET password_hash=? WHERE id=?')->execute([password_hash($password, PASSWORD_DEFAULT), $id]);
                }
                $stages = stage_grants($_POST['stages'] ?? [], $role);
                db()->prepare('DELETE FROM user_stage_access WHERE user_id=?')->execute([$id]);
                $grant = db()->prepare('INSERT INTO user_stage_access (user_id, stage) VALUES (?, ?)');
                foreach ($stages as $stage) $grant->execute([$id, $stage]);
                audit('Updated user account', null, $username);
            } else {
                db()->prepare('INSERT INTO users (name, username, password_hash, role) VALUES (?, ?, ?, ?)')
                    ->execute([$name, $username, password_hash($password, PASSWORD_DEFAULT), $role]);
                $id = (int)db()->lastInsertId();
                $stages = stage_grants($_POST['stages'] ?? [], $role);
                $grant = db()->prepare('INSERT INTO user_stage_access (user_id, stage) VALUES (?, ?)');
                foreach ($stages as $stage) $grant->execute([$id, $stage]);
                audit('Created user account', null, $username);
            }
            db()->commit();
            flash('User account saved.');
            redirect('index.php?page=users');
        }

        if ($action === 'toggle_user') {
            if ($user['role'] !== 'Administrator') {
                throw new RuntimeException('Only an Administrator can manage users.');
            }
            $id = filter_input(INPUT_POST, 'id', FILTER_VALIDATE_INT);
            if (!$id || $id === (int)$user['id']) {
                throw new InvalidArgumentException('You cannot deactivate your own account.');
            }
            db()->prepare('UPDATE users SET active=IF(active=1,0,1) WHERE id=?')->execute([$id]);
            audit('Changed user active status', null, 'User ID ' . $id);
            flash('User status updated.');
            redirect('index.php?page=users');
        }

        if ($action === 'upload_attachment') {
            $id = filter_input(INPUT_POST, 'id', FILTER_VALIDATE_INT);
            $stage = (string)($_POST['stage'] ?? '');
            if (!$id || !isset(STAGES[$stage]) || !can_access_stage($stage, $user)) {
                throw new RuntimeException('You do not have permission to attach documents to that stage.');
            }
            $file = $_FILES['attachment'] ?? null;
            if (!is_array($file) || ($file['error'] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_OK || (int)$file['size'] > $config['upload_max_bytes']) {
                throw new InvalidArgumentException('Choose a file under 10 MB and try again.');
            }
            $allowed = ['pdf' => 'application/pdf', 'png' => 'image/png', 'jpg' => 'image/jpeg', 'jpeg' => 'image/jpeg'];
            $extension = strtolower(pathinfo((string)$file['name'], PATHINFO_EXTENSION));
            $mime = (new finfo(FILEINFO_MIME_TYPE))->file((string)$file['tmp_name']) ?: '';
            if (!isset($allowed[$extension]) || $allowed[$extension] !== $mime) {
                throw new InvalidArgumentException('Only PDF and JPG/PNG image attachments are allowed.');
            }
            $directory = __DIR__ . '/storage/uploads';
            if (!is_dir($directory) && !mkdir($directory, 0700, true) && !is_dir($directory)) {
                throw new RuntimeException('The protected attachment directory could not be created.');
            }
            $stored = bin2hex(random_bytes(24)) . '.' . $extension;
            if (!move_uploaded_file((string)$file['tmp_name'], $directory . '/' . $stored)) {
                throw new RuntimeException('The attachment could not be saved.');
            }
            db()->prepare('INSERT INTO attachments (transaction_id, stage, original_name, stored_name, mime_type, file_size, uploaded_by) VALUES (?, ?, ?, ?, ?, ?, ?)')
                ->execute([(int)$id, $stage, basename((string)$file['name']), $stored, $mime, (int)$file['size'], $user['id']]);
            audit('Uploaded attachment', (int)$id, STAGES[$stage]['label']);
            flash('Attachment uploaded.');
            $returnPage = (string)($_POST['return_page'] ?? '');
            if ($returnPage !== $stage || !isset(STAGES[$returnPage])) $returnPage = '';
            redirect($returnPage !== ''
                ? 'index.php?page=' . rawurlencode($returnPage)
                : 'index.php?page=transaction&id=' . (int)$id . '&stage=' . rawurlencode($stage));
        }

        if ($action === 'import_preview') {
            if ($user['role'] !== 'Administrator') {
                throw new RuntimeException('Only an Administrator can import workbooks.');
            }
            $file = $_FILES['workbook'] ?? null;
            if (!is_array($file) || ($file['error'] ?? UPLOAD_ERR_NO_FILE) !== UPLOAD_ERR_OK || (int)$file['size'] > 20 * 1024 * 1024) {
                throw new InvalidArgumentException('Choose an XLSX workbook under 20 MB.');
            }
            if (strtolower(pathinfo((string)$file['name'], PATHINFO_EXTENSION)) !== 'xlsx') {
                throw new InvalidArgumentException('Upload an .xlsx workbook.');
            }
            $workbookGroup = trim((string)($_POST['workbook_group'] ?? ''));
            if ($workbookGroup === '') $workbookGroup = null;
            $_SESSION['import_preview'] = preview_workbook((string)$file['tmp_name'], $workbookGroup);
            flash('Workbook preview is ready. Review warnings before importing.');
            redirect('index.php?page=import');
        }

        if ($action === 'import_commit') {
            if ($user['role'] !== 'Administrator') {
                throw new RuntimeException('Only an Administrator can import workbooks.');
            }
            $preview = $_SESSION['import_preview'] ?? null;
            if (!is_array($preview) || !empty($preview['errors'])) {
                throw new RuntimeException('There is no valid import preview to commit.');
            }
            $imported = 0;
            $skipped = 0;
            db()->beginTransaction();
            $workbookGroup = $preview['workbook_group'] ?? null;
            if (is_string($workbookGroup)) {
                if (!preg_match('/^[A-Za-z0-9][A-Za-z0-9 ._-]{0,29}$/', $workbookGroup)) {
                    throw new InvalidArgumentException('The workbook group name is invalid. Discard the preview and upload again.');
                }
                db()->prepare('INSERT IGNORE INTO workbook_groups (name, created_by) VALUES (?, ?)')->execute([$workbookGroup, $user['id']]);
            }
            foreach ($preview['rows'] as $row) {
                if (!empty($row['_duplicate'])) {
                    $skipped++;
                    continue;
                }
                $pr = [
                    'sequence_number' => $row['sequence_number'] ?? (string)($row['_source_row'] ?? ''),
                    'pr_date' => $row['pr_date'] ?? null,
                    'pr_number' => $row['pr_number'] ?? null,
                    'received_at' => $row['received_at'] ?? null,
                    'particulars' => $row['particulars'] ?? null,
                    'quantity' => $row['quantity'] ?? null,
                    'unit' => $row['unit'] ?? null,
                    'amount' => $row['amount'] ?? null,
                    'requested_by' => $row['requested_by'] ?? null,
                    'workflow_status' => 'Not Started',
                    'updated_by' => $user['id'],
                ];
                foreach (['pr_date' => 'date', 'received_at' => 'datetime', 'quantity' => 'number', 'amount' => 'money'] as $key => $type) {
                    $pr[$key] = normalize_value($key, $type, $pr[$key] ?? '');
                }
                db()->prepare('INSERT INTO transactions (transaction_code, worksheet, created_by) VALUES (?, ?, ?)')
                    ->execute(['PENDING-' . bin2hex(random_bytes(6)), $row['worksheet'], $user['id']]);
                $id = (int)db()->lastInsertId();
                $code = sprintf('PPT-%s-%06d', date('Y'), $id);
                db()->prepare('UPDATE transactions SET transaction_code=? WHERE id=?')->execute([$code, $id]);
                $pr['transaction_id'] = $id;
                $prCols = array_keys($pr);
                db()->prepare('INSERT INTO purchase_requests (`' . implode('`,`', $prCols) . '`) VALUES (' . implode(',', array_fill(0, count($prCols), '?')) . ')')
                    ->execute(array_values($pr));
                $stageRows = [
                    'bac_records' => ['deliberation_date' => 'deliberation_date', 'status' => 'bac_status', 'resolution_number' => 'resolution_number', 'released_at' => 'released_at'],
                    'purchase_orders' => ['po_number' => 'po_number', 'po_date' => 'po_date', 'supplier' => 'supplier', 'accountant_received_date' => 'accountant_received_date', 'coa_received_date' => 'coa_received_date', 'procurement_mode' => 'procurement_mode', 'description' => 'description', 'quantity' => 'po_quantity', 'unit' => 'po_unit', 'amount' => 'po_amount', 'released_time' => 'po_released_time', 'released_date' => 'po_released_date'],
                    'ors_records' => ['ors_date' => 'ors_date', 'received_time' => 'received_time', 'ors_number' => 'ors_number', 'uacs_code' => 'uacs_code', 'mfo_pap' => 'mfo_pap', 'amount' => 'ors_amount', 'released_date' => 'ors_released_date', 'released_time' => 'ors_released_time'],
                    'iar_records' => ['iar_number' => 'iar_number', 'inspection_date' => 'inspection_date', 'inspection_result' => 'inspection_result', 'acceptance_date' => 'acceptance_date', 'inspector_signed_date' => 'inspector_signed_date'],
                    'dv_records' => ['dv_date' => 'dv_date', 'dv_number' => 'dv_number', 'gross_amount' => 'gross_amount', 'tax' => 'tax', 'net_amount' => 'net_amount', 'received_at' => 'dv_received_at', 'remarks' => 'dv_remarks', 'forwarded_returned_date' => 'forwarded_returned_date'],
                    'jev_records' => ['jev_date' => 'jev_date', 'jev_number' => 'jev_number'],
                ];
                foreach ($stageRows as $table => $mapping) {
                    $stageData = [];
                    foreach ($mapping as $column => $source) {
                        $value = trim((string)($row[$source] ?? ''));
                        if ($value !== '') $stageData[$column] = $value;
                    }
                    if ($stageData === []) continue;
                    $stageData['transaction_id'] = $id;
                    $columns = array_keys($stageData);
                    db()->prepare('INSERT INTO `' . $table . '` (`' . implode('`,`', $columns) . '`) VALUES (' . implode(',', array_fill(0, count($columns), '?')) . ')')
                        ->execute(array_values($stageData));
                }
                if (!empty($row['payment_date']) || !empty($row['reference_number']) || !empty($row['payment_amount'])) {
                    db()->prepare('INSERT INTO payment_records (transaction_id,payment_date,reference_number,amount,workflow_status,created_by) VALUES (?,?,?,?,?,?)')
                        ->execute([$id, $row['payment_date'] ?: null, $row['reference_number'] ?: null, $row['payment_amount'] ?: null, 'In Progress', $user['id']]);
                }
                audit('Imported transaction', $id, $row['worksheet'] . ' row ' . $row['_source_row']);
                $imported++;
            }
            db()->commit();
            unset($_SESSION['import_preview']);
            flash("Imported $imported transactions; skipped $skipped possible duplicates.");
            redirect('index.php?page=import');
        }

        if ($action === 'download_attachment') {
            $attachmentId = filter_input(INPUT_POST, 'attachment_id', FILTER_VALIDATE_INT);
            $stmt = db()->prepare('SELECT * FROM attachments WHERE id=?');
            $stmt->execute([$attachmentId]);
            $file = $stmt->fetch();
            if (!$file || ($user['role'] !== 'Administrator' && !can_access_stage($file['stage'], $user))) {
                throw new RuntimeException('You do not have permission to access that attachment.');
            }
            $path = __DIR__ . '/storage/uploads/' . basename($file['stored_name']);
            if (!is_file($path)) {
                throw new RuntimeException('The attachment file is missing.');
            }
            header('Content-Type: ' . $file['mime_type']);
            header('Content-Length: ' . filesize($path));
            $downloadName = preg_replace('/[\r\n"\\\\]/', '_', (string)$file['original_name']) ?: 'attachment';
            header('Content-Disposition: attachment; filename="' . $downloadName . '"');
            readfile($path);
            exit;
        }

        throw new RuntimeException('That action is not available.');
    } catch (Throwable $error) {
        if (db()->inTransaction()) {
            db()->rollBack();
        }
        $errorMessage = $error instanceof InvalidArgumentException || $error instanceof RuntimeException
            ? $error->getMessage()
            : 'The request could not be completed. Check the PHP error log for details.';
        if (!($error instanceof InvalidArgumentException || $error instanceof RuntimeException)) {
            error_log('PPT system error: ' . $error->getMessage());
        }
    }
}

function page_title(string $page): string
{
    return match ($page) {
        'dashboard' => 'Dashboard',
        'transactions' => 'Transaction Register',
        'reports' => 'Reports & Analytics',
        'users' => 'User Management',
        'activity' => 'Activity Logs',
        'import' => 'Excel Import',
        'transaction' => 'Transaction Details',
        'new-transaction' => 'New Transaction',
        default => STAGES[$page]['label'] ?? 'Procurement Tracker',
    };
}

function allowed_page(string $page, array $user): bool
{
    if (in_array($page, ['dashboard', 'transactions', 'transaction', 'reports', 'export', 'export-xlsx'], true)) {
        return true;
    }
    if ($page === 'new-transaction') return can_access_stage('purchase_requests', $user);
    return match ($page) {
        'users', 'activity', 'import' => $user['role'] === 'Administrator',
        default => isset(STAGES[$page]) && can_access_stage($page, $user),
    };
}

function transaction_filters(): array
{
    $filters = [];
    foreach (['q', 'worksheet', 'supplier', 'stage', 'status', 'date_from', 'date_to'] as $key) {
        $filters[$key] = trim((string)($_GET[$key] ?? ''));
    }
    if ($filters['worksheet'] !== '' && !in_array($filters['worksheet'], workbook_groups(), true)) $filters['worksheet'] = '';
    if (!in_array($filters['stage'], ['', ...array_keys(STAGES)], true)) $filters['stage'] = '';
    if (!in_array($filters['status'], ['', 'In Progress', 'Completed'], true)) $filters['status'] = '';
    foreach (['date_from', 'date_to'] as $key) {
        if ($filters[$key] !== '' && !preg_match('/^\d{4}-\d{2}-\d{2}$/', $filters[$key])) $filters[$key] = '';
    }
    return $filters;
}

function transaction_filter_sql(array $filters): array
{
    $where = [];
    $params = [];
    if ($filters['q'] !== '') {
        $where[] = '(t.transaction_code LIKE ? OR pr.pr_number LIKE ? OR pr.particulars LIKE ? OR pr.requested_by LIKE ? OR po.supplier LIKE ?)';
        array_push($params, ...array_fill(0, 5, '%' . $filters['q'] . '%'));
    }
    foreach (['worksheet' => 't.worksheet', 'stage' => 't.current_stage', 'status' => 't.status'] as $key => $column) {
        if ($filters[$key] !== '') {
            $where[] = "$column=?";
            $params[] = $filters[$key];
        }
    }
    if ($filters['supplier'] !== '') {
        $where[] = 'po.supplier LIKE ?';
        $params[] = '%' . $filters['supplier'] . '%';
    }
    if ($filters['date_from'] !== '') {
        $where[] = '(pr.pr_date IS NOT NULL AND pr.pr_date>=?)';
        $params[] = $filters['date_from'];
    }
    if ($filters['date_to'] !== '') {
        $where[] = '(pr.pr_date IS NOT NULL AND pr.pr_date<=?)';
        $params[] = $filters['date_to'];
    }
    return [$where, $params];
}

function render_filter_controls(array $filters, string $page): void
{
    ?>
    <form class="filter-row" method="get">
        <input type="hidden" name="page" value="<?= h($page) ?>">
        <label class="search-input">Search<input name="q" value="<?= h($filters['q']) ?>" placeholder="Transaction ID, PR, supplier, particulars"></label>
        <label>From PR Date<input type="date" name="date_from" value="<?= h($filters['date_from']) ?>"></label>
        <label>To PR Date<input type="date" name="date_to" value="<?= h($filters['date_to']) ?>"></label>
        <label>Workbook group<select name="worksheet"><option value="">All groups</option><?php foreach (workbook_groups() as $option): ?><option value="<?= h($option) ?>" <?= $filters['worksheet'] === $option ? 'selected' : '' ?>><?= h($option) ?></option><?php endforeach; ?></select></label>
        <label>Stage<select name="stage"><option value="">All stages</option><?php foreach (STAGES as $key => $stage): ?><option value="<?= h($key) ?>" <?= $filters['stage'] === $key ? 'selected' : '' ?>><?= h($stage['label']) ?></option><?php endforeach; ?></select></label>
        <label>Status<select name="status"><option value="">All statuses</option><?php foreach (['In Progress', 'Completed'] as $option): ?><option <?= $filters['status'] === $option ? 'selected' : '' ?>><?= h($option) ?></option><?php endforeach; ?></select></label>
        <label>Supplier<input name="supplier" value="<?= h($filters['supplier']) ?>" placeholder="Supplier name"></label>
        <button class="button primary" type="submit">Apply filters</button>
    </form>
    <?php
}

function stream_excel_export(array $rows): never
{
    if (!class_exists(ZipArchive::class)) {
        throw new RuntimeException('Excel export requires PHP Zip extension. Enable extension=zip and restart Apache.');
    }
    $path = tempnam(sys_get_temp_dir(), 'ppt-export-');
    if ($path === false) throw new RuntimeException('Could not create a temporary Excel file.');
    $headers = ['Transaction ID', 'Worksheet', 'PR Number', 'PR Date', 'Particulars', 'Requested By', 'Supplier', 'PO Number', 'Status', 'PR Amount', 'Last Updated'];
    $groups = [];
    foreach (workbook_groups() as $group) $groups[$group] = [];
    foreach ($rows as $row) {
        $group = (string)$row['worksheet'];
        if (!isset($groups[$group])) $groups[$group] = [];
        $groups[$group][] = array_values($row);
    }
    $columnName = static function (int $number): string {
        $name = '';
        while ($number > 0) {
            $number--;
            $name = chr(65 + ($number % 26)) . $name;
            $number = intdiv($number, 26);
        }
        return $name;
    };
    $xmlValue = static fn(mixed $value): string => htmlspecialchars((string)($value ?? ''), ENT_XML1 | ENT_QUOTES, 'UTF-8');
    $workbookSheets = '';
    $relationships = '';
    $contentTypes = '';
    $zip = new ZipArchive();
    try {
        if ($zip->open($path, ZipArchive::OVERWRITE) !== true) throw new RuntimeException('Could not open the temporary Excel file.');
        $sheetNumber = 1;
        foreach ($groups as $sheetName => $sheetRows) {
            $workbookSheets .= '<sheet name="' . $xmlValue($sheetName) . '" sheetId="' . $sheetNumber . '" r:id="rId' . $sheetNumber . '"/>';
            $relationships .= '<Relationship Id="rId' . $sheetNumber . '" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet' . $sheetNumber . '.xml"/>';
            $contentTypes .= '<Override PartName="/xl/worksheets/sheet' . $sheetNumber . '.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/>';
            $allRows = array_merge([$headers], $sheetRows);
            $sheetXml = '<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main"><sheetData>';
            foreach ($allRows as $rowNumber => $values) {
                $rowNumber++;
                $sheetXml .= '<row r="' . $rowNumber . '">';
                foreach (array_values($values) as $column => $value) {
                    $reference = $columnName($column + 1) . $rowNumber;
                    $sheetXml .= '<c r="' . $reference . '" t="inlineStr"><is><t xml:space="preserve">' . $xmlValue($value) . '</t></is></c>';
                }
                $sheetXml .= '</row>';
            }
            $sheetXml .= '</sheetData></worksheet>';
            $zip->addFromString('xl/worksheets/sheet' . $sheetNumber . '.xml', $sheetXml);
            $sheetNumber++;
        }
        $zip->addFromString('[Content_Types].xml', '<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types"><Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/><Default Extension="xml" ContentType="application/xml"/><Override PartName="/xl/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/>' . $contentTypes . '</Types>');
        $zip->addFromString('_rels/.rels', '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships"><Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="xl/workbook.xml"/></Relationships>');
        $zip->addFromString('xl/workbook.xml', '<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"><sheets>' . $workbookSheets . '</sheets></workbook>');
        $zip->addFromString('xl/_rels/workbook.xml.rels', '<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">' . $relationships . '</Relationships>');
        if (!$zip->close()) throw new RuntimeException('Could not finish the Excel export.');
        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        header('Content-Disposition: attachment; filename="procurement-transactions.xlsx"');
        header('Content-Length: ' . filesize($path));
        readfile($path);
    } finally {
        if (is_file($path) && !unlink($path)) error_log('Could not remove temporary Excel export file.');
    }
    exit;
}

$user = current_user();
$page = (string)($_GET['page'] ?? 'dashboard');
if ($user && !allowed_page($page, $user)) {
    http_response_code(403);
    $errorMessage = 'Your account does not have access to that workspace.';
    $page = 'dashboard';
}
if ($user && $page === 'import' && isset($_GET['discard'])) {
    unset($_SESSION['import_preview']);
    redirect('index.php?page=import');
}
if ($page === 'export' && $user) {
    $filters = transaction_filters();
    [$where, $params] = transaction_filter_sql($filters);
    $sql = 'SELECT t.transaction_code,t.worksheet,pr.pr_number,pr.pr_date,pr.particulars,pr.requested_by,po.supplier,po.po_number,t.status,pr.amount,t.updated_at FROM transactions t LEFT JOIN purchase_requests pr ON pr.transaction_id=t.id LEFT JOIN purchase_orders po ON po.transaction_id=t.id';
    if ($where) $sql .= ' WHERE ' . implode(' AND ', $where);
    $sql .= ' ORDER BY t.updated_at DESC';
    $stmt = db()->prepare($sql);
    $stmt->execute($params);
    header('Content-Type: text/csv; charset=utf-8');
    header('Content-Disposition: attachment; filename="procurement-transactions.csv"');
    $out = fopen('php://output', 'wb');
    fwrite($out, "\xEF\xBB\xBF");
    fputcsv($out, ['Transaction ID', 'Worksheet', 'PR Number', 'PR Date', 'Particulars', 'Requested By', 'Supplier', 'PO Number', 'Status', 'PR Amount', 'Last Updated']);
    while ($row = $stmt->fetch()) {
        fputcsv($out, array_values($row));
    }
    fclose($out);
    exit;
}
if ($page === 'export-xlsx' && $user) {
    if (!class_exists(ZipArchive::class)) {
        http_response_code(503);
        exit('Excel export requires PHP Zip extension. Enable extension=zip and restart Apache.');
    }
    $filters = transaction_filters();
    [$where, $params] = transaction_filter_sql($filters);
    $sql = 'SELECT t.transaction_code,t.worksheet,pr.pr_number,pr.pr_date,pr.particulars,pr.requested_by,po.supplier,po.po_number,t.status,pr.amount,t.updated_at FROM transactions t LEFT JOIN purchase_requests pr ON pr.transaction_id=t.id LEFT JOIN purchase_orders po ON po.transaction_id=t.id';
    if ($where) $sql .= ' WHERE ' . implode(' AND ', $where);
    $sql .= ' ORDER BY t.updated_at DESC';
    $stmt = db()->prepare($sql);
    $stmt->execute($params);
    stream_excel_export($stmt->fetchAll());
}

if ($user && ($_GET['stage_modal'] ?? '') === '1') {
    $id = filter_input(INPUT_GET, 'id', FILTER_VALIDATE_INT);
    $stage = (string)($_GET['stage'] ?? '');
    $returnPage = (string)($_GET['return_page'] ?? '');
    if (!$id || !isset(STAGES[$stage]) || !can_access_stage($stage, $user) || ($returnPage !== '' && $returnPage !== $stage)) {
        http_response_code(403);
        exit('You do not have permission to open that workflow stage.');
    }
    if (!transaction_row((int)$id)) {
        http_response_code(404);
        exit('Transaction not found.');
    }
    if (strtolower((string)($_SERVER['HTTP_X_REQUESTED_WITH'] ?? '')) === 'xmlhttprequest') {
        render_stage_editor((int)$id, $stage, $user, $returnPage);
        exit;
    }
}

$flash = $_SESSION['flash'] ?? null;
unset($_SESSION['flash']);
$currentPageTitle = page_title($page);
?>
<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="theme-color" content="#10432e">
    <title><?= h($currentPageTitle) ?> · PPT System</title>
    <link rel="stylesheet" href="assets/app.css">
    <script defer src="assets/app.js"></script>
</head>
<body>
<?php if (isset($dbError)): ?>
    <main class="auth-wrap"><section class="auth-card"><span class="eyebrow">DATABASE SETUP REQUIRED</span><h1>Cannot connect to MySQL</h1><p>Start MySQL in XAMPP, create the <code>pptracker</code> database in phpMyAdmin, then check <code>config.php</code>.</p></section></main>
<?php elseif (!$user): ?>
    <main class="auth-wrap">
        <section class="auth-card">
            <img class="brand-mark auth-brand-mark" src="assets/dar-logo.png" alt="Department of Agrarian Reform logo">
            <span class="eyebrow"><?= $userCount === 0 ? 'FIRST-TIME SETUP' : 'PROCUREMENT TO PAYMENT' ?></span>
            <h1><?= $userCount === 0 ? 'Create administrator' : 'Sign in' ?></h1>
            <p><?= $userCount === 0 ? 'Create the first account to configure and manage this tracker. There is no default application password.' : 'Use your organization account to continue.' ?></p>
            <?php if ($errorMessage): ?><div class="alert error"><?= h($errorMessage) ?></div><?php endif; ?>
            <form method="post" class="form-stack">
                <input type="hidden" name="csrf" value="<?= h(csrf_token()) ?>">
                <input type="hidden" name="action" value="<?= $userCount === 0 ? 'setup' : 'login' ?>">
                <?php if ($userCount === 0): ?><label>Full name<input name="name" required minlength="2" maxlength="120" autocomplete="name"></label><?php endif; ?>
                <label>Username<input name="username" required minlength="3" maxlength="60" autocomplete="username"></label>
                <label>Password<input name="password" type="password" required maxlength="1024" <?= $userCount === 0 ? 'minlength="12"' : '' ?> autocomplete="<?= $userCount === 0 ? 'new-password' : 'current-password' ?>"></label>
                <button class="button primary wide" type="submit"><?= $userCount === 0 ? 'Create administrator' : 'Sign in' ?></button>
            </form>
        </section>
    </main>
<?php else: ?>
    <div class="layout">
        <aside class="sidebar" id="app-sidebar">
            <a class="brand" href="index.php" aria-label="Procurement Tracker home" title="Procurement Tracker"><img class="brand-mark" src="assets/dar-logo.png" alt=""><span class="brand-copy"><strong>Procurement Tracker</strong><small>Transaction workspace</small></span></a>
            <div class="sidebar-label"><span class="sidebar-label-text">Overview</span></div>
            <nav class="navigation">
                <a class="<?= $page === 'dashboard' ? 'active' : '' ?>" href="index.php?page=dashboard" aria-label="Dashboard" title="Dashboard"><span class="nav-icon" aria-hidden="true">▦</span><span class="nav-label">Dashboard</span></a>
                <a class="<?= in_array($page, ['transactions', 'transaction'], true) ? 'active' : '' ?>" href="index.php?page=transactions" aria-label="Transaction Register" title="Transaction Register"><span class="nav-icon" aria-hidden="true">▤</span><span class="nav-label">Transaction Register</span></a>
            </nav>
            <div class="sidebar-label"><span class="sidebar-label-text">Workflow</span></div>
            <nav class="navigation">
                <?php foreach (STAGES as $stage => $info): if (!can_access_stage($stage, $user)) continue; ?>
                    <a class="<?= $page === $stage ? 'active' : '' ?>" href="index.php?page=<?= h($stage) ?>" aria-label="<?= h($info['label']) ?>" title="<?= h($info['label']) ?>"><span class="nav-icon" aria-hidden="true"><?= h($info['icon']) ?></span><span class="nav-label"><?= h($info['label']) ?></span></a>
                <?php endforeach; ?>
            </nav>
            <div class="sidebar-label"><span class="sidebar-label-text">Tools</span></div>
            <nav class="navigation">
                <a class="<?= $page === 'reports' ? 'active' : '' ?>" href="index.php?page=reports" aria-label="Reports & Analytics" title="Reports & Analytics"><span class="nav-icon" aria-hidden="true">▥</span><span class="nav-label">Reports & Analytics</span></a>
                <?php if ($user['role'] === 'Administrator'): ?>
                    <a class="<?= $page === 'import' ? 'active' : '' ?>" href="index.php?page=import" aria-label="Excel Import" title="Excel Import"><span class="nav-icon" aria-hidden="true">⇧</span><span class="nav-label">Excel Import</span></a>
                    <a class="<?= $page === 'users' ? 'active' : '' ?>" href="index.php?page=users" aria-label="User Management" title="User Management"><span class="nav-icon" aria-hidden="true">♙</span><span class="nav-label">User Management</span></a>
                    <a class="<?= $page === 'activity' ? 'active' : '' ?>" href="index.php?page=activity" aria-label="Activity Logs" title="Activity Logs"><span class="nav-icon" aria-hidden="true">≡</span><span class="nav-label">Activity Logs</span></a>
                <?php endif; ?>
            </nav>
            <div class="sidebar-user"><span class="avatar" title="<?= h($user['name']) ?>"><?= h(strtoupper(substr($user['name'], 0, 1))) ?></span><span class="sidebar-user-copy"><strong><?= h($user['name']) ?></strong><small><?= h($user['role']) ?></small></span>
                <form method="post"><input type="hidden" name="csrf" value="<?= h(csrf_token()) ?>"><input type="hidden" name="action" value="logout"><button class="icon-button" title="Sign out" aria-label="Sign out">↪</button></form>
            </div>
        </aside>
        <main class="main">
            <header class="topbar"><button class="sidebar-toggle" type="button" aria-controls="app-sidebar" aria-expanded="true" aria-label="Minimize navigation menu" title="Minimize navigation menu" data-sidebar-toggle><span aria-hidden="true">☰</span></button><div class="topbar-title"><span class="eyebrow">PROCUREMENT TO PAYMENT</span><h1><?= h($currentPageTitle) ?></h1></div><div class="topbar-actions"><span class="role-chip"><?= h($user['role']) ?></span></div></header>
            <div class="content">
                <?php if ($flash): ?><div class="alert <?= h($flash['kind']) ?><?= $flash['kind'] === 'success' ? ' toast-notification' : '' ?>"<?= $flash['kind'] === 'success' ? ' data-toast role="status" aria-live="polite"' : '' ?>><?= h($flash['message']) ?><?php if ($flash['kind'] === 'success'): ?><button type="button" class="toast-close" data-close-toast aria-label="Dismiss notification">&times;</button><?php endif; ?></div><?php endif; ?>
                <?php if ($errorMessage): ?><div class="alert error"><?= h($errorMessage) ?></div><?php endif; ?>
                <?php render_page($page, $user); ?>
            </div>
        </main>
    </div>
<?php endif; ?>
</body>
</html>

<?php
function render_page(string $page, array $user): void
{
    if ($page === 'dashboard') {
        render_dashboard($user);
        return;
    }
    if ($page === 'transactions') {
        render_register_module($page, $user);
        return;
    }
    if (isset(STAGES[$page])) {
        render_workflow_module($page);
        return;
    }
    if ($page === 'new-transaction') {
        render_transaction_form_module($user);
        return;
    }
    if ($page === 'transaction') {
        render_transaction_detail_module($user);
        return;
    }
    if ($page === 'reports') {
        render_reports_module();
        return;
    }
    if ($page === 'users' && $user['role'] === 'Administrator') {
        render_users_module($user);
        return;
    }
    if ($page === 'activity' && $user['role'] === 'Administrator') {
        render_activity_module();
        return;
    }
    if ($page === 'import' && $user['role'] === 'Administrator') {
        render_import_module();
        return;
    }
    echo '<div class="empty-state">This page is not available.</div>';
}
function render_transaction_table(array $rows, ?string $stage = null): void
{
    if (!$rows) {
        echo '<div class="empty-state">No transactions match these filters yet.</div>';
        return;
    }
    echo '<div class="table-wrap"><table><thead><tr><th>Transaction ID</th><th>PR Number</th><th>Particulars</th><th>Requested By</th><th>Supplier</th><th>Current Stage</th><th>Status</th><th>PR Amount</th><th>Updated</th></tr></thead><tbody>';
    foreach ($rows as $row) {
        $stageQuery = $stage !== null && isset(STAGES[$stage]) ? '&stage=' . rawurlencode($stage) : '';
        $transactionUrl = 'index.php?page=transaction&id=' . (int)$row['id'] . $stageQuery;
        $stageDialogUrl = $stage !== null && isset(STAGES[$stage])
            ? 'index.php?page=transaction&id=' . (int)$row['id'] . '&stage=' . rawurlencode($stage) . '&stage_modal=1&return_page=' . rawurlencode($stage)
            : '';
        $detailDialogUrl = $stageDialogUrl === '' ? 'index.php?page=transaction&id=' . (int)$row['id'] . '&detail_modal=1' : '';
        echo '<tr class="transaction-row" data-row-link="' . h($transactionUrl) . '"' . ($stageDialogUrl !== '' ? ' data-stage-modal-url="' . h($stageDialogUrl) . '"' : ' data-detail-modal-url="' . h($detailDialogUrl) . '"') . ' tabindex="0" aria-label="Open transaction ' . h($row['transaction_code']) . '"><td><a class="text-link" href="' . h($transactionUrl) . '">' . h($row['transaction_code']) . '</a><small class="cell-sub">' . h($row['worksheet']) . '</small></td><td>' . h($row['pr_number'] ?: '—') . '</td><td class="particulars-cell">' . h($row['particulars'] ?: '—') . '</td><td>' . h($row['requested_by'] ?: '—') . '</td><td>' . h($row['supplier'] ?: '—') . '</td><td>' . h(STAGES[$row['current_stage']]['short'] ?? $row['current_stage']) . '</td><td><span class="status ' . h(status_class($row['status'])) . '">' . h($row['status']) . '</span></td><td>' . h($row['amount'] === null ? '—' : money((float)$row['amount'])) . '</td><td>' . h($row['updated_at']) . '</td></tr>';
    }
    echo '</tbody></table></div>';
}

function render_stage_editor(int $id, string $stage, array $user, string $returnPage = ''): void
{
    $current = module_data($id, $stage, $user);
    $record = $stage === 'cashier' ? [] : $current;
    ?>
    <dialog class="stage-dialog" id="stage-dialog" data-auto-open>
    <section class="panel"><div class="panel-heading"><div><h2><?= h(STAGES[$stage]['label']) ?> details</h2><p>Only the assigned role and administrators can edit this section.</p></div><button class="dialog-close" type="button" data-close-stage aria-label="Close dialog">&times;</button></div>
        <form method="post" class="form-stack"><?= csrf_field() ?><input type="hidden" name="action" value="save_stage"><input type="hidden" name="id" value="<?= $id ?>"><input type="hidden" name="stage" value="<?= h($stage) ?>"><?php if ($returnPage === $stage): ?><input type="hidden" name="return_page" value="<?= h($returnPage) ?>"><?php endif; ?>
            <?php if ($stage === 'cashier' && $current): ?><div class="table-wrap"><table><thead><tr><th>Date</th><th>Reference</th><th>Amount</th><th>Status</th></tr></thead><tbody><?php foreach ($current as $payment): ?><tr><td><?= h($payment['payment_date'] ?? '—') ?></td><td><?= h($payment['reference_number'] ?? '—') ?></td><td><?= h($payment['amount'] === null ? '—' : money((float)$payment['amount'])) ?></td><td><?= h($payment['workflow_status']) ?></td></tr><?php endforeach; ?></tbody></table></div><h3>Record another payment</h3><?php endif; ?>
            <?php render_fields($stage, $record, true); ?><div class="form-actions"><button class="button primary"><?= $stage === 'cashier' ? 'Add payment record' : 'Save stage details' ?></button></div>
        </form>
        <form method="post" enctype="multipart/form-data" class="upload-row"><?= csrf_field() ?><input type="hidden" name="action" value="upload_attachment"><input type="hidden" name="id" value="<?= $id ?>"><input type="hidden" name="stage" value="<?= h($stage) ?>"><?php if ($returnPage === $stage): ?><input type="hidden" name="return_page" value="<?= h($returnPage) ?>"><?php endif; ?><label>Attach PDF or image<input type="file" name="attachment" accept=".pdf,.png,.jpg,.jpeg" required></label><button class="button secondary">Upload document</button></form>
    </section></dialog>
    <?php
}

function render_fields(string $stage, array $record = [], bool $showStatus = true): void
{
    echo '<div class="field-grid">';
    foreach (STAGE_FIELDS[$stage] as $key => [$label, $type]) {
        if ($key === 'workflow_status' && !$showStatus) continue;
        $value = $record[$key] ?? '';
        if ($type === 'status') {
            echo '<label>' . h($label) . '<select name="' . h($key) . '">';
            foreach (WORKFLOW_STATUSES as $status) echo '<option ' . ($value === $status ? 'selected' : '') . '>' . h($status) . '</option>';
            echo '</select></label>';
            continue;
        }
        if ($type === 'textarea') {
            echo '<label class="span-2">' . h($label) . '<textarea name="' . h($key) . '" rows="3" maxlength="5000">' . h($value) . '</textarea></label>';
            continue;
        }
        $inputType = match ($type) { 'money', 'number' => 'number', 'datetime' => 'datetime-local', default => $type };
        $step = $type === 'money' ? '0.01' : ($type === 'number' ? '0.001' : null);
        if ($type === 'datetime' && $value) $value = date('Y-m-d\TH:i', strtotime((string)$value));
        echo '<label>' . h($label) . '<input type="' . h($inputType) . '" name="' . h($key) . '" value="' . h($value) . '" maxlength="5000" ' . ($step ? 'step="' . $step . '"' : '') . ' ' . (in_array($type, ['money', 'number'], true) ? 'min="0"' : '') . '></label>';
    }
    echo '</div>';
}
