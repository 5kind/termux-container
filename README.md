<h1 align="center">Termux Container Service</h1>

<div align="center">
  <!-- Version -->
    <img src="https://img.shields.io/badge/Version-v2.0-blue.svg?longCache=true&style=popout-square"
      alt="Version" />
  <!-- Last Updated -->
    <img src="https://img.shields.io/badge/Updated-2026.04.09-green.svg?longCache=true&style=flat-square"
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
3. Install [Termux Services](https://github.com/5kind/termux-services).
4. Set your lxc container config `lxc.start.auto = 1`.
5. Use `termux-services` to manage `dockerd`&`lxc-containers`.

### Optional
#### Modify [rc.conf](/data/adb/termux-container/rc.conf) to customize the behavior of the service in [/etc/rc.local/d](system/etc/rc.local.d).
