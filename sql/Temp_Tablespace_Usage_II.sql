SELECT sid, serial#, contents, sql_address , extents,last_call_et FROM v$session, v$sort_usage
WHERE v$session.saddr = v$sort_usage.session_addr ;


select tablespace_name, sum(bytes)/1024/1024 from dba_temp_files group by tablespace_name;


SELECT v.file#, t.file_name, v.status FROM dba_temp_files t, v$tempfile v WHERE t.file_id = v.file#;