use master


-- Create the database

IF EXISTS (SELECT name FROM master.sys.databases WHERE name = N'DB_NAME')
  BEGIN
    drop database [DB_NAME];
  END

create database [DB_NAME];
