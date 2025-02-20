. ./functions.sh
isInstalled rg

wget --progress=bar:force:noscroll --show-progress -cq "https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep_14.1.0-1_amd64.deb" -O /tmp/ripgrep.deb 2>&1

sudo dpkg -i /tmp/ripgrep.deb > /dev/null
rm /tmp/ripgrep.deb
