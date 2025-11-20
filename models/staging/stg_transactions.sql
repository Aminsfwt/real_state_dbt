
WITH transations_stg AS(
    SELECT 
        transaction_id,
        property_id,
        lead_id AS customer_id,
        SUBSTRING(agent_id,1, CHARINDEX('_', agent_id || '_') - 1) AS agent_id,
        sale_date,
        sale_price,
        payment_method,
        commission_amount,
        commission_rate,
        original_property_price,
        governorate_code


    FROM {{source('RAW_DATA', 'transactions')}} 
)

SELECT * 
FROM transations_stg