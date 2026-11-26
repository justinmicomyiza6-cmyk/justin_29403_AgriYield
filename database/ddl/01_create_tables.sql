
-- ============================================================
-- Student Name : Justin MICOMYIZA
-- Student ID   : 29403
-- Group        : B
-- Project      : AgriYield - Crop Yield Analysis and
--                Agricultural Decision Support System
-- Script       : 01_create_tables.sql
-- Purpose      : Create the six Phase IV database tables
-- ============================================================

-- 1. COUNTRIES
CREATE TABLE countries (
    area_code_m49 VARCHAR2(10) NOT NULL,
    country_name  VARCHAR2(100) NOT NULL
)
TABLESPACE agriyield_data;

-- 2. CROPS
CREATE TABLE crops (
    item_code_cpc VARCHAR2(10) NOT NULL,
    item_name     VARCHAR2(50) NOT NULL
)
TABLESPACE agriyield_data;

-- 3. AGRICULTURAL_ELEMENTS
CREATE TABLE agricultural_elements (
    element_code VARCHAR2(10) NOT NULL,
    element_name VARCHAR2(50) NOT NULL,
    unit         VARCHAR2(20) NOT NULL
)
TABLESPACE agriyield_data;

-- 4. AGRICULTURAL_YEARS
CREATE TABLE agricultural_years (
    year_code NUMBER(4) NOT NULL
)
TABLESPACE agriyield_data;

-- 5. DATA_QUALITY_FLAGS
CREATE TABLE data_quality_flags (
    flag_code        CHAR(1) NOT NULL,
    flag_description VARCHAR2(50) NOT NULL
)
TABLESPACE agriyield_data;

-- 6. CROP_STATISTICS
CREATE TABLE crop_statistics (
    area_code_m49  VARCHAR2(10) NOT NULL,
    item_code_cpc  VARCHAR2(10) NOT NULL,
    element_code   VARCHAR2(10) NOT NULL,
    year_code      NUMBER(4) NOT NULL,
    flag_code      CHAR(1),
    numeric_value  NUMBER(10,2),
    note            VARCHAR2(100)
)
TABLESPACE agriyield_data;

-- End of table creation script

