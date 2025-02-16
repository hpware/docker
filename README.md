# Docker Compose Files & Shell scripts for docker
Here is most of my docker compose files, most of it is used in my actual server. Why? Because migrating from an old server to a new one is a huge pain, with docker compose (or podman) its will be easier for me to reinstall my OS or server (and bonus point, I can move to whatever distro I liked.).

## Start Off
For Ubuntu/Debian users:
```bash
sudo apt update
sudo apt install curl wget docker.io docker-compose docker-compose-plugin -y
```
## Configs
### Home Server
Install: [index.sh](home-server/index.sh)

Display Ports: [ports.sh](home-server/ports.sh)