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
# /usr/sap/GWLOGS/GW_TEST.log for

GW_PROFILE_LIST=`ps -ef | grep gwrd | grep -v grep | awk '{print $(NF)}'`
set -x
for GW_PROFILE_ID in $GW_PROFILE_LIST ;
do
        INSTANCE=`echo $GW_PROFILE_ID | cut -d _ -f 2`
        SID=`echo $GW_PROFILE_ID | cut -d _ -f 1  | cut -d / -f 7`
        SYS_NR=`echo $INSTANCE | rev | cut -c 1-2 | rev`
        GW_Count=`netstat -an | grep 33$SYS_NR | wc -l`
		# MAX_GW=`sappfpar $GW_PROFILE_ID all | egrep 'gw/max_conn' | sort -u` ; echo "MAX_GW is $MAX_GW"
		# MAX_GW_EXACT=`sappfpar $GW_PROFILE_ID all | egrep 'gw/max_conn' | sort -u | awk '{print $4}'` ; echo "MAX_GW_EXACT is $MAX_GW_EXACT"
		GW_PROFILE=`echo $GW_PROFILE_ID | cut -d = -f 2`
		MAX_GW=`more $GW_PROFILE | egrep 'gw/max_conn' | egrep -v '#' | sort -u | tail -1 | awk '{print $3}'`
		GW_PERCENT=`expr $GW_Count / $MAX_GW` ; 
        datestamp=$(date "+%Y.%m.%d-%H.%M.%S")
                if [ $GW_PERCENT -gt 0.70 ]
                        then
                        echo $datestamp $MYhost $SID $INSTANCE Value=$GW_Count Percent=$GW_PERCENT						
                        echo $datestamp $MYhost $SID $INSTANCE Value=$GW_Count Percent=$GW_PERCENT  >> /usr/sap/GWLOGS/GW_TEST.log 2>&1
                        cat /usr/sap/GWLOGS/GW_TEST.log | tail | mailx -r "Sumit Das" -s "$INSTANCE : Gateway MAI Alert" sumit.das@linde.com # imran.patan@linde.com anamika.dutta@linde.com
                else
                        echo $datestamp $MYhost $SID $INSTANCE Value=$GW_Count >> /usr/sap/GWLOGS/ALLGW_TEST.log 2>&1
                fi
done

# CLEANUP

LIVE_LOG="/usr/sap/GWLOGS/GW_TEST.log"
ALL_LOG="/usr/sap/GWLOGS/ALLGW_TEST.log"
LIVE_FILE_SIZE_LIMIT="`echo '1024 * 1024 * 10'|bc`"             # 10 megabyte in bytes
ALLLOG_FILE_SIZE_LIMIT="`echo '1024 * 1024 * 100'|bc`"          # 100 megabyte in bytes

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
