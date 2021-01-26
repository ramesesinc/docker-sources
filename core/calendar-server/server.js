const bodyParser = require("body-parser");
const express = require("express");
const gcalendar = require("./calendar/gcalendar");
const calendarRoutes = require("./routes/calendar");

const config = require("./config/config.js");
const port = global.gConfig.node_port;

const app = express();
const http = require("http").createServer(app);

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(express.static("public"));
app.use("/calendar", calendarRoutes);

gcalendar.init(app);

http.listen(port, (err) => {
  if (err) {
    console.log(err);
  } else {
    console.log(`Calendar server started...`);
  }
});
