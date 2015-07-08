FROM nfnty/arch-mini:latest

RUN rm -f /etc/pacman.d/mirrorlist
ADD mirrorlist /etc/pacman.d/mirrorlist

RUN pacman --noconfirm -Syu patch > /dev/null 2>&1
ADD pacman.conf.patch /tmp/pacman.conf.patch
RUN patch /etc/pacman.conf < /tmp/pacman.conf.patch && rm -f /tmp/pacman.conf.patch

RUN dirmngr < /dev/null > /dev/null 2>&1
RUN pacman-key -r CC1D2606 > /dev/null 2>&1 && pacman-key --lsign-key CC1D2606 > /dev/null 2>&1

RUN pacman --noconfirm -Syu yaourt sudo vim base-devel man man-pages unzip openssh rsync python gdb git > /dev/null 2>&1
RUN echo -e '\ny\ny\n' | pacman -S multilib-devel > /dev/null 2>&1 && echo -e '\r'

RUN useradd -m -d /home/test test
RUN echo "test:test" | chpasswd
RUN chown -R test:test /home/test
RUN echo 'test ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers
ADD .bashrc /home/test/.bashrc
ADD .vimrc /home/test/.vimrc
