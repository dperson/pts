FROM debian
MAINTAINER David Personette <dperson@gmail.com>

# Install PTS
RUN export DEBIAN_FRONTEND='noninteractive' && \
    export url='http://phoronix-test-suite.com/releases/' && \
    export version='8.8.1' && \
    export sha256sum='d6feeeafb6d636667480b6fbfd2a6537e3b354b2c7c72305784d' && \
    apt-get update -qq && \
    apt-get install -qqy --no-install-recommends ca-certificates curl \
                build-essential unzip mesa-utils php7.0-cli php7.0-gd \
                php7.0-json php7.0-xml procps \
                $(apt-get -s dist-upgrade|awk '/^Inst.*ecurity/ {print $2}') &&\
    echo "downloading phoronix-test-suite-${version}.tar.gz ..." && \
    curl -LSs "${url}phoronix-test-suite-${version}.tar.gz" -o pts.tgz && \
    sha256sum pts.tgz | grep -q "$sha256sum" || \
        { echo "expected $sha256sum, got $(sha256sum pts.tgz)"; exit 13; } && \
    tar xf pts.tgz && \
    (cd phoronix-test-suite && ./install-sh) && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* phoronix-test-suite pts.tgz

CMD phoronix-test-suite