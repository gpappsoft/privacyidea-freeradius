#!/bin/sh
set -e

PATH=/opt/sbin:/opt/bin:$PATH
export PATH

### modified from original
sed -i  -e "s|^URL =.*$|URL = ${RADIUS_PI_HOST:-http://127.0.0.1}/validate/check|" \
        -e "s|^REALM =.*$|REALM = ${RADIUS_PI_REALM}|" \
        -e "s|^RESCONF =.*$|RESCONF = ${RADIUS_PI_RESCONF}|" \
        -e "s|^SSL_CHECK =.*$|SSL_CHECK = ${RADIUS_PI_SSLCHECK:-false}|" \
        -e "s|^DEBUG =.*$|DEBUG = ${RADIUS_DEBUG:-false}|" \
        -e "s|^TIMEOUT =.*$|TIMEOUT = ${RADIUS_PI_TIMEOUT:-10}|" /etc/raddb/rlm_perl.ini
### end of modify

# this if will check if the first argument is a flag
# but only works if all arguments require a hyphenated flag
# -v; -SL; -f arg; etc will work, but not arg1 arg2
if [ "$#" -eq 0 ] || [ "${1#-}" != "$1" ]; then
    set -- radiusd "$@"
fi

# check for the expected command
if [ "$1" = 'radiusd' ]; then
    shift
    exec radiusd -f "$@"
fi

# debian people are likely to call "freeradius" as well, so allow that
if [ "$1" = 'freeradius' ]; then
    shift
    exec radiusd -f "$@"
fi

# else default to run whatever the user wanted like "bash" or "sh"
exec "$@"
