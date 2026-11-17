<?php
declare(strict_types=1);

return [
    'db_host' => getenv('PPTRACKER_DB_HOST') ?: '127.0.0.1',
    'db_port' => getenv('PPTRACKER_DB_PORT') ?: '3306',
    'db_name' => getenv('PPTRACKER_DB_NAME') ?: 'pptracker',
    'db_user' => getenv('PPTRACKER_DB_USER') ?: 'root',
    'db_password' => getenv('PPTRACKER_DB_PASSWORD') ?: '',
    'timezone' => getenv('PPTRACKER_TIMEZONE') ?: 'Asia/Manila',
    'upload_max_bytes' => 10 * 1024 * 1024,
];
