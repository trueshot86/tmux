#!/bin/bash

current_dir=$(dirname $(readlink -f $0))

require_items(){
    apt updatea
    apt install make gcc libevent-dev ncurses-dev xsel locales -y
}

set_locale(){
    echo "ja_JP UTF-8" > /etc/locale.gen
    locale-gen
    export LANG=ja_JP.utf8
}

build_install(){
    tar zxvf tmux-2.3.tar.gz
    cd tmux-2.3; ./configure && make
    make install
}

put_configs(){
    cd ${current_dir}
    cp .tmux.conf .tmux2.conf $HOME	
}

main(){
    require_items
    set_locale
    build_install
    put_configs
    echo "install done."
}

main
