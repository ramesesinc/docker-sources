DROP VIEW IF EXISTS vw_occupancy_application;
CREATE VIEW vw_occupancy_application AS 
SELECT 
   op.*,
   t.state AS task_state,
   t.startdate AS task_startdate,
   t.enddate AS task_enddate,
   t.assignee_objid AS task_assignee_objid,
   t.assignee_name AS task_assignee_name,
   t.actor_objid AS task_actor_objid,
   t.actor_name AS task_actor_name,
   (SELECT title FROM sys_wf_node WHERE processname = 'occupancy_application' AND name=t.state) AS task_title,
   (op.totalmaterialcost + op.totaldirectlaborcost + op.totalequipmentcost + op.totalothercost) AS totalprojectcost

FROM occupancy_application op 
INNER JOIN occupancy_application_task t ON op.taskid = t.taskid

