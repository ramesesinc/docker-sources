[getAccountsForBilling]
SELECT a.* FROM 
(SELECT wbb.objid AS batchid, wa.objid, wa.state, wa.acctno, wa.acctname, wbp.year AS lastbillyear, wbp.month AS lastbillmonth,
CASE 
	WHEN 
		wa.state = 'DRAFT' AND wb.objid IS NULL
	THEN 'Account is still in DRAFT status'
	WHEN 
	   wa.state = 'DRAFT' AND ((wbp.year*12)+wbp.month) = (((wbbp.year*12)+wbbp.month) - 1)
	THEN 'Account is still in DRAFT status'
	WHEN 
		NOT(wbp.objid IS NULL) AND NOT((wbp.year*12)+wbp.month) = (((wbbp.year*12)+wbbp.month) - 1)
	THEN 'Latest bill generated is not prior period' 
	ELSE NULL
END AS errmsg	
FROM vw_waterworks_account wa 
LEFT JOIN waterworks_bill wb ON wa.billid = wb.objid 
LEFT JOIN waterworks_billing_period wbp ON wb.periodid = wbp.objid 
INNER JOIN waterworks_batch_billing wbb ON wa.subareaid = wbb.subareaid
INNER JOIN waterworks_billing_period wbbp ON wbb.periodid = wbbp.objid 
WHERE wbb.objid = $P{batchid}
AND wa.excludeinbatch = ${excludeinbatch} ) a
WHERE ${filter}
LIMIT $P{start}, $P{limit}

[findInvalidAccountsForBillingCount]
SELECT COUNT(*) AS count FROM 
(SELECT wbb.objid 
CASE 
	WHEN 
		wa.state = 'DRAFT' AND wb.objid IS NULL
	THEN 1
	WHEN 
	   wa.state = 'DRAFT' AND ((wbp.year*12)+wbp.month) = (((wbbp.year*12)+wbbp.month) - 1)
	THEN 1
	WHEN 
		NOT(wbp.objid IS NULL) AND NOT((wbp.year*12)+wbp.month) = (((wbbp.year*12)+wbbp.month) - 1)
	THEN 1
	ELSE 0
END AS errstate	
FROM vw_waterworks_account wa 
LEFT JOIN waterworks_bill wb ON wa.billid = wb.objid 
LEFT JOIN waterworks_billing_period wbp ON wb.periodid = wbp.objid 
INNER JOIN waterworks_batch_billing wbb ON wa.subareaid = wbb.subareaid
INNER JOIN waterworks_billing_period wbbp ON wbb.periodid = wbbp.objid 
WHERE wbb.objid = $P{batchid}
AND wa.excludeinbatch = 0 ) a
WHERE a.errstate = 1

[getAccountIdsForProcessing]
SELECT a.* FROM 
(SELECT wa.objid AS acctid
FROM vw_waterworks_account wa 
WHERE wa.state = 'ACTIVE'
AND wa.excludeinbatch = 0 
AND wa.objid NOT IN ( 
	SELECT wb2.acctid FROM waterworks_bill wb2 WHERE wb2.batchid = $P{batchid}
)) a
LIMIT $P{start}, $P{limit}

