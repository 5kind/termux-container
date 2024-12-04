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

setup_cg() {
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
# main
[ $(stat -f -c %T /sys/fs/cgroup) != "cgroup2fs" ] && setup_cg
