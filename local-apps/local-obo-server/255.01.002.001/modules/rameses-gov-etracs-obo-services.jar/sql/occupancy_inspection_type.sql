[getSectionsForActivation]
SELECT 
objid FROM occupancy_inspection_type WHERE optional=0 AND activationstate = $P{state}
UNION ALL
SELECT 
objid FROM occupancy_inspection_type WHERE optional <> 0 AND activationstate = $P{state}
