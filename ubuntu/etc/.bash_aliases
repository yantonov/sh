# ls
## Colorize the ls output ##
alias ls='ls --color=auto'
## Use a long listing format ##
alias ll='ls -la'
## Show hidden files ##
alias l.='ls -d .* --color=auto'
# make parent directory if needed
alias mkdir='mkdir -pv'
## colorize the grep
alias grep='grep --color=auto '

# cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# [ development ]
alias hgrepos="cd $HG_REPOS"
alias gitrepos="cd $GIT_REPOS"
alias svnrepos="cd $SVN_REPOS"
alias devbin="cd $DEVELOPMENT_BIN"
alias devsh="cd $DEVELOPMENT_SH"

# [ editor ]
alias ec='$EMACS_HOME/bin/ec.sh'
alias et='$EMACS_HOME/bin/et.sh'
alias es='$EMACS_HOME/bin/es.sh'

# [ security ]
alias ipt-allow="sudo /etc/init.d/yantonov-allow-all-iptables.sh"
alias ipt-deny="sudo /etc/init.d/yantonov-deny-all-iptables.sh"
alias ipt-enable-h="sudo /etc/init.d/yantonov-enable-h-iptables.sh"

# [ vsc / scm ]
alias gitr='cd `git rev-parse --show-toplevel`'
alias hgr='cd `hg root`'

# [ sudo ]
alias fuck='sudo $(fc -ln -1)'

# [ docker ]
alias dangling_images='docker images -f "dangling=true" -q'
alias stopped_containers='docker ps -f "status=exited" -q'

# [tools]
alias cat='bat'
