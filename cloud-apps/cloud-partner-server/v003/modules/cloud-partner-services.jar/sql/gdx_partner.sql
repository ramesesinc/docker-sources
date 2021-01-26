[getList]
select p.*, 
	c.objid as group_objid, 
	c.title as group_title,
	c.name as group_name
from partner p 
	inner join partner_cluster c on c.objid = p.clusterid 
order by c.name, length(p.id), p.id 