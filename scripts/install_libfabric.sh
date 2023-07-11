#!/bin/bash

##SET YOUR VARS HERE##
target=$HOME/install            #where to install to (make sure this is a dedicated directory because it will get force removed!)
repo=$HOME/workspace/libfabric  #where the source code is
debug=1                        #set to 1 for debug build
build_fabtests=1                #set to 1 to build fabtests

declare -a libfabric_args=(
                           "--disable-usnic"
                           "--disable-opx"
                           "--disable-psm"
                           "--disable-psm2"
                           "--disable-psm3"
			   "--enable-ze-dl"
                           )

declare -a fabtests_args=(
                         )
##END SET VARS##




#removed -O0 CFLAG

if [ $debug -eq 1 ]; then
	export CFLAGS="-g"
else
	unset CFLAGS
fi

cd $repo

##clean previous build
rm -rf $target
if [ $build_fabtests -eq 1 ]; then
        (cd fabtests; make distclean)
fi
make distclean


##build libfabric
config_cmd="./configure --prefix=$target"
for arg in "${libfabric_args[@]}"; do
        config_cmd+=" $arg"
done
if [ $debug -eq 1 ]; then
        config_cmd+=" --enable-debug"
fi

./autogen.sh
$config_cmd
make -j install


if [ $build_fabtests -ne 1 ]; then
        exit 0
fi

##build fabtests
cd fabtests
config_cmd="./configure --prefix=$target --with-libfabric=$target"
for arg in "${fabtests_args[@]}"; do
        config_cmd+=" $arg"
done
if [ $debug -eq 1 ]; then
        config_cmd+=" --enable-debug"
fi
./autogen.sh
$config_cmd
make -j install
