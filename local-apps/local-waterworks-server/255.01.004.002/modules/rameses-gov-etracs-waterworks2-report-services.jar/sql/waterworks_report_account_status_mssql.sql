[getReport]
select 
	barangay_objid, barangay_name, 
	sum(res_active) as res_active, sum(com_active) as com_active, 
	sum(ind_active) as ind_active, sum(bulk_active) as bulk_active,
	sum(res_inactive) as res_inactive, sum(com_inactive) as com_inactive, 
	sum(ind_inactive) as ind_inactive, sum(bulk_inactive) as bulk_inactive, 
	sum(gov_active) as gov_active, sum(gov_inactive) as gov_inactive 
from ( 
	select 
		so.barangay_objid, so.barangay_name, 
		case 
			when wa.classificationid='RESIDENTIAL' and acct.state = 'ACTIVE' and isnull(wm.state,'') <> 'DISCONNECTED' then 1 else 0 
		end as res_active, 
		case 
			when wa.classificationid='COMMERCIAL' and acct.state = 'ACTIVE' and isnull(wm.state,'') <> 'DISCONNECTED' then 1 else 0 
		end as com_active, 
		case 
			when wa.classificationid='INDUSTRIAL' and acct.state = 'ACTIVE' and isnull(wm.state,'') <> 'DISCONNECTED' then 1 else 0 
		end as ind_active, 
		case 
			when wa.classificationid='BULK' and acct.state = 'ACTIVE' and isnull(wm.state,'') <> 'DISCONNECTED' then 1 else 0 
		end as bulk_active, 
		case 
			when wa.classificationid='GOVERNMENT' and acct.state = 'ACTIVE' and isnull(wm.state,'') <> 'DISCONNECTED' then 1 else 0 
		end as gov_active, 
		case 
			when wa.classificationid='RESIDENTIAL' and isnull(wm.state,'') = 'DISCONNECTED' then 1 
			when wa.classificationid='RESIDENTIAL' and acct.state = 'INACTIVE' then 1 
			else 0 
		end as res_inactive,  
		case 
			when wa.classificationid='COMMERCIAL' and isnull(wm.state,'') = 'DISCONNECTED' then 1 
			when wa.classificationid='COMMERCIAL' and acct.state = 'INACTIVE' then 1 
			else 0 
		end as com_inactive,  
		case 
			when wa.classificationid='INDUSTRIAL' and isnull(wm.state,'') = 'DISCONNECTED' then 1 
			when wa.classificationid='INDUSTRIAL' and acct.state = 'INACTIVE' then 1 
			else 0 
		end as ind_inactive,  
		case 
			when wa.classificationid='BULK' and isnull(wm.state,'') = 'DISCONNECTED' then 1 
			when wa.classificationid='BULK' and acct.state = 'INACTIVE' then 1 
			else 0 
		end as bulk_inactive, 
		case 
			when wa.classificationid='GOVERNMENT' and isnull(wm.state,'') = 'DISCONNECTED' then 1 
			when wa.classificationid='GOVERNMENT' and acct.state = 'INACTIVE' then 1 
			else 0 
		end as gov_inactive  
	from waterworks_account acct  
		inner join waterworks_account_info wa ON acct.acctinfoid = wa.objid 
		inner join waterworks_subarea so on so.objid = wa.subareaid 
		left join waterworks_meter wm on wm.objid = wa.meterid 
)t1 
where barangay_objid is not null ${filters} 
group by barangay_objid, barangay_name 
order by barangay_name 
