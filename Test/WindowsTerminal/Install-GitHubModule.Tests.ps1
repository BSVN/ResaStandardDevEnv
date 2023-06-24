# ITNOA

# TODO: #4 Add unit test for Install-GitHubModule

BeforeAll {

}

Describe 'Install-GitHubModule' {
    It 'Multiple calling should not be multiple adding module in profile' {
        Select-String -Path .\Test\WindowsTerminal\TestContent.txt -Pattern "Import-Module" -SimpleMatch -Quiet | Should -BeTrue
    }
}