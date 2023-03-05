FROM ubuntu:22.04

# Update package lists 
RUN apt-get update -y && apt-get upgrade -y

# Set timezone
RUN apt-get install -y tzdata
RUN ln -fs /usr/share/zoneinfo/America/Sao_Paulo /etc/localtime && dpkg-reconfigure -f noninteractive tzdata

# Install utils
RUN apt install fd-find
RUN apt-get install -y --no-install-recommends \
	make \
	libc-dev \
	pkg-config \
	gdb zsh unzip gzip tar \
	clang \
	valgrind \
	openssh-server \
	git \
	python3-pip \
	ripgrep

RUN ulimit -n 65535
RUN rm -f /usr/bin/cc
RUN ln -s /usr/bin/clang /usr/bin/cc

# Install Norminette
RUN pip3 install norminette

# Generate SSH key pair
RUN ssh-keygen -t rsa -N "" -f /root/.ssh/id_rs

# Install Node.js 16
RUN apt-get install -y curl
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
RUN apt-get install -y nodejs

# Download and extract neovim appimage
RUN curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage && \
    chmod u+x nvim.appimage && \
    ./nvim.appimage --appimage-extract && \
    mv squashfs-root /neovim && \
    ln -s /neovim/usr/bin/nvim /usr/bin/nvim

# Set the working directory
WORKDIR /root

# Install Powerlevel10k
RUN git clone --depth=1 https://github.com/romkatv/powerlevel10k.git /root/powerlevel10k
RUN echo 'source /root/powerlevel10k/powerlevel10k.zsh-theme' >> /root/.zshrc
# Install zsh plugin manager 
RUN curl -L git.io/antigen > /root/.antigen.zsh
# Install my dotfiles
RUN git clone --branch my_ubuntu_container https://github.com/Vinni-Cedraz/.dotfiles.git
WORKDIR /root/.dotfiles
RUN chmod +x install.sh
RUN ./install.sh

# Install ft_neovim
RUN mkdir -p /root/.config/
RUN git clone --branch my_ubuntu_container https://github.com/Vinni-Cedraz/ft_neovim.git /root/.config/nvim

# Clean up APT cache to reduce image size
RUN apt-get clean && rm -rf /var/lib/apt/lists/*

# Set working directory to ~/
WORKDIR /root

CMD ["/bin/zsh"]