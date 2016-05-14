FROM docker.io/ubuntu:wily
MAINTAINER wth-kiste

ENV TS_VERSION 3.0.12.4

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


CMD LD_LIBRARY_PATH="/opt/teamspeak" /opt/teamspeak/ts3server logpath=/home/teamspeak/data/logs
