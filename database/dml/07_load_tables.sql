
-- ============================================================
-- Student Name : Justin MICOMYIZA
-- Student ID   : 29403
-- Group        : B
-- Project      : AgriYield - Crop Yield Analysis and
--                Agricultural Decision Support System
-- Script       : 07_load_tables.sql
-- Purpose      : Load normalized agricultural data
-- ============================================================

-- 1. Load COUNTRIES

INSERT INTO countries (area_code_m49, country_name)
SELECT DISTINCT area_code_m49, area_name
FROM stg_faostat_clean
WHERE area_code_m49 IS NOT NULL
  AND area_name IS NOT NULL;

-- 2. Load CROPS

INSERT INTO crops (item_code_cpc, item_name)
SELECT DISTINCT item_code_cpc, item_name
FROM stg_faostat_clean
WHERE item_code_cpc IS NOT NULL
  AND item_name IS NOT NULL;

-- 3. Load AGRICULTURAL_ELEMENTS

INSERT INTO agricultural_elements
    (element_code, element_name, unit)
SELECT DISTINCT element_code, element_name, unit
FROM stg_faostat_clean
WHERE element_code IS NOT NULL
  AND element_name IS NOT NULL
  AND unit IS NOT NULL;

-- 4. Load AGRICULTURAL_YEARS

INSERT INTO agricultural_years (year_code)
SELECT DISTINCT year_code
FROM stg_faostat_clean
WHERE year_code IS NOT NULL;

-- 5. Load DATA_QUALITY_FLAGS

INSERT INTO data_quality_flags (flag_code, flag_description)
SELECT DISTINCT flag_code, flag_description
FROM stg_faostat_clean
WHERE flag_code IS NOT NULL
  AND flag_description IS NOT NULL;

COMMIT;

-- Parent tables loaded successfully.

