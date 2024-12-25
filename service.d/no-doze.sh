NO_DOZE=true        # No auto doze android

no_doze(){
    dumpsys deviceidle disable
    echo "PowerManagerService.noSuspend" | tee /sys/power/wake_lock
}

$NO_DOZE && no_doze
