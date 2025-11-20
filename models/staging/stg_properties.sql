
WITH properties_src AS(

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
        SUBSTRING(agent_id,1, CHARINDEX('_', agent_id || '_') - 1) AS agent_id,
        availability_status

    FROM {{source('RAW_DATA', 'properties')}}
)

select *
from properties_src