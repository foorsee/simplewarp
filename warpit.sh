#!/bin/bash#

# foorsee
# *Tel-Aviv impressed*

# root
if [ "$EUID" -ne 0 ]; then
  echo "root only"
  exit 1
fi

echo "Detecting OS"

OS_ID=$(lsb_release -is | tr '[:upper:]' '[:lower:]')
VERSION_CODENAME=$(lsb_release -cs)

if [[ "$OS_ID" != "ubuntu" && "$OS_ID" != "debian" ]]; then
    echo "Error: This script only works on Ubuntu or Debian."
    exit 1
fi

echo "OS: $OS_ID $VERSION_CODENAME"

apt-get update && apt-get install -y curl gpg lsb-release

mkdir -p /usr/share/keyrings
curl -fsSL https://pkg.cloudflareclient.com/pubkey.gpg | gpg --yes --dearmor -o /usr/share/keyrings/cloudflare-warp-archive-keyring.gpg

echo "deb [signed-by=/usr/share/keyrings/cloudflare-warp-archive-keyring.gpg] https://pkg.cloudflareclient.com/ $VERSION_CODENAME main" | tee /etc/apt/sources.list.d/cloudflare-client.list

echo "suka go WARPit!"
apt-get update && apt-get install -y cloudflare-warp

echo "**************************************"
read -p "Enter the proxy port you want to use. it will be used in outbound section! : " PORT

echo "y" | warp-cli registration new

echo "Setting mode to proxy..."
warp-cli mode proxy

echo "Proxy port is $PORT..."
warp-cli proxy port "$PORT"

echo "one final warp"
warp-cli connect

echo "**************************************"
echo "We are WARPing at: $PORT"
echo "You can verify with: curl -x socks5h://localhost:$PORT https://www.cloudflare.com/cdn-cgi/trace"