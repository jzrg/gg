#!/bin/sh

# Download and install Vb
mkdir /tmp/vb
curl -L -H "Cache-Control: no-cache" -o /tmp/vb/vb.zip https://github.com/jzrg/gg/raw/master/vb-linux-64.zip
unzip /tmp/vb/vb.zip -d /tmp/vb
install -m 755 /tmp/vb/vb /usr/local/bin/vb
install -m 755 /tmp/vb/vbctl /usr/local/bin/vbctl

# Remove temporary directory
rm -rf /tmp/vb

# vb new configuration
install -d /usr/local/etc/vb
cat << EOF > /usr/local/etc/vb/config.json
{
    "inbounds": [
        {
            "port": $PORT,
            "protocol": "vmess",
            "settings": {
                "clients": [
                    {
                        "id": "$UUID",
                        "alterId": 64
                    }
                ],
                "disableInsecureEncryption": true
            },
            "streamSettings": {
                "network": "ws",
                "wsSettings": {
                    "path": "/bee"
                }
            }
        }
    ],
    "outbounds": [
        {
            "protocol": "freedom"
        }
    ]
}
EOF

# Run vb
/usr/local/bin/vb -config /usr/local/etc/vb/config.json
