
-- ============================================================
-- Student Name : Justin MICOMYIZA
-- Student ID   : 29403
-- Group        : B
-- Project      : AgriYield - Crop Yield Analysis and
--                Agricultural Decision Support System
-- Script       : 10_validation.sql
-- Purpose      : Final database loading and integrity checks
-- ============================================================

-- 1. Verify final table row counts

SELECT 'COUNTRIES' AS table_name, COUNT(*) AS row_count
FROM countries
UNION ALL
SELECT 'CROPS', COUNT(*) FROM crops
UNION ALL
SELECT 'AGRICULTURAL_ELEMENTS', COUNT(*) FROM agricultural_elements
UNION ALL
SELECT 'AGRICULTURAL_YEARS', COUNT(*) FROM agricultural_years
UNION ALL
SELECT 'DATA_QUALITY_FLAGS', COUNT(*) FROM data_quality_flags
UNION ALL
SELECT 'CROP_STATISTICS', COUNT(*) FROM crop_statistics;

-- 2. Verify all constraints are enabled and validated

SELECT constraint_name, constraint_type, table_name,
       status, validated
FROM user_constraints
WHERE table_name IN (
    'COUNTRIES',
    'CROPS',
    'AGRICULTURAL_ELEMENTS',
    'AGRICULTURAL_YEARS',
    'DATA_QUALITY_FLAGS',
    'CROP_STATISTICS'
)
ORDER BY table_name, constraint_type, constraint_name;

-- 3. Verify missing parent records

SELECT
    (SELECT COUNT(*)
     FROM crop_statistics cs
     LEFT JOIN countries c
       ON cs.area_code_m49 = c.area_code_m49
     WHERE c.area_code_m49 IS NULL) AS missing_countries,

    (SELECT COUNT(*)
     FROM crop_statistics cs
     LEFT JOIN crops c
       ON cs.item_code_cpc = c.item_code_cpc
     WHERE c.item_code_cpc IS NULL) AS missing_crops,

    (SELECT COUNT(*)
     FROM crop_statistics cs
     LEFT JOIN agricultural_elements e
       ON cs.element_code = e.element_code
     WHERE e.element_code IS NULL) AS missing_elements,

    (SELECT COUNT(*)
     FROM crop_statistics cs
     LEFT JOIN agricultural_years y
       ON cs.year_code = y.year_code
     WHERE y.year_code IS NULL) AS missing_years,

    (SELECT COUNT(*)
     FROM crop_statistics cs
     LEFT JOIN data_quality_flags f
       ON cs.flag_code = f.flag_code
     WHERE cs.flag_code IS NOT NULL
       AND f.flag_code IS NULL) AS missing_flags
FROM dual;

-- 4. Verify numeric values

SELECT
    COUNT(*) AS total_records,
    COUNT(numeric_value) AS values_present,
    COUNT(*) - COUNT(numeric_value) AS values_missing,
    MIN(numeric_value) AS minimum_value,
    MAX(numeric_value) AS maximum_value
FROM crop_statistics;

-- 5. Summary by crop and year

SELECT
    c.item_name,
    y.year_code,
    COUNT(*) AS observations,
    COUNT(cs.numeric_value) AS values_present,
    ROUND(AVG(cs.numeric_value), 2) AS average_value
FROM crop_statistics cs
JOIN crops c
  ON cs.item_code_cpc = c.item_code_cpc
JOIN agricultural_years y
  ON cs.year_code = y.year_code
GROUP BY c.item_name, y.year_code
ORDER BY c.item_name, y.year_code;

-- 6. Summary by agricultural element

SELECT
    e.element_name,
    e.unit,
    COUNT(*) AS observations,
    ROUND(AVG(cs.numeric_value), 2) AS average_value
FROM crop_statistics cs
JOIN agricultural_elements e
  ON cs.element_code = e.element_code
GROUP BY e.element_name, e.unit
ORDER BY e.element_name;

-- 7. Subquery: crops with above-average observations

SELECT item_name
FROM crops
WHERE item_code_cpc IN (
    SELECT item_code_cpc
    FROM crop_statistics
    GROUP BY item_code_cpc
    HAVING COUNT(*) > (
        SELECT AVG(record_count)
        FROM (
            SELECT COUNT(*) AS record_count
            FROM crop_statistics
            GROUP BY item_code_cpc
        )
    )
);

-- 8. Verify staging and target row counts

SELECT
    (SELECT COUNT(*) FROM stg_faostat_raw) AS raw_staging_rows,
    (SELECT COUNT(*) FROM stg_faostat_clean) AS cleaned_staging_rows,
    (SELECT COUNT(*) FROM crop_statistics) AS target_rows
FROM dual;

-- End of validation script
