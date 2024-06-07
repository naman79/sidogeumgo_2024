SELECT
     T1.KIJUNIL
    ,T1.UNYONG_GYEJWA
    ,T1.GONGGEUM_GYEJWA
    ,T1.MKDT
    ,T1.DUDT
    ,TO_CHAR(MONTHS_BETWEEN(TO_DATE(T1.DUDT,'yyyymmdd'),TO_DATE(T1.MKDT,'yyyymmdd'))) IJA_MONTH
    ,TO_CHAR(TO_DATE(T1.KIJUNIL,'yyyymmdd')-TO_DATE(T1.MKDT,'yyyymmdd')) IJA_ILSU
    ,NVL(T1.IYUL, 0) AS IYUL
    ,T1.JANAEK
    ,T1.JI_IJA
    ,T1.HOIGYE_CODE
    ,T1.GYEJWA_NAME
FROM
     (
      SELECT
           T1.HOIGYE_CODE
          ,T1.GONGGEUM_GYEJWA
          ,T1.GYEJWA_NAME
          ,T1.UNYONG_GYEJWA
          ,T1.SANGPUM_NAME
          ,T1.MKDT
          ,T1.DUDT
          ,T1.IYUL
          ,T1.JANAEK
          ,T1.KIJUNIL
          ,T1.JI_IJA
      FROM
           (
            SELECT
                 TRIM(T2.KIJUNIL) AS KIJUNIL
                ,T2.GONGGEUM_GYEJWA
                ,T2.UNYONG_GYEJWA
                ,T1.GONGGEUM_HOIGYE_CODE AS HOIGYE_CODE
                ,T1.GONGGEUM_HOIGYE_YEAR AS HOIGYE_YEAR
                ,T2.JANAEK
                ,T3.MKDT
                ,T2.DUDT
                ,T3.HJI_DT
                ,T3.BBK_BKKP_NM
                ,T3.PRDT_BKKP_NM
                ,T2.LST_TRXDT
                ,(
                  SELECT
                       TT.IYUL
                  FROM
                       RPT_UNYONG_JAN TT
                  WHERE 1=1
                       AND TT.GEUMGO_CODE = T2.GEUMGO_CODE
                       AND TT.GONGGEUM_GYEJWA = T2.GONGGEUM_GYEJWA
                       AND TT.UNYONG_GYEJWA = T2.UNYONG_GYEJWA
                       AND TT.KIJUNIL = T2.MKDT
                 ) AS IYUL
                ,T2.GEUMGO_CODE
                ,T2.IPAMT
                ,T2.JIAMT
                ,T2.JI_IJA
                ,T1.GONGGEUM_GYEJWA_NM AS GYEJWA_NAME
                ,T3.SANGPUM_NAME
                ,CASE
                     WHEN T1.GONGGEUM_HOIGYE_YEAR = '9999' THEN SUBSTR(T2.KIJUNIL, 1, 4)
                     WHEN T1.GONGGEUM_HOIGYE_YEAR = SUBSTR(T2.KIJUNIL, 1, 4) THEN T1.GONGGEUM_HOIGYE_YEAR
                     WHEN SUBSTR(T2.KIJUNIL, 1, 8) >= T1.KIJUNIL THEN TO_CHAR(T1.GONGGEUM_HOIGYE_YEAR + 1)
                     WHEN SUBSTR(T2.KIJUNIL, 1, 8) < T1.KIJUNIL THEN T1.GONGGEUM_HOIGYE_YEAR
                     ELSE T1.GONGGEUM_HOIGYE_YEAR
                  END AS R_HOIGYE_YEAR
            FROM
                 (
                  SELECT
                       T1.GONGGEUM_GYEJWA
                      ,T1.GONGGEUM_GEUMGO_CD
                      ,T1.GONGGEUM_HOIGYE_CODE
                      ,T1.GONGGEUM_HOIGYE_YEAR
                      ,T1.GONGGEUM_GYEJWA_NM
                      ,T2.KIJUNIL
                  FROM
                      (
                       SELECT
                            T1.FIL_100_CTNT2 AS GONGGEUM_GYEJWA
                           ,T1.SIGUMGO_ORG_C AS GONGGEUM_GEUMGO_CD
                           ,TO_NUMBER(T2.SIGUMGO_HOIKYE_C) AS GONGGEUM_HOIGYE_CODE
                           ,T1.SIGUMGO_HOIKYE_YR AS GONGGEUM_HOIGYE_YEAR
                           ,T1.SIGUMGO_AC_NM AS GONGGEUM_GYEJWA_NM
                       FROM
                            ACL_SIGUMGO_MAS T1
                           ,RPT_AC_BY_HOIKYE_MAPP T2
                       WHERE 1=1
                            AND T1.FIL_100_CTNT2 = T2.SIGUMGO_ACNO
                            AND T1.SIGUMGO_HOIKYE_YR = T2.SIGUMGO_HOIKYE_YR
                            AND T1.MNG_NO = 1
                            AND T1.SIGUMGO_ORG_C = '150'
                            AND T1.AC_GRBRNO LIKE '' ||'%'
                            AND T1.FIL_100_CTNT2 LIKE '' ||'%'
                            AND DECODE('ALL', 'ALL', 'ALL', T2.SIGUMGO_HOIKYE_C) = 'ALL'
                      ) T1
                     ,RPT_HOIGYE_IWOL T2
                 WHERE 1=1
                      AND T1.GONGGEUM_HOIGYE_CODE = T2.HOIGYE_CODE(+)
                      AND T1.GONGGEUM_HOIGYE_YEAR = T2.HOIGYE_YEAR(+)
                      AND T1.GONGGEUM_GEUMGO_CD = T2.GEUMGO_CODE(+)
                      AND T2.GUBUN_CODE(+) = 1
                 ) T1
                ,RPT_UNYONG_JAN T2
                ,RPT_UNYONG_GYEJWA T3
            WHERE 1=1
                 AND T1.GONGGEUM_GYEJWA = T2.GONGGEUM_GYEJWA
                 AND T1.GONGGEUM_GEUMGO_CD = T2.GEUMGO_CODE
                 AND T2.GONGGEUM_GYEJWA = T3.GONGGEUM_GYEJWA
                 AND T2.UNYONG_GYEJWA = T3.UNYONG_GYEJWA
                 AND T2.KIJUNIL >= '20230101'
                 AND T2.KIJUNIL <= '20231231'
                 AND T2.JI_IJA > 0
           ) T1
      WHERE 1=1
           AND T1.R_HOIGYE_YEAR IN ('9999', '2023')
      UNION ALL
      SELECT
           T5.HOIGYE_CODE AS HOIGYE_CODE
          ,T5.GONGGEUM_GYEJWA
          ,T5.GONGGEUM_GYEJWA_NM AS GYEJWA_NAME
          ,T5.UNYONG_GYEJWA
          ,T5.SANGPUM_NAME
          ,T6.MKDT
          ,T6.DUDT
          ,(
            SELECT
                 TT.IYUL
            FROM
                 RPT_UNYONG_JAN TT
            WHERE 1=1
                 AND TT.GEUMGO_CODE = T6.GEUMGO_CODE
                 AND TT.GONGGEUM_GYEJWA = T6.GONGGEUM_GYEJWA
                 AND TT.UNYONG_GYEJWA = T6.UNYONG_GYEJWA
                 AND TT.KIJUNIL = T6.MKDT
           ) AS IYUL
          ,T6.JANAEK
          ,TRIM(T6.KIJUNIL) AS KIJUNIL
          ,T6.JI_IJA
      FROM
           (
            SELECT
                 T2.GONGGEUM_GYEJWA
                ,T2.GONGGEUM_GYEJWA_NM
                ,T2.HOIGYE_CODE
                ,T3.UNYONG_GYEJWA
                ,T3.SANGPUM_NAME
            FROM
                 (
                  SELECT
                       T1.REF_D_NM AS GONGGEUM_GYEJWA
                      ,T1.REF_CTNT1 AS GONGGEUM_GYEJWA_NM
                      ,T1.REF_S_C AS MNGBR
                      ,TO_NUMBER(SUBSTR(T1.REF_D_NM, 4, 3)) AS GUNGU_CODE
                      ,900+T1.REF_D_C HOIGYE_CODE
                      ,99 AS GYEJWA_BUNRYU
                  FROM
                       RPT_CODE_INFO T1
                  WHERE 1=1
                       AND T1.REF_L_C = '50'
                       AND T1.REF_M_C = '150'
                       AND T1.YUHYO_YN = 0
                  ) T2
                 ,RPT_UNYONG_GYEJWA T3
            WHERE 1=1
                  AND T2.GONGGEUM_GYEJWA = T3.GONGGEUM_GYEJWA
                  AND T2.GONGGEUM_GYEJWA LIKE '' ||'%'
                  AND T2.MNGBR LIKE '' ||'%'
                  AND DECODE('ALL', 'ALL', 'ALL', T2.HOIGYE_CODE) = 'ALL'
                  AND NVL(T3.MKDT,T3.IN_DATE) <= '20231231'
                  AND NVL(T3.OUT_DATE, '99991231') > '20230101'
                  AND NVL(T3.HJI_DT, '99991231') > '20230101'
                  AND T3.BANK_GUBUN = 0
           ) T5
          ,RPT_UNYONG_JAN T6
      WHERE 1=1
           AND T5.GONGGEUM_GYEJWA = T6.GONGGEUM_GYEJWA
           AND T5.UNYONG_GYEJWA = T6.UNYONG_GYEJWA
           AND T6.KIJUNIL >= '20230101'
           AND T6.KIJUNIL <= '20231231'
           AND T6.JI_IJA > 0
           AND (9999 = 9999 OR SUBSTR(T6.KIJUNIL, 1, 4) = '9999')
     ) T1
ORDER BY
     T1.HOIGYE_CODE
    ,T1.GONGGEUM_GYEJWA
    ,DECODE('150', 439,T1.KIJUNIL, T1.UNYONG_GYEJWA)


----------------------------


    select sum(JI_IJA) as ija from rpt_unyong_jan
    where 1=1
    and GEUMGO_CODE = 150
    and KIJUNIL BETWEEN '20240101' AND '20240531'
    and JI_IJA > 0
    and UNYONG_GYEJWA like '200%'



        select * from rpt_unyong_jan
    where 1=1
    and GEUMGO_CODE = 150
    and KIJUNIL BETWEEN '20240101' AND '20240531'
    and JI_IJA > 0
    and UNYONG_GYEJWA like '200%'
    order by KIJUNIL