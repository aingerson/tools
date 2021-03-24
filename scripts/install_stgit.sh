#/bin/bash

cd $HOME/res
mkdir stg_build
cd stg_build

#installs into $HOME/
wget https://github.com/ctmarinas/stgit/archive/v0.21.tar.gz
tar -zxf v*.tar.gz
(cd stgit*/ && make prefix=$HOME install)

cd .. && rm -rf ./stg_build 
