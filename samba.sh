#backup and overwrite the config
SMB_CONFIG="""
@TODO add config here
"""
cp /etc/samba/smb.conf ~/smb.conf.bak
echo $SMB_CONFIG > /etc/samba/smb.conf
#add the user to samba
SMB_USER="""
$2
$2
"""
echo $SMB_USER | smbpasswd -a $1
#restart the services
systemctl restart smb
