with agent_coms as
(
    select * from {{source('RAW_DATA', 'agents')}}
)

select * 
from agent_coms
where commission_rate > 1
AND agent_id 