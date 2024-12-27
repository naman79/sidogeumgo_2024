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

select substr(dr_dttm, 1, 8) AS DD, DROKJA_ID, COUNT(*) AS CNT
from rpt_sunap_jibgye
where geumgo_code = 28
  and drokja_id like 'BGS%'
  and dr_dttm >= '20241211000000'
group by substr(dr_dttm, 1, 8), DROKJA_ID
ORDER BY substr(dr_dttm, 1, 8), DROKJA_ID
    ;

---------------------------------------------------------------------------------------------------


;

SELECT  (ROW_NUMBER() OVER(PARTITION BY S2.SUNAPIL
                           ORDER BY S2.SUNAPIL, S2.JIBGYE_CODE, S2.GEORAE_GUBUN, S2.GEUMGO_CODE, S2.GUNGU_CODE,
                                    S2.HOIGYE_YEAR, S2.YEAR_GUBUN, S2.BANK_GUBUN, S2.MNGBR, S2.GEORAE_CHANNEL)
            ) AS SEQ_NO,
        S2.KEORAEIL,
        S2.SUNAPIL,
        S2.HOIGYE_YEAR,
        S2.YEAR_GUBUN,
        S2.GEUMGO_CODE,
        S2.BANK_GUBUN,
        TO_NUMBER(S2.MNGBR) AS MNGBR,
        TO_NUMBER(CASE WHEN S2.ORG_MNGBR IS NULL THEN S2.MNGBR ELSE S2.ORG_MNGBR END) AS ORG_MNGBR,
        S2.GEORAE_GUBUN,
        S2.GEORAE_CHANNEL,
        S2.GUNGU_CODE,
        S2.JIBGYE_CODE,

        SUM(S2.BONSE_CNT) AS BONSE_CNT,
        SUM(S2.BONSE_AMT) AS BONSE_AMT,
        SUM(S2.SEWOI_CNT) AS SEWOI_CNT,
        SUM(S2.SEWOI_AMT) AS SEWOI_AMT,
        SUM(S2.GYOYUKSE_CNT) AS GYOYUKSE_CNT,
        SUM(S2.GYOYUKSE_AMT) AS GYOYUKSE_AMT,
        SUM(S2.NONGTEUKSE_CNT) AS NONGTEUKSE_CNT,
        SUM(S2.NONGTEUKSE_AMT) AS NONGTEUKSE_AMT,

        MAX(S2.SEIPGYEJWA) AS SEIPGYEJWA,
        MAX(S2.JUSEOK) AS JUSEOK,
        MAX(S2.ICHEIL) AS ICHEIL,
        MAX(S2.HOIKYE_SMOK_C) AS HOIKYE_SMOK_C,
        MAX(S2.TAX_NO) AS TAX_NO,
        MAX(S2.GIROCD) AS GIROCD,
        MAX(S2.SUNP_M_G) AS SUNP_M_G,

        MAX(S2.FIL_DT1) AS FIL_DT1,
        MAX(S2.FIL_DT2) AS FIL_DT2,
        MAX(S2.FIL_DT3) AS FIL_DT3,
        MAX(S2.FIL_DT4) AS FIL_DT4,
        MAX(S2.FIL_DT5) AS FIL_DT5,
        MAX(S2.FIL_5_NO1) AS FIL_5_NO1,
        MAX(S2.FIL_5_NO2) AS FIL_5_NO2,
        MAX(S2.FIL_5_NO3) AS FIL_5_NO3,
        MAX(S2.FIL_5_NO4) AS FIL_5_NO4,
        MAX(S2.FIL_5_NO5) AS FIL_5_NO5,
        SUM(S2.FIL_18_AMT1) AS FIL_18_AMT1,
        SUM(S2.FIL_18_AMT2) AS FIL_18_AMT2,
        SUM(S2.FIL_18_AMT3) AS FIL_18_AMT3,
        SUM(S2.FIL_18_AMT4) AS FIL_18_AMT4,
        SUM(S2.FIL_18_AMT5) AS FIL_18_AMT5,

        TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') AS DR_DTTM,
        'BGS'||S2.SUNAPIL||'G08' AS DROKJA_ID,
        TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') AS UPD_DTTM,
        'BRPTGenerateSunapJibgye' AS MODR_ID,

        S2.KJ_DT
FROM
    (
        SELECT  S1.SEQ_NO_ST,
                S1.SELECT_TYPE,
                (SELECT II.NEXT_BIZ_DT FROM MAP_JOB_DATE II WHERE II.DW_BAS_DDT = S1.SUNAPIL AND II.DT_G = 0 ) AS KEORAEIL,
                S1.SUNAPIL,
                S1.HOIGYE_YEAR,
                S1.YEAR_GUBUN,
                S1.GEUMGO_CODE,
                S1.DDAC_BR_CD,
                TO_NUMBER(SUBSTR(S1.DDAC_BR_CD, 1, 3)) AS BANK_GUBUN,
                SUBSTR(S1.DDAC_BR_CD, 4, 4) AS MNGBR,
                S1.ORG_MNGBR,
                S1.GEORAE_GUBUN,
                S1.GEORAE_CHANNEL,
                S1.GUNGU_CODE,
                S1.JIBGYE_CODE,

                S1.BONSE_CNT, S1.BONSE_AMT,
                S1.SEWOI_CNT, S1.SEWOI_AMT,
                S1.GYOYUKSE_CNT, S1.GYOYUKSE_AMT,
                S1.NONGTEUKSE_CNT, S1.NONGTEUKSE_AMT,

                S1.SEIPGYEJWA, S1.JUSEOK, S1.ICHEIL, S1.HOIKYE_SMOK_C, S1.TAX_NO, S1.GIROCD, S1.SUNP_M_G,

                S1.FIL_DT1, S1.FIL_DT2, S1.FIL_DT3, S1.FIL_DT4, S1.FIL_DT5,
                S1.FIL_5_NO1, S1.FIL_5_NO2, S1.FIL_5_NO3, S1.FIL_5_NO4, S1.FIL_5_NO5,
                S1.FIL_18_AMT1, S1.FIL_18_AMT2, S1.FIL_18_AMT3, S1.FIL_18_AMT4, S1.FIL_18_AMT5,

                S1.KJ_DT
        FROM
            (
                /* SEL01 103000,104000, GEORAE_GUBUN 2, ACL_SIGUMGO_SLV, 통합단말 7290 수기등록(본세,세외) 신한외 */
                SELECT NULL AS SEQ_NO_ST,
                       'SEL01' AS SELECT_TYPE, /* 조회위치 구분용, 디버그용 */
                       NULL AS KEORAEIL,
                       CASE WHEN GJDT > GISDT THEN GISDT ELSE GJDT END AS SUNAPIL,
                       SIGUMGO_HOIKYE_YR AS HOIGYE_YEAR,
                       NEW_GU_YR_G AS YEAR_GUBUN,
                       SIGUMGO_ORG_C AS GEUMGO_CODE,
                       CONCAT('026',TRXBRNO) AS DDAC_BR_CD,
                       NULL AS ORG_MNGBR,
                       SIGUMGO_SUNP_TRX_G AS GEORAE_GUBUN,
                       0 AS GEORAE_CHANNEL,
                       SUNP_ICH_SIGUMGO_GUN_GU_C AS GUNGU_CODE,
                       TO_NUMBER(CONCAT('10', SUNP_SIGUMGO_HOIKYE_SMOK_C)) AS JIBGYE_CODE,

                    /* 회계코드, 세목코드 등, 디버그용 시작 */
                       TO_CHAR(ICH_SIGUMGO_HOIKYE_C) AS HOIKYE_CD,
                       TO_CHAR(SUNP_SIGUMGO_HOIKYE_SMOK_C) AS SMOK_CD,
                    /* 회계코드, 세목코드 등, 디버그용 끝 */

                       MTAX_CNT AS BONSE_CNT,
                       CASE WHEN CRT_CAN_G IN (1,2,33) THEN -1 ELSE 1 END * MTAX_AMT AS BONSE_AMT,
                       TAX_OI_SUIP_CNT AS SEWOI_CNT,
                       CASE WHEN CRT_CAN_G IN (1,2,33) THEN -1 ELSE 1 END * TAX_OI_SUIP_AMT AS SEWOI_AMT,
                       0 AS GYOYUKSE_CNT, 0 AS GYOYUKSE_AMT,
                       0 AS NONGTEUKSE_CNT, 0 AS NONGTEUKSE_AMT,
                       0 AS JIBANG_EDTAX_CNT, 0 AS JIBANG_EDTAX_AMT,
                       0 AS CITY_TAX_CNT, 0 AS CITY_TAX_AMT,
                       0 AS ETC_CNT, 0 AS ETC_AMT,

                       '0' AS SEIPGYEJWA, NULL AS JUSEOK, NULL AS ICHEIL, NULL AS HOIKYE_SMOK_C,
                       NULL AS TAX_NO, NULL AS GIROCD, NULL AS SUNP_M_G,
                       NULL AS FIL_DT1, NULL AS FIL_DT2, NULL AS FIL_DT3, NULL AS FIL_DT4, NULL AS FIL_DT5,
                       NULL AS FIL_5_NO1, NULL AS FIL_5_NO2, NULL AS FIL_5_NO3, NULL AS FIL_5_NO4, NULL AS FIL_5_NO5,
                       NULL AS FIL_18_AMT1, NULL AS FIL_18_AMT2, NULL AS FIL_18_AMT3, NULL AS FIL_18_AMT4, NULL AS FIL_18_AMT5,

                       TRXDT AS KJ_DT
                FROM ACL_SIGUMGO_SLV
                WHERE MNG_NO = 1
                  AND GJDT   = '20241217'
                  AND SIGUMGO_ORG_C = 28
                  AND SIGUMGO_TRX_G = 20
                  AND CRT_CAN_G = 0
                  AND SIGUMGO_SUNP_TRX_G IN (2, 3, 4)
                  AND
                    (
                        SUNP_SIGUMGO_HOIKYE_SMOK_C = 3000
                            OR
                        (
                            SUNP_SIGUMGO_HOIKYE_SMOK_C = 4000
                                AND NOT
                                (
                                    /* 2024.02 서구청 충당 제외 */
                                    SUNP_SIGUMGO_HOIKYE_SMOK_C = 4000
                                        AND SUNP_ICH_SIGUMGO_GUN_GU_C = 260
                                        AND LST_CHG_SCR_ID = '0073460000'
                                    )
                            )
                        )

                UNION ALL
                /* SEL02 209332, GEORAE_GUBUN 2, ACL_SIGUMGO_SLV, 통합단말 7290 수기 */
                SELECT NULL AS SEQ_NO_ST,
                       'SEL02' AS SELECT_TYPE, /* 조회위치 구분용, 디버그용 */
                       NULL AS KEORAEIL,
                       CASE WHEN GJDT > GISDT THEN GISDT ELSE GJDT END AS SUNAPIL,
                       SIGUMGO_HOIKYE_YR AS HOIGYE_YEAR,
                       CASE WHEN NEW_GU_YR_G = 0 THEN 1
                            WHEN SIGUMGO_HOIKYE_YR = '9999' THEN 1
                            WHEN SUBSTR(TRXDT,0,4) = SIGUMGO_HOIKYE_YR THEN 1
                            ELSE 9
                           END AS YEAR_GUBUN,
                       SIGUMGO_ORG_C AS GEUMGO_CODE,
                       CONCAT('026',TRXBRNO) AS DDAC_BR_CD,
                       NULL AS ORG_MNGBR,
                       CASE WHEN SIGUMGO_SUNP_TRX_G = 3 THEN 2
                            ELSE 2
                           END AS GEORAE_GUBUN,
                       0 AS GEORAE_CHANNEL,
                       CASE WHEN SUNP_SIGUMGO_HOIKYE_SMOK_C = 9332 AND SUNP_ICH_SIGUMGO_GUN_GU_C = 0
                                THEN 7100
                            ELSE TO_NUMBER(CONCAT('7',SUNP_ICH_SIGUMGO_GUN_GU_C))
                           END AS GUNGU_CODE,
                       TO_NUMBER(CONCAT('20', SUNP_SIGUMGO_HOIKYE_SMOK_C)) AS JIBGYE_CODE,

                    /* 회계코드, 세목코드 등, 디버그용 시작 */
                       TO_CHAR(ICH_SIGUMGO_HOIKYE_C) AS HOIKYE_CD,
                       TO_CHAR(SUNP_SIGUMGO_HOIKYE_SMOK_C) AS SMOK_CD,
                    /* 회계코드, 세목코드 등, 디버그용 끝 */

                       SUNP_CNT AS BONSE_CNT,
                       CASE WHEN CRT_CAN_G IN (1,2,33) THEN -1 ELSE 1 END * SUNP_AMT AS BONSE_AMT,
                       0 AS SEWOI_CNT, 0 AS SEWOI_AMT,
                       0 AS GYOYUKSE_CNT, 0 AS GYOYUKSE_AMT,
                       0 AS NONGTEUKSE_CNT, 0 AS NONGTEUKSE_AMT,
                       0 AS JIBANG_EDTAX_CNT, 0 AS JIBANG_EDTAX_AMT,
                       0 AS CITY_TAX_CNT, 0 AS CITY_TAX_AMT,
                       0 AS ETC_CNT, 0 AS ETC_AMT,

                       '0' AS SEIPGYEJWA, NULL AS JUSEOK, NULL AS ICHEIL, NULL AS HOIKYE_SMOK_C,
                       NULL AS TAX_NO, NULL AS GIROCD, NULL AS SUNP_M_G,
                       NULL AS FIL_DT1, NULL AS FIL_DT2, NULL AS FIL_DT3, NULL AS FIL_DT4, NULL AS FIL_DT5,
                       NULL AS FIL_5_NO1, NULL AS FIL_5_NO2, NULL AS FIL_5_NO3, NULL AS FIL_5_NO4, NULL AS FIL_5_NO5,
                       NULL AS FIL_18_AMT1, NULL AS FIL_18_AMT2, NULL AS FIL_18_AMT3, NULL AS FIL_18_AMT4, NULL AS FIL_18_AMT5,

                       TRXDT AS KJ_DT
                FROM ACL_SIGUMGO_SLV
                WHERE MNG_NO = 1
                  AND GJDT   = '20241217'
                  AND SIGUMGO_ORG_C = 28
                  AND SIGUMGO_TRX_G = 20
                  AND CRT_CAN_G IN (0, 1, 2, 31, 32)
                  AND SIGUMGO_SUNP_TRX_G IN (2, 3, 4)
                  AND SUNP_SIGUMGO_HOIKYE_SMOK_C = 9332
            ) S1
    ) S2
GROUP BY
    S2.SEQ_NO_ST,
    S2.KEORAEIL,
    S2.SUNAPIL,
    S2.HOIGYE_YEAR,
    S2.YEAR_GUBUN,
    S2.GEUMGO_CODE,
    S2.BANK_GUBUN,
    S2.MNGBR,
    S2.ORG_MNGBR,
    S2.GEORAE_GUBUN,
    S2.GEORAE_CHANNEL,
    S2.GUNGU_CODE,
    S2.JIBGYE_CODE,
    S2.KJ_DT
ORDER BY
    S2.SUNAPIL,
    S2.JIBGYE_CODE,
    S2.GEORAE_GUBUN,
    S2.GEUMGO_CODE,
    S2.GUNGU_CODE,
    S2.HOIGYE_YEAR,
    S2.YEAR_GUBUN,
    S2.BANK_GUBUN,
    S2.MNGBR,
    S2.GEORAE_CHANNEL

;


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
UNION ALL
SELECT GJDT AS DT, '3.충당(ACL_SUNAPMSG_SLV)' AS GUBUN, SUM(SUNP_AMT) AS AMT
FROM ACL_SUNAPMSG_SLV
WHERE GJDT IN (SELECT DT FROM MERGED_BIZDT)
  AND UPMU_G IN (1, 2, 4)
  AND RPT_TOT_C = '104901'
GROUP BY GJDT
UNION ALL
SELECT GJDT AS DT, '4.충당(ACL_SIGUMGO_SLV)' AS GUBUN, SUM(DECODE(CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1)*TRAMT) AS AMT
FROM ACL_SIGUMGO_SLV
WHERE GJDT IN (SELECT DT FROM MERGED_BIZDT)
  AND SIGUMGO_ORG_C = 28
  AND SUNP_ICH_SIGUMGO_GUN_GU_C = '260'
  AND SIGUMGO_TRX_G4 = '10'
GROUP BY GJDT
UNION ALL
SELECT GJDT AS DT, '5.과오납(ACL_SUNAPMSG_SLV)' AS GUBUN, SUM(SUNP_AMT) AS AMT
FROM ACL_SUNAPMSG_SLV
WHERE GJDT IN (SELECT DT FROM MERGED_BIZDT)
  AND UPMU_G IN (3)
GROUP BY GJDT
UNION ALL
SELECT GJDT AS DT, '6.과오납(ACL_SIGUMGO_SLV)' AS GUBUN, SUM(DECODE(CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1)*TRAMT*DECODE(IPJI_G, 1, -1, 1)) AS AMT
FROM ACL_SIGUMGO_SLV
WHERE GJDT IN (SELECT DT FROM MERGED_BIZDT)
  AND SIGUMGO_ORG_C = 28
  AND SIGUMGO_TRX_G IN (24, 64)
GROUP BY GJDT
 UNION ALL
SELECT GJDT AS DT, '7.보고서(ACL_SUNAPMSG_SLV)' AS GUBUN, SUM(SUNP_AMT) AS AMT
FROM ACL_SUNAPMSG_SLV
WHERE GJDT IN (SELECT DT FROM MERGED_BIZDT)
  AND UPMU_G IN (5,6)
GROUP BY GJDT
UNION ALL
SELECT SUNAPIL AS DT, '8.보고서(RPT_SUNAP_JIBGYE)' AS GUBUN, SUM(BONSE_AMT) AS AMT
FROM RPT_SUNAP_JIBGYE
WHERE SUNAPIL IN (SELECT DT FROM MERGED_BIZDT)
  AND GEUMGO_CODE = 28
  AND GEORAE_GUBUN = 1
GROUP BY SUNAPIL
ORDER BY DT, GUBUN, AMT
;


SELECT GJDT AS DT, '충당(ACL_SIGUMGO_SLV)' AS GUBUN, SUM(DECODE(CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1)*TRAMT) AS AMT
FROM ACL_SIGUMGO_SLV
WHERE GJDT BETWEEN '20241201' AND '20241210'
  AND SIGUMGO_ORG_C = 28
  AND SIGUMGO_TRX_G4 = '10'
GROUP BY GJDT

;

-----------------------------------------------------------------------------------------

WITH SGGGWAON AS (
    SELECT
        KEORAEIL,
        SUNAPIL,
        GEORAE_GUBUN,
        ORG_MNGBR,
        GUNGU_CODE,
        JIBGYE_CODE,
        SUM(GYOYUKSE_AMT) AS GYOYUKSE_AMT,
        SUM(NONGTEUKSE_AMT) AS NONGTEUKSE_AMT
    FROM (
             SELECT
                 RQST_DT AS KEORAEIL,
                 RQST_DT AS SUNAPIL,
                 6 AS GEORAE_GUBUN,
                 GRBRNO AS ORG_MNGBR,
                 SUBSTR(JI_MSG_MNG_NO, 3, 3) AS GUNGU_CODE,
                 '103000' AS JIBGYE_CODE,
                 NTAX_EDTAX_AMT + ETC_AMT6 AS GYOYUKSE_AMT,
                 NTAX_NTTAX_AMT + ETC_AMT5 AS NONGTEUKSE_AMT
             FROM ACL_SGGGWAON_IP
             WHERE 1=1
               AND ICH_GMGO_TRX_G LIKE '2%'
               AND (NTAX_NTTAX_AMT + ETC_AMT5 + NTAX_EDTAX_AMT + ETC_AMT6) > 0
               AND TRX_S IS NULL
               AND RQST_DT BETWEEN '20240201' AND '20241031'
         )
    GROUP BY
        KEORAEIL,
        SUNAPIL,
        GEORAE_GUBUN,
        ORG_MNGBR,
        GUNGU_CODE,
        JIBGYE_CODE
    union all
    SELECT RQST_DT AS KEORAEIL,
           RQST_DT AS SUNAPIL,
           3 AS GEORAE_GUBUN,
           GRBRNO AS ORG_MNGBR,
           SUBSTR(JI_MSG_MNG_NO, 3, 3) AS GUNGU_CODE,
           '103000' AS JIBGYE_CODE,
           NTAX_EDTAX_AMT + ETC_AMT6 AS GYOYUKSE_AMT,
           NTAX_NTTAX_AMT + ETC_AMT5 AS NONGTEUKSE_AMT
    FROM ACL_SGGGWAON_IP
    WHERE 1=1
      AND ICH_GMGO_TRX_G = '1001'
      AND (NTAX_NTTAX_AMT + ETC_AMT5 + NTAX_EDTAX_AMT + ETC_AMT6) > 0
      AND TRX_S IS NULL
      AND RQST_DT BETWEEN '20240201' AND '20241031'
),
SUNAPJIBGYE AS
(
    SELECT
        KEORAEIL,
        SUNAPIL,
        GEORAE_GUBUN,
        ORG_MNGBR,
        GUNGU_CODE,
        JIBGYE_CODE,
        SUM(GYOYUKSE_AMT) AS GYOYUKSE_AMT,
        SUM(NONGTEUKSE_AMT) AS NONGTEUKSE_AMT
    FROM RPT_SUNAP_JIBGYE
    WHERE 1=1
    AND GEUMGO_CODE =28
    AND SUNAPIL BETWEEN '20240201' AND '20241031'
    AND GEORAE_GUBUN IN (3,6)
    AND (
        GYOYUKSE_AMT <> 0
        OR
        NONGTEUKSE_AMT <> 0
        )
    GROUP BY
    KEORAEIL,
    SUNAPIL,
    GEORAE_GUBUN,
    ORG_MNGBR,
    GUNGU_CODE,
    JIBGYE_CODE
)
SELECT
    KEORAEIL,
    SUNAPIL,
    GEORAE_GUBUN,
    ORG_MNGBR,
    GUNGU_CODE,
    JIBGYE_CODE,
    SUM(GYOYUKSE_AMT) AS GYOYUKSE_DIFF,
    SUM(NONGTEUKSE_AMT) AS NONGTEUKSE_DIFF
FROM
(
SELECT
    'SGGGWAON' AS GUBUN,
    KEORAEIL,
    SUNAPIL,
    TO_CHAR(GEORAE_GUBUN) AS GEORAE_GUBUN,
    TO_CHAR(ORG_MNGBR) AS ORG_MNGBR,
    TO_CHAR(GUNGU_CODE) AS GUNGU_CODE,
    TO_CHAR(JIBGYE_CODE) AS JIBGYE_CODE,
    GYOYUKSE_AMT*-1 AS GYOYUKSE_AMT,
    NONGTEUKSE_AMT*-1 AS NONGTEUKSE_AMT
FROM SGGGWAON
UNION ALL
SELECT
    'SUNAPJIBGYE' AS GUBUN,
    KEORAEIL,
    SUNAPIL,
    TO_CHAR(GEORAE_GUBUN) AS GEORAE_GUBUN,
    TO_CHAR(ORG_MNGBR)  AS ORG_MNGBR,
    TO_CHAR(GUNGU_CODE) AS GUNGU_CODE,
    TO_CHAR(JIBGYE_CODE) AS JIBGYE_CODE,
    GYOYUKSE_AMT,
    NONGTEUKSE_AMT
FROM SUNAPJIBGYE
    ) A
GROUP BY
    KEORAEIL,
    SUNAPIL,
    GEORAE_GUBUN,
    ORG_MNGBR,
    GUNGU_CODE,
    JIBGYE_CODE
ORDER BY
     KEORAEIL,
     SUNAPIL,
     GEORAE_GUBUN,
     GUNGU_CODE,
     JIBGYE_CODE,
     ORG_MNGBR
------------------------------------------------------

    SELECT COUNT(DW_BAS_DDT) AS CNT FROM MAP_JOB_DATE
    WHERE 1=1
    AND DW_BAS_DDT LIKE '2025%'
    GROUP BY DW_BAS_DDT

--------------------------------------------------------
-- 거래구분 3
SELECT RQST_DT AS KEORAEIL,
        RQST_DT AS SUNAPIL,
       3 AS GEORAE_GUBUN,
       GRBRNO AS ORG_MNGBR,
       SUBSTR(JI_MSG_MNG_NO, 3, 3) AS GUNGU_CODE,
       '103000' AS JIBGYE_CODE,
       NTAX_EDTAX_AMT + ETC_AMT6 AS GYOYUKSE_AMT,
       NTAX_NTTAX_AMT + ETC_AMT5 AS NONGTEUKSE_AMT
FROM ACL_SGGGWAON_IP
WHERE 1=1
  AND ICH_GMGO_TRX_G = '1001'
  AND (NTAX_NTTAX_AMT + ETC_AMT5 + NTAX_EDTAX_AMT + ETC_AMT6) > 0
  AND TRX_S IS NULL
  AND RQST_DT LIKE '202410%'
ORDER BY
    KEORAEIL,
    SUNAPIL,
    GUNGU_CODE,
    JIBGYE_CODE,
    GYOYUKSE_AMT,
    NONGTEUKSE_AMT

;
-- 거래구분 6
SELECT
    KEORAEIL,
    SUNAPIL,
    GEORAE_GUBUN,
    ORG_MNGBR,
    GUNGU_CODE,
    JIBGYE_CODE,
    SUM(GYOYUKSE_AMT) AS GYOYUKSE_AMT,
    SUM(NONGTEUKSE_AMT) AS NONGTEUKSE_AMT
FROM (
         SELECT
             RQST_DT AS KEORAEIL,
             RQST_DT AS SUNAPIL,
             6 AS GEORAE_GUBUN,
             GRBRNO AS ORG_MNGBR,
             SUBSTR(JI_MSG_MNG_NO, 3, 3) AS GUNGU_CODE,
             '103000' AS JIBGYE_CODE,
             NTAX_EDTAX_AMT + ETC_AMT6 AS GYOYUKSE_AMT,
             NTAX_NTTAX_AMT + ETC_AMT5 AS NONGTEUKSE_AMT
         FROM ACL_SGGGWAON_IP
         WHERE 1=1
           AND ICH_GMGO_TRX_G LIKE '2%'
           AND (NTAX_NTTAX_AMT + ETC_AMT5 + NTAX_EDTAX_AMT + ETC_AMT6) > 0
           AND TRX_S IS NULL
           AND RQST_DT LIKE '202410%'
     )
GROUP BY
    KEORAEIL,
    SUNAPIL,
    GEORAE_GUBUN,
    ORG_MNGBR,
    GUNGU_CODE,
    JIBGYE_CODE
ORDER BY
    GEORAE_GUBUN,
    KEORAEIL,
    SUNAPIL,
    GUNGU_CODE,
    JIBGYE_CODE,
    GYOYUKSE_AMT,
    NONGTEUKSE_AMT
;