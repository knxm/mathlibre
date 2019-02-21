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

if [ -x /usr/bin/dconf ]; then
  profile_id=":b1dcc9dd-5262-4d8d-a863-c897e6d979b9/"
#  dconf write /org/gnome/terminal/legacy/default-show-menubar "false"
  dconf write /org/gnome/terminal/legacy/profiles:/$profile_id"use-theme-colors" "false"
  dconf write /org/gnome/terminal/legacy/profiles:/$profile_id"background-color" "'rgb(0, 0, 0)'"
  dconf write /org/gnome/terminal/legacy/profiles:/$profile_id"foreground-color" "'rgb(255, 255, 255)'"
fi
