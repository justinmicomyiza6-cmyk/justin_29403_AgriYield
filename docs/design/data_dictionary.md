# AgriYield — Logical Database Design and Data Dictionary

## 1. Introduction

This document describes the logical and physical database design of **AgriYield: Crop Yield Analysis and Agricultural Decision Support System**.

The database stores agricultural observations obtained from the FAOSTAT dataset. It consists of six related tables designed to minimize redundancy, maintain data integrity, and support agricultural data analysis.

The database is implemented using Oracle Database 21c.

## 2. Database Tables and Justifications

### 2.1 COUNTRIES

**Purpose:** Stores the countries or areas included in the FAOSTAT dataset.

**Justification:** Separating country information from agricultural observations avoids repeating country names in every observation. The M49 area code provides a stable identifier.

| Column | Oracle Data Type | NULL Allowed | Constraint |
|---|---|---|---|
| area_code_m49 | VARCHAR2(10) | No | Primary Key |
| country_name | VARCHAR2(100) | No | UNIQUE |

**Table justification:** The table is in 3NF because each country name depends on the primary key, and country information is stored only once.

### 2.2 CROPS

**Purpose:** Stores agricultural crop identification information.

| Column | Oracle Data Type | NULL Allowed | Constraint |
|---|---|---|---|
| item_code_cpc | VARCHAR2(10) | No | Primary Key |
| item_name | VARCHAR2(50) | No | None |

**Table justification:** Crop identification information is separated from observations to avoid repeating crop names and codes.

CPC codes are stored as text to preserve leading zeros and decimal points.

### 2.3 AGRICULTURAL_ELEMENTS

**Purpose:** Stores agricultural measurement types and their corresponding units.

| Column | Oracle Data Type | NULL Allowed | Constraint |
|---|---|---|---|
| element_code | VARCHAR2(10) | No | Primary Key |
| element_name | VARCHAR2(50) | No | None |
| unit | VARCHAR2(20) | No | None |

**Table justification:** Measurement descriptions and units are stored separately to avoid repeating them in every agricultural observation.

Examples:
- Area harvested — ha
- Yield — kg/ha
- Production — t

### 2.4 AGRICULTURAL_YEARS

**Purpose:** Stores the years associated with agricultural observations.

| Column | Oracle Data Type | NULL Allowed | Constraint |
|---|---|---|---|
| year_code | NUMBER(4) | No | Primary Key, CHECK |

**CHECK constraint:** `year_code BETWEEN 1900 AND 2100`.

**Table justification:** A separate year table provides consistent year references and prevents invalid observation years.

The original dataset's Year and Year Code columns were identical in all 4,041 records. Therefore, only `year_code` is stored.

### 2.5 DATA_QUALITY_FLAGS

**Purpose:** Stores data-quality flag codes and their descriptions.

| Column | Oracle Data Type | NULL Allowed | Constraint |
|---|---|---|---|
| flag_code | CHAR(1) | No | Primary Key |
| flag_description | VARCHAR2(50) | No | None |

The five flag categories are:

| Flag Code | Description |
|---|---|
| A | Official value |
| E | Estimated value |
| I | Value imputed by a receiving agency |
| M | Missing value |
| X | Value from external organization |

**Table justification:** Storing flag descriptions separately prevents repeated descriptions in the central observation table and ensures consistent data-quality classifications.

### 2.6 CROP_STATISTICS

**Purpose:** Stores individual agricultural measurements for each country, crop, measurement element, and year.

| Column | Oracle Data Type | NULL Allowed | Constraint |
|---|---|---|---|
| area_code_m49 | VARCHAR2(10) | No | Composite PK, FK |
| item_code_cpc | VARCHAR2(10) | No | Composite PK, FK |
| element_code | VARCHAR2(10) | No | Composite PK, FK |
| year_code | NUMBER(4) | No | Composite PK, FK |
| flag_code | CHAR(1) | Yes | FK |
| numeric_value | NUMBER(10,2) | Yes | CHECK |
| note | VARCHAR2(100) | Yes | None |

**Composite Primary Key:**

`(area_code_m49, item_code_cpc, element_code, year_code)`

**CHECK constraint:** `numeric_value IS NULL OR numeric_value >= 0`.

**Table justification:** This is the central transaction/observation table. It connects countries, crops, agricultural elements, and years through foreign keys.

The composite primary key prevents duplicate observations for the same country, crop, measurement element, and year.

The `numeric_value` and `note` columns allow NULL because the original dataset contains missing measurements and optional notes.

**Important design decision — nullable flag_code:**

In the original logical design, `flag_code` was required. During Phase IV, it was made nullable to support the required Oracle `ON DELETE SET NULL` foreign-key action.

When a data-quality flag is deleted, the related observations remain in the database and their `flag_code` values become NULL. This preserves the agricultural observations while allowing the referenced flag to be removed.

## 3. Primary Keys and Foreign Keys

### 3.1 Primary Keys

| Table | Primary Key |
|---|---|
| COUNTRIES | area_code_m49 |
| CROPS | item_code_cpc |
| AGRICULTURAL_ELEMENTS | element_code |
| AGRICULTURAL_YEARS | year_code |
| DATA_QUALITY_FLAGS | flag_code |
| CROP_STATISTICS | area_code_m49, item_code_cpc, element_code, year_code |

### 3.2 Foreign Keys

| Child Table | Foreign Key | Referenced Table | Referenced Column |
|---|---|---|---|
| CROP_STATISTICS | area_code_m49 | COUNTRIES | area_code_m49 |
| CROP_STATISTICS | item_code_cpc | CROPS | item_code_cpc |
| CROP_STATISTICS | element_code | AGRICULTURAL_ELEMENTS | element_code |
| CROP_STATISTICS | year_code | AGRICULTURAL_YEARS | year_code |
| CROP_STATISTICS | flag_code | DATA_QUALITY_FLAGS | flag_code |

### 3.3 Additional Constraints

| Constraint Name | Table | Type | Purpose |
|---|---|---|---|
| pk_countries | COUNTRIES | PRIMARY KEY | Uniquely identifies each country |
| pk_crops | CROPS | PRIMARY KEY | Uniquely identifies each crop |
| pk_agricultural_elements | AGRICULTURAL_ELEMENTS | PRIMARY KEY | Uniquely identifies each element |
| pk_agricultural_years | AGRICULTURAL_YEARS | PRIMARY KEY | Uniquely identifies each year |
| pk_data_quality_flags | DATA_QUALITY_FLAGS | PRIMARY KEY | Uniquely identifies each flag |
| pk_crop_statistics | CROP_STATISTICS | PRIMARY KEY | Prevents duplicate observations |
| uq_countries_country_name | COUNTRIES | UNIQUE | Prevents duplicate country names |
| ck_agri_year_code | AGRICULTURAL_YEARS | CHECK | Restricts years to 1900–2100 |
| ck_cs_numeric_value | CROP_STATISTICS | CHECK | Prevents negative measurements |
| fk_cs_countries | CROP_STATISTICS | FOREIGN KEY | References COUNTRIES |
| fk_cs_crops | CROP_STATISTICS | FOREIGN KEY | References CROPS |
| fk_cs_elements | CROP_STATISTICS | FOREIGN KEY | References AGRICULTURAL_ELEMENTS |
| fk_cs_years | CROP_STATISTICS | FOREIGN KEY | References AGRICULTURAL_YEARS |
| fk_cs_flags | CROP_STATISTICS | FOREIGN KEY | References DATA_QUALITY_FLAGS |

All implemented constraints were verified as **ENABLED** and **VALIDATED** in Oracle Database.

## 4. Entity Relationships and Cardinality

The database contains five one-to-many relationships.

| Parent Entity | Child Entity | Cardinality | Explanation |
|---|---|---|---|
| COUNTRIES | CROP_STATISTICS | 1 : 0..* | One country can have zero or many observations |
| CROPS | CROP_STATISTICS | 1 : 0..* | One crop can appear in zero or many observations |
| AGRICULTURAL_ELEMENTS | CROP_STATISTICS | 1 : 0..* | One element can describe zero or many observations |
| AGRICULTURAL_YEARS | CROP_STATISTICS | 1 : 0..* | One year can contain zero or many observations |
| DATA_QUALITY_FLAGS | CROP_STATISTICS | 1 : 0..* | One flag can be assigned to zero or many observations |

### 4.1 Relationship Optionality

- A parent record may exist without associated crop statistics.
- Every CROP_STATISTICS record must reference exactly one country.
- Every CROP_STATISTICS record must reference exactly one crop.
- Every CROP_STATISTICS record must reference exactly one agricultural element.
- Every CROP_STATISTICS record must reference exactly one year.
- A CROP_STATISTICS record may have no data-quality flag because `flag_code` is nullable.

Therefore, each parent-to-child relationship is optional on the parent side (zero or many child records). The child side is mandatory for countries, crops, elements, and years, but optional for data-quality flags.

## 5. Foreign-Key Delete-Rule Decision Table

The following delete rules are implemented in Oracle Database.

| Parent Table | Foreign Key | Delete Rule | Reason |
|---|---|---|---|
| CROPS | fk_cs_crops | ON DELETE CASCADE | Deleting a crop also deletes its associated observations |
| DATA_QUALITY_FLAGS | fk_cs_flags | ON DELETE SET NULL | Observations remain, but their deleted flag reference becomes NULL |
| COUNTRIES | fk_cs_countries | NO ACTION | Prevents deleting a country that still has observations |
| AGRICULTURAL_ELEMENTS | fk_cs_elements | NO ACTION | Prevents deleting an element that is still referenced |
| AGRICULTURAL_YEARS | fk_cs_years | NO ACTION | Prevents deleting a year that is still referenced |

**Oracle implementation note:** Oracle uses NO ACTION behavior by default for foreign keys. Therefore, the three NO ACTION rules do not require an explicit clause in the SQL definitions.

Oracle does not support `ON UPDATE CASCADE`. Primary-key updates must be handled by updating dependent records appropriately or by using a controlled migration procedure.

## 6. Integrity Constraints and Data Validation

The database enforces the following rules:

1. Every table has a primary key.
2. Primary-key values must be unique and cannot be NULL.
3. Foreign-key values must reference existing parent records unless the foreign-key column is nullable.
4. The composite primary key prevents duplicate agricultural observations.
5. The `numeric_value` field accepts NULL but cannot contain negative values.
6. The `note` field accepts NULL.
7. The `flag_code` field accepts NULL or a valid data-quality flag.
8. Country names must be unique.
9. Agricultural years must be between 1900 and 2100.
10. CPC crop codes are stored as text.

Constraint testing demonstrated the enforcement of primary-key, unique, NOT NULL, CHECK, and foreign-key constraints using intentionally invalid operations that produced the expected Oracle errors.

Delete-rule testing also demonstrated CASCADE, SET NULL, and NO ACTION behavior.

## 7. Indexing Strategy

Indexes were created to improve query performance and support foreign-key lookups.

| Index Name | Table | Indexed Column(s) | Type |
|---|---|---|---|
| idx_cs_area | CROP_STATISTICS | area_code_m49 | Single-column |
| idx_cs_crop | CROP_STATISTICS | item_code_cpc | Single-column |
| idx_cs_element | CROP_STATISTICS | element_code | Single-column |
| idx_cs_year | CROP_STATISTICS | year_code | Single-column |
| idx_cs_flag | CROP_STATISTICS | flag_code | Single-column |
| idx_cs_crop_year | CROP_STATISTICS | item_code_cpc, year_code | Composite |
| idx_countries_upper_name | COUNTRIES | UPPER(country_name) | Function-based |

All seven indexes are stored in the `AGRIYIELD_IDX` tablespace.

## 8. Final Logical and Physical Database Structure

The final database consists of:

- Five reference tables: COUNTRIES, CROPS, AGRICULTURAL_ELEMENTS, AGRICULTURAL_YEARS, and DATA_QUALITY_FLAGS.
- One central observation table: CROP_STATISTICS.
- Five one-to-many relationships connecting the reference tables to CROP_STATISTICS.
- Primary-key, foreign-key, unique, NOT NULL, and CHECK constraints.
- Seven indexes for query performance.
- Three views for reporting, summary analysis, and read-only access.

The database uses Oracle tablespaces created during Phase III, including `AGRIYIELD_DATA` for table storage and `AGRIYIELD_IDX` for indexes.

## 9. Phase IV Data Loading Summary

The FAOSTAT source dataset contains 4,041 records.

The following row counts were obtained after loading:

| Table | Records |
|---|---:|
| COUNTRIES | 18 |
| CROPS | 6 |
| AGRICULTURAL_ELEMENTS | 3 |
| AGRICULTURAL_YEARS | 15 |
| DATA_QUALITY_FLAGS | 5 |
| CROP_STATISTICS | 4,041 |

The staging and cleaned staging tables each contain 4,041 records. The final CROP_STATISTICS table also contains 4,041 records.

The source dataset contains 36 observations with missing numeric values, all associated with flag M. These records were retained rather than discarded.

Validation confirmed that there are no duplicate composite keys, no year mismatches, no incomplete required source fields, and no missing parent references in the loaded observations.

## 10. Conclusion

The AgriYield database provides a normalized and constrained structure for storing and analyzing agricultural observations.

The Oracle implementation maintains referential integrity, supports controlled deletion behavior, and provides indexes and views for efficient data retrieval and reporting.

The logical design and physical implementation together provide a reliable foundation for agricultural yield analysis and decision support.
