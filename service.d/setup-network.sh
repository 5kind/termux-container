SETUP_NETWORK=true
MAX_ATTEMPTS=4
device_interface="wlan0 eth0"
# container_interface="lxcbr0 docker0"

gateway_check_online() {
    for attempt in $(seq 1 $MAX_ATTEMPTS); do
        if ping -c 1 $gateway > /dev/null; then
            return 0
        fi
        sleep 1
    done
    return 1
}

set_default_route() {
    # Usage: set_default_route <interface>
    local interface=$1
    if ip route | grep default &> /dev/null; then
        echo "Default route already set, skipping..."
        return 1
    fi
    echo "Setting default route by $interface ..."
    local ipaddr=$(ip addr show dev $interface | grep inet \
    | grep -v inet6 | awk '{print $2}' | cut -d/ -f1)
    if [ -z "$ipaddr" ]; then
        echo "No IP address found for $interface, skipping..."
        return 1
    fi
    local gateway="${ipaddr%.*}.1"
    echo "Guessed gateway: $gateway"
    if gateway_check_online; then
        if ip route add default via $gateway; then
            echo "Default route set to $gateway"
        else
            echo "Failed to set default route: $gateway"
        fi
    else
        echo "$gateway is not reachable, skipping..."
    fi
}

container_internet_access() {
    for interface in $device_interface; do
        set_default_route $interface && break
    done
    ip rule add from all lookup main pref 30000
    $PREFIX/libexec/lxc/lxc-net start
}

$SETUP_NETWORK && container_internet_access
