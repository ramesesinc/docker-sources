[getSubdocsToIssue]
SELECT sd.*, dt.template, dt.controlnopattern
FROM building_application_subdoc sd 
INNER JOIN building_doc_type dt ON sd.doctypeid=dt.objid
WHERE sd.appid = $P{appid}
AND sd.issuanceid IS NULL
AND dt.issuetype = 3
