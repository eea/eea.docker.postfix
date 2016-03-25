#!/bin/bash

# configure postfix

function setup_conf_and_secret {
    postconf -e 'smtp_tls_CAfile = /etc/ssl/certs/ca-bundle.trust.crt'
    postconf -e "relayhost = [$MTP_RELAY]:$MTP_PORT"
    postconf -e 'smtp_sasl_auth_enable = yes'
    postconf -e 'smtp_sasl_password_maps = hash:/etc/postfix/relay_passwd'
    postconf -e 'smtp_sasl_security_options = noanonymous'
    postconf -e 'smtp_tls_security_level = may'
    postconf -e 'mynetworks = 127.0.0.0/8 172.17.0.0/16'

    echo "$MTP_RELAY   $MTP_USER:$MTP_PASS" > /etc/postfix/relay_passwd
    postmap /etc/postfix/relay_passwd
}

if [ -z "$MTP_INTERFACES" ]; then
  postconf -e 'inet_interfaces = all'
else
  postconf -e 'inet_interfaces = $MTP_INTERFACES'
fi

if [ ! -z "$MTP_HOST" ]; then
  postconf -e 'myhostname = $MTP_HOST'
fi

if [ ! -z "$MTP_DESTINATION" ]; then
  postconf -e 'mydestination = $MTP_DESTINATION'
fi

if [ ! -z "$MTP_BANNER" ]; then
  postconf -e 'smtpd_banner = $MTP_BANNER'
fi

if [ ! -z "$MTP_RELAY_DOMAINS" ]; then
  postconf -e 'relay_domains = $MTP_RELAY_DOMAINS'
fi

if [ ! -z "$MTP_RELAY" -a ! -z "$MTP_PORT" -a ! -z "$MTP_USER" -a ! -z "$MTP_PASS" ]; then
    setup_conf_and_secret
else
    postconf -e 'mynetworks = 127.0.0.1/32 192.168.0.0/16 172.16.0.0/12 10.0.0.0/8'
fi

newaliases
