-- 강원도 통합공금 계좌 정보 확인
select 
 * 
from ACL_SIGUMGO_MAS
where MNG_NO = 1
and sigumgo_org_c = 42 
and LINK_ACSER = '125420'

-- 강원도 통합공금
-- 04200080900003999

-- 강원도 통합공금 자금운용계좌 정보 확인
-- unyong_gyejwa = '160000125420'


select 
 *
from RPT_UNYONG_GYEJWA
where GEUMGO_CODE = 42
and unyong_gyejwa = '160000125420'

-- 강원도 통합공금 자금운용계좌 잔액정보 확인

select 
 *
from RPT_UNYONG_JAN
where GEUMGO_CODE = 42
and unyong_gyejwa = '160000125420'


select 
 *
from RPT_UNYONG_JAN
where GEUMGO_CODE = 42
and unyong_gyejwa = '160000125420'
and kijunil like '2025%'
order by kijunil


-- 8620 이월 데이터 확인하기

select 
 *
from ACL_SIGUMGO_SLV
where trxdt like '2026%'
and lst_chg_scr_id like '%8620%'
