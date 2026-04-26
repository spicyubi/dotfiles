FROM archlinux/archlinux:base
# Use ARG for build-time and ENV for runtime
# ARG build_type=standard
# RUN echo 'export USER=$(whoami)' >> /etc/bash.bashrc
RUN pacman -Syu --noconfirm
RUN pacman -S --noconfirm gcc make clang gdb bob fzf git ripgrep wl-clipboard
RUN yes | bob use nightly
RUN ln -s /mnt/.config/nvim/ /root/.config/
RUN ln -s /mnt/.config/.bashrc /root/
RUN git config --global --add safe.directory "*"

# On container start
CMD ["sleep", "infinity"]
