FROM base/archlinux 

RUN echo '[multilib]' >> /etc/pacman.conf
RUN echo 'Include = /etc/pacman.d/mirrorlist' >> /etc/pacman.conf

RUN echo '[archlinuxfr]' >> /etc/pacman.conf
RUN echo 'SigLevel = Never' >> /etc/pacman.conf
RUN echo 'Server = http://repo.archlinux.fr/$arch' >> /etc/pacman.conf

RUN echo 'Server = http://ftp.tsukuba.wide.ad.jp/Linux/archlinux/$repo/os/$arch' > /etc/pacman.d/mirrorlist
RUN echo 'Server = http://ftp.jaist.ac.jp/pub/Linux/ArchLinux/$repo/os/$arch' >> /etc/pacman.d/mirrorlist

RUN pacman --noconfirm -Syy
RUN pacman --noconfirm -Syu
RUN pacman-db-upgrade > /dev/null
RUN pacman --noconfirm -S yaourt sudo vim base-devel man man-pages unzip openssh rsync python gdb
RUN echo -e '\ny\ny\n' | pacman -S multilib-devel && echo -e '\r'

RUN useradd -m -d /home/test test
RUN echo "test:test" | chpasswd
RUN chown -R test:test /home/test
RUN echo 'test ALL=(ALL) ALL' >> /etc/sudoers
ADD .bashrc /home/test/.bashrc
ADD .vimrc /home/test/.vimrc
