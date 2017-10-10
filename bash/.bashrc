prompt() {
    last_status="$?"
    color_end="\[\e[0;m\]"
    color_arrow="\[\e[1;48;5;235;38;5;24m\]"
    color_arrow_error="\[\e[1;48;5;235;38;5;196m\]"
    color_arrow_to_git="\[\e[1;48;5;237;38;5;24m\]"
    color_arrow_to_git_error="\[\e[1;48;5;237;38;5;196m\]"
    color_start="\[\e[1;48;5;24;38;5;254m\]"
    color_start_error="\[\e[1;48;5;196;38;5;254m\]"
    color_git="\[\e[1;48;5;237;38;5;253m\]"
    color_git_arrow="\[\e[1;48;5;235;38;5;237m\]"
    git_branch=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`

    if [ $last_status -eq "0" ]
    then
        smiley="${color_start} 👌  \W"
    else
        smiley="${color_start_error} 🖕  \W"
    fi

    if [ -z "$git_branch" ]
    then
        if [ $last_status -eq "0" ]
        then
            git="${color_arrow}";
        else
            git="${color_arrow_error}";
        fi
    else
        if [ $last_status -eq "0" ]
        then
            git="${color_arrow_to_git} ${color_git}${git_branch}${color_git_arrow}"
        else
            git="${color_arrow_to_git_error} ${color_git}${git_branch}${color_git_arrow}"
        fi
    fi

    PS1="${smiley}${git}${color_end} "
}

PROMPT_COMMAND=prompt

if [ -f ~/dotfiles/git/git-completion.bash ]; then
    . ~/dotfiles/git/git-completion.bash
fi

export PATH=${PATH}:/Users/bruce/Library/Android/sdk/plateform-tools:/Users/bruce/Library/Android/sdk/tools
export CLICOLOR=1
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
#export GREP_OPTIONS='--color=always'
#export GREP_COLOR='ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36'

alias vi='RUBYOPT="-W0" vim'
alias vim='RUBYOPT="-W0" vim'
alias eclim="$ECLIPSE_HOME/eclimd"
alias ll='ls -al'
alias tailf='tail -f'
alias grep='grep --color=always'
alias nginx.start='sudo launchctl load /Library/LaunchDaemons/homebrew.mxcl.nginx.plist'
alias nginx.stop='sudo launchctl unload /Library/LaunchDaemons/homebrew.mxcl.nginx.plist'
alias nginx.restart='nginx.stop && nginx.start'
alias php-fpm.start="launchctl load -w ~/Library/LaunchAgents/homebrew.mxcl.php55.plist"
alias php-fpm.stop="launchctl unload -w ~/Library/LaunchAgents/homebrew.mxcl.php55.plist"
alias php-fpm.restart='php-fpm.stop && php-fpm.start'
alias mongodb.start="launchctl load ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist"
alias mongodb.stop="launchctl unload ~/Library/LaunchAgents/homebrew.mxcl.mongodb.plist"
alias mongodb.restart='mongodb.stop && mongodb.start'
alias postgres.start="pg_ctl -D /usr/local/var/postgres -l /usr/local/var/postgres/server.log start"
alias postgres.stop="pg_ctl -D /usr/local/var/postgres stop -s -m fast"
alias postgres.restart='postgres.stop && postgres.start'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dcharrier/Downloads/google-cloud-sdk/path.bash.inc' ]; then source '/Users/dcharrier/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/dcharrier/Downloads/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/dcharrier/Downloads/google-cloud-sdk/completion.bash.inc'; fi
