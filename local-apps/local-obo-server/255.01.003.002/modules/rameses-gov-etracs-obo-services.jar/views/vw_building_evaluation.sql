DROP VIEW IF EXISTS vw_building_evaluation;
CREATE VIEW vw_building_evaluation AS 
SELECT 
   a.*,
   et.title AS type_title,
   et.sortindex AS type_sortindex,
   et.postpaymentaction AS type_postpaymentaction,
   
   app.task_state AS app_task_state, 

   t.state AS task_state,
   t.dtcreated AS task_dtcreated,
   t.startdate AS task_startdate,
   t.enddate AS task_enddate,
   t.assignee_objid AS task_assignee_objid,
   t.assignee_name AS task_assignee_name,
   t.actor_objid AS task_actor_objid,
   t.actor_name AS task_actor_name,
   (SELECT title FROM sys_wf_node WHERE processname = 'building_evaluation' AND name=t.state) AS task_title,

   TIME_TO_SEC( TIMEDIFF( CASE WHEN t.enddate IS NULL THEN NOW() ELSE t.enddate END, t.dtcreated )) AS task_timediff 

   
FROM building_evaluation a 
INNER JOIN building_evaluation_task t ON a.taskid = t.taskid 
INNER JOIN building_evaluation_type et ON a.typeid = et.objid 
INNER JOIN vw_building_application app ON a.appid = app.objid 