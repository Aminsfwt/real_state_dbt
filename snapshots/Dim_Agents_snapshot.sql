
-- SCD2 FOR Dim_Agents
{% snapshot Dim_Agents_snapshot %}

{{
    config(
        target_database='EGYPT_REAL_ESTATE_DB',
        target_schema='snapshots',
        unique_key='agent_id',
        strategy='check',
        check_cols=[
            'annual_salary',
            'commission_rate',
            'office_city',
            'office_name'
        ]
    )
}}

select *
from {{ ref('stg_agents') }}

{% endsnapshot %}