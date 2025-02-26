WITH BATCH_PARAM AS (
    SELECT
        'AAAA' AS GOF_CD,
        'AAAA' AS GOF_NM,
        28 AS GEUMGO_CODE,
        '20250224' AS BAS_DT,
        TO_NUMBER(2024) AS  BEF_HOIKYE_YR,
        TO_NUMBER(2025) AS HOIKYE_YR
    FROM DUAL
),
GYEJWA AS (
SELECT
    C.LAF_CD
     ,C.LAF_NM
     ,C.ACNT_DV_CD
     ,C.ACNT_DV_MSTR_CD
     ,C.ACNT_DV_MSTR_NM
     ,C.ACNT_DV_NM
     ,C.GONGGEUM_GYEJWA
     ,C.FYR
     ,B.SIGUMGO_ORG_C
     ,B.ICH_SIGUMGO_GUN_GU_C
     ,B.SIGUMGO_HOIKYE_YR
FROM RPT_FISG_INFO_MAP C
         INNER JOIN BATCH_PARAM D ON 1=1
         LEFT OUTER JOIN ACL_SIGUMGO_MAS B ON B.SIGUMGO_ORG_C = D.GEUMGO_CODE AND B.MNG_NO = 1 AND C.GONGGEUM_GYEJWA = B.FIL_100_CTNT2
    -- 자치단체분류코드는 LAF_CD 단위로 하나이다
         LEFT OUTER JOIN  SFI_CMM_C_DAT E ON E.CMM_C_NM = 'RPT자치단체코드분류' AND E.USE_YN = 'Y'AND C.LAF_CD = E.CMM_DTL_C
WHERE 1=1
  AND C.USE_YN = 'Y'
  AND C.FYR IN ( D.BEF_HOIKYE_YR, D.HOIKYE_YR)
  -- 99 계좌 중복 조회 제거
  -- AND NOT (C.FYR = D.BEF_HOIKYE_YR AND C.GONGGEUM_GYEJWA LIKE '%99')
  AND NOT (B.SIGUMGO_ORG_C = 28 AND B.ICH_SIGUMGO_GUN_GU_C IN('260','720'))
GROUP BY   C.LAF_CD
       ,C.LAF_NM
       ,C.ACNT_DV_CD
       ,C.ACNT_DV_MSTR_CD
       ,C.ACNT_DV_MSTR_NM
       ,C.ACNT_DV_NM
       ,C.GONGGEUM_GYEJWA
       ,C.FYR
       ,B.SIGUMGO_ORG_C
       ,B.ICH_SIGUMGO_GUN_GU_C
       ,B.SIGUMGO_HOIKYE_YR
),
GEORAE_JAN_SEQ AS (
    SELECT
        A.SIGUMGO_ORG_C,
        A.FIL_100_CTNT5 AS GONGGEUM_GYEJWA,
        MAX(A.TRXDT) AS MAX_TRXDT,
        D.BAS_DT AS TRXDT,
        MAX(A.LINKAC_TRX_NO) AS MAX_TRX_NO
    FROM  ACL_SIGUMGO_SLV A
              INNER JOIN BATCH_PARAM D ON 1=1
    WHERE 1=1
      AND A.SIGUMGO_ORG_C = D.GEUMGO_CODE
      AND A.FIL_100_CTNT5 IN (
        SELECT GONGGEUM_GYEJWA FROM GYEJWA
    )
      AND A.TRXDT BETWEEN  (D.BEF_HOIKYE_YR ||'0101') AND D.BAS_DT
    GROUP BY A.SIGUMGO_ORG_C ,
             D.BAS_DT,
             A.FIL_100_CTNT5
),
GEORAE_JAN  AS (
      SELECT A.TRXDT,
             CASE WHEN A.SIGUMGO_HOIKYE_YR = 9999 THEN SUBSTR(A.TRXDT, 0, 4) ELSE A.SIGUMGO_HOIKYE_YR END AS SIGUMGO_HOIKYE_YR ,
           A.FIL_100_CTNT5 AS GONGGEUM_GYEJWA,
           A.LINKAC_JAN
    FROM ACL_SIGUMGO_SLV A
             INNER JOIN BATCH_PARAM D ON 1 = 1
             INNER JOIN GEORAE_JAN_SEQ B ON A.SIGUMGO_ORG_C = B.SIGUMGO_ORG_C AND A.TRXDT = B.MAX_TRXDT AND
                                            A.FIL_100_CTNT5 = B.GONGGEUM_GYEJWA AND A.LINKAC_TRX_NO = B.MAX_TRX_NO
    WHERE 1 = 1
      AND A.SIGUMGO_ORG_C = D.GEUMGO_CODE
      AND A.FIL_100_CTNT5 IN (SELECT GONGGEUM_GYEJWA
                              FROM GYEJWA)
    ORDER BY A.FIL_100_CTNT5
    )
SELECT
    A.FYR,
    A.GONGGEUM_GYEJWA,
    B.LINKAC_JAN
FROM GYEJWA A
LEFT OUTER JOIN GEORAE_JAN B ON A.GONGGEUM_GYEJWA = B.GONGGEUM_GYEJWA AND A.FYR = B.SIGUMGO_HOIKYE_YR
ORDER BY A.FYR, A.GONGGEUM_GYEJWA

-------------------------------------------------------------------------


    WITH BATCH_PARAM AS (
    SELECT
        'AAAA' AS GOF_CD,
        'AAAA' AS GOF_NM,
        28 AS GEUMGO_CODE,
        '20240230' AS BAS_DT,
        TO_NUMBER(2023) AS  BEF_HOIKYE_YR,
        TO_NUMBER(2024) AS HOIKYE_YR
    FROM DUAL
),
GYEJWA AS (
SELECT
    C.LAF_CD
     ,C.LAF_NM
     ,C.ACNT_DV_CD
     ,C.ACNT_DV_MSTR_CD
     ,C.ACNT_DV_MSTR_NM
     ,C.ACNT_DV_NM
     ,C.GONGGEUM_GYEJWA
     ,C.FYR
     ,B.SIGUMGO_ORG_C
     ,B.ICH_SIGUMGO_GUN_GU_C
     ,B.SIGUMGO_HOIKYE_YR
FROM RPT_FISG_INFO_MAP C
         INNER JOIN BATCH_PARAM D ON 1=1
         LEFT OUTER JOIN ACL_SIGUMGO_MAS B ON B.SIGUMGO_ORG_C = D.GEUMGO_CODE AND B.MNG_NO = 1 AND C.GONGGEUM_GYEJWA = B.FIL_100_CTNT2
    -- 자치단체분류코드는 LAF_CD 단위로 하나이다
         LEFT OUTER JOIN  SFI_CMM_C_DAT E ON E.CMM_C_NM = 'RPT자치단체코드분류' AND E.USE_YN = 'Y'AND C.LAF_CD = E.CMM_DTL_C
WHERE 1=1
  AND C.USE_YN = 'Y'
  AND C.FYR IN ( D.BEF_HOIKYE_YR, D.HOIKYE_YR)
  -- 99 계좌 중복 조회 제거
  -- AND NOT (C.FYR = D.BEF_HOIKYE_YR AND C.GONGGEUM_GYEJWA LIKE '%99')
  AND NOT (B.SIGUMGO_ORG_C = 28 AND B.ICH_SIGUMGO_GUN_GU_C IN('260','720'))
GROUP BY   C.LAF_CD
       ,C.LAF_NM
       ,C.ACNT_DV_CD
       ,C.ACNT_DV_MSTR_CD
       ,C.ACNT_DV_MSTR_NM
       ,C.ACNT_DV_NM
       ,C.GONGGEUM_GYEJWA
       ,C.FYR
       ,B.SIGUMGO_ORG_C
       ,B.ICH_SIGUMGO_GUN_GU_C
       ,B.SIGUMGO_HOIKYE_YR
) SELECT
      A.SIGUMGO_ORG_C,
      A.FIL_100_CTNT5 AS GONGGEUM_GYEJWA,
      MAX(A.TRXDT) AS MAX_TRXDT,
      D.BAS_DT AS TRXDT,
      MAX(A.LINKAC_TRX_NO) AS MAX_TRX_NO
  FROM  ACL_SIGUMGO_SLV A
            INNER JOIN BATCH_PARAM D ON 1=1
  WHERE 1=1
    AND A.SIGUMGO_ORG_C = D.GEUMGO_CODE
    AND A.FIL_100_CTNT5 IN (
      SELECT GONGGEUM_GYEJWA FROM GYEJWA
  )
    AND A.TRXDT BETWEEN  (D.HOIKYE_YR ||'0101') AND D.BAS_DT
  GROUP BY A.SIGUMGO_ORG_C ,
           D.BAS_DT,
           A.FIL_100_CTNT5

  --------------------------------------------------------------------------------

      WITH BATCH_PARAM AS (
            SELECT
                'AAAA' AS GOF_CD,
                'AAAA' AS GOF_NM,
                28 AS GEUMGO_CODE,
                '20240230' AS BAS_DT,
                TO_NUMBER(2023) AS  BEF_HOIKYE_YR,
                TO_NUMBER(2024) AS HOIKYE_YR
            FROM DUAL
        ),
             UNYONG_JAN AS (
                 SELECT
                     A.HOIKYE_YR,
                     A.GONGGEUM_GYEJWA,
                     SUM(A.JANAEK) AS JANAEK
                 FROM
                     (
                         -- 당해년도 YY 와 99 계좌
                         SELECT /*+ HINTA */
                             D.HOIKYE_YR AS HOIKYE_YR,
                             CASE
                                 WHEN B.SIGUMGO_HOIKYE_YR <> 9999 THEN SUBSTR(A.GONGGEUM_GYEJWA, 0, 15) || SUBSTR((D.HOIKYE_YR), 3, 2)
                                 ELSE A.GONGGEUM_GYEJWA END AS GONGGEUM_GYEJWA,
                             SUM(A.JANAEK) AS JANAEK
                         FROM RPT_UNYONG_JAN A
                                  INNER JOIN ACL_SIGUMGO_MAS B ON B.FIL_100_CTNT2 = A.GONGGEUM_GYEJWA
                                  INNER JOIN BATCH_PARAM D ON 1=1
                         WHERE 1=1
                           AND B.MNG_NO = 1
                           AND A.KIJUNIL = (SELECT CASE WHEN DT_G = 0 THEN BIZ_DT ELSE BF1_BIZ_DT END AS BIZ_DT  FROM MAP_JOB_DATE WHERE DW_BAS_DDT = D.HOIKYE_YR -1 || 1231)
                           AND A.JANAEK > 0
                           AND A.GEUMGO_CODE = D.GEUMGO_CODE
                           AND NOT (B.SIGUMGO_ORG_C = 28 AND B.ICH_SIGUMGO_GUN_GU_C = '000')
                         GROUP BY D.HOIKYE_YR, A.GONGGEUM_GYEJWA, B.SIGUMGO_HOIKYE_YR, D.HOIKYE_YR
                         -- 전년도 YY -1 계좌 99 는 제외
                         UNION ALL
                         SELECT /*+ HINTA */
                             D.BEF_HOIKYE_YR AS HOIKYE_YR,
                             CASE
                                 WHEN B.SIGUMGO_HOIKYE_YR <> 9999 THEN SUBSTR(A.GONGGEUM_GYEJWA, 0, 15) || SUBSTR((D.BEF_HOIKYE_YR), 3, 2)
                                 ELSE A.GONGGEUM_GYEJWA END AS GONGGEUM_GYEJWA,
                             SUM(A.JANAEK) AS JANAEK
                         FROM RPT_UNYONG_JAN A
                                  INNER JOIN ACL_SIGUMGO_MAS B ON B.FIL_100_CTNT2 = A.GONGGEUM_GYEJWA
                                  INNER JOIN BATCH_PARAM D ON 1=1
                         WHERE 1=1
                           AND B.SIGUMGO_HOIKYE_YR <> 9999
                           AND B.MNG_NO = 1
                           AND A.KIJUNIL = (SELECT CASE WHEN DT_G = 0 THEN BIZ_DT ELSE BF1_BIZ_DT END AS BIZ_DT  FROM MAP_JOB_DATE WHERE DW_BAS_DDT = D.BEF_HOIKYE_YR - 1 || 1231)
                           AND A.JANAEK > 0
                           AND A.GEUMGO_CODE = D.GEUMGO_CODE
                           AND NOT (B.SIGUMGO_ORG_C = 28 AND B.ICH_SIGUMGO_GUN_GU_C = '000')
                         GROUP BY D.BEF_HOIKYE_YR, A.GONGGEUM_GYEJWA, B.SIGUMGO_HOIKYE_YR, D.BEF_HOIKYE_YR
                     ) A
                 GROUP BY  A.HOIKYE_YR, A.GONGGEUM_GYEJWA
                 ORDER BY  A.HOIKYE_YR, A.GONGGEUM_GYEJWA
             ),
             GONGGEUM_JAN AS (
                 -- 99 계좌일만 공금잔액 이월해 오기
                 SELECT /*+ HINTB */
                     D.HOIKYE_YR,
                     A.GONGGEUM_GYEJWA,
                     A.JANAEK
                 FROM RPT_GONGGEUM_JAN A
                          INNER JOIN BATCH_PARAM D ON 1=1
                 WHERE 1=1
                   -- 공금잔액 이월은 2금고만 적용(인천 제외)
                   AND A.GEUMGO_CODE <> 28
                   AND A.KEORAEIL = D.BEF_HOIKYE_YR || 1231
                   AND A.GEUMGO_CODE = D.GEUMGO_CODE
                   AND A.HOIGYE_YEAR = 9999
                   AND A.GONGGEUM_GYEJWA IN (
                     SELECT GONGGEUM_GYEJWA
                     FROM RPT_FISG_INFO_MAP
                     WHERE FYR IN ( D.BEF_HOIKYE_YR, D.HOIKYE_YR)
                       AND USE_YN = 'Y'
                 )
             ),
             MI_JAN AS (
                 SELECT C.GONGGEUM_GYEJWA,
                        SUM(DECODE(A.CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(A.IPJI_G, 2, -1, 1) * A.TRAMT) AS JANAEK
                 FROM ACL_SIGUMGO_SLV A
                          INNER JOIN ACL_SIGUMGO_MAS B ON B.MNG_NO = 1 AND A.SIGUMGO_ORG_C = B.SIGUMGO_ORG_C AND A.FIL_100_CTNT5 = B.FIL_100_CTNT2
                          INNER JOIN RPT_FISG_INFO_MAP C ON C.USE_YN = 'Y' AND C.GONGGEUM_GYEJWA = B.FIL_100_CTNT2
                          LEFT OUTER JOIN SFI_CMM_C_DAT E ON E.CMM_C_NM = 'RPT자치단체코드분류' AND E.USE_YN = 'Y' AND E.CMM_DTL_C = C.LAF_CD
                          INNER JOIN BATCH_PARAM D ON 1=1
                 WHERE 1=1
                   AND A.SIGUMGO_ORG_C = D.GEUMGO_CODE
                   AND C.FYR IN ( D.BEF_HOIKYE_YR, D.HOIKYE_YR)
                   AND NVL(A.GISDT, A.TRXDT) BETWEEN D.BEF_HOIKYE_YR || '0101' AND D.BAS_DT
                   AND LPAD(A.SIGUMGO_TRX_G,2,'0')||LPAD(A.SIGUMGO_IP_TRX_G,2,'0')||LPAD(A.SIGUMGO_JI_TRX_G,2,'0') NOT IN (SELECT CMM_DTL_C FROM SFI_CMM_C_DAT WHERE CMM_C_NM = '이호조세입세출송신용' AND USE_YN = 'Y')
                   AND NOT (A.SIGUMGO_ORG_C = 28 AND A.ICH_SIGUMGO_GUN_GU_C IN('260','720'))
                 GROUP BY C.GONGGEUM_GYEJWA
             ),
             GYEJWA AS (
                 SELECT
                     C.LAF_CD
                      ,C.LAF_NM
                      ,C.ACNT_DV_CD
                      ,C.ACNT_DV_MSTR_CD
                      ,C.ACNT_DV_MSTR_NM
                      ,C.ACNT_DV_NM
                      ,C.GONGGEUM_GYEJWA
                      ,C.FYR
                      ,B.SIGUMGO_ORG_C
                      ,B.ICH_SIGUMGO_GUN_GU_C
                      ,B.SIGUMGO_HOIKYE_YR
                      ,G.JANAEK AS UNYONG_JANAEK
                      ,H.JANAEK AS GONGGEUM_JANAEK
                      ,I.JANAEK AS MI_JANAEK
                 FROM RPT_FISG_INFO_MAP C
                          INNER JOIN BATCH_PARAM D ON 1=1
                          LEFT OUTER JOIN ACL_SIGUMGO_MAS B ON B.SIGUMGO_ORG_C = D.GEUMGO_CODE AND B.MNG_NO = 1 AND C.GONGGEUM_GYEJWA = B.FIL_100_CTNT2
                     -- 자치단체분류코드는 LAF_CD 단위로 하나이다
                          LEFT OUTER JOIN  SFI_CMM_C_DAT E ON E.CMM_C_NM = 'RPT자치단체코드분류' AND E.USE_YN = 'Y'AND C.LAF_CD = E.CMM_DTL_C
                          LEFT OUTER JOIN UNYONG_JAN G ON C.GONGGEUM_GYEJWA = G.GONGGEUM_GYEJWA
                          LEFT OUTER JOIN GONGGEUM_JAN H ON C.GONGGEUM_GYEJWA = H.GONGGEUM_GYEJWA
                          LEFT OUTER JOIN MI_JAN I ON C.GONGGEUM_GYEJWA = I.GONGGEUM_GYEJWA
                 WHERE 1=1
                   AND C.USE_YN = 'Y'
                   AND C.FYR IN ( D.BEF_HOIKYE_YR, D.HOIKYE_YR)
                   -- 99 계좌 중복 조회 제거
                   -- AND NOT (C.FYR = D.BEF_HOIKYE_YR AND C.GONGGEUM_GYEJWA LIKE '%99')
                   AND NOT (B.SIGUMGO_ORG_C = 28 AND B.ICH_SIGUMGO_GUN_GU_C IN('260','720'))
                 GROUP BY   C.LAF_CD
                        ,C.LAF_NM
                        ,C.ACNT_DV_CD
                        ,C.ACNT_DV_MSTR_CD
                        ,C.ACNT_DV_MSTR_NM
                        ,C.ACNT_DV_NM
                        ,C.GONGGEUM_GYEJWA
                        ,C.FYR
                        ,B.SIGUMGO_ORG_C
                        ,B.ICH_SIGUMGO_GUN_GU_C
                        ,B.SIGUMGO_HOIKYE_YR
                        ,G.JANAEK
                        ,H.JANAEK
                        ,I.JANAEK
             ) SELECT
                     A.SIGUMGO_ORG_C AS SIGUMGO_ORG_C,
                     A.ICH_SIGUMGO_GUN_GU_C,
                     A.ICH_SIGUMGO_HOIKYE_C,
                     A.SIGUMGO_HOIKYE_YR,
                     A.FIL_100_CTNT5 AS GONGGEUM_GYEJWA,
                     A.TRXNO,
                     A.TRXDT,
                     A.GISDT,
                     NVL(A.GISDT, A.TRXDT) AS REPORT_DATE,
                     (A.TRAMT * DECODE(A.IPJI_G, 2, -1, 1) * DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)) AS TRAMT,
                     F.HRNK_CMM_C_NM ,
                     F.HRNK_CMM_DTL_C
               FROM  ACL_SIGUMGO_SLV A
                         LEFT OUTER JOIN SFI_CMM_C_DAT F ON F.CMM_C_NM = '이호조세입세출송신용' AND F.USE_YN = 'Y'
                         INNER JOIN BATCH_PARAM D ON 1=1
               WHERE 1=1
                 AND A.SIGUMGO_ORG_C = D.GEUMGO_CODE
                 AND A.FIL_100_CTNT5 = '02800001210000023'
                 AND NOT (A.SIGUMGO_ORG_C = 28 AND A.ICH_SIGUMGO_GUN_GU_C IN('260','720'))
                 -- 시작일은 당해년도 1월1일 추가?
                 AND NVL(A.GISDT, A.TRXDT) BETWEEN (D.BEF_HOIKYE_YR || '0101') AND  D.BAS_DT
                 -- 99회계의 거래내역은 당해년도만 계산(99회계는 공금잔에서 전년도 잔액 계산)
                 AND NOT (A.SIGUMGO_HOIKYE_YR = 9999 AND NVL(A.GISDT, A.TRXDT) < D.HOIKYE_YR || '0101')
                 -- 2금고인(인천제외) 경우에 99회계의 10, 60 이월입지급거래내역 제외
                 AND NOT (
                   A.SIGUMGO_ORG_C <> 28
                       AND
                   A.SIGUMGO_HOIKYE_YR = 9999
                       AND
                   LPAD(A.SIGUMGO_TRX_G,2,'0')||LPAD(A.SIGUMGO_IP_TRX_G,2,'0')||LPAD(A.SIGUMGO_JI_TRX_G,2,'0') IN ('100000', '600000')
                   )
                 AND F.CMM_DTL_C = LPAD(A.SIGUMGO_TRX_G,2,'0')||LPAD(A.SIGUMGO_IP_TRX_G,2,'0')||LPAD(A.SIGUMGO_JI_TRX_G,2,'0')

--------------------------------------------------------------------
-- 02800075690000024 20250224 에 잔액이 실잔액이 0원임에도 세입세출일계표는 5,000,000,000 으로 조회됨
-- 세입누계: 59641114097, 세출누계: 1090839290, 자금운용누계: 53550274807
-- 59641114097	1090839290	53550274807

WITH BATCH_PARAM AS (
            SELECT
                'AAAA' AS GOF_CD,
                'AAAA' AS GOF_NM,
                28 AS GEUMGO_CODE,
                '20250224' AS BAS_DT,
                TO_NUMBER(2024) AS  BEF_HOIKYE_YR,
                TO_NUMBER(2025) AS HOIKYE_YR
            FROM DUAL
        )
SELECT /*+  INDEX(A RPT_UNYONG_JAN_UK_02) */
    D.BEF_HOIKYE_YR AS HOIKYE_YR,
    CASE
        WHEN B.SIGUMGO_HOIKYE_YR <> 9999 THEN SUBSTR(A.GONGGEUM_GYEJWA, 0, 15) || SUBSTR((D.BEF_HOIKYE_YR), 3, 2)
        ELSE A.GONGGEUM_GYEJWA END AS GONGGEUM_GYEJWA,
    SUM(A.JANAEK) AS JANAEK
FROM RPT_UNYONG_JAN A
         INNER JOIN ACL_SIGUMGO_MAS B ON B.FIL_100_CTNT2 = A.GONGGEUM_GYEJWA
         INNER JOIN BATCH_PARAM D ON 1=1
WHERE 1=1
  AND B.FIL_100_CTNT2 = '02800075690000024'
  AND B.SIGUMGO_HOIKYE_YR <> 9999
  AND B.MNG_NO = 1
  AND A.KIJUNIL = (SELECT CASE WHEN DT_G = 0 THEN BIZ_DT ELSE BF1_BIZ_DT END AS BIZ_DT  FROM MAP_JOB_DATE WHERE DW_BAS_DDT = D.BEF_HOIKYE_YR - 1 || 1231)
  AND A.JANAEK > 0
  AND A.GEUMGO_CODE = D.GEUMGO_CODE
  AND NOT (B.SIGUMGO_ORG_C = 28 AND B.ICH_SIGUMGO_GUN_GU_C = '000')
GROUP BY D.BEF_HOIKYE_YR, A.GONGGEUM_GYEJWA, B.SIGUMGO_HOIKYE_YR, D.BEF_HOIKYE_YR

SELECT CASE WHEN DT_G = 0 THEN BIZ_DT ELSE BF1_BIZ_DT END AS BIZ_DT  FROM MAP_JOB_DATE WHERE DW_BAS_DDT = 2024 - 1 || 1231

-------------------------------------------------------

SELECT
    *
FROM RPT_UNYONG_JAN
WHERE 1=1
AND GONGGEUM_GYEJWA = '02800075690000024'
AND KIJUNIL = (SELECT CASE WHEN DT_G = 0 THEN BIZ_DT ELSE BF1_BIZ_DT END AS BIZ_DT  FROM MAP_JOB_DATE WHERE DW_BAS_DDT = 2024 - 1 || 1231)

------------------------------------------------------
    WITH BATCH_PARAM AS (
            SELECT
                'AAAA' AS GOF_CD,
                'AAAA' AS GOF_NM,
                28 AS GEUMGO_CODE,
                '20250224' AS BAS_DT,
                TO_NUMBER(2024) AS  BEF_HOIKYE_YR,
                TO_NUMBER(2025) AS HOIKYE_YR
            FROM DUAL
        ),
             UNYONG_JAN AS (
                 SELECT
                     A.HOIKYE_YR,
                     A.GONGGEUM_GYEJWA,
                     SUM(A.JANAEK) AS JANAEK
                 FROM
                     (
                         -- 당해년도 YY 와 99 계좌
                         SELECT /*+ INDEX(A RPT_UNYONG_JAN_UK_02) */
                             D.HOIKYE_YR AS HOIKYE_YR,
                             CASE
                                 WHEN B.SIGUMGO_HOIKYE_YR <> 9999 THEN SUBSTR(A.GONGGEUM_GYEJWA, 0, 15) || SUBSTR((D.HOIKYE_YR), 3, 2)
                                 ELSE A.GONGGEUM_GYEJWA END AS GONGGEUM_GYEJWA,
                             SUM(A.JANAEK) AS JANAEK
                         FROM RPT_UNYONG_JAN A
                                  INNER JOIN ACL_SIGUMGO_MAS B ON B.FIL_100_CTNT2 = A.GONGGEUM_GYEJWA
                                  INNER JOIN BATCH_PARAM D ON 1=1
                         WHERE 1=1
                           AND B.MNG_NO = 1
                           AND A.KIJUNIL = (SELECT CASE WHEN DT_G = 0 THEN BIZ_DT ELSE BF1_BIZ_DT END AS BIZ_DT  FROM MAP_JOB_DATE WHERE DW_BAS_DDT = D.HOIKYE_YR -1 || 1231)
                           AND A.JANAEK > 0
                           AND A.GEUMGO_CODE = D.GEUMGO_CODE
                           AND NOT (B.SIGUMGO_ORG_C = 28 AND B.ICH_SIGUMGO_GUN_GU_C = '000')
                         GROUP BY D.HOIKYE_YR, A.GONGGEUM_GYEJWA, B.SIGUMGO_HOIKYE_YR, D.HOIKYE_YR
                         -- 전년도 YY -1 계좌 99 는 제외
                         UNION ALL
                         SELECT /*+  INDEX(A RPT_UNYONG_JAN_UK_02) */
                             D.BEF_HOIKYE_YR AS HOIKYE_YR,
                             CASE
                                 WHEN B.SIGUMGO_HOIKYE_YR <> 9999 THEN SUBSTR(A.GONGGEUM_GYEJWA, 0, 15) || SUBSTR((D.BEF_HOIKYE_YR), 3, 2)
                                 ELSE A.GONGGEUM_GYEJWA END AS GONGGEUM_GYEJWA,
                             SUM(A.JANAEK) AS JANAEK
                         FROM RPT_UNYONG_JAN A
                                  INNER JOIN ACL_SIGUMGO_MAS B ON B.FIL_100_CTNT2 = A.GONGGEUM_GYEJWA
                                  INNER JOIN BATCH_PARAM D ON 1=1
                         WHERE 1=1
                           AND B.SIGUMGO_HOIKYE_YR <> 9999
                           AND B.MNG_NO = 1
                           AND A.KIJUNIL = (SELECT CASE WHEN DT_G = 0 THEN BIZ_DT ELSE BF1_BIZ_DT END AS BIZ_DT  FROM MAP_JOB_DATE WHERE DW_BAS_DDT = D.BEF_HOIKYE_YR - 1 || 1231)
                           AND A.JANAEK > 0
                           AND A.GEUMGO_CODE = D.GEUMGO_CODE
                           AND NOT (B.SIGUMGO_ORG_C = 28 AND B.ICH_SIGUMGO_GUN_GU_C = '000')
                         GROUP BY D.BEF_HOIKYE_YR, A.GONGGEUM_GYEJWA, B.SIGUMGO_HOIKYE_YR, D.BEF_HOIKYE_YR
                     ) A
                 GROUP BY  A.HOIKYE_YR, A.GONGGEUM_GYEJWA
                 ORDER BY  A.HOIKYE_YR, A.GONGGEUM_GYEJWA
             ),
             GONGGEUM_JAN AS (
                 -- 99 계좌일만 공금잔액 이월해 오기
                 SELECT /*+ INDEX(A RPT_GONGGEUM_JAN_IX_01) */
                     D.HOIKYE_YR,
                     A.GONGGEUM_GYEJWA,
                     A.JANAEK
                 FROM RPT_GONGGEUM_JAN A
                 INNER JOIN BATCH_PARAM D ON 1=1
                 WHERE 1=1
                   -- 공금잔액 이월은 2금고만 적용(인천 제외)
                   AND A.GEUMGO_CODE <> 28
                   AND A.KEORAEIL = D.BEF_HOIKYE_YR || 1231
                   AND A.GEUMGO_CODE = D.GEUMGO_CODE
                   AND A.HOIGYE_YEAR = 9999
                   AND A.GONGGEUM_GYEJWA IN (
                     SELECT GONGGEUM_GYEJWA
                     FROM RPT_FISG_INFO_MAP
                     WHERE FYR IN ( D.BEF_HOIKYE_YR, D.HOIKYE_YR)
                       AND USE_YN = 'Y'
                 )
             ),
             MI_JAN AS (
                 SELECT C.FYR AS HOIKYE_YR,
                        C.GONGGEUM_GYEJWA,
                        SUM(DECODE(A.CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(A.IPJI_G, 2, -1, 1) * A.TRAMT) AS JANAEK
                 FROM ACL_SIGUMGO_SLV A
                          INNER JOIN ACL_SIGUMGO_MAS B ON B.MNG_NO = 1 AND A.SIGUMGO_ORG_C = B.SIGUMGO_ORG_C AND A.FIL_100_CTNT5 = B.FIL_100_CTNT2
                          INNER JOIN RPT_FISG_INFO_MAP C ON C.USE_YN = 'Y' AND C.GONGGEUM_GYEJWA = B.FIL_100_CTNT2
                          LEFT OUTER JOIN SFI_CMM_C_DAT E ON E.CMM_C_NM = 'RPT자치단체코드분류' AND E.USE_YN = 'Y' AND E.CMM_DTL_C = C.LAF_CD
                          INNER JOIN BATCH_PARAM D ON 1=1
                 WHERE 1=1
                   AND A.SIGUMGO_ORG_C = D.GEUMGO_CODE
                   AND C.FYR = D.HOIKYE_YR
                   AND NVL(A.GISDT, A.TRXDT) BETWEEN D.HOIKYE_YR || '0101' AND D.BAS_DT
                   AND LPAD(A.SIGUMGO_TRX_G,2,'0')||LPAD(A.SIGUMGO_IP_TRX_G,2,'0')||LPAD(A.SIGUMGO_JI_TRX_G,2,'0') NOT IN (SELECT CMM_DTL_C FROM SFI_CMM_C_DAT WHERE CMM_C_NM = '이호조세입세출송신용' AND USE_YN = 'Y')
                   AND NOT (A.SIGUMGO_ORG_C = 28 AND A.ICH_SIGUMGO_GUN_GU_C IN('260','720'))
                 GROUP BY C.FYR, C.GONGGEUM_GYEJWA
                 UNION ALL
                 SELECT C.FYR AS HOIKYE_YR,
                     C.GONGGEUM_GYEJWA,
                        SUM(DECODE(A.CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(A.IPJI_G, 2, -1, 1) * A.TRAMT) AS JANAEK
                 FROM ACL_SIGUMGO_SLV A
                          INNER JOIN ACL_SIGUMGO_MAS B ON B.MNG_NO = 1 AND A.SIGUMGO_ORG_C = B.SIGUMGO_ORG_C AND A.FIL_100_CTNT5 = B.FIL_100_CTNT2
                          INNER JOIN RPT_FISG_INFO_MAP C ON C.USE_YN = 'Y' AND C.GONGGEUM_GYEJWA = B.FIL_100_CTNT2
                          LEFT OUTER JOIN SFI_CMM_C_DAT E ON E.CMM_C_NM = 'RPT자치단체코드분류' AND E.USE_YN = 'Y' AND E.CMM_DTL_C = C.LAF_CD
                          INNER JOIN BATCH_PARAM D ON 1=1
                 WHERE 1=1
                   AND A.SIGUMGO_ORG_C = D.GEUMGO_CODE
                   AND C.FYR = D.BEF_HOIKYE_YR
                   AND NVL(A.GISDT, A.TRXDT) BETWEEN D.BEF_HOIKYE_YR || '0101' AND D.BEF_HOIKYE_YR || '1231'
                   AND LPAD(A.SIGUMGO_TRX_G,2,'0')||LPAD(A.SIGUMGO_IP_TRX_G,2,'0')||LPAD(A.SIGUMGO_JI_TRX_G,2,'0') NOT IN (SELECT CMM_DTL_C FROM SFI_CMM_C_DAT WHERE CMM_C_NM = '이호조세입세출송신용' AND USE_YN = 'Y')
                   AND NOT (A.SIGUMGO_ORG_C = 28 AND A.ICH_SIGUMGO_GUN_GU_C IN('260','720'))
                 GROUP BY C.FYR, C.GONGGEUM_GYEJWA
             ),
             GYEJWA AS (
                 SELECT
                     C.LAF_CD
                      ,C.LAF_NM
                      ,C.ACNT_DV_CD
                      ,C.ACNT_DV_MSTR_CD
                      ,C.ACNT_DV_MSTR_NM
                      ,C.ACNT_DV_NM
                      ,C.GONGGEUM_GYEJWA
                      ,C.FYR
                      ,B.SIGUMGO_ORG_C
                      ,B.ICH_SIGUMGO_GUN_GU_C
                      ,B.SIGUMGO_HOIKYE_YR
                      ,G.JANAEK AS UNYONG_JANAEK
                      ,H.JANAEK AS GONGGEUM_JANAEK
                      ,I.JANAEK AS MI_JANAEK
                 FROM RPT_FISG_INFO_MAP C
                          INNER JOIN BATCH_PARAM D ON 1=1
                          LEFT OUTER JOIN ACL_SIGUMGO_MAS B ON B.SIGUMGO_ORG_C = D.GEUMGO_CODE AND B.MNG_NO = 1 AND C.GONGGEUM_GYEJWA = B.FIL_100_CTNT2
                     -- 자치단체분류코드는 LAF_CD 단위로 하나이다
                          LEFT OUTER JOIN  SFI_CMM_C_DAT E ON E.CMM_C_NM = 'RPT자치단체코드분류' AND E.USE_YN = 'Y'AND C.LAF_CD = E.CMM_DTL_C
                          LEFT OUTER JOIN UNYONG_JAN G ON C.GONGGEUM_GYEJWA = G.GONGGEUM_GYEJWA AND C.FYR = G.HOIKYE_YR
                          LEFT OUTER JOIN GONGGEUM_JAN H ON C.GONGGEUM_GYEJWA = H.GONGGEUM_GYEJWA AND C.FYR = H.HOIKYE_YR
                          LEFT OUTER JOIN MI_JAN I ON C.GONGGEUM_GYEJWA = I.GONGGEUM_GYEJWA AND C.FYR = I.HOIKYE_YR
                 WHERE 1=1
                   AND C.USE_YN = 'Y'
                   AND C.FYR IN ( D.BEF_HOIKYE_YR, D.HOIKYE_YR)
                   -- 99 계좌 중복 조회 제거
                   -- AND NOT (C.FYR = D.BEF_HOIKYE_YR AND C.GONGGEUM_GYEJWA LIKE '%99')
                   AND NOT (B.SIGUMGO_ORG_C = 28 AND B.ICH_SIGUMGO_GUN_GU_C IN('260','720'))
                 GROUP BY   C.LAF_CD
                        ,C.LAF_NM
                        ,C.ACNT_DV_CD
                        ,C.ACNT_DV_MSTR_CD
                        ,C.ACNT_DV_MSTR_NM
                        ,C.ACNT_DV_NM
                        ,C.GONGGEUM_GYEJWA
                        ,C.FYR
                        ,B.SIGUMGO_ORG_C
                        ,B.ICH_SIGUMGO_GUN_GU_C
                        ,B.SIGUMGO_HOIKYE_YR
                        ,G.JANAEK
                        ,H.JANAEK
                        ,I.JANAEK
             )
SELECT
    A.SIGUMGO_ORG_C AS SIGUMGO_ORG_C,
    A.ICH_SIGUMGO_GUN_GU_C,
    A.ICH_SIGUMGO_HOIKYE_C,
    CASE WHEN A.SIGUMGO_HOIKYE_YR = 9999 THEN SUBSTR(NVL(A.GISDT, A.TRXDT), 0, 4) ELSE A.SIGUMGO_HOIKYE_YR END AS SIGUMGO_HOIKYE_YR ,
    A.FIL_100_CTNT5 AS GONGGEUM_GYEJWA,
    A.TRXNO,
    A.TRXDT,
    A.GISDT,
    NVL(A.GISDT, A.TRXDT) AS REPORT_DATE,
    (A.TRAMT * DECODE(A.IPJI_G, 2, -1, 1) * DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)) AS TRAMT,
    F.HRNK_CMM_C_NM ,
    F.HRNK_CMM_DTL_C
FROM  ACL_SIGUMGO_SLV A
          LEFT OUTER JOIN SFI_CMM_C_DAT F ON F.CMM_C_NM = '이호조세입세출송신용' AND F.USE_YN = 'Y'
          INNER JOIN BATCH_PARAM D ON 1=1
WHERE 1=1
  AND A.SIGUMGO_ORG_C = D.GEUMGO_CODE
  AND A.FIL_100_CTNT5 = '02800075690000024'
  AND NOT (A.SIGUMGO_ORG_C = 28 AND A.ICH_SIGUMGO_GUN_GU_C IN('260','720'))
  -- 시작일은 당해년도 1월1일 추가?
  AND NVL(A.GISDT, A.TRXDT) BETWEEN (D.BEF_HOIKYE_YR || '0101') AND  D.BAS_DT
  -- 99회계의 거래내역은 당해년도만 계산(99회계는 공금잔에서 전년도 잔액 계산)
  AND NOT (A.SIGUMGO_HOIKYE_YR = 9999 AND NVL(A.GISDT, A.TRXDT) < D.HOIKYE_YR || '0101')
  -- 2금고인(인천제외) 경우에 99회계의 10, 60 이월입지급거래내역 제외
  AND NOT (
    A.SIGUMGO_ORG_C <> 28
        AND
    A.SIGUMGO_HOIKYE_YR = 9999
        AND
    LPAD(A.SIGUMGO_TRX_G,2,'0')||LPAD(A.SIGUMGO_IP_TRX_G,2,'0')||LPAD(A.SIGUMGO_JI_TRX_G,2,'0') IN ('100000', '600000')
    )
  AND F.CMM_DTL_C = LPAD(A.SIGUMGO_TRX_G,2,'0')||LPAD(A.SIGUMGO_IP_TRX_G,2,'0')||LPAD(A.SIGUMGO_JI_TRX_G,2,'0')

-- 02811035230000024

    WITH BATCH_PARAM AS (
            SELECT
                'AAAA' AS GOF_CD,
                'AAAA' AS GOF_NM,
                28 AS GEUMGO_CODE,
                '20250224' AS BAS_DT,
                TO_NUMBER(2024) AS  BEF_HOIKYE_YR,
                TO_NUMBER(2025) AS HOIKYE_YR
            FROM DUAL
        ),
             UNYONG_JAN AS (
                 SELECT
                     A.HOIKYE_YR,
                     A.GONGGEUM_GYEJWA,
                     SUM(A.JANAEK) AS JANAEK
                 FROM
                     (
                         -- 당해년도 YY 와 99 계좌
                         SELECT /*+ INDEX(A RPT_UNYONG_JAN_UK_02) */
                             D.HOIKYE_YR AS HOIKYE_YR,
                             CASE
                                 WHEN B.SIGUMGO_HOIKYE_YR <> 9999 THEN SUBSTR(A.GONGGEUM_GYEJWA, 0, 15) || SUBSTR((D.HOIKYE_YR), 3, 2)
                                 ELSE A.GONGGEUM_GYEJWA END AS GONGGEUM_GYEJWA,
                             SUM(A.JANAEK) AS JANAEK
                         FROM RPT_UNYONG_JAN A
                                  INNER JOIN ACL_SIGUMGO_MAS B ON B.FIL_100_CTNT2 = A.GONGGEUM_GYEJWA
                                  INNER JOIN BATCH_PARAM D ON 1=1
                         WHERE 1=1
                           AND B.MNG_NO = 1
                           AND A.KIJUNIL = (SELECT CASE WHEN DT_G = 0 THEN BIZ_DT ELSE BF1_BIZ_DT END AS BIZ_DT  FROM MAP_JOB_DATE WHERE DW_BAS_DDT = D.HOIKYE_YR -1 || 1231)
                           AND A.JANAEK > 0
                           AND A.GEUMGO_CODE = D.GEUMGO_CODE
                           AND NOT (B.SIGUMGO_ORG_C = 28 AND B.ICH_SIGUMGO_GUN_GU_C = '000')
                         GROUP BY D.HOIKYE_YR, A.GONGGEUM_GYEJWA, B.SIGUMGO_HOIKYE_YR, D.HOIKYE_YR
                         -- 전년도 YY -1 계좌 99 는 제외
                         UNION ALL
                         SELECT /*+  INDEX(A RPT_UNYONG_JAN_UK_02) */
                             D.BEF_HOIKYE_YR AS HOIKYE_YR,
                             CASE
                                 WHEN B.SIGUMGO_HOIKYE_YR <> 9999 THEN SUBSTR(A.GONGGEUM_GYEJWA, 0, 15) || SUBSTR((D.BEF_HOIKYE_YR), 3, 2)
                                 ELSE A.GONGGEUM_GYEJWA END AS GONGGEUM_GYEJWA,
                             SUM(A.JANAEK) AS JANAEK
                         FROM RPT_UNYONG_JAN A
                                  INNER JOIN ACL_SIGUMGO_MAS B ON B.FIL_100_CTNT2 = A.GONGGEUM_GYEJWA
                                  INNER JOIN BATCH_PARAM D ON 1=1
                         WHERE 1=1
                           AND B.SIGUMGO_HOIKYE_YR <> 9999
                           AND B.MNG_NO = 1
                           AND A.KIJUNIL = (SELECT CASE WHEN DT_G = 0 THEN BIZ_DT ELSE BF1_BIZ_DT END AS BIZ_DT  FROM MAP_JOB_DATE WHERE DW_BAS_DDT = D.BEF_HOIKYE_YR - 1 || 1231)
                           AND A.JANAEK > 0
                           AND A.GEUMGO_CODE = D.GEUMGO_CODE
                           AND NOT (B.SIGUMGO_ORG_C = 28 AND B.ICH_SIGUMGO_GUN_GU_C = '000')
                         GROUP BY D.BEF_HOIKYE_YR, A.GONGGEUM_GYEJWA, B.SIGUMGO_HOIKYE_YR, D.BEF_HOIKYE_YR
                     ) A
                 GROUP BY  A.HOIKYE_YR, A.GONGGEUM_GYEJWA
                 ORDER BY  A.HOIKYE_YR, A.GONGGEUM_GYEJWA
             ),
             GONGGEUM_JAN AS (
                 -- 99 계좌일만 공금잔액 이월해 오기
                 SELECT /*+ INDEX(A RPT_GONGGEUM_JAN_IX_01) */
                     D.HOIKYE_YR,
                     A.GONGGEUM_GYEJWA,
                     A.JANAEK
                 FROM RPT_GONGGEUM_JAN A
                 INNER JOIN BATCH_PARAM D ON 1=1
                 WHERE 1=1
                   -- 공금잔액 이월은 2금고만 적용(인천 제외)
                   AND A.GEUMGO_CODE <> 28
                   AND A.KEORAEIL = D.BEF_HOIKYE_YR || 1231
                   AND A.GEUMGO_CODE = D.GEUMGO_CODE
                   AND A.HOIGYE_YEAR = 9999
                   AND A.GONGGEUM_GYEJWA IN (
                     SELECT GONGGEUM_GYEJWA
                     FROM RPT_FISG_INFO_MAP
                     WHERE FYR IN ( D.BEF_HOIKYE_YR, D.HOIKYE_YR)
                       AND USE_YN = 'Y'
                 )
             ),
             MI_JAN AS (
                 SELECT C.FYR AS HOIKYE_YR,
                        C.GONGGEUM_GYEJWA,
                        SUM(DECODE(A.CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(A.IPJI_G, 2, -1, 1) * A.TRAMT) AS JANAEK
                 FROM ACL_SIGUMGO_SLV A
                          INNER JOIN ACL_SIGUMGO_MAS B ON B.MNG_NO = 1 AND A.SIGUMGO_ORG_C = B.SIGUMGO_ORG_C AND A.FIL_100_CTNT5 = B.FIL_100_CTNT2
                          INNER JOIN RPT_FISG_INFO_MAP C ON C.USE_YN = 'Y' AND C.GONGGEUM_GYEJWA = B.FIL_100_CTNT2
                          LEFT OUTER JOIN SFI_CMM_C_DAT E ON E.CMM_C_NM = 'RPT자치단체코드분류' AND E.USE_YN = 'Y' AND E.CMM_DTL_C = C.LAF_CD
                          INNER JOIN BATCH_PARAM D ON 1=1
                 WHERE 1=1
                   AND A.SIGUMGO_ORG_C = D.GEUMGO_CODE
                   AND C.FYR = D.HOIKYE_YR
                   AND NVL(A.GISDT, A.TRXDT) BETWEEN D.HOIKYE_YR || '0101' AND D.BAS_DT
                   AND LPAD(A.SIGUMGO_TRX_G,2,'0')||LPAD(A.SIGUMGO_IP_TRX_G,2,'0')||LPAD(A.SIGUMGO_JI_TRX_G,2,'0') NOT IN (SELECT CMM_DTL_C FROM SFI_CMM_C_DAT WHERE CMM_C_NM = '이호조세입세출송신용' AND USE_YN = 'Y')
                   AND NOT (A.SIGUMGO_ORG_C = 28 AND A.ICH_SIGUMGO_GUN_GU_C IN('260','720'))
                 GROUP BY C.FYR, C.GONGGEUM_GYEJWA
                 UNION ALL
                 SELECT C.FYR AS HOIKYE_YR,
                     C.GONGGEUM_GYEJWA,
                        SUM(DECODE(A.CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(A.IPJI_G, 2, -1, 1) * A.TRAMT) AS JANAEK
                 FROM ACL_SIGUMGO_SLV A
                          INNER JOIN ACL_SIGUMGO_MAS B ON B.MNG_NO = 1 AND A.SIGUMGO_ORG_C = B.SIGUMGO_ORG_C AND A.FIL_100_CTNT5 = B.FIL_100_CTNT2
                          INNER JOIN RPT_FISG_INFO_MAP C ON C.USE_YN = 'Y' AND C.GONGGEUM_GYEJWA = B.FIL_100_CTNT2
                          LEFT OUTER JOIN SFI_CMM_C_DAT E ON E.CMM_C_NM = 'RPT자치단체코드분류' AND E.USE_YN = 'Y' AND E.CMM_DTL_C = C.LAF_CD
                          INNER JOIN BATCH_PARAM D ON 1=1
                 WHERE 1=1
                   AND A.SIGUMGO_ORG_C = D.GEUMGO_CODE
                   AND C.FYR = D.BEF_HOIKYE_YR
                   AND NVL(A.GISDT, A.TRXDT) BETWEEN D.BEF_HOIKYE_YR || '0101' AND D.BEF_HOIKYE_YR || '1231'
                   AND LPAD(A.SIGUMGO_TRX_G,2,'0')||LPAD(A.SIGUMGO_IP_TRX_G,2,'0')||LPAD(A.SIGUMGO_JI_TRX_G,2,'0') NOT IN (SELECT CMM_DTL_C FROM SFI_CMM_C_DAT WHERE CMM_C_NM = '이호조세입세출송신용' AND USE_YN = 'Y')
                   AND NOT (A.SIGUMGO_ORG_C = 28 AND A.ICH_SIGUMGO_GUN_GU_C IN('260','720'))
                 GROUP BY C.FYR, C.GONGGEUM_GYEJWA
             ),
             GYEJWA AS (
                 SELECT
                     C.LAF_CD
                      ,C.LAF_NM
                      ,C.ACNT_DV_CD
                      ,C.ACNT_DV_MSTR_CD
                      ,C.ACNT_DV_MSTR_NM
                      ,C.ACNT_DV_NM
                      ,C.GONGGEUM_GYEJWA
                      ,C.FYR
                      ,B.SIGUMGO_ORG_C
                      ,B.ICH_SIGUMGO_GUN_GU_C
                      ,B.SIGUMGO_HOIKYE_YR
                      ,G.JANAEK AS UNYONG_JANAEK
                      ,H.JANAEK AS GONGGEUM_JANAEK
                      ,I.JANAEK AS MI_JANAEK
                 FROM RPT_FISG_INFO_MAP C
                          INNER JOIN BATCH_PARAM D ON 1=1
                          LEFT OUTER JOIN ACL_SIGUMGO_MAS B ON B.SIGUMGO_ORG_C = D.GEUMGO_CODE AND B.MNG_NO = 1 AND C.GONGGEUM_GYEJWA = B.FIL_100_CTNT2
                     -- 자치단체분류코드는 LAF_CD 단위로 하나이다
                          LEFT OUTER JOIN  SFI_CMM_C_DAT E ON E.CMM_C_NM = 'RPT자치단체코드분류' AND E.USE_YN = 'Y'AND C.LAF_CD = E.CMM_DTL_C
                          LEFT OUTER JOIN UNYONG_JAN G ON C.GONGGEUM_GYEJWA = G.GONGGEUM_GYEJWA AND C.FYR = G.HOIKYE_YR
                          LEFT OUTER JOIN GONGGEUM_JAN H ON C.GONGGEUM_GYEJWA = H.GONGGEUM_GYEJWA AND C.FYR = H.HOIKYE_YR
                          LEFT OUTER JOIN MI_JAN I ON C.GONGGEUM_GYEJWA = I.GONGGEUM_GYEJWA AND C.FYR = I.HOIKYE_YR
                 WHERE 1=1
                   AND C.USE_YN = 'Y'
                   AND C.FYR IN ( D.BEF_HOIKYE_YR, D.HOIKYE_YR)
                   -- 99 계좌 중복 조회 제거
                   -- AND NOT (C.FYR = D.BEF_HOIKYE_YR AND C.GONGGEUM_GYEJWA LIKE '%99')
                   AND NOT (B.SIGUMGO_ORG_C = 28 AND B.ICH_SIGUMGO_GUN_GU_C IN('260','720'))
                 GROUP BY   C.LAF_CD
                        ,C.LAF_NM
                        ,C.ACNT_DV_CD
                        ,C.ACNT_DV_MSTR_CD
                        ,C.ACNT_DV_MSTR_NM
                        ,C.ACNT_DV_NM
                        ,C.GONGGEUM_GYEJWA
                        ,C.FYR
                        ,B.SIGUMGO_ORG_C
                        ,B.ICH_SIGUMGO_GUN_GU_C
                        ,B.SIGUMGO_HOIKYE_YR
                        ,G.JANAEK
                        ,H.JANAEK
                        ,I.JANAEK
             )
SELECT
    A.SIGUMGO_ORG_C AS SIGUMGO_ORG_C,
    A.ICH_SIGUMGO_GUN_GU_C,
    A.ICH_SIGUMGO_HOIKYE_C,
    CASE WHEN A.SIGUMGO_HOIKYE_YR = 9999 THEN SUBSTR(NVL(A.GISDT, A.TRXDT), 0, 4) ELSE A.SIGUMGO_HOIKYE_YR END AS SIGUMGO_HOIKYE_YR ,
    A.FIL_100_CTNT5 AS GONGGEUM_GYEJWA,
    A.TRXNO,
    A.TRXDT,
    A.GISDT,
    NVL(A.GISDT, A.TRXDT) AS REPORT_DATE,
    (A.TRAMT * DECODE(A.IPJI_G, 2, -1, 1) * DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)) AS TRAMT,
    F.HRNK_CMM_C_NM ,
    F.HRNK_CMM_DTL_C
FROM  ACL_SIGUMGO_SLV A
          LEFT OUTER JOIN SFI_CMM_C_DAT F ON F.CMM_C_NM = '이호조세입세출송신용' AND F.USE_YN = 'Y'
          INNER JOIN BATCH_PARAM D ON 1=1
WHERE 1=1
  AND A.SIGUMGO_ORG_C = D.GEUMGO_CODE
  AND A.FIL_100_CTNT5 = '02811035230000024'
  AND NOT (A.SIGUMGO_ORG_C = 28 AND A.ICH_SIGUMGO_GUN_GU_C IN('260','720'))
  -- 시작일은 당해년도 1월1일 추가?
  AND NVL(A.GISDT, A.TRXDT) BETWEEN (D.BEF_HOIKYE_YR || '0101') AND  D.BAS_DT
  -- 99회계의 거래내역은 당해년도만 계산(99회계는 공금잔에서 전년도 잔액 계산)
  AND NOT (A.SIGUMGO_HOIKYE_YR = 9999 AND NVL(A.GISDT, A.TRXDT) < D.HOIKYE_YR || '0101')
  -- 2금고인(인천제외) 경우에 99회계의 10, 60 이월입지급거래내역 제외
  AND NOT (
    A.SIGUMGO_ORG_C <> 28
        AND
    A.SIGUMGO_HOIKYE_YR = 9999
        AND
    LPAD(A.SIGUMGO_TRX_G,2,'0')||LPAD(A.SIGUMGO_IP_TRX_G,2,'0')||LPAD(A.SIGUMGO_JI_TRX_G,2,'0') IN ('100000', '600000')
    )
  AND F.CMM_DTL_C = LPAD(A.SIGUMGO_TRX_G,2,'0')||LPAD(A.SIGUMGO_IP_TRX_G,2,'0')||LPAD(A.SIGUMGO_JI_TRX_G,2,'0')

----------------------------------------------------------------------------------------
    WITH BATCH_PARAM AS (
            SELECT
                'AAAA' AS GOF_CD,
                'AAAA' AS GOF_NM,
                28 AS GEUMGO_CODE,
                '20250224' AS BAS_DT,
                TO_NUMBER(2024) AS  BEF_HOIKYE_YR,
                TO_NUMBER(2025) AS HOIKYE_YR
            FROM DUAL
        )
SELECT
    A.SIGUMGO_ORG_C AS SIGUMGO_ORG_C,
    A.ICH_SIGUMGO_GUN_GU_C,
    A.ICH_SIGUMGO_HOIKYE_C,
    CASE WHEN A.SIGUMGO_HOIKYE_YR = 9999 THEN SUBSTR(NVL(A.GISDT, A.TRXDT), 0, 4) ELSE A.SIGUMGO_HOIKYE_YR END AS SIGUMGO_HOIKYE_YR ,
    A.FIL_100_CTNT5 AS GONGGEUM_GYEJWA,
    A.TRXNO,
    A.TRXDT,
    A.GISDT,
    NVL(A.GISDT, A.TRXDT) AS REPORT_DATE,
    LPAD(A.SIGUMGO_TRX_G,2,'0')||LPAD(A.SIGUMGO_IP_TRX_G,2,'0')||LPAD(A.SIGUMGO_JI_TRX_G,2,'0') AS TRX_G,
    (A.TRAMT * DECODE(A.IPJI_G, 2, -1, 1) * DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)) AS TRAMT,
    F.HRNK_CMM_C_NM ,
    F.HRNK_CMM_DTL_C
FROM  ACL_SIGUMGO_SLV A
          LEFT OUTER JOIN SFI_CMM_C_DAT F ON F.CMM_C_NM = '이호조세입세출송신용' AND F.USE_YN = 'Y'  AND F.CMM_DTL_C = LPAD(A.SIGUMGO_TRX_G,2,'0')||LPAD(A.SIGUMGO_IP_TRX_G,2,'0')||LPAD(A.SIGUMGO_JI_TRX_G,2,'0')
          INNER JOIN BATCH_PARAM D ON 1=1
WHERE 1=1
  AND A.SIGUMGO_ORG_C = D.GEUMGO_CODE
  AND A.FIL_100_CTNT5 = '02811035230000024'
  AND NOT (A.SIGUMGO_ORG_C = 28 AND A.ICH_SIGUMGO_GUN_GU_C IN('260','720'))
  -- 시작일은 당해년도 1월1일 추가?
  AND NVL(A.GISDT, A.TRXDT) BETWEEN (D.BEF_HOIKYE_YR || '0101') AND  D.BAS_DT
  -- 99회계의 거래내역은 당해년도만 계산(99회계는 공금잔에서 전년도 잔액 계산)
  AND NOT (A.SIGUMGO_HOIKYE_YR = 9999 AND NVL(A.GISDT, A.TRXDT) < D.HOIKYE_YR || '0101')
  -- 2금고인(인천제외) 경우에 99회계의 10, 60 이월입지급거래내역 제외
  AND NOT (
    A.SIGUMGO_ORG_C <> 28
        AND
    A.SIGUMGO_HOIKYE_YR = 9999
        AND
    LPAD(A.SIGUMGO_TRX_G,2,'0')||LPAD(A.SIGUMGO_IP_TRX_G,2,'0')||LPAD(A.SIGUMGO_JI_TRX_G,2,'0') IN ('100000', '600000')
    )


----------------------------------------

SELECT
    *
FROM ACL_SIGUMGO_SLV
WHERE FIL_100_CTNT5 = '02811035230000024'
ORDER BY TRXDT


---------------------------------------------------
-- 02871075690000024

    WITH BATCH_PARAM AS (
            SELECT
                'AAAA' AS GOF_CD,
                'AAAA' AS GOF_NM,
                28 AS GEUMGO_CODE,
                '20250224' AS BAS_DT,
                TO_NUMBER(2024) AS  BEF_HOIKYE_YR,
                TO_NUMBER(2025) AS HOIKYE_YR
            FROM DUAL
        )
SELECT
    A.SIGUMGO_ORG_C AS SIGUMGO_ORG_C,
    A.ICH_SIGUMGO_GUN_GU_C,
    A.ICH_SIGUMGO_HOIKYE_C,
    CASE WHEN A.SIGUMGO_HOIKYE_YR = 9999 THEN SUBSTR(NVL(A.GISDT, A.TRXDT), 0, 4) ELSE A.SIGUMGO_HOIKYE_YR END AS SIGUMGO_HOIKYE_YR ,
    A.FIL_100_CTNT5 AS GONGGEUM_GYEJWA,
    A.TRXNO,
    A.TRXDT,
    A.GISDT,
    NVL(A.GISDT, A.TRXDT) AS REPORT_DATE,
    LPAD(A.SIGUMGO_TRX_G,2,'0')||LPAD(A.SIGUMGO_IP_TRX_G,2,'0')||LPAD(A.SIGUMGO_JI_TRX_G,2,'0') AS TRX_G,
    (A.TRAMT * DECODE(A.IPJI_G, 2, -1, 1) * DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)) AS TRAMT,
    F.HRNK_CMM_C_NM ,
    F.HRNK_CMM_DTL_C
FROM  ACL_SIGUMGO_SLV A
          LEFT OUTER JOIN SFI_CMM_C_DAT F ON F.CMM_C_NM = '이호조세입세출송신용' AND F.USE_YN = 'Y'
          INNER JOIN BATCH_PARAM D ON 1=1
WHERE 1=1
  AND A.SIGUMGO_ORG_C = D.GEUMGO_CODE
  AND A.FIL_100_CTNT5 = '02871075690000024'
  AND NOT (A.SIGUMGO_ORG_C = 28 AND A.ICH_SIGUMGO_GUN_GU_C IN('260','720'))
  -- 시작일은 당해년도 1월1일 추가?
  AND NVL(A.GISDT, A.TRXDT) BETWEEN (D.BEF_HOIKYE_YR || '0101') AND  D.BAS_DT
  -- 99회계의 거래내역은 당해년도만 계산(99회계는 공금잔에서 전년도 잔액 계산)
  AND NOT (A.SIGUMGO_HOIKYE_YR = 9999 AND NVL(A.GISDT, A.TRXDT) < D.HOIKYE_YR || '0101')
  -- 2금고인(인천제외) 경우에 99회계의 10, 60 이월입지급거래내역 제외
  AND NOT (
    A.SIGUMGO_ORG_C <> 28
        AND
    A.SIGUMGO_HOIKYE_YR = 9999
        AND
    LPAD(A.SIGUMGO_TRX_G,2,'0')||LPAD(A.SIGUMGO_IP_TRX_G,2,'0')||LPAD(A.SIGUMGO_JI_TRX_G,2,'0') IN ('100000', '600000')
    )
  AND F.CMM_DTL_C = LPAD(A.SIGUMGO_TRX_G,2,'0')||LPAD(A.SIGUMGO_IP_TRX_G,2,'0')||LPAD(A.SIGUMGO_JI_TRX_G,2,'0')
---------------------------------------------------------------------------------------------------------------------------
-- 02811038100000099
-- 104689477 - 16097692 = 88,591,785
-- 전년도 말일 잔액: 88591785

    WITH BATCH_PARAM AS (
            SELECT
                'AAAA' AS GOF_CD,
                'AAAA' AS GOF_NM,
                28 AS GEUMGO_CODE,
                '20250224' AS BAS_DT,
                TO_NUMBER(2024) AS  BEF_HOIKYE_YR,
                TO_NUMBER(2025) AS HOIKYE_YR
            FROM DUAL
        )
SELECT
    A.SIGUMGO_ORG_C AS SIGUMGO_ORG_C,
    A.ICH_SIGUMGO_GUN_GU_C,
    A.ICH_SIGUMGO_HOIKYE_C,
    CASE WHEN A.SIGUMGO_HOIKYE_YR = 9999 THEN SUBSTR(NVL(A.GISDT, A.TRXDT), 0, 4) ELSE A.SIGUMGO_HOIKYE_YR END AS SIGUMGO_HOIKYE_YR ,
    A.FIL_100_CTNT5 AS GONGGEUM_GYEJWA,
    A.TRXNO,
    A.TRXDT,
    A.GISDT,
    NVL(A.GISDT, A.TRXDT) AS REPORT_DATE,
    LPAD(A.SIGUMGO_TRX_G,2,'0')||LPAD(A.SIGUMGO_IP_TRX_G,2,'0')||LPAD(A.SIGUMGO_JI_TRX_G,2,'0') AS TRX_G,
    (A.TRAMT * DECODE(A.IPJI_G, 2, -1, 1) * DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)) AS TRAMT,
    F.HRNK_CMM_C_NM ,
    F.HRNK_CMM_DTL_C
FROM  ACL_SIGUMGO_SLV A
          LEFT OUTER JOIN SFI_CMM_C_DAT F ON F.CMM_C_NM = '이호조세입세출송신용' AND F.USE_YN = 'Y'
          INNER JOIN BATCH_PARAM D ON 1=1
WHERE 1=1
  AND A.SIGUMGO_ORG_C = D.GEUMGO_CODE
  AND A.FIL_100_CTNT5 = '02811038100000099'
  AND NOT (A.SIGUMGO_ORG_C = 28 AND A.ICH_SIGUMGO_GUN_GU_C IN('260','720'))
  -- 시작일은 당해년도 1월1일 추가?
  AND NVL(A.GISDT, A.TRXDT) BETWEEN (D.BEF_HOIKYE_YR || '0101') AND  D.BAS_DT
  -- 99회계의 거래내역은 당해년도만 계산(99회계는 공금잔에서 전년도 잔액 계산)
  AND NOT (A.SIGUMGO_HOIKYE_YR = 9999 AND NVL(A.GISDT, A.TRXDT) < D.HOIKYE_YR || '0101')
  -- 2금고인(인천제외) 경우에 99회계의 10, 60 이월입지급거래내역 제외
  AND NOT (
    A.SIGUMGO_ORG_C <> 28
        AND
    A.SIGUMGO_HOIKYE_YR = 9999
        AND
    LPAD(A.SIGUMGO_TRX_G,2,'0')||LPAD(A.SIGUMGO_IP_TRX_G,2,'0')||LPAD(A.SIGUMGO_JI_TRX_G,2,'0') IN ('100000', '600000')
    )
  AND F.CMM_DTL_C = LPAD(A.SIGUMGO_TRX_G,2,'0')||LPAD(A.SIGUMGO_IP_TRX_G,2,'0')||LPAD(A.SIGUMGO_JI_TRX_G,2,'0')

----------------------------------------------------------------------------------------------------------------------

SELECT * FROM RPT_GONGGEUM_JAN
WHERE 1=1
AND GONGGEUM_GYEJWA = '02811038100000099'
AND KEORAEIL = '20241231'