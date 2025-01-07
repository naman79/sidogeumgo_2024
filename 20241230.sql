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
SELECT *
FROM ACL_INCHICHE_CC
WHERE SIGUMGO_ICHE_KJ_DT IN (SELECT DT FROM MERGED_BIZDT)
  AND SIGUMGO_IP_REF_NO = '55291000670205'
  AND IPJI_G = 1


select * from ACL_INCHICHE_CC where SIGUMGO_ICHE_KJ_DT and dr_dttm like '20241227%'



-- 메뉴별 사용이력

SELECT A.RNUM
     , A.SL_GMGO_MODL_C                         /* 서울시금고모듈CODE */
     , A.USER_U_SPZ_C                           /* 사용자유형특화CODE */
     , A.SIGUMGO_C                        /* 금고CODE */
     , A.MENU_LEV                               /* MENU레벨           */
     , A.MENU_ID                                /* MENUID             */
     , A.MENU_NM                                /* MENU명             */
     , A.USE_YN                                 /* 사용여부           */
  FROM  (
        SELECT ROWNUM AS RNUM
             , X.SL_GMGO_MODL_C                 /* 서울시금고모듈CODE */
             , '000000'        AS USER_U_SPZ_C         /* 사용자유형특화CODE */
             , X.SIGUMGO_C                   /* 금고CODE */
             , X.MENU_ID                        /* MENUID             */
             , '['||X.MENU_LEV||'Lv] '||X.SORT_SNO||'. '||X.MENU_NM
               AS MENU_NM                       /* MENU명             */
             , NVL(X.USE_YN, 'N')
               AS USE_YN                        /* 사용여부           */
             , X.MENU_LEV                       /* MENU레벨           */
             , X.SORT_SNO                       /* 정렬순번           */
          FROM  (
                SELECT A.SL_GMGO_MODL_C         /* 서울시금고모듈CODE */
                     , A.MENU_ID                /* MENUID             */
                     , A.MENU_NM                /* MENU명             */
                     , A.SIGUMGO_C              /* 금고CODE */
                     , NVL(B.USE_YN, 'N') AS USE_YN
                                                /* 사용여부           */
                     , A.HRNK_MENU_ID           /* 상위MENUID         */
                     , A.MENU_LEV               /* MENU레벨           */
                     , TO_NUMBER(A.SORT_SNO) AS SORT_SNO /* 정렬순번  */
                  FROM  RPT_MENU_INF      A      /* 메뉴정보           */
                     , SFI_U_BY_MENU_HIS B      /* 유형별메뉴내역     */
                 WHERE A.SL_GMGO_MODL_C = 'RPT'
                   AND   ((CASE WHEN '28' = '0' THEN '28' ELSE A.SIGUMGO_C  END) =  '28' OR  A.SIGUMGO_C  IS NULL)
                   AND A.USE_YN          = 'Y'
                   AND A.SL_GMGO_MODL_C  = B.SL_GMGO_MODL_C(+)
                   AND A.MENU_ID         = B.MENU_ID(+)
                   AND B.USER_U_SPZ_C(+) = '000000'    /* 사용자유형특화CODE */

               ) X
       START WITH X.MENU_LEV = 0
       CONNECT BY PRIOR X.MENU_ID = X.HRNK_MENU_ID /* 메뉴ID = 상위메뉴ID */
       ORDER SIBLINGS BY X.HRNK_MENU_ID ASC, X.SORT_SNO ASC
       ) A
 WHERE A.RNUM >= 0 AND A.RNUM <= 500
 ORDER BY A.RNUM

------
select
    *
from RPT_MENU_INF
where SL_GMGO_MODL_C = 'RPT'

SELECT RANK() OVER(ORDER BY USER_U_SPZ_C) AS RNUM
             , SL_GMGO_MODL_C       /* 서울시금고모듈CODE */
             , USER_U_SPZ_C         /* 사용자유형특화CODE */
             , USER_U_SPZ_NM        /* 사용자유형특화명   */
          FROM  SFI_USER_U_COD       /* 사용자유형코드     */
         WHERE SL_GMGO_MODL_C = 'RPT'   /* 서울시금고모듈CODE */
--           AND USER_U_SPZ_G = 'U' /* 사용자유형특화구분 U:일반유형 */
           AND USE_YN = 'Y'
           AND (SUBSTR(NVL(USER_U_SPZ_C,'000000'),0,3)= '028' OR SUBSTR(NVL(USER_U_SPZ_C,'000000'),0,3)= '000')


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
  AND Z.DR_DTTM LIKE '%'||'20241230'||'%'
  AND Z.SL_GMGO_MODL_C = B.SL_GMGO_MODL_C
  AND Z.MENU_ID = B.MENU_ID
  AND Z.SL_GMGO_MODL_C = C.SL_GMGO_MODL_C
  AND Z.SCR_ID = C.SCR_ID
  AND ROWNUM <= 100
  ORDER BY UPD_DTTM DESC
) X
WHERE X.RNUM >= 0


select * from SFI_USER_INF A
where sl_gmgo_modl_c = 'RPT'
AND USER_ID = '1024033'


 , ( select USER_U_SPZ_NM from SFI_USER_U_COD where SL_GMGO_MODL_C = 'RPT' and USER_U_SPZ_C = B.USER_U_SPZ_C) as USER_U_SPZ_NM


--------------------------------------------------------------
-- 인천시 메뉴 사용빈도 조사: 사용자가 없는 경우에는 공무원으로 처러
-- 영업점 사용자의 경우 에는 아이디의 길이가 8자리인 경우만 조회


SELECT
    A.MENU_ID,
    A.MENU_NM,
    CASE WHEN SUM(MENU_USE_YN) = 0 THEN 'N' ELSE 'Y' END AS MENU_USE_YN,
    CASE WHEN SUM(UC_USE_YN) = 0 THEN 'N' ELSE 'Y' END AS UC_USE_YN,
    A.USER_U_C,
    ( select USER_U_SPZ_NM from SFI_USER_U_COD where SL_GMGO_MODL_C = 'RPT' and USER_U_SPZ_C = A.USER_U_C) as USER_U_SPZ_NM,
    SUM(A.CNT) AS CNT
FROM
(
SELECT
    A.MENU_ID,
    A.MENU_NM,
    A.MENU_USE_YN,
    0 AS UC_USE_YN,
    CASE WHEN A.USER_U_C IS NULL THEN '028120' ELSE A.USER_U_C END AS USER_U_C,
    SUM(A.CNT) AS CNT
FROM
(
SELECT Z.SL_GMGO_MODL_C
     , Z.USER_ID
     , CASE WHEN B.USE_YN = 'Y' THEN 1 ELSE 0 END AS MENU_USE_YN
     , (select user_u_c from SFI_USER_INF where sl_gmgo_modl_c = 'RPT' and user_id = Z.USER_ID) as USER_U_C
     , Z.MENU_ID
     , B.MENU_NM
     , count(*) as cnt
FROM SFI_SCR_LTST_HIS Z,
     RPT_MENU_INF B,
     SFI_SCR_INF C
WHERE Z.SL_GMGO_MODL_C = 'RPT'
  AND ((SELECT MAX(A.USER_NM)
        FROM SFI_USER_INF A
        WHERE Z.MODR_ID = A.USER_ID) LIKE '%' || '' || '%'
    OR Z.USER_ID LIKE '%' || '' || '%')
  AND ((SELECT MAX(E.MENU_NM)
        FROM SFI_MENU_INF E
        WHERE E.SL_GMGO_MODL_C = 'RPT'
          AND Z.MENU_ID = E.MENU_ID) LIKE '%' || '' || '%'
    OR Z.MENU_ID LIKE '%' || '' || '%')
  AND ((SELECT MAX(F.SCR_NM)
        FROM SFI_SCR_INF F
        WHERE F.SL_GMGO_MODL_C = 'RPT'
          AND Z.SCR_ID = F.SCR_ID) LIKE '%' || '' || '%'
    OR Z.SCR_ID LIKE '%' || '' || '%')
  AND Z.SL_GMGO_MODL_C = B.SL_GMGO_MODL_C
  AND Z.MENU_ID = B.MENU_ID
  AND Z.SL_GMGO_MODL_C = C.SL_GMGO_MODL_C
  AND Z.SCR_ID = C.SCR_ID
group by Z.SL_GMGO_MODL_C
       , Z.USER_ID
       , Z.MENU_ID
       , B.MENU_NM
       , B.USE_YN
) A
WHERE (
          (USER_U_C IN ('028010','028020', '000011') AND LENGTH(USER_ID) = 8)
         OR
          USER_U_C NOT IN ('028010','028020', '000011')
          )
AND USER_U_C NOT IN ('RPT000', 'RPT028')
AND (
        A.MENU_ID LIKE 'ICH%'
    OR
        A.MENU_ID LIKE 'RPT%'
          )

GROUP BY A.MENU_ID, A.MENU_NM, A.USER_U_C, A.MENU_USE_YN
UNION
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
    ) A
WHERE (
        A.MENU_ID LIKE 'ICH%'
    OR
        A.MENU_ID LIKE 'RPT%'
          )
AND A.USER_U_C NOT IN ('RPT000', 'RPT028')
GROUP BY A.MENU_ID, A.MENU_NM, A.USER_U_C
ORDER BY A.MENU_ID, A.USER_U_C

-- ICH030305M01

RPT060405M01	리포팅 히스토리 로그 조회

RPT060406M01	송수신 내역 조회

RPT060407M01	파일다운로드

RPT060410M01	데이터관리



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
    AND A.MENU_ID IN('RPT060405M01', 'RPT060406M01', 'RPT060407M01', 'RPT060410M01')
AND (
        A.MENU_ID LIKE 'ICH%'
    OR
        A.MENU_ID LIKE 'RPT%'
          )
-------------------------------------------------------------

SELECT
    A.MENU_ID,
    A.MENU_NM,
    CASE WHEN SUM(MENU_USE_YN) = 0 THEN 'N' ELSE 'Y' END AS MENU_USE_YN,
    CASE WHEN SUM(UC_USE_YN) = 0 THEN 'N' ELSE 'Y' END AS UC_USE_YN,
    A.USER_U_C,
    ( select USER_U_SPZ_NM from SFI_USER_U_COD where SL_GMGO_MODL_C = 'RPT' and USER_U_SPZ_C = A.USER_U_C) as USER_U_SPZ_NM,
    SUM(A.CNT) AS CNT
FROM
(
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
    ) A
WHERE (
        A.MENU_ID LIKE 'ICH%'
    OR
        A.MENU_ID LIKE 'RPT%'
          )
AND A.USER_U_C NOT IN ('RPT000', 'RPT028')
GROUP BY A.MENU_ID, A.MENU_NM, A.USER_U_C
ORDER BY A.MENU_ID, A.USER_U_C

----------------------------------------------------------------

SELECT Z.SL_GMGO_MODL_C
     , Z.USER_ID
     , (select user_u_c from SFI_USER_INF where sl_gmgo_modl_c = 'RPT' and user_id = Z.USER_ID) as USER_U_C
     , Z.MENU_ID
     , B.MENU_NM
     , count(*) as cnt
FROM SFI_SCR_LTST_HIS Z,
     RPT_MENU_INF B,
     SFI_SCR_INF C
WHERE Z.SL_GMGO_MODL_C = 'RPT'
  AND ((SELECT MAX(A.USER_NM)
        FROM SFI_USER_INF A
        WHERE Z.MODR_ID = A.USER_ID) LIKE '%' || '' || '%'
    OR Z.USER_ID LIKE '%' || '' || '%')
  AND ((SELECT MAX(E.MENU_NM)
        FROM SFI_MENU_INF E
        WHERE E.SL_GMGO_MODL_C = 'RPT'
          AND Z.MENU_ID = E.MENU_ID) LIKE '%' || '' || '%'
    OR Z.MENU_ID LIKE '%' || '' || '%')
  AND ((SELECT MAX(F.SCR_NM)
        FROM SFI_SCR_INF F
        WHERE F.SL_GMGO_MODL_C = 'RPT'
          AND Z.SCR_ID = F.SCR_ID) LIKE '%' || '' || '%'
    OR Z.SCR_ID LIKE '%' || '' || '%')
  AND Z.SL_GMGO_MODL_C = B.SL_GMGO_MODL_C
  AND Z.MENU_ID = B.MENU_ID
  AND Z.SL_GMGO_MODL_C = C.SL_GMGO_MODL_C
  AND Z.SCR_ID = C.SCR_ID
AND Z.MENU_ID = 'RPT060410M01'
group by Z.SL_GMGO_MODL_C
       , Z.USER_ID
       , Z.MENU_ID
       , B.MENU_NM