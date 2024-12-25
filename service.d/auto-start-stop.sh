AUTO_START_STOP=false   # No auto start/stop android
SLEEP_TIME=600
MAX_ATTEMPTS=4
ONLINE_WEBSITES="www.google.com
www.baidu.com
www.example.com"
start_stop_functions() {
    # Set which functions to start/stop android
    # Stop android to reduce power consumption
    start_stop_by_netd
}

netd_check_online() {
    for attempt in $(seq 1 "$MAX_ATTEMPTS"); do
        for website in $ONLINE_WEBSITES; do
            ping -c 1 "$website" > /dev/null && return
        done
    done
    return 1
}

start_stop_by_netd() {
    if netd_check_online; then
        stop
    else
        start
    fi
}

# main
$AUTO_START_STOP &&
while true; do
    start_stop_functions
    sleep "$SLEEP_TIME"
done
