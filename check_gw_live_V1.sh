#!/usr/sbin/bash
# Sumit Das 2017 09 08
# To be used by MAI to check GW connection via netstat ...
# ... for a server taking into account all GW process running on the host

# Set Debugging
# set -x

# Record Hostname (Do not use command `hostname` in DCP - DANGEROUS !!!)
MYhost=`uname -n`

# Go to the Gateway Logs directory. Same for all hosts in a cluster
# In DCP, maintain this script on four clusters - legdgi01 legdgn01 legpgi01 legpgn01
# legden01 cluster hosts only LE legacy system VA1

cd /usr/sap/GWLOGS

# FIND number of gateway process
# Record System Number and SID from gateway process "gwrd"

# DEFINITION of VARIABLES
# GW_PROFILE_LIST is
# GW_PROFILE_ID is
# INSTANCE is
# SID is
# SYS_NR is
# GW_Count is

# FILES USED
# /usr/sap/GWLOGS/tmp_SYS_NR_$MYhost for
# /usr/sap/GWLOGS/tmp_SID_$MYhost for
# /usr/sap/GWLOGS/GW.log for

GW_PROFILE_LIST=`ps -ef | grep gwrd | grep -v grep | awk '{print $(NF)}'`

for GW_PROFILE_ID in $GW_PROFILE_LIST ;
do
	INSTANCE=`echo $GW_PROFILE_ID | cut -d _ -f 2`
	SID=`echo $GW_PROFILE_ID | cut -d _ -f 1  | cut -d / -f 7`
	SYS_NR=`echo $INSTANCE | rev | cut -c 1-2 | rev`
	GW_Count=`netstat -an | grep 33$SYS_NR | wc -l`
	datestamp=$(date "+%Y.%m.%d-%H.%M.%S")
		if [ $GW_Count -gt 4 ]
			then
			echo $datestamp $MYhost $SID $INSTANCE Value=$GW_Count >> /usr/sap/GWLOGS/GW.log
			cat /usr/sap/GWLOGS/GW.log | tail | mailx -r "Sumit Das" -s "Gateway MAI Alert" sumit.das@linde.com imran.patan@linde.com anamika.dutta@linde.com
		else
			echo $datestamp $MYhost $SID $INSTANCE Value=$GW_Count >> /usr/sap/GWLOGS/ALLGW.log
		fi
done

# CLEANUP 

LIVE_LOG="/usr/sap/GWLOGS/GW.log"
ALL_LOG="/usr/sap/GWLOGS/ALLGW.log"
LIVE_FILE_SIZE_LIMIT="`echo '1024 * 1024 * 10'|bc`"    		# 10 megabyte in bytes
ALLLOG_FILE_SIZE_LIMIT="`echo '1024 * 1024 * 100'|bc`"    	# 100 megabyte in bytes

# For Live Log
# If the file exists, find out how big it is in bytes
if [ -f "${LIVE_LOG}" ] ; then 
	filesize=`ls -lad "${LIVE_LOG}" | awk '{print $5}'`
	# Compare the size of the file with the maximum and rename the file if it is too big
	if [ ${filesize} -gt ${LIVE_FILE_SIZE_LIMIT} ] ; then
    	echo "Renaming ${LIVE_LOG} ${LIVE_LOG}.old"
    	mv "${LIVE_LOG}" "${LIVE_LOG}.old"
	fi
else
    echo "File missing: ${LIVE_LOG}"
fi




# For All Log File
# If the file exists, find out how big it is in bytes
if [ -f "${ALL_LOG}" ] ; then 
	filesize=`ls -lad "${ALL_LOG}" | awk '{print $5}'`
	# Compare the size of the file with the maximum and rename the file if it is too big
	if [ ${filesize} -gt ${LIVE_FILE_SIZE_LIMIT} ] ; then
    	echo "Renaming ${ALL_LOG} ${ALL_LOG}.old"
    	mv "${ALL_LOG}" "${ALL_LOG}.old"
	fi
else
    echo "File missing: ${ALL_LOG}"
fi


