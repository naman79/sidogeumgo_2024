select 
 lpad(sigumgo_trx_g, 2, '0') || lpad(sigumgo_ip_trx_g, 2, '0') || lpad(sigumgo_ji_trx_g, 2, '0') as kind_cd
from acl_sigumgo_slv
where fil_100_ctnt5 = '02823701100000025'
group by  lpad(sigumgo_trx_g, 2, '0') || lpad(sigumgo_ip_trx_g, 2, '0') || lpad(sigumgo_ji_trx_g, 2, '0')




select 
 *
from acl_sigumgo_slv
where fil_100_ctnt5 = '02823701100000025'
and  lpad(sigumgo_trx_g, 2, '0') || lpad(sigumgo_ip_trx_g, 2, '0') || lpad(sigumgo_ji_trx_g, 2, '0') in ('670007', '121500')


select * from rpt_txio_ddac_tab
where sgg_acno = '02823701100000025'
and (
  mmda_hji_amt > 0
or
  mmda_mk_ji_amt > 0
)

