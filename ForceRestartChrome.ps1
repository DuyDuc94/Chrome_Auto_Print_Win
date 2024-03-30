# Get-Process "chrome" | ForEach-Object { $_.CloseMainWindow() | Out-Null }
Get-Process "chrome" | Stop-Process
$chromeArgs = "--restore-last-session", "--kiosk-printing", "--disable-popup-blocking", "--use-system-default-print"
Start-Process "chrome" -ArgumentList $chromeArgs