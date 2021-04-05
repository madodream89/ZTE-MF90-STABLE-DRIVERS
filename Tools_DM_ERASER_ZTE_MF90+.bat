@echo off
REM PORT NAME
set entertext=ZTE Mobile Broadband Diagnostics Port.
set manual=0
echo ::::::::::::::: WARNING ::::::::::::::::
echo :::                                  :::
echo :::      THIS SCRIPT ONLY FOR:       :::
echo :::        ZTE_MF90+(833FT)          :::
echo :::                                  :::
echo ::::::::::::::: WARNING ::::::::::::::::
echo -
echo PRESS ANY KEY
pause & cls
::::::::::::::::::::::::::::::::::::PRG::::::::::::::::::::::::::::::::::::

echo Step 1: Set DW mode
call :GETPORTSTART 1 60 5
%~dp0Temp\qcommand.exe -p%dgpnum% -e -c "c 3a"

echo Step 2: Set upload loader
call :GETPORTSTART 20 60 10
%~dp0Temp\qdload.exe -p%dgpnum% -i %~dp0Temp\NPRG9x15p.bin
pause

echo Step 3: View EFS2
%~dp0Temp\qrflash.exe -p%dgpnum% -s@ -m
pause

echo Step 4: Erase NV
%~dp0Temp\qwdirect.exe -p%dgpnum% -b40 -c7b
pause

echo Step 5: Exit DW mode
%~dp0Temp\qcommand.exe -p%dgpnum% -c "c 0b"

echo DONE!
:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
pause
exit /b
:GETPORTSTART
IF %manual% == 1 (IF %1 GTR 0 (PING localhost -n %1 >NUL))
:GETPORT
IF %manual% == 1 (set /P dgpnum="ENTER %entertext% => COM") else (
	echo Wait comport 
	(for /f "tokens=*" %%i in ('%~dp0Temp\dport.exe -ws %1 -wp %2 -we %3 -num ^| find /V ""') do (set dgpnum=%%i) )
)
set /a test=dgpnum
IF "%dgpnum%" NEQ "%test%"  ( goto :GETPORT)
IF %test% EQU 0 (
	if %manual% NEQ 1 (cls & echo Error AutoDetect COM-Port. Device not found!)
	set /a manual=1 
	goto :GETPORT
) else (
	if %manual% == 0 (cls & echo Detected on Com%test%)
)
exit /b
