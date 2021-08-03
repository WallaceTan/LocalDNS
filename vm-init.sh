#!/bin/bash

# Install docker
sudo yum install docker git

# Systemd auto start docker engine
sudo systemctl enable docker
sudo systemctl start docker

# Install docker-compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.3/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

# Clone git local-dns repository
mkdir -p /opt/localdns
cd /opt/localdns
git clone https://bitbucket.ship.gov.sg/projects/DEV/repos/localdns/browse .
git checkout Central-DNS

# Systemd auto start dnsmasq and dnscrypt in docker-compose service
# https://github.com/docker/compose/issues/4266
sudo cp /opt/localdns/etc/systemd/system/central-dns.service /etc/systemd/system/central-dns.service
sudo systemctl enable central-dns
sudo systemctl start central-dns
sudo systemctl status central-dns
