[getUnpostedPaymentList]
select p.*,
	po.txntype, po.txntypename,
	po.paidby, po.particulars, po.refno, po.origin,
	po.mobileno, po.email, po.phoneno,
	pp.code as partnercode, pp.objid as partnerid
from payment p 
	inner join paymentorder_paid po ON po.objid = p.paymentrefid 
	inner join payment_partner pp ON pp.objid = p.paypartnerid 
where p.receiptid is null 
	and p.orgcode = $P{orgcode}
order by p.txndate 
