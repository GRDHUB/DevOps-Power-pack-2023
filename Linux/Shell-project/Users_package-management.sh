#!/bin/bash

# Define an associative array to store user information
declare -A users

# Add initial technical users and manager users
users=( ["user1"]="Technical Department"
        ["user2"]="Technical Department"
        ["user3"]="Technical Department"
        ["user4"]="Manager Department"
        ["user5"]="Manager Department"
        ["user6"]="Manager Department" )

# Function to display user information
display_user_info() {
  echo "User Information:"
  for user in "${!users[@]}"; do
    echo "Username: $user"
    echo "Department: ${users[$user]}"
    echo "--------------------------------------"
  done
}

# Function to log installation process
log_installation() {
  echo "Logging installation process..."
  echo "Package: $1" >> installation_log.txt
  echo "User: $2" >> installation_log.txt
  echo "Date: $(date)" >> installation_log.txt
  echo "--------------------------------------" >> installation_log.txt
}

# Display available package options
echo "Select a package to install:"
echo "1. Nginx"
echo "2. MySQL"
read -p "Enter your choice (1 or 2): " package_choice

# Check if package choice is valid
if [[ "$package_choice" != "1" && "$package_choice" != "2" ]]; then
  echo "Invalid choice. Exiting..."
  exit 1
fi

# Display user information
display_user_info

# Prompt for authorized user name
read -p "Enter authorized user name: " authorized_user

# Check if authorized user is valid
if [[ ! ${users[$authorized_user]} ]]; then
  echo "Unauthorized user. Exiting..."
  exit 1
fi

# Check if authorized user is a manager
if [[ ${users[$authorized_user]} == "Manager Department" ]]; then
  echo "Managers do not have access to install packages. Exiting..."
  exit 1
fi

# Start installation based on package choice
case "$package_choice" in
  "1")
    echo "Installing Nginx..."
    log_installation "Nginx" "$authorized_user"
    # Add command to install Nginx here
    ;;
  "2")
    echo "Installing MySQL..."
    log_installation "MySQL" "$authorized_user"
    # Add command to install MySQL here
    ;;
  *)
    echo "Invalid choice. Exiting..."
    exit 1
    ;;
esac

echo "Installation completed successfully."

