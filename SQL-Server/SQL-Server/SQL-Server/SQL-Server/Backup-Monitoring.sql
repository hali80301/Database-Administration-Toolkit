/*
Purpose: Monitor database backup history
*/

SELECT
    bs.database_name AS DatabaseName,
    CASE bs.type
        WHEN 'D' THEN 'Full Backup'
        WHEN 'I' THEN 'Differential Backup'
        WHEN 'L' THEN 'Transaction Log Backup'
        ELSE bs.type
    END AS BackupType,
    bs.backup_start_date AS BackupStartTime,
    bs.backup_finish_date AS BackupFinishTime,
    CAST(bs.backup_size / 1024.0 / 1024 AS DECIMAL(18,2))
        AS BackupSizeMB,
    bs.server_name AS ServerName,
    bmf.physical_device_name AS BackupLocation
FROM msdb.dbo.backupset bs
LEFT JOIN msdb.dbo.backupmediafamily bmf
    ON bs.media_set_id = bmf.media_set_id
ORDER BY bs.backup_finish_date DESC;
