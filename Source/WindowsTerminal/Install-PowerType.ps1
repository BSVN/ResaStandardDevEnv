# ITNOA

function script:Add-ToProfile {
    New-Variable -Name PROFILE_OPTIONS -Option Constant -Value @"
# Enable PowerType

Import-Module PowerType
Enable-PowerType
Set-PSReadLineOption -PredictionSource HistoryAndPlugin -PredictionViewStyle ListView # Optional
"@

    if (-not (Select-String -Path $PROFILE -Pattern "Enable-PowerType" -SimpleMatch -Quiet)) {
        # TODO: #3 Move configuration to directory instead of manipulating original profile file
        Add-Content -Path $PROFILE -Value $PROFILE_OPTIONS
    }
}

function global:Install-PowerType {

    Install-Module PowerType -Scope CurrentUser

    script:Add-ToProfile
}

# Main
Install-PowerType