#!/bin/sh
if [ "$EUID" -ne 0 ]
  then echo "X [Not Root!]"
  exit
fi
rm -rf experimentalMail.sh.*
echo "*[If this doesnt work, make sure there aren't any duplicates of the file!]"
echo 
cd /home/
rm -rf installers
mkdir installers
cd installers
echo "* [Installing dependencies..]"
wget -qq https://www.rainloop.net/repository/webmail/rainloop-latest.zip
echo 
echo "✓ [Installed dependencies!]"
echo 
echo "* [The installation will now begin!]"
echo 
read -p "* [Enter your domain name (Example: domain.tld)] " domainName
echo 
while true; do
    read -p "*! [This will remove domains "mail" and "webmail" if they exist. Press Y to delete, N to cancel.] " yn
    case $yn in
        [Yy]* ) echo "* [Installing]"; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
echo
read -p "* [If you have a custom directory for websites set, please input!] " custDirWeb
if [ -z ${custDirWeb+x} ]; then custDirWeb=/www/wwwroot && echo "* [Defaulted to /www/wwwroot/]"; else echo "* [Set directory to $custDirWeb]"; fi
cd $custDirWeb/$domainName
rm -rf webmail
rm -rf mail
echo 
echo "✓ [Removed other webmail]"
echo 
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
chmod -R 644 data/VERSION
chmod -R 777 rainloop/*
chmod -R 666 index.php
echo 
echo "✓ [Fixed Permissions]"
echo 
cd /www/wwwroot/$domainName/webmail/data
echo "Deny from all" >> .htaccess
echo "* [Finishing up]"
echo 
echo "✓ [Finished!]"
echo 
echo "Congratulations, RainLoop is accessible on http://$domainName/webmail !"
echo 
echo "The admin section to configure RainLoop to send/recieve is at http://$domainName/webmail/?admin"
echo "Username: admin"
echo "Password: 12345"
echo 
echo "Once you login, change this password to not expose the admin panel to users."
