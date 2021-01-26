let appServer;

const start = (app) => {
  appServer = app;
  registerRoutes();
};

const server = {
  start,
}

const jreportRoutes = require("./routes/jreports")(server);

const registerRoutes = () => {
  appServer.use("/jreports", jreportRoutes);
};


module.exports = server;