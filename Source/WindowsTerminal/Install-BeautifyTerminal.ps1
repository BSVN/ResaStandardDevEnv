# ITNOA

function script:Find-TerminalSettingsPath {
    Set-Variable -Name WINDOWS_TERMINAL_PATH -Value $env:localappdata'\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json' -Option Constant

    return $WINDOWS_TERMINAL_PATH

}

function script:Get-TerminalSettings {
    Set-Variable -Name WINDOWS_TERMINAL_PATH -Value (Find-TerminalSettingsPath) -Option Constant

    # Make backup
    Copy-Item -Path $WINDOWS_TERMINAL_PATH -Destination $env:temp

    # Read Windows Terminal settings
    $settings = Get-Content $WINDOWS_TERMINAL_PATH -Raw | ConvertFrom-Json

    return $settings
}

function script:Save-TerminalSettings {
    param (
        [PSCustomObject]$Settings
    )

    Set-Variable -Name WINDOWS_TERMINAL_PATH -Value (Find-TerminalSettingsPath) -Option Constant

    # Save changes (Write Windows Terminal settings)
    $Settings | ConvertTo-Json -Depth 32 | Set-Content $WINDOWS_TERMINAL_PATH
}

function script:Add-ColorScheme {
    $settings = script:Get-TerminalSettings
    $sonokaiSchema = [PSCustomObject]@{
        name                = "Sonokai Shusia"
        background          = "#2D2A2E"
        black               = "#1A181A"
        blue                = "#1080D0"
        brightBlack         = "#707070"
        brightBlue          = "#22D5FF"
        brightCyan          = "#7ACCD7"
        brightGreen         = "#A4CD7C"
        brightPurple        = "#AB9DF2"
        brightRed           = "#F882A5"
        brightWhite         = "#E3E1E4"
        brightYellow        = "#E5D37E"
        cursorColor         = "#FFFFFF"
        cyan                = "#3AA5D0"
        foreground          = "#E3E1E4"
        green               = "#7FCD2B"
        purple              = "#7C63F2"
        red                 = "#F82F66"
        selectionBackground = "#FFFFFF"
        white               = "#E3E1E4"
        yellow              = "#E5DE2D"
    }

    # Check color schema added before or not?
    if ($settings.schemes | Where-Object -Property name -eq $sonokaiSchema.name) {
        Write-Host "Color Theme Added before"
    }
    else {
        $settings.schemes += $sonokaiSchema

        # Check default profile has colorScheme or not
        if ($settings.profiles.defaults | Get-Member -Name 'colorScheme' -MemberType Properties) {
            $settings.profiles.defaults.colorScheme = $sonokaiSchema.name
        }
        else {
            $settings.profiles.defaults | Add-Member -MemberType NoteProperty -Name 'colorScheme' -Value $sonokaiSchema.name
        }

        script:Save-TerminalSettings -Settings $settings
    }
}

function script:Install-NerdFont() {
    if (-not (Test-Path -Path $env:temp'\FiraCode.zip') -and ((Get-FileHash $env:temp'\FiraCode.zip' -Algorithm MD5).Hash -eq '8127EF3F014A934CE8C7D87A24EEEA62')) {
        Invoke-WebRequest -Uri https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraCode.zip -OutFile $env:temp'\FiraCode.zip'
    }

    Remove-Item -Path $env:temp'\FiraCodeExpand' -Recurse
    Expand-Archive -Path $env:temp'\FiraCode.zip' -DestinationPath $env:temp'\FiraCodeExpand\'

    # TODO: #13 Check error handling
    Import-Module -Name PSWinGlue

    # TODO: #14 Check if fonts exist, skip this step
    # Elevate to Administrative
    if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
        # Install Fonts
        Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -Command {Install-Font -Path $env:temp'\FiraCodeExpand'}" -Verb RunAs
    }

    $settings = script:Get-TerminalSettings

    # Check default profile has font or not
    if ($settings.profiles.defaults | Get-Member -Name 'font' -MemberType Properties) {
        $settings.profiles.defaults.font.face = 'FiraCode Nerd Font'
    }
    else {
        $settings.profiles.defaults | Add-Member -MemberType NoteProperty -Name 'font' -Value ([PSCustomObject]@{
            face = 'FiraCode Nerd Font'
        }) | ConvertTo-Json
    }

    script:Save-TerminalSettings -Settings $settings
}

function script:Add-ToProfile {
    New-Variable -Name PROFILE_OPTIONS -Option Constant -Value @"
# Enable Oh My Posh Theme Engine

oh-my-posh --init --shell pwsh --config ~/AppData/Local/Programs/oh-my-posh/themes/p10k_classic.omp.json | Invoke-Expression
"@

    if (-not (Select-String -Path $PROFILE -Pattern "oh-my-posh" -SimpleMatch -Quiet)) {
        # TODO: #3 Move configuration to directory instead of manipulating original profile file
        Add-Content -Path $PROFILE -Value $PROFILE_OPTIONS
    }
}

function script:Install-OhMyPosh {
    New-Variable -Name OH_MY_POSH_PATH -Option Constant -Value '~\AppData\Local\Programs\oh-my-posh'

    if (-not (Test-Path -Path $OH_MY_POSH_PATH)) {
        # TODO: #13 Check error handling
        Import-PackageProvider -Name WinGet

        Install-Package -Name JanDeDobbeleer.OhMyPosh -ProviderName WinGet
    }

    if (-not (Test-Path -Path $OH_MY_POSH_PATH'\themes\p10k_classic.omp.json')) {
        Invoke-WebRequest -Uri https://gist.githubusercontent.com/AnsonH/55858833ddcfbb7946f42740ac720cd4/raw/7a29a405eb191f66151906b748bd286d75cebbf3/p10k_classic.omp.json -OutFile $OH_MY_POSH_PATH'\themes\p10k_classic.omp.json'
    }

    script:Add-ToProfile
}

# Main
script:Add-ColorScheme
script:Install-NerdFont
script:Install-OhMyPosh

