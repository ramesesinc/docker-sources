const path = require("path");
const fs = require("fs");
const AWS = require("aws-sdk");
const uuid = require("uuid");

const configOptions = {
  accessKeyId: process.env.fsAccessKey,
  secretAccessKey: process.env.fsSecretKey,
  region: process.env.fsRegion || "us-east-1"
};

const configFile = path.join(__dirname, "aws-config.json");
fs.writeFileSync(configFile, JSON.stringify(configOptions));
AWS.config.loadFromPath(configFile);

const API_VERSION = process.env.fsApiVersion || "2006-03-01";
const UPLOAD_BUCKET = process.env.fsUploadDir;

const createBucket = (bucketName) => {
  const Bucket = `${bucketName}-` + uuid.v4();
  return new AWS.S3({ apiVersion: API_VERSION })
    .createBucket({ Bucket: Bucket })
    .promise();
};

const uploadObject = (key, object) => {
  const objectParams = { Bucket: UPLOAD_BUCKET, Key: key, Body: object };
  return new AWS.S3({ apiVersion: API_VERSION }).upload(objectParams).promise();
};

const getObject = (key) => {
  const objectParams = { Bucket: UPLOAD_BUCKET, Key: key };
  return new AWS.S3({ apiVersion: API_VERSION })
    .getObject(objectParams)
    .promise();
};

const deleteObject = (key) => {
  const objectParams = { Bucket: UPLOAD_BUCKET, Key: key };
  return new AWS.S3({ apiVersion: API_VERSION })
    .deleteObject(objectParams)
    .promise();
};

const listObjects = (prefix) => {
  const objectParams = { Bucket: UPLOAD_BUCKET, Prefix: prefix };
  return new AWS.S3({ apiVersion: API_VERSION })
    .listObjects(objectParams)
    .promise();
};

module.exports = {
  createBucket,
  uploadObject,
  getObject,
  deleteObject,
  listObjects
};
