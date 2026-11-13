# Urban Air Quality Monitoring and Pollution Alert Management System

## Project Information

- **Student:** Justin Micomyiza
- **Student ID:** 29403
- **Course:** INSY 8311 – Database Development with PL/SQL
- **Academic Year:** 2026–2027
- **Project Domain:** Environment and Climate
- **Database:** Oracle Database
- **Programming Language:** PL/SQL

## 1. Problem Statement

Air pollution is an environmental challenge that affects human health and the quality of urban life. Monitoring air pollution requires collecting, storing, and analyzing measurements of different pollutants. Without an organized monitoring system, identifying unusual pollutant concentrations and generating timely alerts can be difficult.

This project aims to develop an Oracle database system that manages air-quality measurements, monitors pollutant concentrations, identifies abnormal readings, and generates pollution alerts.

## 2. Project Objectives

### Main Objective

To develop an Oracle database system for monitoring urban air quality and managing pollution alerts using PL/SQL.

### Specific Objectives

1. To design a relational database for storing air-quality monitoring information.
2. To record and analyze measurements of different air pollutants.
3. To automatically identify pollutant readings that exceed configured thresholds.
4. To generate and manage pollution alerts.
5. To provide reports and visualizations of air-quality trends.

## 3. Data Source

The project will use the **UCI Air Quality Dataset**.

- Dataset: Air Quality
- Records: 9,358
- Features: 15
- Location: An Italian urban area
- Period: March 2004 – February 2005

Dataset link: [https://archive.ics.uci.edu/dataset/360/air](https://archive.ics.uci.edu/dataset/360/air)

The dataset contains measurements of pollutants such as CO, benzene, NOx and NO2, together with environmental measurements.

**Data limitation:** The dataset was collected in Italy and will be used as historical research data, not as current measurements from Rwanda.

## 4. Planned Database Tables

| Table                | Description                              |
| -------------------- | ---------------------------------------- |
| MONITORING_STATIONS  | Stores monitoring station information    |
| POLLUTANTS           | Stores pollutant names and descriptions  |
| AIR_QUALITY_READINGS | Stores recorded air-quality measurements |
| ALERT_THRESHOLDS     | Stores configured pollutant thresholds   |
| POLLUTION_ALERTS     | Stores generated pollution alerts        |
| SYSTEM_USERS         | Stores authorized system users           |

## 5. Planned PL/SQL Features

- **Procedures:** Register and manage air-quality readings.
- **Functions:** Calculate pollution indicators and evaluate pollutant levels.
- **Cursors:** Retrieve and process pollution monitoring reports.
- **Triggers:** Automatically generate alerts when readings exceed configured thresholds.
- **Packages:** Organize monitoring, alert management and reporting operations.
- **Exception Handling:** Handle invalid measurements and database errors.
- **Auditing:** Track important database operations and modifications.

## 6. Planned Innovation

**Interactive Power BI Dashboard**

The project will integrate Oracle Database with Power BI to provide an interactive dashboard displaying:

- Air-quality measurements.
- Pollutant concentration trends.
- Pollution alert summaries.
- Comparisons between different pollutants.
- Monitoring reports and visualizations.

The dashboard will use actual records stored in the Oracle database.

## 7. Expected Results

The expected outcome is a functional Oracle database system capable of storing air-quality data, evaluating pollutant measurements, generating automated alerts and producing monitoring reports.

The project will demonstrate the practical application of Oracle SQL, PL/SQL programming, database design, auditing and data visualization.

## 8. References

1. UCI Machine Learning Repository. (n.d.). *Air Quality Dataset*. [https://archive.ics.uci.edu/dataset/360/air](https://archive.ics.uci.edu/dataset/360/air)

2. Oracle. (n.d.). *Oracle Database Documentation*. [https://docs.oracle.com/en/database/](https://docs.oracle.com/en/database/)

---

**Project Status:** Phase 0 – Research, Data Source and Project Proposal
