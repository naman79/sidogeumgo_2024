SELECT A.RNUM
     , (CASE
            WHEN  SUBSTR(TRIM(A.USER_U_C) ,4,1) = '0' THEN 'BANK'
            WHEN  SUBSTR(TRIM(A.USER_U_C) ,4,1) = '1' THEN 'SIGU'
    END) AS USER_GUBUN
     , A.SL_GMGO_MODL_C
     , A.USER_U_C
     , A.PADM_STD_ORG_C
     , (CASE
            WHEN  SUBSTR(TRIM(A.USER_U_C) ,4,1) = '0' THEN F.CMM_DTL_C_NM
            WHEN  SUBSTR(TRIM(A.USER_U_C) ,4,1) = '1' THEN E.PADM_STD_ORGNM
    END) AS PADM_STD_ORG_NM
     , A.SL_GMGO_DEPT_C
     , A.BR_C
     ,(CASE
           WHEN  SUBSTR(TRIM(A.USER_U_C) ,4,1) = '0' THEN A.BR_C
           WHEN  SUBSTR(TRIM(A.USER_U_C) ,4,1) = '1' THEN A.SL_GMGO_DEPT_C
    END) AS DEPT_C
     ,(CASE
           WHEN  SUBSTR(TRIM(A.USER_U_C) ,4,1) = '0' THEN C.HNG_BR_NM
           WHEN  SUBSTR(TRIM(A.USER_U_C) ,4,1) = '1' THEN DECODE(B.DEL_YN,'Y','(폐쇄)','')||B.G_CC_DEPT_NM
    END) AS DEPT_NM
     , A.USER_ID
     ,(CASE
           WHEN 'R' = 'R' THEN A.USER_NM
           WHEN 'R' = 'D' THEN SFIOWN.FUNC_CUS_INFO_CONV (A.USER_NM,'NAME')
    END) AS USER_NM
     , A.DISTG
     , A.USER_RIGHT_G
     , REPLACE(A.USER_TELNO, '-', '') AS USER_TELNO
     , A.USER_EMAIL
     , A.LST_LOGIN_DT
     , A.PSN_INF_JEGONG_YN
     , A.JKGP_NM
     , A.PSN_INF_BRWS_YN
     , A.USE_YN
     , A.UPD_DTTM
     , D.USER_NM AS MODR_ID
FROM
    (
        SELECT ROWNUM AS RNUM
             , A.*
        FROM
            (
                SELECT A.SL_GMGO_MODL_C
                     , A.USER_ID
                     , A.USER_NM
                     , A.DISTG
                     , A.USER_U_C
                     , A.USER_RIGHT_G
                     , A.PADM_STD_ORG_C
                     , A.SL_GMGO_DEPT_C
                     , A.BR_C
                     , A.USER_TELNO
                     , A.USER_EMAIL
                     , A.LST_LOGIN_DT
                     , A.PSN_INF_JEGONG_YN
                     , A.JKGP_NM
                     , A.PSN_INF_BRWS_YN
                     , A.USE_YN
                     , A.UPD_DTTM
                     , A.MODR_ID
                FROM  SFI_USER_INF A
                WHERE A.SL_GMGO_MODL_C = 'RPT'
                  AND (A.USER_ID LIKE '%'|| '' ||'%' OR A.USER_NM LIKE '%'|| '' ||'%')
                  AND ( NVL('','0') = '0' OR A.USER_U_C = '' )
                  AND ( NVL('', '0') = '0' OR A.PADM_STD_ORG_C = '' )
                  AND ( NVL('', '0') = '0' OR A.SL_GMGO_DEPT_C = '' )
                  AND ( NVL('', '0') = '0' OR A.BR_C = '' )
                  AND A.LST_LOGIN_DT BETWEEN '00000000' AND '99999999'
                  AND A.UPD_DTTM BETWEEN '00000000' AND '99999999' || '999999'
                  AND A.PADM_STD_ORG_C <> '0000000'
                ORDER BY A.USER_U_C, A.PADM_STD_ORG_C, A.SL_GMGO_DEPT_C, A.BR_C, A.USER_ID
            ) A
        WHERE ROWNUM <= 1100
    ) A
        LEFT OUTER JOIN SFI_ORG_BY_DEPT_MNG B
                        ON A.PADM_STD_ORG_C = B.PADM_STD_ORG_C
                            AND A.SL_GMGO_DEPT_C = B.G_CC_DEPT_C
        LEFT OUTER JOIN CST_JUM C
                        ON C.GRPCO_C = 'S001'
                            AND A.BR_C = C.BRNO
        LEFT OUTER JOIN SFI_USER_INF D
                        ON A.SL_GMGO_MODL_C = D.SL_GMGO_MODL_C
                            AND A.MODR_ID        = D.USER_ID
        LEFT OUTER JOIN SFI_ORG_DEPT_C_MNG E
                        ON A.PADM_STD_ORG_C = E.PADM_STD_ORG_C
        LEFT OUTER JOIN SFI_CMM_C_DAT F
                        ON REPLACE(A.PADM_STD_ORG_C, '088') = LPAD(F.CMM_DTL_C,4,'0')
                            AND F.CMM_C_NM = 'RPT시도금고코드'
                            AND F.USE_YN = 'Y'
WHERE A.RNUM >= 601
ORDER BY A.RNUM


SELECT
    *
FROM SFI_USER_INF
WHERE 1=1
AND SL_GMGO_MODL_C = 'RPT'
AND USER_NM LIKE '%한예지%'


SELECT
    *
FROM RPT_GONGGEUM_GYEWJA
WHERE GONGGEUM_GYEJWA = '15000080900003699'


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
                    A.SIGUMGO_ORG_C = 150
                  AND A.SIGUMGO_HOIKYE_YR IN ('2025','9999')
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
          AND (-1 = 79 OR Y.SIGUMGO_HOIKYE_C = 79)
    ) Z
WHERE
    Z.ROW_NUM >= 0
  AND Z.ROW_NUM <= 100


--------------------------------------

SELECT
    *
FROM RPT_AC_BY_HOIKYE_MAPP
WHERE SIGUMGO_C = 150
AND SIGUMGO_HOIKYE_C IN (79, 80)


SELECT
    SUM(JANAEK) AS JAN,
    TRUNC(SUM(JANAEK) / 366) AS P_JAN
FROM RPT_GONGGEUM_JAN
WHERE GONGGEUM_GYEJWA = '15000080900003699'
AND KEORAEIL LIKE '2024%'


-------------------------------------------------



SELECT
    T2.HOIGYE_CODE
     ,T2.GONGGEUM_GYEJWA
     ,T2.GONGGEUM_GYEJWA_NM
     ,NVL(TRUNC(SUM(T1.GONGGEUM)/MAX(T3.DAYS_CNT), 0), 0) AS GONGGEUM
     ,NVL(TRUNC(SUM(T1.UNYONG)/MAX(T3.DAYS_CNT), 0), 0) AS JUCHUK
     ,NVL(TRUNC(SUM(T1.MMDA)/MAX(T3.DAYS_CNT), 0), 0) AS MMDA
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
                  AND T1.GEUMGO_CODE = '150'
                  AND T1.GUNGU_CODE = 0
                  AND T2.DW_BAS_DDT >= '20240101'
                  AND T2.DW_BAS_DDT <= '20241231'
            ) T1
           ,ACL_SIGUMGO_MAS T2
           ,RPT_AC_BY_HOIKYE_MAPP T3
        WHERE 1=1
          AND T1.GONGGEUM_GYEJWA = T2.FIL_100_CTNT2
          AND T2.FIL_100_CTNT2 = T3.SIGUMGO_ACNO
          AND T2.SIGUMGO_HOIKYE_YR = T3.SIGUMGO_HOIKYE_YR
          AND T3.SIGUMGO_HOIKYE_C = 80
          AND T2.MNG_NO = 1
          AND (
                  CASE
                      WHEN T2.SIGUMGO_HOIKYE_YR = '9999' AND SUBSTR(T1.TRX_DT, 1, 4) = '2024'
                          THEN 1
                      WHEN T2.SIGUMGO_HOIKYE_YR = '2024'
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
                  WHEN '2024' > '2021'
                      THEN
                      CASE
                          WHEN T1.TRX_DT >= NVL(T2.KIJUNIL, '99991231') THEN 0
                          ELSE NVL(T1.JANAEK, 0)
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
                          WHEN T2.SIGUMGO_HOIKYE_YR = '2024' AND T1.GONGGEUM_GYEJWA <= T2.FIL_100_CTNT2
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
                                  AND T1.GEUMGO_CODE = '150'
                                  AND T2.DW_BAS_DDT >= '20240101'
                                  AND T2.DW_BAS_DDT <= '20241231'
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
                                          AND T1.SIGUMGO_ORG_C = '150'
                                          AND T1.SIGUMGO_HOIKYE_YR = '2024'
                                          AND T1.MNG_NO = 1
                                    ) T1
                                   ,RPT_HOIGYE_IWOL T2
                                WHERE 1=1
                                  AND T1.SIGUMGO_ORG_C = T2.GEUMGO_CODE
                                  AND T1.ICH_SIGUMGO_GUN_GU_C = T2.GUNGU_CODE
                                  AND T1.SIGUMGO_HOIKYE_YR = TO_CHAR(T2.HOIGYE_YEAR + 1)
                                  AND T2.KIJUNIL <= '20241231'
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
                              AND T1.SIGUMGO_ORG_C = '150'
                              AND T1.MNG_NO = 1
                            UNION
                            SELECT
                                T1.FIL_100_CTNT2 AS GONGGEUM_GYEJWA
                                 ,'19000101' AS KIJUNIL
                            FROM
                                ACL_SIGUMGO_MAS T1
                            WHERE 1=1
                              AND T1.SIGUMGO_ORG_C = '150'
                              AND T1.MNG_NO = 1
                              AND (
                                      CASE
                                          WHEN T1.SIGUMGO_HOIKYE_YR = '9999' AND SUBSTR('20241231', 1, 4) = '2024'
                                              THEN 1
                                          WHEN T1.SIGUMGO_HOIKYE_YR = '2024'
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
              AND '2024' > '2021'
              AND T1.HOIGYE_YEAR = '2024'
              AND T1.GEUMGO_CODE = '150'
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
                      AND T1.DW_BAS_DDT >= '20240101'
                      AND T1.DW_BAS_DDT <= '20241231'
                ) T3
                WHERE 1=1
                  AND T1.FIL_100_CTNT2 = T2.SIGUMGO_ACNO
                  AND T1.SIGUMGO_HOIKYE_YR = T2.SIGUMGO_HOIKYE_YR
                  AND T1.SIGUMGO_ORG_C = '150'
                  AND (
                          CASE
                              WHEN T1.SIGUMGO_HOIKYE_YR = '9999' AND SUBSTR(T3.TRX_DT, 1, 4) = '2024'
                                  THEN 1
                              WHEN T1.SIGUMGO_HOIKYE_YR = '2024'
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
                              AND T1.DW_BAS_DDT >= '20240101'
                              AND T1.DW_BAS_DDT <= '20241231'
                        ) T2
                        WHERE 1=1
                          AND T1.REF_L_C =50
                          AND T1.REF_M_C = '150'
                          AND T1.YUHYO_YN = 0
                    ) T1
                   ,RPT_UNYONG_GYEJWA T2
                WHERE 1=1
                  AND T1.GONGGEUM_GYEJWA = T2.GONGGEUM_GYEJWA
                  AND T1.TRX_DT >= SUBSTR(NVL(T2.MKDT,T2.IN_DATE),1,8)
                  AND T1.TRX_DT < NVL(T2.OUT_DATE, '99991231')
                  AND T1.TRX_DT < NVL(T2.HJI_DT, '99991231')
                  AND SUBSTR(T1.TRX_DT, 1, 4) = '2024'
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
    FROM
        ACL_SIGUMGO_MAS T1
       ,RPT_AC_BY_HOIKYE_MAPP T2
    WHERE 1=1
      AND T1.FIL_100_CTNT2 = T2.SIGUMGO_ACNO
      AND T1.SIGUMGO_HOIKYE_YR = T2.SIGUMGO_HOIKYE_YR
      AND T1.SIGUMGO_ORG_C = '150'
      AND T1.SIGUMGO_HOIKYE_YR IN ('2024', '9999')
      AND T1.MNG_NO = 1
    UNION ALL
    SELECT
        900+T1.REF_D_C AS HOIGYE_CODE
         ,T1.REF_D_NM AS GONGGEUM_GYEJWA
         ,T1.REF_CTNT1 AS GONGGEUM_GYEJWA_NM
         ,'9999' AS GONGGEUM_HOIGYE_YEAR
    FROM
        RPT_CODE_INFO T1
    WHERE 1=1
      AND '150' = 110
      AND T1.REF_L_C = 50
      AND T1.REF_M_C = '150'
) T2
   ,(
    SELECT
        COUNT(1) AS DAYS_CNT
    FROM
        MAP_JOB_DATE T1
    WHERE 1=1
      AND T1.DW_BAS_DDT >= '20240101'
      AND T1.DW_BAS_DDT <= '20241231'
) T3
WHERE 1=1
  AND T1.GONGGEUM_GYEJWA(+) = T2.GONGGEUM_GYEJWA
  AND DECODE('150', 439, T2.GONGGEUM_HOIGYE_YEAR, 440, T2.GONGGEUM_HOIGYE_YEAR, 1) = DECODE('150', 439, '2024', 440, '2024', 1)
  AND T2.HOIGYE_CODE  IN (

    '79'

    )

GROUP BY
    T2.HOIGYE_CODE
       ,T1.GONGGEUM_GYEJWA
       ,T2.GONGGEUM_GYEJWA
       ,T2.GONGGEUM_GYEJWA_NM
       ,T2.GONGGEUM_HOIGYE_YEAR
ORDER BY
    T2.HOIGYE_CODE
       ,T1.GONGGEUM_GYEJWA
       ,T2.GONGGEUM_GYEJWA
       ,T2.GONGGEUM_GYEJWA_NM
       ,T2.GONGGEUM_HOIGYE_YEAR

------------------------------------------------------------------------
-- 예금운용현황(예치기간별)

SELECT
    T1.GEUMGO_CODE
     ,T1.GONGGEUM_GUNGU_CODE
     ,T2.CMM_DTL_C_NM AS GEUMGO_NAME
     ,T3.CMM_DTL_C_NM AS GUNGU_NAME
     ,SUM(T1.PYUNG_JAN) AS HAPGYE
     ,SUM(DECODE(T1.GUBUN, 4, 0, T1.PYUNG_JAN)) AS JUNGI_HAPGYE
     ,MAX(DECODE(T1.GUBUN, 1, T1.PYUNG_JAN, 0)) AS JANG_PYUNG_JAN
     ,MAX(DECODE(T1.GUBUN, 1, T1.PYUNG_IYUL, 0)) AS JANG_PYUNG_IYUL
     ,MAX(DECODE(T1.GUBUN, 1, T1.MAX_IYUL, 0)) AS JANG_MAX_IYUL
     ,MAX(DECODE(T1.GUBUN, 1, T1.MIN_IYUL, 0)) AS JANG_MIN_IYUL
     ,MAX(DECODE(T1.GUBUN, 2, T1.PYUNG_JAN, 0)) AS JUNG_PYUNG_JAN
     ,MAX(DECODE(T1.GUBUN, 2, T1.PYUNG_IYUL, 0)) AS JUNG_PYUNG_IYUL
     ,MAX(DECODE(T1.GUBUN, 2, T1.MAX_IYUL, 0)) AS JUNG_MAX_IYUL
     ,MAX(DECODE(T1.GUBUN, 2, T1.MIN_IYUL, 0)) AS JUNG_MIN_IYUL
     ,MAX(DECODE(T1.GUBUN, 3, T1.PYUNG_JAN, 0)) AS DAN_PYUNG_JAN
     ,MAX(DECODE(T1.GUBUN, 3, T1.PYUNG_IYUL, 0)) AS DAN_PYUNG_IYUL
     ,MAX(DECODE(T1.GUBUN, 3, T1.MAX_IYUL, 0)) AS DAN_MAX_IYUL
     ,MAX(DECODE(T1.GUBUN, 3, T1.MIN_IYUL, 0)) AS DAN_MIN_IYUL
     ,MAX(DECODE(T1.GUBUN, 4, T1.PYUNG_JAN, 0)) AS ETC_PYUNG_JAN
     ,MAX(DECODE(T1.GUBUN, 4, T1.PYUNG_IYUL, 0)) AS ETC_PYUNG_IYUL
     ,MAX(DECODE(T1.GUBUN, 4, T1.MAX_IYUL, 0)) AS ETC_MAX_IYUL
     ,MAX(DECODE(T1.GUBUN, 4, T1.MIN_IYUL, 0)) AS ETC_MIN_IYUL
FROM
    (
        SELECT
            T1.GEUMGO_CODE
             ,T2.ICH_SIGUMGO_GUN_GU_C AS GONGGEUM_GUNGU_CODE
             ,CASE
                  WHEN ROUND(MONTHS_BETWEEN(TO_DATE(T1.DUDT, 'YYYYMMDD'), TO_DATE(T1.MKDT, 'YYYYMMDD'))) >= 6 THEN '1'
                  WHEN ROUND(MONTHS_BETWEEN(TO_DATE(T1.DUDT, 'YYYYMMDD'), TO_DATE(T1.MKDT, 'YYYYMMDD'))) >= 3
                      AND ROUND(MONTHS_BETWEEN(TO_DATE(T1.DUDT, 'YYYYMMDD'), TO_DATE(T1.MKDT, 'YYYYMMDD'))) < 6
                      THEN '2'
                  WHEN ROUND(MONTHS_BETWEEN(TO_DATE(T1.DUDT, 'YYYYMMDD'), TO_DATE(T1.MKDT, 'YYYYMMDD'))) >= 1
                      AND ROUND(MONTHS_BETWEEN(TO_DATE(T1.DUDT, 'YYYYMMDD'), TO_DATE(T1.MKDT, 'YYYYMMDD'))) < 3
                      THEN '3'
                  ELSE '4'
            END AS GUBUN
             ,ROUND(SUM(T1.JANAEK)/MAX(T2.JOB_DATE_CNT)) AS PYUNG_JAN
             ,ROUND(SUM(T1.JANAEK * T1.IYUL)/SUM(T1.JANAEK), 2) AS PYUNG_IYUL
             ,MAX(
                CASE
                    WHEN T1.GONGGEUM_GYEJWA LIKE '%99'
                        THEN (
                        SELECT
                            T3.IYUL
                        FROM
                            RPT_UNYONG_JAN T3
                        WHERE 1=1
                          AND T3.GEUMGO_CODE = T1.GEUMGO_CODE
                          AND T3.GONGGEUM_GYEJWA = T1.GONGGEUM_GYEJWA
                          AND T3.UNYONG_GYEJWA = T1.UNYONG_GYEJWA
                          AND T3.KIJUNIL IN (
                            SELECT
                                MAX(T4.KIJUNIL)
                            FROM
                                RPT_UNYONG_JAN T4
                            WHERE 1=1
                              AND T4.GEUMGO_CODE = T1.GEUMGO_CODE
                              AND T4.GONGGEUM_GYEJWA = T1.GONGGEUM_GYEJWA
                              AND T4.UNYONG_GYEJWA = T1.UNYONG_GYEJWA
                              AND T4.KIJUNIL < T4.DUDT
                              AND T4.KIJUNIL <= T1.KIJUNIL
                        )
                    )
                    ELSE (
                        SELECT
                            T3.IYUL
                        FROM
                            RPT_UNYONG_JAN T3
                        WHERE 1=1
                          AND T3.GEUMGO_CODE = T1.GEUMGO_CODE
                          AND T3.GONGGEUM_GYEJWA = T1.GONGGEUM_GYEJWA
                          AND T3.UNYONG_GYEJWA = T1.UNYONG_GYEJWA
                          AND T3.KIJUNIL = T3.MKDT
                    )
                    END
              ) AS MAX_IYUL
             ,MIN(
                CASE
                    WHEN T1.GONGGEUM_GYEJWA LIKE '%99'
                        THEN (
                        SELECT
                            T3.IYUL
                        FROM
                            RPT_UNYONG_JAN T3
                        WHERE 1=1
                          AND T3.GEUMGO_CODE = T1.GEUMGO_CODE
                          AND T3.GONGGEUM_GYEJWA = T1.GONGGEUM_GYEJWA
                          AND T3.UNYONG_GYEJWA = T1.UNYONG_GYEJWA
                          AND T3.KIJUNIL IN (
                            SELECT
                                MAX(T4.KIJUNIL)
                            FROM
                                RPT_UNYONG_JAN T4
                            WHERE 1=1
                              AND T4.GEUMGO_CODE = T1.GEUMGO_CODE
                              AND T4.GONGGEUM_GYEJWA = T1.GONGGEUM_GYEJWA
                              AND T4.UNYONG_GYEJWA = T1.UNYONG_GYEJWA
                              AND T4.KIJUNIL < T4.DUDT
                              AND T4.KIJUNIL <= T1.KIJUNIL
                        )
                    )
                    ELSE (
                        SELECT
                            T3.IYUL
                        FROM
                            RPT_UNYONG_JAN T3
                        WHERE 1=1
                          AND T3.GEUMGO_CODE = T1.GEUMGO_CODE
                          AND T3.GONGGEUM_GYEJWA = T1.GONGGEUM_GYEJWA
                          AND T3.UNYONG_GYEJWA = T1.UNYONG_GYEJWA
                          AND T3.KIJUNIL = T3.MKDT
                    )
                    END
              ) AS MIN_IYUL
        FROM
            RPT_UNYONG_JAN T1
           ,(
            SELECT
                T1.SIGUMGO_ORG_C
                 ,T1.ICH_SIGUMGO_GUN_GU_C
                 ,T1.GONGGEUM_GYEJWA
                 ,T1.UNYONG_GYEJWA
                 ,T1.MKDT
                 ,T1.HJI_DT
                 ,T1.OUT_DATE
                 ,T2.BIZ_DT
                 ,T2.DW_BAS_DDT
                 ,T2.JOB_DATE_CNT
            FROM
                (
                    SELECT
                        T1.SIGUMGO_ORG_C
                         ,T1.ICH_SIGUMGO_GUN_GU_C
                         ,T1.FIL_100_CTNT2 AS GONGGEUM_GYEJWA
                         ,T2.UNYONG_GYEJWA
                         ,T2.MKDT
                         ,T2.HJI_DT
                         ,T2.OUT_DATE
                    FROM
                        ACL_SIGUMGO_MAS T1
                       ,RPT_UNYONG_GYEJWA T2
                    WHERE 1=1
                      AND T1.SIGUMGO_ORG_C = T2.GEUMGO_CODE
                      AND T1.FIL_100_CTNT2 = T2.GONGGEUM_GYEJWA
                      AND T1.SIGUMGO_ORG_C = '150'
                      AND T1.MNG_NO = 1
                      AND (
                              CASE
                                  WHEN NVL(T2.HJI_DT, T2.OUT_DATE) IS NULL THEN 1
                                  ELSE DECODE(SIGN(T2.HJI_DT - '20241231'), 1, 1, 0)
                                  END
                              ) = 1
                      AND T2.MKDT <= '20241231'
                      AND T2.BANK_GUBUN = 0
                      AND T2.MKDT <> NVL(T2.HJI_DT,'99991231')
                    UNION
                    SELECT
                        T1.SIGUMGO_ORG_C
                         ,T1.ICH_SIGUMGO_GUN_GU_C
                         ,T1.FIL_100_CTNT2 AS GONGGEUM_GYEJWA
                         ,T2.UNYONG_GYEJWA
                         ,T2.MKDT
                         ,T2.HJI_DT
                         ,T2.OUT_DATE
                    FROM
                        ACL_SIGUMGO_MAS T1
                       ,RPT_UNYONG_GYEJWA T2
                    WHERE 1=1
                      AND T1.SIGUMGO_ORG_C = T2.GEUMGO_CODE
                      AND T1.FIL_100_CTNT2 = T2.GONGGEUM_GYEJWA
                      AND T1.SIGUMGO_ORG_C = '150'
                      AND T1.MNG_NO = 1
                      AND NVL(T2.HJI_DT, T2.OUT_DATE) >= '20240101'
                      AND NVL(T2.HJI_DT, T2.OUT_DATE) <= '20241231'
                ) T1
               ,(
                SELECT
                    DECODE(T1.DT_G, 0, T1.DW_BAS_DDT, T1.BF1_BIZ_DT) AS BIZ_DT
                     ,T1.DW_BAS_DDT
                     ,COUNT(1) OVER() AS JOB_DATE_CNT
                FROM
                    MAP_JOB_DATE T1
                WHERE 1=1
                  AND T1.DW_BAS_DDT >= '20240101'
                  AND T1.DW_BAS_DDT <= '20241231'
            ) T2
        ) T2
        WHERE 1=1
          AND T1.KIJUNIL = T2.BIZ_DT
          AND TRIM(T1.GONGGEUM_GYEJWA) = T2.GONGGEUM_GYEJWA
          AND T1.UNYONG_GYEJWA = T2.UNYONG_GYEJWA
          AND T1.GEUMGO_CODE = T2.SIGUMGO_ORG_C
          AND NVL(T1.HJI_DT, '99991231') >= T2.DW_BAS_DDT
          AND T1.JANAEK > 0
          AND T1.IYUL <> 0
        GROUP BY
            T1.GEUMGO_CODE
               ,T2.ICH_SIGUMGO_GUN_GU_C
               ,CASE
                    WHEN ROUND(MONTHS_BETWEEN(TO_DATE(T1.DUDT, 'YYYYMMDD'), TO_DATE(T1.MKDT, 'YYYYMMDD'))) >= 6 THEN '1'
                    WHEN ROUND(MONTHS_BETWEEN(TO_DATE(T1.DUDT, 'YYYYMMDD'), TO_DATE(T1.MKDT, 'YYYYMMDD'))) >= 3
                        AND ROUND(MONTHS_BETWEEN(TO_DATE(T1.DUDT, 'YYYYMMDD'), TO_DATE(T1.MKDT, 'YYYYMMDD'))) < 6
                        THEN '2'
                    WHEN ROUND(MONTHS_BETWEEN(TO_DATE(T1.DUDT, 'YYYYMMDD'), TO_DATE(T1.MKDT, 'YYYYMMDD'))) >= 1
                        AND ROUND(MONTHS_BETWEEN(TO_DATE(T1.DUDT, 'YYYYMMDD'), TO_DATE(T1.MKDT, 'YYYYMMDD'))) < 3
                        THEN '3'
                    ELSE '4'
            END
        UNION ALL
        SELECT
            TO_NUMBER(T1.CMM_DTL_C) AS GEUMGO_CODE
             ,TO_NUMBER(T2.CMM_DTL_C) AS GONGGEUM_GUNGU_CODE
             ,'4' AS GUBUN
             ,0 AS PYUNG_JAN
             ,0 AS PYUNG_IYUL
             ,0 AS MAX_IYUL
             ,0 AS MIN_IYUL
        FROM
            SFI_CMM_C_DAT T1
           ,SFI_CMM_C_DAT T2
        WHERE 1=1
          AND T1.CMM_DTL_C = T2.HRNK_CMM_DTL_C
          AND T1.CMM_C_NM = 'RPT시도금고코드'
          AND T1.CMM_DTL_C = '150'
          AND T2.CMM_C_NM = 'RPT군구코드'
    ) T1
   ,SFI_CMM_C_DAT T2
   ,SFI_CMM_C_DAT T3
WHERE 1=1
  AND T1.GEUMGO_CODE = T2.CMM_DTL_C
  AND T1.GONGGEUM_GUNGU_CODE = T3.CMM_DTL_C(+)
  AND T1.GEUMGO_CODE = T3.HRNK_CMM_DTL_C(+)
  AND T2.CMM_C_NM(+) = 'RPT시도금고코드'
  AND T2.USE_YN(+) = 'Y'
  AND T3.CMM_C_NM(+) = 'RPT군구코드'
  AND T3.USE_YN(+) = 'Y'
GROUP BY
    T1.GEUMGO_CODE
       ,T1.GONGGEUM_GUNGU_CODE
       ,T2.CMM_DTL_C_NM
       ,T3.CMM_DTL_C_NM
ORDER BY
    T1.GONGGEUM_GUNGU_CODE

-- 금고운용현황 예치기간별

SELECT
    T1000.GONGGEUM_GYEJWA_NO AS GYEJWA_NO
     , T1000.GONGGEUM_GYEJWA_NM AS GYEJWA_NM
     , ROUND(SUM(T1000.JANG_PYUNG_JAN / T2000.DCNT), 8) AS JANG_PYUNG_JAN
     , ROUND(SUM(T1000.JANG_GAJUNG_AMT) / SUM(T1000.JANG_PYUNG_JAN), 8) AS JANG_PYUNG_IYUL
     , MAX(T1000.JANG_MAX_IYUL) AS JANG_MAX_IYUL
     , MIN(T1000.JANG_MIN_IYUL) AS JANG_MIN_IYUL
     , ROUND(SUM(T1000.JUNG_PYUNG_JAN / T2000.DCNT), 8) AS JUNG_PYUNG_JAN
     , ROUND(SUM(T1000.JUNG_GAJUNG_AMT) / SUM(T1000.JUNG_PYUNG_JAN), 8) AS JUNG_PYUNG_IYUL
     , MAX(T1000.JUNG_MAX_IYUL) AS JUNG_MAX_IYUL
     , MIN(T1000.JUNG_MIN_IYUL) AS JUNG_MIN_IYUL
     , ROUND(SUM(T1000.DAN_PYUNG_JAN / T2000.DCNT), 8) AS DAN_PYUNG_JAN
     , ROUND(SUM(T1000.DAN_GAJUNG_AMT) / SUM(T1000.DAN_PYUNG_JAN), 8) AS DAN_PYUNG_IYUL
     , MAX(T1000.DAN_MAX_IYUL) AS DAN_MAX_IYUL
     , MIN(T1000.DAN_MIN_IYUL) AS DAN_MIN_IYUL
     , ROUND(SUM(T1000.ETC_PYUNG_JAN / T2000.DCNT), 8) AS ETC_PYUNG_JAN
     , ROUND(SUM(T1000.ETC_GAJUNG_AMT) / SUM(T1000.ETC_PYUNG_JAN), 8) AS ETC_PYUNG_IYUL
     , MAX(T1000.ETC_MAX_IYUL) AS ETC_MAX_IYUL
     , MIN(T1000.ETC_MIN_IYUL) AS ETC_MIN_IYUL
     , ROUND(SUM(T1000.JUCHUK_AMT / T2000.DCNT), 8) AS JUCHUK_AMT
     , ROUND(SUM(T1000.SUSI_AMT / T2000.DCNT), 8) AS SUSI_AMT
     , ROUND(SUM(T1000.JUCHUK_AMT / T2000.DCNT) + SUM(T1000.SUSI_AMT / T2000.DCNT), 8) AS HAPGYE
FROM (


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
         , SUM(T10.JANAEK) AS SUSI_AMT
    FROM (SELECT  /*+ INDEX(T1 RPT_GONGGEUM_JAN_IX_01) */
              T1.GONGGEUM_GYEJWA
               , SUM(T1.JANAEK) AS JANAEK
          FROM RPT_GONGGEUM_JAN T1
          WHERE T1.GEUMGO_CODE = 150
            AND T1.GUNGU_CODE = 0
            AND T1.KEORAEIL BETWEEN '20230101' AND '20231231'
            AND T1.JANAEK != 0
                                     AND T1.GONGGEUM_GYEJWA NOT IN ('04200080900003999')
          GROUP BY T1.GONGGEUM_GYEJWA
    ) T10
       , ACL_SIGUMGO_MAS T20
    WHERE 1 = 1
      AND T20.MNG_NO = 1
      AND T20.SIGUMGO_AGE_AC_G IN (0,1)
      AND T20.FIL_100_CTNT2(+) = T10.GONGGEUM_GYEJWA
    GROUP BY T20.SIGUMGO_ORG_C
           , T20.ICH_SIGUMGO_GUN_GU_C, T10.GONGGEUM_GYEJWA, T20.SIGUMGO_AC_NM


    UNION ALL


    SELECT NULL AS GEUMGO_CODE
         , NULL AS GUNGU_CODE
         , T100.GONGGEUM_GYEJWA AS GONGGEUM_GYEJWA_NO
         , T100.SIGUMGO_AC_NM AS GONGGEUM_GYEJWA_NM
         , SUM(DECODE(T100.GIGAN_GUBUN, '1', T100.JUCHUK_AMT)) AS JANG_PYUNG_JAN
         , SUM(DECODE(T100.GIGAN_GUBUN, '1', T100.JUCHUK_AMT * T200.IYUL)) AS JANG_GAJUNG_AMT
         , MAX(DECODE(T100.GIGAN_GUBUN, '1', DECODE(T200.IYUL, 0, NULL, T200.IYUL))) AS JANG_MAX_IYUL
         , MIN(DECODE(T100.GIGAN_GUBUN, '1', DECODE(T200.IYUL, 0, NULL, T200.IYUL))) AS JANG_MIN_IYUL
         , SUM(DECODE(T100.GIGAN_GUBUN, '2', T100.JUCHUK_AMT)) AS JUNG_PYUNG_JAN
         , SUM(DECODE(T100.GIGAN_GUBUN, '2', T100.JUCHUK_AMT * T200.IYUL)) AS JUNG_GAJUNG_AMT
         , MAX(DECODE(T100.GIGAN_GUBUN, '2', DECODE(T200.IYUL, 0, NULL, T200.IYUL))) AS JUNG_MAX_IYUL
         , MIN(DECODE(T100.GIGAN_GUBUN, '2', DECODE(T200.IYUL, 0, NULL, T200.IYUL))) AS JUNG_MIN_IYUL
         , SUM(DECODE(T100.GIGAN_GUBUN, '3', T100.JUCHUK_AMT)) AS DAN_PYUNG_JAN
         , SUM(DECODE(T100.GIGAN_GUBUN, '3', T100.JUCHUK_AMT * T200.IYUL)) AS DAN_GAJUNG_AMT
         , MAX(DECODE(T100.GIGAN_GUBUN, '3', DECODE(T200.IYUL, 0, NULL, T200.IYUL))) AS DAN_MAX_IYUL
         , MIN(DECODE(T100.GIGAN_GUBUN, '3', DECODE(T200.IYUL, 0, NULL, T200.IYUL))) AS DAN_MIN_IYUL
         , SUM(DECODE(T100.GIGAN_GUBUN, '4', T100.JUCHUK_AMT)) AS ETC_PYUNG_JAN
         , SUM(DECODE(T100.GIGAN_GUBUN, '4', T100.JUCHUK_AMT * T200.IYUL)) AS ETC_GAJUNG_AMT
         , MAX(DECODE(T100.GIGAN_GUBUN, '4', DECODE(T200.IYUL, 0, NULL, T200.IYUL))) AS ETC_MAX_IYUL
         , MIN(DECODE(T100.GIGAN_GUBUN, '4', DECODE(T200.IYUL, 0, NULL, T200.IYUL))) AS ETC_MIN_IYUL
         , SUM(T100.JUCHUK_AMT) AS JUCHUK_AMT
         , SUM(T100.SUSI_AMT) AS SUSI_AMT
    FROM (SELECT T10.GEUMGO_CODE
               , T10.GONGGEUM_GYEJWA
               , T20.SIGUMGO_AC_NM
               , T10.UNYONG_GYEJWA
               , T10.GIGAN_GUBUN
               , SUM(T10.JUCHUK_AMT) AS JUCHUK_AMT
               , SUM(T10.SUSI_AMT) AS SUSI_AMT
          FROM (SELECT /*+ LEADING(T1 T2 T3) INDEX(T2 RPT_UNYONG_JAN_UK_01) */
                    T2.GEUMGO_CODE
                     , T2.GONGGEUM_GYEJWA
                     , T2.UNYONG_GYEJWA
                     , CASE WHEN MONTHS_BETWEEN(TO_DATE(T2.DUDT, 'YYYYMMDD'), TO_DATE(T2.MKDT, 'YYYYMMDD')) >= 6 THEN '1'
                            WHEN MONTHS_BETWEEN(TO_DATE(T2.DUDT, 'YYYYMMDD'), TO_DATE(T2.MKDT, 'YYYYMMDD')) >= 3 THEN '2'
                            WHEN MONTHS_BETWEEN(TO_DATE(T2.DUDT, 'YYYYMMDD'), TO_DATE(T2.MKDT, 'YYYYMMDD')) >= 1 THEN '3'
                            ELSE '4'
                  END AS GIGAN_GUBUN
                     , CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) IN ('200', '207') THEN T2.JANAEK END AS JUCHUK_AMT
                     , CASE WHEN SUBSTR(T2.UNYONG_GYEJWA, 1, 3) IN ('100', '140') THEN T2.JANAEK END AS SUSI_AMT
                FROM MAP_JOB_DATE T1
                   , RPT_UNYONG_JAN T2
                   , RPT_UNYONG_GYEJWA T3
                WHERE 1 = 1
                  AND T1.DW_BAS_DDT BETWEEN '20230101' AND '20231231'
                  AND T2.KIJUNIL = CASE WHEN T1.DT_G IN (0) THEN T1.DW_BAS_DDT ELSE T1.BF1_BIZ_DT END
                  AND T2.GEUMGO_CODE = 150
                  AND SUBSTR(T2.GONGGEUM_GYEJWA, 4, 3) = LPAD('0', 3, '0')
                  AND T2.JANAEK != 0
                                             AND T2.GONGGEUM_GYEJWA NOT IN ('04200080900003999')
                                             AND T2.UNYONG_GYEJWA NOT IN ('000000000000')
                                             AND T3.GONGGEUM_GYEJWA(+) = T2.GONGGEUM_GYEJWA
                                             AND T3.UNYONG_GYEJWA(+) = T2.UNYONG_GYEJWA
                                             AND T3.BANK_GUBUN(+) = 0
                                             AND COALESCE(T3.MKDT, T3.IN_DATE, '00010101') != COALESCE(T3.HJI_DT, '99991231')
                                             AND COALESCE(T3.MKDT, T3.IN_DATE, '00010101') <= T1.DW_BAS_DDT
                                             AND COALESCE(T3.HJI_DT, T3.OUT_DATE, '99991231') > T1.DW_BAS_DDT
          ) T10
             , ACL_SIGUMGO_MAS T20
          WHERE 1 = 1
            AND T20.MNG_NO = 1
            AND T20.SIGUMGO_AGE_AC_G IN (0,1)
            AND T20.FIL_100_CTNT2(+) = T10.GONGGEUM_GYEJWA
          GROUP BY T10.GEUMGO_CODE
                 , T10.GONGGEUM_GYEJWA
                 , T20.SIGUMGO_AC_NM
                 , T10.UNYONG_GYEJWA
                 , T10.GIGAN_GUBUN
    ) T100
       , (SELECT T10.GEUMGO_CODE
               , T10.GONGGEUM_GYEJWA
               , T10.UNYONG_GYEJWA
               , CASE WHEN T10.GONGGEUM_GYEJWA LIKE '%99'
                          THEN (SELECT IYUL
                                FROM RPT_UNYONG_JAN
                                WHERE GEUMGO_CODE = T10.GEUMGO_CODE
                                  AND GONGGEUM_GYEJWA = T10.GONGGEUM_GYEJWA
                                  AND UNYONG_GYEJWA = T10.UNYONG_GYEJWA
                                  AND KIJUNIL = T10.MAX_KIJUNIL)
                      ELSE (SELECT IYUL
                            FROM RPT_UNYONG_JAN
                            WHERE GEUMGO_CODE = T10.GEUMGO_CODE
                              AND GONGGEUM_GYEJWA = T10.GONGGEUM_GYEJWA
                              AND UNYONG_GYEJWA = T10.UNYONG_GYEJWA
                              AND KIJUNIL = MKDT)
            END AS IYUL
          FROM (SELECT /*+ LEADING(T1 T2 T3) INDEX(T2 RPT_UNYONG_JAN_UK_01) */
                    T2.GEUMGO_CODE
                     , T2.GONGGEUM_GYEJWA
                     , T2.UNYONG_GYEJWA
                     , MIN(T2.KIJUNIL) AS MAX_KIJUNIL
                FROM MAP_JOB_DATE T1
                   , RPT_UNYONG_JAN T2
                   , RPT_UNYONG_GYEJWA T3
                WHERE 1 = 1
                  AND T1.DW_BAS_DDT BETWEEN '20230101' AND '20231231'
                  AND T2.KIJUNIL = CASE WHEN T1.DT_G IN (0) THEN T1.DW_BAS_DDT ELSE T1.BF1_BIZ_DT END
                  AND T2.GEUMGO_CODE = 150
                  AND SUBSTR(T2.GONGGEUM_GYEJWA, 4, 3) = LPAD('0', 3, '0')
                  AND T2.GONGGEUM_GYEJWA NOT IN ('04200080900003999')
                  AND T2.UNYONG_GYEJWA NOT IN ('000000000000')
                  AND T3.GONGGEUM_GYEJWA(+) = T2.GONGGEUM_GYEJWA
                  AND T3.UNYONG_GYEJWA(+) = T2.UNYONG_GYEJWA
                  AND T3.BANK_GUBUN(+) = 0
                  AND COALESCE(T3.MKDT, T3.IN_DATE, '00010101') != COALESCE(T3.HJI_DT, '99991231')
                                             AND COALESCE(T3.MKDT, T3.IN_DATE, '00010101') <= T1.DW_BAS_DDT
                                             AND COALESCE(T3.HJI_DT, T3.OUT_DATE, '99991231') > T1.DW_BAS_DDT
                GROUP BY T2.GEUMGO_CODE
                        , T2.GONGGEUM_GYEJWA
                        , T2.UNYONG_GYEJWA
               ) T10
          WHERE 1 = 1
    ) T200
    WHERE 1 = 1
      AND T200.GONGGEUM_GYEJWA(+) = T100.GONGGEUM_GYEJWA
      AND T200.UNYONG_GYEJWA(+) = T100.UNYONG_GYEJWA
    GROUP BY T100.GONGGEUM_GYEJWA, T100.SIGUMGO_AC_NM


    UNION ALL


    SELECT /*+ LEADING(T1 T2 T3) INDEX(T2 RPT_UNYONG_JAN_UK_01) */
        NULL AS GEUMGO_CODE
         , NULL AS GUNGU_CODE
         , T2.GONGGEUM_GYEJWA AS GONGGEUM_GYEJWA_NO
         , T3.SIGUMGO_AC_NM AS GONGGEUM_GYEJWA_NM
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
         , SUM(T2.JANAEK) AS SUSI_AMT
    FROM MAP_JOB_DATE T1
       , RPT_UNYONG_JAN T2
       , ACL_SIGUMGO_MAS T3
    WHERE T1.DW_BAS_DDT BETWEEN '20230101' AND '20231231'
      AND T2.KIJUNIL = CASE WHEN T1.DT_G IN (0) THEN T1.DW_BAS_DDT ELSE T1.BF1_BIZ_DT END
      AND T2.GEUMGO_CODE = 150
      AND SUBSTR(T2.GONGGEUM_GYEJWA, 4, 3) = LPAD('0', 3, '0')
      AND T2.GONGGEUM_GYEJWA NOT IN ('04200080900003999')
      AND T2.UNYONG_GYEJWA IN ('000000000000')
      AND T3.MNG_NO = 1
      AND T3.SIGUMGO_AGE_AC_G IN (0,1)
      AND T3.FIL_100_CTNT2(+) = T2.GONGGEUM_GYEJWA
    GROUP BY T2.GONGGEUM_GYEJWA, T3.SIGUMGO_AC_NM


    UNION ALL


    SELECT NULL AS GEUMGO_CODE
         , NULL AS GUNGU_CODE
         , T100.GONGGEUM_GYEJWA AS GONGGEUM_GYEJWA_NO
         , T300.SIGUMGO_AC_NM AS GONGGEUM_GYEJWA_NM
         , SUM(DECODE(T100.GIGAN_GUBUN, '1', T100.JUCHUK_AMT)) AS JANG_PYUNG_JAN
         , SUM(DECODE(T100.GIGAN_GUBUN, '1', T100.JUCHUK_AMT * T200.IYUL)) AS JANG_GAJUNG_AMT
         , MAX(DECODE(T100.GIGAN_GUBUN, '1', DECODE(T200.IYUL, 0, NULL, T200.IYUL))) AS JANG_MAX_IYUL
         , MIN(DECODE(T100.GIGAN_GUBUN, '1', DECODE(T200.IYUL, 0, NULL, T200.IYUL))) AS JANG_MIN_IYUL
         , SUM(DECODE(T100.GIGAN_GUBUN, '2', T100.JUCHUK_AMT)) AS JUNG_PYUNG_JAN
         , SUM(DECODE(T100.GIGAN_GUBUN, '2', T100.JUCHUK_AMT * T200.IYUL)) AS JUNG_GAJUNG_AMT
         , MAX(DECODE(T100.GIGAN_GUBUN, '2', DECODE(T200.IYUL, 0, NULL, T200.IYUL))) AS JUNG_MAX_IYUL
         , MIN(DECODE(T100.GIGAN_GUBUN, '2', DECODE(T200.IYUL, 0, NULL, T200.IYUL))) AS JUNG_MIN_IYUL
         , SUM(DECODE(T100.GIGAN_GUBUN, '3', T100.JUCHUK_AMT)) AS DAN_PYUNG_JAN
         , SUM(DECODE(T100.GIGAN_GUBUN, '3', T100.JUCHUK_AMT * T200.IYUL)) AS DAN_GAJUNG_AMT
         , MAX(DECODE(T100.GIGAN_GUBUN, '3', DECODE(T200.IYUL, 0, NULL, T200.IYUL))) AS DAN_MAX_IYUL
         , MIN(DECODE(T100.GIGAN_GUBUN, '3', DECODE(T200.IYUL, 0, NULL, T200.IYUL))) AS DAN_MIN_IYUL
         , SUM(DECODE(T100.GIGAN_GUBUN, '4', T100.JUCHUK_AMT)) AS ETC_PYUNG_JAN
         , SUM(DECODE(T100.GIGAN_GUBUN, '4', T100.JUCHUK_AMT * T200.IYUL)) AS ETC_GAJUNG_AMT
         , MAX(DECODE(T100.GIGAN_GUBUN, '4', DECODE(T200.IYUL, 0, NULL, T200.IYUL))) AS ETC_MAX_IYUL
         , MIN(DECODE(T100.GIGAN_GUBUN, '4', DECODE(T200.IYUL, 0, NULL, T200.IYUL))) AS ETC_MIN_IYUL
         , SUM(T100.JUCHUK_AMT) AS JUCHUK_AMT
         , NULL AS SUSI_AMT
    FROM (SELECT T10.GEUMGO_CODE
               , T10.GONGGEUM_GYEJWA
               , T10.UNYONG_GYEJWA
               , T10.GIGAN_GUBUN
               , SUM(T10.JUCHUK_AMT) AS JUCHUK_AMT
          FROM (SELECT /*+ LEADING(T1 T2 T3) INDEX(T2 RPT_UNYONG_JAN_UK_01) */
                    T2.GEUMGO_CODE
                     , T2.GONGGEUM_GYEJWA
                     , T2.UNYONG_GYEJWA
                     , CASE WHEN MONTHS_BETWEEN(TO_DATE(T2.DUDT, 'YYYYMMDD'), TO_DATE(T2.MKDT, 'YYYYMMDD')) >= 6 THEN '1'
                            WHEN MONTHS_BETWEEN(TO_DATE(T2.DUDT, 'YYYYMMDD'), TO_DATE(T2.MKDT, 'YYYYMMDD')) >= 3 THEN '2'
                            WHEN MONTHS_BETWEEN(TO_DATE(T2.DUDT, 'YYYYMMDD'), TO_DATE(T2.MKDT, 'YYYYMMDD')) >= 1 THEN '3'
                            ELSE '4'
                  END AS GIGAN_GUBUN
                     , T2.JANAEK AS JUCHUK_AMT
                FROM MAP_JOB_DATE T1
                   , RPT_UNYONG_JAN T2
                   , RPT_UNYONG_GYEJWA T3
                   , RPT_CODE_INFO T4
                WHERE 1 = 1
                  AND T1.DW_BAS_DDT BETWEEN '20230101' AND '20231231'
                  AND T2.KIJUNIL = CASE WHEN T1.DT_G IN (0) THEN T1.DW_BAS_DDT ELSE T1.BF1_BIZ_DT END
                  AND T2.GEUMGO_CODE = 150
                  AND SUBSTR(T2.GONGGEUM_GYEJWA, 4, 3) = LPAD('0', 3, '0')
                  AND T3.GONGGEUM_GYEJWA(+) = T2.GONGGEUM_GYEJWA
                  AND T3.UNYONG_GYEJWA(+) = T2.UNYONG_GYEJWA
                  AND T3.BANK_GUBUN(+) = 0
                  AND COALESCE(T3.MKDT, T3.IN_DATE, '00010101') != COALESCE(T3.HJI_DT, '99991231')
                                             AND COALESCE(T3.MKDT, T3.IN_DATE, '00010101') <= T1.DW_BAS_DDT
                                             AND COALESCE(T3.HJI_DT, T3.OUT_DATE, '99991231') > T1.DW_BAS_DDT
                                             AND T4.REF_L_C = 50
                                             AND T4.REF_M_C = 150
                                             AND T4.YUHYO_YN = 0
                                             AND T4.REF_D_NM = T3.GONGGEUM_GYEJWA

               ) T10
          WHERE 1 = 1
          GROUP BY T10.GEUMGO_CODE
                 , T10.GONGGEUM_GYEJWA
                 , T10.UNYONG_GYEJWA
                 , T10.GIGAN_GUBUN
    ) T100
       , (SELECT T10.GEUMGO_CODE
               , T10.GONGGEUM_GYEJWA
               , T10.UNYONG_GYEJWA
               , CASE WHEN T10.GONGGEUM_GYEJWA LIKE '%99'
                          THEN (SELECT IYUL
                                FROM RPT_UNYONG_JAN
                                WHERE GEUMGO_CODE = T10.GEUMGO_CODE
                                  AND GONGGEUM_GYEJWA = T10.GONGGEUM_GYEJWA
                                  AND UNYONG_GYEJWA = T10.UNYONG_GYEJWA
                                  AND KIJUNIL = T10.MAX_KIJUNIL)
                      ELSE (SELECT IYUL
                            FROM RPT_UNYONG_JAN
                            WHERE GEUMGO_CODE = T10.GEUMGO_CODE
                              AND GONGGEUM_GYEJWA = T10.GONGGEUM_GYEJWA
                              AND UNYONG_GYEJWA = T10.UNYONG_GYEJWA
                              AND KIJUNIL = MKDT)
            END AS IYUL
          FROM (SELECT /*+ LEADING(T1 T2 T3) INDEX(T2 RPT_UNYONG_JAN_UK_01) */
                    T2.GEUMGO_CODE
                     , T2.GONGGEUM_GYEJWA
                     , T2.UNYONG_GYEJWA
                     , MIN(T2.KIJUNIL) AS MAX_KIJUNIL
                FROM MAP_JOB_DATE T1
                   , RPT_UNYONG_JAN T2
                   , RPT_UNYONG_GYEJWA T3
                WHERE 1 = 1
                  AND T1.DW_BAS_DDT BETWEEN '20230101' AND '20231231'
                  AND T2.KIJUNIL = CASE WHEN T1.DT_G IN (0) THEN T1.DW_BAS_DDT ELSE T1.BF1_BIZ_DT END
                  AND T2.GEUMGO_CODE = 150
                  AND SUBSTR(T2.GONGGEUM_GYEJWA, 4, 3) = LPAD('0', 3, '0')
                  AND T2.GONGGEUM_GYEJWA NOT IN ('04200080900003999')
                  AND T2.UNYONG_GYEJWA NOT IN ('000000000000')
                  AND T3.GONGGEUM_GYEJWA(+) = T2.GONGGEUM_GYEJWA
                  AND T3.UNYONG_GYEJWA(+) = T2.UNYONG_GYEJWA
                  AND T3.BANK_GUBUN(+) = 0
                  AND COALESCE(T3.MKDT, T3.IN_DATE, '00010101') != COALESCE(T3.HJI_DT, '99991231')
                                             AND COALESCE(T3.MKDT, T3.IN_DATE, '00010101') <= T1.DW_BAS_DDT
                                             AND COALESCE(T3.HJI_DT, T3.OUT_DATE, '99991231') > T1.DW_BAS_DDT
                GROUP BY T2.GEUMGO_CODE
                        , T2.GONGGEUM_GYEJWA
                        , T2.UNYONG_GYEJWA
               ) T10
          WHERE 1 = 1
    ) T200, ACL_SIGUMGO_MAS T300
    WHERE 1 = 1
      AND T200.GONGGEUM_GYEJWA(+) = T100.GONGGEUM_GYEJWA
      AND T200.UNYONG_GYEJWA(+) = T100.UNYONG_GYEJWA
      AND T300.MNG_NO = 1
      AND T300.SIGUMGO_AGE_AC_G IN (0,1)
      AND T300.FIL_100_CTNT2(+) = T200.GONGGEUM_GYEJWA
    GROUP BY  T100.GONGGEUM_GYEJWA , T300.SIGUMGO_AC_NM

) T1000
   , (SELECT COUNT(1) AS DCNT
      FROM MAP_JOB_DATE
      WHERE DW_BAS_DDT BETWEEN '20230101' AND '20231231') T2000
WHERE 1 = 1
GROUP BY  T1000.GONGGEUM_GYEJWA_NO, T1000.GONGGEUM_GYEJWA_NM

----------------------------------------------------------------

SELECT
    *
FROM