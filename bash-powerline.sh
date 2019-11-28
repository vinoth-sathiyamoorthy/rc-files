#!/usr/bin/env bash
## Uncomment to disable git info
#POWERLINE_GIT=0
__powerline() {
    #Colors
    COLOR_RESET='\[\033[m\]'
    COLOR_CWD=${COLOR_CWD:-'\[\033[01;15m\]'} # white
    COLOR_GIT=${COLOR_GIT:-'\[\033[0;36m\]'} # cyan
    COLOR_GREEN=${COLOR_SUCCESS:-'\[\033[0;32m\]'} # green
    COLOR_RED=${COLOR_FAILURE:-'\[\033[0;31m\]'} # red
    COLOR_LIGHT_YELLOW=${COLOR_LIGHT_YELLOW:-'\[\033[0;95m\]'} #light-yello

    # Symbols
    SYMBOL_GIT_BRANCH=${SYMBOL_GIT_BRANCH:-⑂}
    SYMBOL_GIT_MODIFIED=${SYMBOL_GIT_MODIFIED:-*}
    SYMBOL_GIT_PUSH=${SYMBOL_GIT_PUSH:-↑}
    SYMBOL_GIT_PULL=${SYMBOL_GIT_PULL:-↓}

    ps="\n$COLOR_RED$  $COLOR_RESET"

    __git_info() { 
        [[ $POWERLINE_GIT = 0 ]] && return # disabled
        hash git 2>/dev/null || return # git not found
        local git_eng="env LANG=C git"   # force git output in English to make our work easier

        # get current branch name
        local ref=$($git_eng symbolic-ref --short HEAD 2>/dev/null)

        if [[ -n "$ref" ]]; then
            # prepend branch symbol
            ref=$SYMBOL_GIT_BRANCH$ref
        else
            # get tag name or short unique hash
            ref=$($git_eng describe --tags --always 2>/dev/null)
        fi

        [[ -n "$ref" ]] || return  # not a git repo

        local marks

        # scan first two lines of output from `git status`
        while IFS= read -r line; do
            if [[ $line =~ ^## ]]; then # header line
                [[ $line =~ ahead\ ([0-9]+) ]] && marks+=" $SYMBOL_GIT_PUSH${BASH_REMATCH[1]}"
                [[ $line =~ behind\ ([0-9]+) ]] && marks+=" $SYMBOL_GIT_PULL${BASH_REMATCH[1]}"
            else # branch is modified if output contains more lines after the header line
                marks="$SYMBOL_GIT_MODIFIED$marks"
                break
            fi
        done < <($git_eng status --porcelain --branch 2>/dev/null)  # note the space between the two <

        # print the git branch segment without a trailing newline
        printf " $ref$marks"
    }

    __pyenv(){
      local venv
        if [[ `pyenv version-name` == "system" ]] ; then
	      venv=""
	else
	      venv="[`pyenv version-name`]"
        fi
	printf "$COLOR_LIGHT_YELLOW$venv $COLOR_RESET"
    }

#funtion to put together all pieces above
    ps1(){
	    local cwd="$COLOR_CWD\w$COLOR_RESET"
        # Bash by default expands the content of PS1 unless promptvars is disabled.
        # We must use another layer of reference to prevent expanding any user
        # provided strings, which would cause security issues.
        # POC: https://github.com/njhartwell/pw3nage
        # Related fix in git-bash: https://github.com/git/git/blob/9d77b0405ce6b471cb5ce3a904368fc25e55643d/contrib/completion/git-prompt.sh#L324
#        if shopt -q promptvars; then
            __powerline_git_info="$(__git_info)"
            local git="$COLOR_GIT\${__powerline_git_info}$COLOR_RESET"
#        else
            # promptvars is disabled. Avoid creating unnecessary env var.
#            local git="$COLOR_GIT$(__git_info)$COLOR_RESET"
#        fi
	local pyenv="$(__pyenv)"
        PS1="$pyenv$cwd$git $ps"
#        export PS1
    }


    PROMPT_COMMAND="ps1${PROMPT_COMMAND:+; $PROMPT_COMMAND}"
}

__powerline
unset __powerline

