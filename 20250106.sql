WITH BIZDT AS (
    SELECT
        DW_BAS_DDT AS TDT,
        NEXT_BIZ_DT AS NDT
    FROM MAP_JOB_DATE
    WHERE DW_BAS_DDT = (SELECT TO_CHAR(SYSDATE, 'YYYYMMDD') FROM DUAL)
),
     MERGED_BIZDT AS (
         SELECT TDT AS DT FROM BIZDT
         UNION ALL
         SELECT NDT AS DT FROM BIZDT
     )
SELECT GJDT AS DT, '1.서구청' AS GUBUN, SUM(SUNP_AMT) AS AMT
FROM ACL_SUNAPMSG_SLV
WHERE GJDT IN (SELECT DT FROM MERGED_BIZDT)
  AND UPMU_G IN (1, 2, 4)
  AND RPT_TOT_C != '104901'
GROUP BY GJDT
UNION ALL
SELECT SIGUMGO_ICHE_KJ_DT AS DT, '2.7331' AS GUBUN, SUM(SIGUMGO_IP_AMT) AS AMT
FROM ACL_INCHICHE_CC
WHERE SIGUMGO_ICHE_KJ_DT IN (SELECT DT FROM MERGED_BIZDT)
  AND SIGUMGO_IP_REF_NO = '55291000670205'
  AND IPJI_G = 1
GROUP BY SIGUMGO_ICHE_KJ_DT
ORDER BY DT, GUBUN, AMT
;

SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE, DATA_LENGTH, NULLABLE
FROM ALL_TAB_COLUMNS
WHERE 1=1
and table_name like 'RPT%'
ORDER BY TABLE_NAME, COLUMN_ID

;

SELECT
  RNUM
 , SL_GMGO_MODL_C
 , USER_ID
 , USER_NM
 , DR_SER
 , MENU_ID
 , MENU_NM
 , SCR_ID
 , SCR_NM
 , DR_DTTM
 , DROKJA_ID
 , UPD_DTTM
 , MODR_ID
FROM  (
 SELECT
  ROWNUM AS RNUM
  , Z.SL_GMGO_MODL_C
  , Z.USER_ID
  , (SELECT MAX(B.USER_NM)  USER_NM
       FROM  SFI_USER_INF B
       WHERE Z.MODR_ID = B.USER_ID) AS USER_NM
  , Z.DR_SER
  , Z.MENU_ID
  ,B.MENU_NM
  , Z.SCR_ID
  , C.SCR_NM
  , Z.DR_DTTM
  , Z.DROKJA_ID
  , Z.UPD_DTTM
  , Z.MODR_ID
 FROM  SFI_SCR_LTST_HIS Z, RPT_MENU_INF B, SFI_SCR_INF C
 WHERE
   Z.SL_GMGO_MODL_C = 'RPT'
  AND ((SELECT MAX(A.USER_NM)
          FROM  SFI_USER_INF A
         WHERE Z.MODR_ID = A.USER_ID) LIKE '%'||''||'%'
       OR Z.USER_ID LIKE '%'||''||'%' )
  AND ((SELECT MAX(E.MENU_NM)
          FROM    SFI_MENU_INF E
         WHERE  E.SL_GMGO_MODL_C = 'RPT'
           AND Z.MENU_ID = E.MENU_ID) LIKE '%'||''||'%'
       OR Z.MENU_ID LIKE '%'||''||'%' )
  AND ((SELECT MAX(F.SCR_NM)
          FROM    SFI_SCR_INF F
         WHERE  F.SL_GMGO_MODL_C = 'RPT'
           AND Z.SCR_ID = F.SCR_ID) LIKE '%'||''||'%'
       OR Z.SCR_ID LIKE '%'||''||'%' )
  AND Z.DR_DTTM LIKE '%'||'20250106'||'%'
  AND Z.SL_GMGO_MODL_C = B.SL_GMGO_MODL_C
  AND Z.MENU_ID = B.MENU_ID
  AND Z.SL_GMGO_MODL_C = C.SL_GMGO_MODL_C
  AND Z.SCR_ID = C.SCR_ID
  AND ROWNUM <= 100
  ORDER BY UPD_DTTM DESC
) X
WHERE X.RNUM >= 0


;


SELECT
  ROWNUM AS RNUM
  , Z.SL_GMGO_MODL_C
  , Z.USER_ID
  , (SELECT MAX(B.USER_NM)  USER_NM
       FROM  SFI_USER_INF B
       WHERE Z.MODR_ID = B.USER_ID) AS USER_NM
  , Z.DR_SER
  , Z.MENU_ID
  ,B.MENU_NM
  , Z.SCR_ID
  , C.SCR_NM
  , Z.DR_DTTM
  , Z.DROKJA_ID
  , Z.UPD_DTTM
  , Z.MODR_ID
 FROM  SFI_SCR_LTST_HIS Z, RPT_MENU_INF B, SFI_SCR_INF C
 WHERE
   Z.SL_GMGO_MODL_C = 'RPT'
  AND ((SELECT MAX(A.USER_NM)
          FROM  SFI_USER_INF A
         WHERE Z.MODR_ID = A.USER_ID) LIKE '%'||''||'%'
       OR Z.USER_ID LIKE '%'||''||'%' )
  AND ((SELECT MAX(E.MENU_NM)
          FROM    SFI_MENU_INF E
         WHERE  E.SL_GMGO_MODL_C = 'RPT'
           AND Z.MENU_ID = E.MENU_ID) LIKE '%'||''||'%'
       OR Z.MENU_ID LIKE '%'||''||'%' )
  AND ((SELECT MAX(F.SCR_NM)
          FROM    SFI_SCR_INF F
         WHERE  F.SL_GMGO_MODL_C = 'RPT'
           AND Z.SCR_ID = F.SCR_ID) LIKE '%'||''||'%'
       OR Z.SCR_ID LIKE '%'||''||'%' )
  AND Z.SL_GMGO_MODL_C = B.SL_GMGO_MODL_C
  AND Z.MENU_ID = B.MENU_ID
  AND Z.SL_GMGO_MODL_C = C.SL_GMGO_MODL_C
  AND Z.SCR_ID = C.SCR_ID
  AND ROWNUM <= 100
  ORDER BY UPD_DTTM DESC
;

SELECT A.MENU_ID AS MENU_ID
     , A.MENU_NM AS MENU_NM
     , CASE WHEN A.USE_YN = 'Y' THEN 1 ELSE 0 END AS MENU_USE_YN
     , CASE WHEN B.USE_YN = 'Y' THEN 1 ELSE 0 END AS UC_USE_YN
     , B.USER_U_SPZ_C AS USER_U_C
     , 0 AS CNT
  FROM  RPT_MENU_INF      A
     , SFI_U_BY_MENU_HIS B
 WHERE A.SL_GMGO_MODL_C = 'RPT'
   AND   ((CASE WHEN '28' = '0' THEN '28' ELSE A.SIGUMGO_C  END) =  '28' OR  A.SIGUMGO_C  IS NULL)
   AND A.SL_GMGO_MODL_C  = B.SL_GMGO_MODL_C(+)
   AND A.MENU_ID         = B.MENU_ID(+)
;

SELECT
    USER_ID,
    MENU_ID,
    COUNT(*) AS CNT
FROM
    SFI_SCR_LTST_HIS
WHERE 1=1
AND SL_GMGO_MODL_C = 'RPT'
GROUP BY USER_ID, MENU_ID

------------------------------------------------------------------------------------------------------

SELECT
    A.SL_GMGO_MODL_C,
    A.MENU_ID,
    A.MENU_NM,
    B.USER_U_SPZ_C AS USER_U_C,
    A.USE_YN AS MENU_USE_YN,
    B.USE_YN AS UC_USE_YN,
    0 AS CNT
FROM
    RPT_MENU_INF A
LEFT OUTER JOIN SFI_U_BY_MENU_HIS B ON A.SL_GMGO_MODL_C  = B.SL_GMGO_MODL_C AND A.MENU_ID = B.MENU_ID
WHERE 1=1
AND A.SL_GMGO_MODL_C = 'RPT'
AND ((CASE WHEN '28' = '0' THEN '28' ELSE A.SIGUMGO_C  END) =  '28' OR  A.SIGUMGO_C  IS NULL)
AND B.USER_U_SPZ_C NOT IN ('RPT000', 'RPT028')
AND (
        A.MENU_ID LIKE 'ICH%'
    OR
        A.MENU_ID LIKE 'RPT%'
    )
ORDER BY A.MENU_ID, A.MENU_NM, B.USER_U_SPZ_C
;


WITH MENU_LIST AS (
SELECT
    A.SL_GMGO_MODL_C,
    A.MENU_ID,
    A.MENU_NM,
    B.USER_U_SPZ_C AS USER_U_C,
    A.USE_YN AS MENU_USE_YN,
    B.USE_YN AS UC_USE_YN
FROM
    RPT_MENU_INF A
LEFT OUTER JOIN SFI_U_BY_MENU_HIS B ON A.SL_GMGO_MODL_C  = B.SL_GMGO_MODL_C AND A.MENU_ID = B.MENU_ID
WHERE 1=1
AND A.SL_GMGO_MODL_C = 'RPT'
AND ((CASE WHEN '28' = '0' THEN '28' ELSE A.SIGUMGO_C  END) =  '28' OR  A.SIGUMGO_C  IS NULL)
AND B.USER_U_SPZ_C NOT IN ('RPT000', 'RPT028')
AND (
        A.MENU_ID LIKE 'ICH%'
    OR
        A.MENU_ID LIKE 'RPT%'
    )
),
COUNT_LIST AS (
SELECT
    A.USER_U_C,
    A.MENU_ID,
    SUM(NVL(A.CNT, 0)) AS CNT
FROM (SELECT B.USER_ID,
             NVL((select A.user_u_c from SFI_USER_INF A where A.sl_gmgo_modl_c = 'RPT' and A.user_id = B.USER_ID),
                 '028120') as USER_U_C,
             B.MENU_ID,
             COUNT(*)      AS CNT
      FROM SFI_SCR_LTST_HIS B
      WHERE 1 = 1
        AND B.SL_GMGO_MODL_C = 'RPT'
      GROUP BY B.USER_ID, B.MENU_ID) A
WHERE 1 = 1
        AND (
          (A.USER_U_C IN ('028010', '028020', '000011') AND LENGTH(A.USER_ID) = 8)
              OR
          A.USER_U_C NOT IN ('028010', '028020', '000011')
          )
        AND A.USER_U_C NOT IN ('RPT000', 'RPT028')
GROUP BY A.USER_U_C, A.MENU_ID
               )
SELECT A.MENU_ID,
       A.MENU_NM,
       A.MENU_USE_YN,
       A.UC_USE_YN,
       A.USER_U_C,
       SUM(A.CNT) AS CNT
FROM (

SELECT A.MENU_ID,
             A.MENU_NM,
             A.MENU_USE_YN,
             A.UC_USE_YN,
             B.USER_U_C,
             SUM(NVL(B.CNT, 0)) AS CNT
      FROM MENU_LIST A
      LEFT OUTER JOIN COUNT_LIST B ON A.MENU_ID = B.MENU_ID
      GROUP BY A.MENU_ID, A.MENU_NM, A.MENU_USE_YN, A.UC_USE_YN, B.USER_U_C

      ) A
GROUP BY A.MENU_ID, A.MENU_NM, A.MENU_USE_YN, A.UC_USE_YN, A.USER_U_C
ORDER BY A.MENU_ID, A.MENU_NM, A.USER_U_C

------------------------------------------------------------------------------------


    WITH MENU_LIST AS (
SELECT
    A.SL_GMGO_MODL_C,
    A.MENU_ID,
    A.MENU_NM,
    B.USER_U_SPZ_C AS USER_U_C,
    A.USE_YN AS MENU_USE_YN,
    B.USE_YN AS UC_USE_YN
FROM
    RPT_MENU_INF A
LEFT OUTER JOIN SFI_U_BY_MENU_HIS B ON A.SL_GMGO_MODL_C  = B.SL_GMGO_MODL_C AND A.MENU_ID = B.MENU_ID
WHERE 1=1
AND A.SL_GMGO_MODL_C = 'RPT'
AND ((CASE WHEN '28' = '0' THEN '28' ELSE A.SIGUMGO_C  END) =  '28' OR  A.SIGUMGO_C  IS NULL)
AND B.USER_U_SPZ_C NOT IN ('RPT000', 'RPT028')
AND (
        A.MENU_ID LIKE 'ICH%'
    OR
        A.MENU_ID LIKE 'RPT%'
    )
),
COUNT_LIST AS (
SELECT
    A.USER_U_C,
    A.MENU_ID,
    SUM(NVL(A.CNT, 0)) AS CNT
FROM (SELECT B.USER_ID,
             NVL((select A.user_u_c from SFI_USER_INF A where A.sl_gmgo_modl_c = 'RPT' and A.user_id = B.USER_ID),
                 '028120') as USER_U_C,
             B.MENU_ID,
             COUNT(*)      AS CNT
      FROM SFI_SCR_LTST_HIS B
      WHERE 1 = 1
        AND B.SL_GMGO_MODL_C = 'RPT'
      GROUP BY B.USER_ID, B.MENU_ID) A
WHERE 1 = 1
        AND (
          (A.USER_U_C IN ('028010', '028020', '000011') AND LENGTH(A.USER_ID) = 8)
              OR
          A.USER_U_C NOT IN ('028010', '028020', '000011')
          )
        AND A.USER_U_C NOT IN ('RPT000', 'RPT028')
GROUP BY A.USER_U_C, A.MENU_ID
               )
SELECT A.MENU_ID,
             A.MENU_NM,
             A.MENU_USE_YN,
             A.UC_USE_YN,
             A.USER_U_C,
             B.USER_U_C AS USER_U_C2,
             B.CNT AS CNT
      FROM MENU_LIST A
      LEFT OUTER JOIN COUNT_LIST B ON A.MENU_ID = B.MENU_ID
ORDER BY A.MENU_ID, A.MENU_NM, A.USER_U_C, B.USER_U_C


------------------------------------------------------------------------------------------------------
-- ICH030305M01

SELECT
    A.USER_U_C,
    A.MENU_ID,
    SUM(NVL(A.CNT, 0)) AS CNT
FROM (SELECT B.USER_ID,
             NVL((select A.user_u_c from SFI_USER_INF A where A.sl_gmgo_modl_c = 'RPT' and A.user_id = B.USER_ID),
                 '028120') as USER_U_C,
             B.MENU_ID,
             COUNT(*)      AS CNT
      FROM SFI_SCR_LTST_HIS B
      WHERE 1 = 1
        AND B.SL_GMGO_MODL_C = 'RPT'
        AND B.MENU_ID = 'ICH030305M01'
      GROUP BY B.USER_ID, B.MENU_ID) A
GROUP BY A.USER_U_C, A.MENU_ID


SELECT
    A.USER_U_C,
    A.MENU_ID,
    SUM(NVL(A.CNT, 0)) AS CNT
FROM (SELECT B.USER_ID,
             NVL((select A.user_u_c from SFI_USER_INF A where A.sl_gmgo_modl_c = 'RPT' and A.user_id = B.USER_ID),
                 '028120') as USER_U_C,
             B.MENU_ID,
             COUNT(*)      AS CNT
      FROM SFI_SCR_LTST_HIS B
      WHERE 1 = 1
        AND B.SL_GMGO_MODL_C = 'RPT'
      GROUP BY B.USER_ID, B.MENU_ID) A
WHERE 1 = 1
        AND (
          (A.USER_U_C IN ('028010', '028020', '000011') AND LENGTH(A.USER_ID) = 8)
              OR
          A.USER_U_C NOT IN ('028010', '028020', '000011')
          )
        AND A.USER_U_C NOT IN ('RPT000', 'RPT028')
AND A.MENU_ID = 'ICH030305M01'
GROUP BY A.USER_U_C, A.MENU_ID


SELECT X.G_CC_DEPT_C AS DEPT_C,
       DECODE(X.DEL_YN,'Y','(폐쇄)','')||X.G_CC_DEPT_NM AS DEPT_C_NM,
       X.PADM_STD_ORG_C AS ORG_C,
       B.PADM_STD_ORGNM AS ORG_C_NM,
       CASE WHEN X.G_CC_DEPT_C = X.PADM_STD_ORG_C THEN B.PADM_STD_ORGNM
            ELSE TRIM(REPLACE(X.ALL_ORGNM, C.ALL_ORGNM, ''))
        END ALL_ORGNM,
       X.MG_DT
FROM (
     WITH WT_DEPT_MNG AS (
          SELECT A.G_CC_DEPT_C
            FROM SFI_ORG_BY_DEPT_MNG A
            WHERE PADM_STD_ORG_C = '6280000'
              AND ('all' = 'all'  OR A.G_CC_DEPT_C = 'all')
            GROUP BY A.G_CC_DEPT_C
          ),

          WT_RPT_DEPT_RST AS (
          SELECT RAC.SL_GMGO_DEPT_C
            FROM RPT_JEONJA_ACNO_LIST RAC
            LEFT OUTER JOIN SFI_ORG_DEPT_C_MNG ODC
                 ON RAC.PADM_STD_ORG_C = ODC.PADM_STD_ORG_C

           WHERE ('6280000' = 'all'         OR RAC.PADM_STD_ORG_C = '6280000')
             AND RAC.BRNO = '-1'
             AND RAC.RPT_ID = 'all'
             AND ('all'      = 'all' OR RAC.RPT_AC_G = 'all')
           GROUP BY RAC.SL_GMGO_DEPT_C
          )

     SELECT ROWNUM AS R_NUM,
            A.*
       FROM (
            SELECT B.*
              FROM (
                   SELECT OBD.G_CC_DEPT_C,
                          OBD.G_CC_DEPT_NM,
                          OBD.PADM_STD_ORG_C,
                          OBD.DEL_YN,
                          POI.ALL_ORGNM,
                          POI.MG_DT,
                          CASE WHEN OBD.DEL_YN = 'Y' AND COUNT(ADM.SGG_ACNO) <= 0 THEN 0
                               ELSE 1 END AS FILTER_FLAG
                     FROM SFI_ORG_BY_DEPT_MNG OBD
                     LEFT OUTER JOIN RPT_JEONJA_AC_BY_DEPT_MNG ADM
                       ON ADM.HOIKYE_YEAR = '2025'
                      AND ADM.SL_GMGO_DEPT_C = OBD.G_CC_DEPT_C
                      AND ADM.USE_G IN ('1','2')
                      AND ADM.DEL_YN = 'N'
                     LEFT OUTER JOIN SFI_PADM_ORG_INF POI
                       ON OBD.G_CC_DEPT_C = POI.PADM_STD_ORG_C
                    WHERE OBD.PADM_STD_ORG_C = '6280000'
                      AND ('all' = 'all'        OR OBD.G_CC_DEPT_C = 'all')
                      AND ('all' = 'all'     OR REGEXP_LIKE(OBD.G_CC_DEPT_NM, 'all'))
                      AND ('all' = 'all'   OR OBD.G_CC_DEPT_C IN (SELECT G_CC_DEPT_C FROM WT_DEPT_MNG))
                      AND ('all' = 'all' OR OBD.G_CC_DEPT_C IN (SELECT SL_GMGO_DEPT_C FROM WT_RPT_DEPT_RST))
                    GROUP BY OBD.G_CC_DEPT_C, OBD.G_CC_DEPT_NM, OBD.PADM_STD_ORG_C, OBD.DEL_YN, POI.ALL_ORGNM, POI.MG_DT
                   UNION
                   SELECT AA.G_CC_DEPT_C,
                          AA.G_CC_DEPT_NM,
                          AA.PADM_STD_ORG_C,
                          AA.DEL_YN,
                          AA.ALL_ORGNM,
                          AA.MG_DT,
                          AA.FILTER_FLAG
                     FROM (
                          SELECT A.G_CC_DEPT_C,
                                 A.G_CC_DEPT_NM,
                                 A.PADM_STD_ORG_C,
                                 A.DEL_YN,
                                 C.ALL_ORGNM,
                                 C.MG_DT,
                                 1 AS FILTER_FLAG,
                                 COUNT(B.USER_ID) AS CNT
                            FROM SFI_ORG_BY_DEPT_MNG A,
                                 SFI_USER_INF B,
                                 SFI_PADM_ORG_INF C
                           WHERE A.DEL_YN = 'Y'
                             AND A.PADM_STD_ORG_C = '6280000'
                             AND ('all' = 'all'        OR A.G_CC_DEPT_C = 'all')
                             AND ('all' = 'all'     OR REGEXP_LIKE(A.G_CC_DEPT_NM, 'all'))
                             AND ('all' = 'all'   OR A.G_CC_DEPT_C IN (SELECT G_CC_DEPT_C FROM WT_DEPT_MNG))
                             AND ('all' = 'all' OR A.G_CC_DEPT_C IN (SELECT SL_GMGO_DEPT_C FROM WT_RPT_DEPT_RST))
                             AND A.PADM_STD_ORG_C = B.PADM_STD_ORG_C
                             AND A.G_CC_DEPT_C = B.SL_GMGO_DEPT_C
                             AND A.PADM_STD_ORG_C = C.PADM_STD_ORG_C
                           GROUP BY A.G_CC_DEPT_C, A.G_CC_DEPT_NM, A.PADM_STD_ORG_C, A.DEL_YN, C.ALL_ORGNM, C.MG_DT
                          )AA
                    WHERE AA.CNT > 0
                   ) B
             WHERE FILTER_FLAG = 1
             ORDER BY DEL_YN, G_CC_DEPT_C
            ) A
     ) X

INNER JOIN SFI_ORG_DEPT_C_MNG B
      ON X.PADM_STD_ORG_C = B.PADM_STD_ORG_C
INNER JOIN SFI_PADM_ORG_INF C
      ON X.PADM_STD_ORG_C = C.PADM_STD_ORG_C
WHERE R_NUM >= '0' AND R_NUM <= '2000'
ORDER BY R_NUM


SELECT * FROM SFI_USER_INF
WHERE 1=1
AND SL_GMGO_MODL_C = 'RPT'
AND PADM_STD_ORG_C = '6430000'



SELECT
  RNUM
 , SL_GMGO_MODL_C
 , USER_ID
 , USER_NM
 , DR_SER
 , MENU_ID
 , MENU_NM
 , SCR_ID
 , SCR_NM
 , DR_DTTM
 , DROKJA_ID
 , UPD_DTTM
 , MODR_ID
FROM  (
 SELECT
  ROWNUM AS RNUM
  , Z.SL_GMGO_MODL_C
  , Z.USER_ID
  , (SELECT MAX(B.USER_NM)  USER_NM
       FROM  SFI_USER_INF B
       WHERE Z.MODR_ID = B.USER_ID) AS USER_NM
  , Z.DR_SER
  , Z.MENU_ID
  ,B.MENU_NM
  , Z.SCR_ID
  , C.SCR_NM
  , Z.DR_DTTM
  , Z.DROKJA_ID
  , Z.UPD_DTTM
  , Z.MODR_ID
 FROM  SFI_SCR_LTST_HIS Z, RPT_MENU_INF B, SFI_SCR_INF C
 WHERE
   Z.SL_GMGO_MODL_C = 'RPT'
  AND ((SELECT MAX(A.USER_NM)
          FROM  SFI_USER_INF A
         WHERE Z.MODR_ID = A.USER_ID) LIKE '%'||''||'%'
       OR Z.USER_ID LIKE '%'||''||'%' )
  AND ((SELECT MAX(E.MENU_NM)
          FROM    SFI_MENU_INF E
         WHERE  E.SL_GMGO_MODL_C = 'RPT'
           AND Z.MENU_ID = E.MENU_ID) LIKE '%'||''||'%'
       OR Z.MENU_ID LIKE '%'||''||'%' )
  AND ((SELECT MAX(F.SCR_NM)
          FROM    SFI_SCR_INF F
         WHERE  F.SL_GMGO_MODL_C = 'RPT'
           AND Z.SCR_ID = F.SCR_ID) LIKE '%'||''||'%'
       OR Z.SCR_ID LIKE '%'||''||'%' )
  AND Z.DR_DTTM LIKE '%'||'20250106'||'%'
  AND Z.SL_GMGO_MODL_C = B.SL_GMGO_MODL_C
  AND Z.MENU_ID = B.MENU_ID
  AND Z.SL_GMGO_MODL_C = C.SL_GMGO_MODL_C
  AND Z.SCR_ID = C.SCR_ID
  AND ROWNUM <= 600
  ORDER BY UPD_DTTM DESC
) X
WHERE X.RNUM >= 101


