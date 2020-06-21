FROM debian
MAINTAINER David Personette <dperson@gmail.com>

# Install PTS
RUN export DEBIAN_FRONTEND='noninteractive' && \
    export url='http://phoronix-test-suite.com/releases/' && \
    export version='9.6.1' && \
    export sha256sum='8afae3056aae06a9a5a8aa80e3706eeeb22e3b9ba7d6e7784506' && \
    apt-get update -qq && \
    apt-get install -qqy --no-install-recommends ca-certificates curl \
                build-essential unzip mesa-utils php7.3-cli php7.3-gd \
                php7.3-json php7.3-xml procps \
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