#!/bin/sh
if [ "$EUID" -ne 0 ]
  then echo "X [Not Root!]"
  exit
fi
cd /home/
rm -rf installers
mkdir installers
cd installers
echo I will now install wget.
echo 
yum install wget
wget https://www.rainloop.net/repository/webmail/rainloop-latest.zip
echo 
echo "* [This installer is for aaPanel (BT-PANEL)]"
echo 
read -p "* [Enter your domain name (Example: domain.tld)] " domainName
echo 
read -p "* [Removing other webmails] Are you sure? Press Control + C to not." input
cd /www/wwwroot/$domainName
rm -rf webmail
rm -rf mail
echo 
echo "✓ [Removed other webmail]"
mkdir webmail
cd /home/installers
unzip -qq rainloop-latest.zip
mv * /www/wwwroot/$domainName/webmail
cd /www/wwwroot/$domainName/webmail
rm -rf rainloop-latest.zip
echo "* [Fixing Permissions]"
chmod -R 755 /www/wwwroot/$domainName/webmail
chmod -R 777 data
chmod -R 777 rainloop
chmod -R 666 data/EMPTY
chmod -R 644 data/INSTALLED
chmod -R 777 rainloop/*
chmod -R 666 index.php
echo 
echo "✓ [Fixed Permissions]
echo 
cd /www/wwwroot/$domainName/webmail/data
echo "* [Finishing up]"
echo 
echo "✓ [Finished!]"
echo "Deny from all" >> .htaccess
echo 
echo Congratulations, RainLoop is installed on $domainName!
echo 
echo Finish installing Rainloop at http://$domainName/webmail/?admin
echo Username: admin
echo Password: 12345
echo 
echo Once you login, change this password to not expose the admin panel to users.
