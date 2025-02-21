SELECT T10000.GAJUNG_IYUL AS ALL_PYUNG_IYUL
     , T10000.MAX_IYUL AS ALL_MAX_IYUL
     , T10000.MIN_IYUL AS ALL_MIN_IYUL
     , T20000.CMM_DTL_C_NM AS GEUMGO_NAME
     , T30000.CMM_DTL_C_NM AS GUNGU_NAME
FROM (SELECT ROUND(SUM(T1000.GAJUNG_AMT) / SUM(T1000.JUCHUK_AMT), 8) AS GAJUNG_IYUL
           , MAX(T1000.MAX_IYUL) AS MAX_IYUL
           , MIN(T1000.MIN_IYUL) AS MIN_IYUL
      FROM (


          SELECT SUM(T100.JUCHUK_AMT * T200.IYUL) AS GAJUNG_AMT
               , MAX(DECODE(T200.IYUL, 0, NULL, T200.IYUL)) AS MAX_IYUL
               , MIN(DECODE(T200.IYUL, 0, NULL, T200.IYUL)) AS MIN_IYUL
               , SUM(T100.JUCHUK_AMT) AS JUCHUK_AMT
          FROM (SELECT T10.GEUMGO_CODE
                     , T10.GONGGEUM_GYEJWA
                     , T10.UNYONG_GYEJWA
                     , SUM(T10.JUCHUK_AMT) AS JUCHUK_AMT
                FROM (SELECT
                          T2.GEUMGO_CODE
                           , T2.GONGGEUM_GYEJWA
                           , T2.UNYONG_GYEJWA
                           , CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) IN ('200', '207') THEN T2.JANAEK END AS JUCHUK_AMT
                      FROM MAP_JOB_DATE T1
                         , RPT_UNYONG_JAN T2
                         , RPT_UNYONG_GYEJWA T3
                      WHERE 1 = 1
                       AND T3.GONGGEUM_GYEJWA IN (
                            SELECT
                             FIL_100_CTNT5
                            FROM ACL_SIGUMGO_MAS
                            WHERE MNG_NO = 1
                            AND SIGUMGO_ORG_C = 110
                        )
                        AND T1.DW_BAS_DDT BETWEEN '20240101' AND '20241231'
                        AND T2.KIJUNIL = CASE WHEN T1.DT_G IN (0) THEN T1.DW_BAS_DDT ELSE T1.BF1_BIZ_DT END
                        AND T2.GEUMGO_CODE = 110
                        AND T2.GONGGEUM_GYEJWA NOT IN ('04200080900003999')
                        AND T2.UNYONG_GYEJWA NOT IN ('000000000000')
                        AND MONTHS_BETWEEN(TO_DATE(T2.DUDT, 'YYYYMMDD'), TO_DATE(T2.MKDT, 'YYYYMMDD')) >= 1
                        AND T3.GONGGEUM_GYEJWA(+) = T2.GONGGEUM_GYEJWA
                        AND T3.UNYONG_GYEJWA(+) = T2.UNYONG_GYEJWA
                        AND T3.BANK_GUBUN(+) = 0
                        AND COALESCE(T3.MKDT, T3.IN_DATE, '00010101') != COALESCE(T3.HJI_DT, '99991231')
                                                     AND COALESCE(T3.MKDT, T3.IN_DATE, '00010101') <= T1.DW_BAS_DDT
                                                     AND COALESCE(T3.HJI_DT, T3.OUT_DATE, '99991231') > T1.DW_BAS_DDT
                     ) T10
                WHERE 1 = 1
                GROUP BY T10.GEUMGO_CODE
                       , T10.GONGGEUM_GYEJWA
                       , T10.UNYONG_GYEJWA
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
                FROM (SELECT
                          T2.GEUMGO_CODE
                           , T2.GONGGEUM_GYEJWA
                           , T2.UNYONG_GYEJWA
                           , MAX(T2.KIJUNIL) AS MAX_KIJUNIL
                      FROM MAP_JOB_DATE T1
                         , RPT_UNYONG_JAN T2
                         , RPT_UNYONG_GYEJWA T3
                      WHERE 1 = 1
                        AND T3.GONGGEUM_GYEJWA IN (
                          SELECT
                              FIL_100_CTNT5
                          FROM ACL_SIGUMGO_MAS
                          WHERE MNG_NO = 1
                            AND SIGUMGO_ORG_C = 110
                      )
                        AND T1.DW_BAS_DDT BETWEEN '20240101' AND '20241231'
                        AND T2.KIJUNIL = CASE WHEN T1.DT_G IN (0) THEN T1.DW_BAS_DDT ELSE T1.BF1_BIZ_DT END
                        AND T2.GEUMGO_CODE = 110
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


          UNION ALL


          SELECT SUM(T100.JUCHUK_AMT * T200.IYUL) AS GAJUNG_AMT
               , MAX(DECODE(T200.IYUL, 0, NULL, T200.IYUL)) AS MAX_IYUL
               , MIN(DECODE(T200.IYUL, 0, NULL, T200.IYUL)) AS MIN_IYUL
               , SUM(T100.JUCHUK_AMT) AS JUCHUK_AMT
          FROM (SELECT T10.GEUMGO_CODE
                     , T10.GONGGEUM_GYEJWA
                     , T10.UNYONG_GYEJWA
                     , SUM(T10.JUCHUK_AMT) AS JUCHUK_AMT
                FROM (SELECT T2.GEUMGO_CODE
                           , T2.GONGGEUM_GYEJWA
                           , T2.UNYONG_GYEJWA
                           , T2.JANAEK AS JUCHUK_AMT
                      FROM MAP_JOB_DATE T1
                         , RPT_UNYONG_JAN T2
                         , RPT_UNYONG_GYEJWA T3
                         , RPT_CODE_INFO T4
                      WHERE 1 = 1
                        AND T3.GONGGEUM_GYEJWA IN (
                          SELECT
                              FIL_100_CTNT5
                          FROM ACL_SIGUMGO_MAS
                          WHERE MNG_NO = 1
                            AND SIGUMGO_ORG_C = 110
                      )
                        AND T1.DW_BAS_DDT BETWEEN '20240101' AND '20241231'
                        AND T2.KIJUNIL = CASE WHEN T1.DT_G IN (0) THEN T1.DW_BAS_DDT ELSE T1.BF1_BIZ_DT END
                        AND T2.GEUMGO_CODE = 110
                        AND MONTHS_BETWEEN(TO_DATE(T2.DUDT, 'YYYYMMDD'), TO_DATE(T2.MKDT, 'YYYYMMDD')) >= 1
                        AND T3.GONGGEUM_GYEJWA(+) = T2.GONGGEUM_GYEJWA
                        AND T3.UNYONG_GYEJWA(+) = T2.UNYONG_GYEJWA
                        AND T3.BANK_GUBUN(+) = 0
                        AND COALESCE(T3.MKDT, T3.IN_DATE, '00010101') != COALESCE(T3.HJI_DT, '99991231')
                                                     AND COALESCE(T3.MKDT, T3.IN_DATE, '00010101') <= T1.DW_BAS_DDT
                                                     AND COALESCE(T3.HJI_DT, T3.OUT_DATE, '99991231') > T1.DW_BAS_DDT
                                                     AND T4.REF_L_C = 50
                                                     AND T4.REF_M_C = 110
                                                     AND T4.YUHYO_YN = 0
                                                     AND T4.REF_D_NM = T3.GONGGEUM_GYEJWA

                     ) T10
                WHERE 1 = 1
                GROUP BY T10.GEUMGO_CODE
                       , T10.GONGGEUM_GYEJWA
                       , T10.UNYONG_GYEJWA
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
                FROM (SELECT
                          T2.GEUMGO_CODE
                           , T2.GONGGEUM_GYEJWA
                           , T2.UNYONG_GYEJWA
                           , MAX(T2.KIJUNIL) AS MAX_KIJUNIL
                      FROM MAP_JOB_DATE T1
                         , RPT_UNYONG_JAN T2
                         , RPT_UNYONG_GYEJWA T3
                      WHERE 1 = 1
                        AND T3.GONGGEUM_GYEJWA IN (
                          SELECT
                              FIL_100_CTNT5
                          FROM ACL_SIGUMGO_MAS
                          WHERE MNG_NO = 1
                            AND SIGUMGO_ORG_C = 110
                      )
                        AND T1.DW_BAS_DDT BETWEEN '20240101' AND '20241231'
                        AND T2.KIJUNIL = CASE WHEN T1.DT_G IN (0) THEN T1.DW_BAS_DDT ELSE T1.BF1_BIZ_DT END
                        AND T2.GEUMGO_CODE = 110
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


      ) T1000
         , (SELECT COUNT(1) AS DCNT
            FROM MAP_JOB_DATE
            WHERE DW_BAS_DDT BETWEEN '20240101' AND '20241231') T2000
      WHERE 1 = 1
) T10000
   , SFI_CMM_C_DAT T20000
   , SFI_CMM_C_DAT T30000
WHERE 1 = 1
  AND T20000.CMM_C_NM = 'RPT시도금고코드'
  AND T20000.CMM_DTL_C = '110'
  AND T20000.USE_YN = 'Y'
  AND T30000.CMM_C_NM = 'RPT군구코드'
  AND T30000.HRNK_CMM_DTL_C = '110'
  AND TO_NUMBER(T30000.CMM_DTL_C) = TO_NUMBER(0)
  AND T30000.USE_YN = 'Y'