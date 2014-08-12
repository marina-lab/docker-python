FROM marina/centos7:7.0.1406_r2
MAINTAINER sprin

# Disable fastestmirror plugin and install Python deps
RUN yum install -y \
    tar \
    gcc \
    make \
    zlib-devel \
    openssl-devel \
    sqlite-devel \
    bzip2-devel \
    libxslt-devel \
    postgresql-devel

RUN mkdir /usr/src/python
WORKDIR /usr/src/python
RUN curl -Sl "https://www.python.org/ftp/python/2.7.8/Python-2.7.8.tar.xz" \
    | tar -xJ --strip-components=1
# You may want to verify the download with gpg: https://www.python.org/download

RUN ./configure \
    && make  -j$(nproc) \
    && make install \
    && make clean

# Install pip
RUN curl -Sl "https://bootstrap.pypa.io/get-pip.py" > get-pip.py
RUN /usr/local/bin/python get-pip.py

# Clean up steps prior to flattening
RUN yum clean all \
    && rm -rf /usr/src/python
