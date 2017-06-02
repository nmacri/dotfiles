#!/usr/bin/env bash

git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

cd "$(dirname "${BASH_SOURCE}")";

git pull origin master;

function doIt() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude ".osx" \
		--exclude "bootstrap.sh" \
		--exclude "README.md" \
		--exclude "LICENSE-MIT.txt" \
		-avh --no-perms . ~;
	source ~/.bash_profile;
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
	doIt;
else
	read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
	echo "";
	if [[ $REPLY =~ ^[Yy]$ ]]; then
		doIt;
	fi;
fi;
unset doIt;

rm -Rf ~/.vim/colors
sudo mkdir ~/.vim/colors
sudo cp ~/dotfiles/.vim/colors/solarized.vim ~/.vim/colors/solarized.vim
sudo cp ~/dotfiles/.matplotlib/matplotlibrc ~/.matplotlib/matplotlibrc

vim +PluginInstall +qall




