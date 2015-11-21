FROM debian:jessie
MAINTAINER David Personette <dperson@dperson.com>

# Install PTS
RUN export DEBIAN_FRONTEND='noninteractive' && \
    export url='http://www.phoronix-test-suite.com/releases/repo/pts.debian' &&\
    export version='6.0.1' && \
    export sha256sum='7d6c8bc275f4625b970ada96b68a2d5a5d54e6d088e4d3ed120f' && \
    apt-get update -qq && \
    apt-get install -qqy --no-install-recommends curl build-essential unzip \
                perl perl-base perl-modules libsdl-perl libperl-dev \
                libpcre3-dev mesa-utils php5-cli php5-gd php5-json \
                $(apt-get -s dist-upgrade|awk '/^Inst.*ecurity/ {print $2}') &&\
    apt-get clean && \
    curl -LOC- -s $url/files/phoronix-test-suite_${version}_all.deb && \
    sha256sum phoronix-test-suite_${version}_all.deb | grep -q "$sha256sum" && \
    dpkg -i phoronix-test-suite_${version}_all.deb && \
    rm -rf /var/lib/apt/lists/* /tmp/* phoronix-test-suite_${version}_all.deb

CMD phoronix-test-suite
