--drop existing login if it exists
IF EXISTS (SELECT name  FROM master.sys.server_principals WHERE name = 'DB_USER')
	BEGIN
		DROP LOGIN [DB_USER];
	END



IF EXISTS (SELECT name  FROM master.sys.syslogins WHERE name = 'DB_USER')
	BEGIN
		DROP USER [DB_USER];
	END



--create sql account
CREATE LOGIN [DB_USER]
  WITH PASSWORD=N'DB_PASS',
  DEFAULT_DATABASE=[DB_NAME],
  CHECK_EXPIRATION=OFF,
  CHECK_POLICY=OFF;


USE [DB_NAME];


--create user for the database
CREATE USER [DB_USER]
  FOR LOGIN [DB_USER]
  WITH DEFAULT_SCHEMA=[DB_SCHEMA];



--add user to the db_owner role for the database
EXEC sp_addrolemember 'db_owner', 'DB_USER';
