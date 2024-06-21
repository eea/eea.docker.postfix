FROM rockylinux:9

MAINTAINER "European Environment Agency (EEA): IDM2 A-Team" <eea-edw-a-team-alerts@googlegroups.com>

EXPOSE 25

VOLUME ["/var/log", "/var/spool/postfix"]

RUN yum updateinfo -y && \
    yum update -y glibc && \
    yum install -y epel-release && \
    yum install -y supervisor python3 postfix cyrus-sasl cyrus-sasl-plain s-nail python3-pip && \
    yum clean all

COPY supervisord.conf /etc/supervisord.d/supervisord.conf

COPY docker-setup.sh /docker-setup.sh
RUN chmod +x /docker-setup.sh

ENTRYPOINT ["/usr/bin/supervisord", "-c", "/etc/supervisord.d/supervisord.conf"]
