
WITH transations_stg AS(
    SELECT 
        transaction_id,
        TO_NUMBER(REGEXP_REPLACE(property_id, '\\D', '')) AS property_id,
        TO_NUMBER(REGEXP_REPLACE(lead_id, '\\D', '')) AS customer_id,
        TO_NUMBER(REGEXP_REPLACE(agent_id, '\\D', '')) AS agent_id,
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