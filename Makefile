all: build

config: clean
	lb config \
	--apt-http-proxy "http://localhost:3142" \
	--archive-areas "main contrib non-free" \
	--parent-archive-areas "main contrib non-free" \
	--binary-images iso \
	--apt-options "--yes -oAcquire::Check-Valid-Until=false" \
	--apt-secure false \
	--bootappend-live "boot=live config quiet splash"

config-ja: config
	echo 'task-japanese task-japanese-desktop fonts-takao' > config/package-lists/lang.ja.list.chroot
	echo 'texlive-lang-cjk xdvik-ja yatex' > config/package-lists/lang.ja.tex.list.chroot
	lb config \
	--mirror-bootstrap "http://ftp.jp.debian.org/debian/" \
	--mirror-binary "http://ftp.jp.debian.org/debian/" \
	--mirror-chroot "http://ftp.jp.debian.org/debian/" \
	--parent-mirror-binary "http://ftp.jp.debian.org/debian/" \
	--bootappend-live \
	"boot=live config quiet splash \
	 live-config.locales=ja_JP.UTF-8 \
	 live-config.timezone=Asia/Tokyo \
	 live-config.keyboard-model=jp106 \
	 live-config.keyboard-layouts=jp"

ja: config-ja
	sudo lb build
	ls -l binary*.iso >> iso.ls-l

config-ko: config
	echo 'task-korean task-korean-desktop ' > config/package-lists/lang.ko.list.chroot
	echo 'texlive-lang-cjk auctex' > config/package-lists/lang.ko.tex.list.chroot
	lb config \
	--mirror-bootstrap "http://ftp.kr.debian.org/debian/" \
	--mirror-binary "http://ftp.kr.debian.org/debian/" \
	--mirror-chroot "http://ftp.kr.debian.org/debian/" \
	--parent-mirror-binary "http://ftp.kr.debian.org/debian/" \
	--bootappend-live \
	"boot=live config quiet splash \
	 live-config.locales=ko_KR.UTF-8 \
	 live-config.timezone=Asia/Seoul \
	 live-config.keyboard-model=kr106 \
	 live-config.keyboard-layouts=kr"

ko: config-ko
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
