
WITH campaigns AS (
    SELECT 
        c.campaign_id,
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
        
        c.dbt_valid_from AS strt_date,
        c.dbt_valid_to   AS ed_date,
        CASE WHEN c.dbt_valid_to IS NULL THEN 1 ELSE 0 END AS is_current,
        
        1 AS source_system_code
    FROM {{ ref('Dim_Campaigns_snapshot') }} c
),

lead_stats AS (
    SELECT 
        campaign_id,
        COUNT(DISTINCT lead_id) AS total_leads,
        COUNT_IF(LOWER(purchased) = 'yes') AS converted_leads
    FROM {{ ref('Dim_Leads_snapshot') }}
    GROUP BY campaign_id
)

SELECT 
    ROW_NUMBER() OVER (
        ORDER BY TO_NUMBER(REGEXP_SUBSTR(c.campaign_id, '^[0-9]+'))
    ) AS campaign_key,
    c.*,
    COALESCE(l.total_leads, 0)     AS total_leads,
    COALESCE(l.converted_leads, 0) AS converted_leads
FROM campaigns c
LEFT JOIN lead_stats l
    ON c.campaign_id = l.campaign_id

