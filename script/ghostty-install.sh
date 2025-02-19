if command -v ghostty > /dev/null
then
  echo "Ghostty already installed, doing nothing."
  exit 0
fi

ghostty_url="$(curl -s https://api.github.com/repos/mkasberg/ghostty-ubuntu/releases/latest  | grep 'amd64_22.04' | grep browser_download_url | cut -d '"' -f 4)"
echo "Downloading Ghostty"
wget --progress=bar:force:noscroll --show-progress -cq $ghostty_url -O /tmp/ghostty.deb
echo "Installing Ghostty"
sudo apt-get install -y /tmp/ghostty.deb > /dev/null
rm -f /tmp/ghostty.deb

