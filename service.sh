LOGFILE=/cache/$MODID.log
mv "$LOGFILE" "$LOGFILE".bak
global_service_d=/data/adb/service.d
export PREFIX=/data/data/com.termux/files/usr
export PATH=$global_service_d:$PATH:$MODPATH/service.d:$PREFIX/bin
export HOME=/data/data/com.termux/files/home/.suroot

out() { printf "${@}\n"; }
out_stat () { out "-- ${@} Container Service --"; }
log_msg (){ out "$(date +'%b %d %T') $(hostname) $(basename ${0})[$$]: $@"; }
run_msg (){ log_msg "$@"; . $@ ; }

main() {
    log_msg "Wait for System boot completed ..."
    resetprop -w sys.boot_completed 0
    # pre service
    out_stat Pre
    log_msg "Setup environment for service ..."
    run_msg locksettings-verify.sh
    log_msg "Setup tmpfs, cgroup, network, no doze..."
    run_msg no-doze.sh &
    run_msg setup-tmpfs.sh &
    run_msg setup-cgroups.sh &
    run_msg setup-network.sh &
    wait
    # start service
    out_stat Start
    run_msg start-container.sh &
    # post service
    out_stat Post
    run_msg auto-start-stop.sh &
}

main >>"$LOGFILE" 2>&1
