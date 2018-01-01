FROM centos:7

MAINTAINER "European Environment Agency (EEA): IDM2 A-Team" <eea-edw-a-team-alerts@googlegroups.com>

RUN rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-CentOS-7 && \
    yum updateinfo -y && \
    yum update -y glibc && \
    yum install -y epel-release && \
    rpm --import /etc/pki/rpm-gpg/RPM-GPG-KEY-EPEL-7 && \
    yum install -y python34-devel postfix cyrus-sasl cyrus-sasl-plain mailx && \
    yum clean all

RUN curl https://bootstrap.pypa.io/get-pip.py | python3.4 && \
    pip3 install chaperone

RUN mkdir -p /etc/chaperone.d
COPY chaperone.conf /etc/chaperone.d/chaperone.conf

COPY docker-setup.sh /docker-setup.sh
RUN chmod +x /docker-setup.sh

RUN curl --silent --location https://rpm.nodesource.com/setup_7.x | bash -
RUN yum -y install nodejs
COPY sendmail /sendmail
WORKDIR "/sendmail"
RUN npm install

ENTRYPOINT ["/usr/bin/chaperone"]
