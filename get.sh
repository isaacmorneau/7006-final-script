#where we are pulling from
BASE_URL="https://raw.githubusercontent.com/isaacmorneau/7006-final-script/master/"
#get the parts to the script
#file names
USERADD="useradd.sh"
APACHE="apache.sh"
SAMBA="samba.sh"
NFS="nfs.sh"

#grap the files
curl $BASE_URL$USERADD > $USERADD
curl $BASE_URL$APACHE > $APACHE
curl $BASE_URL$SAMBA > $SAMBA
curl $BASE_URL$NFS > $NFS

#now you have all the scripts make them runable
chmod 777 $USERADD $APACHE $SAMBA $NFS

