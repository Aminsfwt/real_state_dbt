WITH agents AS (
    SELECT 
        agent_id,
        agent_name,
        phone,
        email,
        office_city,
        office_name,
        annual_salary,
        ROUND(commission_rate,3) AS commission_rate,
        hire_date,
        experience_years,
        dbt_valid_from AS strt_date,
        dbt_valid_to   AS ed_date,
        CASE WHEN dbt_valid_to IS NULL THEN 1 ELSE 0 END AS is_current
    FROM {{ ref('Dim_Agents_snapshot') }}
),

lead_counts AS (
    SELECT 
        agent_id,
        COUNT(DISTINCT lead_id) AS total_leads
    FROM {{ ref('Dim_Leads_snapshot') }}
    GROUP BY agent_id
)

SELECT
    ROW_NUMBER() OVER (
        ORDER BY TO_NUMBER(REGEXP_SUBSTR(a.agent_id, '^[0-9]+'))
    ) AS agent_key,
    a.*,
    COALESCE(l.total_leads,0) AS total_leads,
    1 AS source_system_code
FROM agents a
LEFT JOIN lead_counts l
    ON a.agent_id = l.agent_id
