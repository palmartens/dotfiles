if command -v yay &> /dev/null; then
	echo "Yay is already installed"
else
	rm -rf /tmp/yay
	git clone https://aur.archlinux.org/yay-bin.git /tmp/yay
	cd /tmp/yay
	makepkg -si --noconfirm
fi
yay -Ps
