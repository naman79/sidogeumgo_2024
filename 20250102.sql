WITH BIZDT AS (
    SELECT
        DW_BAS_DDT AS TDT,
        NEXT_BIZ_DT AS NDT
    FROM MAP_JOB_DATE
    WHERE DW_BAS_DDT = (SELECT TO_CHAR(SYSDATE, 'YYYYMMDD') FROM DUAL)
),
     MERGED_BIZDT AS (
         SELECT TDT AS DT FROM BIZDT
         UNION ALL
         SELECT NDT AS DT FROM BIZDT
     )
SELECT GJDT AS DT, '1.서구청' AS GUBUN, SUM(SUNP_AMT) AS AMT
FROM ACL_SUNAPMSG_SLV
WHERE GJDT IN (SELECT DT FROM MERGED_BIZDT)
  AND UPMU_G IN (1, 2, 4)
  AND RPT_TOT_C != '104901'
GROUP BY GJDT
UNION ALL
SELECT SIGUMGO_ICHE_KJ_DT AS DT, '2.7331' AS GUBUN, SUM(SIGUMGO_IP_AMT) AS AMT
FROM ACL_INCHICHE_CC
WHERE SIGUMGO_ICHE_KJ_DT IN (SELECT DT FROM MERGED_BIZDT)
  AND SIGUMGO_IP_REF_NO = '55291000670205'
  AND IPJI_G = 1
GROUP BY SIGUMGO_ICHE_KJ_DT
ORDER BY DT, GUBUN, AMT
;

select * from acl_sygul_slv
where gjdt like '2025%'

select
    SGG_ACNO,
BAS_DT,
PROC_DT,
case when length(GISDT) < 8 then bas_dt else gisdt end as GISDT,
SIGUMGO_ORG_C,
ICH_SIGUMGO_GUN_GU_C,
ICH_SIGUMGO_HOIKYE_C,
SIGUMGO_AC_B,
SIGUMGO_HOIKYE_YR,
NEW_GU_YR_G,
SIGUTAX_G,
TAX_IP_SUIB_AMT,
DEP_AMT,
TAX_IP_CRT_AMT,
TAX_IP_GWAON_AMT,
TAXO_FUND_BAEJUNG_AMT,
TAXO_JIBUL_AMT,
MR_FUND_AMT,
JEONBU_AMT,
TAXO_JI_AMT,
TAX_BAEJUNG_IP_AMT,
HNDO_BAEJUNG_AMT,
HNDO_USE_AMT,
REMDR_HNDO_AMT,
TAX_SUNP_IP_AMT,
IWOL_SUNP_IP_AMT,
OBANK_SUNP_IP_AMT,
TBANK_SUNP_IP_AMT,
DEP_HJI_AMT,
GA_IWOL_IP_AMT,
PMNY_JAN_MVI_AMT,
FUND_ADJ_IP_AMT,
BIZPLC_GAM_BAEJUNG_IP_AMT,
JICULWO_GAM_BAEJUNG_IP_AMT,
TAXO_RTRN_AMT,
TAX_IP_CRT_IP_AMT,
TAX_IP_CRT_JI_AMT,
GWAON_PROC_IP_AMT,
MR_FUND_IP_AMT,
HNDO_BAEJUNG_IP_AMT,
FUND_GETBK_IP_AMT,
JEONBU_AMT_IP_AMT,
HNDO_GETBK_IP_AMT,
FUND_IWOL_AMT,
BIZPLC_BAEJUNG_JI_AMT,
JICULWO_BAEJUNG_JI_AMT,
DEP_MK_JI_AMT,
GA_IWOL_JI_AMT,
PMNY_JAN_MVO_AMT,
FUND_ADJ_JI_AMT,
GWAON_PROC_JI_AMT,
TAXO_FUND_BAEJUNG_JI_AMT,
TAXO_HNDO_BAEJUNG_JI_AMT,
TAXO_FUND_GETBK_JI_AMT,
TAXO_HNDO_JICHUL_JI_AMT,
TAXO_HNDO_GETBK_JI_AMT,
MR_FUND_JI_AMT,
HNDO_BAEJUNG_JI_AMT,
FUND_GETBK_JI_AMT,
JEONBU_AMT_JI_AMT,
HNDO_GETBK_JI_AMT,
GAM_BAEJUNG_JI_AMT,
SUIP_CHULNAP_BAEJUNG_AMT,
FUND_UNYONG_INT_AMT,
PMNY_DEP_INT_AMT,
BTDEP_INT_AMT,
KWA_CRRC_IP_AMT,
KWA_CRRC_JI_AMT,
JICULWO_BAEJUNG_IP_AMT,
HNDO_USE_JI_AMT,
HNDO_USE_IP_AMT,
BON_HNDO_USE_JI_AMT,
BON_HNDO_USE_IP_AMT,
BONWOI_HNDO_USE_JI_AMT,
BONWOI_HNDO_USE_IP_AMT,
BON_HNDO_BAEJUNG_AMT,
BON_HNDO_BAEJUNG_JI_AMT,
BON_HNDO_BAEJUNG_IP_AMT,
BONWOI_HNDO_BAEJUNG_AMT,
BONWOI_HNDO_BAEJUNG_JI_AMT,
BONWOI_HNDO_BAEJUNG_IP_AMT,
DR_DTTM,
DROKJA_ID,
UPD_DTTM,
MODR_ID,
DR_SNO
from rpt_txio_ddac_tab
where sigumgo_org_c = 28
and ich_sigumgo_hoikye_c = 22
and SIGUMGO_AC_B IN('10','20')

order by UPD_DTTM desc

select
    count(*) as cnt
from rpt_txio_ddac_tab
where sigumgo_org_c = 28
and ich_sigumgo_hoikye_c = 22
and SIGUMGO_AC_B IN('10','20')
and gisdt is null


select count(*) as cnt from acl_sigumgo_slv
where sigumgo_org_c = 28
and ich_sigumgo_hoikye_c = 22


select count(*) as cnt from rpt_txio_ddac_tab
where sigumgo_org_c = 28
and ich_sigumgo_hoikye_c = 22


select
    *
from rpt_txio_ddac_tab
where sigumgo_org_c = 28
and ich_sigumgo_hoikye_c = 22
and SIGUMGO_AC_B IN('10','20')
and length(trim(gisdt)) = 0

select
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
DR_DTTM,
DROKJA_ID,
UPD_DTTM,
MODR_ID,
DR_SNO
from rpt_txi_ddac_tab
where sigumgo_org_c = 28
and sunap_dt like '2024%'
and ich_sigumgo_hoikye_c in (22, 62)


SELECT TO_NUMBER(GUNGU_CD) GUNGU_CODE, 1 AS DATA_ROW,
                0 AMT1 , 0 AMT2 , 0 AMT3 ,
                SUM(CASE WHEN SUNP_DT = '20241231' THEN NVL(NAPBU_SIDO_TAX_AMT,0) ELSE 0 END) AMT4 , 0 AMT5 , 0 AMT6 ,
                0 AMT7 , 0 AMT8 , 0 AMT9 ,
                0 AMT10, 0 AMT11, 0 AMT12,
                0 AMT13, 0 AMT14, 0 AMT15,
                SUM(NVL(NAPBU_SIDO_TAX_AMT,0)) AMT16, 0 AMT17, 0 AMT18,
                0 AMT19, 0 AMT20, 0 AMT21,
                0 AMT22, 0 AMT23, 0 AMT24,
                0 AMT25,
                SUM(CASE WHEN (SUNP_DT BETWEEN '202412' || '01' AND '20241231') THEN NVL(NAPBU_SIDO_TAX_AMT,0) ELSE 0 END) AMT26,
                0 AMT27,
                0 AMT28
              FROM
              (
               SELECT SUNP_DT,
                  CASE  WHEN NEW_GU_YR_G = 1 THEN 1 WHEN NEW_GU_YR_G = 2 THEN 9  ELSE  99 END YEAR_GUBUN,
                  HOIKYE_CD, SMOK_CD,
                  CASE WHEN CVT_GUCHUNG_CD = '357' THEN '710'
                                           WHEN CVT_GUCHUNG_CD = '358' THEN '720'
                            ELSE CVT_GUCHUNG_CD END AS GUNGU_CD,
                NAPBU_TCNT, NAPBU_NTAX_AMT, NAPBU_SIDO_TAX_AMT, NAPBU_SIGNGU_TAX_AMT
               FROM NIO_STAX_MASTR_TAB
               WHERE SUNP_DT BETWEEN '2024' || '0101' AND '20241231' AND FORM_G <> '1' AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND SIDO_CD <> '628' AND (SUBSTR(SMOK_CD,1,3)  <> '299' OR   SUBSTR(SMOK_CD,4,3) <> '099')
                 AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358') AND HOIKYE_CD = '51' AND SMOK_CD = '281020'
               UNION
                SELECT A.SUNP_DT SUNP_DT,
                      CASE  WHEN NEW_GU_YR_G = 1 THEN 1  WHEN NEW_GU_YR_G = 2 THEN 9  ELSE  99 END YEAR_GUBUN,
                      A.HOIKYE_CD HOIKYE_CD, A.SMOK_CD SMOK_CD,
                      CASE WHEN CVT_GUCHUNG_CD = '357' THEN '710'
                                          WHEN CVT_GUCHUNG_CD = '358' THEN '720'
                            ELSE CVT_GUCHUNG_CD  END AS GUNGU_CD,
                      A.NAPBU_TCNT NAPBU_TCNT, A.NAPBU_NTAX_AMT NAPBU_NTAX_AMT, A.NAPBU_SIDO_TAX_AMT NAPBU_SIDO_TAX_AMT, A.NAPBU_SIGNGU_TAX_AMT NAPBU_SIGNGU_TAX_AMT
                  FROM NIO_STAX_MASTR_TAB A, NIO_DEPT_INF_TAB B
                  WHERE A.SUNP_DT BETWEEN '2024' || '0101' AND '20241231'  AND FORM_G <> '1' AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND SIDO_CD = '628' AND (SUBSTR(A.SMOK_CD,1,3) <> '299' OR  SUBSTR(A.SMOK_CD,4,3) <> '099')
                  AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358') AND A.HOIKYE_CD = '51' AND A.SMOK_CD = '281020'
                  AND A.SIDO_CD = B.GUCHUNG_CD(+) AND A.DEPT_CD = B.DEPT_CD(+) AND A.HOIKYE_CD = B.HOIKYE_CD(+) AND A.SMOK_CD = B.SMOK_CD(+)
                UNION
                SELECT
                      SUNP_DT,
                      CASE  WHEN NEW_GU_YR_G = 1 THEN 1 WHEN NEW_GU_YR_G = 2 THEN 9  ELSE  99 END YEAR_GUBUN,
                      HOIKYE_CD,
                      SMOK_CD,
                      CASE WHEN CVT_GUCHUNG_CD = '357' THEN '710'
                           WHEN CVT_GUCHUNG_CD = '358' THEN '720'
                           ELSE CVT_GUCHUNG_CD END  AS GUNGU_CD,
                      NAPBU_TCNT,
                      NVL(SUM(국세), 0) AS NAPBU_NTAX_AMT, NVL(SUM(시도세),0) AS NAPBU_SIDO_TAX_AMT, NVL(SUM(시군세),0) AS NAPBU_SIGNGU_TAX_AMT
                FROM
                  (
                     SELECT
                        BLK_NO, PROC_SEQ, SUNP_DT, NEW_GU_YR_G,
                               HOIKYE_CD, SMOK_CD,
                               CVT_GUCHUNG_CD,
                               NAPBU_TCNT,
                      CASE WHEN FILLER2 = '1' THEN NTAX_AMT + SIDO_TAX_AMT + SIGNGU_TAX_AMT - NAPGILT_AMT END AS 국세,
                      CASE WHEN FILLER2 = '2' THEN NTAX_AMT + SIDO_TAX_AMT + SIGNGU_TAX_AMT - NAPGILT_AMT END AS 시도세,
                      CASE WHEN FILLER2 = '3' THEN NTAX_AMT + SIDO_TAX_AMT + SIGNGU_TAX_AMT - NAPGILT_AMT END AS 시군세
                    FROM NIO_STAX_MASTR_TAB
                    WHERE SUNP_DT BETWEEN '2024' || '0101' AND '20241231'  AND FILLER2 > '0' AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND FORM_G <> '1'
                      AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358') AND HOIKYE_CD = '51' AND SMOK_CD = '281020'
                  )
                 GROUP BY SUNP_DT, NEW_GU_YR_G, HOIKYE_CD, SMOK_CD,CVT_GUCHUNG_CD, NAPBU_TCNT
                UNION
                SELECT
                   SUNP_DT,
                    CASE  WHEN NEW_GU_YR_G = 1 THEN 1  WHEN NEW_GU_YR_G = 2 THEN 9
                    ELSE  99 END YEAR_GUBUN,
                    HOIKYE_CD,
                    SMOK_CD,
                    CASE WHEN CVT_GUCHUNG_CD = '357' THEN '710'
                         WHEN CVT_GUCHUNG_CD = '358' THEN '720'
                    ELSE CVT_GUCHUNG_CD END  AS GUNGU_CD,
                    NAPBU_TCNT,
                    NVL(SUM(NAPBU_NTAX_AMT), 0) AS NAPBU_NTAX_AMT, NVL(SUM(NAPBU_SIDO_TAX_AMT), 0) AS NAPBU_SIDO_TAX_AMT, NVL(SUM(NAPBU_SIGNGU_TAX_AMT), 0) AS NAPBU_SIGNGU_TAX_AMT
                FROM
                  (
                    SELECT SUNP_DT, NEW_GU_YR_G, HOIKYE_CD, SMOK_CD,
                      CVT_GUCHUNG_CD, NAPBU_TCNT, NAPBU_NTAX_AMT, NAPBU_SIDO_TAX_AMT, NAPBU_SIGNGU_TAX_AMT
                    FROM  NIO_STAX_MASTR_TAB
                    WHERE SUNP_DT BETWEEN '2024' || '0101' AND '20241231'
                      AND SUBSTR(SMOK_CD,1,3) = '299' AND SUBSTR(SMOK_CD,4,3)  = '099'
                      AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND FORM_G <> '1'
                      AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358')
                      AND HOIKYE_CD = '51' AND SMOK_CD = '281020'
                  )
                GROUP BY SUNP_DT, NEW_GU_YR_G, HOIKYE_CD, SMOK_CD,CVT_GUCHUNG_CD,NAPBU_TCNT
               )
              WHERE 1 = 1
              AND (
                    (
                        '1' = (CASE WHEN LENGTH(TRIM(NVL('', ''))) IS NULL THEN '1' ELSE '0' END)
                    )
                OR
                    (
                        '1' = (CASE WHEN GUNGU_CD = '' THEN '1' ELSE '0' END)
                    )
                )
              GROUP BY GUNGU_CD

------------------------------------------------------

SELECT LPAD(REF_D_C,4,'0') GUNGU_CODE, REF_D_NM GUNGU_NM, NVL(DATA_ROW,1) AS DATA_ROW,
       SUM(NVL(AMT1 , 0)) AMT1 , SUM(NVL(AMT2 , 0)) AMT2 , SUM(NVL(AMT3 , 0)) AMT3 ,
       SUM(NVL(AMT4 , 0)) AMT4 , SUM(NVL(AMT5 , 0)) AMT5 , SUM(NVL(AMT6 , 0)) AMT6 ,
       SUM(NVL(AMT7 , 0)) AMT7 , SUM(NVL(AMT8 , 0)) AMT8 , SUM(NVL(AMT9 , 0)) AMT9 ,
       SUM(NVL(AMT10, 0)) AMT10, SUM(NVL(AMT11, 0)) AMT11, SUM(NVL(AMT12, 0)) AMT12,
       SUM(NVL(AMT13, 0)) AMT13, SUM(NVL(AMT14, 0)) AMT14, SUM(NVL(AMT15, 0)) AMT15,
       SUM(NVL(AMT16, 0)) AMT16, SUM(NVL(AMT17, 0)) AMT17, SUM(NVL(AMT18, 0)) AMT18,
       SUM(NVL(AMT19, 0)) AMT19, SUM(NVL(AMT20, 0)) AMT20, SUM(NVL(AMT21, 0)) AMT21,
       SUM(NVL(AMT22, 0)) AMT22, SUM(NVL(AMT23, 0)) AMT23, SUM(NVL(AMT24, 0)) AMT24,
       SUM(NVL(AMT25, 0)) AMT25, SUM(NVL(AMT26, 0)) AMT26, SUM(NVL(AMT27, 0)) AMT27,
       SUM(NVL(AMT28, 0)) AMT28
  FROM  (
       SELECT GUNGU_CODE
               , DATA_ROW
               , AMT1,  AMT2,  AMT3,  AMT4,  AMT5,  AMT6,  AMT7,  AMT8,  AMT9,  AMT10
               , AMT11, AMT12, AMT13, AMT14, AMT15, AMT16, AMT17, AMT18, AMT19, AMT20
               , AMT21, AMT22, AMT23, AMT24, AMT25, AMT26, AMT27, AMT28
       FROM (
         SELECT  CASE WHEN GUNGU_CODE = 0  THEN 7100
                    WHEN GUNGU_CODE = 7000 THEN 7100
                    WHEN GUNGU_CODE < 7000 THEN GUNGU_CODE + 7000
                    WHEN GUNGU_CODE > 7000 THEN GUNGU_CODE
               END  GUNGU_CODE
               , DATA_ROW
               , AMT1,  AMT2,  AMT3,  AMT4,  AMT5,  AMT6,  AMT7,  AMT8,  AMT9,  AMT10
               , AMT11, AMT12, AMT13, AMT14, AMT15, AMT16, AMT17, AMT18, AMT19, AMT20
               , AMT21, AMT22, AMT23, AMT24, AMT25, AMT26, AMT27, AMT28
         FROM
           (
             SELECT
               ICH_SIGUMGO_GUN_GU_C GUNGU_CODE,
               1 DATA_ROW,
               SUM(CASE WHEN (SUNAP_DT = '20241231')  THEN NVL(JIBANGSE_AMT,0) ELSE 0 END ) AMT1,
                    SUM(CASE WHEN (SUNAP_DT = '20241231' )  THEN NVL(JIBANGSE_GWAON_AMT,0) ELSE 0 END ) AMT2,
                    SUM(CASE WHEN (SUNAP_DT = '20241231' )  THEN NVL(JIBANGSE_CRT_AMT,0) ELSE 0 END ) AMT3,
                    SUM(CASE WHEN (SUNAP_DT = '20241231' )  THEN NVL(SEWOI_AMT,0) ELSE 0 END ) AMT4,
                    SUM(CASE WHEN (SUNAP_DT = '20241231' )  THEN NVL(SEWOI_GWAON_AMT,0) ELSE 0 END ) AMT5,
                    SUM(CASE WHEN (SUNAP_DT = '20241231' )  THEN NVL(SEWOI_CRT_AMT,0) ELSE 0 END ) AMT6,
                    SUM(CASE WHEN (SUNAP_DT = '20241231' )  THEN NVL(GYOYUKSE_AMT,0) ELSE 0 END ) AMT7,
                    SUM(CASE WHEN (SUNAP_DT = '20241231' )  THEN NVL(GYOYUKSE_GWAON_AMT,0) ELSE 0 END ) AMT8,
                    SUM(CASE WHEN (SUNAP_DT = '20241231' )  THEN NVL(GYOYUKSE_CRT_AMT,0) ELSE 0 END ) AMT9,
                    SUM(CASE WHEN (SUNAP_DT = '20241231' )  THEN NVL(NONGTEUKSE_AMT,0) ELSE 0 END ) AMT10,
                    SUM(CASE WHEN (SUNAP_DT = '20241231' )  THEN NVL(NONGTEUKSE_GWAON_AMT,0) ELSE 0 END ) AMT11,
                    SUM(CASE WHEN (SUNAP_DT = '20241231' )  THEN NVL(NONGTEUKSE_CRT_AMT,0) ELSE 0 END ) AMT12,
                    SUM(NVL(JIBANGSE_AMT,0) ) AMT13,
                    SUM(NVL(JIBANGSE_GWAON_AMT,0)) AMT14,
                    SUM(NVL(JIBANGSE_CRT_AMT,0 ) )AMT15,
                    SUM(SEWOI_AMT) AMT16,
                    SUM(SEWOI_GWAON_AMT) AMT17,
                    SUM(SEWOI_CRT_AMT) AMT18,
                    SUM(GYOYUKSE_AMT) AMT19,
                    SUM(GYOYUKSE_GWAON_AMT) AMT20,
                    SUM(GYOYUKSE_CRT_AMT) AMT21,
                    SUM(NONGTEUKSE_AMT) AMT22,
                    SUM(NONGTEUKSE_GWAON_AMT) AMT23,
                    SUM(NONGTEUKSE_CRT_AMT) AMT24,
               SUM(   CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20241231',0,6) || '01' AND '20241231')  THEN NVL(JIBANGSE_AMT,0) ELSE 0 END
                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20241231',0,6) || '01' AND '20241231')  THEN NVL(JIBANGSE_GWAON_AMT,0) *-1 ELSE 0 END
                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20241231',0,6) || '01' AND '20241231')  THEN NVL(JIBANGSE_CRT_AMT,0)  ELSE 0 END
               ) AMT25,
                SUM(  CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20241231',0,6) || '01' AND '20241231')  THEN NVL(SEWOI_AMT,0) ELSE 0 END
                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20241231',0,6) || '01' AND '20241231')  THEN NVL(SEWOI_GWAON_AMT,0) *-1 ELSE 0 END
                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20241231',0,6) || '01' AND '20241231')  THEN NVL(SEWOI_CRT_AMT,0)  ELSE 0 END
                ) AMT26,
                SUM(  CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20241231',0,6) || '01' AND '20241231')  THEN NVL(GYOYUKSE_AMT,0) ELSE 0 END
                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20241231',0,6) || '01' AND '20241231')  THEN NVL(GYOYUKSE_GWAON_AMT,0) *-1 ELSE 0 END
                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20241231',0,6) || '01' AND '20241231')  THEN NVL(GYOYUKSE_CRT_AMT,0)  ELSE 0 END
                ) AMT27,
                SUM(  CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20241231',0,6) || '01' AND '20241231')  THEN NVL(NONGTEUKSE_AMT,0) ELSE 0 END
                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20241231',0,6) || '01' AND '20241231')  THEN NVL(NONGTEUKSE_GWAON_AMT,0) *-1 ELSE 0 END
                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20241231',0,6) || '01' AND '20241231')  THEN NVL(NONGTEUKSE_CRT_AMT,0)  ELSE 0 END
                ) AMT28
             FROM RPT_TXI_DDAC_TAB
             WHERE 1=1
             AND SIGUMGO_ORG_C = '28'
                AND SUNAP_DT BETWEEN '20240101' AND '20241231'
                AND ICH_SIGUMGO_HOIKYE_C IN ('22', 62)
                AND SIGUTAX_G = NVL('', '1')
                AND  (  ( '22' =  22  AND ICH_SIGUMGO_HOIKYE_C IN (22, 62, 209332) ) OR
                        ( '22' =  213000  AND ICH_SIGUMGO_HOIKYE_C IN (213000, 217100) ) OR
                        ( '22' =  99 )  OR
                        ( '22' NOT IN (22,213000,99) AND ICH_SIGUMGO_HOIKYE_C = '22' ) )
                AND  (  ( '22' = 22 AND '' = 0 AND ICH_SIGUMGO_GUN_GU_C  IN (7000, 7040, 7810, 7055, 7830, 7840, 7850, 7100, 0) )
                        OR ( '22' IN (21,22,93) AND DECODE('', '', 9999, '') = 9999 )
                        OR ( '22' = 22 AND DECODE('', '', 9999, '') NOT IN (0,9999) AND ( CASE WHEN ICH_SIGUMGO_GUN_GU_C = 7100 THEN  0
                                WHEN ICH_SIGUMGO_GUN_GU_C > 7100 AND ICH_SIGUMGO_GUN_GU_C < 7800 THEN ICH_SIGUMGO_GUN_GU_C - 7000 ELSE ICH_SIGUMGO_GUN_GU_C END) = DECODE(DECODE('', '', 9999, ''), 9999, ICH_SIGUMGO_GUN_GU_C, '') )
                        OR ('22' IN ( 21,93) AND '' = 7100 AND ICH_SIGUMGO_GUN_GU_C  IN (0, 7000, 100, 7100) )
                        OR ('22' IN ( 21,93) AND '' <> 7100 AND ICH_SIGUMGO_GUN_GU_C IN ('', SUBSTR('',2,3)) )
                        OR ('22' NOT IN (21,22,93) AND ICH_SIGUMGO_GUN_GU_C  = DECODE(DECODE('', '', 9999, ''), 9999, ICH_SIGUMGO_GUN_GU_C, '') ) )
                AND (
                  (
                            '0' = 1
                        AND
                            SUNAP_DT >= SUBSTR('20241231',1,4)||'0101'
                        AND
                            NEW_GU_YR_G = 1
                    )
                OR  (
                            '0' = 9
                        AND
                            SUBSTR('20241231',5,2) < 3
                        AND
                            SUNAP_DT >= (SUBSTR('20241231',1,4) - 1 )||'0301' AND NEW_GU_YR_G = 9
                    )
                OR  (
                            '0' = 9
                        AND
                            SUBSTR('20241231',5,2) >= 3
                        AND
                            SUNAP_DT >= (SUBSTR('20241231',1,4))||'0301' AND  NEW_GU_YR_G = 9
                    )
                OR  (
                            '0' = 5
                        AND
                            SUBSTR('20241231',5,2) < 3
                        AND
                            SUNAP_DT >= (SUBSTR('20241231',1,4) - 1 )||'0301' AND NEW_GU_YR_G = 5
                    )
                OR  (
                            '0' = 5
                        AND
                            SUBSTR('20241231',5,2) >= 3
                        AND
                            SUNAP_DT >= (SUBSTR('20241231',1,4))||'0301' AND  NEW_GU_YR_G = 5
                    )
                OR (
                            (
                                    '0' = 8
                                AND
                                    SUBSTR('20241231',5,2) < 3
                                AND
                                    SUNAP_DT BETWEEN  (SUBSTR('20241231',1,4) - 1 )||'0100' AND (SUBSTR('20241231',1,4) - 1 )||'0100'
                                AND
                                    NEW_GU_YR_G = 1
                            )
                        OR
                            (
                                    '0' = 8
                                AND
                                    SUBSTR('20241231',5,2) < 3
                                AND
                                    SUNAP_DT BETWEEN (SUBSTR('20241231',1,4) - 1 )||'0301' AND '20241231'
                                AND
                                    NEW_GU_YR_G <> 1
                            )
                        OR
                            (
                                    '0' = 8
                                AND
                                    SUBSTR('20241231',5,2) >= 3
                                AND
                                    SUNAP_DT BETWEEN SUBSTR('20241231',1,4)||'0301' AND '20241231'
                                AND
                                    NEW_GU_YR_G <> 1
                            )
                     )
                OR (

                        '0' = 0
                    AND
                        SUNAP_DT >= SUBSTR('20241231',1,4)

                    )
                OR (

                        (
                                    '0' = 7
                                AND
                                    SUNAP_DT >= SUBSTR('20241231',1,4)
                                AND
                                    NEW_GU_YR_G = 1
                            )
                        OR
                                (
                                    '0' = 7
                                AND
                                    SUBSTR('20241231',5,2) < 3
                                AND
                                    SUNAP_DT BETWEEN (SUBSTR('20241231',1,4) - 1 )||'0301' AND '20241231'
                                AND
                                    NEW_GU_YR_G <> 1
                            )
                        OR
                            (
                                    '0' = 7
                                AND
                                    SUBSTR('20241231',5,2) >= 3
                                AND
                                    SUNAP_DT BETWEEN SUBSTR('20241231',1,4)||'0301' AND '20241231'
                                AND
                                    NEW_GU_YR_G <> 1
                            )

                    )
                )
             GROUP BY ICH_SIGUMGO_GUN_GU_C
             UNION ALL
              SELECT TO_NUMBER(GUNGU_CD) GUNGU_CODE, 1 AS DATA_ROW,
                0 AMT1 , 0 AMT2 , 0 AMT3 ,
                SUM(CASE WHEN SUNP_DT = '20241231' THEN NVL(NAPBU_SIDO_TAX_AMT,0) ELSE 0 END) AMT4 , 0 AMT5 , 0 AMT6 ,
                0 AMT7 , 0 AMT8 , 0 AMT9 ,
                0 AMT10, 0 AMT11, 0 AMT12,
                0 AMT13, 0 AMT14, 0 AMT15,
                SUM(NVL(NAPBU_SIDO_TAX_AMT,0)) AMT16, 0 AMT17, 0 AMT18,
                0 AMT19, 0 AMT20, 0 AMT21,
                0 AMT22, 0 AMT23, 0 AMT24,
                0 AMT25,
                SUM(CASE WHEN (SUNP_DT BETWEEN '202412' || '01' AND '20241231') THEN NVL(NAPBU_SIDO_TAX_AMT,0) ELSE 0 END) AMT26,
                0 AMT27,
                0 AMT28
              FROM
              (
               SELECT SUNP_DT,
                  CASE  WHEN NEW_GU_YR_G = 1 THEN 1 WHEN NEW_GU_YR_G = 2 THEN 9  ELSE  99 END YEAR_GUBUN,
                  HOIKYE_CD, SMOK_CD,
                  CASE WHEN CVT_GUCHUNG_CD = '357' THEN '710'
                                           WHEN CVT_GUCHUNG_CD = '358' THEN '720'
                            ELSE CVT_GUCHUNG_CD END AS GUNGU_CD,
                NAPBU_TCNT, NAPBU_NTAX_AMT, NAPBU_SIDO_TAX_AMT, NAPBU_SIGNGU_TAX_AMT
               FROM NIO_STAX_MASTR_TAB
               WHERE SUNP_DT BETWEEN '2024' || '0101' AND '20241231' AND FORM_G <> '1' AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND SIDO_CD <> '628' AND (SUBSTR(SMOK_CD,1,3)  <> '299' OR   SUBSTR(SMOK_CD,4,3) <> '099')
                 AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358') AND HOIKYE_CD = '51' AND SMOK_CD = '281020'
               UNION
                SELECT A.SUNP_DT SUNP_DT,
                      CASE  WHEN NEW_GU_YR_G = 1 THEN 1  WHEN NEW_GU_YR_G = 2 THEN 9  ELSE  99 END YEAR_GUBUN,
                      A.HOIKYE_CD HOIKYE_CD, A.SMOK_CD SMOK_CD,
                      CASE WHEN CVT_GUCHUNG_CD = '357' THEN '710'
                                          WHEN CVT_GUCHUNG_CD = '358' THEN '720'
                            ELSE CVT_GUCHUNG_CD  END AS GUNGU_CD,
                      A.NAPBU_TCNT NAPBU_TCNT, A.NAPBU_NTAX_AMT NAPBU_NTAX_AMT, A.NAPBU_SIDO_TAX_AMT NAPBU_SIDO_TAX_AMT, A.NAPBU_SIGNGU_TAX_AMT NAPBU_SIGNGU_TAX_AMT
                  FROM NIO_STAX_MASTR_TAB A, NIO_DEPT_INF_TAB B
                  WHERE A.SUNP_DT BETWEEN '2024' || '0101' AND '20241231'  AND FORM_G <> '1' AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND SIDO_CD = '628' AND (SUBSTR(A.SMOK_CD,1,3) <> '299' OR  SUBSTR(A.SMOK_CD,4,3) <> '099')
                  AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358') AND A.HOIKYE_CD = '51' AND A.SMOK_CD = '281020'
                  AND A.SIDO_CD = B.GUCHUNG_CD(+) AND A.DEPT_CD = B.DEPT_CD(+) AND A.HOIKYE_CD = B.HOIKYE_CD(+) AND A.SMOK_CD = B.SMOK_CD(+)
                UNION
                SELECT
                      SUNP_DT,
                      CASE  WHEN NEW_GU_YR_G = 1 THEN 1 WHEN NEW_GU_YR_G = 2 THEN 9  ELSE  99 END YEAR_GUBUN,
                      HOIKYE_CD,
                      SMOK_CD,
                      CASE WHEN CVT_GUCHUNG_CD = '357' THEN '710'
                           WHEN CVT_GUCHUNG_CD = '358' THEN '720'
                           ELSE CVT_GUCHUNG_CD END  AS GUNGU_CD,
                      NAPBU_TCNT,
                      NVL(SUM(국세), 0) AS NAPBU_NTAX_AMT, NVL(SUM(시도세),0) AS NAPBU_SIDO_TAX_AMT, NVL(SUM(시군세),0) AS NAPBU_SIGNGU_TAX_AMT
                FROM
                  (
                     SELECT
                        BLK_NO, PROC_SEQ, SUNP_DT, NEW_GU_YR_G,
                               HOIKYE_CD, SMOK_CD,
                               CVT_GUCHUNG_CD,
                               NAPBU_TCNT,
                      CASE WHEN FILLER2 = '1' THEN NTAX_AMT + SIDO_TAX_AMT + SIGNGU_TAX_AMT - NAPGILT_AMT END AS 국세,
                      CASE WHEN FILLER2 = '2' THEN NTAX_AMT + SIDO_TAX_AMT + SIGNGU_TAX_AMT - NAPGILT_AMT END AS 시도세,
                      CASE WHEN FILLER2 = '3' THEN NTAX_AMT + SIDO_TAX_AMT + SIGNGU_TAX_AMT - NAPGILT_AMT END AS 시군세
                    FROM NIO_STAX_MASTR_TAB
                    WHERE SUNP_DT BETWEEN '2024' || '0101' AND '20241231'  AND FILLER2 > '0' AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND FORM_G <> '1'
                      AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358') AND HOIKYE_CD = '51' AND SMOK_CD = '281020'
                  )
                 GROUP BY SUNP_DT, NEW_GU_YR_G, HOIKYE_CD, SMOK_CD,CVT_GUCHUNG_CD, NAPBU_TCNT
                UNION
                SELECT
                   SUNP_DT,
                    CASE  WHEN NEW_GU_YR_G = 1 THEN 1  WHEN NEW_GU_YR_G = 2 THEN 9
                    ELSE  99 END YEAR_GUBUN,
                    HOIKYE_CD,
                    SMOK_CD,
                    CASE WHEN CVT_GUCHUNG_CD = '357' THEN '710'
                         WHEN CVT_GUCHUNG_CD = '358' THEN '720'
                    ELSE CVT_GUCHUNG_CD END  AS GUNGU_CD,
                    NAPBU_TCNT,
                    NVL(SUM(NAPBU_NTAX_AMT), 0) AS NAPBU_NTAX_AMT, NVL(SUM(NAPBU_SIDO_TAX_AMT), 0) AS NAPBU_SIDO_TAX_AMT, NVL(SUM(NAPBU_SIGNGU_TAX_AMT), 0) AS NAPBU_SIGNGU_TAX_AMT
                FROM
                  (
                    SELECT SUNP_DT, NEW_GU_YR_G, HOIKYE_CD, SMOK_CD,
                      CVT_GUCHUNG_CD, NAPBU_TCNT, NAPBU_NTAX_AMT, NAPBU_SIDO_TAX_AMT, NAPBU_SIGNGU_TAX_AMT
                    FROM  NIO_STAX_MASTR_TAB
                    WHERE SUNP_DT BETWEEN '2024' || '0101' AND '20241231'
                      AND SUBSTR(SMOK_CD,1,3) = '299' AND SUBSTR(SMOK_CD,4,3)  = '099'
                      AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND FORM_G <> '1'
                      AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358')
                      AND HOIKYE_CD = '51' AND SMOK_CD = '281020'
                  )
                GROUP BY SUNP_DT, NEW_GU_YR_G, HOIKYE_CD, SMOK_CD,CVT_GUCHUNG_CD,NAPBU_TCNT
               )
              WHERE 1 = 1
              AND (
                    (
                        '1' = (CASE WHEN LENGTH(TRIM(NVL('', ''))) IS NULL THEN '1' ELSE '0' END)
                    )
                OR
                    (
                        '1' = (CASE WHEN GUNGU_CD = '' THEN '1' ELSE '0' END)
                    )
                )
              GROUP BY GUNGU_CD
             UNION ALL
             SELECT  9999 ICH_SIGUMGO_GUN_GU_C, 2 DATA_ROW,
               SUM(CASE WHEN  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE BAS_DT END) = '20241231'  THEN  BIZPLC_BAEJUNG_JI_AMT ELSE 0  END)
                 +SUM(CASE WHEN  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE BAS_DT END) = '20241231'  THEN  BIZPLC_GAM_BAEJUNG_IP_AMT ELSE 0  END) AMT1,
               SUM(CASE WHEN  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE BAS_DT END) = '20241231' THEN  TAXO_FUND_BAEJUNG_JI_AMT+TAXO_HNDO_BAEJUNG_JI_AMT+TAXO_FUND_GETBK_JI_AMT
                                                                                                                                      +TAXO_HNDO_JICHUL_JI_AMT+TAXO_HNDO_GETBK_JI_AMT ELSE 0 END) AMT2,
               SUM(CASE WHEN  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE BAS_DT END) = '20241231' THEN  TAXO_RTRN_AMT ELSE 0 END)*-1 AMT3,
               0 AMT4,  0 AMT5,  0 AMT6,  0 AMT7,  0 AMT8,  0 AMT9,  0 AMT10, 0 AMT11, 0 AMT12,
               SUM(CASE WHEN SIGUMGO_AC_B = 10 THEN  BIZPLC_BAEJUNG_JI_AMT ELSE 0 END)
                 +SUM(BIZPLC_GAM_BAEJUNG_IP_AMT) AMT13,
               SUM(TAXO_FUND_BAEJUNG_JI_AMT+TAXO_HNDO_BAEJUNG_JI_AMT+TAXO_FUND_GETBK_JI_AMT
                                                                  +TAXO_HNDO_JICHUL_JI_AMT+TAXO_HNDO_GETBK_JI_AMT) AMT14,
               SUM(TAXO_RTRN_AMT)*-1 AMT15,
               SUM(CASE WHEN '12' < 3 AND '0' = 1 AND '2024' < 2007 THEN  GA_IWOL_JI_AMT
                                    WHEN '12' < 3 AND '0' = 1 AND '2024' >=2007 THEN  GA_IWOL_JI_AMT-GA_IWOL_IP_AMT
                                    WHEN '12' < 3 AND '0' != 1 AND '2024' < 2007  AND (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END)  > '2024' || '0100' THEN GA_IWOL_JI_AMT
                             WHEN '12' < 3 AND '0' != 1 AND '2024' >=2007 AND (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END)  > '2024' || '0100' THEN GA_IWOL_JI_AMT-GA_IWOL_IP_AMT
                      WHEN '12' >= 3 THEN 0
                 END) AMT16,
               0 AMT17,
               SUM(PMNY_JAN_MVO_AMT-PMNY_JAN_MVI_AMT) AMT18,
               0 AMT19, 0 AMT20, 0 AMT21, 0 AMT22, 0 AMT23, 0 AMT24,
               0 AMT25, 0 AMT26, 0 AMT27, 0 AMT28
               FROM  RPT_TXIO_DDAC_TAB A
               WHERE  1=1
               AND A.SIGUMGO_ORG_C  = 28
               AND (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END) BETWEEN SUBSTR('202401',0,4) || '0101' AND '20241231'
               AND A.ICH_SIGUMGO_HOIKYE_C = '22'
               AND (
                    (
                        '1' = (CASE WHEN LENGTH(TRIM(NVL('', ''))) IS NULL THEN '1' ELSE '0' END)
                    )
                OR
                    (
                        '1' = (CASE WHEN ICH_SIGUMGO_GUN_GU_C = '' THEN '1' ELSE '0' END)
                    )
                )
               AND A.SIGUMGO_AC_B IN('10','20')
             UNION ALL
             SELECT  9999 GUNGU_CODE, 2 DATA_ROW,
                 0 AMT1,  0 AMT2,  0 AMT3,  0 AMT4,  0 AMT5,  0 AMT6,  0 AMT7,  0 AMT8,
                 0 AMT9,  0 AMT10, 0 AMT11, 0 AMT12, 0 AMT13, 0 AMT14, 0 AMT15, 0 AMT16,
                 SUM(DEP_MK_JI_AMT-DEP_HJI_AMT) AMT17,
                 0 AMT18, 0 AMT19, 0 AMT20, 0 AMT21, 0 AMT22, 0 AMT23, 0 AMT24,
                 0 AMT25, 0 AMT26, 0 AMT27, 0 AMT28
               FROM  RPT_TXIO_DDAC_TAB A
               WHERE  1=1
               AND A.SIGUMGO_ORG_C = 28
               AND A.ICH_SIGUMGO_HOIKYE_C = '22'
               AND (
                    (
                        '1' = (CASE WHEN LENGTH(TRIM(NVL('', ''))) IS NULL THEN '1' ELSE '0' END)
                    )
                OR
                    (
                        '1' = (CASE WHEN ICH_SIGUMGO_GUN_GU_C = '' THEN '1' ELSE '0' END)
                    )
                )
               AND A.SIGUMGO_AC_B IN('10','20')
             )
            )
          ) AA,
      (SELECT REF_D_C, REF_D_NM FROM RPT_CODE_INFO
             WHERE REF_L_C=500
               AND REF_M_C=28
               AND REF_S_C = 5
             UNION ALL
               SELECT 9999 REF_D_C, '합계' REF_D_NM FROM DUAL
      ) BB
    WHERE AA.GUNGU_CODE(+)   = BB.REF_D_C
    GROUP BY REF_D_C, REF_D_NM, DATA_ROW
    ORDER BY GUNGU_CODE


----------------------------------------

              select A.*
               FROM  RPT_TXIO_DDAC_TAB A
               WHERE  1=1
               AND A.SIGUMGO_ORG_C  = 28
               AND (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END) BETWEEN SUBSTR('202401',0,4) || '0101' AND '20241231'
               AND A.ICH_SIGUMGO_HOIKYE_C = '22'
               AND (
                    (
                        '1' = (CASE WHEN LENGTH(TRIM(NVL('', ''))) IS NULL THEN '1' ELSE '0' END)
                    )
                OR
                    (
                        '1' = (CASE WHEN ICH_SIGUMGO_GUN_GU_C = '' THEN '1' ELSE '0' END)
                    )
                )
               AND A.SIGUMGO_AC_B IN('10','20')

              -------------------------------------------


              SELECT  9999 ICH_SIGUMGO_GUN_GU_C, 2 DATA_ROW,
               SUM(CASE WHEN  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE BAS_DT END) = '20241231'  THEN  BIZPLC_BAEJUNG_JI_AMT ELSE 0  END)
                 +SUM(CASE WHEN  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE BAS_DT END) = '20241231'  THEN  BIZPLC_GAM_BAEJUNG_IP_AMT ELSE 0  END) AMT1,
               SUM(CASE WHEN  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE BAS_DT END) = '20241231' THEN  TAXO_FUND_BAEJUNG_JI_AMT+TAXO_HNDO_BAEJUNG_JI_AMT+TAXO_FUND_GETBK_JI_AMT
                                                                                                                                      +TAXO_HNDO_JICHUL_JI_AMT+TAXO_HNDO_GETBK_JI_AMT ELSE 0 END) AMT2,
               SUM(CASE WHEN  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE BAS_DT END) = '20241231' THEN  TAXO_RTRN_AMT ELSE 0 END)*-1 AMT3,
               0 AMT4,  0 AMT5,  0 AMT6,  0 AMT7,  0 AMT8,  0 AMT9,  0 AMT10, 0 AMT11, 0 AMT12,
               SUM(CASE WHEN SIGUMGO_AC_B = 10 THEN  BIZPLC_BAEJUNG_JI_AMT ELSE 0 END)
                 +SUM(BIZPLC_GAM_BAEJUNG_IP_AMT) AMT13,
               SUM(TAXO_FUND_BAEJUNG_JI_AMT+TAXO_HNDO_BAEJUNG_JI_AMT+TAXO_FUND_GETBK_JI_AMT
                                                                  +TAXO_HNDO_JICHUL_JI_AMT+TAXO_HNDO_GETBK_JI_AMT) AMT14,
               SUM(TAXO_RTRN_AMT)*-1 AMT15,
               SUM(CASE WHEN '12' < 3 AND '0' = 1 AND '2024' < 2007 THEN  GA_IWOL_JI_AMT
                                    WHEN '12' < 3 AND '0' = 1 AND '2024' >=2007 THEN  GA_IWOL_JI_AMT-GA_IWOL_IP_AMT
                                    WHEN '12' < 3 AND '0' != 1 AND '2024' < 2007  AND (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END)  > '2024' || '0100' THEN GA_IWOL_JI_AMT
                             WHEN '12' < 3 AND '0' != 1 AND '2024' >=2007 AND (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END)  > '2024' || '0100' THEN GA_IWOL_JI_AMT-GA_IWOL_IP_AMT
                      WHEN '12' >= 3 THEN 0
                 END) AMT16,
               0 AMT17,
               SUM(PMNY_JAN_MVO_AMT-PMNY_JAN_MVI_AMT) AMT18,
               0 AMT19, 0 AMT20, 0 AMT21, 0 AMT22, 0 AMT23, 0 AMT24,
               0 AMT25, 0 AMT26, 0 AMT27, 0 AMT28
               FROM  RPT_TXIO_DDAC_TAB A
               WHERE  1=1
               AND A.SIGUMGO_ORG_C  = 28
               AND (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END) BETWEEN SUBSTR('202401',0,4) || '0101' AND '20241231'
               AND A.ICH_SIGUMGO_HOIKYE_C = '22'
               AND (
                    (
                        '1' = (CASE WHEN LENGTH(TRIM(NVL('', ''))) IS NULL THEN '1' ELSE '0' END)
                    )
                OR
                    (
                        '1' = (CASE WHEN ICH_SIGUMGO_GUN_GU_C = '' THEN '1' ELSE '0' END)
                    )
                )
               AND A.SIGUMGO_AC_B IN('10','20')


              -------------------------------------------------------


              SELECT  9999 ICH_SIGUMGO_GUN_GU_C, 2 DATA_ROW,
               SUM(CASE WHEN  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE BAS_DT END) = '20241231'  THEN  BIZPLC_BAEJUNG_JI_AMT ELSE 0  END)
                 +SUM(CASE WHEN  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE BAS_DT END) = '20241231'  THEN  BIZPLC_GAM_BAEJUNG_IP_AMT ELSE 0  END) AMT1,
               SUM(CASE WHEN  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE BAS_DT END) = '20241231' THEN  TAXO_FUND_BAEJUNG_JI_AMT+TAXO_HNDO_BAEJUNG_JI_AMT+TAXO_FUND_GETBK_JI_AMT
                                                                                                                                      +TAXO_HNDO_JICHUL_JI_AMT+TAXO_HNDO_GETBK_JI_AMT ELSE 0 END) AMT2,
               SUM(CASE WHEN  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE BAS_DT END) = '20241231' THEN  TAXO_RTRN_AMT ELSE 0 END)*-1 AMT3,
               0 AMT4,  0 AMT5,  0 AMT6,  0 AMT7,  0 AMT8,  0 AMT9,  0 AMT10, 0 AMT11, 0 AMT12,
               SUM(CASE WHEN SIGUMGO_AC_B = 10 THEN  BIZPLC_BAEJUNG_JI_AMT ELSE 0 END)
                 +SUM(BIZPLC_GAM_BAEJUNG_IP_AMT) AMT13,
               SUM(TAXO_FUND_BAEJUNG_JI_AMT+TAXO_HNDO_BAEJUNG_JI_AMT+TAXO_FUND_GETBK_JI_AMT
                                                                  +TAXO_HNDO_JICHUL_JI_AMT+TAXO_HNDO_GETBK_JI_AMT) AMT14,
               SUM(TAXO_RTRN_AMT)*-1 AMT15,
               SUM(CASE WHEN '12' < 3 AND '0' = 1 AND '2024' < 2007 THEN  GA_IWOL_JI_AMT
                                    WHEN '12' < 3 AND '0' = 1 AND '2024' >=2007 THEN  GA_IWOL_JI_AMT-GA_IWOL_IP_AMT
                                    WHEN '12' < 3 AND '0' != 1 AND '2024' < 2007  AND (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END)  > '2024' || '0100' THEN GA_IWOL_JI_AMT
                             WHEN '12' < 3 AND '0' != 1 AND '2024' >=2007 AND (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END)  > '2024' || '0100' THEN GA_IWOL_JI_AMT-GA_IWOL_IP_AMT
                      WHEN '12' >= 3 THEN 0
                 END) AMT16,
               0 AMT17,
               SUM(PMNY_JAN_MVO_AMT-PMNY_JAN_MVI_AMT) AMT18,
               0 AMT19, 0 AMT20, 0 AMT21, 0 AMT22, 0 AMT23, 0 AMT24,
               0 AMT25, 0 AMT26, 0 AMT27, 0 AMT28
               FROM  RPT_TXIO_DDAC_TAB A
               WHERE  1=1
               AND A.SIGUMGO_ORG_C  = 28
               AND (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END) BETWEEN SUBSTR('202401',0,4) || '0101' AND '20241231'
               AND A.ICH_SIGUMGO_HOIKYE_C = '22'
               AND (
                    (
                        '1' = (CASE WHEN LENGTH(TRIM(NVL('', ''))) IS NULL THEN '1' ELSE '0' END)
                    )
                OR
                    (
                        '1' = (CASE WHEN ICH_SIGUMGO_GUN_GU_C = '' THEN '1' ELSE '0' END)
                    )
                )
               AND A.SIGUMGO_AC_B IN('10','20')

              ----------------------------------------------------------

              select * from  SFI_PADM_ORG_INF where upd_dttm like '20250102%'



              select * from  SFI_PADM_ORG_INF where upd_dttm like '20250102%'
and (
mk_dt like '2025%'
or
mg_dt like '2025%'
)
