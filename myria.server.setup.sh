#!/bin/bash

# Update and upgrade packages
apt update && apt upgrade -y

# Configure SSH
if grep -q "^PermitRootLogin yes" /etc/ssh/sshd_config; then
  sudo sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
  sudo systemctl restart ssh
fi

if grep -q "^#PasswordAuthentication yes" /etc/ssh/sshd_config; then
  sudo sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
  sudo systemctl restart ssh
fi

# Install fail2ban
sudo apt install fail2ban -y
sudo systemctl enable fail2ban
sudo systemctl start fail2ban

# Add new users
sudo adduser interadmin
# sudo adduser interadmin2

# Add users to sudo group
sudo usermod -aG sudo interadmin
# sudo usermod -aG sudo interadmin2

# Enable automatic system updates
# sudo apt install unattended-upgrades -y
# sudo dpkg-reconfigure -plow unattended-upgrades

# Download and install Myria CLI binary
sudo wget https://downloads-builds.myria.com/node/install.sh -O - | sudo bash

myria-node --start

