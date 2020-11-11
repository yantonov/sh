# cd
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# [ development ]
alias gitrepos="cd $GIT_REPOS"
alias devbin="cd $DEVELOPMENT_BIN"
alias devsh="cd $DEVELOPMENT_SH"

# [ sudo ]
alias fuck='sudo $(fc -ln -1)'

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
