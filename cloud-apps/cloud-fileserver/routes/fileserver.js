const express = require("express");
const router = express.Router();
const aws = require("../lib/aws");

router.post('/upload', async (req, res) => {
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
      console.log("UPLOAD [error] ", err)
      res.status(500).send({status: "ERROR", err});
    });
})

router.get('/download', (req, res) => {
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

router.delete('/delete', (req, res) => {
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

router.get('/list', (req, res) => {
  const prefix = req.query.prefix;
  if (!prefix) {
    return res.status(500).send({ msg: "prefix must be specified" })
  }
  aws.listObjects(prefix)
    .then(data => {
      res.status(200).send(data.Contents);
    }).catch(err => {
      console.log("get [ERROR]", err)
      res.status(500).send({status: "ERROR", err});
    });
})


module.exports = router;
