# MathLibre

Live Linux for Mathematical Software
http://www.mathlibre.org/
 
## Environment for building
We need these environments:
* Debian Wheezy(7.0)
* live-build (Wheezy)
* apt-cacher or apt-cacher-ng

### ex.
1. # apt-get install git live-build apt-cacher-ng

## How to build MathLibre DVD

1. $ git clone https://github.com/knxm/mathlibre.git
1. $ cd mathlibre/
1. $ make

## Language environments
If you want to make Japanese environment,
please use "make lang=ja".

Makefile is supporting "us(default), ko, cn, tw, etc." languages too.

## Sage system
Sage is a huge computer algebra system, so we extract and make it manually.
We are using sage-5.11, which is extracted to config/includes.chroot/usr/local.
You can download the source code:sage-5.11.tar from
http://www.sagemath.org/download-source.html
It will take your computer a while to compile Sage from the source code.

If you want to download sage-5.7 binary built with wheezy,
you can download it from
http://math.shinshu-u.ac.jp/~nu/nora/sage/bin/sage-5.7/
