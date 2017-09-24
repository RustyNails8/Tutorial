@echo off
REM Sumit Das 2016 12 26
REM SD new script 2017 09 21
REM Collect data for VLAN mapping

@echo off
REM This script taken from the following URL:
REM http://www.winnetmag.com/windowsscripting/article/articleid/9177/windowsscripting_9177.html

REM Create the date and time elements.
for /f "tokens=1-7 delims=:/-, " %%i in ('echo exit^|cmd /q /k"prompt $d $t"') do (
   for /f "tokens=2-4 delims=/-,() skip=1" %%a in ('echo.^|date') do (
      set dow=%%i
      set %%a=%%j
      set %%b=%%k
      set %%c=%%l
      set hh=%%m
      set min=%%n
      set ss=%%o
   )
)

REM Lets see the result.
echo %dow% %yy%-%mm%-%dd% @ %hh%:%min%:%ss%

cd "C:\Users\in10c2\Box Sync\BOC\SIsupport\UNIXscripts\moniscripts"
set LOGFILE=ALL_PHY_HOSTIP_%yy%-%mm%-%dd%-%hh%-%min%-%ss%.TXT
echo %LOGFILE%
set DATESTAMP_PARSE=%yy%.%mm%.%dd%-%hh%.%min%.%ss%
echo %DATESTAMP_PARSE%

set PURPOSE=GateWayCount
set ourCOMMAND="sh ~/moni/checkGWcountAUTO.sh"
set HOSTs_LIST_FILE=ALL_PROD_PHY_HOSTIP.TXT

@echo off
for /f "tokens=1-18* delims=," %%A in (%HOSTs_LIST_FILE%) do (
  IF [%%~B] == [] (
    echo IP of HOST %%~A not found
    ) ELSE (
      echo Collecting data now for SERVER %%~A with IP=%%~B
      echo y | plink %%~B -l in10c2 %ourCOMMAND% >> LOGS\%PURPOSE%.%DATESTAMP_PARSE%.CSV
  )
)
copy LOGS\%PURPOSE%_%DATESTAMP_PARSE%.CSV %PURPOSE%.CSV
