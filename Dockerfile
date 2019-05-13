FROM ubuntu:16.04
MAINTAINER Denley Hsiao <denley@justtodo.com>

# 更新源
# RUN mv /etc/apt/sources.list /etc/apt/sources_bak.list
# COPY sources.list /etc/apt/sources.list

RUN apt-get update \
  && apt-get install -y language-pack-zh-hans \
  curl locales sudo bzip2 libbz2-dev git

# 增加用户denley
RUN localedef -i zh_CN -f UTF-8 zh_CN.UTF-8 \
  && useradd -m -s /bin/bash denley \
  && echo 'denley ALL=(ALL) NOPASSWD:ALL' >>/etc/sudoers
USER denley
WORKDIR /home/denley
SHELL ["/bin/bash", "-c"]

# 配置git
RUN git config --global user.name "Denley Hsiao" \
  && git config --global user.email "denley@justtdodo.com"

# 安装brew
RUN mkdir -p $HOME/.linuxbrew \
  && chown -R denley: $HOME/.linuxbrew \
  && cd $HOME/.linuxbrew \
  && git clone https://github.com/Linuxbrew/brew.git

ENV PATH=$HOME/.linuxbrew/brew/bin:$PATH \
  LD_LIBRARY_PATH=$HOME/.linuxbrew/brew/lib:$LD_LIBRARY_PATH