#!/bin/bash
set -e

# install wget
apt update
apt install -y wget git

# install miniforge
wget https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-$(uname)-$(uname -m).sh -q -O miniforge.sh
chmod u+x miniforge.sh
./miniforge.sh -b -p $HOME/miniforge3
rm -fr miniforge.sh

miniforge3/bin/conda init
