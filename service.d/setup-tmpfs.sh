mount_tmpfs() {
    local dest="$1"
    local opts=${2:-"mode=1777,nosuid,nodev"}

    [ -d "$dest" ] || mkdir -p "$dest"
    mountpoint -q $(realpath "$dest") || mount tmpfs "$dest" -t tmpfs -o "$opts"
    chcon --reference=$PREFIX $dest
    chown $(stat -c "%U:%G" $PREFIX) $dest
}

setup_tmpfs() {
    # make those directories tmpfs
    mount_tmpfs $PREFIX/tmp
    mount_tmpfs $PREFIX/tmp/.X11-unix
    mount_tmpfs $PREFIX/var/run rw,nosuid,nodev,relatime,mode=755
}
# main
setup_tmpfs
