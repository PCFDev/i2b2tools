use master


-- Create the database

IF EXISTS (SELECT name FROM master.sys.databases WHERE name = N'SHRINE_DB_NAME')
  BEGIN
    drop database [SHRINE_DB_NAME];
  END

create database [SHRINE_DB_NAME];
