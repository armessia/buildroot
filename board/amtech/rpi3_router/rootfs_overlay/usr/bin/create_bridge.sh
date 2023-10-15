#!/bin/sh

# $1 interface to wait for
# $2 time to wait in seconds
function wait_for_interface() {
    if [ "$2" -a ! -e "/sys/class/net/$1" ]; then
        printf "Waiting for interface $1 to appear"
        IF_WAIT_DELAY=${2}
        while [ ${IF_WAIT_DELAY} -gt 0 ]; do
            if [ -e "/sys/class/net/$1" ]; then
                printf "\n"
                return 0
            fi
            sleep 1
            printf "."
            : $((IF_WAIT_DELAY -= 1))
        done
        printf " timeout!\n"
        return 1
    fi
    return 0
}

wait_for_interface "eth0" 10
SUCCESS=$?
if [ $SUCCESS -eq 1 ]; then
    printf "Failure\n"
    printf "Exiting\n"
    exit 1
fi

ip link add name br0 type bridge
ip link set dev br0 up
ip link set dev eth0 up
ip link set eth0 master br0

exit 0
