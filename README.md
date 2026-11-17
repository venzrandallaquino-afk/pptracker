Procurement-to-Payment Tracking System
A PHP/MySQL application for linking procurement transactions through the eight workflow stages while keeping each stage's records and permissions separate. The supplied tracker workbook has grouped headers and repeated stage-specific columns; its import mapping is based on the verified worksheet layout and still presents a preview before any records are saved.

Local setup with XAMPP
Place this project at C:\xampp\htdocs\pptracker.
Start Apache and MySQL in the XAMPP Control Panel.
In phpMyAdmin, create a database named pptracker using utf8mb4 collation. The application creates its tables on first open.
If XLSX import is required, enable extension=zip in C:\xampp\php\php.ini and restart Apache. The application requires PHP 8.1+ and PDO MySQL.
Review config.php. Environment variables can override the database connection:
PPTRACKER_DB_HOST
PPTRACKER_DB_PORT
PPTRACKER_DB_NAME
PPTRACKER_DB_USER
PPTRACKER_DB_PASSWORD
PPTRACKER_TIMEZONE
Open http://localhost/pptracker/ and create the first administrator. No application account or default password is built in.
Administrators can create accounts and assign one or more stage permissions in User Management.
Open Excel Import, upload Procurement-to-Payment-Tracker-PPT.xlsx, leave the new workbook group name blank to preserve the 2026 and SPLIT 2026 groups, review the preview warnings and possible exact duplicates, then choose Import ready records.
To add another workbook, use Excel Import and enter a new workbook group name before uploading its .xlsx file. It must use the same 2026 and SPLIT 2026 worksheet names and tracker layout. Review the preview before importing; both source worksheets will be grouped under the new name.
The XAMPP root-user/blank-password values in config.php are development defaults only. Configure a dedicated MySQL account with a strong password before deployment beyond a local development machine.

Smoke test
With the pptracker database configured and PHP Zip enabled, run C:\xampp\php\php.exe -d extension=zip tests\smoke.php. The test uses a database transaction and removes its temporary workbook fixture.

Application modules
index.php handles sessions, authorization, actions, and page routing. Feature rendering is separated into app\dashboard.php and app\modules\ (register, workflow, transaction form/detail, reports, user management, activity, and import). Shared workflow definitions and rendering helpers remain in app\bootstrap.php and index.php.

Use the menu button in the page header to minimize the sidebar to icons or expand it. Navigation remains available while minimized, stays fixed in place while scrolling, and the minimized preference is saved in the current browser.

Roles and stage permissions
The application includes Administrator, Encoder / Records Staff, BAC Personnel, Procurement Personnel, Budget Personnel, Inspection Personnel, Accounting Personnel, Cashier, and Viewer / Management role labels. Administrators explicitly assign workflow-stage permissions to accounts. Stage permissions are checked again by PHP on every modifying request; hiding a menu item is not treated as authorization.

Viewer / Management accounts may have no workflow-stage permissions, which keeps them read-only while allowing access to dashboards, reports, and transaction details.

Users see the shared transaction register and its non-editable progress timeline, but can open and update only the stage(s) assigned to their account. Stage status is a deliberate user choice. Entering a document number or date does not automatically complete a stage or transaction. A transaction is complete only after every workflow stage is explicitly marked complete.

Data model
schema.sql creates related MySQL tables for users and stage grants, transactions, workbook groups, purchase requests, BAC, purchase orders, ORS, IAR, DV, payment entries, JEV, attachments, and activity logs. The transaction ID links its stage records. Payment records support multiple entries per transaction. Each transaction retains its workbook group classification.

Excel import and exports
The Administrator's Excel Import page accepts .xlsx files with worksheets named exactly 2026 and SPLIT 2026. Leave New workbook group name blank to preserve the standard worksheet groups, or enter a name of up to 30 letters, numbers, spaces, dots, underscores, or hyphens to import both source worksheets as a separate group. New groups are available for manually entered transactions, filters, reports, and Excel exports. Imports offer a preview, flag possible duplicate PR numbers, validate identifying fields, and skip duplicate rows when confirmed. The uploaded workbook is processed as a read-only source and is not stored by the application.

Since the original workbook was unavailable, import aliases have not been verified against actual header names, date formats, duplicate rules, merged cells, or multiple amount columns. Inspect and test the mapping in app/import.php against a copy of the workbook before importing organizational data. Blank worksheet cells are not interpreted as failures or overdue items.

The register supports .xlsx export with separate 2026 and SPLIT 2026 worksheets, plus a CSV option. Reports can be printed from the browser and saved as PDF using the browser's print dialog.

Attachments and privacy
PDF, JPG, and PNG attachments are limited to 10 MB and stored under storage/uploads, which is denied direct web access by .htaccess. Administrators and users with permission for the attachment's stage can download it. Keep backups of both the MySQL database and this uploads directory.

Important deployment notes
Use HTTPS for network deployment and configure a least-privilege MySQL account.
This build does not yet include in-app database restore, transaction archiving, or a configurable Settings workspace. Use phpMyAdmin or an approved database tool to back up/restore MySQL, and back up storage/uploads with the database.
Configure web-server upload limits to match the application's 10 MB attachment and 20 MB workbook limits.
No real procurement transactions, users, or financial amounts are seeded by the application.
Reports currently include filtered transaction exports, worksheet totals, monthly PR totals, and supplier totals. The broader list of individual stage-specific reports and pagination is not yet implemented; register lists are capped at 100 rows.
Dashboard follow-up alerts currently flag in-progress transactions with no update in 14 days. They are informational and do not infer overdue status from blank spreadsheet cells.
