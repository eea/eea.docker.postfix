# Postfix Image for SMTP Auth

Build:

    docker build -t eeacms/postfix . 

Update the `.secrets` with your smtp authentication.

Usage:

    docker run --rm  -t -i --env-file=.secret --name=postfix eeacms/postfix 

## Example usage

Run:
    
    cd example
    docker build -t example .
    docker run --rm -it --link=postfix:postfixcontainer example
    
    mail test@example.com
    
    # mail should be sent by the postfix container