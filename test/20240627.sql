select * from 
ACL_SIGUMGO_SLV
where 1=1
and SIGUMGO_ORG_C = 110
and
 (
      TRXDT BETWEEN '20240618' and '20240618'
    or
      lst_cdt BETWEEN '20240618' and '20240618'
    or
      upd_dttm BETWEEN '20240618'||'000000' and '20240618'||'235959'
    )




    select * from 
ACL_SIGUMGO_SLV
where 1=1
and SIGUMGO_ORG_C = 110
and FIL_100_CTNT5 = '11000080900001424'
and
 (
      TRXDT BETWEEN '20240618' and '20240618'
    or
      lst_cdt BETWEEN '20240618' and '20240618'
    or
      upd_dttm BETWEEN '20240618'||'000000' and '20240618'||'235959'
    )

    select * from 
ACL_SIGUMGO_SLV
where 1=1
and SIGUMGO_ORG_C = 110
and FIL_100_CTNT5 = '11000080900001424'
and TRXDT BETWEEN '20240618' and '20240618'


