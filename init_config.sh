#!/usr/bin/bash

echo "START"

read "what is the PC name? " PCNAME
echo "PC name: $PCNAME"

echo "install dependencies" 
sudo apt install npm -y
sudo apt install git -y
sudo apt  install curl -y
sudo apt install neovim -y
sudo apt install nodejs -y
sudo apt install tmux -y

echo "install brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
echo "add homebrew to path"
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/jake/.profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

echo "add tmux config"
cd
git clone https://github.com/gpakosz/.tmux.git
ln -s -f .tmux/.tmux.conf
cp .tmux/.tmux.conf.local .

echo "install Spacevim"
curl -sLf https://spacevim.org/install.sh | bash

echo "set clipboard and vim"
cd
cat << EOF >> /home/jake/.SpaceVim/vimrc

set clipboard+=unnamed  " use the clipboards of vim and win 
set paste               " Paste from a windows or from vim
set go+=a               " Visual selection automatically copied to the clipboard

EOF


echo "add Spavecim Fuzzy Finder and Autocomplete"
cat << EOF >> /home/jake/.SpaceVim.d/init.toml

[options]
autocomplete_method = "coc"

[[layers]]
name = "autocomplete"
auto_completion_return_key_behavior = "nil"
auto_completion_tab_key_behavior = "smart"
auto_completion_delay = 200
auto_completion_complete_with_key_sequence = "nil"
auto_completion_complete_with_key_sequence_delay = 0.1

EOF

cd
echo "set -o vi" >> .bashrc

echo "END"
