# ITNOA

function script:Add-LogFormat {
    # Thanks to https://dev.to/pradumnasaraf/beautify-your-git-log-with-a-single-command-2i5
    git config --global alias.blog "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit --branches"
}

# Main
script:Add-LogFormat