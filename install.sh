#!/bin/bash
# Bash Script for install ftools tools
# Must run to install tool

clear
echo "
 _____ _           _                   _        _____           _     _                ___                       
|  ___| |         | |                 (_)      |_   _|         (_)   (_)              / _ \                      
| |__ | | ___  ___| |_ _ __ ___  _ __  _  ___    | |_   _ _ __  _ ___ _  __ _ _ __   / /_\ \_ __ _ __ ___  _   _ 
|  __|| |/ _ \/ __| __| '__/ _ \| '_ \| |/ __|   | | | | | '_ \| / __| |/ _` | '_ \  |  _  | '__| '_ ` _ \| | | |
| |___| |  __/ (__| |_| | | (_) | | | | | (__    | | |_| | | | | \__ \ | (_| | | | | | | | | |  | | | | | | |_| |
\____/|_|\___|\___|\__|_|  \___/|_| |_|_|\___|   \_/\__,_|_| |_|_|___/_|\__,_|_| |_| \_| |_/_|  |_| |_| |_|\__, |
                                                                                                            __/ |
                                                                                                           |___/ 
         _____ _   _  _____ _____ ___   _      _      ___________                                                
        |_   _| \ | |/  ___|_   _/ _ \ | |    | |    |  ___| ___ \                                               
          | | |  \| |\ `--.  | |/ /_\ \| |    | |    | |__ | |_/ /                                               
          | | | . ` | `--. \ | ||  _  || |    | |    |  __||    /                                                
         _| |_| |\  |/\__/ / | || | | || |____| |____| |___| |\ \                                                
         \___/\_| \_/\____/  \_/\_| |_/\_____/\_____/\____/\_| \_| 
";

sudo chmod +x uninstall

if [ "$PREFIX" = "/data/data/com.termux/files/usr" ]; then
    INSTALL_DIR="$PREFIX/usr/share/doc/ftools"
    BIN_DIR="$PREFIX/bin/"
    BASH_PATH="$PREFIX/bin/bash"
    TERMUX=true

    pkg install -y git python2
elif [ "$(uname)" = "Darwin" ]; then
    INSTALL_DIR="/usr/local/ftools"
    BIN_DIR="/usr/local/bin/"
    BASH_PATH="/bin/bash"
    TERMUX=false
else
    INSTALL_DIR="$HOME/.ftools"
    BIN_DIR="/usr/local/bin/"
    BASH_PATH="/bin/bash"
    TERMUX=false

    sudo apt-get install -y git python2.7
fi

echo "[✔] Checking directories...";
if [ -d "$INSTALL_DIR" ]; then
    echo "[◉] A directory ftools was found! Do you want to replace it? [Y/n]:" ;
    read -r mama
    if [ "$mama" = "y" ]; then
        if [ "$TERMUX" = true ]; then
            rm -rf "$INSTALL_DIR"
            rm "$BIN_DIR/ftools*"
        else
            sudo rm -rf "$INSTALL_DIR"
            sudo rm "$BIN_DIR/ftools*"
        fi
    else
        echo "[✘] If you want to install you must remove previous installations [✘] ";
        echo "[✘] Installation failed! [✘] ";
        exit
    fi
fi
echo "[✔] Cleaning up old directories...";
if [ -d "$ETC_DIR/Manisso" ]; then
    echo "$DIR_FOUND_TEXT"
    if [ "$TERMUX" = true ]; then
        rm -rf "$ETC_DIR/Manisso"
    else
        sudo rm -rf "$ETC_DIR/Manisso"
    fi
fi

echo "[✔] Installing ...";
echo "";
git clone --depth=1 https://github.com/Manisso/ftools "$INSTALL_DIR";
echo "#!$BASH_PATH
python $INSTALL_DIR/ftools.py" "${1+"$@"}" > "$INSTALL_DIR/ftools";
chmod +x "$INSTALL_DIR/ftools";
if [ "$TERMUX" = true ]; then
    cp "$INSTALL_DIR/ftools" "$BIN_DIR"
    cp "$INSTALL_DIR/ftools.cfg" "$BIN_DIR"
else
    sudo cp "$INSTALL_DIR/ftools" "$BIN_DIR"
    sudo cp "$INSTALL_DIR/ftools.cfg" "$BIN_DIR"
fi
rm "$INSTALL_DIR/ftools";


if [ -d "$INSTALL_DIR" ] ;
then
    echo "";
    echo "[✔] Tool installed successfully! [✔]";
    echo "";
    echo "[✔]====================================================================[✔]";
    echo "[✔]      All is done!! You can execute tool by typing ftools !       [✔]";
    echo "[✔]====================================================================[✔]";
    echo "";
else
    echo "[✘] Installation failed! [✘] ";
    exit
fi
