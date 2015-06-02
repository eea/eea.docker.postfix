# Postfix Image for SMTP Auth

Build:

    docker build -t eeacms/postfix . 

Update the `.secrets` with your smtp authentication.

Usage:

    docker run --rm  -t -i --env-file=.secret --name=postfix eeacms/postfix 

## Example usage

In the `example` folder, there is an example centos container than can be used to test connectivity.
    
    cd example
    docker build -t example .
    docker run --rm -it --link=postfix:postfixcontainer example
    
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