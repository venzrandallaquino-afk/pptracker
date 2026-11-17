<?php
declare(strict_types=1);

function render_reports_module(): void
{
    $filters = transaction_filters();
    [$where, $params] = transaction_filter_sql($filters);
    $base = ' FROM transactions t LEFT JOIN purchase_requests pr ON pr.transaction_id=t.id LEFT JOIN purchase_orders po ON po.transaction_id=t.id';
    $filter = $where ? ' WHERE ' . implode(' AND ', $where) : '';
    $summary = db()->prepare('SELECT t.worksheet, COUNT(DISTINCT t.id) AS transactions, SUM(t.status="Completed") AS completed, SUM(t.status="In Progress") AS in_progress, COALESCE(SUM(pr.amount),0) AS pr_total' . $base . $filter . ' GROUP BY t.worksheet');
    $summary->execute($params);
    $stats = $summary->fetchAll();
    $monthlyQuery = db()->prepare("SELECT DATE_FORMAT(pr.pr_date,'%Y-%m') AS month, COUNT(DISTINCT t.id) AS transactions, COALESCE(SUM(pr.amount),0) AS amount" . $base . $filter . ($filter ? ' AND' : ' WHERE') . ' pr.pr_date IS NOT NULL GROUP BY month ORDER BY month DESC LIMIT 12');
    $monthlyQuery->execute($params);
    $monthly = $monthlyQuery->fetchAll();
    $supplierQuery = db()->prepare('SELECT po.supplier,COUNT(DISTINCT t.id) AS transactions,COALESCE(SUM(po.amount),0) AS amount' . $base . $filter . ($filter ? ' AND' : ' WHERE') . ' po.supplier IS NOT NULL AND po.supplier<>"" GROUP BY po.supplier ORDER BY amount DESC LIMIT 50');
    $supplierQuery->execute($params);
    $supplierReport = $supplierQuery->fetchAll();
    $totalRecords = db()->prepare('SELECT COUNT(DISTINCT t.id)' . $base . $filter);
    $totalRecords->execute($params);
    $totalFiltered = (int)$totalRecords->fetchColumn();
    $paymentReport = db()->prepare('SELECT COALESCE(SUM(p.amount),0) FROM payment_records p JOIN transactions t ON t.id=p.transaction_id LEFT JOIN purchase_requests pr ON pr.transaction_id=t.id LEFT JOIN purchase_orders po ON po.transaction_id=t.id' . $filter);
    $paymentReport->execute($params);
    $totalPayments = (float)$paymentReport->fetchColumn();
    ?>
    <section class="panel"><?php render_filter_controls($filters, 'reports'); ?><div class="form-actions"><button class="button secondary" data-print type="button">Print / Save PDF</button><?php $reportFilters = array_filter($filters, static fn(string $value): bool => $value !== ''); $reportExport = http_build_query(array_merge(['page' => 'export-xlsx'], $reportFilters)); $csvExport = http_build_query(array_merge(['page' => 'export'], $reportFilters)); ?><a class="button primary" href="index.php?<?= h($reportExport) ?>">Export Excel</a><a class="button secondary" href="index.php?<?= h($csvExport) ?>">Export CSV</a></div></section>
    <section class="metric-grid compact-grid"><article class="metric"><span>Filtered Transactions</span><strong><?= $totalFiltered ?></strong></article><article class="metric"><span>Filtered Payments</span><strong><?= h(money($totalPayments)) ?></strong></article></section>
    <section class="panel"><div class="panel-heading"><div><h2>Worksheet summary</h2><p>2026 and SPLIT 2026 remain separate groups.</p></div></div><div class="table-wrap"><table><thead><tr><th>Worksheet</th><th>Transactions</th><th>In Progress</th><th>Completed</th><th>PR Amount</th></tr></thead><tbody><?php foreach ($stats as $row): ?><tr><td><?= h($row['worksheet']) ?></td><td><?= (int)$row['transactions'] ?></td><td><?= (int)$row['in_progress'] ?></td><td><?= (int)$row['completed'] ?></td><td><?= h(money((float)$row['pr_total'])) ?></td></tr><?php endforeach; ?></tbody></table></div></section>
    <section class="panel"><div class="panel-heading"><div><h2>Monthly PR summary</h2><p>Monthly groups from recorded PR dates.</p></div></div><div class="table-wrap"><table><thead><tr><th>Month</th><th>Transactions</th><th>PR Amount</th></tr></thead><tbody><?php foreach ($monthly as $row): ?><tr><td><?= h($row['month']) ?></td><td><?= (int)$row['transactions'] ?></td><td><?= h(money((float)$row['amount'])) ?></td></tr><?php endforeach; ?></tbody></table></div></section>
    <section class="panel"><div class="panel-heading"><div><h2>Supplier report</h2><p>Purchase order amounts by supplier</p></div></div><div class="table-wrap"><table><thead><tr><th>Supplier</th><th>Transactions</th><th>PO Amount</th></tr></thead><tbody><?php foreach ($supplierReport as $row): ?><tr><td><?= h($row['supplier']) ?></td><td><?= (int)$row['transactions'] ?></td><td><?= h(money((float)$row['amount'])) ?></td></tr><?php endforeach; ?></tbody></table></div></section>
    <?php
}
