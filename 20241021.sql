-- e호조에서 거래구분 60의 실재적인 활용분석

select
 count(*) as cnt
from acl_sigumgo_slv
where 1=1
and sigumgo_org_c = 28
-- and SIGUMGO_HOIKYE_YR = 2024
and SIGUMGO_TRX_G = 60
and trxdt BETWEEN '20240101' and '20240230'
order by sigumgo_org_c, ICH_SIGUMGO_GUN_GU_C, SIGUMGO_HOIKYE_YR, trxdt

select
 count(*) as cnt
from acl_sigumgo_slv
where 1=1
-- and sigumgo_org_c = 28
-- and SIGUMGO_HOIKYE_YR = 2024
and SIGUMGO_TRX_G = 60
and trxdt BETWEEN '20240101' and '20240230'
order by sigumgo_org_c, ICH_SIGUMGO_GUN_GU_C, SIGUMGO_HOIKYE_YR, trxdt

----------------------------------------------------------

select
SIGUMGO_ORG_C,
ICH_SIGUMGO_GUN_GU_C,
SIGUMGO_TRX_G,
SIGUMGO_HOIKYE_YR,
trxdt,
FIL_100_CTNT5, 
CMMT_CTNT,
DECODE(CRT_CAN_G,1,-1,2,-1,33,-1,1) * tramt as tramt
from acl_sigumgo_slv
where 1=1
-- and sigumgo_org_c = 28
-- and SIGUMGO_HOIKYE_YR = 2024
and SIGUMGO_TRX_G = 60
and trxdt BETWEEN '20240101' and '20240230'
order by sigumgo_org_c, SIGUMGO_HOIKYE_YR, ICH_SIGUMGO_GUN_GU_C, trxdt


----------------------------------------------------------------------

select * from ACL_SIGUMGO_MAS
where 1=1
and sigumgo_org_c = 28
and ICH_SIGUMGO_GUN_GU_C = 170
and FIL_100_CTNT5 in (
    '02817001100000024',
    '02817001210000224'
)

select * from rpt_unyong_gyejwa
where 1=1
and GONGGEUM_GYEJWA = '02817001210000224'