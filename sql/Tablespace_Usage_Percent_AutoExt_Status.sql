select
decode(
max(round(100*(SUM(a.bytes)/1024/1024 - round(c."Free"/1024/1024))/(SUM(decode(b.maxextend, null, A.BYTES/1024/1024, b.maxextend*8192/1024/1024))))), 
100, 'CRIT', 
99, 'CRIT', 
98, 'CRIT', 
97, 'CRIT', 
96, 'CRIT', 
95, 'CRIT', 
94, 'WARN', 
93, 'WARN', 
92, 'WARN',
91, 'WANN',
90, 'WARN',
89, 'WARN',
88, 'WARN',
87, 'WARN',
86, 'WARN',
85, 'WARN',
  'OK') STATUS 
from
dba_data_files a,
sys.filext$ b,
(SELECT d.tablespace_name , sum(nvl(c.bytes,0)) "Free" FROM dba_tablespaces d,DBA_FREE_SPACE c where d.tablespace_name = c.tablespace_name(+) group by d.tablespace_name) c
where a.file_id = b.file#(+)
and a.tablespace_name = c.tablespace_name
GROUP by a.tablespace_name, c."Free"/1024 ;