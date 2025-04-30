WITH BATCH_PARAM AS (
    SELECT
        'AAAA' AS GOF_CD,
        'AAAA' AS GOF_NM,
        28 AS GEUMGO_CODE,
        '20250227' AS BAS_DT,
        TO_NUMBER(2024) AS  BEF_HOIKYE_YR,
        TO_NUMBER(2025) AS HOIKYE_YR
    FROM DUAL
)
SELECT
    A.HOIKYE_YR,
    A.GONGGEUM_GYEJWA,
    A.TRX_G,
    A.JANAEK
FROM (SELECT C.FYR                                                                                                 AS HOIKYE_YR,
             C.GONGGEUM_GYEJWA,
             LPAD(A.SIGUMGO_TRX_G, 2, '0') || LPAD(A.SIGUMGO_IP_TRX_G, 2, '0') ||
             LPAD(A.SIGUMGO_JI_TRX_G, 2, '0')                                                                      AS TRX_G,
             SUM(DECODE(A.CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(A.IPJI_G, 2, -1, 1) *
                 A.TRAMT)                                                                                          AS JANAEK
      FROM ACL_SIGUMGO_SLV A
               INNER JOIN ACL_SIGUMGO_MAS B
                          ON B.MNG_NO = 1 AND A.SIGUMGO_ORG_C = B.SIGUMGO_ORG_C AND A.FIL_100_CTNT5 = B.FIL_100_CTNT2
               INNER JOIN RPT_FISG_INFO_MAP C ON C.USE_YN = 'Y' AND C.GONGGEUM_GYEJWA = B.FIL_100_CTNT2
               LEFT OUTER JOIN SFI_CMM_C_DAT E
                               ON E.CMM_C_NM = 'RPT자치단체코드분류' AND E.USE_YN = 'Y' AND E.CMM_DTL_C = C.LAF_CD
               INNER JOIN BATCH_PARAM D ON 1 = 1
      WHERE 1 = 1
        AND A.SIGUMGO_ORG_C = D.GEUMGO_CODE
        AND C.FYR = D.HOIKYE_YR
        AND NVL(A.GISDT, A.TRXDT) BETWEEN D.HOIKYE_YR || '0101' AND D.BAS_DT
        AND LPAD(A.SIGUMGO_TRX_G, 2, '0') || LPAD(A.SIGUMGO_IP_TRX_G, 2, '0') || LPAD(A.SIGUMGO_JI_TRX_G, 2, '0') NOT IN
            (SELECT CMM_DTL_C FROM SFI_CMM_C_DAT WHERE CMM_C_NM = '이호조세입세출송신용' AND USE_YN = 'Y')
        AND NOT (A.SIGUMGO_ORG_C = 28 AND A.ICH_SIGUMGO_GUN_GU_C IN ('260', '720'))
      GROUP BY C.FYR, C.GONGGEUM_GYEJWA,
               LPAD(A.SIGUMGO_TRX_G, 2, '0') || LPAD(A.SIGUMGO_IP_TRX_G, 2, '0') || LPAD(A.SIGUMGO_JI_TRX_G, 2, '0')
      UNION ALL
      SELECT C.FYR                                                                                                 AS HOIKYE_YR,
             C.GONGGEUM_GYEJWA,
             LPAD(A.SIGUMGO_TRX_G, 2, '0') || LPAD(A.SIGUMGO_IP_TRX_G, 2, '0') ||
             LPAD(A.SIGUMGO_JI_TRX_G, 2, '0')                                                                      AS TRX_G,
             SUM(DECODE(A.CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(A.IPJI_G, 2, -1, 1) *
                 A.TRAMT)                                                                                          AS JANAEK
      FROM ACL_SIGUMGO_SLV A
               INNER JOIN ACL_SIGUMGO_MAS B
                          ON B.MNG_NO = 1 AND A.SIGUMGO_ORG_C = B.SIGUMGO_ORG_C AND A.FIL_100_CTNT5 = B.FIL_100_CTNT2
               INNER JOIN RPT_FISG_INFO_MAP C ON C.USE_YN = 'Y' AND C.GONGGEUM_GYEJWA = B.FIL_100_CTNT2
               LEFT OUTER JOIN SFI_CMM_C_DAT E
                               ON E.CMM_C_NM = 'RPT자치단체코드분류' AND E.USE_YN = 'Y' AND E.CMM_DTL_C = C.LAF_CD
               INNER JOIN BATCH_PARAM D ON 1 = 1
      WHERE 1 = 1
        AND A.SIGUMGO_ORG_C = D.GEUMGO_CODE
        AND C.FYR = D.BEF_HOIKYE_YR
        -- 미분류잔액도 전년도분은 0원 처리
        AND A.SIGUMGO_HOIKYE_YR <> 9999
        AND NVL(A.GISDT, A.TRXDT) BETWEEN D.BEF_HOIKYE_YR || '0101' AND D.BAS_DT
        AND LPAD(A.SIGUMGO_TRX_G, 2, '0') || LPAD(A.SIGUMGO_IP_TRX_G, 2, '0') || LPAD(A.SIGUMGO_JI_TRX_G, 2, '0') NOT IN
            (SELECT CMM_DTL_C FROM SFI_CMM_C_DAT WHERE CMM_C_NM = '이호조세입세출송신용' AND USE_YN = 'Y')
        AND NOT (A.SIGUMGO_ORG_C = 28 AND A.ICH_SIGUMGO_GUN_GU_C IN ('260', '720'))
      GROUP BY C.FYR, C.GONGGEUM_GYEJWA,
               LPAD(A.SIGUMGO_TRX_G, 2, '0') || LPAD(A.SIGUMGO_IP_TRX_G, 2, '0') || LPAD(A.SIGUMGO_JI_TRX_G, 2, '0')
      ) A
ORDER BY A.HOIKYE_YR, A.GONGGEUM_GYEJWA, A.TRX_G