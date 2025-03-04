USE master;
CREATE LOGIN Saks WITH PASSWORD = 'Sql@2025';
CREATE DATABASE HEALTHCARE_
CREATE USER Saks FOR LOGIN Saks;
ALTER ROLE db_owner ADD MEMBER Saks;

-----------------------------------------------