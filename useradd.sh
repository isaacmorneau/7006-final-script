#Expected usage:
#$1 = Username

#echo "removing:"$1
#userdel $1
#echo "cleaning up home dir"
#rm -rf /home/$1
echo "adding user:"$1
useradd $1 -m
