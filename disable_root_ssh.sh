# Configure SSH to disable ssh with root account
if grep -q "^PermitRootLogin yes" /etc/ssh/sshd_config; then
  sudo sed -i 's/^PermitRootLogin yes/PermitRootLogin no/' /etc/ssh/sshd_config
  sudo systemctl restart ssh
fi

if grep -q "^#PasswordAuthentication yes" /etc/ssh/sshd_config; then
  sudo sed -i 's/^#PasswordAuthentication yes/PasswordAuthentication no/' /etc/ssh/sshd_config
  sudo systemctl restart ssh
fi
