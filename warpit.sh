#!/bin/bash

clear

echo "foorsee"
echo "*Tel-Aviv impressed*"

sleep 3

if [ "$EUID" -ne 0 ]; then
  echo "root only"
  exit 1
fi

echo "Detecting OS"
OS_ID=$(lsb_release -is | tr '[:upper:]' '[:lower:]')
VERSION_CODENAME=$(lsb_release -cs)

if [[ "$OS_ID" != "ubuntu" && "$OS_ID" != "debian" ]]; then
  echo "This script only works on Ubuntu or Debian!"
  exit 1
fi

echo "OS: $OS_ID $VERSION_CODENAME"

apt-get update && apt-get install -y curl gpg lsb-release

mkdir -p /usr/share/keyrings

curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | gpg --yes --dearmor -o /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $VERSION_CODENAME main" | tee /etc/apt/sources.list.d/cloudflare-client.list

apt-get update && apt-get install -y cloudflare-warp

echo "**************************************"
read -p "enter the WARP port: " PORT < /dev/tty

echo "y" | warp-cli registration new

echo "proxy"
warp-cli mode proxy

echo "proxy port: $PORT"
warp-cli proxy port "$PORT"

echo "WARPIIING"
warp-cli connect

echo "**************************************"
echo "WARPing at: $PORT"
echo "Tesling:"
echo "curl -x socks5h://localhost:$PORT https://www.cloudflare.com/cdn-cgi/trace"
