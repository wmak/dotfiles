DIR=$(HOME)/dotfiles

polaris: symlinks copy apt-get vim vim-setup zsh zsh-polaris
deb: symlinks copy apt-get vim vim-setup zsh zsh-python3

symlinks:
	@ln -sf $(DIR)/gitconfig $(HOME)/.gitconfig
	@ln -sf $(DIR)/gitignore $(HOME)/.gitignore
	@ln -sf $(DIR)/vimrc $(HOME)/.vimrc
	@ln -sf $(DIR)/zprofile $(HOME)/.zprofile
	@mkdir -p $(HOME)/.config
	@ln -sf $(DIR)/flake8 $(HOME)/.config/flake8

copy:
	@cp -fH $(DIR)/zshrc $(HOME)/.zshrc
	@cp -fH $(DIR)/tmux.conf $(HOME)/.tmux.conf
	@cp -fH $(DIR)/Xresources $(HOME)/.Xresources
	@echo "export LC_ALL=en_US.UTF-8" >> $(HOME)/.zshrc
	@echo "export LANG=en_US.UTF-8" >> $(HOME)/.zshrc

apt-get:
	sudo apt-get install software-properties-common python-software-properties
	sudo add-apt-repository -y ppa:git-core/ppa
	sudo apt-get update
	sudo apt-get -y remove vim vim-runtime gvim
	sudo apt-get -y install git zsh tmux htop ncurses-dev libevent-dev libncurses-dev build-essential autotools-dev automake

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

zsh-python3: copy
	@echo "" >> $(HOME)/.zshrc
	@echo "# Python3 specific settings" >> $(HOME)/.zshrc
	@echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python3" >> $(HOME)/.zshrc
	@echo "export PIP_RESPECT_VIRTUALEV=true" >> $(HOME)/.zshrc
	@echo "export WORKON_HOME=/var/virtualenvs/" >> $(HOME)/.zshrc

zsh-polaris: copy
	@echo "" >> $(HOME)/.zshrc
	@echo "# Polaris specific settings" >> $(HOME)/.zshrc
	@echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python" >> $(HOME)/.zshrc
	@echo "export PIP_RESPECT_VIRTUALEV=true" >> $(HOME)/.zshrc
	@echo "export WORKON_HOME=/var/virtualenvs/" >> $(HOME)/.zshrc
	@echo "export PYTHONPATH=:/home/webdev/websites/polaris/pysrc/apps:/home/webdev/websites/polaris/pysrc/apps/external:/home/webdev/websites/polaris/pysrc/extra_settings" >> $(HOME)/.zshrc
	@echo "alias wopolaris='workon polaris;cd /home/webdev/websites/polaris/pysrc'" >> $(HOME)/.zshrc
	@echo "alias rspolaris='workon polaris;sudo /etc/init.d/apache2 restart;python /home/webdev/websites/polaris/pysrc/manage.py runserver_plus'" >> $(HOME)/.zshrc
	@echo "wopolaris" >> $(HOME)/.zshrc

