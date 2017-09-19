#where we are pulling from
BASE_URL="https://raw.githubusercontent.com/isaacmorneau/7006-final-script/master/"
#get the parts to the script
#file names
MAIN="menu.sh"
USERADD="useradd.sh"
#APACHE="apache.sh"

#grap the files
curl $BASE_URL$MAIN > $MAIN
curl $BASE_URL$USERADD > $USERADD
#curl $BASE_URL$APACHE

#now you have all the scripts, run the main thing
chmod 777 $MAIN
chmod 777 $USERADD
./$MAIN
