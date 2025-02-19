if command -v code > /dev/null 
then
  echo "VSCode is already installed."
  exit 0
fi

echo "Downloading VSCode"
wget --progress=bar:force:noscroll --show-progress -cq 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64' -O /tmp/code_latest_amd64.deb
echo "code code/add-microsoft-repo boolean true" | sudo debconf-set-selections
echo "Installing VSCode"
sudo apt-get install -y /tmp/code_latest_amd64.deb
rm /tmp/code_latest_amd64.deb
