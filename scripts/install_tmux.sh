#/bin/bash

mkdir tmux_build
cd tmux_build

wget https://github.com/libevent/libevent/releases/download/release-2.1.11-stable/libevent-2.1.11-stable.tar.gz
tar -zxf libevent-*.tar.gz
(cd libevent-*/ && ./configure --prefix=$HOME --enable-shared && make && make install)

wget https://ftp.gnu.org/pub/gnu/ncurses/ncurses-6.2.tar.gz
tar -zxf ncurses-*.tar.gz
(cd ncurses-*/ && ./configure --prefix=$HOME --with-shared --enable-pc-files --with-pkg-config-libdir=$HOME/lib/pkgconfig && make && make install)


wget https://github.com/tmux/tmux/releases/download/3.0a/tmux-3.0a.tar.gz
tar -zxf tmux-*.tar.gz
(cd tmux-*/ && PKG_CONFIG_PATH=$HOME/lib/pkgconfig ./configure --prefix=$HOME && make && make install)

cd .. && rm -rf ./tmux_build
