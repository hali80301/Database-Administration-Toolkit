/*
Purpose: Identify active blocking sessions
*/

SELECT
    r.session_id AS BlockedSessionID,
    r.blocking_session_id AS BlockingSessionID,
    r.status,
    r.wait_type,
    r.wait_time / 1000.0 AS WaitTimeSeconds,
    r.wait_resource,
    DB_NAME(r.database_id) AS DatabaseName,
    s.login_name,
    s.host_name,
    s.program_name,
    t.text AS SQLStatement
FROM sys.dm_exec_requests r
INNER JOIN sys.dm_exec_sessions s
    ON r.session_id = s.session_id
OUTER APPLY sys.dm_exec_sql_text(r.sql_handle) t
WHERE r.blocking_session_id <> 0
ORDER BY r.wait_time DESC;
