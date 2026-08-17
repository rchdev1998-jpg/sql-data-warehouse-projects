/*
===================================
	CREATE DATABASE AND SCHEMAS
===================================
Purpose:
		To create database named 'maven_fuzzy_factory' and schemas. If the database is already exists,
		it will set to single user and drop the database
Warning:
		Running this script can drop your entire data warehouse. Before running this script, make it sure
		that you properly backup your database.
*/
USE master;
GO


--Drop the database if exist
IF EXISTS (select 1 from sys.databases where name = 'maven_fuzzy_factory')
	BEGIN
		ALTER DATABASE maven_fuzzy_factory SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
		DROP DATABASE maven_fuzzy_factory;
	END
GO	


--Create Datbase
CREATE DATABASE maven_fuzzy_factory;
GO


--CREATE SCHEMAS
CREATE SCHEMA bronze;
GO
CREATE SCHEMA silver;
GO
CREATE SCHEMA gold;
GO
