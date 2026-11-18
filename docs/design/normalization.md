# AgriYield — Phase II: Data Sourcing, Normalization and Logical Design

## 1. Dataset Source and Description

### 1.1 Dataset Information

| Attribute | Description |
|---|---|
| Dataset name | FAOSTAT Crops and Livestock Products |
| Source | Food and Agriculture Organization of the United Nations (FAO) |
| Source website | https://www.fao.org/faostat/ |
| File name | FAOSTAT_data_en_11-18-2026.csv |
| Format | CSV |
| Number of records | 4,041 data records |
| Number of columns | 15 |
| File size | 601.53 KB |
| Collection date | 18 November 2026 |
| Coverage | 18 African countries/areas |
| Period covered | 2010–2024 |

### 1.2 What One Record Represents

One record represents an agricultural measurement for a particular crop, in a particular country, for a particular year.

The measurement may represent area harvested, crop production, or crop yield. Each record also contains a value, measurement unit, data-quality flag, flag description, and optional note.

### 1.3 Dataset Coverage

The dataset contains:

- 18 countries/areas.
- 6 agricultural crops.
- 3 agricultural measurement elements.
- 15 years of observations (2010–2024).
- 5 data-quality flag categories.

The six crops are Bananas, Beans (dry), Cassava (fresh), Maize (corn), Rice, and Sorghum.

The three measurement elements are Area harvested, Production, and Yield.

### 1.4 Dataset Metadata

The original dataset contains two metadata fields:

- Domain Code: QCL
- Domain: Crops and livestock products

These fields describe the dataset as a whole rather than individual agricultural observations. They are therefore documented as dataset metadata and excluded from the normalized relational tables. They will remain available in the original CSV and the Phase IV staging table.

## 2. Data Quality Assessment

The original CSV was examined for missing values, duplicates, inconsistent descriptions, invalid numerical values, and other data-quality issues.

The following results are from the preliminary dataset analysis and will be verified again during Phase IV data loading.

### 2.1 Missing Values

| Column | Missing values | Percentage |
|---|---:|---:|
| Value | 36 | 0.89% |
| Note | 3,839 | 95.00% |
| Other 13 columns | 0 | 0% |
| **Total missing cells** | **3,875** | **6.39%** |

All 36 missing Value records have the flag M, meaning "Missing value; data cannot exist."

The missing values must remain NULL in the database. They must not be replaced with zero because a missing measurement is different from a measured value of zero.

The Note field is optional. The available non-null notes contain the description "Unofficial figure."

### 2.2 Duplicate Records

- Exact duplicate rows: 0.
- Duplicate candidate observations: 0.

The proposed natural key is:

(Area Code M49, Item Code CPC, Element Code, Year Code)

This combination identifies an individual agricultural measurement.

### 2.3 Other Quality Findings

- No reported negative or infinite numerical values.
- Twelve records contain a value of zero.
- The zero values are associated with Mauritius and Rice.
- The Year Code and Year columns were reported to contain identical values throughout the dataset.
- No code-to-description inconsistencies were reported.
- CPC item codes contain leading zeros and decimal points and must be stored as text.

### 2.4 Data Quality Flag Distribution

| Flag | Description | Records |
|---|---|---:|
| A | Official value | 2,328 |
| E | Estimated value | 825 |
| I | Value imputed by a receiving agency | 562 |
| X | Value from external organization | 290 |
| M | Missing value; data cannot exist | 36 |
| **Total** | | **4,041** |

### 2.5 Cleaning Requirements for Phase IV

The following actions will be performed during implementation:

1. Preserve the original CSV unchanged.
2. Trim unnecessary leading and trailing spaces.
3. Preserve CPC codes as text.
4. Convert numerical values into Oracle NUMBER values.
5. Convert empty Value fields into SQL NULL.
6. Preserve the original data-quality flags.
7. Validate foreign-key references before inserting observations.
8. Check that the imported record count matches the original dataset.
9. Verify the uniqueness of the proposed composite key.

## 3. Identification of Entities

The dataset contains descriptive information about countries, crops, agricultural measurement elements, years, and data-quality flags, alongside individual agricultural observations.

The following six entities were identified.

| Entity | Purpose | Primary Key |
|---|---|---|
| COUNTRIES | Stores country names and M49 codes | area_code_m49 |
| CROPS | Stores crop names and CPC codes | item_code_cpc |
| AGRICULTURAL_ELEMENTS | Stores measurement types and units | element_code |
| AGRICULTURAL_YEARS | Stores observation years | year_code |
| DATA_QUALITY_FLAGS | Stores flag codes and descriptions | flag_code |
| CROP_STATISTICS | Stores individual agricultural measurements | Composite key |

The CROP_STATISTICS table connects the five reference entities and stores the actual agricultural observations.

## 4. Database Normalization

### 4.1 Unnormalized Form (UNF)

The original FAOSTAT CSV is a flat dataset containing agricultural observations together with repeated descriptive information.

For example, country names, crop names, measurement descriptions, units, years, and flag descriptions are repeated across multiple records.

Although the CSV already contains atomic values, its structure contains redundant descriptive attributes. These repetitions create opportunities for update, insertion, and deletion anomalies.

The original CSV is therefore used as the starting point for normalization.

**Sample original records**

| Area | Item | Element | Year | Unit | Value | Flag |
|---|---|---|---:|---|---:|---|
| Burundi | Bananas | Area harvested | 2010 | ha | 273792 | I |
| Burundi | Bananas | Yield | 2010 | kg/ha | 6985.8 | E |
| Burundi | Bananas | Production | 2010 | t | 1912661 | A |
| Burundi | Bananas | Area harvested | 2011 | ha | 272804 | I |

### 4.2 First Normal Form (1NF)

The original dataset satisfies First Normal Form because:

- Each column contains atomic values.
- Each record represents one agricultural measurement.
- There are no repeating groups or nested lists within individual cells.
- Each observation can be identified using the proposed composite key.

The proposed candidate key is:

(Area Code M49, Item Code CPC, Element Code, Year Code)

The dataset is therefore already in 1NF.

### 4.3 Second Normal Form (2NF)

Second Normal Form requires that every non-key attribute depend on the whole candidate key rather than only part of it.

The original dataset contains partial dependencies:

- Area Code determines Area.
- Item Code determines Item.
- Element Code determines Element and Unit.
- Year Code determines Year.

These attributes do not depend on the entire composite key.

To remove these partial dependencies, the descriptive attributes are separated into reference tables.

The following tables are created:

**COUNTRIES**

| area_code_m49 | country_name |
|---:|---|
| 108 | Burundi |

**CROPS**

| item_code_cpc | item_name |
|---|---|
| 0112 | Beans (dry) |
| 01312 | Bananas |

**AGRICULTURAL_ELEMENTS**

| element_code | element_name | unit |
|---:|---|---|
| 5312 | Area harvested | ha |
| 5412 | Yield | kg/ha |
| 5510 | Production | t |

**AGRICULTURAL_YEARS**

| year_code |
|---:|
| 2010 |
| 2011 |

**CROP_STATISTICS**

| area_code_m49 | item_code_cpc | element_code | year_code | numeric_value | flag_code |
|---:|---|---:|---:|---:|---|
| 108 | 01312 | 5312 | 2010 | 273792 | I |
| 108 | 01312 | 5412 | 2010 | 6985.8 | E |
| 108 | 01312 | 5510 | 2010 | 1912661 | A |
| 108 | 01312 | 5312 | 2011 | 272804 | I |

The Year Code and Year columns were reported to be identical. Therefore, only year_code is retained in the normalized design to avoid storing the same information twice. The original Year column will remain in the staging table for validation.

**Dependency removed:** Partial dependencies were removed by separating country, crop, element, and year descriptions from the agricultural observation table.

### 4.4 Third Normal Form (3NF)

Third Normal Form requires that non-key attributes depend directly on the primary key and not on another non-key attribute.

The original dataset contains the following transitive dependency:

flag_code → flag_description

The flag description depends on the flag code, not directly on the agricultural observation's composite key.

To remove this transitive dependency, a separate DATA_QUALITY_FLAGS table is created.

**DATA_QUALITY_FLAGS**

| flag_code | flag_description |
|---|---|
| A | Official value |
| E | Estimated value |
| I | Value imputed by a receiving agency |
| M | Missing value; data cannot exist |
| X | Value from external organization |

The CROP_STATISTICS table stores only flag_code as a foreign key. The corresponding description is obtained from DATA_QUALITY_FLAGS.

**Dependency removed:** The transitive dependency between flag_code and flag_description is removed by storing flag descriptions in a separate reference table.

### 4.5 Final 3NF Tables

The final normalized database consists of six related tables:

1. COUNTRIES
2. CROPS
3. AGRICULTURAL_ELEMENTS
4. AGRICULTURAL_YEARS
5. DATA_QUALITY_FLAGS
