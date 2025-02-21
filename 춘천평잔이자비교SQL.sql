SELECT
    A.HOIGYE_CODE,
    A.GONGGEUM_GYEJWA,
    SUM(A.GONGGEUM) AS GONGGEUM,
    SUM(A.JUCHUK) AS JUCHUK,
    SUM(A.MMDA) AS MMDA,
    SUM(A.GONGGEUM_IJA) AS GONGGEUM_IJA,
    SUM(A.BOTONG_IJA) AS BOTONG_IJA,
    SUM(A.MMDA_IJA) AS MMDA_IJA,
    SUM(A.JUNGGI_IJA) AS JUNGGI_IJA,
    SUM(A.IJA) AS IJA
FROM (

SELECT A.HOIGYE_CODE,
             A.GONGGEUM_GYEJWA,
             A.GONGGEUM_GYEJWA_NM,
             SUM(A.GONGGEUM) AS GONGGEUM,
             SUM(A.JUCHUK)   AS JUCHUK,
             SUM(A.MMDA)     AS MMDA,
            0 AS GONGGEUM_IJA,
            0 AS BOTONG_IJA,
            0 AS MMDA_IJA,
            0 AS JUNGGI_IJA,
             0 AS IJA
      FROM (SELECT T2.HOIGYE_CODE
                 , T2.GONGGEUM_GYEJWA
                 , T2.GONGGEUM_GYEJWA_NM
                 , 0 AS GONGGEUM
                 , 0 AS JUCHUK
                 , 0 AS MMDA
            --, NVL(TRUNC(SUM(T1.GONGGEUM) / MAX(T3.DAYS_CNT), 0), 0) AS GONGGEUM
            --, NVL(TRUNC(SUM(T1.UNYONG) / MAX(T3.DAYS_CNT), 0), 0)   AS JUCHUK
            -- , NVL(TRUNC(SUM(T1.MMDA) / MAX(T3.DAYS_CNT), 0), 0)     AS MMDA
            FROM (SELECT T1.HOIGYE_CODE
                       , T1.GONGGEUM_GYEJWA
                       , T1.TRX_DT
                       , T1.BIZ_DT
                       , T1.JANAEK AS GONGGEUM
                       , 0         AS UNYONG
                       , 0         AS MMDA
                  FROM (SELECT T1.HOIGYE_CODE
                             , T1.GONGGEUM_GYEJWA
                             , T2.DW_BAS_DDT                                AS TRX_DT
                             , DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT) AS BIZ_DT
                             , T1.JANAEK
                        FROM RPT_GONGGEUM_JAN T1
                           , MAP_JOB_DATE T2
                        WHERE 1 = 1
                          AND T1.KEORAEIL = DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT)
                          AND T1.GEUMGO_CODE = '110'
                          AND T1.GUNGU_CODE = 0
                          AND T2.DW_BAS_DDT >= '20240101'
                          AND T2.DW_BAS_DDT <= '20241231') T1
                     , ACL_SIGUMGO_MAS T2
                     , RPT_AC_BY_HOIKYE_MAPP T3
                  WHERE 1 = 1
                    AND T1.GONGGEUM_GYEJWA = T2.FIL_100_CTNT2
                    AND T2.FIL_100_CTNT2 = T3.SIGUMGO_ACNO
                    AND T2.SIGUMGO_HOIKYE_YR = T3.SIGUMGO_HOIKYE_YR
                    AND T2.MNG_NO = 1
                    AND (
                            CASE
                                WHEN T2.SIGUMGO_HOIKYE_YR = '9999' AND SUBSTR(T1.TRX_DT, 1, 4) = '2024'
                                    THEN 1
                                WHEN T2.SIGUMGO_HOIKYE_YR = '2024'
                                    THEN 1
                                ELSE 0
                                END
                            ) = 1
                  UNION ALL
                  SELECT T1.HOIGYE_CODE
                       , T1.GONGGEUM_GYEJWA
                       , T1.TRX_DT
                       , T1.BIZ_DT
                       , 0 AS GONGGEUM
                       , CASE
                             WHEN '2024' > '2021'
                                 THEN
                                 CASE
                                     WHEN T1.TRX_DT >= NVL(T2.KIJUNIL, '99991231') THEN 0
                                     ELSE NVL(T1.JANAEK, 0)
                                     END
                             ELSE NVL(T1.JANAEK, 0)
                      END  AS UNYONG
                       , 0 AS MMDA
                  FROM (SELECT TO_NUMBER(T3.SIGUMGO_HOIKYE_C) AS HOIGYE_CODE
                             , T2.FIL_100_CTNT2               AS GONGGEUM_GYEJWA
                             , T1.TRX_DT
                             , T1.BIZ_DT
                             , T1.JANAEK
                             , T2.SIGUMGO_HOIKYE_YR           AS HOIGYE_YEAR
                             , CASE
                                   WHEN T2.SIGUMGO_HOIKYE_YR = '9999' AND T1.GONGGEUM_GYEJWA = T2.FIL_100_CTNT2
                                       THEN 'Y'
                                   WHEN T2.SIGUMGO_HOIKYE_YR = '2024' AND T1.GONGGEUM_GYEJWA <= T2.FIL_100_CTNT2
                                       THEN 'Y'
                                   ELSE 'N'
                          END                                 AS TRGT_YN
                        FROM (SELECT T2.GONGGEUM_GYEJWA
                                   , SUBSTR(T2.GONGGEUM_GYEJWA, 1, 15) AS GONGGEUM_GYEJWA_15
                                   , T1.JANAEK
                                   , T1.TRX_DT
                                   , T1.BIZ_DT
                                   , CASE
                                         WHEN T1.TRX_DT >= SUBSTR(NVL(T2.MKDT, T2.IN_DATE), 1, 8)
                                             AND T1.TRX_DT < NVL(T2.OUT_DATE, '99991231')
                                             AND T1.TRX_DT < NVL(T2.HJI_DT, '99991231')
                                             THEN 'Y'
                                         ELSE 'N'
                                END                                    AS TRGT_YN
                              FROM (SELECT T1.GONGGEUM_GYEJWA
                                         , T1.UNYONG_GYEJWA
                                         , T2.DW_BAS_DDT                                AS TRX_DT
                                         , DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT) AS BIZ_DT
                                         , T1.JANAEK
                                    FROM RPT_UNYONG_JAN T1
                                       , MAP_JOB_DATE T2
                                    WHERE 1 = 1
                                      AND T1.KIJUNIL = DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT)
                                      AND T1.GEUMGO_CODE = '110'
                                      AND T2.DW_BAS_DDT >= '20240101'
                                      AND T2.DW_BAS_DDT <= '20241231') T1
                                 , RPT_UNYONG_GYEJWA T2
                                 , (SELECT T1.FIL_100_CTNT2 AS GONGGEUM_GYEJWA
                                         , T2.KIJUNIL
                                    FROM ACL_SIGUMGO_MAS T1
                                       , (SELECT T1.SIGUMGO_ORG_C
                                               , T1.GONGGEUM_GYEJWA
                                               , T1.ICH_SIGUMGO_GUN_GU_C
                                               , T1.ICH_SIGUMGO_HOIKYE_C
                                               , T1.SIGUMGO_AC_B
                                               , T1.SIGUMGO_AC_SER
                                               , T1.SIGUMGO_HOIKYE_YR
                                               , T2.KIJUNIL
                                          FROM (SELECT T1.SIGUMGO_ORG_C
                                                     , T1.FIL_100_CTNT2 AS GONGGEUM_GYEJWA
                                                     , T1.ICH_SIGUMGO_GUN_GU_C
                                                     , T1.ICH_SIGUMGO_HOIKYE_C
                                                     , T1.SIGUMGO_AC_B
                                                     , T1.SIGUMGO_AC_SER
                                                     , T1.SIGUMGO_HOIKYE_YR
                                                FROM ACL_SIGUMGO_MAS T1
                                                WHERE 1 = 1
                                                  AND T1.SIGUMGO_ORG_C = '110'
                                                  AND T1.SIGUMGO_HOIKYE_YR = '2024'
                                                  AND T1.MNG_NO = 1) T1
                                             , RPT_HOIGYE_IWOL T2
                                          WHERE 1 = 1
                                            AND T1.SIGUMGO_ORG_C = T2.GEUMGO_CODE
                                            AND T1.ICH_SIGUMGO_GUN_GU_C = T2.GUNGU_CODE
                                            AND T1.SIGUMGO_HOIKYE_YR = TO_CHAR(T2.HOIGYE_YEAR + 1)
                                            AND T2.KIJUNIL <= '20241231'
                                            AND T2.HOIGYE_CODE IN (SELECT TO_NUMBER(T3.SIGUMGO_HOIKYE_C)
                                                                   FROM RPT_AC_BY_HOIKYE_MAPP T3
                                                                   WHERE 1 = 1
                                                                     AND T3.SIGUMGO_ACNO = T1.GONGGEUM_GYEJWA)) T2
                                    WHERE 1 = 1
                                      AND T1.SIGUMGO_ORG_C = T2.SIGUMGO_ORG_C
                                      AND T1.ICH_SIGUMGO_GUN_GU_C = T2.ICH_SIGUMGO_GUN_GU_C
                                      AND T1.ICH_SIGUMGO_HOIKYE_C = T2.ICH_SIGUMGO_HOIKYE_C
                                      AND T1.SIGUMGO_AC_B = T2.SIGUMGO_AC_B
                                      AND T1.SIGUMGO_AC_SER = T2.SIGUMGO_AC_SER
                                      AND T1.SIGUMGO_HOIKYE_YR < T2.SIGUMGO_HOIKYE_YR
                                      AND T1.SIGUMGO_ORG_C = '110'
                                      AND T1.MNG_NO = 1
                                    UNION
                                    SELECT T1.FIL_100_CTNT2 AS GONGGEUM_GYEJWA
                                         , '19000101'       AS KIJUNIL
                                    FROM ACL_SIGUMGO_MAS T1
                                    WHERE 1 = 1
                                      AND T1.SIGUMGO_ORG_C = '110'
                                      AND T1.MNG_NO = 1
                                      AND (
                                              CASE
                                                  WHEN T1.SIGUMGO_HOIKYE_YR = '9999' AND SUBSTR('20241231', 1, 4) = '2024'
                                                      THEN 1
                                                  WHEN T1.SIGUMGO_HOIKYE_YR = '2024'
                                                      THEN 1
                                                  ELSE 0
                                                  END
                                              ) = 1) T3
                              WHERE 1 = 1
                                AND T1.GONGGEUM_GYEJWA = T2.GONGGEUM_GYEJWA
                                AND T1.UNYONG_GYEJWA = T2.UNYONG_GYEJWA
                                AND T1.GONGGEUM_GYEJWA = T3.GONGGEUM_GYEJWA
                                AND T1.TRX_DT >= T3.KIJUNIL
                                AND T2.BANK_GUBUN = 0) T1
                           , ACL_SIGUMGO_MAS T2
                           , RPT_AC_BY_HOIKYE_MAPP T3
                        WHERE 1 = 1
                          AND T2.FIL_100_CTNT2 LIKE T1.GONGGEUM_GYEJWA_15 || '%'
                          AND T2.FIL_100_CTNT2 = T3.SIGUMGO_ACNO
                          AND T2.SIGUMGO_HOIKYE_YR = T3.SIGUMGO_HOIKYE_YR
                          AND T1.TRGT_YN = 'Y'
                          AND T2.MNG_NO = 1) T1
                     , (SELECT T1.KIJUNIL
                             , T1.HOIGYE_YEAR
                             , T1.HOIGYE_CODE
                             , T1.GUNGU_CODE
                             , T1.GEUMGO_CODE
                             , SUM(T1.AMT1) AS AMT2
                        FROM RPT_HOIGYE_IWOL T1
                        WHERE 1 = 1
                          AND '2024' > '2021'
                          AND T1.HOIGYE_YEAR = '2024'
                          AND T1.GEUMGO_CODE = '110'
                          AND T1.GUNGU_CODE = 0
                          AND GUBUN_CODE = 2
                        GROUP BY T1.KIJUNIL
                               , T1.HOIGYE_YEAR
                               , T1.HOIGYE_CODE
                               , T1.GUNGU_CODE
                               , T1.GEUMGO_CODE
                        HAVING SUM(T1.AMT1) > 0) T2
                  WHERE 1 = 1
                    AND T1.HOIGYE_CODE = T2.HOIGYE_CODE(+)
                    AND T1.HOIGYE_YEAR = T2.HOIGYE_YEAR(+)
                    AND T1.TRGT_YN = 'Y'
                  UNION ALL
                  SELECT T1.GONGGEUM_HOIGYE_CODE
                       , T1.GONGGEUM_GYEJWA
                       , T1.TRX_DT
                       , T1.BIZ_DT
                       , 0         AS GONGGEUM
                       , 0         AS UNYONG
                       , T2.JANAEK AS MMDA
                  FROM (SELECT DISTINCT T1.FIL_100_CTNT2               AS GONGGEUM_GYEJWA
                                      , TO_NUMBER(T2.SIGUMGO_HOIKYE_C) AS GONGGEUM_HOIGYE_CODE
                                      , T3.TRX_DT
                                      , T3.BIZ_DT
                                      , T3.DAYS_CNT
                        FROM ACL_SIGUMGO_MAS T1
                           , RPT_AC_BY_HOIKYE_MAPP T2
                           , (SELECT T1.DW_BAS_DDT                                AS TRX_DT
                                   , DECODE(T1.DT_G, 0, T1.BIZ_DT, T1.BF1_BIZ_DT) AS BIZ_DT
                                   , COUNT(1)                                        OVER() AS DAYS_CNT
                              FROM MAP_JOB_DATE T1
                              WHERE 1 = 1
                                AND T1.DW_BAS_DDT >= '20240101'
                                AND T1.DW_BAS_DDT <= '20241231') T3
                        WHERE 1 = 1
                          AND T1.FIL_100_CTNT2 = T2.SIGUMGO_ACNO
                          AND T1.SIGUMGO_HOIKYE_YR = T2.SIGUMGO_HOIKYE_YR
                          AND T1.SIGUMGO_ORG_C = '110'
                          AND (
                                  CASE
                                      WHEN T1.SIGUMGO_HOIKYE_YR = '9999' AND SUBSTR(T3.TRX_DT, 1, 4) = '2024'
                                          THEN 1
                                      WHEN T1.SIGUMGO_HOIKYE_YR = '2024'
                                          THEN 1
                                      ELSE 0
                                      END
                                  ) = 1) T1
                     , RPT_UNYONG_JAN T2
                  WHERE 1 = 1
                    AND T1.GONGGEUM_GYEJWA = T2.GONGGEUM_GYEJWA
                    AND T1.BIZ_DT = T2.KIJUNIL
                    AND T2.UNYONG_GYEJWA = '000000000000'
                  UNION ALL
                  SELECT T1.HOIGYE_CODE
                       , T1.GONGGEUM_GYEJWA
                       , T1.TRX_DT
                       , T1.BIZ_DT
                       , 0         AS GONGGEUM
                       , T2.JANAEK AS UNYONG
                       , 0         AS MMDA
                  FROM (SELECT T2.GONGGEUM_GYEJWA
                             , T2.UNYONG_GYEJWA
                             , T1.HOIGYE_CODE
                             , T1.TRX_DT
                             , T1.BIZ_DT
                             , T1.DAYS_CNT
                        FROM (SELECT T1.REF_D_C + 900 AS HOIGYE_CODE
                                   , T1.REF_D_NM      AS GONGGEUM_GYEJWA
                                   , T2.TRX_DT
                                   , T2.BIZ_DT
                                   , T2.DAYS_CNT
                              FROM RPT_CODE_INFO T1
                                 , (SELECT T1.DW_BAS_DDT                                AS TRX_DT
                                         , DECODE(T1.DT_G, 0, T1.BIZ_DT, T1.BF1_BIZ_DT) AS BIZ_DT
                                         , COUNT(1)                                        OVER() AS DAYS_CNT
                                    FROM MAP_JOB_DATE T1
                                    WHERE 1 = 1
                                      AND T1.DW_BAS_DDT >= '20240101'
                                      AND T1.DW_BAS_DDT <= '20241231') T2
                              WHERE 1 = 1
                                AND T1.REF_L_C = 50
                                AND T1.REF_M_C = '110'
                                AND T1.YUHYO_YN = 0) T1
                           , RPT_UNYONG_GYEJWA T2
                        WHERE 1 = 1
                          AND T1.GONGGEUM_GYEJWA = T2.GONGGEUM_GYEJWA
                          AND T1.TRX_DT >= SUBSTR(NVL(T2.MKDT, T2.IN_DATE), 1, 8)
                          AND T1.TRX_DT < NVL(T2.OUT_DATE, '99991231')
                          AND T1.TRX_DT < NVL(T2.HJI_DT, '99991231')
                          AND SUBSTR(T1.TRX_DT, 1, 4) = '2024'
                          AND T2.BANK_GUBUN = 0) T1
                     , RPT_UNYONG_JAN T2
                  WHERE 1 = 1
                    AND T1.GONGGEUM_GYEJWA = T2.GONGGEUM_GYEJWA
                    AND T1.UNYONG_GYEJWA = T2.UNYONG_GYEJWA
                    AND T1.BIZ_DT = T2.KIJUNIL) T1
               , (SELECT TO_NUMBER(T2.SIGUMGO_HOIKYE_C) AS HOIGYE_CODE
                       , T1.FIL_100_CTNT2               AS GONGGEUM_GYEJWA
                       , T1.SIGUMGO_AC_NM               AS GONGGEUM_GYEJWA_NM
                       , T1.SIGUMGO_HOIKYE_YR           AS GONGGEUM_HOIGYE_YEAR
                  FROM ACL_SIGUMGO_MAS T1
                     , RPT_AC_BY_HOIKYE_MAPP T2
                  WHERE 1 = 1
                    AND T1.FIL_100_CTNT2 = T2.SIGUMGO_ACNO
                    AND T1.SIGUMGO_HOIKYE_YR = T2.SIGUMGO_HOIKYE_YR
                    AND T1.SIGUMGO_ORG_C = '110'
                    AND T1.SIGUMGO_HOIKYE_YR IN ('2024', '9999')
                    AND T1.MNG_NO = 1
                  UNION ALL
                  SELECT 900 + T1.REF_D_C AS HOIGYE_CODE
                       , T1.REF_D_NM      AS GONGGEUM_GYEJWA
                       , T1.REF_CTNT1     AS GONGGEUM_GYEJWA_NM
                       , '9999'           AS GONGGEUM_HOIGYE_YEAR
                  FROM RPT_CODE_INFO T1
                  WHERE 1 = 1
                    AND '110' = 110
                    AND T1.REF_L_C = 50
                    AND T1.REF_M_C = '110') T2
               , (SELECT COUNT(1) AS DAYS_CNT
                  FROM MAP_JOB_DATE T1
                  WHERE 1 = 1
                    AND T1.DW_BAS_DDT >= '20240101'
                    AND T1.DW_BAS_DDT <= '20241231') T3
            WHERE 1 = 1
              AND T1.GONGGEUM_GYEJWA(+) = T2.GONGGEUM_GYEJWA
              AND DECODE('110', 439, T2.GONGGEUM_HOIGYE_YEAR, 440, T2.GONGGEUM_HOIGYE_YEAR, 1) =
                  DECODE('110', 439, '2024', 440, '2024', 1)

            GROUP BY T2.HOIGYE_CODE
                   , T1.GONGGEUM_GYEJWA
                   , T2.GONGGEUM_GYEJWA
                   , T2.GONGGEUM_GYEJWA_NM
                   , T2.GONGGEUM_HOIGYE_YEAR

            UNION ALL

            SELECT T2.HOIGYE_CODE
                 , T2.GONGGEUM_GYEJWA
                 , T2.GONGGEUM_GYEJWA_NM
                 , NVL(TRUNC(SUM(T1.GONGGEUM) / MAX(T3.DAYS_CNT), 0), 0) AS GONGGEUM
                 , NVL(TRUNC(SUM(T1.UNYONG) / MAX(T3.DAYS_CNT), 0), 0)   AS JUCHUK
                 , NVL(TRUNC(SUM(T1.MMDA) / MAX(T3.DAYS_CNT), 0), 0)     AS MMDA
            FROM (SELECT T1.HOIGYE_CODE
                       , T1.GONGGEUM_GYEJWA
                       , T1.TRX_DT
                       , T1.BIZ_DT
                       , T1.JANAEK AS GONGGEUM
                       , 0         AS UNYONG
                       , 0         AS MMDA
                  FROM (SELECT T1.HOIGYE_CODE
                             , T1.GONGGEUM_GYEJWA
                             , T2.DW_BAS_DDT                                AS TRX_DT
                             , DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT) AS BIZ_DT
                             , T1.JANAEK
                        FROM RPT_GONGGEUM_JAN T1
                           , MAP_JOB_DATE T2
                        WHERE 1 = 1
                          AND T1.KEORAEIL = DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT)
                          AND T1.GEUMGO_CODE = '110'
                          AND T1.GUNGU_CODE = 0
                          AND T2.DW_BAS_DDT >= '20240101'
                          AND T2.DW_BAS_DDT <= '20241231') T1
                     , ACL_SIGUMGO_MAS T2
                     , RPT_AC_BY_HOIKYE_MAPP T3
                  WHERE 1 = 1
                    AND T1.GONGGEUM_GYEJWA = T2.FIL_100_CTNT2
                    AND T2.FIL_100_CTNT2 = T3.SIGUMGO_ACNO
                    AND T2.SIGUMGO_HOIKYE_YR = T3.SIGUMGO_HOIKYE_YR
                    AND T2.MNG_NO = 1
                    AND (
                            CASE
                                WHEN T2.SIGUMGO_HOIKYE_YR = '9999' AND SUBSTR(T1.TRX_DT, 1, 4) = '2023'
                                    THEN 1
                                WHEN T2.SIGUMGO_HOIKYE_YR = '2023'
                                    THEN 1
                                ELSE 0
                                END
                            ) = 1
                  UNION ALL
                  SELECT T1.HOIGYE_CODE
                       , T1.GONGGEUM_GYEJWA
                       , T1.TRX_DT
                       , T1.BIZ_DT
                       , 0 AS GONGGEUM
                       , CASE
                             WHEN '2023' > '2021'
                                 THEN
                                 CASE
                                     WHEN T1.TRX_DT >= NVL(T2.KIJUNIL, '99991231') THEN 0
                                     ELSE NVL(T1.JANAEK, 0)
                                     END
                             ELSE NVL(T1.JANAEK, 0)
                      END  AS UNYONG
                       , 0 AS MMDA
                  FROM (SELECT TO_NUMBER(T3.SIGUMGO_HOIKYE_C) AS HOIGYE_CODE
                             , T2.FIL_100_CTNT2               AS GONGGEUM_GYEJWA
                             , T1.TRX_DT
                             , T1.BIZ_DT
                             , T1.JANAEK
                             , T2.SIGUMGO_HOIKYE_YR           AS HOIGYE_YEAR
                             , CASE
                                   WHEN T2.SIGUMGO_HOIKYE_YR = '9999' AND T1.GONGGEUM_GYEJWA = T2.FIL_100_CTNT2
                                       THEN 'Y'
                                   WHEN T2.SIGUMGO_HOIKYE_YR = '2023' AND T1.GONGGEUM_GYEJWA <= T2.FIL_100_CTNT2
                                       THEN 'Y'
                                   ELSE 'N'
                          END                                 AS TRGT_YN
                        FROM (SELECT T2.GONGGEUM_GYEJWA
                                   , SUBSTR(T2.GONGGEUM_GYEJWA, 1, 15) AS GONGGEUM_GYEJWA_15
                                   , T1.JANAEK
                                   , T1.TRX_DT
                                   , T1.BIZ_DT
                                   , CASE
                                         WHEN T1.TRX_DT >= SUBSTR(NVL(T2.MKDT, T2.IN_DATE), 1, 8)
                                             AND T1.TRX_DT < NVL(T2.OUT_DATE, '99991231')
                                             AND T1.TRX_DT < NVL(T2.HJI_DT, '99991231')
                                             THEN 'Y'
                                         ELSE 'N'
                                END                                    AS TRGT_YN
                              FROM (SELECT T1.GONGGEUM_GYEJWA
                                         , T1.UNYONG_GYEJWA
                                         , T2.DW_BAS_DDT                                AS TRX_DT
                                         , DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT) AS BIZ_DT
                                         , T1.JANAEK
                                    FROM RPT_UNYONG_JAN T1
                                       , MAP_JOB_DATE T2
                                    WHERE 1 = 1
                                      AND T1.KIJUNIL = DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT)
                                      AND T1.GEUMGO_CODE = '110'
                                      AND T2.DW_BAS_DDT >= '20240101'
                                      AND T2.DW_BAS_DDT <= '20241231') T1
                                 , RPT_UNYONG_GYEJWA T2
                                 , (SELECT T1.FIL_100_CTNT2 AS GONGGEUM_GYEJWA
                                         , T2.KIJUNIL
                                    FROM ACL_SIGUMGO_MAS T1
                                       , (SELECT T1.SIGUMGO_ORG_C
                                               , T1.GONGGEUM_GYEJWA
                                               , T1.ICH_SIGUMGO_GUN_GU_C
                                               , T1.ICH_SIGUMGO_HOIKYE_C
                                               , T1.SIGUMGO_AC_B
                                               , T1.SIGUMGO_AC_SER
                                               , T1.SIGUMGO_HOIKYE_YR
                                               , T2.KIJUNIL
                                          FROM (SELECT T1.SIGUMGO_ORG_C
                                                     , T1.FIL_100_CTNT2 AS GONGGEUM_GYEJWA
                                                     , T1.ICH_SIGUMGO_GUN_GU_C
                                                     , T1.ICH_SIGUMGO_HOIKYE_C
                                                     , T1.SIGUMGO_AC_B
                                                     , T1.SIGUMGO_AC_SER
                                                     , T1.SIGUMGO_HOIKYE_YR
                                                FROM ACL_SIGUMGO_MAS T1
                                                WHERE 1 = 1
                                                  AND T1.SIGUMGO_ORG_C = '110'
                                                  AND T1.SIGUMGO_HOIKYE_YR = '2023'
                                                  AND T1.MNG_NO = 1) T1
                                             , RPT_HOIGYE_IWOL T2
                                          WHERE 1 = 1
                                            AND T1.SIGUMGO_ORG_C = T2.GEUMGO_CODE
                                            AND T1.ICH_SIGUMGO_GUN_GU_C = T2.GUNGU_CODE
                                            AND T1.SIGUMGO_HOIKYE_YR = TO_CHAR(T2.HOIGYE_YEAR + 1)
                                            AND T2.KIJUNIL <= '20241231'
                                            AND T2.HOIGYE_CODE IN (SELECT TO_NUMBER(T3.SIGUMGO_HOIKYE_C)
                                                                   FROM RPT_AC_BY_HOIKYE_MAPP T3
                                                                   WHERE 1 = 1
                                                                     AND T3.SIGUMGO_ACNO = T1.GONGGEUM_GYEJWA)) T2
                                    WHERE 1 = 1
                                      AND T1.SIGUMGO_ORG_C = T2.SIGUMGO_ORG_C
                                      AND T1.ICH_SIGUMGO_GUN_GU_C = T2.ICH_SIGUMGO_GUN_GU_C
                                      AND T1.ICH_SIGUMGO_HOIKYE_C = T2.ICH_SIGUMGO_HOIKYE_C
                                      AND T1.SIGUMGO_AC_B = T2.SIGUMGO_AC_B
                                      AND T1.SIGUMGO_AC_SER = T2.SIGUMGO_AC_SER
                                      AND T1.SIGUMGO_HOIKYE_YR < T2.SIGUMGO_HOIKYE_YR
                                      AND T1.SIGUMGO_ORG_C = '110'
                                      AND T1.MNG_NO = 1
                                    UNION
                                    SELECT T1.FIL_100_CTNT2 AS GONGGEUM_GYEJWA
                                         , '19000101'       AS KIJUNIL
                                    FROM ACL_SIGUMGO_MAS T1
                                    WHERE 1 = 1
                                      AND T1.SIGUMGO_ORG_C = '110'
                                      AND T1.MNG_NO = 1
                                      AND (
                                              CASE
                                                  WHEN T1.SIGUMGO_HOIKYE_YR = '9999' AND SUBSTR('20241231', 1, 4) = '2023'
                                                      THEN 1
                                                  WHEN T1.SIGUMGO_HOIKYE_YR = '2023'
                                                      THEN 1
                                                  ELSE 0
                                                  END
                                              ) = 1) T3
                              WHERE 1 = 1
                                AND T1.GONGGEUM_GYEJWA = T2.GONGGEUM_GYEJWA
                                AND T1.UNYONG_GYEJWA = T2.UNYONG_GYEJWA
                                AND T1.GONGGEUM_GYEJWA = T3.GONGGEUM_GYEJWA
                                AND T1.TRX_DT >= T3.KIJUNIL
                                AND T2.BANK_GUBUN = 0) T1
                           , ACL_SIGUMGO_MAS T2
                           , RPT_AC_BY_HOIKYE_MAPP T3
                        WHERE 1 = 1
                          AND T2.FIL_100_CTNT2 LIKE T1.GONGGEUM_GYEJWA_15 || '%'
                          AND T2.FIL_100_CTNT2 = T3.SIGUMGO_ACNO
                          AND T2.SIGUMGO_HOIKYE_YR = T3.SIGUMGO_HOIKYE_YR
                          AND T1.TRGT_YN = 'Y'
                          AND T2.MNG_NO = 1) T1
                     , (SELECT T1.KIJUNIL
                             , T1.HOIGYE_YEAR
                             , T1.HOIGYE_CODE
                             , T1.GUNGU_CODE
                             , T1.GEUMGO_CODE
                             , SUM(T1.AMT1) AS AMT2
                        FROM RPT_HOIGYE_IWOL T1
                        WHERE 1 = 1
                          AND '2023' > '2021'
                          AND T1.HOIGYE_YEAR = '2023'
                          AND T1.GEUMGO_CODE = '110'
                          AND T1.GUNGU_CODE = 0
                          AND GUBUN_CODE = 2
                        GROUP BY T1.KIJUNIL
                               , T1.HOIGYE_YEAR
                               , T1.HOIGYE_CODE
                               , T1.GUNGU_CODE
                               , T1.GEUMGO_CODE
                        HAVING SUM(T1.AMT1) > 0) T2
                  WHERE 1 = 1
                    AND T1.HOIGYE_CODE = T2.HOIGYE_CODE(+)
                    AND T1.HOIGYE_YEAR = T2.HOIGYE_YEAR(+)
                    AND T1.TRGT_YN = 'Y'
                  UNION ALL
                  SELECT T1.GONGGEUM_HOIGYE_CODE
                       , T1.GONGGEUM_GYEJWA
                       , T1.TRX_DT
                       , T1.BIZ_DT
                       , 0         AS GONGGEUM
                       , 0         AS UNYONG
                       , T2.JANAEK AS MMDA
                  FROM (SELECT DISTINCT T1.FIL_100_CTNT2               AS GONGGEUM_GYEJWA
                                      , TO_NUMBER(T2.SIGUMGO_HOIKYE_C) AS GONGGEUM_HOIGYE_CODE
                                      , T3.TRX_DT
                                      , T3.BIZ_DT
                                      , T3.DAYS_CNT
                        FROM ACL_SIGUMGO_MAS T1
                           , RPT_AC_BY_HOIKYE_MAPP T2
                           , (SELECT T1.DW_BAS_DDT                                AS TRX_DT
                                   , DECODE(T1.DT_G, 0, T1.BIZ_DT, T1.BF1_BIZ_DT) AS BIZ_DT
                                   , COUNT(1)                                        OVER() AS DAYS_CNT
                              FROM MAP_JOB_DATE T1
                              WHERE 1 = 1
                                AND T1.DW_BAS_DDT >= '20240101'
                                AND T1.DW_BAS_DDT <= '20241231') T3
                        WHERE 1 = 1
                          AND T1.FIL_100_CTNT2 = T2.SIGUMGO_ACNO
                          AND T1.SIGUMGO_HOIKYE_YR = T2.SIGUMGO_HOIKYE_YR
                          AND T1.SIGUMGO_ORG_C = '110'
                          AND (
                                  CASE
                                      WHEN T1.SIGUMGO_HOIKYE_YR = '9999' AND SUBSTR(T3.TRX_DT, 1, 4) = '2023'
                                          THEN 1
                                      WHEN T1.SIGUMGO_HOIKYE_YR = '2023'
                                          THEN 1
                                      ELSE 0
                                      END
                                  ) = 1) T1
                     , RPT_UNYONG_JAN T2
                  WHERE 1 = 1
                    AND T1.GONGGEUM_GYEJWA = T2.GONGGEUM_GYEJWA
                    AND T1.BIZ_DT = T2.KIJUNIL
                    AND T2.UNYONG_GYEJWA = '000000000000'
                  UNION ALL
                  SELECT T1.HOIGYE_CODE
                       , T1.GONGGEUM_GYEJWA
                       , T1.TRX_DT
                       , T1.BIZ_DT
                       , 0         AS GONGGEUM
                       , T2.JANAEK AS UNYONG
                       , 0         AS MMDA
                  FROM (SELECT T2.GONGGEUM_GYEJWA
                             , T2.UNYONG_GYEJWA
                             , T1.HOIGYE_CODE
                             , T1.TRX_DT
                             , T1.BIZ_DT
                             , T1.DAYS_CNT
                        FROM (SELECT T1.REF_D_C + 900 AS HOIGYE_CODE
                                   , T1.REF_D_NM      AS GONGGEUM_GYEJWA
                                   , T2.TRX_DT
                                   , T2.BIZ_DT
                                   , T2.DAYS_CNT
                              FROM RPT_CODE_INFO T1
                                 , (SELECT T1.DW_BAS_DDT                                AS TRX_DT
                                         , DECODE(T1.DT_G, 0, T1.BIZ_DT, T1.BF1_BIZ_DT) AS BIZ_DT
                                         , COUNT(1)                                        OVER() AS DAYS_CNT
                                    FROM MAP_JOB_DATE T1
                                    WHERE 1 = 1
                                      AND T1.DW_BAS_DDT >= '20240101'
                                      AND T1.DW_BAS_DDT <= '20241231') T2
                              WHERE 1 = 1
                                AND T1.REF_L_C = 50
                                AND T1.REF_M_C = '110'
                                AND T1.YUHYO_YN = 0) T1
                           , RPT_UNYONG_GYEJWA T2
                        WHERE 1 = 1
                          AND T1.GONGGEUM_GYEJWA = T2.GONGGEUM_GYEJWA
                          AND T1.TRX_DT >= SUBSTR(NVL(T2.MKDT, T2.IN_DATE), 1, 8)
                          AND T1.TRX_DT < NVL(T2.OUT_DATE, '99991231')
                          AND T1.TRX_DT < NVL(T2.HJI_DT, '99991231')
                          AND SUBSTR(T1.TRX_DT, 1, 4) = '2023'
                          AND T2.BANK_GUBUN = 0) T1
                     , RPT_UNYONG_JAN T2
                  WHERE 1 = 1
                    AND T1.GONGGEUM_GYEJWA = T2.GONGGEUM_GYEJWA
                    AND T1.UNYONG_GYEJWA = T2.UNYONG_GYEJWA
                    AND T1.BIZ_DT = T2.KIJUNIL) T1
               , (SELECT TO_NUMBER(T2.SIGUMGO_HOIKYE_C) AS HOIGYE_CODE
                       , T1.FIL_100_CTNT2               AS GONGGEUM_GYEJWA
                       , T1.SIGUMGO_AC_NM               AS GONGGEUM_GYEJWA_NM
                       , T1.SIGUMGO_HOIKYE_YR           AS GONGGEUM_HOIGYE_YEAR
                  FROM ACL_SIGUMGO_MAS T1
                     , RPT_AC_BY_HOIKYE_MAPP T2
                  WHERE 1 = 1
                    AND T1.FIL_100_CTNT2 = T2.SIGUMGO_ACNO
                    AND T1.SIGUMGO_HOIKYE_YR = T2.SIGUMGO_HOIKYE_YR
                    AND T1.SIGUMGO_ORG_C = '110'
                    AND T1.SIGUMGO_HOIKYE_YR IN ('2023', '9999')
                    AND T1.MNG_NO = 1
                  UNION ALL
                  SELECT 900 + T1.REF_D_C AS HOIGYE_CODE
                       , T1.REF_D_NM      AS GONGGEUM_GYEJWA
                       , T1.REF_CTNT1     AS GONGGEUM_GYEJWA_NM
                       , '9999'           AS GONGGEUM_HOIGYE_YEAR
                  FROM RPT_CODE_INFO T1
                  WHERE 1 = 1
                    AND '110' = 110
                    AND T1.REF_L_C = 50
                    AND T1.REF_M_C = '110') T2
               , (SELECT COUNT(1) AS DAYS_CNT
                  FROM MAP_JOB_DATE T1
                  WHERE 1 = 1
                    AND T1.DW_BAS_DDT >= '20240101'
                    AND T1.DW_BAS_DDT <= '20241231') T3
            WHERE 1 = 1
              AND T1.GONGGEUM_GYEJWA(+) = T2.GONGGEUM_GYEJWA
              AND DECODE('110'
                      , 439
                      , T2.GONGGEUM_HOIGYE_YEAR
                      , 440
                      , T2.GONGGEUM_HOIGYE_YEAR
                      , 1) = DECODE('110'
                      , 439
                      , '2023'
                      , 440
                      , '2023'
                      , 1)

            GROUP BY T2.HOIGYE_CODE
                   , T1.GONGGEUM_GYEJWA
                   , T2.GONGGEUM_GYEJWA
                   , T2.GONGGEUM_GYEJWA_NM
                   , T2.GONGGEUM_HOIGYE_YEAR) A
      GROUP BY A.HOIGYE_CODE
             , A.GONGGEUM_GYEJWA
             , A.GONGGEUM_GYEJWA_NM

      UNION ALL

SELECT
    A.HOIGYE_CODE,
    A.GONGGEUM_GYEJWA,
    A.HOIGYE_NAME AS GONGGEUM_GYEJWA_NM,
    0 AS GONGGEUM,
    0 AS JUCHUK,
    0 AS MMDA,
    SUM(A.GONGGEUM_IJA) AS GONGGEUM_IJA,
    SUM(A.BOTONG_IJA) AS BOTONG_IJA,
    SUM(A.MMDA_IJA) AS MMDA_IJA,
    SUM(A.JUNGGI_IJA) AS JUNGGI_IJA,
    SUM(A.IJA) AS IJA
FROM (
SELECT A.HOIGYE_CODE
           , A.HOIGYE_NAME
           , A.GONGGEUM_GYEJWA
           , 0 AS GONGGEUM_IJA
           , 0 AS BOTONG_IJA
           , 0 AS MMDA_IJA
           , 0 AS JUNGGI_IJA
           , 0 AS IJA
--      , SUM(CASE WHEN KWA = '160' THEN A.JI_IJA ELSE 0 END) AS GONGGEUM_IJA
--      , SUM(CASE WHEN KWA = '100' THEN A.JI_IJA ELSE 0 END) AS BOTONG_IJA
--      , SUM(CASE WHEN KWA = '140' THEN A.JI_IJA ELSE 0 END) AS MMDA_IJA
--      , SUM(CASE WHEN KWA BETWEEN '200' AND '299' THEN A.JI_IJA ELSE 0 END) AS JUNGGI_IJA
--      , SUM(A.JI_IJA) AS IJA
      FROM (WITH WT_GYEJWA_INFO AS
                     (SELECT T2.SIGUMGO_C                   AS GONGGEUM_GEUMGO_CD
                           , T2.SIGUMGO_HOIKYE_YR           AS GONGGEUM_HOIGYE_YEAR
                           , T2.SIGUMGO_ACNO                AS GONGGEUM_GYEJWA
                           , TO_NUMBER(T2.SIGUMGO_HOIKYE_C) AS GONGGEUM_HOIGYE_CODE
                           , T3.HOIKYE_NM                   AS HOIGYE_NAME
                      FROM RPT_AC_BY_HOIKYE_MAPP T2
                               INNER JOIN RPT_HOIKYE_CD T3
                                          ON T2.SIGUMGO_C = T3.SIGUMGO_C
                                              AND T2.SIGUMGO_HOIKYE_C = T3.SIGUMGO_HOIKYE_C
                                              AND T3.SIGUMGO_HOIKYE_C != 98
                AND T3.USE_YN = 'Y'
            WHERE T2.SIGUMGO_C = '110') SELECT
    B.GONGGEUM_HOIGYE_CODE HOIGYE_CODE,
    B.HOIGYE_NAME,
    B.GONGGEUM_GYEJWA,
    '' AS GYEJWA_NAME,
    A.UNYONG_GYEJWA,
    D.SANGPUM_NAME,
    D.MKDT,
    A.DUDT,
    A.IYUL,
    A.JANAEK,
    TRIM(A.KIJUNIL) KIJUNIL,
    A.JI_IJA,
    SUBSTR(A.UNYONG_GYEJWA,1,3) AS KWA
      FROM RPT_UNYONG_JAN A, WT_GYEJWA_INFO B, RPT_HOIGYE_IWOL C, RPT_UNYONG_GYEJWA D
      WHERE A.GONGGEUM_GYEJWA = B.GONGGEUM_GYEJWA
        AND A.GONGGEUM_GYEJWA = D.GONGGEUM_GYEJWA
        AND A.UNYONG_GYEJWA = D.UNYONG_GYEJWA
        AND A.KIJUNIL BETWEEN '20240101'
        AND '20241231'
        AND A.GEUMGO_CODE = '110'
        AND A.GEUMGO_CODE = B.GONGGEUM_GEUMGO_CD
        AND A.GEUMGO_CODE = D.GEUMGO_CODE
        AND B.GONGGEUM_HOIGYE_CODE = C.HOIGYE_CODE(+)
        AND B.GONGGEUM_HOIGYE_YEAR = C.HOIGYE_YEAR(+)
        AND B.GONGGEUM_GEUMGO_CD = C.GEUMGO_CODE(+)
        AND C.GUBUN_CODE(+) = 1
        AND ('ALL' = NVL(''
          , 'ALL')
         OR B.GONGGEUM_HOIGYE_CODE IN (''))
        AND A.JI_IJA
          > 0
        AND (
          'ALL' = NVL('2024'
          , 'ALL')
         OR
          (
          CASE WHEN B.GONGGEUM_HOIGYE_YEAR = 9999 THEN SUBSTR(A.KIJUNIL
          , 1
          , 4)
          WHEN B.GONGGEUM_HOIGYE_YEAR=SUBSTR(A.KIJUNIL
          , 1
          , 4) THEN B.GONGGEUM_HOIGYE_YEAR
          WHEN SUBSTR(A.KIJUNIL
          , 1
          , 8) >= C.KIJUNIL THEN TO_CHAR(B.GONGGEUM_HOIGYE_YEAR + 1)
          WHEN SUBSTR(A.KIJUNIL
          , 1
          , 8)
          < C.KIJUNIL THEN B.GONGGEUM_HOIGYE_YEAR
          ELSE B.GONGGEUM_HOIGYE_YEAR END
          ) = '2024')
        AND ('ALL' = NVL(''
          , 'ALL')
         OR B.GONGGEUM_GYEJWA = '')
        AND ('ALL' = NVL(''
          , 'ALL')
         OR B.GONGGEUM_HOIGYE_CODE IN (''))

      UNION ALL

      SELECT A.GONGGEUM_HOIGYE_CODE HOIGYE_CODE, A.HOIGYE_NAME, A.GONGGEUM_GYEJWA, '', '', '', '', '', 0, 0, '', 0, ''
      FROM WT_GYEJWA_INFO A
      WHERE 1 = 1
        AND ( ('ALL' = NVL('2024'
          , 'ALL'))
         OR (A.GONGGEUM_HOIGYE_YEAR = '2024')
         OR (A.GONGGEUM_HOIGYE_YEAR='9999'
        AND SUBSTR('20240101'
          , 1
          , 4) = '2024'))
        AND ('ALL' = NVL(''
          , 'ALL')
         OR A.GONGGEUM_HOIGYE_CODE IN (''))
        AND ('ALL' = NVL(''
          , 'ALL')
         OR A.GONGGEUM_GYEJWA = '')

      UNION ALL

      SELECT A.HOIGYE_CODE, A.HOIGYE_NAME, A.GONGGEUM_GYEJWA, A.GYEJWA_NAME, B.UNYONG_GYEJWA, B.SANGPUM_NAME, C.MKDT, C.DUDT, C.IYUL, C.JANAEK, TRIM (C.KIJUNIL) KIJUNIL, C.JI_IJA, SUBSTR(B.UNYONG_GYEJWA, 1, 3) KWA
      FROM (SELECT A.REF_D_NM GONGGEUM_GYEJWA, A.REF_CTNT1 GYEJWA_NAME, A.REF_CTNT1 HOIGYE_NAME, A.REF_S_C MNGBR, TO_NUMBER(SUBSTR(A.REF_D_NM, 4, 3)) GUNGU_CODE, A.REF_D_C + 900 HOIGYE_CODE, 99 GYEJWA_BUNRYU
          FROM RPT_CODE_INFO A
          WHERE A.REF_L_C = 50
          AND A.REF_M_C = '110'
          AND A.YUHYO_YN = 0 ) A
              , RPT_UNYONG_GYEJWA B
              , RPT_UNYONG_JAN C
      WHERE A.GONGGEUM_GYEJWA = B.GONGGEUM_GYEJWA
        AND B.GONGGEUM_GYEJWA = C.GONGGEUM_GYEJWA
        AND A.GONGGEUM_GYEJWA = B.GONGGEUM_GYEJWA
        AND B.UNYONG_GYEJWA = C.UNYONG_GYEJWA
        AND SUBSTR(NVL(B.MKDT
          , B.IN_DATE)
          , 1
          , 8) <= '20241231'
        AND (B.OUT_DATE IS NULL
         OR B.OUT_DATE
          > '20240101' )
        AND (B.HJI_DT IS NULL
         OR B.HJI_DT
          > '20240101')
        AND B.BANK_GUBUN = 0
        AND C.KIJUNIL BETWEEN '20240101'
        AND '20241231'
        AND C.JI_IJA
          > 0
        AND ('ALL' = NVL('2024'
          , 'ALL')
         OR SUBSTR('20240101'
          , 1
          , 4) = '2024')
        AND ('ALL' = NVL(''
          , 'ALL')
         OR A.GONGGEUM_GYEJWA = '')
        AND ('ALL' = NVL(''
          , 'ALL')
         OR A.HOIGYE_CODE IN (''))

      UNION ALL

      SELECT A.REF_D_C + 900 HOIGYE_CODE, A.REF_CTNT1 HOIGYE_NAME, A.REF_D_NM GONGGEUM_GYEJWA, '', '', '', '', '', 0, 0, '', 0, ''
      FROM RPT_CODE_INFO A
      WHERE A.REF_L_C = 50
        AND A.REF_M_C = '110'
        AND ('ALL' = NVL('2024'
          , 'ALL')
         OR SUBSTR('20240101'
          , 1
          , 4) = '2024')
        AND ('ALL' = NVL(''
          , 'ALL')
         OR A.REF_D_NM = '')
        AND ('ALL' = NVL(''
          , 'ALL')
         OR (A.REF_D_C + 900) IN (''))

      UNION ALL

      SELECT
          C.GONGGEUM_HOIGYE_CODE, C.HOIGYE_NAME, C.GONGGEUM_GYEJWA, '', '', '', '', '', 0, 0, '', A.IJA AS JI_IJA, '160' AS KWA
      FROM RPT_GONGGEUM_GYULSAN_TMP A, WT_GYEJWA_INFO C
      WHERE A.GEUMGO_CODE = '110'
        AND A.GYULSAN_IL IN (SELECT REF_S_NM FROM RPT_CODE_INFO WHERE REF_L_C = 200
        AND REF_M_C = 999
        AND REF_S_NM BETWEEN '20240101'
        AND '20241231')
        AND A.GONGGEUM_GYEJWA = C.GONGGEUM_GYEJWA
        AND A.IJA
          > 0
        AND ('ALL' = NVL('2024'
          , 'ALL')
         OR SUBSTR(A.GONGGEUM_GYEJWA
          , 16
          , 2) IN (SUBSTR('2024'
          , 3
          , 2)
          , 99))) A
GROUP BY A.HOIGYE_CODE, A.HOIGYE_NAME, A.GONGGEUM_GYEJWA

UNION ALL

SELECT A.HOIGYE_CODE
     , A.HOIGYE_NAME
     , A.GONGGEUM_GYEJWA
     , SUM(CASE WHEN KWA = '160' THEN A.JI_IJA ELSE 0 END) AS GONGGEUM_IJA
     , SUM(CASE WHEN KWA = '100' THEN A.JI_IJA ELSE 0 END) AS BOTONG_IJA
     , SUM(CASE WHEN KWA = '140' THEN A.JI_IJA ELSE 0 END) AS MMDA_IJA
     , SUM(CASE WHEN KWA BETWEEN '200' AND '299' THEN A.JI_IJA ELSE 0 END) AS JUNGGI_IJA
     , SUM(A.JI_IJA) AS IJA
FROM (
         WITH WT_GYEJWA_INFO AS
                  (
                      SELECT T2.SIGUMGO_C AS GONGGEUM_GEUMGO_CD
                           , T2.SIGUMGO_HOIKYE_YR AS GONGGEUM_HOIGYE_YEAR
                           , T2.SIGUMGO_ACNO AS GONGGEUM_GYEJWA
                           , TO_NUMBER(T2.SIGUMGO_HOIKYE_C) AS GONGGEUM_HOIGYE_CODE
                           , T3.HOIKYE_NM AS HOIGYE_NAME
                      FROM  RPT_AC_BY_HOIKYE_MAPP T2
                                INNER JOIN RPT_HOIKYE_CD T3
                                           ON T2.SIGUMGO_C = T3.SIGUMGO_C
                                               AND T2.SIGUMGO_HOIKYE_C = T3.SIGUMGO_HOIKYE_C
                                               AND T3.SIGUMGO_HOIKYE_C != 98
             AND T3.USE_YN = 'Y'
         WHERE T2.SIGUMGO_C = '110'
     )
    SELECT
          B.GONGGEUM_HOIGYE_CODE HOIGYE_CODE,
          B.HOIGYE_NAME,
          B.GONGGEUM_GYEJWA,
          '' AS GYEJWA_NAME,
          A.UNYONG_GYEJWA,
          D.SANGPUM_NAME,
          D.MKDT,
          A.DUDT,
          A.IYUL,
          A.JANAEK,
          TRIM(A.KIJUNIL) KIJUNIL,
          A.JI_IJA,
          SUBSTR(A.UNYONG_GYEJWA,1,3) AS KWA
FROM RPT_UNYONG_JAN A, WT_GYEJWA_INFO B, RPT_HOIGYE_IWOL C, RPT_UNYONG_GYEJWA D
WHERE A.GONGGEUM_GYEJWA = B.GONGGEUM_GYEJWA
  AND A.GONGGEUM_GYEJWA = D.GONGGEUM_GYEJWA
  AND A.UNYONG_GYEJWA = D.UNYONG_GYEJWA
  AND A.KIJUNIL BETWEEN '20240101' AND '20241231'
  AND A.GEUMGO_CODE = '110'
  AND A.GEUMGO_CODE = B.GONGGEUM_GEUMGO_CD
  AND A.GEUMGO_CODE = D.GEUMGO_CODE
  AND B.GONGGEUM_HOIGYE_CODE = C.HOIGYE_CODE(+)
  AND B.GONGGEUM_HOIGYE_YEAR = C.HOIGYE_YEAR(+)
  AND B.GONGGEUM_GEUMGO_CD = C.GEUMGO_CODE(+)
  AND C.GUBUN_CODE(+) = 1
  AND ('ALL' = NVL('','ALL') OR B.GONGGEUM_HOIGYE_CODE IN (''))
  AND A.JI_IJA > 0
  AND (
    'ALL' = NVL('2023','ALL')
   OR
    (
    CASE WHEN B.GONGGEUM_HOIGYE_YEAR = 9999 THEN SUBSTR(A.KIJUNIL,1,4)
    WHEN B.GONGGEUM_HOIGYE_YEAR=SUBSTR(A.KIJUNIL,1,4) THEN B.GONGGEUM_HOIGYE_YEAR
    WHEN SUBSTR(A.KIJUNIL,1,8) >= C.KIJUNIL THEN TO_CHAR(B.GONGGEUM_HOIGYE_YEAR + 1)
    WHEN SUBSTR(A.KIJUNIL,1,8) <  C.KIJUNIL THEN B.GONGGEUM_HOIGYE_YEAR
    ELSE B.GONGGEUM_HOIGYE_YEAR END
    ) = '2023')
  AND ('ALL' = NVL('','ALL') OR B.GONGGEUM_GYEJWA = '')
  AND ('ALL' = NVL('','ALL') OR B.GONGGEUM_HOIGYE_CODE IN (''))

UNION ALL

SELECT A.GONGGEUM_HOIGYE_CODE HOIGYE_CODE, A.HOIGYE_NAME,
    A.GONGGEUM_GYEJWA,
    '', '', '',
    '', '', 0, 0, '', 0, ''
FROM WT_GYEJWA_INFO A
WHERE 1 = 1
  AND (   ('ALL' = NVL('2023','ALL'))
   OR (A.GONGGEUM_HOIGYE_YEAR = '2023')
   OR (A.GONGGEUM_HOIGYE_YEAR='9999' AND SUBSTR('20240101',1,4) = '2023'))
  AND ('ALL' = NVL('','ALL') OR A.GONGGEUM_HOIGYE_CODE IN (''))
  AND ('ALL' = NVL('','ALL') OR A.GONGGEUM_GYEJWA  = '')

UNION ALL

SELECT A.HOIGYE_CODE, A.HOIGYE_NAME, A.GONGGEUM_GYEJWA, A.GYEJWA_NAME,
    B.UNYONG_GYEJWA, B.SANGPUM_NAME,
    C.MKDT, C.DUDT, C.IYUL, C.JANAEK, TRIM(C.KIJUNIL) KIJUNIL,
    C.JI_IJA, SUBSTR(B.UNYONG_GYEJWA,1,3) KWA
FROM (SELECT A.REF_D_NM GONGGEUM_GYEJWA, A.REF_CTNT1 GYEJWA_NAME,
    A.REF_CTNT1 HOIGYE_NAME, A.REF_S_C MNGBR,
    TO_NUMBER(SUBSTR(A.REF_D_NM,4,3)) GUNGU_CODE,
    A.REF_D_C + 900 HOIGYE_CODE, 99 GYEJWA_BUNRYU
    FROM  RPT_CODE_INFO A
    WHERE A.REF_L_C = 50
    AND A.REF_M_C = '110'
    AND A.YUHYO_YN = 0 ) A
        , RPT_UNYONG_GYEJWA B
        , RPT_UNYONG_JAN C
WHERE A.GONGGEUM_GYEJWA = B.GONGGEUM_GYEJWA
  AND B.GONGGEUM_GYEJWA = C.GONGGEUM_GYEJWA
  AND A.GONGGEUM_GYEJWA = B.GONGGEUM_GYEJWA
  AND B.UNYONG_GYEJWA = C.UNYONG_GYEJWA
  AND SUBSTR(NVL(B.MKDT,B.IN_DATE),1,8) <= '20241231'
  AND (B.OUT_DATE IS NULL OR B.OUT_DATE > '20240101' )
  AND (B.HJI_DT IS NULL OR B.HJI_DT > '20240101')
  AND B.BANK_GUBUN = 0
  AND C.KIJUNIL BETWEEN '20240101' AND '20241231'
  AND C.JI_IJA > 0
  AND ('ALL' = NVL('2023','ALL') OR SUBSTR('20240101',1,4) = '2023')
  AND ('ALL' = NVL('','ALL') OR A.GONGGEUM_GYEJWA = '')
  AND ('ALL' = NVL('','ALL') OR A.HOIGYE_CODE IN (''))

UNION ALL

SELECT A.REF_D_C + 900 HOIGYE_CODE, A.REF_CTNT1 HOIGYE_NAME,
    A.REF_D_NM GONGGEUM_GYEJWA, '', '',
    '', '', '', 0, 0, '', 0, ''
FROM RPT_CODE_INFO A
WHERE A.REF_L_C = 50
  AND A.REF_M_C = '110'
  AND ('ALL' = NVL('2023','ALL') OR SUBSTR('20240101',1,4) = '2023')
  AND ('ALL' = NVL('','ALL') OR A.REF_D_NM = '')
  AND ('ALL' = NVL('','ALL') OR (A.REF_D_C + 900) IN (''))

UNION ALL

SELECT
    C.GONGGEUM_HOIGYE_CODE, C.HOIGYE_NAME,
    C.GONGGEUM_GYEJWA, '',  '',
    '', '', '', 0, 0, '', A.IJA AS JI_IJA, '160' AS KWA
FROM RPT_GONGGEUM_GYULSAN_TMP A, WT_GYEJWA_INFO C
WHERE A.GEUMGO_CODE = '110'
  AND A.GYULSAN_IL IN (SELECT REF_S_NM FROM RPT_CODE_INFO WHERE REF_L_C = 200 AND REF_M_C = 999 AND REF_S_NM BETWEEN '20240101' AND '20241231')
  AND A.GONGGEUM_GYEJWA = C.GONGGEUM_GYEJWA
  AND A.IJA  > 0
  AND ('ALL' = NVL('2023','ALL') OR SUBSTR(A.GONGGEUM_GYEJWA,16,2) IN (SUBSTR('2023',3,2),99))

     ) A
WHERE GONGGEUM_GYEJWA NOT LIKE '%99'
GROUP BY A.HOIGYE_CODE, A.HOIGYE_NAME, A.GONGGEUM_GYEJWA

) A
GROUP BY A.HOIGYE_CODE, A.GONGGEUM_GYEJWA, A.HOIGYE_NAME

     ) A
GROUP BY A.HOIGYE_CODE
        , A.GONGGEUM_GYEJWA
ORDER BY A.HOIGYE_CODE
       , A.GONGGEUM_GYEJWA
