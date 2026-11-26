
-- ============================================================
-- Student Name : Justin MICOMYIZA
-- Student ID   : 29403
-- Group        : B
-- Project      : AgriYield - Crop Yield Analysis and
--                Agricultural Decision Support System
-- Script       : 06_clean.sql
-- Purpose      : Clean and validate imported FAOSTAT data
-- ============================================================

-- 1. Create a cleaning audit table

CREATE TABLE data_cleaning_audit (
    audit_id       NUMBER GENERATED ALWAYS AS IDENTITY,
    cleaning_step  VARCHAR2(100) NOT NULL,
    rows_affected  NUMBER NOT NULL,
    details        VARCHAR2(500),
    audit_date     DATE DEFAULT SYSDATE
)
TABLESPACE agriyield_data;

-- 2. Create the cleaned staging table

CREATE TABLE stg_faostat_clean (
    domain_code       VARCHAR2(100),
    domain_name       VARCHAR2(100),
    area_code_m49     VARCHAR2(10),
    area_name         VARCHAR2(100),
    element_code      VARCHAR2(10),
    element_name      VARCHAR2(100),
    item_code_cpc     VARCHAR2(10),
    item_name         VARCHAR2(100),
    year_code         NUMBER(4),
    year_name         NUMBER(4),
    unit              VARCHAR2(20),
    numeric_value     NUMBER(10,2),
    flag_code         CHAR(1),
    flag_description  VARCHAR2(100),
    note              VARCHAR2(100)
)
TABLESPACE agriyield_data;

-- 3. Count rows containing leading/trailing spaces

INSERT INTO data_cleaning_audit
    (cleaning_step, rows_affected, details)
SELECT
    'Whitespace inspection',
    COUNT(*),
    'Rows containing leading or trailing spaces in text columns'
FROM stg_faostat_raw
WHERE
    domain_code <> TRIM(domain_code)
    OR area_code_m49 <> TRIM(area_code_m49)
    OR area_name <> TRIM(area_name)
    OR element_code <> TRIM(element_code)
    OR element_name <> TRIM(element_name)
    OR item_code_cpc <> TRIM(item_code_cpc)
    OR item_name <> TRIM(item_name)
    OR year_code <> TRIM(year_code)
    OR year_name <> TRIM(year_name)
    OR unit <> TRIM(unit)
    OR value_text <> TRIM(value_text)
    OR flag_code <> TRIM(flag_code)
    OR flag_description <> TRIM(flag_description)
    OR note <> TRIM(note);

-- 4. Clean spaces and convert year/value fields

INSERT INTO stg_faostat_clean (
    domain_code, domain_name,
    area_code_m49, area_name,
    element_code, element_name,
    item_code_cpc, item_name,
    year_code, year_name,
    unit, numeric_value,
    flag_code, flag_description, note
)
SELECT
    TRIM(domain_code),
    TRIM(domain_name),
    TRIM(area_code_m49),
    TRIM(area_name),
    TRIM(element_code),
    TRIM(element_name),
    TRIM(item_code_cpc),
    TRIM(item_name),
    TO_NUMBER(TRIM(year_code)),
    TO_NUMBER(TRIM(year_name)),
    TRIM(unit),
    CASE
        WHEN TRIM(value_text) IS NULL THEN NULL
        ELSE TO_NUMBER(TRIM(value_text))
    END,
    TRIM(flag_code),
    TRIM(flag_description),
    TRIM(note)
FROM stg_faostat_raw;

-- 5. Record the number of rows cleaned

INSERT INTO data_cleaning_audit
    (cleaning_step, rows_affected, details)
SELECT
    'Trim and type conversion',
    COUNT(*),
    'Rows copied into cleaned staging table; years and values converted'
FROM stg_faostat_clean;

-- 6. Record duplicate removal result
-- The source inspection found zero duplicate key groups.
-- No source rows are deleted.

INSERT INTO data_cleaning_audit
    (cleaning_step, rows_affected, details)
VALUES (
    'Duplicate inspection',
    0,
    'No duplicate composite-key groups found in raw staging data'
);

-- 7. Record missing numeric values preserved as NULL

INSERT INTO data_cleaning_audit
    (cleaning_step, rows_affected, details)
SELECT
    'Missing numeric values preserved',
    COUNT(*),
    'Missing values retained as NULL with their original flags'
FROM stg_faostat_clean
WHERE numeric_value IS NULL;

COMMIT;

-- End of cleaning script
