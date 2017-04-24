FROM debian:stretch
MAINTAINER David Personette <dperson@gmail.com>

# Install PTS
RUN export DEBIAN_FRONTEND='noninteractive' && \
    export url='http://www.phoronix-test-suite.com/download.php?file=' && \
    export version='7.0.1' && \
    export sha256sum='436d949af604248776d725afb0f4eba6b8f9b1bf134d1f97544b' && \
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