SELECT
          T1.HOIGYE_CD AS HOIGYE_CODE,
          T1.HOIGYE_CD AS JIBGYE_CODE,
          T2.FIL_100_CTNT1 AS HOIGYE_NAME,
          T2.FIL_100_CTNT1 AS JIBGYE_NAME,
          SUM(BEF_AMT) AS BEF_AMT,
          SUM(CUR_SUIB) AS CUR_SUIB,
          SUM(CUR_BACK) AS CUR_BACK,
          0 AS KYONGJENONG,
          SUM(CUR_AMT) AS JAN_AMT,
          SUM(BEF_AMT) + SUM(CUR_AMT) AS NUGYE_AMT
FROM (
            SELECT
                 DECODE(T1.ICH_SIGUMGO_HOIKYE_C,'62','22',T1.ICH_SIGUMGO_HOIKYE_C) AS HOIGYE_CD    
                , '' AS JIBGYE_CODE           
                ,T1.SIGUMGO_ORG_C

          ,SUM(
                    CASE
                        WHEN '1' = '1' AND T1.SUNAP_DT < TO_CHAR(TRUNC(TO_DATE('20240229', 'YYYYMMDD'), 'MM'), 'YYYYMMDD')
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        WHEN '1' = '2' AND T1.SUNAP_DT < TO_CHAR(TRUNC(TO_DATE('20240229', 'YYYYMMDD'), 'Q'), 'YYYYMMDD')
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        ELSE 0
                    END
                ) AS BEF_AMT
                ,SUM(
                    CASE
                        WHEN '1' = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE('20240229', 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= '20240229'
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT
                        WHEN '1' = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE('20240229', 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= '20240229'
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT
                        ELSE 0
                    END
                ) AS CUR_SUIB
                ,SUM(
                    CASE
                        WHEN '1' = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE('20240229', 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= '20240229'
                        THEN T1.JIBANGSE_GWAON_AMT + T1.SEWOI_GWAON_AMT
                        WHEN '1' = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE('20240229', 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= '20240229'
                        THEN T1.JIBANGSE_GWAON_AMT + T1.SEWOI_GWAON_AMT
                        ELSE 0
                    END
                ) AS CUR_BACK
                ,SUM(
                    CASE
                        WHEN '1' = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE('20240229', 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= '20240229'
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        WHEN '1' = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE('20240229', 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= '20240229'
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        ELSE 0
                    END
                ) AS CUR_AMT
            FROM
                RPT_TXI_DDAC_TAB T1                
            WHERE 1=1                
                AND T1.SIGUMGO_ORG_C = 28
                AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE('20240229', 'YYYYMMDD'), 'YYYY'), 'YYYYMMDD')
                AND T1.SUNAP_DT <= '20240229'

                AND T1.ICH_SIGUMGO_HOIKYE_C IN (22, 62)
                AND T1.SIGUTAX_G = NVL('', '1')
                AND  (  ( '0' NOT IN (2,8,9) AND T1.SUNAP_DT BETWEEN SUBSTR('20240229',1,4)||'0100' AND '20240229' )
                     OR ( '0' in (2,9) AND SUBSTR('20240229',5,2) <  3  AND T1.SUNAP_DT BETWEEN (SUBSTR('20240229',1,4) - 1 )||'0301' AND '20240229')
                     OR ( '0' in (2,9) AND SUBSTR('20240229',5,2) >= 3  AND T1.SUNAP_DT BETWEEN SUBSTR('20240229',1,4)||'0101' AND '20240229')
                     OR ( '0' = 8 AND SUBSTR('20240229',5,2) <  3  AND T1.SUNAP_DT BETWEEN (SUBSTR('20240229',1,4) - 1 )||'0101' AND '20240229')
                     OR ( '0' = 8 AND SUBSTR('20240229',5,2) >= 3  AND T1.SUNAP_DT BETWEEN SUBSTR('20240229',1,4)||'0101' AND '20240229'))
                AND  (  ( '22' =  22  AND T1.ICH_SIGUMGO_HOIKYE_C IN (22, 62, 209332) ) OR
                        ( 22 =  213000  AND T1.ICH_SIGUMGO_HOIKYE_C IN (213000, 217100) ) OR
                        ( 22 =  99 )  OR
                        ( 22 NOT IN (22,213000,99) AND T1.ICH_SIGUMGO_HOIKYE_C = 22 ) )
                AND  (  ( 22 = 22 AND 170 = 0 AND T1.ICH_SIGUMGO_GUN_GU_C  IN (7000, 7040, 7810, 7055, 7830, 7840, 7850, 7100, 0) )
                        OR ( 22 IN (21,22,93) AND 170 = 9999 )
                        OR ( 22 = 22 AND 170 NOT IN (0,9999) AND ( CASE WHEN T1.ICH_SIGUMGO_GUN_GU_C = 7100 THEN  0
                                WHEN T1.ICH_SIGUMGO_GUN_GU_C > 7100 AND T1.ICH_SIGUMGO_GUN_GU_C < 7800 THEN T1.ICH_SIGUMGO_GUN_GU_C - 7000 ELSE T1.ICH_SIGUMGO_GUN_GU_C END) = DECODE(170, 9999, T1.ICH_SIGUMGO_GUN_GU_C, 170) )
                        OR (22 IN ( 21,93) AND 170 = 7100 AND T1.ICH_SIGUMGO_GUN_GU_C  IN (0, 7000, 100, 7100) )
                        OR (22 IN ( 21,93) AND 170 <> 7100 AND T1.ICH_SIGUMGO_GUN_GU_C IN (170, SUBSTR(170,2,3)) )
                        OR (22 NOT IN (21,22,93) AND T1.ICH_SIGUMGO_GUN_GU_C  = DECODE(170, 9999, T1.ICH_SIGUMGO_GUN_GU_C, 170) ) )
                AND (  ( '0' = 0 AND SUBSTR('20240229',5,2) < 3  AND T1.SUNAP_DT >= SUBSTR('20240229',1,4)||'0101'   )
                    OR ( '0' = 0 AND SUBSTR('20240229',5,2) >= 3 AND
                         (  ( T1.SUNAP_DT >= SUBSTR('20240229',1,4)||'0101' AND T1.NEW_GU_YR_G= 1)
                         OR ( T1.SUNAP_DT >= SUBSTR('20240229',1,4)||'0301' AND T1.NEW_GU_YR_G <> 1)))
                    OR  ( '0' = 1 AND  T1.SUNAP_DT >= SUBSTR('20240229',1,4)||'0101' AND  (T1.NEW_GU_YR_G = 1 OR T1.SIGUMGO_HOIKYE_YR = 9999 ) )
                    OR  ( '0' in (2,9) AND  SUBSTR('20240229',5,2) < 3  AND T1.SUNAP_DT >= (SUBSTR('20240229',1,4) - 1 )||'0301' AND T1.NEW_GU_YR_G = 9 )
                    OR  ( '0' in (2,9) AND  SUBSTR('20240229',5,2) >= 3 AND  T1.SUNAP_DT >= (SUBSTR('20240229',1,4))||'0301' AND  T1.NEW_GU_YR_G = 9 )
                    OR  ( '0' = 5 AND  SUBSTR('20240229',5,2) < 3  AND T1.SUNAP_DT >= (SUBSTR('20240229',1,4) - 1 )||'0301' AND T1.NEW_GU_YR_G = 5 )
                    OR  ( '0' = 5 AND  SUBSTR('20240229',5,2) >= 3 AND  T1.SUNAP_DT >= (SUBSTR('20240229',1,4))||'0301' AND  T1.NEW_GU_YR_G = 5 )
                    OR  ( '0' = 8 AND  SUBSTR('20240229',5,2) < 3  AND (
                                         (T1.SUNAP_DT BETWEEN (SUBSTR('20240229',1,4) - 1 )||'0001' AND (SUBSTR('20240229',1,4) - 1 )||'1231' AND T1.NEW_GU_YR_G = 1 )
                                      OR (T1.SUNAP_DT >= (SUBSTR('20240229',1,4) - 1 )||'0301' AND T1.NEW_GU_YR_G <> 1)))
                    OR  ( '0' = 8 AND  SUBSTR('20240229',5,2) >= 3 AND  T1.SUNAP_DT >= (SUBSTR('20240229',1,4))||'0301' AND  T1.NEW_GU_YR_G <> 1 ))
            GROUP BY DECODE(T1.ICH_SIGUMGO_HOIKYE_C,'62','22',T1.ICH_SIGUMGO_HOIKYE_C),T1.SIGUMGO_ORG_C
  
            UNION ALL
                SELECT '22' AS HOIGYE_CD, 
                       '22' JIBGYE_CODE, 
                       28 SIGUMGO_ORG_C,

                        SUM(CASE  WHEN '1' = '1' AND SUNAPIL < (SUBSTR('20240229',1,6))||'00' THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN '1' = '2' AND SUBSTR('20240229',5,2) >= 10 AND SUNAPIL < (SUBSTR('20240229',1,4))||'1000'  THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN '1' = '2' AND SUBSTR('20240229',5,2) >= 7  AND SUBSTR('20240229',5,2) < 10 AND SUNAPIL < (SUBSTR('20240229',1,4))||'0700'  THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN '1' = '2' AND SUBSTR('20240229',5,2) >= 4  AND SUBSTR('20240229',5,2) < 7 AND  SUNAPIL < (SUBSTR('20240229',1,4))||'0400'   THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                        ELSE 0 END)  BEF_AMT,
                        SUM(CASE WHEN '1' = '1' AND SUNAPIL BETWEEN (SUBSTR('20240229',1,6))||'01' AND '20240229'  THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN '1' = '2' AND SUBSTR('20240229',5,2) >= 10 AND SUNAPIL BETWEEN (SUBSTR('20240229',1,4))||'1001' AND '20240229' THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN '1' = '2' AND SUBSTR('20240229',5,2) >= 7 AND SUBSTR('20240229',5,2) < 10 AND SUNAPIL BETWEEN (SUBSTR('20240229',1,4))||'0701' AND '20240229' THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN '1' = '2' AND SUBSTR('20240229',5,2) >= 4 AND SUBSTR('20240229',5,2) < 7 AND SUNAPIL BETWEEN (SUBSTR('20240229',1,4))||'0401' AND '20240229'  THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN '1' = '2' AND SUBSTR('20240229',5,2) <  4 AND SUNAPIL <= '20240229'  THEN NVL(NAPBU_SIDO_TAX_AMT,0) ELSE 0 END) CUR_SUIB,
                        0 CUR_BACK,
                        SUM(CASE WHEN '1' = '1' AND SUNAPIL BETWEEN (SUBSTR('20240229',1,6))||'01' AND '20240229' THEN  NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN '1' = '2' AND SUBSTR('20240229',5,2) >= 10 AND SUNAPIL BETWEEN (SUBSTR('20240229',1,4))||'1001' AND '20240229'  THEN  NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN '1' = '2' AND SUBSTR('20240229',5,2) >= 7  AND SUBSTR('20240229',5,2) < 10 AND  SUNAPIL BETWEEN (SUBSTR('20240229',1,4))||'0701' AND '20240229' THEN  NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN '1' = '2' AND SUBSTR('20240229',5,2) >= 4  AND SUBSTR('20240229',5,2) < 7 AND  SUNAPIL BETWEEN (SUBSTR('20240229',1,4))||'0401' AND '20240229' THEN  NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN '1' = '2' AND SUBSTR('20240229',5,2) <  4  AND SUNAPIL <= '20240229'  THEN  NVL(NAPBU_SIDO_TAX_AMT,0)
                        ELSE 0 END) CUR_AMT
                FROM
                (
                    SELECT SUNP_DT AS SUNAPIL,
                        CASE  WHEN NEW_GU_YR_G = 1 THEN 1 WHEN NEW_GU_YR_G = 2 THEN 9  ELSE  99 END YEAR_GUBUN,
                        HOIKYE_CD, SMOK_CD,
                        CASE WHEN CVT_GUCHUNG_CD = '357' THEN 710 WHEN CVT_GUCHUNG_CD = '358' THEN 720 ELSE TO_NUMBER(NVL(CVT_GUCHUNG_CD,0)) END AS GUNGU_CD,
                        NAPBU_TCNT, NAPBU_NTAX_AMT, NAPBU_SIDO_TAX_AMT, NAPBU_SIGNGU_TAX_AMT
                    FROM NIO_STAX_MASTR_TAB
                    WHERE SUNP_DT BETWEEN SUBSTR('20240229',1,4)||'0100' AND '20240229'  AND FORM_G <> '1' AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND SIDO_CD <> '628' AND (SUBSTR(SMOK_CD,1,3)  <> '299' OR   SUBSTR(SMOK_CD,4,3) <> '099')
                    AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358') AND HOIKYE_CD = '51' AND SMOK_CD = '281020'
                    UNION
                    SELECT A.SUNP_DT AS SUNAPIL,
                        CASE  WHEN NEW_GU_YR_G = 1 THEN 1 WHEN NEW_GU_YR_G = 2 THEN 9  ELSE  99 END YEAR_GUBUN,
                                        A.HOIKYE_CD HOIKYE_CD, A.SMOK_CD SMOK_CD,
                        CASE WHEN CVT_GUCHUNG_CD = '357' THEN 710 WHEN CVT_GUCHUNG_CD = '358' THEN 720 ELSE TO_NUMBER(NVL(CVT_GUCHUNG_CD,0))  END AS GUNGU_CD,
                        A.NAPBU_TCNT NAPBU_TCNT, A.NAPBU_NTAX_AMT NAPBU_NTAX_AMT, A.NAPBU_SIDO_TAX_AMT NAPBU_SIDO_TAX_AMT, A.NAPBU_SIGNGU_TAX_AMT NAPBU_SIGNGU_TAX_AMT
                    FROM NIO_STAX_MASTR_TAB A, NIO_DEPT_INF_TAB B
                            WHERE A.SUNP_DT BETWEEN SUBSTR('20240229',1,4)||'0100' AND '20240229'  AND FORM_G <> '1' AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND SIDO_CD = '628' AND (SUBSTR(A.SMOK_CD,1,3) <> '299' OR  SUBSTR(A.SMOK_CD,4,3) <> '099')
                            AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358') AND A.HOIKYE_CD = '51' AND A.SMOK_CD = '281020'
                            AND A.SIDO_CD = B.GUCHUNG_CD(+) AND A.DEPT_CD = B.DEPT_CD(+) AND A.HOIKYE_CD = B.HOIKYE_CD(+) AND A.SMOK_CD = B.SMOK_CD(+)
                            UNION
                            SELECT
                        SUNP_DT AS SUNAPIL,
                        CASE  WHEN NEW_GU_YR_G = 1 THEN 1    WHEN NEW_GU_YR_G = 2 THEN 9 ELSE  99 END YEAR_GUBUN,
                        HOIKYE_CD,
                        SMOK_CD,
                        CASE WHEN CVT_GUCHUNG_CD = '357' THEN 710 WHEN CVT_GUCHUNG_CD = '358' THEN 720 ELSE TO_NUMBER(NVL(CVT_GUCHUNG_CD,0)) END  AS GUNGU_CD,
                        NAPBU_TCNT,
                        NVL(SUM(GUKSAE), 0) AS NAPBU_NTAX_AMT, NVL(SUM(SIDOSAE),0) AS NAPBU_SIDO_TAX_AMT, NVL(SUM(SIGUNSAE),0) AS NAPBU_SIGNGU_TAX_AMT
                            FROM
                    (
                        SELECT
                                        BLK_NO, PROC_SEQ, SUNP_DT, NEW_GU_YR_G,
                                        HOIKYE_CD, SMOK_CD,
                                        CVT_GUCHUNG_CD,
                                        NAPBU_TCNT,
                                        CASE WHEN FILLER2 = '1' THEN NTAX_AMT + SIDO_TAX_AMT + SIGNGU_TAX_AMT - NAPGILT_AMT END AS GUKSAE,
                                        CASE WHEN FILLER2 = '2' THEN NTAX_AMT + SIDO_TAX_AMT + SIGNGU_TAX_AMT - NAPGILT_AMT END AS SIDOSAE,
                                        CASE WHEN FILLER2 = '3' THEN NTAX_AMT + SIDO_TAX_AMT + SIGNGU_TAX_AMT - NAPGILT_AMT END AS SIGUNSAE
                        FROM  NIO_STAX_MASTR_TAB
                        WHERE SUNP_DT BETWEEN SUBSTR('20240229',1,4)||'0100' AND '20240229'  AND FILLER2 > '0' AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND FORM_G <> '1'
                        AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358') AND HOIKYE_CD = '51' AND SMOK_CD = '281020'
                    )
                GROUP BY SUNP_DT, NEW_GU_YR_G, HOIKYE_CD, SMOK_CD,CVT_GUCHUNG_CD, NAPBU_TCNT
                    UNION
                    SELECT
                        SUNP_DT AS SUNAPIL,
                        CASE  WHEN NEW_GU_YR_G = 1 THEN 1  WHEN NEW_GU_YR_G = 2 THEN 9  ELSE  99 END YEAR_GUBUN,
                        HOIKYE_CD,
                        SMOK_CD,
                                        CASE WHEN CVT_GUCHUNG_CD = '357' THEN 710
                                            WHEN CVT_GUCHUNG_CD = '358' THEN 720
                                ELSE TO_NUMBER(NVL(CVT_GUCHUNG_CD,0)) END  AS GUNGU_CD,
                        NAPBU_TCNT,
                        NVL(SUM(NAPBU_NTAX_AMT), 0) AS NAPBU_NTAX_AMT, NVL(SUM(NAPBU_SIDO_TAX_AMT), 0) AS NAPBU_SIDO_TAX_AMT, 
                        NVL(SUM(NAPBU_SIGNGU_TAX_AMT), 0) AS NAPBU_SIGNGU_TAX_AMT
                    FROM
                    (
                        SELECT SUNP_DT, NEW_GU_YR_G,
                                                    HOIKYE_CD, SMOK_CD,
                                                    CVT_GUCHUNG_CD,
                                                    NAPBU_TCNT, NAPBU_NTAX_AMT, NAPBU_SIDO_TAX_AMT, NAPBU_SIGNGU_TAX_AMT
                        FROM NIO_STAX_MASTR_TAB
                        WHERE SUNP_DT BETWEEN SUBSTR('20240229',1,4)||'0100' AND '20240229'  AND SUBSTR(SMOK_CD,1,3) = '299' AND SUBSTR(SMOK_CD,4,3)  = '099'  AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND FORM_G <> '1'
                        AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358') AND HOIKYE_CD = '51' AND SMOK_CD = '281020'
                    )
                    GROUP BY SUNP_DT, NEW_GU_YR_G, HOIKYE_CD, SMOK_CD,CVT_GUCHUNG_CD,NAPBU_TCNT
                )
                WHERE 1 = 1
                AND  (GUNGU_CD = 170 OR 9999 = 170 )
                GROUP BY GUNGU_CD

            ) T1, 
            RPT_HOIKYE_CD T2
    WHERE 1=1
    AND T1.HOIGYE_CD = T2.SIGUMGO_HOIKYE_C(+)
    AND T1.SIGUMGO_ORG_C = T2.SIGUMGO_C(+)
    GROUP BY T1.HOIGYE_CD, T1.SIGUMGO_ORG_C, T2.FIL_100_CTNT1


-------------------------------------------------------------------------------------------------


SELECT
          T1.HOIGYE_CD AS HOIGYE_CODE,
          T1.HOIGYE_CD AS JIBGYE_CODE,
          T2.FIL_100_CTNT1 AS HOIGYE_NAME,
          T2.FIL_100_CTNT1 AS JIBGYE_NAME,
          SUM(BEF_AMT) AS BEF_AMT,
          SUM(CUR_SUIB) AS CUR_SUIB,
          SUM(CUR_BACK) AS CUR_BACK,
          0 AS KYONGJENONG,
          SUM(CUR_AMT) AS JAN_AMT,
          SUM(BEF_AMT) + SUM(CUR_AMT) AS NUGYE_AMT
FROM (
            SELECT
                 DECODE(T1.ICH_SIGUMGO_HOIKYE_C,'62','22',T1.ICH_SIGUMGO_HOIKYE_C) AS HOIGYE_CD    
                , '' AS JIBGYE_CODE           
                ,T1.SIGUMGO_ORG_C

          ,SUM(
                    CASE
                        WHEN '1' = '1' AND T1.SUNAP_DT < TO_CHAR(TRUNC(TO_DATE('20240331', 'YYYYMMDD'), 'MM'), 'YYYYMMDD')
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        WHEN '1' = '2' AND T1.SUNAP_DT < TO_CHAR(TRUNC(TO_DATE('20240331', 'YYYYMMDD'), 'Q'), 'YYYYMMDD')
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        ELSE 0
                    END
                ) AS BEF_AMT
                ,SUM(
                    CASE
                        WHEN '1' = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE('20240331', 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= '20240331'
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT
                        WHEN '1' = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE('20240331', 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= '20240331'
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT
                        ELSE 0
                    END
                ) AS CUR_SUIB
                ,SUM(
                    CASE
                        WHEN '1' = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE('20240331', 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= '20240331'
                        THEN T1.JIBANGSE_GWAON_AMT + T1.SEWOI_GWAON_AMT
                        WHEN '1' = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE('20240331', 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= '20240331'
                        THEN T1.JIBANGSE_GWAON_AMT + T1.SEWOI_GWAON_AMT
                        ELSE 0
                    END
                ) AS CUR_BACK
                ,SUM(
                    CASE
                        WHEN '1' = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE('20240331', 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= '20240331'
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        WHEN '1' = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE('20240331', 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= '20240331'
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        ELSE 0
                    END
                ) AS CUR_AMT
            FROM
                RPT_TXI_DDAC_TAB T1                
            WHERE 1=1                
                AND T1.SIGUMGO_ORG_C = 28
                AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE('20240331', 'YYYYMMDD'), 'YYYY'), 'YYYYMMDD')
                AND T1.SUNAP_DT <= '20240331'

                AND T1.ICH_SIGUMGO_HOIKYE_C IN (22, 62)
                AND T1.SIGUTAX_G = NVL('', '1')
                AND  (  ( '0' NOT IN (2,8,9) AND T1.SUNAP_DT BETWEEN SUBSTR('20240331',1,4)||'0100' AND '20240331' )
                     OR ( '0' in (2,9) AND SUBSTR('20240331',5,2) <  3  AND T1.SUNAP_DT BETWEEN (SUBSTR('20240331',1,4) - 1 )||'0301' AND '20240331')
                     OR ( '0' in (2,9) AND SUBSTR('20240331',5,2) >= 3  AND T1.SUNAP_DT BETWEEN SUBSTR('20240331',1,4)||'0101' AND '20240331')
                     OR ( '0' = 8 AND SUBSTR('20240331',5,2) <  3  AND T1.SUNAP_DT BETWEEN (SUBSTR('20240331',1,4) - 1 )||'0101' AND '20240331')
                     OR ( '0' = 8 AND SUBSTR('20240331',5,2) >= 3  AND T1.SUNAP_DT BETWEEN SUBSTR('20240331',1,4)||'0101' AND '20240331'))
                AND  (  ( '22' =  22  AND T1.ICH_SIGUMGO_HOIKYE_C IN (22, 62, 209332) ) OR
                        ( 22 =  213000  AND T1.ICH_SIGUMGO_HOIKYE_C IN (213000, 217100) ) OR
                        ( 22 =  99 )  OR
                        ( 22 NOT IN (22,213000,99) AND T1.ICH_SIGUMGO_HOIKYE_C = 22 ) )
                AND  (  ( 22 = 22 AND 170 = 0 AND T1.ICH_SIGUMGO_GUN_GU_C  IN (7000, 7040, 7810, 7055, 7830, 7840, 7850, 7100, 0) )
                        OR ( 22 IN (21,22,93) AND 170 = 9999 )
                        OR ( 22 = 22 AND 170 NOT IN (0,9999) AND ( CASE WHEN T1.ICH_SIGUMGO_GUN_GU_C = 7100 THEN  0
                                WHEN T1.ICH_SIGUMGO_GUN_GU_C > 7100 AND T1.ICH_SIGUMGO_GUN_GU_C < 7800 THEN T1.ICH_SIGUMGO_GUN_GU_C - 7000 ELSE T1.ICH_SIGUMGO_GUN_GU_C END) = DECODE(170, 9999, T1.ICH_SIGUMGO_GUN_GU_C, 170) )
                        OR (22 IN ( 21,93) AND 170 = 7100 AND T1.ICH_SIGUMGO_GUN_GU_C  IN (0, 7000, 100, 7100) )
                        OR (22 IN ( 21,93) AND 170 <> 7100 AND T1.ICH_SIGUMGO_GUN_GU_C IN (170, SUBSTR(170,2,3)) )
                        OR (22 NOT IN (21,22,93) AND T1.ICH_SIGUMGO_GUN_GU_C  = DECODE(170, 9999, T1.ICH_SIGUMGO_GUN_GU_C, 170) ) )
                AND (  ( '0' = 0 AND SUBSTR('20240331',5,2) < 3  AND T1.SUNAP_DT >= SUBSTR('20240331',1,4)||'0101'   )
                    OR ( '0' = 0 AND SUBSTR('20240331',5,2) >= 3 AND
                         (  ( T1.SUNAP_DT >= SUBSTR('20240331',1,4)||'0101' AND T1.NEW_GU_YR_G= 1)
                         OR ( T1.SUNAP_DT >= SUBSTR('20240331',1,4)||'0301' AND T1.NEW_GU_YR_G <> 1)))
                    OR  ( '0' = 1 AND  T1.SUNAP_DT >= SUBSTR('20240331',1,4)||'0101' AND  (T1.NEW_GU_YR_G = 1 OR T1.SIGUMGO_HOIKYE_YR = 9999 ) )
                    OR  ( '0' in (2,9) AND  SUBSTR('20240331',5,2) < 3  AND T1.SUNAP_DT >= (SUBSTR('20240331',1,4) - 1 )||'0301' AND T1.NEW_GU_YR_G = 9 )
                    OR  ( '0' in (2,9) AND  SUBSTR('20240331',5,2) >= 3 AND  T1.SUNAP_DT >= (SUBSTR('20240331',1,4))||'0301' AND  T1.NEW_GU_YR_G = 9 )
                    OR  ( '0' = 5 AND  SUBSTR('20240331',5,2) < 3  AND T1.SUNAP_DT >= (SUBSTR('20240331',1,4) - 1 )||'0301' AND T1.NEW_GU_YR_G = 5 )
                    OR  ( '0' = 5 AND  SUBSTR('20240331',5,2) >= 3 AND  T1.SUNAP_DT >= (SUBSTR('20240331',1,4))||'0301' AND  T1.NEW_GU_YR_G = 5 )
                    OR  ( '0' = 8 AND  SUBSTR('20240331',5,2) < 3  AND (
                                         (T1.SUNAP_DT BETWEEN (SUBSTR('20240331',1,4) - 1 )||'0001' AND (SUBSTR('20240331',1,4) - 1 )||'1231' AND T1.NEW_GU_YR_G = 1 )
                                      OR (T1.SUNAP_DT >= (SUBSTR('20240331',1,4) - 1 )||'0301' AND T1.NEW_GU_YR_G <> 1)))
                    OR  ( '0' = 8 AND  SUBSTR('20240331',5,2) >= 3 AND  T1.SUNAP_DT >= (SUBSTR('20240331',1,4))||'0301' AND  T1.NEW_GU_YR_G <> 1 ))
            GROUP BY DECODE(T1.ICH_SIGUMGO_HOIKYE_C,'62','22',T1.ICH_SIGUMGO_HOIKYE_C),T1.SIGUMGO_ORG_C
  
            UNION ALL
                SELECT '22' AS HOIGYE_CD, 
                       '22' JIBGYE_CODE, 
                       28 SIGUMGO_ORG_C,

                        SUM(CASE  WHEN '1' = '1' AND SUNAPIL < (SUBSTR('20240331',1,6))||'00' THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN '1' = '2' AND SUBSTR('20240331',5,2) >= 10 AND SUNAPIL < (SUBSTR('20240331',1,4))||'1000'  THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN '1' = '2' AND SUBSTR('20240331',5,2) >= 7  AND SUBSTR('20240331',5,2) < 10 AND SUNAPIL < (SUBSTR('20240331',1,4))||'0700'  THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN '1' = '2' AND SUBSTR('20240331',5,2) >= 4  AND SUBSTR('20240331',5,2) < 7 AND  SUNAPIL < (SUBSTR('20240331',1,4))||'0400'   THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                        ELSE 0 END)  BEF_AMT,
                        SUM(CASE WHEN '1' = '1' AND SUNAPIL BETWEEN (SUBSTR('20240331',1,6))||'01' AND '20240331'  THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN '1' = '2' AND SUBSTR('20240331',5,2) >= 10 AND SUNAPIL BETWEEN (SUBSTR('20240331',1,4))||'1001' AND '20240331' THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN '1' = '2' AND SUBSTR('20240331',5,2) >= 7 AND SUBSTR('20240331',5,2) < 10 AND SUNAPIL BETWEEN (SUBSTR('20240331',1,4))||'0701' AND '20240331' THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN '1' = '2' AND SUBSTR('20240331',5,2) >= 4 AND SUBSTR('20240331',5,2) < 7 AND SUNAPIL BETWEEN (SUBSTR('20240331',1,4))||'0401' AND '20240331'  THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN '1' = '2' AND SUBSTR('20240331',5,2) <  4 AND SUNAPIL <= '20240331'  THEN NVL(NAPBU_SIDO_TAX_AMT,0) ELSE 0 END) CUR_SUIB,
                        0 CUR_BACK,
                        SUM(CASE WHEN '1' = '1' AND SUNAPIL BETWEEN (SUBSTR('20240331',1,6))||'01' AND '20240331' THEN  NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN '1' = '2' AND SUBSTR('20240331',5,2) >= 10 AND SUNAPIL BETWEEN (SUBSTR('20240331',1,4))||'1001' AND '20240331'  THEN  NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN '1' = '2' AND SUBSTR('20240331',5,2) >= 7  AND SUBSTR('20240331',5,2) < 10 AND  SUNAPIL BETWEEN (SUBSTR('20240331',1,4))||'0701' AND '20240331' THEN  NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN '1' = '2' AND SUBSTR('20240331',5,2) >= 4  AND SUBSTR('20240331',5,2) < 7 AND  SUNAPIL BETWEEN (SUBSTR('20240331',1,4))||'0401' AND '20240331' THEN  NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN '1' = '2' AND SUBSTR('20240331',5,2) <  4  AND SUNAPIL <= '20240331'  THEN  NVL(NAPBU_SIDO_TAX_AMT,0)
                        ELSE 0 END) CUR_AMT
                FROM
                (
                    SELECT SUNP_DT AS SUNAPIL,
                        CASE  WHEN NEW_GU_YR_G = 1 THEN 1 WHEN NEW_GU_YR_G = 2 THEN 9  ELSE  99 END YEAR_GUBUN,
                        HOIKYE_CD, SMOK_CD,
                        CASE WHEN CVT_GUCHUNG_CD = '357' THEN 710 WHEN CVT_GUCHUNG_CD = '358' THEN 720 ELSE TO_NUMBER(NVL(CVT_GUCHUNG_CD,0)) END AS GUNGU_CD,
                        NAPBU_TCNT, NAPBU_NTAX_AMT, NAPBU_SIDO_TAX_AMT, NAPBU_SIGNGU_TAX_AMT
                    FROM NIO_STAX_MASTR_TAB
                    WHERE SUNP_DT BETWEEN SUBSTR('20240331',1,4)||'0100' AND '20240331'  AND FORM_G <> '1' AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND SIDO_CD <> '628' AND (SUBSTR(SMOK_CD,1,3)  <> '299' OR   SUBSTR(SMOK_CD,4,3) <> '099')
                    AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358') AND HOIKYE_CD = '51' AND SMOK_CD = '281020'
                    UNION
                    SELECT A.SUNP_DT AS SUNAPIL,
                        CASE  WHEN NEW_GU_YR_G = 1 THEN 1 WHEN NEW_GU_YR_G = 2 THEN 9  ELSE  99 END YEAR_GUBUN,
                                        A.HOIKYE_CD HOIKYE_CD, A.SMOK_CD SMOK_CD,
                        CASE WHEN CVT_GUCHUNG_CD = '357' THEN 710 WHEN CVT_GUCHUNG_CD = '358' THEN 720 ELSE TO_NUMBER(NVL(CVT_GUCHUNG_CD,0))  END AS GUNGU_CD,
                        A.NAPBU_TCNT NAPBU_TCNT, A.NAPBU_NTAX_AMT NAPBU_NTAX_AMT, A.NAPBU_SIDO_TAX_AMT NAPBU_SIDO_TAX_AMT, A.NAPBU_SIGNGU_TAX_AMT NAPBU_SIGNGU_TAX_AMT
                    FROM NIO_STAX_MASTR_TAB A, NIO_DEPT_INF_TAB B
                            WHERE A.SUNP_DT BETWEEN SUBSTR('20240331',1,4)||'0100' AND '20240331'  AND FORM_G <> '1' AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND SIDO_CD = '628' AND (SUBSTR(A.SMOK_CD,1,3) <> '299' OR  SUBSTR(A.SMOK_CD,4,3) <> '099')
                            AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358') AND A.HOIKYE_CD = '51' AND A.SMOK_CD = '281020'
                            AND A.SIDO_CD = B.GUCHUNG_CD(+) AND A.DEPT_CD = B.DEPT_CD(+) AND A.HOIKYE_CD = B.HOIKYE_CD(+) AND A.SMOK_CD = B.SMOK_CD(+)
                            UNION
                            SELECT
                        SUNP_DT AS SUNAPIL,
                        CASE  WHEN NEW_GU_YR_G = 1 THEN 1    WHEN NEW_GU_YR_G = 2 THEN 9 ELSE  99 END YEAR_GUBUN,
                        HOIKYE_CD,
                        SMOK_CD,
                        CASE WHEN CVT_GUCHUNG_CD = '357' THEN 710 WHEN CVT_GUCHUNG_CD = '358' THEN 720 ELSE TO_NUMBER(NVL(CVT_GUCHUNG_CD,0)) END  AS GUNGU_CD,
                        NAPBU_TCNT,
                        NVL(SUM(GUKSAE), 0) AS NAPBU_NTAX_AMT, NVL(SUM(SIDOSAE),0) AS NAPBU_SIDO_TAX_AMT, NVL(SUM(SIGUNSAE),0) AS NAPBU_SIGNGU_TAX_AMT
                            FROM
                    (
                        SELECT
                                        BLK_NO, PROC_SEQ, SUNP_DT, NEW_GU_YR_G,
                                        HOIKYE_CD, SMOK_CD,
                                        CVT_GUCHUNG_CD,
                                        NAPBU_TCNT,
                                        CASE WHEN FILLER2 = '1' THEN NTAX_AMT + SIDO_TAX_AMT + SIGNGU_TAX_AMT - NAPGILT_AMT END AS GUKSAE,
                                        CASE WHEN FILLER2 = '2' THEN NTAX_AMT + SIDO_TAX_AMT + SIGNGU_TAX_AMT - NAPGILT_AMT END AS SIDOSAE,
                                        CASE WHEN FILLER2 = '3' THEN NTAX_AMT + SIDO_TAX_AMT + SIGNGU_TAX_AMT - NAPGILT_AMT END AS SIGUNSAE
                        FROM  NIO_STAX_MASTR_TAB
                        WHERE SUNP_DT BETWEEN SUBSTR('20240331',1,4)||'0100' AND '20240331'  AND FILLER2 > '0' AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND FORM_G <> '1'
                        AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358') AND HOIKYE_CD = '51' AND SMOK_CD = '281020'
                    )
                GROUP BY SUNP_DT, NEW_GU_YR_G, HOIKYE_CD, SMOK_CD,CVT_GUCHUNG_CD, NAPBU_TCNT
                    UNION
                    SELECT
                        SUNP_DT AS SUNAPIL,
                        CASE  WHEN NEW_GU_YR_G = 1 THEN 1  WHEN NEW_GU_YR_G = 2 THEN 9  ELSE  99 END YEAR_GUBUN,
                        HOIKYE_CD,
                        SMOK_CD,
                                        CASE WHEN CVT_GUCHUNG_CD = '357' THEN 710
                                            WHEN CVT_GUCHUNG_CD = '358' THEN 720
                                ELSE TO_NUMBER(NVL(CVT_GUCHUNG_CD,0)) END  AS GUNGU_CD,
                        NAPBU_TCNT,
                        NVL(SUM(NAPBU_NTAX_AMT), 0) AS NAPBU_NTAX_AMT, NVL(SUM(NAPBU_SIDO_TAX_AMT), 0) AS NAPBU_SIDO_TAX_AMT, 
                        NVL(SUM(NAPBU_SIGNGU_TAX_AMT), 0) AS NAPBU_SIGNGU_TAX_AMT
                    FROM
                    (
                        SELECT SUNP_DT, NEW_GU_YR_G,
                                                    HOIKYE_CD, SMOK_CD,
                                                    CVT_GUCHUNG_CD,
                                                    NAPBU_TCNT, NAPBU_NTAX_AMT, NAPBU_SIDO_TAX_AMT, NAPBU_SIGNGU_TAX_AMT
                        FROM NIO_STAX_MASTR_TAB
                        WHERE SUNP_DT BETWEEN SUBSTR('20240331',1,4)||'0100' AND '20240331'  AND SUBSTR(SMOK_CD,1,3) = '299' AND SUBSTR(SMOK_CD,4,3)  = '099'  AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND FORM_G <> '1'
                        AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358') AND HOIKYE_CD = '51' AND SMOK_CD = '281020'
                    )
                    GROUP BY SUNP_DT, NEW_GU_YR_G, HOIKYE_CD, SMOK_CD,CVT_GUCHUNG_CD,NAPBU_TCNT
                )
                WHERE 1 = 1
                AND  (GUNGU_CD = 170 OR 9999 = 170 )
                GROUP BY GUNGU_CD

            ) T1, 
            RPT_HOIKYE_CD T2
    WHERE 1=1
    AND T1.HOIGYE_CD = T2.SIGUMGO_HOIKYE_C(+)
    AND T1.SIGUMGO_ORG_C = T2.SIGUMGO_C(+)
    GROUP BY T1.HOIGYE_CD, T1.SIGUMGO_ORG_C, T2.FIL_100_CTNT1