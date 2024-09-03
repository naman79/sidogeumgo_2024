select * from rpt_unyong_gyejwa where unyong_gyejwa = '200848000387'
select * from rpt_unyong_jan where unyong_gyejwa = '200848000387'


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
         AND T1.KIJUNIL <= '20240830'
         AND T1.GEUMGO_CODE = '42'
         AND T1.JI_IJA > 0
         AND T2.MNG_NO = 1
     AND DECODE(NVL('', 'all'), 'all', 9999, T2.AC_GRBRNO) = DECODE(NVL('', 'all'), 'all', 9999, '')
     and t1.unyong_gyejwa = '200848000387'

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
           AND ( (T1.DUDT between '20240101' AND '20240830')
              OR 
              (NVL(T1.OUT_DATE, '99991231') between '20240101' and '20240830' )
           )
           AND NVL(T1.OUT_DATE, '99991231') > '20240101'
           AND NVL(T1.HJI_DT, '99991231') > '20240101'
           AND T2.REF_L_C = 50
           AND T2.YUHYO_YN = 0
              and t1.unyong_gyejwa = '200848000387'

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
           AND T1.DUDT <= '20240830'
           AND NVL(T1.OUT_DATE, '99991231') >= '20240101'
           AND NVL(T1.HJI_DT, '99991231') >= '20240101'
           AND T2.MNG_NO = 1
           and t1.unyong_gyejwa = '200848000387'
     AND DECODE(NVL('', 'all'), 'all', 9999, T2.AC_GRBRNO) = DECODE(NVL('', 'all'), 'all', 9999, '')

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
    ,T6.IYUL
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
           AND T1.DUDT <= '20240830'
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
           AND T1.DUDT <= '20240830'
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
         AND T1.KIJUNIL <= '20240830'
         AND T1.GEUMGO_CODE = '42'
         AND T1.JI_IJA > 0
         AND T2.MNG_NO = 1
     AND DECODE(NVL('', 'all'), 'all', 9999, T2.AC_GRBRNO) = DECODE(NVL('', 'all'), 'all', 9999, '')
    ) T6
WHERE 1=1
     AND T4.KIJUNIL = T5.KIJUNIL(+)
     AND T4.GONGGEUM_GYEJWA = T5.GONGGEUM_GYEJWA(+)
     AND T4.UNYONG_GYEJWA = T5.UNYONG_GYEJWA(+)
     AND T5.GONGGEUM_GYEJWA = T6.GONGGEUM_GYEJWA(+)
     AND T5.UNYONG_GYEJWA = T6.UNYONG_GYEJWA(+)
  AND DECODE(NVL('', 'all'), 'all', 9999, T4.HOIGYE_CODE) = DECODE(NVL('', 'all'), 'all', 9999, '')
  AND DECODE(NVL('04200080900002299', 'all'), 'all', 9999, T4.GONGGEUM_GYEJWA) = DECODE(NVL('04200080900002299', 'all'), 'all', 9999, '04200080900002299')
ORDER BY
     T4.GONGGEUM_GYEJWA
    ,T4.MKDT