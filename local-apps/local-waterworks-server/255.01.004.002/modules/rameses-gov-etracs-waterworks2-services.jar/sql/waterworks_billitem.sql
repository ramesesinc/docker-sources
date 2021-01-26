[findBalanceForward]
SELECT wb.balanceforward 
FROM waterworks_bill wb 
INNER JOIN waterworks_account wa ON wb.objid=wa.billid 
WHERE wa.objid = $P{acctid}