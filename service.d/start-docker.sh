SETUP_DOCKER=true   # run docker_start 
EXEC_DOCKERD=true   # run exec dockerd
docker_start() {
    $SETUP_DOCKER || return 1
    # start docker service
    export PATH=$PATH:$PREFIX/bin
    [ -x $PREFIX/libexec/dockerd ] &&
        ln -s $(cat $PREFIX/etc/docker/daemon.json | grep -o 'unix://[^"]*' | sed 's#unix://##') $PREFIX/var/run/docker.sock &&
        $EXEC_DOCKERD && exec $PREFIX/libexec/dockerd &
}

docker_start