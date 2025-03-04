@echo off
:loop
rem Terminate all instances of Chrome (same as user clicking Close)
taskkill /IM chrome.exe /F > nul 2>&1

rem Wait a moment for the processes to close
timeout /T 1 > nul

rem Check if Chrome is still running and repeat if it is
tasklist /FI "IMAGENAME eq chrome.exe" | findstr /I "chrome.exe" > nul
if not errorlevel 1 goto loop

rem Restart Chrome with the specified arguments
start chrome.exe --restore-last-session --kiosk-printing --disable-popup-blocking --use-system-default-print