{{ 
    test_agent_commission(column_name="commission_rate", 
    model=get_where_subquery(ref('stg_agents'))) 
}}
