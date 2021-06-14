FROM centos:8

MAINTAINER "European Environment Agency (EEA): IDM2 A-Team" <eea-edw-a-team-alerts@googlegroups.com>

EXPOSE 25

VOLUME ["/var/log", "/var/spool/postfix"]


RUN dnf install -y python3 postfix cyrus-sasl cyrus-sasl-plain mailx && \
    dnf clean all

RUN python3 -m pip install chaperone

RUN mkdir -p /etc/chaperone.d
COPY chaperone.conf /etc/chaperone.d/chaperone.conf

COPY docker-setup.sh /docker-setup.sh
RUN chmod +x /docker-setup.sh

ENTRYPOINT ["/usr/local/bin/chaperone"]
