// Load the SDK and UUID
const path = require("path");
const AWS = require("aws-sdk");
const uuid = require("uuid");

const configPath = path.join(__dirname, "..", "config.json");
AWS.config.loadFromPath(configPath);

const API_VERSION = "2006-03-01";
const UPLOAD_BUCKET = "uploads-89aec797-f5e4-4778-b4a0-3a324906ef50";

const createBucket = (bucketName) => {
  const Bucket = `${bucketName}-` + uuid.v4();
  return new AWS.S3({ apiVersion: API_VERSION })
    .createBucket({ Bucket: Bucket })
    .promise();
};

const uploadObject = (key, object) => {
  const objectParams = { Bucket: UPLOAD_BUCKET, Key: key, Body: object };
  return new AWS.S3({ apiVersion: API_VERSION })
    .upload(objectParams)
    .promise();
};

const getObject = (key) => {
  const objectParams = { Bucket: UPLOAD_BUCKET, Key: key};
  return new AWS.S3({ apiVersion: API_VERSION })
    .getObject(objectParams)
    .promise();
};

const deleteObject = (key) => {
  const objectParams = { Bucket: UPLOAD_BUCKET, Key: key};
  return new AWS.S3({ apiVersion: API_VERSION })
    .deleteObject(objectParams)
    .promise();
};

const listObjects = (prefix) => {
  const objectParams = { Bucket: UPLOAD_BUCKET, Prefix: prefix};
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
