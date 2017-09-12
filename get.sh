#where we are pulling from
BASE_URL="https://raw.github.com/isaacmorneau/7006-final-script/"
#get the parts to the script
#file names
$MAIN="menu.sh"
$USERADD="useradd.sh"
#$APACHE="apache.sh"

#grap the files
wget $BASE_URL$MAIN
wget $BASE_URL$USERADD
#wget $BASE_URL$APACHE

#now you have all the scripts, run the main thing
chmod 777 $MAIN
chmod 777 $USERADD
$MAIN
