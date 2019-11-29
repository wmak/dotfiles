# exports {{{
bindkey -e # LITERALLY MAGIC NO CLUE WHY PUTTING THIS AT THE BOTTOM FUCKS SHIT UP
export HISTFILE=$HOME/.zsh_history
export SAVEHIST=2048
export HISTSIZE=2048
export EDITOR="nvim"
export VISUAL="nvim"
export TERM="xterm-256color"
export LANG=en_US.UTF-8
export PYTHONSTARTUP=$HOME/dotfiles/pythonstartup.py
export VIRTUALENVWRAPPER_PYTHON=/usr/local/bin/python

# Python
export WORKON_HOME=$HOME/.virtualenvs

# Aliases {{{
if [ -x /usr/bin/dircolors ]; then
    alias ls="ls -h --color=auto"
    alias dir="dir -h --color=auto"
    alias grep='grep --color=auto'
fi
alias reload-zsh=". $HOME/.zshrc"
alias murder="kill -9"
alias die="kill -15"
alias g="git"
alias vi="nvim"
alias vif="vi \$(fzf)"
alias ':q'="exit"
alias psgrep="ps aux | grep"
alias pyclean="find . -name '*.pyc' -delete"
alias ip="ipython2"

print_info () {
	printf "\e[1;33m$1\n\e[1;0m"
}

print_error() {
	printf "\e[1;31m$1\n\e[1;0m"
}

function ltest(){
    # Usage on improper input
    if [ $# -lt 2 ]; then
	print_error "usage: ltest <file> <command>\n"
	print_error "An example use of ltest would be:"
	print_error "\tltest ./go-raptor go run\n"
	print_error "ltest will work on either a file or an entire folder for example:"
	print_error "\tltest ./ go run"
	print_error "will run whenever there's a change in the current directory"
	return 1
    fi

    # Store the name of the file and shift variables
    file=$1
    shift

    # Check that the file being checked actually exists
    if [ -f $file ]; then
	print_info "Starting ltest on the file: "$file
    elif [ -d $file ]; then
	print_info "Starting ltest on the folder: "$file
    else
	print_error $file" is is not a file or folder"
	return 1
    fi

    # Store the intial timestamp for the file
    if [ -x /usr/local/bin/gdate ]; then
	# On macosx `brew install coreutils` so this works
        alias timecmd=gdate
    else
        alias timecmd=date
    fi
    timestamp=`timecmd +%s -r $file`

    # Main execution loop, detect if file has changed within the last 2 seconds.
    while :
    do
	if [ $(expr `timecmd +%s -r $file` - $timestamp) -gt 0 ]; then
	    timestamp=`timecmd +%s -r $file`
	    # Check that the file isn't being modified
	    if [ -f $file ] || [ -d $file ]; then
		clear && print_info "Starting... " && $* && print_info "Finished."
	    fi
	fi
	sleep 2
    done
}
function lptest() {
    ltest $1 ipython2 $1
}

function workon(){
	if [ -f $HOME/.workon/$@ ]; then
		printf "You're now working on %b\n" $@
		source $HOME/.workon/$@
	else
		source /usr/local/bin/virtualenvwrapper.sh
		workon $@
	fi
}

# }}}

# autoloads {{{
autoload -U colors && colors
autoload -U compinit && compinit -i
# zmodload -i zsh/complist
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
	branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
	if [ $? -eq 0 ];
	then
	    diff=$(git diff --no-ext-diff --quiet --exit-code)
	    [[ $? -eq 1 ]] \
		    && echo -n "%{$fg[red]%}" \
		    || echo -n "%{$fg[blue]%}"
	    echo "("${branch}")%{$reset_color%}"
	fi
}

ord=`printf '%d' "'$HOST"`
host_name=$HOST

if [ $HOST = "Rhea" ]; then
    ord=199
elif [ $HOST = "Williams-MacBook-Pro-with-2-Thunderbolt-3-ports-2019" ]; then
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
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
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
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

export FZF_COMPLETION_TRIGGER='~~'
export FZF_BASE="$HOME/.fzf"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
