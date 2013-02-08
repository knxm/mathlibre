all: build

config: clean
	lb config \
	--apt-http-proxy "http://localhost:3142" \
	--mirror-bootstrap "http://ftp.jp.debian.org/debian/" \
	--mirror-binary "http://ftp.jp.debian.org/debian/" \
	--mirror-chroot "http://ftp.jp.debian.org/debian/" \
	--parent-mirror-binary "http://ftp.jp.debian.org/debian/" \
	--archive-areas "main contrib non-free" \
	--parent-archive-areas "main contrib non-free" \
	--binary-images iso \
	--apt-options "--yes -oAcquire::Check-Valid-Until=false" \
	--apt-secure false 

config-ja: config
	echo 'task-japanese task-japanese-desktop fonts-takao' > config/package-lists/ja.list.chroot
	echo 'texlive-lang-cjk xdvik-ja yatex' > config/package-lists/ja.tex.list.chroot
	lb config --bootappend-live \
	"live-config.locales=ja_JP.UTF-8 \
	 live-config.timezone=Asia/Tokyo \
	 live-config.keyboard-model=jp106 \
	 live-config.keyboard-layouts=jp"

ja: config-ja
	sudo lb build
	ls -l binary*.iso >> iso.ls-l

build: config
	sudo lb build
	ls -l binary*.iso >> iso.ls-l

clean:
	sudo lb clean

distclean: clean
 	#sudo lb clean --purge
	sudo rm -f *.iso *.img *.list *.packages *.buildlog *.md5sum
