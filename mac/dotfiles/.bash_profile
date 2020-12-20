[[ -s "$HOME/.profile" ]] && source "$HOME/.profile" # Load the default .profile
# load my settings
[[ -s "$HOME/.profile_colors" ]] && source "$HOME/.profile_colors"
[[ -s "$HOME/.profile_path" ]] && source "$HOME/.profile_path"
[[ -s "$HOME/.profile_alias_common" ]] && source "$HOME/.profile_alias_common"
[[ -s "$HOME/.profile_alias_os" ]] && source "$HOME/.profile_alias_os"


# python problem
# ValueError: unknown locale: UTF-8
# http://stackoverflow.com/questions/15526996/ipython-notebook-locale-error
# export LC_ALL=en_US.UTF-8
# export LANG=en_US.UTF-8
# or uncheck "Set locale variables automatically" at Terminal app preferences
# Terminal App -> Preferences -> Profiles -> Advanced -> Flag "Set locale variables automatically"

# Setting PATH for Python 3.7
# The original version is saved in .bash_profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.7/bin:${PATH}"
export PATH

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi
