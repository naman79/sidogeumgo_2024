select * from ACL_SIGUMGO_MAS
where 1=1
and sigumgo_org_c = 130
and fil_100_ctnt5 = 13000080900000199
and mng_no = 1


select * from rpt_gonggeum_jan
where GONGGEUM_GYEJWA = '13000080900000199'

select * from acl_sigumgo_slv
where fil_100_ctnt5 = '13000080900000199'


select * from acl_sigumgo_slv
where fil_100_ctnt5 = '13000080900000199'
and trxdt like '2025%'



select * from acl_sigumgo_slv
where fil_100_ctnt5 = '13000080900000199'
order by trxdt desc


select
trxdt,
CASE
                                      WHEN IPJI_G = 1 THEN DECODE(CRT_CAN_G,1,-1,2,-1,33,-1,1) * TRAMT
                                      ELSE 0
                                   END AS IPGEUM_AMT
                                ,CASE
                                      WHEN IPJI_G = 2 THEN DECODE(CRT_CAN_G,1,-1,2,-1,33,-1,1) * TRAMT
                                      ELSE 0
                                   END AS JIGEUB_AMT ,
                                   linkac_jan                                  
from acl_sigumgo_slv
where fil_100_ctnt5 = '13000080900000199' 
order by trxdt, trxno 


select trxdt, linkac_jan from acl_sigumgo_slv
where fil_100_ctnt5 = '13000080900000199'
and (trxdt, trxno) in (
select trxdt, max(trxno) as trxno,  from acl_sigumgo_slv
where fil_100_ctnt5 = '13000080900000199'
group by trxdt)
order by trxdt

select trxdt, max(trxno) as trxno,  from acl_sigumgo_slv
where fil_100_ctnt5 = '13000080900000199'
group by trxdt





select trxdt, linkac_jan from acl_sigumgo_slv
where fil_100_ctnt5 = '13000080900000199'
and (trxdt, trxno) in (
select trxdt, max(trxno) as trxno  from acl_sigumgo_slv
where fil_100_ctnt5 = '13000080900000199'
group by trxdt)
and (trxdt, linkac_jan) in (
    select keoraeil, janaek from rpt_gonggeum_jan
    where gonggeum_gyejwa = '13000080900000199'
)

order by trxdt


select keoraeil, janaek, ipamt, jiamt from rpt_gonggeum_jan
where GONGGEUM_GYEJWA = '13000080900000199'
and (ipamt <> 0 or jiamt <> 0)
order by keoraeil




select 
trxdt,
sum(ipgeum_amt) as ipgeum_amt,
sum(jigeub_amt) as jigeub_amt
from 
(
select
trxdt,
SUM(CASE
                                      WHEN IPJI_G = 1 THEN DECODE(CRT_CAN_G,1,-1,2,-1,33,-1,1) * TRAMT
                                      ELSE 0
                                   END) AS IPGEUM_AMT
                                ,SUM(CASE
                                      WHEN IPJI_G = 2 THEN DECODE(CRT_CAN_G,1,-1,2,-1,33,-1,1) * TRAMT
                                      ELSE 0
                                   END) AS JIGEUB_AMT                                
from acl_sigumgo_slv
where fil_100_ctnt5 = '13000080900000199' 
group by trxdt, IPJI_G, CRT_CAN_G, TRAMT
)
group by trxdt
order by trxdt


select trxdt, linkac_jan from acl_sigumgo_slv
where fil_100_ctnt5 = '13000080900000199'
and (trxdt, trxno) in (
select trxdt, max(trxno) as trxno from acl_sigumgo_slv
where fil_100_ctnt5 = '13000080900000199'
group by trxdt
)
order by trxdt



select * from acl_sigumgo_slv
where fil_100_ctnt5 = '13000080900000199'
and trxdt = '20250210'
order by trxno

select * from acl_sigumgo_slv
where fil_100_ctnt5 = '13000080900000199'
and trxdt = '20250117'
order by trxno


select * from rpt_unyong_gyejwa
where unyong_gyejwa = '207020195842'


select * from ACL_SIGUMGO_MAS
where 1=1


select * from rpt_unyong_gyejwa_his


SELECT *
FROM all_tab_columns
where table_name = 'RPT_UNYONG_GYEJWA_HIS'

SELECT *
FROM all_tab_columns
where table_name like 'RPT_UNYONG_GYEJWA_HIS%'

select * from all_cons_columns 
where constraint_name = 'RPT_UNYONG_GYEJWA_HIS_PK'



-- 02800075690000099

select * from rpt_unyong_gyejwa
where gonggeum_gyejwa = '02800075690000099'

select * from rpt_unyong_jan
where unyong_gyejwa = '207020195842'