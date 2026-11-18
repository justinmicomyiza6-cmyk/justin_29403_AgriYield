# AgriYield: Crop Yield Analysis and Agricultural Decision Support System

## Student Information
- **Student:** Justin Micomyiza
- **Student ID:** 29403
- **Course:** INSY 8311 – Database Development with PL/SQL
- **Academic Year:** 2026–2027

## Project Overview
- **Project Domain:** Agriculture
- **Database:** Oracle Database
- **Programming Language:** PL/SQL
- **Innovation Tool:** Microsoft Power BI

## 1. Problem Statement
Farmers and agricultural decision-makers need reliable information to understand crop production trends and identify crops with low yields. AgriYield will store and analyze crop production, harvested area, and yield data across different crops and years, generating reports and insights to support better agricultural decisions.

## 2. Project Objectives
- Store agricultural production data in an Oracle database.
- Analyze crop yields across different years and regions.
- Identify trends and variations in crop production.
- Generate reports to support agricultural decision-making.
- Visualize agricultural performance using Power BI.

## 3. Data Source
**FAOSTAT – Food and Agriculture Organization Corporate Statistical Database**

Website: https://www.fao.org/faostat/

The project will use crop production statistics, including production quantities, harvested areas, and yields. The selected dataset will be reviewed and prepared before importing it into Oracle Database.

**Data limitation:** The initial analysis will use available historical and country-level statistics. It will not claim to represent individual farm-level production.

## 4. Planned Database Tables
1. CROPS
2. COUNTRIES
3. AGRICULTURAL_SEASONS
4. HARVESTED_AREAS
5. CROP_PRODUCTION
6. YIELD_ANALYSIS

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

## 7. Expected Results
A functional Oracle database application capable of storing, analyzing, and reporting agricultural production data to support evidence-based decision-making.

## 8. References
- Food and Agriculture Organization (FAO): https://www.fao.org/faostat/
- Oracle Database Documentation: https://docs.oracle.com/en/database/

## 9. Project Status
Phase 0 – Project proposal and research.

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
| [Business Process Diagram](docs/business_process/business_process_diagram.pdf) | PDF version of the BPMN diagram |
| [Full Business Process Documentation](docs/business_process/business_process_explanation.pdf) | Complete Phase I explanation and documentation |
| [One-Page Business Process Explanation](docs/business_process/business_process_one_page_explanation.pdf) | Concise explanation of the business process |

### 4. Main Actors

- Data Administrator
- Oracle Database
- Agricultural Data Analyst
- Power BI
- Agricultural Decision-Maker
- FAOSTAT (External Data Provider)

### 5. Data Operations

The process includes creating, retrieving, and updating agricultural records. Invalid records are rejected or retained for review rather than routinely deleted.
