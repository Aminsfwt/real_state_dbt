
WITH fact_sales AS(
    SELECT 
        t.transaction_id,
        l.lead_key AS customer_key,
        p.property_key,
        a.agent_key,
        c.campaign_key,
        d.date_key,
        t.sale_price,
        (t.sale_price * (a.commission_rate )) AS commission_amount,
        ROUND(((t.sale_price - t.original_property_price) / t.sale_price * 100),2) AS profit_margin,
        CURRENT_TIMESTAMP() AS created_at
    FROM {{ref('stg_transactions')}} t
    JOIN {{ref('Dim_Agent')}} a
        ON t.agent_id = a.agent_id
    JOIN {{ref('Dim_Property')}} p
        ON t.property_id = p.property_id    
    JOIN {{ref('Dim_Date')}} d
        ON t.sale_date = d.full_date       
    LEFT JOIN {{ref('Dim_Lead')}} l 
        ON t.customer_id = l.lead_id 
        AND l.purchased = 'yes'
    LEFT JOIN {{ref('Dim_Campaign')}} c
        ON l.campaign_id = c.campaign_id    
)

SELECT
    ROW_NUMBER() OVER (ORDER BY transaction_id) AS fact_sales_key,
    *
FROM fact_sales