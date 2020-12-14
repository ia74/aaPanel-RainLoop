# aaPanel-RainLoop V3
rm -rf v3.*
clear
echo "ooooooo____________oo__________oo________________________________
oo____oo___ooooo_______oo_ooo__oo_______ooooo___ooooo_____ooooo__
oo____oo__oo___oo__oo__ooo___o_oo______oo___oo_oo___oo____o___oo_
ooooooo___oo___oo__oo__oo____o_oo______oo___oo_oo___oo___oo___oo_
oo____oo__oo___oo__oo__oo____o_oo______oo___oo_oo___oo___oo___oo_
oo_____oo__oooo_o_oooo_oo____o_ooooooo__ooooo___ooooo__o_ooooo___
_______________________________________________________oooo______"
sleep 1
clear
echo "* [ Welcome to the aaPanel RainLoop installer! ]"
echo
echo "* [ Downloading RainLoop ]"
echo
mkdir /tmp/rainloop
cd /tmp/rainloop
wget --quiet https://www.rainloop.net/repository/webmail/rainloop-latest.zip
unzip -qq rainloop-latest.zip
rm -rf rainloop-latest.zip
echo "* [ Downloaded RainLoop ]"
read -p "* [ Enter your TLD. Example: domain.tld ] " domainName
echo
read -p "* [ Enter your web root folder. If you don't have one, type /www/wwwroot ] " webFolder
echo
echo "* [ TLD: $domainName ]\n * [ Web Root: $webFolder ]"
echo
read -p "Does this look right? " yn
case $yn in
        [Yy]* ) echo "* [ Starting installation! ]";;
        [Nn]* ) echo "! [ Please restart the program. ]"; exit;;
        * ) echo "Please answer yes or no!";;
    esac
cd $webFolder/$domainName
mv /tmp/rainloop/* .
echo
read -p "! [ This will delete any folder with the name 'rainloop', 'mail', or 'webmail'! Are you sure? " yn
case $yn in
        [Yy]* ) echo "* [ Continuing.. ]";;
        [Nn]* ) echo "! [ Please restart the program. ]"; exit;;
        * ) echo "Please answer yes or no!";;
    esac
echo
