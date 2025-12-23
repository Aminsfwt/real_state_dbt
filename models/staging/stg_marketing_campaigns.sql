

with campaigns_src AS(
    SELECT 
        SUBSTRING(campaign_id,1, CHARINDEX('_', campaign_id || '_') - 1) AS campaign_id,
        LEFT(campaign_name, LEN(campaign_name) - CHARINDEX(' ', REVERSE(campaign_name))) AS campaign_name,
        start_date, 
        end_date ,
        budget,
        clicks,
        impressions,
        marketing_channel,
        governorate_name,
        campaign_type,
        campaign_status,
        target_leads_nums

    FROM {{source('RAW_DATA', 'marketing_campaign')}}
)

select * 
from campaigns_src

