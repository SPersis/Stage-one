The script `user_management.sh` automates user creation with secure password handling and logging. Here’s a breakdown of its functionality:

- **Variables**: 
  - `LOG_FILE` specifies the path for logging user creation activities.
  - `PASSWORD_FILE` stores user passwords securely.

- **Root Privilege Check**: 
  - The script verifies if it is executed with root privileges (`root` user ID `0`). If not, it exits with an error message.

- **Function `generate_password`**: 
  - Generates a random alphanumeric password of length 12 using OpenSSL and stores it securely.

- **Function `create_user`**: 
  - Creates a new user with a specified username and assigns them to specified groups.
  - Checks if the user already exists before attempting creation.
  - Sets the generated password for the user and logs both the username and password securely in `PASSWORD_FILE`.
  - Adds the user to specified groups, creating the groups if they do not exist.
  - Logs the creation process including username, assigned groups, and home directory path.

- **Main Script**: 
  - Checks if `users.txt` exists and is readable. If not, it exits with an error message.
  - Reads `users.txt` line by line, where each line contains a username and a comma-separated list of groups.
  - Calls `create_user` function for each user specified in `users.txt`.

- **Completion Message**: 
  - Once all users from `users.txt` are processed, it outputs "User creation process completed."

This script facilitates automated user management with robust security measures and detailed logging, ensuring efficient user creation and management in a controlled environment.
