#!/bin/bash
# Script for update Ftools tools

git clone --depth=1 https://github.com/Manisso/ftools.git
sudo chmod +x ftools/install.sh
bash ftools/install.sh
