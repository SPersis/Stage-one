**Bash Script: create_users.sh**


=============================

This repository contains a Bash script to automate the creation of users and groups from a text file.

**Overview**
The create_users.sh Bash script automates the creation of user accounts on a Linux system based on data provided in a text file. It ensures users are set up with appropriate groups, permissions, and random passwords, while logging all operations for accountability.

**Features**
User Creation: Reads user data from a specified file and creates users with home directories.
Group Management: Assigns users to personal groups based on their usernames and additional groups specified in the input file.
Password Generation: Generates secure, random passwords for each user and stores them securely.
Logging: Logs all actions performed by the script to /var/log/user_management.log.
Secure Storage: Passwords are stored securely in /var/secure/user_passwords.txt.
Prerequisites
Root Privileges: Ensure the script is executed with root privileges (sudo).
Input File: Provide a properly formatted input file (users.txt) containing user data in the format username;groups.
Usage
Clone the repository:

git clone https://github.com/your_username/your_repository.git
cd your_repository
Make the script executable:

chmod +x create_users.sh
Run the script:

sudo ./create_users.sh users.txt
Replace users.txt with your actual input file containing user data.

$$
Verify user creation:
$$

Check /var/log/user_management.log for detailed logs of each operation.
Access generated passwords securely from /var/secure/user_passwords.txt.
Example User Data Format
Ensure your input file (users.txt) follows this format:

username1; group1, group2
username2; group3