#!/usr/bin/env sh


if [ -z "$LOGIN" ]; then
    echo "ERR: LOGIN name is mandatory. Terminating.." && exit 1
else
    sed -i -e "s/^login=##YOUR_LOGIN##/login=$LOGIN/" /etc/ddclient/ddclient.conf
fi

if [ -z "$PASS" ]; then
    echo "ERR: PASS is mandatory. Terminating.." && exit 1
else
    sed -i -e "s/^password=##YOUR_PASS##/password=$PASS/" /etc/ddclient/ddclient.conf
fi

if [ -z "$HOST" ]; then
    echo "ERR: HOST is mandatory. Terminating.." && exit 1
else
    sed -i -e "s/^##YOUR_HOSTNAME##/$(HOST)/" /etc/ddclient/ddclient.conf
fi

if [ -z "$EMAIL" ]; then
    echo "INFO: No email specified, no emails will be sent."
else
    sed -i -e "s/^mail-failure=##YOUR_EMAIL##/mail-failure=$EMAIL/" /etc/ddclient/ddclient.conf
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

OUT=$(ddclient -daemon=0 -noquiet); R=$?
if [ "$R" -ne "0" ]; then
    # exit 1
    echo "Oops"
fi
echo_time $OUT

er_count=0
while :
do
    OUT=$(ddclient -daemon=0 -noquiet); R=$?
    if [ "$R" -ne "0" ]; then
        echo_time "ERR: ddclient has failed. Inspect the output for additional info."
        er_count=`expr $er_count + 1`
    else
        er_count=0
    fi

    if [ ! -z "$OUT" ]; then    
        echo_time $OUT
    fi;

    if [ $er_count -ge 10 ]; then
        exit 1
    fi

    sleep $(DAEMON) || exit 1

done

exit 0