
-- ============================================================
-- Student Name : Justin MICOMYIZA
-- Student ID   : 29403
-- Group        : B
-- Project      : AgriYield
-- Script       : 08_constraint_tests.sql
-- Purpose      : Demonstrate database constraint enforcement
-- ============================================================

-- TEST 1: PRIMARY KEY violation
-- Expected: ORA-00001 (duplicate primary key)

INSERT INTO countries (area_code_m49, country_name)
VALUES ('108', 'Duplicate Country');

-- TEST 2: UNIQUE constraint violation
-- Expected: ORA-00001 (duplicate country name)

INSERT INTO countries (area_code_m49, country_name)
VALUES ('999', 'Burundi');

-- TEST 3: NOT NULL constraint violation
-- Expected: ORA-01400

INSERT INTO crops (item_code_cpc, item_name)
VALUES ('TEST01', NULL);

-- TEST 4: CHECK constraint violation
-- Expected: ORA-02290

INSERT INTO agricultural_years (year_code)
VALUES (1800);

-- TEST 5: FOREIGN KEY constraint violation
-- Expected: ORA-02291

INSERT INTO crop_statistics (
    area_code_m49,
    item_code_cpc,
    element_code,
    year_code,
    flag_code,
    numeric_value,
    note
)
VALUES (
    '9999',
    '01701',
    '5312',
    2024,
    'A',
    100,
    'Invalid country test'
);

-- TEST 6: CHECK constraint violation for negative value
-- Expected: ORA-02290

UPDATE crop_statistics
SET numeric_value = -100
WHERE ROWNUM = 1;

-- No COMMIT is required because all tests should fail.
-- End of constraint tests.
