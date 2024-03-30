# Get-Process "chrome" | ForEach-Object { $_.CloseMainWindow() | Out-Null } # this shutdow only current selected instances of Chrome with behavior same as user click on Close button
Get-Process "chrome" | Stop-Process # this force to shutdown all process of Chrome as behavior of crash
$chromeArgs = "--restore-last-session", "--kiosk-printing", "--disable-popup-blocking", "--use-system-default-print"
Start-Process "chrome" -ArgumentList $chromeArgs