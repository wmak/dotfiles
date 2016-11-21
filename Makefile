DIR=$(HOME)/dotfiles

deb: symlinks copy apt-get vundle zsh

symlinks:
	@ln -sf $(DIR)/gitconfig $(HOME)/.gitconfig
	@ln -sf $(DIR)/gitignore $(HOME)/.gitignore
	@ln -sf $(DIR)/tmux.conf $(HOME)/.tmux.conf
	@ln -sf $(DIR)/vimrc $(HOME)/.vimrc
	@ln -sf $(DIR)/zprofile $(HOME)/.zprofile

copy:
	@cp -fH $(DIR)/zshrc $(HOME)/.zshrc
	@echo "export LC_ALL=en_US.UTF-8" >> $(HOME)/.zshrc
	@echo "export LANG=en_US.UTF-8" >> $(HOME)/.zshrc

apt-get:
	sudo apt-get install software-properties-common python-software-properties
	#sudo add-apt-repository ppa:wmakkers/precise-vim
	sudo add-apt-repository ppa:git-core/ppa
	sudo apt-get update
	sudo apt-get install vim git zsh

vundle: symlinks
	if [ ! -d $(HOME)/.vim/bundle/Vundle.vim ]; then \
		git clone https://github.com/gmarik/Vundle.vim.git $(HOME)/.vim/bundle/Vundle.vim; \
	fi
	vim +PluginInstall +qall

zsh: symlinks
	sudo chsh -s /bin/zsh vagrant

polaris: copy
	@echo "" >> $(HOME)/.zshrc
	@echo "# Polaris specific settings" >> $(HOME)/.zshrc
	@echo "export VIRTUALENVWRAPPER_PYTHON=/usr/bin/python" >> $(HOME)/.zshrc
	@echo "export PIP_RESPECT_VIRTUALEV=true" >> $(HOME)/.zshrc
	@echo "export WORKON_HOME=/var/virtualenvs/" >> $(HOME)/.zshrc
	@echo "export PYTHONPATH=:/home/webdev/websites/polaris/pysrc/apps:/home/webdev/websites/polaris/pysrc/apps/external:/home/webdev/websites/polaris/pysrc/extra_settings" >> $(HOME)/.zshrc
	@echo "alias wopolaris='workon polaris;cd /home/webdev/websites/polaris/pysrc'" >> $(HOME)/.zshrc
	@echo "alias rspolaris='workon polaris;sudo /etc/init.d/apache2 restart;python /home/webdev/websites/polaris/pysrc/manage.py runserver_plus'" >> $(HOME)/.zshrc
	@echo "wopolaris" >> $(HOME)/.zshrc
