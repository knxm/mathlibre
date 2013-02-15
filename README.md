# MathLibre

Live Linux for Mathematical Software
http://www.mathlibre.org/
 
## Environment for building
We need these environments:
* Debian Sid/Wheezy(7.0)
* live-build (Sid)
* apt-cacher or apt-cacher-ng

### ex.
1. # apt-get install git apt-cacher-ng
1. # echo "deb-src http://ftp.jp.debian.org/debian/ sid main contrib" >> /etc/apt/sources.list
1. $ apt-get -b source live-boot live-build live-config
1. # dpkg -i live-boot*.deb live-build*.deb live-config_*.deb

## How to build MathLibre DVD

1. $ git clone https://github.com/knxm/mathlibre.git
1. $ cd mathlibre/
1. $ make

## Language environments
If you want to make Japanese environment,
please use "make ja".

Makefile is supporting "us(default), ko, cn, tw" languages too,
but these are not checked yet. 2013.2.15

## Sage system
Sage is a huge computer algebra system, so we extract and make it manually.
We are using sage-5.6, which is extracted to config/includes.chroot/usr/local.
You can download sage-5.6.tar from
http://www.sagemath.org/download-source.html
It will take your computer a while to compile Sage from the source code.
