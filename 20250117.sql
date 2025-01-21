select * from rpt_sunap_jibgye
where 1=1
and geumgo_code = 28
and sunapil like '2025%'
and rownum = 1

select * from acl_sigumgo_slv
where 1=1
and sigumgo_org_c = 28
and trxdt = '20241231'

