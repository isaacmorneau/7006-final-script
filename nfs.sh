#Expected usage:
#$1 = Username

./useradd.sh $1

while true; do
    read -p "add no root squash fs? [y/n]:" yn
    case $yn in
        [Yy]* ) SQUASH=",no_root_squash"; break ;;
        [Nn]* ) break;;
    esac
done

#backup and overwrite the config
NFS_CONFIG="""
/home/$1 192.168.0.0/255.255.255.0 (rw$SQUASH)
"""
cp /etc/exports ~/exports.bak
echo $NFS_CONFIG > /etc/exports
#restart the services
echo "Exporting the file system"
exportfs -v
systemctl restart nfs

