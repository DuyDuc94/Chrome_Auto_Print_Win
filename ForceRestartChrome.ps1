#issue: https://www.reddit.com/r/PowerShell/comments/186z5us/help_stopprocess_isnt_terminating_all_chrome/
do {
    Get-Process chrome -ErrorAction SilentlyContinue | ForEach-Object { $_.CloseMainWindow() | Out-Null } # this shutdow only current selected instances of Chrome with behavior same as user click on Close button
    # Start-Sleep -Milliseconds 100  # brief pause to allow processes to close
} while (Get-Process chrome -ErrorAction SilentlyContinue)  # loop to handle if user have open many profile chrome window
# Get-Process "chrome"  | Stop-Process # this forcefully to shutdown all process of Chrome as behavior of crash, leading to data lost
$chromeArgs = "--restore-last-session", "--kiosk-printing", "--disable-popup-blocking", "--use-system-default-print"
Start-Process "chrome" -ArgumentList $chromeArgs