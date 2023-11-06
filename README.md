# MathLibre

Live Linux for Mathematical Software
http://www.mathlibre.org/
 
## Environment for building
We need these environments:
* Debian bookworm (12.2)
* live-build (bookworm)
* apt-cacher or apt-cacher-ng

### ex.
1. apt-get install git live-build apt-cacher-ng

## How to build MathLibre DVD

1. $ git clone https://github.com/knxm/mathlibre.git
1. $ cd mathlibre/
1. $ make

## Language environments
If you want to make Japanese environment,
please use "make lang=ja".

Makefile is supporting "us(default), ko, cn, tw, etc." languages too.

## Sage system
From 2018, we install sagemath on MathLibre as an official debian package.
* https://packages.debian.org/stretch/sagemath

