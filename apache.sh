echo "Installing httpd"
dnf install httpd

echo "Getting username"
echo "Enter the name of the apache user"
read myUser

./useradd.sh $myUser

echo "Creating public_html"
mkdir /home/$myUser/public_html

echo "Enter the default message to be shown on the web page"
read myMessage

echo "Adding basic html file"
echo "<p>$myMessage</p>" > /home/$myUser/public_html/index.html

echo "Chmod 777'ing all the myUser folders/files"
chmod 777 /home/$myUser
chmod 777 /home/$myUser/public_html
chmod 777 /home/$myUser/public_html/index.html

userdirconf = """
# Settings for user home directories
#
# Required module: mod_authz_core, mod_authz_host, mod_userdir

#
# UserDir: The name of the directory that is appended onto a user's home
# directory if a ~user request is received.  Note that you must also set
# the default access control for these directories, as in the example below.
#
UserDir public_html

#
# Control access to UserDir directories.  The following is an example
# for a site where these directories are restricted to read-only.
#
#<Directory "/home/*/public_html">
    #AllowOverride FileInfo AuthConfig Limit Indexes
    #Options MultiViews Indexes SymLinksIfOwnerMatch IncludesNoExec
    #Require method GET POST OPTIONS
#</Directory>

<Directory /home/$myUser>
    AllowOverride None
    AuthUserFile /var/www/html/passwords/httpd-passwords #httpd-passwords is a temp name for password file
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
cat $userdirconf > /etc/httpd/conf.d/userdir.conf

echo "Creating html passwords file"
mkdir /var/www/html/passwords
echo "Chmod 777'ing passwords file"
chmod 777 /var/www/html/passwords
echo "Getting website password"
htpasswd -c /var/www/html/passwords/httpd-passwords $myUser

echo "Restarting httpd"
systemctl restart httpd

