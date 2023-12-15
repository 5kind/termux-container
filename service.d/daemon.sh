# termux tmpfs
PREFIX=/data/data/com.termux/files/usr
SLEEP_TIME=5

ensure_exist(){
    local folder="$1"
    while [ ! -e $folder ] ;do
        sleep $SLEEP_TIME
    done
}

mount_tmpfs() {
    local dest="$1"
    local opts=${2:-"mode=1777,nosuid,nodev"}

    [ -d "$dest" ] || mkdir -p "$dest"
    mountpoint -q $(realpath "$dest") || mount tmpfs "$dest" -t tmpfs -o "$opts"
    chcon --reference=$PREFIX $dest
    chown $(stat -c "%U:%G" $PREFIX) $dest
}

ensure_exist $PREFIX
mount_tmpfs $PREFIX/tmp
mount_tmpfs $PREFIX/tmp/.X11-unix
mount_tmpfs $PREFIX/var/run rw,nosuid,nodev,relatime,mode=755

# termux container
export HOME=/data/data/com.termux/files/home/.suroot
[ -x /data/data/com.termux/files/usr/bin/lxc-autostart ] &&
/data/data/com.termux/files/usr/bin/lxc-autostart
[ -x /data/data/com.termux/files/usr/bin/dockerd ] &&
exec /data/data/com.termux/files/usr/bin/dockerd