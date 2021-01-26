const serviceMgr = require("../../lib/service-manager");

const errorHandlers = {};

const getOrgCode = async (poid) => {
  try {
    const svc = await serviceMgr.getService("CloudPaymentService", "getPaymentOrder", "epayment");
    const args = [{objid: poid}];
    const po = await svc.invoke(args);
    return po.orgcode;
  } catch (err) {
    console.log("getOrgCode [ERROR]", err);
    return null;
  }
}

/* 
* /payoptions/dbperror?message=error testing&responseCode=11&referenceCode=15400061EFWE7AP27N
*/
errorHandlers.dbperror = async function(req, res) {
  const error = {};
  if (req.query.responseCode) error.code = req.query.responseCode
  if (req.query.message) error.message = req.query.message;
  error.orgcode = await getOrgCode(req.query.referenceCode);
  return error;
}


/*
* /payoptions/landbankerror?MerchantCode=2018080027&Status=01&MerchantRefNo=154000CRT9KDVQ3J6K
*/
errorHandlers.landbankerror = async function(req, res) {
  const error = {}
  error.code = req.query.Status;
  error.orgcode = await getOrgCode(req.query.MerchantRefNo);
  return error;
}

/*
* /payoptions/paymayaerror?paymentrefid=000000E5UC4L02TYU3
*/
errorHandlers.paymayaerror = async function(req, res) {
  const error = {}
  error.orgcode = await getOrgCode(req.query.paymentrefid);
  return error;
}

module.exports = errorHandlers;

