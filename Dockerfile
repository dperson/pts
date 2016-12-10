FROM debian:stretch
MAINTAINER David Personette <dperson@gmail.com>

# Install PTS
RUN export DEBIAN_FRONTEND='noninteractive' && \
    export url='http://www.phoronix-test-suite.com/download.php?file=' && \
    export version='6.8.0' && \
    export sha256sum='fe741336dbf251fc210367b20713b554b3fd4edf15cf1f5950ff' && \
    apt-get update -qq && \
    apt-get install -qqy --no-install-recommends ca-certificates curl \
                build-essential unzip mesa-utils php7.0-cli php7.0-gd \
                php7.0-json php7.0-xml procps \
                $(apt-get -s dist-upgrade|awk '/^Inst.*ecurity/ {print $2}') &&\
    echo "downloading phoronix-test-suite_${version}.tgz ..." && \
    curl -Ls "${url}phoronix-test-suite-${version}" -o pts.tgz && \
    sha256sum pts.tgz | grep -q "$sha256sum" && \
    tar xf pts.tgz && \
    (cd phoronix-test-suite && ./install-sh) && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /phoronix-test-suite /pts.tgz

CMD phoronix-test-suite