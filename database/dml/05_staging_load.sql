
-- ============================================================
-- Student Name : Justin MICOMYIZA
-- Student ID   : 29403
-- Group        : B
-- Project      : AgriYield - Crop Yield Analysis and
--                Agricultural Decision Support System
-- Script       : 05_staging_load.sql
-- Purpose      : Create raw FAOSTAT staging table
-- ============================================================

CREATE TABLE stg_faostat_raw (
    domain_code       VARCHAR2(4000),
    domain_name       VARCHAR2(4000),
    area_code_m49     VARCHAR2(4000),
    area_name         VARCHAR2(4000),
    element_code      VARCHAR2(4000),
    element_name      VARCHAR2(4000),
    item_code_cpc     VARCHAR2(4000),
    item_name         VARCHAR2(4000),
    year_code         VARCHAR2(4000),
    year_name         VARCHAR2(4000),
    unit              VARCHAR2(4000),
    value_text        VARCHAR2(4000),
    flag_code         VARCHAR2(4000),
    flag_description  VARCHAR2(4000),
    note              VARCHAR2(4000)
)
TABLESPACE agriyield_data;

-- All 15 source columns are stored as text.
-- Data cleaning and type conversion will happen later.
