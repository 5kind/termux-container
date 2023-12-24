<h1 align="center">Termux Container Service</h1>

<div align="center">
  <!-- Version -->
    <img src="https://img.shields.io/badge/Version-v1.0-blue.svg?longCache=true&style=popout-square"
      alt="Version" />
  <!-- Last Updated -->
    <img src="https://img.shields.io/badge/Updated-2023.12.15-green.svg?longCache=true&style=flat-square"
      alt="_time_stamp_" />
  <!-- Min Magisk -->
    <img src="https://img.shields.io/badge/MinMagisk-20.4-red.svg?longCache=true&style=flat-square"
      alt="_time_stamp_" />
  <!-- Min KSU -->
    <img src="https://img.shields.io/badge/MinKernelSU-0.6.6-red.svg?longCache=true&style=flat-square"
      alt="_time_stamp_" /></div>

<div align="center">
  <strong>Mount Cgroup and Run Termux LXC & Docker 
  <h4>Also supports KSU</h4>
</div>

<div align="center">
  <h3>
    <a href="https://github.com/5kind/termux-contaner">
      Source Code
    </a>
  </h3>
</div>

### Usage
- Flash a kernel that support lxc & docker.
- Install lxc & docker in termux app.
- Set your lxc container config `lxc.start.auto = 1`.
- Lxc-autostart & dockerd will start automatically.

### Notice
- There is a known problem that the latest (1.6.21-2) containerd don't work, see [issue](https://github.com/termux/termux-packages/issues/18359).
