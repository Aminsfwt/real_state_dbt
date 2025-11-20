
WITH dates AS (
    SELECT 
        DATEADD(day, seq4(), '2010-01-01'::DATE) AS full_date
    FROM TABLE(GENERATOR(ROWCOUNT => 10000)) -- adjust rowcount for date range
)
SELECT
    TO_NUMBER(TO_CHAR(full_date, 'DDMMYYYY')) AS date_key,
    full_date,
    YEAR(full_date) AS year,
    MONTH(full_date) AS month,
    DAY(full_date) AS day,
    WEEK(full_date) AS week,
    TO_CHAR(full_date, 'DY') AS day_name,
    CASE WHEN MONTH(full_date) <= 6 THEN 'H1' ELSE 'H2' END AS half_year,
    QUARTER(full_date) AS quarter,
    DAYOFYEAR(full_date) AS day_of_year,
    CASE WHEN DAYOFWEEK(full_date) IN (1,7) THEN 0 ELSE 1 END AS is_weekday,
    CASE WHEN MONTH(full_date) = 12 AND DAY(full_date) = 25 THEN 1 ELSE 0 END AS is_holiday
FROM dates
WHERE full_date <= CURRENT_DATE
ORDER BY full_date