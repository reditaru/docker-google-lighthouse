#!/bin/sh
set -e

# limit network
tc qdisc add dev eth0 root tbf rate 4mbit peakrate 8mbit burst 64kb latency 50ms minburst 1540

# first arg is `-f` or `--some-option`
if [ "${1#http}" != "$1" ]; then
    set -- lighthouse --enable-error-reporting --chrome-flags="--headless --disable-gpu" "$@"
fi

exec "$@"
