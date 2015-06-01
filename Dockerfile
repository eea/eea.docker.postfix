FROM centos:centos7

ENV MTP_HOST=fwd.example.com
ENV MTP_PORT=25
ENV MTP_USER=user
ENV MTP_PASS=password

RUN yum -y install postfix mailx cyrus-sasl cyrus-sasl-plain python-setuptools python-pip
RUN curl https://bootstrap.pypa.io/get-pip.py | python -
RUN pip install supervisor
RUN mkdir -p /etc/supervisor.d/conf.d
RUN echo_supervisord_conf > /etc/supervisord.conf
RUN echo '[include]' >> /etc/supervisord.conf
RUN echo 'files = supervisor/conf.d/*.conf' >> /etc/supervisord.conf

RUN postconf -e "relayhost = [$MTP_HOST]:$MTP_PORT"
RUN postconf -e 'smtp_sasl_auth_enable = yes'
RUN postconf -e 'smtp_sasl_password_maps = hash:/etc/postfix/relay_passwd'
RUN postconf -e 'smtp_sasl_security_options = noanonymous'
RUN postconf -e 'smtp_tls_security_level = may'
RUN touch /var/log/mail.log
RUN mkdir -p /var/spool/postfix/public/
RUN mkfifo /var/spool/postfix/public/pickup

EXPOSE 25
VOLUME ["/var/log", "/var/spool/postfix"]

ADD postfix.sh /postfix.sh
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["sh", "-c", "/usr/bin/supervisord""]