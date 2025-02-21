-- 세입세출일계표 2025.01.31 총괄 하수도

SELECT LPAD(REF_D_C,4,'0') GUNGU_CODE, REF_D_NM GUNGU_NM, NVL(DATA_ROW,1) AS DATA_ROW,
       SUM(NVL(AMT1 , 0)) AMT1 , SUM(NVL(AMT2 , 0)) AMT2 , SUM(NVL(AMT3 , 0)) AMT3 ,
       SUM(NVL(AMT4 , 0)) AMT4 , SUM(NVL(AMT5 , 0)) AMT5 , SUM(NVL(AMT6 , 0)) AMT6 ,
       SUM(NVL(AMT7 , 0)) AMT7 , SUM(NVL(AMT8 , 0)) AMT8 , SUM(NVL(AMT9 , 0)) AMT9 ,
       SUM(NVL(AMT10, 0)) AMT10, SUM(NVL(AMT11, 0)) AMT11, SUM(NVL(AMT12, 0)) AMT12,
       SUM(NVL(AMT13, 0)) AMT13, SUM(NVL(AMT14, 0)) AMT14, SUM(NVL(AMT15, 0)) AMT15,
       SUM(NVL(AMT16, 0)) AMT16, SUM(NVL(AMT17, 0)) AMT17, SUM(NVL(AMT18, 0)) AMT18,
       SUM(NVL(AMT19, 0)) AMT19, SUM(NVL(AMT20, 0)) AMT20, SUM(NVL(AMT21, 0)) AMT21,
       SUM(NVL(AMT22, 0)) AMT22, SUM(NVL(AMT23, 0)) AMT23, SUM(NVL(AMT24, 0)) AMT24,
       SUM(NVL(AMT25, 0)) AMT25, SUM(NVL(AMT26, 0)) AMT26, SUM(NVL(AMT27, 0)) AMT27,
       SUM(NVL(AMT28, 0)) AMT28
FROM  (
          SELECT GUNGU_CODE
               , DATA_ROW
               , AMT1,  AMT2,  AMT3,  AMT4,  AMT5,  AMT6,  AMT7,  AMT8,  AMT9,  AMT10
               , AMT11, AMT12, AMT13, AMT14, AMT15, AMT16, AMT17, AMT18, AMT19, AMT20
               , AMT21, AMT22, AMT23, AMT24, AMT25, AMT26, AMT27, AMT28
          FROM (
                   SELECT  CASE WHEN GUNGU_CODE = 0  THEN 7100
                                WHEN GUNGU_CODE = 7000 THEN 7100
                                WHEN GUNGU_CODE < 7000 THEN GUNGU_CODE + 7000
                                WHEN GUNGU_CODE > 7000 THEN GUNGU_CODE
                       END  GUNGU_CODE
                        , DATA_ROW
                        , AMT1,  AMT2,  AMT3,  AMT4,  AMT5,  AMT6,  AMT7,  AMT8,  AMT9,  AMT10
                        , AMT11, AMT12, AMT13, AMT14, AMT15, AMT16, AMT17, AMT18, AMT19, AMT20
                        , AMT21, AMT22, AMT23, AMT24, AMT25, AMT26, AMT27, AMT28
                   FROM
                       (
                           SELECT
                               ICH_SIGUMGO_GUN_GU_C GUNGU_CODE,
                               1 DATA_ROW,
                               SUM(CASE WHEN (SUNAP_DT = '20250131')  THEN NVL(JIBANGSE_AMT,0) ELSE 0 END ) AMT1,
                               SUM(CASE WHEN (SUNAP_DT = '20250131' )  THEN NVL(JIBANGSE_GWAON_AMT,0) ELSE 0 END ) AMT2,
                               SUM(CASE WHEN (SUNAP_DT = '20250131' )  THEN NVL(JIBANGSE_CRT_AMT,0) ELSE 0 END ) AMT3,
                               SUM(CASE WHEN (SUNAP_DT = '20250131' )  THEN NVL(SEWOI_AMT,0) ELSE 0 END ) AMT4,
                               SUM(CASE WHEN (SUNAP_DT = '20250131' )  THEN NVL(SEWOI_GWAON_AMT,0) ELSE 0 END ) AMT5,
                               SUM(CASE WHEN (SUNAP_DT = '20250131' )  THEN NVL(SEWOI_CRT_AMT,0) ELSE 0 END ) AMT6,
                               SUM(CASE WHEN (SUNAP_DT = '20250131' )  THEN NVL(GYOYUKSE_AMT,0) ELSE 0 END ) AMT7,
                               SUM(CASE WHEN (SUNAP_DT = '20250131' )  THEN NVL(GYOYUKSE_GWAON_AMT,0) ELSE 0 END ) AMT8,
                               SUM(CASE WHEN (SUNAP_DT = '20250131' )  THEN NVL(GYOYUKSE_CRT_AMT,0) ELSE 0 END ) AMT9,
                               SUM(CASE WHEN (SUNAP_DT = '20250131' )  THEN NVL(NONGTEUKSE_AMT,0) ELSE 0 END ) AMT10,
                               SUM(CASE WHEN (SUNAP_DT = '20250131' )  THEN NVL(NONGTEUKSE_GWAON_AMT,0) ELSE 0 END ) AMT11,
                               SUM(CASE WHEN (SUNAP_DT = '20250131' )  THEN NVL(NONGTEUKSE_CRT_AMT,0) ELSE 0 END ) AMT12,
                               SUM(NVL(JIBANGSE_AMT,0) ) AMT13,
                               SUM(NVL(JIBANGSE_GWAON_AMT,0)) AMT14,
                               SUM(NVL(JIBANGSE_CRT_AMT,0 ) )AMT15,
                               SUM(SEWOI_AMT) AMT16,
                               SUM(SEWOI_GWAON_AMT) AMT17,
                               SUM(SEWOI_CRT_AMT) AMT18,
                               SUM(GYOYUKSE_AMT) AMT19,
                               SUM(GYOYUKSE_GWAON_AMT) AMT20,
                               SUM(GYOYUKSE_CRT_AMT) AMT21,
                               SUM(NONGTEUKSE_AMT) AMT22,
                               SUM(NONGTEUKSE_GWAON_AMT) AMT23,
                               SUM(NONGTEUKSE_CRT_AMT) AMT24,
                               SUM(   CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20250131',0,6) || '01' AND '20250131')  THEN NVL(JIBANGSE_AMT,0) ELSE 0 END
                                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20250131',0,6) || '01' AND '20250131')  THEN NVL(JIBANGSE_GWAON_AMT,0) *-1 ELSE 0 END
                                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20250131',0,6) || '01' AND '20250131')  THEN NVL(JIBANGSE_CRT_AMT,0)  ELSE 0 END
                               ) AMT25,
                               SUM(  CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20250131',0,6) || '01' AND '20250131')  THEN NVL(SEWOI_AMT,0) ELSE 0 END
                                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20250131',0,6) || '01' AND '20250131')  THEN NVL(SEWOI_GWAON_AMT,0) *-1 ELSE 0 END
                                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20250131',0,6) || '01' AND '20250131')  THEN NVL(SEWOI_CRT_AMT,0)  ELSE 0 END
                               ) AMT26,
                               SUM(  CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20250131',0,6) || '01' AND '20250131')  THEN NVL(GYOYUKSE_AMT,0) ELSE 0 END
                                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20250131',0,6) || '01' AND '20250131')  THEN NVL(GYOYUKSE_GWAON_AMT,0) *-1 ELSE 0 END
                                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20250131',0,6) || '01' AND '20250131')  THEN NVL(GYOYUKSE_CRT_AMT,0)  ELSE 0 END
                               ) AMT27,
                               SUM(  CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20250131',0,6) || '01' AND '20250131')  THEN NVL(NONGTEUKSE_AMT,0) ELSE 0 END
                                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20250131',0,6) || '01' AND '20250131')  THEN NVL(NONGTEUKSE_GWAON_AMT,0) *-1 ELSE 0 END
                                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20250131',0,6) || '01' AND '20250131')  THEN NVL(NONGTEUKSE_CRT_AMT,0)  ELSE 0 END
                               ) AMT28
                           FROM RPT_TXI_DDAC_TAB
                           WHERE 1=1
                             AND SIGUMGO_ORG_C = '28'
                             AND SUNAP_DT BETWEEN '20250101' AND '20250131'
                             AND ICH_SIGUMGO_HOIKYE_C IN ('22', 62)
                             AND SIGUTAX_G = NVL('', '1')
                             AND  (  ( '22' =  22  AND ICH_SIGUMGO_HOIKYE_C IN (22, 62, 209332) ) OR
                                     ( '22' =  213000  AND ICH_SIGUMGO_HOIKYE_C IN (213000, 217100) ) OR
                                     ( '22' =  99 )  OR
                                     ( '22' NOT IN (22,213000,99) AND ICH_SIGUMGO_HOIKYE_C = '22' ) )
                             AND  (  ( '22' = 22 AND '' = 0 AND ICH_SIGUMGO_GUN_GU_C  IN (7000, 7040, 7810, 7055, 7830, 7840, 7850, 7100, 0) )
                               OR ( '22' IN (21,22,93) AND DECODE('', '', 9999, '') = 9999 )
                               OR ( '22' = 22 AND DECODE('', '', 9999, '') NOT IN (0,9999) AND ( CASE WHEN ICH_SIGUMGO_GUN_GU_C = 7100 THEN  0
                                                                                                      WHEN ICH_SIGUMGO_GUN_GU_C > 7100 AND ICH_SIGUMGO_GUN_GU_C < 7800 THEN ICH_SIGUMGO_GUN_GU_C - 7000 ELSE ICH_SIGUMGO_GUN_GU_C END) = DECODE(DECODE('', '', 9999, ''), 9999, ICH_SIGUMGO_GUN_GU_C, '') )
                               OR ('22' IN ( 21,93) AND '' = 7100 AND ICH_SIGUMGO_GUN_GU_C  IN (0, 7000, 100, 7100) )
                               OR ('22' IN ( 21,93) AND '' <> 7100 AND ICH_SIGUMGO_GUN_GU_C IN ('', SUBSTR('',2,3)) )
                               OR ('22' NOT IN (21,22,93) AND ICH_SIGUMGO_GUN_GU_C  = DECODE(DECODE('', '', 9999, ''), 9999, ICH_SIGUMGO_GUN_GU_C, '') ) )
                             AND (
                               (
                                   '0' = 1
                                       AND
                                   SUNAP_DT >= SUBSTR('20250131',1,4)||'0101'
                                       AND
                                   NEW_GU_YR_G = 1
                                   )
                                   OR  (
                                   '0' = 9
                                       AND
                                   SUBSTR('20250131',5,2) < 3
                                       AND
                                   SUNAP_DT >= (SUBSTR('20250131',1,4) - 1 )||'0301' AND NEW_GU_YR_G = 9
                                   )
                                   OR  (
                                   '0' = 9
                                       AND
                                   SUBSTR('20250131',5,2) >= 3
                                       AND
                                   SUNAP_DT >= (SUBSTR('20250131',1,4))||'0301' AND  NEW_GU_YR_G = 9
                                   )
                                   OR  (
                                   '0' = 5
                                       AND
                                   SUBSTR('20250131',5,2) < 3
                                       AND
                                   SUNAP_DT >= (SUBSTR('20250131',1,4) - 1 )||'0301' AND NEW_GU_YR_G = 5
                                   )
                                   OR  (
                                   '0' = 5
                                       AND
                                   SUBSTR('20250131',5,2) >= 3
                                       AND
                                   SUNAP_DT >= (SUBSTR('20250131',1,4))||'0301' AND  NEW_GU_YR_G = 5
                                   )
                                   OR (
                                   (
                                       '0' = 8
                                           AND
                                       SUBSTR('20250131',5,2) < 3
                                           AND
                                       SUNAP_DT BETWEEN  (SUBSTR('20250131',1,4) - 1 )||'0100' AND (SUBSTR('20250131',1,4) - 1 )||'0100'
                                           AND
                                       NEW_GU_YR_G = 1
                                       )
                                       OR
                                   (
                                       '0' = 8
                                           AND
                                       SUBSTR('20250131',5,2) < 3
                                           AND
                                       SUNAP_DT BETWEEN (SUBSTR('20250131',1,4) - 1 )||'0301' AND '20250131'
                                           AND
                                       NEW_GU_YR_G <> 1
                                       )
                                       OR
                                   (
                                       '0' = 8
                                           AND
                                       SUBSTR('20250131',5,2) >= 3
                                           AND
                                       SUNAP_DT BETWEEN SUBSTR('20250131',1,4)||'0301' AND '20250131'
                                           AND
                                       NEW_GU_YR_G <> 1
                                       )
                                   )
                                   OR (

                                   '0' = 0
                                       AND
                                   SUNAP_DT >= SUBSTR('20250131',1,4)

                                   )
                                   OR (

                                   (
                                       '0' = 7
                                           AND
                                       SUNAP_DT >= SUBSTR('20250131',1,4)
                                           AND
                                       NEW_GU_YR_G = 1
                                       )
                                       OR
                                   (
                                       '0' = 7
                                           AND
                                       SUBSTR('20250131',5,2) < 3
                                           AND
                                       SUNAP_DT BETWEEN (SUBSTR('20250131',1,4) - 1 )||'0301' AND '20250131'
                                           AND
                                       NEW_GU_YR_G <> 1
                                       )
                                       OR
                                   (
                                       '0' = 7
                                           AND
                                       SUBSTR('20250131',5,2) >= 3
                                           AND
                                       SUNAP_DT BETWEEN SUBSTR('20250131',1,4)||'0301' AND '20250131'
                                           AND
                                       NEW_GU_YR_G <> 1
                                       )

                                   )
                               )
                           GROUP BY ICH_SIGUMGO_GUN_GU_C
                           UNION ALL
                           SELECT TO_NUMBER(GUNGU_CD) GUNGU_CODE, 1 AS DATA_ROW,
                                  0 AMT1 , 0 AMT2 , 0 AMT3 ,
                                  SUM(CASE WHEN SUNP_DT = '20250131' THEN NVL(NAPBU_SIDO_TAX_AMT,0) ELSE 0 END) AMT4 , 0 AMT5 , 0 AMT6 ,
                                  0 AMT7 , 0 AMT8 , 0 AMT9 ,
                                  0 AMT10, 0 AMT11, 0 AMT12,
                                  0 AMT13, 0 AMT14, 0 AMT15,
                                  SUM(NVL(NAPBU_SIDO_TAX_AMT,0)) AMT16, 0 AMT17, 0 AMT18,
                                  0 AMT19, 0 AMT20, 0 AMT21,
                                  0 AMT22, 0 AMT23, 0 AMT24,
                                  0 AMT25,
                                  SUM(CASE WHEN (SUNP_DT BETWEEN '202501' || '01' AND '20250131') THEN NVL(NAPBU_SIDO_TAX_AMT,0) ELSE 0 END) AMT26,
                                  0 AMT27,
                                  0 AMT28
                           FROM
                               (
                                   SELECT SUNP_DT,
                                          CASE  WHEN NEW_GU_YR_G = 1 THEN 1 WHEN NEW_GU_YR_G = 2 THEN 9  ELSE  99 END YEAR_GUBUN,
                                          HOIKYE_CD, SMOK_CD,
                                          CASE WHEN CVT_GUCHUNG_CD = '357' THEN '710'
                                               WHEN CVT_GUCHUNG_CD = '358' THEN '720'
                                               ELSE CVT_GUCHUNG_CD END AS GUNGU_CD,
                                          NAPBU_TCNT, NAPBU_NTAX_AMT, NAPBU_SIDO_TAX_AMT, NAPBU_SIGNGU_TAX_AMT
                                   FROM NIO_STAX_MASTR_TAB
                                   WHERE SUNP_DT BETWEEN '2025' || '0101' AND '20250131' AND FORM_G <> '1' AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND SIDO_CD <> '628' AND (SUBSTR(SMOK_CD,1,3)  <> '299' OR   SUBSTR(SMOK_CD,4,3) <> '099')
                                     AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358') AND HOIKYE_CD = '51' AND SMOK_CD = '281020'
                                   UNION ALL
                                   SELECT A.SUNP_DT SUNP_DT,
                                          CASE  WHEN NEW_GU_YR_G = 1 THEN 1  WHEN NEW_GU_YR_G = 2 THEN 9  ELSE  99 END YEAR_GUBUN,
                                          A.HOIKYE_CD HOIKYE_CD, A.SMOK_CD SMOK_CD,
                                          CASE WHEN CVT_GUCHUNG_CD = '357' THEN '710'
                                               WHEN CVT_GUCHUNG_CD = '358' THEN '720'
                                               ELSE CVT_GUCHUNG_CD  END AS GUNGU_CD,
                                          A.NAPBU_TCNT NAPBU_TCNT, A.NAPBU_NTAX_AMT NAPBU_NTAX_AMT, A.NAPBU_SIDO_TAX_AMT NAPBU_SIDO_TAX_AMT, A.NAPBU_SIGNGU_TAX_AMT NAPBU_SIGNGU_TAX_AMT
                                   FROM NIO_STAX_MASTR_TAB A, NIO_DEPT_INF_TAB B
                                   WHERE A.SUNP_DT BETWEEN '2025' || '0101' AND '20250131'  AND FORM_G <> '1' AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND SIDO_CD = '628' AND (SUBSTR(A.SMOK_CD,1,3) <> '299' OR  SUBSTR(A.SMOK_CD,4,3) <> '099')
                                     AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358') AND A.HOIKYE_CD = '51' AND A.SMOK_CD = '281020'
                                     AND A.SIDO_CD = B.GUCHUNG_CD(+) AND A.DEPT_CD = B.DEPT_CD(+) AND A.HOIKYE_CD = B.HOIKYE_CD(+) AND A.SMOK_CD = B.SMOK_CD(+)
                                   UNION ALL
                                   SELECT
                                       SUNP_DT,
                                       CASE  WHEN NEW_GU_YR_G = 1 THEN 1 WHEN NEW_GU_YR_G = 2 THEN 9  ELSE  99 END YEAR_GUBUN,
                                       HOIKYE_CD,
                                       SMOK_CD,
                                       CASE WHEN CVT_GUCHUNG_CD = '357' THEN '710'
                                            WHEN CVT_GUCHUNG_CD = '358' THEN '720'
                                            ELSE CVT_GUCHUNG_CD END  AS GUNGU_CD,
                                       NAPBU_TCNT,
                                       NVL(SUM(국세), 0) AS NAPBU_NTAX_AMT, NVL(SUM(시도세),0) AS NAPBU_SIDO_TAX_AMT, NVL(SUM(시군세),0) AS NAPBU_SIGNGU_TAX_AMT
                                   FROM
                                       (
                                           SELECT
                                               BLK_NO, PROC_SEQ, SUNP_DT, NEW_GU_YR_G,
                                               HOIKYE_CD, SMOK_CD,
                                               CVT_GUCHUNG_CD,
                                               NAPBU_TCNT,
                                               CASE WHEN FILLER2 = '1' THEN NTAX_AMT + SIDO_TAX_AMT + SIGNGU_TAX_AMT - NAPGILT_AMT END AS 국세,
                                               CASE WHEN FILLER2 = '2' THEN NTAX_AMT + SIDO_TAX_AMT + SIGNGU_TAX_AMT - NAPGILT_AMT END AS 시도세,
                                               CASE WHEN FILLER2 = '3' THEN NTAX_AMT + SIDO_TAX_AMT + SIGNGU_TAX_AMT - NAPGILT_AMT END AS 시군세
                                           FROM NIO_STAX_MASTR_TAB
                                           WHERE SUNP_DT BETWEEN '2025' || '0101' AND '20250131'  AND FILLER2 > '0' AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND FORM_G <> '1'
                                             AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358') AND HOIKYE_CD = '51' AND SMOK_CD = '281020'
                                       )
                                   GROUP BY SUNP_DT, NEW_GU_YR_G, HOIKYE_CD, SMOK_CD,CVT_GUCHUNG_CD, NAPBU_TCNT
                                   UNION ALL
                                   SELECT
                                       SUNP_DT,
                                       CASE  WHEN NEW_GU_YR_G = 1 THEN 1  WHEN NEW_GU_YR_G = 2 THEN 9
                                             ELSE  99 END YEAR_GUBUN,
                                       HOIKYE_CD,
                                       SMOK_CD,
                                       CASE WHEN CVT_GUCHUNG_CD = '357' THEN '710'
                                            WHEN CVT_GUCHUNG_CD = '358' THEN '720'
                                            ELSE CVT_GUCHUNG_CD END  AS GUNGU_CD,
                                       NAPBU_TCNT,
                                       NVL(SUM(NAPBU_NTAX_AMT), 0) AS NAPBU_NTAX_AMT, NVL(SUM(NAPBU_SIDO_TAX_AMT), 0) AS NAPBU_SIDO_TAX_AMT, NVL(SUM(NAPBU_SIGNGU_TAX_AMT), 0) AS NAPBU_SIGNGU_TAX_AMT
                                   FROM
                                       (
                                           SELECT SUNP_DT, NEW_GU_YR_G, HOIKYE_CD, SMOK_CD,
                                                  CVT_GUCHUNG_CD, NAPBU_TCNT, NAPBU_NTAX_AMT, NAPBU_SIDO_TAX_AMT, NAPBU_SIGNGU_TAX_AMT
                                           FROM  NIO_STAX_MASTR_TAB
                                           WHERE SUNP_DT BETWEEN '2025' || '0101' AND '20250131'
                                             AND SUBSTR(SMOK_CD,1,3) = '299' AND SUBSTR(SMOK_CD,4,3)  = '099'
                                             AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND FORM_G <> '1'
                                             AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358')
                                             AND HOIKYE_CD = '51' AND SMOK_CD = '281020'
                                       )
                                   GROUP BY SUNP_DT, NEW_GU_YR_G, HOIKYE_CD, SMOK_CD,CVT_GUCHUNG_CD,NAPBU_TCNT
                               )
                           WHERE 1 = 1
                             AND (
                               (
                                   '1' = (CASE WHEN LENGTH(TRIM(NVL('', ''))) IS NULL THEN '1' ELSE '0' END)
                                   )
                                   OR
                               (
                                   '1' = (CASE WHEN GUNGU_CD = '' THEN '1' ELSE '0' END)
                                   )
                               )
                           GROUP BY GUNGU_CD
                           UNION ALL
                           SELECT  9999 ICH_SIGUMGO_GUN_GU_C, 2 DATA_ROW,
                                   SUM(CASE WHEN  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE BAS_DT END) = '20250131'  THEN  BIZPLC_BAEJUNG_JI_AMT ELSE 0  END)
                                       +SUM(CASE WHEN  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE BAS_DT END) = '20250131'  THEN  BIZPLC_GAM_BAEJUNG_IP_AMT ELSE 0  END) AMT1,
                                   SUM(CASE WHEN  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE BAS_DT END) = '20250131' THEN  TAXO_FUND_BAEJUNG_JI_AMT+TAXO_HNDO_BAEJUNG_JI_AMT+TAXO_FUND_GETBK_JI_AMT
                                       +TAXO_HNDO_JICHUL_JI_AMT+TAXO_HNDO_GETBK_JI_AMT ELSE 0 END) AMT2,
                                   SUM(CASE WHEN  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE BAS_DT END) = '20250131' THEN  TAXO_RTRN_AMT ELSE 0 END)*-1 AMT3,
                                   0 AMT4,  0 AMT5,  0 AMT6,  0 AMT7,  0 AMT8,  0 AMT9,  0 AMT10, 0 AMT11, 0 AMT12,
                                   SUM(CASE WHEN SIGUMGO_AC_B = 10 THEN  BIZPLC_BAEJUNG_JI_AMT ELSE 0 END)
                                       +SUM(BIZPLC_GAM_BAEJUNG_IP_AMT) AMT13,
                                   SUM(TAXO_FUND_BAEJUNG_JI_AMT+TAXO_HNDO_BAEJUNG_JI_AMT+TAXO_FUND_GETBK_JI_AMT
                                       +TAXO_HNDO_JICHUL_JI_AMT+TAXO_HNDO_GETBK_JI_AMT) AMT14,
                                   SUM(TAXO_RTRN_AMT)*-1 AMT15,
                                   SUM(CASE WHEN '1' < 3 AND '0' = 1 AND '2025' < 2007 THEN  GA_IWOL_JI_AMT
                                            WHEN '1' < 3 AND '0' = 1 AND '2025' >=2007 THEN  GA_IWOL_JI_AMT-GA_IWOL_IP_AMT
                                            WHEN '1' < 3 AND '0' != 1 AND '2025' < 2007  AND (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END)  > '2025' || '0100' THEN GA_IWOL_JI_AMT
                                       WHEN '1' < 3 AND '0' != 1 AND '2025' >=2007 AND (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END)  > '2025' || '0100' THEN GA_IWOL_JI_AMT-GA_IWOL_IP_AMT
                      WHEN '1' >= 3 THEN 0
                 END) AMT16,
                                   0 AMT17,
                                   SUM(PMNY_JAN_MVO_AMT-PMNY_JAN_MVI_AMT) AMT18,
                                   0 AMT19, 0 AMT20, 0 AMT21, 0 AMT22, 0 AMT23, 0 AMT24,
                                   0 AMT25, 0 AMT26, 0 AMT27, 0 AMT28
                           FROM  RPT_TXIO_DDAC_TAB A
                           WHERE  1=1
                             AND (NVL('', 1) = 1 AND A.SGG_ACNO != '02810022100000099'
                    OR NVL('', 1) != 1)
                             AND A.SIGUMGO_ORG_C  = 28
                             AND (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END) BETWEEN SUBSTR('202401',0,4) || '0101' AND '20250131'
                             AND A.ICH_SIGUMGO_HOIKYE_C = '22'
                             AND (
                               (
                                   '1' = (CASE WHEN LENGTH(TRIM(NVL('', ''))) IS NULL THEN '1' ELSE '0' END)
                                   )
                                   OR
                               (
                                   '1' = (CASE WHEN ICH_SIGUMGO_GUN_GU_C = '' THEN '1' ELSE '0' END)
                                   )
                               )
                             AND(
                               ('1' = (CASE WHEN '0' = 1 AND (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END) >= '2025' AND (NEW_GU_YR_G ='0' OR SIGUMGO_HOIKYE_YR= 9999 ) THEN  '1' ELSE '0' END))
                                   OR ('1' = (CASE WHEN '0' IN (5,9) AND '1' <3  AND  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END) >= ('2025')-1 || '0301' AND NEW_GU_YR_G ='0'  THEN  '1' ELSE '0' END))
                                   OR ('1' = (CASE WHEN '0' IN (5,9) AND '1' >=3  AND  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END) >= '2025' AND NEW_GU_YR_G ='0'  THEN  '1' ELSE '0' END))
                                   OR (
                                   ('1' = (CASE WHEN '0' = 8 AND '1' <3  AND  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END) BETWEEN ('2025')-1 || '0100' AND ('2025')-1 || '1231' AND NEW_GU_YR_G ='0'  THEN  '1' ELSE '0' END))
                                       OR
                                   ('1' = (CASE WHEN '0' = 8 AND '1' <3  AND  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END) >= ('2025')-1 || '0301'  AND NEW_GU_YR_G <> '0'  THEN  '1' ELSE '0' END))
                                   )
                                   OR ('1' = (CASE WHEN '0' = 8 AND '1' >=3  AND  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END) >= '2025' AND NEW_GU_YR_G <> '0'  THEN  '1' ELSE '0' END))
                                   OR ('1' = (CASE WHEN '0' = 0 AND  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END) >= '2025' THEN  '1' ELSE '0' END))
                                   OR ('1' = (CASE WHEN '0' = 7 AND '1' <3  AND  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END) >= '2025' THEN  '1' ELSE '0' END))
                                   OR ('1' = (CASE WHEN '0' = 7 AND '1' >=3  AND  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END) >= '2025' AND NEW_GU_YR_G =1 THEN  '1' ELSE '0' END))
                               )
                             AND A.SIGUMGO_AC_B IN('10','20')
                           UNION ALL
                           SELECT  9999 GUNGU_CODE, 2 DATA_ROW,
                                   0 AMT1,  0 AMT2,  0 AMT3,  0 AMT4,  0 AMT5,  0 AMT6,  0 AMT7,  0 AMT8,
                                   0 AMT9,  0 AMT10, 0 AMT11, 0 AMT12, 0 AMT13, 0 AMT14, 0 AMT15, 0 AMT16,
                                   SUM(DEP_MK_JI_AMT-DEP_HJI_AMT) AMT17,
                                   0 AMT18, 0 AMT19, 0 AMT20, 0 AMT21, 0 AMT22, 0 AMT23, 0 AMT24,
                                   0 AMT25, 0 AMT26, 0 AMT27, 0 AMT28
                           FROM  RPT_TXIO_DDAC_TAB A
                           WHERE  1=1
                             AND (NVL('', 1) = 1 AND A.SGG_ACNO != '02810022100000099'
                    OR NVL('', 1) != 1)
                             AND A.SIGUMGO_ORG_C = 28
                             AND A.ICH_SIGUMGO_HOIKYE_C = '22'
                             AND
                               (
                                   (
                                       ('1' = (CASE WHEN '1' < 3  AND '22' IN(1,30) AND '0' = 7 AND  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END) <  SUBSTR('20250131',0,4) || '0100' THEN  '1' ELSE '0' END))
                                           OR
                                       ('1' = (CASE WHEN '1' < 3  AND '22' IN(1,30) AND '0' = 7 AND  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END) BETWEEN SUBSTR('20250131',0,4) || '0100' AND '20250131'  AND  NEW_GU_YR_G = 9  THEN  '1' ELSE '0' END))
                                           OR
                                       ('1' = (CASE WHEN '1' < 3  AND '22' IN(1,30) AND  '0' = 7 AND  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END) BETWEEN SUBSTR('20250131',0,4) || '0100' AND '20250131' AND (NEW_GU_YR_G = 1 OR SIGUMGO_HOIKYE_YR = 9999)  THEN  '1' ELSE '0' END))
                                       )
                                       OR  ('1' = (CASE WHEN '1' < 3  AND '22' IN(1,30) AND '0' = 1 AND (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END) BETWEEN SUBSTR('20250131',0,4) || '0100' AND '20250131'  THEN  '1' ELSE '0' END))
                                       OR  ('1' = (CASE WHEN '1' < 3  AND '22' IN(1,30) AND '0' = 5 AND NEW_GU_YR_G = 5 THEN  '1' ELSE '0' END))
                                       OR  (
                                       ('1' = (CASE WHEN '1' < 3  AND '22' IN(1,30) AND '0' = 9 AND  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END) <  SUBSTR('20250131',0,4) || '0100' THEN  '1' ELSE '0' END))
                                           OR
                                       ('1' = (CASE WHEN '1' < 3  AND '22' IN(1,30) AND '0' = 9 AND  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END) BETWEEN SUBSTR('20250131',0,4) || '0100' AND '20250131'  AND  NEW_GU_YR_G = 9  THEN  '1' ELSE '0' END))
                                       )
                                       OR  ('1' = (CASE WHEN ('1' >= 3 OR '22' NOT IN(1,30))  AND '22' = 23  AND (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END) BETWEEN '20061231' AND '20250131' THEN  '1' ELSE '0' END))
                                       OR  ('1' = (CASE WHEN ('1' >= 3 OR '22' NOT IN(1,30)) AND '22' <> 23  AND (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END) <= '20250131' THEN  '1' ELSE '0' END))
                                   )
                             AND (
                               (
                                   '1' = (CASE WHEN LENGTH(TRIM(NVL('', ''))) IS NULL THEN '1' ELSE '0' END)
                                   )
                                   OR
                               (
                                   '1' = (CASE WHEN ICH_SIGUMGO_GUN_GU_C = '' THEN '1' ELSE '0' END)
                                   )
                               )
                             AND A.SIGUMGO_AC_B IN('10','20')
                       )
               )
      ) AA,
      (SELECT REF_D_C, REF_D_NM FROM RPT_CODE_INFO
       WHERE REF_L_C=500
         AND REF_M_C=28
         AND REF_S_C = 5
       UNION ALL
       SELECT 9999 REF_D_C, '합계' REF_D_NM FROM DUAL
      ) BB
WHERE AA.GUNGU_CODE(+)   = BB.REF_D_C
GROUP BY REF_D_C, REF_D_NM, DATA_ROW
ORDER BY GUNGU_CODE

-- 자금정산표 2025.01.31 총괄 하수도


SELECT
    SUM(T1.SEIP_GYEJWA_JAN) AS SEIPGYEJWA_JANAEG
     ,SUM(T1.BAEJUNG_GYEJWA_JAN) AS BAEJEONGGYEJWA_JANAEG
     ,SUM(T1.JATA_BNK_SUNAB_ICHE_AMT) AS JATASUNAB_ICHEAEG
     ,SUM(T1.JOJEONG_IPGEUM_AMT) AS JOJEONG_IBGEUMAEG
     ,SUM(T1.CARD_AMT) AS CARD_GEUMAEG
     ,SUM(T1.ARS_CARD_AMT) AS ARSCARD_GEUMAEG
     ,SUM(T1.ARS_CARD_SEWOI_AMT) AS ARSCARD_SEWOI_GEUMAEG
     ,SUM(T1.ARS_CARD_HAND_PHONE_AMT) AS ARSHP_GEUMAEG
     ,SUM(T1.JOJEONG_JIGEUB_AMT) AS JOJEONGJI_GEUMAEG
     ,(
    SUM(T1.SEIP_GYEJWA_JAN) + SUM(T1.BAEJUNG_GYEJWA_JAN) +SUM(T1.JATA_BNK_SUNAB_ICHE_AMT)
        + SUM(T1.JOJEONG_IPGEUM_AMT) - SUM(T1.JOJEONG_JIGEUB_AMT)
    ) AS JEONGSANPYO_JANAEG
FROM
    (
        SELECT
            SUM(DECODE(T1.SIGUMGO_AC_B, 10, NVL(T2.JANAEK, 0), 0)) AS SEIP_GYEJWA_JAN
             ,SUM(DECODE(T1.SIGUMGO_AC_B, 20, NVL(T2.JANAEK, 0), 0)) AS BAEJUNG_GYEJWA_JAN
             ,0 AS JATA_BNK_SUNAB_ICHE_AMT
             ,0 AS JOJEONG_IPGEUM_AMT
             ,0 AS CARD_AMT
             ,0 AS ARS_CARD_AMT
             ,0 AS ARS_CARD_SEWOI_AMT
             ,0 AS ARS_CARD_HAND_PHONE_AMT
             ,0 AS JOJEONG_JIGEUB_AMT
        FROM
            ACL_SIGUMGO_MAS T1
           ,RPT_GONGGEUM_JAN T2
        WHERE 1=1
          AND T1.FIL_100_CTNT2 = T2.GONGGEUM_GYEJWA
          AND T1.SIGUMGO_ORG_C = T2.GEUMGO_CODE
          AND T1.ICH_SIGUMGO_GUN_GU_C = T2.GUNGU_CODE
          AND T1.SIGUMGO_ORG_C = '28'
          AND DECODE(NVL('', '9999'), '9999', 1, DECODE(T1.ICH_SIGUMGO_GUN_GU_C, '', 1, 0)) = 1
          AND T1.ICH_SIGUMGO_HOIKYE_C = '22'
          AND T1.SIGUMGO_AC_B IN (10,20)
          AND (
                  CASE
                      WHEN '0' = 1 THEN DECODE(T1.SIGUMGO_HOIKYE_YR, '9999', 1, SUBSTR('20250131', 1, 4), 1, 0)
                      WHEN '0' IN (8, 9) THEN DECODE(T1.SIGUMGO_HOIKYE_YR, SUBSTR('20250131', 1, 4) - 1, 1, 0)
                      WHEN '0' = 0 THEN DECODE(T1.SIGUMGO_HOIKYE_YR, '9999', 1, SUBSTR('20250131', 1, 4), 1, SUBSTR('20250131', 1, 4) - 1, 1, 0)
                      ELSE 0
                      END
                  ) = 1
          AND T1.MNG_NO = 1
          AND T2.KEORAEIL = '20250131'
        UNION ALL
        SELECT
            0 AS SEIP_GYEJWA_JAN
             ,0 AS BAEJUNG_GYEJWA_JAN
             ,SUM(NVL(T1.IPGEUM_AMT, 0)) AS JATA_BNK_SUNAB_ICHE_AMT
             ,0 AS JOJEONG_IPGEUM_AMT
             ,0 AS CARD_AMT
             ,0 AS ARS_CARD_AMT
             ,0 AS ARS_CARD_SEWOI_AMT
             ,0 AS ARS_CARD_HAND_PHONE_AMT
             ,0 AS JOJEONG_JIGEUB_AMT
        FROM
            (
                SELECT
                    T2.TRXDT AS KEORAEIL
                     ,T2.GJDT AS KIJUNIL
                     ,T2.GISDT AS KISANIL
                     ,T2.TRXNO AS GEORAE_SEQ
                     ,T2.CRT_CAN_G AS JEONGJEONG
                     ,DECODE(T2.IPJI_G, 1, DECODE(T2.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T2.TRAMT, 0) AS IPGEUM_AMT
                     ,DECODE(T2.IPJI_G, 1, 0, DECODE(T2.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T2.TRAMT) AS JIGEUB_AMT
                     ,T2.CMMT_CTNT AS JUKYO
                     ,T2.SIGUMGO_TRX_G AS GEORAE_GUBUN
                     ,T2.SIGUMGO_IP_TRX_G AS IPGEUM_GEORAE
                     ,T2.SIGUMGO_TAX_IP_MNG_NO AS HANDO_GYEJWA
                FROM
                    ACL_SIGUMGO_MAS T1
                   ,ACL_SIGUMGO_SLV T2
                WHERE 1=1
                  AND T1.FIL_100_CTNT2 = T2.FIL_100_CTNT5
                  AND T1.SIGUMGO_ORG_C = '28'
                  AND DECODE(NVL('', '9999'), '9999', 1, DECODE(T1.ICH_SIGUMGO_GUN_GU_C, '', 1, 0)) = 1
                  AND T1.ICH_SIGUMGO_HOIKYE_C = '22'
                  AND T1.SIGUMGO_AC_B IN (10,20)
                  AND (
                          CASE
                              WHEN '0' = 1 THEN DECODE(T1.SIGUMGO_HOIKYE_YR, '9999', 1, SUBSTR('20250131', 1, 4), 1, 0)
                              WHEN '0' IN (8, 9) THEN DECODE(T1.SIGUMGO_HOIKYE_YR, SUBSTR('20250131', 1, 4) - 1, 1, 0)
                              WHEN '0' = 0 THEN DECODE(T1.SIGUMGO_HOIKYE_YR, '9999', 1, SUBSTR('20250131', 1, 4), 1, SUBSTR('20250131', 1, 4) - 1, 1, 0)
                              ELSE 0
                              END
                          ) = 1
                  AND T1.MNG_NO = 1
                  AND T2.TRXDT > '20250131'
                  AND T2.GJDT IN (
                    SELECT
                        T1.BIZ_DT
                    FROM
                        (
                            SELECT
                                T1.BIZ_DT
                            FROM
                                MAP_JOB_DATE T1
                            WHERE 1=1
                              AND T1.BIZ_DT <= '20250131'
                              AND T1.DT_G = 0
                            ORDER BY
                                T1.BIZ_DT DESC
                        ) T1
                    WHERE 1=1
                      AND ROWNUM <= 8
                )
                  AND T2.SIGUMGO_TRX_G = 11
                  AND T2.IMMD_PROC_DSYN <> 1
                UNION ALL
                SELECT
                    T2.TRXDT AS KEORAEIL
                     ,T2.GJDT AS KIJUNIL
                     ,T2.GISDT AS KISANIL
                     ,T2.TRXNO AS GEORAE_SEQ
                     ,T2.CRT_CAN_G AS JEONGJEONG
                     ,DECODE(T2.IPJI_G, 1, DECODE(T2.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T2.TRAMT, 0) AS IPGEUM_AMT
                     ,DECODE(T2.IPJI_G, 1, 0, DECODE(T2.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T2.TRAMT) AS JIGEUB_AMT
                     ,NULL AS JUKYO
                     ,T2.SIGUMGO_TRX_G AS GEORAE_GUBUN
                     ,0 AS IPGEUM_GEORAE
                     ,NULL AS HANDO_GYEJWA
                FROM
                    ACL_SIGUMGO_MAS T1
                   ,ACL_SGGHANDO_SLV T2
                WHERE 1=1
                  AND T1.FIL_100_CTNT2 = T2.SIGUMGO_ACNO
                  AND T1.SIGUMGO_ORG_C = '28'
                  AND DECODE(NVL('', '9999'), '9999', 1, DECODE(T1.ICH_SIGUMGO_GUN_GU_C, '', 1, 0)) = 1
                  AND T1.ICH_SIGUMGO_HOIKYE_C = '22'
                  AND T1.SIGUMGO_AC_B IN (10,20)
                  AND (
                          CASE
                              WHEN '0' = 1 THEN DECODE(T1.SIGUMGO_HOIKYE_YR, '9999', 1, SUBSTR('20250131', 1, 4), 1, 0)
                              WHEN '0' IN (8, 9) THEN DECODE(T1.SIGUMGO_HOIKYE_YR, SUBSTR('20250131', 1, 4) - 1, 1, 0)
                              WHEN '0' = 0 THEN DECODE(T1.SIGUMGO_HOIKYE_YR, '9999', 1, SUBSTR('20250131', 1, 4), 1, SUBSTR('20250131', 1, 4) - 1, 1, 0)
                              ELSE 0
                              END
                          ) = 1
                  AND T1.MNG_NO = 1
                  AND T2.TRXDT > '20250131'
                  AND T2.GJDT IN (
                    SELECT
                        T1.BIZ_DT
                    FROM
                        (
                            SELECT
                                T1.BIZ_DT
                            FROM
                                MAP_JOB_DATE T1
                            WHERE 1=1
                              AND T1.BIZ_DT <= '20250131'
                              AND T1.DT_G = 0
                            ORDER BY
                                T1.BIZ_DT DESC
                        ) T1
                    WHERE 1=1
                      AND ROWNUM <= 8
                )
                  AND T2.SIGUMGO_TRX_G = 11
            ) T1
        UNION ALL
        SELECT
            0 AS SEIP_GYEJWA_JAN
             ,0 AS BAEJUNG_GYEJWA_JAN
             ,0 AS JATA_BNK_SUNAB_ICHE_AMT
             ,SUM(DECODE(T1.GEORAE_GUBUN, 13, T1.IPGEUM_AMT, 0)) AS JOJEONG_IPGEUM_AMT
             ,0 AS CARD_AMT
             ,0 AS ARS_CARD_AMT
             ,0 AS ARS_CARD_SEWOI_AMT
             ,0 AS ARS_CARD_HAND_PHONE_AMT
             ,SUM(
                CASE
                    WHEN T1.GEORAE_GUBUN IN (63, 64) THEN T1.JIGEUB_AMT
                    ELSE 0
                    END
              ) AS JOJEONG_JIGEUB_AMT
        FROM
            (
                SELECT
                    T2.TRXDT AS KEORAEIL
                     ,T2.GJDT AS KIJUNIL
                     ,T2.GISDT AS KISANIL
                     ,T2.TRXNO AS GEORAE_SEQ
                     ,T2.CRT_CAN_G AS JEONGJEONG
                     ,DECODE(T2.IPJI_G, 1, DECODE(T2.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T2.TRAMT, 0) AS IPGEUM_AMT
                     ,DECODE(T2.IPJI_G, 1, 0, DECODE(T2.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T2.TRAMT) AS JIGEUB_AMT
                     ,T2.CMMT_CTNT AS JUKYO
                     ,T2.SIGUMGO_TRX_G AS GEORAE_GUBUN
                     ,T2.SIGUMGO_TRX_G||LPAD(T2.SIGUMGO_IP_TRX_G, 2, 0)||LPAD(T2.SIGUMGO_JI_TRX_G, 2, 0) AS GEORAE_CODE
                     ,T2.SIGUMGO_IP_TRX_G AS IPGEUM_GEORAE
                     ,T2.SIGUMGO_TAX_IP_MNG_NO AS HANDO_GYEJWA
                FROM
                    ACL_SIGUMGO_MAS T1
                   ,ACL_SIGUMGO_SLV T2
                WHERE 1=1
                  AND T1.FIL_100_CTNT2 = T2.FIL_100_CTNT5
                  AND T1.SIGUMGO_ORG_C = '28'
                  AND DECODE(NVL('', '9999'), '9999', 1, DECODE(T1.ICH_SIGUMGO_GUN_GU_C, '', 1, 0)) = 1
                  AND T1.ICH_SIGUMGO_HOIKYE_C = '22'
                  AND T1.SIGUMGO_AC_B = 10
                  AND (
                          CASE
                              WHEN '0' = 1 THEN DECODE(T1.SIGUMGO_HOIKYE_YR, '9999', 1, SUBSTR('20250131', 1, 4), 1, 0)
                              WHEN '0' IN (8, 9) THEN DECODE(T1.SIGUMGO_HOIKYE_YR, SUBSTR('20250131', 1, 4) - 1, 1, 0)
                              WHEN '0' = 0 THEN DECODE(T1.SIGUMGO_HOIKYE_YR, '9999', 1, SUBSTR('20250131', 1, 4), 1, SUBSTR('20250131', 1, 4) - 1, 1, 0)
                              ELSE 0
                              END
                          ) = 1
                  AND T1.MNG_NO = 1
                  AND T2.GISDT > '20250131'
                  AND T2.GJDT <= '20250131'
                  AND T2.SIGUMGO_TRX_G IN (13,63,64)
                UNION ALL
                SELECT
                    T2.TRXDT AS KEORAEIL
                     ,T2.GJDT AS KIJUNIL
                     ,T2.GISDT AS KISANIL
                     ,T2.TRXNO AS GEORAE_SEQ
                     ,T2.CRT_CAN_G AS JEONGJEONG
                     ,DECODE(T2.IPJI_G, 1, DECODE(T2.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T2.TRAMT, 0) AS IPGEUM_AMT
                     ,DECODE(T2.IPJI_G, 1, 0, DECODE(T2.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T2.TRAMT) AS JIGEUB_AMT
                     ,NULL AS JUKYO
                     ,T2.SIGUMGO_TRX_G AS GEORAE_GUBUN
                     ,T2.SIGUMGO_TRX_G||'00' AS GEORAE_CODE
                     ,0 AS IPGEUM_GEORAE
                     ,NULL AS HANDO_GYEJWA
                FROM
                    ACL_SIGUMGO_MAS T1
                   ,ACL_SGGHANDO_SLV T2
                WHERE 1=1
                  AND T1.FIL_100_CTNT2 = T2.SIGUMGO_ACNO
                  AND T1.SIGUMGO_ORG_C = '28'
                  AND DECODE(NVL('', '9999'), '9999', 1, DECODE(T1.ICH_SIGUMGO_GUN_GU_C, '', 1, 0)) = 1
                  AND T1.ICH_SIGUMGO_HOIKYE_C = '22'
                  AND T1.SIGUMGO_AC_B = 10
                  AND (
                          CASE
                              WHEN '0' = 1 THEN DECODE(T1.SIGUMGO_HOIKYE_YR, '9999', 1, SUBSTR('20250131', 1, 4), 1, 0)
                              WHEN '0' IN (8, 9) THEN DECODE(T1.SIGUMGO_HOIKYE_YR, SUBSTR('20250131', 1, 4) - 1, 1, 0)
                              WHEN '0' = 0 THEN DECODE(T1.SIGUMGO_HOIKYE_YR, '9999', 1, SUBSTR('20250131', 1, 4), 1, SUBSTR('20250131', 1, 4) - 1, 1, 0)
                              ELSE 0
                              END
                          ) = 1
                  AND T1.MNG_NO = 1
                  AND T2.GISDT > '20250131'
                  AND T2.GJDT <= '20250131'
                  AND T2.SIGUMGO_TRX_G IN (13,63,64)
            ) T1
        UNION ALL
        SELECT
            0 AS SEIP_GYEJWA_JAN
             ,0 AS BAEJUNG_GYEJWA_JAN
             ,0 AS JATA_BNK_SUNAB_ICHE_AMT
             ,0 AS JOJEONG_IPGEUM_AMT
             ,SUM(NVL(T1.BONSE_AMT, 0) + NVL(T1.GYOYUKSE_AMT, 0) + NVL(T1.NONGTEUKSE_AMT, 0) + NVL(T1.SEWOI_AMT, 0)) AS CARD_AMT
             ,0 AS ARS_CARD_AMT
             ,0 AS ARS_CARD_SEWOI_AMT
             ,0 AS ARS_CARD_HAND_PHONE_AMT
             ,0 AS JOJEONG_JIGEUB_AMT
        FROM
            RPT_SUNAP_JIBGYE T1
        WHERE 1=1
          AND NVL('', 0) = 0
          AND T1.GEUMGO_CODE = '28'
          AND T1.SUNAPIL >= SUBSTR('20250131', 1, 6)||'01'
          AND T1.SUNAPIL <= '20250131'
          AND T1.BANK_GUBUN IN (94,95,96,97,98,44,381,361,364,365,366,367,368,369,370,371,372,373,374,389,390,391,392,393)
          AND '0' IN (1, 0)
          AND '22' = 1
        UNION ALL
        SELECT
            0 AS SEIP_GYEJWA_JAN
             ,0 AS BAEJUNG_GYEJWA_JAN
             ,0 AS JATA_BNK_SUNAB_ICHE_AMT
             ,0 AS JOJEONG_IPGEUM_AMT
             ,0 AS CARD_AMT
             ,CASE
                  WHEN T1.BANK_GUBUN = 99 AND T1.MNGBR <> 9878
                      THEN NVL(T1.BONSE_AMT, 0) + NVL(T1.GYOYUKSE_AMT, 0) + NVL(T1.NONGTEUKSE_AMT, 0)
                  ELSE 0
            END AS ARS_CARD_AMT
             ,CASE
                  WHEN T1.BANK_GUBUN = 99 AND T1.MNGBR <> 9878
                      THEN NVL(T1.SEWOI_AMT, 0)
                  ELSE 0
            END AS ARS_CARD_SEWOI_AMT
             ,CASE
                  WHEN T1.BANK_GUBUN = 99 AND T1.MNGBR = 9878
                      THEN NVL(T1.BONSE_AMT, 0) + NVL(T1.GYOYUKSE_AMT, 0) + NVL(T1.NONGTEUKSE_AMT, 0) + NVL(T1.SEWOI_AMT, 0)
                  ELSE 0
            END AS ARS_CARD_HAND_PHONE_AMT
             ,0 AS JOJEONG_JIGEUB_AMT
        FROM
            RPT_SUNAP_JIBGYE T1
        WHERE 1=1
          AND NVL('', 0) = 0
          AND T1.GEUMGO_CODE = '28'
          AND T1.SUNAPIL >= SUBSTR('20250131', 1, 6)||'01'
          AND T1.SUNAPIL <= '20250131'
          AND T1.BANK_GUBUN = 99
          AND '0' IN (1, 0)
          AND '22' = 1
    ) T1

    ============================================================================================
, 1739752559976
20250217treap2pRPTPWK0508896500

=========================== XDA ID:[tom.ich.fmt.xda.xSelectListICH040401By12]===============================
SELECT
    T2.REF_D_C AS GUNGU_CODE
     ,T2.REF_D_NM AS GUNGU_NM
     ,NVL(T1.DATA_ROW, 1) AS DATA_ROW
     ,SUM(NVL(T1.AMT1, 0)) AS AMT1
     ,SUM(NVL(T1.AMT2, 0)) AS AMT2
     ,SUM(NVL(T1.AMT3, 0)) AS AMT3
     ,SUM(NVL(T1.AMT4, 0)) AS AMT4
     ,SUM(NVL(T1.AMT5, 0)) AS AMT5
     ,SUM(NVL(T1.AMT6, 0)) AS AMT6
     ,SUM(NVL(T1.AMT7, 0)) AS AMT7
     ,SUM(NVL(T1.AMT8, 0)) AS AMT8
     ,SUM(NVL(T1.AMT9, 0)) AS AMT9
     ,SUM(NVL(T1.AMT10, 0)) AS AMT10
     ,SUM(NVL(T1.AMT11, 0)) AS AMT11
     ,SUM(NVL(T1.AMT12, 0)) AS AMT12
     ,SUM(NVL(T1.AMT13, 0)) AS AMT13
     ,SUM(NVL(T1.AMT14, 0)) AS AMT14
     ,SUM(NVL(T1.AMT15, 0)) AS AMT15
     ,SUM(NVL(T1.AMT16, 0)) AS AMT16
     ,SUM(NVL(T1.AMT17, 0)) AS AMT17
     ,SUM(NVL(T1.AMT18, 0)) AS AMT18
     ,SUM(NVL(T1.AMT19, 0)) AS AMT19
     ,SUM(NVL(T1.AMT20, 0)) AS AMT20
     ,SUM(NVL(T1.AMT21, 0)) AS AMT21
     ,SUM(NVL(T1.AMT22, 0)) AS AMT22
     ,SUM(NVL(T1.AMT23, 0)) AS AMT23
     ,SUM(NVL(T1.AMT24, 0)) AS AMT24
     ,SUM(NVL(T1.AMT25, 0)) AS AMT25
     ,SUM(NVL(T1.AMT26, 0)) AS AMT26
     ,SUM(NVL(T1.AMT27, 0)) AS AMT27
     ,SUM(NVL(T1.AMT28, 0)) AS AMT28
FROM
    (
        SELECT
            CASE
                WHEN T1.GUNGU_CODE = 0 THEN 7100
                WHEN T1.GUNGU_CODE < 7000 THEN T1.GUNGU_CODE + 7000
                WHEN T1.GUNGU_CODE > 7000 THEN T1.GUNGU_CODE
                END AS GUNGU_CODE
             ,T1.DATA_ROW
             ,T1.AMT1
             ,T1.AMT2
             ,T1.AMT3
             ,T1.AMT4
             ,T1.AMT5
             ,T1.AMT6
             ,T1.AMT7
             ,T1.AMT8
             ,T1.AMT9
             ,T1.AMT10
             ,T1.AMT11
             ,T1.AMT12
             ,T1.AMT13
             ,T1.AMT14
             ,T1.AMT15
             ,T1.AMT16
             ,T1.AMT17
             ,T1.AMT18
             ,T1.AMT19
             ,T1.AMT20
             ,T1.AMT21
             ,T1.AMT22
             ,T1.AMT23
             ,T1.AMT24
             ,T1.AMT25
             ,T1.AMT26
             ,T1.AMT27
             ,T1.AMT28
        FROM
            (
                SELECT
                    T1.GUNGU_CODE
                     ,1 DATA_ROW
                     ,SUM(
                        CASE
                            WHEN T1.GEORAE_GUBUN IN (1, 2, 4) AND T1.SUNAPIL = '20250131'
                                THEN NVL(T1.BONSE_AMT, 0)
                            ELSE 0
                            END
                      ) AS AMT1
                     ,SUM(
                        CASE
                            WHEN T1.GEORAE_GUBUN = 3 AND T1.SUNAPIL = '20250131'
                                THEN NVL(T1.BONSE_AMT, 0)
                            ELSE 0
                            END
                      ) AS AMT2
                     ,0 AS AMT3
                     ,SUM(
                        CASE
                            WHEN T1.GEORAE_GUBUN IN (1, 2, 4) AND T1.SUNAPIL = '20250131'
                                THEN NVL(T1.SEWOI_AMT, 0)
                            ELSE 0
                            END
                      ) AS AMT4
                     ,SUM(
                        CASE
                            WHEN T1.GEORAE_GUBUN = 3 AND T1.SUNAPIL = '20250131'
                                THEN NVL(T1.SEWOI_AMT, 0)
                            ELSE 0
                            END
                      ) AS AMT5
                     ,0 AS AMT6
                     ,SUM(
                        CASE
                            WHEN T1.GEORAE_GUBUN IN (1, 2, 4) AND T1.SUNAPIL = '20250131'
                                THEN NVL(T1.GYOYUKSE_AMT, 0)
                            ELSE 0
                            END
                      ) AS AMT7
                     ,SUM(
                        CASE
                            WHEN T1.GEORAE_GUBUN = 3 AND T1.SUNAPIL = '20250131'
                                THEN NVL(T1.GYOYUKSE_AMT, 0)
                            ELSE 0
                            END
                      ) AS AMT8
                     ,0 AS AMT9
                     ,SUM(
                        CASE
                            WHEN T1.GEORAE_GUBUN IN (1, 2, 4) AND T1.SUNAPIL = '20250131'
                                THEN NVL(T1.NONGTEUKSE_AMT, 0)
                            ELSE 0
                            END
                      ) AS AMT10
                     ,SUM(
                        CASE
                            WHEN T1.GEORAE_GUBUN = 3 AND T1.SUNAPIL = '20250131'
                                THEN NVL(T1.NONGTEUKSE_AMT, 0)
                            ELSE 0
                            END
                      ) AS AMT11
                     ,0 AS AMT12
                     ,SUM(
                        CASE
                            WHEN T1.GEORAE_GUBUN IN (1, 2, 4)
                                THEN NVL(T1.BONSE_AMT, 0)
                            ELSE 0
                            END
                      ) AS AMT13
                     ,SUM(
                        CASE
                            WHEN T1.GEORAE_GUBUN = 3
                                THEN NVL(T1.BONSE_AMT, 0)
                            ELSE 0
                            END
                      ) AS AMT14
                     ,0 AS AMT15
                     ,SUM(
                        CASE
                            WHEN T1.GEORAE_GUBUN IN (1, 2, 4)
                                THEN NVL(T1.SEWOI_AMT, 0)
                            ELSE 0
                            END
                      ) AS AMT16
                     ,SUM(
                        CASE
                            WHEN T1.GEORAE_GUBUN = 3
                                THEN NVL(T1.SEWOI_AMT, 0)
                            ELSE 0
                            END
                      ) AS AMT17
                     ,0 AS AMT18
                     ,SUM(
                        CASE
                            WHEN T1.GEORAE_GUBUN IN (1, 2, 4)
                                THEN NVL(T1.GYOYUKSE_AMT, 0)
                            ELSE 0
                            END
                      ) AS AMT19
                     ,SUM(
                        CASE
                            WHEN T1.GEORAE_GUBUN = 3
                                THEN NVL(T1.GYOYUKSE_AMT, 0)
                            ELSE 0
                            END
                      ) AS AMT20
                     ,0 AS AMT21
                     ,SUM(
                        CASE
                            WHEN T1.GEORAE_GUBUN IN (1, 2, 4)
                                THEN NVL(T1.NONGTEUKSE_AMT, 0)
                            ELSE 0
                            END
                      ) AS AMT22
                     ,SUM(
                        CASE
                            WHEN T1.GEORAE_GUBUN = 3
                                THEN NVL(T1.NONGTEUKSE_AMT, 0)
                            ELSE 0
                            END
                      ) AS AMT23
                     ,0 AS AMT24
                     ,SUM(
                        CASE
                            WHEN T1.SUNAPIL >= SUBSTR('20250131', 1 ,6)||'01' AND T1.SUNAPIL <= '20250131' AND T1.GEORAE_GUBUN IN (1, 2, 4)
                                THEN NVL(T1.BONSE_AMT, 0)
                            WHEN T1.SUNAPIL >= SUBSTR('20250131', 1 ,6)||'01' AND T1.SUNAPIL <= '20250131' AND T1.GEORAE_GUBUN = 3
                                THEN NVL(T1.BONSE_AMT, 0) * -1
                            ELSE 0
                            END
                      ) AS AMT25
                     ,SUM(
                        CASE
                            WHEN T1.SUNAPIL >= SUBSTR('20250131', 1 ,6)||'01' AND T1.SUNAPIL <= '20250131' AND T1.GEORAE_GUBUN IN (1, 2, 4)
                                THEN NVL(T1.SEWOI_AMT, 0)
                            WHEN T1.SUNAPIL >= SUBSTR('20250131', 1 ,6)||'01' AND T1.SUNAPIL <= '20250131' AND T1.GEORAE_GUBUN = 3
                                THEN NVL(T1.SEWOI_AMT, 0) * -1
                            ELSE 0
                            END
                      ) AS AMT26
                     ,SUM(
                        CASE
                            WHEN T1.SUNAPIL >= SUBSTR('20250131', 1 ,6)||'01' AND T1.SUNAPIL <= '20250131' AND T1.GEORAE_GUBUN IN (1, 2, 4)
                                THEN NVL(T1.GYOYUKSE_AMT, 0)
                            WHEN T1.SUNAPIL >= SUBSTR('20250131', 1 ,6)||'01' AND T1.SUNAPIL <= '20250131' AND T1.GEORAE_GUBUN = 3
                                THEN NVL(T1.GYOYUKSE_AMT, 0) * -1
                            ELSE 0
                            END
                      ) AS AMT27
                     ,SUM(
                        CASE
                            WHEN T1.SUNAPIL >= SUBSTR('20250131', 1 ,6)||'01' AND T1.SUNAPIL <= '20250131' AND T1.GEORAE_GUBUN IN (1, 2, 4)
                                THEN NVL(T1.NONGTEUKSE_AMT, 0)
                            WHEN T1.SUNAPIL >= SUBSTR('20250131', 1 ,6)||'01' AND T1.SUNAPIL <= '20250131' AND T1.GEORAE_GUBUN = 3
                                THEN NVL(T1.NONGTEUKSE_AMT, 0) * -1
                            ELSE 0
                            END
                      ) AS AMT28
                FROM
                    RPT_SUNAP_JIBGYE T1
                WHERE 1=1
                  AND T1.GEUMGO_CODE = '28'
                  AND T1.SUNAPIL >= (
                    CASE
                        WHEN  TO_NUMBER(SUBSTR('20250131', 5, 2)) < 3
                            AND '209331' IN (103000, 104000, 213000)
                            AND '0' IN (8, 9)
                            THEN  SUBSTR('20250131', 1, 4) - 1||DECODE('0', 9, '0301', '0101')
                        ELSE  SUBSTR('20250131', 1, 4)||'0101'
                        END
                    )
                  AND T1.SUNAPIL <= '20250131'
                  AND (
                          CASE
                              WHEN '0' = 1
                                  THEN
                                  CASE
                                      WHEN T1.SUNAPIL >= SUBSTR('20250131', 1, 4)||'0100'
                                          AND DECODE(T1.YEAR_GUBUN, '0', 1, DECODE(T1.HOIGYE_YEAR, '9999', 1, 0)) = 1
                                          THEN 1
                                      ELSE 0
                                      END
                              WHEN '0' IN (9, 5)
                                  THEN
                                  CASE
                                      WHEN TO_NUMBER(SUBSTR('20250131', 5, 2)) < 3
                                          THEN
                                          CASE
                                              WHEN T1.SUNAPIL >= SUBSTR('20250131', 1, 4)-1||'0301' AND T1.YEAR_GUBUN = '0'
                                                  THEN 1
                                              ELSE 0
                                              END
                                      ELSE
                                          CASE
                                              WHEN T1.SUNAPIL >= SUBSTR('20250131', 1, 4)||'0301' AND T1.YEAR_GUBUN = '0'
                                                  THEN 1
                                              ELSE 0
                                              END
                                      END
                              WHEN '0' = 8
                                  THEN
                                  CASE
                                      WHEN TO_NUMBER(SUBSTR('20250131', 5, 2)) < 3
                                          THEN
                                          CASE
                                              WHEN T1.SUNAPIL >= SUBSTR('20250131', 1, 4)-1||'0100'
                                                  AND T1.SUNAPIL <= SUBSTR('20250131', 1, 4)-1||'1231'
                                                  AND T1.YEAR_GUBUN = 1
                                                  THEN 1
                                              WHEN T1.SUNAPIL >= SUBSTR('20250131', 1, 4)-1||'0300'
                                                  AND T1.YEAR_GUBUN <> 1
                                                  THEN 1
                                              ELSE 0
                                              END
                                      ELSE
                                          CASE
                                              WHEN T1.SUNAPIL >= SUBSTR('20250131', 1, 4)||'0301' AND T1.YEAR_GUBUN <> 1
                                                  THEN 1
                                              ELSE 0
                                              END
                                      END
                              WHEN  '0' IN (0, 7)
                                  THEN
                                  CASE
                                      WHEN T1.SUNAPIL >= SUBSTR('20250131', 1, 4)||'0100' THEN 1
                                      ELSE 0
                                      END
                              ELSE 0
                              END
                          ) = 1
                  AND (
                          CASE
                              WHEN '209331' = 209331
                                  THEN
                                  CASE
                                      WHEN T1.JIBGYE_CODE IN (209331, 209332, 216200)
                                          THEN 1
                                      WHEN T1.HOIKYE_SMOK_C = 281020 AND T1.SUNAPIL >= '20230201'
                                          THEN 1
                                      ELSE 0
                                      END
                              ELSE  DECODE(T1.JIBGYE_CODE, '209331', 1, 0)
                              END
                          ) = 1
                  AND DECODE(NVL('', '9999'), '9999', 1, DECODE(T1.GUNGU_CODE, '', 1, 0)) = 1
                GROUP BY
                    T1.GUNGU_CODE
                UNION ALL
                SELECT
                    T1.GUNGU_CODE
                     ,1 AS DATA_ROW
                     ,0 AS AMT1
                     ,SUM(
                        CASE
                            WHEN T1.JOJEONG_GUBUN = 2 AND T1.IPJI_GUBUN = 1 AND T1.SUNAPIL = '20250131'
                                THEN NVL(T1.JIBANGSE_AMT, 0) * -1
                            WHEN T1.JOJEONG_GUBUN = 2 AND T1.IPJI_GUBUN = 2 AND T1.SUNAPIL = '20250131'
                                THEN NVL(T1.JIBANGSE_AMT, 0)
                            ELSE 0
                            END
                      ) AS AMT2
                     ,SUM(
                        CASE
                            WHEN T1.JOJEONG_GUBUN <> 2 AND T1.IPJI_GUBUN = 1 AND T1.SUNAPIL = '20250131'
                                THEN NVL(T1.JIBANGSE_AMT, 0)
                            WHEN T1.JOJEONG_GUBUN <> 2 AND T1.IPJI_GUBUN = 2 AND T1.SUNAPIL = '20250131'
                                THEN NVL(T1.JIBANGSE_AMT, 0) * -1
                            ELSE 0
                            END
                      ) AS AMT3
                     ,0 AS AMT4
                     ,SUM(
                        CASE
                            WHEN T1.JOJEONG_GUBUN = 2 AND T1.IPJI_GUBUN = 1 AND T1.SUNAPIL = '20250131'
                                THEN NVL(T1.SEWOI_AMT, 0) * -1
                            WHEN T1.JOJEONG_GUBUN = 2 AND T1.IPJI_GUBUN = 2 AND T1.SUNAPIL = '20250131'
                                THEN NVL(T1.SEWOI_AMT, 0)
                            ELSE 0
                            END
                      ) AS AMT5
                     ,SUM(
                        CASE
                            WHEN T1.JOJEONG_GUBUN <> 2 AND T1.IPJI_GUBUN = 1 AND T1.SUNAPIL = '20250131'
                                THEN NVL(T1.SEWOI_AMT, 0)
                            WHEN T1.JOJEONG_GUBUN <> 2 AND T1.IPJI_GUBUN = 2 AND T1.SUNAPIL = '20250131'
                                THEN NVL(T1.SEWOI_AMT, 0) * -1
                            ELSE 0
                            END
                      ) AS AMT6
                     ,0 AS AMT7
                     ,SUM(
                        CASE
                            WHEN T1.JOJEONG_GUBUN = 2 AND T1.IPJI_GUBUN = 1 AND T1.SUNAPIL = '20250131'
                                THEN NVL(T1.GYOYUKSE_AMT, 0) * -1
                            WHEN T1.JOJEONG_GUBUN = 2 AND T1.IPJI_GUBUN = 2 AND T1.SUNAPIL = '20250131'
                                THEN NVL(T1.GYOYUKSE_AMT, 0)
                            ELSE 0
                            END
                      ) AS AMT8
                     ,SUM(
                        CASE
                            WHEN T1.JOJEONG_GUBUN <> 2 AND T1.IPJI_GUBUN = 1 AND T1.SUNAPIL = '20250131'
                                THEN NVL(T1.GYOYUKSE_AMT, 0)
                            WHEN T1.JOJEONG_GUBUN <> 2 AND T1.IPJI_GUBUN = 2 AND T1.SUNAPIL = '20250131'
                                THEN NVL(T1.GYOYUKSE_AMT, 0) * -1
                            ELSE 0
                            END
                      ) AS AMT9
                     ,0 AS AMT10
                     ,SUM(
                        CASE
                            WHEN T1.JOJEONG_GUBUN = 2 AND T1.IPJI_GUBUN = 1 AND T1.SUNAPIL = '20250131'
                                THEN NVL(T1.NONGTEUKSE_AMT, 0) * -1
                            WHEN T1.JOJEONG_GUBUN = 2 AND T1.IPJI_GUBUN = 2 AND T1.SUNAPIL = '20250131'
                                THEN NVL(T1.NONGTEUKSE_AMT, 0)
                            ELSE 0
                            END
                      ) AS AMT11
                     ,SUM(
                        CASE
                            WHEN T1.JOJEONG_GUBUN <> 2 AND T1.IPJI_GUBUN = 1 AND T1.SUNAPIL = '20250131'
                                THEN NVL(T1.NONGTEUKSE_AMT, 0)
                            WHEN T1.JOJEONG_GUBUN <> 2 AND T1.IPJI_GUBUN = 2 AND T1.SUNAPIL = '20250131'
                                THEN NVL(T1.NONGTEUKSE_AMT, 0) * -1
                            ELSE 0
                            END
                      ) AS AMT12
                     ,0 AS AMT13
                     ,SUM(
                        CASE
                            WHEN T1.JOJEONG_GUBUN = 2 AND T1.IPJI_GUBUN = 1
                                THEN NVL(T1.JIBANGSE_AMT, 0) * -1
                            WHEN T1.JOJEONG_GUBUN = 2 AND T1.IPJI_GUBUN = 2
                                THEN NVL(T1.JIBANGSE_AMT, 0)
                            ELSE 0
                            END
                      ) AS AMT14
                     ,SUM(
                        CASE
                            WHEN T1.JOJEONG_GUBUN <> 2 AND T1.IPJI_GUBUN = 1
                                THEN NVL(T1.JIBANGSE_AMT, 0)
                            WHEN T1.JOJEONG_GUBUN <> 2 AND T1.IPJI_GUBUN = 2
                                THEN NVL(T1.JIBANGSE_AMT, 0) * -1
                            ELSE 0
                            END
                      ) AS AMT15
                     ,0 AS AMT16
                     ,SUM(
                        CASE
                            WHEN T1.JOJEONG_GUBUN = 2 AND T1.IPJI_GUBUN = 1
                                THEN NVL(T1.SEWOI_AMT, 0) * -1
                            WHEN T1.JOJEONG_GUBUN = 2 AND T1.IPJI_GUBUN = 2
                                THEN NVL(T1.SEWOI_AMT, 0)
                            ELSE 0
                            END
                      ) AS AMT17
                     ,SUM(
                        CASE
                            WHEN T1.JOJEONG_GUBUN <> 2 AND T1.IPJI_GUBUN = 1
                                THEN NVL(T1.SEWOI_AMT, 0)
                            WHEN T1.JOJEONG_GUBUN <> 2 AND T1.IPJI_GUBUN = 2
                                THEN NVL(T1.SEWOI_AMT, 0) * -1
                            ELSE 0
                            END
                      ) AS AMT18
                     ,0 AS AMT19
                     ,SUM(
                        CASE
                            WHEN T1.JOJEONG_GUBUN = 2 AND T1.IPJI_GUBUN = 1
                                THEN NVL(T1.GYOYUKSE_AMT, 0) * -1
                            WHEN T1.JOJEONG_GUBUN = 2 AND T1.IPJI_GUBUN = 2
                                THEN NVL(T1.GYOYUKSE_AMT, 0)
                            ELSE 0
                            END
                      ) AS AMT20
                     ,SUM(
                        CASE
                            WHEN T1.JOJEONG_GUBUN <> 2 AND T1.IPJI_GUBUN = 1
                                THEN NVL(T1.GYOYUKSE_AMT, 0)
                            WHEN T1.JOJEONG_GUBUN <> 2 AND T1.IPJI_GUBUN = 2
                                THEN NVL(T1.GYOYUKSE_AMT, 0) * -1
                            ELSE 0
                            END
                      ) AS AMT21
                     ,0 AS AMT22
                     ,SUM(
                        CASE
                            WHEN T1.JOJEONG_GUBUN = 2 AND T1.IPJI_GUBUN = 1
                                THEN NVL(T1.NONGTEUKSE_AMT, 0) * -1
                            WHEN T1.JOJEONG_GUBUN = 2 AND T1.IPJI_GUBUN = 2
                                THEN NVL(T1.NONGTEUKSE_AMT, 0)
                            ELSE 0
                            END
                      ) AS AMT23
                     ,SUM(
                        CASE
                            WHEN T1.JOJEONG_GUBUN <> 2 AND T1.IPJI_GUBUN = 1
                                THEN NVL(T1.NONGTEUKSE_AMT, 0)
                            WHEN T1.JOJEONG_GUBUN <> 2 AND T1.IPJI_GUBUN = 2
                                THEN NVL(T1.NONGTEUKSE_AMT, 0) * -1
                            ELSE 0
                            END
                      ) AS AMT24
                     ,SUM(
                        CASE
                            WHEN T1.SUNAPIL >= SUBSTR('20250131', 1, 6)||'01' AND T1.SUNAPIL <= '20250131' AND T1.IPJI_GUBUN = 1
                                THEN NVL(T1.JIBANGSE_AMT, 0)
                            WHEN T1.SUNAPIL >= SUBSTR('20250131', 1, 6)||'01' AND T1.SUNAPIL <= '20250131' AND T1.IPJI_GUBUN <> 1
                                THEN NVL(T1.JIBANGSE_AMT, 0) * -1
                            ELSE 0
                            END
                      ) AS AMT25
                     ,SUM(
                        CASE
                            WHEN T1.SUNAPIL >= SUBSTR('20250131', 1, 6)||'01' AND T1.SUNAPIL <= '20250131' AND T1.IPJI_GUBUN = 1
                                THEN NVL(T1.SEWOI_AMT, 0)
                            WHEN T1.SUNAPIL >= SUBSTR('20250131', 1, 6)||'01' AND T1.SUNAPIL <= '20250131' AND T1.IPJI_GUBUN <> 1
                                THEN NVL(T1.SEWOI_AMT, 0) * -1
                            ELSE 0
                            END
                      ) AS AMT26
                     ,SUM(
                        CASE
                            WHEN T1.SUNAPIL >= SUBSTR('20250131', 1, 6)||'01' AND T1.SUNAPIL <= '20250131' AND T1.IPJI_GUBUN = 1
                                THEN NVL(T1.GYOYUKSE_AMT, 0)
                            WHEN T1.SUNAPIL >= SUBSTR('20250131', 1, 6)||'01' AND T1.SUNAPIL <= '20250131' AND T1.IPJI_GUBUN <> 1
                                THEN NVL(T1.GYOYUKSE_AMT, 0) * -1
                            ELSE 0
                            END
                      ) AS AMT27
                     ,SUM(
                        CASE
                            WHEN T1.SUNAPIL >= SUBSTR('20250131', 1, 6)||'00' AND T1.SUNAPIL <= '20250131' AND T1.IPJI_GUBUN = 1
                                THEN NVL(T1.NONGTEUKSE_AMT, 0)
                            WHEN T1.SUNAPIL >= SUBSTR('20250131', 1, 6)||'00' AND T1.SUNAPIL <= '20250131' AND T1.IPJI_GUBUN <> 1
                                THEN NVL(T1.NONGTEUKSE_AMT, 0) * -1
                            ELSE 0
                            END
                      ) AS AMT28
                FROM
                    RPT_DANGSEIPJOJEONG T1
                WHERE 1=1
                  AND T1.GEUMGO_CODE = '28'
                  AND T1.SUNAPIL >= (
                    CASE
                        WHEN  TO_NUMBER(SUBSTR('20250131', 5, 2)) < 3
                            AND '209331' IN (103000, 104000, 213000)
                            AND '0' IN (8, 9)
                            THEN  SUBSTR('20250131', 1, 4) - 1||DECODE('0', 9, '0301', '0101')
                        ELSE SUBSTR ('20250131', 1, 4)||'0101'
                        END
                    )
                  AND T1.SUNAPIL <= '20250131'
                  AND (
                          CASE
                              WHEN '0' = 1
                                  THEN
                                  CASE
                                      WHEN T1.SUNAPIL >= SUBSTR('20250131', 1, 4)||'0100'
                                          AND DECODE(T1.YEAR_GUBUN, '0', 1, DECODE(T1.HOIGYE_YEAR, '9999', 1, 0)) = 1
                                          THEN 1
                                      ELSE 0
                                      END
                              WHEN '0' IN (9, 5)
                                  THEN
                                  CASE
                                      WHEN TO_NUMBER(SUBSTR('20250131', 5, 2)) < 3
                                          THEN
                                          CASE
                                              WHEN T1.SUNAPIL >= SUBSTR('20250131', 1, 4)-1||'0301' AND T1.YEAR_GUBUN = '0'
                                                  THEN 1
                                              ELSE 0
                                              END
                                      ELSE
                                          CASE
                                              WHEN T1.SUNAPIL >= SUBSTR('20250131', 1, 4)||'0301' AND T1.YEAR_GUBUN = '0'
                                                  THEN 1
                                              ELSE 0
                                              END
                                      END
                              WHEN '0' = 8
                                  THEN
                                  CASE
                                      WHEN TO_NUMBER(SUBSTR('20250131', 5, 2)) < 3
                                          THEN
                                          CASE
                                              WHEN T1.SUNAPIL >= SUBSTR('20250131', 1, 4)-1||'0100'
                                                  AND T1.SUNAPIL <= SUBSTR('20250131', 1, 4)-1||'1231'
                                                  AND T1.YEAR_GUBUN = 1
                                                  THEN 1
                                              WHEN T1.SUNAPIL >= SUBSTR('20250131', 1, 4)-1||'0300'
                                                  AND T1.YEAR_GUBUN <> 1
                                                  THEN 1
                                              ELSE 0
                                              END
                                      ELSE
                                          CASE
                                              WHEN T1.SUNAPIL >= SUBSTR('20250131', 1, 4)||'0301' AND T1.YEAR_GUBUN <> 1
                                                  THEN 1
                                              ELSE 0
                                              END
                                      END
                              WHEN '0' IN (0, 7)
                                  THEN
                                  CASE
                                      WHEN T1.SUNAPIL >= SUBSTR('20250131', 1, 4)||'0100' THEN 1
                                      ELSE 0
                                      END
                              ELSE 0
                              END
                          ) = 1
                  AND (
                          CASE
                              WHEN '209331' = 209331
                                  THEN
                                  CASE
                                      WHEN T1.JIBGYE_CODE IN (209331, 209332)
                                          THEN 1
                                      ELSE 0
                                      END
                              ELSE  DECODE(T1.JIBGYE_CODE, '209331', 1, 0)
                              END
                          ) = 1
                  AND DECODE(NVL('', '9999'), '9999', 1, DECODE(T1.GUNGU_CODE, '', 1, 0)) = 1
                GROUP BY
                    T1.GUNGU_CODE
                UNION ALL
                SELECT TO_NUMBER(GUNGU_CD) GUNGU_CODE, 1 AS DATA_ROW,
                       0 AMT1 , 0 AMT2 , 0 AMT3 ,
                       SUM(CASE WHEN SUNP_DT = '20250131' THEN NVL(NAPBU_SIDO_TAX_AMT,0) ELSE 0 END) AMT4 , 0 AMT5 , 0 AMT6 ,
                       0 AMT7 , 0 AMT8 , 0 AMT9 ,
                       0 AMT10, 0 AMT11, 0 AMT12,
                       0 AMT13, 0 AMT14, 0 AMT15,
                       SUM(NVL(NAPBU_SIDO_TAX_AMT,0)) AMT16, 0 AMT17, 0 AMT18,
                       0 AMT19, 0 AMT20, 0 AMT21,
                       0 AMT22, 0 AMT23, 0 AMT24,
                       0 AMT25,
                       SUM(CASE WHEN (SUNP_DT BETWEEN SUBSTR('20250131', 1, 6)||'01' AND '20250131') THEN NVL(NAPBU_SIDO_TAX_AMT,0) ELSE 0 END) AMT26,
                       0 AMT27,
                       0 AMT28
                FROM
                    (
                        SELECT SUNP_DT,
                               CASE  WHEN NEW_GU_YR_G = 1 THEN 1
                                     WHEN NEW_GU_YR_G = 2 THEN 9
                                     ELSE  99 END YEAR_GUBUN,
                               HOIKYE_CD, SMOK_CD,
                               CASE WHEN CVT_GUCHUNG_CD = '357' THEN '710'
                                    WHEN CVT_GUCHUNG_CD = '358' THEN '720'
                                    ELSE CVT_GUCHUNG_CD END AS GUNGU_CD
                                ,
                               NAPBU_TCNT, NAPBU_NTAX_AMT, NAPBU_SIDO_TAX_AMT, NAPBU_SIGNGU_TAX_AMT
                        FROM
                            NIO_STAX_MASTR_TAB
                        WHERE 1=1
                          AND '209331' = 209331
                          AND SUNP_DT >= SUBSTR('20250131', 1, 4)||'0100'  AND FORM_G <> '1' AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND SIDO_CD <> '628' AND (SUBSTR(SMOK_CD,1,3)  <> '299' OR   SUBSTR(SMOK_CD,4,3) <> '099')
                          AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358') AND HOIKYE_CD = '51' AND SMOK_CD = '281020'
                        UNION
                        SELECT A.SUNP_DT SUNP_DT,
                               CASE  WHEN NEW_GU_YR_G = 1 THEN 1
                                     WHEN NEW_GU_YR_G = 2 THEN 9
                                     ELSE  99 END YEAR_GUBUN,
                               A.HOIKYE_CD HOIKYE_CD, A.SMOK_CD SMOK_CD,
                               CASE WHEN CVT_GUCHUNG_CD = '357' THEN '710'
                                    WHEN CVT_GUCHUNG_CD = '358' THEN '720'
                                    ELSE CVT_GUCHUNG_CD  END AS GUNGU_CD
                                ,
                               A.NAPBU_TCNT NAPBU_TCNT, A.NAPBU_NTAX_AMT NAPBU_NTAX_AMT, A.NAPBU_SIDO_TAX_AMT NAPBU_SIDO_TAX_AMT, A.NAPBU_SIGNGU_TAX_AMT NAPBU_SIGNGU_TAX_AMT
                        FROM
                            NIO_STAX_MASTR_TAB A, NIO_DEPT_INF_TAB B
                        WHERE 1=1
                          AND '209331' = 209331
                          AND A.SUNP_DT >= SUBSTR('20250131', 1, 4)||'0100'  AND FORM_G <> '1' AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND SIDO_CD = '628' AND (SUBSTR(A.SMOK_CD,1,3) <> '299' OR  SUBSTR(A.SMOK_CD,4,3) <> '099')
                          AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358') AND A.HOIKYE_CD = '51' AND A.SMOK_CD = '281020'
                          AND A.SIDO_CD = B.GUCHUNG_CD(+) AND A.DEPT_CD = B.DEPT_CD(+) AND A.HOIKYE_CD = B.HOIKYE_CD(+) AND A.SMOK_CD = B.SMOK_CD(+)
                        UNION
                        SELECT
                            SUNP_DT,
                            CASE  WHEN NEW_GU_YR_G = 1 THEN 1
                                  WHEN NEW_GU_YR_G = 2 THEN 9
                                  ELSE  99 END YEAR_GUBUN,
                            HOIKYE_CD,
                            SMOK_CD,
                            CASE WHEN CVT_GUCHUNG_CD = '357' THEN '710'
                                 WHEN CVT_GUCHUNG_CD = '358' THEN '720'
                                 ELSE CVT_GUCHUNG_CD END  AS GUNGU_CD
                                ,
                            NAPBU_TCNT,
                            NVL(SUM(국세), 0) AS NAPBU_NTAX_AMT, NVL(SUM(시도세),0) AS NAPBU_SIDO_TAX_AMT, NVL(SUM(시군세),0) AS NAPBU_SIGNGU_TAX_AMT
                        FROM
                            (
                                SELECT
                                    BLK_NO, PROC_SEQ, SUNP_DT, NEW_GU_YR_G,
                                    HOIKYE_CD, SMOK_CD,
                                    CVT_GUCHUNG_CD,
                                    NAPBU_TCNT,
                                    CASE WHEN FILLER2 = '1' THEN NTAX_AMT + SIDO_TAX_AMT + SIGNGU_TAX_AMT - NAPGILT_AMT END AS 국세,
                                    CASE WHEN FILLER2 = '2' THEN NTAX_AMT + SIDO_TAX_AMT + SIGNGU_TAX_AMT - NAPGILT_AMT END AS 시도세,
                                    CASE WHEN FILLER2 = '3' THEN NTAX_AMT + SIDO_TAX_AMT + SIGNGU_TAX_AMT - NAPGILT_AMT END AS 시군세
                                FROM
                                    NIO_STAX_MASTR_TAB
                                WHERE 1=1
                                  AND '209331' = 209331
                                  AND SUNP_DT >= SUBSTR('20250131', 1, 4)||'0100'  AND FILLER2 > '0' AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND FORM_G <> '1'
                                  AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358') AND HOIKYE_CD = '51' AND SMOK_CD = '281020'
                            )
                        GROUP BY SUNP_DT, NEW_GU_YR_G, HOIKYE_CD, SMOK_CD,CVT_GUCHUNG_CD, NAPBU_TCNT
                        UNION
                        SELECT
                            SUNP_DT,
                            CASE  WHEN NEW_GU_YR_G = 1 THEN 1
                                  WHEN NEW_GU_YR_G = 2 THEN 9
                                  ELSE  99 END YEAR_GUBUN,
                            HOIKYE_CD,
                            SMOK_CD,
                            CASE WHEN CVT_GUCHUNG_CD = '357' THEN '710'
                                 WHEN CVT_GUCHUNG_CD = '358' THEN '720'
                                 ELSE CVT_GUCHUNG_CD END  AS GUNGU_CD
                                ,
                            NAPBU_TCNT,
                            NVL(SUM(NAPBU_NTAX_AMT), 0) AS NAPBU_NTAX_AMT, NVL(SUM(NAPBU_SIDO_TAX_AMT), 0) AS NAPBU_SIDO_TAX_AMT, NVL(SUM(NAPBU_SIGNGU_TAX_AMT), 0) AS NAPBU_SIGNGU_TAX_AMT
                        FROM
                            (
                                SELECT SUNP_DT, NEW_GU_YR_G,
                                       HOIKYE_CD, SMOK_CD,
                                       CVT_GUCHUNG_CD,
                                       NAPBU_TCNT, NAPBU_NTAX_AMT, NAPBU_SIDO_TAX_AMT, NAPBU_SIGNGU_TAX_AMT
                                FROM
                                    NIO_STAX_MASTR_TAB
                                WHERE 1=1
                                  AND '209331' = 209331
                                  AND SUNP_DT >= SUBSTR('20250131', 1, 4)||'0100'  AND SUBSTR(SMOK_CD,1,3) = '299' AND SUBSTR(SMOK_CD,4,3)  = '099'  AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND FORM_G <> '1'
                                  AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358') AND HOIKYE_CD = '51' AND SMOK_CD = '281020'
                            )
                        GROUP BY SUNP_DT, NEW_GU_YR_G, HOIKYE_CD, SMOK_CD,CVT_GUCHUNG_CD,NAPBU_TCNT
                    )
                WHERE 1 = 1
                  AND DECODE(NVL('', '9999'), '9999', 1, DECODE(GUNGU_CD, '', 1, 0)) = 1
                GROUP BY
                    GUNGU_CD
            ) T1
        UNION ALL
        SELECT
            9999 AS GUNGU_CODE
             ,2 AS DATA_ROW
             ,SUM(
                CASE
                    WHEN DECODE(SIGN(NVL(TRIM(T1.BAS_DT), '99991231') - NVL(TRIM(T1.GISDT), '99991231')), 1, T1.GISDT, T1.BAS_DT) = '20250131' AND T1.SIGUMGO_AC_B = 10
                        THEN T1.BIZPLC_BAEJUNG_JI_AMT + T1.BIZPLC_GAM_BAEJUNG_IP_AMT
                    ELSE 0
                    END
              ) AS AMT1
             ,SUM(
                CASE
                    WHEN DECODE(SIGN(NVL(TRIM(T1.BAS_DT), '99991231') - NVL(TRIM(T1.GISDT), '99991231')), 1, T1.GISDT, T1.BAS_DT) = '20250131'
                        THEN   T1.TAXO_FUND_BAEJUNG_JI_AMT + T1.TAXO_HNDO_BAEJUNG_JI_AMT
                        + T1.TAXO_HNDO_JICHUL_JI_AMT + T1.TAXO_FUND_GETBK_JI_AMT
                    ELSE 0
                    END
              ) AS AMT2
             ,SUM(
                CASE
                    WHEN DECODE(SIGN(NVL(TRIM(T1.BAS_DT), '99991231') - NVL(TRIM(T1.GISDT), '99991231')), 1, T1.GISDT, T1.BAS_DT) = '20250131'
                        THEN T1.TAXO_RTRN_AMT * -1
                    ELSE 0
                    END
              ) AS AMT3
             ,0 AS AMT4
             ,0 AS AMT5
             ,0 AS AMT6
             ,0 AS AMT7
             ,0 AS AMT8
             ,0 AS AMT9
             ,0 AS AMT10
             ,0 AS AMT11
             ,0 AS AMT12
             ,SUM(
                CASE
                    WHEN T1.SIGUMGO_AC_B = 10
                        THEN T1.BIZPLC_BAEJUNG_JI_AMT + T1.BIZPLC_GAM_BAEJUNG_IP_AMT
                    ELSE 0
                    END
              ) AS AMT13
             ,SUM(
                T1.TAXO_FUND_BAEJUNG_JI_AMT + T1.TAXO_HNDO_BAEJUNG_JI_AMT
                    + T1.TAXO_HNDO_JICHUL_JI_AMT + T1.TAXO_FUND_GETBK_JI_AMT
              ) AS AMT14
             ,SUM(T1.TAXO_RTRN_AMT * -1) AS AMT15
             ,SUM(
                CASE
                    WHEN TO_NUMBER(SUBSTR('20250131', 5, 2)) < 3
                        THEN
                        CASE
                            WHEN '0' = 1
                                THEN T1.GA_IWOL_JI_AMT - T1.GA_IWOL_IP_AMT
                            WHEN DECODE(SIGN(NVL(TRIM(T1.BAS_DT), '99991231') - NVL(TRIM(T1.GISDT), '99991231')), 1, T1.GISDT, T1.BAS_DT) > SUBSTR('20250131', 1, 4)||'0100'
                                THEN T1.GA_IWOL_JI_AMT - T1.GA_IWOL_IP_AMT
                            END
                    ELSE 0
                    END
              ) AS AMT16
             ,0 AS AMT17
             ,SUM(T1.PMNY_JAN_MVO_AMT + T1.PMNY_JAN_MVI_AMT) AS AMT18
             ,0 AS AMT19
             ,0 AS AMT20
             ,0 AS AMT21
             ,0 AS AMT22
             ,0 AS AMT23
             ,0 AS AMT24
             ,0 AS AMT25
             ,0 AS AMT26
             ,0 AS AMT27
             ,0 AS AMT28
        FROM
            RPT_TXIO_DDAC_TAB T1
        WHERE 1=1
          AND T1.SIGUMGO_ORG_C = '28'
          AND DECODE(SIGN(NVL(TRIM(T1.BAS_DT), '99991231') - NVL(TRIM(T1.GISDT), '99991231')), 1, T1.GISDT, T1.BAS_DT)
            >= SUBSTR('20250131', 1, 4)||'0100'
          AND DECODE(SIGN(NVL(TRIM(T1.BAS_DT), '99991231') - NVL(TRIM(T1.GISDT), '99991231')), 1, T1.GISDT, T1.BAS_DT) <= '20250131'
          AND T1.ICH_SIGUMGO_HOIKYE_C = '22'
          AND (
                  CASE
                      WHEN '22' IN (21, 22)
                          THEN DECODE(T1.ICH_SIGUMGO_GUN_GU_C, 0, 1, 0)
                      ELSE 1
                      END
                  ) = 1
          AND (
                  CASE
                      WHEN '209331' = 103000
                          THEN DECODE(T1.ICH_SIGUMGO_GUN_GU_C, 0, 1, 0)
                      WHEN '209331' = 104000
                          THEN DECODE(T1.ICH_SIGUMGO_GUN_GU_C, 0, 0, 1)
                      ELSE 1
                      END
                  ) = 1
          AND DECODE(NVL('', '9999'), '9999', 1, DECODE(T1.ICH_SIGUMGO_GUN_GU_C, '', 1, 0)) = 1
          AND (
                  CASE
                      WHEN '0' = 1
                          THEN DECODE(T1.NEW_GU_YR_G, '0', 1, DECODE(T1.SIGUMGO_HOIKYE_YR, '9999', 1, 0))
                      WHEN '0' IN (9, 5)
                          THEN
                          CASE
                              WHEN TO_NUMBER(SUBSTR('20250131', 5, 2)) < 3
                                  THEN
                                  CASE
                                      WHEN DECODE(SIGN(NVL(TRIM(T1.BAS_DT), '99991231') - NVL(TRIM(T1.GISDT), '99991231')), 1, T1.GISDT, T1.BAS_DT)
                                               >= SUBSTR('20250131', 1, 4)-1||'0301'
                                          AND T1.NEW_GU_YR_G = '0'
                                          THEN 1
                                      END
                              ELSE
                                  CASE
                                      WHEN DECODE(SIGN(NVL(TRIM(T1.BAS_DT), '99991231') - NVL(TRIM(T1.GISDT), '99991231')), 1, T1.GISDT, T1.BAS_DT)
                                               >= SUBSTR('20250131', 1, 4)||'0301'
                                          AND T1.NEW_GU_YR_G = '0'
                                          THEN 1
                                      ELSE 0
                                      END
                              END
                      WHEN '0' = 8
                          THEN
                          CASE
                              WHEN TO_NUMBER(SUBSTR('20250131', 5, 2)) < 3
                                  THEN
                                  CASE
                                      WHEN DECODE(SIGN(NVL(TRIM(T1.BAS_DT), '99991231') - NVL(TRIM(T1.GISDT), '99991231')), 1, T1.GISDT, T1.BAS_DT)
                                               >= SUBSTR('20250131', 1, 4)-1||'0100'
                                          AND DECODE(SIGN(NVL(TRIM(T1.BAS_DT), '99991231') - NVL(TRIM(T1.GISDT), '99991231')), 1, T1.GISDT, T1.BAS_DT)
                                               <= SUBSTR('20250131', 1, 4)-1||'1231'
                                          AND T1.NEW_GU_YR_G = 1
                                          THEN 1
                                      WHEN DECODE(SIGN(NVL(TRIM(T1.BAS_DT), '99991231') - NVL(TRIM(T1.GISDT), '99991231')), 1, T1.GISDT, T1.BAS_DT)
                                               >= SUBSTR('20250131', 1, 4)-1||'0301'
                                          AND T1.NEW_GU_YR_G <> 1
                                          THEN 1
                                      END
                              ELSE
                                  CASE
                                      WHEN DECODE(SIGN(NVL(TRIM(T1.BAS_DT), '99991231') - NVL(TRIM(T1.GISDT), '99991231')), 1, T1.GISDT, T1.BAS_DT)
                                               >= SUBSTR('20250131', 1, 4)||'0301'
                                          AND T1.NEW_GU_YR_G <> 1
                                          THEN 1
                                      ELSE 0
                                      END
                              END
                      WHEN '0' = 7
                          THEN
                          DECODE(SIGN(TO_NUMBER(SUBSTR('20250131', 5, 2)) - 3), -1, 1, DECODE(T1.NEW_GU_YR_G, 1, 1, 0))
                      ELSE 1
                      END
                  ) = 1
          AND T1.SIGUMGO_AC_B IN (10, 20)
        GROUP BY
            T1.ICH_SIGUMGO_GUN_GU_C
        UNION ALL
        SELECT
            9999 AS GUNGU_CODE
             ,2 AS DATA_ROW
             ,0 AS AMT1
             ,0 AS AMT2
             ,0 AS AMT3
             ,0 AS AMT4
             ,0 AS AMT5
             ,0 AS AMT6
             ,0 AS AMT7
             ,0 AS AMT8
             ,0 AS AMT9
             ,0 AS AMT10
             ,0 AS AMT11
             ,0 AS AMT12
             ,0 AS AMT13
             ,0 AS AMT14
             ,0 AS AMT15
             ,0 AS AMT16
             ,SUM(T1.DEP_MK_JI_AMT - T1.DEP_HJI_AMT) AS AMT17
             ,0 AS AMT18
             ,0 AS AMT19
             ,0 AS AMT20
             ,0 AS AMT21
             ,0 AS AMT22
             ,0 AS AMT23
             ,0 AS AMT24
             ,0 AS AMT25
             ,0 AS AMT26
             ,0 AS AMT27
             ,0 AS AMT28
        FROM
            RPT_TXIO_DDAC_TAB T1
        WHERE 1=1
          AND T1.SIGUMGO_ORG_C = '28'
          AND T1.ICH_SIGUMGO_HOIKYE_C = '22'
          AND (
                  CASE
                      WHEN '22' IN (21, 22)
                          THEN DECODE(T1.ICH_SIGUMGO_GUN_GU_C, 0, 1, 0)
                      ELSE 1
                      END
                  ) = 1
          AND (
                  CASE
                      WHEN TO_NUMBER(SUBSTR('20250131', 5, 2)) < 3 AND '209331' IN (103000, 104000)
                          THEN
                          CASE
                              WHEN '0' = 1
                                  THEN
                                  CASE
                                      WHEN     DECODE(SIGN(NVL(TRIM(T1.BAS_DT), '99991231') - NVL(TRIM(T1.GISDT), '99991231')), 1, T1.GISDT, T1.BAS_DT) >= SUBSTR('20250131', 1, 4)||'0100'
                                          AND DECODE(SIGN(NVL(TRIM(T1.BAS_DT), '99991231') - NVL(TRIM(T1.GISDT), '99991231')), 1, T1.GISDT, T1.BAS_DT) <= '20250131'
                                          AND DECODE(T1.NEW_GU_YR_G, '0', 1, DECODE(T1.SIGUMGO_HOIKYE_YR, '9999', 1, 0)) = 1
                                          THEN 1
                                      ELSE 0
                                      END
                              WHEN '0' IN (8, 9)
                                  THEN
                                  CASE
                                      WHEN DECODE(SIGN(NVL(TRIM(T1.BAS_DT), '99991231') - NVL(TRIM(T1.GISDT), '99991231')), 1, T1.GISDT, T1.BAS_DT) < SUBSTR('20250131', 1, 4)||'0100'
                                          THEN 1
                                      WHEN     DECODE(SIGN(NVL(TRIM(T1.BAS_DT), '99991231') - NVL(TRIM(T1.GISDT), '99991231')), 1, T1.GISDT, T1.BAS_DT) >= SUBSTR('20250131', 1, 4)||'0100'
                                          AND DECODE(SIGN(NVL(TRIM(T1.BAS_DT), '99991231') - NVL(TRIM(T1.GISDT), '99991231')), 1, T1.GISDT, T1.BAS_DT) <= '20250131'
                                          AND T1.NEW_GU_YR_G = '0'
                                          THEN 1
                                      END
                              WHEN '0' = 5
                                  THEN DECODE(T1.NEW_GU_YR_G, '0', 1, 0)
                              WHEN '0' IN (0, 7)
                                  THEN
                                  CASE
                                      WHEN DECODE(SIGN(NVL(TRIM(T1.BAS_DT), '99991231') - NVL(TRIM(T1.GISDT), '99991231')), 1, T1.GISDT, T1.BAS_DT) < SUBSTR('20250131', 1, 4)||'0100'
                                          THEN 1
                                      WHEN     DECODE(SIGN(NVL(TRIM(T1.BAS_DT), '99991231') - NVL(TRIM(T1.GISDT), '99991231')), 1, T1.GISDT, T1.BAS_DT) >= SUBSTR('20250131', 1, 4)||'0100'
                                          AND DECODE(SIGN(NVL(TRIM(T1.BAS_DT), '99991231') - NVL(TRIM(T1.GISDT), '99991231')), 1, T1.GISDT, T1.BAS_DT) <= '20250131'
                                          AND T1.NEW_GU_YR_G = 9
                                          THEN 1
                                      WHEN     DECODE(SIGN(NVL(TRIM(T1.BAS_DT), '99991231') - NVL(TRIM(T1.GISDT), '99991231')), 1, T1.GISDT, T1.BAS_DT) >= SUBSTR('20250131', 1, 4)||'0100'
                                          AND DECODE(SIGN(NVL(TRIM(T1.BAS_DT), '99991231') - NVL(TRIM(T1.GISDT), '99991231')), 1, T1.GISDT, T1.BAS_DT) <= '20250131'
                                          AND DECODE(T1.NEW_GU_YR_G, '0', 1, DECODE(T1.SIGUMGO_HOIKYE_YR, '9999', 1, 0)) = 1
                                          THEN 1
                                      ELSE 0
                                      END
                              END
                      ELSE
                          CASE
                              WHEN DECODE(SIGN(NVL(TRIM(T1.BAS_DT), '99991231') - NVL(TRIM(T1.GISDT), '99991231')), 1, T1.GISDT, T1.BAS_DT) <= '20250131'
                                  THEN 1
                              ELSE 0
                              END
                      END
                  ) = 1
          AND (
                  CASE
                      WHEN '209331' = 103000
                          THEN DECODE(T1.ICH_SIGUMGO_GUN_GU_C, 0, 1, 0)
                      WHEN '209331' = 104000
                          THEN DECODE(T1.ICH_SIGUMGO_GUN_GU_C, 0, 0, 1)
                      ELSE 1
                      END
                  ) = 1
          AND DECODE(NVL('', '9999'), '9999', 1, DECODE(T1.ICH_SIGUMGO_GUN_GU_C, '', 1, 0)) = 1
          AND T1.SIGUMGO_AC_B IN (10, 20)
        GROUP BY
            T1.ICH_SIGUMGO_GUN_GU_C
    ) T1
   ,(
    SELECT
        T1.REF_D_C
         ,T1.REF_D_NM
    FROM
        RPT_CODE_INFO T1
    WHERE 1=1
      AND T1.REF_L_C = 500
      AND T1.REF_M_C = 28
      AND T1.REF_S_C = 5
    UNION ALL
    SELECT
        9999 AS REF_D_C, '합계' AS REF_D_NM
    FROM
        DUAL
) T2
WHERE 1=1
  AND T2.REF_D_C = T1.GUNGU_CODE(+)
GROUP BY
    T2.REF_D_C
       ,T2.REF_D_NM
       ,T1.DATA_ROW
ORDER BY
    T2.REF_D_C

-- 긍액차이 7100 상수도본부 785,150

SELECT
    *
FROM
    RPT_SUNAP_JIBGYE
WHERE SUNAPIL BETWEEN '20250106' AND '20250106'
AND GEUMGO_CODE = 28
AND GUNGU_CODE = 0
AND JIBGYE_CODE = 209332

SELECT
    *
FROM
    RPT_SUNAP_JIBGYE
WHERE SUNAPIL BETWEEN '20250106' AND '20250106'
  AND GEUMGO_CODE = 28
  AND GUNGU_CODE = 0
  AND JIBGYE_CODE = 281020

SELECT
    *
FROM
    RPT_SUNAP_JIBGYE
WHERE SUNAPIL BETWEEN '20250106' AND '20250106'
  AND GEUMGO_CODE = 28
  AND GUNGU_CODE = 0
  AND JIBGYE_CODE = 216200


SELECT
    *
FROM RPT_DANGSEIPJOJEONG
WHERE SUNAPIL BETWEEN '20250131' AND '20250131'
AND GEUMGO_CODE = 28
AND GUNGU_CODE = 0
AND JIBGYE_CODE = 209332


SELECT
    *
FROM RPT_TXI_DDAC_TAB
WHERE 1=1
  AND SIGUMGO_ORG_C = '28'
  AND SUNAP_DT BETWEEN '20250101' AND '20250131'
  AND ICH_SIGUMGO_HOIKYE_C IN ('22', 62)
  AND SIGUTAX_G = NVL('', '1')
  AND  (  ( '22' =  22  AND ICH_SIGUMGO_HOIKYE_C IN (22, 62, 209332) ) OR
          ( '22' =  213000  AND ICH_SIGUMGO_HOIKYE_C IN (213000, 217100) ) OR
          ( '22' =  99 )  OR
          ( '22' NOT IN (22,213000,99) AND ICH_SIGUMGO_HOIKYE_C = '22' ) )
  AND  (  ( '22' = 22 AND '' = 0 AND ICH_SIGUMGO_GUN_GU_C  IN (7000, 7040, 7810, 7055, 7830, 7840, 7850, 7100, 0) )
    OR ( '22' IN (21,22,93) AND DECODE('', '', 9999, '') = 9999 )
    OR ( '22' = 22 AND DECODE('', '', 9999, '') NOT IN (0,9999) AND ( CASE WHEN ICH_SIGUMGO_GUN_GU_C = 7100 THEN  0
                                                                           WHEN ICH_SIGUMGO_GUN_GU_C > 7100 AND ICH_SIGUMGO_GUN_GU_C < 7800 THEN ICH_SIGUMGO_GUN_GU_C - 7000 ELSE ICH_SIGUMGO_GUN_GU_C END) = DECODE(DECODE('', '', 9999, ''), 9999, ICH_SIGUMGO_GUN_GU_C, '') )
    OR ('22' IN ( 21,93) AND '' = 7100 AND ICH_SIGUMGO_GUN_GU_C  IN (0, 7000, 100, 7100) )
    OR ('22' IN ( 21,93) AND '' <> 7100 AND ICH_SIGUMGO_GUN_GU_C IN ('', SUBSTR('',2,3)) )
    OR ('22' NOT IN (21,22,93) AND ICH_SIGUMGO_GUN_GU_C  = DECODE(DECODE('', '', 9999, ''), 9999, ICH_SIGUMGO_GUN_GU_C, '') ) )
  AND (
    (
        '0' = 1
            AND
        SUNAP_DT >= SUBSTR('20250131',1,4)||'0101'
            AND
        NEW_GU_YR_G = 1
        )
        OR  (
        '0' = 9
            AND
        SUBSTR('20250131',5,2) < 3
            AND
        SUNAP_DT >= (SUBSTR('20250131',1,4) - 1 )||'0301' AND NEW_GU_YR_G = 9
        )
        OR  (
        '0' = 9
            AND
        SUBSTR('20250131',5,2) >= 3
            AND
        SUNAP_DT >= (SUBSTR('20250131',1,4))||'0301' AND  NEW_GU_YR_G = 9
        )
        OR  (
        '0' = 5
            AND
        SUBSTR('20250131',5,2) < 3
            AND
        SUNAP_DT >= (SUBSTR('20250131',1,4) - 1 )||'0301' AND NEW_GU_YR_G = 5
        )
        OR  (
        '0' = 5
            AND
        SUBSTR('20250131',5,2) >= 3
            AND
        SUNAP_DT >= (SUBSTR('20250131',1,4))||'0301' AND  NEW_GU_YR_G = 5
        )
        OR (
        (
            '0' = 8
                AND
            SUBSTR('20250131',5,2) < 3
                AND
            SUNAP_DT BETWEEN  (SUBSTR('20250131',1,4) - 1 )||'0100' AND (SUBSTR('20250131',1,4) - 1 )||'0100'
                AND
            NEW_GU_YR_G = 1
            )
            OR
        (
            '0' = 8
                AND
            SUBSTR('20250131',5,2) < 3
                AND
            SUNAP_DT BETWEEN (SUBSTR('20250131',1,4) - 1 )||'0301' AND '20250131'
                AND
            NEW_GU_YR_G <> 1
            )
            OR
        (
            '0' = 8
                AND
            SUBSTR('20250131',5,2) >= 3
                AND
            SUNAP_DT BETWEEN SUBSTR('20250131',1,4)||'0301' AND '20250131'
                AND
            NEW_GU_YR_G <> 1
            )
        )
        OR (

        '0' = 0
            AND
        SUNAP_DT >= SUBSTR('20250131',1,4)

        )
        OR (

        (
            '0' = 7
                AND
            SUNAP_DT >= SUBSTR('20250131',1,4)
                AND
            NEW_GU_YR_G = 1
            )
            OR
        (
            '0' = 7
                AND
            SUBSTR('20250131',5,2) < 3
                AND
            SUNAP_DT BETWEEN (SUBSTR('20250131',1,4) - 1 )||'0301' AND '20250131'
                AND
            NEW_GU_YR_G <> 1
            )
            OR
        (
            '0' = 7
                AND
            SUBSTR('20250131',5,2) >= 3
                AND
            SUNAP_DT BETWEEN SUBSTR('20250131',1,4)||'0301' AND '20250131'
                AND
            NEW_GU_YR_G <> 1
            )

        )
    )

--------------------------------------------

SELECT
    *
FROM RPT_TXI_DDAC_TAB
WHERE 1=1
  AND SIGUMGO_ORG_C = '28'
  AND SUNAP_DT BETWEEN '20250101' AND '20250131'
  AND ICH_SIGUMGO_HOIKYE_C IN ('22', 62)
  AND SIGUTAX_G = NVL('', '1')
  AND  (  ( '22' =  22  AND ICH_SIGUMGO_HOIKYE_C IN (22, 62, 209332) ) OR
          ( '22' =  213000  AND ICH_SIGUMGO_HOIKYE_C IN (213000, 217100) ) OR
          ( '22' =  99 )  OR
          ( '22' NOT IN (22,213000,99) AND ICH_SIGUMGO_HOIKYE_C = '22' ) )
  AND  (  ( '22' = 22 AND '' = 0 AND ICH_SIGUMGO_GUN_GU_C  IN (7000, 7040, 7810, 7055, 7830, 7840, 7850, 7100, 0) )
    OR ( '22' IN (21,22,93) AND DECODE('', '', 9999, '') = 9999 )
    OR ( '22' = 22 AND DECODE('', '', 9999, '') NOT IN (0,9999) AND ( CASE WHEN ICH_SIGUMGO_GUN_GU_C = 7100 THEN  0
                                                                           WHEN ICH_SIGUMGO_GUN_GU_C > 7100 AND ICH_SIGUMGO_GUN_GU_C < 7800 THEN ICH_SIGUMGO_GUN_GU_C - 7000 ELSE ICH_SIGUMGO_GUN_GU_C END) = DECODE(DECODE('', '', 9999, ''), 9999, ICH_SIGUMGO_GUN_GU_C, '') )
    OR ('22' IN ( 21,93) AND '' = 7100 AND ICH_SIGUMGO_GUN_GU_C  IN (0, 7000, 100, 7100) )
    OR ('22' IN ( 21,93) AND '' <> 7100 AND ICH_SIGUMGO_GUN_GU_C IN ('', SUBSTR('',2,3)) )
    OR ('22' NOT IN (21,22,93) AND ICH_SIGUMGO_GUN_GU_C  = DECODE(DECODE('', '', 9999, ''), 9999, ICH_SIGUMGO_GUN_GU_C, '') ) )
  AND (
    (
        '0' = 1
            AND
        SUNAP_DT >= SUBSTR('20250131',1,4)||'0101'
            AND
        NEW_GU_YR_G = 1
        )
        OR  (
        '0' = 9
            AND
        SUBSTR('20250131',5,2) < 3
            AND
        SUNAP_DT >= (SUBSTR('20250131',1,4) - 1 )||'0301' AND NEW_GU_YR_G = 9
        )
        OR  (
        '0' = 9
            AND
        SUBSTR('20250131',5,2) >= 3
            AND
        SUNAP_DT >= (SUBSTR('20250131',1,4))||'0301' AND  NEW_GU_YR_G = 9
        )
        OR  (
        '0' = 5
            AND
        SUBSTR('20250131',5,2) < 3
            AND
        SUNAP_DT >= (SUBSTR('20250131',1,4) - 1 )||'0301' AND NEW_GU_YR_G = 5
        )
        OR  (
        '0' = 5
            AND
        SUBSTR('20250131',5,2) >= 3
            AND
        SUNAP_DT >= (SUBSTR('20250131',1,4))||'0301' AND  NEW_GU_YR_G = 5
        )
        OR (
        (
            '0' = 8
                AND
            SUBSTR('20250131',5,2) < 3
                AND
            SUNAP_DT BETWEEN  (SUBSTR('20250131',1,4) - 1 )||'0100' AND (SUBSTR('20250131',1,4) - 1 )||'0100'
                AND
            NEW_GU_YR_G = 1
            )
            OR
        (
            '0' = 8
                AND
            SUBSTR('20250131',5,2) < 3
                AND
            SUNAP_DT BETWEEN (SUBSTR('20250131',1,4) - 1 )||'0301' AND '20250131'
                AND
            NEW_GU_YR_G <> 1
            )
            OR
        (
            '0' = 8
                AND
            SUBSTR('20250131',5,2) >= 3
                AND
            SUNAP_DT BETWEEN SUBSTR('20250131',1,4)||'0301' AND '20250131'
                AND
            NEW_GU_YR_G <> 1
            )
        )
        OR (

        '0' = 0
            AND
        SUNAP_DT >= SUBSTR('20250131',1,4)

        )
        OR (

        (
            '0' = 7
                AND
            SUNAP_DT >= SUBSTR('20250131',1,4)
                AND
            NEW_GU_YR_G = 1
            )
            OR
        (
            '0' = 7
                AND
            SUBSTR('20250131',5,2) < 3
                AND
            SUNAP_DT BETWEEN (SUBSTR('20250131',1,4) - 1 )||'0301' AND '20250131'
                AND
            NEW_GU_YR_G <> 1
            )
            OR
        (
            '0' = 7
                AND
            SUBSTR('20250131',5,2) >= 3
                AND
            SUNAP_DT BETWEEN SUBSTR('20250131',1,4)||'0301' AND '20250131'
                AND
            NEW_GU_YR_G <> 1
            )

        )
    )

-------------------------------------------

SELECT
    *
FROM RPT_TXI_DDAC_TAB
WHERE SIGUMGO_ORG_C = '28'
  AND SUNAP_DT BETWEEN '20250106' AND '20250106'
  AND ICH_SIGUMGO_HOIKYE_C = 62

---------------------------------------------


SELECT
    *
FROM
    RPT_SUNAP_JIBGYE T1
WHERE 1=1
  AND T1.GEUMGO_CODE = '28'
  AND T1.SUNAPIL >= (
    CASE
        WHEN  TO_NUMBER(SUBSTR('20250131', 5, 2)) < 3
            AND '209331' IN (103000, 104000, 213000)
            AND '0' IN (8, 9)
            THEN  SUBSTR('20250131', 1, 4) - 1||DECODE('0', 9, '0301', '0101')
        ELSE  SUBSTR('20250131', 1, 4)||'0101'
        END
    )
  AND T1.SUNAPIL <= '20250131'
  AND (
          CASE
              WHEN '0' = 1
                  THEN
                  CASE
                      WHEN T1.SUNAPIL >= SUBSTR('20250131', 1, 4)||'0100'
                          AND DECODE(T1.YEAR_GUBUN, '0', 1, DECODE(T1.HOIGYE_YEAR, '9999', 1, 0)) = 1
                          THEN 1
                      ELSE 0
                      END
              WHEN '0' IN (9, 5)
                  THEN
                  CASE
                      WHEN TO_NUMBER(SUBSTR('20250131', 5, 2)) < 3
                          THEN
                          CASE
                              WHEN T1.SUNAPIL >= SUBSTR('20250131', 1, 4)-1||'0301' AND T1.YEAR_GUBUN = '0'
                                  THEN 1
                              ELSE 0
                              END
                      ELSE
                          CASE
                              WHEN T1.SUNAPIL >= SUBSTR('20250131', 1, 4)||'0301' AND T1.YEAR_GUBUN = '0'
                                  THEN 1
                              ELSE 0
                              END
                      END
              WHEN '0' = 8
                  THEN
                  CASE
                      WHEN TO_NUMBER(SUBSTR('20250131', 5, 2)) < 3
                          THEN
                          CASE
                              WHEN T1.SUNAPIL >= SUBSTR('20250131', 1, 4)-1||'0100'
                                  AND T1.SUNAPIL <= SUBSTR('20250131', 1, 4)-1||'1231'
                                  AND T1.YEAR_GUBUN = 1
                                  THEN 1
                              WHEN T1.SUNAPIL >= SUBSTR('20250131', 1, 4)-1||'0300'
                                  AND T1.YEAR_GUBUN <> 1
                                  THEN 1
                              ELSE 0
                              END
                      ELSE
                          CASE
                              WHEN T1.SUNAPIL >= SUBSTR('20250131', 1, 4)||'0301' AND T1.YEAR_GUBUN <> 1
                                  THEN 1
                              ELSE 0
                              END
                      END
              WHEN  '0' IN (0, 7)
                  THEN
                  CASE
                      WHEN T1.SUNAPIL >= SUBSTR('20250131', 1, 4)||'0100' THEN 1
                      ELSE 0
                      END
              ELSE 0
              END
          ) = 1
  AND (
          CASE
              WHEN '209331' = 209331
                  THEN
                  CASE
                      WHEN T1.JIBGYE_CODE IN (209331, 209332, 216200)
                          THEN 1
                      WHEN T1.HOIKYE_SMOK_C = 281020 AND T1.SUNAPIL >= '20230201'
                          THEN 1
                      ELSE 0
                      END
              ELSE  DECODE(T1.JIBGYE_CODE, '209331', 1, 0)
              END
          ) = 1
  AND DECODE(NVL('', '9999'), '9999', 1, DECODE(T1.GUNGU_CODE, '', 1, 0)) = 1
  and sunapil = '20250106'