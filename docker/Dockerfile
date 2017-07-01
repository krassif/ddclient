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
	mkdir /var/cache/ddclient

# setting up the service
ADD ../ddclient /usr/local/bin/ddclient
ADD ddclient-loop.sh /usr/local/bin/ddclient-loop
ADD docker-etc_ddclient.conf /etc/ddclient/ddclient.conf

# CMD [ "ddclient-loop" ]