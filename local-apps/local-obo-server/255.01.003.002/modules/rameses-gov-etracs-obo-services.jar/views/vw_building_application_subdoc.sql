DROP VIEW IF EXISTS vw_building_application_subdoc; 
CREATE VIEW vw_building_application_subdoc AS 
SELECT 
   bt.state AS appstate,
   a.*,
   iss.controlno,
   iss.dtissued,
   iss.expirydate,
   iss.issuedby_name,
   iss.issuedby_objid,
   iss.remarks AS issue_remarks,
   iss.template,
   iss.transmittalid  
FROM building_application_subdoc a  
LEFT JOIN building_issuance iss ON a.issuanceid = iss.objid 
INNER JOIN building_application ba ON a.appid = ba.objid 
LEFT JOIN building_application_task bt ON ba.taskid = bt.taskid 
