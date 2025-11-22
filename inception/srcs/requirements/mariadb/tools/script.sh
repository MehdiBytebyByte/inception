#!/bin/bash

# 1. Start the database in the background
service mariadb start

# 2. Give it a moment to wake up (your preferred method)
sleep 5

# 3. Run the setup commands
# I fixed the syntax here because the original lines were broken.
mariadb -u root -e "CREATE DATABASE IF NOT EXISTS \`${DB_NAME}\`;"
mariadb -u root -e "CREATE USER IF NOT EXISTS '${DB_USER}'@'%' IDENTIFIED BY '${DB_PASS}';"
mariadb -u root -e "GRANT ALL PRIVILEGES ON \`${DB_NAME}\`.* TO '${DB_USER}'@'%';"
mariadb -u root -e "FLUSH PRIVILEGES;"

# 4. Shut down the background service so we can restart it properly below
mariadb-admin -u root shutdown

# 5. Start the database permanently
exec mysqld_safe --bind-address=0.0.0.0