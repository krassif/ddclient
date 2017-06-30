FROM armhf/alpine:3.5

# setting up the service
ADD ddclient /usr/sbin/ddclient
ADD sample-etc_rc.d_init.d_ddclient.alpine /etc/init.d/ddclient

RUN rc-update add ddclient && \
	apk add perl && \
	apk add perl-io-socket-ssl

# rc-service ddclient start
