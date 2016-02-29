FROM nfnty/arch-mini:latest
MAINTAINER colajam93 <https://github.com/colajam93>

RUN rm -f /etc/pacman.d/mirrorlist
ADD mirrorlist /etc/pacman.d/mirrorlist
RUN rm -f /etc/pacman.conf
ADD pacman.conf /etc/pacman.conf

RUN pacman --noconfirm -Syu yaourt vim base-devel man man-pages unzip openssh rsync python gdb git abs
RUN echo -e '\ny\ny\n' | pacman -S multilib-devel && echo -e '\r'
RUN timeout 5 abs > /dev/null 2>&1 || true
RUN abs > /dev/null 2>&1

RUN pacman-key --init
RUN dirmngr < /dev/null
RUN pacman-key -r F32D93DA
RUN pacman-key --lsign-key F32D93DA
RUN pacman -Syu --noconfirm archstrike-keyring

RUN useradd -m -d /home/test test
RUN echo "test:test" | chpasswd
RUN echo 'test ALL=(ALL) ALL' >> /etc/sudoers
ADD .bashrc /home/test/.bashrc
ADD .vimrc /home/test/.vimrc
ADD .gdbinit /home/test/.gdbinit
RUN chown -R test:test /home/test
