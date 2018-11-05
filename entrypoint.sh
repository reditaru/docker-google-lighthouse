#!/bin/sh
set -e

# limit network
tc qdisc add dev eth0 root tbf rate 4mbit peakrate 8mbit burst 64kb latency 50ms minburst 1540

# first arg is `-f` or `--some-option`
if [ "${1#http}" != "$1" ]; then
    command="sudo -H -u chrome sh -c \"lighthouse --enable-error-reporting --chrome-flags=\\\"--headless --disable-gpu\\\" $@\""
    exec sh -c "$command"
else
    # pass extra command at position 0, such as network limit (tc qdisc add dev eth0 root tbf rate 4mbit peakrate 8mbit burst 64kb latency 50ms minburst 1540)
    first_arg="$1"
    shift
    command="$first_arg && sudo -H -u chrome sh -c \"lighthouse --enable-error-reporting --chrome-flags=\\\"--headless --disable-gpu\\\" $@\""
    exec sh -c "$command"
fi
