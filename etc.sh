#!/bin/bash

num_users=$(cat /etc/passwd | wc -l)

if [[ $(grep -c '\$6' /etc/passwd) -eq $num_users ]]; then
    hashed="Yes"
else
    hashed="No"
fi


dangerous_files=$(find /etc/ -type f -perm 777)

echo "Number of users in etc/passwd file: $num_users"
echo "Is etc/passwd file hashed? $hashed"
if [[ ! -z "$dangerous_files" ]]; then
    echo "Warning! The following files have dangerous permissions:"
    echo "$dangerous_files"
fi
