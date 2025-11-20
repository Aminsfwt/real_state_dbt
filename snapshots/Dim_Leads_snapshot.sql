{% snapshot Dim_Leads_snapshot %}

{{
    config(
        target_database='Realestate_DB',
        target_schema='snapshots',
        unique_key='lead_id',
        strategy='check',
        check_cols=[
            'max_budget',
            'min_budget'
        ]
    )
}}

select *
from {{ref('stg_leads')}}

{% endsnapshot %}