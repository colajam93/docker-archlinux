FROM nfnty/arch-mini:latest
MAINTAINER colajam93 <https://github.com/colajam93>

# pacman
COPY mirrorlist /etc/pacman.d/mirrorlist
COPY pacman.conf /etc/pacman.conf
RUN pacman --noconfirm --needed -Syu \
    abs \
    base-devel \
    gdb \
    git \
    man \
    man-pages \
    openssh \
    python \
    rsync \
    unzip \
    vim \
    yaourt \
        > /dev/null
RUN echo -e '\ny\ny\n' | pacman -S multilib-devel && echo -e '\r'

# abs
RUN timeout 5 abs > /dev/null 2>&1 || abs > /dev/null 2>&1

# dotfiles
RUN git clone --depth 1 https://github.com/colajam93/dotfiles.git \
    && bash /dotfiles/install.sh simple

# user
RUN useradd -m test
RUN echo "test:test" | chpasswd
RUN echo 'test ALL=(ALL) ALL' >> /etc/sudoers
USER test
WORKDIR /home/test
RUN bash /dotfiles/install.sh simple && bash /dotfiles/install.sh develop
# bashrc overwrite workaround
RUN mv -f .bashrc.dotnew .bashrc
