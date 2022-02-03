FROM alpine:3.15
LABEL maintainer="wallacetan@gmail.com"

# Install dnscrypt-proxy
RUN apk update \
	&& apk --no-cache add dnscrypt-proxy dnscrypt-proxy-openrc

COPY etc/dnscrypt-proxy.toml /etc/dnscrypt-proxy.toml

#dnscrypt-proxy -config /etc/dnscrypt-proxy.toml
ENTRYPOINT ["dnscrypt-proxy","-config","/etc/dnscrypt-proxy.toml"]
#ENTRYPOINT ["tail", "-f", "/dev/null"]
