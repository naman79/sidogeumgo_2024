select * from acl_sigumgo_slv
where 1=1
and fil_100_ctnt5 = '02800022100000099'

SELECT
A.HOIGYE_TITLE,
A.DAY_TITLE,
A.ACNO,
SUM(A.DAY_IPSU) AS DAY_IPSU,
SUM(A.DAY_IPGWA) AS DAY_IPGWA,
SUM(A.DAY_IPSU - A.DAY_IPGWA) AS DAY_IPCHA,
SUM(A.DAY_JAGEUM) AS DAY_JAGEUM,
SUM(A.DAY_SEJI) AS DAY_SEJI,
SUM(A.DAY_SEBAN) AS DAY_SEBAN,

SUM(A.DAY_SEJI - A.DAY_SEBAN) AS DAY_SECHA ,
SUM(A.DAY_IPSU - A.DAY_IPGWA - A.DAY_JAGEUM - A.DAY_SEJI + A.DAY_SEBAN) AS DAY_JANNO4,
SUM(A.DAY_JEO + A.DAY_JEON + A.DAY_GA) AS DAY_TOTAL,
SUM(A.DAY_JEO) AS DAY_JEO ,
SUM(A.DAY_JEON) AS DAY_JEON,
SUM(A.DAY_GA) AS DAY_GA,
SUM(A.DAY_IPSU - A.DAY_IPGWA - A.DAY_JAGEUM - A.DAY_SEJI + A.DAY_SEBAN - A.DAY_JEO - A.DAY_JEON - A.DAY_GA) AS DAY_GONGJAN ,
A.NU_TITLE,
SUM(A.NU_IPSU) AS NU_IPSU ,
SUM(A.NU_IPGWA) AS NU_IPGWA ,

SUM(A.NU_IPSU - A.NU_IPGWA) AS NU_IPCHA,
SUM(A.NU_JAGEUM) AS NU_JAGEUM ,
SUM(A.NU_SEJI) AS NU_SEJI,
SUM(A.NU_SEBAN) AS NU_SEBAN,

SUM(A.NU_SEJI - A.NU_SEBAN) AS NU_SECHA ,
SUM(A.NU_IPSU - A.NU_IPGWA - A.NU_JAGEUM - A.NU_SEJI + A.NU_SEBAN) AS NU_JANNO4,
SUM(A.NU_JEO + A.NU_JEON + A.NU_GA) AS NU_TOTAL,
SUM(A.NU_JEO) AS NU_JEO,
SUM(A.NU_JEON) AS NU_JEON,
SUM(A.NU_GA) AS NU_GA ,
SUM(A.NU_IPSU - A.NU_IPGWA - A.NU_JAGEUM - A.NU_SEJI + A.NU_SEBAN - A.NU_JEO - A.NU_JEON - A.NU_GA) AS NU_GONGJAN
FROM
(
 WITH ACNO_LIST AS (

    SELECT FIL_100_CTNT2 AS ACNO FROM ACL_SIGUMGO_MAS
 WHERE 1=1
 AND SIGUMGO_ORG_C = '28'

 AND FIL_100_CTNT2 = '02800022100000099'
),
GONGGEUM_JAN AS (
    SELECT
        GONGGEUM_GYEJWA AS ACNO,
        JANAEK
    FROM
        RPT_GONGGEUM_JAN
    WHERE
        KEORAEIL =  TO_CHAR(TO_NUMBER('2021') - 1)||'1231'
    AND
        GONGGEUM_GYEJWA IN (
            SELECT ACNO FROM ACNO_LIST
        )
),
JEON_JAN AS (
    SELECT
    FIL_100_CTNT5 AS ACNO,
    SUM(DECODE(CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(IPJI_G, 2, -1, 1) * TRAMT) AS TT
    FROM ACL_SIGUMGO_SLV
    WHERE FIL_100_CTNT5 IN (SELECT ACNO FROM ACNO_LIST)
    AND GJDT LIKE TO_CHAR(TO_NUMBER('2021') - 1)||'%'
    AND TRXDT LIKE '2021' ||'%'
    GROUP BY FIL_100_CTNT5
)
, G_GUBUN AS (
  SELECT
  A.GUBUN,
  A.ACNO,
  A.TRX,
  SUM(A.TT) AS TT
  FROM
  (
    SELECT
        A.GUBUN,
        A.ACNO,
        A.TRX,
        SUM(A.TT) AS TT
    FROM
(
    SELECT
        1 AS GUBUN,
        FIL_100_CTNT5 AS ACNO,
        LPAD(SIGUMGO_TRX_G, 2, 0) || LPAD(SIGUMGO_IP_TRX_G, 2, 0) || LPAD(SIGUMGO_JI_TRX_G, 2, 0) AS TRX,
        SUM(DECODE(CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * TRAMT) AS TT
    FROM ACL_SIGUMGO_SLV
    WHERE FIL_100_CTNT5 IN (SELECT ACNO FROM ACNO_LIST)
      AND GJDT BETWEEN '2021' || '0101' AND '20211231'
    GROUP BY FIL_100_CTNT5, LPAD(SIGUMGO_TRX_G, 2, 0) || LPAD(SIGUMGO_IP_TRX_G, 2, 0) || LPAD(SIGUMGO_JI_TRX_G, 2, 0)
    UNION ALL
    SELECT
        2 AS GUBUN,
        FIL_100_CTNT5 AS ACNO,
        LPAD(SIGUMGO_TRX_G, 2, 0) || LPAD(SIGUMGO_IP_TRX_G, 2, 0) || LPAD(SIGUMGO_JI_TRX_G, 2, 0) AS TRX,
        SUM(DECODE(CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * TRAMT) AS TT
    FROM ACL_SIGUMGO_SLV
    WHERE FIL_100_CTNT5 IN (SELECT ACNO FROM ACNO_LIST)
      AND GJDT = '20211231'
    GROUP BY FIL_100_CTNT5, LPAD(SIGUMGO_TRX_G, 2, 0) || LPAD(SIGUMGO_IP_TRX_G, 2, 0) || LPAD(SIGUMGO_JI_TRX_G, 2, 0)
    UNION ALL
    SELECT
        1 AS GUBUN,
        ACNO,
        '110100',
        JANAEK AS TT
    FROM GONGGEUM_JAN
    UNION ALL
    SELECT
        1 AS GUBUN,
        ACNO,
        '110100',
        TT AS TT
    FROM JEON_JAN
    UNION ALL
    SELECT
        2 AS GUBUN,
        ACNO,
        '110100',
        CASE WHEN ( '20211231' =  ( '2021' || '0101') ) THEN JANAEK ELSE 0 END AS TT
    FROM GONGGEUM_JAN
    UNION ALL
    SELECT
        2 AS GUBUN,
        ACNO,
        '110100',
        CASE WHEN ( '20211231' =  ( '2021' || '0101') ) THEN TT ELSE 0 END AS TT
    FROM JEON_JAN
  ) A
  GROUP BY A.GUBUN, A.ACNO, A.TRX
) A GROUP BY A.GUBUN, A.ACNO, A.TRX
)
SELECT
'하수도' AS HOIGYE_TITLE,
'일계' AS DAY_TITLE,
A.ACNO,
 CASE WHEN A.GUBUN = 2 AND ( A.TRX = 110100 OR A.TRX = 130000 ) THEN SUM(A.TT) ELSE 0 END  AS DAY_IPSU,
CASE WHEN A.GUBUN = 2 AND ( A.TRX = 640000 OR A.TRX = 630000 )THEN SUM(A.TT) ELSE 0 END  AS DAY_IPGWA,

 0  AS DAY_IPCHA,
 0 AS DAY_JAGEUM,
 CASE WHEN A.GUBUN = 2 AND ( A.TRX = 610001 OR  A.TRX = 610002 ) THEN SUM(A.TT) ELSE 0 END  AS DAY_SEJI,
 CASE WHEN A.GUBUN = 2 AND ( A.TRX = 140600 OR  A.TRX = 140700 ) THEN SUM(A.TT) ELSE 0 END  AS DAY_SEBAN,

 0  AS DAY_SECHA,
 0  AS DAY_JANNO4,
 0  AS DAY_TOTAL,
 CASE WHEN A.GUBUN = 2 AND A.TRX = 620003  THEN SUM(A.TT)
 WHEN A.GUBUN = 2 AND A.TRX = 120300  THEN SUM(A.TT*-1)
 ELSE 0 END  AS DAY_JEO,
 0  AS DAY_JEON,
 0  AS DAY_GA,
 0  AS DAY_GONGJAN,
'누계' AS NU_TITLE,
 CASE WHEN A.GUBUN = 1 AND ( A.TRX = 110100 OR A.TRX = 130000 ) THEN SUM(A.TT) ELSE 0 END  AS NU_IPSU,
 CASE WHEN A.GUBUN = 1 AND ( A.TRX = 640000 OR A.TRX = 630000 ) THEN SUM(A.TT) ELSE 0 END  AS NU_IPGWA,

 0  AS NU_IPCHA,
 0  AS NU_JAGEUM,
 CASE WHEN A.GUBUN = 1 AND ( A.TRX = 610001 OR  A.TRX = 610002 ) THEN SUM(A.TT) ELSE 0 END  AS NU_SEJI,
 CASE WHEN A.GUBUN = 1 AND ( A.TRX = 140600 OR  A.TRX = 140700 ) THEN SUM(A.TT) ELSE 0 END  AS NU_SEBAN,

 0 AS NU_SECHA,
 0  AS NU_JANNO4,
 0  AS NU_TOTAL,
CASE WHEN A.GUBUN = 1 AND A.TRX = 620003  THEN SUM(A.TT)
 WHEN A.GUBUN = 1 AND A.TRX = 120300  THEN SUM(A.TT*-1)
 ELSE 0 END   AS NU_JEO,
 0 AS NU_JEON,
 0  AS NU_GA,
 0  AS NU_GONGJAN
FROM  G_GUBUN A
GROUP BY A.ACNO, A.GUBUN, A.TRX
) A
GROUP BY A.HOIGYE_TITLE,
A.DAY_TITLE,
A.ACNO,
A.NU_TITLE
;

                                       SELECT
                                            T1.BIZ_DT
                                       FROM
                                            (
                                             SELECT
                                                  T1.BIZ_DT
                                             FROM
                                                  MAP_JOB_DATE T1
                                             WHERE 1=1
                                                  AND T1.BIZ_DT <= '20241231'
                                                  AND T1.DT_G = 0
                                             ORDER BY
                                                  T1.BIZ_DT DESC
                                            ) T1
                                       WHERE 1=1
                                            AND ROWNUM < 7

 ----------------------------------------------------------------------------



SELECT
         X.RNUM
         ,X.KEORAEIL
         ,X.KIJUNIL
         ,X.KISANIL
         ,X.GEORAE_SEQ
         ,X.JEONGJEONG
         ,X.IPGEUM_AMT
         ,X.JIGEUB_AMT
         ,X.JUKYO
         ,X.GEORAEGUBUN
         ,X.TOT_CNT
FROM
         (
            SELECT
                ROW_NUMBER() OVER(ORDER BY T1.KEORAEIL,T1.KIJUNIL,T1.KISANIL,T1.GEORAE_SEQ) AS RNUM
                ,T1.KEORAEIL
                ,T1.KIJUNIL
                ,T1.KISANIL
                ,T1.GEORAE_SEQ
                ,T1.JEONGJEONG
                ,T1.IPGEUM_AMT
                ,T1.JIGEUB_AMT
                ,T1.JUKYO
                ,T1.GEORAE_GUBUN||'-당행수납분 입금' AS GEORAEGUBUN
                ,(COUNT(1) OVER ()) AS TOT_CNT
            FROM
                 (
                  SELECT
                       T2.TRXDT AS KEORAEIL
                      ,T2.GJDT AS KIJUNIL
                      ,T2.GISDT AS KISANIL
                      ,T2.TRXNO AS GEORAE_SEQ
                      ,T2.CRT_CAN_G AS JEONGJEONG
                      ,DECODE(T2.IPJI_G, 1, DECODE(T2.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T2.TRAMT, 0) AS IPGEUM_AMT
                      ,DECODE(T2.IPJI_G, 1, 0, DECODE(T2.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T2.TRAMT) AS JIGEUB_AMT
                      ,T2.CMMT_CTNT AS JUKYO
                      ,T2.SIGUMGO_TRX_G AS GEORAE_GUBUN
                      ,T2.SIGUMGO_IP_TRX_G AS IPGEUM_GEORAE
                      ,T2.SIGUMGO_TAX_IP_MNG_NO AS HANDO_GYEJWA
                  FROM
                       ACL_SIGUMGO_MAS T1
                      ,ACL_SIGUMGO_SLV T2
                  WHERE 1=1
                       AND T1.FIL_100_CTNT2 = T2.FIL_100_CTNT5
                       AND T1.SIGUMGO_ORG_C = '28'
                       AND DECODE(NVL('', '9999'), '9999', 1, DECODE(T1.ICH_SIGUMGO_GUN_GU_C, '', 1, 0)) = 1
                       AND T1.ICH_SIGUMGO_HOIKYE_C = '01'
                       AND T1.SIGUMGO_AC_B = 10
                       AND (
                            CASE
                                WHEN '0' = 1 THEN DECODE(T1.SIGUMGO_HOIKYE_YR, '9999', 1, SUBSTR('20241231', 1, 4), 1, 0)
                                WHEN '0' IN (8, 9) THEN DECODE(T1.SIGUMGO_HOIKYE_YR, SUBSTR('20241231', 1, 4) - 1, 1, 0)
                                WHEN '0' = 0 THEN DECODE(T1.SIGUMGO_HOIKYE_YR, '9999', 1, SUBSTR('20241231', 1, 4), 1, SUBSTR('20241231', 1, 4) - 1, 1, 0)
                                ELSE 0
                             END
                           ) = 1
                       AND T1.MNG_NO = 1
                       AND T2.TRXDT > '20241231'
                       AND T2.GJDT IN (
                                       SELECT
                                            T1.BIZ_DT
                                       FROM
                                            (
                                             SELECT
                                                  T1.BIZ_DT
                                             FROM
                                                  MAP_JOB_DATE T1
                                             WHERE 1=1
                                                  AND T1.BIZ_DT <= '20241231'
                                                  AND T1.DT_G = 0
                                             ORDER BY
                                                  T1.BIZ_DT DESC
                                            ) T1
                                       WHERE 1=1
                                            AND ROWNUM < 7
                                      )
                       AND T2.SIGUMGO_TRX_G = 11
                       AND T2.IMMD_PROC_DSYN <> 1
                  UNION ALL
                  SELECT
                       T2.TRXDT AS KEORAEIL
                      ,T2.GJDT AS KIJUNIL
                      ,T2.GISDT AS KISANIL
                      ,T2.TRXNO AS GEORAE_SEQ
                      ,T2.CRT_CAN_G AS JEONGJEONG
                      ,DECODE(T2.IPJI_G, 1, DECODE(T2.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T2.TRAMT, 0) AS IPGEUM_AMT
                      ,DECODE(T2.IPJI_G, 1, 0, DECODE(T2.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T2.TRAMT) AS JIGEUB_AMT
                      ,NULL AS JUKYO
                      ,T2.SIGUMGO_TRX_G AS GEORAE_GUBUN
                      ,0 AS IPGEUM_GEORAE
                      ,NULL AS HANDO_GYEJWA
                  FROM
                       ACL_SIGUMGO_MAS T1
                      ,ACL_SGGHANDO_SLV T2
                  WHERE 1=1
                       AND T1.FIL_100_CTNT2 = T2.SIGUMGO_ACNO
                       AND T1.SIGUMGO_ORG_C = '28'
                       AND DECODE(NVL('', '9999'), '9999', 1, DECODE(T1.ICH_SIGUMGO_GUN_GU_C, '', 1, 0)) = 1
                       AND T1.ICH_SIGUMGO_HOIKYE_C = '01'
                       AND T1.SIGUMGO_AC_B = 10
                       AND (
                            CASE
                                WHEN '0' = 1 THEN DECODE(T1.SIGUMGO_HOIKYE_YR, '9999', 1, SUBSTR('20241231', 1, 4), 1, 0)
                                WHEN '0' IN (8, 9) THEN DECODE(T1.SIGUMGO_HOIKYE_YR, SUBSTR('20241231', 1, 4) - 1, 1, 0)
                                WHEN '0' = 0 THEN DECODE(T1.SIGUMGO_HOIKYE_YR, '9999', 1, SUBSTR('20241231', 1, 4), 1, SUBSTR('20241231', 1, 4) - 1, 1, 0)
                                ELSE 0
                             END
                           ) = 1
                       AND T1.MNG_NO = 1
                       AND T2.TRXDT > '20241231'
                       AND T2.GJDT IN (
                                       SELECT
                                            T1.BIZ_DT
                                       FROM
                                            (
                                             SELECT
                                                  T1.BIZ_DT
                                             FROM
                                                  MAP_JOB_DATE T1
                                             WHERE 1=1
                                                  AND T1.BIZ_DT <= '20241231'
                                                  AND T1.DT_G = 0
                                             ORDER BY
                                                  T1.BIZ_DT DESC
                                            ) T1
                                       WHERE 1=1
                                            AND ROWNUM < 7
                                      )
                       AND T2.SIGUMGO_TRX_G = 11
                 ) T1
         )  X
WHERE
         X.RNUM > 0 AND X.RNUM <= 2000


-------------------------------------------------

SELECT
                       T2.TRXDT AS KEORAEIL
                      ,T2.GJDT AS KIJUNIL
                      ,T2.GISDT AS KISANIL
                      ,T2.TRXNO AS GEORAE_SEQ
                      ,T2.CRT_CAN_G AS JEONGJEONG
                      ,DECODE(T2.IPJI_G, 1, DECODE(T2.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T2.TRAMT, 0) AS IPGEUM_AMT
                      ,DECODE(T2.IPJI_G, 1, 0, DECODE(T2.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T2.TRAMT) AS JIGEUB_AMT
                      ,T2.CMMT_CTNT AS JUKYO
                      ,T2.SIGUMGO_TRX_G AS GEORAE_GUBUN
                      ,T2.SIGUMGO_IP_TRX_G AS IPGEUM_GEORAE
                      ,T2.SIGUMGO_TAX_IP_MNG_NO AS HANDO_GYEJWA
                  FROM
                       ACL_SIGUMGO_MAS T1
                      ,ACL_SIGUMGO_SLV T2
                  WHERE 1=1
                       AND T1.FIL_100_CTNT2 = T2.FIL_100_CTNT5
                       AND T1.SIGUMGO_ORG_C = '28'
                       AND DECODE(NVL('', '9999'), '9999', 1, DECODE(T1.ICH_SIGUMGO_GUN_GU_C, '', 1, 0)) = 1
                       AND T1.ICH_SIGUMGO_HOIKYE_C = '01'
                       AND T1.SIGUMGO_AC_B = 10
                       AND (
                            CASE
                                WHEN '0' = 1 THEN DECODE(T1.SIGUMGO_HOIKYE_YR, '9999', 1, SUBSTR('20241231', 1, 4), 1, 0)
                                WHEN '0' IN (8, 9) THEN DECODE(T1.SIGUMGO_HOIKYE_YR, SUBSTR('20241231', 1, 4) - 1, 1, 0)
                                WHEN '0' = 0 THEN DECODE(T1.SIGUMGO_HOIKYE_YR, '9999', 1, SUBSTR('20241231', 1, 4), 1, SUBSTR('20241231', 1, 4) - 1, 1, 0)
                                ELSE 0
                             END
                           ) = 1
                       AND T1.MNG_NO = 1
                       AND T2.TRXDT > '20241231'
                       AND T2.GJDT IN (
                                       SELECT
                                            T1.BIZ_DT
                                       FROM
                                            (
                                             SELECT
                                                  T1.BIZ_DT
                                             FROM
                                                  MAP_JOB_DATE T1
                                             WHERE 1=1
                                                  AND T1.BIZ_DT <= '20241231'
                                                  AND T1.DT_G = 0
                                             ORDER BY
                                                  T1.BIZ_DT DESC
                                            ) T1
                                       WHERE 1=1
                                            AND ROWNUM < 7
                                      )
                       AND T2.SIGUMGO_TRX_G = 11
                       AND T2.IMMD_PROC_DSYN <> 1