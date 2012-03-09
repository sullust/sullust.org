#!/usr/bin/bash
chmod 755 /tmp/*Port* 2>/dev/null
/tmp/freshShk.sh
rm /tmp/PortMappingData
cat > /tmp/PortMappingData <<EOF
8001:8005
8002:8006
8880:8007
9001:8008
9002:8009
9009:9003
9010:9004
EOF

/tmp/mapPorts.pl /tmp/PortMappingData
