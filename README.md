[提升vim版本]
# How to Install Vim 8.2 in Ubuntu 18.04, 16.04, 19.10
sudo add-apt-repository ppa:jonathonf/vim
sudo apt update
sudo apt install vim
sudo apt install vim-gtk3 vim-nox

[初始化vim环境]
mkdir -p $HOME/.vim/files
mkdir -p $HOME/.vim/files/backup/
mkdir -p $HOME/.vim/files/swap/
mkdir -p $HOME/.vim/files/undo/
mkdir -p $HOME/.vim/files/info/viminfo

[vim项目之间跳转]
.vimenv
set tags+=~/.cache/tags/home-Administrator-openwrt-libubox-.tags
set tags+=~/.cache/tags/home-Administrator-openwrt-ubus-.tags
set tags+=~/.cache/tags/home-Administrator-openwrt-libnl-tiny-.tags
set tags+=~/.cache/tags/home-Administrator-openwrt-uci-.tags
set tags+=~/.cache/tags/home-Administrator-openwrt-json-c-0.12-.tagsAdministrator

[vim插件]
:PlugInstall
