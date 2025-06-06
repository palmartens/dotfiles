. ./functions.sh

chmod 700 ~/.ssh
chmod 600 ~/.ssh/*    

DISTRO_NAME=$(getLinuxDistro)
echo "$DISTRO_NAME Detected"

case "$DISTRO_NAME" in
  "ubuntu")
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
    gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink true
    gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true

    ;;
  "linuxmint")
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
    ;;    
  "endeavouros")
    echo "Setting Arch preferences"
    echo 'Enable dark mode'
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
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
    gsettings set org.gnome.shell.extensions.dash-to-dock custom-theme-shrink true
    gsettings set org.gnome.shell.extensions.dash-to-dock dock-fixed true
    ;;
  *)
    echo "Distribution '$DISTRO_NAME' not supported (yet...)."
    ;;
esac

echo "Installing packages"

if [ "$DISTRO_NAME" = "endeavouros" ]; then
  sudo pacman -S --noconfirm --needed bat colordiff tmux vim code fzf ripgrep lazygit starship ghostty bat archlinux-wallpaper
else
  sudo apt-get install -y bat colordiff tmux vim ccze > /dev/null
  if which starship > /dev/null 2>&1; then
    echo "Starship is already installed."
  else
    echo "Installing starship"
    mkdir -p ~/.local/bin
    curl -sS https://starship.rs/install.sh | sh -s -- -y -b ~/.local/bin/
  fi

fi
