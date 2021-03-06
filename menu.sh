echo "Final Script"

ISF=$'\n'

install_apache() {
    echo "Enter the apache username"
    read apacheUser

    echo "Enter the apache password"
    read apachePass

    echo "Enter the apache web message"
    read apacheMesg

    ./apache.sh $apacheUser $apachePass "$apacheMesg"
    local result=$?
if [[ result -eq 0 ]]; then
    echo "Apache.sh exited successfully"
else
    echo "Apache.sh exited with error $result"
fi
}

install_nfs() {
    echo "Enter the name of the user to setup nfs for: "
    read nfsUser

    ./nfs.sh $nfsUser
    result=$?
if [[ result -eq 0 ]]; then
    echo "nfs.sh exited successfully"
else
    echo "nfs.sh exited with error $result"
fi
}

install_samba() {
    echo "Enter the name of the user to setup samba for: "
    read sambaUser

    echo "Enter the password for samba: "
    read sambaPass

    echo "Enter the workgroup for samba: "
    read sambaGroup
    ./samba.sh $sambaUser $sambaPass $sambaGroup

    local result=$?
if [[ result -eq 0 ]]; then
    echo "samba.sh exited successfully"
else
    echo "samba.sh exited with error $result"
fi
}

install_xinetd() {
    echo "Enter the ip that is allowed to connect through telnet: "
    read telnetIP

    ./xinetd.sh $telnetIP
    local result=$?
if [[ result -eq 0 ]]; then
    echo "xinetd.sh exited successfully"
else
    echo "xinetd.sh exited with error $result"
fi
}

if [ -n "$1" ]; then
    echo "Skip Prompt Enabled"
    install_apache
    install_nfs
    install_samba
else
    while true; do
        read -p "Install apache? [y/n]: " yn
        case $yn in
            [Yy]* ) install_apache; break ;;
            [Nn]* ) break;;
        esac
    done

    while true; do
        read -p "Install nfs? [y/n]: " yn
        case $yn in
            [Yy]* ) install_nfs; break ;;
            [Nn]* ) break;;
        esac
    done

    while true; do
        read -p "Install samba? [y/n]: " yn
        case $yn in
            [Yy]* ) install_samba; break ;;
            [Nn]* ) break;;
        esac
    done

    while true; do
        read -p "Install xinetd? [y/n]: " yn
        case $yn in
            [Yy]* ) install_xinetd; break ;;
            [Nn]* ) break;;
        esac
    done
fi
