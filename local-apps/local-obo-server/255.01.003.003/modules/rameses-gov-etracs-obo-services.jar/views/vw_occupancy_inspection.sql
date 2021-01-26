DROP VIEW IF EXISTS vw_occupancy_inspection;
CREATE VIEW vw_occupancy_inspection AS 
SELECT 
   a.objid,
   a.title,
   e.typeid
FROM obo_itemaccount a 
INNER JOIN occupancy_inspection_type_itemaccount e ON a.objid = e.itemid 
