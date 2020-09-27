#!/bin/sh
while true; do
    read -p "*! [This will remove domains "mail" and "webmail" if they exist. Press Y to delete, N to cancel.] " yn
    case $yn in
        [Yy]* ) echo "* [Installing]"; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done
echo
read -p "* [If you have a custom directory for websites set, please input! If not, press enter.] " custDirWeb
if [ -z "$custDirWeb" ]
then
      export custDirWeb=/www/wwwroot
      echo "* [Defaulted to $custDirWeb]"
else
      echo "* [Set Directory to $custDirWeb]"
fi
cd $custDirWeb/$domainName
rm -rf webmail
rm -rf mail
echo 
echo "✓ [Removed other webmail]"
echo 
cd /home/installers
unzip -qq rainloop-latest.zip
mv * $custDirWeb/$domainName/
cd $custDirWeb/$domainName/
rm -rf rainloop-latest.zip
echo "* [Fixing Permissions]"
chmod -R 755 $custDirWeb/$domainName/
chmod -R 777 data
chmod -R 777 rainloop
chmod -R 666 data/EMPTY
chmod -R 644 data/VERSION
chmod -R 777 rainloop/*
chmod -R 666 index.php
echo 
echo "✓ [Fixed Permissions]"
echo 
cd $custDirWeb/$domainName/data
echo "Deny from all" >> .htaccess
echo "* [Finishing up]"
echo 
echo "✓ [Finished!]"
echo 
echo "Congratulations, RainLoop is accessible on http://$domainName/ !"
echo 
echo "The admin section to configure RainLoop to send/recieve is at http://$domainName/?admin"
echo "Username: admin"
echo "Password: 12345"
echo 
echo "Once you login, change this password to not expose the admin panel to users."
