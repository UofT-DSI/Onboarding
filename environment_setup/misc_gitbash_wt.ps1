#################################################
# Add Git Bash as a profile in Windows Terminal #
#################################################

# find out where Git is installed
$git_dir = Split-Path -parent (Split-Path -parent (Get-Command git.exe).Source)

# build the JSON fragment
$terminal_settings = @{guid = "{" + [guid]::NewGuid().ToString() + "}"; name = "Git Bash"; commandline = $git_dir + "\bin\bash.exe -i -l"; icon = $git_dir + "\mingw64\share\git\git-for-windows.ico"; hidden = $false; startingDirectory = "%USERPROFILE%" }
$terminal_settings = @{ profiles = @($terminal_settings) }
$terminal_settings = $terminal_settings | ConvertTo-Json

# make directory only if it doesn't exist
if (!(Test-Path "C:\Users\$env:UserName\AppData\Local\Microsoft\Windows Terminal\Fragments\Git")) {
    mkdir "C:\Users\$env:UserName\AppData\Local\Microsoft\Windows Terminal\Fragments\Git"
}

# write the JSON fragment to file
$terminal_settings | Out-File -FilePath "C:\Users\$env:UserName\AppData\Local\Microsoft\Windows Terminal\Fragments\Git\gitbash.json" -Encoding Utf8
