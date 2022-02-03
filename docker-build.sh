#!/bin/bash
VERSION=2022.02.03
docker build --no-cache -f dnscrypt/Dockerfile -t dnscrypt:${VERSION} .
docker build --no-cache -f dnsmasq/Dockerfile -t dnsmasq:${VERSION} .
docker compose -f docker-compose.yml up -d
#docker-compose -f docker-compose.yml up
# Visit http://<docker-host>:5380, authenticate with foo/bar and you should see
# http://foo:bar@localhost:5380

# docker compose -f ~/Projects/Docker/localdns/docker-compose.yml ps
# docker compose ps
# docker compose up -d
# docker compose logs dnsmasq
# docker compose -f docker-compose.yml up
# docker compose -f docker-compose.yml up -d
# docker compose -f docker-compose.yml down
# docker compose -f ~/Projects/Docker/localdns/docker-compose.yml logs dnsmasq -f

# sudo networksetup -listallnetworkservices
# sudo networksetup -getdnsservers Wi-Fi
# sudo networksetup -setdnsservers Wi-Fi empty
# sudo networksetup -setdnsservers Wi-Fi 127.0.0.1
# sudo networksetup -setdnsservers Wi-Fi 1.1.1.1

#https://celeritascdn.com/prod/redirect.html?lu=https%3A%2F%2Fc.lazada.sg%2Ft%2Fc.bFaFjE%3Fsub_id1%3D1221179-Desktop-ADC
# dig celeritascdn.com
# dig 474F21Nov75