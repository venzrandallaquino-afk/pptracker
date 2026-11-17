<?php
declare(strict_types=1);

function render_transaction_form_module(array $user, bool $inDialog = false): void
{
    if (!can_access_stage('purchase_requests', $user)) {
        echo '<div class="empty-state">Your role cannot create purchase requests.</div>';
        return;
    }
    if ($inDialog) {
        ?>
        <dialog class="transaction-dialog" id="transaction-dialog">
            <form method="post" class="form-stack dialog-form">
                <?= csrf_field() ?><input type="hidden" name="action" value="create_transaction">
                <div class="dialog-heading"><div><h2>New Transaction</h2><p>Start a record in the Transaction Register.</p></div><button class="dialog-close" type="button" data-close-transaction aria-label="Close dialog">&times;</button></div>
                <label>Workbook group<select name="worksheet" required><option value="">Select workbook</option><?php foreach (workbook_groups() as $group): ?><option value="<?= h($group) ?>"><?= h($group) ?></option><?php endforeach; ?></select><small>Groups are kept separate to preserve workbook classification.</small></label>
                <?php render_fields('purchase_requests', ['workflow_status' => 'In Progress'], false); ?>
                <div class="form-actions"><button type="button" class="button secondary" data-close-transaction>Cancel</button><button class="button primary">Create transaction</button></div>
            </form>
        </dialog>
        <?php
        return;
    }
    ?>
    <section class="panel narrow"><div class="panel-heading"><div><h2>New transaction</h2><p>Start a record in the Transaction Register.</p></div></div><form method="post" class="form-stack">
        <?= csrf_field() ?><input type="hidden" name="action" value="create_transaction">
        <label>Workbook group<select name="worksheet" required><option value="">Select workbook</option><?php foreach (workbook_groups() as $group): ?><option value="<?= h($group) ?>"><?= h($group) ?></option><?php endforeach; ?></select><small>Groups are kept separate to preserve workbook classification.</small></label>
        <?php render_fields('purchase_requests', ['workflow_status' => 'In Progress'], false); ?>
        <div class="form-actions"><a class="button secondary" href="index.php?page=transactions">Cancel</a><button class="button primary">Create transaction</button></div>
    </form></section>
    <?php
}
