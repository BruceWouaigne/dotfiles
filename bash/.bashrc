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

export PATH=$HOME/.jenv/bin:$PATH
eval "$(jenv init -)"

export PHPENV_ROOT="/usr/local/bin/phpenv"
if [ -d "${PHPENV_ROOT}" ]; then
  export PATH="${PHPENV_ROOT}/bin:${PATH}"
  eval "$(phpenv init -)"
fi

loaduserfrom() {
  username=`jhurl -s services.gew1.spotify.net "hm://userdata/account?$1=$2" -p | jq -r '.[0].username'`
  userid=`jhurl -s services.gew1.spotify.net "hm://userdata/account?$1=$2" -p | jq -r '.[0].user_id'`
  country=`jhurl -s services.gew1.spotify.net "hm://userdata/account?$1=$2" -p | jq -r '.[0].country'`
  jhurl -s services.gew1.spotify.net "hm://userdata/account?$1=$2" -p | jq '.'
}

nameless() {
  echo "-- hermes --"
  dig _spotify-$1._hm.services.gew1.spotify.net srv +short
  dig _spotify-$1._hm.services.gae2.spotify.net srv +short
  dig _spotify-$1._hm.services.guc3.spotify.net srv +short
  echo "-- grpc --"
  dig _spotify-$1._grpc.services.gew1.spotify.net srv +short
  dig _spotify-$1._grpc.services.gae2.spotify.net srv +short
  dig _spotify-$1._grpc.services.guc3.spotify.net srv +short
}

hostfor() {
  host=`disco service $1 --protocol grpc | grep --color=never gew | head -n 1 | sed 's/^.*\(ip.*\):.*$/\1/'`
  echo $host
}

PROMPT_COMMAND=prompt

if [ -f ~/dotfiles/git/git-completion.bash ]; then
    source ~/dotfiles/git/git-completion.bash
fi

export ANDROID_HOME=/Users/dcharrier/Library/Android/sdk
export PATH=${PATH}:$ANDROID_HOME/plateform-tools:$ANDROID_HOME/tools
export PATH=${PATH}:/usr/local/opt/postgresql@9.6/bin
export CLICOLOR=1
export LSCOLORS="ExGxBxDxCxEgEdxbxgxcxd"
#export GREP_OPTIONS='--color=always'
#export GREP_COLOR='ms=01;31:mc=01;31:sl=:cx=:fn=35:ln=32:bn=32:se=36'

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

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

export PATH="$HOME/.symfony/bin:$PATH"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

export POWERLINE_HOME=/Users/dcharrier/Library/Python/3.7/lib/python/site-packages/powerline

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/dcharrier/google-cloud-sdk/path.bash.inc' ]; then . '/Users/dcharrier/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/dcharrier/google-cloud-sdk/completion.bash.inc' ]; then . '/Users/dcharrier/google-cloud-sdk/completion.bash.inc'; fi
export PATH="/usr/local/opt/mysql-client/bin:$PATH"

export BASH_SILENCE_DEPRECATION_WARNING=1

export SPOTIFY_DOMAIN=gew1.spotify.net

eval "$(pyenv init -)"

eval "$(thefuck --alias)"
