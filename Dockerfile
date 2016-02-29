FROM nfnty/arch-mini:latest

RUN rm -f /etc/pacman.d/mirrorlist
ADD mirrorlist /etc/pacman.d/mirrorlist
RUN rm -f /etc/pacman.conf
ADD pacman.conf /etc/pacman.conf

RUN pacman --noconfirm -Syu yaourt sudo vim base-devel man man-pages unzip openssh rsync python gdb git abs
RUN echo -e '\ny\ny\n' | pacman -S multilib-devel && echo -e '\r'
RUN timeout 5 abs || true
RUN abs

RUN useradd -m -d /home/test test
RUN echo "test:test" | chpasswd
RUN echo 'test ALL=(ALL) ALL' >> /etc/sudoers
ADD .bashrc /home/test/.bashrc
ADD .vimrc /home/test/.vimrc
ADD .gdbinit /home/test/.gdbinit
RUN chown -R test:test /home/test
