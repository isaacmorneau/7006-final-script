#Expected usage
#$1 Only access from that ip

TELNET_CONFIG="""
service telnet
{
    socket_type = stream
    wait = no
    user = root
    server = /usr/sbin/in.telnetd
    log_on_failure += USERID
    disable = no
    access_times = 08:00-21:00
    only_from = $1
}
"""

dnf install -y xinetd telnet telnet-server

echo "$TELNET_CONFIG" > /etc/xinetd.d/telnet

systemctl restart xinetd
