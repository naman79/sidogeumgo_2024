select * from RPT_UNYONG_JAN
where 1=1
and KIJUNIL like '%0102'
and GEUMGO_CODE = 28 
and (gonggeum_gyejwa, unyong_gyejwa) in (
select gonggeum_gyejwa, unyong_gyejwa from RPT_UNYONG_GYEJWA
where 1=1
and GEUMGO_CODE = 28
and HJI_DT in (
select 
    biz_dt
from MAP_JOB_DATE
where DW_BAS_DDT like '%1231'
and biz_dt not like '%1231'
))