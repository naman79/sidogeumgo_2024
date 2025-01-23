SELECT X.G_GYEJWA,
           X.GONGGEUM_BRNO,
           X.G_HOIGYE_YEAR,
           X.GONGGEUM_GUNGU_CODE,
           X.GONGGEUM_GEUMGO_CD,
           TO_NUMBER(X.GONGGEUM_HOIGYE_CODE) GONGGEUM_HOIGYE_CODE,
           X.GONGGEUM_GYEJWA_CD
FROM    (SELECT TRIM(X.FIL_100_CTNT2) G_GYEJWA,
                       X.AC_GRBRNO GONGGEUM_BRNO,
                       X.SIGUMGO_HOIKYE_YR G_HOIGYE_YEAR,
                       X.ICH_SIGUMGO_GUN_GU_C GONGGEUM_GUNGU_CODE,
                       X.SIGUMGO_ORG_C GONGGEUM_GEUMGO_CD,
                       CASE
                          WHEN SIGUMGO_C != 28 THEN NVL(Y.SIGUMGO_HOIKYE_C, TO_CHAR(X.ICH_SIGUMGO_HOIKYE_C))
                          ELSE TO_CHAR(X.ICH_SIGUMGO_HOIKYE_C)
                       END AS GONGGEUM_HOIGYE_CODE,
                       CASE
                          WHEN SIGUMGO_C != 28
                                 AND SIGUMGO_AC_B != 80 THEN 0
                          ELSE X.SIGUMGO_AC_B
                       END AS GONGGEUM_GYEJWA_CD
            FROM    ACL_SIGUMGO_MAS X,
                       RPT_AC_BY_HOIKYE_MAPP Y
            WHERE   ( ( X.SIGUMGO_HOIKYE_YR BETWEEN TO_CHAR(TO_NUMBER(TO_CHAR(SYSDATE, 'YYYY')) - 1) AND TO_CHAR(SYSDATE, 'YYYY') )
                           OR ( X.SIGUMGO_HOIKYE_YR = '9999' ) )
                       AND X.SIGUMGO_ORG_C NOT IN ( 21, 41, 302, 312, 322, 901 )
                       AND MNG_NO = 1
                       AND X.FIL_100_CTNT2 = Y.SIGUMGO_ACNO (+)) X  
ORDER BY X.G_HOIGYE_YEAR


----------------------------------------------

    select * from acl_sigumgo_slv
    where 1=1
    and fil_100_ctnt5 = '13000080900000199'
    and trxdt = '20250120'
    order by trxno desc

    select
        FIL_100_CTNT5,
        SUM(DECODE(CRT_CAN_G,1,-1,2,-1,33,-1,1) * DECODE(IPJI_G,1,TRAMT,0)) AS IP_AMT,
        SUM(DECODE(CRT_CAN_G,1,-1,2,-1,33,-1,1) * DECODE(IPJI_G,2,TRAMT,0)) AS JI_AMT,
        SUM(DECODE(CRT_CAN_G,1,-1,2,-1,33,-1,1) * DECODE(IPJI_G,2,-1,1) * TRAMT) AS AMT
    from acl_sigumgo_slv
    where 1=1
    and fil_100_ctnt5 = '13000080900000199'
    GROUP BY FIL_100_CTNT5



     -- LINKAC_JAN : 588,905,438

    SELECT * FROM RPT_GONGGEUM_JAN
    WHERE GONGGEUM_GYEJWA = '13000080900000199'
    ORDER BY KEORAEIL DESC




--- 오류로그 마지막 라인
01/22 02:14:16.044 [main/INFO/2025012202000355502-000] =  <ERROR> 잔액검증 오류
01/22 02:14:16.044 [main/INFO/2025012202000355502-000] =        - 공금계좌[13000080900000199]
01/22 02:14:16.044 [main/INFO/2025012202000355502-000] =        - 코어잔액[588,905,438]
01/22 02:14:16.044 [main/INFO/2025012202000355502-000] =        - 단위잔액[579,613,118]


SELECT
 GONGGEUM_GYEJWA,
 KEORAEIL,
 JANAEK
FROM RPT_GONGGEUM_JAN
WHERE GONGGEUM_GYEJWA = '02800001100000024'
ORDER BY KEORAEIL DESC


SELECT
    A.FIL_100_CTNT5 AS GONGGEUM_GYEJWA,
    A.TRXDT AS KEORAEIL,
    A.LINKAC_JAN AS JANAEK,
FROM
    ACL_SIGUMGO_SLV A
INNER JOIN (
    SELECT
        FIL_100_CTNT5,
        TRXDT,
        MAX(TRXNO) AS MAX_TRXNO
    FROM
        ACL_SIGUMGO_SLV
    WHERE
        FIL_100_CTNT5 = '02800001100000024'
    GROUP BY FIL_100_CTNT5, TRXDT
) B
ON A.FIL_100_CTNT5 = B.FIL_100_CTNT5
   AND A.TRXDT = B.TRXDT
   AND A.TRXNO = B.MAX_TRXNO
WHERE
    A.FIL_100_CTNT5 = '02800001100000024'
ORDER BY
    A.TRXDT DESC

----------------------------------------------------------------

WITH CombinedData AS (
    -- 첫 번째 쿼리
    SELECT
        GONGGEUM_GYEJWA,
        KEORAEIL,
        JANAEK,
        'RPT_GONGGEUM_JAN' AS SOURCE
    FROM RPT_GONGGEUM_JAN
    WHERE GONGGEUM_GYEJWA = '02800001100000024'

    UNION ALL

    SELECT
              A.GONGGEUM_GYEJWA,
              A.KIJUNIL AS KEORAEIL,
              SUM(A.BFJAN  +  A.IPGEUM_AMT  -  A.JIGEUB_AMT)
                      OVER  (PARTITION  BY  A.GONGGEUM_GYEJWA  ORDER  BY  A.KIJUNIL)  JANEAK,
                'RPT_GONGGEUM_JAN_TRXDT' AS SOURCE
FROM  (
        SELECT  A.KIJUNIL,
                      A.GONGGEUM_GYEJWA,
                      SUM(A.IPGEUM_AMT)  IPGEUM_AMT,
                      SUM(A.JIGEUB_AMT)  JIGEUB_AMT,
                      SUM(A.BFJAN)  BFJAN,
                      A.GEUMGO_CODE
        FROM  (
                          SELECT  A.TRXDT  KIJUNIL,    /*  공금거래  입지  발췌  */
                                        A.FIL_100_CTNT5  GONGGEUM_GYEJWA,
                                        DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)  *  DECODE(IPJI_G,'1',A.TRAMT,0)    IPGEUM_AMT,
                                        DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)  *  DECODE(IPJI_G,'2',A.TRAMT,0)    JIGEUB_AMT,
                                        0  BFJAN,
                                        A.SIGUMGO_ORG_C  GEUMGO_CODE
                          FROM  ACL_SIGUMGO_SLV  A
                          WHERE  A.FIL_100_CTNT5  =  '02800001100000024'
                              AND  A.TRXDT>=  '20070205'
                          UNION  ALL
                          SELECT  A.DW_BAS_DDT  KIJUNIL,
                                        '02800001100000024'  AS  GONGGEUM_GYEJWA,
                                        0  IPGEUM_AMT,
                                        0  JIGEUB_AMT,
                                        0  BFJAN,
                                        28  AS  GEUMGO_CODE
                          FROM  MAP_JOB_DATE  A
                          WHERE  A.DW_BAS_DDT  BETWEEN  '20231222'  AND  TO_CHAR(SYSDATE,  'YYYYMMDD')
                          UNION  ALL  /*  신규  후  거래가  하나도  없어도  잔액이  생성될  수  있도록  0원  잔액  추가  */
                          SELECT  TO_CHAR(SYSDATE,  'YYYYMMDD')  KIJUNIL,
                                        '02800001100000024'  AS  GONGGEUM_GYEJWA,
                                        0  IPGEUM_AMT,
                                        0  JIGEUB_AMT,
                                        0  BFJAN,
                                        28  AS  GEUMGO_CODE
                          FROM  DUAL
                  )  A
                  GROUP  BY  A.KIJUNIL,  A.GONGGEUM_GYEJWA,  A.GEUMGO_CODE
)  A
WHERE  A.GONGGEUM_GYEJWA  =  '02800001100000024'
    AND  A.GEUMGO_CODE    =  28


    UNION ALL

    -- 두 번째 쿼리
    SELECT
        A.FIL_100_CTNT5 AS GONGGEUM_GYEJWA,
        A.TRXDT AS KEORAEIL,
        A.LINKAC_JAN AS JANAEK,
        'ACL_SIGUMGO_SLV' AS SOURCE
    FROM
        ACL_SIGUMGO_SLV A
    INNER JOIN (
        SELECT
            FIL_100_CTNT5,
            TRXDT,
            MAX(TRXNO) AS MAX_TRXNO
        FROM
            ACL_SIGUMGO_SLV
        WHERE
            FIL_100_CTNT5 = '02800001100000024'
        GROUP BY FIL_100_CTNT5, TRXDT
    ) B
    ON A.FIL_100_CTNT5 = B.FIL_100_CTNT5
       AND A.TRXDT = B.TRXDT
       AND A.TRXNO = B.MAX_TRXNO
    WHERE
        A.FIL_100_CTNT5 = '02800001100000024'
)
SELECT
    KEORAEIL,
    MAX(CASE WHEN SOURCE = 'RPT_GONGGEUM_JAN' THEN JANAEK ELSE 0 END) AS RPT_JANAEK,
    MAX(CASE WHEN SOURCE = 'RPT_GONGGEUM_JAN_TRXDT' THEN JANAEK ELSE 0 END) AS RPT_JANAEK_TRXDT,
    MAX(CASE WHEN SOURCE = 'ACL_SIGUMGO_SLV' THEN JANAEK ELSE 0 END) AS SIGUMGO_JANAEK,
    (MAX(CASE WHEN SOURCE = 'RPT_GONGGEUM_JAN' THEN JANAEK ELSE 0 END) - MAX(CASE WHEN SOURCE = 'ACL_SIGUMGO_SLV' THEN JANAEK ELSE 0 END)) AS DIFF1,
    (MAX(CASE WHEN SOURCE = 'RPT_GONGGEUM_JAN_TRXDT' THEN JANAEK ELSE 0 END) - MAX(CASE WHEN SOURCE = 'ACL_SIGUMGO_SLV' THEN JANAEK ELSE 0 END)) AS DIFF2
FROM
    CombinedData
GROUP BY KEORAEIL
ORDER BY
    KEORAEIL DESC
------------------------------------------------------

WITH CombinedData AS (
    -- 첫 번째 쿼리
    SELECT
        GONGGEUM_GYEJWA,
        KEORAEIL,
        JANAEK,
        'RPT_GONGGEUM_JAN' AS SOURCE
    FROM RPT_GONGGEUM_JAN
    WHERE GONGGEUM_GYEJWA = '02800022100000099'

    UNION ALL

    -- 두 번째 쿼리
    SELECT
        A.FIL_100_CTNT5 AS GONGGEUM_GYEJWA,
        A.TRXDT AS KEORAEIL,
        A.LINKAC_JAN AS JANAEK,
        'ACL_SIGUMGO_SLV' AS SOURCE
    FROM
        ACL_SIGUMGO_SLV A
    INNER JOIN (
        SELECT
            FIL_100_CTNT5,
            TRXDT,
            MAX(TRXNO) AS MAX_TRXNO
        FROM
            ACL_SIGUMGO_SLV
        WHERE
            FIL_100_CTNT5 = '02800022100000099'
        GROUP BY FIL_100_CTNT5, TRXDT
    ) B
    ON A.FIL_100_CTNT5 = B.FIL_100_CTNT5
       AND A.TRXDT = B.TRXDT
       AND A.TRXNO = B.MAX_TRXNO
    WHERE
        A.FIL_100_CTNT5 = '02800022100000099'
)
SELECT
    KEORAEIL,
    MAX(CASE WHEN SOURCE = 'RPT_GONGGEUM_JAN' THEN JANAEK ELSE 0 END) AS RPT_JANAEK,
    MAX(CASE WHEN SOURCE = 'ACL_SIGUMGO_SLV' THEN JANAEK ELSE 0 END) AS SIGUMGO_JANAEK,
    (MAX(CASE WHEN SOURCE = 'RPT_GONGGEUM_JAN' THEN JANAEK ELSE 0 END) - MAX(CASE WHEN SOURCE = 'ACL_SIGUMGO_SLV' THEN JANAEK ELSE 0 END)) AS DIFF
FROM
    CombinedData
GROUP BY KEORAEIL
ORDER BY
    KEORAEIL DESC

------------------------------------------------------

WITH CombinedData AS (
    -- 첫 번째 쿼리
    SELECT
        GONGGEUM_GYEJWA,
        KEORAEIL,
        JANAEK,
        'RPT_GONGGEUM_JAN' AS SOURCE
    FROM RPT_GONGGEUM_JAN
    WHERE GONGGEUM_GYEJWA = '02800021100000099'

    UNION ALL

    -- 두 번째 쿼리
    SELECT
        A.FIL_100_CTNT5 AS GONGGEUM_GYEJWA,
        A.TRXDT AS KEORAEIL,
        A.LINKAC_JAN AS JANAEK,
        'ACL_SIGUMGO_SLV' AS SOURCE
    FROM
        ACL_SIGUMGO_SLV A
    INNER JOIN (
        SELECT
            FIL_100_CTNT5,
            TRXDT,
            MAX(TRXNO) AS MAX_TRXNO
        FROM
            ACL_SIGUMGO_SLV
        WHERE
            FIL_100_CTNT5 = '02800021100000099'
        GROUP BY FIL_100_CTNT5, TRXDT
    ) B
    ON A.FIL_100_CTNT5 = B.FIL_100_CTNT5
       AND A.TRXDT = B.TRXDT
       AND A.TRXNO = B.MAX_TRXNO
    WHERE
        A.FIL_100_CTNT5 = '02800021100000099'
)
SELECT
    KEORAEIL,
    MAX(CASE WHEN SOURCE = 'RPT_GONGGEUM_JAN' THEN JANAEK ELSE 0 END) AS RPT_JANAEK,
    MAX(CASE WHEN SOURCE = 'ACL_SIGUMGO_SLV' THEN JANAEK ELSE 0 END) AS SIGUMGO_JANAEK,
    (MAX(CASE WHEN SOURCE = 'RPT_GONGGEUM_JAN' THEN JANAEK ELSE 0 END) - MAX(CASE WHEN SOURCE = 'ACL_SIGUMGO_SLV' THEN JANAEK ELSE 0 END)) AS DIFF
FROM
    CombinedData
GROUP BY KEORAEIL
ORDER BY
    KEORAEIL DESC

------------------------------------------------------

WITH CombinedData AS (
    -- 첫 번째 쿼리
    SELECT
        GONGGEUM_GYEJWA,
        KEORAEIL,
        JANAEK,
        'RPT_GONGGEUM_JAN' AS SOURCE
    FROM RPT_GONGGEUM_JAN
    WHERE GONGGEUM_GYEJWA = '02810023100000099'

    UNION ALL

    -- 두 번째 쿼리
    SELECT
        A.FIL_100_CTNT5 AS GONGGEUM_GYEJWA,
        A.TRXDT AS KEORAEIL,
        A.LINKAC_JAN AS JANAEK,
        'ACL_SIGUMGO_SLV' AS SOURCE
    FROM
        ACL_SIGUMGO_SLV A
    INNER JOIN (
        SELECT
            FIL_100_CTNT5,
            TRXDT,
            MAX(TRXNO) AS MAX_TRXNO
        FROM
            ACL_SIGUMGO_SLV
        WHERE
            FIL_100_CTNT5 = '02810023100000099'
        GROUP BY FIL_100_CTNT5, TRXDT
    ) B
    ON A.FIL_100_CTNT5 = B.FIL_100_CTNT5
       AND A.TRXDT = B.TRXDT
       AND A.TRXNO = B.MAX_TRXNO
    WHERE
        A.FIL_100_CTNT5 = '02810023100000099'
)
SELECT
    KEORAEIL,
    MAX(CASE WHEN SOURCE = 'RPT_GONGGEUM_JAN' THEN JANAEK ELSE 0 END) AS RPT_JANAEK,
    MAX(CASE WHEN SOURCE = 'ACL_SIGUMGO_SLV' THEN JANAEK ELSE 0 END) AS SIGUMGO_JANAEK,
    (MAX(CASE WHEN SOURCE = 'RPT_GONGGEUM_JAN' THEN JANAEK ELSE 0 END) - MAX(CASE WHEN SOURCE = 'ACL_SIGUMGO_SLV' THEN JANAEK ELSE 0 END)) AS DIFF
FROM
    CombinedData
GROUP BY KEORAEIL
ORDER BY
    KEORAEIL DESC

------------------------------------------------------

WITH CombinedData AS (
    -- 첫 번째 쿼리
    SELECT
        GONGGEUM_GYEJWA,
        KEORAEIL,
        JANAEK,
        'RPT_GONGGEUM_JAN' AS SOURCE
    FROM RPT_GONGGEUM_JAN
    WHERE GONGGEUM_GYEJWA = '02800024100000099'

    UNION ALL

    -- 두 번째 쿼리
    SELECT
        A.FIL_100_CTNT5 AS GONGGEUM_GYEJWA,
        A.TRXDT AS KEORAEIL,
        A.LINKAC_JAN AS JANAEK,
        'ACL_SIGUMGO_SLV' AS SOURCE
    FROM
        ACL_SIGUMGO_SLV A
    INNER JOIN (
        SELECT
            FIL_100_CTNT5,
            TRXDT,
            MAX(TRXNO) AS MAX_TRXNO
        FROM
            ACL_SIGUMGO_SLV
        WHERE
            FIL_100_CTNT5 = '02800024100000099'
        GROUP BY FIL_100_CTNT5, TRXDT
    ) B
    ON A.FIL_100_CTNT5 = B.FIL_100_CTNT5
       AND A.TRXDT = B.TRXDT
       AND A.TRXNO = B.MAX_TRXNO
    WHERE
        A.FIL_100_CTNT5 = '02800024100000099'
)
SELECT
    KEORAEIL,
    MAX(CASE WHEN SOURCE = 'RPT_GONGGEUM_JAN' THEN JANAEK ELSE 0 END) AS RPT_JANAEK,
    MAX(CASE WHEN SOURCE = 'ACL_SIGUMGO_SLV' THEN JANAEK ELSE 0 END) AS SIGUMGO_JANAEK,
    (MAX(CASE WHEN SOURCE = 'RPT_GONGGEUM_JAN' THEN JANAEK ELSE 0 END) - MAX(CASE WHEN SOURCE = 'ACL_SIGUMGO_SLV' THEN JANAEK ELSE 0 END)) AS DIFF
FROM
    CombinedData
GROUP BY KEORAEIL
ORDER BY
    KEORAEIL DESC


----------------------------------------------------------------

    SELECT
        *
    FROM RPT_GONGGEUM_JAN
    WHERE GONGGEUM_GYEJWA = '02800001100000024'


---------------------------------------------------------------------------
-- 거래일 기준 잔액

SELECT
              A.GONGGEUM_GYEJWA,
              A.KIJUNIL AS KEORAEIL,
              SUM(A.BFJAN  +  A.IPGEUM_AMT  -  A.JIGEUB_AMT)
                      OVER  (PARTITION  BY  A.GONGGEUM_GYEJWA  ORDER  BY  A.KIJUNIL)  JANEAK
FROM  (
        SELECT  A.KIJUNIL,
                      A.GONGGEUM_GYEJWA,
                      SUM(A.IPGEUM_AMT)  IPGEUM_AMT,
                      SUM(A.JIGEUB_AMT)  JIGEUB_AMT,
                      SUM(A.BFJAN)  BFJAN,
                      A.GEUMGO_CODE
        FROM  (
                          SELECT  A.TRXDT  KIJUNIL,    /*  공금거래  입지  발췌  */
                                        A.FIL_100_CTNT5  GONGGEUM_GYEJWA,
                                        DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)  *  DECODE(IPJI_G,'1',A.TRAMT,0)    IPGEUM_AMT,
                                        DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)  *  DECODE(IPJI_G,'2',A.TRAMT,0)    JIGEUB_AMT,
                                        0  BFJAN,
                                        A.SIGUMGO_ORG_C  GEUMGO_CODE
                          FROM  ACL_SIGUMGO_SLV  A
                          WHERE  A.FIL_100_CTNT5  =  '02800001100000024'
                              AND  A.TRXDT>=  '20070205'
                          UNION  ALL
                          SELECT  A.DW_BAS_DDT  KIJUNIL,
                                        '02800001100000024'  AS  GONGGEUM_GYEJWA,
                                        0  IPGEUM_AMT,
                                        0  JIGEUB_AMT,
                                        0  BFJAN,
                                        28  AS  GEUMGO_CODE
                          FROM  MAP_JOB_DATE  A
                          WHERE  A.DW_BAS_DDT  BETWEEN  '20231222'  AND  TO_CHAR(SYSDATE,  'YYYYMMDD')
                          UNION  ALL  /*  신규  후  거래가  하나도  없어도  잔액이  생성될  수  있도록  0원  잔액  추가  */
                          SELECT  TO_CHAR(SYSDATE,  'YYYYMMDD')  KIJUNIL,
                                        '02800001100000024'  AS  GONGGEUM_GYEJWA,
                                        0  IPGEUM_AMT,
                                        0  JIGEUB_AMT,
                                        0  BFJAN,
                                        28  AS  GEUMGO_CODE
                          FROM  DUAL
                  )  A
                  GROUP  BY  A.KIJUNIL,  A.GONGGEUM_GYEJWA,  A.GEUMGO_CODE
)  A
WHERE  A.GONGGEUM_GYEJWA  =  '02800001100000024'
    AND  A.GEUMGO_CODE    =  28


-------------------------------------------------------------------


SELECT  A.KIJUNIL,
              A.GONGGEUM_GYEJWA,
              7127  AS  GONGGEUM_BRNO,
              A.GEUMGO_CODE,
              2024  AS  G_HOIGYE_YEAR,
              0  AS  GONGGEUM_GUNGU_CODE,
              1  AS  GONGGEUM_HOIGYE_CODE,
              10  AS  GONGGEUM_GYEJWA_CD,
              SUM(A.BFJAN  +  A.IPGEUM_AMT  -  A.JIGEUB_AMT)
                      OVER  (PARTITION  BY  A.GONGGEUM_GYEJWA  ORDER  BY  A.KIJUNIL)  JANEAK,
              A.IPGEUM_AMT,
              A.JIGEUB_AMT,
              SUM(A.BFJAN  +  A.IPGEUM_AMT  -  A.JIGEUB_AMT)
                      OVER  (PARTITION  BY  A.GONGGEUM_GYEJWA  ORDER  BY  A.KIJUNIL)
                      -  A.IPGEUM_AMT  +  A.JIGEUB_AMT  BFJAN
FROM  (
        SELECT  A.KIJUNIL,
                      A.GONGGEUM_GYEJWA,
                      SUM(A.IPGEUM_AMT)  IPGEUM_AMT,
                      SUM(A.JIGEUB_AMT)  JIGEUB_AMT,
                      SUM(A.BFJAN)  BFJAN,
                      A.GEUMGO_CODE
        FROM  (
                          SELECT  NVL(A.GISDT,A.TRXDT)  KIJUNIL,    /*  공금거래  입지  발췌  */
                                        A.FIL_100_CTNT5  GONGGEUM_GYEJWA,
                                        DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)  *  DECODE(IPJI_G,'1',A.TRAMT,0)    IPGEUM_AMT,
                                        DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)  *  DECODE(IPJI_G,'2',A.TRAMT,0)    JIGEUB_AMT,
                                        0  BFJAN,
                                        A.SIGUMGO_ORG_C  GEUMGO_CODE
                          FROM  ACL_SIGUMGO_SLV  A
                          WHERE  A.FIL_100_CTNT5  =  '02800001100000024'
                              AND  A.TRXDT>=  '20070205'
                          UNION  ALL
                          SELECT  A.DW_BAS_DDT  KIJUNIL,
                                        '02800001100000024'  AS  GONGGEUM_GYEJWA,
                                        0  IPGEUM_AMT,
                                        0  JIGEUB_AMT,
                                        0  BFJAN,
                                        28  AS  GEUMGO_CODE
                          FROM  MAP_JOB_DATE  A
                          WHERE  A.DW_BAS_DDT  BETWEEN  '20231222'  AND  TO_CHAR(SYSDATE,  'YYYYMMDD')
                          UNION  ALL  /*  신규  후  거래가  하나도  없어도  잔액이  생성될  수  있도록  0원  잔액  추가  */
                          SELECT  TO_CHAR(SYSDATE,  'YYYYMMDD')  KIJUNIL,
                                        '02800001100000024'  AS  GONGGEUM_GYEJWA,
                                        0  IPGEUM_AMT,
                                        0  JIGEUB_AMT,
                                        0  BFJAN,
                                        28  AS  GEUMGO_CODE
                          FROM  DUAL
                  )  A
                  GROUP  BY  A.KIJUNIL,  A.GONGGEUM_GYEJWA,  A.GEUMGO_CODE
)  A
WHERE  A.GONGGEUM_GYEJWA  =  '02800001100000024'
    AND  A.GEUMGO_CODE    =  28