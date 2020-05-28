# Docker generic-seeder   
[![Docker Automated build](https://img.shields.io/docker/automated/buzzkillb/generic-seeder.svg?style=for-the-badge&logo=docker)](https://hub.docker.com/r/buzzkillb/generic-seeder/)
[![Docker Pulls](https://img.shields.io/docker/pulls/buzzkillb/generic-seeder.svg?style=for-the-badge&logo=docker)](https://hub.docker.com/r/buzzkillb/generic-seeder/)
[![Docker Stars](https://img.shields.io/docker/stars/buzzkillb/generic-seeder.svg?style=for-the-badge&logo=docker)](https://hub.docker.com/r/buzzkillb/generic-seeder/)

[![Alpine Version](https://img.shields.io/badge/Alpine%20version-v3.11-green.svg?style=for-the-badge)](https://alpinelinux.org/)  
Docker based on https://github.com/team-exor/generic-seeder a tweaked Sipa Bitcoin Seeder  
## setting.conf [Denarius]  
```
protocol_version="33900"
init_proto_version="33900"
min_peer_proto_version="33900"
caddr_time_version="33900"
pchMessageStart_0 = "0xfa"
pchMessageStart_1 = "0xf2"
pchMessageStart_2 = "0xef"
pchMessageStart_3 = "0xb4"
wallet_port="33369"
explorer_url="https://chainz.cryptoid.info/d/api.dws?q=getblockcount"
second_explorer_url=""
explorer_requery_seconds="60"
block_count="3272984"
seed_1="dnsseed.denarius.guide"
seed_2="dnsseed.denarius.pro"
seed_3="mseed.denarius.guide"
seed_4="bseed.denarius.guide"
seed_5="seed.denarius.host"
seed_6=""
seed_7=""
seed_8=""
seed_9=""
seed_10=""
cf_domain=""
cf_domain_prefix=""
cf_username="email@domain.com"
cf_api_key=""
cf_seed_dump="dnsseed.dump"
```
## docker-compose.yml  
(I placed settings.conf in ~/docker/generic-seeder/settings.conf)  
```
version: '3'
services:
  generic-seeder:
    image: buzzkillb/generic-seeder:armv7
    volumes:
      - ~/docker/generic-seeder/settings.conf:/settings.conf
    ports:
      - "5353:5353"
    command: -h dnsseed.denarius.pro -n vps.denarius.pro -m buzz.denarius.io -p 5353 -o 127.0.0.1:9050
```
### port 53  
Port 53 if root, or port 5353 if not root, both ports are exposed in the docker container itself. To forward 5353 to 53 if not root.  
```
sudo iptables -t nat -A PREROUTING -p udp --dport 53 -j REDIRECT --to-port 5353
```
### Local Build  
```
docker build --tag seeder:1.0 .
```
