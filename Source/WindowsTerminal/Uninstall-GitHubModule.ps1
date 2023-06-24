# ITNOA

function script:Remove-FromProfile() {
    New-Variable -Name PROFILE_OPTIONS -Visibility Private -Option Constant -Scope Local -Value "#\s+Enable\s+PowerShellForGitHub\s+Module\s+\r?\nImport-Module\s+PowerShellForGitHub"

    if (Select-String -Path $PROFILE -Pattern "Import-Module PowerShellForGitHub" -SimpleMatch -Quiet) {
        # TODO: #3 Move configuration to directory instead of manipulating original profile file
        Set-Content -Path $PROFILE -Value ((Get-Content $PROFILE -Raw) -replace $PROFILE_OPTIONS)
    }
    else {
        Write-Warning "Correct profile optoins does not exist"
    }
}

function global:Uninstall-GitHubModule() {
    Uninstall-Module -Name PowerShellForGitHub -Confirm:$false

    Remove-FromProfile
}

# Main
Uninstall-GitHubModule
