<?php
declare(strict_types=1);

function import_column_map(): array
{
    $aliases = [
        'sequence_number' => ['sequence number', 'sequence no', 'seq no', 'no'],
        'pr_date' => ['pr date', 'date of pr', 'purchase request date'],
        'pr_number' => ['pr number', 'pr no', 'purchase request number', 'purchase request no'],
        'received_at' => ['date time received from end user', 'date received from end user', 'received from end user'],
        'particulars' => ['particulars', 'item particulars', 'description of procurement'],
        'quantity' => ['quantity', 'qty'], 'unit' => ['unit', 'uom'],
        'amount' => ['amount', 'pr amount', 'total amount'], 'po_amount' => ['po amount', 'contract amount'],
        'requested_by' => ['requested by', 'end user', 'requesting office'],
        'deliberation_date' => ['deliberation date', 'bac deliberation date'],
        'bac_status' => ['bac status', 'status'], 'resolution_number' => ['resolution number', 'resolution no', 'resolution #'],
        'released_at' => ['date time released', 'date released'],
        'po_number' => ['po contract number', 'po number', 'po no', 'contract number', 'contract no'],
        'po_date' => ['po contract date', 'po date', 'contract date'], 'supplier' => ['supplier', 'supplier name'],
        'accountant_received_date' => ['date received after signed by accountant', 'accountant received date'],
        'coa_received_date' => ['date received by coa', 'coa received date'],
        'procurement_mode' => ['mode of procurement', 'procurement mode'], 'description' => ['description'],
        'released_time' => ['time released'], 'released_date' => ['po date released', 'date po released'],
        'ors_date' => ['ors date'], 'received_time' => ['ors time received', 'time received'],
        'ors_number' => ['ors number', 'ors no'], 'uacs_code' => ['uacs code', 'uacs'], 'mfo_pap' => ['mfo pap', 'mfo/pap'],
        'ors_amount' => ['ors amount'], 'ors_released_date' => ['ors date released'], 'ors_released_time' => ['ors time released'],
        'iar_number' => ['iar number', 'iar no'], 'inspection_date' => ['inspection date'],
        'inspection_result' => ['inspection result'], 'acceptance_date' => ['acceptance date'],
        'inspector_signed_date' => ['actual date signed by inspector', 'inspector signed date'],
        'dv_date' => ['dv date'], 'dv_number' => ['dv number', 'dv no', 'dv control number', 'control number'],
        'gross_amount' => ['gross amount'], 'tax' => ['tax'], 'net_amount' => ['net amount'],
        'dv_received_at' => ['date time received', 'dv received date time'], 'dv_remarks' => ['dv remarks', 'remarks'],
        'forwarded_returned_date' => ['date forwarded returned', 'date forwarded', 'date returned'],
        'payment_date' => ['payment date', 'date paid'],
        'reference_number' => ['lddap ada number', 'lddap ada no', 'check number', 'check no', 'payment reference'],
        'payment_amount' => ['payment amount', 'amount paid'], 'jev_date' => ['jev date'], 'jev_number' => ['jev number', 'jev no'],
    ];
    $map = [];
    foreach ($aliases as $key => $names) {
        foreach ($names as $name) $map[normalize_header($name)] = $key;
    }
    return $map;
}

function tracker_import_column_map(array $headers): ?array
{
    $anchors = [
        1 => 'pr date',
        2 => 'pr no',
        4 => 'particulars',
        13 => 'po contract no',
        27 => 'ors no',
        33 => 'iar no',
        39 => 'dv no control no',
        50 => 'jev no',
    ];
    foreach ($anchors as $column => $expected) {
        if (normalize_header((string)($headers[$column] ?? '')) !== $expected) return null;
    }

    return [
        0 => 'sequence_number', 1 => 'pr_date', 2 => 'pr_number', 3 => 'received_at',
        4 => 'particulars', 5 => 'quantity', 6 => 'unit', 7 => 'amount', 8 => 'requested_by',
        9 => 'deliberation_date', 10 => 'bac_status', 11 => 'resolution_number', 12 => 'released_at',
        13 => 'po_number', 14 => 'po_date', 15 => 'supplier', 16 => 'accountant_received_date',
        17 => 'coa_received_date', 18 => 'procurement_mode', 19 => 'description',
        20 => 'po_quantity', 21 => 'po_unit', 22 => 'po_amount', 23 => 'po_released_time',
        24 => 'po_released_date', 25 => 'ors_date', 26 => 'received_time', 27 => 'ors_number',
        28 => 'uacs_code', 29 => 'mfo_pap', 30 => 'ors_amount', 31 => 'ors_released_date',
        32 => 'ors_released_time', 33 => 'iar_number', 34 => 'inspection_date',
        35 => 'inspection_result', 36 => 'acceptance_date', 37 => 'inspector_signed_date',
        38 => 'dv_date', 39 => 'dv_number', 40 => 'gross_amount', 41 => 'tax',
        42 => 'net_amount', 43 => 'dv_received_at', 44 => 'dv_remarks',
        45 => 'forwarded_returned_date', 46 => 'payment_date', 47 => 'reference_number',
        48 => 'payment_amount', 49 => 'jev_date', 50 => 'jev_number',
    ];
}

function normalize_header(string $value): string
{
    return trim(preg_replace('/[^a-z0-9]+/', ' ', strtolower($value)) ?? '');
}

function excel_cell_column(string $reference): int
{
    preg_match('/^[A-Z]+/', strtoupper($reference), $match);
    $number = 0;
    foreach (str_split($match[0] ?? 'A') as $letter) $number = $number * 26 + ord($letter) - 64;
    return $number - 1;
}

function xml_texts(SimpleXMLElement $node, string $namespace): string
{
    $node->registerXPathNamespace('x', $namespace);
    $parts = $node->xpath('.//x:t');
    return $parts ? implode('', array_map(static fn(SimpleXMLElement $part): string => (string)$part, $parts)) : '';
}

function xlsx_sheets(string $path): array
{
    if (!class_exists(ZipArchive::class)) {
        throw new RuntimeException('PHP Zip extension is required to read Excel workbooks. Enable extension=zip in php.ini and restart Apache.');
    }
    $zip = new ZipArchive();
    if ($zip->open($path) !== true) throw new InvalidArgumentException('The uploaded file is not a readable XLSX workbook.');
    $mainNs = 'http://schemas.openxmlformats.org/spreadsheetml/2006/main';
    try {
        $workbookXml = $zip->getFromName('xl/workbook.xml');
        $relsXml = $zip->getFromName('xl/_rels/workbook.xml.rels');
        if ($workbookXml === false || $relsXml === false) throw new InvalidArgumentException('The file is missing required Excel workbook metadata.');
        $workbook = simplexml_load_string($workbookXml);
        $rels = simplexml_load_string($relsXml);
        if (!$workbook || !$rels) throw new InvalidArgumentException('The Excel workbook metadata is invalid.');

        $targets = [];
        $relNs = 'http://schemas.openxmlformats.org/package/2006/relationships';
        $rels->registerXPathNamespace('p', $relNs);
        foreach ($rels->xpath('/p:Relationships/p:Relationship') ?: [] as $relation) {
            $attrs = $relation->attributes();
            $targets[(string)$attrs['Id']] = (string)$attrs['Target'];
        }
        $shared = [];
        $sharedXml = $zip->getFromName('xl/sharedStrings.xml');
        if ($sharedXml !== false && ($sharedRoot = simplexml_load_string($sharedXml))) {
            $sharedRoot->registerXPathNamespace('x', $mainNs);
            foreach ($sharedRoot->xpath('/x:sst/x:si') ?: [] as $item) $shared[] = xml_texts($item, $mainNs);
        }

        $result = [];
        $relIdNs = 'http://schemas.openxmlformats.org/officeDocument/2006/relationships';
        $workbook->registerXPathNamespace('x', $mainNs);
        foreach ($workbook->xpath('/x:workbook/x:sheets/x:sheet') ?: [] as $sheet) {
            $attrs = $sheet->attributes($relIdNs);
            $name = (string)$sheet['name'];
            $target = $targets[(string)$attrs['id']] ?? '';
            if ($target === '') continue;
            $entry = str_starts_with($target, '/') ? ltrim($target, '/') : (str_starts_with($target, 'xl/') ? $target : 'xl/' . $target);
            $entry = preg_replace('#(^|/)worksheets/\.\./#', '$1', $entry) ?? $entry;
            $sheetXml = $zip->getFromName($entry);
            if ($sheetXml === false || !($root = simplexml_load_string($sheetXml))) continue;
            $rows = [];
            $root->registerXPathNamespace('x', $mainNs);
            foreach ($root->xpath('/x:worksheet/x:sheetData/x:row') ?: [] as $row) {
                $values = [];
                $row->registerXPathNamespace('x', $mainNs);
                foreach ($row->xpath('./x:c') ?: [] as $cell) {
                    $cell->registerXPathNamespace('x', $mainNs);
                    $attrs = $cell->attributes();
                    $index = excel_cell_column((string)$attrs['r']);
                    $type = (string)$attrs['t'];
                    $valueNodes = $cell->xpath('./x:v');
                    $value = isset($valueNodes[0]) ? (string)$valueNodes[0] : '';
                    if ($type === 's') $value = $shared[(int)$value] ?? '';
                    elseif ($type === 'inlineStr') {
                        $inlineNodes = $cell->xpath('./x:is');
                        $value = isset($inlineNodes[0]) ? xml_texts($inlineNodes[0], $mainNs) : '';
                    }
                    $values[$index] = $value;
                }
                if ($values) {
                    ksort($values);
                    $rows[(int)$row['r']] = $values;
                }
            }
            $result[$name] = $rows;
        }
        return $result;
    } finally {
        $zip->close();
    }
}

function convert_excel_value(string $key, string $value): string
{
    if (in_array(strtolower(trim($value)), ['n/a', 'na'], true)) return '';
    if ($value === '' || !is_numeric($value)) return $value;
    $serial = (float)$value;
    if (str_ends_with($key, '_time') && $serial >= 0 && $serial < 1) {
        return gmdate('H:i', (int)round($serial * 86400));
    }
    if (($serial === 0.0 || $serial < 1) && (str_ends_with($key, '_at') || str_ends_with($key, '_date'))) return '';
    if ($serial < 1 || $serial > 2958465) return $value;
    $dateKeys = ['_at', '_date'];
    foreach ($dateKeys as $suffix) {
        if (str_ends_with($key, $suffix)) {
            $timestamp = strtotime('1899-12-30 00:00:00 UTC') + (int)round($serial * 86400);
            return str_ends_with($key, '_at') ? gmdate('Y-m-d H:i', $timestamp) : gmdate('Y-m-d', $timestamp);
        }
    }
    return $value;
}
function preview_workbook(string $path, ?string $workbookGroup = null): array
{
    if ($workbookGroup !== null && !preg_match('/^[A-Za-z0-9][A-Za-z0-9 ._-]{0,29}$/', $workbookGroup)) {
        throw new InvalidArgumentException('Workbook group names must be 1–30 letters, numbers, spaces, dots, underscores, or hyphens, and start with a letter or number.');
    }
    $sheets = xlsx_sheets($path);
    foreach (['2026', 'SPLIT 2026'] as $name) {
        if (!array_key_exists($name, $sheets)) throw new InvalidArgumentException('The workbook must contain both worksheets named 2026 and SPLIT 2026.');
    }
    $columnMap = import_column_map();
    $rows = [];
    $errors = [];
    $warnings = [];
    $duplicates = [];
    $ignored = 0;
    $seen = [];
    $existing = db()->query('SELECT t.worksheet,pr.pr_number,pr.particulars FROM transactions t JOIN purchase_requests pr ON pr.transaction_id=t.id WHERE pr.pr_number IS NOT NULL')->fetchAll();
    foreach ($existing as $record) {
        $key = strtolower(trim($record['worksheet']) . '|' . trim($record['pr_number']) . '|' . trim((string)$record['particulars']));
        $seen[$key] = true;
    }

    foreach (['2026', 'SPLIT 2026'] as $worksheet) {
        $sheetRows = $sheets[$worksheet];
        $headerRow = null;
        $headers = [];
        foreach (array_slice($sheetRows, 0, 15, true) as $rowNumber => $candidate) {
            $mapped = [];
            foreach ($candidate as $column => $text) $mapped[$column] = $columnMap[normalize_header((string)$text)] ?? null;
            if (in_array('pr_number', $mapped, true) || in_array('particulars', $mapped, true)) {
                $headerRow = $rowNumber;
                $headers = tracker_import_column_map($candidate) ?? $mapped;
                break;
            }
        }
        if ($headerRow === null) {
            $errors[] = $worksheet . ': could not identify a header row (PR Number or Particulars column missing).';
            continue;
        }
        foreach ($sheetRows as $rowNumber => $cells) {
            if ($rowNumber <= $headerRow) continue;
            $releaseTime = trim((string)($cells[23] ?? ''));
            $releaseDate = trim((string)($cells[24] ?? ''));
            if (is_numeric($releaseTime) && (float)$releaseTime >= 1
                && is_numeric($releaseDate) && (float)$releaseDate >= 0 && (float)$releaseDate < 1) {
                $cells[23] = $releaseDate;
                $cells[24] = $releaseTime;
                $warnings[] = "$worksheet row $rowNumber: PO release date and time appeared in reversed columns; preview corrected them by Excel value format.";
            }
                $row = ['worksheet' => $workbookGroup ?? $worksheet, 'source_worksheet' => $worksheet];
            foreach ($headers as $column => $key) {
                if ($key !== null) $row[$key] = convert_excel_value($key, trim((string)($cells[$column] ?? '')));
            }
            if (count(array_filter($row, static fn($value): bool => is_string($value) && $value !== '')) <= 1) continue;
            if (trim((string)($row['pr_number'] ?? '')) === '' && trim((string)($row['particulars'] ?? '')) === '') {
                $ignored++;
                continue;
            }
            foreach ([
                'pr_date' => 'date', 'received_at' => 'datetime', 'quantity' => 'number', 'po_quantity' => 'number', 'amount' => 'money',
                'deliberation_date' => 'date', 'released_at' => 'datetime', 'po_date' => 'date',
                'accountant_received_date' => 'date', 'coa_received_date' => 'date', 'po_amount' => 'money',
                'po_released_time' => 'time', 'po_released_date' => 'date', 'ors_date' => 'date', 'received_time' => 'time',
                'ors_amount' => 'money', 'ors_released_date' => 'date', 'ors_released_time' => 'time',
                'inspection_date' => 'date', 'acceptance_date' => 'date', 'inspector_signed_date' => 'date',
                'dv_date' => 'date', 'gross_amount' => 'money', 'tax' => 'money', 'net_amount' => 'money',
                'dv_received_at' => 'datetime', 'forwarded_returned_date' => 'date', 'payment_date' => 'date',
                'payment_amount' => 'money', 'jev_date' => 'date',
            ] as $field => $type) {
                if (!isset($row[$field]) || $row[$field] === '') continue;
                try {
                    normalize_value($field, $type, $row[$field]);
                } catch (InvalidArgumentException $exception) {
                    $warnings[] = "$worksheet row $rowNumber: " . str_replace('_', ' ', $field) . ' value was omitted (' . $exception->getMessage() . ')';
                    $row[$field] = '';
                }
            }
            $key = strtolower(trim($row['worksheet'] . '|' . (string)($row['pr_number'] ?? '') . '|' . (string)($row['particulars'] ?? '')));
            $row['_duplicate'] = !empty($row['pr_number']) && isset($seen[$key]);
            if ($row['_duplicate']) $duplicates[] = $key;
            if (!empty($row['pr_number'])) $seen[$key] = true;
            $row['_source_row'] = $rowNumber;
            $row['key'] = $key;
            $rows[] = $row;
            if (count($rows) > 2000) throw new InvalidArgumentException('Import is limited to 2,000 non-empty rows per preview.');
        }
    }
    return ['rows' => $rows, 'errors' => $errors, 'warnings' => $warnings, 'duplicates' => array_values(array_unique($duplicates)), 'ignored' => $ignored, 'workbook_group' => $workbookGroup];
}
