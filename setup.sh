#!/bin/bash

echo "Install Chrome: https://www.google.com/chrome/browser/#eula"
read -p "Press [Enter] key to continue..."

echo "Installing Brew"
PERSONAL_DIR=~/workspace/personal

#Install brew
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

brew doctor
brew install zsh zsh-completions zsh-lovers zsh-syntax-highlighting reattach-to-user-namespace gradle groovy tmux ssh-copy-id tree watch htop-osx ansible wget
sudo chsh -s `which zsh` `whoami`

read -p "Press [Enter] key to continue..."

# Install Pathogen for VIM
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

#Install nerdtree
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree

#Clone Personal repo
echo "Cloneing personal repo"
DOT_FILES=$PERSONAL_DIR/dotfiles
mkdir -p $PERSONAL_DIR
git clone https://github.com/ethankhall/dotfiles.git $DOT_FILES

echo "mapping personal files"
ln -s $DOT_FILES/.gitconfig ~/.gitconfig
ln -s $DOT_FILES/.tmux.conf ~/.tmux.conf
ln -s $DOT_FILES/.vimrc ~/.vimrc
ln -s $DOT_FILES/.tmux ~/.tmux

echo "Cloning personal zprezto"
git clone --recursive https://github.com/ethankhall/prezto.git "${ZDOTDIR:-$HOME}/.zprezto"

if [ "$(uname)" == "Darwin" ]; then
    echo "Setting up custom Mac settings"
    defaults write NSGlobalDomain InitialKeyRepeat -int 12
    defaults write NSGlobalDomain KeyRepeat -int 0.01
    defaults write -g ApplePressAndHoldEnabled -bool false
fi

echo  "Install VirtualBox: https://www.virtualbox.org/wiki/Downloads"
echo  "Install Vagrant: http://www.vagrantup.com/downloads.html"
echo  "Install iTerm2: http://iterm2.com/downloads.html"
echo  "Install IntelliJ: http://www.jetbrains.com/idea/download/"
echo  "Install iStat5: http://bjango.com/mac/istatmenus/"
echo  "Install Bartender: http://www.macbartender.com/"
echo  "Install Marked: http://marked2app.com/"
echo  "Install Sizeup: http://www.irradiatedsoftware.com/downloads/?file=SizeUp.zip"
echo  "Install Fonts: https://github.com/fncll/vimstuff/tree/master/powerline-fonts"
read -p "Press [Enter] key to continue..."

echo "Run the following from ZSH"

cat > zshconfig.sh << END
#!/usr/bin/env zsh
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
      ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
END
