const bodyParser = require("body-parser");
const express = require("express");
const fileUpload = require('express-fileupload');
const fileServerRoutes = require("./routes/fileserver");

const config = require("./config/config.js");
const port = global.gConfig.node_port;

const app = express();
const http = require("http").createServer(app);

app.use(bodyParser.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(fileUpload());
app.use("/fileserver", fileServerRoutes);

app.use(express.static("public"));

http.listen(port, (err) => {
  if (err) {
    console.log(err);
  } else {
    console.log(`Server listening on port ${port}`);
    console.log("===================================");
  }
});
