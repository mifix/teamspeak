FROM docker.io/ubuntu:trusty
MAINTAINER wth-kiste

ENV TS_VERSION 3.5.1

# create user and add data dir
RUN useradd -m teamspeak && \
    mkdir -p /home/teamspeak/data && \
    chown -R teamspeak:teamspeak  /home/teamspeak/data

# install deps
RUN DEBIAN_FRONTEND=noninteractive apt-get -q update && apt-get install -qy --no-install-recommends ca-certificates curl bzip2

# install TS
RUN curl -LS http://dl.4players.de/ts/releases/${TS_VERSION}/teamspeak3-server_linux_amd64-${TS_VERSION}.tar.bz2 | tar jxC /tmp \
  && mv /tmp/teamspeak3-server_linux_amd64 /opt/teamspeak \
  && apt-get clean \
  && rm -rf /var/lib/apt /tmp/* /var/tmp/*


EXPOSE 9987/udp 10011 30033

VOLUME ["/home/teamspeak/data"]

WORKDIR /opt/teamspeak

USER teamspeak

RUN ln -s /home/teamspeak/data/ts3server.sqlitedb /opt/teamspeak/ts3server.sqlitedb

ENV TS3SERVER_LICENSE=accept

CMD LD_LIBRARY_PATH="/opt/teamspeak" /opt/teamspeak/ts3server logpath=/home/teamspeak/data/logs
