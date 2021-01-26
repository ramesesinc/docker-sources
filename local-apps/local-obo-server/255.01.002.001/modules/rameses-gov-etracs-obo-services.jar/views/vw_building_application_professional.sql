DROP VIEW IF EXISTS vw_building_application_professional;
CREATE VIEW vw_building_application_professional AS 
SELECT 
   a.*,
   e.name,  
   e.firstname, 
   e.lastname, 
   e.middlename, 
   e.address_text, 
   e.tin, 
   e.id 
FROM building_application_professional a 
INNER JOIN building_application_entity e ON a.entityid = e.objid;