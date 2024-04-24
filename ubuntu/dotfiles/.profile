# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

if [ -f "$HOME/.config/shell_profile/.colors" ]; then
    . $HOME/.config/shell_profile/.colors
fi

if [ -f "$HOME/.config/shell_profile/.path" ]; then
    . $HOME/.config/shell_profile/.path
fi

if [ -f "$HOME/.config/shell_profile/.alias_common" ]; then
    . $HOME/.config/shell_profile/.alias_common
fi

if [ -f "$HOME/.config/shell_profile/.pyenv" ]; then
    . $HOME/.config/shell_profile/.pyenv
fi

if [ -f "$HOME/.profile_os_env" ]; then
    . $HOME/.profile_os_env
fi

if [ -f "$HOME/.profile_alias_os" ]; then
    . $HOME/.profile_alias_os
fi

if [ -f "$HOME/.profile_ssh" ]; then
    . $HOME/.profile_ssh
fi

if [ -f "$HOME/.profile_starship" ]; then
    . $HOME/.profile_starship
fi

if [ -f "$HOME/.profile_custom" ]; then
    . $HOME/.profile_custom
fi

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi

