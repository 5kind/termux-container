start_lxc(){
    [ -x $PREFIX/libexec/lxc/lxc-containers ] &&
    $PREFIX/libexec/lxc/lxc-containers start
}

setup_docker(){
    ln -s $(cat $PREFIX/etc/docker/daemon.json \
    | grep -o 'unix://[^"]*' | sed 's#unix://##'\
    ) $PREFIX/var/run/docker.sock
}

$START_LXC && start_lxc
$SETUP_DOCKER && setup_docker
