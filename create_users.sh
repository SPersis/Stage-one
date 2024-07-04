#!/bin/bash

# Script: create_users.sh
# Description: Create users and groups from input file, set up home directories,
#              generate passwords, and log actions.

# Input file: users.txt (format: username;groups)
# To learn More about the initiative behind this project, click the link below.
# https://hng.tech/internship, https://hng.tech/hire,

# Log file
LOG_FILE="/var/log/user_management.log"
# Secure password storage
PASSWORD_FILE="/var/secure/user_passwords.txt"

# Check if script is run as root
if [ "$(id -u)" -ne 0 ]; then
    echo "This script must be run as root" >&2
    exit 1
fi

# Function to generate random password
generate_password() {
    local password_length=12
    local password=$(openssl rand -base64 12 | tr -dc 'a-zA-Z0-9' | head -c "$password_length")
    echo "$password"
}

# Function to create user
create_user() {
    local username="$1"
    local groups="$2"
    
    # Check if user already exists
    if id "$username" &>/dev/null; then
        echo "User '$username' already exists. Skipping." | tee -a "$LOG_FILE"
        return
    fi
    
    # Create user with home directory and set password
    useradd -m -s /bin/bash "$username"
    
    # Set password
    local password=$(generate_password)
    echo "$username:$password" | chpasswd
    
    # Store password securely
    echo "$username:$password" >> "$PASSWORD_FILE"
    chmod 600 "$PASSWORD_FILE"
    
    # Add user to groups
    IFS=',' read -ra group_list <<< "$groups"
    for group in "${group_list[@]}"; do
        groupadd "$group"  # Create group if it doesn't exist
        usermod -aG "$group" "$username"
    done
    
    # Logging
    echo "Created user '$username' with groups '$groups' and home directory '$(eval echo ~$username)'." | tee -a "$LOG_FILE"
}

# Main script

# Check if users.txt exists and readable
if [ ! -f "users.txt" ]; then
    echo "users.txt not found!" >&2
    exit 1
fi

# Read each line from users.txt
while IFS=';' read -r username groups; do
    create_user "$username" "$groups"
done < "users.txt"

echo "User creation process completed."
