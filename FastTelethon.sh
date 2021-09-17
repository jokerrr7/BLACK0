#!/usr/bin/env bash
cd $HOME/TEAMTELETHON
rm -rf $HOME/.telegram-cli
install() {
rm -rf $HOME/.telegram-cli
sudo chmod +x tg
sudo chmod +x install.sh
./install.sh
}
if [ "$1" = "ins" ]; then
install
fi

lua blackinstall.lua
