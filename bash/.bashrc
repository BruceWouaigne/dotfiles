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
        smiley="${color_start} 👌 "
    else
        smiley="${color_start_error} 🖕 "
    fi

    if [ ! -z $VIRTUAL_ENV ]
    then
        venv="[venv] "
    else
        venv=""
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

    PS1="${smiley} \W ${venv}${git}${color_end} "
}

enablejava12() {
  sudo mv /Library/Java/JavaVirtualMachines/jdk-12.0.1.jdk/Contents/Info.plist{.disabled,}
}

disablejava12() {
  sudo mv /Library/Java/JavaVirtualMachines/jdk-12.0.1.jdk/Contents/Info.plist{,.disabled}
  source ~/.bash_profile
}

userfrom() {
  jhurl -s services.guc3.spotify.net "hm://userdata/account?$1=$2" -p | jq '.'
  source ~/.bash_profile
}

loaduserfrom() {
  username=`jhurl -s services.guc3.spotify.net "hm://userdata/account?$1=$2" -p | jq -r '.[0].username'`
  userid=`jhurl -s services.guc3.spotify.net "hm://userdata/account?$1=$2" -p | jq -r '.[0].user_id'`
  jhurl -s services.guc3.spotify.net "hm://userdata/account?$1=$2" -p | jq '.'
}

setBruce() {
  username=$BRUCEUSERNAME
  userid=$BRUCEUSERID
}

setPlay() {
  username=$PLAYUSERNAME
  userid=$PLAYUSERID
}

PROMPT_COMMAND=prompt

if [ -f ~/dotfiles/git/git-completion.bash ]; then
    . ~/dotfiles/git/git-completion.bash
fi

export ANDROID_HOME=/Users/dcharrier/Library/Android/sdk
export PATH=${PATH}:$ANDROID_HOME/plateform-tools:$ANDROID_HOME/tools
export PATH=${PATH}:/usr/local/opt/postgresql@9.6/bin
export CLICOLOR=1
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
#export GREP_OPTIONS='--color=always'
#export GREP_COLOR='ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36'

export BRUCEUSERID="1090073d1dab4385bf33fb6c6985582e"
export BRUCEUSERNAME="brucewouaigne"
export PLAYUSERID="74c49e338d4f419cbec278013286e67f"
export PLAYUSERNAME="9z6kf7uy83ob54ufa63u5hshn"
export JOJOUSERID="363b6922b6dd485fb2c6b6517a435d52"
export JOJOUSERNAME="johpag"
export JJUSERID="d9d2f87087674cb38abac84b3e5bf514"
export JJUSERNAME="11131170635"

alias vi='RUBYOPT="-W0" vim'
alias vim='RUBYOPT="-W0" vim'
alias eclim="$ECLIPSE_HOME/eclimd"
alias ll='ls -al'
alias ltr='ls -ltr'
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
alias ggrep='git grep'

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dcharrier/Downloads/google-cloud-sdk/path.bash.inc' ]; then source '/Users/dcharrier/Downloads/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/dcharrier/Downloads/google-cloud-sdk/completion.bash.inc' ]; then source '/Users/dcharrier/Downloads/google-cloud-sdk/completion.bash.inc'; fi
