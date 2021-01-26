[findBatch]
SELECT
wbb.objid, 
wbb.mobilereading,
wbb.subareaid,
sa.code AS subareacode,
sa.barangay_name AS barangay,
sa.barangay_objid AS barangayid,
wa.code AS areacode,
wbp.year,
wbp.month,
wbp.fromdate,
wbp.todate,
wbp.duedate,
wbp.discdate,
wbb.reader_objid AS readerid,
wbb.reader_name AS readername
FROM waterworks_batch_billing wbb 
INNER JOIN waterworks_subarea sa ON wbb.subareaid = sa.objid
INNER JOIN waterworks_area wa ON  sa.areaid=wa.objid 
INNER JOIN waterworks_billing_period wbp ON wbb.periodid = wbp.objid 
WHERE wbb.objid = $P{batchid}

[getStubouts]
SELECT ws.objid, ws.subareaid, ws.code, ws.description, 
  sa.barangay_name AS barangay, ws.lng, ws.lat 
FROM waterworks_stubout ws 
INNER JOIN waterworks_subarea sa ON ws.subareaid = sa.objid 
INNER JOIN 
(
	SELECT wai.stuboutid 
	FROM waterworks_account_info wai 
	INNER JOIN waterworks_bill wb ON wb.acctinfoid = wai.objid 
	WHERE wb.batchid = $P{batchid} AND NOT(wai.stuboutid IS NULL) 
	GROUP BY wai.stuboutid 
) a ON ws.objid = a.stuboutid


[findBatchCount]
SELECT COUNT(*) AS count
FROM waterworks_bill b 
INNER JOIN waterworks_consumption wc ON b.consumptionid = wc.objid
WHERE b.batchid = $P{batchid}
AND wc.hold = 0

[getItems]
SELECT 
wb.objid, 
wb.consumptionid,
wb.batchid,
wb.billno, 
wa.seqno,
wa.acctno,
wai.acctname,
wai.classificationid AS classification,
wai.address_text AS address,
c.prev_reading AS prevreading,
wm.serialno AS meterserialno,
wm.brand AS meterbrand,
wm.capacity AS metercapacity,
wms.title AS metersize,
wms.objid AS metersizeid,
wb.balanceforward,
wai.stuboutid
FROM waterworks_bill wb
INNER JOIN waterworks_account wa ON wa.objid = wb.acctid
INNER JOIN waterworks_account_info wai ON wai.objid = wb.acctinfoid
INNER JOIN vw_waterworks_bill_consumption c ON wb.consumptionid = c.objid
LEFT JOIN waterworks_meter wm ON wai.meterid = wm.objid 
LEFT JOIN waterworks_metersize wms ON wm.sizeid = wms.objid
WHERE wb.batchid = $P{batchid}
AND c.hold = 0
LIMIT $P{start}, $P{limit}
