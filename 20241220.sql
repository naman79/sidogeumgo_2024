select
    *
from
    rpt_sunap_jibgye
where drokja_id = 'BGS'||'20241219'||'G07'

;



select count(*) as cnt from rpt_sunap_jibgye
where geumgo_code = 28
and sunapil like '2024%'


select * from rpt_txi_ddac_tab
where sigumgo_org_c = 28
and sunap_dt like '2024%'
;



SELECT
    SIGUMGO_ORG_C,
    ICH_SIGUMGO_GUN_GU_C,
    ICH_SIGUMGO_HOIKYE_C,
    SIGUMGO_AC_B,
    SIGUMGO_HOIKYE_YR,
    SUNAP_DT,
    NEW_GU_YR_G,
    SIGUTAX_G,
    TAX_IP_AMT,
    GWAON_AMT,
    TAX_IP_CRT_AMT,
    JIBANGSE_AMT,
    JIBANGSE_GWAON_AMT,
    JIBANGSE_CRT_AMT,
    SEWOI_AMT,
    SEWOI_GWAON_AMT,
    SEWOI_CRT_AMT,
    GYOYUKSE_AMT,
    GYOYUKSE_GWAON_AMT,
    GYOYUKSE_CRT_AMT,
    NONGTEUKSE_AMT,
    NONGTEUKSE_GWAON_AMT,
    NONGTEUKSE_CRT_AMT,
    DR_DTTM as D,
    DROKJA_ID,
    UPD_DTTM ,
    MODR_ID,
    DR_SNO
FROM RPT_TXI_DDAC_TAB
where sigumgo_org_c = 28
  and sunap_dt like '2024%'
;

select
    fil_100_ctnt5,
    gjdt,
    trxdt,
    gisdt
from
    acl_sigumgo_slv
where
    gjdt like '2023%'
and
    trxdt like '2024%'
