chmod 700 ~/.ssh
chmod 600 ~/.ssh/*    

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


if which docker > /dev/null 2>&1; then
  echo "Docker is already installed."
else
  echo "Installing docker"
  . ./script/docker-install.sh
fi

if which starship > /dev/null 2>&1; then
  echo "Starship is already installed."
else
  echo "Installing starship"
  mkdir -p ~/.local/bin
  curl -sS https://starship.rs/install.sh | sh -s -- -y -b ~/.local/bin/
fi
