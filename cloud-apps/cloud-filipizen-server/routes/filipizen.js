const serviceMgr = require("../lib/service-manager");
const Service = require("../lib/remote-server-proxy");

const express = require("express");
const router = express.Router();

router.post("/attachment/upload", async (req, res) => {
  res.send({ key: key, etag: key, location: key });
});

router.get("/attachment/download", (req, res) => {
    res.send({data: {}});
});

router.delete("/attachment/delete", (req, res) => {
    res.status(200).send("ok");
});

router.get("/attachment/list", (req, res) => {
  res.status(200).send([]);
});


router.get("/service/metainfo", async (req, res) => {
  try {
    const { serviceName, connection } = req.query;
    const meta = await serviceMgr.getServiceMeta(serviceName, connection);
    res.send(meta);
  } catch (err) {
    res.status(400).send(err.toString());
  }
});

router.post("/service/invoke", async (req, res) => {
  const { service, args } = req.body;
  const { name: serviceName, action, connection } = service;
  try {
    const svc = Service.lookup(serviceName, connection);
    const data = await svc.invoke(action, args);
    res.send(data);
  } catch (err) {
    res.status(400).send(err.toString());
  }
});

const postPartnerPayment = async (params) => {
  const svc = Service.lookup("CloudPaymentService", "epayment");
  const pmt = await svc.invoke("postPartnerPayment", params);
  console.log("postPartnerPayment.postPartnerPayment===========================");
  console.log(pmt);
  console.log("postPartnerPayment.postPartnerPayment===========================");
  
  const remoteSvc = Service.lookup(
    `${pmt.orgcode}:EPaymentService`,
    "epayment"
  );
  remoteSvc
    .invoke("postPayment", pmt)
    .then(() => console.log(`EPayment posted to partner ${pmt.orgcode}`))
    .catch((err) => console.log("postPartnerPayment [Error]: Ignore, ", err));

  return pmt;
};

const postPartnerPaymentError = async (params) => {
  const svc = Service.lookup("CloudPaymentService", "epayment");
  const error = await svc.invoke("postPartnerPaymentError", params);
  console.log("postPartnerPayment.postPartnerPaymentError===========================");
  console.log(error);
  console.log("postPartnerPayment.postPartnerPaymentError===========================");
  return error;
};

router.get("/payoptions/:statusid", async (req, res) => {
  console.log("payoptions: GET===============================");
  console.log("PARAMS: ", req.params);
  console.log("QUERY: ", req.query);
  console.log("BODY: ", req.body);

  const statusid = req.params.statusid;
  if (/error/i.test(statusid)) {
    const params = { statusid, ...req.body, ...req.query };
    const error = await postPartnerPaymentError(params);
    const errorArgs = encodeArgs(error);
    res.redirect(`/payment/error?${errorArgs}`);
  } else {
    try {
      const params = { statusid, ...req.body, ...req.query };
      const pmt = await postPartnerPayment(params);
      const args = buildArgs(pmt);
      res.redirect(`/payment/success?${args}`);
    } catch (err) {
      console.log("payoptions [ERROR]", err);
      res.redirect(
        "/payment/error?message=Your payment was not successfully credited to your bill. Kindly contact the Treasurer's Office for assistance"
      );
    }
  }
});

router.post("/payoptions/:statusid", async (req, res) => {
  console.log("payoptions: POST===============================");
  console.log("PARAMS: ", req.params);
  console.log("QUERY: ", req.query);
  console.log("BODY: ", req.body);

  const statusid = req.params.statusid;
  if (/error/i.test(statusid)) {
    try {
      const params = { statusid, ...req.body, ...req.query };
      const error = await postPartnerPaymentError(params);
      const errorArgs = encodeArgs(error);
      res.redirect(`/payment/error?${errorArgs}`);
    } catch (err) {
      console.log("payoptions [ERROR]", err);
      res.redirect(
        "/payment/error?message=Your payment was not successfully credited to your bill. Kindly contact payment partner for assistance"
      );
    }
  } else {
    try {
      const params = { statusid, ...req.body, ...req.query };
      const pmt = await postPartnerPayment(params);
      const args = buildArgs(pmt);
      res.redirect(`/payment/success?${args}`);
    } catch (err) {
      console.log("payoptions [ERROR]", err);
      res.redirect(
        "/payment/error?message=Your payment was not successfully credited to your bill. Kindly contact payment partner for assistance"
      );
    }
  }
});

router.post("/webhooks/:paypartnerid", async (req, res) => {
  console.log("WEBHOOK POST===============================");
  console.log("REQUEST => ", req);

  const params = {
    ...req.params,
    ...req.query,
    data: req.body
  }

  try {
    const svc = Service.lookup("CloudPaymentService", "epayment");
    const retval = await svc.invoke("postPartnerWebhook", params);
    if (retval.response) {
      res.json(retval.response);
    } else {
      res.sendStatus(retval.status);
    }
  } catch (err) {
    console.log("WEBHOOK [ERROR] ", err);
    res.sendStatus(503);
  }
});


const buildArgs = (pmt) => {
  const data = {
    orgcode: pmt.orgcode,
    txnno: pmt.paymentrefid,
    txndate: pmt.txndate,
    amount: Number(pmt.amount),
    paypartnerid: pmt.paypartnerid.toLowerCase(),
    paidby: pmt.paidby,
    email: pmt.email,
  };
  return encodeArgs(data);
};

const encodeArgs = (data) => {
  const args = [];
  Object.keys(data).forEach((key) =>
    args.push(`${key}=${encodeURIComponent(data[key])}`)
  );
  return args.join("&");
};

module.exports = router;
