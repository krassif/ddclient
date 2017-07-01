FROM armhf/alpine:3.5

# add prerequisites
RUN apk update && \
	apk add --no-cache perl && \
	apk add --no-cache make && \
	apk add --no-cache perl-io-socket-ssl && \
	apk add --no-cache perl-netaddr-ip && \
	PERL_MM_USE_DEFAULT=1 cpan -i Data::Validate::IP && \
	apk del make

# add folders related to the config / service
RUN mkdir /etc/ddclient && \
	mkdir /var/cache/ddclient && \
	mkdir /var/log/ddclient

# setting up the service
ADD ddclient /usr/sbin/ddclient
ADD docker/ddclient-loop.sh /usr/local/bin/ddclient-loop
ADD docker/docker-etc_ddclient.conf /etc/ddclient/ddclient.conf

RUN chmod 600 /etc/ddclient/ddclient.conf

CMD [ "/bin/sh", "-c", "ddclient-loop > /var/log/ddclient/server.log 2>&1" ]