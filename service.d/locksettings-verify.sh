PASSWORD=""
SLEEP_TIME=5

locksettings_verify () {
    [ -z "$PASSWORD" ] && return 1
    locksettings verify --old "$PASSWORD"
}

# service function
ensure_exist() {
    local folder="$1"
    while [ ! -e $folder ]; do
        sleep $SLEEP_TIME
    done
}

if ! locksettings_verify ; then
    ensure_exist $PREFIX
fi
