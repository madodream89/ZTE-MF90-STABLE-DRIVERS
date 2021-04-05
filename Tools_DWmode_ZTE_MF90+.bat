@echo off
if not exist %~dp0Temp\qcommand.exe (echo START D-ZTE.exe and restart this script! && pause && exit /B)
echo ::::::::::::::: WARNING ::::::::::::::::
echo :::                                  :::
echo :::      THIS SCRIPT ONLY FOR:       :::
echo :::        ZTE_MF90+(833FT)          :::
echo :::                                  :::
echo ::::::::::::::: WARNING ::::::::::::::::
echo -
echo PRESS ANY KEY
pause
echo PRESS ANY KEY
pause
(echo Wait comport) & (for /f "tokens=*" %%i in ('%~dp0Temp\dport.exe -wp 10 -num ^| find /V ""') do set dgpnum=%%i)
(if ["%dgpnum%"] == ["0"] (cls & echo Error: Device not found & pause & exit /B)) & (cls & echo Detected on Com%dgpnum%)
%~dp0Temp\qcommand.exe -p%dgpnum% -e -c "c 3a"
(echo Wait comport) & (for /f "tokens=*" %%i in ('%~dp0Temp\dport.exe -ws 10 -wp 120 -we 10 -num ^| find /V ""') do set dlpnum=%%i)
(if ["%dlpnum%"] == ["0"] (cls & echo Error: Device not found & pause & exit /B)) & (cls & echo Detected on Com%dlpnum%)
%~dp0Temp\qdload.exe -p%dlpnum% -i %~dp0Temp\NPRG9x15p.bin
pause
%~dp0Temp\qrflash.exe -p%dlpnum% -s@ -m
pause
%~dp0Temp\qwdirect.exe -p%dlpnum% -b40 -c7b
pause
%~dp0Temp\qcommand.exe -p%dlpnum% -c "c 0b"
pause