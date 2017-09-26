echo "Installing httpd"
dnf install httpd

#Need to do /etc/httpd/conf.d/userdir.conf modification here
#Userdir enabled and stuff like that

echo "Getting username"
read myUser

./useradd.sh $myUser

echo "Logging in as new user"
su $myUser
echo "Creating public_html"
mkdir /home/$myUser/public_html
exit

read myMessage

echo "Adding basic html file"
echo "<p>$myMessage</p>" > /home/$myUser/public_html/index.html

echo "Chmod 777'ing all the myUser folders/files"
chmod 777 /home/$myUser
chmod 777 /home/$myUser/public_html
chmod 777 /home/$myUser/public_html/index.html

#TODO add full userdir.conf string to overwrite with

cp /etc/httpd/conf.d/userdir.conf ~/userdir.conf.bak

#passwdConf = """
#<Directory /home/$myUser>
    #AllowOverride None
    #AuthUserFile /var/www/html/passwords/foobar
    #AuthGroupFile /dev/null
    #AuthName test
    #AuthType Basic
    #<Limit GET>
        #require valid-user
        #order deny,allow
        #deny from all
        #allow from all
    #</Limit>
#</Directory>
#"""

#echo "Appending password block to userdir.conf"
#echo $passwdConf >> /etc/httpd/conf.d/userdir.conf

#Need to comment out default rules that don't require password in userdir.conf

echo "Creating html passwords file"
mkdir /var/www/html/passwords
echo "Chmod 777'ing passwords file"
chmod 777 /var/www/html/passwords
echo "Getting website password"
htpasswd -c /var/www/html/passwords $myUser

echo "Restarting httpd"
systemctl restart httpd

