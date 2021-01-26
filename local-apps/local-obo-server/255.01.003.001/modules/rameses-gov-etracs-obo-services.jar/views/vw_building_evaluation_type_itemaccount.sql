DROP VIEW IF EXISTS vw_building_evaluation_type_itemaccount;
CREATE VIEW vw_building_evaluation_type_itemaccount AS 
SELECT 
   a.objid,
   itm.objid AS item_objid,
   itm.title AS item_title
FROM building_evaluation_type_itemaccount a 
INNER JOIN obo_itemaccount itm ON a.itemid = itm.objid

