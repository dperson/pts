FROM debian:jessie
MAINTAINER David Personette <dperson@dperson.com>

# Install PTS
RUN export DEBIAN_FRONTEND='noninteractive' && \
    export url='http://www.phoronix-test-suite.com/download.php?file=' && \
    export version='6.4.0' && \
    export sha256sum='9162975f690f9ea17df8f86ce2ee99b979434aea8242485fe2a4' && \
    apt-get update -qq && \
    apt-get install -qqy --no-install-recommends ca-certificates curl && \
    echo "deb http://packages.dotdeb.org jessie all" \
                >>/etc/apt/sources.list.d/dotdeb.list && \
    curl -Ls https://www.dotdeb.org/dotdeb.gpg | apt-key add - && \
    apt-get update -qq && \
    apt-get install -qqy --no-install-recommends build-essential unzip \
                mesa-utils php7.0-cli php7.0-gd php7.0-json php7.0-xml \
                $(apt-get -s dist-upgrade|awk '/^Inst.*ecurity/ {print $2}') &&\
    echo "downloading phoronix-test-suite_${version}.tgz ..." && \
    set -x && \
    curl -Ls "${url}phoronix-test-suite-${vesion}" -o pts.tgz && \
    sha256sum pts.tgz | grep -q "$sha256sum" && \
    tar xf pts.tgz && \
    (cd phoronix-test-suite && ./install-sh)
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /phoronix-test-suite /pts.tgz

CMD phoronix-test-suite