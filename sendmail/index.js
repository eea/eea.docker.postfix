const express = require('express');
const app = express();
const bodyParser = require('body-parser');
const nodemailer = require('nodemailer');


let transporter = nodemailer.createTransport({
  host: 'localhost',
  port: 25,
  secure: false
});

app.use(bodyParser.json());

app.post('/', function (req, res) {
  let from, to, subject, text, html;
  try {
    ({from, to, subject, text, html} = req.body);
    to = to.join(); // merge comma separated email addresses
  } catch (err) {
    res.status(400).send("Error in parsing payload.\n" + err);
  }
  let mailOptions = {
    from: from,
    to: to,
    subject: subject,
    text: text,
    html: html
  };

  transporter.sendMail(mailOptions, (err, info) => {
    if (err) {
      res.status(500).send("Error in server." + err);
    } else {
      res.status(200).send(`Message sent: ${info.messageId}`);
    }
  });
});

app.listen(80, function () {
  console.log('sendmail app listening on port 80!');
});
