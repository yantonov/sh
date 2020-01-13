# cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# [ development ]
alias hgrepos="cd $HG_REPOS"
alias gitrepos="cd $GIT_REPOS"
alias devbin="cd $DEVELOPMENT_BIN"
alias devsh="cd $DEVELOPMENT_SH"
alias gitr='cd $(git root)'

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

## Colorize the ls output ##
alias ls='ls -G '
## Use a long listing format ##
alias ll='ls -la '
## Show hidden files ##
alias l.='ls -d .* -G '

# tools
alias flush_dns='sudo killall -HUP mDNSResponder'