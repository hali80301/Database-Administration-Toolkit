
/*
Project: Database Administration Toolkit
Script: Database Health Check
Purpose: Basic SQL Server instance and database health monitoring
Author: Haseeb Ali
*/

-- 1. SQL Server Version
SELECT
    @@SERVERNAME AS ServerName,
    @@VERSION AS SQLServerVersion;

-- 2. Database Information
SELECT
    name AS DatabaseName,
    state_desc AS DatabaseState,
    recovery_model_desc AS RecoveryModel,
    compatibility_level
FROM sys.databases
ORDER BY name;

-- 3. Database File Information
SELECT
    DB_NAME(database_id) AS DatabaseName,
    name AS LogicalFileName,
    type_desc AS FileType,
    size * 8 / 1024 AS SizeMB,
    physical_name AS PhysicalPath
FROM sys.master_files
ORDER BY database_id;

-- 4. Database Space Usage
EXEC sp_spaceused;

-- 5. Active Requests
SELECT
    session_id,
    status,
    command,
    wait_type,
    blocking_session_id,
    cpu_time,
    total_elapsed_time
FROM sys.dm_exec_requests
WHERE session_id <> @@SPID;

-- 6. Database Recovery Models
SELECT
    name AS DatabaseName,
    recovery_model_desc
FROM sys.databases;
