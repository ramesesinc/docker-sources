const bodyParser = require("body-parser");
const express = require("express");

const config = require("./config/config.js");
const port = global.gConfig.node_port;

const app = express();
const http = require("http").createServer(app);

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());

const reportServer = require("./src/report-server");
reportServer.start(app);

http.listen(port, (err) => {
  if (err) {
    console.log(err);
  } else {
    console.log(`Jasper Report Server successfully started.`);
  }
});
