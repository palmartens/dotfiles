echo "Updating and installing required packages"
sudo apt-get update > /dev/null
sudo apt-get install apt-transport-https > /dev/null

if which docker > /dev/null 2>&1; then
  echo "Docker is already installed."
else
  echo "Docker not installed, installing now."
  echo "Adding docker gpg to keyring" 
  curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --yes --dearmor -o /usr/share/keyrings/docker.gpg
  echo "Adding docker repository" 
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu jammy stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
  echo "Installing docker"
  sudo apt-get update > /dev/null
  sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin > /dev/null

  echo "Adding ${USER} to docker group"
  sudo usermod -aG docker ${USER}
fi
