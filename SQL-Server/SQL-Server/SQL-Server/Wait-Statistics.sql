/*
Purpose: Analyze SQL Server wait statistics
*/

SELECT TOP 20
    wait_type,
    waiting_tasks_count,
    wait_time_ms / 1000.0 AS WaitTimeSeconds,
    signal_wait_time_ms / 1000.0 AS SignalWaitSeconds,
    (wait_time_ms - signal_wait_time_ms) / 1000.0
        AS ResourceWaitSeconds
FROM sys.dm_os_wait_stats
WHERE wait_type NOT IN
(
    'SLEEP_TASK',
    'SLEEP_SYSTEMTASK',
    'BROKER_TASK_STOP',
    'BROKER_TO_FLUSH',
    'SQLTRACE_INCREMENTAL_FLUSH_SLEEP',
    'XE_TIMER_EVENT',
    'XE_DISPATCHER_WAIT',
    'LAZYWRITER_SLEEP',
    'LOGMGR_QUEUE',
    'REQUEST_FOR_DEADLOCK_SEARCH'
)
ORDER BY wait_time_ms DESC;
