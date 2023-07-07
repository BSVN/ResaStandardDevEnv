# ResaStandardDevEnv
Resa Standard Development Environment Bootstrapping 

## Before all
Run `Prepare-PowerShell.ps1` in `Source/Commons`

## Windows Terminal Configuration
We follow configuration for [Windows Terminal](https://github.com/microsoft/terminal) based on https://dev.to/ansonh/customize-beautify-your-windows-terminal-2022-edition-541l
* For automate applying above configuration run `Install-BeautifyTerminal.ps1` in `Source/WindowsTerminal/`

### Additinal plugin install for Windows Termianl
* Install [winfetch](https://github.com/kiedtl/winfetch)
  * For automate installing and applying configuration run `Install-WinFetch.ps1` in `Source/WindowsTerminal/`
* Install [PowerType](https://github.com/AnderssonPeter/PowerType) for enhance PowerShell auto completion
* Install [PowerShellForGitHub](https://github.com/microsoft/PowerShellForGitHub) for native PowerShell speaking to GitHub
  * For automate installing run `Install-GitHubModule.ps1` in `Source/WindowsTerminal/`
