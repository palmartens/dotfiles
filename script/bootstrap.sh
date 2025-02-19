chmod 700 ~/.ssh
chmod 600 ~/.ssh/*    

DISTRO_NAME=$(cat /etc/*-release | grep ID | head -n1 | cut -d '=' -f2)
echo "$DISTRO_NAME Detected"

if [ "$DISTRO_NAME" == "Ubuntu" ] 
then
  echo "Setting Ubuntu preferences"
  echo 'Enable dark mode'
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
	  gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-olive-dark'
    echo "Disable blank screen delay"
    gsettings set org.gnome.desktop.session idle-delay 0
    echo "Disable automatic screen lock"
    gsettings set org.gnome.desktop.screensaver lock-enabled false
    echo "Setup the dock"
    gsettings set org.gnome.shell.extensions.dash-to-dock show-mounts false
    gsettings set org.gnome.shell.extensions.dash-to-dock show-trash false    
    gsettings set org.gnome.shell.extensions.dash-to-dock dock-position BOTTOM
    gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 40
    gsettings set org.gnome.shell.extensions.dash-to-dock show-apps-at-top true  
else
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
fi



echo "Installing packages"
sudo apt-get install -y bat colordiff tmux vim ccze terminator > /dev/null

if which starship > /dev/null 2>&1; then
  echo "Starship is already installed."
else
  echo "Installing starship"
  mkdir -p ~/.local/bin
  curl -sS https://starship.rs/install.sh | sh -s -- -y -b ~/.local/bin/
fi
