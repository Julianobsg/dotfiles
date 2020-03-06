FROM archlinux:latest

RUN pacman -Sy && \
    pacman -S --noconfirm zsh vim

CMD ["zsh"]
