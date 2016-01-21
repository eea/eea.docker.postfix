# Postfix Image for SMTP Auth

Available tags: [latest](https://github.com/eea/eea.docker.postfix/blob/master/Dockerfile), [eionet](https://github.com/eea/eea.docker.postfix/blob/master/eionet/Dockerfile).

This image is a CentOS 7 container running postfix preconfigured for SMTP relay authentication. It runs as an open relay mail server inside the Docker Containers internal network, so it can be used by any container to send emails through the remote relay.

The hostname of the postfix server is set in the environment variable `MTP_HOST` and is mandatory. Postfix will run as an open relay server only if the variables below are also set.

The relay is set in `MTP_RELAY` and the port in `MTP_PORT`.

The `.secrets` file should be used as a runtime environment variables, to set the user and password required for SMTP authentication by the `MTP_RELAY`:

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
