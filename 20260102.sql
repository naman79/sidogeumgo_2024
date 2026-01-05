select dw_bas_ddt, count(*) as cnt from map_job_date
where dw_bas_ddt like '2026%'
group by dw_bas_ddt 
having count(*) > 1



select * from 
map_job_date
where 1=1
and dw_bas_ddt in (
    '20260302',
    '20260525',
    '20260603',
    '20260817',
    '20261005'
)
and dt_g = 0

--------------------------------------------------------------

[1767331406956
20260102treap1pRPTPWK0809239300

=========================== XDA ID:[tom.kwd.rpt.xda.xSelectListKWD130305By01]===============================
 
SELECT
     T2.HOIGYE_CODE
    ,T2.GONGGEUM_GYEJWA
    ,T2.GONGGEUM_GYEJWA_NM
    ,NVL(TRUNC(SUM(T1.GONGGEUM)/MAX(T3.DAYS_CNT), 0), 0) AS GONGGEUM
    ,NVL(TRUNC(SUM(T1.UNYONG)/MAX(T3.DAYS_CNT), 0), 0) AS JUCHUK
    ,NVL(TRUNC(SUM(T1.MMDA)/MAX(T3.DAYS_CNT), 0), 0) AS MMDA
    ,T2.GONGGEUM_YUDONG_ACNO
FROM
     (
      SELECT
           T1.HOIGYE_CODE
          ,T1.GONGGEUM_GYEJWA
          ,T1.TRX_DT
          ,T1.BIZ_DT
          ,T1.JANAEK AS GONGGEUM
          ,0 AS UNYONG
          ,0 AS MMDA
      FROM
           (
            SELECT
                 T1.HOIGYE_CODE
                ,T1.GONGGEUM_GYEJWA
                ,T2.DW_BAS_DDT AS TRX_DT
                ,DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT) AS BIZ_DT
                ,T1.JANAEK
            FROM
                 RPT_GONGGEUM_JAN T1
                ,MAP_JOB_DATE T2
            WHERE 1=1
                 AND T1.KEORAEIL = DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT)
                 AND T1.GEUMGO_CODE = '42'
                 AND T1.GUNGU_CODE = 0
                 AND T2.DW_BAS_DDT >= '20241101'
                 AND T2.DW_BAS_DDT <= '20251130'
           ) T1
          ,ACL_SIGUMGO_MAS T2
          ,RPT_AC_BY_HOIKYE_MAPP T3
      WHERE 1=1
           AND T1.GONGGEUM_GYEJWA = T2.FIL_100_CTNT2
           AND T2.FIL_100_CTNT2 = T3.SIGUMGO_ACNO
           AND T2.SIGUMGO_HOIKYE_YR = T3.SIGUMGO_HOIKYE_YR
           AND T2.MNG_NO = 1
           AND (
                CASE
                     WHEN T2.SIGUMGO_HOIKYE_YR = '9999' AND SUBSTR(T1.TRX_DT, 1, 4) = '2025'
                     THEN 1
                     WHEN T2.SIGUMGO_HOIKYE_YR = '2025'
                     THEN 1
                     ELSE 0
                  END
               ) = 1
      UNION ALL
      SELECT
           T1.HOIGYE_CODE
          ,T1.GONGGEUM_GYEJWA
          ,T1.TRX_DT
          ,T1.BIZ_DT
          ,0 AS GONGGEUM
          ,CASE
               WHEN '2025' > '2021'
               THEN
                    CASE
                        WHEN T1.TRX_DT >= NVL(T2.KIJUNIL, '19000101') THEN NVL(T1.JANAEK, 0)
                        ELSE 0
                     END
               ELSE NVL(T1.JANAEK, 0)
            END AS UNYONG
          ,0 AS MMDA
      FROM
           (
            SELECT
                 TO_NUMBER(T3.SIGUMGO_HOIKYE_C) AS HOIGYE_CODE
                ,T2.FIL_100_CTNT2 AS GONGGEUM_GYEJWA
                ,T1.TRX_DT
                ,T1.BIZ_DT
                ,T1.JANAEK
                ,T2.SIGUMGO_HOIKYE_YR AS HOIGYE_YEAR
                ,CASE
                     WHEN T2.SIGUMGO_HOIKYE_YR = '9999' AND T1.GONGGEUM_GYEJWA = T2.FIL_100_CTNT2
                     THEN 'Y'
                     WHEN T2.SIGUMGO_HOIKYE_YR = '2025' AND T1.GONGGEUM_GYEJWA <= T2.FIL_100_CTNT2
                     THEN 'Y'
                     ELSE 'N'
                  END AS TRGT_YN
            FROM
                 (
                  SELECT
                       T2.GONGGEUM_GYEJWA
                      ,SUBSTR(T2.GONGGEUM_GYEJWA, 1, 15) AS GONGGEUM_GYEJWA_15
                      ,T1.JANAEK
                      ,T1.TRX_DT
                      ,T1.BIZ_DT
                      ,CASE
                           WHEN     T1.TRX_DT >= SUBSTR(NVL(T2.MKDT,T2.IN_DATE),1,8) 
                                AND T1.TRX_DT < NVL(T2.OUT_DATE, '99991231')
                                AND T1.TRX_DT < NVL(T2.HJI_DT, '99991231')
                           THEN 'Y'
                           ELSE 'N'
                        END AS TRGT_YN
                  FROM
                       (
                        SELECT
                             T1.GONGGEUM_GYEJWA
                            ,T1.UNYONG_GYEJWA
                            ,T2.DW_BAS_DDT AS TRX_DT
                            ,DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT) AS BIZ_DT
                            ,T1.JANAEK
                        FROM
                             RPT_UNYONG_JAN T1
                            ,MAP_JOB_DATE T2
                        WHERE 1=1
                             AND T1.KIJUNIL = DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT)
                             AND T1.GEUMGO_CODE = '42'
                             AND T2.DW_BAS_DDT >= '20241101'
                             AND T2.DW_BAS_DDT <= '20251130'
                       ) T1
                      ,RPT_UNYONG_GYEJWA T2
                      ,(
                        SELECT
                             T1.FIL_100_CTNT2 AS GONGGEUM_GYEJWA
                            ,T2.KIJUNIL
                        FROM
                             ACL_SIGUMGO_MAS T1
                            ,(
                              SELECT
                                   T1.SIGUMGO_ORG_C
                                  ,T1.GONGGEUM_GYEJWA
                                  ,T1.ICH_SIGUMGO_GUN_GU_C
                                  ,T1.ICH_SIGUMGO_HOIKYE_C
                                  ,T1.SIGUMGO_AC_B
                                  ,T1.SIGUMGO_AC_SER
                                  ,T1.SIGUMGO_HOIKYE_YR
                                  ,T2.KIJUNIL
                              FROM
                                   (
                                    SELECT
                                         T1.SIGUMGO_ORG_C
                                        ,T1.FIL_100_CTNT2 AS GONGGEUM_GYEJWA
                                        ,T1.ICH_SIGUMGO_GUN_GU_C
                                        ,T1.ICH_SIGUMGO_HOIKYE_C
                                        ,T1.SIGUMGO_AC_B
                                        ,T1.SIGUMGO_AC_SER
                                        ,T1.SIGUMGO_HOIKYE_YR
                                    FROM
                                         ACL_SIGUMGO_MAS T1
                                    WHERE 1=1
                                         AND T1.SIGUMGO_ORG_C = '42'
                                         AND T1.SIGUMGO_HOIKYE_YR = '2025'
                                         AND T1.MNG_NO = 1
                                   ) T1
                                  ,RPT_HOIGYE_IWOL T2
                              WHERE 1=1
                                   AND T1.SIGUMGO_ORG_C = T2.GEUMGO_CODE
                                   AND T1.ICH_SIGUMGO_GUN_GU_C = T2.GUNGU_CODE
                                   AND T1.SIGUMGO_HOIKYE_YR = TO_CHAR(T2.HOIGYE_YEAR + 1)
                                   AND T2.KIJUNIL <= '20251130'
                                   AND T2.HOIGYE_CODE IN (
                                                          SELECT
                                                               TO_NUMBER(T3.SIGUMGO_HOIKYE_C)
                                                          FROM
                                                               RPT_AC_BY_HOIKYE_MAPP T3
                                                          WHERE 1=1
                                                               AND T3.SIGUMGO_ACNO = T1.GONGGEUM_GYEJWA
                                                         )
                                   
                             ) T2
                        WHERE 1=1
                             AND T1.SIGUMGO_ORG_C = T2.SIGUMGO_ORG_C
                             AND T1.ICH_SIGUMGO_GUN_GU_C = T2.ICH_SIGUMGO_GUN_GU_C
                             AND T1.ICH_SIGUMGO_HOIKYE_C = T2.ICH_SIGUMGO_HOIKYE_C
                             AND T1.SIGUMGO_AC_B = T2.SIGUMGO_AC_B
                             AND T1.SIGUMGO_AC_SER = T2.SIGUMGO_AC_SER
                             AND T1.SIGUMGO_HOIKYE_YR < T2.SIGUMGO_HOIKYE_YR
                             AND T1.SIGUMGO_ORG_C = '42'
                             AND T1.MNG_NO = 1
                        UNION
                        SELECT
                             T1.FIL_100_CTNT2 AS GONGGEUM_GYEJWA
                            ,'19000101' AS KIJUNIL
                        FROM
                             ACL_SIGUMGO_MAS T1
                        WHERE 1=1
                             AND T1.SIGUMGO_ORG_C = '42'
                             AND T1.MNG_NO = 1
                             AND (
                                  CASE
                                      WHEN T1.SIGUMGO_HOIKYE_YR = '9999' AND SUBSTR('20251130', 1, 4) = '2025'
                                      THEN 1
                                      WHEN T1.SIGUMGO_HOIKYE_YR = '2025'
                                      THEN 1
                                      ELSE 0
                                   END
                                 ) = 1
                       ) T3
                  WHERE 1=1
                       AND T1.GONGGEUM_GYEJWA = T2.GONGGEUM_GYEJWA
                       AND T1.UNYONG_GYEJWA = T2.UNYONG_GYEJWA
                       AND T1.GONGGEUM_GYEJWA = T3.GONGGEUM_GYEJWA
                       AND T1.TRX_DT >= T3.KIJUNIL
                       AND T2.BANK_GUBUN = 0
                 ) T1
                ,ACL_SIGUMGO_MAS T2
                ,RPT_AC_BY_HOIKYE_MAPP T3
      WHERE 1=1
           AND T2.FIL_100_CTNT2 LIKE T1.GONGGEUM_GYEJWA_15||'%'
           AND T2.FIL_100_CTNT2 = T3.SIGUMGO_ACNO
           AND T2.SIGUMGO_HOIKYE_YR = T3.SIGUMGO_HOIKYE_YR
           AND T1.TRGT_YN = 'Y'
           AND T2.MNG_NO = 1
      ) T1
     ,(
       SELECT
            T1.KIJUNIL
           ,T1.HOIGYE_YEAR
           ,T1.HOIGYE_CODE
           ,T1.GUNGU_CODE
           ,T1.GEUMGO_CODE
           ,SUM(T1.AMT1) AS AMT2
       FROM
            RPT_HOIGYE_IWOL T1
       WHERE 1=1
            AND '2025' > '2021'
            AND T1.HOIGYE_YEAR = '2025'
            AND T1.GEUMGO_CODE = '42'
            AND T1.GUNGU_CODE = 0
            AND GUBUN_CODE = 2
       GROUP BY
            T1.KIJUNIL
           ,T1.HOIGYE_YEAR
           ,T1.HOIGYE_CODE
           ,T1.GUNGU_CODE
           ,T1.GEUMGO_CODE
       HAVING SUM(T1.AMT1) > 0 
      ) T2
      WHERE 1=1
            AND T1.HOIGYE_CODE = T2.HOIGYE_CODE(+)
            AND T1.HOIGYE_YEAR = T2.HOIGYE_YEAR(+)
            AND T1.TRGT_YN = 'Y'
      UNION ALL
      SELECT
           T1.GONGGEUM_HOIGYE_CODE
          ,T1.GONGGEUM_GYEJWA
          ,T1.TRX_DT
          ,T1.BIZ_DT
          ,0 AS GONGGEUM
          ,0 AS UNYONG
          ,T2.JANAEK AS MMDA
      FROM
           (
            SELECT DISTINCT
                 T1.FIL_100_CTNT2 AS GONGGEUM_GYEJWA
                ,TO_NUMBER(T2.SIGUMGO_HOIKYE_C) AS GONGGEUM_HOIGYE_CODE
                ,T3.TRX_DT
                ,T3.BIZ_DT
                ,T3.DAYS_CNT
            FROM
                 ACL_SIGUMGO_MAS T1
                ,RPT_AC_BY_HOIKYE_MAPP T2
                ,(
                  SELECT
                        T1.DW_BAS_DDT AS TRX_DT
                       ,DECODE(T1.DT_G, 0, T1.BIZ_DT, T1.BF1_BIZ_DT) AS BIZ_DT
                       ,COUNT(1) OVER() AS DAYS_CNT
                  FROM
                       MAP_JOB_DATE T1
                  WHERE 1=1
                       AND T1.DW_BAS_DDT >= '20241101'
                       AND T1.DW_BAS_DDT <= '20251130'
                 ) T3
            WHERE 1=1
                 AND T1.FIL_100_CTNT2 = T2.SIGUMGO_ACNO
                 AND T1.SIGUMGO_HOIKYE_YR = T2.SIGUMGO_HOIKYE_YR
                 AND T1.SIGUMGO_ORG_C = '42'
                 AND (
                      CASE
                          WHEN T1.SIGUMGO_HOIKYE_YR = '9999' AND SUBSTR(T3.TRX_DT, 1, 4) = '2025'
                          THEN 1
                          WHEN T1.SIGUMGO_HOIKYE_YR = '2025'
                          THEN 1
                          ELSE 0
                       END
                     ) = 1
           ) T1
          ,RPT_UNYONG_JAN T2
      WHERE 1=1
           AND T1.GONGGEUM_GYEJWA = T2.GONGGEUM_GYEJWA
           AND T1.BIZ_DT = T2.KIJUNIL
           AND T2.UNYONG_GYEJWA = '000000000000'
      UNION ALL
      SELECT
          T1.HOIGYE_CODE
         ,T1.GONGGEUM_GYEJWA
         ,T1.TRX_DT
         ,T1.BIZ_DT
         ,0 AS GONGGEUM
         ,T2.JANAEK AS UNYONG
         ,0 AS MMDA
     FROM
          (
          SELECT
               T2.GONGGEUM_GYEJWA
              ,T2.UNYONG_GYEJWA
              ,T1.HOIGYE_CODE
              ,T1.TRX_DT
              ,T1.BIZ_DT
              ,T1.DAYS_CNT
          FROM
               (
               SELECT
                    T1.REF_D_C + 900 AS HOIGYE_CODE
                   ,T1.REF_D_NM AS GONGGEUM_GYEJWA
                   ,T2.TRX_DT
                   ,T2.BIZ_DT
                   ,T2.DAYS_CNT
               FROM
                    RPT_CODE_INFO T1
                   ,(
                     SELECT
                           T1.DW_BAS_DDT AS TRX_DT
                          ,DECODE(T1.DT_G, 0, T1.BIZ_DT, T1.BF1_BIZ_DT) AS BIZ_DT
                          ,COUNT(1) OVER() AS DAYS_CNT
                     FROM
                          MAP_JOB_DATE T1
                     WHERE 1=1
                          AND T1.DW_BAS_DDT >= '20241101'
                          AND T1.DW_BAS_DDT <= '20251130'
                    ) T2
               WHERE 1=1
                    AND T1.REF_L_C =50
                    AND T1.REF_M_C = '42'
                    AND T1.YUHYO_YN = 0
               ) T1
              ,RPT_UNYONG_GYEJWA T2
          WHERE 1=1
               AND T1.GONGGEUM_GYEJWA = T2.GONGGEUM_GYEJWA
               AND T1.TRX_DT >= SUBSTR(NVL(T2.MKDT,T2.IN_DATE),1,8)
               AND T1.TRX_DT < NVL(T2.OUT_DATE, '99991231')
               AND T1.TRX_DT < NVL(T2.HJI_DT, '99991231')
               AND SUBSTR(T1.TRX_DT, 1, 4) = '2025'
               AND T2.BANK_GUBUN = 0
          ) T1
         ,RPT_UNYONG_JAN T2
     WHERE 1=1
          AND T1.GONGGEUM_GYEJWA = T2.GONGGEUM_GYEJWA
          AND T1.UNYONG_GYEJWA = T2.UNYONG_GYEJWA
          AND T1.BIZ_DT = T2.KIJUNIL
     ) T1
    ,(
      SELECT
           TO_NUMBER(T2.SIGUMGO_HOIKYE_C) AS HOIGYE_CODE
          ,T1.FIL_100_CTNT2 AS GONGGEUM_GYEJWA
          ,T1.SIGUMGO_AC_NM AS GONGGEUM_GYEJWA_NM
          ,T1.SIGUMGO_HOIKYE_YR AS GONGGEUM_HOIGYE_YEAR
          ,LPAD(T1.LINKAC_KWA_C, 3, '0')||LPAD(T1.LINK_ACSER, 9, '0') AS GONGGEUM_YUDONG_ACNO
      FROM
           ACL_SIGUMGO_MAS T1
          ,RPT_AC_BY_HOIKYE_MAPP T2
      WHERE 1=1
           AND T1.FIL_100_CTNT2 = T2.SIGUMGO_ACNO
           AND T1.SIGUMGO_HOIKYE_YR = T2.SIGUMGO_HOIKYE_YR
           AND T1.SIGUMGO_ORG_C = '42'
           AND T1.MNG_NO = 1
           AND T1.FIL_100_CTNT2 <> '04200080900003999'
           AND (
                CASE
                    WHEN '04200080900000125' IS NULL
                    THEN 
                         CASE
                             WHEN T1.SIGUMGO_HOIKYE_YR IN ('2025', '9999')
                             THEN 1
                             ELSE 0
                          END
                    ELSE DECODE(T1.SIGUMGO_HOIKYE_YR, '2025', 1, 0)
                 END
               ) = 1
     ) T2
    ,(
      SELECT
            COUNT(1) AS DAYS_CNT
      FROM
           MAP_JOB_DATE T1
      WHERE 1=1
           AND T1.DW_BAS_DDT >= '20241101'
           AND T1.DW_BAS_DDT <= '20251130'
     ) T3
WHERE 1=1
     AND T1.GONGGEUM_GYEJWA(+) = T2.GONGGEUM_GYEJWA
   AND T2.GONGGEUM_GYEJWA  = '04200080900000125'  
GROUP BY
     T2.HOIGYE_CODE
    ,T1.GONGGEUM_GYEJWA
    ,T2.GONGGEUM_GYEJWA
    ,T2.GONGGEUM_GYEJWA_NM
    ,T2.GONGGEUM_HOIGYE_YEAR
    ,T2.GONGGEUM_YUDONG_ACNO
ORDER BY
    T2.HOIGYE_CODE
    ,T1.GONGGEUM_GYEJWA
    ,T2.GONGGEUM_GYEJWA
    ,T2.GONGGEUM_GYEJWA_NM
    ,T2.GONGGEUM_HOIGYE_YEAR
    ,T2.GONGGEUM_YUDONG_ACNO

============================================================================================
, 1767331403816
20260102treap1pRPTPWK0809239000

=========================== XDA ID:[tom.rpt.utils.xda.xSelectListComboBy052]===============================

   SELECT A.FIL_100_CTNT2 AS CODE
   , SUBSTR (A.FIL_100_CTNT2, 1, 3)
   || '-'
   || SUBSTR (A.FIL_100_CTNT2, 4, 3)
   || '-'
   || SUBSTR (A.FIL_100_CTNT2, 7, 2)
   || '-'
   || SUBSTR (A.FIL_100_CTNT2, 9, 2)
   || '-'
   || SUBSTR (A.FIL_100_CTNT2, 11, 5)
   || '-'
   || SUBSTR (A.FIL_100_CTNT2, 16, 2)
  || ' [' || A.SIGUMGO_AC_NM || ']' AS NAME
    FROM ACL_SIGUMGO_MAS A,
  RPT_AC_BY_HOIKYE_MAPP B
 WHERE 1=1
             AND A.SIGUMGO_ORG_C = B.SIGUMGO_C
             AND A.ICH_SIGUMGO_GUN_GU_C = TO_NUMBER(SUBSTR(B.SIGUMGO_ACNO, 4, 3))
             AND A.ICH_SIGUMGO_HOIKYE_C = TO_NUMBER(SUBSTR(B.SIGUMGO_ACNO, 7, 2))
             AND A.SIGUMGO_AC_B = TO_NUMBER(SUBSTR(B.SIGUMGO_ACNO, 9, 2))
             AND A.SIGUMGO_AC_SER = TO_NUMBER(SUBSTR(B.SIGUMGO_ACNO, 10, 6))
             AND A.SIGUMGO_HOIKYE_YR = B.SIGUMGO_HOIKYE_YR
  AND  A.SIGUMGO_ORG_C = '42'
  AND A.MNG_NO = 1
  AND A.ICH_SIGUMGO_GUN_GU_C   <>   900
  AND A.SIGUMGO_HOIKYE_YR IN ('2025','9999')
  AND (A.AC_GRBRNO LIKE '%'|| '' ||'%' OR A.AC_GRBRNO IS NULL)
  
 ORDER BY CODE

============================================================================================
]

------------------------------------------------------------
-- 강원 자금운용

-- 계좌정보 계좌명, 예금종류

WITH GYEJWA AS ( 
    SELECT
        '공금예금' AS GYEJWA_TYPE,
        LINKAC_KWA_C || '000' || LPAD(TO_CHAR(LINK_ACSER), 6, '0') AS ACNO,
        FIL_100_CTNT5 AS GONGGEUM_GYEJWA,    
        SIGUMGO_AC_NM AS GYEJWA_NM,
        '20241101' AS START_DT,
        '20251130' AS END_DT
    FROM
        ACL_SIGUMGO_MAS
    WHERE 
        SIGUMGO_ORG_C = 42
    AND MNG_NO = 1    
    AND 
        FIL_100_CTNT5 IN (
            SELECT GONGGEUM_GYEJWA FROM RPT_GONGGEUM_JAN
            WHERE 1=1
            AND GEUMGO_CODE = 42
            AND KEORAEIL BETWEEN '20241101' AND '20251130'
            GROUP BY GONGGEUM_GYEJWA
        )
    UNION ALL 
    SELECT
        CASE 
        WHEN SUBSTR(UNYONG_GYEJWA , 0, 3) = '200' THEN '정기예금'
        WHEN SUBSTR(UNYONG_GYEJWA , 0, 3) = '207' THEN '정기예금' 
        ELSE '수시입출금식예금' END AS GYEJWA_TYPE,
        UNYONG_GYEJWA AS ACNO,
        GONGGEUM_GYEJWA AS GONGGEUM_GYEJWA,
        SANGPUM_NAME AS GYEJWA_NM,
        MKDT AS START_DT, 
        NVL(DUDT, '20251130') AS END_DT
    FROM RPT_UNYONG_GYEJWA
    WHERE 1=1
    AND GEUMGO_CODE = 42
    AND UNYONG_GYEJWA NOT LIKE '160%'
    AND UNYONG_GYEJWA IN (
                            SELECT
                                T1.UNYONG_GYEJWA
                            FROM
                                RPT_UNYONG_JAN T1
                                ,MAP_JOB_DATE T2
                            WHERE 1=1
                                AND T1.KIJUNIL = DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT)
                                AND T1.GEUMGO_CODE = '42'
                                AND T2.DW_BAS_DDT >= '20241101'
                                AND T2.DW_BAS_DDT <= '20251130'
    )
),
JOB_DATE (
      SELECT
            COUNT(1) AS DAYS_CNT
      FROM
           MAP_JOB_DATE T1
      WHERE 1=1
           AND T1.DW_BAS_DDT >= '20241101'
           AND T1.DW_BAS_DDT <= '20251130'
     )
SELECT
 *
FROM GYEJWA
ORDER BY ACNO, GONGGEUM_GYEJWA 

-------------------------------------------------------
-- 평잔용 누적일수

SELECT
 COUNT(*) AS CNT
FROM MAP_JOB_DATE 
WHERE DW_BAS_DDT BETWEEN '20241101' AND '20251130'


-------------------------------------------------------

-- 공금예금(160) 평잔

            SELECT
                (SELECT LINKAC_KWA_C || '000' || LPAD(TO_CHAR(LINK_ACSER), 6, '0') FROM ACL_SIGUMGO_MAS WHERE SIGUMGO_ORG_C = 42 AND MNG_NO = 1 AND FIL_100_CTNT5 = T1.GONGGEUM_GYEJWA) AS ACNO
                ,T1.GONGGEUM_GYEJWA
                ,T2.DW_BAS_DDT AS TRX_DT
                ,DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT) AS BIZ_DT
                ,T1.JANAEK
            FROM
                 RPT_GONGGEUM_JAN T1
                ,MAP_JOB_DATE T2
            WHERE 1=1
                 AND T1.KEORAEIL = DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT)
                 AND T1.GEUMGO_CODE = '42'
                 AND T1.GUNGU_CODE = 0
                 AND T2.DW_BAS_DDT >= '20241101'
                 AND T2.DW_BAS_DDT <= '20251130'


-- 정기예금(200, 207) 평잔

                        SELECT
                            T1.UNYONG_GYEJWA AS ACNO
                            ,T1.GONGGEUM_GYEJWA
                            ,T2.DW_BAS_DDT AS TRX_DT
                            ,DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT) AS BIZ_DT
                            ,T1.JANAEK
                        FROM
                             RPT_UNYONG_JAN T1
                            ,MAP_JOB_DATE T2
                        WHERE 1=1
                             AND T1.KIJUNIL = DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT)
                             AND T1.GEUMGO_CODE = '42'
                             AND T2.DW_BAS_DDT >= '20241101'
                             AND T2.DW_BAS_DDT <= '20251130'

-- 수시입출금식(200, 207 외) 평잔

-- 공금 및 예금 적수

SELECT 
 A.ACNO,
 A.GONGGEUM_GYEJWA,
 SUM(A.JANAEK) AS JANAEK,
 TRUNC(SUM(A.JANAEK)/ 395 , 0) AS P_JAN
FROM 
(
            SELECT
                (SELECT LINKAC_KWA_C || '000' || LPAD(TO_CHAR(LINK_ACSER), 6, '0') FROM ACL_SIGUMGO_MAS WHERE SIGUMGO_ORG_C = 42 AND MNG_NO = 1 AND FIL_100_CTNT5 = T1.GONGGEUM_GYEJWA) AS ACNO
                ,T1.GONGGEUM_GYEJWA
                ,T2.DW_BAS_DDT AS TRX_DT
                ,DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT) AS BIZ_DT
                ,T1.JANAEK
            FROM
                 RPT_GONGGEUM_JAN T1
                ,MAP_JOB_DATE T2
            WHERE 1=1
                 AND T1.KEORAEIL = DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT)
                 AND T1.GEUMGO_CODE = '42'
                 AND T1.GUNGU_CODE = 0
                 AND T2.DW_BAS_DDT >= '20241101'
                 AND T2.DW_BAS_DDT <= '20251130'
    UNION ALL 
                            SELECT
                            T1.UNYONG_GYEJWA AS ACNO
                            ,T1.GONGGEUM_GYEJWA
                            ,T2.DW_BAS_DDT AS TRX_DT
                            ,DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT) AS BIZ_DT
                            ,T1.JANAEK
                        FROM
                             RPT_UNYONG_JAN T1
                            ,MAP_JOB_DATE T2
                        WHERE 1=1
                             AND T1.KIJUNIL = DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT)
                             AND T1.GEUMGO_CODE = '42'
                             AND T1.UNYONG_GYEJWA NOT LIKE '00000%'
                             AND T2.DW_BAS_DDT >= '20241101'
                             AND T2.DW_BAS_DDT <= '20251130'
 ) A
GROUP BY A.ACNO, A.GONGGEUM_GYEJWA 

----------------------------------------------


-- 공금예금 이율, 이자, 예치기간
WITH GYEJWA AS ( 
    SELECT
        '공금예금' AS GYEJWA_TYPE,
        LINKAC_KWA_C || '000' || LPAD(TO_CHAR(LINK_ACSER), 6, '0') AS ACNO,
        FIL_100_CTNT5 AS GONGGEUM_GYEJWA,    
        SIGUMGO_AC_NM AS GYEJWA_NM,
        '20241101' AS START_DT,
        '20251130' AS END_DT
    FROM
        ACL_SIGUMGO_MAS
    WHERE 
        SIGUMGO_ORG_C = 42
    AND MNG_NO = 1    
    AND 
        FIL_100_CTNT5 IN (
            SELECT GONGGEUM_GYEJWA FROM RPT_GONGGEUM_JAN
            WHERE 1=1
            AND GEUMGO_CODE = 42
            AND KEORAEIL BETWEEN '20241101' AND '20251130'
            GROUP BY GONGGEUM_GYEJWA
        )
    UNION ALL 
    SELECT
        CASE 
        WHEN SUBSTR(UNYONG_GYEJWA , 0, 3) = '200' THEN '정기예금'
        WHEN SUBSTR(UNYONG_GYEJWA , 0, 3) = '207' THEN '정기예금' 
        ELSE '수시입출금식예금' END AS GYEJWA_TYPE,
        UNYONG_GYEJWA AS ACNO,
        GONGGEUM_GYEJWA AS GONGGEUM_GYEJWA,
        SANGPUM_NAME AS GYEJWA_NM,
        MKDT AS START_DT, 
        NVL(DUDT, '20251130') AS END_DT
    FROM RPT_UNYONG_GYEJWA
    WHERE 1=1
    AND GEUMGO_CODE = 42
    AND UNYONG_GYEJWA NOT LIKE '160%'
    AND UNYONG_GYEJWA IN (
                            SELECT
                                T1.UNYONG_GYEJWA
                            FROM
                                RPT_UNYONG_JAN T1
                                ,MAP_JOB_DATE T2
                            WHERE 1=1
                                AND T1.KIJUNIL = DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT)
                                AND T1.GEUMGO_CODE = '42'
                                AND T2.DW_BAS_DDT >= '20241101'
                                AND T2.DW_BAS_DDT <= '20251130'
    )
)
SELECT 
 A.ACNO, 
 SUM(A.IJA) AS IJA, 
 A.IYUL
FROM 
(
    SELECT 
        EFT_ACNO AS ACNO,
        TRXDT AS BIZ_DT,
        SUM(TRAMT) AS IJA,
        0 AS IYUL
    FROM ACL_SIGYUL_SLV
    WHERE TRXDT BETWEEN '20241101' AND '20251130'
    AND EFT_ACNO IN (SELECT ACNO FROM GYEJWA)
    GROUP BY EFT_ACNO, TRXDT
    UNION ALL 
    SELECT 
    A.ACNO, A.BIZ_DT, A.IJA, A.IYUL 
    FROM 
    (
    SELECT
                                T1.UNYONG_GYEJWA AS ACNO
                                ,DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT) AS BIZ_DT
                                ,T1.JI_IJA AS IJA
                                ,DECODE(T1.IYUL, 0, (SELECT MAX(IYUL) FROM RPT_UNYONG_JAN T5 WHERE T5.UNYONG_GYEJWA = T1.UNYONG_GYEJWA AND T5.GONGGEUM_GYEJWA = T5.GONGGEUM_GYEJWA), T1.IYUL) AS IYUL
                            FROM
                                RPT_UNYONG_JAN T1
                                ,MAP_JOB_DATE T2
                            WHERE 1=1
                                AND T1.KIJUNIL = DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT)
                                AND T1.GEUMGO_CODE = '42'
                                AND T1.UNYONG_GYEJWA NOT LIKE '00000%'
                                AND T2.DW_BAS_DDT >= '20241101'
                                AND T2.DW_BAS_DDT <= '20251130'
                                AND T1.JI_IJA > 0
    ) A                              
    GROUP BY A.ACNO,  A.BIZ_DT, A.IJA, A.IYUL 
) A 
GROUP BY A.ACNO, A.IYUL

-- 이율이 0 인 경우
-- 200798645594 20241113
SELECT * FROM RPT_UNYONG_JAN
WHERE UNYONG_GYEJWA = '200798645594'
AND KIJUNIL LIKE '2024%'
ORDER BY KIJUNIL 


-- 정기예금 이율, 이자, 예치기간

-- 수시입출금식 이율, 이자, 예치기간

------------------------------------------------

WITH GYEJWA AS ( 
    SELECT
        '공금예금' AS GYEJWA_TYPE,
        LINKAC_KWA_C || '000' || LPAD(TO_CHAR(LINK_ACSER), 6, '0') AS G_ACNO,
        MAX(SIGUMGO_AC_NM) AS GYEJWA_NM,
        LINKAC_KWA_C || '000' || LPAD(TO_CHAR(LINK_ACSER), 6, '0') AS ACNO,
        MAX(SIGUMGO_AC_NM) AS SANGPUM_NM,
        '20241101' AS START_DT,
        '20251130' AS END_DT
    FROM
        ACL_SIGUMGO_MAS
    WHERE 
        SIGUMGO_ORG_C = 42
    AND MNG_NO = 1    
    AND 
        FIL_100_CTNT5 IN (
            SELECT GONGGEUM_GYEJWA FROM RPT_GONGGEUM_JAN
            WHERE 1=1
            AND GEUMGO_CODE = 42
            AND KEORAEIL BETWEEN '20241101' AND '20251130'
            GROUP BY GONGGEUM_GYEJWA
        )
    GROUP BY  LINKAC_KWA_C || '000' || LPAD(TO_CHAR(LINK_ACSER), 6, '0')
    UNION ALL 
    SELECT
        CASE 
        WHEN SUBSTR(UNYONG_GYEJWA , 0, 3) = '200' THEN '정기예금'
        WHEN SUBSTR(UNYONG_GYEJWA , 0, 3) = '207' THEN '정기예금' 
        ELSE '수시입출금식예금' END AS GYEJWA_TYPE,
        (SELECT LINKAC_KWA_C || '000' || LPAD(TO_CHAR(LINK_ACSER), 6, '0') FROM ACL_SIGUMGO_MAS WHERE SIGUMGO_ORG_C = 42 AND MNG_NO = 1 AND FIL_100_CTNT5 = GONGGEUM_GYEJWA)  AS G_ACNO,
        (SELECT MAX(SIGUMGO_AC_NM) FROM ACL_SIGUMGO_MAS WHERE SIGUMGO_ORG_C = 42 AND MNG_NO = 1 AND FIL_100_CTNT5 = GONGGEUM_GYEJWA GROUP BY LINKAC_KWA_C || '000' || LPAD(TO_CHAR(LINK_ACSER), 6, '0')) AS GYEJWA_NM,
        UNYONG_GYEJWA AS ACNO,
        SANGPUM_NAME AS SANGPUM_NM,
        MKDT AS START_DT, 
        NVL(DUDT, '20251130') AS END_DT
    FROM RPT_UNYONG_GYEJWA
    WHERE 1=1
    AND GEUMGO_CODE = 42
    AND UNYONG_GYEJWA NOT LIKE '160%'
    AND UNYONG_GYEJWA IN (
                            SELECT
                                T1.UNYONG_GYEJWA
                            FROM
                                RPT_UNYONG_JAN T1
                                ,MAP_JOB_DATE T2
                            WHERE 1=1
                                AND T1.KIJUNIL = DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT)
                                AND T1.GEUMGO_CODE = '42'
                                AND T2.DW_BAS_DDT >= '20241101'
                                AND T2.DW_BAS_DDT <= '20251130'
    )
),
JOB_DATE AS (
      SELECT
            COUNT(1) AS DAYS_CNT
      FROM
           MAP_JOB_DATE T1
      WHERE 1=1
           AND T1.DW_BAS_DDT >= '20241101'
           AND T1.DW_BAS_DDT <= '20251130'
     ),
IJA_DATA AS (
    SELECT 
        A.ACNO, 
        SUM(A.IJA) AS IJA, 
        A.IYUL
        FROM 
        (
            SELECT 
                EFT_ACNO AS ACNO,
                TRXDT AS BIZ_DT,
                SUM(TRAMT) AS IJA,
                0 AS IYUL
            FROM ACL_SIGYUL_SLV
            WHERE TRXDT BETWEEN '20241101' AND '20251130'
            AND EFT_ACNO IN (SELECT ACNO FROM GYEJWA)
            GROUP BY EFT_ACNO, TRXDT
            UNION ALL 
            SELECT 
            A.ACNO, A.BIZ_DT, A.IJA, A.IYUL 
            FROM 
            (
            SELECT
                                        T1.UNYONG_GYEJWA AS ACNO
                                        ,DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT) AS BIZ_DT
                                        ,T1.JI_IJA AS IJA
                                        ,DECODE(T1.IYUL, 0, (SELECT MAX(IYUL) FROM RPT_UNYONG_JAN T5 WHERE T5.UNYONG_GYEJWA = T1.UNYONG_GYEJWA AND T5.GONGGEUM_GYEJWA = T5.GONGGEUM_GYEJWA), T1.IYUL) AS IYUL
                                    FROM
                                        RPT_UNYONG_JAN T1
                                        ,MAP_JOB_DATE T2
                                    WHERE 1=1
                                        AND T1.KIJUNIL = DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT)
                                        AND T1.GEUMGO_CODE = '42'
                                        AND T1.UNYONG_GYEJWA NOT LIKE '00000%'
                                        AND T2.DW_BAS_DDT >= '20241101'
                                        AND T2.DW_BAS_DDT <= '20251130'
                                        AND T1.JI_IJA > 0
            ) A                              
            GROUP BY A.ACNO,  A.BIZ_DT, A.IJA, A.IYUL 
        ) A 
        GROUP BY A.ACNO, A.IYUL
),
JAN_DATA AS (
    SELECT 
        A.ACNO,
        SUM(A.JANAEK) AS JANAEK,
        TRUNC(SUM(A.JANAEK)/ 395 , 0) AS P_JAN
        FROM 
        (
                    SELECT
                        (SELECT LINKAC_KWA_C || '000' || LPAD(TO_CHAR(LINK_ACSER), 6, '0') FROM ACL_SIGUMGO_MAS WHERE SIGUMGO_ORG_C = 42 AND MNG_NO = 1 AND FIL_100_CTNT5 = T1.GONGGEUM_GYEJWA) AS ACNO
                        ,T1.GONGGEUM_GYEJWA
                        ,T2.DW_BAS_DDT AS TRX_DT
                        ,DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT) AS BIZ_DT
                        ,T1.JANAEK
                    FROM
                        RPT_GONGGEUM_JAN T1
                        ,MAP_JOB_DATE T2
                    WHERE 1=1
                        AND T1.KEORAEIL = DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT)
                        AND T1.GEUMGO_CODE = '42'
                        AND T1.GUNGU_CODE = 0
                        AND T2.DW_BAS_DDT >= '20241101'
                        AND T2.DW_BAS_DDT <= '20251130'
            UNION ALL 
                                    SELECT
                                    T1.UNYONG_GYEJWA AS ACNO
                                    ,T1.GONGGEUM_GYEJWA
                                    ,T2.DW_BAS_DDT AS TRX_DT
                                    ,DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT) AS BIZ_DT
                                    ,T1.JANAEK
                                FROM
                                    RPT_UNYONG_JAN T1
                                    ,MAP_JOB_DATE T2
                                WHERE 1=1
                                    AND T1.KIJUNIL = DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT)
                                    AND T1.GEUMGO_CODE = '42'
                                    AND UNYONG_GYEJWA <> '160000125420'
                                    AND T1.UNYONG_GYEJWA NOT LIKE '00000%'
                                    AND T2.DW_BAS_DDT >= '20241101'
                                    AND T2.DW_BAS_DDT <= '20251130'
        ) A
        GROUP BY A.ACNO
)
SELECT
 A.GYEJWA_TYPE,
 A.G_ACNO,
 A.GYEJWA_NM,
 A.ACNO,
 A.SANGPUM_NM,
 A.START_DT,
 A.END_DT,
 B.P_JAN,
 C.IJA,
 C.IYUL
FROM GYEJWA A 
LEFT JOIN JAN_DATA B ON A.ACNO = B.ACNO
LEFT JOIN IJA_DATA C ON A.ACNO = C.ACNO
WHERE B.P_JAN > 0
ORDER BY  A.GYEJWA_TYPE, A.G_ACNO, A.ACNO, A.GYEJWA_NM,  A.SANGPUM_NM


--------------------------------------------------------------------------------
-- 160000125420

SELECT SUM(JANAEK) AS JAN, TRUNC(SUM(JANAEK) / 395) AS P_JAN FROM RPT_GONGGEUM_JAN
WHERE 1=1
AND GEUMGO_CODE = 42
AND KEORAEIL BETWEEN '20241101' AND '20251130'
AND GONGGEUM_GYEJWA = '04200080900003999'

------------------------------------------------------

SELECT SUM(JANAEK) AS JAN, TRUNC(SUM(JANAEK) / 395) AS P_JAN FROM RPT_GONGGEUM_JAN
WHERE 1=1
AND GEUMGO_CODE = 42
AND KEORAEIL BETWEEN '20241101' AND '20251130'
AND GONGGEUM_GYEJWA IN (
SELECT FIL_100_CTNT5 FROM ACL_SIGUMGO_MAS
WHERE MNG_NO = 1
AND SIGUMGO_ORG_C = 42
AND LINK_ACSER = 125420
)

-----------------------------------------------------------------------------

SELECT 
        A.*
        FROM 
        (
                    SELECT
                        (SELECT LINKAC_KWA_C || '000' || LPAD(TO_CHAR(LINK_ACSER), 6, '0') FROM ACL_SIGUMGO_MAS WHERE SIGUMGO_ORG_C = 42 AND MNG_NO = 1 AND FIL_100_CTNT5 = T1.GONGGEUM_GYEJWA) AS ACNO
                        ,T1.GONGGEUM_GYEJWA
                        ,T2.DW_BAS_DDT AS TRX_DT
                        ,DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT) AS BIZ_DT
                        ,T1.JANAEK
                    FROM
                        RPT_GONGGEUM_JAN T1
                        ,MAP_JOB_DATE T2
                    WHERE 1=1
                        AND T1.KEORAEIL = DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT)
                        AND T1.GEUMGO_CODE = '42'
                        AND T1.GUNGU_CODE = 0
                        AND T2.DW_BAS_DDT >= '20241101'
                        AND T2.DW_BAS_DDT <= '20251130'
            UNION ALL 
                                    SELECT
                                    T1.UNYONG_GYEJWA AS ACNO
                                    ,T1.GONGGEUM_GYEJWA
                                    ,T2.DW_BAS_DDT AS TRX_DT
                                    ,DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT) AS BIZ_DT
                                    ,T1.JANAEK
                                FROM
                                    RPT_UNYONG_JAN T1
                                    ,MAP_JOB_DATE T2
                                WHERE 1=1
                                    AND T1.KIJUNIL = DECODE(T2.DT_G, 0, T2.BIZ_DT, T2.BF1_BIZ_DT)
                                    AND T1.GEUMGO_CODE = '42'
                                    AND UNYONG_GYEJWA <> '160000125420'
                                    AND T1.UNYONG_GYEJWA NOT LIKE '00000%'
                                    AND T2.DW_BAS_DDT >= '20241101'
                                    AND T2.DW_BAS_DDT <= '20251130'
        ) A
        WHERE ACNO = '160000125420'


-- 160000126092

SELECT SUM(JANAEK) AS JAN, TRUNC(SUM(JANAEK) / 395) AS P_JAN FROM RPT_GONGGEUM_JAN
WHERE 1=1
AND GEUMGO_CODE = 42
AND KEORAEIL BETWEEN '20241101' AND '20251130'
AND GONGGEUM_GYEJWA IN (
SELECT FIL_100_CTNT5 FROM ACL_SIGUMGO_MAS
WHERE MNG_NO = 1
AND SIGUMGO_ORG_C = 42
AND LINK_ACSER = 126092
AND 
        FIL_100_CTNT5 IN (
            SELECT GONGGEUM_GYEJWA FROM RPT_GONGGEUM_JAN
            WHERE 1=1
            AND GEUMGO_CODE = 42
            AND KEORAEIL BETWEEN '20241101' AND '20251130'
            GROUP BY GONGGEUM_GYEJWA
        )
)

-------------------------------

SELECT SUM(JANAEK) AS JAN, TRUNC(SUM(JANAEK) / 395) AS P_JAN FROM RPT_GONGGEUM_JAN
WHERE 1=1
AND GEUMGO_CODE = 42
AND KEORAEIL BETWEEN '20241101' AND '20251130'
AND GONGGEUM_GYEJWA IN (
SELECT FIL_100_CTNT5 FROM ACL_SIGUMGO_MAS
WHERE MNG_NO = 1
AND SIGUMGO_ORG_C = 42
AND LINK_ACSER = 126092
AND 
        FIL_100_CTNT5 IN (
            SELECT GONGGEUM_GYEJWA FROM RPT_GONGGEUM_JAN
            WHERE 1=1
            AND GEUMGO_CODE = 42
            AND KEORAEIL BETWEEN '20241101' AND '20251130'
            GROUP BY GONGGEUM_GYEJWA
        )
AND SIGUMGO_HOIKYE_YR IN (2024)        
)


----------------------------------------------------------


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
                                     AND T1.KEORAEIL BETWEEN '20241101' AND '20251130'
                                     AND T1.JANAEK != 0
                                     AND T1.GONGGEUM_GYEJWA NOT IN ('04200080900003999')
                                GROUP BY T1.GONGGEUM_GYEJWA
                                 ) T10
                               , ACL_SIGUMGO_MAS T20
                           WHERE 1 = 1
                             AND T20.MNG_NO = 1
                             AND T20.SIGUMGO_AGE_AC_G IN (0,1) 
                             AND T20.LINK_ACSER = 126092
                             AND T20.FIL_100_CTNT2(+) = T10.GONGGEUM_GYEJWA
                        GROUP BY T20.SIGUMGO_ORG_C
                               , T20.ICH_SIGUMGO_GUN_GU_C, T10.GONGGEUM_GYEJWA, T20.SIGUMGO_AC_NM