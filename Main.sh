while true; do
    read -p "* [Welcome to the aaPanel-Installers Main Script" yn
    case $yn in
        [1]* ) wget;;
        [2]* ) wget ;;
        * ) echo "Please select an option!";;
    esac
done
