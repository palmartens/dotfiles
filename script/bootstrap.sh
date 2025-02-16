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
sudo apt-get install -y bat colordiff tmux vim ccze terminator > /dev/null

# Check if the folder exists
if [ -d "/usr/local/share/fonts/Hack/" ]; then
    echo "Hack Nerd font already installed."
else
    echo "Installing Hack Nerd font"
    wget -P /tmp https://github.com/ryanoasis/nerd-fonts/releases/download/v3.3.0/Hack.zip 2> /dev/null
    sudo unzip /tmp/Hack.zip -d /usr/local/share/fonts/Hack > /dev/null
    rm /tmp/Hack.zip
    fc-cache -f
fi

if which docker > /dev/null 2>&1; then
  echo "Docker is already installed."
else
  echo "Installing docker"
  . ./script/docker-install.sh
fi