DROP VIEW IF EXISTS vw_building_evaluation_itemaccount;
CREATE VIEW vw_building_evaluation_itemaccount AS 
SELECT 
   a.objid,
   a.title,
   e.typeid
FROM obo_itemaccount a 
INNER JOIN building_evaluation_type_itemaccount e ON a.objid = e.itemid 

