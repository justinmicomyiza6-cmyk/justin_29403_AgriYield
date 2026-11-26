
-- ============================================================
-- Student Name : Justin MICOMYIZA
-- Student ID   : 29403
-- Group        : B
-- Project      : AgriYield - Crop Yield Analysis and
--                Agricultural Decision Support System
-- Script       : 02_constraints.sql
-- Purpose      : Add primary, unique, foreign key and
--                check constraints
-- ============================================================

-- PRIMARY KEY CONSTRAINTS

ALTER TABLE countries
ADD CONSTRAINT pk_countries
PRIMARY KEY (area_code_m49);

ALTER TABLE crops
ADD CONSTRAINT pk_crops
PRIMARY KEY (item_code_cpc);

ALTER TABLE agricultural_elements
ADD CONSTRAINT pk_agricultural_elements
PRIMARY KEY (element_code);

ALTER TABLE agricultural_years
ADD CONSTRAINT pk_agricultural_years
PRIMARY KEY (year_code);

ALTER TABLE data_quality_flags
ADD CONSTRAINT pk_data_quality_flags
PRIMARY KEY (flag_code);

ALTER TABLE crop_statistics
ADD CONSTRAINT pk_crop_statistics
PRIMARY KEY (
    area_code_m49,
    item_code_cpc,
    element_code,
    year_code
);

-- UNIQUE CONSTRAINT

ALTER TABLE countries
ADD CONSTRAINT uq_countries_country_name
UNIQUE (country_name);

-- CHECK CONSTRAINTS

ALTER TABLE agricultural_years
ADD CONSTRAINT ck_agricultural_years_year_code
CHECK (year_code BETWEEN 1900 AND 2100);

ALTER TABLE crop_statistics
ADD CONSTRAINT ck_crop_statistics_numeric_value
CHECK (numeric_value IS NULL OR numeric_value >= 0);

-- FOREIGN KEY CONSTRAINTS

ALTER TABLE crop_statistics
ADD CONSTRAINT fk_crop_statistics_countries
FOREIGN KEY (area_code_m49)
REFERENCES countries (area_code_m49)
ON DELETE NO ACTION;

ALTER TABLE crop_statistics
ADD CONSTRAINT fk_crop_statistics_crops
FOREIGN KEY (item_code_cpc)
REFERENCES crops (item_code_cpc)
ON DELETE CASCADE;

ALTER TABLE crop_statistics
ADD CONSTRAINT fk_crop_statistics_agricultural_elements
FOREIGN KEY (element_code)
REFERENCES agricultural_elements (element_code)
ON DELETE NO ACTION;

ALTER TABLE crop_statistics
ADD CONSTRAINT fk_crop_statistics_agricultural_years
FOREIGN KEY (year_code)
REFERENCES agricultural_years (year_code)
ON DELETE NO ACTION;

ALTER TABLE crop_statistics
ADD CONSTRAINT fk_crop_statistics_data_quality_flags
FOREIGN KEY (flag_code)
REFERENCES data_quality_flags (flag_code)
ON DELETE SET NULL;

-- End of constraints script
