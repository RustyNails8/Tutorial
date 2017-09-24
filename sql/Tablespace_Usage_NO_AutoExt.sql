SELECT DISTINCT 'zz', df.tablespace_name, SUM (df.BYTES) "Total Bytes", MAX( fs.total_bytes) "Bytes Free", 
(MAX(fs.total_bytes)/SUM (df.BYTES))*100 "% Free" 
FROM SYS.dba_data_files df, SYS.dba_free_space_coalesced fs 
WHERE ((df.tablespace_name = fs.tablespace_name)) 
GROUP BY df.tablespace_name 
ORDER BY df.tablespace_name


---------------------------------------------------



set linesize 100
set pagesize 100

select
                a.tablespace_name,
                round(SUM(a.bytes)/(1024*1024*1024)) CURRENT_GB,
                round(SUM(decode(b.maxextend, null, A.BYTES/(1024*1024*1024), 
                b.maxextend*8192/(1024*1024*1024)))) MAX_GB,
                (SUM(a.bytes)/(1024*1024*1024) - round(c.Free/1024/1024/1024)) USED_GB,
                round((SUM(decode(b.maxextend, null, A.BYTES/(1024*1024*1024), 
                b.maxextend*8192/(1024*1024*1024))) - (SUM(a.bytes)/(1024*1024*1024) - 
                round(c.Free/1024/1024/1024))),2) FREE_GB,
                round(100*(SUM(a.bytes)/(1024*1024*1024) - 
                round(c.Free/1024/1024/1024))/(SUM(decode(b.maxextend, null, A.BYTES/(1024*1024*1024), 
                b.maxextend*8192/(1024*1024*1024))))) USED_PCT
from
                dba_data_files a,
                sys.filext$ b,
                (SELECT
                               d.tablespace_name ,sum(nvl(c.bytes,0)) Free
                FROM
                               dba_tablespaces d,
                               DBA_FREE_SPACE c
                WHERE
                               d.tablespace_name = c.tablespace_name(+)
                               group by d.tablespace_name) c
WHERE
                a.file_id = b.file#(+)
                and a.tablespace_name = c.tablespace_name
GROUP BY a.tablespace_name, c.Free/1024
ORDER BY tablespace_name;