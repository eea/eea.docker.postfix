# sendmail

- `sendmail` uses [nodemailer](https://nodemailer.com/) and [expressjs](http://expressjs.com/)
- can follow original eea.docker.postfix usage

## usage of sendmail

- sendmail nodejs server uses 80 port inside a container

```
# This example have mapped port as 8080 -> 80
$ sudo docker run --rm -p 8080:80 eubnara/postfix:0.1.0
Jan  1 13:19:18 784267207eb8 chaperone[1]: Switching all chaperone logging to /dev/log
Jan  1 13:19:18 784267207eb8 chaperone[1]: chaperone version 0.3.9, ready.
Jan  1 13:19:19 784267207eb8 sendmail[11]: sendmail app listening on port 80!
Jan  1 13:19:20 784267207eb8 postfix-script[86]: starting the Postfix mail system
Jan  1 13:19:20 784267207eb8 master[88]: daemon started -- version 2.10.1, configuration /etc/postfix
```

- send mail by requesting POST to specific port

```
$ curl -H "Content-type: application/json" localhost:8080 -d '{
"from": "eubnara@naver.com",
"to": ["eubnara@gmail.com", "yubi.lee@navercorp.com"],
"subject": "smtp test",
"text": "plain text",
"html": "<b>html</b>"
}'
Message sent: <e90882ea-0216-961a-3bd3-da2b0c711903@naver.com>
```

- you should send payload as json and also specifiy header(`Content-type: application/json`).


## docker image

- at https://hub.docker.com/r/eubnara/postfix/
