@REM Get list of existing Chrome processes and close them gracefully
for /f "tokens=2" %%a in ('tasklist /nh /fi "imagename eq chrome.exe"') do (
    REM Store process ID
    set PID=%%a
    REM Close Chrome gracefully using PowerShell
    powershell -Command "Stop-Process -Id %PID% -Force"
)

@REM Start Chrome with specified options
start chrome --restore-last-session --kiosk-printing --disable-popup-blocking --use-system-default-print