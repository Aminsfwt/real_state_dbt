
{% snapshot Dim_Properties_snapshot %}

{{
    config(
        target_database='Realestate_DB',
        target_schema='snapshots',
        unique_key='property_id',
        strategy='check',
        check_cols=[
            'property_price',
            'renovation_cost'
        ]
    )
}}

select *
from {{ref('stg_properties')}}

{% endsnapshot %}