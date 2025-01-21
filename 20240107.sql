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

SELECT
    SIGUMGO_TRX_G,
    SIGUMGO_IP_TRX_G,
    SIGUMGO_JI_TRX_G,
    SUM(DECODE(IPJI_G, 2, -1, 1) * DECODE(CRT_CAN_G,1,-1,2,-1,33,-1,1) * TRAMT) AS AMT
FROM ACL_SIGUMGO_SLV
WHERE SIGUMGO_ORG_C = 150
AND FIL_100_CTNT5 = '15000080900000124'
GROUP BY SIGUMGO_TRX_G, SIGUMGO_IP_TRX_G, SIGUMGO_JI_TRX_G
ORDER BY SIGUMGO_TRX_G, SIGUMGO_IP_TRX_G, SIGUMGO_JI_TRX_G


select * from rpt_unyong_gyejwa
where gonggeum_gyejwa = '15000080900000124'
and hji_dt is null
order by mkdt desc


SELECT
     T1.HOIGYE_CODE
    ,T2.HOIKYE_NM AS HOIGYE_NAME
    ,(
      (
         (SUM(T1.SEIP_SUNAP_JIBGYE)
        + SUM(T1.SEIP_BAEJEONG_IP)
        + SUM(T1.IWOL_SUNAP))
       - ((SUM(T1.SEIP_SUNAP_JIBGYE)
       - SUM(T1.SEIP_SUIP_AMT))
        + SUM(T1.IWOL_MIICHE))
      ) - SUM(T1.SEIB_BANNAP)
      + (
         SUM(T1.SEIB_GYEONGJEONG_IB)
      - SUM(T1.SECHUL_GYEONGJEONG_IB)
        )
      - (
         SUM(T1.JAGEUM_BAEJEONG)
        - SUM(T1.JAGEUM_HWANSU)
        )
      - (
         SUM(T1.SECHUL_JIGEUB)
        - SUM(T1.SECHUL_BANHWAN)
        )
      + (
         SUM(T1.SECHUL_GYEONGJEONG_JI)
       - SUM(T1.SECHUL_GYEONGJEONG_IB)
        )
      - SUM(T1.JUN_IIB)
       - SUM(T1.JUN_IWOL)
     ) AS GONGGUEM
    ,(SUM(T1.YAEGEUM_SINGYU) + SUM(T1.IWOL_YAEGEUM)) - SUM(T1.HWANIP) AS JAGUEMUNYONG
    ,0 AS BIGO
    ,0 AS JUNBUGUEM
    ,0 AS MIJUNGSAN
    ,0 AS MMDA_MMF
FROM
     (
      SELECT
           TO_NUMBER(T2.SIGUMGO_HOIKYE_C) AS HOIGYE_CODE
          ,DECODE(T1.SIGUMGO_TRX_G, 11, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT, 0) AS SEIP_SUIP_AMT
          ,CASE
               WHEN T1.SIGUMGO_TRX_G IN (15, 16) THEN DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT
               ELSE 0
            END AS SEIP_BAEJEONG_IP
          ,DECODE(T1.SIGUMGO_TRX_G, 64, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT, 0) AS SEIB_BANNAP
          ,DECODE(T1.SIGUMGO_TRX_G, 19, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT, 0) AS SEIB_GYEONGJEONG_IB
          ,DECODE(T1.SIGUMGO_TRX_G, 69, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT, 0) AS SEIB_GYEONGJEONG_JI
          ,CASE
               WHEN T1.SIGUMGO_TRX_G = 61 AND T1.SIGUMGO_JI_TRX_G = 1 THEN DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT
               ELSE 0
            END AS JAGEUM_BAEJEONG
          ,CASE
               WHEN T1.SIGUMGO_TRX_G  = 14 AND T1.SIGUMGO_IP_TRX_G = 6 THEN DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT
               ELSE 0
            END AS JAGEUM_HWANSU
          ,DECODE(T1.SIGUMGO_TRX_G, 67, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT, 0) AS SECHUL_JIGEUB
          ,DECODE(T1.SIGUMGO_TRX_G, 17, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT, 0) AS SECHUL_BANHWAN
          ,DECODE(T1.SIGUMGO_TRX_G, 18, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT, 0) AS SECHUL_GYEONGJEONG_IB
          ,DECODE(T1.SIGUMGO_TRX_G, 65, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT, 0) AS SECHUL_GYEONGJEONG_JI
          ,CASE
               WHEN T1.SIGUMGO_TRX_G = 12 AND T1.SIGUMGO_IP_TRX_G = 4 THEN DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT
               ELSE 0
            END AS JUN_IIB
          ,CASE
               WHEN T1.SIGUMGO_TRX_G = 62 AND T1.SIGUMGO_JI_TRX_G = 4 THEN DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT
               ELSE 0
            END AS JUN_IWOL
          ,CASE
               WHEN T1.SIGUMGO_TRX_G = 62 AND T1.SIGUMGO_JI_TRX_G = 3 THEN DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT
               ELSE 0
            END AS YAEGEUM_SINGYU
          ,CASE
               WHEN T1.SIGUMGO_TRX_G = 12 AND T1.SIGUMGO_IP_TRX_G = 3 THEN DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT
               ELSE 0
            END AS HWANIP
          ,0 AS SEIP_SUNAP_JIBGYE
          ,0 AS IWOL_SUNAP
          ,0 AS IWOL_MIICHE
          ,0 AS IWOL_MMDA
          ,0 AS IWOL_YAEGEUM
      FROM
           ACL_SIGUMGO_SLV T1
          ,RPT_AC_BY_HOIKYE_MAPP T2
      WHERE 1=1
           AND T1.FIL_100_CTNT5 = T2.SIGUMGO_ACNO
           AND T1.SIGUMGO_ORG_C = T2.SIGUMGO_C
           AND T1.SIGUMGO_ORG_C = '150'
           AND T1.GJDT >= '20240101'
           AND T1.GJDT <= '20250107'
           AND DECODE(T1.SIGUMGO_HOIKYE_YR, '9999', SUBSTR(T1.GJDT, 1, 4), T1.SIGUMGO_HOIKYE_YR) = '2024'
 AND DECODE(NVL('', '99'), '99', 1, T2.SIGUMGO_HOIKYE_C) = DECODE(NVL('', '99'), '99', 1, '')
      UNION ALL
      SELECT
           T1.JIBGYE_CODE AS HOIGYE_CODE
          ,0 AS SEIP_SUIP_AMT
          ,0 AS SEIP_BAEJEONG_IP
          ,0 AS SEIB_BANNAP
          ,0 AS SEIB_GYEONGJEONG_IB
          ,0 AS SEIB_GYEONGJEONG_JI
          ,0 AS JAGEUM_BAEJEONG
          ,0 AS JAGEUM_HWANSU
          ,0 AS SECHUL_JIGEUB
          ,0 AS SECHUL_BANHWAN
          ,0 AS SECHUL_GYEONGJEONG_IB
          ,0 AS SECHUL_GYEONGJEONG_JI
          ,0 AS JUN_IIB
          ,0 AS JUN_IWOL
          ,0 AS YAEGEUM_SINGYU
          ,0 AS HWANIP
          ,T1.BONSE_AMT AS SEIP_SUNAP_JIBGYE
          ,0 AS IWOL_SUNAP
          ,0 AS IWOL_MIICHE
          ,0 AS IWOL_MMDA
          ,0 AS IWOL_YAEGEUM
      FROM
           RPT_SUNAP_JIBGYE T1
      WHERE 1=1
           AND T1.SUNAPIL >= '20240101'
           AND T1.SUNAPIL <= '20250107'
           AND T1.GEUMGO_CODE = '150'
           AND T1.HOIGYE_YEAR = '2024'
           AND T1.GEORAE_GUBUN <> 3
           AND T1.GUNGU_CODE = 0
AND DECODE(NVL('', '99'), '99', 1, T1.JIBGYE_CODE) = DECODE(NVL('', '99'), '99', 1, '')
      UNION ALL
      SELECT
           T1.HOIGYE_CODE
          ,0 AS SEIP_SUIP_AMT
          ,0 AS SEIP_BAEJEONG_IP
          ,0 AS SEIB_BANNAP
          ,0 AS SEIB_GYEONGJEONG_IB
          ,0 AS SEIB_GYEONGJEONG_JI
          ,0 AS JAGEUM_BAEJEONG
          ,0 AS JAGEUM_HWANSU
          ,0 AS SECHUL_JIGEUB
          ,0 AS SECHUL_BANHWAN
          ,0 AS SECHUL_GYEONGJEONG_IB
          ,0 AS SECHUL_GYEONGJEONG_JI
          ,0 AS JUN_IIB
          ,0 AS JUN_IWOL
          ,0 AS YAEGEUM_SINGYU
          ,0 AS HWANIP
          ,0 AS SEIP_SUNAP_JIBGYE
          ,DECODE(T1.GUBUN_CODE, 1, T1.AMT1, 0) AS IWOL_SUNAP
          ,DECODE(T1.GUBUN_CODE, 5, T1.AMT1, 0) AS IWOL_MIICHE
          ,DECODE(T1.GUBUN_CODE, 4, T1.AMT1, 0) AS IWOL_MMDA
          ,DECODE(T1.GUBUN_CODE, 2, T1.AMT1, 0) AS IWOL_YAEGEUM
      FROM
           RPT_HOIGYE_IWOL T1
      WHERE 1=1
           AND T1.KIJUNIL >= '20240101'
           AND T1.KIJUNIL <= '20250107'
           AND T1.GEUMGO_CODE = '150'
           AND T1.HOIGYE_YEAR = '2024' - 1
           AND T1.GUBUN_CODE IN (1, 2, 4, 5)
           AND T1.GUNGU_CODE = 0
     AND DECODE(NVL('', '99'), '99', 1, T1.HOIGYE_CODE) = DECODE(NVL('', '99'), '99', 1, '')
      UNION ALL
      SELECT
           TO_NUMBER(T1.SIGUMGO_HOIKYE_C) AS HOIGYE_CODE
          ,0 AS SEIP_SUIP_AMT
          ,0 AS SEIP_BAEJEONG_IP
          ,0 AS SEIB_BANNAP
          ,0 AS SEIB_GYEONGJEONG_IB
          ,0 AS SEIB_GYEONGJEONG_JI
          ,0 AS JAGEUM_BAEJEONG
          ,0 AS JAGEUM_HWANSU
          ,0 AS SECHUL_JIGEUB
          ,0 AS SECHUL_BANHWAN
          ,0 AS SECHUL_GYEONGJEONG_IB
          ,0 AS SECHUL_GYEONGJEONG_JI
          ,0 AS JUN_IIB
          ,0 AS JUN_IWOL
          ,0 AS YAEGEUM_SINGYU
          ,0 AS HWANIP
          ,0 AS SEIP_SUNAP_JIBGYE
          ,0 AS IWOL_SUNAP
          ,0 AS IWOL_MIICHE
          ,0 AS IWOL_MMDA
          ,0 AS IWOL_YAEGEUM
      FROM
           RPT_HOIKYE_CD T1
      WHERE 1=1
           AND T1.SIGUMGO_C = '150'
           AND T1.USE_YN = 'Y'
    AND DECODE(NVL('', '99'), '99', 1, T1.SIGUMGO_HOIKYE_C) = DECODE(NVL('', '99'), '99', 1, '')
     ) T1
    ,RPT_HOIKYE_CD T2
WHERE 1=1
     AND T1.HOIGYE_CODE = T2.SIGUMGO_HOIKYE_C
     AND T2.SIGUMGO_C = '150'
     AND T2.USE_YN = 'Y'
GROUP BY
     T1.HOIGYE_CODE
    ,T2.HOIKYE_NM
ORDER BY
     T1.HOIGYE_CODE
    ,T2.HOIKYE_NM


--------------------------------------------------------------

    ,DECODE(T1.SIGUMGO_TRX_G, 11, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT, 0) AS SEIP_SUIP_AMT
          ,CASE
               WHEN T1.SIGUMGO_TRX_G IN (15, 16) THEN DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT
               ELSE 0
            END AS SEIP_BAEJEONG_IP
          ,DECODE(T1.SIGUMGO_TRX_G, 64, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT, 0) AS SEIB_BANNAP
          ,DECODE(T1.SIGUMGO_TRX_G, 19, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT, 0) AS SEIB_GYEONGJEONG_IB
          ,DECODE(T1.SIGUMGO_TRX_G, 69, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT, 0) AS SEIB_GYEONGJEONG_JI
          ,CASE
               WHEN T1.SIGUMGO_TRX_G = 61 AND T1.SIGUMGO_JI_TRX_G = 1 THEN DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT
               ELSE 0
            END AS JAGEUM_BAEJEONG
          ,CASE
               WHEN T1.SIGUMGO_TRX_G  = 14 AND T1.SIGUMGO_IP_TRX_G = 6 THEN DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT
               ELSE 0
            END AS JAGEUM_HWANSU
          ,DECODE(T1.SIGUMGO_TRX_G, 67, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT, 0) AS SECHUL_JIGEUB
          ,DECODE(T1.SIGUMGO_TRX_G, 17, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT, 0) AS SECHUL_BANHWAN
          ,DECODE(T1.SIGUMGO_TRX_G, 18, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT, 0) AS SECHUL_GYEONGJEONG_IB
          ,DECODE(T1.SIGUMGO_TRX_G, 65, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT, 0) AS SECHUL_GYEONGJEONG_JI
          ,CASE
               WHEN T1.SIGUMGO_TRX_G = 12 AND T1.SIGUMGO_IP_TRX_G = 4 THEN DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT
               ELSE 0
            END AS JUN_IIB
          ,CASE
               WHEN T1.SIGUMGO_TRX_G = 62 AND T1.SIGUMGO_JI_TRX_G = 4 THEN DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT
               ELSE 0
            END AS JUN_IWOL
          ,CASE
               WHEN T1.SIGUMGO_TRX_G = 62 AND T1.SIGUMGO_JI_TRX_G = 3 THEN DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT
               ELSE 0
            END AS YAEGEUM_SINGYU
          ,CASE
               WHEN T1.SIGUMGO_TRX_G = 12 AND T1.SIGUMGO_IP_TRX_G = 3 THEN DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT
               ELSE 0
            END AS HWANIP

-------------------------------------------------------------

(
      (
         (SUM(T1.SEIP_SUNAP_JIBGYE)
        + SUM(T1.SEIP_BAEJEONG_IP)
        + SUM(T1.IWOL_SUNAP))
       - ((SUM(T1.SEIP_SUNAP_JIBGYE)
       - SUM(T1.SEIP_SUIP_AMT))
        + SUM(T1.IWOL_MIICHE))
      ) - SUM(T1.SEIB_BANNAP)
      + (
         SUM(T1.SEIB_GYEONGJEONG_IB)
      - SUM(T1.SECHUL_GYEONGJEONG_IB)
        )
      - (
         SUM(T1.JAGEUM_BAEJEONG)
        - SUM(T1.JAGEUM_HWANSU)
        )
      - (
         SUM(T1.SECHUL_JIGEUB)
        - SUM(T1.SECHUL_BANHWAN)
        )
      + (
         SUM(T1.SECHUL_GYEONGJEONG_JI)
       - SUM(T1.SECHUL_GYEONGJEONG_IB)
        )
      - SUM(T1.JUN_IIB)
       - SUM(T1.JUN_IWOL)
     ) AS GONGGUEM

-----------------------------------------------------------------

,(
      (

        + SUM(15,16)
        + SUM(IWOL_SUNAP))

       - SUM(11))
        + SUM(IWOL_MIICHE))
      ) - SUM(64)
      + (
         SUM(19)
      - SUM(69)
        )
      - (
         SUM(61-1)
        - SUM(14-6)
        )
      - (
         SUM(67)
        - SUM(17)
        )
      + (
         SUM(18)
       - SUM(65)
        )
      - SUM(12-4)
       - SUM(62-4)
     ) AS GONGGUEM

---------------------------------------------

           SELECT
                HOIGYE_CODE,
                SUM(SEIP_SUIP_AMT) AS SEIP_SUIP_AMT ,
                SUM(SEIP_BAEJEONG_IP) AS  SEIP_BAEJEONG_IP,
                SUM(SEIB_BANNAP) AS SEIB_BANNAP ,
                SUM(SEIB_GYEONGJEONG_IB) AS SEIB_GYEONGJEONG_IB ,
                SUM(SEIB_GYEONGJEONG_JI) ASSEIB_GYEONGJEONG_JI ,
                SUM(JAGEUM_BAEJEONG) AS JAGEUM_BAEJEONG ,
                SUM(JAGEUM_HWANSU) AS JAGEUM_HWANSU ,
                SUM(SECHUL_JIGEUB) AS SECHUL_JIGEUB ,
                SUM(SECHUL_BANHWAN) AS SECHUL_BANHWAN ,
                SUM(SECHUL_GYEONGJEONG_IB) AS SECHUL_GYEONGJEONG_IB ,
                SUM(SECHUL_GYEONGJEONG_JI) AS SECHUL_GYEONGJEONG_JI ,
                SUM(JUN_IIB) AS JUN_IIB ,
                SUM(JUN_IWOL) AS  JUN_IWOL,
                SUM(YAEGEUM_SINGYU) AS YAEGEUM_SINGYU ,
                SUM(HWANIP) AS  HWANIP,
                SUM(SEIP_SUNAP_JIBGYE) AS  SEIP_SUNAP_JIBGYE,
                SUM(IWOL_SUNAP) AS  IWOL_SUNAP,
                SUM(IWOL_MIICHE) AS  IWOL_MIICHE,
                SUM(IWOL_MMDA) AS  IWOL_MMDA,
                SUM(IWOL_YAEGEUM) AS IWOL_YAEGEUM
            FROM
                (
                SELECT
           TO_NUMBER(T2.SIGUMGO_HOIKYE_C) AS HOIGYE_CODE
          ,DECODE(T1.SIGUMGO_TRX_G, 11, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT, 0) AS SEIP_SUIP_AMT
          ,CASE
               WHEN T1.SIGUMGO_TRX_G IN (15, 16) THEN DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT
               ELSE 0
            END AS SEIP_BAEJEONG_IP
          ,DECODE(T1.SIGUMGO_TRX_G, 64, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT, 0) AS SEIB_BANNAP
          ,DECODE(T1.SIGUMGO_TRX_G, 19, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT, 0) AS SEIB_GYEONGJEONG_IB
          ,DECODE(T1.SIGUMGO_TRX_G, 69, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT, 0) AS SEIB_GYEONGJEONG_JI
          ,CASE
               WHEN T1.SIGUMGO_TRX_G = 61 AND T1.SIGUMGO_JI_TRX_G = 1 THEN DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT
               ELSE 0
            END AS JAGEUM_BAEJEONG
          ,CASE
               WHEN T1.SIGUMGO_TRX_G  = 14 AND T1.SIGUMGO_IP_TRX_G = 6 THEN DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT
               ELSE 0
            END AS JAGEUM_HWANSU
          ,DECODE(T1.SIGUMGO_TRX_G, 67, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT, 0) AS SECHUL_JIGEUB
          ,DECODE(T1.SIGUMGO_TRX_G, 17, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT, 0) AS SECHUL_BANHWAN
          ,DECODE(T1.SIGUMGO_TRX_G, 18, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT, 0) AS SECHUL_GYEONGJEONG_IB
          ,DECODE(T1.SIGUMGO_TRX_G, 65, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT, 0) AS SECHUL_GYEONGJEONG_JI
          ,CASE
               WHEN T1.SIGUMGO_TRX_G = 12 AND T1.SIGUMGO_IP_TRX_G = 4 THEN DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT
               ELSE 0
            END AS JUN_IIB
          ,CASE
               WHEN T1.SIGUMGO_TRX_G = 62 AND T1.SIGUMGO_JI_TRX_G = 4 THEN DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT
               ELSE 0
            END AS JUN_IWOL
          ,CASE
               WHEN T1.SIGUMGO_TRX_G = 62 AND T1.SIGUMGO_JI_TRX_G = 3 THEN DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT
               ELSE 0
            END AS YAEGEUM_SINGYU
          ,CASE
               WHEN T1.SIGUMGO_TRX_G = 12 AND T1.SIGUMGO_IP_TRX_G = 3 THEN DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT
               ELSE 0
            END AS HWANIP
          ,0 AS SEIP_SUNAP_JIBGYE
          ,0 AS IWOL_SUNAP
          ,0 AS IWOL_MIICHE
          ,0 AS IWOL_MMDA
          ,0 AS IWOL_YAEGEUM
      FROM
           ACL_SIGUMGO_SLV T1
          ,RPT_AC_BY_HOIKYE_MAPP T2
      WHERE 1=1
           AND T1.FIL_100_CTNT5 = T2.SIGUMGO_ACNO
           AND T1.SIGUMGO_ORG_C = T2.SIGUMGO_C
           AND T1.SIGUMGO_ORG_C = '150'
           AND T1.GJDT >= '20240101'
           AND T1.GJDT <= '20250107'
           AND DECODE(T1.SIGUMGO_HOIKYE_YR, '9999', SUBSTR(T1.GJDT, 1, 4), T1.SIGUMGO_HOIKYE_YR) = '2024'
 AND DECODE(NVL('', '99'), '99', 1, T2.SIGUMGO_HOIKYE_C) = DECODE(NVL('', '99'), '99', 1, '')
) A
            WHERE A.HOIGYE_CODE = 1
                GROUP BY A.HOIGYE_CODE

           -------------------------------------------------
           SELECT
               A.*
                  FROM  SFI_USER_INF A
        WHERE A.SL_GMGO_MODL_C = 'RPT'
ORDER BY UPD_DTTM D ESC


select * from rpt_employee
where JKW_NM = '임정택'

-- 24100889
