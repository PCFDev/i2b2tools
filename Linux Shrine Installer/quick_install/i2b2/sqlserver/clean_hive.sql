-- The ONT and CRC DB lookup tables provide path information for the ont-ds.xml
delete from ONT_DB_LOOKUP where C_PROJECT_PATH = 'SHRINE/';
delete from CRC_DB_LOOKUP where C_PROJECT_PATH = '/SHRINE/';
