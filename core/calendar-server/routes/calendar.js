const calendar = require("../calendar/gcalendar");
const util = require("../lib/util");

const express = require("express");
const router = express.Router();


router.get("/event/authorization", async (req, res) => {
  const oAuth2Client = await calendar.getOAuthClient();
  const authUrl = calendar.getAccessTokenUrl(oAuth2Client);
  const html = [];
  html.push("<html>");
  html.push("<body>");
  html.push("<h2>Calendar Authorization</h2>");
  html.push("<h4>To authorize this Calendar</h4>");
  html.push("<ol>");
  html.push(`<li>Visit this <a href="${authUrl}" target="_blank">authorization link</a></li>`);
  html.push("<li>Login to your account if necessary</li>");
  html.push("<li>Follow the Authorization Wizard and grant access to all request</li>");
  html.push("<li>Copy the generated Access Token and paste on the Access Token field below</li>");
  html.push("<li>Click Submit to authorize the Calendar app</li>");
  html.push("</ol>");
  html.push("<br />");
  html.push(`<form method="post" action="/calendar/event/authorize">`)
  html.push("<label>Access Token</label>")
  html.push(`<input type="text" name="token" />`)
  html.push("<br />")
  html.push(`<button type="submit">Submit</button>`)
  html.push("</form>")
  html.push("</body>");
  html.push("</html>");
  res.send(html.join("\n"));
});

router.post("/event/authorize", async (req, res) => {
  if (!req.body.token) {
    res.status(400).send("Bad Request: token is required");
    return;
  } 

  try {
    const oAuth2Client = await calendar.getOAuthClient();
    calendar.saveAccessToken(oAuth2Client, req.body.token);
    res.send("OK");
  } catch (err) {
    res.status(400).send(err);
  }
});

router.get("/event/list", calendar.useCheckAuthorization, (req, res) => {
  calendar
    .listEvents(req, req.query)
    .then((data) => res.send(data))
    .catch((err) => {
      res.send({ error: err.toString() });
    });
});

router.post("/event/insert", calendar.useCheckAuthorization, async (req, res) => {
  const eventInfo = getEventInfo(req) || req.body;
  if (util.isObjectEmpty(eventInfo)) {
    res.status(400).send("Event is required.");
  } else {
    calendar
      .insertEvent(req, eventInfo)
      .then((data) => {
        console.log("Calendar event sent.");
        console.log("Event: ", data);
      })
      .catch((err) => res.send({ error: err.toString() }));
    res.send("OK")
  }
});


const getEventInfo = (req) => {
  if (req.body.data) {
    try {
      return JSON.parse(req.body.data);
    } catch (error) {
      throw { code: 400, error };
    }
  }
  return null;
};

module.exports = router;
