-- 강릉시 금고운용현황(예치기간별)

SELECT
    T1000.GONGGEUM_GYEJWA_NO AS GYEJWA_NO
     , T1000.GONGGEUM_GYEJWA_NM AS GYEJWA_NM
     , ROUND(SUM(T1000.JANG_PYUNG_JAN / T2000.DCNT), 8) AS JANG_PYUNG_JAN
     , ROUND(SUM(T1000.JANG_GAJUNG_AMT) / SUM(T1000.JANG_PYUNG_JAN), 8) AS JANG_PYUNG_IYUL
     , MAX(T1000.JANG_MAX_IYUL) AS JANG_MAX_IYUL
     , MIN(T1000.JANG_MIN_IYUL) AS JANG_MIN_IYUL
     , ROUND(SUM(T1000.JUNG_PYUNG_JAN / T2000.DCNT), 8) AS JUNG_PYUNG_JAN
     , ROUND(SUM(T1000.JUNG_GAJUNG_AMT) / SUM(T1000.JUNG_PYUNG_JAN), 8) AS JUNG_PYUNG_IYUL
     , MAX(T1000.JUNG_MAX_IYUL) AS JUNG_MAX_IYUL
     , MIN(T1000.JUNG_MIN_IYUL) AS JUNG_MIN_IYUL
     , ROUND(SUM(T1000.DAN_PYUNG_JAN / T2000.DCNT), 8) AS DAN_PYUNG_JAN
     , ROUND(SUM(T1000.DAN_GAJUNG_AMT) / SUM(T1000.DAN_PYUNG_JAN), 8) AS DAN_PYUNG_IYUL
     , MAX(T1000.DAN_MAX_IYUL) AS DAN_MAX_IYUL
     , MIN(T1000.DAN_MIN_IYUL) AS DAN_MIN_IYUL
     , ROUND(SUM(T1000.ETC_PYUNG_JAN / T2000.DCNT), 8) AS ETC_PYUNG_JAN
     , ROUND(SUM(T1000.ETC_GAJUNG_AMT) / SUM(T1000.ETC_PYUNG_JAN), 8) AS ETC_PYUNG_IYUL
     , MAX(T1000.ETC_MAX_IYUL) AS ETC_MAX_IYUL
     , MIN(T1000.ETC_MIN_IYUL) AS ETC_MIN_IYUL
     , ROUND(SUM(T1000.JUCHUK_AMT / T2000.DCNT), 8) AS JUCHUK_AMT
     , ROUND(SUM(T1000.SUSI_AMT / T2000.DCNT), 8) AS SUSI_AMT
     , ROUND(SUM(T1000.JUCHUK_AMT / T2000.DCNT) + SUM(T1000.SUSI_AMT / T2000.DCNT), 8) AS HAPGYE
FROM (


    SELECT T20.SIGUMGO_ORG_C AS GEUMGO_CODE
         , T20.ICH_SIGUMGO_GUN_GU_C AS GUNGU_CODE
         , T10.GONGGEUM_GYEJWA AS GONGGEUM_GYEJWA_NO
         , T20.SIGUMGO_AC_NM AS GONGGEUM_GYEJWA_NM
         , NULL AS JANG_PYUNG_JAN
         , NULL AS JANG_GAJUNG_AMT
         , NULL AS JANG_MAX_IYUL
         , NULL AS JANG_MIN_IYUL
         , NULL AS JUNG_PYUNG_JAN
         , NULL AS JUNG_GAJUNG_AMT
         , NULL AS JUNG_MAX_IYUL
         , NULL AS JUNG_MIN_IYUL
         , NULL AS DAN_PYUNG_JAN
         , NULL AS DAN_GAJUNG_AMT
         , NULL AS DAN_MAX_IYUL
         , NULL AS DAN_MIN_IYUL
         , NULL AS ETC_PYUNG_JAN
         , NULL AS ETC_GAJUNG_AMT
         , NULL AS ETC_MAX_IYUL
         , NULL AS ETC_MIN_IYUL
         , NULL AS JUCHUK_AMT
         , SUM(T10.JANAEK) AS SUSI_AMT
    FROM (SELECT  /*+ INDEX(T1 RPT_GONGGEUM_JAN_IX_01) */
              T1.GONGGEUM_GYEJWA
               , SUM(T1.JANAEK) AS JANAEK
          FROM RPT_GONGGEUM_JAN T1
          WHERE T1.GEUMGO_CODE = 150
            AND T1.GUNGU_CODE = 0
            AND T1.KEORAEIL BETWEEN '20240101' AND '20241231'
            AND T1.JANAEK != 0
                                     AND T1.GONGGEUM_GYEJWA NOT IN ('04200080900003999')
          GROUP BY T1.GONGGEUM_GYEJWA
    ) T10
       , ACL_SIGUMGO_MAS T20
    WHERE 1 = 1
      AND T20.MNG_NO = 1
      AND T20.SIGUMGO_AGE_AC_G IN (0,1)
      AND T20.FIL_100_CTNT2(+) = T10.GONGGEUM_GYEJWA
    GROUP BY T20.SIGUMGO_ORG_C
           , T20.ICH_SIGUMGO_GUN_GU_C, T10.GONGGEUM_GYEJWA, T20.SIGUMGO_AC_NM


    UNION ALL


    SELECT NULL AS GEUMGO_CODE
         , NULL AS GUNGU_CODE
         , T100.GONGGEUM_GYEJWA AS GONGGEUM_GYEJWA_NO
         , T100.UNYONG_GYEJWA
         , T100.SIGUMGO_AC_NM AS GONGGEUM_GYEJWA_NM
         , SUM(DECODE(T100.GIGAN_GUBUN, '1', T100.JUCHUK_AMT)) AS JANG_PYUNG_JAN
         , SUM(DECODE(T100.GIGAN_GUBUN, '1', T100.JUCHUK_AMT * T200.IYUL)) AS JANG_GAJUNG_AMT
         , MAX(DECODE(T100.GIGAN_GUBUN, '1', DECODE(T200.IYUL, 0, NULL, T200.IYUL))) AS JANG_MAX_IYUL
         , MIN(DECODE(T100.GIGAN_GUBUN, '1', DECODE(T200.IYUL, 0, NULL, T200.IYUL))) AS JANG_MIN_IYUL
         , SUM(DECODE(T100.GIGAN_GUBUN, '2', T100.JUCHUK_AMT)) AS JUNG_PYUNG_JAN
         , SUM(DECODE(T100.GIGAN_GUBUN, '2', T100.JUCHUK_AMT * T200.IYUL)) AS JUNG_GAJUNG_AMT
         , MAX(DECODE(T100.GIGAN_GUBUN, '2', DECODE(T200.IYUL, 0, NULL, T200.IYUL))) AS JUNG_MAX_IYUL
         , MIN(DECODE(T100.GIGAN_GUBUN, '2', DECODE(T200.IYUL, 0, NULL, T200.IYUL))) AS JUNG_MIN_IYUL
         , SUM(DECODE(T100.GIGAN_GUBUN, '3', T100.JUCHUK_AMT)) AS DAN_PYUNG_JAN
         , SUM(DECODE(T100.GIGAN_GUBUN, '3', T100.JUCHUK_AMT * T200.IYUL)) AS DAN_GAJUNG_AMT
         , MAX(DECODE(T100.GIGAN_GUBUN, '3', DECODE(T200.IYUL, 0, NULL, T200.IYUL))) AS DAN_MAX_IYUL
         , MIN(DECODE(T100.GIGAN_GUBUN, '3', DECODE(T200.IYUL, 0, NULL, T200.IYUL))) AS DAN_MIN_IYUL
         , SUM(DECODE(T100.GIGAN_GUBUN, '4', T100.JUCHUK_AMT)) AS ETC_PYUNG_JAN
         , SUM(DECODE(T100.GIGAN_GUBUN, '4', T100.JUCHUK_AMT * T200.IYUL)) AS ETC_GAJUNG_AMT
         , MAX(DECODE(T100.GIGAN_GUBUN, '4', DECODE(T200.IYUL, 0, NULL, T200.IYUL))) AS ETC_MAX_IYUL
         , MIN(DECODE(T100.GIGAN_GUBUN, '4', DECODE(T200.IYUL, 0, NULL, T200.IYUL))) AS ETC_MIN_IYUL
         , SUM(T100.JUCHUK_AMT) AS JUCHUK_AMT
         , SUM(T100.SUSI_AMT) AS SUSI_AMT
    FROM (SELECT T10.GEUMGO_CODE
               , T10.GONGGEUM_GYEJWA
               , T20.SIGUMGO_AC_NM
               , T10.UNYONG_GYEJWA
               , T10.GIGAN_GUBUN
               , SUM(T10.JUCHUK_AMT) AS JUCHUK_AMT
               , SUM(T10.SUSI_AMT) AS SUSI_AMT
          FROM (SELECT /*+ LEADING(T1 T2 T3) INDEX(T2 RPT_UNYONG_JAN_UK_01) */
                    T2.GEUMGO_CODE
                     , T2.GONGGEUM_GYEJWA
                     , T2.UNYONG_GYEJWA
                     , CASE WHEN MONTHS_BETWEEN(TO_DATE(T2.DUDT, 'YYYYMMDD'), TO_DATE(T2.MKDT, 'YYYYMMDD')) >= 6 THEN '1'
                            WHEN MONTHS_BETWEEN(TO_DATE(T2.DUDT, 'YYYYMMDD'), TO_DATE(T2.MKDT, 'YYYYMMDD')) >= 3 THEN '2'
                            WHEN MONTHS_BETWEEN(TO_DATE(T2.DUDT, 'YYYYMMDD'), TO_DATE(T2.MKDT, 'YYYYMMDD')) >= 1 THEN '3'
                            ELSE '4'
                  END AS GIGAN_GUBUN
                     , CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) IN ('200', '207') THEN T2.JANAEK END AS JUCHUK_AMT
                     , CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) IN ('100', '140') THEN T2.JANAEK END AS SUSI_AMT
                FROM MAP_JOB_DATE T1
                   , RPT_UNYONG_JAN T2
                   , RPT_UNYONG_GYEJWA T3
                WHERE 1 = 1
                  AND T1.DW_BAS_DDT BETWEEN '20240101' AND '20241231'
                  AND T2.KIJUNIL = CASE WHEN T1.DT_G IN (0) THEN T1.DW_BAS_DDT ELSE T1.BF1_BIZ_DT END
                  AND T2.GEUMGO_CODE = 150
                  AND SUBSTR(T2.GONGGEUM_GYEJWA, 4, 3) = LPAD('0', 3, '0')
                  AND T2.JANAEK != 0
                                             AND T2.GONGGEUM_GYEJWA NOT IN ('04200080900003999')
                                             AND T2.UNYONG_GYEJWA NOT IN ('000000000000')
                                             AND T3.GONGGEUM_GYEJWA(+) = T2.GONGGEUM_GYEJWA
                                             AND T3.UNYONG_GYEJWA(+) = T2.UNYONG_GYEJWA
                                             AND T3.BANK_GUBUN(+) = 0
                                             AND COALESCE(T3.MKDT, T3.IN_DATE, '00010101') != COALESCE(T3.HJI_DT, '99991231')
                                             AND COALESCE(T3.MKDT, T3.IN_DATE, '00010101') <= T1.DW_BAS_DDT
                                             AND COALESCE(T3.HJI_DT, T3.OUT_DATE, '99991231') > T1.DW_BAS_DDT
          ) T10
             , ACL_SIGUMGO_MAS T20
          WHERE 1 = 1
            AND T20.MNG_NO = 1
            AND T20.SIGUMGO_AGE_AC_G IN (0,1)
            AND T20.FIL_100_CTNT2(+) = T10.GONGGEUM_GYEJWA
          GROUP BY T10.GEUMGO_CODE
                 , T10.GONGGEUM_GYEJWA
                 , T20.SIGUMGO_AC_NM
                 , T10.UNYONG_GYEJWA
                 , T10.GIGAN_GUBUN
    ) T100
       , (SELECT T10.GEUMGO_CODE
               , T10.GONGGEUM_GYEJWA
               , T10.UNYONG_GYEJWA
               , CASE WHEN T10.GONGGEUM_GYEJWA LIKE '%99'
                          THEN (SELECT IYUL
                                FROM RPT_UNYONG_JAN
                                WHERE GEUMGO_CODE = T10.GEUMGO_CODE
                                  AND GONGGEUM_GYEJWA = T10.GONGGEUM_GYEJWA
                                  AND UNYONG_GYEJWA = T10.UNYONG_GYEJWA
                                  AND KIJUNIL = T10.MAX_KIJUNIL)
                      ELSE (SELECT IYUL
                            FROM RPT_UNYONG_JAN
                            WHERE GEUMGO_CODE = T10.GEUMGO_CODE
                              AND GONGGEUM_GYEJWA = T10.GONGGEUM_GYEJWA
                              AND UNYONG_GYEJWA = T10.UNYONG_GYEJWA
                              AND KIJUNIL = MKDT)
            END AS IYUL
          FROM (SELECT /*+ LEADING(T1 T2 T3) INDEX(T2 RPT_UNYONG_JAN_UK_01) */
                    T2.GEUMGO_CODE
                     , T2.GONGGEUM_GYEJWA
                     , T2.UNYONG_GYEJWA
                     , MIN(T2.KIJUNIL) AS MAX_KIJUNIL
                FROM MAP_JOB_DATE T1
                   , RPT_UNYONG_JAN T2
                   , RPT_UNYONG_GYEJWA T3
                WHERE 1 = 1
                  AND T1.DW_BAS_DDT BETWEEN '20240101' AND '20241231'
                  AND T2.KIJUNIL = CASE WHEN T1.DT_G IN (0) THEN T1.DW_BAS_DDT ELSE T1.BF1_BIZ_DT END
                  AND T2.GEUMGO_CODE = 150
                  AND SUBSTR(T2.GONGGEUM_GYEJWA, 4, 3) = LPAD('0', 3, '0')
                  AND T2.GONGGEUM_GYEJWA NOT IN ('04200080900003999')
                  AND T2.UNYONG_GYEJWA NOT IN ('000000000000')
                  AND T3.GONGGEUM_GYEJWA(+) = T2.GONGGEUM_GYEJWA
                  AND T3.UNYONG_GYEJWA(+) = T2.UNYONG_GYEJWA
                  AND T3.BANK_GUBUN(+) = 0
                  AND COALESCE(T3.MKDT, T3.IN_DATE, '00010101') != COALESCE(T3.HJI_DT, '99991231')
                                             AND COALESCE(T3.MKDT, T3.IN_DATE, '00010101') <= T1.DW_BAS_DDT
                                             AND COALESCE(T3.HJI_DT, T3.OUT_DATE, '99991231') > T1.DW_BAS_DDT
                GROUP BY T2.GEUMGO_CODE
                        , T2.GONGGEUM_GYEJWA
                        , T2.UNYONG_GYEJWA
               ) T10
          WHERE 1 = 1
    ) T200
    WHERE 1 = 1
      AND T200.GONGGEUM_GYEJWA(+) = T100.GONGGEUM_GYEJWA
      AND T200.UNYONG_GYEJWA(+) = T100.UNYONG_GYEJWA
    GROUP BY T100.GONGGEUM_GYEJWA, T100.UNYONG_GYEJWA, T100.SIGUMGO_AC_NM


    UNION ALL


    SELECT /*+ LEADING(T1 T2 T3) INDEX(T2 RPT_UNYONG_JAN_UK_01) */
        NULL AS GEUMGO_CODE
         , NULL AS GUNGU_CODE
         , T2.GONGGEUM_GYEJWA AS GONGGEUM_GYEJWA_NO
         , T3.SIGUMGO_AC_NM AS GONGGEUM_GYEJWA_NM
         , NULL AS JANG_PYUNG_JAN
         , NULL AS JANG_GAJUNG_AMT
         , NULL AS JANG_MAX_IYUL
         , NULL AS JANG_MIN_IYUL
         , NULL AS JUNG_PYUNG_JAN
         , NULL AS JUNG_GAJUNG_AMT
         , NULL AS JUNG_MAX_IYUL
         , NULL AS JUNG_MIN_IYUL
         , NULL AS DAN_PYUNG_JAN
         , NULL AS DAN_GAJUNG_AMT
         , NULL AS DAN_MAX_IYUL
         , NULL AS DAN_MIN_IYUL
         , NULL AS ETC_PYUNG_JAN
         , NULL AS ETC_GAJUNG_AMT
         , NULL AS ETC_MAX_IYUL
         , NULL AS ETC_MIN_IYUL
         , NULL AS JUCHUK_AMT
         , SUM(T2.JANAEK) AS SUSI_AMT
    FROM MAP_JOB_DATE T1
       , RPT_UNYONG_JAN T2
       , ACL_SIGUMGO_MAS T3
    WHERE T1.DW_BAS_DDT BETWEEN '20240101' AND '20241231'
      AND T2.KIJUNIL = CASE WHEN T1.DT_G IN (0) THEN T1.DW_BAS_DDT ELSE T1.BF1_BIZ_DT END
      AND T2.GEUMGO_CODE = 150
      AND SUBSTR(T2.GONGGEUM_GYEJWA, 4, 3) = LPAD('0', 3, '0')
      AND T2.GONGGEUM_GYEJWA NOT IN ('04200080900003999')
      AND T2.UNYONG_GYEJWA IN ('000000000000')
      AND T3.MNG_NO = 1
      AND T3.SIGUMGO_AGE_AC_G IN (0,1)
      AND T3.FIL_100_CTNT2(+) = T2.GONGGEUM_GYEJWA
    GROUP BY T2.GONGGEUM_GYEJWA, T3.SIGUMGO_AC_NM


    UNION ALL


    SELECT NULL AS GEUMGO_CODE
         , NULL AS GUNGU_CODE
         , T100.GONGGEUM_GYEJWA AS GONGGEUM_GYEJWA_NO
         , T300.SIGUMGO_AC_NM AS GONGGEUM_GYEJWA_NM
         , SUM(DECODE(T100.GIGAN_GUBUN, '1', T100.JUCHUK_AMT)) AS JANG_PYUNG_JAN
         , SUM(DECODE(T100.GIGAN_GUBUN, '1', T100.JUCHUK_AMT * T200.IYUL)) AS JANG_GAJUNG_AMT
         , MAX(DECODE(T100.GIGAN_GUBUN, '1', DECODE(T200.IYUL, 0, NULL, T200.IYUL))) AS JANG_MAX_IYUL
         , MIN(DECODE(T100.GIGAN_GUBUN, '1', DECODE(T200.IYUL, 0, NULL, T200.IYUL))) AS JANG_MIN_IYUL
         , SUM(DECODE(T100.GIGAN_GUBUN, '2', T100.JUCHUK_AMT)) AS JUNG_PYUNG_JAN
         , SUM(DECODE(T100.GIGAN_GUBUN, '2', T100.JUCHUK_AMT * T200.IYUL)) AS JUNG_GAJUNG_AMT
         , MAX(DECODE(T100.GIGAN_GUBUN, '2', DECODE(T200.IYUL, 0, NULL, T200.IYUL))) AS JUNG_MAX_IYUL
         , MIN(DECODE(T100.GIGAN_GUBUN, '2', DECODE(T200.IYUL, 0, NULL, T200.IYUL))) AS JUNG_MIN_IYUL
         , SUM(DECODE(T100.GIGAN_GUBUN, '3', T100.JUCHUK_AMT)) AS DAN_PYUNG_JAN
         , SUM(DECODE(T100.GIGAN_GUBUN, '3', T100.JUCHUK_AMT * T200.IYUL)) AS DAN_GAJUNG_AMT
         , MAX(DECODE(T100.GIGAN_GUBUN, '3', DECODE(T200.IYUL, 0, NULL, T200.IYUL))) AS DAN_MAX_IYUL
         , MIN(DECODE(T100.GIGAN_GUBUN, '3', DECODE(T200.IYUL, 0, NULL, T200.IYUL))) AS DAN_MIN_IYUL
         , SUM(DECODE(T100.GIGAN_GUBUN, '4', T100.JUCHUK_AMT)) AS ETC_PYUNG_JAN
         , SUM(DECODE(T100.GIGAN_GUBUN, '4', T100.JUCHUK_AMT * T200.IYUL)) AS ETC_GAJUNG_AMT
         , MAX(DECODE(T100.GIGAN_GUBUN, '4', DECODE(T200.IYUL, 0, NULL, T200.IYUL))) AS ETC_MAX_IYUL
         , MIN(DECODE(T100.GIGAN_GUBUN, '4', DECODE(T200.IYUL, 0, NULL, T200.IYUL))) AS ETC_MIN_IYUL
         , SUM(T100.JUCHUK_AMT) AS JUCHUK_AMT
         , NULL AS SUSI_AMT
    FROM (SELECT T10.GEUMGO_CODE
               , T10.GONGGEUM_GYEJWA
               , T10.UNYONG_GYEJWA
               , T10.GIGAN_GUBUN
               , SUM(T10.JUCHUK_AMT) AS JUCHUK_AMT
          FROM (SELECT /*+ LEADING(T1 T2 T3) INDEX(T2 RPT_UNYONG_JAN_UK_01) */
                    T2.GEUMGO_CODE
                     , T2.GONGGEUM_GYEJWA
                     , T2.UNYONG_GYEJWA
                     , CASE WHEN MONTHS_BETWEEN(TO_DATE(T2.DUDT, 'YYYYMMDD'), TO_DATE(T2.MKDT, 'YYYYMMDD')) >= 6 THEN '1'
                            WHEN MONTHS_BETWEEN(TO_DATE(T2.DUDT, 'YYYYMMDD'), TO_DATE(T2.MKDT, 'YYYYMMDD')) >= 3 THEN '2'
                            WHEN MONTHS_BETWEEN(TO_DATE(T2.DUDT, 'YYYYMMDD'), TO_DATE(T2.MKDT, 'YYYYMMDD')) >= 1 THEN '3'
                            ELSE '4'
                  END AS GIGAN_GUBUN
                     , T2.JANAEK AS JUCHUK_AMT
                FROM MAP_JOB_DATE T1
                   , RPT_UNYONG_JAN T2
                   , RPT_UNYONG_GYEJWA T3
                   , RPT_CODE_INFO T4
                WHERE 1 = 1
                  AND T1.DW_BAS_DDT BETWEEN '20240101' AND '20241231'
                  AND T2.KIJUNIL = CASE WHEN T1.DT_G IN (0) THEN T1.DW_BAS_DDT ELSE T1.BF1_BIZ_DT END
                  AND T2.GEUMGO_CODE = 150
                  AND SUBSTR(T2.GONGGEUM_GYEJWA, 4, 3) = LPAD('0', 3, '0')
                  AND T3.GONGGEUM_GYEJWA(+) = T2.GONGGEUM_GYEJWA
                  AND T3.UNYONG_GYEJWA(+) = T2.UNYONG_GYEJWA
                  AND T3.BANK_GUBUN(+) = 0
                  AND COALESCE(T3.MKDT, T3.IN_DATE, '00010101') != COALESCE(T3.HJI_DT, '99991231')
                                             AND COALESCE(T3.MKDT, T3.IN_DATE, '00010101') <= T1.DW_BAS_DDT
                                             AND COALESCE(T3.HJI_DT, T3.OUT_DATE, '99991231') > T1.DW_BAS_DDT
                                             AND T4.REF_L_C = 50
                                             AND T4.REF_M_C = 150
                                             AND T4.YUHYO_YN = 0
                                             AND T4.REF_D_NM = T3.GONGGEUM_GYEJWA

               ) T10
          WHERE 1 = 1
          GROUP BY T10.GEUMGO_CODE
                 , T10.GONGGEUM_GYEJWA
                 , T10.UNYONG_GYEJWA
                 , T10.GIGAN_GUBUN
    ) T100
       , (SELECT T10.GEUMGO_CODE
               , T10.GONGGEUM_GYEJWA
               , T10.UNYONG_GYEJWA
               , CASE WHEN T10.GONGGEUM_GYEJWA LIKE '%99'
                          THEN (SELECT IYUL
                                FROM RPT_UNYONG_JAN
                                WHERE GEUMGO_CODE = T10.GEUMGO_CODE
                                  AND GONGGEUM_GYEJWA = T10.GONGGEUM_GYEJWA
                                  AND UNYONG_GYEJWA = T10.UNYONG_GYEJWA
                                  AND KIJUNIL = T10.MAX_KIJUNIL)
                      ELSE (SELECT IYUL
                            FROM RPT_UNYONG_JAN
                            WHERE GEUMGO_CODE = T10.GEUMGO_CODE
                              AND GONGGEUM_GYEJWA = T10.GONGGEUM_GYEJWA
                              AND UNYONG_GYEJWA = T10.UNYONG_GYEJWA
                              AND KIJUNIL = MKDT)
            END AS IYUL
          FROM (SELECT /*+ LEADING(T1 T2 T3) INDEX(T2 RPT_UNYONG_JAN_UK_01) */
                    T2.GEUMGO_CODE
                     , T2.GONGGEUM_GYEJWA
                     , T2.UNYONG_GYEJWA
                     , MIN(T2.KIJUNIL) AS MAX_KIJUNIL
                FROM MAP_JOB_DATE T1
                   , RPT_UNYONG_JAN T2
                   , RPT_UNYONG_GYEJWA T3
                WHERE 1 = 1
                  AND T1.DW_BAS_DDT BETWEEN '20240101' AND '20241231'
                  AND T2.KIJUNIL = CASE WHEN T1.DT_G IN (0) THEN T1.DW_BAS_DDT ELSE T1.BF1_BIZ_DT END
                  AND T2.GEUMGO_CODE = 150
                  AND SUBSTR(T2.GONGGEUM_GYEJWA, 4, 3) = LPAD('0', 3, '0')
                  AND T2.GONGGEUM_GYEJWA NOT IN ('04200080900003999')
                  AND T2.UNYONG_GYEJWA NOT IN ('000000000000')
                  AND T3.GONGGEUM_GYEJWA(+) = T2.GONGGEUM_GYEJWA
                  AND T3.UNYONG_GYEJWA(+) = T2.UNYONG_GYEJWA
                  AND T3.BANK_GUBUN(+) = 0
                  AND COALESCE(T3.MKDT, T3.IN_DATE, '00010101') != COALESCE(T3.HJI_DT, '99991231')
                                             AND COALESCE(T3.MKDT, T3.IN_DATE, '00010101') <= T1.DW_BAS_DDT
                                             AND COALESCE(T3.HJI_DT, T3.OUT_DATE, '99991231') > T1.DW_BAS_DDT
                GROUP BY T2.GEUMGO_CODE
                        , T2.GONGGEUM_GYEJWA
                        , T2.UNYONG_GYEJWA
               ) T10
          WHERE 1 = 1
    ) T200, ACL_SIGUMGO_MAS T300
    WHERE 1 = 1
      AND T200.GONGGEUM_GYEJWA(+) = T100.GONGGEUM_GYEJWA
      AND T200.UNYONG_GYEJWA(+) = T100.UNYONG_GYEJWA
      AND T300.MNG_NO = 1
      AND T300.SIGUMGO_AGE_AC_G IN (0,1)
      AND T300.FIL_100_CTNT2(+) = T200.GONGGEUM_GYEJWA
    GROUP BY  T100.GONGGEUM_GYEJWA , T300.SIGUMGO_AC_NM

) T1000
   , (SELECT COUNT(1) AS DCNT
      FROM MAP_JOB_DATE
      WHERE DW_BAS_DDT BETWEEN '20240101' AND '20241231') T2000
WHERE 1 = 1
GROUP BY  T1000.GONGGEUM_GYEJWA_NO, T1000.GONGGEUM_GYEJWA_NM

-- 강릉시 예금운용현황(예치기간별)

SELECT
    T1.GEUMGO_CODE
     ,T1.GONGGEUM_GUNGU_CODE
     ,T2.CMM_DTL_C_NM AS GEUMGO_NAME
     ,T3.CMM_DTL_C_NM AS GUNGU_NAME
     ,SUM(T1.PYUNG_JAN) AS HAPGYE
     ,SUM(DECODE(T1.GUBUN, 4, 0, T1.PYUNG_JAN)) AS JUNGI_HAPGYE
     ,MAX(DECODE(T1.GUBUN, 1, T1.PYUNG_JAN, 0)) AS JANG_PYUNG_JAN
     ,MAX(DECODE(T1.GUBUN, 1, T1.PYUNG_IYUL, 0)) AS JANG_PYUNG_IYUL
     ,MAX(DECODE(T1.GUBUN, 1, T1.MAX_IYUL, 0)) AS JANG_MAX_IYUL
     ,MAX(DECODE(T1.GUBUN, 1, T1.MIN_IYUL, 0)) AS JANG_MIN_IYUL
     ,MAX(DECODE(T1.GUBUN, 2, T1.PYUNG_JAN, 0)) AS JUNG_PYUNG_JAN
     ,MAX(DECODE(T1.GUBUN, 2, T1.PYUNG_IYUL, 0)) AS JUNG_PYUNG_IYUL
     ,MAX(DECODE(T1.GUBUN, 2, T1.MAX_IYUL, 0)) AS JUNG_MAX_IYUL
     ,MAX(DECODE(T1.GUBUN, 2, T1.MIN_IYUL, 0)) AS JUNG_MIN_IYUL
     ,MAX(DECODE(T1.GUBUN, 3, T1.PYUNG_JAN, 0)) AS DAN_PYUNG_JAN
     ,MAX(DECODE(T1.GUBUN, 3, T1.PYUNG_IYUL, 0)) AS DAN_PYUNG_IYUL
     ,MAX(DECODE(T1.GUBUN, 3, T1.MAX_IYUL, 0)) AS DAN_MAX_IYUL
     ,MAX(DECODE(T1.GUBUN, 3, T1.MIN_IYUL, 0)) AS DAN_MIN_IYUL
     ,MAX(DECODE(T1.GUBUN, 4, T1.PYUNG_JAN, 0)) AS ETC_PYUNG_JAN
     ,MAX(DECODE(T1.GUBUN, 4, T1.PYUNG_IYUL, 0)) AS ETC_PYUNG_IYUL
     ,MAX(DECODE(T1.GUBUN, 4, T1.MAX_IYUL, 0)) AS ETC_MAX_IYUL
     ,MAX(DECODE(T1.GUBUN, 4, T1.MIN_IYUL, 0)) AS ETC_MIN_IYUL
FROM
    (
        SELECT
            T1.GEUMGO_CODE
             ,T2.ICH_SIGUMGO_GUN_GU_C AS GONGGEUM_GUNGU_CODE
             ,CASE
                  WHEN ROUND(MONTHS_BETWEEN(TO_DATE(T1.DUDT, 'YYYYMMDD'), TO_DATE(T1.MKDT, 'YYYYMMDD'))) >= 6 THEN '1'
                  WHEN ROUND(MONTHS_BETWEEN(TO_DATE(T1.DUDT, 'YYYYMMDD'), TO_DATE(T1.MKDT, 'YYYYMMDD'))) >= 3
                      AND ROUND(MONTHS_BETWEEN(TO_DATE(T1.DUDT, 'YYYYMMDD'), TO_DATE(T1.MKDT, 'YYYYMMDD'))) < 6
                      THEN '2'
                  WHEN ROUND(MONTHS_BETWEEN(TO_DATE(T1.DUDT, 'YYYYMMDD'), TO_DATE(T1.MKDT, 'YYYYMMDD'))) >= 1
                      AND ROUND(MONTHS_BETWEEN(TO_DATE(T1.DUDT, 'YYYYMMDD'), TO_DATE(T1.MKDT, 'YYYYMMDD'))) < 3
                      THEN '3'
                  ELSE '4'
            END AS GUBUN
             ,ROUND(SUM(T1.JANAEK)/MAX(T2.JOB_DATE_CNT)) AS PYUNG_JAN
             ,ROUND(SUM(T1.JANAEK * T1.IYUL)/SUM(T1.JANAEK), 2) AS PYUNG_IYUL
             ,MAX(
                CASE
                    WHEN T1.GONGGEUM_GYEJWA LIKE '%99'
                        THEN (
                        SELECT
                            T3.IYUL
                        FROM
                            RPT_UNYONG_JAN T3
                        WHERE 1=1
                          AND T3.GEUMGO_CODE = T1.GEUMGO_CODE
                          AND T3.GONGGEUM_GYEJWA = T1.GONGGEUM_GYEJWA
                          AND T3.UNYONG_GYEJWA = T1.UNYONG_GYEJWA
                          AND T3.KIJUNIL IN (
                            SELECT
                                MAX(T4.KIJUNIL)
                            FROM
                                RPT_UNYONG_JAN T4
                            WHERE 1=1
                              AND T4.GEUMGO_CODE = T1.GEUMGO_CODE
                              AND T4.GONGGEUM_GYEJWA = T1.GONGGEUM_GYEJWA
                              AND T4.UNYONG_GYEJWA = T1.UNYONG_GYEJWA
                              AND T4.KIJUNIL < T4.DUDT
                              AND T4.KIJUNIL <= T1.KIJUNIL
                        )
                    )
                    ELSE (
                        SELECT
                            T3.IYUL
                        FROM
                            RPT_UNYONG_JAN T3
                        WHERE 1=1
                          AND T3.GEUMGO_CODE = T1.GEUMGO_CODE
                          AND T3.GONGGEUM_GYEJWA = T1.GONGGEUM_GYEJWA
                          AND T3.UNYONG_GYEJWA = T1.UNYONG_GYEJWA
                          AND T3.KIJUNIL = T3.MKDT
                    )
                    END
              ) AS MAX_IYUL
             ,MIN(
                CASE
                    WHEN T1.GONGGEUM_GYEJWA LIKE '%99'
                        THEN (
                        SELECT
                            T3.IYUL
                        FROM
                            RPT_UNYONG_JAN T3
                        WHERE 1=1
                          AND T3.GEUMGO_CODE = T1.GEUMGO_CODE
                          AND T3.GONGGEUM_GYEJWA = T1.GONGGEUM_GYEJWA
                          AND T3.UNYONG_GYEJWA = T1.UNYONG_GYEJWA
                          AND T3.KIJUNIL IN (
                            SELECT
                                MAX(T4.KIJUNIL)
                            FROM
                                RPT_UNYONG_JAN T4
                            WHERE 1=1
                              AND T4.GEUMGO_CODE = T1.GEUMGO_CODE
                              AND T4.GONGGEUM_GYEJWA = T1.GONGGEUM_GYEJWA
                              AND T4.UNYONG_GYEJWA = T1.UNYONG_GYEJWA
                              AND T4.KIJUNIL < T4.DUDT
                              AND T4.KIJUNIL <= T1.KIJUNIL
                        )
                    )
                    ELSE (
                        SELECT
                            T3.IYUL
                        FROM
                            RPT_UNYONG_JAN T3
                        WHERE 1=1
                          AND T3.GEUMGO_CODE = T1.GEUMGO_CODE
                          AND T3.GONGGEUM_GYEJWA = T1.GONGGEUM_GYEJWA
                          AND T3.UNYONG_GYEJWA = T1.UNYONG_GYEJWA
                          AND T3.KIJUNIL = T3.MKDT
                    )
                    END
              ) AS MIN_IYUL
        FROM
            RPT_UNYONG_JAN T1
           ,(
            SELECT
                T1.SIGUMGO_ORG_C
                 ,T1.ICH_SIGUMGO_GUN_GU_C
                 ,T1.GONGGEUM_GYEJWA
                 ,T1.UNYONG_GYEJWA
                 ,T1.MKDT
                 ,T1.HJI_DT
                 ,T1.OUT_DATE
                 ,T2.BIZ_DT
                 ,T2.DW_BAS_DDT
                 ,T2.JOB_DATE_CNT
            FROM
                (
                    SELECT
                        T1.SIGUMGO_ORG_C
                         ,T1.ICH_SIGUMGO_GUN_GU_C
                         ,T1.FIL_100_CTNT2 AS GONGGEUM_GYEJWA
                         ,T2.UNYONG_GYEJWA
                         ,T2.MKDT
                         ,T2.HJI_DT
                         ,T2.OUT_DATE
                    FROM
                        ACL_SIGUMGO_MAS T1
                       ,RPT_UNYONG_GYEJWA T2
                    WHERE 1=1
                      AND T1.SIGUMGO_ORG_C = T2.GEUMGO_CODE
                      AND T1.FIL_100_CTNT2 = T2.GONGGEUM_GYEJWA
                      AND T1.SIGUMGO_ORG_C = '150'
                      AND T1.MNG_NO = 1
                      AND (
                              CASE
                                  WHEN NVL(T2.HJI_DT, T2.OUT_DATE) IS NULL THEN 1
                                  ELSE DECODE(SIGN(T2.HJI_DT - '20241231'), 1, 1, 0)
                                  END
                              ) = 1
                      AND T2.MKDT <= '20241231'
                      AND T2.BANK_GUBUN = 0
                      AND T2.MKDT <> NVL(T2.HJI_DT,'99991231')
                    UNION
                    SELECT
                        T1.SIGUMGO_ORG_C
                         ,T1.ICH_SIGUMGO_GUN_GU_C
                         ,T1.FIL_100_CTNT2 AS GONGGEUM_GYEJWA
                         ,T2.UNYONG_GYEJWA
                         ,T2.MKDT
                         ,T2.HJI_DT
                         ,T2.OUT_DATE
                    FROM
                        ACL_SIGUMGO_MAS T1
                       ,RPT_UNYONG_GYEJWA T2
                    WHERE 1=1
                      AND T1.SIGUMGO_ORG_C = T2.GEUMGO_CODE
                      AND T1.FIL_100_CTNT2 = T2.GONGGEUM_GYEJWA
                      AND T1.SIGUMGO_ORG_C = '150'
                      AND T1.MNG_NO = 1
                      AND NVL(T2.HJI_DT, T2.OUT_DATE) >= '20240101'
                      AND NVL(T2.HJI_DT, T2.OUT_DATE) <= '20241231'
                ) T1
               ,(
                SELECT
                    DECODE(T1.DT_G, 0, T1.DW_BAS_DDT, T1.BF1_BIZ_DT) AS BIZ_DT
                     ,T1.DW_BAS_DDT
                     ,COUNT(1) OVER() AS JOB_DATE_CNT
                FROM
                    MAP_JOB_DATE T1
                WHERE 1=1
                  AND T1.DW_BAS_DDT >= '20240101'
                  AND T1.DW_BAS_DDT <= '20241231'
            ) T2
        ) T2
        WHERE 1=1
          AND T1.KIJUNIL = T2.BIZ_DT
          AND TRIM(T1.GONGGEUM_GYEJWA) = T2.GONGGEUM_GYEJWA
          AND T1.UNYONG_GYEJWA = T2.UNYONG_GYEJWA
          AND T1.GEUMGO_CODE = T2.SIGUMGO_ORG_C
          AND NVL(T1.HJI_DT, '99991231') >= T2.DW_BAS_DDT
          AND T1.JANAEK > 0
          AND T1.IYUL <> 0
        GROUP BY
            T1.GEUMGO_CODE
               ,T2.ICH_SIGUMGO_GUN_GU_C
               ,CASE
                    WHEN ROUND(MONTHS_BETWEEN(TO_DATE(T1.DUDT, 'YYYYMMDD'), TO_DATE(T1.MKDT, 'YYYYMMDD'))) >= 6 THEN '1'
                    WHEN ROUND(MONTHS_BETWEEN(TO_DATE(T1.DUDT, 'YYYYMMDD'), TO_DATE(T1.MKDT, 'YYYYMMDD'))) >= 3
                        AND ROUND(MONTHS_BETWEEN(TO_DATE(T1.DUDT, 'YYYYMMDD'), TO_DATE(T1.MKDT, 'YYYYMMDD'))) < 6
                        THEN '2'
                    WHEN ROUND(MONTHS_BETWEEN(TO_DATE(T1.DUDT, 'YYYYMMDD'), TO_DATE(T1.MKDT, 'YYYYMMDD'))) >= 1
                        AND ROUND(MONTHS_BETWEEN(TO_DATE(T1.DUDT, 'YYYYMMDD'), TO_DATE(T1.MKDT, 'YYYYMMDD'))) < 3
                        THEN '3'
                    ELSE '4'
            END
        UNION ALL
        SELECT
            TO_NUMBER(T1.CMM_DTL_C) AS GEUMGO_CODE
             ,TO_NUMBER(T2.CMM_DTL_C) AS GONGGEUM_GUNGU_CODE
             ,'4' AS GUBUN
             ,0 AS PYUNG_JAN
             ,0 AS PYUNG_IYUL
             ,0 AS MAX_IYUL
             ,0 AS MIN_IYUL
        FROM
            SFI_CMM_C_DAT T1
           ,SFI_CMM_C_DAT T2
        WHERE 1=1
          AND T1.CMM_DTL_C = T2.HRNK_CMM_DTL_C
          AND T1.CMM_C_NM = 'RPT시도금고코드'
          AND T1.CMM_DTL_C = '150'
          AND T2.CMM_C_NM = 'RPT군구코드'
    ) T1
   ,SFI_CMM_C_DAT T2
   ,SFI_CMM_C_DAT T3
WHERE 1=1
  AND T1.GEUMGO_CODE = T2.CMM_DTL_C
  AND T1.GONGGEUM_GUNGU_CODE = T3.CMM_DTL_C(+)
  AND T1.GEUMGO_CODE = T3.HRNK_CMM_DTL_C(+)
  AND T2.CMM_C_NM(+) = 'RPT시도금고코드'
  AND T2.USE_YN(+) = 'Y'
  AND T3.CMM_C_NM(+) = 'RPT군구코드'
  AND T3.USE_YN(+) = 'Y'
GROUP BY
    T1.GEUMGO_CODE
       ,T1.GONGGEUM_GUNGU_CODE
       ,T2.CMM_DTL_C_NM
       ,T3.CMM_DTL_C_NM
ORDER BY
    T1.GONGGEUM_GUNGU_CODE


-------------------------------------------------------------------------
-- 인천광역시 동구청

SELECT
    REF_L_C     , REF_L_NM   , REF_M_C    ,
    REF_M_NM    , REF_S_C    , REF_S_NM   ,
    REF_D_C     , REF_D_NM   , YUHYO_YN   ,
    REF_CTNT1   , REF_CTNT2  , REF_CTNT3  ,
    REF_CTNT4   , REF_CTNT5  , ROWID,
    REF_L_C AS OLD_REF_L_C,
    REF_M_C AS OLD_REF_M_C,
    REF_S_C AS OLD_REF_S_C,
    REF_D_C AS OLD_REF_D_C
FROM
    RPT_CODE_INFO
WHERE
    REF_L_C = 110
  AND REF_M_C = NVL(28, REF_M_C)
  AND REF_S_C = NVL(140, REF_S_C)
ORDER BY
    REF_L_C, REF_M_C, REF_S_C, REF_D_C

--------------------------------------------------------------------------------

SELECT T100.GUNGU_CODE,
    SUM(T100.JUKSU_AMT * T100.IYUL) AS GAJUNG_AMT
     , MAX(DECODE(T100.IYUL, 0, NULL, T100.IYUL)) AS MAX_IYUL
     , MIN(DECODE(T100.IYUL, 0, NULL, T100.IYUL)) AS MIN_IYUL
     , SUM(T100.JUKSU_AMT) AS JUCHUK_AMT
FROM (
         SELECT SUBSTR(GONGGEUM_GYEJWA, 4, 3) AS GUNGU_CODE, GONGGEUM_GYEJWA, YUDONG_ACNO , JUKSU_AMT, IJA,  ILSU ,   (NULLIF(IJA, 0) * 365) / (NULLIF(JUKSU_AMT, 0) * ILSU) * 100 AS IYUL
         FROM RPT_GONGGEUM_GYULSAN_TMP
         WHERE GEUMGO_CODE = 28
           AND GYULSAN_IL IN ('20250101', '20240701')
           AND IJA > 0
           AND JUKSU_AMT > 0) T100
GROUP BY GUNGU_CODE


SELECT *
FROM RPT_GONGGEUM_GYULSAN_TMP


-- 5035949610
SELECT SUM(JANAEK) AS JAN FROM RPT_GONGGEUM_JAN
WHERE GONGGEUM_GYEJWA = '02800080600006899'
AND KEORAEIL BETWEEN '20240701' AND '20241231'


SELECT *
FROM RPT_GONGGEUM_GYULSAN_TMP
WHERE 1=1
  AND GYULSAN_IL LIKE '2025%'

-- 200778556436
SELECT * FROM RPT_UNYONG_GYEJWA
WHERE UNYONG_GYEJWA = '200778556436'


SELECT UNYONG_GYEJWA, SUM(JANAEK) AS SUM_JAN, COUNT(*) AS CNT FROM RPT_UNYONG_JAN
WHERE UNYONG_GYEJWA = '200778556436'
AND KIJUNIL BETWEEN '20240101' AND '20241231'
GROUP BY UNYONG_GYEJWA

SELECT COUNT(*) AS CNT FROM MAP_JOB_DATE WHERE 1=1 AND DW_BAS_DDT BETWEEN '20240101' AND '20241231'
