LOGFILE=/cache/$MODID.log
mv "$LOGFILE" "$LOGFILE".bak
export PATH=$PATH:$MODPATH/bin
# function variables
PREFIX=/data/data/com.termux/files/usr

main() {
    # wait for termux to be ready
    resetprop -w sys.boot_completed 0
    . locksettings-verify
    echo "Setup cgroup & tmpfs ..."
    . setup-cgroups &
    . setup-tmpfs &
    wait
    # start service
    echo "Start Container Service ..."
    exec container-service
}

main >>"$LOGFILE" 2>&1
