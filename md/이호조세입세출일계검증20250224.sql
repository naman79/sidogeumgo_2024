SELECT
    NVL(A.LAF_CD, '0') AS LAF_CD,
    NVL(A.LAF_NM, '0') AS LAF_NM,
    NVL(A.GOF_CD, '0') AS GOF_CD,
    NVL(A.GOF_NM, '0') AS GOF_NM,
    NVL(A.FYR, '0') AS FYR,
    NVL(A.ACNT_DV_CD, '0') AS ACNT_DV_CD,
    NVL(A.ACNT_DV_MSTR_CD, '0') AS ACNT_DV_MSTR_CD,
    NVL(A.ACNT_DV_MSTR_NM, '0') AS ACNT_DV_MSTR_NM,
    NVL(A.ACNT_DV_NM, '0') AS ACNT_DV_NM,
    NVL(A.GONGGEUM_GYEJWA, '0') AS GONGGEUM_GYEJWA,
    NVL(A.ACNT_YMD, '0') AS ACNT_YMD,
    SUM(NVL(A.NU_TXRV_DD_SUM_AMT, 0)) AS 세입누계,
    SUM(NVL(A.NU_ANE_AMT, 0)) AS 세출누계,
    SUM(NVL(A.NU_FD_OP_AMT, 0)) AS 자금운용누계,
    SUM(NVL(A.NU_TXRV_DD_SUM_AMT, 0) - NVL(A.NU_ANE_AMT, 0) - NVL(A.NU_FD_OP_AMT, 0)) AS 공금잔액,
    SUM(NVL(A.GONGGEUM_JANAEK, '0')) AS 수납회계이월액,
    SUM(NVL(A.UNYOUNG_JANAEK, '0')) AS 운용회계이월액,
    SUM(NVL(A.미분류합계, '0')) AS MI_JAN_AMT,
    SUM(NVL(A.RCVMT_AMT, '0')) AS RCVMT_AMT,
    SUM(NVL(A.RFN_AMT, '0')) AS RFN_AMT,
    SUM(NVL(A.TXRV_SBJ_RVSN_AMT, '0')) AS TXRV_SBJ_RVSN_AMT,
    SUM(NVL(A.TXRV_DD_SUM_AMT, '0')) AS TXRV_DD_SUM_AMT,
    SUM(NVL(A.FDAC_AMT, '0')) AS FDAC_AMT,
    SUM(NVL(A.FDAC_RTN_AMT, '0')) AS FDAC_RTN_AMT,
    SUM(NVL(A.FDAC_RAMT_AMT, '0')) AS FDAC_RAMT_AMT,
    SUM(NVL(A.EP_AMT, '0')) AS EP_AMT,
    SUM(NVL(A.RTN_AMT, '0')) AS RTN_AMT,
    SUM(NVL(A.ANE_SBJ_RVSN_AMT, '0')) AS ANE_SBJ_RVSN_AMT,
    SUM(NVL(A.ANE_AMT, '0')) AS ANE_AMT,
    SUM(NVL(A.PMOD_NPYM_AMT, '0')) AS PMOD_NPYM_AMT,
    SUM(NVL(A.FD_BDTR_AMT, '0')) AS FD_BDTR_AMT,
    SUM(NVL(A.FD_OP_DPI_AMT, '0')) AS FD_OP_DPI_AMT,
    SUM(NVL(A.FD_OP_CNLT_AMT, '0')) AS FD_OP_CNLT_AMT,
    SUM(NVL(A.FD_OP_AMT, '0')) AS FD_OP_AMT,
    SUM(NVL(A.STBX_RAMT_AMT, '0')) AS STBX_RAMT_AMT,
    SUM(NVL(A.UNDL_TRSFR_AMT, '0')) AS UNDL_TRSFR_AMT,
    SUM(NVL(A.NU_ANE_AMT, 0))  AS NU_ANE_AMT,
    SUM(NVL(A.NU_FD_OP_AMT, 0)) AS NU_FD_OP_AMT,
    SUM(NVL(A.NU_RCVMT_AMT, 0)) AS NU_RCVMT_AMT,
    SUM(NVL(A.NU_RFN_AMT, '0')) AS NU_RFN_AMT,
    SUM(NVL(A.NU_TXRV_SBJ_RVSN_AMT, '0')) AS NU_TXRV_SBJ_RVSN_AMT,
    SUM(NVL(A.NU_TXRV_DD_SUM_AMT, 0)) AS NU_TXRV_DD_SUM_AMT,
    SUM(NVL(A.NU_FDAC_AMT, '0')) AS NU_FDAC_AMT,
    SUM(NVL(A.NU_FDAC_RTN_AMT, '0')) AS NU_FDAC_RTN_AMT,
    SUM(NVL(A.NU_FDAC_RAMT_AMT, '0')) AS NU_FDAC_RAMT_AMT,
    SUM(NVL(A.NU_EP_AMT, '0')) AS NU_EP_AMT,
    SUM(NVL(A.NU_RTN_AMT, '0')) AS NU_RTN_AMT,
    SUM(NVL(A.NU_ANE_SBJ_RVSN_AMT, '0')) AS NU_ANE_SBJ_RVSN_AMT,
    SUM(NVL(A.NU_PMOD_NPYM_AMT, '0')) AS NU_PMOD_NPYM_AMT,
    SUM(NVL(A.NU_FD_BDTR_AMT, '0')) AS NU_FD_BDTR_AMT,
    SUM(NVL(A.NU_FD_OP_DPI_AMT, '0')) AS NU_FD_OP_DPI_AMT,
    SUM(NVL(A.NU_FD_OP_CNLT_AMT, '0')) AS NU_FD_OP_CNLT_AMT,
    SUM(NVL(A.NU_STBX_RAMT_AMT, '0')) AS NU_STBX_RAMT_AMT,
    SUM(NVL(A.NU_UNDL_TRSFR_AMT, '0')) AS NU_UNDL_TRSFR_AMT,
    NVL(A.STBX_BANK_CD, '0') AS STBX_BANK_CD
FROM
    (
        WITH BATCH_PARAM AS (
            SELECT
                'AAAA' AS GOF_CD,
                'AAAA' AS GOF_NM,
                28 AS GEUMGO_CODE,
                '20240205' AS BAS_DT,
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
                         SELECT /*+ HINT1 */
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
                         SELECT /*+ HINT1 */
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
                 SELECT /*+ HINT2 */
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
             ),
             GEORAE AS (
                 SELECT
                     A.SIGUMGO_ORG_C
                      , A.ICH_SIGUMGO_GUN_GU_C
                      , A.ICH_SIGUMGO_HOIKYE_C
                      , A.SIGUMGO_HOIKYE_YR
                      , A.GONGGEUM_GYEJWA
                      , A.REPORT_DATE
                      , A.HRNK_CMM_C_NM
                      , A.HRNK_CMM_DTL_C
                      , SUM(TRAMT) AS TRAMT
                 FROM (
                          SELECT
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
                            AND A.FIL_100_CTNT5 IN (
                              SELECT GONGGEUM_GYEJWA FROM GYEJWA
                          )
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
                      ) A
                 GROUP BY A.SIGUMGO_ORG_C
                        , A.ICH_SIGUMGO_GUN_GU_C
                        , A.ICH_SIGUMGO_HOIKYE_C
                        , A.SIGUMGO_HOIKYE_YR
                        , A.GONGGEUM_GYEJWA
                        , A.REPORT_DATE
                        , A.HRNK_CMM_C_NM
                        , A.HRNK_CMM_DTL_C
             )
        SELECT
            C.LAF_CD AS LAF_CD,
            C.LAF_NM AS LAF_NM,
            D.GOF_CD AS GOF_CD,
            D.GOF_NM AS GOF_NM,
            C.FYR AS FYR,
            C.ACNT_DV_CD AS ACNT_DV_CD ,
            C.ACNT_DV_MSTR_CD AS ACNT_DV_MSTR_CD ,
            C.ACNT_DV_MSTR_NM AS ACNT_DV_MSTR_NM ,
            C.ACNT_DV_NM AS ACNT_DV_NM ,
            C.GONGGEUM_GYEJWA AS GONGGEUM_GYEJWA,
            C.GONGGEUM_JANAEK AS GONGGEUM_JANAEK,
            C.UNYONG_JANAEK AS UNYOUNG_JANAEK,
            C.MI_JANAEK AS 미분류합계,
            D.BAS_DT AS ACNT_YMD
             , SUM(CASE WHEN A.HRNK_CMM_C_NM = '세입'   AND  A.REPORT_DATE = D.BAS_DT     THEN A.TRAMT ELSE 0 END) AS TXRV_DD_SUM_AMT
             , SUM(CASE WHEN A.HRNK_CMM_DTL_C = '수납'  AND  A.REPORT_DATE = D.BAS_DT         THEN A.TRAMT ELSE 0 END) AS RCVMT_AMT
             , SUM(CASE WHEN A.HRNK_CMM_DTL_C = '과오납환급'  AND  A.REPORT_DATE = D.BAS_DT         THEN  -1 * A.TRAMT ELSE 0 END) AS RFN_AMT
             , SUM(CASE WHEN A.HRNK_CMM_DTL_C = '과목경정'   AND  A.REPORT_DATE = D.BAS_DT        THEN A.TRAMT ELSE 0 END) AS TXRV_SBJ_RVSN_AMT
             , 0 AS FDAC_RTN_AMT
             , 0 AS FDAC_RAMT_AMT
             , SUM(CASE WHEN A.HRNK_CMM_C_NM = '세출'     AND  A.REPORT_DATE = D.BAS_DT      THEN -1 * A.TRAMT ELSE 0 END) AS ANE_AMT
             , SUM(CASE WHEN A.HRNK_CMM_DTL_C = '지출'      AND  A.REPORT_DATE = D.BAS_DT     THEN -1 * A.TRAMT ELSE 0 END) AS EP_AMT
             , SUM(CASE WHEN A.HRNK_CMM_DTL_C = '반납'      AND  A.REPORT_DATE = D.BAS_DT     THEN A.TRAMT ELSE 0 END) AS RTN_AMT
             , SUM(CASE WHEN A.HRNK_CMM_DTL_C = '세출과목경정'     AND  A.REPORT_DATE = D.BAS_DT     THEN  -1 * A.TRAMT ELSE 0 END) AS ANE_SBJ_RVSN_AMT
             , SUM(CASE WHEN A.HRNK_CMM_DTL_C = '자금배정'  AND  A.REPORT_DATE = D.BAS_DT         THEN -1 * A.TRAMT ELSE 0 END) AS FDAC_AMT
             ,0 AS PMOD_NPYM_AMT
             , SUM(CASE WHEN A.HRNK_CMM_C_NM = '자금운용'     AND  A.REPORT_DATE = D.BAS_DT      THEN -1 * A.TRAMT ELSE 0 END) AS FD_OP_AMT
             , SUM(CASE WHEN A.HRNK_CMM_DTL_C = '자금운용예치'     AND  A.REPORT_DATE = D.BAS_DT      THEN -1 * A.TRAMT ELSE 0 END) AS FD_OP_DPI_AMT
             , SUM(CASE WHEN A.HRNK_CMM_DTL_C = '자금운용해지'      AND  A.REPORT_DATE = D.BAS_DT     THEN A.TRAMT ELSE 0 END) AS FD_OP_CNLT_AMT
             , SUM(CASE WHEN A.HRNK_CMM_DTL_C = '자금전용'    AND  A.REPORT_DATE = D.BAS_DT       THEN A.TRAMT ELSE 0 END) AS FD_BDTR_AMT
             , SUM(CASE WHEN A.HRNK_CMM_C_NM = '지급명령미지급액'    AND  A.REPORT_DATE = D.BAS_DT       THEN A.TRAMT ELSE 0 END) AS UNDL_TRSFR_AMT
             , SUM(CASE WHEN A.HRNK_CMM_C_NM = '세입' AND (A.REPORT_DATE >= SUBSTR(D.BAS_DT,0,4) || '0101' OR A.SIGUMGO_HOIKYE_YR <> 9999) THEN A.TRAMT ELSE 0 END) + NVL(C.GONGGEUM_JANAEK,0) + NVL(C.UNYONG_JANAEK,0) AS NU_TXRV_DD_SUM_AMT
             , SUM(CASE WHEN A.HRNK_CMM_DTL_C = '수납'     AND (A.REPORT_DATE >= SUBSTR(D.BAS_DT,0,4) || '0101' OR A.SIGUMGO_HOIKYE_YR <> 9999)  THEN A.TRAMT ELSE 0 END) + NVL(C.GONGGEUM_JANAEK,0) + NVL(C.UNYONG_JANAEK,0) AS NU_RCVMT_AMT
             , SUM(CASE WHEN A.HRNK_CMM_DTL_C = '과오납환급'   AND (A.REPORT_DATE >= SUBSTR(D.BAS_DT,0,4) || '0101' OR A.SIGUMGO_HOIKYE_YR <> 9999)  THEN -1 * A.TRAMT ELSE 0 END) AS NU_RFN_AMT
             , SUM(CASE WHEN A.HRNK_CMM_DTL_C = '과목경정'  AND (A.REPORT_DATE >= SUBSTR(D.BAS_DT,0,4) || '0101' OR A.SIGUMGO_HOIKYE_YR <> 9999)  THEN A.TRAMT ELSE 0 END) AS NU_TXRV_SBJ_RVSN_AMT
             , 0 AS NU_FDAC_RTN_AMT
             , 0 AS NU_FDAC_RAMT_AMT
             , SUM(CASE WHEN A.HRNK_CMM_C_NM = '세출' AND (A.REPORT_DATE >= SUBSTR(D.BAS_DT,0,4) || '0101' OR A.SIGUMGO_HOIKYE_YR <> 9999)  THEN -1 * A.TRAMT ELSE 0 END) AS NU_ANE_AMT
             , SUM(CASE WHEN A.HRNK_CMM_DTL_C = '지출' AND (A.REPORT_DATE >= SUBSTR(D.BAS_DT,0,4) || '0101' OR A.SIGUMGO_HOIKYE_YR <> 9999)  THEN -1 * A.TRAMT ELSE 0 END) AS NU_EP_AMT
             , SUM(CASE WHEN A.HRNK_CMM_DTL_C = '반납'  AND (A.REPORT_DATE >= SUBSTR(D.BAS_DT,0,4) || '0101' OR A.SIGUMGO_HOIKYE_YR <> 9999)  THEN A.TRAMT ELSE 0 END) AS NU_RTN_AMT
             , SUM(CASE WHEN A.HRNK_CMM_DTL_C = '세출과목경정' AND (A.REPORT_DATE >= SUBSTR(D.BAS_DT,0,4) || '0101' OR A.SIGUMGO_HOIKYE_YR <> 9999) THEN -1 * A.TRAMT ELSE 0 END) AS NU_ANE_SBJ_RVSN_AMT
             , SUM(CASE WHEN A.HRNK_CMM_DTL_C = '자금배정'AND (A.REPORT_DATE >= SUBSTR(D.BAS_DT,0,4) || '0101' OR A.SIGUMGO_HOIKYE_YR <> 9999) THEN -1 * A.TRAMT ELSE 0 END) AS NU_FDAC_AMT
             ,0 AS NU_PMOD_NPYM_AMT
             , SUM(CASE WHEN A.HRNK_CMM_C_NM = '자금운용'    AND A.REPORT_DATE >= SUBSTR(D.BAS_DT,0,4) || '0101'  THEN -1 * A.TRAMT ELSE 0 END)  + NVL(C.UNYONG_JANAEK,0) AS NU_FD_OP_AMT
             , SUM(CASE WHEN A.HRNK_CMM_DTL_C = '자금운용예치'   AND A.REPORT_DATE >= SUBSTR(D.BAS_DT,0,4) || '0101'  THEN -1 * A.TRAMT ELSE 0 END) + NVL(C.UNYONG_JANAEK,0) AS NU_FD_OP_DPI_AMT
             , SUM(CASE WHEN A.HRNK_CMM_DTL_C = '자금운용해지'   AND A.REPORT_DATE >= SUBSTR(D.BAS_DT,0,4) || '0101'  THEN A.TRAMT ELSE 0 END) AS NU_FD_OP_CNLT_AMT
             , SUM(CASE WHEN A.HRNK_CMM_DTL_C = '자금전용' AND A.REPORT_DATE >= SUBSTR(D.BAS_DT,0,4) || '0101' THEN A.TRAMT ELSE 0 END) AS NU_FD_BDTR_AMT
             , SUM(CASE WHEN A.HRNK_CMM_C_NM = '지급명령미지급액'  AND A.REPORT_DATE >= SUBSTR(D.BAS_DT,0,4) || '0101'  THEN A.TRAMT ELSE 0 END) AS NU_UNDL_TRSFR_AMT
             , 0 AS STBX_RAMT_AMT
             , 0 AS NU_STBX_RAMT_AMT
             , '10' AS DAY_MON_FG
             , '088' STBX_BANK_CD
        FROM  GYEJWA C
                  LEFT OUTER JOIN GEORAE A ON C.GONGGEUM_GYEJWA = A.GONGGEUM_GYEJWA
                  INNER JOIN BATCH_PARAM D ON 1=1
        WHERE 1=1
        GROUP BY C.LAF_CD,  C.LAF_NM, D.GOF_CD, D.GOF_NM, C.FYR, C.ACNT_DV_CD, C.ACNT_DV_MSTR_CD, C.ACNT_DV_MSTR_NM, C.ACNT_DV_NM, C.GONGGEUM_GYEJWA,  C.UNYONG_JANAEK, C.GONGGEUM_JANAEK, C.MI_JANAEK, D.BAS_DT
    ) A
GROUP BY A.LAF_CD, A.LAF_NM, A.GOF_CD, A.GOF_NM, A.FYR, A.GONGGEUM_GYEJWA, A.ACNT_DV_CD, A.ACNT_DV_MSTR_CD, A.ACNT_DV_MSTR_NM, A.ACNT_DV_NM, A.ACNT_YMD, A.STBX_BANK_CD
ORDER BY A.FYR, A.GONGGEUM_GYEJWA