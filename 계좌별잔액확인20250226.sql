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