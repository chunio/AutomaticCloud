#!bin/bash

:<<MARK
#https://github.com/nvm-sh/nvm
MARK

wget -qO- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
source ~/.bashrc
nvm install v12.3.1
nvm alias default v12.3.1
nvm use v12.3.1
echo "--------------------------------------------------"
nvm --version
echo "--------------------------------------------------"
echo "$0 , success"
echo "--------------------------------------------------"