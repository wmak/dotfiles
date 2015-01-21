[[ -r $HOME/.profile ]] && . $HOME/.profile
[[ -z $DISPLAY && $XDG_VTNR -eq 1 ]] && exec startx
