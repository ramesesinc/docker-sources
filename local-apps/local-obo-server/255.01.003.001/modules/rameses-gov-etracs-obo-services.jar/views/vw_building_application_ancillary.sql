DROP VIEW IF EXISTS vw_building_application_subdoc;
CREATE VIEW vw_building_application_subdoc AS 
SELECT 
   a.*,
    pt.title,
    pt.sortorder    
FROM building_application_subdoc a 
INNER JOIN obo_permit_type pt ON a.permittypeid = pt.objid 

