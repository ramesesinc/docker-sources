[cleanup-online-building_permit]
UPDATE online_building_permit SET locationid = null, applicantid = null, plansinchargeid=null, structuralinchargeid=null, constructioninchargeid=null;
DELETE FROM online_building_permit_info;
DELETE FROM online_building_permit_requirement;
DELETE FROM online_building_permit_ancillary;
DELETE FROM online_building_permit_rpu;
DELETE FROM online_building_permit_professional;
DELETE FROM online_building_permit_entity;
DELETE FROM online_building_permit;

[cleanup-online-occupancy_permit]
UPDATE online_occupancy_permit SET locationid = NULL, applicantid = NULL;
DELETE FROM online_occupancy_permit_costitem;
DELETE FROM online_occupancy_permit_professional;
DELETE FROM online_occupancy_permit_entity;
DELETE FROM online_occupancy_permit_rpu;
DELETE FROM online_occupancy_permit;

