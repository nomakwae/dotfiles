# /etc/skel/.bash_profile

export PATH="$HOME/.local/bin:$HOME/go/bin:$HOME/.cargo/bin:$PATH"
export C_INCLUDE_PATH="$HOME/.local/include"
export XDG_CONFIG_HOME="$HOME/.config"

# This file is sourced by bash for login shells.  The following line
# runs your .bashrc and is recommended by the bash info pages.
if [[ -f ~/.bashrc ]] ; then
	. ~/.bashrc
fi
