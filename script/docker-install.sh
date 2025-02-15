echo "Updating and installing required packages"
sudo apt update 2> /dev/null
sudo apt install apt-transport-https 2> /dev/null

echo "Adding docker gpg to keyring" 
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --yes --dearmor -o /usr/share/keyrings/docker.gpg

echo "Adding docker repository"
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu jammy stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "Installing docker"
sudo apt update 2> /dev/null
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin 2> /dev/null

echo "Adding ${USER} to docker group"
sudo usermod -aG docker ${USER}

echo "Running hello-world container"
sudo docker run --rm hello-world
