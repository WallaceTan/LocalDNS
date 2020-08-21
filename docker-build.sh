#!/bin/bash
VERSION=2019.8.20
docker build -f dnscrypt/Dockerfile -t dnscrypt:${VERSION} .
docker build -f dnsmasq/Dockerfile -t dnsmasq:${VERSION} .
docker-compose -f docker-compose.yml up
# Visit http://<docker-host>:5380, authenticate with foo/bar and you should see
# http://foo:bar@localhost:5380
# docker-compose -f docker-compose.yml up
