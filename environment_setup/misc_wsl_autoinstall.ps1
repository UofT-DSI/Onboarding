
# install vscode wsl extension
code --install-extension ms-vscode-remote.remote-wsl

# check if wsl is available
$wsl = Get-Command wsl -ErrorAction SilentlyContinue
if (!$wsl) {
    Write-Warning "Your computer may not be compatible with the course requirements."
    exit 1
}

# check for ubuntu and install if not available
$ubuntu = wsl -l -v | Select-String -Pattern "Ubuntu-20.04"
if ($ubuntu) {
    Write-Host "Ubuntu: Installed"
} else {
    Write-Host "Ubuntu: ... installing!"
    Start-Process C:\Windows\system32\wsl.exe -Verb RunAs --install
}

