lxc_start() {
    # start lxc service
    export HOME=/data/data/com.termux/files/home/.suroot
    [ -x $PREFIX/bin/lxc-autostart ] &&
        $PREFIX/bin/lxc-autostart -l DEBUG
}

lxc_start
