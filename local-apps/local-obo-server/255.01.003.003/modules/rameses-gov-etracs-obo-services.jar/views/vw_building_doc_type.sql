DROP VIEW IF EXISTS vw_building_doc_type;
CREATE VIEW vw_building_doc_type AS 
SELECT 
   a.*,
   bt.org_objid,
   bt.org_name   
FROM building_doc_type a 
LEFT JOIN building_evaluation_type bt ON a.evaltypeid = bt.objid
