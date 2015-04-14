create user I2B2_DB_SHRINE_ONT_USER identified by I2B2_DB_SHRINE_ONT_PASSWORD;
grant create session, connect, resource to I2B2_DB_SHRINE_ONT_USER;

-- i2b2metadata.table_access
grant all privileges to I2B2_DB_SHRINE_ONT_USER;
