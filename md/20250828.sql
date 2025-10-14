SELECT 
 A.GROUP_NM,
 A.GUNGU_NM,
 A.TYPE1_AMT,
 A.TYPE2_AMT,
 A.TYPE3_AMT,
 A.TYPE4_AMT,
 A.TYPE5_AMT,
 A.TYPE6_AMT,
    A.TYPE7_AMT,
 A.TYPE8_AMT
FROM (
WITH PARAM_DATA AS (
                SELECT 
                   '1' AS  BUNGI_GUBUN,
                   '20250731' AS TRNX_YMD,
                   '30' AS HOIKYE_CODE,
                   '1' AS SIGUTAX_G,
                   '185' AS GUNGU_CODE,
                   '1' AS FIS_YEAR_CD
                FROM DUAL
 ) ,
 CODE_INFO AS (
SELECT
 A.REF_D_C,
 A.REF_D_NM
FROM 
(
SELECT 
 REF_D_C,
 REF_D_NM
FROM RPT_CODE_INFO
WHERE REF_L_C = 500
AND REF_M_C =28
AND REF_S_C = 5
UNION ALL 
SELECT 
 REF_D_C,
 REF_D_NM
FROM RPT_CODE_INFO
WHERE REF_L_C = 500
AND REF_M_C =28
AND REF_S_C = 1
) A
GROUP BY A.REF_D_C, A.REF_D_NM
ORDER BY A.REF_D_C, A.REF_D_NM
),
RESULT_DATA AS (
SELECT
          T1.HOIGYE_CD AS HOIGYE_CODE,
          T1.HOIGYE_CD AS JIBGYE_CODE,
          T2.FIL_100_CTNT1 AS HOIGYE_NAME,
          T2.FIL_100_CTNT1 AS JIBGYE_NAME,
   T1.GUNGU_CD, 
    '('||T1.GUNGU_CD||') '|| T3.GUNGU_NM AS GUNGU_NM,
   SUM(CUR_JIBANGSE_AMT) AS CUR_JIBANGSE_AMT,
   SUM(CUR_JIBANGSE_GWAON_AMT) AS CUR_JIBANGSE_GWAON_AMT,
   SUM(CUR_JIBANGSE_CRT_AMT) AS CUR_JIBANGSE_CRT_AMT,
   SUM(CUR_SEWOI_AMT) AS CUR_SEWOI_AMT,
   SUM(CUR_SEWOI_GWAON_AMT) AS CUR_SEWOI_GWAON_AMT,
   SUM(CUR_SEWOI_CRT_AMT) AS CUR_SEWOI_CRT_AMT,
   SUM(CUR_GYOYUKSE_AMT) AS CUR_GYOYUKSE_AMT,
   SUM(CUR_GYOYUKSE_GWAON_AMT) AS CUR_GYOYUKSE_GWAON_AMT,
   SUM(CUR_GYOYUKSE_CRT_AMT) AS CUR_GYOYUKSE_CRT_AMT,
   SUM(CUR_NONGTEUKSE_AMT) AS CUR_NONGTEUKSE_AMT,
   SUM(CUR_NONGTEUKSE_GWAON_AMT) AS CUR_NONGTEUKSE_GWAON_AMT,
   SUM(CUR_NONGTEUKSE_CRT_AMT) AS CUR_NONGTEUKSE_CRT_AMT
FROM (
            SELECT
                 DECODE(T1.ICH_SIGUMGO_HOIKYE_C,'62','22',T1.ICH_SIGUMGO_HOIKYE_C) AS HOIGYE_CD    
                , '' AS JIBGYE_CODE           
                ,T1.SIGUMGO_ORG_C
  ,T1.ICH_SIGUMGO_GUN_GU_C AS GUNGU_CD
   , SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_AMT 
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_AMT 
                        ELSE 0
                    END
                ) AS CUR_JIBANGSE_AMT
   , SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_GWAON_AMT 
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_GWAON_AMT 
                        ELSE 0
                    END
                ) AS CUR_JIBANGSE_GWAON_AMT
   , SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_CRT_AMT 
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_CRT_AMT 
                        ELSE 0
                    END
                ) AS CUR_JIBANGSE_CRT_AMT
   , SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.SEWOI_AMT 
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.SEWOI_AMT 
                        ELSE 0
                    END
                ) AS CUR_SEWOI_AMT
   , SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.SEWOI_GWAON_AMT 
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.SEWOI_GWAON_AMT 
                        ELSE 0
                    END
                ) AS CUR_SEWOI_GWAON_AMT
   , SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.SEWOI_CRT_AMT 
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.SEWOI_CRT_AMT 
                        ELSE 0
                    END
                ) AS CUR_SEWOI_CRT_AMT
   , SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.GYOYUKSE_AMT 
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.GYOYUKSE_AMT 
                        ELSE 0
                    END
                ) AS CUR_GYOYUKSE_AMT
   , SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.GYOYUKSE_GWAON_AMT 
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.GYOYUKSE_GWAON_AMT 
                        ELSE 0
                    END
                ) AS CUR_GYOYUKSE_GWAON_AMT
   , SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.GYOYUKSE_CRT_AMT 
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.GYOYUKSE_CRT_AMT 
                        ELSE 0
                    END
                ) AS CUR_GYOYUKSE_CRT_AMT
   , SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.NONGTEUKSE_AMT 
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.NONGTEUKSE_AMT 
                        ELSE 0
                    END
                ) AS CUR_NONGTEUKSE_AMT
   , SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.NONGTEUKSE_GWAON_AMT 
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.NONGTEUKSE_GWAON_AMT 
                        ELSE 0
                    END
                ) AS CUR_NONGTEUKSE_GWAON_AMT
   , SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.NONGTEUKSE_CRT_AMT 
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.NONGTEUKSE_CRT_AMT 
                        ELSE 0
                    END
                ) AS CUR_NONGTEUKSE_CRT_AMT
            FROM
                RPT_TXI_DDAC_TAB T1,
                PARAM_DATA                
            WHERE 1=1                
                AND T1.SIGUMGO_ORG_C = 28
                AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'YYYY'), 'YYYYMMDD')
                AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                AND T1.ICH_SIGUMGO_HOIKYE_C IN (PARAM_DATA.HOIKYE_CODE, 62)
                AND T1.SIGUTAX_G = NVL(PARAM_DATA.SIGUTAX_G, '1')
                AND  (  ( PARAM_DATA.HOIKYE_CODE =  22  AND T1.ICH_SIGUMGO_HOIKYE_C IN (22, 62, 209332) ) OR
                        ( PARAM_DATA.HOIKYE_CODE =  213000  AND T1.ICH_SIGUMGO_HOIKYE_C IN (213000, 217100) ) OR
                        ( PARAM_DATA.HOIKYE_CODE =  99 )  OR
                        ( PARAM_DATA.HOIKYE_CODE NOT IN (22,213000,99) AND T1.ICH_SIGUMGO_HOIKYE_C = PARAM_DATA.HOIKYE_CODE ) )
                AND  (  ( PARAM_DATA.HOIKYE_CODE = 22 AND PARAM_DATA.GUNGU_CODE = 0 AND T1.ICH_SIGUMGO_GUN_GU_C  IN (7000, 7040, 7810, 7055, 7830, 7840, 7850, 7100, 0) )
                        OR ( PARAM_DATA.HOIKYE_CODE IN (21,22,93) AND PARAM_DATA.GUNGU_CODE = 9999 )
                        OR ( PARAM_DATA.HOIKYE_CODE = 22 AND PARAM_DATA.GUNGU_CODE NOT IN (0,9999) AND ( CASE WHEN T1.ICH_SIGUMGO_GUN_GU_C = 7100 THEN  0
                                WHEN T1.ICH_SIGUMGO_GUN_GU_C > 7100 AND T1.ICH_SIGUMGO_GUN_GU_C < 7800 THEN T1.ICH_SIGUMGO_GUN_GU_C - 7000 ELSE T1.ICH_SIGUMGO_GUN_GU_C END) = DECODE(PARAM_DATA.GUNGU_CODE, 9999, T1.ICH_SIGUMGO_GUN_GU_C, PARAM_DATA.GUNGU_CODE) )
                        OR (PARAM_DATA.HOIKYE_CODE IN ( 21,93) AND PARAM_DATA.GUNGU_CODE = 7100 AND T1.ICH_SIGUMGO_GUN_GU_C  IN (0, 7000, 100, 7100) )
                        OR (PARAM_DATA.HOIKYE_CODE IN ( 21,93) AND PARAM_DATA.GUNGU_CODE <> 7100 AND T1.ICH_SIGUMGO_GUN_GU_C IN (PARAM_DATA.GUNGU_CODE, SUBSTR(PARAM_DATA.GUNGU_CODE,2,3)) )
                        OR (PARAM_DATA.HOIKYE_CODE NOT IN (21,22,93) AND T1.ICH_SIGUMGO_GUN_GU_C  = DECODE(PARAM_DATA.GUNGU_CODE, 9999, T1.ICH_SIGUMGO_GUN_GU_C, PARAM_DATA.GUNGU_CODE) ) )                
                AND (
                  (  
                            PARAM_DATA.FIS_YEAR_CD = 1 
                        AND  
                            T1.SUNAP_DT >= SUBSTR(PARAM_DATA.TRNX_YMD,1,4)||'0101' 
                        AND  
                            T1.NEW_GU_YR_G = 1 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 9 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                        AND 
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0301' AND T1.NEW_GU_YR_G = 9 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 9 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 3 
                        AND  
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4))||'0301' AND  T1.NEW_GU_YR_G = 9 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 5 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                        AND 
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0301' AND T1.NEW_GU_YR_G = 5 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 5 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 3 
                        AND  
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4))||'0301' AND  T1.NEW_GU_YR_G = 5 
                    )    
                OR (  
                            ( 
                                    PARAM_DATA.FIS_YEAR_CD = 8  
                                AND 
                                    SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                                AND 
                                    T1.SUNAP_DT BETWEEN  (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0100' AND (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0100'
                                AND 
                                    T1.NEW_GU_YR_G = 1    
                            )
                        OR 
                            ( 
                                    PARAM_DATA.FIS_YEAR_CD = 8  
                                AND 
                                    SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                                AND 
                                    T1.SUNAP_DT BETWEEN (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0301' AND PARAM_DATA.TRNX_YMD
                                AND 
                                    T1.NEW_GU_YR_G <> 1 
                            )
                        OR 
                            (
                                    PARAM_DATA.FIS_YEAR_CD = 8 
                                AND 
                                    SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 3  
                                AND 
                                    T1.SUNAP_DT BETWEEN SUBSTR(PARAM_DATA.TRNX_YMD,1,4)||'0301' AND PARAM_DATA.TRNX_YMD
                                AND 
                                    T1.NEW_GU_YR_G <> 1 
                            )
                     )
                OR ( 
                    
                        PARAM_DATA.FIS_YEAR_CD = 0  
                    AND 
                        T1.SUNAP_DT >= SUBSTR(PARAM_DATA.TRNX_YMD,1,4)  
                    
                    )
                )        
            GROUP BY DECODE(T1.ICH_SIGUMGO_HOIKYE_C,'62','22',T1.ICH_SIGUMGO_HOIKYE_C),T1.SIGUMGO_ORG_C,T1.ICH_SIGUMGO_GUN_GU_C
            UNION ALL
                SELECT '22' AS HOIGYE_CD 
                       ,'22' JIBGYE_CODE 
                       ,28 SIGUMGO_ORG_C
   ,GUNGU_CD
   , 0 AS CUR_JIBANGSE_AMT
   , 0 AS CUR_JIBANGSE_GWAON_AMT
   , 0 AS CUR_JIBANGSE_CRT_AMT
   , SUM(CASE WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND SUNAPIL BETWEEN (SUBSTR(PARAM_DATA.TRNX_YMD,1,6))||'01' AND PARAM_DATA.TRNX_YMD  THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 10 AND SUNAPIL BETWEEN (SUBSTR(PARAM_DATA.TRNX_YMD,1,4))||'1001' AND PARAM_DATA.TRNX_YMD THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 7 AND SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 10 AND SUNAPIL BETWEEN (SUBSTR(PARAM_DATA.TRNX_YMD,1,4))||'0701' AND PARAM_DATA.TRNX_YMD THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 4 AND SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 7 AND SUNAPIL BETWEEN (SUBSTR(PARAM_DATA.TRNX_YMD,1,4))||'0401' AND PARAM_DATA.TRNX_YMD  THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND SUBSTR(PARAM_DATA.TRNX_YMD,5,2) <  4 AND SUNAPIL <= PARAM_DATA.TRNX_YMD  THEN NVL(NAPBU_SIDO_TAX_AMT,0) ELSE 0 END) AS CUR_SEWOI_AMT
   , 0 AS CUR_SEWOI_GWAON_AMT
   , 0 AS CUR_SEWOI_CRT_AMT
   , 0 AS CUR_GYOYUKSE_AMT
   , 0 AS CUR_GYOYUKSE_GWAON_AMT
   , 0 AS CUR_GYOYUKSE_CRT_AMT
   , 0 AS CUR_NONGTEUKSE_AMT
   , 0 AS CUR_NONGTEUKSE_GWAON_AMT
   , 0 AS CUR_NONGTEUKSE_CRT_AMT
                FROM
                (
                    -- 2025.06.04. 하수도원인자부담금은 부가세가 없어 부가세 로직 제거 및 신세목코드추가
                    -- 추후 RPT_SUNAP_JIBGYE 수납 데이터 생성후 NIO_STAX_MASTR_TAB 제거
 SELECT SUNP_DT AS SUNAPIL,
                        CASE  WHEN NEW_GU_YR_G = 1 THEN 1 WHEN NEW_GU_YR_G = 2 THEN 9  ELSE  99 END YEAR_GUBUN,
                        HOIKYE_CD, SMOK_CD,
                        CASE WHEN CVT_GUCHUNG_CD = '357' THEN 710 WHEN CVT_GUCHUNG_CD = '358' THEN 720 ELSE TO_NUMBER(NVL(CVT_GUCHUNG_CD,0)) END AS GUNGU_CD,
                        NAPBU_TCNT, NAPBU_NTAX_AMT, NAPBU_SIDO_TAX_AMT, NAPBU_SIGNGU_TAX_AMT
                    FROM NIO_STAX_MASTR_TAB,
                PARAM_DATA
                    WHERE SUNP_DT BETWEEN SUBSTR(PARAM_DATA.TRNX_YMD,1,4)||'0100' AND PARAM_DATA.TRNX_YMD  AND FORM_G <> '1' AND INSIK_G <> 'D' AND INSIK_G <> 'R' 
                    AND BLK_NO = '990'  AND CVT_GUCHUNG_CD IN ('357','358') AND HOIKYE_CD = '51' AND ((SMOK_CD = '281020') OR (NEW_SMOK_CD = '236009' AND NEW_SMOK_OP_CD = '000'))  
                ),
                PARAM_DATA
                WHERE 1 = 1
                AND  (GUNGU_CD = PARAM_DATA.GUNGU_CODE OR 9999 = PARAM_DATA.GUNGU_CODE )
                AND 1 = (CASE WHEN PARAM_DATA.HOIKYE_CODE = '22' THEN 1 ELSE 0 END)
                GROUP BY GUNGU_CD
            ) T1, 
            RPT_HOIKYE_CD T2,
     (
  SELECT 
  REF_D_C AS GUNGU_CD, 
  REF_D_NM AS GUNGU_NM
  FROM CODE_INFO                                                        
     ) T3 
    WHERE 1=1
    AND T1.HOIGYE_CD = T2.SIGUMGO_HOIKYE_C(+)
    AND T1.SIGUMGO_ORG_C = T2.SIGUMGO_C(+) 
    AND T1.GUNGU_CD = T3.GUNGU_CD(+)
    GROUP BY T1.HOIGYE_CD, T1.SIGUMGO_ORG_C, T2.FIL_100_CTNT1, T1.GUNGU_CD, T3.GUNGU_NM
 )
 SELECT 
  HOIGYE_CODE,
         JIBGYE_CODE,
         HOIGYE_NAME,
         JIBGYE_NAME,
  GUNGU_CD, 
  GUNGU_NM,
  '1' AS GROUP_NM,
  CUR_JIBANGSE_AMT AS TYPE1_AMT,
  CUR_JIBANGSE_GWAON_AMT AS TYPE2_AMT,
  CUR_JIBANGSE_CRT_AMT AS TYPE3_AMT,
     (CUR_JIBANGSE_AMT + CUR_JIBANGSE_CRT_AMT - CUR_JIBANGSE_GWAON_AMT) AS TYPE4_AMT,
  CUR_SEWOI_AMT AS TYPE5_AMT,
  CUR_SEWOI_GWAON_AMT AS TYPE6_AMT,
  CUR_SEWOI_CRT_AMT AS TYPE7_AMT,
     (CUR_SEWOI_AMT + CUR_SEWOI_CRT_AMT - CUR_SEWOI_GWAON_AMT) AS TYPE8_AMT
 FROM RESULT_DATA
 UNION ALL
  SELECT 
  HOIGYE_CODE,
         JIBGYE_CODE,
         HOIGYE_NAME,
         JIBGYE_NAME,
  GUNGU_CD, 
  GUNGU_NM,
  '2' AS GROUP_NM ,
  CUR_GYOYUKSE_AMT AS TYPE1_AMT,
  CUR_GYOYUKSE_GWAON_AMT AS TYPE2_AMT,
  CUR_GYOYUKSE_CRT_AMT AS TYPE3_AMT,
     (CUR_GYOYUKSE_AMT + CUR_GYOYUKSE_CRT_AMT - CUR_GYOYUKSE_GWAON_AMT) AS TYPE4_AMT,
  CUR_NONGTEUKSE_AMT AS TYPE5_AMT,
  CUR_NONGTEUKSE_GWAON_AMT AS TYPE6_AMT,
  CUR_NONGTEUKSE_CRT_AMT AS TYPE7_AMT,
     (CUR_NONGTEUKSE_AMT + CUR_NONGTEUKSE_CRT_AMT - CUR_NONGTEUKSE_GWAON_AMT) AS TYPE8_AMT
 FROM RESULT_DATA
) A
WHERE 1=1 
ORDER BY A.GROUP_NM, A.GUNGU_CD



=========================== XDA ID:[tom.ich.rpt.xda.xSelectListICH030201By01]===============================
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
            WITH PARAM_DATA AS (
                SELECT 
                   '1' AS  BUNGI_GUBUN,
                   '20250731' AS TRNX_YMD,
                   '30' AS HOIKYE_CODE,
                   '1' AS SIGUTAX_G,
                   '185' AS GUNGU_CODE,
                   '1' AS FIS_YEAR_CD
                FROM DUAL
            )
            SELECT
                 DECODE(T1.ICH_SIGUMGO_HOIKYE_C,'62','22',T1.ICH_SIGUMGO_HOIKYE_C) AS HOIGYE_CD    
                , '' AS JIBGYE_CODE           
                ,T1.SIGUMGO_ORG_C
          ,SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT < TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD')
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT < TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD')
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        ELSE 0
                    END
                ) AS BEF_AMT
                ,SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT
                        ELSE 0
                    END
                ) AS CUR_SUIB
                ,SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_GWAON_AMT + T1.SEWOI_GWAON_AMT
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_GWAON_AMT + T1.SEWOI_GWAON_AMT
                        ELSE 0
                    END
                ) AS CUR_BACK
                ,SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        ELSE 0
                    END
                ) AS CUR_AMT
            FROM
                RPT_TXI_DDAC_TAB T1,
                PARAM_DATA                
            WHERE 1=1                
                AND T1.SIGUMGO_ORG_C = 28
                AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'YYYY'), 'YYYYMMDD')
                AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                AND T1.ICH_SIGUMGO_HOIKYE_C IN (PARAM_DATA.HOIKYE_CODE, 62)
                AND T1.SIGUTAX_G = NVL(PARAM_DATA.SIGUTAX_G, '1')
                AND  (  ( PARAM_DATA.HOIKYE_CODE =  22  AND T1.ICH_SIGUMGO_HOIKYE_C IN (22, 62, 209332) ) OR
                        ( PARAM_DATA.HOIKYE_CODE =  213000  AND T1.ICH_SIGUMGO_HOIKYE_C IN (213000, 217100) ) OR
                        ( PARAM_DATA.HOIKYE_CODE =  99 )  OR
                        ( PARAM_DATA.HOIKYE_CODE NOT IN (22,213000,99) AND T1.ICH_SIGUMGO_HOIKYE_C = PARAM_DATA.HOIKYE_CODE ) )
                AND  (  ( PARAM_DATA.HOIKYE_CODE = 22 AND PARAM_DATA.GUNGU_CODE = 0 AND T1.ICH_SIGUMGO_GUN_GU_C  IN (7000, 7040, 7810, 7055, 7830, 7840, 7850, 7100, 0) )
                        OR ( PARAM_DATA.HOIKYE_CODE IN (21,22,93) AND PARAM_DATA.GUNGU_CODE = 9999 )
                        OR ( PARAM_DATA.HOIKYE_CODE = 22 AND PARAM_DATA.GUNGU_CODE NOT IN (0,9999) AND ( CASE WHEN T1.ICH_SIGUMGO_GUN_GU_C = 7100 THEN  0
                                WHEN T1.ICH_SIGUMGO_GUN_GU_C > 7100 AND T1.ICH_SIGUMGO_GUN_GU_C < 7800 THEN T1.ICH_SIGUMGO_GUN_GU_C - 7000 ELSE T1.ICH_SIGUMGO_GUN_GU_C END) = DECODE(PARAM_DATA.GUNGU_CODE, 9999, T1.ICH_SIGUMGO_GUN_GU_C, PARAM_DATA.GUNGU_CODE) )
                        OR (PARAM_DATA.HOIKYE_CODE IN ( 21,93) AND PARAM_DATA.GUNGU_CODE = 7100 AND T1.ICH_SIGUMGO_GUN_GU_C  IN (0, 7000, 100, 7100) )
                        OR (PARAM_DATA.HOIKYE_CODE IN ( 21,93) AND PARAM_DATA.GUNGU_CODE <> 7100 AND T1.ICH_SIGUMGO_GUN_GU_C IN (PARAM_DATA.GUNGU_CODE, SUBSTR(PARAM_DATA.GUNGU_CODE,2,3)) )
                        OR (PARAM_DATA.HOIKYE_CODE NOT IN (21,22,93) AND T1.ICH_SIGUMGO_GUN_GU_C  = DECODE(PARAM_DATA.GUNGU_CODE, 9999, T1.ICH_SIGUMGO_GUN_GU_C, PARAM_DATA.GUNGU_CODE) ) )                
                AND (
                  (  
                            PARAM_DATA.FIS_YEAR_CD = 1 
                        AND  
                            T1.SUNAP_DT >= SUBSTR(PARAM_DATA.TRNX_YMD,1,4)||'0101' 
                        AND  
                            T1.NEW_GU_YR_G = 1 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 9 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                        AND 
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0301' AND T1.NEW_GU_YR_G = 9 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 9 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 3 
                        AND  
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4))||'0301' AND  T1.NEW_GU_YR_G = 9 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 5 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                        AND 
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0301' AND T1.NEW_GU_YR_G = 5 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 5 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 3 
                        AND  
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4))||'0301' AND  T1.NEW_GU_YR_G = 5 
                    )    
                OR (  
                            ( 
                                    PARAM_DATA.FIS_YEAR_CD = 8  
                                AND 
                                    SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                                AND 
                                    T1.SUNAP_DT BETWEEN  (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0100' AND (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0100'
                                AND 
                                    T1.NEW_GU_YR_G = 1    
                            )
                        OR 
                            ( 
                                    PARAM_DATA.FIS_YEAR_CD = 8  
                                AND 
                                    SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                                AND 
                                    T1.SUNAP_DT BETWEEN (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0301' AND PARAM_DATA.TRNX_YMD
                                AND 
                                    T1.NEW_GU_YR_G <> 1 
                            )
                        OR 
                            (
                                    PARAM_DATA.FIS_YEAR_CD = 8 
                                AND 
                                    SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 3  
                                AND 
                                    T1.SUNAP_DT BETWEEN SUBSTR(PARAM_DATA.TRNX_YMD,1,4)||'0301' AND PARAM_DATA.TRNX_YMD
                                AND 
                                    T1.NEW_GU_YR_G <> 1 
                            )
                     )
                OR ( 
                    
                        PARAM_DATA.FIS_YEAR_CD = 0  
                    AND 
                        T1.SUNAP_DT >= SUBSTR(PARAM_DATA.TRNX_YMD,1,4)  
                    
                    )
                )        
            GROUP BY DECODE(T1.ICH_SIGUMGO_HOIKYE_C,'62','22',T1.ICH_SIGUMGO_HOIKYE_C),T1.SIGUMGO_ORG_C
            UNION ALL
                SELECT '22' AS HOIGYE_CD, 
                       '22' JIBGYE_CODE, 
                       28 SIGUMGO_ORG_C,
                        SUM(CASE  WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND SUNAPIL < (SUBSTR(PARAM_DATA.TRNX_YMD,1,6))||'00' THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 10 AND SUNAPIL < (SUBSTR(PARAM_DATA.TRNX_YMD,1,4))||'1000'  THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 7  AND SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 10 AND SUNAPIL < (SUBSTR(PARAM_DATA.TRNX_YMD,1,4))||'0700'  THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 4  AND SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 7 AND  SUNAPIL < (SUBSTR(PARAM_DATA.TRNX_YMD,1,4))||'0400'   THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                        ELSE 0 END)  BEF_AMT,
                        SUM(CASE WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND SUNAPIL BETWEEN (SUBSTR(PARAM_DATA.TRNX_YMD,1,6))||'01' AND PARAM_DATA.TRNX_YMD  THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 10 AND SUNAPIL BETWEEN (SUBSTR(PARAM_DATA.TRNX_YMD,1,4))||'1001' AND PARAM_DATA.TRNX_YMD THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 7 AND SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 10 AND SUNAPIL BETWEEN (SUBSTR(PARAM_DATA.TRNX_YMD,1,4))||'0701' AND PARAM_DATA.TRNX_YMD THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 4 AND SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 7 AND SUNAPIL BETWEEN (SUBSTR(PARAM_DATA.TRNX_YMD,1,4))||'0401' AND PARAM_DATA.TRNX_YMD  THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND SUBSTR(PARAM_DATA.TRNX_YMD,5,2) <  4 AND SUNAPIL <= PARAM_DATA.TRNX_YMD  THEN NVL(NAPBU_SIDO_TAX_AMT,0) ELSE 0 END) CUR_SUIB,
                        0 CUR_BACK,
                        SUM(CASE WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND SUNAPIL BETWEEN (SUBSTR(PARAM_DATA.TRNX_YMD,1,6))||'01' AND PARAM_DATA.TRNX_YMD THEN  NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 10 AND SUNAPIL BETWEEN (SUBSTR(PARAM_DATA.TRNX_YMD,1,4))||'1001' AND PARAM_DATA.TRNX_YMD  THEN  NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 7  AND SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 10 AND  SUNAPIL BETWEEN (SUBSTR(PARAM_DATA.TRNX_YMD,1,4))||'0701' AND PARAM_DATA.TRNX_YMD THEN  NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 4  AND SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 7 AND  SUNAPIL BETWEEN (SUBSTR(PARAM_DATA.TRNX_YMD,1,4))||'0401' AND PARAM_DATA.TRNX_YMD THEN  NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND SUBSTR(PARAM_DATA.TRNX_YMD,5,2) <  4  AND SUNAPIL <= PARAM_DATA.TRNX_YMD  THEN  NVL(NAPBU_SIDO_TAX_AMT,0)
                        ELSE 0 END) CUR_AMT
                FROM
                (
                    SELECT SUNP_DT AS SUNAPIL,
                        CASE  WHEN NEW_GU_YR_G = 1 THEN 1 WHEN NEW_GU_YR_G = 2 THEN 9  ELSE  99 END YEAR_GUBUN,
                        HOIKYE_CD, SMOK_CD,
                        CASE WHEN CVT_GUCHUNG_CD = '357' THEN 710 WHEN CVT_GUCHUNG_CD = '358' THEN 720 ELSE TO_NUMBER(NVL(CVT_GUCHUNG_CD,0)) END AS GUNGU_CD,
                        NAPBU_TCNT, NAPBU_NTAX_AMT, NAPBU_SIDO_TAX_AMT, NAPBU_SIGNGU_TAX_AMT
                    FROM NIO_STAX_MASTR_TAB,
                    PARAM_DATA
                    WHERE SUNP_DT BETWEEN SUBSTR(PARAM_DATA.TRNX_YMD,1,4)||'0100' AND PARAM_DATA.TRNX_YMD  AND FORM_G <> '1' AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND SIDO_CD <> '628' AND (SUBSTR(SMOK_CD,1,3)  <> '299' OR   SUBSTR(SMOK_CD,4,3) <> '099')
                    AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358') AND HOIKYE_CD = '51' AND SMOK_CD = '281020'
                    UNION ALL
                    SELECT A.SUNP_DT AS SUNAPIL,
                        CASE  WHEN NEW_GU_YR_G = 1 THEN 1 WHEN NEW_GU_YR_G = 2 THEN 9  ELSE  99 END YEAR_GUBUN,
                                        A.HOIKYE_CD HOIKYE_CD, A.SMOK_CD SMOK_CD,
                        CASE WHEN CVT_GUCHUNG_CD = '357' THEN 710 WHEN CVT_GUCHUNG_CD = '358' THEN 720 ELSE TO_NUMBER(NVL(CVT_GUCHUNG_CD,0))  END AS GUNGU_CD,
                        A.NAPBU_TCNT NAPBU_TCNT, A.NAPBU_NTAX_AMT NAPBU_NTAX_AMT, A.NAPBU_SIDO_TAX_AMT NAPBU_SIDO_TAX_AMT, A.NAPBU_SIGNGU_TAX_AMT NAPBU_SIGNGU_TAX_AMT
                    FROM NIO_STAX_MASTR_TAB A, NIO_DEPT_INF_TAB B,
                    PARAM_DATA
                            WHERE A.SUNP_DT BETWEEN SUBSTR(PARAM_DATA.TRNX_YMD,1,4)||'0100' AND PARAM_DATA.TRNX_YMD  AND FORM_G <> '1' AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND SIDO_CD = '628' AND (SUBSTR(A.SMOK_CD,1,3) <> '299' OR  SUBSTR(A.SMOK_CD,4,3) <> '099')
                            AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358') AND A.HOIKYE_CD = '51' AND A.SMOK_CD = '281020'
                            AND A.SIDO_CD = B.GUCHUNG_CD(+) AND A.DEPT_CD = B.DEPT_CD(+) AND A.HOIKYE_CD = B.HOIKYE_CD(+) AND A.SMOK_CD = B.SMOK_CD(+)
                            UNION ALL
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
                        FROM  NIO_STAX_MASTR_TAB,
                        PARAM_DATA
                        WHERE SUNP_DT BETWEEN SUBSTR(PARAM_DATA.TRNX_YMD,1,4)||'0100' AND PARAM_DATA.TRNX_YMD  AND FILLER2 > '0' AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND FORM_G <> '1'
                        AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358') AND HOIKYE_CD = '51' AND SMOK_CD = '281020'
                    ),
                    PARAM_DATA
                GROUP BY SUNP_DT, NEW_GU_YR_G, HOIKYE_CD, SMOK_CD,CVT_GUCHUNG_CD, NAPBU_TCNT
                    UNION ALL
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
                        FROM NIO_STAX_MASTR_TAB,
                        PARAM_DATA
                        WHERE SUNP_DT BETWEEN SUBSTR(PARAM_DATA.TRNX_YMD,1,4)||'0100' AND PARAM_DATA.TRNX_YMD  AND SUBSTR(SMOK_CD,1,3) = '299' AND SUBSTR(SMOK_CD,4,3)  = '099'  AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND FORM_G <> '1'
                        AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358') AND HOIKYE_CD = '51' AND SMOK_CD = '281020'
                    )
                    GROUP BY SUNP_DT, NEW_GU_YR_G, HOIKYE_CD, SMOK_CD,CVT_GUCHUNG_CD,NAPBU_TCNT
                ),
                PARAM_DATA
                WHERE 1 = 1
                AND  (GUNGU_CD = PARAM_DATA.GUNGU_CODE OR 9999 = PARAM_DATA.GUNGU_CODE )
                AND 1 = (CASE WHEN PARAM_DATA.HOIKYE_CODE = '22' THEN 1 ELSE 0 END)
                GROUP BY GUNGU_CD
            ) T1, 
            RPT_HOIKYE_CD T2
    WHERE 1=1
    AND T1.HOIGYE_CD = T2.SIGUMGO_HOIKYE_C(+)
    AND T1.SIGUMGO_ORG_C = T2.SIGUMGO_C(+)
    GROUP BY T1.HOIGYE_CD, T1.SIGUMGO_ORG_C, T2.FIL_100_CTNT1
============================================================================================


WITH PARAM_DATA AS (
                SELECT 
                   '1' AS  BUNGI_GUBUN,
                   '20250731' AS TRNX_YMD,
                   '30' AS HOIKYE_CODE,
                   '1' AS SIGUTAX_G,
                   '185' AS GUNGU_CODE,
                   '1' AS FIS_YEAR_CD
                FROM DUAL
            )
            SELECT
                 DECODE(T1.ICH_SIGUMGO_HOIKYE_C,'62','22',T1.ICH_SIGUMGO_HOIKYE_C) AS HOIGYE_CD    
                , '' AS JIBGYE_CODE           
                ,T1.SIGUMGO_ORG_C
          ,SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT < TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD')
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT < TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD')
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        ELSE 0
                    END
                ) AS BEF_AMT
                ,SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT
                        ELSE 0
                    END
                ) AS CUR_SUIB
                ,SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_GWAON_AMT + T1.SEWOI_GWAON_AMT
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_GWAON_AMT + T1.SEWOI_GWAON_AMT
                        ELSE 0
                    END
                ) AS CUR_BACK
                ,SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        ELSE 0
                    END
                ) AS CUR_AMT
            FROM
                RPT_TXI_DDAC_TAB T1,
                PARAM_DATA                
            WHERE 1=1                
                AND T1.SIGUMGO_ORG_C = 28
                AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'YYYY'), 'YYYYMMDD')
                AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                AND T1.ICH_SIGUMGO_HOIKYE_C IN (PARAM_DATA.HOIKYE_CODE, 62)
                AND T1.SIGUTAX_G = NVL(PARAM_DATA.SIGUTAX_G, '1')
                AND  (  ( PARAM_DATA.HOIKYE_CODE =  22  AND T1.ICH_SIGUMGO_HOIKYE_C IN (22, 62, 209332) ) OR
                        ( PARAM_DATA.HOIKYE_CODE =  213000  AND T1.ICH_SIGUMGO_HOIKYE_C IN (213000, 217100) ) OR
                        ( PARAM_DATA.HOIKYE_CODE =  99 )  OR
                        ( PARAM_DATA.HOIKYE_CODE NOT IN (22,213000,99) AND T1.ICH_SIGUMGO_HOIKYE_C = PARAM_DATA.HOIKYE_CODE ) )
                AND  (  ( PARAM_DATA.HOIKYE_CODE = 22 AND PARAM_DATA.GUNGU_CODE = 0 AND T1.ICH_SIGUMGO_GUN_GU_C  IN (7000, 7040, 7810, 7055, 7830, 7840, 7850, 7100, 0) )
                        OR ( PARAM_DATA.HOIKYE_CODE IN (21,22,93) AND PARAM_DATA.GUNGU_CODE = 9999 )
                        OR ( PARAM_DATA.HOIKYE_CODE = 22 AND PARAM_DATA.GUNGU_CODE NOT IN (0,9999) AND ( CASE WHEN T1.ICH_SIGUMGO_GUN_GU_C = 7100 THEN  0
                                WHEN T1.ICH_SIGUMGO_GUN_GU_C > 7100 AND T1.ICH_SIGUMGO_GUN_GU_C < 7800 THEN T1.ICH_SIGUMGO_GUN_GU_C - 7000 ELSE T1.ICH_SIGUMGO_GUN_GU_C END) = DECODE(PARAM_DATA.GUNGU_CODE, 9999, T1.ICH_SIGUMGO_GUN_GU_C, PARAM_DATA.GUNGU_CODE) )
                        OR (PARAM_DATA.HOIKYE_CODE IN ( 21,93) AND PARAM_DATA.GUNGU_CODE = 7100 AND T1.ICH_SIGUMGO_GUN_GU_C  IN (0, 7000, 100, 7100) )
                        OR (PARAM_DATA.HOIKYE_CODE IN ( 21,93) AND PARAM_DATA.GUNGU_CODE <> 7100 AND T1.ICH_SIGUMGO_GUN_GU_C IN (PARAM_DATA.GUNGU_CODE, SUBSTR(PARAM_DATA.GUNGU_CODE,2,3)) )
                        OR (PARAM_DATA.HOIKYE_CODE NOT IN (21,22,93) AND T1.ICH_SIGUMGO_GUN_GU_C  = DECODE(PARAM_DATA.GUNGU_CODE, 9999, T1.ICH_SIGUMGO_GUN_GU_C, PARAM_DATA.GUNGU_CODE) ) )                
                AND (
                  (  
                            PARAM_DATA.FIS_YEAR_CD = 1 
                        AND  
                            T1.SUNAP_DT >= SUBSTR(PARAM_DATA.TRNX_YMD,1,4)||'0101' 
                        AND  
                            T1.NEW_GU_YR_G = 1 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 9 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                        AND 
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0301' AND T1.NEW_GU_YR_G = 9 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 9 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 3 
                        AND  
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4))||'0301' AND  T1.NEW_GU_YR_G = 9 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 5 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                        AND 
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0301' AND T1.NEW_GU_YR_G = 5 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 5 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 3 
                        AND  
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4))||'0301' AND  T1.NEW_GU_YR_G = 5 
                    )    
                OR (  
                            ( 
                                    PARAM_DATA.FIS_YEAR_CD = 8  
                                AND 
                                    SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                                AND 
                                    T1.SUNAP_DT BETWEEN  (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0100' AND (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0100'
                                AND 
                                    T1.NEW_GU_YR_G = 1    
                            )
                        OR 
                            ( 
                                    PARAM_DATA.FIS_YEAR_CD = 8  
                                AND 
                                    SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                                AND 
                                    T1.SUNAP_DT BETWEEN (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0301' AND PARAM_DATA.TRNX_YMD
                                AND 
                                    T1.NEW_GU_YR_G <> 1 
                            )
                        OR 
                            (
                                    PARAM_DATA.FIS_YEAR_CD = 8 
                                AND 
                                    SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 3  
                                AND 
                                    T1.SUNAP_DT BETWEEN SUBSTR(PARAM_DATA.TRNX_YMD,1,4)||'0301' AND PARAM_DATA.TRNX_YMD
                                AND 
                                    T1.NEW_GU_YR_G <> 1 
                            )
                     )
                OR ( 
                    
                        PARAM_DATA.FIS_YEAR_CD = 0  
                    AND 
                        T1.SUNAP_DT >= SUBSTR(PARAM_DATA.TRNX_YMD,1,4)  
                    
                    )
                )        
            GROUP BY DECODE(T1.ICH_SIGUMGO_HOIKYE_C,'62','22',T1.ICH_SIGUMGO_HOIKYE_C),T1.SIGUMGO_ORG_C

-----------------------------------------------------


WITH PARAM_DATA AS (
                SELECT 
                   '1' AS  BUNGI_GUBUN,
                   '20250731' AS TRNX_YMD,
                   '30' AS HOIKYE_CODE,
                   '1' AS SIGUTAX_G,
                   '185' AS GUNGU_CODE,
                   '1' AS FIS_YEAR_CD
                FROM DUAL
            )
            SELECT
                T1.* 
            FROM
                RPT_TXI_DDAC_TAB T1,
                PARAM_DATA                
            WHERE 1=1                
                AND T1.SIGUMGO_ORG_C = 28
                AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'YYYY'), 'YYYYMMDD')
                AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                AND T1.ICH_SIGUMGO_HOIKYE_C IN (PARAM_DATA.HOIKYE_CODE, 62)
                AND T1.SIGUTAX_G = NVL(PARAM_DATA.SIGUTAX_G, '1')
                AND  (  ( PARAM_DATA.HOIKYE_CODE =  22  AND T1.ICH_SIGUMGO_HOIKYE_C IN (22, 62, 209332) ) OR
                        ( PARAM_DATA.HOIKYE_CODE =  213000  AND T1.ICH_SIGUMGO_HOIKYE_C IN (213000, 217100) ) OR
                        ( PARAM_DATA.HOIKYE_CODE =  99 )  OR
                        ( PARAM_DATA.HOIKYE_CODE NOT IN (22,213000,99) AND T1.ICH_SIGUMGO_HOIKYE_C = PARAM_DATA.HOIKYE_CODE ) )
                AND  (  ( PARAM_DATA.HOIKYE_CODE = 22 AND PARAM_DATA.GUNGU_CODE = 0 AND T1.ICH_SIGUMGO_GUN_GU_C  IN (7000, 7040, 7810, 7055, 7830, 7840, 7850, 7100, 0) )
                        OR ( PARAM_DATA.HOIKYE_CODE IN (21,22,93) AND PARAM_DATA.GUNGU_CODE = 9999 )
                        OR ( PARAM_DATA.HOIKYE_CODE = 22 AND PARAM_DATA.GUNGU_CODE NOT IN (0,9999) AND ( CASE WHEN T1.ICH_SIGUMGO_GUN_GU_C = 7100 THEN  0
                                WHEN T1.ICH_SIGUMGO_GUN_GU_C > 7100 AND T1.ICH_SIGUMGO_GUN_GU_C < 7800 THEN T1.ICH_SIGUMGO_GUN_GU_C - 7000 ELSE T1.ICH_SIGUMGO_GUN_GU_C END) = DECODE(PARAM_DATA.GUNGU_CODE, 9999, T1.ICH_SIGUMGO_GUN_GU_C, PARAM_DATA.GUNGU_CODE) )
                        OR (PARAM_DATA.HOIKYE_CODE IN ( 21,93) AND PARAM_DATA.GUNGU_CODE = 7100 AND T1.ICH_SIGUMGO_GUN_GU_C  IN (0, 7000, 100, 7100) )
                        OR (PARAM_DATA.HOIKYE_CODE IN ( 21,93) AND PARAM_DATA.GUNGU_CODE <> 7100 AND T1.ICH_SIGUMGO_GUN_GU_C IN (PARAM_DATA.GUNGU_CODE, SUBSTR(PARAM_DATA.GUNGU_CODE,2,3)) )
                        OR (PARAM_DATA.HOIKYE_CODE NOT IN (21,22,93) AND T1.ICH_SIGUMGO_GUN_GU_C  = DECODE(PARAM_DATA.GUNGU_CODE, 9999, T1.ICH_SIGUMGO_GUN_GU_C, PARAM_DATA.GUNGU_CODE) ) )                
                AND (
                  (  
                            PARAM_DATA.FIS_YEAR_CD = 1 
                        AND  
                            T1.SUNAP_DT >= SUBSTR(PARAM_DATA.TRNX_YMD,1,4)||'0101' 
                        AND  
                            T1.NEW_GU_YR_G = 1 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 9 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                        AND 
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0301' AND T1.NEW_GU_YR_G = 9 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 9 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 3 
                        AND  
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4))||'0301' AND  T1.NEW_GU_YR_G = 9 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 5 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                        AND 
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0301' AND T1.NEW_GU_YR_G = 5 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 5 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 3 
                        AND  
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4))||'0301' AND  T1.NEW_GU_YR_G = 5 
                    )    
                OR (  
                            ( 
                                    PARAM_DATA.FIS_YEAR_CD = 8  
                                AND 
                                    SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                                AND 
                                    T1.SUNAP_DT BETWEEN  (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0100' AND (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0100'
                                AND 
                                    T1.NEW_GU_YR_G = 1    
                            )
                        OR 
                            ( 
                                    PARAM_DATA.FIS_YEAR_CD = 8  
                                AND 
                                    SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                                AND 
                                    T1.SUNAP_DT BETWEEN (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0301' AND PARAM_DATA.TRNX_YMD
                                AND 
                                    T1.NEW_GU_YR_G <> 1 
                            )
                        OR 
                            (
                                    PARAM_DATA.FIS_YEAR_CD = 8 
                                AND 
                                    SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 3  
                                AND 
                                    T1.SUNAP_DT BETWEEN SUBSTR(PARAM_DATA.TRNX_YMD,1,4)||'0301' AND PARAM_DATA.TRNX_YMD
                                AND 
                                    T1.NEW_GU_YR_G <> 1 
                            )
                     )
                OR ( 
                    
                        PARAM_DATA.FIS_YEAR_CD = 0  
                    AND 
                        T1.SUNAP_DT >= SUBSTR(PARAM_DATA.TRNX_YMD,1,4)  
                    
                    )
                )

 --------------------------------


 WITH PARAM_DATA AS (
                SELECT 
                   '1' AS  BUNGI_GUBUN,
                   '20250731' AS TRNX_YMD,
                   '30' AS HOIKYE_CODE,
                   '1' AS SIGUTAX_G,
                   '185' AS GUNGU_CODE,
                   '1' AS FIS_YEAR_CD
                FROM DUAL
            )
            SELECT
                 DECODE(T1.ICH_SIGUMGO_HOIKYE_C,'62','22',T1.ICH_SIGUMGO_HOIKYE_C) AS HOIGYE_CD    
                , '' AS JIBGYE_CODE           
                ,T1.SIGUMGO_ORG_C
          ,SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT < TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD')
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT < TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD')
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        ELSE 0
                    END
                ) AS BEF_AMT
                ,SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT
                        ELSE 0
                    END
                ) AS CUR_SUIB
                ,SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_GWAON_AMT + T1.SEWOI_GWAON_AMT
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_GWAON_AMT + T1.SEWOI_GWAON_AMT
                        ELSE 0
                    END
                ) AS CUR_BACK
                ,SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        ELSE 0
                    END
                ) AS CUR_AMT
            FROM
                RPT_TXI_DDAC_TAB T1,
                PARAM_DATA                
            WHERE 1=1                
                AND T1.SIGUMGO_ORG_C = 28
                AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'YYYY'), 'YYYYMMDD')
                AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                AND T1.ICH_SIGUMGO_HOIKYE_C IN (PARAM_DATA.HOIKYE_CODE, 62)
        GROUP BY DECODE(T1.ICH_SIGUMGO_HOIKYE_C,'62','22',T1.ICH_SIGUMGO_HOIKYE_C),T1.SIGUMGO_ORG_C                       

=========================== XDA ID:[tom.ich.rpt.xda.xSelectListICH030201By04]===============================
SELECT 
 A.GROUP_NM,
 A.GUNGU_NM,
 A.TYPE1_AMT,
 A.TYPE2_AMT,
 A.TYPE3_AMT,
 A.TYPE4_AMT,
 A.TYPE5_AMT,
 A.TYPE6_AMT,
    A.TYPE7_AMT,
 A.TYPE8_AMT
FROM (
WITH PARAM_DATA AS (
                SELECT 
                   '1' AS  BUNGI_GUBUN,
                   '20250731' AS TRNX_YMD,
                   '30' AS HOIKYE_CODE,
                   '1' AS SIGUTAX_G,
                   '185' AS GUNGU_CODE,
                   '1' AS FIS_YEAR_CD
                FROM DUAL
 ) ,
 CODE_INFO AS (
SELECT
 A.REF_D_C,
 A.REF_D_NM
FROM 
(
SELECT 
 REF_D_C,
 REF_D_NM
FROM RPT_CODE_INFO
WHERE REF_L_C = 500
AND REF_M_C =28
AND REF_S_C = 5
UNION ALL 
SELECT 
 REF_D_C,
 REF_D_NM
FROM RPT_CODE_INFO
WHERE REF_L_C = 500
AND REF_M_C =28
AND REF_S_C = 1
) A
GROUP BY A.REF_D_C, A.REF_D_NM
ORDER BY A.REF_D_C, A.REF_D_NM
),
RESULT_DATA AS (
SELECT
          T1.HOIGYE_CD AS HOIGYE_CODE,
          T1.HOIGYE_CD AS JIBGYE_CODE,
          T2.FIL_100_CTNT1 AS HOIGYE_NAME,
          T2.FIL_100_CTNT1 AS JIBGYE_NAME,
   T1.GUNGU_CD, 
    '('||T1.GUNGU_CD||') '|| T3.GUNGU_NM AS GUNGU_NM,
   SUM(CUR_JIBANGSE_AMT) AS CUR_JIBANGSE_AMT,
   SUM(CUR_JIBANGSE_GWAON_AMT) AS CUR_JIBANGSE_GWAON_AMT,
   SUM(CUR_JIBANGSE_CRT_AMT) AS CUR_JIBANGSE_CRT_AMT,
   SUM(CUR_SEWOI_AMT) AS CUR_SEWOI_AMT,
   SUM(CUR_SEWOI_GWAON_AMT) AS CUR_SEWOI_GWAON_AMT,
   SUM(CUR_SEWOI_CRT_AMT) AS CUR_SEWOI_CRT_AMT,
   SUM(CUR_GYOYUKSE_AMT) AS CUR_GYOYUKSE_AMT,
   SUM(CUR_GYOYUKSE_GWAON_AMT) AS CUR_GYOYUKSE_GWAON_AMT,
   SUM(CUR_GYOYUKSE_CRT_AMT) AS CUR_GYOYUKSE_CRT_AMT,
   SUM(CUR_NONGTEUKSE_AMT) AS CUR_NONGTEUKSE_AMT,
   SUM(CUR_NONGTEUKSE_GWAON_AMT) AS CUR_NONGTEUKSE_GWAON_AMT,
   SUM(CUR_NONGTEUKSE_CRT_AMT) AS CUR_NONGTEUKSE_CRT_AMT
FROM (
            SELECT
                 DECODE(T1.ICH_SIGUMGO_HOIKYE_C,'62','22',T1.ICH_SIGUMGO_HOIKYE_C) AS HOIGYE_CD    
                , '' AS JIBGYE_CODE           
                ,T1.SIGUMGO_ORG_C
  ,T1.ICH_SIGUMGO_GUN_GU_C AS GUNGU_CD
   , SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_AMT 
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_AMT 
                        ELSE 0
                    END
                ) AS CUR_JIBANGSE_AMT
   , SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_GWAON_AMT 
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_GWAON_AMT 
                        ELSE 0
                    END
                ) AS CUR_JIBANGSE_GWAON_AMT
   , SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_CRT_AMT 
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_CRT_AMT 
                        ELSE 0
                    END
                ) AS CUR_JIBANGSE_CRT_AMT
   , SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.SEWOI_AMT 
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.SEWOI_AMT 
                        ELSE 0
                    END
                ) AS CUR_SEWOI_AMT
   , SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.SEWOI_GWAON_AMT 
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.SEWOI_GWAON_AMT 
                        ELSE 0
                    END
                ) AS CUR_SEWOI_GWAON_AMT
   , SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.SEWOI_CRT_AMT 
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.SEWOI_CRT_AMT 
                        ELSE 0
                    END
                ) AS CUR_SEWOI_CRT_AMT
   , SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.GYOYUKSE_AMT 
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.GYOYUKSE_AMT 
                        ELSE 0
                    END
                ) AS CUR_GYOYUKSE_AMT
   , SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.GYOYUKSE_GWAON_AMT 
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.GYOYUKSE_GWAON_AMT 
                        ELSE 0
                    END
                ) AS CUR_GYOYUKSE_GWAON_AMT
   , SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.GYOYUKSE_CRT_AMT 
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.GYOYUKSE_CRT_AMT 
                        ELSE 0
                    END
                ) AS CUR_GYOYUKSE_CRT_AMT
   , SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.NONGTEUKSE_AMT 
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.NONGTEUKSE_AMT 
                        ELSE 0
                    END
                ) AS CUR_NONGTEUKSE_AMT
   , SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.NONGTEUKSE_GWAON_AMT 
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.NONGTEUKSE_GWAON_AMT 
                        ELSE 0
                    END
                ) AS CUR_NONGTEUKSE_GWAON_AMT
   , SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.NONGTEUKSE_CRT_AMT 
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.NONGTEUKSE_CRT_AMT 
                        ELSE 0
                    END
                ) AS CUR_NONGTEUKSE_CRT_AMT
            FROM
                RPT_TXI_DDAC_TAB T1,
                PARAM_DATA                
            WHERE 1=1                
                AND T1.SIGUMGO_ORG_C = 28
                AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'YYYY'), 'YYYYMMDD')
                AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                AND T1.ICH_SIGUMGO_HOIKYE_C IN (PARAM_DATA.HOIKYE_CODE, 62)
                AND T1.SIGUTAX_G = NVL(PARAM_DATA.SIGUTAX_G, '1')
                AND  (  ( PARAM_DATA.HOIKYE_CODE =  22  AND T1.ICH_SIGUMGO_HOIKYE_C IN (22, 62, 209332) ) OR
                        ( PARAM_DATA.HOIKYE_CODE =  213000  AND T1.ICH_SIGUMGO_HOIKYE_C IN (213000, 217100) ) OR
                        ( PARAM_DATA.HOIKYE_CODE =  99 )  OR
                        ( PARAM_DATA.HOIKYE_CODE NOT IN (22,213000,99) AND T1.ICH_SIGUMGO_HOIKYE_C = PARAM_DATA.HOIKYE_CODE ) )
                AND  (  ( PARAM_DATA.HOIKYE_CODE = 22 AND PARAM_DATA.GUNGU_CODE = 0 AND T1.ICH_SIGUMGO_GUN_GU_C  IN (7000, 7040, 7810, 7055, 7830, 7840, 7850, 7100, 0) )
                        OR ( PARAM_DATA.HOIKYE_CODE IN (21,22,93) AND PARAM_DATA.GUNGU_CODE = 9999 )
                        OR ( PARAM_DATA.HOIKYE_CODE = 22 AND PARAM_DATA.GUNGU_CODE NOT IN (0,9999) AND ( CASE WHEN T1.ICH_SIGUMGO_GUN_GU_C = 7100 THEN  0
                                WHEN T1.ICH_SIGUMGO_GUN_GU_C > 7100 AND T1.ICH_SIGUMGO_GUN_GU_C < 7800 THEN T1.ICH_SIGUMGO_GUN_GU_C - 7000 ELSE T1.ICH_SIGUMGO_GUN_GU_C END) = DECODE(PARAM_DATA.GUNGU_CODE, 9999, T1.ICH_SIGUMGO_GUN_GU_C, PARAM_DATA.GUNGU_CODE) )
                        OR (PARAM_DATA.HOIKYE_CODE IN ( 21,93) AND PARAM_DATA.GUNGU_CODE = 7100 AND T1.ICH_SIGUMGO_GUN_GU_C  IN (0, 7000, 100, 7100) )
                        OR (PARAM_DATA.HOIKYE_CODE IN ( 21,93) AND PARAM_DATA.GUNGU_CODE <> 7100 AND T1.ICH_SIGUMGO_GUN_GU_C IN (PARAM_DATA.GUNGU_CODE, SUBSTR(PARAM_DATA.GUNGU_CODE,2,3)) )
                        OR (PARAM_DATA.HOIKYE_CODE NOT IN (21,22,93) AND T1.ICH_SIGUMGO_GUN_GU_C  = DECODE(PARAM_DATA.GUNGU_CODE, 9999, T1.ICH_SIGUMGO_GUN_GU_C, PARAM_DATA.GUNGU_CODE) ) )                
                AND (
                  (  
                            PARAM_DATA.FIS_YEAR_CD = 1 
                        AND  
                            T1.SUNAP_DT >= SUBSTR(PARAM_DATA.TRNX_YMD,1,4)||'0101' 
                        AND  
                            T1.NEW_GU_YR_G = 1 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 9 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                        AND 
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0301' AND T1.NEW_GU_YR_G = 9 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 9 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 3 
                        AND  
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4))||'0301' AND  T1.NEW_GU_YR_G = 9 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 5 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                        AND 
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0301' AND T1.NEW_GU_YR_G = 5 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 5 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 3 
                        AND  
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4))||'0301' AND  T1.NEW_GU_YR_G = 5 
                    )    
                OR (  
                            ( 
                                    PARAM_DATA.FIS_YEAR_CD = 8  
                                AND 
                                    SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                                AND 
                                    T1.SUNAP_DT BETWEEN  (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0100' AND (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0100'
                                AND 
                                    T1.NEW_GU_YR_G = 1    
                            )
                        OR 
                            ( 
                                    PARAM_DATA.FIS_YEAR_CD = 8  
                                AND 
                                    SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                                AND 
                                    T1.SUNAP_DT BETWEEN (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0301' AND PARAM_DATA.TRNX_YMD
                                AND 
                                    T1.NEW_GU_YR_G <> 1 
                            )
                        OR 
                            (
                                    PARAM_DATA.FIS_YEAR_CD = 8 
                                AND 
                                    SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 3  
                                AND 
                                    T1.SUNAP_DT BETWEEN SUBSTR(PARAM_DATA.TRNX_YMD,1,4)||'0301' AND PARAM_DATA.TRNX_YMD
                                AND 
                                    T1.NEW_GU_YR_G <> 1 
                            )
                     )
                OR ( 
                    
                        PARAM_DATA.FIS_YEAR_CD = 0  
                    AND 
                        T1.SUNAP_DT >= SUBSTR(PARAM_DATA.TRNX_YMD,1,4)  
                    
                    )
                )        
            GROUP BY DECODE(T1.ICH_SIGUMGO_HOIKYE_C,'62','22',T1.ICH_SIGUMGO_HOIKYE_C),T1.SIGUMGO_ORG_C,T1.ICH_SIGUMGO_GUN_GU_C
            UNION ALL
                SELECT '22' AS HOIGYE_CD 
                       ,'22' JIBGYE_CODE 
                       ,28 SIGUMGO_ORG_C
   ,GUNGU_CD
   , 0 AS CUR_JIBANGSE_AMT
   , 0 AS CUR_JIBANGSE_GWAON_AMT
   , 0 AS CUR_JIBANGSE_CRT_AMT
   , SUM(CASE WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND SUNAPIL BETWEEN (SUBSTR(PARAM_DATA.TRNX_YMD,1,6))||'01' AND PARAM_DATA.TRNX_YMD  THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 10 AND SUNAPIL BETWEEN (SUBSTR(PARAM_DATA.TRNX_YMD,1,4))||'1001' AND PARAM_DATA.TRNX_YMD THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 7 AND SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 10 AND SUNAPIL BETWEEN (SUBSTR(PARAM_DATA.TRNX_YMD,1,4))||'0701' AND PARAM_DATA.TRNX_YMD THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 4 AND SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 7 AND SUNAPIL BETWEEN (SUBSTR(PARAM_DATA.TRNX_YMD,1,4))||'0401' AND PARAM_DATA.TRNX_YMD  THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND SUBSTR(PARAM_DATA.TRNX_YMD,5,2) <  4 AND SUNAPIL <= PARAM_DATA.TRNX_YMD  THEN NVL(NAPBU_SIDO_TAX_AMT,0) ELSE 0 END) AS CUR_SEWOI_AMT
   , 0 AS CUR_SEWOI_GWAON_AMT
   , 0 AS CUR_SEWOI_CRT_AMT
   , 0 AS CUR_GYOYUKSE_AMT
   , 0 AS CUR_GYOYUKSE_GWAON_AMT
   , 0 AS CUR_GYOYUKSE_CRT_AMT
   , 0 AS CUR_NONGTEUKSE_AMT
   , 0 AS CUR_NONGTEUKSE_GWAON_AMT
   , 0 AS CUR_NONGTEUKSE_CRT_AMT
                FROM
                (
                    -- 2025.06.04. 하수도원인자부담금은 부가세가 없어 부가세 로직 제거 및 신세목코드추가
                    -- 추후 RPT_SUNAP_JIBGYE 수납 데이터 생성후 NIO_STAX_MASTR_TAB 제거
 SELECT SUNP_DT AS SUNAPIL,
                        CASE  WHEN NEW_GU_YR_G = 1 THEN 1 WHEN NEW_GU_YR_G = 2 THEN 9  ELSE  99 END YEAR_GUBUN,
                        HOIKYE_CD, SMOK_CD,
                        CASE WHEN CVT_GUCHUNG_CD = '357' THEN 710 WHEN CVT_GUCHUNG_CD = '358' THEN 720 ELSE TO_NUMBER(NVL(CVT_GUCHUNG_CD,0)) END AS GUNGU_CD,
                        NAPBU_TCNT, NAPBU_NTAX_AMT, NAPBU_SIDO_TAX_AMT, NAPBU_SIGNGU_TAX_AMT
                    FROM NIO_STAX_MASTR_TAB,
                PARAM_DATA
                    WHERE SUNP_DT BETWEEN SUBSTR(PARAM_DATA.TRNX_YMD,1,4)||'0100' AND PARAM_DATA.TRNX_YMD  AND FORM_G <> '1' AND INSIK_G <> 'D' AND INSIK_G <> 'R' 
                    AND BLK_NO = '990'  AND CVT_GUCHUNG_CD IN ('357','358') AND HOIKYE_CD = '51' AND ((SMOK_CD = '281020') OR (NEW_SMOK_CD = '236009' AND NEW_SMOK_OP_CD = '000'))  
                ),
                PARAM_DATA
                WHERE 1 = 1
                AND  (GUNGU_CD = PARAM_DATA.GUNGU_CODE OR 9999 = PARAM_DATA.GUNGU_CODE )
                AND 1 = (CASE WHEN PARAM_DATA.HOIKYE_CODE = '22' THEN 1 ELSE 0 END)
                GROUP BY GUNGU_CD
            ) T1, 
            RPT_HOIKYE_CD T2,
     (
  SELECT 
  REF_D_C AS GUNGU_CD, 
  REF_D_NM AS GUNGU_NM
  FROM CODE_INFO                                                        
     ) T3 
    WHERE 1=1
    AND T1.HOIGYE_CD = T2.SIGUMGO_HOIKYE_C(+)
    AND T1.SIGUMGO_ORG_C = T2.SIGUMGO_C(+) 
    AND T1.GUNGU_CD = T3.GUNGU_CD(+)
    GROUP BY T1.HOIGYE_CD, T1.SIGUMGO_ORG_C, T2.FIL_100_CTNT1, T1.GUNGU_CD, T3.GUNGU_NM
 )
 SELECT 
  HOIGYE_CODE,
         JIBGYE_CODE,
         HOIGYE_NAME,
         JIBGYE_NAME,
  GUNGU_CD, 
  GUNGU_NM,
  '1' AS GROUP_NM,
  CUR_JIBANGSE_AMT AS TYPE1_AMT,
  CUR_JIBANGSE_GWAON_AMT AS TYPE2_AMT,
  CUR_JIBANGSE_CRT_AMT AS TYPE3_AMT,
     (CUR_JIBANGSE_AMT + CUR_JIBANGSE_CRT_AMT - CUR_JIBANGSE_GWAON_AMT) AS TYPE4_AMT,
  CUR_SEWOI_AMT AS TYPE5_AMT,
  CUR_SEWOI_GWAON_AMT AS TYPE6_AMT,
  CUR_SEWOI_CRT_AMT AS TYPE7_AMT,
     (CUR_SEWOI_AMT + CUR_SEWOI_CRT_AMT - CUR_SEWOI_GWAON_AMT) AS TYPE8_AMT
 FROM RESULT_DATA
 UNION ALL
  SELECT 
  HOIGYE_CODE,
         JIBGYE_CODE,
         HOIGYE_NAME,
         JIBGYE_NAME,
  GUNGU_CD, 
  GUNGU_NM,
  '2' AS GROUP_NM ,
  CUR_GYOYUKSE_AMT AS TYPE1_AMT,
  CUR_GYOYUKSE_GWAON_AMT AS TYPE2_AMT,
  CUR_GYOYUKSE_CRT_AMT AS TYPE3_AMT,
     (CUR_GYOYUKSE_AMT + CUR_GYOYUKSE_CRT_AMT - CUR_GYOYUKSE_GWAON_AMT) AS TYPE4_AMT,
  CUR_NONGTEUKSE_AMT AS TYPE5_AMT,
  CUR_NONGTEUKSE_GWAON_AMT AS TYPE6_AMT,
  CUR_NONGTEUKSE_CRT_AMT AS TYPE7_AMT,
     (CUR_NONGTEUKSE_AMT + CUR_NONGTEUKSE_CRT_AMT - CUR_NONGTEUKSE_GWAON_AMT) AS TYPE8_AMT
 FROM RESULT_DATA
) A
WHERE 1=1 
ORDER BY A.GROUP_NM, A.GUNGU_CD        

=========================== XDA ID:[tom.ich.rpt.xda.xSelectListICH030201By01]===============================
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
            WITH PARAM_DATA AS (
                SELECT 
                   '1' AS  BUNGI_GUBUN,
                   '20250731' AS TRNX_YMD,
                   '30' AS HOIKYE_CODE,
                   '1' AS SIGUTAX_G,
                   '185' AS GUNGU_CODE,
                   '1' AS FIS_YEAR_CD
                FROM DUAL
            )
            SELECT
                 DECODE(T1.ICH_SIGUMGO_HOIKYE_C,'62','22',T1.ICH_SIGUMGO_HOIKYE_C) AS HOIGYE_CD    
                , '' AS JIBGYE_CODE           
                ,T1.SIGUMGO_ORG_C
          ,SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT < TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD')
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT < TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD')
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        ELSE 0
                    END
                ) AS BEF_AMT
                ,SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT
                        ELSE 0
                    END
                ) AS CUR_SUIB
                ,SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_GWAON_AMT + T1.SEWOI_GWAON_AMT
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_GWAON_AMT + T1.SEWOI_GWAON_AMT
                        ELSE 0
                    END
                ) AS CUR_BACK
                ,SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        ELSE 0
                    END
                ) AS CUR_AMT
            FROM
                RPT_TXI_DDAC_TAB T1,
                PARAM_DATA                
            WHERE 1=1                
                AND T1.SIGUMGO_ORG_C = 28
                AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'YYYY'), 'YYYYMMDD')
                AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                AND T1.ICH_SIGUMGO_HOIKYE_C IN (PARAM_DATA.HOIKYE_CODE, 62)
                AND T1.SIGUTAX_G = NVL(PARAM_DATA.SIGUTAX_G, '1')
                AND  (  ( PARAM_DATA.HOIKYE_CODE =  22  AND T1.ICH_SIGUMGO_HOIKYE_C IN (22, 62, 209332) ) OR
                        ( PARAM_DATA.HOIKYE_CODE =  213000  AND T1.ICH_SIGUMGO_HOIKYE_C IN (213000, 217100) ) OR
                        ( PARAM_DATA.HOIKYE_CODE =  99 )  OR
                        ( PARAM_DATA.HOIKYE_CODE NOT IN (22,213000,99) AND T1.ICH_SIGUMGO_HOIKYE_C = PARAM_DATA.HOIKYE_CODE ) )
                AND  (  ( PARAM_DATA.HOIKYE_CODE = 22 AND PARAM_DATA.GUNGU_CODE = 0 AND T1.ICH_SIGUMGO_GUN_GU_C  IN (7000, 7040, 7810, 7055, 7830, 7840, 7850, 7100, 0) )
                        OR ( PARAM_DATA.HOIKYE_CODE IN (21,22,93) AND PARAM_DATA.GUNGU_CODE = 9999 )
                        OR ( PARAM_DATA.HOIKYE_CODE = 22 AND PARAM_DATA.GUNGU_CODE NOT IN (0,9999) AND ( CASE WHEN T1.ICH_SIGUMGO_GUN_GU_C = 7100 THEN  0
                                WHEN T1.ICH_SIGUMGO_GUN_GU_C > 7100 AND T1.ICH_SIGUMGO_GUN_GU_C < 7800 THEN T1.ICH_SIGUMGO_GUN_GU_C - 7000 ELSE T1.ICH_SIGUMGO_GUN_GU_C END) = DECODE(PARAM_DATA.GUNGU_CODE, 9999, T1.ICH_SIGUMGO_GUN_GU_C, PARAM_DATA.GUNGU_CODE) )
                        OR (PARAM_DATA.HOIKYE_CODE IN ( 21,93) AND PARAM_DATA.GUNGU_CODE = 7100 AND T1.ICH_SIGUMGO_GUN_GU_C  IN (0, 7000, 100, 7100) )
                        OR (PARAM_DATA.HOIKYE_CODE IN ( 21,93) AND PARAM_DATA.GUNGU_CODE <> 7100 AND T1.ICH_SIGUMGO_GUN_GU_C IN (PARAM_DATA.GUNGU_CODE, SUBSTR(PARAM_DATA.GUNGU_CODE,2,3)) )
                        OR (PARAM_DATA.HOIKYE_CODE NOT IN (21,22,93) AND T1.ICH_SIGUMGO_GUN_GU_C  = DECODE(PARAM_DATA.GUNGU_CODE, 9999, T1.ICH_SIGUMGO_GUN_GU_C, PARAM_DATA.GUNGU_CODE) ) )                
                AND (
                  (  
                            PARAM_DATA.FIS_YEAR_CD = 1 
                        AND  
                            T1.SUNAP_DT >= SUBSTR(PARAM_DATA.TRNX_YMD,1,4)||'0101' 
                        AND  
                            T1.NEW_GU_YR_G = 1 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 9 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                        AND 
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0301' AND T1.NEW_GU_YR_G = 9 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 9 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 3 
                        AND  
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4))||'0301' AND  T1.NEW_GU_YR_G = 9 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 5 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                        AND 
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0301' AND T1.NEW_GU_YR_G = 5 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 5 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 3 
                        AND  
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4))||'0301' AND  T1.NEW_GU_YR_G = 5 
                    )    
                OR (  
                            ( 
                                    PARAM_DATA.FIS_YEAR_CD = 8  
                                AND 
                                    SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                                AND 
                                    T1.SUNAP_DT BETWEEN  (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0100' AND (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0100'
                                AND 
                                    T1.NEW_GU_YR_G = 1    
                            )
                        OR 
                            ( 
                                    PARAM_DATA.FIS_YEAR_CD = 8  
                                AND 
                                    SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                                AND 
                                    T1.SUNAP_DT BETWEEN (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0301' AND PARAM_DATA.TRNX_YMD
                                AND 
                                    T1.NEW_GU_YR_G <> 1 
                            )
                        OR 
                            (
                                    PARAM_DATA.FIS_YEAR_CD = 8 
                                AND 
                                    SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 3  
                                AND 
                                    T1.SUNAP_DT BETWEEN SUBSTR(PARAM_DATA.TRNX_YMD,1,4)||'0301' AND PARAM_DATA.TRNX_YMD
                                AND 
                                    T1.NEW_GU_YR_G <> 1 
                            )
                     )
                OR ( 
                    
                        PARAM_DATA.FIS_YEAR_CD = 0  
                    AND 
                        T1.SUNAP_DT >= SUBSTR(PARAM_DATA.TRNX_YMD,1,4)  
                    
                    )
                )        
            GROUP BY DECODE(T1.ICH_SIGUMGO_HOIKYE_C,'62','22',T1.ICH_SIGUMGO_HOIKYE_C),T1.SIGUMGO_ORG_C
            
            ) T1, 
            RPT_HOIKYE_CD T2
    WHERE 1=1
    AND T1.HOIGYE_CD = T2.SIGUMGO_HOIKYE_C(+)
    AND T1.SIGUMGO_ORG_C = T2.SIGUMGO_C(+)
    GROUP BY T1.HOIGYE_CD, T1.SIGUMGO_ORG_C, T2.FIL_100_CTNT1
============================================================================================


SELECT 
 T1.* 
FROM (
            WITH PARAM_DATA AS (
                SELECT 
                   '1' AS  BUNGI_GUBUN,
                   '20250731' AS TRNX_YMD,
                   '30' AS HOIKYE_CODE,
                   '1' AS SIGUTAX_G,
                   '185' AS GUNGU_CODE,
                   '1' AS FIS_YEAR_CD
                FROM DUAL
            )
            SELECT
                 DECODE(T1.ICH_SIGUMGO_HOIKYE_C,'62','22',T1.ICH_SIGUMGO_HOIKYE_C) AS HOIGYE_CD    
                , '' AS JIBGYE_CODE           
                ,T1.SIGUMGO_ORG_C
          ,SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT < TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD')
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT < TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD')
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        ELSE 0
                    END
                ) AS BEF_AMT
                ,SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT
                        ELSE 0
                    END
                ) AS CUR_SUIB
                ,SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_GWAON_AMT + T1.SEWOI_GWAON_AMT
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_GWAON_AMT + T1.SEWOI_GWAON_AMT
                        ELSE 0
                    END
                ) AS CUR_BACK
                ,SUM(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        ELSE 0
                    END
                ) AS CUR_AMT
            FROM
                RPT_TXI_DDAC_TAB T1,
                PARAM_DATA                
            WHERE 1=1                
                AND T1.SIGUMGO_ORG_C = 28
                AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'YYYY'), 'YYYYMMDD')
                AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                AND T1.ICH_SIGUMGO_HOIKYE_C IN (PARAM_DATA.HOIKYE_CODE, 62)
                AND T1.SIGUTAX_G = NVL(PARAM_DATA.SIGUTAX_G, '1')
                AND  (  ( PARAM_DATA.HOIKYE_CODE =  22  AND T1.ICH_SIGUMGO_HOIKYE_C IN (22, 62, 209332) ) OR
                        ( PARAM_DATA.HOIKYE_CODE =  213000  AND T1.ICH_SIGUMGO_HOIKYE_C IN (213000, 217100) ) OR
                        ( PARAM_DATA.HOIKYE_CODE =  99 )  OR
                        ( PARAM_DATA.HOIKYE_CODE NOT IN (22,213000,99) AND T1.ICH_SIGUMGO_HOIKYE_C = PARAM_DATA.HOIKYE_CODE ) )
                AND  (  ( PARAM_DATA.HOIKYE_CODE = 22 AND PARAM_DATA.GUNGU_CODE = 0 AND T1.ICH_SIGUMGO_GUN_GU_C  IN (7000, 7040, 7810, 7055, 7830, 7840, 7850, 7100, 0) )
                        OR ( PARAM_DATA.HOIKYE_CODE IN (21,22,93) AND PARAM_DATA.GUNGU_CODE = 9999 )
                        OR ( PARAM_DATA.HOIKYE_CODE = 22 AND PARAM_DATA.GUNGU_CODE NOT IN (0,9999) AND ( CASE WHEN T1.ICH_SIGUMGO_GUN_GU_C = 7100 THEN  0
                                WHEN T1.ICH_SIGUMGO_GUN_GU_C > 7100 AND T1.ICH_SIGUMGO_GUN_GU_C < 7800 THEN T1.ICH_SIGUMGO_GUN_GU_C - 7000 ELSE T1.ICH_SIGUMGO_GUN_GU_C END) = DECODE(PARAM_DATA.GUNGU_CODE, 9999, T1.ICH_SIGUMGO_GUN_GU_C, PARAM_DATA.GUNGU_CODE) )
                        OR (PARAM_DATA.HOIKYE_CODE IN ( 21,93) AND PARAM_DATA.GUNGU_CODE = 7100 AND T1.ICH_SIGUMGO_GUN_GU_C  IN (0, 7000, 100, 7100) )
                        OR (PARAM_DATA.HOIKYE_CODE IN ( 21,93) AND PARAM_DATA.GUNGU_CODE <> 7100 AND T1.ICH_SIGUMGO_GUN_GU_C IN (PARAM_DATA.GUNGU_CODE, SUBSTR(PARAM_DATA.GUNGU_CODE,2,3)) )
                        OR (PARAM_DATA.HOIKYE_CODE NOT IN (21,22,93) AND T1.ICH_SIGUMGO_GUN_GU_C  = DECODE(PARAM_DATA.GUNGU_CODE, 9999, T1.ICH_SIGUMGO_GUN_GU_C, PARAM_DATA.GUNGU_CODE) ) )                
                AND (
                  (  
                            PARAM_DATA.FIS_YEAR_CD = 1 
                        AND  
                            T1.SUNAP_DT >= SUBSTR(PARAM_DATA.TRNX_YMD,1,4)||'0101' 
                        AND  
                            T1.NEW_GU_YR_G = 1 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 9 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                        AND 
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0301' AND T1.NEW_GU_YR_G = 9 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 9 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 3 
                        AND  
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4))||'0301' AND  T1.NEW_GU_YR_G = 9 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 5 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                        AND 
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0301' AND T1.NEW_GU_YR_G = 5 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 5 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 3 
                        AND  
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4))||'0301' AND  T1.NEW_GU_YR_G = 5 
                    )    
                OR (  
                            ( 
                                    PARAM_DATA.FIS_YEAR_CD = 8  
                                AND 
                                    SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                                AND 
                                    T1.SUNAP_DT BETWEEN  (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0100' AND (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0100'
                                AND 
                                    T1.NEW_GU_YR_G = 1    
                            )
                        OR 
                            ( 
                                    PARAM_DATA.FIS_YEAR_CD = 8  
                                AND 
                                    SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                                AND 
                                    T1.SUNAP_DT BETWEEN (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0301' AND PARAM_DATA.TRNX_YMD
                                AND 
                                    T1.NEW_GU_YR_G <> 1 
                            )
                        OR 
                            (
                                    PARAM_DATA.FIS_YEAR_CD = 8 
                                AND 
                                    SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 3  
                                AND 
                                    T1.SUNAP_DT BETWEEN SUBSTR(PARAM_DATA.TRNX_YMD,1,4)||'0301' AND PARAM_DATA.TRNX_YMD
                                AND 
                                    T1.NEW_GU_YR_G <> 1 
                            )
                     )
                OR ( 
                    
                        PARAM_DATA.FIS_YEAR_CD = 0  
                    AND 
                        T1.SUNAP_DT >= SUBSTR(PARAM_DATA.TRNX_YMD,1,4)  
                    
                    )
                )        
            GROUP BY DECODE(T1.ICH_SIGUMGO_HOIKYE_C,'62','22',T1.ICH_SIGUMGO_HOIKYE_C),T1.SIGUMGO_ORG_C
            
            ) T1, 
            RPT_HOIKYE_CD T2
    WHERE 1=1
    AND T1.HOIGYE_CD = T2.SIGUMGO_HOIKYE_C(+)
    AND T1.SIGUMGO_ORG_C = T2.SIGUMGO_C(+)


------------------------------- 
WITH PARAM_DATA AS (
                SELECT 
                   '1' AS  BUNGI_GUBUN,
                   '20250731' AS TRNX_YMD,
                   '30' AS HOIKYE_CODE,
                   '1' AS SIGUTAX_G,
                   '185' AS GUNGU_CODE,
                   '1' AS FIS_YEAR_CD
                FROM DUAL
            )
            SELECT
                 DECODE(T1.ICH_SIGUMGO_HOIKYE_C,'62','22',T1.ICH_SIGUMGO_HOIKYE_C) AS HOIGYE_CD    
                , '' AS JIBGYE_CODE           
                ,T1.SIGUMGO_ORG_C
          ,
                    T1.SUNAP_DT

          ,(
                    CASE
                        WHEN PARAM_DATA.BUNGI_GUBUN = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT
                        WHEN PARAM_DATA.BUNGI_GUBUN = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT
                        ELSE 0
                    END
                ) AS CUR_SUIB
                
                
            FROM
                RPT_TXI_DDAC_TAB T1,
                PARAM_DATA                
            WHERE 1=1                
                AND T1.SIGUMGO_ORG_C = 28
                AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'YYYY'), 'YYYYMMDD')
                AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                AND T1.ICH_SIGUMGO_HOIKYE_C IN (PARAM_DATA.HOIKYE_CODE, 62)
                AND T1.SIGUTAX_G = NVL(PARAM_DATA.SIGUTAX_G, '1')
                AND  (  ( PARAM_DATA.HOIKYE_CODE =  22  AND T1.ICH_SIGUMGO_HOIKYE_C IN (22, 62, 209332) ) OR
                        ( PARAM_DATA.HOIKYE_CODE =  213000  AND T1.ICH_SIGUMGO_HOIKYE_C IN (213000, 217100) ) OR
                        ( PARAM_DATA.HOIKYE_CODE =  99 )  OR
                        ( PARAM_DATA.HOIKYE_CODE NOT IN (22,213000,99) AND T1.ICH_SIGUMGO_HOIKYE_C = PARAM_DATA.HOIKYE_CODE ) )
                AND  (  ( PARAM_DATA.HOIKYE_CODE = 22 AND PARAM_DATA.GUNGU_CODE = 0 AND T1.ICH_SIGUMGO_GUN_GU_C  IN (7000, 7040, 7810, 7055, 7830, 7840, 7850, 7100, 0) )
                        OR ( PARAM_DATA.HOIKYE_CODE IN (21,22,93) AND PARAM_DATA.GUNGU_CODE = 9999 )
                        OR ( PARAM_DATA.HOIKYE_CODE = 22 AND PARAM_DATA.GUNGU_CODE NOT IN (0,9999) AND ( CASE WHEN T1.ICH_SIGUMGO_GUN_GU_C = 7100 THEN  0
                                WHEN T1.ICH_SIGUMGO_GUN_GU_C > 7100 AND T1.ICH_SIGUMGO_GUN_GU_C < 7800 THEN T1.ICH_SIGUMGO_GUN_GU_C - 7000 ELSE T1.ICH_SIGUMGO_GUN_GU_C END) = DECODE(PARAM_DATA.GUNGU_CODE, 9999, T1.ICH_SIGUMGO_GUN_GU_C, PARAM_DATA.GUNGU_CODE) )
                        OR (PARAM_DATA.HOIKYE_CODE IN ( 21,93) AND PARAM_DATA.GUNGU_CODE = 7100 AND T1.ICH_SIGUMGO_GUN_GU_C  IN (0, 7000, 100, 7100) )
                        OR (PARAM_DATA.HOIKYE_CODE IN ( 21,93) AND PARAM_DATA.GUNGU_CODE <> 7100 AND T1.ICH_SIGUMGO_GUN_GU_C IN (PARAM_DATA.GUNGU_CODE, SUBSTR(PARAM_DATA.GUNGU_CODE,2,3)) )
                        OR (PARAM_DATA.HOIKYE_CODE NOT IN (21,22,93) AND T1.ICH_SIGUMGO_GUN_GU_C  = DECODE(PARAM_DATA.GUNGU_CODE, 9999, T1.ICH_SIGUMGO_GUN_GU_C, PARAM_DATA.GUNGU_CODE) ) )                
                AND (
                  (  
                            PARAM_DATA.FIS_YEAR_CD = 1 
                        AND  
                            T1.SUNAP_DT >= SUBSTR(PARAM_DATA.TRNX_YMD,1,4)||'0101' 
                        AND  
                            T1.NEW_GU_YR_G = 1 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 9 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                        AND 
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0301' AND T1.NEW_GU_YR_G = 9 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 9 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 3 
                        AND  
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4))||'0301' AND  T1.NEW_GU_YR_G = 9 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 5 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                        AND 
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0301' AND T1.NEW_GU_YR_G = 5 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 5 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 3 
                        AND  
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4))||'0301' AND  T1.NEW_GU_YR_G = 5 
                    )    
                OR (  
                            ( 
                                    PARAM_DATA.FIS_YEAR_CD = 8  
                                AND 
                                    SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                                AND 
                                    T1.SUNAP_DT BETWEEN  (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0100' AND (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0100'
                                AND 
                                    T1.NEW_GU_YR_G = 1    
                            )
                        OR 
                            ( 
                                    PARAM_DATA.FIS_YEAR_CD = 8  
                                AND 
                                    SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                                AND 
                                    T1.SUNAP_DT BETWEEN (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0301' AND PARAM_DATA.TRNX_YMD
                                AND 
                                    T1.NEW_GU_YR_G <> 1 
                            )
                        OR 
                            (
                                    PARAM_DATA.FIS_YEAR_CD = 8 
                                AND 
                                    SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 3  
                                AND 
                                    T1.SUNAP_DT BETWEEN SUBSTR(PARAM_DATA.TRNX_YMD,1,4)||'0301' AND PARAM_DATA.TRNX_YMD
                                AND 
                                    T1.NEW_GU_YR_G <> 1 
                            )
                     )
                OR ( 
                    
                        PARAM_DATA.FIS_YEAR_CD = 0  
                    AND 
                        T1.SUNAP_DT >= SUBSTR(PARAM_DATA.TRNX_YMD,1,4)  
                    
                    )
                )        

---------------------------------------------------------------------

 select keoraeil, SUNAPIL, sum(SEWOI_AMT) as SEWOI_AMT From RPT_SUNAP_JIBGYE
 where 1=1 
 and GEUMGO_CODE = 28
 and GUNGU_CODE  = 185
 and JIBGYE_CODE in (213000,217100) 
 and SUNAPIL between '20250701' and '20250731'
 group by keoraeil, SUNAPIL
 order by sunapil, keoraeil          

 ----------------------------------------------------------------------


 WITH PARAM_DATA AS (
                SELECT 
                   '1' AS  BUNGI_GUBUN,
                   '20250731' AS TRNX_YMD,
                   '30' AS HOIKYE_CODE,
                   '1' AS SIGUTAX_G,
                   '185' AS GUNGU_CODE,
                   '1' AS FIS_YEAR_CD
                FROM DUAL
            )
            SELECT
                 DECODE(T1.ICH_SIGUMGO_HOIKYE_C,'62','22',T1.ICH_SIGUMGO_HOIKYE_C) AS HOIGYE_CD    
                , '' AS JIBGYE_CODE           
                , T1.* 
                
                
            FROM
                RPT_TXI_DDAC_TAB T1,
                PARAM_DATA                
            WHERE 1=1                
                AND T1.SIGUMGO_ORG_C = 28
                AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE(PARAM_DATA.TRNX_YMD, 'YYYYMMDD'), 'YYYY'), 'YYYYMMDD')
                and T1.SUNAP_DT >= '20250701'
                AND T1.SUNAP_DT <= PARAM_DATA.TRNX_YMD
                AND T1.ICH_SIGUMGO_HOIKYE_C IN (PARAM_DATA.HOIKYE_CODE, 62)
                AND T1.SIGUTAX_G = NVL(PARAM_DATA.SIGUTAX_G, '1')
                AND  (  ( PARAM_DATA.HOIKYE_CODE =  22  AND T1.ICH_SIGUMGO_HOIKYE_C IN (22, 62, 209332) ) OR
                        ( PARAM_DATA.HOIKYE_CODE =  213000  AND T1.ICH_SIGUMGO_HOIKYE_C IN (213000, 217100) ) OR
                        ( PARAM_DATA.HOIKYE_CODE =  99 )  OR
                        ( PARAM_DATA.HOIKYE_CODE NOT IN (22,213000,99) AND T1.ICH_SIGUMGO_HOIKYE_C = PARAM_DATA.HOIKYE_CODE ) )
                AND  (  ( PARAM_DATA.HOIKYE_CODE = 22 AND PARAM_DATA.GUNGU_CODE = 0 AND T1.ICH_SIGUMGO_GUN_GU_C  IN (7000, 7040, 7810, 7055, 7830, 7840, 7850, 7100, 0) )
                        OR ( PARAM_DATA.HOIKYE_CODE IN (21,22,93) AND PARAM_DATA.GUNGU_CODE = 9999 )
                        OR ( PARAM_DATA.HOIKYE_CODE = 22 AND PARAM_DATA.GUNGU_CODE NOT IN (0,9999) AND ( CASE WHEN T1.ICH_SIGUMGO_GUN_GU_C = 7100 THEN  0
                                WHEN T1.ICH_SIGUMGO_GUN_GU_C > 7100 AND T1.ICH_SIGUMGO_GUN_GU_C < 7800 THEN T1.ICH_SIGUMGO_GUN_GU_C - 7000 ELSE T1.ICH_SIGUMGO_GUN_GU_C END) = DECODE(PARAM_DATA.GUNGU_CODE, 9999, T1.ICH_SIGUMGO_GUN_GU_C, PARAM_DATA.GUNGU_CODE) )
                        OR (PARAM_DATA.HOIKYE_CODE IN ( 21,93) AND PARAM_DATA.GUNGU_CODE = 7100 AND T1.ICH_SIGUMGO_GUN_GU_C  IN (0, 7000, 100, 7100) )
                        OR (PARAM_DATA.HOIKYE_CODE IN ( 21,93) AND PARAM_DATA.GUNGU_CODE <> 7100 AND T1.ICH_SIGUMGO_GUN_GU_C IN (PARAM_DATA.GUNGU_CODE, SUBSTR(PARAM_DATA.GUNGU_CODE,2,3)) )
                        OR (PARAM_DATA.HOIKYE_CODE NOT IN (21,22,93) AND T1.ICH_SIGUMGO_GUN_GU_C  = DECODE(PARAM_DATA.GUNGU_CODE, 9999, T1.ICH_SIGUMGO_GUN_GU_C, PARAM_DATA.GUNGU_CODE) ) )                
                AND (
                  (  
                            PARAM_DATA.FIS_YEAR_CD = 1 
                        AND  
                            T1.SUNAP_DT >= SUBSTR(PARAM_DATA.TRNX_YMD,1,4)||'0101' 
                        AND  
                            T1.NEW_GU_YR_G = 1 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 9 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                        AND 
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0301' AND T1.NEW_GU_YR_G = 9 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 9 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 3 
                        AND  
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4))||'0301' AND  T1.NEW_GU_YR_G = 9 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 5 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                        AND 
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0301' AND T1.NEW_GU_YR_G = 5 
                    )
                OR  ( 
                            PARAM_DATA.FIS_YEAR_CD = 5 
                        AND  
                            SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 3 
                        AND  
                            T1.SUNAP_DT >= (SUBSTR(PARAM_DATA.TRNX_YMD,1,4))||'0301' AND  T1.NEW_GU_YR_G = 5 
                    )    
                OR (  
                            ( 
                                    PARAM_DATA.FIS_YEAR_CD = 8  
                                AND 
                                    SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                                AND 
                                    T1.SUNAP_DT BETWEEN  (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0100' AND (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0100'
                                AND 
                                    T1.NEW_GU_YR_G = 1    
                            )
                        OR 
                            ( 
                                    PARAM_DATA.FIS_YEAR_CD = 8  
                                AND 
                                    SUBSTR(PARAM_DATA.TRNX_YMD,5,2) < 3  
                                AND 
                                    T1.SUNAP_DT BETWEEN (SUBSTR(PARAM_DATA.TRNX_YMD,1,4) - 1 )||'0301' AND PARAM_DATA.TRNX_YMD
                                AND 
                                    T1.NEW_GU_YR_G <> 1 
                            )
                        OR 
                            (
                                    PARAM_DATA.FIS_YEAR_CD = 8 
                                AND 
                                    SUBSTR(PARAM_DATA.TRNX_YMD,5,2) >= 3  
                                AND 
                                    T1.SUNAP_DT BETWEEN SUBSTR(PARAM_DATA.TRNX_YMD,1,4)||'0301' AND PARAM_DATA.TRNX_YMD
                                AND 
                                    T1.NEW_GU_YR_G <> 1 
                            )
                     )
                OR ( 
                    
                        PARAM_DATA.FIS_YEAR_CD = 0  
                    AND 
                        T1.SUNAP_DT >= SUBSTR(PARAM_DATA.TRNX_YMD,1,4)  
                    
                    )
                ) 
                order by T1.SUNAP_DT

 ----------------------------------------

 select hoigye_year, keoraeil, SUNAPIL, sum(SEWOI_AMT) as SEWOI_AMT From RPT_SUNAP_JIBGYE
 where 1=1 
 and GEUMGO_CODE = 28
 and GUNGU_CODE  = 185
 and JIBGYE_CODE in (213000,217100) 
 and SUNAPIL between '20250701' and '20250731'
 group by keoraeil, SUNAPIL, hoigye_year
 order by sunapil, keoraeil, hoigye_year               


 -------------------------------------------------------------

 -- 춘천시 69번 대신 68으로 수입액 차감 처리가 되는지 확인

 SELECT   BB.SIGUMGO_HOIKYE_C 
  ,BB.HOIKYE_NM NUGYE_HOIGYE_NAME
                ,TO_CHAR((SUM(NVL(SUNP_AMT,0)) + SUM(NVL(TAX_BAEJUNG_IP_AMT,0)) + SUM(NVL(IWOL_GONGGEUM,0)))) AS NUGYE_SEIB_SUIP
                ,TO_CHAR(SUM(NVL(SEIB_BANNAB,0))) AS NUGYE_SEIB_BANNAB 
                ,TO_CHAR(SUM(NVL(SEIB_GYEONGJEONG_IB,0))) AS NUGYE_SEIB_GYEONGJEONG_IB
                ,TO_CHAR(SUM(NVL(SEIB_GYEONGJEONG_JI,0))*-1) AS NUGYE_SEIB_GYEONGJEONG_JI
                ,TO_CHAR(SUM(NVL(SECHUL_BAEJEONG,0))) AS NUGYE_SECHUL_BAEJEONG
                ,TO_CHAR(SUM(NVL(SECHUL_HWANSU,0))*-1) AS NUGYE_SECHUL_HWANSU
                ,TO_CHAR(SUM(NVL(SECHUL_JI,0))) AS NUGYE_SECHUL_JI
                ,TO_CHAR(SUM(NVL(SECHUL_BANNAB,0))*-1) AS NUGYE_SECHUL_BANNAB
                ,TO_CHAR(SUM(NVL(SECHUL_GYEONGJEONG_IB,0))) AS NUGYE_SECHUL_GYEONGJEONG_IB
                ,TO_CHAR(SUM(NVL(SECHUL_GYEONGJEONG_JI,0))) AS NUGYE_SECHUL_GYEONGJEONG_JI 
                ,TO_CHAR(SUM(NVL(SEIB_GYULSANBF_IIB,0))) AS NUGYE_SEIB_GYULSANBF_IIB
                ,TO_CHAR(SUM(NVL(SECHUL_GYULSANBF_IWOL,0))) AS NUGYE_SECHUL_GYULSANBF_IWOL
                ,TO_CHAR(SUM(NVL(DEP,0)) + SUM(NVL(IWOL_GONGGEUM_DEP,0))) AS NUGYE_DEP
               ,TO_CHAR(SUM(NVL(MMDA,0)) + SUM(NVL(IWOL_MMDA,0))) AS NUGYE_MMDA
               ,TO_CHAR(SUM(NVL(SUNP_AMT,0)) - SUM(NVL(SEIB_SUIP,0)) + SUM(NVL(IWOL_MIJUNGSAN,0))) AS NUGYE_MIICHE
                ,TO_CHAR((SUM(NVL(SUNP_AMT2,0)) + SUM(NVL(TAX_BAEJUNG_IP_AMT2,0)) + SUM(NVL(IWOL_GONGGEUM2,0)))) AS ILGYE_SEIB_SUIP
                ,TO_CHAR(SUM(NVL(SEIB_BANNAB2,0))) AS ILGYE_SEIB_BANNAB
                ,TO_CHAR(SUM(NVL(SEIB_GYEONGJEONG_IB2,0))) AS ILGYE_SEIB_GYEONGJEONG_IB
                ,TO_CHAR(SUM(NVL(SEIB_GYEONGJEONG_JI2,0))*-1) AS ILGYE_SEIB_GYEONGJEONG_JI
                ,TO_CHAR(SUM(NVL(SECHUL_BAEJEONG2,0))) AS ILGYE_SECHUL_BAEJEONG
                ,TO_CHAR(SUM(NVL(SECHUL_HWANSU2,0))*-1) AS ILGYE_SECHUL_HWANSU
                ,TO_CHAR(SUM(NVL(SECHUL_JI2,0))) AS ILGYE_SECHUL_JI
                ,TO_CHAR(SUM(NVL(SECHUL_BANNAB2,0))*-1) AS ILGYE_SECHUL_BANNAB
                ,TO_CHAR(SUM(NVL(SECHUL_GYEONGJEONG_IB2,0))) AS ILGYE_SECHUL_GYEONGJEONG_IB  
                ,TO_CHAR(SUM(NVL(SECHUL_GYEONGJEONG_JI2,0))) AS ILGYE_SECHUL_GYEONGJEONG_JI  
                ,TO_CHAR(SUM(NVL(SEIB_GYULSANBF_IIB2,0))) AS ILGYE_SEIB_GYULSANBF_IIB
                ,TO_CHAR(SUM(NVL(SECHUL_GYULSANBF_IWOL2,0))) AS ILGYE_SECHUL_GYULSANBF_IWOL
                ,TO_CHAR(SUM(NVL(DEP2,0)) + SUM(NVL(IWOL_GONGGEUM_DEP2,0))) AS ILGYE_DEP
               ,TO_CHAR(SUM(NVL(MMDA2,0)) + SUM(NVL(IWOL_MMDA2,0))) AS ILGYE_MMDA
               ,TO_CHAR(SUM(NVL(SUNP_AMT2,0)) - SUM(NVL(SEIB_SUIP2,0)) + SUM(NVL(IWOL_MIJUNGSAN2,0))) AS ILGYE_MIICHE
FROM
(

 WITH AC_LIST AS (
  SELECT     
    T2.SIGUMGO_ORG_C
    ,T3.SIGUMGO_HOIKYE_C AS RPT_HOIKYE_C
    ,T2.GONGGEUM_GYEJWA
    ,T2.GONGGEUM_GYEJWA_NM
    ,T2.SIGUMGO_HOIKYE_YR
  FROM
    (
  SELECT
    T1.SIGUMGO_ORG_C
    ,T1.ICH_SIGUMGO_GUN_GU_C
    ,T1.ICH_SIGUMGO_HOIKYE_C
    ,T1.SIGUMGO_AC_B
    ,T1.SIGUMGO_AC_SER
    ,T1.SIGUMGO_HOIKYE_YR
    ,LPAD(T1.SIGUMGO_ORG_C, 3, 0)||LPAD(T1.ICH_SIGUMGO_GUN_GU_C, 3, 0)||LPAD(T1.ICH_SIGUMGO_HOIKYE_C, 2, 0)||RPAD(T1.SIGUMGO_AC_B, 2, 0)||LPAD(T1.SIGUMGO_AC_SER, 5, '0')||SUBSTR(T1.SIGUMGO_HOIKYE_YR, 3, 2) AS  GONGGEUM_GYEJWA    
    ,T1.LINKAC_KWA_C ||'000'|| T1.LINK_ACSER AS GONGGEUM_YUDONG_ACNO
    ,T1.SIGUMGO_AC_NM AS GONGGEUM_GYEJWA_NM
  FROM
    ACL_SIGUMGO_MAS T1
  WHERE 1=1
    AND T1.SIGUMGO_ORG_C = '110'
    AND T1.SIGUMGO_HOIKYE_YR IN ('2025', '9999')
    AND T1.MNG_NO = 1
    ) T2
    ,RPT_AC_BY_HOIKYE_MAPP T3
  WHERE 1=1
    AND T2.GONGGEUM_GYEJWA = T3.SIGUMGO_ACNO
    AND T2.SIGUMGO_HOIKYE_YR = T3.SIGUMGO_HOIKYE_YR
    AND T2.SIGUMGO_ORG_C = T3.SIGUMGO_C
 )
 SELECT
    HOIGYE_CODE,
    SIGUMGO_ORG_C,
           NVL(TAX_SUNP_IP_AMT,0) AS SEIB_SUIP,           
    NVL(TAX_BAEJUNG_IP_AMT,0) AS TAX_BAEJUNG_IP_AMT,    
    NVL(GWAON_PROC_JI_AMT,0) AS SEIB_BANNAB,                  
    NVL(TAX_IP_CRT_IP_AMT,0) AS SEIB_GYEONGJEONG_IB,       
    NVL(TAX_IP_CRT_JI_AMT,0) AS SEIB_GYEONGJEONG_JI,                  
    NVL(BIZPLC_BAEJUNG_JI_AMT,0)+NVL(GAM_BAEJUNG_JI_AMT,0) AS SECHUL_BAEJEONG,                 
    NVL(BIZPLC_GAM_BAEJUNG_IP_AMT,0) AS SECHUL_HWANSU,                
    NVL(TAXO_JI_AMT,0) AS SECHUL_JI,                       
    NVL(TAXO_RTRN_AMT,0) AS SECHUL_BANNAB,                    
    NVL(KWA_CRRC_IP_AMT,0) AS SECHUL_GYEONGJEONG_IB,                 
    NVL(KWA_CRRC_JI_AMT,0) AS SECHUL_GYEONGJEONG_JI,                 
    NVL(GA_IWOL_IP_AMT,0) AS SEIB_GYULSANBF_IIB,                   
    NVL(GA_IWOL_JI_AMT,0) AS SECHUL_GYULSANBF_IWOL,                  
    NVL(DEP_MK_JI_AMT,0) - NVL(DEP_HJI_AMT,0) AS DEP,                       
    NVL(MMDA,0) AS MMDA,                       
    NVL(SUNP_AMT,0) AS SUNP_AMT,           
    NVL(IWOL_GONGGEUM,0) AS IWOL_GONGGEUM,      
    NVL(IWOL_MIJUNGSAN,0) AS IWOL_MIJUNGSAN ,      
    NVL(IWOL_MMDA,0) AS IWOL_MMDA,         
     NVL(IWOL_GONGGEUM_DEP,0) AS IWOL_GONGGEUM_DEP,    
    0 AS SEIB_SUIP2,                
    0 AS TAX_BAEJUNG_IP_AMT2,           
    0 AS SEIB_BANNAB2,                        
    0 AS SEIB_GYEONGJEONG_IB2,             
    0 AS SEIB_GYEONGJEONG_JI2,                        
    0 AS SECHUL_BAEJEONG2,                        
    0 AS SECHUL_HWANSU2,                        
    0 AS SECHUL_JI2,                           
    0 AS SECHUL_BANNAB2,                         
    0 AS SECHUL_GYEONGJEONG_IB2,                       
    0 AS SECHUL_GYEONGJEONG_JI2,                       
    0 AS SEIB_GYULSANBF_IIB2,                        
    0 AS SECHUL_GYULSANBF_IWOL2,                       
    0 AS DEP2,                            
    0 AS MMDA2,                          
    0 AS SUNP_AMT2,              
    0 AS IWOL_GONGGEUM2,           
    0 AS IWOL_MIJUNGSAN2 ,            
    0 AS IWOL_MMDA2,             
     0 AS IWOL_GONGGEUM_DEP2          
 FROM
 (
  SELECT   
      RPT_HOIKYE_C AS HOIGYE_CODE
     ,A.SIGUMGO_ORG_C
     ,SUM(TAX_SUNP_IP_AMT) AS TAX_SUNP_IP_AMT
     ,SUM(SUIP_CHULNAP_BAEJUNG_AMT)
        +SUM(FUND_UNYONG_INT_AMT)
        +SUM(PMNY_DEP_INT_AMT)
        +SUM(BTDEP_INT_AMT)
        +SUM(JICULWO_BAEJUNG_IP_AMT) AS TAX_BAEJUNG_IP_AMT
     ,SUM(GWAON_PROC_JI_AMT) AS GWAON_PROC_JI_AMT
     ,SUM(TAX_IP_CRT_IP_AMT) AS TAX_IP_CRT_IP_AMT
     ,SUM(TAX_IP_CRT_JI_AMT) AS TAX_IP_CRT_JI_AMT
     ,SUM(BIZPLC_BAEJUNG_JI_AMT) AS BIZPLC_BAEJUNG_JI_AMT
     ,SUM(BIZPLC_GAM_BAEJUNG_IP_AMT) AS BIZPLC_GAM_BAEJUNG_IP_AMT
    ,SUM(TAXO_FUND_BAEJUNG_JI_AMT)
     +SUM(TAXO_HNDO_BAEJUNG_JI_AMT)
     +SUM(TAXO_FUND_GETBK_JI_AMT)
     +SUM(TAXO_HNDO_JICHUL_JI_AMT)
     +SUM(TAXO_HNDO_GETBK_JI_AMT)  AS TAXO_JI_AMT
    ,SUM(TAXO_RTRN_AMT) AS TAXO_RTRN_AMT
    ,SUM(KWA_CRRC_IP_AMT) AS KWA_CRRC_IP_AMT
    ,SUM(KWA_CRRC_JI_AMT) AS KWA_CRRC_JI_AMT
    ,SUM(GA_IWOL_IP_AMT) AS GA_IWOL_IP_AMT
    ,SUM(GA_IWOL_JI_AMT) AS GA_IWOL_JI_AMT
    ,SUM(DEP_MK_JI_AMT) AS DEP_MK_JI_AMT
    ,SUM(MR_FUND_AMT) AS MMDA
    ,SUM(DEP_HJI_AMT) AS DEP_HJI_AMT
    ,0 AS SUNP_AMT
    ,0 AS IWOL_GONGGEUM
    ,0 AS IWOL_MIJUNGSAN
    ,0 AS IWOL_MMDA
    ,0 AS IWOL_GONGGEUM_DEP
    ,SUM(GAM_BAEJUNG_JI_AMT) GAM_BAEJUNG_JI_AMT
  FROM RPT_TXIO_DDAC_TAB A, AC_LIST B
  WHERE  A.SGG_ACNO(+) = B.GONGGEUM_GYEJWA 
       AND CASE WHEN A.SIGUMGO_HOIKYE_YR(+) = 9999 THEN TO_NUMBER(SUBSTR(A.BAS_DT(+),1,4))
                   ELSE TO_NUMBER(A.SIGUMGO_HOIKYE_YR(+)) END  = '2025'
  AND A.BAS_DT(+) BETWEEN SUBSTR('20250101',0,4)||'0101' AND '20250827'
  AND A.SIGUMGO_ORG_C(+)  = '110'  
  AND A.ICH_SIGUMGO_GUN_GU_C = 0
  GROUP BY RPT_HOIKYE_C, A.SIGUMGO_ORG_C

  UNION ALL
  -- 25.08.11 11-11, 11-12, 11-13 금액을 수입액에 잡아줌

  SELECT   
    RPT_HOIKYE_C AS HOIGYE_CODE
    , A.SIGUMGO_ORG_C
    , 0 AS TAX_SUNP_IP_AMT
    , 0 AS TAX_BAEJUNG_IP_AMT
    , 0 AS GWAON_PROC_JI_AMT
    , 0 AS TAX_IP_CRT_IP_AMT
    , 0 AS TAX_IP_CRT_JI_AMT
    , 0 AS BIZPLC_BAEJUNG_JI_AMT
    , 0 AS BIZPLC_GAM_BAEJUNG_IP_AMT
    , 0 AS TAXO_JI_AMT
    , 0 AS TAXO_RTRN_AMT
    , 0 AS KWA_CRRC_IP_AMT
    , 0 AS KWA_CRRC_JI_AMT
    , 0 AS GA_IWOL_IP_AMT
    , 0 AS GA_IWOL_JI_AMT
    , 0 AS DEP_MK_JI_AMT
    , 0 AS MMDA
    , 0 AS DEP_HJI_AMT
    , SUM(DECODE(CRT_CAN_G, 1 ,-1, 2, -1, 33, -1, 1) * DECODE(IPJI_G, 2, -1, 1) * TRAMT) AS SUNP_AMT
    , 0 AS IWOL_GONGGEUM
    , 0 AS IWOL_MIJUNGSAN
    , 0 AS IWOL_MMDA
    , 0 AS IWOL_GONGGEUM_DEP
    , 0 AS GAM_BAEJUNG_JI_AMT
  FROM ACL_SIGUMGO_SLV A, AC_LIST B
  WHERE  A.FIL_100_CTNT5(+) = B.GONGGEUM_GYEJWA 
       AND CASE WHEN A.SIGUMGO_HOIKYE_YR(+) = 9999 THEN TO_NUMBER(SUBSTR(A.GJDT(+),1,4))
                   ELSE TO_NUMBER(A.SIGUMGO_HOIKYE_YR(+)) END  = '2025'
  AND A.GJDT(+) BETWEEN SUBSTR('20250101',0,4)||'0101' AND '20250827'
  AND A.SIGUMGO_ORG_C(+)  = '110'  
  AND A.ICH_SIGUMGO_GUN_GU_C = 0
  AND A.SIGUMGO_TRX_G = 11
  AND A.SIGUMGO_IP_TRX_G IN (11, 12, 13)
  GROUP BY RPT_HOIKYE_C, A.SIGUMGO_ORG_C

  UNION ALL
  SELECT  TO_CHAR(ICH_SIGUMGO_HOIKYE_C) HOIGYE_CODE
    ,A.SIGUMGO_ORG_C
    ,0 AS TAX_SUNP_IP_AMT
    ,0 AS TAX_BAEJUNG_IP_AMT
    ,0 AS GWAON_PROC_JI_AMT
    ,0 AS TAX_IP_CRT_IP_AMT
    ,0 AS TAX_IP_CRT_JI_AMT
    ,0 AS BIZPLC_BAEJUNG_JI_AMT
    ,0 AS BIZPLC_GAM_BAEJUNG_IP_AMT
    ,0 AS TAXO_JI_AMT
    ,0 AS TAXO_RTRN_AMT
    ,0 AS KWA_CRRC_IP_AMT
    ,0 AS KWA_CRRC_JI_AMT
    ,0 AS GA_IWOL_IP_AMT
    ,0 AS GA_IWOL_JI_AMT
    ,0 AS DEP_MK_JI_AMT
    ,0 AS MR_FUND_AMT
    ,0 AS DEP_HJI_AMT
    ,SUM(JIBANGSE_AMT)  AS SUNP_AMT
    ,0 AS IWOL_GONGGEUM
    ,0 AS IWOL_MIJUNGSAN
    ,0 AS IWOL_MMDA
    ,0 AS IWOL_GONGGEUM_DEP
    ,0 GAM_BAEJUNG_JI_AMT
   FROM   RPT_TXI_DDAC_TAB A
   WHERE  A.SIGUMGO_HOIKYE_YR = ( '2025' ) 
     AND A.SIGUMGO_ORG_C = '110'
     AND A.SUNAP_DT BETWEEN SUBSTR('20250101',0,4)||'0101' AND '20250827'
     AND A.ICH_SIGUMGO_GUN_GU_C = 0    
     GROUP BY ICH_SIGUMGO_HOIKYE_C, A.SIGUMGO_ORG_C
  UNION ALL
  SELECT  TO_CHAR(HOIGYE_CODE) HOIGYE_CODE
    ,GEUMGO_CODE
    ,0 AS TAX_SUNP_IP_AMT
    ,0 AS TAX_BAEJUNG_IP_AMT
    ,0 AS GWAON_PROC_JI_AMT
    ,0 AS TAX_IP_CRT_IP_AMT
    ,0 AS TAX_IP_CRT_JI_AMT
    ,0 AS BIZPLC_BAEJUNG_JI_AMT
    ,0 AS BIZPLC_GAM_BAEJUNG_IP_AMT
    ,0 AS TAXO_JI_AMT
    ,0 AS TAXO_RTRN_AMT
    ,0 AS KWA_CRRC_IP_AMT
    ,0 AS KWA_CRRC_JI_AMT
    ,0 AS GA_IWOL_IP_AMT
    ,0 AS GA_IWOL_JI_AMT
    ,0 AS DEP_MK_JI_AMT
    ,0 AS MR_FUND_AMT
    ,0 AS DEP_HJI_AMT
    ,0 AS SUNP_AMT
    ,SUM(CASE WHEN GUBUN_CODE = 1 THEN AMT1 ELSE 0 END) AS IWOL_GONGGEUM
    ,SUM(CASE WHEN GUBUN_CODE = 5 THEN AMT1 ELSE 0 END) AS IWOL_MIJUNGSAN
    ,SUM(CASE WHEN GUBUN_CODE = 4 THEN AMT1 ELSE 0 END) AS IWOL_MMDA
    ,SUM(CASE WHEN GUBUN_CODE = 2 THEN AMT1 ELSE 0 END) AS IWOL_GONGGEUM_DEP
    ,0 GAM_BAEJUNG_JI_AMT
   FROM   RPT_HOIGYE_IWOL A
   WHERE  A.HOIGYE_YEAR = ( '2025' - 1 )
     AND A.GEUMGO_CODE = '110'
     AND A.GUBUN_CODE IN (1, 2, 4, 5)
     AND A.KIJUNIL BETWEEN SUBSTR('20250101',0,4)||'0101' AND '20250827'
     AND A.GUNGU_CODE = 0
     GROUP BY HOIGYE_CODE, GEUMGO_CODE
 ) 
 UNION ALL
 SELECT   
    HOIGYE_CODE,
    SIGUMGO_ORG_C,
           0 AS SEIB_SUIP,                
    0 AS TAX_BAEJUNG_IP_AMT,           
    0 AS SEIB_BANNAB,                        
    0 AS SEIB_GYEONGJEONG_IB,             
    0 AS SEIB_GYEONGJEONG_JI,                        
    0 AS SECHUL_BAEJEONG,                        
    0 AS SECHUL_HWANSU,                        
    0 AS SECHUL_JI,                           
    0 AS SECHUL_BANNAB,                         
    0 AS SECHUL_GYEONGJEONG_IB,                       
    0 AS SECHUL_GYEONGJEONG_JI,                       
    0 AS SEIB_GYULSANBF_IIB,                         
    0 AS SECHUL_GYULSANBF_IWOL,                       
    0 AS DEP,                            
    0 AS MMDA,                          
    0 AS SUNP_AMT,               
    0 AS IWOL_GONGGEUM,            
    0 AS IWOL_MIJUNGSAN ,            
    0 AS IWOL_MMDA,             
     0 AS IWOL_GONGGEUM_DEP,           
           NVL(TAX_SUNP_IP_AMT,0) AS SEIB_SUIP2,          
    NVL(TAX_BAEJUNG_IP_AMT,0) AS TAX_BAEJUNG_IP_AMT2,    
    NVL(GWAON_PROC_JI_AMT,0) AS SEIB_BANNAB2,                 
    NVL(TAX_IP_CRT_IP_AMT,0) AS SEIB_GYEONGJEONG_IB2,       
    NVL(TAX_IP_CRT_JI_AMT,0) AS SEIB_GYEONGJEONG_JI2,                  
    NVL(BIZPLC_BAEJUNG_JI_AMT,0) AS SECHUL_BAEJEONG2,                
    NVL(BIZPLC_GAM_BAEJUNG_IP_AMT,0) AS SECHUL_HWANSU2,                
    NVL(TAXO_JI_AMT,0) AS SECHUL_JI2,                      
    NVL(TAXO_RTRN_AMT,0) AS SECHUL_BANNAB2,                    
    NVL(KWA_CRRC_IP_AMT,0) AS SECHUL_GYEONGJEONG_IB2,                 
    NVL(KWA_CRRC_JI_AMT,0) AS SECHUL_GYEONGJEONG_JI2,                 
    NVL(GA_IWOL_IP_AMT,0) AS SEIB_GYULSANBF_IIB2,                   
    NVL(GA_IWOL_JI_AMT,0) AS SECHUL_GYULSANBF_IWOL2,                  
    NVL(DEP_MK_JI_AMT,0) - NVL(DEP_HJI_AMT,0) AS DEP2,                       
    NVL(MMDA,0) AS MMDA2,                       
    NVL(SUNP_AMT,0) AS SUNP_AMT2,          
    NVL(IWOL_GONGGEUM,0) AS IWOL_GONGGEUM2,      
    NVL(IWOL_MIJUNGSAN,0) AS IWOL_MIJUNGSAN2,      
    NVL(IWOL_MMDA,0) AS IWOL_MMDA2,         
    NVL(IWOL_GONGGEUM_DEP,0) AS IWOL_GONGGEUM_DEP2
     
 FROM
 (
  SELECT   
      RPT_HOIKYE_C AS HOIGYE_CODE
     ,A.SIGUMGO_ORG_C
     ,SUM(TAX_SUNP_IP_AMT) AS TAX_SUNP_IP_AMT
     ,SUM(SUIP_CHULNAP_BAEJUNG_AMT)
        +SUM(FUND_UNYONG_INT_AMT)
        +SUM(PMNY_DEP_INT_AMT)
        +SUM(BTDEP_INT_AMT)
        +SUM(JICULWO_BAEJUNG_IP_AMT) AS TAX_BAEJUNG_IP_AMT
     ,SUM(GWAON_PROC_JI_AMT) AS GWAON_PROC_JI_AMT
     ,SUM(TAX_IP_CRT_IP_AMT) AS TAX_IP_CRT_IP_AMT
     ,SUM(TAX_IP_CRT_JI_AMT) AS TAX_IP_CRT_JI_AMT
     ,SUM(BIZPLC_BAEJUNG_JI_AMT) AS BIZPLC_BAEJUNG_JI_AMT
     ,SUM(BIZPLC_GAM_BAEJUNG_IP_AMT) AS BIZPLC_GAM_BAEJUNG_IP_AMT
    ,SUM(TAXO_FUND_BAEJUNG_JI_AMT)
     +SUM(TAXO_HNDO_BAEJUNG_JI_AMT)
     +SUM(TAXO_FUND_GETBK_JI_AMT)
     +SUM(TAXO_HNDO_JICHUL_JI_AMT)
     +SUM(TAXO_HNDO_GETBK_JI_AMT)  AS TAXO_JI_AMT
    ,SUM(TAXO_RTRN_AMT) AS TAXO_RTRN_AMT
    ,SUM(KWA_CRRC_IP_AMT) AS KWA_CRRC_IP_AMT
    ,SUM(KWA_CRRC_JI_AMT) AS KWA_CRRC_JI_AMT
    ,SUM(GA_IWOL_IP_AMT) AS GA_IWOL_IP_AMT
    ,SUM(GA_IWOL_JI_AMT) AS GA_IWOL_JI_AMT
    ,SUM(DEP_MK_JI_AMT) AS DEP_MK_JI_AMT
    ,SUM(MR_FUND_AMT) AS MMDA
    ,SUM(DEP_HJI_AMT) AS DEP_HJI_AMT
    ,0 AS SUNP_AMT
    ,0 AS IWOL_GONGGEUM
    ,0 AS IWOL_MIJUNGSAN
    ,0 AS IWOL_MMDA
    ,0 AS IWOL_GONGGEUM_DEP
    ,SUM(GAM_BAEJUNG_JI_AMT) GAM_BAEJUNG_JI_AMT
  FROM RPT_TXIO_DDAC_TAB A, AC_LIST B
  WHERE  A.SGG_ACNO(+) = B.GONGGEUM_GYEJWA
       AND CASE WHEN A.SIGUMGO_HOIKYE_YR(+) = 9999 THEN TO_NUMBER(SUBSTR(A.BAS_DT(+),1,4))
                   ELSE TO_NUMBER(A.SIGUMGO_HOIKYE_YR(+)) END  = '2025'
  AND A.BAS_DT(+) BETWEEN '20250827' AND '20250827'
  AND A.SIGUMGO_ORG_C(+) = '110'
  AND A.ICH_SIGUMGO_GUN_GU_C = 0
  GROUP BY RPT_HOIKYE_C, A.SIGUMGO_ORG_C

  UNION ALL
  -- 25.08.11 11-11, 11-12, 11-13 금액을 수입액에 잡아줌

  SELECT   
    RPT_HOIKYE_C AS HOIGYE_CODE
    , A.SIGUMGO_ORG_C
    , 0 AS TAX_SUNP_IP_AMT
    , 0 AS TAX_BAEJUNG_IP_AMT
    , 0 AS GWAON_PROC_JI_AMT
    , 0 AS TAX_IP_CRT_IP_AMT
    , 0 AS TAX_IP_CRT_JI_AMT
    , 0 AS BIZPLC_BAEJUNG_JI_AMT
    , 0 AS BIZPLC_GAM_BAEJUNG_IP_AMT
    , 0 AS TAXO_JI_AMT
    , 0 AS TAXO_RTRN_AMT
    , 0 AS KWA_CRRC_IP_AMT
    , 0 AS KWA_CRRC_JI_AMT
    , 0 AS GA_IWOL_IP_AMT
    , 0 AS GA_IWOL_JI_AMT
    , 0 AS DEP_MK_JI_AMT
    , 0 AS MMDA
    , 0 AS DEP_HJI_AMT
    , SUM(DECODE(CRT_CAN_G, 1 ,-1, 2, -1, 33, -1, 1) * DECODE(IPJI_G, 2, -1, 1) * TRAMT) AS SUNP_AMT
    , 0 AS IWOL_GONGGEUM
    , 0 AS IWOL_MIJUNGSAN
    , 0 AS IWOL_MMDA
    , 0 AS IWOL_GONGGEUM_DEP
    , 0 AS GAM_BAEJUNG_JI_AMT
  FROM ACL_SIGUMGO_SLV A, AC_LIST B
  WHERE  A.FIL_100_CTNT5(+) = B.GONGGEUM_GYEJWA 
       AND CASE WHEN A.SIGUMGO_HOIKYE_YR(+) = 9999 THEN TO_NUMBER(SUBSTR(A.GJDT(+),1,4))
                   ELSE TO_NUMBER(A.SIGUMGO_HOIKYE_YR(+)) END  = '2025'
  AND A.GJDT(+) BETWEEN '20250827' AND '20250827'
  AND A.SIGUMGO_ORG_C(+)  = '110'  
  AND A.ICH_SIGUMGO_GUN_GU_C = 0
  AND A.SIGUMGO_TRX_G = 11
  AND A.SIGUMGO_IP_TRX_G IN (11, 12, 13)
  GROUP BY RPT_HOIKYE_C, A.SIGUMGO_ORG_C

  UNION ALL
  SELECT  TO_CHAR(ICH_SIGUMGO_HOIKYE_C) HOIGYE_CODE
    ,A.SIGUMGO_ORG_C
    ,0 AS TAX_SUNP_IP_AMT
    ,0 AS TAX_BAEJUNG_IP_AMT
    ,0 AS GWAON_PROC_JI_AMT
    ,0 AS TAX_IP_CRT_IP_AMT
    ,0 AS TAX_IP_CRT_JI_AMT
    ,0 AS BIZPLC_BAEJUNG_JI_AMT
    ,0 AS BIZPLC_GAM_BAEJUNG_IP_AMT
    ,0 AS TAXO_JI_AMT
    ,0 AS TAXO_RTRN_AMT
    ,0 AS KWA_CRRC_IP_AMT
    ,0 AS KWA_CRRC_JI_AMT
    ,0 AS GA_IWOL_IP_AMT
    ,0 AS GA_IWOL_JI_AMT
    ,0 AS DEP_MK_JI_AMT
    ,0 AS MR_FUND_AMT
    ,0 AS DEP_HJI_AMT
    ,SUM(JIBANGSE_AMT)  AS SUNP_AMT
    ,0 AS IWOL_GONGGEUM
    ,0 AS IWOL_MIJUNGSAN
    ,0 AS IWOL_MMDA
    ,0 AS IWOL_GONGGEUM_DEP
   , 0 GAM_BAEJUNG_JI_AMT
   FROM   RPT_TXI_DDAC_TAB A
   WHERE  A.SIGUMGO_HOIKYE_YR = ( '2025' ) 
     AND A.SIGUMGO_ORG_C = '110'
     AND A.SUNAP_DT BETWEEN '20250827' AND '20250827'
     AND A.ICH_SIGUMGO_GUN_GU_C = 0
     GROUP BY ICH_SIGUMGO_HOIKYE_C, A.SIGUMGO_ORG_C
  UNION ALL 
  SELECT  TO_CHAR(HOIGYE_CODE) HOIGYE_CODE
    ,A.GEUMGO_CODE
    ,0 AS TAX_SUNP_IP_AMT
    ,0 AS TAX_BAEJUNG_IP_AMT
    ,0 AS GWAON_PROC_JI_AMT
    ,0 AS TAX_IP_CRT_IP_AMT
    ,0 AS TAX_IP_CRT_JI_AMT
    ,0 AS BIZPLC_BAEJUNG_JI_AMT
    ,0 AS BIZPLC_GAM_BAEJUNG_IP_AMT
    ,0 AS TAXO_JI_AMT
    ,0 AS TAXO_RTRN_AMT
    ,0 AS KWA_CRRC_IP_AMT
    ,0 AS KWA_CRRC_JI_AMT
    ,0 AS GA_IWOL_IP_AMT
    ,0 AS GA_IWOL_JI_AMT
    ,0 AS DEP_MK_JI_AMT
    ,0 AS MR_FUND_AMT
    ,0 AS DEP_HJI_AMT
    ,0 AS SUNP_AMT
    ,SUM(CASE WHEN GUBUN_CODE = 1 THEN AMT1 ELSE 0 END) AS IWOL_GONGGEUM
    ,SUM(CASE WHEN GUBUN_CODE = 5 THEN AMT1 ELSE 0 END) AS IWOL_MIJUNGSAN
    ,SUM(CASE WHEN GUBUN_CODE = 4 THEN AMT1 ELSE 0 END) AS IWOL_MMDA
    ,SUM(CASE WHEN GUBUN_CODE = 2 THEN AMT1 ELSE 0 END) AS IWOL_GONGGEUM_DEP
   ,0 GAM_BAEJUNG_JI_AMT
    FROM   RPT_HOIGYE_IWOL A
   WHERE  A.HOIGYE_YEAR = ( '2025' - 1 ) 
     AND A.GEUMGO_CODE = '110'
     AND A.GUBUN_CODE IN (1, 2, 4, 5)
     AND A.KIJUNIL BETWEEN '20250827' AND '20250827'
     AND A.GUNGU_CODE = 0
     GROUP BY HOIGYE_CODE, A.GEUMGO_CODE
 )
) AA, RPT_HOIKYE_CD BB
WHERE AA.SIGUMGO_ORG_C(+) = BB.SIGUMGO_C
AND AA.HOIGYE_CODE(+) = BB.SIGUMGO_HOIKYE_C
  AND BB.SIGUMGO_HOIKYE_C IN ( 
    
   SELECT T2.SIGUMGO_HOIKYE_C
   FROM
   RPT_HOIKYE_GRP_INFO T1
     ,RPT_HOIKYE_GRP_HOIKYE_CD T2
    WHERE 1=1
   AND T1.SIGUMGO_C = T2.SIGUMGO_C
   AND T1.HOIKYE_GRP_ID = T2.HOIKYE_GRP_ID
   AND T1.SIGUMGO_C = '110'
   AND  T1.HOIKYE_GRP_ID = '1004'
     
         )
   
AND BB.SIGUMGO_C = '110'
AND BB.USE_YN = 'Y'
GROUP BY BB.SIGUMGO_HOIKYE_C, BB.HOIKYE_NM
ORDER BY TO_NUMBER(BB.SIGUMGO_HOIKYE_C), BB.HOIKYE_NM



------------------------------------- 


NUGYE_SEIB_SUIP

TO_CHAR((SUM(NVL(SUNP_AMT,0)) + SUM(NVL(TAX_BAEJUNG_IP_AMT,0)) + SUM(NVL(IWOL_GONGGEUM,0)))) 

     ,SUM(TAX_SUNP_IP_AMT) AS TAX_SUNP_IP_AMT
     ,SUM(SUIP_CHULNAP_BAEJUNG_AMT)
        +SUM(FUND_UNYONG_INT_AMT)
        +SUM(PMNY_DEP_INT_AMT)
        +SUM(BTDEP_INT_AMT)
        +SUM(JICULWO_BAEJUNG_IP_AMT) AS TAX_BAEJUNG_IP_AMT

NUGYE_SEIB_BANNAB

SEIB_BANNAB

NUGYE_SEIB_GYEONGJEONG_IB - NUGYE_SEIB_GYEONGJEONG_JI

SEIB_GYEONGJEONG_IB - SEIB_GYEONGJEONG_JI


           NVL(TAX_SUNP_IP_AMT,0) AS SEIB_SUIP,           
    NVL(TAX_BAEJUNG_IP_AMT,0) AS TAX_BAEJUNG_IP_AMT,    
    NVL(GWAON_PROC_JI_AMT,0) AS SEIB_BANNAB,                  
    NVL(TAX_IP_CRT_IP_AMT,0) AS SEIB_GYEONGJEONG_IB,       
    NVL(TAX_IP_CRT_JI_AMT,0) AS SEIB_GYEONGJEONG_JI, 

    TAX_SUNP_IP_AMT

    TAX_BAEJUNG_IP_AMT
     ,SUM(SUIP_CHULNAP_BAEJUNG_AMT)
        +SUM(FUND_UNYONG_INT_AMT)
        +SUM(PMNY_DEP_INT_AMT)
        +SUM(BTDEP_INT_AMT)
        +SUM(JICULWO_BAEJUNG_IP_AMT) 

    GWAON_PROC_JI_AMT

    TAX_IP_CRT_IP_AMT

    TAX_IP_CRT_JI_AMT

---------------------------------------    



WITH AC_LIST AS (
  SELECT     
    T2.SIGUMGO_ORG_C
    ,T3.SIGUMGO_HOIKYE_C AS RPT_HOIKYE_C
    ,T2.GONGGEUM_GYEJWA
    ,T2.GONGGEUM_GYEJWA_NM
    ,T2.SIGUMGO_HOIKYE_YR
  FROM
    (
  SELECT
    T1.SIGUMGO_ORG_C
    ,T1.ICH_SIGUMGO_GUN_GU_C
    ,T1.ICH_SIGUMGO_HOIKYE_C
    ,T1.SIGUMGO_AC_B
    ,T1.SIGUMGO_AC_SER
    ,T1.SIGUMGO_HOIKYE_YR
    ,LPAD(T1.SIGUMGO_ORG_C, 3, 0)||LPAD(T1.ICH_SIGUMGO_GUN_GU_C, 3, 0)||LPAD(T1.ICH_SIGUMGO_HOIKYE_C, 2, 0)||RPAD(T1.SIGUMGO_AC_B, 2, 0)||LPAD(T1.SIGUMGO_AC_SER, 5, '0')||SUBSTR(T1.SIGUMGO_HOIKYE_YR, 3, 2) AS  GONGGEUM_GYEJWA    
    ,T1.LINKAC_KWA_C ||'000'|| T1.LINK_ACSER AS GONGGEUM_YUDONG_ACNO
    ,T1.SIGUMGO_AC_NM AS GONGGEUM_GYEJWA_NM
  FROM
    ACL_SIGUMGO_MAS T1
  WHERE 1=1
    AND T1.SIGUMGO_ORG_C = '110'
    AND T1.SIGUMGO_HOIKYE_YR IN ('2025', '9999')
    AND T1.MNG_NO = 1
    ) T2
    ,RPT_AC_BY_HOIKYE_MAPP T3
  WHERE 1=1
    AND T2.GONGGEUM_GYEJWA = T3.SIGUMGO_ACNO
    AND T2.SIGUMGO_HOIKYE_YR = T3.SIGUMGO_HOIKYE_YR
    AND T2.SIGUMGO_ORG_C = T3.SIGUMGO_C
 )
SELECT   
      RPT_HOIKYE_C AS HOIGYE_CODE
     ,A.SIGUMGO_ORG_C
     ,SUM(TAX_SUNP_IP_AMT) AS TAX_SUNP_IP_AMT
     ,SUM(SUIP_CHULNAP_BAEJUNG_AMT)
        +SUM(FUND_UNYONG_INT_AMT)
        +SUM(PMNY_DEP_INT_AMT)
        +SUM(BTDEP_INT_AMT)
        +SUM(JICULWO_BAEJUNG_IP_AMT) AS TAX_BAEJUNG_IP_AMT
     ,SUM(GWAON_PROC_JI_AMT) AS GWAON_PROC_JI_AMT
     ,SUM(TAX_IP_CRT_IP_AMT) AS TAX_IP_CRT_IP_AMT
     ,SUM(TAX_IP_CRT_JI_AMT) AS TAX_IP_CRT_JI_AMT
     ,SUM(BIZPLC_BAEJUNG_JI_AMT) AS BIZPLC_BAEJUNG_JI_AMT
     ,SUM(BIZPLC_GAM_BAEJUNG_IP_AMT) AS BIZPLC_GAM_BAEJUNG_IP_AMT
    ,SUM(TAXO_FUND_BAEJUNG_JI_AMT)
     +SUM(TAXO_HNDO_BAEJUNG_JI_AMT)
     +SUM(TAXO_FUND_GETBK_JI_AMT)
     +SUM(TAXO_HNDO_JICHUL_JI_AMT)
     +SUM(TAXO_HNDO_GETBK_JI_AMT)  AS TAXO_JI_AMT
    ,SUM(TAXO_RTRN_AMT) AS TAXO_RTRN_AMT
    ,SUM(KWA_CRRC_IP_AMT) AS KWA_CRRC_IP_AMT
    ,SUM(KWA_CRRC_JI_AMT) AS KWA_CRRC_JI_AMT
    ,SUM(GA_IWOL_IP_AMT) AS GA_IWOL_IP_AMT
    ,SUM(GA_IWOL_JI_AMT) AS GA_IWOL_JI_AMT
    ,SUM(DEP_MK_JI_AMT) AS DEP_MK_JI_AMT
    ,SUM(MR_FUND_AMT) AS MMDA
    ,SUM(DEP_HJI_AMT) AS DEP_HJI_AMT
    ,0 AS SUNP_AMT
    ,0 AS IWOL_GONGGEUM
    ,0 AS IWOL_MIJUNGSAN
    ,0 AS IWOL_MMDA
    ,0 AS IWOL_GONGGEUM_DEP
    ,SUM(GAM_BAEJUNG_JI_AMT) GAM_BAEJUNG_JI_AMT
  FROM RPT_TXIO_DDAC_TAB A, AC_LIST B
  WHERE  A.SGG_ACNO(+) = B.GONGGEUM_GYEJWA 
       AND CASE WHEN A.SIGUMGO_HOIKYE_YR(+) = 9999 THEN TO_NUMBER(SUBSTR(A.BAS_DT(+),1,4))
                   ELSE TO_NUMBER(A.SIGUMGO_HOIKYE_YR(+)) END  = '2025'
  AND A.BAS_DT(+) BETWEEN SUBSTR('20250101',0,4)||'0101' AND '20250827'
  AND A.SIGUMGO_ORG_C(+)  = '110'  
  AND A.ICH_SIGUMGO_GUN_GU_C = 0
  GROUP BY RPT_HOIKYE_C, A.SIGUMGO_ORG_C
  ORDER BY RPT_HOIKYE_C, A.SIGUMGO_ORG_C