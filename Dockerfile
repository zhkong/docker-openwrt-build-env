FROM debian:buster

RUN sed -i 's/deb.debian.org/mirrors.ustc.edu.cn/g' /etc/apt/sources.list

RUN apt-get update &&\
    apt-get install -y \
        sudo time git-core subversion build-essential g++ bash make \
        libssl-dev patch libncurses5 libncurses5-dev zlib1g-dev gawk \
        flex gettext wget unzip xz-utils python python-distutils-extra \
        python3 python3-distutils-extra rsync curl libsnmp-dev liblzma-dev \
        libpam0g-dev cpio rsync ocaml zsh locales && \
    apt-get clean && \
    useradd -m user && \
    echo 'user ALL=NOPASSWD: ALL' > /etc/sudoers.d/user

# set system locale to en_US.UTF-8
RUN sed -i 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen && \
    update-locale LANG=en_US.UTF-8

# set system wide dummy git config
RUN git config --system user.name "user" && git config --system user.email "user@example.com"

# install oh-my-zsh
RUN git clone https://github.com/ohmyzsh/ohmyzsh.git /home/user/.oh-my-zsh && \
    cp /home/user/.oh-my-zsh/templates/zshrc.zsh-template /home/user/.zshrc && \
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="agnoster"/' /home/user/.zshrc &&\
    chsh -s /usr/bin/zsh user

USER user
WORKDIR /mnt
