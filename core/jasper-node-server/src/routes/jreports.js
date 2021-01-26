const path = require("path");
const express = require("express");
const router = express.Router();

let reportServer;

const Service = require("../lib/remote-server-proxy");

const generateReport = (req) => {
  const { modulename, reportid, org } = req.params;
  const jasperSvc = Service.lookup("JasperReportService", modulename);
  const reportParams = { org, modulename, reportid,  ...req.query };
  return jasperSvc.invoke("generateReport", reportParams);
}


/*=======================================
**
** local report and download
**
=======================================*/
router.get("/:modulename/:reportid", async (req, res) => {
  try {
    const report = await generateReport(req);
    const reportFile = path.resolve("reports", `${report.tokenid}.pdf`);
    res.sendFile(reportFile);
  } catch (err) {
    res.status(400).send({ status: "ERROR", error: err.toString() });
  }
});

/* local report: download */
router.get("/download/:modulename/:reportid", async (req, res) => {
  try {
    const report = await generateReport(req);
    const reportFile = path.resolve("reports", `${report.tokenid}.pdf`);
    res.setHeader('Content-Disposition', `attachment; filename=${report.tokenid}.pdf`);
    res.sendFile(reportFile);
  } catch (err) {
    res.status(400).send({ status: "ERROR", error: err.toString() });
  }
});


/*=======================================
**
** local org report and download
**
=======================================*/
router.get("/partner/:org/:modulename/:reportid", async (req, res) => {
  try {
    const report = await generateReport(req);
    const reportFile = path.resolve("reports", `${report.tokenid}.pdf`);
    console.log("reportFile: ", reportFile);
    res.sendFile(reportFile);
  } catch (err) {
    res.status(400).send({ status: "ERROR", error: err.toString() });
  }
});

/* local report: download */
router.get("/download/partner/:org/:modulename/:reportid", async (req, res) => {
  try {
    const report = await generateReport(req);
    const reportFile = path.resolve("reports", `${report.tokenid}.pdf`);
    console.log("reportFile: ", reportFile);
    res.setHeader('Content-Disposition', `attachment; filename=${report.tokenid}.pdf`);
    res.sendFile(reportFile);
  } catch (err) {
    res.status(400).send({ status: "ERROR", error: err.toString() });
  }
});

/* remote report */
router.get("/partners/:partner/reports/:modulename/:reportid", async (req, res) => {
  try {
    const report = await generateReport(req);
    const reportFile = path.resolve("reports", `${report.tokenid}.pdf`);
    res.sendFile(reportFile);
  } catch (err) {
    res.status(400).send({ status: "ERROR", error: err.toString() });
  }
});

/* remote report: download */
router.get("/partners/:partner/reports/download/:modulename/:reportid", async (req, res) => {
  try {
    const report = await generateReport(req);
    const reportFile = path.resolve("reports", `${report.tokenid}.pdf`);
    res.setHeader('Content-Disposition', `attachment; filename=${report.tokenid}.pdf`);
    res.sendFile(reportFile);
  } catch (err) {
    res.status(400).send({ status: "ERROR", error: err.toString() });
  }
});

module.exports = (server) => {
  reportServer = server;
  return router;
};
