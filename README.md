<h1 align="center">Termux Container Service</h1>

<div align="center">
  <!-- Version -->
    <img src="https://img.shields.io/badge/Version-v1.5-blue.svg?longCache=true&style=popout-square"
      alt="Version" />
  <!-- Last Updated -->
    <img src="https://img.shields.io/badge/Updated-2024.12.25-green.svg?longCache=true&style=flat-square"
      alt="_time_stamp_" />
  <!-- Min Magisk -->
    <img src="https://img.shields.io/badge/MinMagisk-27.0-red.svg?longCache=true&style=flat-square"
      alt="_time_stamp_" />
  <!-- Min KSU -->
    <img src="https://img.shields.io/badge/MinKernelSU-0.9.5-red.svg?longCache=true&style=flat-square"
      alt="_time_stamp_" /></div>

<div align="center">
  <strong>Mount Cgroup and Run Termux LXC & Docker 
  <h4>Also supports KSU</h4>
</div>

<div align="center">
  <h3>
    <a href="https://github.com/5kind/termux-container">
      Source Code
    </a>
  </h3>
</div>

### Usage
1. Flash a kernel that support lxc & docker.
2. Install lxc & docker in termux app.
3. Set your lxc container config `lxc.start.auto = 1`.
4. `lxc-autostart` & `dockerd` will start automatically.

### Optional
#### Modify scripts in the [/data/adb/service.d](./service.d) to customize the behavior of the service.
1. Modify `PASSWORD` in [/data/adb/service.d/locksettings-verify.sh](./service.d/locksettings-verify.sh) to automatically decrypt /data partitions;
2. Modify `SETUP_DOCKER EXEC_DOCKERD` in [/data/adb/service.d/start-container.sh](./service.d/start-container.sh) to customize the behavior of the docker service;
3. Modify `NO_START_STOP` in [/data/adb/service.d/auto-start-stop.sh](./service.d/auto-start-stop.sh) to auto start/stop android system;
4. Copy & modify other scripts in [/data/adb/service.d](./service.d) (copy from ./service.d by yourself) to customize the behavior of those service.