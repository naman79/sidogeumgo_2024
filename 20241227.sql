

select * from acl_sgggwaon_slv
where 1=1
and trxdt = '20240222'
and ich_sigumgo_gun_gu_c = 200
and rpt_wrt_10_no =1

select trxdt, ich_sigumgo_gun_gu_c, sum(tout_amt) as tout_amt from acl_sgggwaon_slv
where 1=1
and trxdt = '20240222'
and ich_sigumgo_gun_gu_c = 200
and rpt_wrt_10_no =1
group by trxdt, ich_sigumgo_gun_gu_c

-- 부가국세 검토

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

-- 거래구분 3: 담배소비세 군구코드 로직 확인
SELECT
    NULL AS SEQ_NO_ST,
    'SEL02' AS SELECT_TYPE,
    RQST_DT AS KEORAEIL,
    RQST_DT AS SUNAPIL,
    '2024' AS HOIGYE_YEAR, -- 변경 필요
    1 AS YEAR_GUBUN, -- 확인 필요
    SUBSTR(JI_MSG_MNG_NO, 1, 2) AS GEUMGO_CODE, -- 확인 필요
    CONCAT('000','0000') AS DDAC_BR_CD, -- 확인 필요, GRBRNO
    NULL AS ORG_MNGBR, --
    3 AS GEORAE_GUBUN, -- 확정
    0 AS GEORAE_CHANNEL,
    CASE
        WHEN SUBSTR(JI_MSG_MNG_NO, 3, 3) = '000' THEN '60'
        WHEN SUBSTR(JI_MSG_MNG_NO, 3, 3) = '177' THEN '170'
        ELSE SUBSTR(JI_MSG_MNG_NO, 3, 3)
        END AS GUNGU_CODE, -- 확인 필요
    '103000' AS JIBGYE_CODE, -- 확인 필요
    NULL AS HOIKYE_CD,
    NULL AS SMOK_CD,
    0 AS BONSE_CNT,
    0 AS BONSE_AMT,
    0 AS SEWOI_CNT,
    0 AS SEWOI_AMT,
    0 AS GYOYUKSE_CNT,
    NTAX_EDTAX_AMT + ETC_AMT6 AS GYOYUKSE_AMT,
    0 AS NONGTEUKSE_CNT,
    NTAX_NTTAX_AMT + ETC_AMT5 AS NONGTEUKSE_AMT,
    0 AS JIBANG_EDTAX_CNT, 0 AS JIBANG_EDTAX_AMT,
    0 AS CITY_TAX_CNT, 0 AS CITY_TAX_AMT,
    0 AS ETC_CNT, 0 AS ETC_AMT,
    /* FILLER 값 설정 - SEIPGYEJWA, FIL_5_NO1 */
    '02800001100000024' AS SEIPGYEJWA, -- 변경 필요
    NULL AS JUSEOK, NULL AS ICHEIL, NULL AS HOIKYE_SMOK_C,
    NULL AS TAX_NO, NULL AS GIROCD, NULL AS SUNP_M_G,
    NULL AS FIL_DT1, NULL AS FIL_DT2, NULL AS FIL_DT3, NULL AS FIL_DT4, NULL AS FIL_DT5,
    NULL AS FIL_5_NO1,
    NULL AS FIL_5_NO2, NULL AS FIL_5_NO3, NULL AS FIL_5_NO4, NULL AS FIL_5_NO5,
    NULL AS FIL_18_AMT1, NULL AS FIL_18_AMT2, NULL AS FIL_18_AMT3, NULL AS FIL_18_AMT4, NULL AS FIL_18_AMT5,
    RQST_DT AS KJ_DT
FROM ACL_SGGGWAON_IP
WHERE 1=1
  AND ICH_GMGO_TRX_G = '1001'
  AND (NTAX_NTTAX_AMT + ETC_AMT5 + NTAX_EDTAX_AMT + ETC_AMT6) > 0
  AND TRX_S IS NULL
  AND RQST_DT LIKE '202410%' -- 파라미터 받아서 사용
;

-- 거래구분 6: MNGBR, ORG_MNGBR 부분 신경쓸 것
SELECT
    2 AS SEQ_NO,
    KEORAEIL,
    KIJUNIL,
    2024 AS HOIGYE_YEAR,
    1 AS YEAR_GUBUN,
    28 AS GEUMGO_CODE,
    26 AS BANK_GUBUN,
    MNGBR,
    MNGBR AS SUNAP_BR,
    6 AS GEORAE_GUBUN,
    0 AS GEORAE_CHANNEL,
    GUNGU_CODE,
    '103000' AS JIBGYE_CODE,
    0 AS BONSE_CNT,
    0 AS BONSE_AMT,
    0 AS SEWOI_CNT,
    0 AS SEWOI_AMT,
    0 AS GYOYUKSE_CNT,
    SUM(GYOYUKSE_AMT) AS GYOYUKSE_AMT,
    0 AS NONGTEUKSE_CNT,
    SUM(NONGTEUKSE_AMT) AS NONGTEUKSE_AMT,
    0 AS OCR_G,
    0 AS OCR_CNT,
    0 AS OCR_AMT,
    '02800001100000024' AS GONGGEUM_GYEJWA,
    '충당금' AS JUSEOK,
    '' AS ICHEIL
FROM (
         SELECT
             RQST_DT AS KEORAEIL,
             RQST_DT AS KIJUNIL,
             GRBRNO AS MNGBR,
             CASE
                 WHEN SUBSTR(JI_MSG_MNG_NO, 3, 3) = '000' THEN '60'
                 WHEN SUBSTR(JI_MSG_MNG_NO, 3, 3) = '177' THEN '170'
                 ELSE SUBSTR(JI_MSG_MNG_NO, 3, 3)
                 END AS GUNGU_CODE, -- 확인 필요
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
    KIJUNIL,
    MNGBR,
    GUNGU_CODE


-------------------------------------------
-------------------------------------------
-------------------------------------------



-- 거래구분 3: 바깥 쿼리 포함 (BGSGubun07)
SELECT   (ROW_NUMBER() OVER(PARTITION BY S2.KEORAEIL
                                         ORDER BY S2.KEORAEIL, S2.SUNAPIL, S2.JIBGYE_CODE, S2.GEORAE_GUBUN, S2.GEUMGO_CODE, S2.GUNGU_CODE,
                                                      S2.HOIGYE_YEAR, S2.YEAR_GUBUN, S2.BANK_GUBUN, S2.MNGBR, S2.GEORAE_CHANNEL) + 70000
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

        S2.BONSE_CNT,
        S2.BONSE_AMT,
        S2.SEWOI_CNT,
        S2.SEWOI_AMT,
        S2.GYOYUKSE_CNT,
        S2.GYOYUKSE_AMT,
        S2.NONGTEUKSE_CNT,
        S2.NONGTEUKSE_AMT,

        S2.SEIPGYEJWA,
        S2.JUSEOK,
        S2.ICHEIL,
        S2.HOIKYE_SMOK_C,
        S2.TAX_NO,
        S2.GIROCD,
        S2.SUNP_M_G,

        S2.FIL_DT1,
        S2.FIL_DT2,
        S2.FIL_DT3,
        S2.FIL_DT4,
        S2.FIL_DT5,
        S2.FIL_5_NO1,
        S2.FIL_5_NO2,
        S2.FIL_5_NO3,
        S2.FIL_5_NO4,
        S2.FIL_5_NO5,
        S2.FIL_18_AMT1,
        S2.FIL_18_AMT2,
        S2.FIL_18_AMT3,
        S2.FIL_18_AMT4,
        S2.FIL_18_AMT5,

        TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') AS DR_DTTM,
        'BGS'||S2.KEORAEIL||'G07' AS DROKJA_ID,
        TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') AS UPD_DTTM,
        'BRPTGenerateSunapJibgye' AS MODR_ID,

        S2.KJ_DT
FROM
    (
        SELECT  S1.SEQ_NO_ST,
                S1.SELECT_TYPE,
                S1.KEORAEIL,
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
                SELECT
                    NULL AS SEQ_NO_ST,
                    'SEL02' AS SELECT_TYPE,
                    RQST_DT AS KEORAEIL,
                    RQST_DT AS SUNAPIL,
                    '2024' AS HOIGYE_YEAR, -- 변경 필요
                    1 AS YEAR_GUBUN, -- 확인 필요
                    SUBSTR(JI_MSG_MNG_NO, 1, 2) AS GEUMGO_CODE, -- 확인 필요
                    CONCAT('000','0000') AS DDAC_BR_CD, -- 확인 필요, GRBRNO
                    NULL AS ORG_MNGBR, --
                    3 AS GEORAE_GUBUN, -- 확정
                    0 AS GEORAE_CHANNEL,
                    CASE
                        WHEN SUBSTR(JI_MSG_MNG_NO, 3, 3) = '000' THEN '60'
                        WHEN SUBSTR(JI_MSG_MNG_NO, 3, 3) = '177' THEN '170'
                        ELSE SUBSTR(JI_MSG_MNG_NO, 3, 3)
                        END AS GUNGU_CODE, -- 확인 필요
                    '103000' AS JIBGYE_CODE, -- 확인 필요
                    NULL AS HOIKYE_CD,
                    NULL AS SMOK_CD,
                    0 AS BONSE_CNT,
                    0 AS BONSE_AMT,
                    0 AS SEWOI_CNT,
                    0 AS SEWOI_AMT,
                    0 AS GYOYUKSE_CNT,
                    NTAX_EDTAX_AMT + ETC_AMT6 AS GYOYUKSE_AMT,
                    0 AS NONGTEUKSE_CNT,
                    NTAX_NTTAX_AMT + ETC_AMT5 AS NONGTEUKSE_AMT,
                    0 AS JIBANG_EDTAX_CNT, 0 AS JIBANG_EDTAX_AMT,
                    0 AS CITY_TAX_CNT, 0 AS CITY_TAX_AMT,
                    0 AS ETC_CNT, 0 AS ETC_AMT,
                    /* FILLER 값 설정 - SEIPGYEJWA, FIL_5_NO1 */
                    '02800001100000024' AS SEIPGYEJWA, -- 변경 필요
                    NULL AS JUSEOK, NULL AS ICHEIL, NULL AS HOIKYE_SMOK_C,
                    NULL AS TAX_NO, NULL AS GIROCD, NULL AS SUNP_M_G,
                    NULL AS FIL_DT1, NULL AS FIL_DT2, NULL AS FIL_DT3, NULL AS FIL_DT4, NULL AS FIL_DT5,
                    NULL AS FIL_5_NO1,
                    NULL AS FIL_5_NO2, NULL AS FIL_5_NO3, NULL AS FIL_5_NO4, NULL AS FIL_5_NO5,
                    NULL AS FIL_18_AMT1, NULL AS FIL_18_AMT2, NULL AS FIL_18_AMT3, NULL AS FIL_18_AMT4, NULL AS FIL_18_AMT5,
                    RQST_DT AS KJ_DT
                FROM ACL_SGGGWAON_IP
                WHERE 1=1
                  AND ICH_GMGO_TRX_G = '1001'
                  AND (NTAX_NTTAX_AMT + ETC_AMT5 + NTAX_EDTAX_AMT + ETC_AMT6) > 0
                  AND TRX_S IS NULL
                  AND RQST_DT >= '20240213' -- 파라미터 받아서 사용
            ) S1
    ) S2
/* 2024.10.21 GROUP BY 제거 */
ORDER BY
    S2.KEORAEIL,
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



-- 거래구분 6: 바깥쿼리 포함 (EaiAfterProc)
SELECT
    SEQ_NO
     ,KEORAEIL
     ,KIJUNIL
     ,HOIGYE_YEAR
     ,YEAR_GUBUN
     ,GEUMGO_CODE
     ,BANK_GUBUN
     ,MNGBR
     ,SUNAP_BR
     ,GEORAE_GUBUN
     ,GEORAE_CHANNEL
     ,GUNGU_CODE
     ,JIBGYE_CODE
     ,SUM(BONSE_CNT)
     ,SUM(BONSE_AMT)
     ,SUM(SEWOI_CNT)
     ,SUM(SEWOI_AMT)
     ,SUM(GYOYUKSE_CNT)
     ,SUM(GYOYUKSE_AMT)
     ,SUM(NONGTEUKSE_CNT)
     ,SUM(NONGTEUKSE_AMT)
     ,GONGGEUM_GYEJWA
     ,JUSEOK
     ,''
FROM   (
           SELECT
               2 AS SEQ_NO,
               KEORAEIL,
               KIJUNIL,
               2024 AS HOIGYE_YEAR,
               1 AS YEAR_GUBUN,
               28 AS GEUMGO_CODE,
               26 AS BANK_GUBUN,
               MNGBR,
               MNGBR AS SUNAP_BR,
               6 AS GEORAE_GUBUN,
               0 AS GEORAE_CHANNEL,
               GUNGU_CODE,
               '103000' AS JIBGYE_CODE,
               0 AS BONSE_CNT,
               0 AS BONSE_AMT,
               0 AS SEWOI_CNT,
               0 AS SEWOI_AMT,
               0 AS GYOYUKSE_CNT,
               SUM(GYOYUKSE_AMT) AS GYOYUKSE_AMT,
               0 AS NONGTEUKSE_CNT,
               SUM(NONGTEUKSE_AMT) AS NONGTEUKSE_AMT,
               0 AS OCR_G,
               0 AS OCR_CNT,
               0 AS OCR_AMT,
               '02800001100000024' AS GONGGEUM_GYEJWA,
               '충당금' AS JUSEOK,
               '' AS ICHEIL
           FROM (
                    SELECT
                        RQST_DT AS KEORAEIL,
                        RQST_DT AS KIJUNIL,
                        GRBRNO AS MNGBR,
                        CASE
                            WHEN SUBSTR(JI_MSG_MNG_NO, 3, 3) = '000' THEN '60'
                            WHEN SUBSTR(JI_MSG_MNG_NO, 3, 3) = '177' THEN '170'
                            ELSE SUBSTR(JI_MSG_MNG_NO, 3, 3)
                            END AS GUNGU_CODE, -- 확인 필요
                        NTAX_EDTAX_AMT + ETC_AMT6 AS GYOYUKSE_AMT,
                        NTAX_NTTAX_AMT + ETC_AMT5 AS NONGTEUKSE_AMT
                    FROM ACL_SGGGWAON_IP
                    WHERE 1=1
                      AND ICH_GMGO_TRX_G LIKE '2%'
                      AND (NTAX_NTTAX_AMT + ETC_AMT5 + NTAX_EDTAX_AMT + ETC_AMT6) > 0
                      AND TRX_S IS NULL
                      AND RQST_DT >= '20240213'
                )
           GROUP BY
               KEORAEIL,
               KIJUNIL,
               MNGBR,
               GUNGU_CODE
       ) T
GROUP BY  SEQ_NO
       ,KEORAEIL
       ,KIJUNIL
       ,HOIGYE_YEAR
       ,YEAR_GUBUN
       ,GEUMGO_CODE
       ,BANK_GUBUN
       ,MNGBR
       ,SUNAP_BR
       ,GEORAE_GUBUN
       ,GEORAE_CHANNEL
       ,GUNGU_CODE
       ,JIBGYE_CODE
       ,GONGGEUM_GYEJWA
       ,JUSEOK

;

    select count(*) as cnt from rpt_sunap_jibgye
    where sunapil like '2024%'
    and georae_gubun in (3, 6)


    select * from rpt_sunap_jibgye
where
geumgo_code = 28
and sunapil like '2024%'
and georae_gubun in (3, 6)