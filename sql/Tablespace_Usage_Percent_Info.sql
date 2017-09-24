select a.tablespace_name tablespace_name,
          round(a.total_bytes/1024)     total_KB,
          round(b.free_bytes/1024)      free_KB,
          round((a.total_bytes-b.free_bytes)/1024) used_kb,
          (((a.total_bytes-b.free_bytes)/1024)/(a.total_bytes/1024))*100 "Percentage Used"
     from (select tablespace_name,
                  sum(bytes) total_bytes,
                  count(bytes) no_of_files,
                  sqrt(max(blocks)/sum(blocks))*
                      (100/sqrt(sqrt(count(blocks)))) lfi
             from sys.dba_data_files
            group by tablespace_name) a,
          (select tablespace_name,
                  sum(bytes) free_bytes,
                  count(bytes) fragments,
                  max(bytes)   max_frag,
                  min(bytes)   min_frag
            from sys.dba_free_space
           group by tablespace_name) b,
           (select tablespace_name,avg(extents) avg_ext,max(extents) max_ext,
	           (1/sqrt(greatest(avg(extents)/5,1))*
	           (1/sqrt(greatest(max(extents)/10,1))))*100 tfi
              from sys.dba_segments
	     group by tablespace_name) c
 where a.tablespace_name    =b.tablespace_name(+)
   and c.tablespace_name(+) =b.tablespace_name;
