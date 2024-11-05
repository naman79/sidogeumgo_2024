select count(*) as cnt from rpt_sunap_jibgye
where 1=1
and sunapil BETWEEN '20241001' and '20241031'


select * from rpt_sunap_jibgye
where 1=1
and sunapil BETWEEN '20241001' and '20241031'
and jibgye_code not in (300000, 304000)
order by sunapil 

select KEORAEIL,
sunapil,
 GEORAE_GUBUN,
 jibgye_code,
 sum(BONSE_AMT) as BONSE_AMT,
 sum(SEWOI_AMT) as SEWOI_AMT,
 sum(GYOYUKSE_AMT) as GYOYUKSE_AMT ,
 sum(NONGTEUKSE_AMT) as NONGTEUKSE_AMT,
0 as to_KEORAEIL ,
0 as to_sunapil ,
 0 as to_GEORAE_GUBUN ,
 0  as to_jibgye_code,
0  as to_BONSE_AMT,
 0   as to_SEWOI_AMT,
 0   as to_GYOYUKSE_AMT ,
0   as to_NONGTEUKSE_AMT from rpt_sunap_jibgye
where 1=1
and GEUMGO_CODE = 28
and sunapil BETWEEN '20241010' and '20241010'
and jibgye_code not in (300000, 304000)
group by KEORAEIL, sunapil, GEORAE_GUBUN, jibgye_code

select 
KEORAEIL,
sunapil,
 GEORAE_GUBUN,
 jibgye_code,
  sum(BONSE_AMT) as BONSE_AMT,
 sum(SEWOI_AMT) as SEWOI_AMT,
 sum(GYOYUKSE_AMT) as GYOYUKSE_AMT ,
 sum(NONGTEUKSE_AMT) as NONGTEUKSE_AMT,
 KEORAEIL as to_KEORAEIL ,
sunapil as to_sunapil ,
 GEORAE_GUBUN as to_GEORAE_GUBUN ,
 jibgye_code  as to_jibgye_code,
 sum(BONSE_AMT)   as to_BONSE_AMT,
 sum(SEWOI_AMT)   as to_SEWOI_AMT,
 sum(GYOYUKSE_AMT)   as to_GYOYUKSE_AMT ,
 sum(NONGTEUKSE_AMT)
(
select KEORAEIL,
sunapil,
 GEORAE_GUBUN,
 jibgye_code,
 BONSE_AMT as BONSE_AMT,
 SEWOI_AMT as SEWOI_AMT,
 GYOYUKSE_AMT as GYOYUKSE_AMT ,
 NONGTEUKSE_AMT as NONGTEUKSE_AMT,
0 as to_KEORAEIL ,
0 as to_sunapil ,
 0 as to_GEORAE_GUBUN ,
 0  as to_jibgye_code,
0  as to_BONSE_AMT,
 0   as to_SEWOI_AMT,
 0   as to_GYOYUKSE_AMT ,
0   as to_NONGTEUKSE_AMT from rpt_sunap_jibgye
where 1=1
and GEUMGO_CODE = 28
and sunapil BETWEEN '20241010' and '20241010'
and jibgye_code not in (300000, 304000)
unio all 
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
 BONSE_AMT   as to_BONSE_AMT,
 SEWOI_AMT   as to_SEWOI_AMT,
 GYOYUKSE_AMT   as to_GYOYUKSE_AMT ,
 NONGTEUKSE_AMT   as to_NONGTEUKSE_AMT from rpt_sunap_jibgye_tmp
where 1=1
and GEUMGO_CODE = 28
and sunapil BETWEEN '20241010' and '20241010'
) A
group by KEORAEIL, sunapil, GEORAE_GUBUN, jibgye_code, to_KEORAEIL, to_sunapil, to_GEORAE_GUBUN, to_jibgye_code

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
and sunapil BETWEEN '20241010' and '20241010'
group by to_KEORAEIL, to_sunapil, to_GEORAE_GUBUN, to_jibgye_code