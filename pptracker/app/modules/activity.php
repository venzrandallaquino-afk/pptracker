<?php
declare(strict_types=1);

function render_activity_module(): void
{
    $rows = db()->query('SELECT a.*,u.name AS user_name,t.transaction_code FROM activity_logs a LEFT JOIN users u ON a.user_id=u.id LEFT JOIN transactions t ON a.transaction_id=t.id ORDER BY a.created_at DESC LIMIT 200')->fetchAll();
    ?>
    <section class="panel"><div class="panel-heading"><div><h2>Recent activity</h2><p>Most recent 200 account and transaction events</p></div></div><div class="table-wrap"><table><thead><tr><th>Date</th><th>User</th><th>Action</th><th>Transaction</th><th>Details</th></tr></thead><tbody><?php foreach ($rows as $row): ?><tr><td><?= h($row['created_at']) ?></td><td><?= h($row['user_name'] ?? 'Removed account') ?></td><td><?= h($row['action']) ?></td><td><?= h($row['transaction_code'] ?? '—') ?></td><td><?= h($row['details'] ?? '—') ?></td></tr><?php endforeach; ?></tbody></table></div></section>
    <?php
}
