[getSubdocsToActivate]
SELECT objid FROM building_doc_type bd WHERE bd.autocreate = 1 
AND evaltypeid IN (
	SELECT typeid FROM building_evaluation WHERE objid = $P{objid}
)
AND objid NOT IN ( 
	SELECT sd.doctypeid 
	FROM building_application_subdoc sd
	INNER JOIN building_doc_type dt ON sd.doctypeid = dt.objid 
	INNER JOIN building_evaluation be ON be.appid = sd.appid AND dt.evaltypeid = be.typeid 	
	WHERE be.objid = $P{objid}
)


[getDocsThatRequireFees]
SELECT dt.title
FROM building_application_subdoc sd
INNER JOIN building_doc_type dt ON sd.doctypeid = dt.objid 
INNER JOIN building_evaluation be ON be.appid = sd.appid AND dt.evaltypeid = be.typeid 
WHERE be.objid = $P{evaluationid}
AND dt.requirefee = 1 
AND (sd.amount IS NULL OR sd.amount <= 0)
