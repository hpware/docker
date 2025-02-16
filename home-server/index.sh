#!/bin/bash

# Go to Folder
cd /
mkdir docker
cd docker


# Portainer Dashboard

mkdir /docker/portainer/data
docker run -d -p 58000:8000 -p 59443:9443 -p 59000:9000 --name portainer --restart=always -v /var/run/docker.sock:/var/run/docker.sock -v /docker/portainer/data:/data portainer/portainer-ce:2.21.5

# Nginx Proxy Manager

mkdir /docker/nginxproxymanager
cd /docker/nginxproxymanager
curl --output docker-compose.yml https://cdn.jsdelivr.net/gh/hpware/docker@main/home-server/nginxproxymanager.yml
docker-compose up -d
cd /docker/

# n8n
mkdir /docker/n8n/data
docker run -it -d --restart=unless-stopped --name n8n -p 55678:5678 -v /docker/n8n/data:/home/node/.n8n -e WEBHOOK_URL=https://127.0.0.1 -e N8N_SECURE_COOKIE=false docker.n8n.io/n8nio/n8n

# Home assistant
mkdir /docker/homeassistant
docker run -d  --name homeassistant --privileged --restart=unless-stopped -e TZ=Asia/Taipei -v /docker/homeassistant/config:/config -v /run/dbus:/run/dbus:ro --network=host ghcr.io/home-assistant/home-assistant:stable

# Update Kuma
mkdir /docker/uptimekuma/data
docker run -d --restart=unless-stopped -p 53001:3001 -v /docker/uptimekuma/data/app/data --name uptimekuma louislam/uptime-kuma:latest

# MySQL
docker run --restart=unless-stopped -it --name mysql-default -e MYSQL_ROOT_PASSWORD=GetABetterPassWord10923@ -p 3306:3306 -d mysql:latest

# Minecraft
docker run --restart=unless-stopped -d --name mcserver-default -e MEMORYSIZE='1G' -v /docker/mcserver/data:/data:rw -p 25565:25565 -i marctv/minecraft-papermc-server:latest

# KMS Server
docker run -d -p 1688:1688 --restart=unless-stoped --name vlmcsd mikolatero/vlmcsd

# File Browser
docker run -v /:/srv -v /docker/filebrowser/filebrowser.db:/database.db -v /docker/filebrowser/.filebrowser.json:/.filebrowser.json -u $(id -u):$(id -g) -p 56684:80 filebrowser/filebrowser

# AdGuard Home
mkdir /docker/adguardhome
docker run --name adguardhome --restart unless-stopped -v /docker/adguardhome/work:/opt/adguardhome/work -v /docker/adguardhome/conf:/opt/adguardhome/conf -p 53:53/tcp -p 53:53/udp -p 67:67/udp -p 68:68/udp -p 82:80/tcp -p 2443:443/tcp -p 443:443/udp -p 53000:3000/tcp -p 853:853/tcp -p 784:784/udp -p 853:853/udp -p 8853:8853/udp -p 5443:5443/tcp -p 5443:5443/udp -d adguard/adguardhome

# List Ports
curl -fsSL https://cdn.jsdelivr.net/gh/hpware/docker@main/home-server/ports.sh | bash

# Tell the user to run ports.sh to display the ports
touch ports.sh
curl -fsSL https://cdn.jsdelivr.net/gh/hpware/docker@main/home-server/ports.sh | cat >> ports.sh
echo Run ports.sh to know what port is what, You can 'bash ports.sh' to do so.
