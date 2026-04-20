<h1 align="center">
  <a href="https://t.me/LarpVPN">LarpVPN</a>
</h1>

Usage
```bash
curl -sSL https://raw.githubusercontent.com/foorsee/simplewarp/refs/heads/main/warpit.sh | sudo bash
```

<h3>Add to outbounds section:</h3>

```json
{
  "tag": "warp",
  "protocol": "socks",
  "settings": {
    "servers": [
      {
        "address": "127.0.0.1",
        "port": $WARP_PORT
      }
    ]
  }
},
```
<h3>Add to routing:</h3>
you can add other domains here if you need to!

```json
{
  "type": "field",
  "domain": [
    "geosite:google",
    "domain:gemini.google.com",
    "domain:bard.google.com",
    "domain:aistudio.google.com",
    "geosite:google-deepmind",
    "domain:speedtest.net",
    "domain:anthropic.com",
    "domain:claude.ai",
    "domain:intercomcdn.com",
    "domain:clau.de",
    "domain:claude.com",
    "domain:claudemcpclient.com",
    "domain:claudeusercontent.com",
    "geosite:anthropic"
  ],
  "outboundTag": "warp"
},
```
