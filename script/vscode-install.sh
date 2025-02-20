. ./functions.sh
isInstalled code


echo "Downloading VSCode"
wget --progress=bar:force:noscroll --show-progress -cq 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64' -O /tmp/code_latest_amd64.deb 2>&1
echo "code code/add-microsoft-repo boolean true" | sudo debconf-set-selections
echo "Installing VSCode"
sudo apt-get install -y /tmp/code_latest_amd64.deb > /dev/null
rm /tmp/code_latest_amd64.deb
