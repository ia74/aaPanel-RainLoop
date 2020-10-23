#!/bin/sh
export RLVersion = latest
export versionS = stable/v2
if [ "$EUID" -ne 0 ]
  then echo "X [Not Root!]"
  exit
fi
rm -rf experimentalMail.sh.*
echo "RL [Delete duplicates if there are any!]"
echo 
cd /home/
rm -rf temp.rlInstall
mkdir temp.rlInstall
cd temp.rlInstall
echo "RL [Downloading Rainloop]"
wget -qq https://www.rainloop.net/repository/webmail/rainloop-latest.zip
echo 
echo "✓ [Downloaded Rainloop]"
echo 
echo "RL [The installation will now begin!]"
echo 
read -p "RL [Enter the folder name for your domain. (Example: MyDomain.TLD)] " domainName
echo 
while true; do
    read -p "*! [This will remove folders "mail" and "webmail" if they exist inside $domainName. Press Y to delete, N to cancel.] " yn
    case $yn in
        [Yy]* ) echo "RL [Removing]"; break;;
        [Nn]* ) exit;;
        * ) echo "!!! [You didn't answer Y or N!]";;
    esac
done
echo
echo "WARNING [ Your domain directory must be set to /www/wwwroot.]"
cd /www/wwwroot/$domainName
rm -rf webmail
rm -rf mail
echo 
echo "✓ [Removed other webmail]"
echo 
mkdir webmail
cd /home/temp.rlInstall
unzip -qq rainloop-latest.zip
mv * /www/wwwroot/$domainName/webmail
cd /www/wwwroot/$domainName/webmail
rm -rf rainloop-latest.zip
echo "RL [Fixing the RainLoop permissions]"
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
rm -rf /home/temp.rlInstall
echo "✓ [Finished!]"
echo 
echo "Congratulations, RainLoop is accessible on http://$domainName/webmail !"
echo 
echo "The admin section to configure RainLoop to send/recieve is at http://$domainName/webmail/?admin"
echo "Username: admin"
echo "Password: 12345"
echo 
echo "Once you login, change this password to not expose the admin panel to users."
