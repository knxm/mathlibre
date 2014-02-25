#
# Makefile for sage (experimental)
# Make sure you have the dependencies and 3 GB of free disk space.
# It takes some hours for compiling.
#
# Eg:  make -f Makefile.sage version=6.1.1
#
mirror="http://ftp.tsukuba.wide.ad.jp/software/sage/src/"

all: build

build: 	
ifdef version
	wget -nc $(mirror)/sage-$(version).tar.gz
	tar xvzf sage-$(version).tar.gz 
	# with SSL
	(cd sage-$(version); sudo make ssl)
	install-sage
endif

install-sage:
	rm -rf config/include.chroot/usr/local/sage
	mv sage-$(version) config/include.chroot/usr/local/sage

clean:
	rm -rf sage-$(version)

