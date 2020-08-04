#!/bin/sh
if [ "$EUID" -ne 0 ]
  then echo "Please run this script as root. You can type 'sudo -i' to become root."
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
echo "This installer is for aaPanel, or BT-Panel."
echo 
read -p "Enter your domain name. (This must be in your panel before!) Example: yourdomain.tld " domainName
echo 
read -p "I will replace the existing webmail/mail folder in the domain. Please close the program if you do not want this to happen. If you are sure, press ENTER. If not, press Control + C." input
cd /www/wwwroot/$domainName
rm -rf webmail
rm -rf mail
mkdir webmail
cd /home/installers
unzip -qq rainloop-latest.zip
mv * /www/wwwroot/$domainName/webmail
cd /www/wwwroot/$domainName/webmail
rm -rf rainloop-latest.zip
chmod -R 0666 data
chmod -R 777 rainloop
chmod -R 0777 rainloop/v/
chmod -R 0666 index.php
cd /www/wwwroot/$domainName/webmail/data
echo "Deny from all" >> .htaccess
echo 
echo Congratulations, RainLoop is installed on http://$domainName/?admin!
echo Finish installation at: aaPanel, http://$domainName/webmail, and http://$domainName/webmail/?admin
