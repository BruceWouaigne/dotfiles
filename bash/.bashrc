prompt() {
    last_status="$?"
    color_end="\[\e[0;m\]"
    color_arrow="\[\e[1;48;5;234;38;5;24m\]"
    color_arrow_error="\[\e[1;48;5;234;38;5;196m\]"
    color_arrow_to_git="\[\e[1;48;5;237;38;5;24m\]"
    color_arrow_to_git_error="\[\e[1;48;5;237;38;5;196m\]"
    color_start="\[\e[1;48;5;24;38;5;254m\]"
    color_start_error="\[\e[1;48;5;196;38;5;254m\]"
    color_git="\[\e[1;48;5;237;38;5;253m\]"
    color_git_arrow="\[\e[1;48;5;234;38;5;237m\]"
    git_branch=`git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/'`

    if [ $last_status -eq "0" ]
    then
        smiley="${color_start}☺  \W"
    else
        smiley="${color_start_error}☹  \W"
    fi

    if [ -z "$git_branch" ]
    then
        if [ $last_status -eq "0" ]
        then
            git="${color_arrow}⮀";
        else
            git="${color_arrow_error}⮀";
        fi
    else
        if [ $last_status -eq "0" ]
        then
            git="${color_arrow_to_git}⮀ ${color_git}${git_branch}${color_git_arrow}⮀"
        else
            git="${color_arrow_to_git_error}⮀ ${color_git}${git_branch}${color_git_arrow}⮀"
        fi
    fi

    PS1="${smiley}${git}${color_end} "
}

PROMPT_COMMAND=prompt

alias tmux='tmux -2'
alias docker='sudo docker'
alias wireshark='gksu wireshark&'
