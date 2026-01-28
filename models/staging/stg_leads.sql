

WITH leads_src AS(
    SELECT 
        lead_id,
        --TO_NUMBER(REGEXP_REPLACE(lead_id, '\\D', '')) as lead_id,
        lead_name,
        phone,
        mail,
        contact_date,
        last_contact_date,
        conversion_date,
        num_calls,
        lead_status,
        lead_source,
        purchased,
        agent_id,
        campaign_id,
        --TO_NUMBER(REGEXP_REPLACE(agent_id, '\\D', '')) AS agent_id,
        --TO_NUMBER(REGEXP_REPLACE(campaign_id, '\\D', '')) AS campaign_id,
        min_budget,
        max_budget

    FROM {{source('RAW_DATA','lead')}}
) 

select 
    *
from leads_src

