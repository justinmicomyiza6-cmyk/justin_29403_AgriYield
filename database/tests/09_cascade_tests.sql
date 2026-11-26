
-- ============================================================
-- Student Name : Justin MICOMYIZA
-- Student ID   : 29403
-- Group        : B
-- Project      : AgriYield
-- Script       : 09_cascade_tests.sql
-- Purpose      : Demonstrate foreign key delete rules
-- ============================================================

-- TEST 1: ON DELETE CASCADE
-- Deleting a temporary crop should delete its statistics.

INSERT INTO crops (item_code_cpc, item_name)
VALUES ('TESTCROP', 'Temporary Crop');

INSERT INTO crop_statistics (
    area_code_m49, item_code_cpc, element_code,
    year_code, flag_code, numeric_value, note
)
VALUES (
    '108', 'TESTCROP', '5312',
    2014, 'A', 100, 'Cascade test'
);

SELECT COUNT(*) AS BEFORE_CASCADE
FROM crop_statistics
WHERE item_code_cpc = 'TESTCROP';

DELETE FROM crops
WHERE item_code_cpc = 'TESTCROP';

SELECT COUNT(*) AS AFTER_CASCADE
FROM crop_statistics
WHERE item_code_cpc = 'TESTCROP';


-- TEST 2: ON DELETE SET NULL

INSERT INTO countries (area_code_m49, country_name)
VALUES ('9999', 'Temporary Test Country');

INSERT INTO data_quality_flags (flag_code, flag_description)
VALUES ('Z', 'Temporary test flag');

INSERT INTO crop_statistics (
    area_code_m49, item_code_cpc, element_code,
    year_code, flag_code, numeric_value, note
)
VALUES (
    '9999', '01701', '5312',
    2014, 'Z', 100, 'Set null test'
);

DELETE FROM data_quality_flags
WHERE flag_code = 'Z';

SELECT flag_code
FROM crop_statistics
WHERE area_code_m49 = '9999'
  AND item_code_cpc = '01701'
  AND element_code = '5312'
  AND year_code = 2014;

-- Cleanup temporary test records
DELETE FROM crop_statistics
WHERE area_code_m49 = '9999';

DELETE FROM countries
WHERE area_code_m49 = '9999';

-- TEST 3: NO ACTION (Oracle default)
-- Deleting a country referenced by statistics must fail.

DELETE FROM countries
WHERE area_code_m49 = '108';

-- Expected: ORA-02292 (child record found).

-- End of delete-rule tests.
