SELECT                  GYEJWA_NO
                       , GYEJWA_NM
                       , MAPP_HOIGYE_CODE
                       , SUM(JUCHUK_AMT) AS JUCHUK_AMT
                       , SUM(TRUNC(NVL(ALL_JUCHUK_AMT, 0))) AS ALL_JUCHUK_AMT
                       , SUM(GONGGEUM_AMT) AS GONGGEUM_AMT
                       , SUM(UY_100_AMT) AS UY_100_AMT
                       , SUM(UY_140_AMT) AS UY_140_AMT
                       , SUM(UY_160_AMT) AS UY_160_AMT
                       , SUM(UY_ETC_AMT) AS UY_ETC_AMT
                       , SUM(MMDA_AMT) AS MMDA_AMT
                       , SUM(UY_140_AMT) + SUM(MMDA_AMT) AS ALL_MMDA_AMT
                       , SUM(SUSI_AMT) AS SUSI_AMT

FROM (
SELECT                 DECODE(42, '42', LPAD(T20000.LINKAC_KWA_C, 3, '0') || LPAD(T20000.LINK_ACSER, 9, '0'), T10000.GYEJWA_NO) AS GYEJWA_NO
                       , GYEJWA_NM
                       , TO_NUMBER(DECODE(42, 28, T20000.ICH_SIGUMGO_HOIKYE_C, T30000.SIGUMGO_HOIKYE_C)) AS MAPP_HOIGYE_CODE
                       , JUCHUK_AMT
                       , TRUNC(NVL(JANG_PYUNG_JAN, 0)) + TRUNC(NVL(JUNG_PYUNG_JAN, 0)) + TRUNC(NVL(DAN_PYUNG_JAN, 0)) AS ALL_JUCHUK_AMT
                       , GONGGEUM_AMT
                       , UY_100_AMT
                       , UY_140_AMT
                       , UY_160_AMT
                       , UY_ETC_AMT
                       , MMDA_AMT
                       , UY_140_AMT + MMDA_AMT AS ALL_MMDA_AMT
                       , SUSI_AMT
FROM 
(
SELECT 
                         T1000.GONGGEUM_GYEJWA_NO AS GYEJWA_NO
                       , T1000.GONGGEUM_GYEJWA_NM AS GYEJWA_NM
                       , ROUND(SUM(T1000.JANG_PYUNG_JAN / T2000.DCNT), 8) AS JANG_PYUNG_JAN
                       , SUM(T1000.JANG_PYUNG_JAN) AS JANG_JAN
                       , SUM(T1000.JANG_GAJUNG_AMT) AS JANG_GAJUNG_AMT
                       , ROUND(SUM(T1000.JANG_GAJUNG_AMT) / SUM(T1000.JANG_PYUNG_JAN), 8) AS JANG_PYUNG_IYUL
                       , MAX(T1000.JANG_MAX_IYUL) AS JANG_MAX_IYUL 
                       , MIN(T1000.JANG_MIN_IYUL) AS JANG_MIN_IYUL
                       , NVL(MIN(T1000.JANG_MIN_IYUL), 100) AS JANG_SUB_MIN_IYUL
                       , ROUND(SUM(T1000.JUNG_PYUNG_JAN / T2000.DCNT), 8) AS JUNG_PYUNG_JAN
                       , SUM(T1000.JUNG_PYUNG_JAN) AS JUNG_JAN
                       , SUM(T1000.JUNG_GAJUNG_AMT) AS JUNG_GAJUNG_AMT
                       , ROUND(SUM(T1000.JUNG_GAJUNG_AMT) / SUM(T1000.JUNG_PYUNG_JAN), 8) AS JUNG_PYUNG_IYUL
                       , MAX(T1000.JUNG_MAX_IYUL) AS JUNG_MAX_IYUL
                       , MIN(T1000.JUNG_MIN_IYUL) AS JUNG_MIN_IYUL
                       , NVL(MIN(T1000.JUNG_MIN_IYUL), 100) AS JUNG_SUB_MIN_IYUL
                       , ROUND(SUM(T1000.DAN_PYUNG_JAN / T2000.DCNT), 8) AS DAN_PYUNG_JAN
                       , SUM(T1000.DAN_PYUNG_JAN) AS DAN_JAN
                       , SUM(T1000.DAN_GAJUNG_AMT) AS DAN_GAJUNG_AMT
                       , ROUND(SUM(T1000.DAN_GAJUNG_AMT) / SUM(T1000.DAN_PYUNG_JAN), 8) AS DAN_PYUNG_IYUL
                       , MAX(T1000.DAN_MAX_IYUL) AS DAN_MAX_IYUL
                       , MIN(T1000.DAN_MIN_IYUL) AS DAN_MIN_IYUL
                       , NVL(MIN(T1000.DAN_MIN_IYUL), 100) AS DAN_SUB_MIN_IYUL
                       , ROUND(SUM(T1000.ETC_PYUNG_JAN / T2000.DCNT), 8) AS ETC_PYUNG_JAN
                       , ROUND(SUM(T1000.ETC_GAJUNG_AMT) / SUM(T1000.ETC_PYUNG_JAN), 8) AS ETC_PYUNG_IYUL
                       , MAX(T1000.ETC_MAX_IYUL) AS ETC_MAX_IYUL
                       , MIN(T1000.ETC_MIN_IYUL) AS ETC_MIN_IYUL
                       , ROUND(SUM(T1000.JUCHUK_AMT / T2000.DCNT), 8) AS JUCHUK_AMT
                       , ROUND(SUM(T1000.GONGGEUM_AMT / T2000.DCNT), 8) AS GONGGEUM_AMT
                       , ROUND(SUM(NVL(T1000.UY_100_AMT, 0) / T2000.DCNT), 8) AS UY_100_AMT
                       , ROUND(SUM(NVL(T1000.UY_140_AMT, 0) / T2000.DCNT), 8) AS UY_140_AMT
                       , ROUND(SUM(NVL(T1000.UY_160_AMT, 0) / T2000.DCNT), 8) AS UY_160_AMT
                       , ROUND(SUM(NVL(T1000.UY_ETC_AMT, 0) / T2000.DCNT), 8) AS UY_ETC_AMT
                       , ROUND(SUM(NVL(T1000.MMDA_AMT, 0) / T2000.DCNT), 8) AS MMDA_AMT
                       , ROUND(SUM(NVL(T1000.GONGGEUM_AMT, 0) / T2000.DCNT), 8) + ROUND(SUM(NVL(T1000.UY_140_AMT, 0) / T2000.DCNT), 8) +  
                       ROUND(SUM(NVL(T1000.MMDA_AMT, 0) / T2000.DCNT), 8) AS SUSI_AMT
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
                               , SUM(T10.JANAEK) AS GONGGEUM_AMT
                               , NULL AS UY_100_AMT
                               , NULL AS UY_140_AMT
                               , NULL AS UY_160_AMT
                               , NULL AS UY_ETC_AMT
                               , NULL AS MMDA_AMT
                            FROM (SELECT  /*+ INDEX(T1 RPT_GONGGEUM_JAN_IX_01) */
                                         T1.GONGGEUM_GYEJWA
                                       , SUM(T1.JANAEK) AS JANAEK
                                    FROM RPT_GONGGEUM_JAN T1
                                   WHERE T1.GEUMGO_CODE = 42
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
                               , NULL AS GONGGEUM_AMT
                               , SUM(T100.UY_100_AMT) AS UY_100_AMT
                               , SUM(T100.UY_140_AMT) AS UY_140_AMT
                               , SUM(T100.UY_160_AMT) AS UY_160_AMT
                               , SUM(T100.UY_ETC_AMT) AS UY_ETC_AMT
                               , NULL AS MMDA_AMT
                            FROM (SELECT T10.GEUMGO_CODE
                                       , T10.GONGGEUM_GYEJWA
                                       , T20.SIGUMGO_AC_NM
                                       , T10.UNYONG_GYEJWA
                                       , T10.GIGAN_GUBUN
                                       , SUM(T10.JUCHUK_AMT) AS JUCHUK_AMT
                                       , SUM(T10.UY_100_AMT) AS UY_100_AMT
                                       , SUM(T10.UY_140_AMT) AS UY_140_AMT
                                       , SUM(T10.UY_160_AMT) AS UY_160_AMT
                                       , SUM(T10.UY_ETC_AMT) AS UY_ETC_AMT
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
                                               , CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) IN ('100') THEN T2.JANAEK END AS UY_100_AMT
                                               , CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) IN ('140') THEN T2.JANAEK END AS UY_140_AMT 
                                               , CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) IN ('160') THEN T2.JANAEK END AS UY_160_AMT
                                               , CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) NOT IN ('100', '140', '160', '200', '207') THEN T2.JANAEK END AS UY_ETC_AMT
                                            FROM MAP_JOB_DATE T1
                                               , RPT_UNYONG_JAN T2
                                               , RPT_UNYONG_GYEJWA T3
                                           WHERE 1 = 1
                                             AND T1.DW_BAS_DDT BETWEEN '20240101' AND '20241231'
                                             AND T2.KIJUNIL = CASE WHEN T1.DT_G IN (0) THEN T1.DW_BAS_DDT ELSE T1.BF1_BIZ_DT END
                                             AND T2.GEUMGO_CODE = 42
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
                                             AND T2.GEUMGO_CODE = 42
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
                           GROUP BY T100.GONGGEUM_GYEJWA, T100.SIGUMGO_AC_NM    
                          

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
                               , NULL AS GONGGEUM_AMT
                               , NULL AS UY_100_AMT
                               , NULL AS UY_140_AMT
                               , NULL AS UY_160_AMT
                               , NULL AS UY_ETC_AMT
                               , SUM(T2.JANAEK) AS MMDA_AMT
                            FROM MAP_JOB_DATE T1
                               , RPT_UNYONG_JAN T2
                               , ACL_SIGUMGO_MAS T3
                           WHERE T1.DW_BAS_DDT BETWEEN '20240101' AND '20241231'
                             AND T2.KIJUNIL = CASE WHEN T1.DT_G IN (0) THEN T1.DW_BAS_DDT ELSE T1.BF1_BIZ_DT END
                             AND T2.GEUMGO_CODE = 42
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
                               , NULL AS GONGGEUM_AMT
                               , NULL AS UY_100_AMT
                               , NULL AS UY_140_AMT
                               , NULL AS UY_160_AMT
                               , NULL AS UY_ETC_AMT
                               , NULL AS MMDA_AMT
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
                                             AND T2.GEUMGO_CODE = 42
                                             AND SUBSTR(T2.GONGGEUM_GYEJWA, 4, 3) = LPAD('0', 3, '0')
                                             AND T3.GONGGEUM_GYEJWA(+) = T2.GONGGEUM_GYEJWA
                                             AND T3.UNYONG_GYEJWA(+) = T2.UNYONG_GYEJWA
                                             AND T3.BANK_GUBUN(+) = 0
                                             AND COALESCE(T3.MKDT, T3.IN_DATE, '00010101') != COALESCE(T3.HJI_DT, '99991231')
                                             AND COALESCE(T3.MKDT, T3.IN_DATE, '00010101') <= T1.DW_BAS_DDT
                                             AND COALESCE(T3.HJI_DT, T3.OUT_DATE, '99991231') > T1.DW_BAS_DDT
                                             AND T4.REF_L_C = 50
                                             AND T4.REF_M_C = 42
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
                                             AND T2.GEUMGO_CODE = 42
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
) T10000
, ACL_SIGUMGO_MAS T20000
, RPT_AC_BY_HOIKYE_MAPP T30000
WHERE 1 = 1
                             AND T20000.MNG_NO = 1
                             AND T20000.SIGUMGO_AGE_AC_G IN (0,1) 
                             AND T20000.FIL_100_CTNT2(+) = T10000.GYEJWA_NO
                             AND T30000.SIGUMGO_ACNO(+) = T20000.FIL_100_CTNT2
                             AND T30000.SIGUMGO_HOIKYE_YR(+) = T20000.SIGUMGO_HOIKYE_YR
                             AND T30000.SIGUMGO_C(+) = T20000.SIGUMGO_ORG_C
                             ) T100000
GROUP BY GYEJWA_NO 
                       , GYEJWA_NM
                       , MAPP_HOIGYE_CODE
ORDER BY MAPP_HOIGYE_CODE
       , GYEJWA_NO
       , GYEJWA_NM
-----------------------------------------


SELECT T10.GEUMGO_CODE
                                       , T10.GONGGEUM_GYEJWA
                                       , T20.SIGUMGO_AC_NM
                                       , T10.UNYONG_GYEJWA
                                       , T10.GIGAN_GUBUN
                                       , SUM(T10.JUCHUK_AMT) AS JUCHUK_AMT
                                       , SUM(T10.UY_100_AMT) AS UY_100_AMT
                                       , SUM(T10.UY_140_AMT) AS UY_140_AMT
                                       , SUM(T10.UY_160_AMT) AS UY_160_AMT
                                       , SUM(T10.UY_ETC_AMT) AS UY_ETC_AMT
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
                                               , CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) IN ('100') THEN T2.JANAEK END AS UY_100_AMT
                                               , CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) IN ('140') THEN T2.JANAEK END AS UY_140_AMT 
                                               , CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) IN ('160') THEN T2.JANAEK END AS UY_160_AMT
                                               , CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) NOT IN ('100', '140', '160', '200', '207') THEN T2.JANAEK END AS UY_ETC_AMT
                                            FROM MAP_JOB_DATE T1
                                               , RPT_UNYONG_JAN T2
                                               , RPT_UNYONG_GYEJWA T3
                                           WHERE 1 = 1
                                             AND T1.DW_BAS_DDT BETWEEN '20240101' AND '20241231'
                                             AND T2.KIJUNIL = CASE WHEN T1.DT_G IN (0) THEN T1.DW_BAS_DDT ELSE T1.BF1_BIZ_DT END
                                             AND T2.GEUMGO_CODE = 42
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


---------------------------------------------------------------------------------------

SELECT T10.GEUMGO_CODE
                                       , T10.GONGGEUM_GYEJWA
                                       , T20.SIGUMGO_AC_NM
                                       , T10.UNYONG_GYEJWA
                                       , T10.GIGAN_GUBUN
                                       , SUM(T10.JUCHUK_AMT) AS JUCHUK_AMT
                                       , SUM(T10.UY_100_AMT) AS UY_100_AMT
                                       , SUM(T10.UY_140_AMT) AS UY_140_AMT
                                       , SUM(T10.UY_160_AMT) AS UY_160_AMT
                                       , SUM(T10.UY_ETC_AMT) AS UY_ETC_AMT
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
                                               , CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) IN ('100') THEN T2.JANAEK END AS UY_100_AMT
                                               , CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) IN ('140') THEN T2.JANAEK END AS UY_140_AMT 
                                               , CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) IN ('160') THEN T2.JANAEK END AS UY_160_AMT
                                               , CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) NOT IN ('100', '140', '160', '200', '207') THEN T2.JANAEK END AS UY_ETC_AMT
                                            FROM MAP_JOB_DATE T1
                                               , RPT_UNYONG_JAN T2
                                               , RPT_UNYONG_GYEJWA T3
                                           WHERE 1 = 1
                                             AND T1.DW_BAS_DDT BETWEEN '20240101' AND '20241231'
                                             AND T2.KIJUNIL = CASE WHEN T1.DT_G IN (0) THEN T1.DW_BAS_DDT ELSE T1.BF1_BIZ_DT END
                                             AND T2.GEUMGO_CODE = 42
                                             AND SUBSTR(T2.GONGGEUM_GYEJWA, 4, 3) = LPAD('0', 3, '0')
                                             AND T2.JANAEK != 0
                                             AND T2.GONGGEUM_GYEJWA NOT IN ('04200080900003999')
                                             AND T2.UNYONG_GYEJWA NOT IN ('000000000000')
                                             AND T3.GONGGEUM_GYEJWA(+) = T2.GONGGEUM_GYEJWA
                                             AND T3.UNYONG_GYEJWA(+) = T2.UNYONG_GYEJWA
                                             AND T3.BANK_GUBUN(+) = 0
                                             AND COALESCE(T3.MKDT, T3.IN_DATE, '00010101') != COALESCE(T3.HJI_DT, '99991231')
                                             AND COALESCE(T3.MKDT, T3.IN_DATE, '00010101') <= T1.DW_BAS_DDT
                                             AND COALESCE(T3.HJI_DT, T3.OUT_DATE, '99991231') >= T1.DW_BAS_DDT
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

-------------------------------------------------------------------------------------------------

SELECT T10.GEUMGO_CODE
                                       , T10.GONGGEUM_GYEJWA
                                       , T20.SIGUMGO_AC_NM
                                       , T10.UNYONG_GYEJWA
                                       , T10.GIGAN_GUBUN
                                       , SUM(T10.JUCHUK_AMT) AS JUCHUK_AMT
                                       , SUM(T10.UY_100_AMT) AS UY_100_AMT
                                       , SUM(T10.UY_140_AMT) AS UY_140_AMT
                                       , SUM(T10.UY_160_AMT) AS UY_160_AMT
                                       , SUM(T10.UY_ETC_AMT) AS UY_ETC_AMT
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
                                               , CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) IN ('100') THEN T2.JANAEK END AS UY_100_AMT
                                               , CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) IN ('140') THEN T2.JANAEK END AS UY_140_AMT 
                                               , CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) IN ('160') THEN T2.JANAEK END AS UY_160_AMT
                                               , CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) NOT IN ('100', '140', '160', '200', '207') THEN T2.JANAEK END AS UY_ETC_AMT
                                            FROM MAP_JOB_DATE T1
                                               , RPT_UNYONG_JAN T2
                                               , RPT_UNYONG_GYEJWA T3
                                           WHERE 1 = 1
                                             AND T1.DW_BAS_DDT BETWEEN '20240101' AND '20241231'
                                             AND T2.KIJUNIL = CASE WHEN T1.DT_G IN (0) THEN T1.DW_BAS_DDT ELSE T1.BF1_BIZ_DT END
                                             AND T2.GEUMGO_CODE = 42
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
                                         , RPT_AC_BY_HOIKYE_MAPP T30
                                   WHERE 1 = 1
                                   AND T20.MNG_NO = 1
                                   AND T20.SIGUMGO_AGE_AC_G IN (0,1) 
                                   AND T20.FIL_100_CTNT2(+) = T10.GONGGEUM_GYEJWA
                                   AND T30.SIGUMGO_HOIKYE_YR(+) = T20.SIGUMGO_HOIKYE_YR
                                   AND T30.SIGUMGO_C(+) = T20.SIGUMGO_ORG_C
                                   AND T30.SIGUMGO_ACNO(+) = T20.FIL_100_CTNT2
                                GROUP BY T10.GEUMGO_CODE
                                       , T10.GONGGEUM_GYEJWA
                                       , T20.SIGUMGO_AC_NM
                                       , T10.UNYONG_GYEJWA
                                       , T10.GIGAN_GUBU
                                       
---------------------------------------------------------------

SELECT /*+ LEADING(T1 T2 T3) INDEX(T2 RPT_UNYONG_JAN_UK_01) */
                                                 T2.GEUMGO_CODE
                                               , T2.GONGGEUM_GYEJWA
                                               , T2.UNYONG_GYEJWA
                                               , CASE WHEN MONTHS_BETWEEN(TO_DATE(T2.DUDT, 'YYYYMMDD'), TO_DATE(T2.MKDT, 'YYYYMMDD')) >= 6 THEN '1'
                                                      WHEN MONTHS_BETWEEN(TO_DATE(T2.DUDT, 'YYYYMMDD'), TO_DATE(T2.MKDT, 'YYYYMMDD')) >= 3 THEN '2'
                                                      WHEN MONTHS_BETWEEN(TO_DATE(T2.DUDT, 'YYYYMMDD'), TO_DATE(T2.MKDT, 'YYYYMMDD')) >= 1 THEN '3'
                                                      ELSE '4'
                                                 END AS GIGAN_GUBUN
                                               , CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) IN ('200', '207') THEN T2.JANAEK END AS JUCHUK_AMT
                                               , CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) IN ('100') THEN T2.JANAEK END AS UY_100_AMT
                                               , CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) IN ('140') THEN T2.JANAEK END AS UY_140_AMT 
                                               , CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) IN ('160') THEN T2.JANAEK END AS UY_160_AMT
                                               , CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) NOT IN ('100', '140', '160', '200', '207') THEN T2.JANAEK END AS UY_ETC_AMT
                                            FROM MAP_JOB_DATE T1
                                               , RPT_UNYONG_JAN T2
                                               , RPT_UNYONG_GYEJWA T3
                                           WHERE 1 = 1
                                             AND T1.DW_BAS_DDT BETWEEN '20240101' AND '20241231'
                                             AND T2.KIJUNIL = CASE WHEN T1.DT_G IN (0) THEN T1.DW_BAS_DDT ELSE T1.BF1_BIZ_DT END
                                             AND T2.GEUMGO_CODE = 42
                                             AND SUBSTR(T2.GONGGEUM_GYEJWA, 4, 3) = LPAD('0', 3, '0')
                                             AND T2.JANAEK != 0
                                             AND T2.GONGGEUM_GYEJWA NOT IN ('04200080900003999')
                                             AND T2.UNYONG_GYEJWA NOT IN ('000000000000')
                                             AND T3.GONGGEUM_GYEJWA(+) = T2.GONGGEUM_GYEJWA
                                             AND T3.UNYONG_GYEJWA(+) = T2.UNYONG_GYEJWA
                                             AND T3.BANK_GUBUN(+) = 0
                                             AND COALESCE(T3.MKDT, T3.IN_DATE, '00010101') != COALESCE(T3.HJI_DT, '99991231')
                                             AND COALESCE(T3.MKDT, T3.IN_DATE, '00010101') <= T1.DW_BAS_DDT
                                             AND COALESCE(T3.HJI_DT, T3.OUT_DATE, '99991231') >= T1.DW_BAS_DDT

----------------------------------------------------------------------------------------------------------------------------------------                                             

SELECT /*+ LEADING(T1 T2 T3) INDEX(T2 RPT_UNYONG_JAN_UK_01) */
                                                 T2.GEUMGO_CODE
                                               , T2.GONGGEUM_GYEJWA
                                               , T2.UNYONG_GYEJWA
                                               , CASE WHEN MONTHS_BETWEEN(TO_DATE(T2.DUDT, 'YYYYMMDD'), TO_DATE(T2.MKDT, 'YYYYMMDD')) >= 6 THEN '1'
                                                      WHEN MONTHS_BETWEEN(TO_DATE(T2.DUDT, 'YYYYMMDD'), TO_DATE(T2.MKDT, 'YYYYMMDD')) >= 3 THEN '2'
                                                      WHEN MONTHS_BETWEEN(TO_DATE(T2.DUDT, 'YYYYMMDD'), TO_DATE(T2.MKDT, 'YYYYMMDD')) >= 1 THEN '3'
                                                      ELSE '4'
                                                 END AS GIGAN_GUBUN
                                               , CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) IN ('200', '207') THEN T2.JANAEK END AS JUCHUK_AMT
                                               , CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) IN ('100') THEN T2.JANAEK END AS UY_100_AMT
                                               , CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) IN ('140') THEN T2.JANAEK END AS UY_140_AMT 
                                               , CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) IN ('160') THEN T2.JANAEK END AS UY_160_AMT
                                               , CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) NOT IN ('100', '140', '160', '200', '207') THEN T2.JANAEK END AS UY_ETC_AMT
                                            FROM MAP_JOB_DATE T1
                                               , RPT_UNYONG_JAN T2
                                               , RPT_UNYONG_GYEJWA T3
                                           WHERE 1 = 1
                                             AND T1.DW_BAS_DDT BETWEEN '20240101' AND '20241231'
                                             AND T2.KIJUNIL = CASE WHEN T1.DT_G IN (0) THEN T1.DW_BAS_DDT ELSE T1.BF1_BIZ_DT END
                                             AND T2.GEUMGO_CODE = 42
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