DROP VIEW IF EXISTS vw_building_application_fee;
CREATE VIEW vw_building_application_fee AS 
SELECT 
   a.*,
   sd.doctypeid 
FROM building_application_fee a 
LEFT JOIN building_application_subdoc sd ON a.parentid = sd.objid
