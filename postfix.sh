#!/bin/bash

# Set up user
function setup_secret {
    echo "$MTP_HOST   $MTP_USER:$MTP_PASS" > /etc/postfix/relay_passwd
    postmap /etc/postfix/relay_passwd
}

setup_secret

postfix start

tail -f /var/log/mail.log
