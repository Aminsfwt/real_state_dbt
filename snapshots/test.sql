{% snapshot test_t %}

{{
    config(
        target_database='Realestate_DB',
        target_schema='RAW_DATA',
        unique_key='id',
        strategy='check',

        check_cols=[
            'stat'
        ],
    )
}}

select *
    from {{source('RAW_DATA', 'test')}}

{% endsnapshot %}
