# system settings

# OPAM configuration
. /Users/yantonov/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

add_to_path "$HOME/.cargo/bin"

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
