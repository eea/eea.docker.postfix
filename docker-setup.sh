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
    postconf -e 'local_recipient_maps ='

    echo "$MTP_RELAY   $MTP_USER:$MTP_PASS" > /etc/postfix/relay_passwd
    postmap /etc/postfix/relay_passwd
}

postconf -e "myhostname = $MTP_HOST"
postconf -e 'inet_interfaces = all'

if [ ! -z "$MTP_RELAY" -a ! -z "$MTP_PORT" -a ! -z "$MTP_USER" -a ! -z "$MTP_PASS" ]; then
    setup_conf_and_secret
else
    postconf -e 'mynetworks = 127.0.0.1/32 192.168.0.0/16 172.16.0.0/12 10.0.0.0/8'
fi

newaliases
