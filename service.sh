LOGFILE=/cache/$MODID.log
mv "$LOGFILE" "$LOGFILE".bak
global_service_d=/data/adb/service.d
export PATH=$global_service_d:$PATH:$MODPATH/service.d
# function variables
PREFIX=/data/data/com.termux/files/usr

main() {
    # wait for termux to be ready
    resetprop -w sys.boot_completed 0
    . locksettings-verify.sh
    echo "Setup cgroup & tmpfs ..."
    . setup-cgroups.sh &
    . setup-tmpfs.sh &
    wait
    # start service
    echo "Start Container Service ..."
    . start-lxc.sh
    . start-docker.sh &
    echo "Container Service completed at $(uptime) ..."
    echo "Start container-completed service ..."
    . container-completed.sh &
}

main >>"$LOGFILE" 2>&1
