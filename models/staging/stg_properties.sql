
WITH properties_src AS(

    SELECT 
        TO_NUMBER(REGEXP_REPLACE(property_id, '\\D', '')) AS property_id,
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
        TO_NUMBER(REGEXP_REPLACE(agent_id, '\\D', '')) AS agent_id,
        availability_status

    FROM {{source('RAW_DATA', 'properties')}}
)

select *
from properties_src