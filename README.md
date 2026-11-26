# AgriYield: Crop Yield Analysis and Agricultural Decision Support System

## Student Information

- **Student:** Justin Micomyiza
- **Student ID:** 29403
- **Group:** B
- **Course:** INSY 8311 – Database Development with PL/SQL
- **Academic Year:** 2026–2027

## Project Overview

- **Project Domain:** Agriculture
- **Database:** Oracle Database 21c
- **Programming Language:** SQL and PL/SQL
- **Innovation Tool:** Microsoft Power BI
- **Project Name:** AgriYield – Crop Yield Analysis and Agricultural Decision Support System

## 1. Problem Statement

Farmers and agricultural decision-makers need reliable information to understand crop production trends and identify crops with low yields. AgriYield stores and analyzes crop production, harvested area, and yield data across different crops, countries, and years, generating reports and insights to support better agricultural decisions.

## 2. Project Objectives

- Store agricultural production data in an Oracle database.
- Analyze crop yields across different years and regions.
- Identify trends and variations in crop production.
- Generate reports to support agricultural decision-making.
- Visualize agricultural performance using Power BI.

## 3. Data Source

**FAOSTAT – Food and Agriculture Organization Corporate Statistical Database**

Website: [https://www.fao.org/faostat/](https://www.fao.org/faostat/)

The project uses crop production statistics, including production quantities, harvested areas, and yields.

**Data limitation:** The analysis uses available historical and country-level statistics. It does not claim to represent individual farm-level production.

## 4. Database Structure

The database consists of six related tables:

1. COUNTRIES
2. CROPS
3. AGRICULTURAL_ELEMENTS
4. AGRICULTURAL_YEARS
5. DATA_QUALITY_FLAGS
6. CROP_STATISTICS

The five reference tables are connected to the central CROP_STATISTICS table through foreign-key relationships.

## 5. Planned PL/SQL Features

- Stored procedures
- Functions
- Explicit and implicit cursors
- Database triggers
- PL/SQL packages
- Exception handling
- Data validation and reporting

## 6. Planned Innovation

An interactive Microsoft Power BI dashboard connected to Oracle Database. It will display crop production trends, compare yields, and highlight agricultural performance indicators.

## 7. References

- Food and Agriculture Organization (FAO): [https://www.fao.org/faostat/](https://www.fao.org/faostat/)
- Oracle Database Documentation: [https://docs.oracle.com/en/database/](https://docs.oracle.com/en/database/)

---

# Project Implementation and Progress

## Phase I – Business Process Modeling

### 1. Business Process

**Agricultural Data Collection, Validation, Storage and Reporting**

AgriYield follows a structured process for collecting agricultural statistics from FAOSTAT, validating the records, storing approved data in an Oracle Database, analyzing crop performance, and presenting findings through Power BI dashboards.

### 2. Modeling Tool

**Tool:** diagrams.net (draw.io)

**Published Business Process Diagram:**

[View AgriYield Business Process Diagram](https://viewer.diagrams.net/?tags=%7B%7D&lightbox=1&highlight=0000ff&edit=_blank&layers=1&nav=1&title=AgriYield_Business_Process_29403.drawio&dark=auto#Uhttps%3A%2F%2Fdrive.google.com%2Fuc%3Fid%3D1wpEvfcHa1U6DIcBEGvG-MkkZziMriVmn%26export%3Ddownload#%7B%22pageId%22%3A%22agriyield-phase1%22%7D)

### 3. Phase I Documentation

| Document | Description |
|---|---|
| [Business Process Diagram](https://github.com/justinmicomyiza6-cmyk/justin_29403_AgriYield/blob/main/docs/business_process/business_process_diagram.pdf) | PDF version of the BPMN diagram |
| [Full Business Process Documentation](https://github.com/justinmicomyiza6-cmyk/justin_29403_AgriYield/blob/main/docs/business_process/business_process_explanation.pdf) | Complete Phase I explanation and documentation |
| [One-Page Business Process Explanation](https://github.com/justinmicomyiza6-cmyk/justin_29403_AgriYield/blob/main/docs/business_process/business_process_one_page_explanation.pdf) | Concise explanation of the business process |

### 4. Main Actors

- Data Administrator
- Oracle Database
- Agricultural Data Analyst
- Power BI
- Agricultural Decision-Maker
- FAOSTAT (External Data Provider)

### 5. Data Operations

The process includes creating, retrieving, and updating agricultural records. Invalid records are rejected or retained for review rather than routinely deleted.

## Phase II – Data Understanding and Database Design

Phase II focused on understanding the FAOSTAT dataset, identifying data-quality issues, normalizing the database structure, and designing the logical database model.

### Dataset Summary

- **Source:** FAOSTAT
- **Total data records:** 4,041
- **Countries or areas:** 18
- **Crops:** 6
- **Agricultural measurement elements:** 3
- **Years:** 15 (2010–2024)
- **Data-quality flags:** 5

### Deliverables

- [Dataset Card](data/dataset_card.md)
- [Normalization Documentation](docs/design/normalization.md)
- [Original Entity Relationship Diagram](docs/design/erd.png)
- [Data Dictionary](docs/design/data_dictionary.md)
- [Raw Dataset](data/raw/FAOSTAT_data_en_11-18-2026.csv)

## Phase III – Oracle Database and PDB Creation

This phase covers the creation and configuration of the Oracle 21c Pluggable Database (PDB) for AgriYield.

### Database Configuration

- **PDB Name:** `B_29403_JUSTIN_AGRI_DB`
- **Administrator:** `JUSTIN_ADMIN`
- **Data Tablespace:** `AGRIYIELD_DATA` (100 MB, autoextend enabled, maximum 1 GB)
- **Index Tablespace:** `AGRIYIELD_IDX` (50 MB, autoextend enabled, maximum 500 MB)
- **Temporary Tablespace:** `AGRIYIELD_TEMP` (50 MB, autoextend enabled, maximum 500 MB)
- **Archive Logging:** Enabled (ARCHIVELOG mode)
- **Enterprise Manager Express:** Configured on HTTPS port `5503`

### Deliverables

- [Database Setup SQL Scripts](database/setup/)
- [Database Configuration Evidence and Screenshots](database/screenshots/)

## Phase IV – Table Creation, Data Loading and Validation

Phase IV implemented the physical Oracle database structure, loaded the FAOSTAT dataset, enforced integrity constraints, created indexes and views, and tested database behavior.

### 1. Table Creation and Constraints

Six Oracle tables were created:

- COUNTRIES
- CROPS
- AGRICULTURAL_ELEMENTS
- AGRICULTURAL_YEARS
- DATA_QUALITY_FLAGS
- CROP_STATISTICS

The database includes:

- Primary-key constraints.
- Foreign-key constraints.
- Unique constraints.
- NOT NULL constraints.
- CHECK constraints.
- A composite primary key on CROP_STATISTICS.

All 28 constraints were verified as ENABLED and VALIDATED.

### 2. Foreign-Key Delete Rules

Three delete behaviors were implemented and tested:

| Parent Table | Delete Rule | Result |
|---|---|---|
| CROPS | ON DELETE CASCADE | Related crop observations are deleted |
| DATA_QUALITY_FLAGS | ON DELETE SET NULL | Related observations remain, with flag_code set to NULL |
| COUNTRIES | NO ACTION | Deletion is prevented when observations reference the country |
| AGRICULTURAL_ELEMENTS | NO ACTION | Deletion is prevented when observations reference the element |
| AGRICULTURAL_YEARS | NO ACTION | Deletion is prevented when observations reference the year |

Oracle uses NO ACTION behavior by default when no alternative delete clause is specified.

### 3. Indexing Strategy

Seven indexes were created in the `AGRIYIELD_IDX` tablespace:

| Index | Type |
|---|---|
| IDX_CS_AREA | Single-column |
| IDX_CS_CROP | Single-column |
| IDX_CS_ELEMENT | Single-column |
| IDX_CS_YEAR | Single-column |
| IDX_CS_FLAG | Single-column |
| IDX_CS_CROP_YEAR | Composite |
| IDX_COUNTRIES_UPPER_NAME | Function-based |

Execution-plan analysis demonstrated the use of the composite index `IDX_CS_CROP_YEAR`.

For the tested crop-and-year query:

- Index range scan estimated cost: 1
- Full table scan estimated cost: 7

These are Oracle optimizer cost estimates, not measured execution times.

### 4. Database Views

Three views were created:

| View | Purpose |
|---|---|
| VW_AGRI_REPORTING | Combines agricultural observations with country, crop, element, year, and flag information |
| VW_CROP_YEAR_SUMMARY | Provides grouped crop and year summaries |
| VW_AGRI_READONLY | Provides read-only access to crop statistics |

All three views were successfully queried.

### 5. Data Staging and Cleaning

The original FAOSTAT CSV file was first imported into the staging table `STG_FAOSTAT_RAW`, with all 15 source columns stored as text.

The data was then processed into the typed staging table `STG_FAOSTAT_CLEAN`.

Cleaning and inspection included:

- Whitespace inspection and trimming.
- Data-type conversion.
- Duplicate-record inspection.
- Missing numeric-value inspection.
- Year consistency checks.
- Required-field checks.

The source contained 36 missing numeric values, all associated with flag M. These observations were retained.

### 6. Data Loading Results

The reference tables were populated before the central observation table to maintain referential integrity.

| Table | Loaded Records |
|---|---:|
| COUNTRIES | 18 |
| CROPS | 6 |
| AGRICULTURAL_ELEMENTS | 3 |
| AGRICULTURAL_YEARS | 15 |
| DATA_QUALITY_FLAGS | 5 |
| CROP_STATISTICS | 4,041 |

The raw staging table, cleaned staging table, and final CROP_STATISTICS table each contain 4,041 records.

### 7. Constraint and Delete-Rule Testing

The database tests demonstrated the enforcement of:

- Primary-key constraints.
- Unique constraints.
- NOT NULL constraints.
- CHECK constraints.
- Foreign-key constraints.
- CASCADE behavior.
- SET NULL behavior.
- NO ACTION behavior.

Invalid operations produced the expected Oracle errors, and temporary test records were cleaned up.

### 8. Validation and Analysis

Validation confirmed:

- No duplicate composite primary keys.
- No year mismatches.
- No incomplete required source records.
- No missing parent references in loaded observations.
- All implemented constraints are ENABLED and VALIDATED.
- The expected table row counts were maintained after testing.

Additional SQL analysis includes JOIN operations, GROUP BY summaries, and subqueries.

### 9. Phase IV Deliverables

| Directory | Contents |
|---|---|
| `database/ddl/` | Table creation, constraints, indexes, and views |
| `database/dml/` | Staging import, cleaning, and table loading |
| `database/tests/` | Constraint tests, delete-rule tests, and validation scripts |
| `database/screenshots/` | Database setup, loading, testing, and execution-plan evidence |
| `docs/design/` | ERD diagrams and updated data dictionary |
| `queries/` | SQL analysis and demonstration queries |

### Main Phase IV Scripts

- `database/ddl/01_create_tables.sql`
- `database/ddl/02_constraints.sql`
- `database/ddl/03_indexes.sql`
- `database/ddl/04_views.sql`
- `database/dml/05_staging_load.sql`
- `database/dml/06_clean.sql`
- `database/dml/07_load_tables.sql`
- `database/tests/08_constraint_tests.sql`
- `database/tests/09_cascade_tests.sql`
- `database/tests/10_validation.sql`
- `queries/phase4_analysis.sql`

### Phase IV Screenshots

- `08_constraint_tests.png`
- `09_delete_rule_tests.png`
- `10_final_row_counts.png`
- `11_index_execution_plan.png`
- `12_full_table_scan_plan.png`

## 8. Project Status

| Phase | Description | Status |
|---|---|---|
| Phase I | Business Process Modeling | Completed |
| Phase II | Data Understanding and Database Design | Completed |
| Phase III | Oracle PDB Creation and Configuration | Completed |
| Phase IV | Table Creation, Data Loading and Validation | Completed |

**Current milestone:** Phase IV database implementation and validation.

## 9. Future Development

The next development activities include:

- Implementing PL/SQL procedures, functions, cursors, triggers, and packages.
- Developing agricultural reporting and decision-support operations.
- Connecting the Oracle database to Microsoft Power BI.
- Building interactive dashboards for crop production, harvested area, and yield analysis.

## 10. Conclusion

AgriYield has progressed from business process modeling and logical database design to a working Oracle 21c database implementation.

The Phase IV implementation provides six related tables, 4,041 agricultural observations, integrity constraints, controlled delete rules, indexes, reporting views, and data-validation procedures.

The resulting database provides a structured foundation for further PL/SQL development, agricultural analysis, and Power BI visualization.
