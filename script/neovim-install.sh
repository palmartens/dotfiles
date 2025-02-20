. ./functions.sh
isInstalled nvim

echo "Installing neovim dependencies"
sudo apt-get install -y ninja-build gettext cmake curl build-essential > /dev/null
echo "Clone neovim Git repository"
git clone https://github.com/neovim/neovim /tmp/neovim > /dev/null 2>&1 
cd /tmp/neovim
echo "Switch to stable branch"
git checkout stable > /dev/null 2>&1
echo "Build neovim"
make CMAKE_BUILD_TYPE=RelWithDebInfo > /dev/null
cd build 
cpack -G DEB > /dev/null 2>&1
echo "Install neovim"
sudo dpkg -i nvim-linux-x86_64.deb > /dev/null
