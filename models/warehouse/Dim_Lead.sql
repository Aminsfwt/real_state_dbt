
WITH dim_leads AS
(
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
        agent_id,
        campaign_id,
        min_budget,
        max_budget,

        dbt_valid_from AS start_date,
        dbt_valid_to AS end_date,
        CASE WHEN dbt_valid_to IS NULL THEN 1 ELSE 0 END AS is_current,
        1 AS source_system_code

    FROM {{ref('Dim_Leads_snapshot')}}
)

select 
    ROW_NUMBER() OVER (ORDER BY lead_id) AS lead_key,
    *
FROM dim_leads    
