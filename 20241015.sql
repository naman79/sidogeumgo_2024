[1728958893383
20241015treap2pRPTPWK0359289600

=========================== XDA ID:[tom.kwd.fmt.xda.xSelectListKWD140405By02]===============================
SELECT T10000.MAPP_HOIGYE_CODE
       , T10000.GYEJWA_NO
       , T10000.GONGGEUM_GYEJWA_NM AS GYEJWA_NM
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
    FROM (SELECT T1000.MAPP_HOIGYE_CODE
               , T1000.GONGGEUM_GYEJWA_NO
               , T1000.UNYONG_GYEJWA_NO
               , T1000.GONGGEUM_GYEJWA_NM
               , DECODE(42, '42', LPAD(T2000.LINKAC_KWA_C, 3, '0') || LPAD(T2000.LINK_ACSER, 9, '0'), T1000.GONGGEUM_GYEJWA_NO) AS GYEJWA_NO
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
                    FROM (
                         
                          SELECT TO_NUMBER(DECODE(42, 28, T20.ICH_SIGUMGO_HOIKYE_C, T30.SIGUMGO_HOIKYE_C)) AS MAPP_HOIGYE_CODE
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
                            FROM (SELECT 
                                         T1.GEUMGO_CODE
                                       , T1.GUNGU_CODE
                                       , T1.GONGGEUM_GYEJWA
                                       , SUM(T1.JANAEK) AS GONGGEUM_AMT
                                    FROM RPT_GONGGEUM_JAN T1
                                   WHERE T1.GEUMGO_CODE = 42
                                     AND T1.GUNGU_CODE = 0
                                     AND T1.KEORAEIL BETWEEN '20230101' AND '20231231'
                                     AND T1.GONGGEUM_GYEJWA NOT IN ('04200080900003999')
                                     AND T1.JANAEK != 0
                                GROUP BY  T1.GEUMGO_CODE
                                       , T1.GUNGU_CODE
                                       , T1.GONGGEUM_GYEJWA
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

                          
                          
                          SELECT TO_NUMBER(DECODE(42, 28, T20.ICH_SIGUMGO_HOIKYE_C, T30.SIGUMGO_HOIKYE_C)) AS MAPP_HOIGYE_CODE
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
                            FROM (SELECT 
                                         T2.GONGGEUM_GYEJWA
                                       , T2.UNYONG_GYEJWA
                                       , SUM(CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) IN ('100') THEN T2.JANAEK END) AS UY_100_AMT
                                       , SUM(CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) IN ('140') THEN T2.JANAEK END) AS UY_140_AMT 
                                       , SUM(CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) IN ('160') THEN T2.JANAEK END) AS UY_160_AMT
                                       , SUM(CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) IN ('200', '207') THEN T2.JANAEK END) AS UY_200_AMT 
                                       , SUM(CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) NOT IN ('100', '140', '160', '200', '207') THEN T2.JANAEK END) AS UY_ETC_AMT
                                    FROM MAP_JOB_DATE T1
                                       , RPT_UNYONG_JAN T2
                                       , RPT_UNYONG_GYEJWA T3
                                   WHERE 1 = 1
                                     AND T1.DW_BAS_DDT BETWEEN '20230101' AND '20231231'
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
                            FROM (SELECT 
                                         T2.GONGGEUM_GYEJWA
                                       , T2.UNYONG_GYEJWA
                                       , SUM(T2.JANAEK) AS MMDA_AMT
                                    FROM MAP_JOB_DATE T1
                                       , RPT_UNYONG_JAN T2
                                   WHERE T1.DW_BAS_DDT BETWEEN '20230101' AND '20231231'
                                     AND T2.KIJUNIL = CASE WHEN T1.DT_G IN (0) THEN T1.DW_BAS_DDT ELSE T1.BF1_BIZ_DT END
                                     AND T2.GEUMGO_CODE = 42
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
                            FROM (SELECT T2.GONGGEUM_GYEJWA
                                       , T2.UNYONG_GYEJWA
                                       , SUM(T2.JANAEK) AS KG_AMT
                                       , T4.REF_D_C + 900 AS MAPP_HOIGYE_CODE
                                       , T4.REF_CTNT1 AS GONGGEUM_GYEJWA_NM
                                    FROM MAP_JOB_DATE T1
                                       , RPT_UNYONG_JAN T2
                                       , RPT_UNYONG_GYEJWA T3
                                       , RPT_CODE_INFO T4
                                   WHERE 1 = 1
                                     AND T1.DW_BAS_DDT BETWEEN '20230101' AND '20231231'
                                     AND T2.KIJUNIL = CASE WHEN T1.DT_G IN (0) THEN T1.DW_BAS_DDT ELSE T1.BF1_BIZ_DT END
                                     AND T2.GEUMGO_CODE = 42
                                     AND SUBSTR(T2.GONGGEUM_GYEJWA, 4, 3) = LPAD('0', 3, '0')
                                     AND T3.GONGGEUM_GYEJWA(+) = T2.GONGGEUM_GYEJWA
                                     AND T3.UNYONG_GYEJWA(+) = T2.UNYONG_GYEJWA
                                     AND T3.BANK_GUBUN(+) = 0
                                     AND COALESCE(T3.MKDT, T3.IN_DATE, '00010101') != COALESCE(T3.HJI_DT, '99991231')
                                     AND COALESCE(T3.MKDT, T3.IN_DATE, '00010101') <= T1.DW_BAS_DDT
                                     AND COALESCE(T3.HJI_DT, T3.OUT_DATE, '99991231') >= T1.DW_BAS_DDT
                                     AND T4.REF_L_C = 50
                                     AND T4.REF_M_C = 42
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
                           WHERE DW_BAS_DDT BETWEEN '20230101' AND '20231231') T200
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
         ) T10000
   WHERE 1 = 1
GROUP BY T10000.MAPP_HOIGYE_CODE
       , T10000.GYEJWA_NO
       , T10000.GONGGEUM_GYEJWA_NM
ORDER BY T10000.MAPP_HOIGYE_CODE
       , T10000.GYEJWA_NO
       , T10000.GONGGEUM_GYEJWA_NM
============================================================================================


SELECT 
      Z.ROW_NUM,
      Z.SIGUMGO_ORG_C,
      Z.ICH_SIGUMGO_GUN_GU_C,
      Z.ICH_SIGUMGO_HOIKYE_C,
      Z.SIGUMGO_HOIKYE_C,
      Z.SIGUMGO_AC_B,
      Z.SIGUMGO_AC_SER,
      Z.SIGUMGO_HOIKYE_YR,
      Z.GONGGEUM_GYEJWA,
      Z.GONGGEUM_YUDONG_ACNO,
      Z.AC_GRBRNO,
      Z.HNG_BR_NM,
      Z.SIGUMGO_AC_NM,
      Z.UPD_DTTM,
      Z.MODR_ID

FROM
      (
        SELECT 
              ROW_NUMBER() OVER(ORDER BY X.GONGGEUM_GYEJWA) AS ROW_NUM,
              X.SIGUMGO_ORG_C,
              X.ICH_SIGUMGO_GUN_GU_C,
              X.ICH_SIGUMGO_HOIKYE_C,
              Y.SIGUMGO_HOIKYE_C,
              X.SIGUMGO_AC_B,
              X.SIGUMGO_AC_SER,
              X.SIGUMGO_HOIKYE_YR,
              X.GONGGEUM_GYEJWA,
              X.GONGGEUM_YUDONG_ACNO,
              X.AC_GRBRNO,
              X.HNG_BR_NM,
              X.SIGUMGO_AC_NM,
              Y.UPD_DTTM,
              Y.MODR_ID
        FROM
              (
                SELECT  
                      A.SIGUMGO_ORG_C,
                      A.ICH_SIGUMGO_GUN_GU_C,
                      A.ICH_SIGUMGO_HOIKYE_C,
                      A.SIGUMGO_AC_B,
                      A.SIGUMGO_AC_SER,
                      A.SIGUMGO_HOIKYE_YR,
                      LPAD(A.SIGUMGO_ORG_C, 3, '0')||
                      LPAD(A.ICH_SIGUMGO_GUN_GU_C, 3, '0')||
                      LPAD(A.ICH_SIGUMGO_HOIKYE_C, 2, '0')||
                      LPAD(A.SIGUMGO_AC_B, 2, '0')||
                      LPAD(A.SIGUMGO_AC_SER, 5, '0')||
                      SUBSTR(A.SIGUMGO_HOIKYE_YR, 3, 2) AS GONGGEUM_GYEJWA,
                      A.LINKAC_KWA_C ||'000'||A.LINK_ACSER AS GONGGEUM_YUDONG_ACNO,
                      A.AC_GRBRNO,
                      B.HNG_BR_NM,
                      A.SIGUMGO_AC_NM,
                      A.UPD_DTTM,
                      A.MODR_ID
                FROM 
                      ACL_SIGUMGO_MAS A
                      LEFT OUTER JOIN CST_JUM B
                        ON A.AC_GRBRNO = B.BRNO
                        AND B.GRPCO_C = 'S001'
                WHERE
                      A.SIGUMGO_ORG_C = 42
                      AND A.SIGUMGO_HOIKYE_YR IN ('2024','9999')
                      AND A.MNG_NO = '1'
                      AND (-1 = -1 OR A.ICH_SIGUMGO_GUN_GU_C = -1)
                      AND (-1 = -1 OR A.SIGUMGO_AC_B = -1)
                      AND (-1 = -1 OR A.AC_GRBRNO = -1)
                      AND (-1 = 80 OR A.ICH_SIGUMGO_HOIKYE_C = 80)
              ) X
              LEFT OUTER JOIN RPT_AC_BY_HOIKYE_MAPP Y
                  ON X.SIGUMGO_ORG_C = Y.SIGUMGO_C 
                  AND X.SIGUMGO_HOIKYE_YR = Y.SIGUMGO_HOIKYE_YR
                  AND X.GONGGEUM_GYEJWA = Y.SIGUMGO_ACNO
             WHERE 1 = 1
                   AND (-1 = -1 OR Y.SIGUMGO_HOIKYE_C = -1)
      ) Z
WHERE
      Z.ROW_NUM >= 0
      AND Z.ROW_NUM <= 100

---------------------------------------------------------------------------------------------

select 
 count(*) as cnt
from 
acl_sigumgo_slv
where 1=1
and SIGUMGO_TRX_G = 60


select 
*
from 
acl_sigumgo_slv
where 1=1
and SIGUMGO_TRX_G = 60

---------------------------------------------------------------------------------------------
-- 자금운용만기명세
SELECT
     T4.HOIGYE_CODE
    ,T4.GONGGEUM_GYEJWA
    ,T4.GYEJWA_NAME
    ,T4.GONGGEUM_GYEJWA ||' '||T4.GYEJWA_NAME AS GONGGEUM_GYEJWA_NM
    ,T4.UNYONG_GYEJWA
    ,T4.SANGPUM_NAME
    ,T4.IN_DATE
    ,T4.OUT_DATE
    ,T4.MKDT
    ,T4.DUDT
    ,T4.HJI_DT
    ,NVL(T5.JANAEK,0) AS JANAEK
    ,NVL(T6.JI_IJA,0) AS MANKI_IJA
    ,(NVL(T5.JANAEK,0) + NVL(T6.JI_IJA,0)) AS MANKI_AMT
    ,T7.IYUL
    ,T4.LST_TRXDT
    ,T4.BBK_BKKP_NM
    ,T4.PRDT_BKKP_NM
FROM
     (
      SELECT
           CASE
               WHEN T1.OUT_DATE IS NULL AND T1.HJI_DT IS NULL
               THEN (
                     SELECT
                          BIZ_DT
                     FROM
                          MAP_JOB_DATE
                     WHERE 1=1
                          AND DW_BAS_DDT = TO_CHAR(SYSDATE, 'YYYYMMDD')
                    )
                ELSE (
                      SELECT
                           BF1_BIZ_DT
                      FROM
                           MAP_JOB_DATE
                      WHERE 1=1
                           AND DW_BAS_DDT = LEAST(NVL(TRIM(T1.HJI_DT), '99991231'), NVL(TRIM(T1.OUT_DATE), '99991231') )
                    )
           END AS KIJUNIL
          ,T1.BANK_NAME
          ,T1.GONGGEUM_GYEJWA
          ,T2.SIGUMGO_AC_NM AS GYEJWA_NAME
          ,T1.UNYONG_GYEJWA
          ,T1.SANGPUM_NAME
          ,T1.IN_DATE
          ,T1.OUT_DATE
          ,T1.MKDT
          ,T1.DUDT
          ,T1.HJI_DT
          ,T1.LST_TRXDT
          ,T1.BBK_BKKP_NM
          ,T1.PRDT_BKKP_NM
          ,T1.ROWID AS RID
          ,T1.BANK_GUBUN
          ,T1.GEUMAEK_AMT
          ,TO_NUMBER(T3.SIGUMGO_HOIKYE_C) AS HOIGYE_CODE
      FROM
           RPT_UNYONG_GYEJWA T1
          ,ACL_SIGUMGO_MAS T2
          ,RPT_AC_BY_HOIKYE_MAPP T3
      WHERE 1=1
           AND T1.GONGGEUM_GYEJWA = T2.FIL_100_CTNT2
           AND T1.GEUMGO_CODE = T2.SIGUMGO_ORG_C
           AND T2.FIL_100_CTNT2 = T3.SIGUMGO_ACNO
           AND T2.SIGUMGO_HOIKYE_YR = T3.SIGUMGO_HOIKYE_YR
           AND T1.GEUMGO_CODE = '42'
           AND T1.BANK_GUBUN = 0
           AND T1.DUDT >= '20240101'
           AND T1.DUDT <= '20241015'
           AND NVL(T1.OUT_DATE, '99991231') >= '20240101'
           AND NVL(T1.HJI_DT, '99991231') >= '20240101'
           AND T2.MNG_NO = 1
     AND DECODE(NVL('', 'all'), 'all', 9999, T2.AC_GRBRNO) = DECODE(NVL('', 'all'), 'all', 9999, '')
      UNION ALL
      SELECT
           CASE
               WHEN T1.OUT_DATE IS NULL AND T1.HJI_DT IS NULL
               THEN (
                     SELECT
                          BIZ_DT
                     FROM
                          MAP_JOB_DATE
                     WHERE 1=1
                          AND DW_BAS_DDT = TO_CHAR(SYSDATE, 'YYYYMMDD')
                    )
                ELSE (
                      SELECT
                           BF1_BIZ_DT
                      FROM
                           MAP_JOB_DATE
                      WHERE 1=1
                           AND DW_BAS_DDT = LEAST(NVL(TRIM(T1.HJI_DT), '99991231'), NVL(TRIM(T1.OUT_DATE), '99991231') )
                    )
           END AS KIJUNIL
          ,T1.BANK_NAME
          ,T1.GONGGEUM_GYEJWA
          ,T2.REF_CTNT1 AS GYEJWA_NAME
          ,T1.UNYONG_GYEJWA
          ,T1.SANGPUM_NAME
          ,T1.IN_DATE
          ,T1.OUT_DATE
          ,T1.MKDT
          ,T1.DUDT
          ,T1.HJI_DT
          ,T1.LST_TRXDT
          ,T1.BBK_BKKP_NM
          ,T1.PRDT_BKKP_NM
          ,T1.ROWID AS RID
          ,T1.BANK_GUBUN
          ,T1.GEUMAEK_AMT
          ,99 AS HOIGYE_CODE
      FROM
           RPT_UNYONG_GYEJWA T1
          ,RPT_CODE_INFO T2
      WHERE 1=1
           AND T1.GONGGEUM_GYEJWA = T2.REF_D_NM
           AND T1.GEUMGO_CODE = T2.REF_M_C
           AND T1.GEUMGO_CODE = '42'
           AND T1.BANK_GUBUN = 0
           AND T1.DUDT >= '20240101'
           AND T1.DUDT <= '20241015'
           AND NVL(T1.OUT_DATE, '99991231') > '20240101'
           AND NVL(T1.HJI_DT, '99991231') > '20240101'
           AND T2.REF_L_C = 50
           AND T2.YUHYO_YN = 0
     ) T4
    ,RPT_UNYONG_JAN T5
    ,(
      SELECT
           TRIM(T1.KIJUNIL) AS KIJUNIL
          ,T1.GONGGEUM_GYEJWA
          ,T1.UNYONG_GYEJWA
          ,TO_NUMBER(T3.SIGUMGO_HOIKYE_C) AS HOIGYE_CODE
          ,T2.SIGUMGO_HOIKYE_YR AS HOIGYE_YEAR
          ,T1.JANAEK
          ,T1.DUDT
          ,T1.LST_TRXDT
          ,T1.IYUL
          ,T1.GEUMGO_CODE
          ,T1.IPAMT
          ,T1.JIAMT
          ,T1.JI_IJA
          ,T2.SIGUMGO_AC_NM AS GONGGEUM_GYEJWA_NM
      FROM
           RPT_UNYONG_JAN T1
          ,ACL_SIGUMGO_MAS T2
          ,RPT_AC_BY_HOIKYE_MAPP T3
      WHERE 1=1
         AND T1.GONGGEUM_GYEJWA = T2.FIL_100_CTNT2
         AND T1.GEUMGO_CODE = T2.SIGUMGO_ORG_C
         AND T2.FIL_100_CTNT2 = T3.SIGUMGO_ACNO
         AND T2.SIGUMGO_HOIKYE_YR = T3.SIGUMGO_HOIKYE_YR
         AND T1.KIJUNIL >= '20240101'
         AND T1.KIJUNIL <= '20241015'
         AND T1.GEUMGO_CODE = '42'
         AND T1.JI_IJA > 0
         AND T2.MNG_NO = 1
     AND DECODE(NVL('', 'all'), 'all', 9999, T2.AC_GRBRNO) = DECODE(NVL('', 'all'), 'all', 9999, '')
    ) T6,
    (SELECT
           MIN(T1.IYUL) AS IYUL
          ,T1.GONGGEUM_GYEJWA
          ,T1.UNYONG_GYEJWA
          ,TO_NUMBER(T3.SIGUMGO_HOIKYE_C) AS HOIGYE_CODE
          ,T2.SIGUMGO_HOIKYE_YR AS HOIGYE_YEAR
          ,T1.DUDT
          ,T1.GEUMGO_CODE
      FROM
           RPT_UNYONG_JAN T1
          ,ACL_SIGUMGO_MAS T2
          ,RPT_AC_BY_HOIKYE_MAPP T3
          ,MAP_JOB_DATE T4
      WHERE 1=1
         AND T1.GONGGEUM_GYEJWA = T2.FIL_100_CTNT2
         AND T1.GEUMGO_CODE = T2.SIGUMGO_ORG_C
         AND T2.FIL_100_CTNT2 = T3.SIGUMGO_ACNO
         AND T4.DW_BAS_DDT = '20240101'
         AND T2.SIGUMGO_HOIKYE_YR = T3.SIGUMGO_HOIKYE_YR
         AND T1.KIJUNIL >= T4.BF1_BIZ_DT
         AND T1.KIJUNIL <= '20241015'
         AND T1.GEUMGO_CODE = '42'
         AND T1.IYUL IS NOT NULL
         AND T1.IYUL <> 0
         AND T2.MNG_NO = 1
         AND DECODE(NVL('', 'all'), 'all', 9999, T2.AC_GRBRNO) = DECODE(NVL('', 'all'), 'all', 9999, '')
     GROUP BY T1.GONGGEUM_GYEJWA
          ,T1.UNYONG_GYEJWA
          ,T3.SIGUMGO_HOIKYE_C
          ,T2.SIGUMGO_HOIKYE_YR
          ,T1.DUDT
          ,T1.GEUMGO_CODE) T7
WHERE 1=1
     AND T4.KIJUNIL = T5.KIJUNIL(+)
     AND T4.GONGGEUM_GYEJWA = T5.GONGGEUM_GYEJWA(+)
     AND T4.UNYONG_GYEJWA = T5.UNYONG_GYEJWA(+)
     AND T5.GONGGEUM_GYEJWA = T6.GONGGEUM_GYEJWA(+)
     AND T5.UNYONG_GYEJWA = T6.UNYONG_GYEJWA(+)
     AND T4.GONGGEUM_GYEJWA = T7.GONGGEUM_GYEJWA(+) 
     AND T4.UNYONG_GYEJWA = T7.UNYONG_GYEJWA(+)
  AND DECODE(NVL('', 'all'), 'all', 9999, T4.HOIGYE_CODE) = DECODE(NVL('', 'all'), 'all', 9999, '')
  AND DECODE(NVL('', 'all'), 'all', 9999, T4.GONGGEUM_GYEJWA) = DECODE(NVL('', 'all'), 'all', 9999, '')
ORDER BY
     T4.GONGGEUM_GYEJWA
    ,T4.MKDT


select * from rpt_unyong_gyejwa
where 1=1
and GEUMGO_CODE = 42
and HJI_DT < DUDT
and MKDT like '2023%'


select * from RPT_UNYONG_JAN
where 1=1
and UNYONG_GYEJWA = '200114870455'
order by KIJUNIL desc

select UNYONG_GYEJWA, min(iyul) min_iyul, max(iyul) max_iyul , max(KIJUNIL) max_date from RPT_UNYONG_JAN
where 1=1
and UNYONG_GYEJWA in (
select UNYONG_GYEJWA from rpt_unyong_gyejwa
where 1=1
and GEUMGO_CODE = 42
and HJI_DT < DUDT
-- and MKDT like '2023%'
)
-- and iyul > 0
group by UNYONG_GYEJWA

select * from rpt_unyong_jan
where 1=1
and UNYONG_GYEJWA = '200375156438'
and KIJUNIL = '20180724'

select B.UNYONG_GYEJWA, min(B.iyul) min_iyul, max(B.iyul) max_iyul , max(B.KIJUNIL) max_date, (select A.iyul from RPT_UNYONG_JAN A where A.KIJUNIL = max(B.KIJUNIL)) as  last_iyul from RPT_UNYONG_JAN B
where 1=1
and B.UNYONG_GYEJWA in (
select UNYONG_GYEJWA from rpt_unyong_gyejwa
where 1=1
and GEUMGO_CODE = 42
and HJI_DT < DUDT
-- and MKDT like '2023%'
)
-- and iyul > 0
group by B.UNYONG_GYEJWA


select * from rpt_unyong_jan
where 1=1
and (UNYONG_GYEJWA, KIJUNIL) in (
select UNYONG_GYEJWA, HJI_DT from rpt_unyong_gyejwa
where 1=1
and GEUMGO_CODE = 42
and HJI_DT < DUDT
and MKDT like '2023%'
)