#!/usr/bin/env sh


if [ -z "$LOGIN" ]; then
    echo "ERR: LOGIN name is mandatory. Terminating.."
else
    sed -i -e "s/^login=##YOUR_LOGIN##/login=$(LOGIN)/" /etc/ddclient/ddclient.conf
fi

if [ -z "$PASS" ]; then
    echo "ERR: PASS is mandatory. Terminating.."
else
    sed -i -e "s/^password=##YOUR_PASS##/password=$(PASS)/" /etc/ddclient/ddclient.conf
fi

if [ -z "$HOST" ]; then
    echo "ERR: HOST is mandatory. Terminating.."
else
    sed -i -e "s/^##YOUR_HOSTNAME##/$(HOST)/" /etc/ddclient/ddclient.conf
fi

if [ -z "$EMAIL" ]; then
    echo "INFO: No email specified, no emails will be sent."
else
    sed -i -e "s/^mail-failure=##YOUR_EMAIL##/mail-failure=$(EMAIL)/" /etc/ddclient/ddclient.conf
fi

if [ -z "$SSL" ]; then
    echo "INFO: Using plain unsecure http, consider specifying SSL for secure socket layers."
    sed -i -e "s/^ssl=yes$//" /etc/ddclient/ddclient.conf
fi

if [ -z "$DAEMON"]; then
    DAEMON=300
fi
echo "INFO: Running IP update/ check every $(DAEMON) seconds.."

echo_time() {
     date +"[ %Y-%m-%d %H:%M Z ] $(printf "%s " "$@" | sed 's/%/%%/g')"
}

while :
do
    OUT=$(ddclient -daemon=0 -noquiet)
    if [ ! -z "$OUT" ]; then    
        echo_time $OUT
    fi;
    sleep $(DAEMON)
done
