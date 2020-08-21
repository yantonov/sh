# cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# [ development ]
alias gitrepos="cd $GIT_REPOS"
alias devbin="cd $DEVELOPMENT_BIN"
alias devsh="cd $DEVELOPMENT_SH"
alias gitr='cd $(git root)'

# [ sudo ]
alias fuck='sudo $(fc -ln -1)'

## Colorize the ls output ##
alias ls='ls -G '
## Use a long listing format ##
alias ll='ls -la '
## Show hidden files ##
alias l.='ls -d .* -G '

# tools
alias flush_dns='sudo killall -HUP mDNSResponder'