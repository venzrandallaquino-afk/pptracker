CREATE TABLE IF NOT EXISTS users (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(120) NOT NULL,
    username VARCHAR(60) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    role VARCHAR(60) NOT NULL,
    active TINYINT(1) NOT NULL DEFAULT 1,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    last_login DATETIME NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS user_stage_access (
    user_id BIGINT UNSIGNED NOT NULL,
    stage VARCHAR(40) NOT NULL,
    PRIMARY KEY (user_id, stage),
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS login_attempts (
    attempt_key CHAR(64) PRIMARY KEY,
    count INT UNSIGNED NOT NULL,
    last_attempt DATETIME NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS transactions (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    transaction_code VARCHAR(40) NOT NULL UNIQUE,
    worksheet VARCHAR(30) NOT NULL,
    current_stage VARCHAR(40) NOT NULL DEFAULT 'purchase_requests',
    status VARCHAR(30) NOT NULL DEFAULT 'In Progress',
    created_by BIGINT UNSIGNED NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_transaction_creator FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_transaction_worksheet (worksheet),
    INDEX idx_transaction_stage (current_stage),
    INDEX idx_transaction_updated (updated_at)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS workbook_groups (
    name VARCHAR(30) NOT NULL PRIMARY KEY,
    is_default TINYINT(1) NOT NULL DEFAULT 0,
    created_by BIGINT UNSIGNED NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT IGNORE INTO workbook_groups (name, is_default) VALUES ('2026', 1), ('SPLIT 2026', 1);
INSERT IGNORE INTO workbook_groups (name) SELECT DISTINCT worksheet FROM transactions;

CREATE TABLE IF NOT EXISTS purchase_requests (
    transaction_id BIGINT UNSIGNED PRIMARY KEY,
    sequence_number VARCHAR(50) NULL,
    pr_date DATE NULL,
    pr_number VARCHAR(100) NULL,
    received_at DATETIME NULL,
    particulars TEXT NULL,
    quantity DECIMAL(16,3) NULL,
    unit VARCHAR(80) NULL,
    amount DECIMAL(16,2) NULL,
    requested_by VARCHAR(150) NULL,
    workflow_status VARCHAR(30) NOT NULL DEFAULT 'In Progress',
    updated_by BIGINT UNSIGNED NULL,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (transaction_id) REFERENCES transactions(id) ON DELETE CASCADE,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS bac_records (
    transaction_id BIGINT UNSIGNED PRIMARY KEY,
    deliberation_date DATE NULL,
    status VARCHAR(100) NULL,
    resolution_number VARCHAR(100) NULL,
    released_at DATETIME NULL,
    workflow_status VARCHAR(30) NOT NULL DEFAULT 'Not Started',
    remarks TEXT NULL,
    updated_by BIGINT UNSIGNED NULL,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (transaction_id) REFERENCES transactions(id) ON DELETE CASCADE,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS purchase_orders (
    transaction_id BIGINT UNSIGNED PRIMARY KEY,
    po_number VARCHAR(100) NULL,
    po_date DATE NULL,
    supplier VARCHAR(200) NULL,
    accountant_received_date DATE NULL,
    coa_received_date DATE NULL,
    procurement_mode VARCHAR(150) NULL,
    description TEXT NULL,
    quantity DECIMAL(16,3) NULL,
    unit VARCHAR(80) NULL,
    amount DECIMAL(16,2) NULL,
    released_time TIME NULL,
    released_date DATE NULL,
    workflow_status VARCHAR(30) NOT NULL DEFAULT 'Not Started',
    remarks TEXT NULL,
    updated_by BIGINT UNSIGNED NULL,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (transaction_id) REFERENCES transactions(id) ON DELETE CASCADE,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_po_supplier (supplier)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS ors_records (
    transaction_id BIGINT UNSIGNED PRIMARY KEY,
    ors_date DATE NULL,
    received_time TIME NULL,
    ors_number VARCHAR(100) NULL,
    uacs_code VARCHAR(150) NULL,
    mfo_pap VARCHAR(200) NULL,
    amount DECIMAL(16,2) NULL,
    released_date DATE NULL,
    released_time TIME NULL,
    workflow_status VARCHAR(30) NOT NULL DEFAULT 'Not Started',
    remarks TEXT NULL,
    updated_by BIGINT UNSIGNED NULL,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (transaction_id) REFERENCES transactions(id) ON DELETE CASCADE,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS iar_records (
    transaction_id BIGINT UNSIGNED PRIMARY KEY,
    iar_number VARCHAR(100) NULL,
    inspection_date DATE NULL,
    inspection_result TEXT NULL,
    acceptance_date DATE NULL,
    inspector_signed_date DATE NULL,
    workflow_status VARCHAR(30) NOT NULL DEFAULT 'Not Started',
    remarks TEXT NULL,
    updated_by BIGINT UNSIGNED NULL,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (transaction_id) REFERENCES transactions(id) ON DELETE CASCADE,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS dv_records (
    transaction_id BIGINT UNSIGNED PRIMARY KEY,
    dv_date DATE NULL,
    dv_number VARCHAR(100) NULL,
    gross_amount DECIMAL(16,2) NULL,
    tax DECIMAL(16,2) NULL,
    net_amount DECIMAL(16,2) NULL,
    received_at DATETIME NULL,
    remarks TEXT NULL,
    forwarded_returned_date DATE NULL,
    workflow_status VARCHAR(30) NOT NULL DEFAULT 'Not Started',
    updated_by BIGINT UNSIGNED NULL,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (transaction_id) REFERENCES transactions(id) ON DELETE CASCADE,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS payment_records (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    transaction_id BIGINT UNSIGNED NOT NULL,
    payment_date DATE NULL,
    reference_number VARCHAR(120) NULL,
    amount DECIMAL(16,2) NULL,
    remarks TEXT NULL,
    workflow_status VARCHAR(30) NOT NULL DEFAULT 'In Progress',
    created_by BIGINT UNSIGNED NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (transaction_id) REFERENCES transactions(id) ON DELETE CASCADE,
    FOREIGN KEY (created_by) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_payment_transaction (transaction_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS jev_records (
    transaction_id BIGINT UNSIGNED PRIMARY KEY,
    jev_date DATE NULL,
    jev_number VARCHAR(100) NULL,
    workflow_status VARCHAR(30) NOT NULL DEFAULT 'Not Started',
    remarks TEXT NULL,
    updated_by BIGINT UNSIGNED NULL,
    updated_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (transaction_id) REFERENCES transactions(id) ON DELETE CASCADE,
    FOREIGN KEY (updated_by) REFERENCES users(id) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS attachments (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    transaction_id BIGINT UNSIGNED NOT NULL,
    stage VARCHAR(40) NOT NULL,
    original_name VARCHAR(255) NOT NULL,
    stored_name VARCHAR(80) NOT NULL UNIQUE,
    mime_type VARCHAR(120) NOT NULL,
    file_size BIGINT UNSIGNED NOT NULL,
    uploaded_by BIGINT UNSIGNED NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (transaction_id) REFERENCES transactions(id) ON DELETE CASCADE,
    FOREIGN KEY (uploaded_by) REFERENCES users(id) ON DELETE SET NULL,
    INDEX idx_attachment_transaction (transaction_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE IF NOT EXISTS activity_logs (
    id BIGINT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    user_id BIGINT UNSIGNED NULL,
    transaction_id BIGINT UNSIGNED NULL,
    action VARCHAR(80) NOT NULL,
    details TEXT NULL,
    ip_address VARCHAR(45) NULL,
    created_at DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE SET NULL,
    FOREIGN KEY (transaction_id) REFERENCES transactions(id) ON DELETE SET NULL,
    INDEX idx_activity_created (created_at),
    INDEX idx_activity_transaction (transaction_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
