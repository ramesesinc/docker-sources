DROP VIEW IF EXISTS vw_waterworks_bill;
CREATE VIEW vw_waterworks_bill AS
SELECT 
   wb.*, 
   CASE wb.month 
      WHEN 1 THEN 'JAN' 
      WHEN 2 THEN 'FEB' 
      WHEN 3 THEN 'MAR' 
      WHEN 4 THEN 'APR' 
      WHEN 5 THEN 'MAY' 
      WHEN 6 THEN 'JUN' 
      WHEN 7 THEN 'JUL' 
      WHEN 8 THEN 'AUG' 
      WHEN 9 THEN 'SEP' 
      WHEN 10 THEN 'OCT' 
      WHEN 11 THEN 'NOV' 
      WHEN 12 THEN 'DEC' 
   END AS monthname,
       
   a.acctno, 
   ai.acctname, 
   a.state AS acctstate, 
   a.seqno,
   ai.subareaid,
   ai.address_text,
   ai.classificationid,
   ai.stuboutid,
   ai.meterid, 
   ai.meterstate,

   sarea.schedulegroupid AS subarea_schedulegroupid,
   sarea.code AS subarea_code,
   sarea.barangay_name AS subarea_barangay_name,
   area.code AS area_code,

   p.fromdate AS period_fromdate,
   p.todate AS period_todate,
   p.readingdate AS period_readingdate,
   p.readingenddate AS period_readingenddate,
   p.billdate AS period_billdate,
   p.billingenddate AS period_billingenddate,
   p.discdate AS period_discdate,
   p.duedate AS period_duedate,
   p.billexpirydate AS period_billexpirydate

FROM waterworks_bill wb 
INNER JOIN waterworks_account a on a.objid = wb.acctid
INNER JOIN waterworks_account_info ai ON wb.acctinfoid = ai.objid
INNER JOIN waterworks_subarea sarea ON ai.subareaid=sarea.objid
INNER JOIN waterworks_area area ON sarea.areaid=area.objid
LEFT JOIN waterworks_billing_period p ON wb.year = p.year AND wb.month=p.month AND wb.scheduleid = p.scheduleid

