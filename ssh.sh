#!/bin/bash

# Get SSH version
ssh_version=$(ssh -V 2>&1 | awk '{print $1}')

echo "SSH Version: $ssh_version"


groups=$(grep ssh /etc/group | cut -d ":" -f 1)

if [ -z "$groups" ]; then
    echo "No groups have SSH access."
else
    echo "Groups with SSH access: $groups"
fi


ports=$(netstat -tlnp | grep ssh | awk '{print $4}' | cut -d ":" -f 2)

for port in $ports; do
    if [ "$port" == "22" ]; then
        echo "SSH is using port 22, which is a common target for attacks."
    fi
done


if [ $(grep "^AllowUsers" /etc/ssh/sshd_config) ] || [ $(grep "^AllowGroups" /etc/ssh/sshd_config) ] || [ $(grep "^DenyUsers" /etc/ssh/sshd_config) ] || [ $(grep "^DenyGroups" /etc/ssh/sshd_config) ] || [ $(grep "^PermitRootLogin no" /etc/ssh/sshd_config) ]; then
    echo "Time/IP restrictions are set in sshd_config."
else
    echo "No time/IP restrictions are set in sshd_config."
fi

auth_methods=$(grep "^AuthenticationMethods" /etc/ssh/sshd_config)

if [[ "$auth_methods" == *"publickey"* ]]; then
    echo "Public/private keys are used for authentication."
else 
    echo "Passwords are used for authentication. It is recommended to use public/private keys instead."
fi
