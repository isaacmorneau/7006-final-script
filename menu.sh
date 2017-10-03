echo "Final Script"

install_apache() {
    ./apache.sh
    local result=$?
#TODO Make use of result
}

install_nfs() {
    echo "Enter the name of the user to setup nfs for: "
    read nfsUser
    ./useradd.sh $nfsUser
    local result=$?
    ./nfs.sh $nfsUser
    result=$?
#TODO Make use of result
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
