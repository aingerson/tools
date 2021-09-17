#!/bin/bash

mkdir -p ~/.vim/colors
git clone https://github.com/flazz/vim-colorschemes.git
cp ./vim-colorschemes/colors/* ~/.vim/colors
rm -rf ./vim-colorschemes
