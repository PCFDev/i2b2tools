-- Create the database
drop database if exists shrine_query_history;
create database shrine_query_history; 

-- Create a SQL user for query history
grant all privileges on shrine_query_history.* to SHRINE_MYSQL_USER@SHRINE_MYSQL_HOST identified by 'SHRINE_MYSQL_PASSWORD';

-- Hibernate will create the schema for us
