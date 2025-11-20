
WITH dim_agent AS(

    SELECT
        DISTINCT SUBSTRING(a.agent_id,1, CHARINDEX('_', a.agent_id || '_') - 1) AS agent_id,
        a.agent_name,
        a.phone,
        a.email,
        a.office_city,
        a.office_name,
        a.annual_salary,
        ROUND(a.commission_rate,3) AS commission_rate,
        a.hire_date,
        a.experience_years,
        COUNT(l.lead_id)OVER(PARTITION BY a.agent_id) AS total_leads,

        a.dbt_valid_from AS start_date,
        a.dbt_valid_to AS end_date,
        CASE WHEN a.dbt_valid_to IS NULL THEN 1 ELSE 0 END AS is_current,
        1 AS source_system_code

    FROM {{ref('Dim_Agents_snapshot')}} AS a
    LEFT JOIN {{ref('Dim_Leads_snapshot')}} AS l
        ON a.agent_id = l.agent_id
)

select 
    ROW_NUMBER() OVER (ORDER BY agent_id) AS agent_key,
    *
FROM dim_agent    