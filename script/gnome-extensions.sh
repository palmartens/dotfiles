echo "Installing Gnome extension manager and extensions"
yay -S extension-manager gnome-shell-extension-dash-to-dock --noconfirm --needed
echo "Enable Dash-To-Dock"
gnome-extensions enable dash-to-dock@micxgx.gmail.com
echo "Extensions installed, logout and login again to see changes"
