# ITNOA

BeforeAll {
    New-Variable -Name PROFILE_OPTIONS_VALUE -Visibility Public -Option Constant -Scope Local -Value "Import-Module PowerShellForGitHub"

    function script:Test-ContentInProfileExists() {
        return Select-String -Path $PROFILE -Pattern $PROFILE_OPTIONS_VALUE -SimpleMatch -Quiet
    }

    Mock Uninstall-Module { }
    Mock Install-Module { }

    # TODO: #8 Why below code does not work
    if (-not (Test-Path -Path $PROFILE)) {
        New-Item -Path $PROFILE -ItemType File -Force
    }

    # Dot sourcing main script
    . .\Source\WindowsTerminal\Install-GitHubModule.ps1

    . .\Source\WindowsTerminal\Uninstall-GitHubModule.ps1
}

Describe 'Install-GitHubModule' {
    BeforeEach {
        Uninstall-GitHubModule
    }
    It 'Calling Install-GitHubModule shoud add correct configuration into profile' {
        Test-ContentInProfileExists | Should -BeFalse
        Install-GitHubModule
        Test-ContentInProfileExists | Should -BeTrue
    }
    It 'Multiple calling should not be multiple adding module in profile' {
        if (-not (Test-ContentInProfileExists)) {
            Install-GitHubModule
        }

        Test-ContentInProfileExists | Should -BeTrue
        Install-GitHubModule
        Test-ContentInProfileExists | Should -BeTrue
        (Get-Content -Path $PROFILE | Select-String -Pattern $PROFILE_OPTIONS_VALUE | Measure-Object -Line).Count | Should -Be 1
    }
    AfterEach {

    }
}