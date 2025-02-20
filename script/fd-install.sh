. ./functions.sh
isInstalled fd

wget --progress=bar:force:noscroll --show-progress -cq "https://github.com/sharkdp/fd/releases/download/v10.2.0/fd-musl_10.2.0_amd64.deb" -O /tmp/fd.deb 2>&1
sudo dpkg -i /tmp/fd.deb > /dev/null
rm /tmp/fd.deb
