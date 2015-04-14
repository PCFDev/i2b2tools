-- modified to fit Postgres 2014-07-23
create user I2B2_DB_SHRINE_ONT_USER with password 'I2B2_DB_SHRINE_ONT_PASSWORD';

-- create matching schema
create schema authorization I2B2_DB_SHRINE_ONT_USER;

-- i2b2metadata.table_access
grant all privileges on all tables in schema I2B2_DB_SHRINE_ONT_USER to I2B2_DB_SHRINE_ONT_USER;
grant all privileges on all sequences in schema I2B2_DB_SHRINE_ONT_USER to I2B2_DB_SHRINE_ONT_USER;
grant all privileges on all functions in schema I2B2_DB_SHRINE_ONT_USER to I2B2_DB_SHRINE_ONT_USER;
