const serviceMgr = require("../lib/service-manager");
const Service = require("../lib/remote-server-proxy");
const errorHandlers = require("../modules/epayment/error-handlers");

const express = require("express");
const router = express.Router();
const aws = require("../lib/aws");


router.post('/attachment/upload', async (req, res) => {
  const key = req.body.key;
  if (!key) {
    return res.status(500).send({ msg: "key must be specified" })
  }
  if (!req.files || !req.files.file) {
      return res.status(500).send({ msg: "file is not found" })
  }

  aws.uploadObject(`${key}`, req.files.file.data)
    .then(data => {
      res.send({key: data.key, etag: data.ETag, location: data.Location});
    }).catch(err => {
      res.status(500).send({status: "ERROR", err});
    });
})

router.get('/attachment/download', (req, res) => {
  console.log("body", req.body);
  const key = req.query.key;
  if (!key) {
    return res.status(500).send({ msg: "key must be specified" })
  }
  aws.getObject(key)
    .then(data => {
      res.send(data.Body);
    }).catch(err => {
      res.status(500).send({status: "ERROR", err});
    });
})

router.delete('/attachment/delete', (req, res) => {
  const key = req.query.key;
  if (!key) {
    return res.status(500).send({ msg: "key must be specified" })
  }
  aws.deleteObject(key)
    .then(data => {
      res.status(200).send("ok");
    }).catch(err => {
      res.status(500).send({status: "ERROR", err});
    });
})

router.get('/attachment/list', (req, res) => {
  const prefix = req.query.prefix;
  if (!prefix) {
    return res.status(500).send({ msg: "prefix must be specified" })
  }
  aws.listObjects(prefix)
    .then(data => {
      res.status(200).send(data.Contents);
    }).catch(err => {
      res.status(500).send({status: "ERROR", err});
    });
})






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
})


const postPartnerPayment = async (params) => {
  const svc = Service.lookup("CloudPaymentService", "epayment");
  const pmt = await svc.invoke("postPartnerPayment", params);
  
  const remoteSvc = Service.lookup(`${pmt.orgcode}:EPaymentService`, "epayment");
  remoteSvc.invoke("postPayment", pmt)
    .then(() => console.log(`EPayment posted to partner ${pmt.orgcode}`))
    .catch(err => console.log("postPartnerPayment [Error]: Ignore, ", err));

  return pmt;
}


let partnerError = "Our partner was not able to process your payment."
partnerError += "Kindly verify that your credentials are correct upon submitting your payment.";


router.get("/payoptions/:statusid", async (req, res) => {
  console.log("GET===============================");
  console.log("PARAMS: ",req.params);
  console.log("QUERY: ", req.query);
  
  const statusid = req.params.statusid;
  if (/error/i.test(statusid)) {
    const handler = errorHandlers[statusid];
    const error = typeof(handler) === "function" ? await handler(req, res) : {};
    const errorArgs = encodeArgs(error);
    res.redirect(`/payment/error?${errorArgs}`);
  } else {
    try {
      const params = {statusid , ...req.body, ...req.query}
      const pmt = await postPartnerPayment(params);
      const args = buildArgs(pmt);
      res.redirect(`/payment/success?${args}`);
    } catch (err) {
      console.log("payoptions [ERROR]", err)
      res.redirect("/payment/error?message=Your payment was not successfully credited to your bill. Kindly contact the Treasurer's Office for assistance");
    }
  }
})

router.post("/payoptions/:statusid", async (req, res) => {
  console.log("POST===============================");
  console.log("PARAMS: ",req.params);
  console.log("QUERY: ", req.query);

  const statusid = req.params.statusid;
  if (/error/i.test(statusid)) {
    const handler = errorHandlers[statusid];
    const error = typeof(handler) === "function" ? await handler(req, res) : {};
    const errorArgs = encodeArgs(error);
    res.redirect(`/payment/error?${errorArgs}`);
  } else {
    try {
      const params = {statusid , ...req.body, ...req.query}
      const pmt = await postPartnerPayment(params);
      const args = buildArgs(pmt);
      res.redirect(`/payment/success?${args}`);
    } catch (err) {
      console.log("payoptions [ERROR]", err)
      res.redirect("/payment/error?message=Your payment was not successfully credited to your bill. Kindly contact the Treasurer's Office for assistance");
    }
  }
})

const buildArgs = (pmt) => {
  const data = {
    orgcode: pmt.orgcode,
    txnno: pmt.paymentrefid,
    txndate: pmt.txndate,
    amount: Number(pmt.amount),
    paypartnerid: pmt.paypartnerid.toLowerCase(),
    paidby: pmt.paidby,
    email: pmt.email,
  }
  return encodeArgs(data);
}

const encodeArgs = (data) => {
  const args = [];
  Object.keys(data).forEach(key =>
    args.push(`${key}=${encodeURIComponent(data[key])}`)
  );
  return args.join("&")
}

module.exports = router;
