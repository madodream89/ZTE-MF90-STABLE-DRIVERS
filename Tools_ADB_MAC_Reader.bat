@echo off
if not exist %~dp0Temp\qcommand.exe (echo START D-ZTE.exe and restart this script! && pause && exit /B)
%~dp0Temp\adb.exe shell "ifconfig|grep 'HWaddr '|grep -v '00-00'|awk '{print $1,$5}'"
pause