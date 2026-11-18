# AgriYield — Logical Database Design and Data Dictionary

## 1. Introduction

This document describes the logical database design for AgriYield: Crop Yield Analysis and Agricultural Decision Support System.

The database consists of six related tables designed to store agricultural observations while minimizing redundancy and maintaining data integrity.

## 2. Database Tables

### 2.1 COUNTRIES

**Purpose:** Stores the countries or areas included in the FAOSTAT dataset.

| Column | Description | Primary Key | Foreign Key | Required | Unique |
|---|---|---|---|---|---|
| area_code_m49 | UN M49 country or area code | Yes | No | Yes | Yes |
| country_name | Country or area name | No | No | Yes | No |

### 2.2 CROPS

**Purpose:** Stores agricultural crop identification information.

| Column | Description | Primary Key | Foreign Key | Required | Unique |
|---|---|---|---|---|---|
| item_code_cpc | CPC code identifying a crop | Yes | No | Yes | Yes |
| item_name | Crop name | No | No | Yes | No |

CPC codes must be stored as text to preserve leading zeros and decimal points.

### 2.3 AGRICULTURAL_ELEMENTS

**Purpose:** Stores the agricultural measurement types and their corresponding units.

| Column | Description | Primary Key | Foreign Key | Required | Unique |
|---|---|---|---|---|---|
| element_code | Code identifying the measurement element | Yes | No | Yes | Yes |
| element_name | Measurement description | No | No | Yes | No |
| unit | Measurement unit | No | No | Yes | No |

Examples include Area harvested (ha), Yield (kg/ha), and Production (t).

### 2.4 AGRICULTURAL_YEARS

**Purpose:** Stores the years associated with agricultural observations.

| Column | Description | Primary Key | Foreign Key | Required | Unique |
|---|---|---|---|---|---|
| year_code | Year identifying the observation period | Yes | No | Yes | Yes |

The original Year field is not stored separately because it was reported to be identical to Year Code.

### 2.5 DATA_QUALITY_FLAGS

**Purpose:** Stores the data-quality flag codes and their descriptions.

| Column | Description | Primary Key | Foreign Key | Required | Unique |
|---|---|---|---|---|---|
| flag_code | Code identifying the data-quality status | Yes | No | Yes | Yes |
| flag_description | Description of the data-quality status | No | No | Yes | No |

The five flag categories are:

| Flag Code | Description |
|---|---|
| A | Official value |
| E | Estimated value |
| I | Value imputed by a receiving agency |
| M | Missing value; data cannot exist |
| X | Value from external organization |

### 2.6 CROP_STATISTICS

**Purpose:** Stores individual agricultural measurements for each country, crop, measurement element, and year.

| Column | Description | Primary Key | Foreign Key | Required | Unique |
|---|---|---|---|---|---|
| area_code_m49 | Country or area identifier | Yes (Composite) | Yes | Yes | No |
| item_code_cpc | Crop identifier | Yes (Composite) | Yes | Yes | No |
| element_code | Measurement element identifier | Yes (Composite) | Yes | Yes | No |
| year_code | Observation year identifier | Yes (Composite) | Yes | Yes | No |
| numeric_value | Recorded agricultural measurement | No | No | No | No |
| flag_code | Data-quality flag identifier | No | Yes | Yes | No |
| note | Additional information about the observation | No | No | No | No |

The composite primary key consists of:

`(area_code_m49, item_code_cpc, element_code, year_code)`

The `numeric_value` and `note` fields are optional because the source dataset contains missing values and notes.

The `flag_code` is a foreign key only. It is not part of the composite primary key.

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

## 4. Entity Relationships and Cardinality

The logical database design contains five one-to-many relationships.

| Parent Entity | Child Entity | Cardinality | Explanation |
|---|---|---|---|
| COUNTRIES | CROP_STATISTICS | 1:M | One country can have many agricultural observations. |
| CROPS | CROP_STATISTICS | 1:M | One crop can appear in many observations. |
| AGRICULTURAL_ELEMENTS | CROP_STATISTICS | 1:M | One measurement element can describe many observations. |
| AGRICULTURAL_YEARS | CROP_STATISTICS | 1:M | One year can contain many agricultural observations. |
| DATA_QUALITY_FLAGS | CROP_STATISTICS | 1:M | One quality flag can be assigned to many observations. |

### 4.1 Relationship Optionality

- A parent record may exist without any associated crop statistics.
- Every CROP_STATISTICS record must reference exactly one country.
- Every CROP_STATISTICS record must reference exactly one crop.
- Every CROP_STATISTICS record must reference exactly one agricultural element.
- Every CROP_STATISTICS record must reference exactly one year.
- Every CROP_STATISTICS record must reference exactly one data-quality flag.

Therefore, each parent-to-child relationship is optional on the parent side (zero or many child records) and mandatory on the child side (exactly one parent record).

## 5. Integrity Constraints

The following constraints will be implemented during Phase IV:

1. Every table must have a primary key.
2. Primary-key values must be unique and cannot be NULL.
3. Foreign-key values must reference existing parent records.
4. The CROP_STATISTICS composite primary key must prevent duplicate observations.
5. The numeric_value field must accept NULL values.
6. The note field must accept NULL values.
7. The flag_code field must reference a valid data-quality flag.
8. CPC crop codes must be preserved as text.
9. The numeric_value field must contain valid numeric values whenever it is not NULL.

## 6. Final Logical Database Structure

The final database consists of:

- Five reference tables: COUNTRIES, CROPS, AGRICULTURAL_ELEMENTS, AGRICULTURAL_YEARS, and DATA_QUALITY_FLAGS.
- One central observation table: CROP_STATISTICS.
- Five one-to-many relationships connecting the reference tables to CROP_STATISTICS.

This logical design provides a normalized structure for storing, managing, and analyzing agricultural data.

Oracle-specific data types, column sizes, SQL constraints, and implementation details will be defined during Phase IV.
