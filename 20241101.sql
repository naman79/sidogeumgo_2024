select
column_id,
owner as owner_name,
table_name,
column_name,
data_type,
data_length,
nullable
from all_tab_columns
where 1=1
and (
table_name like 'ACL%'
or table_name like 'RPT%'
or table_name like 'CST%'
)
order by table_name, column_id

----------------------------------------------------
select
column_id as id,
table_name as table_nm ,
column_name as column_nm
from all_tab_columns
where 1=1
and (
table_name like 'ACL%'
or table_name like 'RPT%'
or table_name like 'CST%'
)
order by table_name, column_id

----------------------------------------------------

select 
 sunapil,
 geumgo_code,
 GUNGU_CODE,
 jibgye_code,
 sum(BONSE_AMT) as BONSE_AMT
from rpt_sunap_jibgye
where 1=1
and geumgo_code = 28
and georae_gubun = 3
and sunapil BETWEEN '20241001' and '20241031'
group by sunapil,
 geumgo_code,
 GUNGU_CODE,
 jibgye_code
order by sunapil, geumgo_code, GUNGU_CODE, jibgye_code

select 
count(*) as cnt
from rpt_sunap_jibgye
where 1=1
and geumgo_code = 28
and georae_gubun = 3
and sunapil BETWEEN '20241001' and '20241031'

----------------------------------------------------
select 
 sunapil,
 sum(BONSE_AMT) as BONSE_AMT
from rpt_sunap_jibgye
where 1=1
and geumgo_code = 28
and georae_gubun = 3
and sunapil BETWEEN '20241001' and '20241031'
group by sunapil
order by sunapil

----------------------------------------------------

select 
 GJDT,
 sum(tramt) as tramt
from acl_sigumgo_slv
where 1=1
and sigumgo_org_c = 28
and sigumgo_trx_g = 64
and GJDT BETWEEN '20241001' and '20241031'
group by  GJDT
 order by GJDT

----------------------------------------------------


select 
 gisdt,
 sum(tramt) as tramt
from acl_sigumgo_slv
where 1=1
and sigumgo_org_c = 28
and sigumgo_trx_g = 64
and gisdt BETWEEN '20241001' and '20241031'
group by  gisdt
 order by gisdt

-------------------------------------------------------

select 
 gisdt,
 sigumgo_org_c,
 ICH_SIGUMGO_GUN_GU_C,
 ICH_SIGUMGO_HOIKYE_C,
 sum(tramt) as tramt
from acl_sigumgo_slv
where 1=1
and sigumgo_org_c = 28
and sigumgo_trx_g = 64
and gisdt BETWEEN '20241001' and '20241031'
group by  gisdt,
 sigumgo_org_c,
 ICH_SIGUMGO_GUN_GU_C,
 ICH_SIGUMGO_HOIKYE_C
 order by gisdt, sigumgo_org_c, ICH_SIGUMGO_GUN_GU_C, ICH_SIGUMGO_HOIKYE_C


----------------------------------------------------

select 
 count(*) as cnt
from acl_sigumgo_slv
where 1=1
and sigumgo_org_c = 28
and sigumgo_trx_g = 64
and gisdt BETWEEN '20241001' and '20241031'