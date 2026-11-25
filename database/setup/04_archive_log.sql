/*
Name: Justin
Student ID: 29403
Group: B
Project: AgriYield
Description: Enables ARCHIVELOG mode for the Oracle database.
*/

-- IMPORTANT:
-- ARCHIVELOG is a CDB-level setting, not a PDB-level setting.
-- It applies to the entire Container Database and all its PDBs.
-- It requires shutting down and mounting the CDB before enabling.
-- Run only on your own local Oracle installation, never on a shared server.

-- Connect locally as SYSDBA.

ARCHIVE LOG LIST;

SHUTDOWN IMMEDIATE;
STARTUP MOUNT;

ALTER DATABASE ARCHIVELOG;

ALTER DATABASE OPEN;

ARCHIVE LOG LIST;
