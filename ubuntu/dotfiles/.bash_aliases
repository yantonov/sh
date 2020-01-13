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
alias ec="$HOME/emacs/bin/ec.sh"
alias et="$HOME/emacs/bin/et.sh"
alias es="$HOME/emacs/bin/es.sh"

# [ sudo ]
alias fuck='sudo $(fc -ln -1)'

# [ docker ]
alias dockerpsn='docker ps --format="{{.Names}}"'
alias dockerpsn1='dockerpsn | head -n 1'
alias dangling_images='docker images -f "dangling=true" -q'
alias stopped_containers='docker ps -f "status=exited" -q'

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

# [ security ]
alias ipt-allow="sudo /etc/init.d/yantonov-allow-all-iptables.sh"
alias ipt-deny="sudo /etc/init.d/yantonov-deny-all-iptables.sh"
alias ipt-enable-h="sudo /etc/init.d/yantonov-enable-h-iptables.sh"
