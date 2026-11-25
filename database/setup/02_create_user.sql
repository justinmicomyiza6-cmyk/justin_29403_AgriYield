/*
Name: Justin
Student ID: 29403
Group: B
Project: AgriYield
Description: Configures the PDB administrator account.
*/

-- Connect as SYSDBA and switch to the AgriYield PDB.
ALTER SESSION SET CONTAINER = b_29403_justin_agri_db;

-- Grant administrator privileges.
GRANT DBA TO justin_admin;

-- Grant access to Enterprise Manager Express.
GRANT EM_EXPRESS_ALL TO justin_admin;

-- Ensure the account is unlocked.
ALTER USER justin_admin ACCOUNT UNLOCK;
