setup_docker(){
    local daemon_json="$PREFIX/etc/docker/daemon.json"
    local target_link="$PREFIX/var/run/docker.sock"
    if [ ! -f "$daemon_json" ]; then
        echo "Warning: $daemon_json not found, skipping docker.sock setup."
        return 1
    fi
    local config_socket=$(grep -o 'unix://[^"]*' "$daemon_json" | head -n 1 | sed 's#unix://##')
    if [ -n "$config_socket" ] && [ "$config_socket" != "$target_link" ]; then
        ln -sfv "$config_socket" "$target_link"
    else
        echo "Skip symlink: Configured socket is empty or already at $target_link"
    fi
}
$SETUP_DOCKER && setup_docker
