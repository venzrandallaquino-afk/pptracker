<?php
declare(strict_types=1);

function render_register_module(string $page, array $user): void
{
    $filters = transaction_filters();
    [$where, $params] = transaction_filter_sql($filters);
    if (isset(STAGES[$page])) {
        $table = STAGES[$page]['table'];
        $where[] = $page === 'cashier'
            ? 'EXISTS (SELECT 1 FROM payment_records p WHERE p.transaction_id=t.id)'
            : "EXISTS (SELECT 1 FROM `$table` s WHERE s.transaction_id=t.id)";
    }
    $sql = 'SELECT t.id,t.transaction_code,t.worksheet,t.status,t.current_stage,t.updated_at,pr.pr_number,pr.particulars,pr.requested_by,pr.amount,po.supplier FROM transactions t LEFT JOIN purchase_requests pr ON pr.transaction_id=t.id LEFT JOIN purchase_orders po ON po.transaction_id=t.id';
    if ($where) $sql .= ' WHERE ' . implode(' AND ', $where);
    $sql .= ' ORDER BY t.updated_at DESC LIMIT 100';
    $stmt = db()->prepare($sql);
    $stmt->execute($params);
    $rows = $stmt->fetchAll();
    ?>
    <section class="panel">
        <?php if ($page === 'transactions' && can_access_stage('purchase_requests', $user)): ?><div class="register-new-action"><button class="button primary" type="button" data-open-transaction>+ New Transaction</button></div><?php endif; ?>
        <?php render_filter_controls($filters, $page); ?><div class="form-actions"><button class="button secondary" data-print type="button">Print / Save PDF</button>
        <?php $exportFilters = array_filter($filters, static fn(string $value): bool => $value !== ''); $exportQuery = http_build_query(array_merge(['page' => 'export-xlsx'], $exportFilters)); $csvQuery = http_build_query(array_merge(['page' => 'export'], $exportFilters)); ?><a class="button primary" href="index.php?<?= h($exportQuery) ?>">Export Excel</a><a class="button secondary" href="index.php?<?= h($csvQuery) ?>">Export CSV</a></div></section>
    <section class="panel"><div class="panel-heading"><div><h2><?= isset(STAGES[$page]) ? h(STAGES[$page]['label']) : 'All transactions' ?></h2><p><?= count($rows) ?> records shown (up to 100)</p></div></div><?php render_transaction_table($rows); ?></section>
    <?php if ($page === 'transactions' && can_access_stage('purchase_requests', $user)) render_transaction_form_module($user, true); ?>
    <?php
}
