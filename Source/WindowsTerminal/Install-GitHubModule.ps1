# ITNOA 

function script:Add-ToProfile {
    New-Variable -Name PROFILE_OPTIONS -Visibility Private -Option Constant -Scope Local -Value @"
# Enable PowerShellForGitHub Module

Import-Module PowerShellForGitHub
"@

    if (-not (Select-String -Path $PROFILE -Pattern "Import-Module PowerShellForGitHub" -SimpleMatch -Quiet)) {
        # TODO: #3 Move configuration to directory instead of manipulating original profile file
        Add-Content -Path $PROFILE -Value $PROFILE_OPTIONS
    }
}

function global:Install-GitHubModule {
    Install-Module -Name PowerShellForGitHub -Confirm:$false -AcceptLicense

    Add-ToProfile
}

# Main
Install-GitHubModule
