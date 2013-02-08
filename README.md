# MathLibre

Live Linux for Mathematical Software
http://www.mathlibre.org/
 
## Environment for building
We need these environments
* Debian Sid/Wheezy(7.0)
* live-build (Sid)
* apt-cacher or apt-cacher-ng

### ex.
1. # apt-get install git apt-cacher-ng
1. # echo "deb-src http://ftp.jp.debian.org/debian/ sid main contrib" >> /etc/apt/sources.list
1. $ apt-get -b source live-boot live-build live-config live-tools
1. # dpkg -i live-boot live-boot-initramfs-tools live-build live-config live-config-sysvinit live-tools

## How to build MathLibre DVD

1. $ git clone https://github.com/knxm/mathlibre.git
1. $ cd mathlibre/
1. $ make

If you want to make Japanese environment,
please use "make ja".
