select
    sigumgo_org_c,
    sigumgo_hoikye_yr,
    sigumgo_trx_g || LPAD(sigumgo_ip_trx_g, 2, '0') || LPAD(sigumgo_ji_trx_g, 2, '0') as trx_g,
    count(*) as cnt
from
    acl_sigumgo_slv
where 1=1
group by sigumgo_org_c,sigumgo_hoikye_yr,sigumgo_trx_g, sigumgo_ip_trx_g, sigumgo_ji_trx_g
order by sigumgo_org_c,sigumgo_hoikye_yr,sigumgo_trx_g, sigumgo_ip_trx_g, sigumgo_ji_trx_g


-----------------------------
select
    sigumgo_org_c,
    sigumgo_trx_g || LPAD(sigumgo_ip_trx_g, 2, '0') || LPAD(sigumgo_ji_trx_g, 2, '0') as trx_g,
    count(*) as cnt
from
    acl_sigumgo_slv
where 1=1
group by sigumgo_org_c,sigumgo_trx_g, sigumgo_ip_trx_g, sigumgo_ji_trx_g
order by sigumgo_org_c,sigumgo_trx_g, sigumgo_ip_trx_g, sigumgo_ji_trx_g


---------------------------------------------------------
select
    *
from
    acl_sigumgo_slv