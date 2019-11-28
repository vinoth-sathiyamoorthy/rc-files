# .bashrc

#pyenv settings
export HOME="${HOME%/*}/$(whoami)"
export VIMHOME=~/.vim
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
eval "$(pyenv virtualenv-init -)"
#grep exclude file named tag to avoid grepping ctags file
alias grep='grep --color=auto --exclude=tags'
alias ls='ls --color'


#PROMPT PS1
source ~/.bash-powerline.sh
#source ~/.bash_profile

#ALIASES
#git
alias g='git'
alias st='git status'
alias com='git commit -m'
alias clone='git clone'
alias sth='git stash'
alias lg='git log'
alias u='git add -u'
alias all='git add .'
#cdpaths
alias p='cd ~/myProgs/python'
alias y='cd /home/vsathiyamoorthy/yocto'
alias m='cd /home/vsathiyamoorthy/yocto/sources/meta-aos'
alias cs='cd /home/vsathiyamoorthy/yocto/build_ctr8740/workspace/sources'
alias ds='cd /home/vsathiyamoorthy/yocto/build_docker/workspace/sources'
#docker
alias dk='docker'
alias dkl='docker logs'
alias dki='docker image'
alias dks='docker service'
alias dkrn='docker run'
alias dkrm='docker rm'
alias dkpl='docker pull'
alias dkps='docker ps'
alias dkph='docker push'
alias dkk='docker kill'
alias dkn='docker network'
alias dke='docker exec'
alias dkip="docker ps -q | xargs \
            docker inspect --format \
            '{{range .NetworkSettings.Networks}}{{print .IPAddress}}{{end}} \
            {{.Config.Image}}'"

#to change prompt, change /.config/powerline-shell/config.json
#PS1=$(powerline-shell $?)
