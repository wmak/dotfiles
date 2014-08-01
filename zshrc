ZSH=$HOME/.oh-my-zsh

function workspace_cd() {
	cd $@ && [ -f ".workspace" ] && sh ./.workspace
}

alias mathlab="ssh makwill1@mathlab.utsc.utoronto.ca"
alias canopus="ssh 192.168.0.40"
alias murder="kill -9"
alias die="kill -15"
alias fuckinginternet="wicd-curses"
alias cleanup="sudo pacman -Sc && sudo pacman-optimize && sync"
alias pdf="texi2pdf --build-dir=.t2d"
alias cd="workspace_cd"

plugins=(git)

source $ZSH/oh-my-zsh.sh

# User configuration

setopt HIST_IGNORE_DUPS


export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/usr/lib/smlnj/bin"

# Go

export GOPATH=$HOME/go
export PATH=$PATH:$GOPATH/bin

PROMPT=$'%{\e[0;34m%}%B┌─[%b%{\e[0m%}%{\e[1;32m%}%n%{\e[1;30m%}@%{\e[0m%}%{\e[0;36m%}%m%{\e[0;34m%}%B]%b%{\e[0m%}─%b%{\e[0;34m%}%B[%b%{\e[1;35m%}%2d%{\e[0;34m%}%B]%b%{\e[0m%}─%{\e[0;34m%}%B[%b%{\e[0;33m%}'%D{"%T"}%b$'%{\e[0;34m%}%B]%b%{\e[0m%}─%b%{\e[0;34m%}%B[%b%{\e[1;31m%}%?%{\e[0;34m%}%B]%b%{\e[0m%}
%{\e[0;34m%}%B└─%B[%{\e[1;35m%}$%{\e[0;34m%}%B] <$(git_prompt_info)>%{\e[0m%}%b '

source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

cd $HOME/development

