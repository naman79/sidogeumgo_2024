SELECT
   geumgo_code, jibgye_code, gungu_code
from RPT_DANGSEIPJOJEONG
where 1=1
and geumgo_code = 28
and jibgye_code < '700000'
group by geumgo_code, jibgye_code, gungu_code
order by geumgo_code, jibgye_code, gungu_code