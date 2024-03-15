@REM @echo off
@REM start chrome --kiosk-printing --use-system-default-print "https://pages.fm"

@echo off
@REM Close all existing instances of Chrome
taskkill /IM chrome.exe /F

@REM Wait for Chrome processes to close
timeout /t 5

@REM Start Chrome with specified options --disable-print-preview --show-fpt-counter
start chrome --restore-last-session --kiosk-printing --disable-popup-blocking --use-system-default-print

@echo off

REM Get list of existing Chrome processes
for /f "tokens=2" %%a in ('tasklist /nh /fi "imagename eq chrome.exe"') do (
    REM Store process ID
    set PID=%%a
    REM Send message to Chrome to save tabs
    WMIC PROCESS WHERE "ProcessId=%PID%" CALL WMISaveAllDocument.mof
)

REM Start Chrome with specified options
start chrome --new-window --kiosk-printing --disable-popup-blocking --use-system-default-print
