SETUP_TMPFS=true

TERMUX_SOCKET=/dev/socket/termux

clone_attr() {
    local src=$1
    local dest=$2
    shift 2
    local opts=$@
    chcon --reference=$src $dest $opts
    chown $(stat -c "%U:%G" $src) $dest $opts
}

setup_tmpfs() {
    # setup tmpfs in /dev/socket/termux
    mkdir -m 1777 $TERMUX_SOCKET/tmp $TERMUX_SOCKET/tmp/.X11-unix
    mkdir -m 755 $TERMUX_SOCKET/run $TERMUX_SOCKET/run/dbus \
    $TERMUX_SOCKET/run/user $TERMUX_SOCKET/run/lock
    clone_attr $PREFIX $TERMUX_SOCKET -R
    # make those directories tmpfs
    mount --bind $TERMUX_SOCKET/tmp $PREFIX/tmp
    mount --bind $TERMUX_SOCKET/run $PREFIX/var/run
}
# main
$SETUP_TMPFS &&
setup_tmpfs
