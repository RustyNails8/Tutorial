SELECT SUM (u.blocks * blk.block_size) / 1024 / 1024 "Mb. in sort segments"
, (hwm.MAX * blk.block_size) / 1024 / 1024 "Mb. High Water Mark"
FROM v$sort_usage u
, (SELECT block_size
FROM DBA_TABLESPACES
WHERE CONTENTS = 'TEMPORARY') blk
, (SELECT segblk# + blocks MAX
FROM v$sort_usage
WHERE segblk# = (SELECT MAX (segblk#)
FROM v$sort_usage)) hwm
GROUP BY hwm.MAX * blk.block_size / 1024 / 1024;