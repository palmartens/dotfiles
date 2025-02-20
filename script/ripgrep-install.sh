. ./functions.sh
isInstalled rg

curl -LO https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep_14.1.0-1_amd64.deb
sudo dpkg -i ripgrep_14.1.0-1_amd64.deb > /dev/null
rm ripgrep_14.1.0-1_amd64.deb
