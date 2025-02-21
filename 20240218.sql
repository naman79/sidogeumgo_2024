SELECT
    A.UNYONG_GYEJWA
     ,'20250217' KIJUNIL
     ,SUM(CASE WHEN A.KIJUNIL = '20250217' THEN A.IPAMT ELSE 0 END) IPAMT
     ,SUM(CASE WHEN A.KIJUNIL = '20250217' THEN A.JIAMT ELSE 0 END) JIAMT
     ,SUM(A.IPAMT) NUGYE_IPAMT
     ,SUM(A.JIAMT) NUGYE_JIAMT
     ,SUM(CASE WHEN A.KIJUNIL = '20250217' THEN A.BFJAN ELSE 0 END) BFJAN
     ,SUM(CASE WHEN A.KIJUNIL = '20250217' THEN A.JANAEK ELSE 0 END) JANAEK
FROM RPT_UNYONG_JAN_GITA A
WHERE  A.KIJUNIL BETWEEN '20250101' AND '20250217'
  AND A.GEUMGO_CODE = 130


  AND A.UNYONG_GYEJWA IN (
    SELECT UNYONG_GYEJWA
    FROM RPT_UNYONG_JAN_GITA
    WHERE GEUMGO_CODE = '130'
      AND KIJUNIL = '20250217'
      AND HJI_DT IS NULL
)
GROUP BY A.UNYONG_GYEJWA
ORDER BY A.UNYONG_GYEJWA


------------------------------------

    select
        *
    FROM RPT_UNYONG_JAN_GITA A


-- 운용계좌정보가 없는데 운용잔 데이터가 적재되고 있는 이유 --

select *
from rpt_unyong_jan
where kijunil like '2025%'
  and unyong_gyejwa not in (
    select distinct unyong_gyejwa
    from rpt_unyong_gyejwa
)
  and unyong_gyejwa != '000000000000'
------------------------------------------
SELECT
    *
FROM RPT_UNYONG_GYEJWA
WHERE UNYONG_GYEJWA IN (
'200529108223',
'200682902398',
'200685555209',
'200613867077',
'200515110703',
'200509540880',
'200898589483',
'200911151822'
    )

----------------------------------------------
SELECT
    *
FROM RPT_UNYONG_JAN
WHERE UNYONG_GYEJWA = '200529108223'
ORDER BY KIJUNIL

------------------------------------------------

SELECT
    MAX(KIJUNIL) AS MAX_KIJUNIL,
    MIN(KIJUNIL) AS MIN_KIJUNIL,
    GONGGEUM_GYEJWA,
    UNYONG_GYEJWA,
    JANAEK,
    MKDT,
    DUDT,
    HJI_DT,
    BBK_BKKP_NM,
    PRDT_BKKP_NM,
    LST_TRXDT,
    IYUL,
    GEUMGO_CODE,
    IPAMT,
    JIAMT,
    JI_IJA
FROM RPT_UNYONG_JAN
WHERE KIJUNIL LIKE '2025%'
AND UNYONG_GYEJWA NOT IN (
    SELECT DISTINCT  UNYONG_GYEJWA
    FROM RPT_UNYONG_GYEJWA
    )
AND UNYONG_GYEJWA != '000000000000'
GROUP BY GONGGEUM_GYEJWA,
    UNYONG_GYEJWA,
    JANAEK,
    MKDT,
    DUDT,
    HJI_DT,
    BBK_BKKP_NM,
    PRDT_BKKP_NM,
    LST_TRXDT,
    IYUL,
    GEUMGO_CODE,
    IPAMT,
    JIAMT,
    JI_IJA

-----------------------------------------------


SELECT AA.KIJUNIL
     ,AA.GONGGEUM_GYEJWA
     ,AA.UNYONG_GYEJWA
     ,AA.JANAEK
     ,AA.MKDT
     ,AA.DUDT
     ,AA.HJI_DT
     ,AA.BBK_BKKP_NM
     ,AA.PRDT_BKKP_NM
     ,AA.LST_TRXDT
     ,AA.IYUL
     ,AA.GEUMGO_CODE
     ,AA.IPAMT
     ,AA.JIAMT
     ,AA.JI_IJA
FROM
    ( SELECT A.KIJUNIL
           ,B.GONGGEUM_GYEJWA
           ,B.UNYONG_GYEJWA
           ,B.JANAEK,B.MKDT
           ,B.DUDT,B.HJI_DT
           ,B.BBK_BKKP_NM
           ,B.PRDT_BKKP_NM
           ,B.LST_TRXDT
           ,B.IYUL
           ,B.GEUMGO_CODE
           ,B.IPAMT
           ,B.JIAMT
           ,B.JI_IJA
      FROM ( SELECT DISTINCT KIJUNIL
             FROM  RPT_UNYONG_JAN
             WHERE KIJUNIL >= '20080701'
               AND   KIJUNIL <   '20250218'
      ) A
         ,( SELECT KIJUNIL
                 ,GONGGEUM_GYEJWA
                 ,UNYONG_GYEJWA
                 ,JANAEK,MKDT
                 ,DUDT,HJI_DT
                 ,BBK_BKKP_NM
                 ,PRDT_BKKP_NM
                 ,LST_TRXDT
                 ,IYUL
                 ,GEUMGO_CODE
                 ,IPAMT
                 ,JIAMT
                 ,JI_IJA
            FROM RPT_UNYONG_JAN
            WHERE KIJUNIL = '20250218'
      ) B
      WHERE B.MKDT <= A.KIJUNIL
    ) AA
   ,(SELECT KIJUNIL
          ,GONGGEUM_GYEJWA
          ,UNYONG_GYEJWA
          ,JANAEK
          ,MKDT
          ,DUDT
          ,HJI_DT
          ,BBK_BKKP_NM
          ,PRDT_BKKP_NM
          ,LST_TRXDT,IYUL
     FROM RPT_UNYONG_JAN
     WHERE KIJUNIL >= '20080701'
       AND   KIJUNIL <   '20250218'
) BB
WHERE AA.KIJUNIL = BB.KIJUNIL(+)
  AND   AA.GONGGEUM_GYEJWA = BB.GONGGEUM_GYEJWA(+)
  AND   AA.UNYONG_GYEJWA   = BB.UNYONG_GYEJWA(+)
  AND   BB.KIJUNIL IS NULL