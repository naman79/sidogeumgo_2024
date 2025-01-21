


-----------------------------------------------------------------------------
SELECT REF_D_NM AS GONGGEUM_GYEJWA_NM,
       GONGGEUM_GYEJWA,
       SUM(ROUND(NVL(YECHI_JUNGGI/1000, 0),0)) AS YECHI_JUNGI,
       SUM(ROUND(NVL(YECHI_DANGGI/1000, 0),0)) AS YECHI_DANGGI,
       SUM(JUNGI_TONGHAP_AMT) AS JUNGI_TONGHAP_AMT,
         SUM(YECHI_JUNGGI_MMDA) AS YECHI_JUNGGI_MMDA,
         SUM(TOT_YECHI_JUNGGI_MMDA) AS TOT_YECHI_JUNGGI_MMDA,
         SUM(ROUND(NVL(TRUNC((((JUNGI_TONGHAP_AMT * YECHI_JUNGGI_MMDA) / NULLIF(TOT_YECHI_JUNGGI_MMDA, 0))), 0), 0)/1000)) AS IJA_JUNGI_ADD,
            SUM(JUN_IJA) AS JUN_IJA,
       SUM(ROUND(NVL(TRUNC((((JUNGI_TONGHAP_AMT * YECHI_JUNGGI_MMDA) / NULLIF(TOT_YECHI_JUNGGI_MMDA, 0)) + JUN_IJA), 0), 0)/1000)) AS IJA_JUNGI,
       SUM(ROUND(NVL(TRUNC((((DANGGI_TONGHAP_AMT * YECHI_DANGGI_MMDA) / NULLIF(TOT_YECHI_DANGGI_MMDA, 0)) + DANG_IJA), 0), 0)/1000)) AS IJA_DANGGI,
       REF_CTNT4 AS SECTION,
       REF_CTNT2 AS SEQ1,
       REF_CTNT3 AS SEQ2
  FROM
(
       WITH WT_GYEJWA_INFO AS
       (
            SELECT T1.SIGUMGO_ORG_C AS GONGGEUM_GEUMGO_CD
                 , T1.SIGUMGO_GUN_GU_C AS GONGGEUM_GUNGU_CODE
                 , TO_NUMBER(T2.SIGUMGO_HOIKYE_C) AS GONGGEUM_HOIGYE_CODE
                 , T1.SIGUMGO_HOIKYE_YR AS GONGGEUM_HOIGYE_YEAR
                 , T1.SIGUMGO_ACNO AS GONGGEUM_GYEJWA
                 , T1.SIGUMGO_AC_NM AS GONGGEUM_GYEJWA_NM
                 , LPAD(LINKAC_KWA_C, 3, '0')||LPAD(LINKAC_SER, 9, '0') AS GONGGEUM_YUDONG_ACNO
                 , AC_GRBRNO AS GONGGEUM_BRNO
              FROM ACL_SIGUMGO_MAS_SUB T1
              INNER JOIN RPT_AC_BY_HOIKYE_MAPP T2
                      ON T1.SIGUMGO_ACNO = T2.SIGUMGO_ACNO
                     AND T1.SIGUMGO_ORG_C = T2.SIGUMGO_C
              WHERE T1.SIGUMGO_ORG_C = '42'
       )
       , BASE AS
       (
            SELECT HOIGYE_CODE,
                   GONGGEUM_GYEJWA,
                   GONGGEUM_GYEJWA_NM,
      SUM(YECHI_JUNGGI_GONGGEUM) AS YECHI_JUNGGI_GONGGEUM,
        SUM(YECHI_JUNGGI_JUCHUK) AS YECHI_JUNGGI_JUCHUK,
        SUM(YECHI_JUNGGI_MMDA) AS YECHI_JUNGGI_MMDA,
                   (SUM(YECHI_JUNGGI_GONGGEUM) + SUM(YECHI_JUNGGI_JUCHUK) + SUM(YECHI_JUNGGI_MMDA)) AS YECHI_JUNGGI,
                   (SUM(YECHI_DANGGI_GONGGEUM) + SUM(YECHI_DANGGI_JUCHUK) + SUM(YECHI_DANGGI_MMDA)) AS YECHI_DANGGI,
                   NVL((SELECT A.IJA
                          FROM RPT_GONGGEUM_GYULSAN_TMP A,RPT_GONGGEUM_GYULSAN B,WT_GYEJWA_INFO C
                         WHERE A.GEUMGO_CODE = '42'
                           AND A.GEUMGO_CODE = B.GEUMGO_CODE
                           AND A.GUNGU_CODE  = B.GUNGU_CODE
                           AND A.GYULSAN_IL  = '2024' || '0101'
                           AND A.YUDONG_ACNO = B.YUDONG_ACNO
                           AND A.GYULSAN_IL  = B.GYULSAN_IL
                           AND A.GONGGEUM_GYEJWA =C.GONGGEUM_GYEJWA
                           AND A.IJA > 0
                           AND C.GONGGEUM_HOIGYE_CODE = 98), 0) JUNGI_TONGHAP_AMT,
                   NVL((SELECT A.IJA
                          FROM RPT_GONGGEUM_GYULSAN_TMP A,RPT_GONGGEUM_GYULSAN B,WT_GYEJWA_INFO C
                         WHERE A.GEUMGO_CODE = '42'
                           AND A.GEUMGO_CODE = B.GEUMGO_CODE
                           AND A.GUNGU_CODE  = B.GUNGU_CODE
                           AND A.GYULSAN_IL  = '2024' || '0701'
                           AND A.YUDONG_ACNO = B.YUDONG_ACNO
                           AND A.GYULSAN_IL  = B.GYULSAN_IL
                           AND A.GONGGEUM_GYEJWA =C.GONGGEUM_GYEJWA
                           AND A.IJA > 0
                           AND C.GONGGEUM_HOIGYE_CODE = 98), 0) DANGGI_TONGHAP_AMT,
                   NVL(SUM(YECHI_JUNGGI_MMDA), 0) AS YECHI_JUNGGI_MMDA,
                   NVL(SUM(YECHI_DANGGI_MMDA), 0) AS YECHI_DANGGI_MMDA,
                   NVL(SUM(JUN_IJA), 0) AS JUN_IJA,
                   NVL(SUM(DANG_IJA), 0) AS DANG_IJA
            FROM (

                   SELECT HOIGYE_CODE,
                          C.GONGGEUM_GYEJWA,
                          C.GONGGEUM_GYEJWA_NM,
                          TRUNC( SUM(GONGGEUM) / B.DAYS_CNT, 0 )AS YECHI_JUNGGI_GONGGEUM,
                          TRUNC( SUM(UNYONG) / B.DAYS_CNT, 0 )AS YECHI_JUNGGI_JUCHUK,
                          TRUNC( SUM(MMDA) / B.DAYS_CNT, 0 )AS YECHI_JUNGGI_MMDA,
                          0 YECHI_DANGGI_GONGGEUM,
                          0 YECHI_DANGGI_JUCHUK,
                          0 YECHI_DANGGI_MMDA,
                          0 JUN_IJA,
                          0 DANG_IJA
                     FROM
                     (

                          SELECT   A.HOIGYE_CODE, A.GONGGEUM_GYEJWA, SUM(A.JANAEK) GONGGEUM, 0 UNYONG, 0 MMDA
                            FROM RPT_GONGGEUM_JAN A, (SELECT DW_BAS_DDT TRX_DT, CASE WHEN DT_G = 0 THEN BIZ_DT ELSE BF1_BIZ_DT END BIZ_DT
                                                        FROM MAP_JOB_DATE
                                                       WHERE DW_BAS_DDT BETWEEN ( '2024' - 1 ) || '0101' AND ( '2024' - 1 ) || '1231') D, WT_GYEJWA_INFO E
                           WHERE A.KEORAEIL = D.BIZ_DT
                             AND A.GUNGU_CODE = 0
                             AND ( ( A.HOIGYE_YEAR = '2024' - 1 ) OR
                                   ( A.HOIGYE_YEAR = 9999 AND TO_NUMBER(SUBSTR(D.TRX_DT,1,4)) = '2024' - 1 ) )
                             AND A.GEUMGO_CODE = '42'
                             AND A.GONGGEUM_GYEJWA = E.GONGGEUM_GYEJWA
                           GROUP BY A.HOIGYE_CODE, A.GONGGEUM_GYEJWA
                           UNION ALL

                          SELECT A.GONGGEUM_HOIGYE_CODE, A.GONGGEUM_GYEJWA, 0 GONGGEUM, SUM(C.JANAEK) UNYONG, 0 MMDA
                            FROM WT_GYEJWA_INFO A, RPT_UNYONG_GYEJWA B, RPT_UNYONG_JAN C,
                                 (SELECT DW_BAS_DDT TRX_DT, CASE WHEN DT_G = 0 THEN BIZ_DT ELSE BF1_BIZ_DT END BIZ_DT
                                    FROM MAP_JOB_DATE
                                   WHERE DW_BAS_DDT BETWEEN ( '2024' - 1 ) || '0101' AND ( '2024' - 1 ) || '1231') D
                           WHERE A.GONGGEUM_GYEJWA >= B.GONGGEUM_GYEJWA
                             AND SUBSTR(A.GONGGEUM_GYEJWA,1,15) = SUBSTR(B.GONGGEUM_GYEJWA,1,15)
                             AND B.GONGGEUM_GYEJWA = C.GONGGEUM_GYEJWA
                             AND ((A.GONGGEUM_HOIGYE_YEAR <> 9999 AND A.GONGGEUM_GYEJWA >= B.GONGGEUM_GYEJWA) OR
                                  (A.GONGGEUM_HOIGYE_YEAR = 9999  AND A.GONGGEUM_GYEJWA  = B.GONGGEUM_GYEJWA))
                             AND A.GONGGEUM_GUNGU_CODE = 0
                             AND B.GONGGEUM_GYEJWA IN (SELECT Z.GONGGEUM_GYEJWA
                                                         FROM WT_GYEJWA_INFO X, RPT_HOIGYE_IWOL Y, WT_GYEJWA_INFO Z
                                                        WHERE X.GONGGEUM_GEUMGO_CD = Y.GEUMGO_CODE
                                                          AND X.GONGGEUM_HOIGYE_CODE = Y.HOIGYE_CODE
                                                          AND X.GONGGEUM_GUNGU_CODE = Y.GUNGU_CODE
                                                          AND X.GONGGEUM_HOIGYE_YEAR = Y.HOIGYE_YEAR + 1
                                                          AND X.GONGGEUM_GEUMGO_CD = '42'
                                                          AND X.GONGGEUM_HOIGYE_YEAR = '2024' - 1
                                                          AND Y.GUBUN_CODE = 1
                                                          AND Y.KIJUNIL <= D.TRX_DT
                                                          AND X.GONGGEUM_GEUMGO_CD = Z.GONGGEUM_GEUMGO_CD
                                                          AND X.GONGGEUM_HOIGYE_CODE = Z.GONGGEUM_HOIGYE_CODE
                                                          AND X.GONGGEUM_GUNGU_CODE = Z.GONGGEUM_GUNGU_CODE
                                                          AND X.GONGGEUM_HOIGYE_YEAR > Z.GONGGEUM_HOIGYE_YEAR
                                                        UNION
                                                       SELECT A.GONGGEUM_GYEJWA
                                                         FROM WT_GYEJWA_INFO A
                                                        WHERE A.GONGGEUM_GEUMGO_CD = '42'
                                                          AND (    (A.GONGGEUM_HOIGYE_YEAR = '2024' - 1 )
                                                                OR (A.GONGGEUM_HOIGYE_YEAR = 9999 AND TO_NUMBER(SUBSTR(D.TRX_DT,1,4)) = '2024' - 1 ))
                                                      )
                             AND B.UNYONG_GYEJWA = C.UNYONG_GYEJWA
                             AND ( (A.GONGGEUM_HOIGYE_YEAR = '2024' - 1 ) OR
                                   (A.GONGGEUM_HOIGYE_YEAR = 9999 AND TO_NUMBER(SUBSTR(D.TRX_DT,1,4)) = '2024' - 1 ))
                             AND SUBSTR(NVL(B.MKDT,B.IN_DATE),1,8) <= D.TRX_DT
                             AND (B.OUT_DATE IS NULL OR B.OUT_DATE > D.TRX_DT)
                             AND (B.HJI_DT IS NULL OR B.HJI_DT > D.TRX_DT)
                             AND B.BANK_GUBUN = 0
                             AND C.KIJUNIL = D.BIZ_DT
                             AND A.GONGGEUM_GEUMGO_CD = '42'
                           GROUP BY A.GONGGEUM_HOIGYE_CODE, A.GONGGEUM_GYEJWA
                           UNION ALL

                          SELECT A.GONGGEUM_HOIGYE_CODE, A.GONGGEUM_GYEJWA, 0 GONGGEUM, 0 UNYONG, SUM(C.JANAEK) MMDA
                            FROM WT_GYEJWA_INFO A
                               , RPT_UNYONG_JAN C
                               , (SELECT DW_BAS_DDT TRX_DT, CASE WHEN DT_G = 0 THEN BIZ_DT ELSE BF1_BIZ_DT END BIZ_DT
                                    FROM MAP_JOB_DATE
                                   WHERE DW_BAS_DDT BETWEEN ( '2024' - 1 ) || '0101' AND ( '2024' - 1 ) || '1231') D
                           WHERE A.GONGGEUM_GYEJWA = C.GONGGEUM_GYEJWA
                             AND C.UNYONG_GYEJWA = '000000000000'
                             AND C.KIJUNIL = D.BIZ_DT
                             AND ( ( A.GONGGEUM_HOIGYE_YEAR = '2024' - 1 ) OR
                                   ( A.GONGGEUM_HOIGYE_YEAR = 9999 AND SUBSTR(( '2024' - 1 ) || '0101',1,4) = '2024' - 1 ) )
                             AND A.GONGGEUM_GEUMGO_CD = '42'
                           GROUP BY A.GONGGEUM_HOIGYE_CODE, A.GONGGEUM_GYEJWA
                           UNION ALL

                          SELECT C.HOIGYE_CODE, A.GONGGEUM_GYEJWA, 0 GONGGEUM, SUM(B.JANAEK) UNYONG, 0 MMDA
                            FROM RPT_UNYONG_GYEJWA A, RPT_UNYONG_JAN B,
                                 (SELECT A.REF_D_C + 900 HOIGYE_CODE, A.REF_D_NM GONGGEUM_GYEJWA
                                    FROM RPT_CODE_INFO A
                                   WHERE A.REF_L_C = 50
                                     AND A.REF_M_C = '42'
                                     AND A.YUHYO_YN = 0 ) C,
                                 (SELECT DW_BAS_DDT TRX_DT,
                                    CASE WHEN DT_G = 0 THEN BIZ_DT ELSE BF1_BIZ_DT END BIZ_DT
                                    FROM MAP_JOB_DATE
                                    WHERE DW_BAS_DDT BETWEEN ( '2024' - 1 ) || '0101' AND ( '2024' - 1 ) || '1231') D
                           WHERE A.GONGGEUM_GYEJWA = B.GONGGEUM_GYEJWA
                             AND A.GONGGEUM_GYEJWA = C.GONGGEUM_GYEJWA
                             AND A.UNYONG_GYEJWA = B.UNYONG_GYEJWA
                             AND B.KIJUNIL = D.BIZ_DT
                             AND A.GEUMGO_CODE = '42'
                             AND SUBSTR(NVL(A.MKDT,A.IN_DATE),1,8) <= D.TRX_DT
                             AND (A.OUT_DATE IS NULL OR A.OUT_DATE > D.TRX_DT)
                             AND (A.HJI_DT IS NULL OR A.HJI_DT > D.TRX_DT)
                             AND A.BANK_GUBUN = 0
                             AND TO_NUMBER(SUBSTR(D.TRX_DT,1,4)) = '2024' - 1
                             AND SUBSTR(( '2024' - 1 ) || '0101',1,4) = '2024' - 1
                           GROUP BY C.HOIGYE_CODE, A.GONGGEUM_GYEJWA
                        ) A
                        , (SELECT COUNT(DW_BAS_DDT) DAYS_CNT
                             FROM MAP_JOB_DATE
                            WHERE DW_BAS_DDT BETWEEN ( '2024' - 1 ) || '0101' AND ( '2024' - 1 ) || '1231') B
                        , WT_GYEJWA_INFO C
                    WHERE C.GONGGEUM_GEUMGO_CD = '42'
                      AND C.GONGGEUM_GYEJWA <> '04200080900003999'
                      AND A.GONGGEUM_GYEJWA(+) =  C.GONGGEUM_GYEJWA
                      AND ((C.GONGGEUM_HOIGYE_YEAR = '2024' - 1 ) OR (C.GONGGEUM_HOIGYE_YEAR = '9999'))
                    GROUP BY A.HOIGYE_CODE, A.GONGGEUM_GYEJWA,C.GONGGEUM_GYEJWA, B.DAYS_CNT,C.GONGGEUM_GYEJWA_NM,C.GONGGEUM_HOIGYE_YEAR


                    UNION ALL


                   SELECT HOIGYE_CODE,
                          C.GONGGEUM_GYEJWA,
                          C.GONGGEUM_GYEJWA_NM,
                          0 YECHI_JUNGGI_GONGGEUM,
                          0 YECHI_JUNGGI_JUCHUK,
                          0 YECHI_JUNGGI_MMDA,
                          TRUNC( SUM(GONGGEUM) / B.DAYS_CNT, 0 )AS YECHI_DANGGI_GONGGEUM,
                          TRUNC( SUM(UNYONG) / B.DAYS_CNT, 0 )AS YECHI_DANGGI_JUCHUK,
                          TRUNC( SUM(MMDA) / B.DAYS_CNT, 0 )AS YECHI_DANGGI_MMDA,
                          0 JUN_IJA,
                          0 DANG_IJA
                     FROM
                     (

                          SELECT A.HOIGYE_CODE, A.GONGGEUM_GYEJWA, SUM(A.JANAEK) GONGGEUM, 0 UNYONG, 0 MMDA
                            FROM RPT_GONGGEUM_JAN A, (SELECT DW_BAS_DDT TRX_DT, CASE WHEN DT_G = 0 THEN BIZ_DT ELSE BF1_BIZ_DT END BIZ_DT
                                                        FROM MAP_JOB_DATE
                                                       WHERE DW_BAS_DDT BETWEEN '20240101' AND '20241231' ) D, WT_GYEJWA_INFO E
                           WHERE A.KEORAEIL = D.BIZ_DT
                             AND A.GUNGU_CODE = 0
                             AND ( ( A.HOIGYE_YEAR = '2024' ) OR
                                   ( A.HOIGYE_YEAR = 9999 AND TO_NUMBER(SUBSTR(D.TRX_DT,1,4)) = '2024' ) )
                             AND A.GEUMGO_CODE = '42'
                             AND A.GONGGEUM_GYEJWA = E.GONGGEUM_GYEJWA
                           GROUP BY A.HOIGYE_CODE, A.GONGGEUM_GYEJWA
                           UNION ALL

                          SELECT A.GONGGEUM_HOIGYE_CODE, A.GONGGEUM_GYEJWA, 0 GONGGEUM, SUM(C.JANAEK) UNYONG, 0 MMDA
                            FROM WT_GYEJWA_INFO A, RPT_UNYONG_GYEJWA B, RPT_UNYONG_JAN C,
                                 (SELECT DW_BAS_DDT TRX_DT, CASE WHEN DT_G = 0 THEN BIZ_DT ELSE BF1_BIZ_DT END BIZ_DT
                                    FROM MAP_JOB_DATE
                                    WHERE DW_BAS_DDT BETWEEN '20240101' AND '20241231' ) D
                           WHERE A.GONGGEUM_GYEJWA >= B.GONGGEUM_GYEJWA
                             AND SUBSTR(A.GONGGEUM_GYEJWA,1,15) = SUBSTR(B.GONGGEUM_GYEJWA,1,15)
                             AND B.GONGGEUM_GYEJWA = C.GONGGEUM_GYEJWA
                             AND ((A.GONGGEUM_HOIGYE_YEAR <> 9999 AND A.GONGGEUM_GYEJWA >= B.GONGGEUM_GYEJWA) OR
                                  (A.GONGGEUM_HOIGYE_YEAR = 9999  AND A.GONGGEUM_GYEJWA  = B.GONGGEUM_GYEJWA))
                             AND A.GONGGEUM_GUNGU_CODE = 0
                             AND B.GONGGEUM_GYEJWA IN (SELECT Z.GONGGEUM_GYEJWA
                                                         FROM WT_GYEJWA_INFO X, RPT_HOIGYE_IWOL Y, WT_GYEJWA_INFO Z
                                                        WHERE X.GONGGEUM_GEUMGO_CD = Y.GEUMGO_CODE
                                                          AND X.GONGGEUM_HOIGYE_CODE = Y.HOIGYE_CODE
                                                          AND X.GONGGEUM_GUNGU_CODE = Y.GUNGU_CODE
                                                          AND X.GONGGEUM_HOIGYE_YEAR = Y.HOIGYE_YEAR + 1
                                                          AND X.GONGGEUM_GEUMGO_CD = '42'
                                                          AND X.GONGGEUM_HOIGYE_YEAR = '2024'
                                                          AND Y.GUBUN_CODE = 1
                                                          AND Y.KIJUNIL <= D.TRX_DT
                                                          AND X.GONGGEUM_GEUMGO_CD = Z.GONGGEUM_GEUMGO_CD
                                                          AND X.GONGGEUM_HOIGYE_CODE = Z.GONGGEUM_HOIGYE_CODE
                                                          AND X.GONGGEUM_GUNGU_CODE = Z.GONGGEUM_GUNGU_CODE
                                                          AND X.GONGGEUM_HOIGYE_YEAR > Z.GONGGEUM_HOIGYE_YEAR
                                                        UNION
                                                       SELECT A.GONGGEUM_GYEJWA
                                                         FROM WT_GYEJWA_INFO A
                                                        WHERE A.GONGGEUM_GEUMGO_CD = '42'
                                                          AND ( (A.GONGGEUM_HOIGYE_YEAR = '2024' ) OR
                                                                (A.GONGGEUM_HOIGYE_YEAR = 9999 AND TO_NUMBER(SUBSTR(D.TRX_DT,1,4)) = '2024' ))
                                                      )
                             AND B.UNYONG_GYEJWA = C.UNYONG_GYEJWA
                             AND ( (A.GONGGEUM_HOIGYE_YEAR = '2024' ) OR
                                   (A.GONGGEUM_HOIGYE_YEAR = 9999 AND TO_NUMBER(SUBSTR(D.TRX_DT,1,4)) = '2024' ))
                             AND SUBSTR(NVL(B.MKDT,B.IN_DATE),1,8) <= D.TRX_DT
                             AND (B.OUT_DATE IS NULL OR B.OUT_DATE > D.TRX_DT)
                             AND (B.HJI_DT IS NULL OR B.HJI_DT > D.TRX_DT)
                             AND B.BANK_GUBUN = 0
                             AND C.KIJUNIL = D.BIZ_DT
                             AND A.GONGGEUM_GEUMGO_CD = '42'
                           GROUP BY A.GONGGEUM_HOIGYE_CODE, A.GONGGEUM_GYEJWA
                           UNION ALL

                          SELECT A.GONGGEUM_HOIGYE_CODE, A.GONGGEUM_GYEJWA, 0 GONGGEUM, 0 UNYONG, SUM(C.JANAEK) MMDA
                            FROM WT_GYEJWA_INFO A, RPT_UNYONG_JAN C,
                                 (SELECT DW_BAS_DDT TRX_DT, CASE WHEN DT_G = 0 THEN BIZ_DT ELSE BF1_BIZ_DT END BIZ_DT
                                    FROM MAP_JOB_DATE
                                   WHERE DW_BAS_DDT BETWEEN '20240101' AND '20241231' ) D
                           WHERE A.GONGGEUM_GYEJWA = C.GONGGEUM_GYEJWA
                             AND C.UNYONG_GYEJWA = '000000000000'
                             AND C.KIJUNIL = D.BIZ_DT
                             AND ( ( A.GONGGEUM_HOIGYE_YEAR = '2024' ) OR
                                   ( A.GONGGEUM_HOIGYE_YEAR = 9999 AND SUBSTR('20240101',1,4) = '2024' ) )
                             AND A.GONGGEUM_GEUMGO_CD = '42'
                           GROUP BY A.GONGGEUM_HOIGYE_CODE, A.GONGGEUM_GYEJWA
                           UNION ALL

                          SELECT C.HOIGYE_CODE, A.GONGGEUM_GYEJWA, 0 GONGGEUM, SUM(B.JANAEK) UNYONG, 0 MMDA
                            FROM RPT_UNYONG_GYEJWA A, RPT_UNYONG_JAN B,
                                 (SELECT A.REF_D_C + 900 HOIGYE_CODE, A.REF_D_NM GONGGEUM_GYEJWA
                                    FROM RPT_CODE_INFO A
                                   WHERE A.REF_L_C = 50
                                     AND A.REF_M_C = '42'
                                     AND A.YUHYO_YN = 0 ) C,
                                 (SELECT DW_BAS_DDT TRX_DT,
                                    CASE WHEN DT_G = 0 THEN BIZ_DT ELSE BF1_BIZ_DT END BIZ_DT
                                    FROM MAP_JOB_DATE
                                   WHERE DW_BAS_DDT BETWEEN '20240101' AND '20241231' ) D
                           WHERE A.GONGGEUM_GYEJWA = B.GONGGEUM_GYEJWA
                             AND A.GONGGEUM_GYEJWA = C.GONGGEUM_GYEJWA
                             AND A.UNYONG_GYEJWA = B.UNYONG_GYEJWA
                             AND B.KIJUNIL = D.BIZ_DT
                             AND A.GEUMGO_CODE = '42'
                             AND SUBSTR(NVL(A.MKDT,A.IN_DATE),1,8) <= D.TRX_DT
                             AND (A.OUT_DATE IS NULL OR A.OUT_DATE > D.TRX_DT)
                             AND (A.HJI_DT IS NULL OR A.HJI_DT > D.TRX_DT)
                             AND A.BANK_GUBUN = 0
                             AND TO_NUMBER(SUBSTR(D.TRX_DT,1,4)) = '2024'
                             AND SUBSTR('20240101',1,4) = '2024'
                           GROUP BY C.HOIGYE_CODE, A.GONGGEUM_GYEJWA
                        ) A
                        , (SELECT COUNT(DW_BAS_DDT) DAYS_CNT
                             FROM MAP_JOB_DATE
                            WHERE DW_BAS_DDT BETWEEN '20240101' AND '20241231') B
                        , WT_GYEJWA_INFO C
                    WHERE C.GONGGEUM_GEUMGO_CD = '42'
                      AND C.GONGGEUM_GYEJWA <> '04200080900003999'
                      AND A.GONGGEUM_GYEJWA(+) =  C.GONGGEUM_GYEJWA
                      AND ((C.GONGGEUM_HOIGYE_YEAR = '2024' ) OR (C.GONGGEUM_HOIGYE_YEAR = '9999'))
                    GROUP BY A.HOIGYE_CODE, A.GONGGEUM_GYEJWA,C.GONGGEUM_GYEJWA, B.DAYS_CNT,C.GONGGEUM_GYEJWA_NM,C.GONGGEUM_HOIGYE_YEAR


                    UNION ALL


                   SELECT A.HOIGYE_CODE,
                          A.GONGGEUM_GYEJWA,
                          A.GYEJWA_NAME,
                          0 YECHI_JUNGGI_GONGGEUM,
                          0 YECHI_JUNGGI_JUCHUK,
                          0 YECHI_JUNGGI_MMDA,
                          0 YECHI_DANGGI_GONGGEUM,
                          0 YECHI_DANGGI_JUCHUK,
                          0 YECHI_DANGGI_MMDA,
                          SUM(A.JI_IJA) JUN_IJA,
                          0 DANG_IJA
                     FROM (
                          SELECT A.HOIGYE_CODE, A.GONGGEUM_GYEJWA, A.GYEJWA_NAME, A.SANGPUM_NAME,
                                 A.MKDT, A.DUDT, A.IYUL, A.JANAEK, A.KIJUNIL, A.JI_IJA
                            FROM (
                                  SELECT TRIM(A.KIJUNIL) KIJUNIL, A.GONGGEUM_GYEJWA,
                                         B.GONGGEUM_HOIGYE_CODE HOIGYE_CODE, B.GONGGEUM_HOIGYE_YEAR HOIGYE_YEAR,
                                         A.JANAEK, D.MKDT, A.DUDT, D.HJI_DT, D.BBK_BKKP_NM, D.PRDT_BKKP_NM, A.LST_TRXDT,
                                         A.IYUL, A.GEUMGO_CODE, A.IPAMT, A.JIAMT, A.JI_IJA,
                                         B.GONGGEUM_GYEJWA_NM GYEJWA_NAME, D.SANGPUM_NAME,

                                         CASE WHEN B.GONGGEUM_HOIGYE_YEAR = 9999 THEN TO_CHAR(SUBSTR(A.KIJUNIL,1,4))
                                              WHEN B.GONGGEUM_HOIGYE_YEAR = SUBSTR(A.KIJUNIL,1,4) THEN B.GONGGEUM_HOIGYE_YEAR
                                              WHEN SUBSTR(A.KIJUNIL,1,8) >= C.KIJUNIL THEN TO_CHAR(B.GONGGEUM_HOIGYE_YEAR + 1 )
                                              WHEN SUBSTR(A.KIJUNIL,1,8) <  C.KIJUNIL THEN B.GONGGEUM_HOIGYE_YEAR
                                              ELSE B.GONGGEUM_HOIGYE_YEAR END R_HOIGYE_YEAR
                                    FROM RPT_UNYONG_JAN A, WT_GYEJWA_INFO B, RPT_HOIGYE_IWOL C, RPT_UNYONG_GYEJWA D
                                   WHERE A.GONGGEUM_GYEJWA = B.GONGGEUM_GYEJWA
                                     AND A.GONGGEUM_GYEJWA = D.GONGGEUM_GYEJWA
                                     AND A.UNYONG_GYEJWA = D.UNYONG_GYEJWA
                                     AND A.KIJUNIL BETWEEN ( '2024' - 1 ) || '0101' AND ( '2024' - 1 ) || '1231'
                                     AND A.GEUMGO_CODE = '42'
                                     AND B.GONGGEUM_GEUMGO_CD = '42'
                                     AND B.GONGGEUM_GEUMGO_CD = D.GEUMGO_CODE
                                     AND B.GONGGEUM_HOIGYE_CODE = C.HOIGYE_CODE(+)
                                     AND B.GONGGEUM_HOIGYE_YEAR = C.HOIGYE_YEAR(+)
                                     AND B.GONGGEUM_GEUMGO_CD = C.GEUMGO_CODE(+)
                                     AND C.GUBUN_CODE(+) = 1
                                     AND A.JI_IJA > 0
                               ) A
                           WHERE A.R_HOIGYE_YEAR IN ('9999', '2024' - 1 )
                           UNION ALL
                          SELECT A.HOIGYE_CODE, A.GONGGEUM_GYEJWA, A.GYEJWA_NAME, B.SANGPUM_NAME,
                                 C.MKDT, C.DUDT, C.IYUL, C.JANAEK, TRIM(C.KIJUNIL) KIJUNIL, C.JI_IJA
                            FROM (
                                 SELECT A.REF_D_NM GONGGEUM_GYEJWA, A.REF_CTNT1 GYEJWA_NAME,
                                        A.REF_S_C MNGBR, TO_NUMBER(SUBSTR(A.REF_D_NM,4,3)) GUNGU_CODE,
                                        A.REF_D_C + 900 HOIGYE_CODE, 99 GYEJWA_BUNRYU
                                   FROM RPT_CODE_INFO A
                                  WHERE A.REF_L_C = 50
                                    AND A.REF_M_C = '42'
                                    AND A.YUHYO_YN = 0) A
                               , RPT_UNYONG_GYEJWA B, RPT_UNYONG_JAN C
                           WHERE A.GONGGEUM_GYEJWA = B.GONGGEUM_GYEJWA
                             AND A.GONGGEUM_GYEJWA = C.GONGGEUM_GYEJWA
                             AND B.UNYONG_GYEJWA = C.UNYONG_GYEJWA
                             AND SUBSTR(NVL(B.MKDT,B.IN_DATE),1,8) <= ( '2024' - 1 ) || '1231'
                             AND (B.OUT_DATE IS NULL OR B.OUT_DATE > ( '2024' - 1 ) || '0101' )
                             AND (B.HJI_DT IS NULL OR B.HJI_DT > ( '2024' - 1 ) || '0101' )
                             AND B.BANK_GUBUN = 0
                             AND C.KIJUNIL BETWEEN ( '2024' - 1 ) || '0101' AND ( '2024' - 1 ) || '1231'
                             AND C.JI_IJA > 0
                             AND ( 9999 = 9999 OR SUBSTR(C.KIJUNIL,1,4) = 9999 )
                        ) A
                    GROUP BY A.HOIGYE_CODE, A.GONGGEUM_GYEJWA, A.GYEJWA_NAME


                    UNION ALL


                   SELECT A.HOIGYE_CODE,
                          A.GONGGEUM_GYEJWA,
                          A.GYEJWA_NAME,
                          0 YECHI_JUNGGI_GONGGEUM,
                          0 YECHI_JUNGGI_JUCHUK,
                          0 YECHI_JUNGGI_MMDA,
                          0 YECHI_DANGGI_GONGGEUM,
                          0 YECHI_DANGGI_JUCHUK,
                          0 YECHI_DANGGI_MMDA,
                          0 JUN_IJA,
                          SUM(A.JI_IJA) DANG_IJA
                     FROM (
                          SELECT A.HOIGYE_CODE, A.GONGGEUM_GYEJWA, A.GYEJWA_NAME, A.SANGPUM_NAME,
                                 A.MKDT, A.DUDT, A.IYUL, A.JANAEK, A.KIJUNIL, A.JI_IJA
                            FROM (
                                 SELECT TRIM(A.KIJUNIL) KIJUNIL, A.GONGGEUM_GYEJWA,
                                        B.GONGGEUM_HOIGYE_CODE HOIGYE_CODE, B.GONGGEUM_HOIGYE_YEAR HOIGYE_YEAR,
                                        A.JANAEK, D.MKDT, A.DUDT, D.HJI_DT, D.BBK_BKKP_NM, D.PRDT_BKKP_NM, A.LST_TRXDT,
                                        A.IYUL, A.GEUMGO_CODE, A.IPAMT, A.JIAMT, A.JI_IJA,
                                        B.GONGGEUM_GYEJWA_NM GYEJWA_NAME, D.SANGPUM_NAME,

                                        CASE WHEN B.GONGGEUM_HOIGYE_YEAR = 9999 THEN TO_CHAR(SUBSTR(A.KIJUNIL,1,4))
                                             WHEN B.GONGGEUM_HOIGYE_YEAR = SUBSTR(A.KIJUNIL,1,4) THEN B.GONGGEUM_HOIGYE_YEAR
                                             WHEN SUBSTR(A.KIJUNIL,1,8) >= C.KIJUNIL THEN TO_CHAR(B.GONGGEUM_HOIGYE_YEAR + 1 )
                                             WHEN SUBSTR(A.KIJUNIL,1,8) <  C.KIJUNIL THEN B.GONGGEUM_HOIGYE_YEAR
                                             ELSE B.GONGGEUM_HOIGYE_YEAR END R_HOIGYE_YEAR
                                   FROM RPT_UNYONG_JAN A, WT_GYEJWA_INFO B, RPT_HOIGYE_IWOL C, RPT_UNYONG_GYEJWA D
                                  WHERE A.GONGGEUM_GYEJWA = B.GONGGEUM_GYEJWA
                                    AND A.GONGGEUM_GYEJWA = D.GONGGEUM_GYEJWA
                                    AND A.UNYONG_GYEJWA = D.UNYONG_GYEJWA
                                    AND A.KIJUNIL BETWEEN '20240101' AND '20241231'
                                    AND A.GEUMGO_CODE = '42'
                                    AND B.GONGGEUM_GEUMGO_CD = '42'
                                    AND B.GONGGEUM_GEUMGO_CD = D.GEUMGO_CODE
                                    AND B.GONGGEUM_HOIGYE_CODE = C.HOIGYE_CODE(+)
                                    AND B.GONGGEUM_HOIGYE_YEAR = C.HOIGYE_YEAR(+)
                                    AND B.GONGGEUM_GEUMGO_CD = C.GEUMGO_CODE(+)
                                    AND C.GUBUN_CODE(+) = 1
                                    AND A.JI_IJA > 0
                               ) A
                           WHERE A.R_HOIGYE_YEAR IN ('9999', '2024' )
                           UNION ALL
                          SELECT A.HOIGYE_CODE, A.GONGGEUM_GYEJWA, A.GYEJWA_NAME, B.SANGPUM_NAME,
                                 C.MKDT, C.DUDT, C.IYUL, C.JANAEK, TRIM(C.KIJUNIL) KIJUNIL, C.JI_IJA
                            FROM (
                                 SELECT A.REF_D_NM GONGGEUM_GYEJWA, A.REF_CTNT1 GYEJWA_NAME,
                                        A.REF_S_C MNGBR, TO_NUMBER(SUBSTR(A.REF_D_NM,4,3)) GUNGU_CODE,
                                        A.REF_D_C + 900 HOIGYE_CODE, 99 GYEJWA_BUNRYU
                                   FROM RPT_CODE_INFO A
                                  WHERE A.REF_L_C = 50
                                    AND A.REF_M_C = '42'
                                    AND A.YUHYO_YN = 0) A
                               , RPT_UNYONG_GYEJWA B, RPT_UNYONG_JAN C
                           WHERE A.GONGGEUM_GYEJWA = B.GONGGEUM_GYEJWA
                             AND A.GONGGEUM_GYEJWA = C.GONGGEUM_GYEJWA
                             AND B.UNYONG_GYEJWA = C.UNYONG_GYEJWA
                             AND SUBSTR(NVL(B.MKDT,B.IN_DATE),1,8) <= '20241231'
                             AND (B.OUT_DATE IS NULL OR B.OUT_DATE > '20240101' )
                             AND (B.HJI_DT IS NULL OR B.HJI_DT > '20240101' )
                             AND B.BANK_GUBUN = 0
                             AND C.KIJUNIL BETWEEN '20240101' AND '20241231'
                             AND C.JI_IJA > 0
                             AND ( 9999 = 9999 OR SUBSTR(C.KIJUNIL,1,4) = 9999 )
                        ) A
                    GROUP BY A.HOIGYE_CODE, A.GONGGEUM_GYEJWA, A.GYEJWA_NAME

               )
           GROUP BY HOIGYE_CODE, GONGGEUM_GYEJWA, GONGGEUM_GYEJWA_NM
       )
       SELECT HOIGYE_CODE,
              GONGGEUM_GYEJWA,
              GONGGEUM_GYEJWA_NM,
              YECHI_JUNGGI,
              YECHI_DANGGI,
              JUNGI_TONGHAP_AMT,
              DANGGI_TONGHAP_AMT,
              YECHI_JUNGGI_MMDA,
              YECHI_DANGGI_MMDA,
              JUN_IJA,
              DANG_IJA,
              SUM(YECHI_JUNGGI_MMDA) OVER () AS TOT_YECHI_JUNGGI_MMDA,
              SUM(YECHI_DANGGI_MMDA) OVER () AS TOT_YECHI_DANGGI_MMDA
         FROM BASE
         GROUP BY HOIGYE_CODE, GONGGEUM_GYEJWA, GONGGEUM_GYEJWA_NM, YECHI_JUNGGI, YECHI_DANGGI, JUNGI_TONGHAP_AMT,
                  DANGGI_TONGHAP_AMT, YECHI_JUNGGI_MMDA, YECHI_DANGGI_MMDA, JUN_IJA, DANG_IJA
     ) A
     , (

      SELECT
      A.*
      FROM
      ( SELECT REF_D_NM, REF_CTNT1, REF_CTNT2, REF_CTNT3, REF_CTNT4
      FROM RPT_CODE_INFO
      WHERE REF_L_C = '550'
      AND REF_M_C = NVL('42', REF_M_C)
      AND REF_S_C = NVL('1', REF_S_C)
      AND YUHYO_YN = 0
      UNION ALL
      SELECT
      '통합공금' AS REF_D_NM, '98' AS REF_CTNT1, '3' AS REF_CTNT2, '20' AS REF_CTNT3, '통합공금' AS REF_CTNT4
      FROM DUAL
      ) A GROUP BY A.REF_D_NM, A.REF_CTNT1, A.REF_CTNT2, A.REF_CTNT3, A.REF_CTNT4
) B
 WHERE HOIGYE_CODE (+)= REF_CTNT1
 GROUP BY REF_D_NM, GONGGEUM_GYEJWA, REF_CTNT4, REF_CTNT2, REF_CTNT3
 ORDER BY TO_NUMBER(REF_CTNT2), GONGGEUM_GYEJWA, TO_NUMBER(REF_CTNT3)
;


SELECT REF_D_NM,
               REF_CTNT1,
               REF_CTNT2,
               REF_CTNT3,
               REF_CTNT4
          FROM RPT_CODE_INFO
         WHERE REF_L_C = '550'
           AND REF_M_C = NVL('42', REF_M_C)
           AND REF_S_C = NVL('1', REF_S_C)
           AND YUHYO_YN = 0
UNION ALL
SELECT
    '통합공금' AS REF_D_NM,
    '98' AS REF_CTNT1,
    '3' AS REF_CTNT2,
    '20' AS REF_CTNT3,
    '통합공금' AS REF_CTNT4
    FROM DUAL


WITH WT_GYEJWA_INFO AS
       (
            SELECT T1.SIGUMGO_ORG_C AS GONGGEUM_GEUMGO_CD
                 , T1.SIGUMGO_GUN_GU_C AS GONGGEUM_GUNGU_CODE
                 , TO_NUMBER(T2.SIGUMGO_HOIKYE_C) AS GONGGEUM_HOIGYE_CODE
                 , T1.SIGUMGO_HOIKYE_YR AS GONGGEUM_HOIGYE_YEAR
                 , T1.SIGUMGO_ACNO AS GONGGEUM_GYEJWA
                 , T1.SIGUMGO_AC_NM AS GONGGEUM_GYEJWA_NM
                 , LPAD(LINKAC_KWA_C, 3, '0')||LPAD(LINKAC_SER, 9, '0') AS GONGGEUM_YUDONG_ACNO
                 , AC_GRBRNO AS GONGGEUM_BRNO
              FROM ACL_SIGUMGO_MAS_SUB T1
              INNER JOIN RPT_AC_BY_HOIKYE_MAPP T2
                      ON T1.SIGUMGO_ACNO = T2.SIGUMGO_ACNO
                     AND T1.SIGUMGO_ORG_C = T2.SIGUMGO_C
              WHERE T1.SIGUMGO_ORG_C = '42'
       )
SELECT HOIGYE_CODE,
                          C.GONGGEUM_GYEJWA,
                          C.GONGGEUM_GYEJWA_NM,
                          B.DAYS_CNT,
                          SUM(GONGGEUM) YECHI_JUNGGI_GONGGEUM,
                          TRUNC( SUM(GONGGEUM) / B.DAYS_CNT, 0 )AS YECHI_JUNGGI_GONGGEUM_PYONG,
                          SUM(UNYONG) YECHI_JUNGGI_JUCHUK,
                          TRUNC( SUM(UNYONG) / B.DAYS_CNT, 0 )AS YECHI_JUNGGI_JUCHUK_PYONG,
                        SUM(MMDA) YECHI_JUNGGI_MMDA,
                          TRUNC( SUM(MMDA) / B.DAYS_CNT, 0 )AS YECHI_JUNGGI_MMDA_PYONG,
                          0 YECHI_DANGGI_GONGGEUM,
                          0 YECHI_DANGGI_JUCHUK,
                          0 YECHI_DANGGI_MMDA,
                          0 JUN_IJA,
                          0 DANG_IJA
                     FROM
                     (

                          SELECT   A.HOIGYE_CODE, A.GONGGEUM_GYEJWA, SUM(A.JANAEK) GONGGEUM, 0 UNYONG, 0 MMDA
                            FROM RPT_GONGGEUM_JAN A, (SELECT DW_BAS_DDT TRX_DT, CASE WHEN DT_G = 0 THEN BIZ_DT ELSE BF1_BIZ_DT END BIZ_DT
                                                        FROM MAP_JOB_DATE
                                                       WHERE DW_BAS_DDT BETWEEN ( '2024' - 1 ) || '0101' AND ( '2024' - 1 ) || '1231') D, WT_GYEJWA_INFO E
                           WHERE A.KEORAEIL = D.BIZ_DT
                             AND A.GUNGU_CODE = 0
                             AND ( ( A.HOIGYE_YEAR = '2024' - 1 ) OR
                                   ( A.HOIGYE_YEAR = 9999 AND TO_NUMBER(SUBSTR(D.TRX_DT,1,4)) = '2024' - 1 ) )
                             AND A.GEUMGO_CODE = '42'
                             AND A.GONGGEUM_GYEJWA = E.GONGGEUM_GYEJWA
                           GROUP BY A.HOIGYE_CODE, A.GONGGEUM_GYEJWA
                           UNION ALL

                          SELECT A.GONGGEUM_HOIGYE_CODE, A.GONGGEUM_GYEJWA, 0 GONGGEUM, SUM(C.JANAEK) UNYONG, 0 MMDA
                            FROM WT_GYEJWA_INFO A, RPT_UNYONG_GYEJWA B, RPT_UNYONG_JAN C,
                                 (SELECT DW_BAS_DDT TRX_DT, CASE WHEN DT_G = 0 THEN BIZ_DT ELSE BF1_BIZ_DT END BIZ_DT
                                    FROM MAP_JOB_DATE
                                   WHERE DW_BAS_DDT BETWEEN ( '2024' - 1 ) || '0101' AND ( '2024' - 1 ) || '1231') D
                           WHERE A.GONGGEUM_GYEJWA >= B.GONGGEUM_GYEJWA
                             AND SUBSTR(A.GONGGEUM_GYEJWA,1,15) = SUBSTR(B.GONGGEUM_GYEJWA,1,15)
                             AND B.GONGGEUM_GYEJWA = C.GONGGEUM_GYEJWA
                             AND ((A.GONGGEUM_HOIGYE_YEAR <> 9999 AND A.GONGGEUM_GYEJWA >= B.GONGGEUM_GYEJWA) OR
                                  (A.GONGGEUM_HOIGYE_YEAR = 9999  AND A.GONGGEUM_GYEJWA  = B.GONGGEUM_GYEJWA))
                             AND A.GONGGEUM_GUNGU_CODE = 0
                             AND B.GONGGEUM_GYEJWA IN (SELECT Z.GONGGEUM_GYEJWA
                                                         FROM WT_GYEJWA_INFO X, RPT_HOIGYE_IWOL Y, WT_GYEJWA_INFO Z
                                                        WHERE X.GONGGEUM_GEUMGO_CD = Y.GEUMGO_CODE
                                                          AND X.GONGGEUM_HOIGYE_CODE = Y.HOIGYE_CODE
                                                          AND X.GONGGEUM_GUNGU_CODE = Y.GUNGU_CODE
                                                          AND X.GONGGEUM_HOIGYE_YEAR = Y.HOIGYE_YEAR + 1
                                                          AND X.GONGGEUM_GEUMGO_CD = '42'
                                                          AND X.GONGGEUM_HOIGYE_YEAR = '2024' - 1
                                                          AND Y.GUBUN_CODE = 1
                                                          AND Y.KIJUNIL <= D.TRX_DT
                                                          AND X.GONGGEUM_GEUMGO_CD = Z.GONGGEUM_GEUMGO_CD
                                                          AND X.GONGGEUM_HOIGYE_CODE = Z.GONGGEUM_HOIGYE_CODE
                                                          AND X.GONGGEUM_GUNGU_CODE = Z.GONGGEUM_GUNGU_CODE
                                                          AND X.GONGGEUM_HOIGYE_YEAR > Z.GONGGEUM_HOIGYE_YEAR
                                                        UNION
                                                       SELECT A.GONGGEUM_GYEJWA
                                                         FROM WT_GYEJWA_INFO A
                                                        WHERE A.GONGGEUM_GEUMGO_CD = '42'
                                                          AND (    (A.GONGGEUM_HOIGYE_YEAR = '2024' - 1 )
                                                                OR (A.GONGGEUM_HOIGYE_YEAR = 9999 AND TO_NUMBER(SUBSTR(D.TRX_DT,1,4)) = '2024' - 1 ))
                                                      )
                             AND B.UNYONG_GYEJWA = C.UNYONG_GYEJWA
                             AND ( (A.GONGGEUM_HOIGYE_YEAR = '2024' - 1 ) OR
                                   (A.GONGGEUM_HOIGYE_YEAR = 9999 AND TO_NUMBER(SUBSTR(D.TRX_DT,1,4)) = '2024' - 1 ))
                             AND SUBSTR(NVL(B.MKDT,B.IN_DATE),1,8) <= D.TRX_DT
                             AND (B.OUT_DATE IS NULL OR B.OUT_DATE > D.TRX_DT)
                             AND (B.HJI_DT IS NULL OR B.HJI_DT > D.TRX_DT)
                             AND B.BANK_GUBUN = 0
                             AND C.KIJUNIL = D.BIZ_DT
                             AND A.GONGGEUM_GEUMGO_CD = '42'
                           GROUP BY A.GONGGEUM_HOIGYE_CODE, A.GONGGEUM_GYEJWA
                           UNION ALL

                          SELECT A.GONGGEUM_HOIGYE_CODE, A.GONGGEUM_GYEJWA, 0 GONGGEUM, 0 UNYONG, SUM(C.JANAEK) MMDA
                            FROM WT_GYEJWA_INFO A
                               , RPT_UNYONG_JAN C
                               , (SELECT DW_BAS_DDT TRX_DT, CASE WHEN DT_G = 0 THEN BIZ_DT ELSE BF1_BIZ_DT END BIZ_DT
                                    FROM MAP_JOB_DATE
                                   WHERE DW_BAS_DDT BETWEEN ( '2024' - 1 ) || '0101' AND ( '2024' - 1 ) || '1231') D
                           WHERE A.GONGGEUM_GYEJWA = C.GONGGEUM_GYEJWA
                             AND C.UNYONG_GYEJWA = '000000000000'
                             AND C.KIJUNIL = D.BIZ_DT
                             AND ( ( A.GONGGEUM_HOIGYE_YEAR = '2024' - 1 ) OR
                                   ( A.GONGGEUM_HOIGYE_YEAR = 9999 AND SUBSTR(( '2024' - 1 ) || '0101',1,4) = '2024' - 1 ) )
                             AND A.GONGGEUM_GEUMGO_CD = '42'
                           GROUP BY A.GONGGEUM_HOIGYE_CODE, A.GONGGEUM_GYEJWA
                           UNION ALL

                          SELECT C.HOIGYE_CODE, A.GONGGEUM_GYEJWA, 0 GONGGEUM, SUM(B.JANAEK) UNYONG, 0 MMDA
                            FROM RPT_UNYONG_GYEJWA A, RPT_UNYONG_JAN B,
                                 (SELECT A.REF_D_C + 900 HOIGYE_CODE, A.REF_D_NM GONGGEUM_GYEJWA
                                    FROM RPT_CODE_INFO A
                                   WHERE A.REF_L_C = 50
                                     AND A.REF_M_C = '42'
                                     AND A.YUHYO_YN = 0 ) C,
                                 (SELECT DW_BAS_DDT TRX_DT,
                                    CASE WHEN DT_G = 0 THEN BIZ_DT ELSE BF1_BIZ_DT END BIZ_DT
                                    FROM MAP_JOB_DATE
                                    WHERE DW_BAS_DDT BETWEEN ( '2024' - 1 ) || '0101' AND ( '2024' - 1 ) || '1231') D
                           WHERE A.GONGGEUM_GYEJWA = B.GONGGEUM_GYEJWA
                             AND A.GONGGEUM_GYEJWA = C.GONGGEUM_GYEJWA
                             AND A.UNYONG_GYEJWA = B.UNYONG_GYEJWA
                             AND B.KIJUNIL = D.BIZ_DT
                             AND A.GEUMGO_CODE = '42'
                             AND SUBSTR(NVL(A.MKDT,A.IN_DATE),1,8) <= D.TRX_DT
                             AND (A.OUT_DATE IS NULL OR A.OUT_DATE > D.TRX_DT)
                             AND (A.HJI_DT IS NULL OR A.HJI_DT > D.TRX_DT)
                             AND A.BANK_GUBUN = 0
                             AND TO_NUMBER(SUBSTR(D.TRX_DT,1,4)) = '2024' - 1
                             AND SUBSTR(( '2024' - 1 ) || '0101',1,4) = '2024' - 1
                           GROUP BY C.HOIGYE_CODE, A.GONGGEUM_GYEJWA
                        ) A
                        , (SELECT COUNT(DW_BAS_DDT) DAYS_CNT
                             FROM MAP_JOB_DATE
                            WHERE DW_BAS_DDT BETWEEN ( '2024' - 1 ) || '0101' AND ( '2024' - 1 ) || '1231') B
                        , WT_GYEJWA_INFO C
                    WHERE C.GONGGEUM_GEUMGO_CD = '42'
                      AND C.GONGGEUM_GYEJWA <> '04200080900003999'
                      AND A.GONGGEUM_GYEJWA(+) =  C.GONGGEUM_GYEJWA
                      AND ((C.GONGGEUM_HOIGYE_YEAR = '2024' - 1 ) OR (C.GONGGEUM_HOIGYE_YEAR = '9999'))
                    GROUP BY A.HOIGYE_CODE, A.GONGGEUM_GYEJWA,C.GONGGEUM_GYEJWA, B.DAYS_CNT,C.GONGGEUM_GYEJWA_NM,C.GONGGEUM_HOIGYE_YEAR
                    ORDER BY A.HOIGYE_CODE, A.GONGGEUM_GYEJWA

 ;

 WITH WT_GYEJWA_INFO AS
       (
            SELECT T1.SIGUMGO_ORG_C AS GONGGEUM_GEUMGO_CD
                 , T1.SIGUMGO_GUN_GU_C AS GONGGEUM_GUNGU_CODE
                 , TO_NUMBER(T2.SIGUMGO_HOIKYE_C) AS GONGGEUM_HOIGYE_CODE
                 , T1.SIGUMGO_HOIKYE_YR AS GONGGEUM_HOIGYE_YEAR
                 , T1.SIGUMGO_ACNO AS GONGGEUM_GYEJWA
                 , T1.SIGUMGO_AC_NM AS GONGGEUM_GYEJWA_NM
                 , LPAD(LINKAC_KWA_C, 3, '0')||LPAD(LINKAC_SER, 9, '0') AS GONGGEUM_YUDONG_ACNO
                 , AC_GRBRNO AS GONGGEUM_BRNO
              FROM ACL_SIGUMGO_MAS_SUB T1
              INNER JOIN RPT_AC_BY_HOIKYE_MAPP T2
                      ON T1.SIGUMGO_ACNO = T2.SIGUMGO_ACNO
                     AND T1.SIGUMGO_ORG_C = T2.SIGUMGO_C
              WHERE T1.SIGUMGO_ORG_C = '42'
       )
SELECT HOIGYE_CODE,
                          C.GONGGEUM_GYEJWA,
                          C.GONGGEUM_GYEJWA_NM,
                          TRUNC( SUM(GONGGEUM) / B.DAYS_CNT, 0 )AS YECHI_JUNGGI_GONGGEUM,
                          TRUNC( SUM(UNYONG) / B.DAYS_CNT, 0 )AS YECHI_JUNGGI_JUCHUK,
                          TRUNC( SUM(MMDA) / B.DAYS_CNT, 0 )AS YECHI_JUNGGI_MMDA,
                          0 YECHI_DANGGI_GONGGEUM,
                          0 YECHI_DANGGI_JUCHUK,
                          0 YECHI_DANGGI_MMDA,
                          0 JUN_IJA,
                          0 DANG_IJA
                     FROM
                     (

                          SELECT   A.HOIGYE_CODE, A.GONGGEUM_GYEJWA, SUM(A.JANAEK) GONGGEUM, 0 UNYONG, 0 MMDA
                            FROM RPT_GONGGEUM_JAN A, (SELECT DW_BAS_DDT TRX_DT, CASE WHEN DT_G = 0 THEN BIZ_DT ELSE BF1_BIZ_DT END BIZ_DT
                                                        FROM MAP_JOB_DATE
                                                       WHERE DW_BAS_DDT BETWEEN ( '2024' - 1 ) || '0101' AND ( '2024' - 1 ) || '1231') D, WT_GYEJWA_INFO E
                           WHERE A.KEORAEIL = D.BIZ_DT
                             AND A.GUNGU_CODE = 0
                             AND ( ( A.HOIGYE_YEAR = '2024' - 1 ) OR
                                   ( A.HOIGYE_YEAR = 9999 AND TO_NUMBER(SUBSTR(D.TRX_DT,1,4)) = '2024' - 1 ) )
                             AND A.GEUMGO_CODE = '42'
                             AND A.GONGGEUM_GYEJWA = E.GONGGEUM_GYEJWA
                           GROUP BY A.HOIGYE_CODE, A.GONGGEUM_GYEJWA
                           UNION ALL

                          SELECT A.GONGGEUM_HOIGYE_CODE, A.GONGGEUM_GYEJWA, 0 GONGGEUM, SUM(C.JANAEK) UNYONG, 0 MMDA
                            FROM WT_GYEJWA_INFO A, RPT_UNYONG_GYEJWA B, RPT_UNYONG_JAN C,
                                 (SELECT DW_BAS_DDT TRX_DT, CASE WHEN DT_G = 0 THEN BIZ_DT ELSE BF1_BIZ_DT END BIZ_DT
                                    FROM MAP_JOB_DATE
                                   WHERE DW_BAS_DDT BETWEEN ( '2024' - 1 ) || '0101' AND ( '2024' - 1 ) || '1231') D
                           WHERE A.GONGGEUM_GYEJWA >= B.GONGGEUM_GYEJWA
                             AND SUBSTR(A.GONGGEUM_GYEJWA,1,15) = SUBSTR(B.GONGGEUM_GYEJWA,1,15)
                             AND B.GONGGEUM_GYEJWA = C.GONGGEUM_GYEJWA
                             AND ((A.GONGGEUM_HOIGYE_YEAR <> 9999 AND A.GONGGEUM_GYEJWA >= B.GONGGEUM_GYEJWA) OR
                                  (A.GONGGEUM_HOIGYE_YEAR = 9999  AND A.GONGGEUM_GYEJWA  = B.GONGGEUM_GYEJWA))
                             AND A.GONGGEUM_GUNGU_CODE = 0
                             AND B.GONGGEUM_GYEJWA IN (SELECT Z.GONGGEUM_GYEJWA
                                                         FROM WT_GYEJWA_INFO X, RPT_HOIGYE_IWOL Y, WT_GYEJWA_INFO Z
                                                        WHERE X.GONGGEUM_GEUMGO_CD = Y.GEUMGO_CODE
                                                          AND X.GONGGEUM_HOIGYE_CODE = Y.HOIGYE_CODE
                                                          AND X.GONGGEUM_GUNGU_CODE = Y.GUNGU_CODE
                                                          AND X.GONGGEUM_HOIGYE_YEAR = Y.HOIGYE_YEAR + 1
                                                          AND X.GONGGEUM_GEUMGO_CD = '42'
                                                          AND X.GONGGEUM_HOIGYE_YEAR = '2024' - 1
                                                          AND Y.GUBUN_CODE = 1
                                                          AND Y.KIJUNIL <= D.TRX_DT
                                                          AND X.GONGGEUM_GEUMGO_CD = Z.GONGGEUM_GEUMGO_CD
                                                          AND X.GONGGEUM_HOIGYE_CODE = Z.GONGGEUM_HOIGYE_CODE
                                                          AND X.GONGGEUM_GUNGU_CODE = Z.GONGGEUM_GUNGU_CODE
                                                          AND X.GONGGEUM_HOIGYE_YEAR > Z.GONGGEUM_HOIGYE_YEAR
                                                        UNION
                                                       SELECT A.GONGGEUM_GYEJWA
                                                         FROM WT_GYEJWA_INFO A
                                                        WHERE A.GONGGEUM_GEUMGO_CD = '42'
                                                          AND (    (A.GONGGEUM_HOIGYE_YEAR = '2024' - 1 )
                                                                OR (A.GONGGEUM_HOIGYE_YEAR = 9999 AND TO_NUMBER(SUBSTR(D.TRX_DT,1,4)) = '2024' - 1 ))
                                                      )
                             AND B.UNYONG_GYEJWA = C.UNYONG_GYEJWA
                             AND ( (A.GONGGEUM_HOIGYE_YEAR = '2024' - 1 ) OR
                                   (A.GONGGEUM_HOIGYE_YEAR = 9999 AND TO_NUMBER(SUBSTR(D.TRX_DT,1,4)) = '2024' - 1 ))
                             AND SUBSTR(NVL(B.MKDT,B.IN_DATE),1,8) <= D.TRX_DT
                             AND (B.OUT_DATE IS NULL OR B.OUT_DATE > D.TRX_DT)
                             AND (B.HJI_DT IS NULL OR B.HJI_DT > D.TRX_DT)
                             AND B.BANK_GUBUN = 0
                             AND C.KIJUNIL = D.BIZ_DT
                             AND A.GONGGEUM_GEUMGO_CD = '42'
                           GROUP BY A.GONGGEUM_HOIGYE_CODE, A.GONGGEUM_GYEJWA
                           UNION ALL

                          SELECT A.GONGGEUM_HOIGYE_CODE, A.GONGGEUM_GYEJWA, 0 GONGGEUM, 0 UNYONG, SUM(C.JANAEK) MMDA
                            FROM WT_GYEJWA_INFO A
                               , RPT_UNYONG_JAN C
                               , (SELECT DW_BAS_DDT TRX_DT, CASE WHEN DT_G = 0 THEN BIZ_DT ELSE BF1_BIZ_DT END BIZ_DT
                                    FROM MAP_JOB_DATE
                                   WHERE DW_BAS_DDT BETWEEN ( '2024' - 1 ) || '0101' AND ( '2024' - 1 ) || '1231') D
                           WHERE A.GONGGEUM_GYEJWA = C.GONGGEUM_GYEJWA
                             AND C.UNYONG_GYEJWA = '000000000000'
                             AND C.KIJUNIL = D.BIZ_DT
                             AND ( ( A.GONGGEUM_HOIGYE_YEAR = '2024' - 1 ) OR
                                   ( A.GONGGEUM_HOIGYE_YEAR = 9999 AND SUBSTR(( '2024' - 1 ) || '0101',1,4) = '2024' - 1 ) )
                             AND A.GONGGEUM_GEUMGO_CD = '42'
                           GROUP BY A.GONGGEUM_HOIGYE_CODE, A.GONGGEUM_GYEJWA
                           UNION ALL

                          SELECT C.HOIGYE_CODE, A.GONGGEUM_GYEJWA, 0 GONGGEUM, SUM(B.JANAEK) UNYONG, 0 MMDA
                            FROM RPT_UNYONG_GYEJWA A, RPT_UNYONG_JAN B,
                                 (SELECT A.REF_D_C + 900 HOIGYE_CODE, A.REF_D_NM GONGGEUM_GYEJWA
                                    FROM RPT_CODE_INFO A
                                   WHERE A.REF_L_C = 50
                                     AND A.REF_M_C = '42'
                                     AND A.YUHYO_YN = 0 ) C,
                                 (SELECT DW_BAS_DDT TRX_DT,
                                    CASE WHEN DT_G = 0 THEN BIZ_DT ELSE BF1_BIZ_DT END BIZ_DT
                                    FROM MAP_JOB_DATE
                                    WHERE DW_BAS_DDT BETWEEN ( '2024' - 1 ) || '0101' AND ( '2024' - 1 ) || '1231') D
                           WHERE A.GONGGEUM_GYEJWA = B.GONGGEUM_GYEJWA
                             AND A.GONGGEUM_GYEJWA = C.GONGGEUM_GYEJWA
                             AND A.UNYONG_GYEJWA = B.UNYONG_GYEJWA
                             AND B.KIJUNIL = D.BIZ_DT
                             AND A.GEUMGO_CODE = '42'
                             AND SUBSTR(NVL(A.MKDT,A.IN_DATE),1,8) <= D.TRX_DT
                             AND (A.OUT_DATE IS NULL OR A.OUT_DATE > D.TRX_DT)
                             AND (A.HJI_DT IS NULL OR A.HJI_DT > D.TRX_DT)
                             AND A.BANK_GUBUN = 0
                             AND TO_NUMBER(SUBSTR(D.TRX_DT,1,4)) = '2024' - 1
                             AND SUBSTR(( '2024' - 1 ) || '0101',1,4) = '2024' - 1
                           GROUP BY C.HOIGYE_CODE, A.GONGGEUM_GYEJWA
                        ) A
 , (SELECT COUNT(DW_BAS_DDT) DAYS_CNT
                             FROM MAP_JOB_DATE
                            WHERE DW_BAS_DDT BETWEEN '20240101' AND '20241231') B
                        , WT_GYEJWA_INFO C
                    WHERE C.GONGGEUM_GEUMGO_CD = '42'
                      AND C.GONGGEUM_GYEJWA <> '04200080900003999'
                      AND A.GONGGEUM_GYEJWA(+) =  C.GONGGEUM_GYEJWA
                      AND ((C.GONGGEUM_HOIGYE_YEAR = '2024' ) OR (C.GONGGEUM_HOIGYE_YEAR = '9999'))
                    GROUP BY A.HOIGYE_CODE, A.GONGGEUM_GYEJWA,C.GONGGEUM_GYEJWA, B.DAYS_CNT,C.GONGGEUM_GYEJWA_NM,C.GONGGEUM_HOIGYE_YEAR
;



       WITH WT_GYEJWA_INFO AS
       (
            SELECT T1.SIGUMGO_ORG_C AS GONGGEUM_GEUMGO_CD
                 , T1.SIGUMGO_GUN_GU_C AS GONGGEUM_GUNGU_CODE
                 , TO_NUMBER(T2.SIGUMGO_HOIKYE_C) AS GONGGEUM_HOIGYE_CODE
                 , T1.SIGUMGO_HOIKYE_YR AS GONGGEUM_HOIGYE_YEAR
                 , T1.SIGUMGO_ACNO AS GONGGEUM_GYEJWA
                 , T1.SIGUMGO_AC_NM AS GONGGEUM_GYEJWA_NM
                 , LPAD(LINKAC_KWA_C, 3, '0')||LPAD(LINKAC_SER, 9, '0') AS GONGGEUM_YUDONG_ACNO
                 , AC_GRBRNO AS GONGGEUM_BRNO
              FROM ACL_SIGUMGO_MAS_SUB T1
              INNER JOIN RPT_AC_BY_HOIKYE_MAPP T2
                      ON T1.SIGUMGO_ACNO = T2.SIGUMGO_ACNO
                     AND T1.SIGUMGO_ORG_C = T2.SIGUMGO_C
              WHERE T1.SIGUMGO_ORG_C = '42'
       )
SELECT A.HOIGYE_CODE,
                          A.GONGGEUM_GYEJWA,
                          A.GYEJWA_NAME,
                          0 YECHI_JUNGGI_GONGGEUM,
                          0 YECHI_JUNGGI_JUCHUK,
                          0 YECHI_JUNGGI_MMDA,
                          0 YECHI_DANGGI_GONGGEUM,
                          0 YECHI_DANGGI_JUCHUK,
                          0 YECHI_DANGGI_MMDA,
                          ROUND(SUM(A.JI_IJA) / 1000) AS  JUN_IJA,
                          0 DANG_IJA
                     FROM (
                          SELECT A.HOIGYE_CODE, A.GONGGEUM_GYEJWA, A.GYEJWA_NAME, A.SANGPUM_NAME,
                                 A.MKDT, A.DUDT, A.IYUL, A.JANAEK, A.KIJUNIL, A.JI_IJA
                            FROM (
                                  SELECT TRIM(A.KIJUNIL) KIJUNIL, A.GONGGEUM_GYEJWA,
                                         B.GONGGEUM_HOIGYE_CODE HOIGYE_CODE, B.GONGGEUM_HOIGYE_YEAR HOIGYE_YEAR,
                                         A.JANAEK, D.MKDT, A.DUDT, D.HJI_DT, D.BBK_BKKP_NM, D.PRDT_BKKP_NM, A.LST_TRXDT,
                                         A.IYUL, A.GEUMGO_CODE, A.IPAMT, A.JIAMT, A.JI_IJA,
                                         B.GONGGEUM_GYEJWA_NM GYEJWA_NAME, D.SANGPUM_NAME,

                                         CASE WHEN B.GONGGEUM_HOIGYE_YEAR = 9999 THEN TO_CHAR(SUBSTR(A.KIJUNIL,1,4))
                                              WHEN B.GONGGEUM_HOIGYE_YEAR = SUBSTR(A.KIJUNIL,1,4) THEN B.GONGGEUM_HOIGYE_YEAR
                                              WHEN SUBSTR(A.KIJUNIL,1,8) >= C.KIJUNIL THEN TO_CHAR(B.GONGGEUM_HOIGYE_YEAR + 1 )
                                              WHEN SUBSTR(A.KIJUNIL,1,8) <  C.KIJUNIL THEN B.GONGGEUM_HOIGYE_YEAR
                                              ELSE B.GONGGEUM_HOIGYE_YEAR END R_HOIGYE_YEAR
                                    FROM RPT_UNYONG_JAN A, WT_GYEJWA_INFO B, RPT_HOIGYE_IWOL C, RPT_UNYONG_GYEJWA D
                                   WHERE A.GONGGEUM_GYEJWA = B.GONGGEUM_GYEJWA
                                     AND A.GONGGEUM_GYEJWA = D.GONGGEUM_GYEJWA
                                     AND A.UNYONG_GYEJWA = D.UNYONG_GYEJWA
                                     AND A.KIJUNIL BETWEEN ( '2024' - 1 ) || '0101' AND ( '2024' - 1 ) || '1231'
                                     AND A.GEUMGO_CODE = '42'
                                     AND B.GONGGEUM_GEUMGO_CD = '42'
                                     AND B.GONGGEUM_GEUMGO_CD = D.GEUMGO_CODE
                                     AND B.GONGGEUM_HOIGYE_CODE = C.HOIGYE_CODE(+)
                                     AND B.GONGGEUM_HOIGYE_YEAR = C.HOIGYE_YEAR(+)
                                     AND B.GONGGEUM_GEUMGO_CD = C.GEUMGO_CODE(+)
                                     AND C.GUBUN_CODE(+) = 1
                                     AND A.JI_IJA > 0
                               ) A
                           WHERE A.R_HOIGYE_YEAR IN ('9999', '2024' - 1 )
                           UNION ALL
                          SELECT A.HOIGYE_CODE, A.GONGGEUM_GYEJWA, A.GYEJWA_NAME, B.SANGPUM_NAME,
                                 C.MKDT, C.DUDT, C.IYUL, C.JANAEK, TRIM(C.KIJUNIL) KIJUNIL, C.JI_IJA
                            FROM (
                                 SELECT A.REF_D_NM GONGGEUM_GYEJWA, A.REF_CTNT1 GYEJWA_NAME,
                                        A.REF_S_C MNGBR, TO_NUMBER(SUBSTR(A.REF_D_NM,4,3)) GUNGU_CODE,
                                        A.REF_D_C + 900 HOIGYE_CODE, 99 GYEJWA_BUNRYU
                                   FROM RPT_CODE_INFO A
                                  WHERE A.REF_L_C = 50
                                    AND A.REF_M_C = '42'
                                    AND A.YUHYO_YN = 0) A
                               , RPT_UNYONG_GYEJWA B, RPT_UNYONG_JAN C
                           WHERE A.GONGGEUM_GYEJWA = B.GONGGEUM_GYEJWA
                             AND A.GONGGEUM_GYEJWA = C.GONGGEUM_GYEJWA
                             AND B.UNYONG_GYEJWA = C.UNYONG_GYEJWA
                             AND SUBSTR(NVL(B.MKDT,B.IN_DATE),1,8) <= ( '2024' - 1 ) || '1231'
                             AND (B.OUT_DATE IS NULL OR B.OUT_DATE > ( '2024' - 1 ) || '0101' )
                             AND (B.HJI_DT IS NULL OR B.HJI_DT > ( '2024' - 1 ) || '0101' )
                             AND B.BANK_GUBUN = 0
                             AND C.KIJUNIL BETWEEN ( '2024' - 1 ) || '0101' AND ( '2024' - 1 ) || '1231'
                             AND C.JI_IJA > 0
                             AND ( 9999 = 9999 OR SUBSTR(C.KIJUNIL,1,4) = 9999 )
                        ) A
                    GROUP BY A.HOIGYE_CODE, A.GONGGEUM_GYEJWA, A.GYEJWA_NAME
                    ORDER BY A.HOIGYE_CODE, A.GONGGEUM_GYEJWA
;



              WITH WT_GYEJWA_INFO AS
       (
            SELECT T1.SIGUMGO_ORG_C AS GONGGEUM_GEUMGO_CD
                 , T1.SIGUMGO_GUN_GU_C AS GONGGEUM_GUNGU_CODE
                 , TO_NUMBER(T2.SIGUMGO_HOIKYE_C) AS GONGGEUM_HOIGYE_CODE
                 , T1.SIGUMGO_HOIKYE_YR AS GONGGEUM_HOIGYE_YEAR
                 , T1.SIGUMGO_ACNO AS GONGGEUM_GYEJWA
                 , T1.SIGUMGO_AC_NM AS GONGGEUM_GYEJWA_NM
                 , LPAD(LINKAC_KWA_C, 3, '0')||LPAD(LINKAC_SER, 9, '0') AS GONGGEUM_YUDONG_ACNO
                 , AC_GRBRNO AS GONGGEUM_BRNO
              FROM ACL_SIGUMGO_MAS_SUB T1
              INNER JOIN RPT_AC_BY_HOIKYE_MAPP T2
                      ON T1.SIGUMGO_ACNO = T2.SIGUMGO_ACNO
                     AND T1.SIGUMGO_ORG_C = T2.SIGUMGO_C
              WHERE T1.SIGUMGO_ORG_C = '42'
       )

                          SELECT A.GONGGEUM_HOIGYE_CODE, A.GONGGEUM_GYEJWA, 0 GONGGEUM, 0 UNYONG, SUM(C.JANAEK) MMDA
                            FROM WT_GYEJWA_INFO A
                               , RPT_UNYONG_JAN C
                               , (SELECT DW_BAS_DDT TRX_DT, CASE WHEN DT_G = 0 THEN BIZ_DT ELSE BF1_BIZ_DT END BIZ_DT
                                    FROM MAP_JOB_DATE
                                   WHERE DW_BAS_DDT BETWEEN ( '2024' - 1 ) || '0101' AND ( '2024' - 1 ) || '1231') D
                           WHERE A.GONGGEUM_GYEJWA = C.GONGGEUM_GYEJWA
                             AND C.UNYONG_GYEJWA = '000000000000'
                             AND C.KIJUNIL = D.BIZ_DT
                             AND ( ( A.GONGGEUM_HOIGYE_YEAR = '2024' - 1 ) OR
                                   ( A.GONGGEUM_HOIGYE_YEAR = 9999 AND SUBSTR(( '2024' - 1 ) || '0101',1,4) = '2024' - 1 ) )
                             AND A.GONGGEUM_GEUMGO_CD = '42'
                           GROUP BY A.GONGGEUM_HOIGYE_CODE, A.GONGGEUM_GYEJWA
                           ORDER BY A.GONGGEUM_HOIGYE_CODE, A.GONGGEUM_GYEJWA




                                 WITH WT_GYEJWA_INFO AS
       (
            SELECT T1.SIGUMGO_ORG_C AS GONGGEUM_GEUMGO_CD
                 , T1.SIGUMGO_GUN_GU_C AS GONGGEUM_GUNGU_CODE
                 , TO_NUMBER(T2.SIGUMGO_HOIKYE_C) AS GONGGEUM_HOIGYE_CODE
                 , T1.SIGUMGO_HOIKYE_YR AS GONGGEUM_HOIGYE_YEAR
                 , T1.SIGUMGO_ACNO AS GONGGEUM_GYEJWA
                 , T1.SIGUMGO_AC_NM AS GONGGEUM_GYEJWA_NM
                 , LPAD(LINKAC_KWA_C, 3, '0')||LPAD(LINKAC_SER, 9, '0') AS GONGGEUM_YUDONG_ACNO
                 , AC_GRBRNO AS GONGGEUM_BRNO
              FROM ACL_SIGUMGO_MAS_SUB T1
              INNER JOIN RPT_AC_BY_HOIKYE_MAPP T2
                      ON T1.SIGUMGO_ACNO = T2.SIGUMGO_ACNO
                     AND T1.SIGUMGO_ORG_C = T2.SIGUMGO_C
              WHERE T1.SIGUMGO_ORG_C = '42'
       )
                          SELECT A.IJA
                          FROM RPT_GONGGEUM_GYULSAN_TMP A,RPT_GONGGEUM_GYULSAN B,WT_GYEJWA_INFO C
                         WHERE A.GEUMGO_CODE = '42'
                           AND A.GEUMGO_CODE = B.GEUMGO_CODE
                           AND A.GUNGU_CODE  = B.GUNGU_CODE
                           AND A.GYULSAN_IL  = '2024' || '0101'
                           AND A.YUDONG_ACNO = B.YUDONG_ACNO
                           AND A.GYULSAN_IL  = B.GYULSAN_IL
                           AND A.GONGGEUM_GYEJWA =C.GONGGEUM_GYEJWA
                           AND A.IJA > 0
                           AND C.GONGGEUM_HOIGYE_CODE = 98
-- 이자지급보고서

SELECT A.HOIGYE_CODE
     , A.HOIGYE_NAME
     , A.GONGGEUM_GYEJWA
     , SUM(CASE WHEN KWA = '160' THEN A.JI_IJA ELSE 0 END) AS GONGGEUM_IJA
     , SUM(CASE WHEN KWA = '100' THEN A.JI_IJA ELSE 0 END) AS BOTONG_IJA
     , SUM(CASE WHEN KWA = '140' THEN A.JI_IJA ELSE 0 END) AS MMDA_IJA
     , SUM(CASE WHEN KWA BETWEEN '200' AND '299' THEN A.JI_IJA ELSE 0 END) AS JUNGGI_IJA
  FROM (
       WITH WT_GYEJWA_INFO AS
       (
            SELECT T2.SIGUMGO_C AS GONGGEUM_GEUMGO_CD
                 , T2.SIGUMGO_HOIKYE_YR AS GONGGEUM_HOIGYE_YEAR
                 , T2.SIGUMGO_ACNO AS GONGGEUM_GYEJWA
                 , TO_NUMBER(T2.SIGUMGO_HOIKYE_C) AS GONGGEUM_HOIGYE_CODE
                 , T3.HOIKYE_NM AS HOIGYE_NAME
              FROM  RPT_AC_BY_HOIKYE_MAPP T2
              INNER JOIN RPT_HOIKYE_CD T3
                      ON T2.SIGUMGO_C = T3.SIGUMGO_C
                     AND T2.SIGUMGO_HOIKYE_C = T3.SIGUMGO_HOIKYE_C
                     AND T3.SIGUMGO_HOIKYE_C != 98
                     AND T3.USE_YN = 'Y'
              WHERE T2.SIGUMGO_C = '42'
       )
        SELECT
          B.GONGGEUM_HOIGYE_CODE HOIGYE_CODE,
          B.HOIGYE_NAME,
          B.GONGGEUM_GYEJWA,
          '' AS GYEJWA_NAME,
          A.UNYONG_GYEJWA,
          D.SANGPUM_NAME,
          D.MKDT,
          A.DUDT,
          A.IYUL,
          A.JANAEK,
          TRIM(A.KIJUNIL) KIJUNIL,
          A.JI_IJA,
          SUBSTR(A.UNYONG_GYEJWA,1,3) AS KWA
        FROM RPT_UNYONG_JAN A, WT_GYEJWA_INFO B, RPT_HOIGYE_IWOL C, RPT_UNYONG_GYEJWA D
        WHERE A.GONGGEUM_GYEJWA = B.GONGGEUM_GYEJWA
        AND A.GONGGEUM_GYEJWA = D.GONGGEUM_GYEJWA
        AND A.UNYONG_GYEJWA = D.UNYONG_GYEJWA
        AND A.KIJUNIL BETWEEN '20230101' AND '20231231'
        AND A.GEUMGO_CODE = '42'
        AND A.GEUMGO_CODE = B.GONGGEUM_GEUMGO_CD
        AND A.GEUMGO_CODE = D.GEUMGO_CODE
        AND B.GONGGEUM_HOIGYE_CODE = C.HOIGYE_CODE(+)
        AND B.GONGGEUM_HOIGYE_YEAR = C.HOIGYE_YEAR(+)
        AND B.GONGGEUM_GEUMGO_CD = C.GEUMGO_CODE(+)
        AND C.GUBUN_CODE(+) = 1
        AND ('ALL' = NVL('','ALL') OR B.GONGGEUM_HOIGYE_CODE IN (''))
        AND A.JI_IJA > 0
        AND (
         'ALL' = NVL('2023','ALL')
          OR
          (
            CASE WHEN B.GONGGEUM_HOIGYE_YEAR = 9999 THEN SUBSTR(A.KIJUNIL,1,4)
                   WHEN B.GONGGEUM_HOIGYE_YEAR=SUBSTR(A.KIJUNIL,1,4) THEN B.GONGGEUM_HOIGYE_YEAR
                   WHEN SUBSTR(A.KIJUNIL,1,8) >= C.KIJUNIL THEN TO_CHAR(B.GONGGEUM_HOIGYE_YEAR + 1)
                   WHEN SUBSTR(A.KIJUNIL,1,8) <  C.KIJUNIL THEN B.GONGGEUM_HOIGYE_YEAR
                   ELSE B.GONGGEUM_HOIGYE_YEAR END
          ) = '2023')
        AND ('ALL' = NVL('','ALL') OR B.GONGGEUM_GYEJWA = '')
        AND ('ALL' = NVL('','ALL') OR B.GONGGEUM_HOIGYE_CODE IN (''))

       UNION ALL

      SELECT A.GONGGEUM_HOIGYE_CODE HOIGYE_CODE, A.HOIGYE_NAME,
             A.GONGGEUM_GYEJWA,
             '', '', '',
             '', '', 0, 0, '', 0, ''
        FROM WT_GYEJWA_INFO A
       WHERE 1 = 1
         AND (   ('ALL' = NVL('2023','ALL'))
              OR (A.GONGGEUM_HOIGYE_YEAR = '2023')
              OR (A.GONGGEUM_HOIGYE_YEAR='9999' AND SUBSTR('20230101',1,4) = '2023'))
         AND ('ALL' = NVL('','ALL') OR A.GONGGEUM_HOIGYE_CODE IN (''))
         AND ('ALL' = NVL('','ALL') OR A.GONGGEUM_GYEJWA  = '')

       UNION ALL

      SELECT A.HOIGYE_CODE, A.HOIGYE_NAME, A.GONGGEUM_GYEJWA, A.GYEJWA_NAME,
             B.UNYONG_GYEJWA, B.SANGPUM_NAME,
             C.MKDT, C.DUDT, C.IYUL, C.JANAEK, TRIM(C.KIJUNIL) KIJUNIL,
             C.JI_IJA, SUBSTR(B.UNYONG_GYEJWA,1,3) KWA
        FROM (SELECT A.REF_D_NM GONGGEUM_GYEJWA, A.REF_CTNT1 GYEJWA_NAME,
                     A.REF_CTNT1 HOIGYE_NAME, A.REF_S_C MNGBR,
                     TO_NUMBER(SUBSTR(A.REF_D_NM,4,3)) GUNGU_CODE,
                     A.REF_D_C + 900 HOIGYE_CODE, 99 GYEJWA_BUNRYU
                FROM  RPT_CODE_INFO A
               WHERE A.REF_L_C = 50
                 AND A.REF_M_C = '42'
                 AND A.YUHYO_YN = 0 ) A
           , RPT_UNYONG_GYEJWA B
           , RPT_UNYONG_JAN C
       WHERE A.GONGGEUM_GYEJWA = B.GONGGEUM_GYEJWA
         AND B.GONGGEUM_GYEJWA = C.GONGGEUM_GYEJWA
         AND A.GONGGEUM_GYEJWA = B.GONGGEUM_GYEJWA
         AND B.UNYONG_GYEJWA = C.UNYONG_GYEJWA
         AND SUBSTR(NVL(B.MKDT,B.IN_DATE),1,8) <= '20231231'
         AND (B.OUT_DATE IS NULL OR B.OUT_DATE > '20230101' )
         AND (B.HJI_DT IS NULL OR B.HJI_DT > '20230101')
         AND B.BANK_GUBUN = 0
         AND C.KIJUNIL BETWEEN '20230101' AND '20231231'
         AND C.JI_IJA > 0
         AND ('ALL' = NVL('2023','ALL') OR SUBSTR('20230101',1,4) = '2023')
         AND ('ALL' = NVL('','ALL') OR A.GONGGEUM_GYEJWA = '')
         AND ('ALL' = NVL('','ALL') OR A.HOIGYE_CODE IN (''))

       UNION ALL

      SELECT A.REF_D_C + 900 HOIGYE_CODE, A.REF_CTNT1 HOIGYE_NAME,
             A.REF_D_NM GONGGEUM_GYEJWA, '', '',
             '', '', '', 0, 0, '', 0, ''
        FROM RPT_CODE_INFO A
       WHERE A.REF_L_C = 50
         AND A.REF_M_C = '42'
         AND ('ALL' = NVL('2023','ALL') OR SUBSTR('20230101',1,4) = '2023')
         AND ('ALL' = NVL('','ALL') OR A.REF_D_NM = '')
         AND ('ALL' = NVL('','ALL') OR (A.REF_D_C + 900) IN (''))

        UNION ALL

     SELECT
     C.GONGGEUM_HOIGYE_CODE, C.HOIGYE_NAME,
  C.GONGGEUM_GYEJWA, '',  '',
  '', '', '', 0, 0, '', A.IJA AS JI_IJA, '160' AS KWA
          FROM RPT_GONGGEUM_GYULSAN_TMP A, WT_GYEJWA_INFO C
         WHERE A.GEUMGO_CODE = '42'
           AND A.GYULSAN_IL IN (SELECT REF_S_NM FROM RPT_CODE_INFO WHERE REF_L_C = 200 AND REF_M_C = 999 AND REF_S_NM BETWEEN '20230101' AND '20231231')
           AND A.GONGGEUM_GYEJWA = C.GONGGEUM_GYEJWA
           AND A.IJA  > 0
           AND ('ALL' = NVL('2023','ALL') OR SUBSTR(A.GONGGEUM_GYEJWA,16,2) IN (SUBSTR('2023',3,2),99))

     ) A
 GROUP BY A.HOIGYE_CODE, A.HOIGYE_NAME, A.GONGGEUM_GYEJWA
 ORDER BY A.HOIGYE_CODE, A.HOIGYE_NAME, A.GONGGEUM_GYEJWA
;

SELECT * FROM RPT_UNYONG_GYEJWA
WHERE GONGGEUM_GYEJWA = '04200080900000099'








