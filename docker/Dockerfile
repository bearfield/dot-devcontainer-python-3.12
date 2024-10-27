ARG BASE_IMAGE_TAG=bookworm

FROM ghcr.io/bearfield/debian-fish:${BASE_IMAGE_TAG}
#
# set argument
ARG PYTHON_VERSION=3.12.7
ARG USER_NAME=kumano_ryo
#
# Add HashiCorp Linux repository and install terraform.
USER root
SHELL ["/bin/bash", "-c"]
# 必要なパッケージのインストール
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        wget \
        build-essential \
        libffi-dev \
        libgdbm-dev \
        libc6-dev \
        libssl-dev \
        zlib1g-dev \
        libbz2-dev \
        libreadline-dev \
        libsqlite3-dev \
        libncurses5-dev \
        libncursesw5-dev \
        xz-utils \
        tk-dev \
    && rm -rf /var/lib/apt/lists/*

# Python 3.12のソースをダウンロード、展開、ビルド、インストール
RUN wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz \
    && tar -xvf Python-${PYTHON_VERSION}.tgz \
    && cd Python-${PYTHON_VERSION} \
    && ./configure --enable-optimizations \
    && make -j`nproc` \
    && make altinstall \
    && cd .. \
    && rm -rf Python-${PYTHON_VERSION} \
    && rm Python-${PYTHON_VERSION}.tgz

# デフォルトのPythonバージョンを3.12に設定
RUN update-alternatives --install /usr/bin/python python /usr/local/bin/python3.12 1
# pipのインストール
RUN wget https://bootstrap.pypa.io/get-pip.py \
    && python get-pip.py \
    && rm get-pip.py
# pyenvのインストール(pipenvのpythonバージョン管理に必要)
USER $USER_NAME
RUN git clone https://github.com/pyenv/pyenv.git ~/.pyenv \
    && cd ~/.pyenv && src/configure && make -C src
# pipenvのインストール
USER root
RUN pip install pipenv
#
# set env
ENV DEBIAN_FRONTEND=dialog
LABEL org.opencontainers.image.source=https://github.com/bearfield/dot-devcontainer-python-3.12