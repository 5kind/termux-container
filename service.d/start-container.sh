START_LXC=true      # lxc-autostart
SETUP_DOCKER=true   # docker.sock
EXEC_DOCKERD=true   # exec dockerd

start_lxc(){
    [ -x $PREFIX/libexec/lxc/lxc-containers ] &&
    $PREFIX/libexec/lxc/lxc-containers start
}

setup_docker(){
    ln -s $(cat $PREFIX/etc/docker/daemon.json \
    | grep -o 'unix://[^"]*' | sed 's#unix://##'\
    ) $PREFIX/var/run/docker.sock
}

start_docker(){
    [ -x $PREFIX/libexec/dockerd ] &&
    exec $PREFIX/libexec/dockerd
}

$START_LXC && start_lxc
$SETUP_DOCKER && setup_docker
$EXEC_DOCKERD && start_docker
