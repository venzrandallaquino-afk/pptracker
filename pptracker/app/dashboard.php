<?php
declare(strict_types=1);

function render_dashboard(array $user): void
{
    $filters = transaction_filters();
    [$where, $params] = transaction_filter_sql($filters);
    $base = ' FROM transactions t LEFT JOIN purchase_requests pr ON pr.transaction_id=t.id LEFT JOIN purchase_orders po ON po.transaction_id=t.id';
    $filter = $where ? ' WHERE ' . implode(' AND ', $where) : '';
    $metricsQuery = db()->prepare('SELECT COUNT(DISTINCT t.id) AS total, SUM(t.status="Completed") AS completed, COALESCE(SUM(pr.amount),0) AS amount' . $base . $filter);
    $metricsQuery->execute($params);
    $metrics = $metricsQuery->fetch();
    $total = (int)$metrics['total'];
    $completed = (int)$metrics['completed'];
    $amount = (float)$metrics['amount'];
    $paymentSql = 'SELECT COALESCE(SUM(p.amount),0) FROM payment_records p JOIN transactions t ON t.id=p.transaction_id LEFT JOIN purchase_requests pr ON pr.transaction_id=t.id LEFT JOIN purchase_orders po ON po.transaction_id=t.id' . $filter;
    $paymentQuery = db()->prepare($paymentSql);
    $paymentQuery->execute($params);
    $payments = (float)$paymentQuery->fetchColumn();
    $poQuery = db()->prepare('SELECT COUNT(DISTINCT t.id)' . $base . $filter . ($filter ? ' AND ' : ' WHERE ') . 'po.po_number IS NOT NULL AND po.po_number<>""');
    $poQuery->execute($params);
    $purchaseOrders = (int)$poQuery->fetchColumn();
    $recentQuery = db()->prepare('SELECT t.id,t.transaction_code,t.worksheet,t.status,t.current_stage,t.updated_at,pr.pr_number,pr.particulars,pr.requested_by,pr.amount,po.supplier' . $base . $filter . ' ORDER BY t.updated_at DESC LIMIT 8');
    $recentQuery->execute($params);
    $recent = $recentQuery->fetchAll();
    $stageQuery = db()->prepare('SELECT t.current_stage,COUNT(DISTINCT t.id) AS total' . $base . $filter . ' GROUP BY t.current_stage');
    $stageQuery->execute($params);
    $byStage = array_column($stageQuery->fetchAll(), 'total', 'current_stage');
    $supplierCondition = $filter ? $filter . ' AND ' : ' WHERE ';
    $supplierQuery = db()->prepare('SELECT po.supplier,COUNT(*) AS total,COALESCE(SUM(po.amount),0) AS amount' . $base . $supplierCondition . 'po.supplier IS NOT NULL AND po.supplier<>"" GROUP BY po.supplier ORDER BY amount DESC LIMIT 5');
    $supplierQuery->execute($params);
    $suppliers = $supplierQuery->fetchAll();
    $staleQuery = db()->prepare('SELECT COUNT(DISTINCT t.id)' . $base . ($filter ? $filter . ' AND ' : ' WHERE ') . 't.status="In Progress" AND t.updated_at < DATE_SUB(NOW(), INTERVAL 14 DAY)');
    $staleQuery->execute($params);
    $stale = (int)$staleQuery->fetchColumn();
    ?>
    <section class="panel"><?php render_filter_controls($filters, 'dashboard'); ?><div class="form-actions"><button class="button secondary" data-print type="button">Print / Save PDF</button></div></section>
    <section class="welcome-panel"><div><span class="eyebrow">WORKFLOW OVERVIEW</span><h2>Track each transaction, stage by stage.</h2><p>Stage completion is recorded explicitly by the responsible team. Adding a document reference alone does not mark a stage complete.</p></div><a class="button light" href="index.php?page=transactions">Open register <span>→</span></a></section>
    <section class="metric-grid">
        <article class="metric"><span>Total Transactions</span><strong><?= $total ?></strong><small>Across both workbook groups</small></article>
        <article class="metric"><span>Purchase Request Amount</span><strong><?= h(money($amount)) ?></strong><small>Sum of recorded PR amounts</small></article>
        <article class="metric"><span>Purchase Orders</span><strong><?= $purchaseOrders ?></strong><small>PO numbers recorded</small></article>
        <article class="metric"><span>In Progress</span><strong><?= max(0, $total - $completed) ?></strong><small>Not marked complete at every stage</small></article>
        <article class="metric"><span>Completed</span><strong><?= $completed ?></strong><small>All workflow stages explicitly complete</small></article>
        <article class="metric"><span>Recorded Payments</span><strong><?= h(money($payments)) ?></strong><small>Sum of cashier entries</small></article>
    </section>
    <?php if ($stale > 0): ?><div class="alert warning"><?= $stale ?> in-progress transactions have not been updated in 14 days. This is a follow-up reminder, not an automatic overdue determination.</div><?php endif; ?>
    <section class="panel"><div class="panel-heading"><div><h2>Transactions by current stage</h2><p>Stage progress is based on explicit workflow status selections.</p></div></div><div class="bar-list"><?php foreach (STAGES as $key => $stage): $count = (int)($byStage[$key] ?? 0); $width = $total ? (int)round($count / $total * 100) : 0; ?><div class="bar-row"><span><?= h($stage['label']) ?></span><div class="bar-track"><i style="width:<?= $width ?>%"></i></div><strong><?= $count ?></strong></div><?php endforeach; ?></div></section>
    <section class="panel"><div class="panel-heading"><div><h2>Recent transactions</h2><p>Latest updated records</p></div><a class="text-link" href="index.php?page=transactions">View register →</a></div>
        <?php render_transaction_table($recent); ?>
    </section>
    <section class="panel"><div class="panel-heading"><div><h2>Top suppliers</h2><p>Purchase order totals for recorded suppliers</p></div></div><?php if ($suppliers): ?><div class="table-wrap"><table><thead><tr><th>Supplier</th><th>Purchase Orders</th><th>PO Amount</th></tr></thead><tbody><?php foreach ($suppliers as $supplier): ?><tr><td><?= h($supplier['supplier']) ?></td><td><?= (int)$supplier['total'] ?></td><td><?= h(money((float)$supplier['amount'])) ?></td></tr><?php endforeach; ?></tbody></table></div><?php else: ?><div class="empty-state compact">No supplier amounts are recorded yet.</div><?php endif; ?></section>
    <section class="panel"><div class="panel-heading"><div><h2>Workflow stages</h2><p>Open your assigned work area to update its stage.</p></div></div><div class="stage-grid"><?php foreach (STAGES as $key => $stage): ?>
        <div class="stage-card"><span class="stage-tag"><?= h($stage['short']) ?></span><div><strong><?= h($stage['label']) ?></strong><small><?= h($stage['role']) ?></small></div></div>
    <?php endforeach; ?></div></section>
    <?php
}
