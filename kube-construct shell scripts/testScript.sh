while true; do
    read -p "Do you wish to install this program?" yn
    case $yn in
        [Yy]* ) ins="install"; break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
done

if [ $ins = "install" ]
then
	echo "installl"
fi
