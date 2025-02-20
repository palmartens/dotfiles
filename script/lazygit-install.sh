. ./functions.sh
isInstalled lazygit

echo "Downloading lazygit" 
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | \grep -Po '"tag_name": *"v\K[^"]*')
wget --progress=bar:force:noscroll --show-progress -cq "https://github.com/jesseduffield/lazygit/releases/download/v${LAZYGIT_VERSION}/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz" -O /tmp/lazygit.tar.gz 2>&1
echo "Installing lazygit" 
tar xf /tmp/lazygit.tar.gz -C /tmp
sudo install /tmp/lazygit -D -t /usr/local/bin/
rm -r /tmp/lazygit /tmp/lazygit.tar.gz
echo "lazygit installed."  