#!/bin/bash
VERSION=2021.8.29
docker build -f dnscrypt/Dockerfile -t dnscrypt:${VERSION} .
docker build -f dnsmasq/Dockerfile -t dnsmasq:${VERSION} .
docker compose -f docker-compose.yml up -d
#docker-compose -f docker-compose.yml up
# Visit http://<docker-host>:5380, authenticate with foo/bar and you should see
# http://foo:bar@localhost:5380
# docker compose -f ~/Projects/Docker/localdns/docker-compose.yml ps
# docker compose -f docker-compose.yml up
# docker compose -f docker-compose.yml up -d

# sudo networksetup -listallnetworkservices
# sudo networksetup -getdnsservers Wi-Fi
# sudo networksetup -setdnsservers Wi-Fi empty
# sudo networksetup -setdnsservers Wi-Fi 127.0.0.1
# sudo networksetup -setdnsservers Wi-Fi 1.1.1.1