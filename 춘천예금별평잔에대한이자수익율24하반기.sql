
WITH GYEJWA AS (
  SELECT
      SIGUMGO_ORG_C AS GEUMGO_CODE,
      SIGUMGO_AC_NM AS GONGGEUM_GEYJWA_NM,
      SIGUMGO_HOIKYE_YR AS HOKYE_YR,
      FIL_100_CTNT2 AS GONGGEUM_GYEJWA,
      LINKAC_KWA_C || '000' || LINK_ACSER AS EFT_ACNO
  FROM ACL_SIGUMGO_MAS
  WHERE SIGUMGO_ORG_C = 110
  AND MNG_NO = 1
),
UNYONG AS (
    SELECT B.DW_BAS_DDT,
                       B.BIZ_DT,
                       A.GONGGEUM_GYEJWA,
                       A.UNYONG_GYEJWA,
                       A.JANAEK,
                       A.JI_IJA
                FROM RPT_UNYONG_JAN A,
                     MAP_JOB_DATE B
                WHERE A.GEUMGO_CODE = 110
                  AND B.DW_BAS_DDT BETWEEN '20240701' AND '20241231'
                  AND B.BIZ_DT = A.KIJUNIL

),
GONGGEUM AS (
    SELECT
        EFT_ACNO,
        TRAMT
    FROM ACL_SIGYUL_SLV
    WHERE TRXDT BETWEEN '20240701' AND '20241231'
),
DCNT AS (
    SELECT
        COUNT(*) AS CNT
    FROM MAP_JOB_DATE
    WHERE DW_BAS_DDT BETWEEN '20240701' AND '20241231'
),
GONGGEUM_JAN AS (
SELECT
    SUM(JANAEK) AS JAN
FROM (SELECT GONGGEUM_GYEJWA,
             JANAEK
      FROM RPT_GONGGEUM_JAN A
      WHERE A.GONGGEUM_GYEJWA IN (SELECT B.GONGGEUM_GYEJWA
                                  FROM GYEJWA B
                                  WHERE B.EFT_ACNO IN (SELECT C.EFT_ACNO
                                                       FROM GONGGEUM C))
        AND KEORAEIL BETWEEN '20240701' AND '20241231')
),
UNYONG_JAN AS (SELECT A.GUBUN_NM,
                      SUM(A.JANAEK) AS JANAEK,
                      SUM(A.IJA)    AS IJA
               FROM (SELECT GONGGEUM_GYEJWA,
                            UNYONG_GYEJWA,
                            SUBSTR(UNYONG_GYEJWA, 0, 3) AS GUBUN,
                            CASE
                                WHEN SUBSTR(UNYONG_GYEJWA, 0, 3) = 100 THEN 'BOTONG'
                                WHEN SUBSTR(UNYONG_GYEJWA, 0, 3) IN (200, 207) THEN 'JUCHUK'
                                WHEN SUBSTR(UNYONG_GYEJWA, 0, 3) = 140 THEN 'MMDA'
                                ELSE 'GONG' END         AS GUBUN_NM,
                            SUM(JANAEK)                 AS JANAEK,
                            SUM(JI_IJA)                 AS IJA
                     FROM UNYONG
                     GROUP BY GONGGEUM_GYEJWA, UNYONG_GYEJWA) A
               WHERE (A.JANAEK > 0 OR A.IJA > 0)
               GROUP BY A.GUBUN_NM
)
,
GONGGEUM_IJA AS (
                 SELECT SUM(A.TRAMT) AS IJA
                 FROM (SELECT *
                       FROM GONGGEUM A
                       WHERE A.EFT_ACNO IN (SELECT B.EFT_ACNO
                                            FROM GYEJWA B)) A

                 )
SELECT
    GUBUN,
    JAN,
    IJA,
    DAY_CNT,
    ROUND(JAN / DAY_CNT, 8) AS P_JAN,
    ROUND(IJA / ( JAN / DAY_CNT) * 100, 8) AS IYUL
FROM (SELECT 'GONG'           AS GUBUN,
             GONGGEUM_JAN.JAN AS JAN,
             GONGGEUM_IJA.IJA AS IJA,
             DCNT.CNT         AS DAY_CNT

      FROM GONGGEUM_JAN,
           GONGGEUM_IJA,
           DCNT
      UNION ALL
      SELECT GUBUN_NM AS GUBUN,
             JANAEK   AS JAN,
             IJA      AS IJA,
             DCNT.CNT AS DAY_CNT
      FROM UNYONG_JAN,
           DCNT
) A
