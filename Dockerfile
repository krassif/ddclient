FROM armhf/alpine:3.5

# add prerequisites
RUN apk update && \
	apk add --no-cache perl && \
	apk add --no-cache make git perl-dev && \
	apk add --no-cache perl-io-socket-ssl && \
	apk add --no-cache perl-netaddr-ip && \
	PERL_MM_USE_DEFAULT=1 cpan -i Data::Validate::IP

# add folders related to the config / service
RUN mkdir /etc/ddclient && \
	mkdir /var/cache/ddclient

# setting up the service
ADD ddclient /usr/sbin/ddclient
ADD sample-etc_rc.d_init.d_ddclient.alpine /etc/init.d/ddclient
ADD docker-etc_ddclient.conf /etc/ddclient/ddclient.conf

# rc-update add ddclient
# rc-service ddclient start
