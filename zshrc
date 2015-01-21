# Aliases {{{
if [ -x /usr/bin/dircolors ]; then
	alias ls="ls -h --color=auto"
	alias dir="dir -h --color=auto"
	alias grep='grep --color=auto'
fi
alias topmon="xrandr --output DP1 --auto --above LVDS1 && sh $HOME/.fehbg && xset dpms force off ;"
alias leftmon="xrandr --output DP1 --auto --left-of LVDS1 && sh $HOME/.fehbg && xset dpms force off ;"
alias rightmon="xrandr --output DP1 --auto --right-of LVDS1 && sh $HOME/.fehbg && xset dpms force off ;"
alias 'wakethefuckup╯(´Д´)╯彡┻━┻'="xset dpms force off ;"
alias offmon="xrandr --output DP1 --off"
alias reload-zsh=". $HOME/.zshrc"
alias mathlab="ssh makwill1@mathlab.utsc.utoronto.ca"
alias Osiris="ssh 192.168.0.41"
alias murder="kill -9"
alias die="kill -15"
alias fuckinginternet="wicd-curses"
alias cleanup="sudo pacman -Sc && sudo pacman-optimize && sync"
alias pdf="texi2pdf --build-dir=.t2d"
alias g="git"

function cdls(){
	cd $@ && ls
}
alias cl="cdls"
# }}}

# autoloads {{{
autoload -U colors && colors
autoload -U compinit && compinit -i
zmodload -i zsh/complist
# }}}

# Keybinding {{{
typeset -A key

key[Home]=[1~
key[End]=[4~
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}

# setup key accordingly
bindkey     "${key[Home]}"      beginning-of-line
bindkey     "${key[End]}"       end-of-line

bindkey     "${key[Insert]}"    overwrite-mode
bindkey     "${key[Delete]}"    delete-char
# }}}

# Options {{{
	# Completion {{{
		setopt		ALWAYS_TO_END
		unsetopt	LIST_BEEP
		unsetopt	FLOW_CONTROL
		setopt		AUTO_PUSHD
		setopt		PUSHD_IGNORE_DUPS
		setopt		AUTO_CD
	# }}}

	# History{{{
		setopt		EXTENDED_HISTORY
		setopt		HIST_IGNORE_ALL_DUPS
		setopt		HIST_REDUCE_BLANKS
		setopt		SHARE_HISTORY
	# }}}

	# Input {{{
		setopt		CORRECT
		setopt		INTERACTIVE_COMMENTS
		setopt		IGNORE_EOF
	# }}}
	
	# Other {{{
		setopt		COMPLETE_IN_WORD
	# }}}
# }}}

# exports {{{
export HISTFILE=$HOME/.zsh_history
export SAVEHIST=2048
export HISTSIZE=2048
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/smlnj/bin:/opt/android-sdk/tools"
export EDITOR="vim"

# Go
export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin
#}}}

# zstyles {{{
# That good ol' pretty autocomplete
zstyle ':completion:*' \
	        matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

zstyle ':completion:*' list-colors ''

zstyle ':completion:*:*:*:*:*' menu select

zstyle ':completion:*:*:kill:*:processes' \
	        list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'

zstyle ':completion:*:*:*:*:processes' \
	        command "ps -u$USER -o pid,user,comm -w -w"
zstyle ':completion:*:cd:*' \
	        tag-order local-directories directory-stack path-directories
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ${HOME}/.cache/zsh
zstyle ':completion:*:*:*:users' ignored-patterns \
	        avahi bin daemon dbus ftp git http mail mpd mysql nobody ntp \
		        polkitd postfix postgres root rtkit transmission usbmux uuidd
autoload -Uz vcs_info
zstyle ':vcs_info:*' max-exports 3
zstyle ':vcs_info:git*' check-for-changes true
zstyle ':vcs_info:git*' actionformats '(%b|%a) ' '%u%c' '%s'
zstyle ':vcs_info:git*' formats '(%b)' '%u%c' '%s'
zstyle ':vcs_info:' enable git
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked
# }}}

# Prompt {{{
# avoid weirdness with untracked items
+vi-git-untracked() {
	git rev-parse --is-inside-work-tree &> /dev/null || return;
	git status --porcelain | grep '??' &> /dev/null || return;
	hook_com[unstaged]+='T'
}

function git_prompt_info() {
	vcs_info #Get version control system info
	[[ "${vcs_info_msg_2_}" != "git" ]] && return
	[[ -n "${vcs_info_msg_1_}" ]] \
		&& echo -n "%{$fg[red]%}" \
		|| echo -n "%{$fg[blue]%}"
	echo ${vcs_info_msg_0_}"%{$reset_color%}"
}

function virtualenv_info() {
	[[ -n $VIRTUAL_ENV ]] && echo -n "%{$fg[blue]%}──Ⅽ%{$fg[green]%}%B"`basename $VIRTUAL_ENV`"%{$fg[blue]%}Ↄ"
}

precmd() {
	PROMPT="%{$fg[red]%}%B╭───Ⅽ%b"
	PROMPT+="%{$fg[green]%}${USER}"
	PROMPT+="%{$fg[grey]%}%B@%b"
	PROMPT+="%{$fg[yellow]%}${HOST}"
	PROMPT+="%{$fg[red]%}%BↃ──Ⅽ%b"
	PROMPT+="%{$fg[blue]%}%2d"
	PROMPT+="%{$fg[red]%}%BↃ──Ⅽ%b"
	PROMPT+="%{$fg[cyan]%}%T"
	PROMPT+="%{$fg[red]%}%BↃ──Ⅽ%b"
	PROMPT+="%{$fg[red]%}%?"
	PROMPT+="%{$fg[red]%}%BↃ"
	PROMPT+=$(virtualenv_info)
	PROMPT+=$'\n'"╰─‹"
	PROMPT+="%{$reset_color%}%b"
	PROMPT+=$(git_prompt_info)
	PROMPT+="%{$fg[red]%}%B› "
	PROMPT+="%{$reset_color%}%b"
}

#}}}

# Plugins {{{
	source $HOME/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#}}}

# dircolors config. {{{
eval `dircolors -b $HOME/dotfiles/dircolors.conf`
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
#}}}

# If there's a development folder cd to it.
[[ -e $HOME/development ]] && cd $HOME/development
