
WITH leads_src AS(
    SELECT 
        lead_id,
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
        SUBSTRING(agent_id,1, CHARINDEX('_', agent_id || '_') - 1) AS agent_id,
        SUBSTRING(campaign_id,1, CHARINDEX('_', campaign_id || '_') - 1) AS campaign_id,
        min_budget,
        max_budget

    FROM {{source('RAW_DATA','leads')}}
) 

select *
from leads_src