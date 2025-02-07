SELECT
    A.GYEJWA_NM,
    A.ACNO,
    A.ORDER_NUM,
    A.GUBUN_NM,
    COALESCE(SUM(JEONHANDO_BAEJEONG), 0) AS JEONHANDO_BAEJEONG,
    COALESCE(SUM(JEONHANDO_HWANSU), 0) AS JEONHANDO_HWANSU,
    COALESCE(SUM(DANGHANDO_BAEJEONG), 0) AS DANGHANDO_BAEJEONG,
    COALESCE(SUM(DANGHANDO_HWANSU), 0) AS DANGHANDO_HWANSU,
    COALESCE(SUM(JEONSECHUL_JICHUL), 0) AS JEONSECHUL_JICHUL,
    COALESCE(SUM(JEONSECHUL_BANNAB), 0) AS JEONSECHUL_BANNAB,
    COALESCE(SUM(DANGSECHUL_JICHUL), 0) AS DANGSECHUL_JICHUL,
    COALESCE(SUM(DANGSECHUL_BANNAB), 0) AS DANGSECHUL_BANNAB
FROM (
         WITH ACNO_LIST AS (
             /* 거래내역의 계좌 목록 추출 */
             SELECT FIL_100_CTNT2 AS ACNO , SIGUMGO_AC_NM AS GYEJWA_NM, SIGUMGO_AGE_AC_G AS AC_GUBUN FROM ACL_SIGUMGO_MAS
             WHERE 1=1
               AND SIGUMGO_ORG_C = '28'
               AND (ICH_SIGUMGO_GUN_GU_C = '0'
                 OR  ICH_SIGUMGO_GUN_GU_C = CASE WHEN '0' = 0 THEN '050' ELSE '0' END)
               AND ICH_SIGUMGO_HOIKYE_C = 1
               AND SIGUMGO_HOIKYE_YR = '2024'
               AND SIGUMGO_AGE_AC_G IN (1,2,3)
               AND MNG_NO = 1
             UNION
             SELECT FIL_100_CTNT2 AS ACNO , SIGUMGO_AC_NM AS GYEJWA_NM, SIGUMGO_AGE_AC_G AS AC_GUBUN FROM ACL_SIGUMGO_MAS
             WHERE SIGUMGO_ORG_C = '28'
               AND ICH_SIGUMGO_GUN_GU_C = '0'
               AND ICH_SIGUMGO_HOIKYE_C = 1
               AND SIGUMGO_HOIKYE_YR = '2024'
               AND SIGUMGO_AGE_AC_G IN (1,2,3)
               AND MNG_NO = 1
               AND (FIL_100_CTNT2 LIKE '028000012500141%' OR FIL_100_CTNT2 LIKE '028000012500142%' OR FIL_100_CTNT2 LIKE '028000012500149%')
         ), G_GUBUN AS (
             /* 거래내역 합산 (전일 및 당일) */
             SELECT
                 1 AS GUBUN,
                 1 AS H_GUBUN,
                 B.AC_GUBUN,
                 A.FIL_100_CTNT5 AS ACNO,
                 B.GYEJWA_NM AS GYEJWA_NM,
                 LPAD(A.SIGUMGO_TRX_G, 2, 0) || LPAD(A.SIGUMGO_IP_TRX_G, 2, 0) || LPAD(A.SIGUMGO_JI_TRX_G, 2, 0) AS TRX,
                 SUM(DECODE(A.CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(A.IPJI_G, 2, -1, 1) * A.TRAMT) AS TT
             FROM ACL_SIGUMGO_SLV A, ACNO_LIST B
             WHERE A.FIL_100_CTNT5 = B.ACNO
               AND A.SIGUMGO_TRX_G IN (67, 17)
               AND A.GJDT BETWEEN ('2024' || '0101') AND TO_CHAR(TO_DATE( '20241231' , 'YYYYMMDD') - 1, 'YYYYMMDD')
             GROUP BY A.FIL_100_CTNT5,  LPAD(A.SIGUMGO_TRX_G, 2, 0) || LPAD(A.SIGUMGO_IP_TRX_G, 2, 0) || LPAD(A.SIGUMGO_JI_TRX_G, 2, 0) , B.AC_GUBUN, B.GYEJWA_NM

             UNION ALL
             /* 거래내역 합산 (당일) */
             SELECT
                 2 GUBUN,
                 1 AS H_GUBUN,
                 B.AC_GUBUN,
                 A.FIL_100_CTNT5 AS ACNO,
                 B.GYEJWA_NM AS GYEJWA_NM,
                 LPAD(A.SIGUMGO_TRX_G, 2, 0) || LPAD(A.SIGUMGO_IP_TRX_G, 2, 0) || LPAD(A.SIGUMGO_JI_TRX_G, 2, 0) AS TRX,
                 SUM(DECODE(A.CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(A.IPJI_G, 2, -1, 1) * A.TRAMT) AS TT
             FROM ACL_SIGUMGO_SLV A, ACNO_LIST B
             WHERE A.FIL_100_CTNT5 = B.ACNO
               AND A.SIGUMGO_TRX_G IN (67, 17)
               AND A.GJDT = '20241231'
             GROUP BY A.FIL_100_CTNT5,  LPAD(A.SIGUMGO_TRX_G, 2, 0) || LPAD(A.SIGUMGO_IP_TRX_G, 2, 0) || LPAD(A.SIGUMGO_JI_TRX_G, 2, 0) ,  B.AC_GUBUN, B.GYEJWA_NM

             UNION ALL

             /* 한도 거래내역 합산 (전일) */
             SELECT
                 1 AS GUBUN,
                 2 as H_GUBUN,
                 B.AC_GUBUN,
                 A.SIGUMGO_ACNO AS ACNO,
                 B.GYEJWA_NM AS GYEJWA_NM,
                 TO_CHAR(A.SIGUMGO_TRX_G) AS TRX,
                 SUM(DECODE(A.CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(A.IPJI_G, 2, -1, 1) * A.TRAMT) AS TT
             FROM ACL_SGGHANDO_SLV A, ACNO_LIST B
             WHERE A.SIGUMGO_ACNO = B.ACNO
               AND GJDT BETWEEN ('2024' || '0101') AND TO_CHAR(TO_DATE( '20241231' , 'YYYYMMDD') - 1, 'YYYYMMDD')
             GROUP BY A.SIGUMGO_ACNO, TO_CHAR(A.SIGUMGO_TRX_G),  B.AC_GUBUN, B.GYEJWA_NM

             UNION ALL

             /* 한도 거래내역 합산 (당일) */
             SELECT
                 2 AS GUBUN,
                 2 as H_GUBUN,
                 B.AC_GUBUN,
                 A.SIGUMGO_ACNO AS ACNO,
                 B.GYEJWA_NM AS GYEJWA_NM,
                 TO_CHAR(A.SIGUMGO_TRX_G) AS TRX,
                 SUM(DECODE(A.CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(A.IPJI_G, 2, -1, 1) * A.TRAMT) AS TT
             FROM ACL_SGGHANDO_SLV A, ACNO_LIST B
             WHERE A.SIGUMGO_ACNO = B.ACNO
               AND A.GJDT = '20241231'
             GROUP BY A.SIGUMGO_ACNO, TO_CHAR(A.SIGUMGO_TRX_G), B.AC_GUBUN,  B.GYEJWA_NM
         )
         SELECT
             G_GUBUN.ACNO,
             G_GUBUN.AC_GUBUN,
             G_GUBUN.GYEJWA_NM AS GYEJWA_NM,
             CASE
                 WHEN G_GUBUN.H_GUBUN = 1 AND G_GUBUN.AC_GUBUN = 1 AND (G_GUBUN.TRX IN ('670090', '179000')) THEN 1
                 WHEN G_GUBUN.H_GUBUN = 1 AND G_GUBUN.AC_GUBUN = 1 AND (G_GUBUN.TRX IN ('670092', '179200', '670093', '179300')) THEN 2
                 WHEN G_GUBUN.H_GUBUN = 2 AND G_GUBUN.AC_GUBUN = 1 AND (G_GUBUN.TRX IN ('45', '91')) THEN 2
                 WHEN G_GUBUN.H_GUBUN = 1 AND G_GUBUN.AC_GUBUN = 1 AND (G_GUBUN.TRX IN ('670091', '179100')) THEN 3
                 WHEN G_GUBUN.H_GUBUN = 2 AND G_GUBUN.AC_GUBUN = 1 AND (G_GUBUN.TRX IN ('42', '90')) THEN 3
                 WHEN G_GUBUN.H_GUBUN = 1 AND G_GUBUN.AC_GUBUN = 2 AND (G_GUBUN.TRX IN ('670092', '179200')) THEN 2
                 WHEN G_GUBUN.H_GUBUN = 2 AND G_GUBUN.AC_GUBUN = 2 AND (G_GUBUN.TRX IN ('41', '95')) THEN 2
                 WHEN G_GUBUN.H_GUBUN = 1 AND G_GUBUN.AC_GUBUN = 2 AND (G_GUBUN.TRX IN ('670091', '179100')) THEN 3
                 WHEN G_GUBUN.H_GUBUN = 2 AND G_GUBUN.AC_GUBUN = 2 AND (G_GUBUN.TRX IN ('40', '92', '45', '91')) THEN 3
                 WHEN G_GUBUN.H_GUBUN = 1 AND G_GUBUN.AC_GUBUN = 3 AND (G_GUBUN.TRX IN ('670093', '179300')) THEN 2
                 WHEN G_GUBUN.H_GUBUN = 2 AND G_GUBUN.AC_GUBUN = 3 AND (G_GUBUN.TRX IN ('41', '95')) THEN 2
                 ELSE 9
                 END AS ORDER_NUM,
             CASE
                 WHEN G_GUBUN.H_GUBUN = 1 AND G_GUBUN.AC_GUBUN = 1 AND (G_GUBUN.TRX IN ('670090', '179000')) THEN '본청'
                 WHEN G_GUBUN.H_GUBUN = 1 AND G_GUBUN.AC_GUBUN = 1 AND (G_GUBUN.TRX IN ('670092', '179200', '670093', '179300')) THEN '본청(일상경비)'
                 WHEN G_GUBUN.H_GUBUN = 2 AND G_GUBUN.AC_GUBUN = 1 AND (G_GUBUN.TRX IN ('45', '91')) THEN '본청(일상경비)'
                 WHEN G_GUBUN.H_GUBUN = 1 AND G_GUBUN.AC_GUBUN = 1 AND (G_GUBUN.TRX IN ('670091', '179100')) THEN '본청외'
                 WHEN G_GUBUN.H_GUBUN = 2 AND G_GUBUN.AC_GUBUN = 1 AND (G_GUBUN.TRX IN ('42', '90')) THEN '본청외'
                 WHEN G_GUBUN.H_GUBUN = 1 AND G_GUBUN.AC_GUBUN = 2 AND (G_GUBUN.TRX IN ('670092', '179200')) THEN '본청(일상경비)'
                 WHEN G_GUBUN.H_GUBUN = 2 AND G_GUBUN.AC_GUBUN = 2 AND (G_GUBUN.TRX IN ('41', '95')) THEN '본청(일상경비)'
                 WHEN G_GUBUN.H_GUBUN = 1 AND G_GUBUN.AC_GUBUN = 2 AND (G_GUBUN.TRX IN ('670091', '179100')) THEN '본청외'
                 WHEN G_GUBUN.H_GUBUN = 2 AND G_GUBUN.AC_GUBUN = 2 AND (G_GUBUN.TRX IN ('40', '92', '45', '91')) THEN '본청외'
                 WHEN G_GUBUN.H_GUBUN = 1 AND G_GUBUN.AC_GUBUN = 3 AND (G_GUBUN.TRX IN ('670093', '179300')) THEN '본청(일상경비)'
                 WHEN G_GUBUN.H_GUBUN = 2 AND G_GUBUN.AC_GUBUN = 3 AND (G_GUBUN.TRX IN ('41', '95')) THEN '본청(일상경비)'
                 ELSE '기타'
                 END AS GUBUN_NM,
             CASE
                 WHEN G_GUBUN.GUBUN = 1 AND G_GUBUN.H_GUBUN = 2 AND G_GUBUN.AC_GUBUN = 1 AND (G_GUBUN.TRX IN ('90', '91')) THEN SUM(G_GUBUN.TT) * -1
                 WHEN G_GUBUN.GUBUN = 1 AND G_GUBUN.H_GUBUN = 2 AND G_GUBUN.AC_GUBUN = 2 AND (G_GUBUN.TRX IN ('40', '45','91','41')) THEN SUM(G_GUBUN.TT)
                 WHEN G_GUBUN.GUBUN = 1 AND G_GUBUN.H_GUBUN = 2 AND G_GUBUN.AC_GUBUN = 3 AND (G_GUBUN.TRX IN ('41')) THEN SUM(G_GUBUN.TT)
                 ELSE 0
                 END AS JEONHANDO_BAEJEONG,
             CASE
                 WHEN G_GUBUN.GUBUN = 1 AND G_GUBUN.H_GUBUN = 2 AND G_GUBUN.AC_GUBUN = 1 AND (G_GUBUN.TRX IN ('42', '45')) THEN SUM(G_GUBUN.TT)
                 WHEN G_GUBUN.GUBUN = 1 AND G_GUBUN.H_GUBUN = 2 AND G_GUBUN.AC_GUBUN = 2 AND (G_GUBUN.TRX IN ('92', '95')) THEN SUM(G_GUBUN.TT) * -1
                 WHEN G_GUBUN.GUBUN = 1 AND G_GUBUN.H_GUBUN = 2 AND G_GUBUN.AC_GUBUN = 3 AND (G_GUBUN.TRX IN ('95')) THEN SUM(G_GUBUN.TT) * -1
                 ELSE 0
                 END AS JEONHANDO_HWANSU,
             CASE
                 WHEN G_GUBUN.GUBUN = 2 AND G_GUBUN.H_GUBUN = 2 AND G_GUBUN.AC_GUBUN = 1 AND (G_GUBUN.TRX IN ('90', '91')) THEN SUM(G_GUBUN.TT) * -1
                 WHEN G_GUBUN.GUBUN = 2 AND G_GUBUN.H_GUBUN = 2 AND G_GUBUN.AC_GUBUN = 2 AND (G_GUBUN.TRX IN ('40', '45','91','41')) THEN SUM(G_GUBUN.TT)
                 WHEN G_GUBUN.GUBUN = 2 AND G_GUBUN.H_GUBUN = 2 AND G_GUBUN.AC_GUBUN = 3 AND (G_GUBUN.TRX IN ('41')) THEN SUM(G_GUBUN.TT)
                 ELSE 0
                 END AS DANGHANDO_BAEJEONG,
             CASE
                 WHEN G_GUBUN.GUBUN = 2 AND G_GUBUN.H_GUBUN = 2 AND G_GUBUN.AC_GUBUN = 1 AND (G_GUBUN.TRX IN ('42', '45')) THEN SUM(G_GUBUN.TT)
                 WHEN G_GUBUN.GUBUN = 2 AND G_GUBUN.H_GUBUN = 2 AND G_GUBUN.AC_GUBUN = 2 AND (G_GUBUN.TRX IN ('92', '95')) THEN SUM(G_GUBUN.TT) * -1
                 WHEN G_GUBUN.GUBUN = 2 AND G_GUBUN.H_GUBUN = 2 AND G_GUBUN.AC_GUBUN = 3 AND (G_GUBUN.TRX IN ('95')) THEN SUM(G_GUBUN.TT) * -1
                 ELSE 0
                 END AS DANGHANDO_HWANSU,
             CASE
                 WHEN G_GUBUN.GUBUN = 1 AND G_GUBUN.H_GUBUN = 1 AND (G_GUBUN.TRX IN ('670090', '670091', '670092', '670093')) THEN SUM(G_GUBUN.TT) * -1
                 ELSE 0
                 END AS JEONSECHUL_JICHUL,
             CASE
                 WHEN G_GUBUN.GUBUN = 1 AND G_GUBUN.H_GUBUN = 1 AND (G_GUBUN.TRX IN ('179000', '179100', '179200', '179300')) THEN SUM(G_GUBUN.TT)
                 ELSE 0
                 END AS JEONSECHUL_BANNAB,
             CASE
                 WHEN G_GUBUN.GUBUN = 2 AND G_GUBUN.H_GUBUN = 1 AND (G_GUBUN.TRX IN ('670090', '670091', '670092', '670093')) THEN SUM(G_GUBUN.TT) * -1
                 ELSE 0
                 END AS DANGSECHUL_JICHUL,
             CASE
                 WHEN G_GUBUN.GUBUN = 2 AND G_GUBUN.H_GUBUN = 1 AND (G_GUBUN.TRX IN ('179000', '179100', '179200', '179300')) THEN SUM(G_GUBUN.TT)
                 ELSE 0
                 END AS DANGSECHUL_BANNAB
         FROM G_GUBUN
         GROUP BY G_GUBUN.ACNO, G_GUBUN.AC_GUBUN, G_GUBUN.GYEJWA_NM , G_GUBUN.GUBUN, G_GUBUN.H_GUBUN, G_GUBUN.TRX
         UNION ALL
         SELECT
             ACNO,
             AC_GUBUN,
             GYEJWA_NM,
             1 AS ORDER_NUM,
             '본청' AS GUBUN_NM,
             0 AS JEONHANDO_BAEJEONG,
             0 AS JEONHANDO_HWANSU,
             0 AS DANGHANDO_BAEJEONG,
             0 AS DANGHANDO_HWANSU,
             0 AS JEONSECHUL_JICHUL,
             0 AS JEONSECHUL_BANNAB,
             0 AS DANGSECHUL_JICHUL,
             0 AS DANGSECHUL_BANNAB
         FROM ACNO_LIST

         UNION ALL
         SELECT
             ACNO,
             AC_GUBUN,
             GYEJWA_NM,
             2 AS ORDER_NUM,
             '본청(일상경비)' AS GUBUN_NM,
             0 AS JEONHANDO_BAEJEONG,
             0 AS JEONHANDO_HWANSU,
             0 AS DANGHANDO_BAEJEONG,
             0 AS DANGHANDO_HWANSU,
             0 AS JEONSECHUL_JICHUL,
             0 AS JEONSECHUL_BANNAB,
             0 AS DANGSECHUL_JICHUL,
             0 AS DANGSECHUL_BANNAB
         FROM ACNO_LIST

         UNION ALL
         SELECT
             ACNO,
             AC_GUBUN,
             GYEJWA_NM,
             3 AS ORDER_NUM,
             '본청외' AS GUBUN_NM,
             0 AS JEONHANDO_BAEJEONG,
             0 AS JEONHANDO_HWANSU,
             0 AS DANGHANDO_BAEJEONG,
             0 AS DANGHANDO_HWANSU,
             0 AS JEONSECHUL_JICHUL,
             0 AS JEONSECHUL_BANNAB,
             0 AS DANGSECHUL_JICHUL,
             0 AS DANGSECHUL_BANNAB
         FROM ACNO_LIST
     ) A
WHERE ORDER_NUM <> 9
GROUP BY A.GUBUN_NM, A.ORDER_NUM, A.ACNO, A.AC_GUBUN, A.GYEJWA_NM
ORDER BY A.ACNO, A.ORDER_NUM
