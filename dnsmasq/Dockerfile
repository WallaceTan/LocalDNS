FROM alpine:3.15
LABEL maintainer="dev@jpillora.com"
# webproc release settings
ENV WEBPROC_VERSION 0.4.0
ENV WEBPROC_URL https://github.com/jpillora/webproc/releases/download/v${WEBPROC_VERSION}/webproc_${WEBPROC_VERSION}_linux_amd64.gz
# configure TimeZone
ENV TZ=Asia/Singapore
# fetch dnsmasq and webproc binary
RUN apk update \
	&& apk add --no-cache dnsmasq tzdata \
	&& apk add --no-cache --virtual .build-deps curl \
	&& curl -sL $WEBPROC_URL | gzip -d - > /usr/local/bin/webproc \
	&& chmod +x /usr/local/bin/webproc \
	&& apk del .build-deps \
	&& cp /usr/share/zoneinfo/$TZ /etc/localtime \
	&& echo $TZ > /etc/timezone \
	&& rm -rf /var/cache/apk/*
# RUN apk add --no-cache dnscrypt-proxy dnscrypt-proxy-openrc
# configure dnsmasq
RUN mkdir -p /etc/default/
COPY etc/default/dnsmasq /etc/default/dnsmasq

RUN mkdir -p /etc/dnsmasq.d/
COPY etc/dnsmasq.d/adservers_add.txt /etc/dnsmasq.d/adservers_add.txt
COPY etc/dnsmasq.d/adservers_remove.txt /etc/dnsmasq.d/adservers_remove.txt
COPY etc/dnsmasq.d/adservers.conf /etc/dnsmasq.d/adservers.conf
COPY etc/dnsmasq.d/dnsmasq.conf /etc/dnsmasq.d/dnsmasq.conf

COPY etc/get_adservers_dnsmasq.sh /etc/get_adservers_dnsmasq.sh
COPY etc/getadservers.sh /etc/getadservers.sh
RUN /etc/getadservers.sh
#run!
#ENTRYPOINT ["webproc","--configuration-file","/etc/dnsmasq.d/dnsmasq.conf","--","dnsmasq","--no-daemon"]
ENTRYPOINT ["webproc","-c","/etc/dnsmasq.d/dnsmasq.conf","-c","/etc/dnsmasq.d/adservers.conf","--","dnsmasq","--no-daemon","--"]
#ENTRYPOINT ["/etc/getadservers.sh", "--", "webproc","--configuration-file","/etc/dnsmasq.d/dnsmasq.conf","--","dnsmasq","--no-daemon","--"]
#ENTRYPOINT ["webproc","--configuration-file","/etc/dnsmasq.d/dnsmasq.conf","--","dnscrypt-proxy","-config","/etc/dnscrypt-proxy/dnscrypt-proxy.toml","--","dnsmasq","--no-daemon","--"]
