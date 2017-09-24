select to_char(first_time,'MM/DD') day, 
to_char(sum(decode(substr(to_char(first_time,'DD-MON-YYHH24'),10,2),'00',1,0)),'99') "00", 
to_char(sum(decode(substr(to_char(first_time,'DD-MON-YYHH24'),10,2),'01',1,0)),'99') "1", 
to_char(sum(decode(substr(to_char(first_time,'DD-MON-YYHH24'),10,2),'02',1,0)),'99') "02", 
to_char(sum(decode(substr(to_char(first_time,'DD-MON-YYHH24'),10,2),'03',1,0)),'99') "03", 
to_char(sum(decode(substr(to_char(first_time,'DD-MON-YYHH24'),10,2),'04',1,0)),'99') "04", 
to_char(sum(decode(substr(to_char(first_time,'DD-MON-YYHH24'),10,2),'05',1,0)),'99') "05", 
to_char(sum(decode(substr(to_char(first_time,'DD-MON-YYHH24'),10,2),'06',1,0)),'99') "06", 
to_char(sum(decode(substr(to_char(first_time,'DD-MON-YYHH24'),10,2),'07',1,0)),'99') "07", 
to_char(sum(decode(substr(to_char(first_time,'DD-MON-YYHH24'),10,2),'08',1,0)),'99') "08", 
to_char(sum(decode(substr(to_char(first_time,'DD-MON-YYHH24'),10,2),'09',1,0)),'99') "09", 
to_char(sum(decode(substr(to_char(first_time,'DD-MON-YYHH24'),10,2),'10',1,0)),'99') "10", 
to_char(sum(decode(substr(to_char(first_time,'DD-MON-YYHH24'),10,2),'11',1,0)),'99') "11", 
to_char(sum(decode(substr(to_char(first_time,'DD-MON-YYHH24'),10,2),'12',1,0)),'99') "12", 
to_char(sum(decode(substr(to_char(first_time,'DD-MON-YYHH24'),10,2),'13',1,0)),'99') "13", 
to_char(sum(decode(substr(to_char(first_time,'DD-MON-YYHH24'),10,2),'14',1,0)),'99') "14", 
to_char(sum(decode(substr(to_char(first_time,'DD-MON-YYHH24'),10,2),'15',1,0)),'99') "15", 
to_char(sum(decode(substr(to_char(first_time,'DD-MON-YYHH24'),10,2),'16',1,0)),'99') "16", 
to_char(sum(decode(substr(to_char(first_time,'DD-MON-YYHH24'),10,2),'17',1,0)),'99') "17", 
To_char(sum(decode(substr(to_char(first_time,'DD-MON-YYHH24'),10,2),'18',1,0)),'99') "18", 
COUNT(1) "Total Switch" from V$log_history 
where first_time between trunc(sysdate,'mon') and last_day(sysdate) 
group by to_char(first_time,'MM/DD') 
/ 