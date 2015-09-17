FROM centos:6

RUN yum -y install postfix mailx cyrus-sasl cyrus-sasl-plain python-setuptools python-pip rsyslog

VOLUME ["/var/log"]

ADD postfix.sh /postfix.sh

CMD ["sh", "-c", "/postfix.sh"]
