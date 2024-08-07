# Postfix SMTP only with relay support

Postfix SMTP only Docker image with SMTP relay support.

 - Rocky Linux: **9.3**
 - Postfix: **3.5.9**
 - Expose: **25**

## Supported tags and respective Dockerfile links

> [!IMPORTANT]
> Starting with the release **3.5-1.0**, the `MTP_USER` and `MTP_PASS` variables became mandatory, as without them, emails are rejected as **SPAM** and are not sent

   
  - `:latest` [*Dockerfile*](https://github.com/eea/eea.docker.postfix/blob/master/Dockerfile) - Rocky Linux: **9.3** Postfix: **3.5.9**

  - `:3.5-1.0` [*Dockerfile*](https://github.com/eea/eea.docker.postfix/blob/master/Dockerfile) - Rocky Linux: **9.3** Postfix: **3.5.9**

  - `:2.10-3.8` [*Dockerfile*](https://github.com/eea/eea.docker.postfix/blob/2.10-3.8/Dockerfile) - CentOS: **7** Postfix: **2.10.1**

See [older versions](https://github.com/eea/eea.docker.postfix/releases)


## Base docker image

 - [hub.docker.com](https://hub.docker.com/r/eeacms/postfix)


## Source code

  - [github.com](http://github.com/eea/eea.docker.postfix)


## Usage

Start postfix (to send emails using postfix within container)

    $ docker run --rm --name=postfix \
                 -e  MTP_HOST=foo.com \
             eeacms/postfix

or start postfix (to send emails by using a remote email server)

    $ docker run --rm --name=postfix \
                 -e MTP_HOST=foo.com \
                 -e MTP_RELAY=smtp.gmail.com \
                 -e MTP_USER=foo \
                 -e MTP_PASS=secret \
             eeacms/postfix

Start sending emails:

    $ docker run -it --rm --link=postfix busybox sh
      $ telnet postfix 25
      HELO foo.com
      MAIL FROM: bar@foo.com
      RCPT TO: foo@bar.com
      DATA
      subject: Test
      Testing 1, 2, 3
      .
      quit


## Supported environment variables

* `MTP_HOST` The `myhostname` parameter specifies the internet hostname of this mail system
* `MTP_DESTINATION` The `mydestination` parameter specifies the list of domains that this machine considers itself the final destination for.
* `MTP_BANNER` The `smtpd_banner` parameter specifies the text that follows the 220 code in the SMTP server's greeting banner.
* `MTP_RELAY` The `relayhost` parameter specifies the default host to send mail to when no entry is matched in the optional transport(5) table.
* `MTP_RELAY_DOMAINS` The `relay_domains` parameter restricts what destinations this system will relay mail to.
* `MTP_PORT` The `relayhost` port.
* `MTP_USER` The user used to connect to the `relayhost`.
* `MTP_PASS` The password used to connect to the `relayhost`.
* `MTP_INTERFACES` The `inet_interfaces` parameter specifies the network interface addresses that this mail system receives mail on.
* `MTP_PROTOCOLS` The `inet_protocols` parameter specifies the network interface protocol. Can be set to `all`, `ipv4`,`ipv6` or `ipv4,ipv6`. The default value is `all`.
* `MTP_MS_SIZE_LIMIT` If set, will configure email size limit.
* `SMTPD_TLS_SECURITY_LEVEL` The SMTP TLS security level for the Postfix SMTP server. Default value: none. Possible values: none(TLS will not be used), may( Opportunistic TLS), encrypt(Mandatory TLS encryption)
* `SMTP_TLS_SECURITY_LEVEL` The default SMTP TLS security level for the Postfix SMTP client. Default value: may. Possible values: none(TLS will not be used), may( Opportunistic TLS), encrypt(Mandatory TLS encryption)


## Copyright and license

The Initial Owner of the Original Code is European Environment Agency (EEA).
All Rights Reserved.

The Original Code is free software;
you can redistribute it and/or modify it under the terms of the GNU
General Public License as published by the Free Software Foundation;
either version 2 of the License, or (at your option) any later
version.


## Funding

[European Environment Agency (EU)](http://eea.europa.eu)
