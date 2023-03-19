#!/bin/bash -e

set -eou pipefail

cat <<EOF | tee /etc/sysctl.d/10-ipv6-disable.conf
net.ipv6.conf.all.disable_ipv6 = 1
net.ipv6.conf.default.disable_ipv6 = 1
EOF

sysctl -w net.ipv6.conf.all.disable_ipv6=1
sysctl -w net.ipv6.conf.default.disable_ipv6=1
sysctl -w net.ipv6.route.flush=1

