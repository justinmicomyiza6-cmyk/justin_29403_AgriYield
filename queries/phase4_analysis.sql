-- 1. Reporting JOIN
SELECT *
FROM vw_agri_reporting
FETCH FIRST 10 ROWS ONLY;

-- 2. GROUP BY summary
SELECT crop_name, year_code,
       COUNT(*) AS observations,
       ROUND(AVG(numeric_value), 2) AS average_value
FROM vw_agri_reporting
GROUP BY crop_name, year_code
ORDER BY crop_name, year_code;

-- 3. Subquery
SELECT item_name
FROM crops
WHERE item_code_cpc IN (
    SELECT item_code_cpc
    FROM crop_statistics
    GROUP BY item_code_cpc
    HAVING COUNT(*) > (
        SELECT AVG(crop_count)
        FROM (
            SELECT COUNT(*) AS crop_count
            FROM crop_statistics
            GROUP BY item_code_cpc
        )
    )
);
