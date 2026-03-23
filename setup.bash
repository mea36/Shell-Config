#!/bin/bash

CONFIGPATH=`pwd`
echo "Config path: $CONFIGPATH"

echo "Configuring NVIM"
mkdir -p ~/.config/nvim
ln -sf $CONFIGPATH/init.lua ~/.config/nvim/init.lua 

echo "Configuring BASH"
if [[ ! `grep ". $CONFIGPATH/bash_custom" ~/.bashrc` ]]; then
    echo -ne "if [ -f $CONFIGPATH/bash_custom ]; then\n  . $CONFIGPATH/bash_custom \nfi" >> ~/.bashrc
fi
if [[ ! `grep ". $CONFIGPATH/bash_custom" ~/.bash_profile` ]]; then
    echo -ne "if [ -f $CONFIGPATH/bash_custom ]; then\n  . $CONFIGPATH/bash_custom \nfi" >> ~/.bash_profile
fi
mv ~/.bash_scripts ~/.bash_scripts.bak
ln -sf $CONFIGPATH/bash_scripts ~/.bash_scripts
mv ~/.inputrc ~/.inputrc.bak
ln -sf $CONFIGPATH/inputrc ~/.inputrc

echo "Configuring AsciiDoc"
mv ~/.asciidoc ~/.asciidoc.bak
ln -sf $CONFIGPATH/asciidoc ~/.asciidoc

echo "Configuring SCREEN"
mv ~/.screenrc ~/.screenrc.bak
ln -sf $CONFIGPATH/screenrc ~/.screenrc

echo "Install homebrew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo "Install brew packages"
xargs brew install < brew_list

