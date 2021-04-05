@echo off
if not exist %~dp0Temp\qcommand.exe (echo START D-ZTE.exe and restart this script! && pause && exit /B)
%~dp0Temp\adb.exe shell "A=$(iptables -v -t mangle -L|grep 'TTL set to'|awk '{print $13}');if [ $A > 0 ];then echo 'TTL NOW (FIX) = '$A";else echo 'Error read TTL';fi
pause