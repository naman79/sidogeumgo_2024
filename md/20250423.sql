select * from rpt_sunap_jibgye
where 1=1
and bank_gubun in (7,30)
and SUNAPIL  between '20240101' and '20250422'


-- 결산이자 계산후
select gyulsan_il as gs, sum(ija) as amt 
from rpt_gonggeum_gyulsan_tmp
where 1=1
and geumgo_code = 28
group by gyulsan_il
order by gyulsan_il

-- 코어 결산이자 금액
select
 gjdt, sum(tramt) as sum_tramt 
from acl_sigyul_slv
where 1=1
and to_number(substr(eft_acno, 4, 9)) in (
    select link_acser from acl_sigumgo_mas
    where sigumgo_org_c = 28
)
group by gjdt
order by gjdt

    select * from rpt_unyong_gyejwa
    where 1=1
    and unyong_gyejwa = '20059715320'
    and gongggem_gyejwa = ''


select * from rpt_unyong_gyejwa
where 1=1
and unyong_gyejwa = '207014401681'

select * from rpt_unyong_gyejwa
where 1=1
and unyong_gyejwa = '207014402615'

select * from rpt_unyong_gyejwa
where 1=1
and unyong_gyejwa = '200934034238'


select * from rpt_gonggeum_gyulsan_tmp
WHERE 1=1 
and geumgo_code = 28
AND gyulsan_il = '20240101'
and yudong_acno = '160000109335'

select * from acl_sigyul_slv
where 1=1
and eft_acno = '160000109335'
and gjdt = '20240101'


select * from rpt_gonggeum_gyulsan_tmp
WHERE 1=1 
and geumgo_code = 28
AND gyulsan_il = '20240101'
and yudong_acno = '160000106613'

select * from acl_sigyul_slv
where 1=1
and eft_acno = '160000106613'
and gjdt = '20240101'


select * from acl_sigumgo_mas
where 1=1
and link_acser = '106613'
and mng_no = 1
and sigumgo_hoikye_yr in (2022, 2023)

-- 02818501210000222
select * from acl_sigumgo_slv
where 1=1
and sigumgo_org_c = 28
and fil_100_ctnt5 = '02818501210000222'
and gisdt between '20230701' and '20231231'


select * from rpt_gonggeum_jan
where gonggeum_gyejwa = '02818501210000222'
and keoraeil between '20230701' and '20231231'
