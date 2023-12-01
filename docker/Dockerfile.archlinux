ARG TAG=latest

FROM archlinux:$TAG
ARG USER=pat

# Install git and ansible
RUN pacman -Syyu --noconfirm
RUN pacman -Sy --noconfirm make ansible git sudo

ENV USER ${USER}
ENV HOME /home/${USER}
RUN useradd -m -s /bin/bash -N -u 1000 $USER && \
    echo "${USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers && \
    chmod 0440 /etc/sudoers && \
    chmod g+w /etc/passwd

USER ${USER}

WORKDIR /home/${USER}/dotfiles
