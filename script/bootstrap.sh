echo "Setting Mint (Cinnamon) preferences"
gsettings set org.nemo.preferences desktop-is-home-dir false
gsettings set org.nemo.desktop volumes-visible false    
gsettings set org.cinnamon.desktop.interface gtk-theme 'Mint-Y-Dark-Aqua'
gsettings set org.cinnamon.theme name 'Mint-Y-Dark-Aqua'
gsettings set org.gnome.desktop.interface gtk-theme 'Mint-Y-Dark-Aqua'
gsettings set org.mate.interface gtk-theme 'Mint-Y-Dark-Aqua'
gsettings set x.dm.slick-greeter theme-name 'Mint-Y-Dark-Aqua'
gsettings set org.cinnamon.desktop.interface icon-theme 'Mint-Y'
gsettings set org.gnome.desktop.interface icon-theme 'Mint-Y'
gsettings set org.x.apps.portal color-scheme 'prefer-dark'
gsettings set org.cinnamon.settings-daemon.plugins.power sleep-display-ac 0
gsettings set org.cinnamon.settings-daemon.plugins.power sleep-display-battery 0

echo "Installing packages"
sudo apt install -y bat colordiff tmux vim ccze terminator

echo "Installing Hack Nerd Font"
wget -P /tmp https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hack.zip 2> /dev/null
sudo unzip /tmp/Hack.zip -d /usr/local/share/fonts/Hack
rm /tmp/Hack.zip
fc-cache -fv

echo "Checking if docker is installed"
if which docker > /dev/null 2>&1; then
  echo "Docker is already installed."
else
  echo "Docker not installed, installing now."
  bash ./docker-install.sh
fi