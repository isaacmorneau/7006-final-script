echo "Final Script"

install_apache() {
    ./apache.sh
    local result=$?
#TODO Make use of result
if [[ -n result ]]; then
    echo "Apache.sh exited successfully"
else
    echo "Apache.sh exited with error $result"
fi
}

install_nfs() {
    echo "Enter the name of the user to setup nfs for: "
    read nfsUser
    ./useradd.sh $nfsUser
    local result=$?

if [[ -n result ]]; then
    echo "useradd.sh exited successfully"
else
    echo "useradd.sh exited with error $result"
fi
    ./nfs.sh $nfsUser
    result=$?
#TODO Make use of result
if [[ -n result ]]; then
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
#TODO Make use of result
if [[ -n result ]]; then
    echo "samba.sh exited successfully"
else
    echo "samba.sh exited with error $result"
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
fi
