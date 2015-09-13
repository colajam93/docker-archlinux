FROM nfnty/arch-mini:latest

RUN rm -f /etc/pacman.d/mirrorlist
ADD mirrorlist /etc/pacman.d/mirrorlist

RUN pacman --noconfirm -Syu patch > /dev/null 2>&1
ADD pacman.conf.patch /tmp/pacman.conf.patch
RUN patch /etc/pacman.conf < /tmp/pacman.conf.patch && rm -f /tmp/pacman.conf.patch

RUN pacman --noconfirm -Syu yaourt sudo vim base-devel man man-pages unzip openssh rsync python gdb git abs > /dev/null 2>&1
RUN echo -e '\ny\ny\n' | pacman -S multilib-devel > /dev/null 2>&1 && echo -e '\r'
RUN timeout 60 abs > /dev/null 2>&1 || true
RUN abs > /dev/null 2>&1

RUN useradd -m -d /home/test test
RUN echo "test:test" | chpasswd
RUN echo 'test ALL=(ALL) ALL' >> /etc/sudoers
ADD .bashrc /home/test/.bashrc
ADD .vimrc /home/test/.vimrc
ADD .gdbinit /home/test/.gdbinit
RUN chown -R test:test /home/test
