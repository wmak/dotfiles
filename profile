export PAGER="less"
export LESSOPEN="| /usr/bin/lesspipe.sh %s"
export LESS=' -R -m -i'
export LSCOLORS="Gxfxcxdxbxegedabagacad"
set -o emacs

eval $( keychain --eval id_rsa)
