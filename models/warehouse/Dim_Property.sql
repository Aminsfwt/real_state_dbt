

WITH dim_property AS
(
    SELECT 
        property_id,
        governorate,
        governorate_lat,
        governorate_lon,
        city,
        compound,
        compound_lat,
        compound_lon,
        property_type,
        property_status,
        bedrooms,
        area,
        property_price,
        selling_price,
        renovation_cost,
        agent_id,
        availability_status,

        dbt_valid_from AS start_date,
        dbt_valid_to AS end_date,
        CASE WHEN dbt_valid_to IS NULL THEN 1 ELSE 0 END AS is_current,
        1 AS source_system_code

    FROM {{ref('Dim_Properties_snapshot')}}
)

select 
    ROW_NUMBER() OVER (ORDER BY property_id) AS property_key,
    *
FROM dim_property    