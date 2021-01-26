const path = require("path");
const bodyParser = require("body-parser");
const express = require("express");
const fileUpload = require('express-fileupload');

const config = require("./config/config.js");
const port = global.gConfig.node_port;

const anubis = require("./anubis");


const app = express();
const http = require("http").createServer(app);

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(fileUpload());


anubis.start(app);

/* setup client */
app.use(express.static("client"));
app.use(express.static("public"));

/* filipizen client Handler */
const clientBuildPath = path.join(__dirname, "client");
app.get("/*", (req, res) => {
  res.sendFile(path.join(clientBuildPath, "index.html"));
});


http.listen(port, (err) => {
  if (err) {
    console.log(err);
  } else {
    console.log(`Server listening on port ${port}`);
  }
});
