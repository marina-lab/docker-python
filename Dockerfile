FROM centos:7.0.1406
MAINTAINER sprin
# Inspired by docker-library/python

# Disable fastermirror plugin - not using it is actually faster.
RUN sed -ri 's/^enabled=1/enabled=0/' /etc/yum/pluginconf.d/fastestmirror.conf

# Install Python deps
RUN yum install -y \
    tar \
    gcc \
    make \
    zlib-devel \
    openssl-devel \
    sqlite-devel \
    bzip2-devel \
    libxslt-devel \
    postgresql-devel \
    && yum clean all

# You may want to verify the download with gpg: https://www.python.org/download
RUN set -x \
    && mkdir -p /usr/src/python \
    && curl -Sl "https://www.python.org/ftp/python/2.7.9/Python-2.7.9.tar.xz" \
        | tar -xJC /usr/src/python --strip-components=1 \
    && cd /usr/src/python \
    && ./configure \
        --enable-shared \
         --prefix=/usr/local \
        --with-ensurepip=install \
        LDFLAGS="-Wl,-rpath /usr/local/lib" \
    && make  -j$(nproc) \
    && make install \
    && make clean \
    && ldconfig -v \
    && find /usr/local \
      \( -type d -a -name test -o -name tests \) \
      -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
      -exec rm -rf '{}' + \
    && rm -rf /usr/src/python
