
WITH dim_campaign AS
(
    SELECT 
        DISTINCT c.campaign_id,
        c.campaign_name,
        c.start_date,
        c.end_date,
        c.budget,
        c.clicks,
        c.impressions,
        c.marketing_channel,
        c.governorate_name,
        c.campaign_type,
        c.campaign_status,
        c.target_leads_nums,

        COUNT(l.lead_id) OVER(PARTITION BY c.campaign_id) AS total_leads,
        SUM(CASE WHEN l.purchased = 'Yes' THEN 1 ELSE 0 END)
            OVER (PARTITION BY c.campaign_id) AS converted_leads,

        c.dbt_valid_from AS strt_date,
        c.dbt_valid_to AS ed_date,
        CASE WHEN c.dbt_valid_to IS NULL THEN 1 ELSE 0 END AS is_current,

        1 AS source_system_code    

    FROM {{ref('Dim_Campaigns_snapshot')}} AS c
    LEFT JOIN {{ref('Dim_Leads_snapshot')}} AS l
        ON c.campaign_id = l.campaign_id
)

SELECT 
    ROW_NUMBER() OVER (ORDER BY campaign_id) AS campaign_key,
        *
FROM dim_campaign
