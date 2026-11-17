<?php
declare(strict_types=1);

$config = require dirname(__DIR__) . '/config.php';
date_default_timezone_set($config['timezone']);

const APP_ROLES = [
    'Administrator', 'Encoder / Records Staff', 'BAC Personnel', 'Procurement Personnel',
    'Budget Personnel', 'Inspection Personnel', 'Accounting Personnel', 'Cashier', 'Viewer / Management',
];
const STAGES = [
    'purchase_requests' => ['label' => 'Purchase Requests', 'short' => 'PR', 'icon' => '▤', 'role' => 'Encoder / Records Staff', 'table' => 'purchase_requests'],
    'bac' => ['label' => 'BAC Management', 'short' => 'BAC', 'icon' => '⚖', 'role' => 'BAC Personnel', 'table' => 'bac_records'],
    'purchase_orders' => ['label' => 'Purchase Orders / Contracts', 'short' => 'PO', 'icon' => '▣', 'role' => 'Procurement Personnel', 'table' => 'purchase_orders'],
    'ors' => ['label' => 'ORS Management', 'short' => 'ORS', 'icon' => '◷', 'role' => 'Budget Personnel', 'table' => 'ors_records'],
    'iar' => ['label' => 'IAR Management', 'short' => 'IAR', 'icon' => '✓', 'role' => 'Inspection Personnel', 'table' => 'iar_records'],
    'dv' => ['label' => 'DV Management', 'short' => 'DV', 'icon' => '▧', 'role' => 'Accounting Personnel', 'table' => 'dv_records'],
    'cashier' => ['label' => 'Cashier / Payments', 'short' => 'Payment', 'icon' => '¤', 'role' => 'Cashier', 'table' => 'payment_records'],
    'jev' => ['label' => 'JEV Management', 'short' => 'JEV', 'icon' => '▥', 'role' => 'Accounting Personnel', 'table' => 'jev_records'],
];
const WORKFLOW_STATUSES = ['Not Started', 'In Progress', 'Completed', 'Returned', 'On Hold'];
const STAGE_FIELDS = [
    'purchase_requests' => [
        'sequence_number' => ['Sequence Number', 'text'], 'pr_date' => ['PR Date', 'date'],
        'pr_number' => ['PR Number', 'text'], 'received_at' => ['Date/Time Received from End-user', 'datetime'],
        'particulars' => ['Particulars', 'textarea'], 'quantity' => ['Quantity', 'number'],
        'unit' => ['Unit', 'text'], 'amount' => ['Amount', 'money'], 'requested_by' => ['Requested By', 'text'],
        'workflow_status' => ['Stage Status', 'status'],
    ],
    'bac' => [
        'deliberation_date' => ['Deliberation Date', 'date'], 'status' => ['BAC Decision / Status', 'text'],
        'resolution_number' => ['Resolution Number', 'text'], 'released_at' => ['Date/Time Released', 'datetime'],
        'workflow_status' => ['Stage Status', 'status'], 'remarks' => ['Remarks', 'textarea'],
    ],
    'purchase_orders' => [
        'po_number' => ['PO / Contract Number', 'text'], 'po_date' => ['PO / Contract Date', 'date'],
        'supplier' => ['Supplier', 'text'], 'accountant_received_date' => ['Date Received After Signed by Accountant', 'date'],
        'coa_received_date' => ['Date Received by COA', 'date'], 'procurement_mode' => ['Mode of Procurement', 'text'],
        'description' => ['Description', 'textarea'], 'quantity' => ['Quantity', 'number'], 'unit' => ['Unit', 'text'],
        'amount' => ['Amount', 'money'], 'released_time' => ['Time Released', 'time'],
        'released_date' => ['Date Released', 'date'], 'workflow_status' => ['Stage Status', 'status'],
        'remarks' => ['Remarks', 'textarea'],
    ],
    'ors' => [
        'ors_date' => ['ORS Date', 'date'], 'received_time' => ['Time Received', 'time'],
        'ors_number' => ['ORS Number', 'text'], 'uacs_code' => ['UACS Code', 'text'],
        'mfo_pap' => ['MFO / PAP', 'text'], 'amount' => ['Amount', 'money'],
        'released_date' => ['Date Released', 'date'], 'released_time' => ['Time Released', 'time'],
        'workflow_status' => ['Stage Status', 'status'], 'remarks' => ['Remarks', 'textarea'],
    ],
    'iar' => [
        'iar_number' => ['IAR Number', 'text'], 'inspection_date' => ['Inspection Date', 'date'],
        'inspection_result' => ['Inspection Result', 'textarea'], 'acceptance_date' => ['Acceptance Date', 'date'],
        'inspector_signed_date' => ['Actual Date Signed by Inspector', 'date'],
        'workflow_status' => ['Stage Status', 'status'], 'remarks' => ['Remarks', 'textarea'],
    ],
    'dv' => [
        'dv_date' => ['DV Date', 'date'], 'dv_number' => ['DV Number / Control Number', 'text'],
        'gross_amount' => ['Gross Amount', 'money'], 'tax' => ['Tax', 'money'], 'net_amount' => ['Net Amount', 'money'],
        'received_at' => ['Date/Time Received', 'datetime'], 'remarks' => ['Remarks', 'textarea'],
        'forwarded_returned_date' => ['Date Forwarded / Returned', 'date'], 'workflow_status' => ['Stage Status', 'status'],
    ],
    'cashier' => [
        'payment_date' => ['Payment Date', 'date'], 'reference_number' => ['LDDAP-ADA / Check Number', 'text'],
        'amount' => ['Payment Amount', 'money'], 'remarks' => ['Remarks', 'textarea'],
        'workflow_status' => ['Payment Stage Status', 'status'],
    ],
    'jev' => [
        'jev_date' => ['JEV Date', 'date'], 'jev_number' => ['JEV Number', 'text'],
        'workflow_status' => ['Stage Status', 'status'], 'remarks' => ['Remarks', 'textarea'],
    ],
];

function db(): PDO
{
    static $pdo;
    global $config;
    if ($pdo instanceof PDO) return $pdo;
    $dsn = sprintf('mysql:host=%s;port=%s;dbname=%s;charset=utf8mb4', $config['db_host'], $config['db_port'], $config['db_name']);
    $pdo = new PDO($dsn, $config['db_user'], $config['db_password'], [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION,
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,
        PDO::ATTR_EMULATE_PREPARES => false,
    ]);
    return $pdo;
}

function install_schema(): void
{
    $sql = file_get_contents(dirname(__DIR__) . '/schema.sql');
    if (!is_string($sql)) throw new RuntimeException('The database schema file could not be read.');
    foreach (array_filter(array_map('trim', explode(';', $sql))) as $statement) db()->exec($statement);
}

function workbook_groups(): array
{
    return db()->query('SELECT name FROM workbook_groups ORDER BY is_default DESC, name')->fetchAll(PDO::FETCH_COLUMN);
}

function h(mixed $value): string
{
    return htmlspecialchars((string)($value ?? ''), ENT_QUOTES | ENT_SUBSTITUTE, 'UTF-8');
}

function current_user(): ?array
{
    static $resolved = false;
    static $resolvedUser = null;
    if ($resolved) return $resolvedUser;
    $resolved = true;
    $id = (int)($_SESSION['user']['id'] ?? 0);
    if ($id < 1) return null;
    $stmt = db()->prepare('SELECT id,name,username,role FROM users WHERE id=? AND active=1');
    $stmt->execute([$id]);
    $user = $stmt->fetch();
    if (!$user) {
        unset($_SESSION['user']);
        return null;
    }
    $resolvedUser = [
        'id' => (int)$user['id'],
        'name' => $user['name'],
        'username' => $user['username'],
        'role' => $user['role'],
    ];
    $_SESSION['user'] = $resolvedUser;
    return $resolvedUser;
}

function can_access_stage(string $stage, ?array $user = null): bool
{
    static $accessCache = [];
    $user ??= current_user();
    if ($user === null || !isset(STAGES[$stage])) return false;
    if ($user['role'] === 'Administrator') return true;
    $id = (int)$user['id'];
    if (!isset($accessCache[$id])) {
        $stmt = db()->prepare('SELECT stage FROM user_stage_access WHERE user_id=?');
        $stmt->execute([$id]);
        $accessCache[$id] = $stmt->fetchAll(PDO::FETCH_COLUMN);
        if ($accessCache[$id] === []) {
            $accessCache[$id] = array_values(array_filter(array_keys(STAGES), static fn(string $key): bool => STAGES[$key]['role'] === $user['role']));
        }
    }
    return in_array($stage, $accessCache[$id], true);
}

function stage_grants(mixed $input, string $role): array
{
    if (!is_array($input)) throw new InvalidArgumentException('Choose valid workflow permissions.');
    $stages = [];
    foreach ($input as $stage) {
        if (!is_string($stage) || !isset(STAGES[$stage])) throw new InvalidArgumentException('Choose valid workflow permissions.');
        $stages[] = $stage;
    }
    $stages = array_values(array_unique($stages));
    if ($role !== 'Administrator' && $role !== 'Viewer / Management' && $stages === []) {
        throw new InvalidArgumentException('Assign at least one valid workflow permission to this user.');
    }
    return $stages;
}

function require_login(): array
{
    $user = current_user();
    if ($user === null) redirect('index.php');
    return $user;
}

function csrf_token(): string
{
    $_SESSION['csrf'] ??= bin2hex(random_bytes(32));
    return $_SESSION['csrf'];
}

function verify_csrf(): void
{
    $token = $_POST['csrf'] ?? '';
    if (!is_string($token) || !hash_equals(csrf_token(), $token)) {
        http_response_code(419);
        exit('Your session expired. Refresh the page and try again.');
    }
}

function redirect(string $url): never
{
    header('Location: ' . $url);
    exit;
}

function flash(string $message, string $kind = 'success'): void
{
    $_SESSION['flash'] = ['message' => $message, 'kind' => $kind];
}

function audit(string $action, ?int $transactionId = null, ?string $details = null): void
{
    $user = current_user();
    $stmt = db()->prepare('INSERT INTO activity_logs (user_id, transaction_id, action, details, ip_address) VALUES (?, ?, ?, ?, ?)');
    $stmt->execute([$user['id'] ?? null, $transactionId, $action, $details, $_SERVER['REMOTE_ADDR'] ?? null]);
}

function normalize_value(string $key, string $type, mixed $raw): ?string
{
    if ($raw !== null && !is_scalar($raw)) throw new InvalidArgumentException('Invalid value for ' . str_replace('_', ' ', $key) . '.');
    $value = trim((string)$raw);
    if ($value === '') return null;
    if (strlen($value) > 5000) throw new InvalidArgumentException('Each field must be 5,000 characters or fewer.');
    if ($type === 'status' && !in_array($value, WORKFLOW_STATUSES, true)) throw new InvalidArgumentException('Choose a valid workflow status.');
    if ($type === 'date') {
        $date = DateTimeImmutable::createFromFormat('!Y-m-d', $value);
        if (!$date || $date->format('Y-m-d') !== $value) throw new InvalidArgumentException('Enter a real date in YYYY-MM-DD format.');
    }
    if ($type === 'datetime') {
        $value = str_replace('T', ' ', $value);
        $formats = ['!Y-m-d H:i:s', '!Y-m-d H:i'];
        $matched = false;
        foreach ($formats as $format) {
            $date = DateTimeImmutable::createFromFormat($format, $value);
            if ($date !== false && $date->format(str_replace('!', '', $format)) === $value) {
                $value = $date->format('Y-m-d H:i:s');
                $matched = true;
                break;
            }
        }
        if (!$matched) throw new InvalidArgumentException('Enter a real date and time in a valid format.');
    }
    if ($type === 'time') {
        $formats = ['!H:i:s', '!H:i'];
        $matched = false;
        foreach ($formats as $format) {
            $time = DateTimeImmutable::createFromFormat($format, $value);
            if ($time !== false && $time->format(str_replace('!', '', $format)) === $value) {
                $value = $time->format(str_replace('!', '', $format));
                $matched = true;
                break;
            }
        }
        if (!$matched) throw new InvalidArgumentException('Enter a real time in HH:MM format.');
    }
    if (in_array($type, ['money', 'number'], true)) {
        $value = str_replace([',', '₱', ' '], '', $value);
        if (!is_numeric($value) || (float)$value < 0) throw new InvalidArgumentException('Enter a valid non-negative number.');
        $value = number_format((float)$value, $type === 'money' ? 2 : 3, '.', '');
    }
    return $value;
}
function transaction_row(int $id): ?array
{
    $stmt = db()->prepare('SELECT t.*, pr.pr_number, pr.pr_date, pr.particulars, pr.requested_by, pr.amount AS pr_amount, po.supplier, po.po_number FROM transactions t LEFT JOIN purchase_requests pr ON pr.transaction_id=t.id LEFT JOIN purchase_orders po ON po.transaction_id=t.id WHERE t.id=?');
    $stmt->execute([$id]);
    $row = $stmt->fetch();
    return $row ?: null;
}

function module_data(int $id, string $stage, array $user): array
{
    if (!isset(STAGES[$stage]) || !can_access_stage($stage, $user)) return [];
    $table = STAGES[$stage]['table'];
    $stmt = db()->prepare($stage === 'cashier'
        ? 'SELECT * FROM payment_records WHERE transaction_id=? ORDER BY payment_date DESC, id DESC'
        : "SELECT * FROM `$table` WHERE transaction_id=?");
    $stmt->execute([$id]);
    if ($stage === 'cashier') return $stmt->fetchAll();
    return $stmt->fetch() ?: [];
}

function stage_statuses(int $id): array
{
    $statuses = [];
    foreach (STAGES as $stage => $info) {
        if ($stage === 'cashier') {
            $stmt = db()->prepare('SELECT COUNT(*), SUM(workflow_status = ?) FROM payment_records WHERE transaction_id=?');
            $stmt->execute(['Completed', $id]);
            [$count, $done] = $stmt->fetch(PDO::FETCH_NUM);
            $statuses[$stage] = (int)$count === 0 ? 'Not Started' : ((int)$count === (int)$done ? 'Completed' : 'In Progress');
            continue;
        }
        $stmt = db()->prepare("SELECT workflow_status FROM `{$info['table']}` WHERE transaction_id=?");
        $stmt->execute([$id]);
        $value = $stmt->fetchColumn();
        $statuses[$stage] = is_string($value) && $value !== '' ? $value : 'Not Started';
    }
    return $statuses;
}

function update_transaction_progress(int $id): void
{
    $statuses = stage_statuses($id);
    $next = array_key_last(STAGES);
    foreach (array_keys(STAGES) as $stage) {
        if (($statuses[$stage] ?? 'Not Started') !== 'Completed') {
            $next = $stage;
            break;
        }
    }
    $complete = count(array_filter($statuses, static fn(string $status): bool => $status === 'Completed')) === count(STAGES);
    db()->prepare('UPDATE transactions SET current_stage=?,status=?,updated_at=NOW() WHERE id=?')
        ->execute([$next, $complete ? 'Completed' : 'In Progress', $id]);
}

function status_class(string $status): string
{
    return match ($status) {
        'Completed' => 'complete', 'Returned' => 'returned', 'On Hold' => 'hold',
        'In Progress' => 'progress', default => 'pending',
    };
}

function money(float $amount): string
{
    return '₱' . number_format($amount, 2);
}

function csrf_field(): string
{
    return '<input type="hidden" name="csrf" value="' . h(csrf_token()) . '">';
}

require __DIR__ . '/import.php';
