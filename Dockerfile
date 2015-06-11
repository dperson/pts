FROM debian:jessie
MAINTAINER David Personette <dperson@dperson.com>

# Install PTS
RUN export DEBIAN_FRONTEND='noninteractive' && \
    export url='http://www.phoronix-test-suite.com/releases/repo/pts.debian' &&\
    export version='5.8.0' && \
    export sha256sum='0affa1ac8c99e7c8557df92ec41094001e685e33259e53506ea7' && \
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
