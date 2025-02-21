WITH CUR_YEAR AS (
    SELECT T2.HOIGYE_CODE
         , T2.GONGGEUM_GYEJWA
         , T2.GONGGEUM_GYEJWA_NM
         , NVL(TRUNC(SUM(T1.GONGGEUM) / MAX(T3.DAYS_CNT), 0), 0) AS GONGGEUM
         , NVL(TRUNC(SUM(T1.UNYONG) / MAX(T3.DAYS_CNT), 0), 0)   AS JUCHUK
         , NVL(TRUNC(SUM(T1.MMDA) / MAX(T3.DAYS_CNT), 0), 0)     AS MMDA
         , T2.GONGGEUM_YUDONG_ACNO
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
                  AND T1.GEUMGO_CODE = '440'
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
    ) T1
       , (SELECT TO_NUMBER(T2.SIGUMGO_HOIKYE_C)                               AS HOIGYE_CODE
               , T1.FIL_100_CTNT2                                             AS GONGGEUM_GYEJWA
               , T1.SIGUMGO_AC_NM                                             AS GONGGEUM_GYEJWA_NM
               , T1.SIGUMGO_HOIKYE_YR                                         AS GONGGEUM_HOIGYE_YEAR
               , LPAD(T1.LINKAC_KWA_C, 3, '0') || LPAD(T1.LINK_ACSER, 9, '0') AS GONGGEUM_YUDONG_ACNO
          FROM ACL_SIGUMGO_MAS T1
             , RPT_AC_BY_HOIKYE_MAPP T2
          WHERE 1 = 1
            AND T1.FIL_100_CTNT2 = T2.SIGUMGO_ACNO
            AND T1.SIGUMGO_HOIKYE_YR = T2.SIGUMGO_HOIKYE_YR
            AND T1.SIGUMGO_ORG_C = '440'
            AND T1.MNG_NO = 1
            AND T1.FIL_100_CTNT2 <> '04200080900003999'
            AND (
                    CASE
                        WHEN '' IS NULL
                            THEN
                            CASE
                                WHEN T1.SIGUMGO_HOIKYE_YR IN ('2024', '9999')
                                    THEN 1
                                ELSE 0
                                END
                        ELSE DECODE(T1.SIGUMGO_HOIKYE_YR, '2024', 1, 0)
                        END
                    ) = 1) T2
       , (SELECT COUNT(1) AS DAYS_CNT
          FROM MAP_JOB_DATE T1
          WHERE 1 = 1
            AND T1.DW_BAS_DDT >= '20240101'
            AND T1.DW_BAS_DDT <= '20241231') T3
    WHERE 1 = 1
      AND T1.GONGGEUM_GYEJWA(+) = T2.GONGGEUM_GYEJWA

    GROUP BY T2.HOIGYE_CODE
           , T1.GONGGEUM_GYEJWA
           , T2.GONGGEUM_GYEJWA
           , T2.GONGGEUM_GYEJWA_NM
           , T2.GONGGEUM_HOIGYE_YEAR
           , T2.GONGGEUM_YUDONG_ACNO

),
    BEF_YEAR AS (

    SELECT T2.HOIGYE_CODE
         , T2.GONGGEUM_GYEJWA
         , T2.GONGGEUM_GYEJWA_NM
         , NVL(TRUNC(SUM(T1.GONGGEUM) / MAX(T3.DAYS_CNT), 0), 0) AS GONGGEUM
         , NVL(TRUNC(SUM(T1.UNYONG) / MAX(T3.DAYS_CNT), 0), 0)   AS JUCHUK
         , NVL(TRUNC(SUM(T1.MMDA) / MAX(T3.DAYS_CNT), 0), 0)     AS MMDA
         , T2.GONGGEUM_YUDONG_ACNO
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
                  AND T1.GEUMGO_CODE = '440'
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
    ) T1
       , (SELECT TO_NUMBER(T2.SIGUMGO_HOIKYE_C)                               AS HOIGYE_CODE
               , T1.FIL_100_CTNT2                                             AS GONGGEUM_GYEJWA
               , T1.SIGUMGO_AC_NM                                             AS GONGGEUM_GYEJWA_NM
               , T1.SIGUMGO_HOIKYE_YR                                         AS GONGGEUM_HOIGYE_YEAR
               , LPAD(T1.LINKAC_KWA_C, 3, '0') || LPAD(T1.LINK_ACSER, 9, '0') AS GONGGEUM_YUDONG_ACNO
          FROM ACL_SIGUMGO_MAS T1
             , RPT_AC_BY_HOIKYE_MAPP T2
          WHERE 1 = 1
            AND T1.FIL_100_CTNT2 = T2.SIGUMGO_ACNO
            AND T1.SIGUMGO_HOIKYE_YR = T2.SIGUMGO_HOIKYE_YR
            AND T1.SIGUMGO_ORG_C = '440'
            AND T1.MNG_NO = 1
            AND T1.FIL_100_CTNT2 <> '04200080900003999'
            AND (
                    CASE
                        WHEN '' IS NULL
                            THEN
                            CASE
                                WHEN T1.SIGUMGO_HOIKYE_YR IN ('2023', '9999')
                                    THEN 1
                                ELSE 0
                                END
                        ELSE DECODE(T1.SIGUMGO_HOIKYE_YR, '2023', 1, 0)
                        END
                    ) = 1) T2
       , (SELECT COUNT(1) AS DAYS_CNT
          FROM MAP_JOB_DATE T1
          WHERE 1 = 1
            AND T1.DW_BAS_DDT >= '20240101'
            AND T1.DW_BAS_DDT <= '20241231') T3
    WHERE 1 = 1
      AND T1.GONGGEUM_GYEJWA(+) = T2.GONGGEUM_GYEJWA

    GROUP BY T2.HOIGYE_CODE
           , T1.GONGGEUM_GYEJWA
           , T2.GONGGEUM_GYEJWA
           , T2.GONGGEUM_GYEJWA_NM
           , T2.GONGGEUM_HOIGYE_YEAR
           , T2.GONGGEUM_YUDONG_ACNO
)
SELECT
    T1.HOIGYE_CODE
     ,T1.GONGGEUM_GYEJWA
     ,T1.GONGGEUM_GYEJWA_NM
     ,SUM(T1.GONGGEUM) AS GONGGEUM
     ,SUM(T1.JUCHUK) AS JUCHUK
     ,SUM(T1.MMDA) AS MMDA
     ,T1.GONGGEUM_YUDONG_ACNO
FROM (
         SELECT
             CUR_YEAR.*
         FROM CUR_YEAR
         UNION ALL
         SELECT
             BEF_YEAR.*
         FROM BEF_YEAR

     ) T1
GROUP BY
    T1.HOIGYE_CODE
       ,T1.GONGGEUM_GYEJWA
       ,T1.GONGGEUM_GYEJWA_NM
       ,T1.GONGGEUM_YUDONG_ACNO
ORDER BY
    T1.HOIGYE_CODE
       ,T1.GONGGEUM_GYEJWA
       ,T1.GONGGEUM_GYEJWA_NM
       ,T1.GONGGEUM_YUDONG_ACNO


