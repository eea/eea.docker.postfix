# Postfix Image for SMTP Auth

Build:

    docker build -t eeacms/postfix . 

Edit the `.secrets` with your smtp authentication.

Usage:

    docker run --rm  -t -i --env-file=.secret eeacms/postfix 
