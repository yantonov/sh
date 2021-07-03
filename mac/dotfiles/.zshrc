export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
source ~/.bash_profile

if command -v starship &> /dev/null
then
    eval "$(starship init zsh)"
fi
