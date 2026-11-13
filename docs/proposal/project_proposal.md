# PROJECT PROPOSAL

## AgriYield: Crop Yield Analysis and Agricultural Decision Support System

### 1. Student Information

| Item | Details |
|---|---|
| Student Name | Justin Micomyiza |
| Student ID | 29403 |
| Course | INSY 8311 – Database Development with PL/SQL |
| Academic Year | 2026–2027 |
| Project Domain | Agriculture and Food |

### 2. Background and Problem Statement

Agriculture plays an important role in Rwanda's economy and food security. Understanding crop production, harvested area, and yield is essential for evaluating agricultural performance and supporting informed decisions.

However, agricultural statistics can be difficult to organize, compare, and interpret when they are stored in separate datasets or reports. AgriYield proposes a centralized database solution that organizes historical crop statistics and provides analytical reports to support agricultural decision-making.

### 3. Project Objectives

The main objective is to develop an agricultural data analysis and decision-support system using Oracle Database and PL/SQL.

Specific objectives are to:

1. Store historical agricultural production data in a structured Oracle database.
2. Analyze crop production, harvested area, and yield across different years.
3. Compare the performance of selected crops.
4. Generate reports that identify agricultural production trends.
5. Develop an interactive Power BI dashboard connected to Oracle Database.

### 4. Data Source

The project will use the FAOSTAT Crops and Livestock Products dataset.

Source: https://www.fao.org/faostat/en/#data/QCL

The selected Rwanda dataset contains 234 records covering six crops: bananas, dry beans, cassava, maize, rice, and sorghum. It includes production quantity, harvested area, and yield observations for 13 years between 2010 and 2024.

The dataset contains historical country-level statistics and does not represent individual farm records.

### 5. Proposed Solution and Database Design

AgriYield will use Oracle Database to organize agricultural information through related tables, including:

- COUNTRIES
- CROPS
- AGRICULTURAL_YEARS
- DATA_QUALITY_FLAGS
- CROP_STATISTICS

A staging table will be used to import and validate the original FAOSTAT records before processing them into the main database tables.

### 6. Planned Technologies and Innovation

- **Oracle Database:** Storage and management of agricultural records.
- **PL/SQL:** Procedures, functions, cursors, triggers, packages, and exception handling.
- **Microsoft Power BI:** Interactive dashboards and visualization of agricultural performance.
- **SQL Developer:** Database development and administration.

The planned innovation is an interactive agricultural dashboard connected to Oracle Database, enabling users to compare crop production, harvested area, and yield across different years.

### 7. Expected Results

The project is expected to deliver:

1. A structured Oracle relational database containing agricultural statistics.
2. PL/SQL programs for data processing, validation, and analysis.
3. Reports comparing crop production and yield.
4. An interactive Power BI dashboard.
5. A functional educational prototype demonstrating data-driven agricultural decision support.

### 8. References

1. FAO. FAOSTAT – https://www.fao.org/faostat/
2. NISR. Seasonal Agricultural Survey – https://www.statistics.gov.rw/
3. MINAGRI. Strategic Plan for Agriculture Transformation – https://www.minagri.gov.rw/
4. Oracle. PL/SQL Language Reference – https://docs.oracle.com/en/database/oracle/oracle-database/19/lnpls/
5. Oracle. Database Documentation – https://docs.oracle.com/en/database/
6. Microsoft. Power BI Oracle Database Connector – https://learn.microsoft.com/en-us/power-query/connectors/oracle-database

