#!/bin/bash


ftp_version=$(ftp -v | grep "FTP version")


ssl_tls=$(ftp -v | grep "AUTH TLS\|AUTH SSL")
if [ -z "$ssl_tls" ]; then
  echo "Warning: SSL/TLS not used in FTP"
fi


file_permissions=$(ls -l /etc/ftp* | awk '{print $1}')
if [[ "$file_permissions" == *"rwx"* ]]; then
  echo "Warning: Sensitive files are accessible to all users"
fi


echo "FTP Version: $ftp_version"
echo "SSL/TLS Usage: $ssl_tls"
echo "File Permissions: $file_permissions"
