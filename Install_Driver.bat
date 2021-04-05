@echo off
pnputil -i -a %~dp0soft/MF90Drivers/zgdcdiag.inf
pnputil -i -a %~dp0soft/ADBdriver/android_winusb.inf
pause