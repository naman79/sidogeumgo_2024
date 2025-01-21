SELECT GEUMGO_CODE, GUBUN_CODE FROM RPT_HOIGYE_IWOL
GROUP BY GEUMGO_CODE, GUBUN_CODE
ORDER BY  GEUMGO_CODE, GUBUN_CODE

SELECT * FROM RPT_HOIGYE_IWOL
where gubun_code = 4
and amt1 > 0
ORDER BY  GEUMGO_CODE, GUBUN_CODE, kijunil

-- 130-000-80-90-00001-99
select * from rpt_gonggeum_jan
where gonggeum_gyejwa = '13000080900000699'
and keoraeil like '2025%'


select * from rpt_unyong_jan
where gonggeum_gyejwa = '13000080900000699'
and kijunil like '2025%'

select * from acl_sigumgo_slv
where 1=1
and sigumgo_org_c = 28
and gjdt between '20240101' and '2050109'
and rownum = 1

select * from acl_sigumgo_slv
where 1=1
and fil_100_ctnt5 in (
    select sigumgo_acno from rpt_ac_by_hoikye_mapp
where 1=1
and sigumgo_hoikye_yr = 2024
and (
    (sigumgo_c = 42 and sigumgo_hoikye_c = 2)
    or
    (sigumgo_c = 150 and sigumgo_hoikye_c = 4)
        or
    (sigumgo_c = 110 and sigumgo_hoikye_c = 4)
        or
    (sigumgo_c = 43 and sigumgo_hoikye_c = 7)
            or
    (sigumgo_c = 439 and sigumgo_hoikye_c = 4)
                or
    (sigumgo_c = 440 and sigumgo_hoikye_c = 7)
    )
    )
and gjdt between '20240101' and '2050109'

select sigumgo_acno from rpt_ac_by_hoikye_mapp
where 1=1
and sigumgo_hoikye_yr = 2024
and (
    (sigumgo_c = 42 and sigumgo_hoikye_c = 2)
    or
    (sigumgo_c = 150 and sigumgo_hoikye_c = 4)
        or
    (sigumgo_c = 110 and sigumgo_hoikye_c = 4)
        or
    (sigumgo_c = 43 and sigumgo_hoikye_c = 7)
            or
    (sigumgo_c = 439 and sigumgo_hoikye_c = 4)
                or
    (sigumgo_c = 440 and sigumgo_hoikye_c = 7)
    )

select * from rpt_sunap_jibgye
where geumgo_code <> 28
and sunapil between '20240101' and '20250109'

select * from rpt_hoigye_iwol
where geumgo_code <> 28
and hoigye_year = 2023
