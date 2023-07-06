# ITNOA

function script:Find-TerminalSettingsPath() {
    Set-Variable -Name WINDOWS_TERMINAL_PATH -Value $env:localappdata'\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json' -Option Constant

    # Make backup
    Copy-Item -Path $WINDOWS_TERMINAL_PATH -Destination $env:temp

    $sonokaiSchema = [PSCustomObject]@{
           name = "Sonokai Shusia"
           background = "#2D2A2E"
           black = "#1A181A"
           blue = "#1080D0"
           brightBlack = "#707070"
           brightBlue = "#22D5FF"
           brightCyan = "#7ACCD7"
           brightGreen = "#A4CD7C"
           brightPurple = "#AB9DF2"
           brightRed = "#F882A5"
           brightWhite = "#E3E1E4"
           brightYellow = "#E5D37E"
           cursorColor = "#FFFFFF"
           cyan = "#3AA5D0"
           foreground = "#E3E1E4"
           green = "#7FCD2B"
           purple = "#7C63F2"
           red = "#F82F66"
           selectionBackground = "#FFFFFF"
           white = "#E3E1E4"
           yellow = "#E5DE2D"
    }
    $settings = Get-Content $WINDOWS_TERMINAL_PATH -Raw | ConvertFrom-Json
    $settings.schemes.Add($sonokaiSchema)

}

function script:Add-ColorScheme() {

}