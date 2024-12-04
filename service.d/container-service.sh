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

lxc_start
docker_start
