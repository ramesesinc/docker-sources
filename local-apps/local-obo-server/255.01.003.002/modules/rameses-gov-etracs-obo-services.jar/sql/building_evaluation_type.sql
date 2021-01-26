[getSectionsForActivation]
SELECT 
objid FROM building_evaluation_type WHERE optional=0 AND activationstate = $P{state}
UNION ALL
SELECT objid FROM building_evaluation_type WHERE optional=1 AND activationstate = $P{state}
AND permitid IN ( 
   SELECT permittypeid FROM building_application_subdoc ba WHERE appid = $P{appid}
)	 

[getTest]
SELECT objid FROM building_evaluation_type