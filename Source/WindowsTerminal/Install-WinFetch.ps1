# ITNOA

function global:Install-WinFetch {
    Install-Script -Name winfetch -AcceptLicense

    if (-not (Test-Path -Path $env:USERPROFILE/.config/winfetch/config.ps1)) {
        winfetch -genconf
    }

    (Get-Content $env:USERPROFILE/.config/winfetch/config.ps1).Replace('# $ShowDisks = @("*")','$ShowDisks = @("*")') | Set-Content $env:USERPROFILE/.config/winfetch/config.ps1
    (Get-Content $env:USERPROFILE/.config/winfetch/config.ps1).Replace('# $memorystyle','$memorystyle') | Set-Content $env:USERPROFILE/.config/winfetch/config.ps1
    (Get-Content $env:USERPROFILE/.config/winfetch/config.ps1).Replace('# $diskstyle','$diskstyle') | Set-Content $env:USERPROFILE/.config/winfetch/config.ps1
}

# Main
Install-WinFetch