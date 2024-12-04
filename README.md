<h1 align="center">Termux Container Service</h1>

<div align="center">
  <!-- Version -->
    <img src="https://img.shields.io/badge/Version-v1.3-blue.svg?longCache=true&style=popout-square"
      alt="Version" />
  <!-- Last Updated -->
    <img src="https://img.shields.io/badge/Updated-2024.12.01-green.svg?longCache=true&style=flat-square"
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
- Flash a kernel that support lxc & docker.
- Install lxc & docker in termux app.
- Set your lxc container config `lxc.start.auto = 1`.
- Lxc-autostart & dockerd will start automatically.
- If you want the device to automatically decrypt /data partitions,
modify PASSWORD in [/data/adb/service.d/locksettings-verify.sh](./service.d/locksettings-verify.sh) after install.