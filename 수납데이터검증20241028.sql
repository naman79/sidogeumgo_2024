-- 검증쿼리

select 
A.KEORAEIL,
A.sunapil,
 A.GEORAE_GUBUN,
 A.jibgye_code,
  sum(A.BONSE_AMT) as BONSE_AMT,
 sum(A.SEWOI_AMT) as SEWOI_AMT,
 sum(A.GYOYUKSE_AMT) as GYOYUKSE_AMT ,
 sum(A.NONGTEUKSE_AMT) as NONGTEUKSE_AMT,
 A.to_GEORAE_GUBUN ,
 A.to_jibgye_code,
 sum(A.to_BONSE_AMT)   as to_BONSE_AMT,
 sum(A.to_SEWOI_AMT)   as to_SEWOI_AMT,
 sum(A.to_GYOYUKSE_AMT)   as to_GYOYUKSE_AMT ,
 sum(A.to_NONGTEUKSE_AMT)
(
select KEORAEIL,
sunapil,
 GEORAE_GUBUN,
 jibgye_code,
 BONSE_AMT as BONSE_AMT,
 SEWOI_AMT as SEWOI_AMT,
 GYOYUKSE_AMT as GYOYUKSE_AMT ,
 NONGTEUKSE_AMT as NONGTEUKSE_AMT,
 0 as to_GEORAE_GUBUN ,
 0  as to_jibgye_code,
0  as to_BONSE_AMT,
 0   as to_SEWOI_AMT,
 0   as to_GYOYUKSE_AMT ,
0   as to_NONGTEUKSE_AMT from rpt_sunap_jibgye
where 1=1
and GEUMGO_CODE = 28
and sunapil BETWEEN '20241025' and '20241025'
and jibgye_code not in (300000, 304000)
union all 
select 
KEORAEIL as KEORAEIL,
sunapil  as sunapil,
 0  as GEORAE_GUBUN,
 0  as jibgye_code,
 0 as BONSE_AMT,
 0 as SEWOI_AMT,
 0 as GYOYUKSE_AMT ,
 0 as NONGTEUKSE_AMT ,
 GEORAE_GUBUN as to_GEORAE_GUBUN ,
 jibgye_code  as to_jibgye_code,
 BONSE_AMT   as to_BONSE_AMT,
 SEWOI_AMT   as to_SEWOI_AMT,
 GYOYUKSE_AMT   as to_GYOYUKSE_AMT ,
 NONGTEUKSE_AMT   as to_NONGTEUKSE_AMT from rpt_sunap_jibgye_tmp
where 1=1
and GEUMGO_CODE = 28
and sunapil BETWEEN '20241025' and '20241025'
) A
group by KEORAEIL, sunapil, GEORAE_GUBUN, jibgye_code, to_GEORAE_GUBUN, to_jibgye_code

---------------------------------------------------------------------------
select count(*) as cnt from rpt_sunap_jibgye
where 1=1
and sunapil BETWEEN '20241001' and '20241031'


select * from rpt_sunap_jibgye
where 1=1
and sunapil BETWEEN '20241001' and '20241031'
and jibgye_code not in (300000, 304000)
order by sunapil 



----------------------------------------------------------------------------------------------------------

select count(*) as cnt from rpt_sunap_jibgye_tmp
where 1=1
and sunapil BETWEEN '20241001' and '20241031'


select * from rpt_sunap_jibgye_tmp
where 1=1
and sunapil BETWEEN '20241001' and '20241031'
order by sunapil 

select 
0 as KEORAEIL,
0  as sunapil,
 0  as GEORAE_GUBUN,
 0  as jibgye_code,
 0 as BONSE_AMT,
 0 as SEWOI_AMT,
 0 as GYOYUKSE_AMT ,
 0 as NONGTEUKSE_AMT ,
KEORAEIL as to_KEORAEIL ,
sunapil as to_sunapil ,
 GEORAE_GUBUN as to_GEORAE_GUBUN ,
 jibgye_code  as to_jibgye_code,
 sum(BONSE_AMT)   as to_BONSE_AMT,
 sum(SEWOI_AMT)   as to_SEWOI_AMT,
 sum(GYOYUKSE_AMT)   as to_GYOYUKSE_AMT ,
 sum(NONGTEUKSE_AMT)   as to_NONGTEUKSE_AMT from rpt_sunap_jibgye_tmp
where 1=1
and GEUMGO_CODE = 28
and sunapil BETWEEN '20241025' and '20241025'
group by to_KEORAEIL, to_sunapil, to_GEORAE_GUBUN, to_jibgye_code