/*
Name: Justin
Student ID: 29403
Group: B
Project: AgriYield
Description: Creates the AgriYield Pluggable Database.
*/

-- Connect as SYSDBA in CDB$ROOT before running this script.

CREATE PLUGGABLE DATABASE b_29403_justin_agri_db
ADMIN USER justin_admin
IDENTIFIED BY "&&ADMIN_PASSWORD"
FILE_NAME_CONVERT = (
    'C:\PLSQL\ORCL21\PDBSEED\',
    'C:\PLSQL\ORCL21\B_29403_JUSTIN_AGRI_DB\'
);

-- Open the PDB and save its open state.
ALTER PLUGGABLE DATABASE b_29403_justin_agri_db OPEN;
ALTER PLUGGABLE DATABASE b_29403_justin_agri_db SAVE STATE;
