# ITNOA

Set-Variable -Name PROFILE_OPTIONS -Visibility Private -Option Constant -Scope Script -Value @"
# Enable PowerShellForGitHub Module

Import-Module PowerShellForGitHub
"@ 

function script:Add-ToProfile() {
    if (-not (Select-String -Path $PROFILE -Pattern "Import-Module PowerShellForGitHub" -SimpleMatch -Quiet)) {
        # TODO: #3 Move configuration to directory instead of manipulating original profile file
        Add-Content -Path $PROFILE -Value $PROFILE_OPTIONS
    }
}

function Install-GitHubModule() {
    Install-Module -Name PowerShellForGitHub -Confirm:$false -AcceptLicense

    Add-ToProfile
}

# Main
Install-GitHubModule
