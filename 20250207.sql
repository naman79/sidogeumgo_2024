select
    sum(janaek) as jan
from rpt_gonggeum_jan
where 1=1
and geumgo_code = 43
and keoraeil between  '20240701' and '20241231'