DIR=$(HOME)/dotfiles

deb: symlinks copy apt-get vim vim-setup zsh python3
mac: symlinks copy homebrew keybindings neovim
docker: symlinks copy
.PHONY: keybindings

symlinks:
	@ln -sf $(DIR)/gitconfig $(HOME)/.gitconfig
	@ln -sf $(DIR)/gitignore $(HOME)/.gitignore
	@mkdir -p $(HOME)/.config
	@ln -sf $(DIR)/flake8 $(HOME)/.config/flake8
	@ln -sf $(DIR)/zshrc $(HOME)/.zshrc

copy:
	@cp -fH $(DIR)/tmux.conf $(HOME)/.tmux.conf
	@cp -fH $(DIR)/Xresources $(HOME)/.Xresources
	@mkdir -p $(HOME)/.ipython/profile_default
	@cp -fH $(DIR)/ipython_config.py $(HOME)/.ipython/profile_default/ipython_config.py

homebrew:
	curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install | ruby
	brew install tmux htop
	brew cask install ngrok

fzf:
	brew install fzf
	/usr/local/opt/fzf/install --no-bash --no-fish

keybindings:
	@ln -sf $(DIR)/KeyBindings $(HOME)/Library/KeyBindings

neovim: node python3
	@brew install neovim
	@pip3 install --user neovim
	@npm install -g neovim typescript
	@ln -sf $(DIR)/nvim $(HOME)/.config/nvim
	@curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	@nvim +PlugInstall +qall

apt-get:
	sudo apt-get -y install software-properties-common python-software-properties
	sudo add-apt-repository -y ppa:git-core/ppa
	sudo apt-get update
	sudo apt-get -y remove vim vim-runtime gvim
	sudo apt-get -y install git zsh tmux htop ncurses-dev libevent-dev libncurses-dev build-essential autotools-dev automake
	

node:
	brew install nvm
	source /usr/local/opt/nvm/nvm.sh \
	export NVM_DIR="$(HOME)/.nvm" \
	nvm install 10.16.3

vim:
	if [ ! -d $(HOME)/.vimsource ]; then \
		git clone https://github.com/vim/vim.git $(HOME)/.vimsource; \
	fi
	cd $(HOME)/.vimsource && git pull
	cd $(HOME)/.vimsource && ./configure --with-features=huge \
            --enable-multibyte \
            --enable-rubyinterp=yes \
            --enable-pythoninterp=yes \
            --with-python-config-dir=/usr/lib/python2.7/config \
            --enable-python3interp=yes \
            --with-python3-config-dir=/usr/lib/python3.5/config \
            --enable-perlinterp=yes \
            --enable-luainterp=yes \
            --enable-gui=gtk2 --enable-cscope --prefix=/usr
	cd $(HOME)/.vimsource && make
	cd $(HOME)/.vimsource && sudo make install

tmux:
	if [ ! -d $(HOME)/.tmuxsource ]; then \
		git clone https://github.com/tmux/tmux.git $(HOME)/.tmuxsource; \
	fi
	cd $(HOME)/.tmuxsource && git pull
	cd $(HOME)/.tmuxsource && sh autogen.sh
	cd $(HOME)/.tmuxsource && ./configure && make
	cd $(HOME)/.tmuxsource && sudo make install
	if [ ! -d $(HOME)/.tmux/plugins/tpm ]; then \
		git clone https://github.com/tmux-plugins/tpm $(HOME)/.tmux/plugins/tpm; \
	fi
	@echo "set -g mouse on" >> $(HOME)/.tmux.conf
	@echo "set -g @plugin 'tmux-plugins/tmux-resurrect'" >> $(HOME)/.tmux.conf
	@echo "run '~/.tmux/plugins/tpm/tpm'" >> $(HOME)/.tmux.conf

vim-setup: symlinks
	if [ ! -d $(HOME)/.vim/bundle/Vundle.vim ]; then \
		git clone https://github.com/gmarik/Vundle.vim.git $(HOME)/.vim/bundle/Vundle.vim; \
	fi
	@echo | echo | vim +PluginInstall +qall
	@mkdir -p $(HOME)/.vim/backups

zsh: symlinks
	sudo chsh -s /bin/zsh $(USER)

python3:
	brew install python3
