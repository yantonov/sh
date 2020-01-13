source $HOME/.profile_custom

# OPAM configuration
. /Users/yantonov/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH="$HOME/.cargo/bin:$PATH"
