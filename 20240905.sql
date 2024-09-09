select * from acl_sigumgo_slv
where 1=1
and fil_100_ctnt5 = '02800075690000123'

select * from acl_sigumgo_mas
where 1=1
and fil_100_ctnt2 = '02800075690000123'
and mng_no = 1


select fil_100_ctnt5, sigumgo_trx_g from acl_sigumgo_slv
where 1=1
and fil_100_ctnt5 like '0280007569%'
and fil_100_ctnt5 not like '%99'
and sigumgo_trx_g in (10, 60, 13, 63)
order by fil_100_ctnt5

select * from rpt_dangseipjojeong
where 1=1
and jibgye_code = 750009