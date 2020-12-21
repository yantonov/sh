# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
    . "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -f "$HOME/.profile_colors" ]; then
    . $HOME/.profile_colors
fi

if [ -f "$HOME/.profile_path" ]; then
    . $HOME/.profile_path
fi

if [ -f "$HOME/.profile_alias_common" ]; then
    . $HOME/.profile_alias_common
fi

if [ -f "$HOME/.profile_alias_os" ]; then
    . $HOME/.profile_alias_os
fi

if [ -f "$HOME/.profile_ssh" ]; then
    . $HOME/.profile_ssh
fi

if [ -f "$HOME/.profile_custom" ]; then
    . $HOME/.profile_custom
fi

export PATH="$HOME/.cargo/bin:$PATH"
