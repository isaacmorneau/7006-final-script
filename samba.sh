#Expected usage:
#$1 = Username
#$2 = Password
#$3 = Workgroup

#backup and overwrite the config
SMB_CONFIG="""
# See smb.conf.example for a more detailed config file or
# read the smb.conf manpage.
# Run 'testparm' to verify the config is correct after
# you modified it.

[global]
	workgroup = $3
	server string = Samba Server
	security = user

	passdb backend = tdbsam

	printing = cups
	printcap name = cups
	load printers = yes
	cups options = raw

[NFSHARE]
	comments = Win32 Share
	path = /home/$1
	public = yes
	writable = yes
	printable = no

[homes]
	comment = Home Directories
	valid users = %S, %D%w%S
	browseable = No
	read only = No
	inherit acls = Yes

[printers]
	comment = All Printers
	path = /var/tmp
	printable = Yes
	create mask = 0600
	browseable = No

[print$]
	comment = Printer Drivers
	path = /var/lib/samba/drivers
	write list = root
	create mask = 0664
	directory mask = 0775
"""

dnf install -y samba

cp /etc/samba/smb.conf ~/smb.conf.bak
echo "$SMB_CONFIG" > /etc/samba/smb.conf
#add the user to samba
SMB_USER="""$2
$2
"""
echo "$SMB_USER" | smbpasswd -a $1
#restart the services
systemctl restart smb
