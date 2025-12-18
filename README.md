# Postfix SMTP only with relay support

Postfix SMTP only Docker image with SMTP relay support.

 - Rocky Linux: **9.3**
 - Postfix: **3.5.25**
 - Expose: **25**

## Supported tags and respective Dockerfile links

> [!IMPORTANT]
> Starting with the release **3.5-1.0**, the `MTP_USER` and `MTP_PASS` variables became mandatory, as without them, emails are rejected as **SPAM** and are not sent

   
  - `:latest` [*Dockerfile*](https://github.com/eea/eea.docker.postfix/blob/master/Dockerfile) - Rocky Linux: **9.3** Postfix: **3.5.25**
  - `:3.5-1.1` [*Dockerfile*](https://github.com/eea/eea.docker.postfix/blob/master/Dockerfile) - Rocky Linux: **9.3** Postfix: **3.5.25**
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

* `MTP_HOST` – Defines the `myhostname` value, representing the public internet hostname of this mail system.
* `MTP_DESTINATION` – Sets `mydestination`, the list of domains for which this host is considered the final mail destination.
* `MTP_BANNER` – Configures `smtpd_banner`, the text displayed after the 220 response in the SMTP greeting.
* `MTP_RELAY` – Specifies `relayhost`, the default server used to forward outgoing mail when no transport rule matches.
* `MTP_RELAY_DOMAINS` – Limits the set of destination domains for which this system is allowed to relay mail.
* `MTP_PORT` – Defines the port used when connecting to the relay host.
* `MTP_USER` – Username used to authenticate with the relay host.
* `MTP_PASS` – Password used to authenticate with the relay host.
* `MTP_INTERFACES` – Sets `inet_interfaces`, controlling the network interfaces on which Postfix listens for incoming mail.
* `MTP_PROTOCOLS` – Sets `inet_protocols`, specifying the IP protocol(s) to use (`all`, `ipv4`, `ipv6`, or `ipv4,ipv6`; default: `all`).
* `MTP_MS_SIZE_LIMIT` – When defined, configures the maximum allowed email size.
* `SMTPD_TLS_SECURITY_LEVEL` – TLS security level for the Postfix SMTP **server** (default: `none`; values: `none`, `may` – opportunistic TLS, `encrypt` – mandatory TLS).
* `SMTP_TLS_SECURITY_LEVEL` – TLS security level for the Postfix SMTP **client** (default: `may`; values: `none`, `may` – opportunistic TLS, `encrypt` – mandatory TLS).


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
