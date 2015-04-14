-- Create user shrine/demouser
insert into PM_USER_DATA
(user_id, full_name, password, status_cd)
values
('SHRINE_USER', 'shrine', 'SHRINE_PASSWORD_CRYPTED', 'A');

-- TODO Override the ecommons requirement
-- http://open.med.harvard.edu/jira/browse/SHRINE-671
-- insert into PM_USER_PARAMS
-- (DATATYPE_CD, USER_ID, PARAM_NAME_CD, VALUE, CHANGEBY_CHAR, STATUS_CD)
-- values
-- ('T', 'shrine', 'ecommons_username', 'shrine', 'i2b2', 'A');

-- CREATE THE PROJECT for SHRINE
insert into PM_PROJECT_DATA
(project_id, project_name, project_wiki, project_path, status_cd)
values
('SHRINE', 'SHRINE', 'http://open.med.harvard.edu/display/SHRINE', '/SHRINE', 'A');

insert into PM_PROJECT_USER_ROLES
(PROJECT_ID, USER_ID, USER_ROLE_CD, STATUS_CD)
values
('SHRINE', 'SHRINE_USER', 'USER', 'A');

insert into PM_PROJECT_USER_ROLES
(PROJECT_ID, USER_ID, USER_ROLE_CD, STATUS_CD)
values
('SHRINE', 'SHRINE_USER', 'DATA_OBFSC', 'A');

-- captures information and registers the cells associated to the hive.
insert into PM_CELL_DATA
(cell_id, project_path, name, method_cd, url, can_override, status_cd)
values
('CRC', '/SHRINE', 'SHRINE Federated Query', 'REST', 'https://SHRINE_IP:SHRINE_SSL_PORT/shrine/rest/i2b2/', 1, 'A');
