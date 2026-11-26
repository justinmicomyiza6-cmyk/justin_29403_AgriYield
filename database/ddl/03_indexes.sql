
-- ============================================================
-- Student Name : Justin MICOMYIZA
-- Student ID   : 29403
-- Group        : B
-- Project      : AgriYield - Crop Yield Analysis and
--                Agricultural Decision Support System
-- Script       : 03_indexes.sql
-- Purpose      : Create indexes for foreign keys and queries
-- ============================================================

-- Indexes on foreign key columns

CREATE INDEX idx_cs_area
ON crop_statistics (area_code_m49)
TABLESPACE agriyield_idx;

CREATE INDEX idx_cs_crop
ON crop_statistics (item_code_cpc)
TABLESPACE agriyield_idx;

CREATE INDEX idx_cs_element
ON crop_statistics (element_code)
TABLESPACE agriyield_idx;

CREATE INDEX idx_cs_year
ON crop_statistics (year_code)
TABLESPACE agriyield_idx;

CREATE INDEX idx_cs_flag
ON crop_statistics (flag_code)
TABLESPACE agriyield_idx;

-- Composite index for crop and year analysis

CREATE INDEX idx_cs_crop_year
ON crop_statistics (item_code_cpc, year_code)
TABLESPACE agriyield_idx;

-- Function-based index for case-insensitive country searches

CREATE INDEX idx_countries_upper_name
ON countries (UPPER(country_name))
TABLESPACE agriyield_idx;
-- End of script
