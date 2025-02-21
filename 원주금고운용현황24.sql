SELECT T10000.MAPP_HOIGYE_CODE
     , T10000.GYEJWA_NO
     , T10000.GONGGEUM_GYEJWA_NM AS GYEJWA_NM
     , G.CMM_DTL_C AS GUBUN_CMM_DTL_C
     , G.HRNK_CMM_C_NM AS GUBUN_NAME
     , G.CMM_DTL_C_NM AS GROUP_NAME
     , NVL(G.SORT_SNO, 9999) AS GUBUN_SORT_SNO
     , GG.CMM_DTL_C AS GROUP_CMM_DTL_C
     , SUM(T10000.GONGGEUM_AMT) AS GONGGEUM_AMT
     , SUM(T10000.UY_100_AMT) AS UY_100_AMT
     , SUM(T10000.UY_140_AMT) AS UY_140_AMT
     , SUM(T10000.UY_160_AMT) AS UY_160_AMT
     , SUM(T10000.UY_200_AMT) AS UY_200_AMT
     , SUM(T10000.UY_ETC_AMT) AS UY_ETC_AMT
     , SUM(T10000.MMDA_AMT) AS MMDA_AMT
     , SUM(T10000.KG_AMT) AS KG_AMT
     , SUM(T10000.SOGYE) AS SOGYE
     , SUM(T10000.HAPGYE) AS HAPGYE
     , SUM(T10000.ALL_JUCHUK_AMT) AS ALL_JUCHUK_AMT
     , SUM(T10000.ALL_MMDA_AMT) AS ALL_MMDA_AMT
     , SUM(T10000.JI_IJA) AS JI_IJA
FROM (SELECT T1000.MAPP_HOIGYE_CODE
           , T1000.GONGGEUM_GYEJWA_NO
           , T1000.UNYONG_GYEJWA_NO
           , T1000.GONGGEUM_GYEJWA_NM
           , DECODE(130, '42', LPAD(T2000.LINKAC_KWA_C, 3, '0') || LPAD(T2000.LINK_ACSER, 9, '0'), T1000.GONGGEUM_GYEJWA_NO) AS GYEJWA_NO
           , T1000.GONGGEUM_AMT
           , T1000.UY_100_AMT
           , T1000.UY_140_AMT
           , T1000.UY_160_AMT
           , T1000.UY_200_AMT
           , T1000.UY_ETC_AMT
           , T1000.MMDA_AMT
           , T1000.KG_AMT
           , T1000.GONGGEUM_AMT + T1000.UY_100_AMT + T1000.UY_140_AMT + T1000.MMDA_AMT AS SOGYE
           , T1000.GONGGEUM_AMT + T1000.UY_100_AMT + T1000.UY_140_AMT + T1000.MMDA_AMT + T1000.UY_200_AMT + T1000.KG_AMT AS HAPGYE
           , T1000.UY_200_AMT + T1000.KG_AMT AS ALL_JUCHUK_AMT
           , T1000.UY_140_AMT + T1000.MMDA_AMT AS ALL_MMDA_AMT
           , T1000.JI_IJA AS JI_IJA
      FROM (SELECT T100.MAPP_HOIGYE_CODE
                 , T100.GONGGEUM_GYEJWA_NO
                 , T100.GONGGEUM_GYEJWA_NM
                 , T100.UNYONG_GYEJWA_NO
                 , ROUND(SUM(NVL(T100.GONGGEUM_AMT, 0) / T200.DCNT), 8) AS GONGGEUM_AMT
                 , ROUND(SUM(NVL(T100.UY_100_AMT, 0) / T200.DCNT), 8) AS UY_100_AMT
                 , ROUND(SUM(NVL(T100.UY_140_AMT, 0) / T200.DCNT), 8) AS UY_140_AMT
                 , ROUND(SUM(NVL(T100.UY_160_AMT, 0) / T200.DCNT), 8) AS UY_160_AMT
                 , ROUND(SUM(NVL(T100.UY_200_AMT, 0) / T200.DCNT), 8) AS UY_200_AMT
                 , ROUND(SUM(NVL(T100.UY_ETC_AMT, 0) / T200.DCNT), 8) AS UY_ETC_AMT
                 , ROUND(SUM(NVL(T100.MMDA_AMT, 0) / T200.DCNT), 8) AS MMDA_AMT
                 , ROUND(SUM(NVL(T100.KG_AMT, 0) / T200.DCNT), 8) AS KG_AMT
                 , SUM(NVL(T100.JI_IJA, 0)) AS JI_IJA
            FROM (

                SELECT TO_NUMBER(DECODE(130, 28, T20.ICH_SIGUMGO_HOIKYE_C, T30.SIGUMGO_HOIKYE_C)) AS MAPP_HOIGYE_CODE
                     , T10.GONGGEUM_GYEJWA AS GONGGEUM_GYEJWA_NO
                     , T20.SIGUMGO_AC_NM AS GONGGEUM_GYEJWA_NM
                     , NULL AS UNYONG_GYEJWA_NO
                     , T10.GONGGEUM_AMT
                     , NULL AS UY_100_AMT
                     , NULL AS UY_140_AMT
                     , NULL AS UY_160_AMT
                     , NULL AS UY_200_AMT
                     , NULL AS UY_ETC_AMT
                     , NULL AS MMDA_AMT
                     , NULL AS KG_AMT
                     , T40.IJA AS JI_IJA
                FROM (SELECT /*+ INDEX(T1 RPT_GONGGEUM_JAN_IX_01) */
                          T1.GEUMGO_CODE
                           , T1.GUNGU_CODE
                           , T1.GONGGEUM_GYEJWA
                           , SUM(T1.JANAEK) AS GONGGEUM_AMT
                      FROM RPT_GONGGEUM_JAN T1
                      WHERE T1.GEUMGO_CODE = 130
                        AND T1.GUNGU_CODE = 0
                        AND T1.KEORAEIL BETWEEN '20240101' AND '20241231'
                        AND T1.GONGGEUM_GYEJWA NOT IN ('04200080900003999')
                        AND T1.JANAEK != 0
                      GROUP BY  T1.GEUMGO_CODE
                              , T1.GUNGU_CODE
                              , T1.GONGGEUM_GYEJWA
                ) T10
                   , ACL_SIGUMGO_MAS T20
                   , RPT_AC_BY_HOIKYE_MAPP T30
                   , (SELECT  GONGGEUM_GYEJWA, SUM(IJA) AS IJA
                      FROM RPT_GONGGEUM_GYULSAN_TMP
                      WHERE GEUMGO_CODE = 130
                        AND GYULSAN_IL IN (SELECT REF_S_NM FROM RPT_CODE_INFO WHERE REF_L_C = 200 AND REF_M_C = 999 AND REF_S_NM BETWEEN '20240101' AND '20241231')
                        AND IJA > 0
                      GROUP BY GONGGEUM_GYEJWA
                ) T40
                WHERE 1 = 1
                  AND T20.MNG_NO = 1
                  AND T20.SIGUMGO_AGE_AC_G IN (0,1)
                  AND T20.FIL_100_CTNT2(+) = T10.GONGGEUM_GYEJWA
                  AND T30.SIGUMGO_ACNO(+) = T20.FIL_100_CTNT2
                  AND T30.SIGUMGO_HOIKYE_YR(+) = T20.SIGUMGO_HOIKYE_YR
                  AND T30.SIGUMGO_C(+) = T20.SIGUMGO_ORG_C
                  AND T10.GONGGEUM_GYEJWA = T40.GONGGEUM_GYEJWA(+)
                UNION ALL



                SELECT TO_NUMBER(DECODE(130, 28, T20.ICH_SIGUMGO_HOIKYE_C, T30.SIGUMGO_HOIKYE_C)) AS MAPP_HOIGYE_CODE
                     , T10.GONGGEUM_GYEJWA AS GONGGEUM_GYEJWA_NO
                     , T20.SIGUMGO_AC_NM AS GONGGEUM_GYEJWA_NM
                     , T10.UNYONG_GYEJWA AS UNYONG_GYEJWA_NO
                     , NULL AS GONGGEUM_AMT
                     , T10.UY_100_AMT
                     , T10.UY_140_AMT
                     , T10.UY_160_AMT
                     , T10.UY_200_AMT
                     , T10.UY_ETC_AMT
                     , NULL AS MMDA_AMT
                     , NULL AS KG_AMT
                     , T10.JI_IJA
                FROM (SELECT /*+ LEADING(T1 T2 T3) INDEX(T2 RPT_UNYONG_JAN_UK_01) */
                          T2.GONGGEUM_GYEJWA
                           , T2.UNYONG_GYEJWA
                           , SUM(CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) IN ('100') AND COALESCE(T3.HJI_DT, T3.OUT_DATE, '99991231') > T1.DW_BAS_DDT THEN T2.JANAEK END) AS UY_100_AMT
                           , SUM(CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) IN ('140') AND COALESCE(T3.HJI_DT, T3.OUT_DATE, '99991231') > T1.DW_BAS_DDT THEN T2.JANAEK END) AS UY_140_AMT
                           , SUM(CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) IN ('160') AND COALESCE(T3.HJI_DT, T3.OUT_DATE, '99991231') > T1.DW_BAS_DDT THEN T2.JANAEK END) AS UY_160_AMT
                           , SUM(CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) IN ('200', '207') AND COALESCE(T3.HJI_DT, T3.OUT_DATE, '99991231') > T1.DW_BAS_DDT THEN T2.JANAEK END) AS UY_200_AMT
                           , SUM(CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) NOT IN ('100', '140', '160', '200', '207') AND COALESCE(T3.HJI_DT, T3.OUT_DATE, '99991231') > T1.DW_BAS_DDT THEN T2.JANAEK END) AS UY_ETC_AMT
                           , SUM(CASE WHEN T1.DT_G IN (0) THEN T2.JI_IJA END) AS JI_IJA
                      FROM MAP_JOB_DATE T1
                         , RPT_UNYONG_JAN T2
                         , RPT_UNYONG_GYEJWA T3
                      WHERE 1 = 1
                        AND T1.DW_BAS_DDT BETWEEN '20240101' AND '20241231'
                        AND T2.KIJUNIL = CASE WHEN T1.DT_G IN (0) THEN T1.DW_BAS_DDT ELSE T1.BF1_BIZ_DT END
                        AND T2.GEUMGO_CODE = 130
                        AND SUBSTR(T2.GONGGEUM_GYEJWA, 4, 3) = LPAD('0', 3, '0')
                        AND T2.GONGGEUM_GYEJWA NOT IN ('04200080900003999')
                        AND T2.UNYONG_GYEJWA NOT IN ('000000000000')
                        AND T3.GONGGEUM_GYEJWA(+) = T2.GONGGEUM_GYEJWA
                        AND T3.UNYONG_GYEJWA(+) = T2.UNYONG_GYEJWA
                        AND T3.BANK_GUBUN(+) = 0
                        AND COALESCE(T3.MKDT, T3.IN_DATE, '00010101') != COALESCE(T3.HJI_DT, '99991231')
                                     AND COALESCE(T3.MKDT, T3.IN_DATE, '00010101') <= T1.DW_BAS_DDT
                                     AND COALESCE(T3.HJI_DT, T3.OUT_DATE, '99991231') >= T1.DW_BAS_DDT
                      GROUP BY T2.GONGGEUM_GYEJWA
                              , T2.UNYONG_GYEJWA
                ) T10
                   , ACL_SIGUMGO_MAS T20
                   , RPT_AC_BY_HOIKYE_MAPP T30
                WHERE 1 = 1
                  AND T20.MNG_NO = 1
                  AND T20.SIGUMGO_AGE_AC_G IN (0,1)
                  AND T20.FIL_100_CTNT2(+) = T10.GONGGEUM_GYEJWA
                  AND T30.SIGUMGO_ACNO(+) = T20.FIL_100_CTNT2
                  AND T30.SIGUMGO_HOIKYE_YR(+) = T20.SIGUMGO_HOIKYE_YR
                  AND T30.SIGUMGO_C(+) = T20.SIGUMGO_ORG_C


                UNION ALL



                SELECT TO_NUMBER(T30.SIGUMGO_HOIKYE_C) AS MAPP_HOIGYE_CODE
                     , T10.GONGGEUM_GYEJWA AS GONGGEUM_GYEJWA_NO
                     , T20.SIGUMGO_AC_NM AS GONGGEUM_GYEJWA_NM
                     , T10.UNYONG_GYEJWA AS UNYONG_GYEJWA_NO
                     , NULL AS GONGGEUM_AMT
                     , NULL AS UY_100_AMT
                     , NULL AS UY_140_AMT
                     , NULL AS UY_160_AMT
                     , NULL AS UY_200_AMT
                     , NULL AS UY_ETC_AMT
                     , T10.MMDA_AMT
                     , NULL AS KG_AMT
                     , T10.JI_IJA
                FROM (SELECT /*+ LEADING(T1 T2) INDEX(T2 RPT_UNYONG_JAN_UK_01) */
                          T2.GONGGEUM_GYEJWA
                           , T2.UNYONG_GYEJWA
                           , SUM(T2.JANAEK) AS MMDA_AMT
                           , SUM(CASE WHEN T1.DT_G IN (0) THEN T2.JI_IJA END) AS JI_IJA
                      FROM MAP_JOB_DATE T1
                         , RPT_UNYONG_JAN T2
                      WHERE T1.DW_BAS_DDT BETWEEN '20240101' AND '20241231'
                        AND T2.KIJUNIL = CASE WHEN T1.DT_G IN (0) THEN T1.DW_BAS_DDT ELSE T1.BF1_BIZ_DT END
                        AND T2.GEUMGO_CODE = 130
                        AND SUBSTR(T2.GONGGEUM_GYEJWA, 4, 3) = LPAD('0', 3, '0')
                        AND T2.GONGGEUM_GYEJWA NOT IN ('04200080900003999')
                        AND T2.UNYONG_GYEJWA IN ('000000000000')
                      GROUP BY T2.GONGGEUM_GYEJWA
                             , T2.UNYONG_GYEJWA
                      HAVING SUM(T2.JANAEK) != 0
                ) T10
                   , ACL_SIGUMGO_MAS T20
                   , RPT_AC_BY_HOIKYE_MAPP T30
                WHERE 1 = 1
                  AND T20.MNG_NO = 1
                  AND T20.SIGUMGO_AGE_AC_G IN (0,1)
                  AND T20.FIL_100_CTNT2(+) = T10.GONGGEUM_GYEJWA
                  AND T30.SIGUMGO_ACNO(+) = T20.FIL_100_CTNT2
                  AND T30.SIGUMGO_HOIKYE_YR(+) = T20.SIGUMGO_HOIKYE_YR
                  AND T30.SIGUMGO_C(+) = T20.SIGUMGO_ORG_C

                UNION ALL


                SELECT T10.MAPP_HOIGYE_CODE
                     , T10.GONGGEUM_GYEJWA AS GONGGEUM_GYEJWA_NO
                     , T10.GONGGEUM_GYEJWA_NM
                     , T10.UNYONG_GYEJWA AS UNYONG_GYEJWA_NO
                     , NULL AS GONGGEUM_AMT
                     , NULL AS UY_100_AMT
                     , NULL AS UY_140_AMT
                     , NULL AS UY_160_AMT
                     , NULL AS UY_200_AMT
                     , NULL AS UY_ETC_AMT
                     , NULL AS MMDA_AMT
                     , T10.KG_AMT
                     , T10.JI_IJA
                FROM (SELECT T2.GONGGEUM_GYEJWA
                           , T2.UNYONG_GYEJWA
                           , SUM(CASE WHEN COALESCE(T3.HJI_DT, T3.OUT_DATE, '99991231') > T1.DW_BAS_DDT THEN T2.JANAEK END) AS KG_AMT
                           , T4.REF_D_C + 900 AS MAPP_HOIGYE_CODE
                           , T4.REF_CTNT1 AS GONGGEUM_GYEJWA_NM
                           , SUM(CASE WHEN T1.DT_G IN (0) THEN T2.JI_IJA END) AS JI_IJA
                      FROM MAP_JOB_DATE T1
                         , RPT_UNYONG_JAN T2
                         , RPT_UNYONG_GYEJWA T3
                         , RPT_CODE_INFO T4
                      WHERE 1 = 1
                        AND T1.DW_BAS_DDT BETWEEN '20240101' AND '20241231'
                        AND T2.KIJUNIL = CASE WHEN T1.DT_G IN (0) THEN T1.DW_BAS_DDT ELSE T1.BF1_BIZ_DT END
                        AND T2.GEUMGO_CODE = 130
                        AND SUBSTR(T2.GONGGEUM_GYEJWA, 4, 3) = LPAD('0', 3, '0')
                        AND T3.GONGGEUM_GYEJWA(+) = T2.GONGGEUM_GYEJWA
                        AND T3.UNYONG_GYEJWA(+) = T2.UNYONG_GYEJWA
                        AND T3.BANK_GUBUN(+) = 0
                        AND COALESCE(T3.MKDT, T3.IN_DATE, '00010101') != COALESCE(T3.HJI_DT, '99991231')
                                     AND COALESCE(T3.MKDT, T3.IN_DATE, '00010101') <= T1.DW_BAS_DDT
                                     AND COALESCE(T3.HJI_DT, T3.OUT_DATE, '99991231') >= T1.DW_BAS_DDT
                                     AND T4.REF_L_C = 50
                                     AND T4.REF_M_C = 130
                                     AND T4.YUHYO_YN = 0
                                     AND T4.REF_D_NM = T3.GONGGEUM_GYEJWA
                      GROUP BY T2.GONGGEUM_GYEJWA
                              , T2.UNYONG_GYEJWA
                              , T4.REF_D_C
                              , T4.REF_CTNT1

                     ) T10
                WHERE 1 = 1


            ) T100
               , (SELECT COUNT(1) AS DCNT
                  FROM MAP_JOB_DATE
                  WHERE DW_BAS_DDT BETWEEN '20240101' AND '20241231') T200
            WHERE 1 = 1
            GROUP BY T100.MAPP_HOIGYE_CODE
                   , T100.GONGGEUM_GYEJWA_NO
                   , T100.GONGGEUM_GYEJWA_NM
                   , T100.UNYONG_GYEJWA_NO
      ) T1000
         , ACL_SIGUMGO_MAS T2000
      WHERE 1 = 1
        AND T2000.FIL_100_CTNT2(+) = T1000.GONGGEUM_GYEJWA_NO
        AND T2000.MNG_NO = 1
        AND T2000.SIGUMGO_AGE_AC_G IN (0,1)
     ) T10000 LEFT OUTER JOIN SFI_CMM_C_DAT GG ON GG.CMM_C_NM = '금고운용현황지역별연동계좌'
    AND T10000.GYEJWA_NO = GG.CMM_DTL_C_NM
              LEFT OUTER JOIN SFI_CMM_C_DAT G ON G.CMM_C_NM = '금고운용현황회계구분'
    AND G.USE_YN = 'Y'
    AND G.UPMU_HMK_1_SLV = '130'
    AND G.CMM_DTL_C = GG.HRNK_CMM_DTL_C
WHERE 1 = 1
GROUP BY T10000.MAPP_HOIGYE_CODE
       , T10000.GYEJWA_NO
       , T10000.GONGGEUM_GYEJWA_NM
       , GG.CMM_C_NM, G.CMM_DTL_C
       , G.CMM_DTL_C_NM , G.HRNK_CMM_C_NM , NVL(G.SORT_SNO, 9999)
       , GG.UPMU_HMK_1_SLV, GG.CMM_DTL_C
ORDER BY GUBUN_SORT_SNO
       , T10000.MAPP_HOIGYE_CODE
       , T10000.GYEJWA_NO
       , T10000.GONGGEUM_GYEJWA_NM