<?php
declare(strict_types=1);

function render_transaction_detail_module(array $user): void
{
    $id = filter_input(INPUT_GET, 'id', FILTER_VALIDATE_INT);
    $record = $id ? transaction_row((int)$id) : null;
    if (!$record) {
        echo '<div class="empty-state">Transaction not found.</div>';
        return;
    }
    $statuses = stage_statuses((int)$id);
    $isManagementViewer = $user['role'] === 'Viewer / Management';
    $selectedStage = (string)($_GET['stage'] ?? '');
    $attachments = db()->prepare('SELECT a.*,u.name AS uploader FROM attachments a LEFT JOIN users u ON a.uploaded_by=u.id WHERE a.transaction_id=? ORDER BY a.created_at DESC');
    $attachments->execute([$id]);
    $allAttachments = array_values(array_filter($attachments->fetchAll(), static fn(array $file): bool => $user['role'] === 'Administrator' || can_access_stage($file['stage'], $user)));
    ?>
    <div id="transaction-detail-content">
    <section class="record-heading panel"><div><span class="eyebrow"><?= h($record['worksheet']) ?> WORKSHEET</span><h2><?= h($record['transaction_code']) ?></h2><p><?= h($record['pr_number'] ?: 'PR number not assigned') ?> · <?= h($record['particulars'] ?: 'No particulars entered') ?></p></div><div class="record-actions"><span class="status <?= h(status_class($record['status'])) ?>"><?= h($record['status']) ?></span><?php if ($user['role'] === 'Administrator'): ?><form method="post" data-confirm="Delete this transaction and all its stage data and attachments?"><?= csrf_field() ?><input type="hidden" name="action" value="delete_transaction"><input type="hidden" name="id" value="<?= (int)$id ?>"><button class="button danger">Delete transaction</button></form><?php endif; ?></div></section>
    <?php if ($isManagementViewer): ?>
        <section class="panel">
            <div class="panel-heading"><div><h2>Transaction Progress</h2><p>Read-only status for each workflow stage.</p></div></div>
            <?php if ($record['status'] === 'Completed'): ?><div class="viewer-completion"><span class="viewer-completion-icon" aria-hidden="true">✓</span><div><strong>Transaction completed!</strong><small>All workflow stages are complete.</small></div></div><?php endif; ?>
            <div class="timeline timeline-viewer"><?php foreach (STAGES as $stage => $info): $stageStatus = $statuses[$stage] ?? 'Not Started'; ?>
                <div class="timeline-item"><span class="timeline-dot <?= h(status_class($stageStatus)) ?>"></span><div class="timeline-copy"><strong><?= h($info['label']) ?></strong><small><?= h($stageStatus) ?></small></div><span class="status <?= h(status_class($stageStatus)) ?>"><?= h($stageStatus) ?></span></div>
            <?php endforeach; ?></div>
        </section>
    <?php else: ?>
        <section class="panel"><?php if ($user['role'] === 'Administrator'): ?><div class="panel-heading"><div><h2>Transaction timeline</h2><p>Stage completion is manually selected by its responsible role.</p></div></div><?php endif; ?><div class="timeline<?= $user['role'] === 'Administrator' ? '' : ' timeline-assigned' ?>"><?php foreach (STAGES as $stage => $info): if (!can_access_stage($stage, $user)) continue; $stageStatus = $statuses[$stage] ?? 'Not Started'; ?>
            <div class="timeline-item"><span class="timeline-dot <?= h(status_class($stageStatus)) ?>"></span><div class="timeline-copy"><strong><?= h($info['label']) ?></strong><small><?= h($stageStatus) ?> · <?= h($info['role']) ?></small></div>
                <a class="button small secondary" data-open-stage-modal href="index.php?page=transaction&id=<?= (int)$id ?>&stage=<?= h($stage) ?>&stage_modal=1">Open stage</a>
            </div><?php endforeach; ?></div></section>
    <?php endif; ?>
    <?php if ($selectedStage && isset(STAGES[$selectedStage]) && can_access_stage($selectedStage, $user)): render_stage_editor((int)$id, $selectedStage, $user); endif; ?>
    <section class="panel"><div class="panel-heading"><div><h2>Attachments</h2><p>Documents are private to the assigned stage team and administrators.</p></div></div>
        <?php if ($allAttachments): ?><div class="table-wrap"><table><thead><tr><th>Document</th><th>Stage</th><th>Uploaded by</th><th>Date</th><th></th></tr></thead><tbody><?php foreach ($allAttachments as $file): ?><tr><td><?= h($file['original_name']) ?></td><td><?= h(STAGES[$file['stage']]['label'] ?? $file['stage']) ?></td><td><?= h($file['uploader'] ?? 'Unknown') ?></td><td><?= h($file['created_at']) ?></td><td><?php if ($user['role'] === 'Administrator' || can_access_stage($file['stage'], $user)): ?><form method="post"><?= csrf_field() ?><input type="hidden" name="action" value="download_attachment"><input type="hidden" name="attachment_id" value="<?= (int)$file['id'] ?>"><button class="text-link">Download</button></form><?php else: ?><span class="muted">Restricted</span><?php endif; ?></td></tr><?php endforeach; ?></tbody></table></div><?php else: ?><div class="empty-state compact">No documents uploaded yet.</div><?php endif; ?>
    </section>
    <section class="panel"><div class="panel-heading"><div><h2>Transaction summary</h2><p>Register-level fields visible across workflow roles</p></div></div><div class="detail-grid"><div><small>PR Date</small><strong><?= h($record['pr_date'] ?: '—') ?></strong></div><div><small>Requested By</small><strong><?= h($record['requested_by'] ?: '—') ?></strong></div><div><small>PR Amount</small><strong><?= h($record['pr_amount'] === null ? '—' : money((float)$record['pr_amount'])) ?></strong></div><div><small>Supplier</small><strong><?= h($record['supplier'] ?: '—') ?></strong></div><div><small>Current Stage</small><strong><?= h(STAGES[$record['current_stage']]['label'] ?? $record['current_stage']) ?></strong></div><div><small>Last Updated</small><strong><?= h($record['updated_at']) ?></strong></div></div></section>
    </div>
    <?php
}
