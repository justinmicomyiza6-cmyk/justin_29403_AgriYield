
-- ============================================================
-- Student Name : Justin MICOMYIZA
-- Student ID   : 29403
-- Group        : B
-- Project      : AgriYield - Crop Yield Analysis and
--                Agricultural Decision Support System
-- Script       : 04_views.sql
-- Purpose      : Create reporting, summary and protected views
-- ============================================================

-- 1. REPORTING VIEW
-- Combines crop statistics with readable reference information.

CREATE OR REPLACE VIEW vw_agri_reporting AS
SELECT
    co.country_name,
    cr.item_name AS crop_name,
    ae.element_name,
    ae.unit,
    cs.year_code,
    cs.numeric_value,
    dq.flag_description,
    cs.note
FROM crop_statistics cs
JOIN countries co
    ON cs.area_code_m49 = co.area_code_m49
JOIN crops cr
    ON cs.item_code_cpc = cr.item_code_cpc
JOIN agricultural_elements ae
    ON cs.element_code = ae.element_code
JOIN agricultural_years ay
    ON cs.year_code = ay.year_code
LEFT JOIN data_quality_flags dq
    ON cs.flag_code = dq.flag_code;

-- 2. SUMMARY VIEW
-- Counts observations and calculates average values by crop and year.

CREATE OR REPLACE VIEW vw_crop_year_summary AS
SELECT
    cr.item_name AS crop_name,
    cs.year_code,
    COUNT(*) AS observation_count,
    COUNT(cs.numeric_value) AS available_value_count,
    AVG(cs.numeric_value) AS average_value
FROM crop_statistics cs
JOIN crops cr
    ON cs.item_code_cpc = cr.item_code_cpc
GROUP BY
    cr.item_name,
    cs.year_code;

-- 3. PROTECTED VIEW
-- WITH READ ONLY prevents INSERT, UPDATE and DELETE through this view.

CREATE OR REPLACE VIEW vw_agri_readonly AS
SELECT
    area_code_m49,
    item_code_cpc,
    element_code,
    year_code,
    flag_code,
    numeric_value,
    note
FROM crop_statistics
WITH READ ONLY;

-- End of script
