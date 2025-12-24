

with agent_src AS(
    SELECT
        TO_NUMBER(REGEXP_REPLACE(agent_id, '\\D', '')) AS agent_id,
        agent_name,
        phone,
        email,
        office_city,
        office_name,
        annual_salary,
        ROUND(commission_rate,3) AS commission_rate,
        hire_date,
        experience_years
    FROM {{source('RAW_DATA', 'agent')}}
)

select * FROM agent_src      

    