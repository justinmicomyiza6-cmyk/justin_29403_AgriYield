# AgriYield: Crop Yield Analysis and Agricultural Decision Support System

## Student Information

- **Student:** Justin Micomyiza
- **Student ID:** 29403
- **Course:** INSY 8311 – Database Development with PL/SQL
- **Group:** B
- **Academic Year:** 2026–2027

## 1. Project Overview

- **Project Domain:** Agriculture
- **Database:** Oracle Database 21c
- **PDB:** `B_29403_JUSTIN_AGRI_DB`
- **Data Tablespace:** `AGRIYIELD_DATA`
- **Index Tablespace:** `AGRIYIELD_IDX`
- **Dataset Source:** FAOSTAT – Crops and Livestock Products (QCL)
- **Dataset:** Rwanda crop statistics, 2010–2024

AgriYield organizes Rwanda's historical crop statistics into normalized relational tables. It supports analysis of harvested area, crop production and crop yield across different crops and years.

The database contains six normalized tables and 4,041 crop-statistic observations.

---

## 2. Database Design and Normalization

### 2.1 Table Overview

| Table | Purpose |
|---|---|
| COUNTRIES | Stores country or area identifiers and names. |
| CROPS | Stores crop identifiers and crop names. |
| AGRICULTURAL_ELEMENTS | Stores agricultural measurement indicators and their units. |
| AGRICULTURAL_YEARS | Stores unique agricultural year values. |
| DATA_QUALITY_FLAGS | Stores FAOSTAT data-quality codes and descriptions. |
| CROP_STATISTICS | Stores crop measurements and links them to their country, crop, element, year and quality flag. |

### 2.2 Normalization to Third Normal Form (3NF)

The original FAOSTAT CSV contains repeated country, crop, element, year and quality-flag information across thousands of records.

The data was separated into six related tables to reduce redundancy and improve consistency.

**First Normal Form (1NF)**

- Each column contains a single atomic value.
- Each row represents one crop-statistic observation.
- Repeating country, crop, year and element descriptions were identified for separation.

**Second Normal Form (2NF)**

- The main observation table uses a composite primary key consisting of `area_code_m49`, `item_code_cpc`, `element_code` and `year_code`.
- Descriptive attributes that depend on individual identifiers were moved into their respective parent tables.
- This prevents partial dependencies on only part of the composite key.

**Third Normal Form (3NF)**

- Country names depend on country identifiers.
- Crop names depend on crop identifiers.
- Element names and units depend on element identifiers.
- Quality descriptions depend on quality-flag identifiers.
- Agricultural year values are stored separately.
- The statistics table stores measurements and foreign keys rather than repeating descriptive information.

Non-key attributes in each table depend on that table's key, the whole key and nothing but the key. This supports the 3NF design.

### 2.3 Primary Key Strategy

Natural keys were selected because the source dataset already provides stable FAOSTAT identifiers.

| Table | Primary Key | Reason |
|---|---|---|
| COUNTRIES | area_code_m49 | FAOSTAT area identifier. |
| CROPS | item_code_cpc | CPC crop identifier. |
| AGRICULTURAL_ELEMENTS | element_code | FAOSTAT measurement-element identifier. |
| AGRICULTURAL_YEARS | year_code | Identifies an agricultural year. |
| DATA_QUALITY_FLAGS | flag_code | Identifies a quality-status code. |
| CROP_STATISTICS | area_code_m49, item_code_cpc, element_code, year_code | Uniquely identifies an observation for a country, crop, element and year. |

The country name also has a UNIQUE constraint to prevent duplicate country names.

---

## 3. Detailed Data Dictionary

The following tables document every column, its Oracle datatype, nullability, constraints and purpose.

### 3.1 COUNTRIES

**Purpose:** Stores country or area identifiers and their corresponding names. This avoids repeating country names in every crop-statistic record.

| Column | Oracle Data Type | NULL Allowed | Constraint | Why / Description |
|---|---|---|---|---|
| area_code_m49 | VARCHAR2(10) | No | PK | Stores the FAOSTAT M49 area identifier. It uniquely identifies each country or area and is referenced by CROP_STATISTICS. |
| country_name | VARCHAR2(100) | No | NOT NULL, UQ | Stores the readable country or area name. The UNIQUE constraint prevents duplicate names and supports accurate reporting. |

**Design justification:** A separate country table avoids repeating country names across thousands of observations. The natural FAOSTAT area code is used as the primary key.

### 3.2 CROPS

**Purpose:** Stores crop identifiers and crop names used in the agricultural statistics.

| Column | Oracle Data Type | NULL Allowed | Constraint | Why / Description |
|---|---|---|---|---|
| item_code_cpc | VARCHAR2(10) | No | PK | Stores the FAOSTAT CPC item identifier. It uniquely identifies each crop and is referenced by CROP_STATISTICS. |
| item_name | VARCHAR2(50) | No | NOT NULL | Stores the readable crop name, such as maize, rice or sorghum. It supports understandable reports and crop comparisons. |

**Design justification:** Crop details are separated from measurements to prevent repeated crop names and maintain consistent crop identification.

### 3.3 AGRICULTURAL_ELEMENTS

**Purpose:** Stores the agricultural measurement indicators and their associated units.

| Column | Oracle Data Type | NULL Allowed | Constraint | Why / Description |
|---|---|---|---|---|
| element_code | VARCHAR2(10) | No | PK | Stores the FAOSTAT element identifier. It distinguishes harvested area, yield and production. |
| element_name | VARCHAR2(50) | No | NOT NULL | Stores the readable measurement name, such as Area harvested, Yield or Production. |
| unit | VARCHAR2(20) | No | NOT NULL | Stores the measurement unit associated with the element, such as ha, kg/ha or t. This ensures measurements are interpreted correctly. |

**Design justification:** Measurement descriptions and units are stored once instead of being repeated in every observation. This also prevents inconsistent unit descriptions.

### 3.4 AGRICULTURAL_YEARS

**Purpose:** Stores unique agricultural year values used to organize and compare observations over time.

| Column | Oracle Data Type | NULL Allowed | Constraint | Why / Description |
|---|---|---|---|---|
| year_code | NUMBER(4) | No | PK, CK | Stores the four-digit agricultural year. It uniquely identifies each year and is referenced by CROP_STATISTICS. The CHECK constraint restricts values to the range 1900–2100. |

**Design justification:** A separate year table avoids repeated year values and provides a consistent reference for time-based analysis.

### 3.5 DATA_QUALITY_FLAGS

**Purpose:** Stores FAOSTAT quality codes and their descriptions.

| Column | Oracle Data Type | NULL Allowed | Constraint | Why / Description |
|---|---|---|---|---|
| flag_code | CHAR(1) | No | PK | Stores the single-character FAOSTAT quality code, such as A, E, I, X or M. It uniquely identifies a quality status. |
| flag_description | VARCHAR2(50) | No | NOT NULL | Stores the explanation of each quality code, allowing users to understand the reliability or status of a reported observation. |

**Design justification:** Quality codes and descriptions are stored separately to avoid repeating their meanings throughout the statistics table.

### 3.6 CROP_STATISTICS

**Purpose:** Stores the actual agricultural observations. Each row represents one measurement for a particular country, crop, agricultural element and year.

| Column | Oracle Data Type | NULL Allowed | Constraint | Why / Description |
|---|---|---|---|---|
| area_code_m49 | VARCHAR2(10) | No | PK, FK | Identifies the country or area associated with the observation. References COUNTRIES and forms part of the composite primary key. |
| item_code_cpc | VARCHAR2(10) | No | PK, FK | Identifies the crop being measured. References CROPS and forms part of the composite primary key. |
| element_code | VARCHAR2(10) | No | PK, FK | Identifies the agricultural measurement indicator. References AGRICULTURAL_ELEMENTS and forms part of the composite primary key. |
| year_code | NUMBER(4) | No | PK, FK | Identifies the year of the observation. References AGRICULTURAL_YEARS and forms part of the composite primary key. |
| flag_code | CHAR(1) | Yes | FK | Identifies the FAOSTAT quality status. References DATA_QUALITY_FLAGS. It is nullable to support ON DELETE SET NULL while retaining the observation. |
| numeric_value | NUMBER(10,2) | Yes | CK | Stores the numeric agricultural measurement, such as harvested area, production or yield. It permits NULL because some source observations have no numeric value. The CHECK constraint prevents negative measurements. |
| note | VARCHAR2(100) | Yes | — | Stores optional additional information supplied by FAOSTAT, such as an unofficial-figure note. It is nullable because not every observation contains a note. |

**Design justification:**

CROP_STATISTICS is the central fact table. Its composite primary key prevents duplicate observations for the same country, crop, element and year.

The foreign keys enforce valid relationships with all five parent tables. The quality flag is nullable because deleting a quality-flag parent should not delete the underlying agricultural observation.

The numeric value is nullable because the source dataset contains 36 records without numeric measurements. Negative values are prohibited because they are not valid for these agricultural measurements.

---

## 4. Integrity Constraints

### 4.1 Constraint Summary

The database uses primary keys, foreign keys, NOT NULL, UNIQUE and CHECK constraints.

| Constraint Name | Table | Type | Purpose |
|---|---|---|---|
| pk_countries | COUNTRIES | PRIMARY KEY | Uniquely identifies each country or area. |
| uq_countries_country_name | COUNTRIES | UNIQUE | Prevents duplicate country names. |
| pk_crops | CROPS | PRIMARY KEY | Uniquely identifies each crop. |
| pk_agricultural_elements | AGRICULTURAL_ELEMENTS | PRIMARY KEY | Uniquely identifies each measurement element. |
| pk_agricultural_years | AGRICULTURAL_YEARS | PRIMARY KEY | Uniquely identifies each agricultural year. |
| ck_agri_year_code | AGRICULTURAL_YEARS | CHECK | Restricts years to 1900–2100. |
| pk_data_quality_flags | DATA_QUALITY_FLAGS | PRIMARY KEY | Uniquely identifies each quality flag. |
| pk_crop_statistics | CROP_STATISTICS | PRIMARY KEY | Prevents duplicate observations using the four-column composite key. |
| ck_cs_numeric_value | CROP_STATISTICS | CHECK | Allows NULL or nonnegative numeric values. |
| fk_cs_countries | CROP_STATISTICS | FOREIGN KEY | Ensures every country reference exists. |
| fk_cs_crops | CROP_STATISTICS | FOREIGN KEY | Ensures every crop reference exists. |
| fk_cs_elements | CROP_STATISTICS | FOREIGN KEY | Ensures every measurement element exists. |
| fk_cs_years | CROP_STATISTICS | FOREIGN KEY | Ensures every year reference exists. |
| fk_cs_flags | CROP_STATISTICS | FOREIGN KEY | Ensures every non-NULL quality flag exists. |

Additional NOT NULL constraints protect required columns in all six tables.

**Constraint status:** The database contains 28 constraints. Verification confirmed that all are ENABLED and VALIDATED.

### 4.2 Defaults

No DEFAULT constraints were added because the source dataset does not provide a justified universal default for missing agricultural measurements, years, identifiers or quality codes. Missing values are retained as NULL where the design permits them instead of inventing data.

---

## 5. Foreign-Key Relationships and Delete Rules

### 5.1 Relationship Overview

| Parent Table | Child Table | Cardinality | Delete Rule |
|---|---|---|---|
| COUNTRIES | CROP_STATISTICS | One-to-many | NO ACTION |
| CROPS | CROP_STATISTICS | One-to-many | ON DELETE CASCADE |
| AGRICULTURAL_ELEMENTS | CROP_STATISTICS | One-to-many | NO ACTION |
| AGRICULTURAL_YEARS | CROP_STATISTICS | One-to-many | NO ACTION |
| DATA_QUALITY_FLAGS | CROP_STATISTICS | One-to-many | ON DELETE SET NULL |

Each parent may have zero or many related statistics. Each statistics row must reference one country, crop, element and year. Its quality flag is optional.

### 5.2 Foreign-Key Decision Table

| Foreign Key | Child Table | Parent Table | Rule Chosen | Why This Rule |
|---|---|---|---|---|
| fk_cs_countries | CROP_STATISTICS | COUNTRIES | NO ACTION | Country records must not be deleted while agricultural observations still reference them. This protects historical statistics. |
| fk_cs_crops | CROP_STATISTICS | CROPS | ON DELETE CASCADE | A crop's observations are dependent on that crop record. If a crop is intentionally removed, its related observations are removed as well. |
| fk_cs_elements | CROP_STATISTICS | AGRICULTURAL_ELEMENTS | NO ACTION | Measurement definitions must remain available while observations reference them. |
| fk_cs_years | CROP_STATISTICS | AGRICULTURAL_YEARS | NO ACTION | Historical observations must not lose their year reference. |
| fk_cs_flags | CROP_STATISTICS | DATA_QUALITY_FLAGS | ON DELETE SET NULL | If a quality-flag definition is deleted, observations remain available but their flag reference becomes NULL. |

### 5.3 Demonstration of Referential Actions

The referential-action tests are stored in `database/tests/09_cascade_tests.sql`.

- **CASCADE:** A temporary crop and its observation were inserted. Deleting the crop automatically deleted its child observation. The child count changed from 1 to 0.
- **SET NULL:** A temporary quality flag was inserted and referenced by a statistic. Deleting the flag changed the observation's `flag_code` to NULL while preserving the observation.
- **NO ACTION:** An attempt to delete a country with existing statistics was rejected by Oracle with `ORA-02292`, confirming that the parent cannot be deleted while child records reference it.

### 5.4 Handling Key Updates in Oracle

Oracle does not support `ON UPDATE CASCADE` for foreign keys. Therefore, referenced primary keys should normally be treated as stable identifiers.

If a key must change, the application should handle the change through a controlled transaction. This may involve updating child references before changing the parent key, or using a carefully designed migration procedure with appropriate integrity checks. Referential integrity must remain protected throughout the operation.

---

## 6. Indexing Strategy

Indexes were created in the `AGRIYIELD_IDX` tablespace to improve joins, filtering and query performance.

### 6.1 Index List

| Index Name | Table | Indexed Column(s) | Type | Justification |
|---|---|---|---|---|
| idx_cs_area | CROP_STATISTICS | area_code_m49 | B-tree | Speeds up country-based joins and searches. |
| idx_cs_crop | CROP_STATISTICS | item_code_cpc | B-tree | Improves crop-based filtering and joins. |
| idx_cs_element | CROP_STATISTICS | element_code | B-tree | Supports filtering by agricultural measurement. |
| idx_cs_year | CROP_STATISTICS | year_code | B-tree | Improves year-based searches and joins. |
| idx_cs_flag | CROP_STATISTICS | flag_code | B-tree | Supports quality-flag filtering and parent-row deletion checks. |
| idx_cs_crop_year | CROP_STATISTICS | item_code_cpc, year_code | Composite B-tree | Improves queries filtering by crop and year together. |
| idx_countries_upper_name | COUNTRIES | UPPER(country_name) | Function-based | Supports case-insensitive country-name searches. |

All five foreign-key columns in CROP_STATISTICS have corresponding indexes.

The composite index supports common crop-and-year queries. The function-based index supports searches that apply `UPPER()` to country names.

### 6.2 Execution Plan Comparison

The execution plan was tested using the crop-and-year query:

```sql
SELECT *
FROM crop_statistics
WHERE item_code_cpc = '01701'
  AND year_code = 2020;
```

**With the composite index:**

- Oracle used `INDEX RANGE SCAN IDX_CS_CROP_YEAR`.
- The table access operation was `TABLE ACCESS BY INDEX ROWID BATCHED`.
- Estimated cost: 1.

**With a forced full table scan:**

```sql
SELECT /*+ FULL(cs) */ *
FROM crop_statistics cs
WHERE item_code_cpc = '01701'
  AND year_code = 2020;
```

- Oracle used `TABLE ACCESS FULL CROP_STATISTICS`.
- Estimated cost: 7.

The comparison demonstrates that the composite index can reduce the estimated query cost for this particular query.

---

## 7. Database Views

Three views were created to simplify reporting and control access to data.

| View | Purpose |
|---|---|
| vw_agri_reporting | Joins crop statistics with country, crop, element, year and quality-flag information to provide readable reporting results. |
| vw_crop_year_summary | Groups observations by crop and year and calculates observation counts, available numeric values and average measurements. |
| vw_agri_readonly | Provides read-only access to crop-statistic records using WITH READ ONLY. |

### 7.1 Reporting View

`vw_agri_reporting` combines the related tables so that reports can display descriptive country, crop, element, year and quality information without repeatedly writing multiple joins.

### 7.2 Summary View

`vw_crop_year_summary` uses GROUP BY to summarize crop statistics by crop and year. It provides observation counts, available numeric-value counts and average numeric values.

### 7.3 Protected View

`vw_agri_readonly` was created using `WITH READ ONLY`.

This prevents INSERT, UPDATE and DELETE operations through the view, protecting the underlying records from modification through this reporting interface.

---

## 8. Data Staging and Cleaning

### 8.1 Raw Staging Table

The raw FAOSTAT CSV was imported into `STG_FAOSTAT_RAW` using SQL Developer's Import Data wizard.

All 15 source columns were defined as text using VARCHAR2(4000). This allowed the original records to be staged without rejecting rows because of numeric or datatype conversion problems.

The raw staging table contains 4,041 rows.

### 8.2 Cleaning Process

The cleaning process is implemented in `database/dml/06_clean.sql`.

| Cleaning Step | Result | Explanation |
|---|---:|---|
| Whitespace inspection | 0 rows affected | No whitespace corrections were required. |
| Type conversion and trimming | 4,041 rows processed | Source values were converted into the appropriate typed columns. |
| Duplicate inspection | 0 duplicate groups | No duplicate composite-key groups were found. |
| Missing numeric values | 36 | These records were retained with NULL numeric values because the source marked them with quality flag M. |

The cleaning process records its results in `DATA_CLEANING_AUDIT`.

No source observations were discarded merely because their numeric measurement was missing.

### 8.3 Data Quality Findings

- Total source records: 4,041.
- Records with numeric values: 4,005.
- Records without numeric values: 36.
- Duplicate composite-key groups: 0.
- Year and year-code mismatches: 0.
- Incomplete required source records: 0.

---

## 9. Data Loading

The cleaned staging records were transferred into the normalized tables using `database/dml/07_load_tables.sql`.

Parent tables were populated before the child table to ensure that all foreign-key references existed.

### 9.1 Final Table Counts

| Table | Rows Loaded |
|---|---:|
| COUNTRIES | 18 |
| CROPS | 6 |
| AGRICULTURAL_ELEMENTS | 3 |
| AGRICULTURAL_YEARS | 15 |
| DATA_QUALITY_FLAGS | 5 |
| CROP_STATISTICS | 4,041 |

### 9.2 Staging and Target Comparison

| Data Source | Row Count |
|---|---:|
| STG_FAOSTAT_RAW | 4,041 |
| STG_FAOSTAT_CLEAN | 4,041 |
| CROP_STATISTICS | 4,041 |

The staging and target observation counts match. No observations were lost during loading.

The five parent tables contain unique reference records extracted from the same dataset, so their counts are not expected to equal the number of observations.

---

## 10. Validation and Testing

### 10.1 Constraint Testing

The following tests were performed and produced the expected Oracle errors:

| Test | Expected Result |
|---|---|
| Duplicate primary key | ORA-00001 |
| Duplicate unique country name | ORA-00001 |
| NULL value in required crop name | ORA-01400 |
| Invalid agricultural year | ORA-02290 |
| Invalid country foreign key | ORA-02291 |
| Negative numeric measurement | ORA-02290 |

All tests were performed using intentionally invalid values. Invalid records were not retained in the database.

### 10.2 Referential Integrity Validation

The database was checked for child records with missing parent references.

Results:

- Missing country references: 0.
- Missing crop references: 0.
- Missing element references: 0.
- Missing year references: 0.
- Missing non-NULL quality-flag references: 0.

All 28 constraints were verified as ENABLED and VALIDATED.

### 10.3 Query Testing

The project includes SQL queries demonstrating:

- Multi-table JOIN operations.
- GROUP BY aggregation.
- Subqueries.
- Reporting and summary views.
- Read-only view access.
- Data validation and row-count comparisons.

The test queries are stored in `queries/phase4_analysis.sql`.

### 10.4 Main Table Size

The central `CROP_STATISTICS` table contains 4,041 observations, exceeding the assignment's requirement that the main tables hold 100–500 or more rows.

---

## 11. Project Deliverables

The following Phase IV deliverables are maintained in the GitHub repository.

### Design Documentation

- `docs/design/AgriYield_PhaseIV_ERD.png`
- `docs/design/AgriYield_PhaseIV_ERD.drawio`
- `docs/design/data_dictionary.md`

### DDL Scripts

- `database/ddl/01_create_tables.sql`
- `database/ddl/02_constraints.sql`
- `database/ddl/03_indexes.sql`
- `database/ddl/04_views.sql`

### DML Scripts

- `database/dml/05_staging_load.sql`
- `database/dml/06_clean.sql`
- `database/dml/07_load_tables.sql`

### Test Scripts

- `database/tests/08_constraint_tests.sql`
- `database/tests/09_cascade_tests.sql`
- `database/tests/10_validation.sql`

### Queries

- `queries/phase4_analysis.sql`

### Screenshots

Database setup, constraint tests, referential-action tests, final row counts and execution-plan evidence are stored in `database/screenshots/`.

---

## 12. Conclusion

Phase IV established the AgriYield Oracle database using six normalized tables, named integrity constraints, foreign-key relationships, indexes and reporting views.

The FAOSTAT dataset was successfully staged, cleaned and loaded, resulting in 4,041 agricultural observations. Validation confirmed that staging and target observation counts match, parent references are valid and all constraints are enabled and validated.

The resulting database provides a structured foundation for historical crop-statistic analysis and future agricultural reporting.

**Project:** AgriYield – Crop Yield Analysis and Agricultural Decision Support System  
**Student:** Justin Micomyiza  
**Student ID:** 29403  
**Course:** INSY 8311  
**Group:** B  
**Academic Year:** 2026–2027
