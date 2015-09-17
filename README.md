# Postfix Image for SMTP Auth

Available tags: [latest](https://github.com/eea/eea.docker.postfix/blob/master/Dockerfile), [eionet](https://github.com/eea/eea.docker.postfix/blob/master/eionet/Dockerfile).

This image is a CentOS 6 container running postfix preconfigured for SMTP relay authentication. It runs as an open relay mail server inside the Docker Containers internal network, so it can be used by any container to send emails through the remote relay.

The hostname of the postfix server is set in the environment variable `MTP_HOST` and is mandatory. Postfix will run as an open relay server only if the variables below are also set.

The relay is set in `MTP_RELAY` and the port in `MTP_PORT`.

The `.secrets` file should be used as a runtime environment variables, to set the user and password required for SMTP authentication by the `MTP_RELAY`:

    MTP_USER=user
    MTP_PASS=password

Basic way to get one instance up and running:

    docker run --rm  -t -i --env-file=.secret -v /etc/localtime:/etc/localtime:ro --name=postfix eeacms/postfix 

From the application container, running on the same docker host, one can set the SMTP server to the postfix container address.

Using the mount directive ```-v /etc/localtime:/etc/localtime:ro``` will make sure that the postfix container will share same timezone as the host, so that the emails have correct date and timestamps.

## Example usage

In the `example` folder, there is an example centos container than can be used to test connectivity.
    
    cd example
    docker build -t example .
    docker run --rm -it -v /etc/localtime:/etc/localtime:ro --link=postfix:postfixcontainer example
    
    # from commandline:
    $ mail test@example.com
    
    # from an application, python:
    $ python
    Python 2.6.6 (r266:84292, Jan 22 2014, 09:42:36) 
    [GCC 4.4.7 20120313 (Red Hat 4.4.7-4)] on linux2
    Type "help", "copyright", "credits" or "license" for more information.
    >>> import smtplib
    >>> s = smtplib.SMTP('postfixcontainer')
    >>> s.sendmail('test@example.eionet.europa.eu', ['user@example.com'], 'test')
    {}

## Existing container configuration

If you have an existing container that makes use of `/usr/bin/sendmail` to send emails, and you want to use this postfix image instead, you must modify your `Dockerfile` to :

Install mailx/ssmtp:

    # RUN apt-get install -y mailx ssmtp
    or
    # RUN yum install -y mailx ssmtp
    
Modify and copy / mount the `/etc/ssmtp.conf` file (see: https://github.com/eea/eea.docker.postfix/blob/master/example/ssmtp.conf). Change `mailhub` directive to the name of the postfixcontainer.

    # ADD ssmtp.conf /etc/ssmtp.conf
    
You can check the example image for more details.
