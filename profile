export PAGER="less"
export LESSOPEN="| /usr/bin/lesspipe.sh %s"
export LESS=' -R -m -i'
export LSCOLORS="Gxfxcxdxbxegedabagacad"

eval $( keychain --eval id_rsa)
