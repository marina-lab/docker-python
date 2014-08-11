FROM marina/centos7:7.0.1406_r1
MAINTAINER sprin

RUN yum install -y tar gcc make

RUN mkdir /usr/src/python
WORKDIR /usr/src/python
RUN curl -Sl "https://www.python.org/ftp/python/2.7.8/Python-2.7.8.tar.xz" \
    | tar -xJ --strip-components=1
# You may want to verify the download with gpg: https://www.python.org/download

RUN ./configure \
    && make  -j$(nproc) \
    && make install \
    && make clean

# Clean up steps prior to flattening
RUN yum remove -y tar gcc make \
    && yum clean all \
    && rm -rf /usr/src/python
