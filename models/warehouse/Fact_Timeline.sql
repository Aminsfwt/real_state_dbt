

WITH fact_sales AS(
    SELECT 
        t.transaction_id,
        l.lead_key,
        p.property_key,
        a.agent_key,
        cd.date_key AS Contact_date_key,
        ld.date_key AS Last_Contact_date_key,
        ccd.date_key AS Conversion_date_key,
        CURRENT_TIMESTAMP() AS created_at
    FROM {{ref('stg_transactions')}} AS t
    JOIN {{ref('Dim_Agent')}} a
        ON t.agent_id = a.agent_id
    JOIN {{ref('Dim_Property')}} p
        ON t.property_id = p.property_id              
    JOIN {{ref('Dim_Lead')}} AS l 
        ON t.customer_id = l.lead_id 
        AND l.purchased = 'yes'
    JOIN {{ref('Dim_Date')}} cd
        ON l.contact_date = cd.full_date  
    JOIN {{ref('Dim_Date')}} ld
        ON l.last_contact_date = ld.full_date 
    JOIN {{ref('Dim_Date')}} ccd
        ON l.conversion_date = ccd.full_date     
)

SELECT
    ROW_NUMBER() OVER (ORDER BY transaction_id) AS fact_sales_key,
    *
FROM fact_sales