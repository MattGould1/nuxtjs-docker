#!/bin/sh
sudo apt-get update
if [ $(dpkg-query -W -f='${Status}' openssl 2>/dev/null | grep -c "ok installed") -eq 0 ];
then
  sudo apt-get install openssl;
fi
openssl req -x509 -sha256 -nodes -newkey rsa:2048 -days 365 -keyout certs/localhost.key -out certs/localhost.crt
