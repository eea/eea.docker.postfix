# Postfix Image for SMTP Auth

This image is a CentOS 7 container running postfix pre-configured for SMTP relay authentication.
It runs as an open relay mail server inside the Docker Containers internal network,
so it can be used by any container to send emails through the remote relay.

The hostname of the postfix server is set in the environment variable `MTP_HOST` and is mandatory.
Postfix will run as an open relay server only if the variables below are also set.

The relay is set in `MTP_RELAY` and the port in `MTP_PORT`.

## Supported tags and respective Dockerfile links

  - `:latest` [*Dockerfile*](https://github.com/eea/eea.docker.postfix/blob/master/Dockerfile) (default)
  - `:eionet` [*Dockerfile*](https://github.com/eea/eea.docker.postfix/blob/master/eionet/Dockerfile) (EEA specific)
  - `:2.10.1` [*Dockerfile*](https://github.com/eea/eea.docker.postfix/blob/2.10.1/Dockerfile) (centos 7, chaperone, support more environment variables)
  - `:2.10` [*Dockerfile*](https://github.com/eea/eea.docker.postfix/blob/2.10/Dockerfile) (centos 7, chaperone)
  - `:2.6` [*Dockerfile*](https://github.com/eea/eea.docker.postfix/blob/2.6/Dockerfile) (centos 6)

## Base docker image

 - [hub.docker.com](https://registry.hub.docker.com/u/eeacms/postfix)

## Source code

  - [github.com](http://github.com/eea/eea.docker.postfix)


The `.secrets` file should be used as a runtime environment variables,
to set the user and password required for SMTP authentication by the `MTP_RELAY`:

    MTP_USER=user
    MTP_PASS=password

Basic way to get one instance up and running:

    docker run --rm  -t -i -e MTP_HOST=mydomain.com --env-file=.secret -v /etc/localtime:/etc/localtime:ro --name=postfix eeacms/postfix 

From the application container, running on the same docker host, one can set the SMTP server to the postfix container address.

Using the mount directive ```-v /etc/localtime:/etc/localtime:ro``` will make sure that the postfix container will share same timezone as the host, so that the emails have correct date and timestamps.

## Example usage

From the postfix container ("postfix"):

    # from an application, python:
    $ python
    >>> import smtplib, os
    >>> s = smtplib.SMTP(os.getenv('HOSTNAME'))
    >>> s.sendmail('test@mydomain.com', ['user@example.com'], 'test')

From another application container ("app"):

    docker run --rm -it -v /etc/localtime:/etc/localtime:ro --name=app --link=postfix:postfixcontainer app_image

    # from an application, python:
    $ python
    >>> import smtplib
    >>> s = smtplib.SMTP('postfixcontainer')
    >>> s.sendmail('test@mydomain.com', ['user@example.com'], 'test')

## Supported environment variables

* `MTP_HOST` The `myhostname` parameter specifies the internet hostname of this mail system
* `MTP_DESTINATION` The `mydestination` parameter specifies the list of domains that this machine considers itself the final destination for.
* `MTP_BANNER` The `smtpd_banner` parameter specifies the text that follows the 220 code in the SMTP server's greeting banner.
* `MTP_RELAY` The `relayhost` parameter specifies the default host to send mail to when no entry is matched in the optional transport(5) table.
* `MTP_RELAY_DOMAINS` The `relay_domains` parameter restricts what destinations this system will relay mail to.
* `MTP_PORT` The `relayhost` port
* `MTP_USER` The user used to connect to the `relayhost`
* `MTP_PASS` The password used to connect to the `relayhost`
* `MTP_INTERFACES` The `inet_interfaces` parameter specifies the network interface addresses that this mail system receives mail on.

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
