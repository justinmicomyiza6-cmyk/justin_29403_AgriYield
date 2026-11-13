# AgriYield – Literature Review

## 1. Introduction
This literature review examines agricultural production analysis, crop yield monitoring, database management, and data visualization. It identifies how existing agricultural statistics and database technologies support the development of the AgriYield system.

## 2. Review of Related Sources

### 2.1 FAO – FAOSTAT
The Food and Agriculture Organization provides agricultural statistics through FAOSTAT. Its crop production dataset includes harvested area, production quantity, and yield measurements for countries worldwide. These indicators provide the foundation for AgriYield's agricultural analysis.

Source: https://data.fao.org/catalog/iso/d24a448b-3b62-4c09-8c1d-4a39bb599876

### 2.2 National Institute of Statistics of Rwanda (NISR)
NISR publishes Seasonal Agricultural Survey reports containing information about crop production, harvested area, and yield in Rwanda. These reports demonstrate the importance of measuring agricultural performance and provide useful context for interpreting the FAOSTAT dataset.

Source: https://www.statistics.gov.rw/data-sources/surveys/Seasonal-Agricultural-Survey

### 2.3 Ministry of Agriculture and Animal Resources (MINAGRI)
Rwanda's Fifth Strategic Plan for Agriculture Transformation (PSTA 5), covering 2024/25–2028/29, emphasizes productive, resilient, and sustainable agri-food systems. It identifies agricultural productivity, food security, and climate resilience as important priorities. AgriYield supports these objectives by making historical production information easier to organize and analyze.

Source: https://www.minagri.gov.rw/updates/news-details/rwanda-launches-5th-strategic-plan-for-agriculture-transformation

### 2.4 Oracle Database – PL/SQL Language Reference
Oracle's PL/SQL documentation explains database programming features such as procedures, functions, packages, triggers, cursors, and exception handling. These features will be used to implement AgriYield's data processing, validation, and reporting operations.

Source: https://docs.oracle.com/en/database/oracle/oracle-database/19/lnpls/

### 2.5 Oracle Database – Creating and Managing Tables
Oracle documentation explains how database tables and integrity constraints are created and managed. Primary keys, foreign keys, and other constraints will help AgriYield maintain accurate and consistent agricultural records.

Source: https://docs.oracle.com/en/database/oracle/oracle-database/26/tdddg/creating-and-managing-tables.html

### 2.6 Microsoft Power BI – Oracle Database Connector
Microsoft documents how Power BI connects to Oracle Database using its Oracle connector. It supports importing data and, for supported configurations, DirectQuery. This provides a technical foundation for the proposed AgriYield dashboard.

Source: https://learn.microsoft.com/en-us/power-query/connectors/oracle-database

### 2.7 NISR – Seasonal Agricultural Survey 2026, Season A
The 2026 Season A report provides recent Rwanda crop statistics, including cultivated area, harvested area, production, and yield for crops such as maize, rice, cassava, beans, and bananas. It demonstrates the practical value of comparing crop performance over time.

Source: https://statistics.gov.rw/sites/default/files/documents/2026-04/SAS%202026%20Season%20A%20_Final%20Report.pdf

## 3. Research Findings
The reviewed sources show that agricultural production and yield indicators are important for monitoring agricultural performance. Rwanda's agricultural strategies emphasize improved productivity and resilient food systems. FAOSTAT and NISR provide statistical information that can support this type of analysis.

Oracle Database provides the data storage and processing capabilities required to organize agricultural records. PL/SQL can automate validation and analytical operations, while Power BI can present the results through interactive visualizations.

## 4. Research Gap and Project Contribution
The reviewed sources provide agricultural statistics, strategic information, and technical documentation. AgriYield will bring selected historical crop statistics into a structured Oracle database and provide a unified way to compare production, harvested area, and yield across crops and years.

The project is an educational decision-support prototype. It does not claim to predict crop yields or replace official agricultural statistics.

## 5. Conclusion
The literature supports the feasibility and relevance of AgriYield. The project combines publicly available agricultural data, Oracle Database, PL/SQL, and Power BI to demonstrate how agricultural information can be organized and analyzed for decision support.
