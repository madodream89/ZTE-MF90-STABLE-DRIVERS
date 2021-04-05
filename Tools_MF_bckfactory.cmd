@echo off
REM PORT NAME
set entertext=ZTE Mobile Broadband Diagnostics Port.
set manual=0
::::::::::::::::::::::::::::::::::::PRG::::::::::::::::::::::::::::::::::::
call :GETPORTSTART 1 60 1
%~dp0Temp\qcommand.exe -p%dgpnum% -e -c "c 4b aa 00 00 00"
%~dp0Temp\qcommand.exe -p%dgpnum% -e -c "c 29 02 00"
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
