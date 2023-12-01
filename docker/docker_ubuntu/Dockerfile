ARG TAG=latest
ARG DEBIAN_FRONTEND=noninteractive

FROM ubuntu:$TAG

ARG USER=pat

# Install git and ansible
RUN apt update
RUN DEBIAN_FRONTEND=$DEBIAN_FRONTEND apt -y install ansible git sudo make

ENV USER ${USER}
ENV HOME /home/${USER}
RUN useradd -m -s /bin/bash -N -u 1000 $USER && \
    echo "${USER} ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers && \
    chmod 0440 /etc/sudoers && \
    chmod g+w /etc/passwd

USER ${USER}

WORKDIR /home/${USER}/dotfiles

