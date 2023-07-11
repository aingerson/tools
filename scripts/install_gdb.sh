#!/bin/bash

mkdir gdb_build
cd gdb_build

mkdir gdb

wget https://ftp.gnu.org/gnu/gdb/gdb-13.2.tar.gz -O gdb.tar.gz

tar -xvf gdb.tar.gz -C gdb --strip-components=1

(cd gdb && ./configure --prefix=$HOME && make -j && make install)

cd ..
rm -rf gdb_build
