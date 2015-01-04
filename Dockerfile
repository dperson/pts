FROM ubuntu:trusty
MAINTAINER David Personette <dperson@dperson.com>

# Phoronix test suite file info
ENV DEBIAN_FRONTEND noninteractive
ENV version 5.4.1
ENV sha256sum 8b5dbaf52c57fd658d6d914c27b71811d46849ff4ee25f8fb64c9758071ea6e1

# Install PTS
RUN apt-get update -qq && \
    apt-get install -qqy --no-install-recommends curl build-essential unzip \
                perl perl-base perl-modules libsdl-perl libperl-dev \
                libpcre3-dev mesa-utils php5-cli php5-gd php5-json && \
    apt-get clean && \
    curl -LOC- -s http://www.phoronix-test-suite.com/releases/repo/pts.debian/files/phoronix-test-suite_${version}_all.deb && \
    sha256sum phoronix-test-suite_${version}_all.deb | grep -q "$sha256sum" && \
    dpkg -i phoronix-test-suite_${version}_all.deb && \
    rm -rf /var/lib/apt/lists/* /tmp/* phoronix-test-suite_${version}_all.deb

ENTRYPOINT ["phoronix-test-suite"]
