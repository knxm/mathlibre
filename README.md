# MathLibre

Live Linux for Mathematical Software
http://www.mathlibre.org/
 
## How to build MathLibre DVD

## Environment for building
- Debian Sid/Wheezy(7.0)
- live-build (Sid)
- apt-cacher or apt-cacher-ng

sudo apt-get install git apt-cacher-ng
sudo echo "deb-src http://ftp.jp.debian.org/debian/ sid main contrib" \
>> /etc/apt/sources.list`
apt-get -b source live-boot live-build live-config live-tools
sudo dpkg -i live-*.deb
git clone https://github.com/knxm/mathlibre.git
cd mathlibre/
make

If you want to make Japanese environment,
please use "make ja".
