export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting
source ~/.bash_profile

# https://stackoverflow.com/questions/592620/how-can-i-check-if-a-program-exists-from-a-bash-script
if command -v starship &> /dev/null
then
    eval "$(starship init zsh)"
fi
