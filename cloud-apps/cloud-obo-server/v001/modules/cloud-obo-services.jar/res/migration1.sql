ALTER TABLE online_building_permit DROP COLUMN location_address1;
ALTER TABLE online_building_permit DROP COLUMN location_address2;

ALTER TABLE online_building_permit ADD COLUMN location_unitno varchar(25);
ALTER TABLE online_building_permit ADD COLUMN location_bldgno varchar(25);
ALTER TABLE online_building_permit ADD COLUMN location_bldgname varchar(25);
ALTER TABLE online_building_permit ADD COLUMN location_subdivision varchar(25);