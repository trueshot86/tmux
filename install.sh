#!/bin/bash

current_dir=$(dirname $(readlink -f $0))

require_items(){
    apt install libevent-dev ncurses-devel gcc xsel -y
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
    build_install
    put_configs
    echo "install done."
}

main
