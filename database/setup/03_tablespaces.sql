/*
Name: Justin
Student ID: 29403
Group: B
Project: AgriYield
Description: Creates and configures AgriYield tablespaces.
*/

-- Connect as JUSTIN_ADMIN to the AgriYield PDB.

-- Create the data tablespace.
CREATE TABLESPACE agriYield_data
DATAFILE 'C:\PLSQL\ORCL21\B_29403_JUSTIN_AGRI_DB\agriYield_data01.dbf'
SIZE 100M AUTOEXTEND ON NEXT 10M MAXSIZE 1G;

-- Create the index tablespace.
CREATE TABLESPACE agriYield_idx
DATAFILE 'C:\PLSQL\ORCL21\B_29403_JUSTIN_AGRI_DB\agriYield_idx01.dbf'
SIZE 50M AUTOEXTEND ON NEXT 10M MAXSIZE 500M;

-- Create the temporary tablespace.
CREATE TEMPORARY TABLESPACE agriYield_temp
TEMPFILE 'C:\PLSQL\ORCL21\B_29403_JUSTIN_AGRI_DB\agriYield_temp01.dbf'
SIZE 50M AUTOEXTEND ON NEXT 10M MAXSIZE 500M;

-- Set default and temporary tablespaces for the administrator.
ALTER USER justin_admin
DEFAULT TABLESPACE agriYield_data
TEMPORARY TABLESPACE agriYield_temp;

-- Grant unlimited quotas.
ALTER USER justin_admin QUOTA UNLIMITED ON agriYield_data;
ALTER USER justin_admin QUOTA UNLIMITED ON agriYield_idx;
