#!/bin/bash

perms=$(stat -c "%a" /var/)
if [ "$perms" != "755" ]; then
  echo "Warning: Directory permissions for /var/ are not secure."
fi

users=$(ls -ld /var/ | awk '{print $3,$4}')
if [ "$users" != "root root" ]; then
  echo "Warning: Unauthorized users have access to /var/."
fi

php_version=$(php -v | grep -oP "(?<=PHP )\d+\.\d+\.\d+")
mysql_version=$(mysql --version | grep -oP "(?<=Ver )\d+\.\d+\.\d+")
if [ -z "$php_version" ] || [ -z "$mysql_version" ]; then
  echo "Warning: PHP and/or MySQL are not installed in /var/."
else
  echo "PHP version installed in /var/: $php_version"
  echo "MySQL version installed in /var/: $mysql_version"
fi
