# ITNOA

Set-PSRepository -Name 'PSGallery' -InstallationPolicy Trusted

if (-not (Test-Path $PROFILE)) {
    New-Item -Path $PROFILE -Type File -Force
}

Install-PackageProvider WinGet -Force -Scope CurrentUser

#if (Get-Module -Name 'PSWinGlue' -ListAvailable) {
#    Write-Information 'PSWinGlue Module available in your system'
#}
#else {
#    Install-Module -Name PSWinGlue
#}

# Comment for bug https://github.com/microsoft/winget-cli/issues/3413
#if (Get-Module -Name 'Microsoft.WinGet.Client' -ListAvailable) {
#    Write-Information 'Microsoft.WinGet.Client Module available in your system'
#}
#else {
#    Install-Module -Name Microsoft.WinGet.Client
#}
