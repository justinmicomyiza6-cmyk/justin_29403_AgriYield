# AgriYield – Database Design

## 1. Introduction
This document describes the proposed Oracle Database structure for the AgriYield project. The database will organize Rwanda's historical agricultural production statistics obtained from FAOSTAT.

## 2. Database Tables

### 2.1 COUNTRIES
Stores information about countries represented in the agricultural dataset.
- COUNTRY_ID – Primary Key
- COUNTRY_NAME
- FAOSTAT_AREA_CODE

### 2.2 CROPS
Stores the different agricultural crops.
- CROP_ID – Primary Key
- CROP_NAME
- FAOSTAT_ITEM_CODE

### 2.3 AGRICULTURAL_YEARS
Stores the years represented in the dataset.
- YEAR_ID – Primary Key
- YEAR_VALUE

### 2.4 DATA_QUALITY_FLAGS
Stores the official FAOSTAT data-quality codes and descriptions.
- FLAG_ID – Primary Key
- FLAG_CODE
- FLAG_DESCRIPTION

### 2.5 CROP_STATISTICS
Stores the agricultural measurements for each crop, country, and year.
- STATISTIC_ID – Primary Key
- COUNTRY_ID – Foreign Key
- CROP_ID – Foreign Key
- YEAR_ID – Foreign Key
- ELEMENT_CODE
- INDICATOR_NAME
- UNIT
- VALUE
- FLAG_ID – Foreign Key

## 3. Relationships
- One country can have many crop statistics records.
- One crop can have many crop statistics records.
- One year can contain many agricultural observations.
- One data-quality flag can be associated with many statistics records.

## 4. Database Design Approach
The database will use primary keys and foreign keys to maintain data integrity and reduce unnecessary duplication.

A staging table will also be created during data import to preserve the original FAOSTAT CSV records before transformation into the main tables.

## 5. Conclusion
The proposed database structure will support agricultural data storage, analysis, reporting, and PL/SQL operations for the AgriYield system.
