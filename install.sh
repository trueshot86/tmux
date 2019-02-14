#!/bin/bash

current_dir=$(dirname $(readlink -f $0))
OS=""

get_os_distribution(){
    if [ -e /etc/lsb-release ] ; then
        OS="ubuntu"
    elif [ -e /etc/redhat-release ] ; then
        OS="centos"
    else
	echo "this tool can use at Ubuntu or CentOS"
        exit 1
    fi
}

require_items(){
    if [ ${OS} == "ubuntu" ] ; then
        apt updatea
        apt install make gcc libevent-dev ncurses-dev xsel locales -y
    elif [ ${OS} == "centos" ] ; then
	yum install epel-release -y
        yum install make gcc libevent-devel ncurses-devel xsel locales -y
    fi
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
    get_os_distribution
    require_items
    set_locale
    build_install
    put_configs
    echo "install done."
    echo "Don't forget to do export LANG=ja_JP.utf8"
}

main
