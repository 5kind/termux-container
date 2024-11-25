LOGFILE=/cache/$MODID.log
mv "$LOGFILE" "$LOGFILE".bak
# function variables
PREFIX=/data/data/com.termux/files/usr
SLEEP_TIME=5

# cgroup function
ln_cg() {
    local src=$1
    local scg="/sys/fs/cgroup/${2}"

    if [ -d "${src}" ] && [ ! -e "${scg}" ]; then
        ln -s "${src}" "${scg}"
    fi
}

mount_cg() {
    local cg=$1
    local opts=$2
    local real_cg=$(realpath /sys/fs/cgroup/${cg})

    if [ ! -d "/sys/fs/cgroup/${cg}" ]; then
        mkdir -p "/sys/fs/cgroup/${cg}"
    fi

    if ! mountpoint -q ${real_cg}; then
        mount -t cgroup -o "${opts}" cgroup "${real_cg}"
    fi
}

# service function
ensure_exist() {
    local folder="$1"
    while [ ! -e $folder ]; do
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

# main function
setup_cgroup() {
    # setup cgroup v1
    if ! mountpoint -q /sys/fs/cgroup; then
        mount -t tmpfs -o rw,mode=755,nodev,noexec,nosuid tmpfs /sys/fs/cgroup
    else
        mount -o remount,rw /sys/fs/cgroup
    fi
    # termux lxc,docker declares that they need these
    ln_cg /acct cpuacct
    ln_cg /dev/blkio blkio
    ln_cg /dev/cg2_bpf cg2_bpf
    ln_cg /dev/cpuctl cpu
    ln_cg /dev/cpuset cpuset
    ln_cg /dev/freezer freezer
    ln_cg /dev/memcg memory
    ln_cg /dev/stune schedtune
    # if those cgroups are not mounted, mount them
    for cg in blkio cpu cpuacct cpuset devices freezer memory pids schedtune; do
        mount_cg ${cg} ${cg}
    done
    # mount systemd cgroup
    for cg in systemd; do
        mount_cg ${cg} "none,nosuid,nodev,noexec,relatime,xattr,name=${cg}"
    done
    # make cgroup read-only
    mount -o remount,ro /sys/fs/cgroup
}

setup_tmpfs() {
    # make those directories tmpfs
    mount_tmpfs $PREFIX/tmp
    mount_tmpfs $PREFIX/tmp/.X11-unix
    mount_tmpfs $PREFIX/var/run rw,nosuid,nodev,relatime,mode=755
}

lxc_start() {
    # start lxc service
    export HOME=/data/data/com.termux/files/home/.suroot
    [ -x $PREFIX/bin/lxc-autostart ] &&
        $PREFIX/bin/lxc-autostart -l DEBUG
}

docker_start() {
    # start docker service
    export PATH=$PATH:$PREFIX/bin
    [ -x $PREFIX/libexec/dockerd ] &&
        ln -s $(cat $PREFIX/etc/docker/daemon.json | grep -o 'unix://[^"]*' | sed 's#unix://##') $PREFIX/var/run/docker.sock &&
        exec $PREFIX/libexec/dockerd
}

main() {
    # wait for termux to be ready
    resetprop -w sys.boot_completed 0
    ensure_exist $PREFIX
    # start service
    echo "Setup cgroup & tmpfs ..."
    setup_cgroup
    setup_tmpfs
    echo "Start lxc service ..."
    lxc_start
    echo "Start docker service ..."
    docker_start
}

main >>"$LOGFILE" 2>&1
