#!/bin/bash

# Create two folders: Technical and Manager
mkdir Technical
mkdir Manager

# Create Technical group with access to Technical folder
sudo groupadd Technical
sudo chown :Technical Technical
sudo chmod 770 Technical

# Create Manager group with access to Manager folder
sudo groupadd Manager
sudo chown :Manager Manager
sudo chmod 770 Manager

# Ask for new user name
read -p "Enter the name of the new user: " NEW_USER

# Ask for department name
read -p "Enter the department name (Technical/Manager): " DEPARTMENT

# Create new user
sudo useradd $NEW_USER

# Add user to the respective group
if [ "$DEPARTMENT" == "Technical" ]; then
  sudo usermod -aG Technical $NEW_USER
else
  sudo usermod -aG Manager $NEW_USER
fi

# Grant sudo access to the new user
echo "$NEW_USER ALL=(ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$NEW_USER
sudo chown root:root /etc/sudoers.d/$NEW_USER
sudo chmod 440 /etc/sudoers.d/$NEW_USER

# Print summary message
echo "New user $NEW_USER has been created and added to the $DEPARTMENT group."
echo "Sudo access has been granted to $NEW_USER."
echo "The Technical folder has been assigned to the Technical group with appropriate permissions."
echo "The Manager folder has been assigned to the Manager group with appropriate permissions."

