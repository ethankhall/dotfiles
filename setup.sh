#!/bin/bash

echo "Installing Brew"
PERSONAL_DIR=~/workspace/personal

#Install brew
ruby -e "$(curl -fsSL https://raw.github.com/Homebrew/homebrew/go/install)"

brew doctor
brew install zsh zsh-completions zsh-lovers zsh-syntax-highlighting reattach-to-user-namespace \
    gradle groovy tmux ssh-copy-id tree watch htop-osx ansible wget \
    git 
    
sudo chsh -s `which zsh` `whoami`

brew install caskroom/cask/brew-cask

brew cask install google-chrome iterm2 1password vagrant vagrant-manager \
    intellij-idea caskroom/versions/java7 sizeup marked bartender istat-menus \
    virtualbox vmware-fusion caffeine flux dropbox alfred

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

sudo wget https://github.com/fncll/vimstuff/raw/master/powerline-fonts/Andale_Mono-Powerline.ttf --directory-prefix=/Library/Fonts/
sudo wget https://github.com/fncll/vimstuff/raw/master/powerline-fonts/SourceCodePro-Black-Powerline.otf --directory-prefix=/Library/Fonts/
sudo wget https://github.com/fncll/vimstuff/raw/master/powerline-fonts/SourceCodePro-Bold-Powerline.otf --directory-prefix=/Library/Fonts/
sudo wget https://github.com/fncll/vimstuff/raw/master/powerline-fonts/SourceCodePro-ExtraLight-Powerline.otf --directory-prefix=/Library/Fonts/
sudo wget https://github.com/fncll/vimstuff/raw/master/powerline-fonts/SourceCodePro-Light-Powerline.otf --directory-prefix=/Library/Fonts/
sudo wget https://github.com/fncll/vimstuff/raw/master/powerline-fonts/SourceCodePro-Regular-Powerline.otf --directory-prefix=/Library/Fonts/
sudo wget https://github.com/fncll/vimstuff/raw/master/powerline-fonts/SourceCodePro-Semibold-Powerline.otf --directory-prefix=/Library/Fonts/

cat > zshconfig.sh << END
#!/usr/bin/env zsh
setopt EXTENDED_GLOB
for rcfile in "${ZDOTDIR:-$HOME}"/.zprezto/runcoms/^README.md(.N); do
      ln -s "$rcfile" "${ZDOTDIR:-$HOME}/.${rcfile:t}"
done
END

chmod +x zshconfig.sh
zsh ./zshconfig.sh
