{% snapshot Dim_Campaigns_snapshot %}

{{
    config(
        target_database='Realestate_DB',
        target_schema='snapshots',
        unique_key='campaign_id',
        strategy='check',
        check_cols=[
            'budget'
        ]
    )
}}

select 
    *
from {{ref('stg_marketing_campaigns')}}

{% endsnapshot %}