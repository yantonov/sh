[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
# load my settings
[[ -s "$HOME/.profile_colors" ]] && source "$HOME/.profile_colors"
[[ -s "$HOME/.profile_custom" ]] && source "$HOME/.profile_custom"
[[ -s "$HOME/.profile_alias_common" ]] && source "$HOME/.profile_alias_common"
[[ -s "$HOME/.profile_alias_os" ]] && source "$HOME/.profile_alias_os"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

export PATH="$HOME/.cargo/bin:$PATH"

# OPAM configuration
. /Users/yantonov/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
