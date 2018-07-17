# exports {{{
bindkey -e # LITERALLY MAGIC NO CLUE WHY PUTTING THIS AT THE BOTTOM FUCKS SHIT UP
export HISTFILE=$HOME/.zsh_history
export SAVEHIST=2048
export HISTSIZE=2048
export PATH=$PATH:"/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/smlnj/bin:/opt/android-sdk/tools"
export EDITOR="vim"
export VISUAL="vim"
export TERM="xterm-256color"
export LANG=en_US.UTF-8
export SLACKHANDLE="wmak"

# Python
export WORKON_HOME=$HOME/.virtualenvs

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
alias Osiris="ssh 192.168.0.40"
alias murder="kill -9"
alias die="kill -15"
alias fuckinginternet="wicd-curses"
alias cleanup="sudo pacman -Sc && sudo pacman-optimize && sync"
alias pdf="texi2pdf --build-dir=.t2d"
alias g="git"
alias emacs="emacs -nw"
alias anaconda-up="export PATH=$HOME/anaconda/bin:$PATH && export VIRTUAL_ENV=Anaconda"
alias ':q'="exit"
alias psgrep="ps aux | grep"
alias uppolaris="cd ~/polaris/provisioning; vagrant up web db_primary"
alias wopolaris="ssh vagrant@33.0.0.10"
alias rspolaris="ssh vagrant@33.0.0.10 'zsh -ic rspolaris'"
alias woglingo="ssh ubuntu@34.0.0.10"
alias rsglingo="ssh ubuntu@34.0.0.10 'zsh -ic rsglingo'"
alias pshell="cd $HOME/polaris/provisioning && vagrant ssh web -- -t 'zsh -ic pshell'"
alias vagrantsshdb="cd $HOME/polaris/provisioning && vagrant ssh db_primary"
export FULL_NAME='William Mak'
alias prodshell="mosh webdev@pweb1 -- bash -ic 'export FULL_NAME=\"William Mak\" && pshell'"
alias pweb="mosh webdev@pweb1 -- bash -ic 'tmux a -t wmak'"
alias pwebssh="ssh webdev@pweb1 -t \"bash -ic 'tmux a -t wmak'\""
alias polaris="cd $HOME/development/polaris/pysrc"
alias pyclean="find . -name '*.pyc' -delete"
alias ltest="$HOME/development/ltest/ltest"

function workon(){
	if [ -f $HOME/.workon/$@ ]; then
		printf "You're now working on %b\n" $@
		source $HOME/.workon/$@
	else
		source /usr/local/bin/virtualenvwrapper.sh
		workon $@
	fi
}

function notify(){
    if hash notify-send 2>/dev/null; then
	notify-send $1 $2 --urgency=${3:-normal} 
    elif hash terminal-notifier 2>/dev/null; then
	echo $2 | terminal-notifier -sound default
    else
	echo $1
    fi
}

function runpolaris(){
    while :
	    do
		    rspolaris |
			    while IFS= read -r line
				    do
					    if [ "$line" = "Development server is running at http://127.0.0.1:8000/" ]; then
						    notify "Polaris Server" "Restarted" low
					    fi
				    done
		    notify "Polaris Server" "Crashed" critical
		    sleep 3
	    done
}

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

up-line-or-local-history() {
    zle set-local-history 1
    zle up-line-or-history
    zle set-local-history 0
}
zle -N up-line-or-local-history
down-line-or-local-history() {
    zle set-local-history 1
    zle down-line-or-history
    zle set-local-history 0
}
zle -N down-line-or-local-history

# Adding command editor
autoload -z edit-command-line
bindkey -M vicmd v edit-command-line
zle -N edit-command-line
bindkey "^X^E" edit-command-line

key[Home]=[1~
key[End]=[4~
key[Insert]=${terminfo[kich1]}
key[Delete]=${terminfo[kdch1]}

# setup key accordingly
bindkey     "${key[Home]}"      beginning-of-line
bindkey     "${key[End]}"       end-of-line

bindkey     "${key[Insert]}"    overwrite-mode
bindkey     "${key[Delete]}"    delete-char

bindkey		"${key[Up]}"		up-line-or-local-history()
bindkey		"${key[Down]}"		down-line-or-local-history()
# }}}

# Options {{{
	# Completion {{{
		setopt		ALWAYS_TO_END
		unsetopt	LIST_BEEP
		unsetopt	FLOW_CONTROL
		setopt		AUTO_PUSHD
		setopt		PUSHD_IGNORE_DUPS
		unsetopt	AUTO_CD
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

ord=`printf '%d' "'$HOST"`
host_name=$HOST

if [ $HOST = "Rhea" ]; then
    ord=199
elif [ $HOST = "GTOR-03013" ]; then
    host_name='WorkMac'
    ord=171
fi

function virtualenv_info() {
    [[ -n $VIRTUAL_ENV ]] && 
    echo -n "%{"%F{$ord}"%}──Ⅽ%{$fg[green]%}%B"`basename $VIRTUAL_ENV`"%{"%F{$ord}"%}Ↄ"
}

precmd() {
    PROMPT=%F{$ord}"╭───Ⅽ"
    PROMPT+="%{$fg[green]%}${USER}"
    PROMPT+="%{$fg[grey]%}%B@%b"
    PROMPT+="%{$fg[yellow]%}${host_name}"
    PROMPT+=%F{$ord}"Ↄ──Ⅽ"
    PROMPT+="%{$fg[blue]%}%2d"
    PROMPT+=%F{$ord}"Ↄ──Ⅽ"
    PROMPT+="%{$fg[cyan]%}%T"
    PROMPT+=%F{$ord}"Ↄ──Ⅽ"
    PROMPT+=%F{$ord}"%?"
    PROMPT+=%F{$ord}"Ↄ"
    PROMPT+=$(virtualenv_info)
    PROMPT+=$'\n'"╰─‹"
    PROMPT+="%{$reset_color%}%b"
    PROMPT+=$(git_prompt_info)
    PROMPT+=%F{$ord}"› "
    PROMPT+=%F{255}%b
}

#}}}

# Plugins {{{
    source $HOME/dotfiles/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#}}}

# dircolors config. {{{
if whence dircolors >/dev/null; then
    eval `dircolors -b $HOME/dotfiles/dircolors.conf`
    zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
else
    export CLICOLOR=1
    zstyle ':completion:*:default' list-colors ''
fi	
#}}}

# If there's a development folder cd to it.
[[ -e $HOME/development ]] && cd $HOME/development

# Setup ssh agent
ssh-agent -s > /dev/null
ssh-add 2> /dev/null
