select * from rpt_sunap_jibgye where seipgyejwa in (
select fil_100_ctnt2 from acl_sigumgo_mas where sigumgo_ac_nm like '고향사랑기금' and mng_no =1
)