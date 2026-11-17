<?php
declare(strict_types=1);

function render_workflow_module(string $page): void
{
    echo '<section class="panel"><div class="panel-heading"><div><h2>Assigned transactions</h2><p>All transactions are listed so you can open or start their ' . h(STAGES[$page]['label']) . ' details.</p></div></div>';
    $query = 'SELECT t.id,t.transaction_code,t.worksheet,t.status,t.current_stage,t.updated_at,pr.pr_number,pr.particulars,pr.requested_by,pr.amount,po.supplier FROM transactions t LEFT JOIN purchase_requests pr ON pr.transaction_id=t.id LEFT JOIN purchase_orders po ON po.transaction_id=t.id ORDER BY t.updated_at DESC LIMIT 100';
    render_transaction_table(db()->query($query)->fetchAll(), $page);
    echo '</section>';
}
