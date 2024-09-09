select * from rpt_sunap_jibgye
where geumgo_code = 110
and sunapil between '20240801' and '20240831'
and sunapil <> keoraeil


select *  from rpt_sunap_jibgye
where geumgo_code = 110
and hoigye_year = 2024
and sunapil in (
    select sunap_dt from rpt_txi_ddac_tab
    where sigumgo_org_c = 110
    and sigumgo_hoikye_yr = 2024
)
order by sunapil desc