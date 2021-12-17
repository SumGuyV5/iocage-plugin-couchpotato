#!/bin/sh -x
IP_ADDRESS=$(ifconfig | grep -E 'inet.[0-9]' | grep -v '127.0.0.1' | awk '{ print $2}')

cd /usr/local

git clone https://github.com/CouchPotato/CouchPotatoServer.git

cp CouchPotatoServer/init/freebsd /usr/local/etc/rc.d/couchpotato

ln -sf /usr/local/bin/python2.7 /usr/local/bin/python2

sed -i' ' -e 's:#\!/usr/bin/env python2:#\!/usr/local/bin/python2:' /usr/local/CouchPotatoServer/CouchPotato.py

chmod 555 /usr/local/etc/rc.d/couchpotato

sysrc couchpotato_enable=YES

service couchpotato restart 2>/dev/null

echo -e "Couch Potato now installed.\n" > /root/PLUGIN_INFO
echo -e "\nPlease open your web browser and go to http://${IP_ADDRESS}:5050 to configure couchpotato.\n" >> /root/PLUGIN_INFO