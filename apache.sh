echo "Installing httpd"
dnf -y install httpd

./useradd.sh $1

passenter="""
$2
$2
"""

echo "Creating public_html"
mkdir /home/$1/public_html

echo "Adding basic html file"
echo "<p>$3</p>" > /home/$1/public_html/index.html

echo "Chmod 777'ing all the myUser folders/files"
chmod 777 /home/$1
chmod 777 /home/$1/public_html
chmod 777 /home/$1/public_html/index.html

userdirconf="""
# Settings for user home directories
#
# Required module: mod_authz_core, mod_authz_host, mod_userdir

#
# UserDir: The name of the directory that is appended onto a user's home
# directory if a ~user request is received.  Note that you must also set
# the default access control for these directories, as in the example below.
#
<IfModule mod_userdir.c>

    UserDir enabled

    UserDir public_html

</IfModule>

#
# Control access to UserDir directories.  The following is an example
# for a site where these directories are restricted to read-only.
#
#<Directory "/home/*/public_html">
    #AllowOverride FileInfo AuthConfig Limit Indexes
    #Options MultiViews Indexes SymLinksIfOwnerMatch IncludesNoExec
    #Require method GET POST OPTIONS
#</Directory>

<Directory /home/$1>
    AllowOverride None
    #httpd-passwords is a temp name for password file
    AuthUserFile /var/www/html/passwords/httpd-passwords
    AuthGroupFile /dev/null
    AuthName test
    AuthType Basic
    <Limit GET>
        require valid-user
        order deny,allow
        deny from all
        allow from all
    </Limit>
</Directory>
"""

echo "Backing up userdir.conf to home directory"
cp /etc/httpd/conf.d/userdir.conf ~/userdir.conf.bak

echo "Writing config to /etc/httpd/conf.d/userdir.conf"
echo "$userdirconf" > /etc/httpd/conf.d/userdir.conf

echo "Creating html passwords file"
mkdir /var/www/html/passwords
echo "Chmod 777'ing passwords file"
chmod 777 /var/www/html/passwords
echo "Getting website password"
echo "$passenter" | htpasswd -c /var/www/html/passwords/httpd-passwords $1

echo "Restarting httpd"
systemctl restart httpd

