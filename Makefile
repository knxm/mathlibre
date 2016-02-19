# Makefile for building MathLibre 
# Make sure you have the dependencies and 30 GB of free disk space.
#
# Eg:  make lang=ja
#
MIRROR="http://ftp.jp.debian.org/debian/"

all: build

config: clean
	lb config \
	--apt-http-proxy "http://localhost:3142" \
	--mirror-bootstrap $(MIRROR) \
	--mirror-chroot $(MIRROR) \
	--archive-areas "main contrib non-free" \
	--parent-archive-areas "main contrib non-free" \
	--apt-options "--fix-missing --yes -oAcquire::Check-Valid-Until=false" \
	--bootappend-live "boot=live config quiet splash persistence" \
	--apt-secure false \
	--architectures amd64 --linux-flavours amd64 --debian-installer live \
#	--parent-mirror-binary "http://www.jp.debian.org/debian/" \
#        --parent-mirror-binary-backports "http://ftp.debian.org/debian/" \
#        --backports true \
#       --linux-packages "linux-image linux-headers" \
#	--win32-loader false \
#	--distribution jessie \
#	--binary-images hdd

build: 	config
ifdef lang
	sh lang/$(lang)
endif
	sudo lb build
#	ls -l binary*.iso >> iso.ls-l

clean:
	sudo lb clean
	rm -f config/hooks/lang.*.chroot
	rm -f config/package-lists/lang.*.list.chroot
	rm -f config/includes.chroot/etc/emacs/site-start.d/99lang.*.el
	rm -f config/includes.binary/isolinux/live.cfg # for bilingual menu

distclean: clean
	#sudo lb clean --purge
	sudo rm -f *.iso *.img *.list *.packages *.buildlog *.md5sum
