---- 세출월계표(한도분기보)--------------------------------------------------------------------------------------------
-- 변경전
 SELECT LIST.RN
        , LIST.GONGGEUM_GYEJWA_NM
        , LIST.GUNGU_NAME
        , LIST.DANGWOL_BAEJUNG
        , LIST.BAEJUNG_NUGYE
        , LIST.JUNWOL_JICHUL
        , LIST.DANGWOL_JICHUL
        , LIST.MIJIGEUB
        , LIST.DANGWOL_YUIP
        , LIST.DANGWOL_GYULJUNG
        , LIST.JICHUL_NUGYE
        , LIST.JANAC
        , LIST.GONGGEUM_GYEJWA
    FROM ( 
        SELECT ORG.*
         FROM (
                SELECT  ROW_NUMBER() OVER (ORDER BY A.GONGGEUM_GYEJWA_NM, A.GUNGU_NAME )  RN
                        ,A.GONGGEUM_GYEJWA_NM                                                                            
                        ,'(' || A.GUNGU_CODE || ')' ||  A.GUNGU_NAME AS GUNGU_NAME                                         
                        ,SUM(A.DANGWOL_BAEJUNG) AS DANGWOL_BAEJUNG                                                                
                        ,SUM(A.BAEJUNG_NUGYE) AS BAEJUNG_NUGYE                                                                  
                        ,SUM(A.JUNWOL_JICHUL) AS JUNWOL_JICHUL                                                                  
                        ,SUM(A.DANGWOL_JICHUL) AS DANGWOL_JICHUL                                                                 
                        ,0 AS MIJIGEUB                                                                                     
                        ,SUM(A.DANGWOL_YUIP) AS DANGWOL_YUIP                                                                   
                        ,SUM(A.DANGWOL_GYULJUNG) AS DANGWOL_GYULJUNG                                                               
                        ,SUM(A.JUNWOL_JICHUL + A.DANGWOL_JICHUL - A.DANGWOL_YUIP - A.DANGWOL_GYULJUNG) AS JICHUL_NUGYE                            
                        ,SUM(A.BAEJUNG_NUGYE - (A.JUNWOL_JICHUL + A.DANGWOL_JICHUL - A.DANGWOL_YUIP - A.DANGWOL_GYULJUNG)) AS JANAC  
                        ,A.GONGGEUM_GYEJWA
                FROM
                (

                
                SELECT   HOIGYE_CODE, GONGGEUM_GYEJWA, GONGGEUM_GYEJWA_NM, GUNGU_CODE, GUNGU_NAME, HOIGYE_YEAR,
                                YEAR_GUBUN,
                                CASE 
                                    WHEN ILJA >= '20251201'  AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 90 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20251201'  AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 90 THEN IPGEUM_AMT*-1
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 91 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 45  THEN  IPGEUM_AMT*-1
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 90 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 42  THEN  IPGEUM_AMT*-1
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 40 THEN  IPGEUM_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 92  THEN  JIGEUB_AMT*-1
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 41 THEN  IPGEUM_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 95  THEN  JIGEUB_AMT*-1                                    
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 41 THEN  IPGEUM_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 95  THEN  JIGEUB_AMT*-1
                                    ELSE 0 END DANGWOL_BAEJUNG,
                               CASE 
                                        
                                    WHEN SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 90 THEN JIGEUB_AMT
                                    WHEN SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 90 THEN IPGEUM_AMT*-1                                        
                                    WHEN SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 91 THEN JIGEUB_AMT
                                    WHEN SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 45  THEN  IPGEUM_AMT*-1
                                    WHEN SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 90 THEN JIGEUB_AMT
                                    WHEN SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 42  THEN  IPGEUM_AMT*-1
                                    WHEN SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 40 THEN  IPGEUM_AMT
                                    WHEN SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 92  THEN  JIGEUB_AMT*-1
                                    WHEN SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 41 THEN  IPGEUM_AMT
                                    WHEN SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 95  THEN  JIGEUB_AMT*-1
                                    WHEN SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 41 THEN  IPGEUM_AMT
                                    WHEN SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 95  THEN  JIGEUB_AMT*-1
                                    ELSE 0 END BAEJUNG_NUGYE,
                                CASE 
                                    WHEN ILJA < '20251201' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 90 THEN JIGEUB_AMT
                                    WHEN ILJA < '20251201' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 90 THEN IPGEUM_AMT*-1
                                    WHEN ILJA < '20251201' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 91 THEN JIGEUB_AMT
                                    WHEN ILJA < '20251201' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 45 THEN IPGEUM_AMT*-1
                                    WHEN ILJA < '20251201' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 91 THEN JIGEUB_AMT
                                    WHEN ILJA < '20251201' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 91 THEN IPGEUM_AMT * -1
                                    WHEN ILJA < '20251201' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    WHEN ILJA < '20251201' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT * -1
                                    WHEN ILJA < '20251201' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 91 THEN JIGEUB_AMT
                                    WHEN ILJA < '20251201' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 91 THEN IPGEUM_AMT * -1
                                    WHEN ILJA < '20251201' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 91 THEN JIGEUB_AMT
                                    WHEN ILJA < '20251201' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 45 THEN IPGEUM_AMT*-1
                                    WHEN ILJA < '20251201' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 92 THEN JIGEUB_AMT
                                    WHEN ILJA < '20251201' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 92 THEN IPGEUM_AMT * -1
                                    WHEN ILJA < '20251201' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    WHEN ILJA < '20251201' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT * -1
                                    WHEN ILJA < '20251201' AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    WHEN ILJA < '20251201' AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT * -1
                                    ELSE 0 END JUNWOL_JICHUL,
                                CASE 
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 90 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 91 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 91 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 91 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 91 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 92 THEN JIGEUB_AMT            
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    ELSE 0 END DANGWOL_JICHUL,
                                CASE 
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 90 THEN IPGEUM_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 91 THEN IPGEUM_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 45  THEN  IPGEUM_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 91 THEN IPGEUM_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 45  THEN  IPGEUM_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 92 THEN IPGEUM_AMT                                                
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT
                                    ELSE 0 END DANGWOL_YUIP,
                                0 DANGWOL_GYULJUNG             
                        FROM (
                                SELECT  A.FIL_100_CTNT5 GONGGEUM_GYEJWA, B.SIGUMGO_AC_NM GONGGEUM_GYEJWA_NM,
                                A.ICH_SIGUMGO_HOIKYE_C HOIGYE_CODE, A.ICH_SIGUMGO_GUN_GU_C GUNGU_CODE,
                                                B.SIGUMGO_AGE_AC_G,
                                                B.SIGUMGO_AC_G,                                                
                                                C.GUNGU_NAME, A.SIGUMGO_HOIKYE_YR HOIGYE_YEAR, 
                                                A.NEW_GU_YR_G YEAR_GUBUN, A.SIGUMGO_TRX_G GEORAE_GUBUN, 
                                                A.SIGUMGO_IP_TRX_G IPGEUM_GEORAE, A.SIGUMGO_JI_TRX_G JIGEUB_GEORAE,
                                                A.GISDT ILJA,
                                                DECODE(CRT_CAN_G,1,-1,2,-1,33,-1,1) * DECODE(ipji_g,1,TRAMT,0) IPGEUM_AMT,
                                                DECODE(CRT_CAN_G,1,-1,2,-1,33,-1,1) * DECODE(ipji_g,2,TRAMT,0) JIGEUB_AMT                        
                                FROM ACL_SIGUMGO_SLV A, ACL_SIGUMGO_MAS B,
                                    (SELECT REF_D_C  AS GUNGU_CODE, REF_D_NM  AS GUNGU_NAME
                                    FROM RPT_CODE_INFO
                                    WHERE REF_L_C=500 AND REF_M_C=28 AND REF_S_C=1
                                    ) C
                                WHERE A.FIL_100_CTNT5 = B.FIL_100_CTNT2
                                  AND A.ICH_SIGUMGO_GUN_GU_C = C.GUNGU_CODE
                                  AND B.MNG_NO = 1
                                  AND B.SIGUMGO_ORG_C = '28'          
                                  AND A.GISDT BETWEEN '20250101'  AND '20251204'
                                  AND A.SIGUMGO_TRX_G IN (17, 67)
                                  AND (SUBSTR(A.FIL_100_CTNT5,4,3) <> '900' OR SUBSTR(A.FIL_100_CTNT5,7,2) <> '90')
                                  AND A.ICH_SIGUMGO_HOIKYE_C = B.ICH_SIGUMGO_HOIKYE_C
                                  AND A.SIGUMGO_HOIKYE_YR = '2025'
    
                                            AND A.ICH_SIGUMGO_HOIKYE_C = '1'
                                              
                                        AND A.FIL_100_CTNT5 = '02800001100000025'
                                    
                        UNION ALL
                            SELECT A.SIGUMGO_ACNO GONGGEUM_GYEJWA, B.SIGUMGO_AC_NM GONGGEUM_GYEJWA_NM
                                , A.ICH_SIGUMGO_HOIKYE_C HOIGYE_CODE, A.ICH_SIGUMGO_GUN_GU_C GUNGU_CODE,
                                B.SIGUMGO_AGE_AC_G,
                                B.SIGUMGO_AC_G,  
                                C.GUNGU_NAME, A.SIGUMGO_HOIKYE_YR HOIGYE_YEAR, 
                                0 YEAR_GUBUN, A.SIGUMGO_TRX_G GEORAE_GUBUN, 
                                0 IPGEUM_GEORAE, 0 JIGEUB_GEORAE,
                                        A.GISDT ILJA,
                                        DECODE(CRT_CAN_G,1,-1,2,-1,33,-1,1) * DECODE(ipji_g,1,TRAMT,0) IPGEUM_AMT,
                                        DECODE(CRT_CAN_G,1,-1,2,-1,33,-1,1) * DECODE(ipji_g,2,TRAMT,0) JIGEUB_AMT 
                                FROM ACL_SGGHANDO_SLV A, ACL_SIGUMGO_MAS B,
                                    (SELECT REF_D_C  AS GUNGU_CODE, REF_D_NM  AS GUNGU_NAME
                                    FROM RPT_CODE_INFO
                                    WHERE REF_L_C=500 AND REF_M_C=28 AND REF_S_C=1
                                    ) C
                                WHERE A.SIGUMGO_ACNO = B.FIL_100_CTNT2
                                AND A.ICH_SIGUMGO_GUN_GU_C = C.GUNGU_CODE
                                AND b.MNG_NO = 1
                                AND B.SIGUMGO_ORG_C = '28'               
                                AND A.GISDT BETWEEN '20250101'  AND '20251204'  
                                AND A.SIGUMGO_TRX_G IN (90,91,92,95,40,41,42,45)
                                AND (SUBSTR(A.SIGUMGO_ACNO,4,3) <> '900' OR SUBSTR(A.SIGUMGO_ACNO,7,2) <> '90')
                                AND A.ICH_SIGUMGO_HOIKYE_C = B.ICH_SIGUMGO_HOIKYE_C
                                AND A.SIGUMGO_HOIKYE_YR = '2025'          
    
                                            AND A.ICH_SIGUMGO_HOIKYE_C = '1'
                                              
                                        AND A.SIGUMGO_ACNO = '02800001100000025'
                                                      
                        UNION ALL

                        SELECT A.FIL_100_CTNT2 GONGGEUM_GYEJWA,
                               A.SIGUMGO_AC_NM GONGGEUM_GYEJWA_NM, 
                               ICH_SIGUMGO_HOIKYE_C GONGGEUM_HOIGYE_CODE,
                               A.ICH_SIGUMGO_GUN_GU_C GONGGEUM_GUNGU_CODE,
                               A.SIGUMGO_AGE_AC_G, 
                               A.SIGUMGO_AC_G, 
                               B.GUNGU_NAME,
                               TO_CHAR(A.SIGUMGO_HOIKYE_YR), 
                               0 YEAR_GUBUN, 
                               67 GEORAE_GUBUN, 
                               0 IPGEUM_GEORAE, 
                               0 JIGEUB_GEORAE,
                               '20251204'  AS ILJA,
                               0 IPGEUM_AMT,
                               0 JIGEUB_AMT
                          FROM ACL_SIGUMGO_MAS A,
                                (SELECT REF_D_C  AS GUNGU_CODE, REF_D_NM  AS GUNGU_NAME
                                    FROM RPT_CODE_INFO
                                    WHERE REF_L_C=500 AND REF_M_C=28 AND REF_S_C=1
                                ) B
                                WHERE A.ICH_SIGUMGO_GUN_GU_C = B.GUNGU_CODE
                           AND A.SIGUMGO_ORG_C = '28'
                           AND A.MNG_NO = 1    
                           AND A.SIGUMGO_HOIKYE_YR = '2025'
    
                                        AND A.ICH_SIGUMGO_HOIKYE_C = '1'
                                          
                                    AND A.FIL_100_CTNT2 = '02800001100000025'
                                       
                        
                        ) A
                ) A
                GROUP BY A.GONGGEUM_GYEJWA_NM, A.GUNGU_CODE, A.GUNGU_NAME, A.GONGGEUM_GYEJWA
                ORDER BY A.GONGGEUM_GYEJWA_NM, A.GUNGU_CODE, A.GUNGU_NAME, A.GONGGEUM_GYEJWA
        ) ORG
    WHERE ROWNUM  <=  '2000') LIST
WHERE LIST.RN  >  '0'


------------------------------------------------------------------------------------------------------------------------------------------------
-- 변경후

    SELECT LIST.RN
        , LIST.GONGGEUM_GYEJWA_NM
        , LIST.GUNGU_NAME
        , LIST.DANGWOL_BAEJUNG
        , LIST.BAEJUNG_NUGYE
        , LIST.JUNWOL_JICHUL
        , LIST.DANGWOL_JICHUL
        , LIST.MIJIGEUB
        , LIST.DANGWOL_YUIP
        , LIST.DANGWOL_GYULJUNG
        , LIST.JICHUL_NUGYE
        , LIST.JANAC
        , LIST.GONGGEUM_GYEJWA
    FROM ( 
        SELECT ORG.*
         FROM (
                SELECT  ROW_NUMBER() OVER (ORDER BY A.GONGGEUM_GYEJWA_NM, A.GUNGU_NAME )  RN
                        ,A.GONGGEUM_GYEJWA_NM                                                                            
                        ,'(' || A.GUNGU_CODE || ')' ||  A.GUNGU_NAME AS GUNGU_NAME                                         
                        ,SUM(A.DANGWOL_BAEJUNG) AS DANGWOL_BAEJUNG                                                                
                        ,SUM(A.BAEJUNG_NUGYE) AS BAEJUNG_NUGYE                                                                  
                        ,SUM(A.JUNWOL_JICHUL) AS JUNWOL_JICHUL                                                                  
                        ,SUM(A.DANGWOL_JICHUL) AS DANGWOL_JICHUL                                                                 
                        ,0 AS MIJIGEUB                                                                                     
                        ,SUM(A.DANGWOL_YUIP) AS DANGWOL_YUIP                                                                   
                        ,SUM(A.DANGWOL_GYULJUNG) AS DANGWOL_GYULJUNG                                                               
                        ,SUM(A.JUNWOL_JICHUL + A.DANGWOL_JICHUL - A.DANGWOL_YUIP - A.DANGWOL_GYULJUNG) AS JICHUL_NUGYE                            
                        ,SUM(A.BAEJUNG_NUGYE - (A.JUNWOL_JICHUL + A.DANGWOL_JICHUL - A.DANGWOL_YUIP - A.DANGWOL_GYULJUNG)) AS JANAC  
                        ,A.GONGGEUM_GYEJWA
                FROM
                (

                
                SELECT   HOIGYE_CODE, GONGGEUM_GYEJWA, GONGGEUM_GYEJWA_NM, GUNGU_CODE, GUNGU_NAME, HOIGYE_YEAR,
                                YEAR_GUBUN,
                                CASE 
                                    WHEN ILJA >= '20251201'  AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 90 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20251201'  AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 90 THEN IPGEUM_AMT*-1
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 91 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 45  THEN  IPGEUM_AMT*-1
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 90 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 42  THEN  IPGEUM_AMT*-1
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 40 THEN  IPGEUM_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 92  THEN  JIGEUB_AMT*-1
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 41 THEN  IPGEUM_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 95  THEN  JIGEUB_AMT*-1                                    
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 41 THEN  IPGEUM_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 95  THEN  JIGEUB_AMT*-1
                                    ELSE 0 END DANGWOL_BAEJUNG,
                               CASE 
                                        
                                    WHEN SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 90 THEN JIGEUB_AMT
                                    WHEN SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 90 THEN IPGEUM_AMT*-1                                        
                                    WHEN SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 91 THEN JIGEUB_AMT
                                    WHEN SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 45  THEN  IPGEUM_AMT*-1
                                    WHEN SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 90 THEN JIGEUB_AMT
                                    WHEN SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 42  THEN  IPGEUM_AMT*-1
                                    WHEN SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 40 THEN  IPGEUM_AMT
                                    WHEN SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 92  THEN  JIGEUB_AMT*-1
                                    WHEN SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 41 THEN  IPGEUM_AMT
                                    WHEN SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 95  THEN  JIGEUB_AMT*-1
                                    WHEN SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 41 THEN  IPGEUM_AMT
                                    WHEN SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 95  THEN  JIGEUB_AMT*-1
                                    ELSE 0 END BAEJUNG_NUGYE,
                                CASE 
                                    WHEN ILJA < '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 90 THEN JIGEUB_AMT
                                    WHEN ILJA < '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 90 THEN IPGEUM_AMT*-1
                                    WHEN ILJA < '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 91 THEN JIGEUB_AMT
                                    WHEN ILJA < '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 45 THEN IPGEUM_AMT*-1
                                    WHEN ILJA < '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 91 THEN JIGEUB_AMT
                                    WHEN ILJA < '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 91 THEN IPGEUM_AMT * -1
                                    WHEN ILJA < '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    WHEN ILJA < '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT * -1
                                    WHEN ILJA < '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 91 THEN JIGEUB_AMT
                                    WHEN ILJA < '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 91 THEN IPGEUM_AMT * -1
                                    WHEN ILJA < '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 91 THEN JIGEUB_AMT
                                    WHEN ILJA < '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 45 THEN IPGEUM_AMT*-1
                                    WHEN ILJA < '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 92 THEN JIGEUB_AMT
                                    WHEN ILJA < '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 92 THEN IPGEUM_AMT * -1
                                    WHEN ILJA < '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    WHEN ILJA < '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT * -1
                                    WHEN ILJA < '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    WHEN ILJA < '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT * -1
                                    ELSE 0 END JUNWOL_JICHUL,
                                CASE 
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 90 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 91 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 91 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 91 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 91 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 92 THEN JIGEUB_AMT            
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    ELSE 0 END DANGWOL_JICHUL,
                                CASE 
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 90 THEN IPGEUM_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 91 THEN IPGEUM_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 45  THEN  IPGEUM_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 91 THEN IPGEUM_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 45  THEN  IPGEUM_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 92 THEN IPGEUM_AMT                                                
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT
                                    WHEN ILJA >= '20251201' AND SIGUMGO_AC_G <> 0 AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT
                                    ELSE 0 END DANGWOL_YUIP,
                                0 DANGWOL_GYULJUNG             
                        FROM (
                                SELECT  A.FIL_100_CTNT5 GONGGEUM_GYEJWA, B.SIGUMGO_AC_NM GONGGEUM_GYEJWA_NM,
                                A.ICH_SIGUMGO_HOIKYE_C HOIGYE_CODE, A.ICH_SIGUMGO_GUN_GU_C GUNGU_CODE,
                                                B.SIGUMGO_AGE_AC_G,
                                                B.SIGUMGO_AC_G,                                                
                                                C.GUNGU_NAME, A.SIGUMGO_HOIKYE_YR HOIGYE_YEAR, 
                                                A.NEW_GU_YR_G YEAR_GUBUN, A.SIGUMGO_TRX_G GEORAE_GUBUN, 
                                                A.SIGUMGO_IP_TRX_G IPGEUM_GEORAE, A.SIGUMGO_JI_TRX_G JIGEUB_GEORAE,
                                                A.GISDT ILJA,
                                                DECODE(CRT_CAN_G,1,-1,2,-1,33,-1,1) * DECODE(ipji_g,1,TRAMT,0) IPGEUM_AMT,
                                                DECODE(CRT_CAN_G,1,-1,2,-1,33,-1,1) * DECODE(ipji_g,2,TRAMT,0) JIGEUB_AMT                        
                                FROM ACL_SIGUMGO_SLV A, ACL_SIGUMGO_MAS B,
                                    (SELECT REF_D_C  AS GUNGU_CODE, REF_D_NM  AS GUNGU_NAME
                                    FROM RPT_CODE_INFO
                                    WHERE REF_L_C=500 AND REF_M_C=28 AND REF_S_C=1
                                    ) C
                                WHERE A.FIL_100_CTNT5 = B.FIL_100_CTNT2
                                  AND A.ICH_SIGUMGO_GUN_GU_C = C.GUNGU_CODE
                                  AND B.MNG_NO = 1
                                  AND B.SIGUMGO_ORG_C = '28'          
                                  AND A.GISDT BETWEEN '20250101'  AND '20251204'
                                  AND A.SIGUMGO_TRX_G IN (17, 67)
                                  AND (SUBSTR(A.FIL_100_CTNT5,4,3) <> '900' OR SUBSTR(A.FIL_100_CTNT5,7,2) <> '90')
                                  AND A.ICH_SIGUMGO_HOIKYE_C = B.ICH_SIGUMGO_HOIKYE_C
                                  AND A.SIGUMGO_HOIKYE_YR = '2025'
    
                                            AND A.ICH_SIGUMGO_HOIKYE_C = '1'
                                              
                                        AND A.FIL_100_CTNT5 = '02800001100000025'
                                    
                        UNION ALL
                            SELECT A.SIGUMGO_ACNO GONGGEUM_GYEJWA, B.SIGUMGO_AC_NM GONGGEUM_GYEJWA_NM
                                , A.ICH_SIGUMGO_HOIKYE_C HOIGYE_CODE, A.ICH_SIGUMGO_GUN_GU_C GUNGU_CODE,
                                B.SIGUMGO_AGE_AC_G,
                                B.SIGUMGO_AC_G,  
                                C.GUNGU_NAME, A.SIGUMGO_HOIKYE_YR HOIGYE_YEAR, 
                                0 YEAR_GUBUN, A.SIGUMGO_TRX_G GEORAE_GUBUN, 
                                0 IPGEUM_GEORAE, 0 JIGEUB_GEORAE,
                                        A.GISDT ILJA,
                                        DECODE(CRT_CAN_G,1,-1,2,-1,33,-1,1) * DECODE(ipji_g,1,TRAMT,0) IPGEUM_AMT,
                                        DECODE(CRT_CAN_G,1,-1,2,-1,33,-1,1) * DECODE(ipji_g,2,TRAMT,0) JIGEUB_AMT 
                                FROM ACL_SGGHANDO_SLV A, ACL_SIGUMGO_MAS B,
                                    (SELECT REF_D_C  AS GUNGU_CODE, REF_D_NM  AS GUNGU_NAME
                                    FROM RPT_CODE_INFO
                                    WHERE REF_L_C=500 AND REF_M_C=28 AND REF_S_C=1
                                    ) C
                                WHERE A.SIGUMGO_ACNO = B.FIL_100_CTNT2
                                AND A.ICH_SIGUMGO_GUN_GU_C = C.GUNGU_CODE
                                AND b.MNG_NO = 1
                                AND B.SIGUMGO_ORG_C = '28'               
                                AND A.GISDT BETWEEN '20250101'  AND '20251204'  
                                AND A.SIGUMGO_TRX_G IN (90,91,92,95,40,41,42,45)
                                AND (SUBSTR(A.SIGUMGO_ACNO,4,3) <> '900' OR SUBSTR(A.SIGUMGO_ACNO,7,2) <> '90')
                                AND A.ICH_SIGUMGO_HOIKYE_C = B.ICH_SIGUMGO_HOIKYE_C
                                AND A.SIGUMGO_HOIKYE_YR = '2025'          
    
                                            AND A.ICH_SIGUMGO_HOIKYE_C = '1'
                                              
                                        AND A.SIGUMGO_ACNO = '02800001100000025'
                                                      
                        UNION ALL

                        SELECT A.FIL_100_CTNT2 GONGGEUM_GYEJWA,
                               A.SIGUMGO_AC_NM GONGGEUM_GYEJWA_NM, 
                               ICH_SIGUMGO_HOIKYE_C GONGGEUM_HOIGYE_CODE,
                               A.ICH_SIGUMGO_GUN_GU_C GONGGEUM_GUNGU_CODE,
                               A.SIGUMGO_AGE_AC_G, 
                               A.SIGUMGO_AC_G, 
                               B.GUNGU_NAME,
                               TO_CHAR(A.SIGUMGO_HOIKYE_YR), 
                               0 YEAR_GUBUN, 
                               67 GEORAE_GUBUN, 
                               0 IPGEUM_GEORAE, 
                               0 JIGEUB_GEORAE,
                               '20251204'  AS ILJA,
                               0 IPGEUM_AMT,
                               0 JIGEUB_AMT
                          FROM ACL_SIGUMGO_MAS A,
                                (SELECT REF_D_C  AS GUNGU_CODE, REF_D_NM  AS GUNGU_NAME
                                    FROM RPT_CODE_INFO
                                    WHERE REF_L_C=500 AND REF_M_C=28 AND REF_S_C=1
                                ) B
                                WHERE A.ICH_SIGUMGO_GUN_GU_C = B.GUNGU_CODE
                           AND A.SIGUMGO_ORG_C = '28'
                           AND A.MNG_NO = 1    
                           AND A.SIGUMGO_HOIKYE_YR = '2025'
    
                                        AND A.ICH_SIGUMGO_HOIKYE_C = '1'
                                          
                                    AND A.FIL_100_CTNT2 = '02800001100000025'
                                       
                        
                        ) A
                ) A
                GROUP BY A.GONGGEUM_GYEJWA_NM, A.GUNGU_CODE, A.GUNGU_NAME, A.GONGGEUM_GYEJWA
                ORDER BY A.GONGGEUM_GYEJWA_NM, A.GUNGU_CODE, A.GUNGU_NAME, A.GONGGEUM_GYEJWA
        ) ORG
    WHERE ROWNUM  <=  '2000') LIST
WHERE LIST.RN  >  '0'


--- 세출월계표 ------------------------------------------------------------------------------------------------------------------------------------------------
-- 변경전

SELECT
 A.GYEJWA_NM AS GYEJWA_NM
 , A.ACNO
 , A.GUBUN_NM
 , SUM(NVL(TO_NUMBER(A.JEONHANDO_BAEJEONG), 0)) AS JEONHANDO_BAEJEONG
 , SUM(NVL(TO_NUMBER(A.JEONHANDO_HWANSU), 0)) AS JEONHANDO_HWANSU
 , SUM(NVL(TO_NUMBER(A.DANGHANDO_BAEJEONG), 0)) AS DANGHANDO_BAEJEONG
 , SUM(NVL(TO_NUMBER(A.DANGHANDO_HWANSU), 0)) AS DANGHANDO_HWANSU
 , SUM(NVL(TO_NUMBER(A.JEONSECHUL_JICHUL), 0)) AS JEONSECHUL_JICHUL
 , SUM(NVL(TO_NUMBER(A.JEONSECHUL_BANNAB), 0)) AS JEONSECHUL_BANNAB
 , SUM(NVL(TO_NUMBER(A.DANGSECHUL_JICHUL), 0)) AS DANGSECHUL_JICHUL
 , SUM(NVL(TO_NUMBER(A.DANGSECHUL_BANNAB), 0)) AS DANGSECHUL_BANNAB
FROM (

  WITH DEPT_GYEJWA AS (
 SELECT SGG_ACNO
   FROM
 (
   SELECT ROWNUM AS R_NUM
     , A.*
     FROM 
   (
       SELECT SGM.SIGUMGO_ACNO AS SGG_ACNO
      FROM (
   
       SELECT ADM.SGG_ACNO
      FROM SFI_ORG_DEPT_C_MNG ODC
     INNER JOIN SFI_ORG_BY_DEPT_MNG OBD
       ON OBD.PADM_STD_ORG_C = ODC.PADM_STD_ORG_C
     INNER JOIN RPT_JEONJA_AC_BY_DEPT_MNG ADM
       ON ADM.GEUMGO_CODE = '28'
         AND ADM.SL_GMGO_DEPT_C = OBD.G_CC_DEPT_C
         AND (ADM.HOIKYE_YEAR = '2025' OR ADM.HOIKYE_YEAR = '9999')
         AND (ADM.USE_G = '1' OR ADM.USE_G = '2')
         AND ADM.DEL_YN = 'N'
      WHERE ('all'  = 'all'            OR ODC.REP_ORG_C = 'all') 
        AND ('all'  = 'all'            OR OBD.PADM_STD_ORG_C = 'all')
        AND ('all'  = 'all'           OR ADM.SL_GMGO_DEPT_C = 'all')
        AND ODC.DEL_YN = 'N'
      GROUP BY ADM.SGG_ACNO
        
    ) ADM
     INNER JOIN ACL_SIGUMGO_MAS_SUB SGM
       ON SIGUMGO_ORG_C = '28'
         AND SGM.SIGUMGO_ACNO = ADM.SGG_ACNO
     WHERE 1=1
     AND ( '99' = '99' OR TO_CHAR(SGM.SIGUMGO_HOIKYE_C) = '99')
     GROUP BY SGM.SIGUMGO_ACNO
     ORDER BY SGM.SIGUMGO_ACNO
   ) A
   WHERE ROWNUM <= '2000'
 ) X
 WHERE X.R_NUM >= '0'
   AND (('02800001100000025' = 'all' AND SUBSTR(SGG_ACNO, 7, 4) <> '0110' ) OR  SGG_ACNO = '02800001100000025')
  )
  , GYEJWA AS (
    SELECT
      FIL_100_CTNT2 AS ACNO
      , SIGUMGO_AC_B AS ACB
      , SIGUMGO_AGE_AC_G AS AGE
      , SIGUMGO_AC_G AS ACG
      , SIGUMGO_AC_NM AS GYEJWA_NM
    FROM ACL_SIGUMGO_MAS
    WHERE ( '99' = '99' OR ICH_SIGUMGO_HOIKYE_C = '99')
      AND SIGUMGO_HOIKYE_YR IN( TO_NUMBER('2025'), 9999)
      AND ( 
  FIL_100_CTNT2 IN (SELECT SGG_ACNO FROM DEPT_GYEJWA)
    OR
  (
   SIGUMGO_AGE_AC_G = 3
  AND 
   FUND_BAEJUNG_SIGUMGO_MNG_NO IN (SELECT SGG_ACNO FROM DEPT_GYEJWA)
  )
    )
      AND MNG_NO = 1
      AND (
        (  '1' = 0 AND SIGUMGO_AGE_AC_G = 0 )           
        OR 
        (  '1' <> 0 AND SIGUMGO_AGE_AC_G <> 0)
       )
  )
  , SLV AS (
  SELECT
  TRXDT
  , GISDT
  , ACNO
  , GYEJWA_NM
  , ACB
  , AGE
  , G
  , GG
  , AMT
  FROM ( 
            SELECT
            TRXDT
            , GISDT
            , FIL_100_CTNT5 AS ACNO
            , (SELECT GYEJWA_NM FROM GYEJWA WHERE ACNO = FIL_100_CTNT5) AS GYEJWA_NM
            , (SELECT ACB FROM GYEJWA WHERE ACNO = FIL_100_CTNT5) AS ACB
            , (SELECT AGE FROM GYEJWA WHERE ACNO = FIL_100_CTNT5) AS AGE
            , 'JG' AS G
            , LPAD(SIGUMGO_TRX_G, 2, '0') || LPAD(SIGUMGO_IP_TRX_G, 2, '0') || LPAD(SIGUMGO_JI_TRX_G, 2, '0') AS GG
            , SUM( DECODE(CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(IPJI_G, 2, -1, 1) * TRAMT ) AS AMT
        FROM ACL_SIGUMGO_SLV
        WHERE FIL_100_CTNT5 IN (SELECT ACNO FROM GYEJWA)
        AND TRXDT >= '2025' || '0101'
        GROUP BY TRXDT, GISDT, FIL_100_CTNT5, LPAD(SIGUMGO_TRX_G, 2, '0') || LPAD(SIGUMGO_IP_TRX_G, 2, '0') || LPAD(SIGUMGO_JI_TRX_G, 2, '0')

        UNION ALL

        SELECT
            TRXDT
            , GISDT
            , SIGUMGO_ACNO AS ACNO
            , (SELECT GYEJWA_NM FROM GYEJWA WHERE ACNO = SIGUMGO_ACNO) AS GYEJWA_NM
            , (SELECT ACB FROM GYEJWA WHERE ACNO = SIGUMGO_ACNO) AS ACB
            , (SELECT AGE FROM GYEJWA WHERE ACNO = SIGUMGO_ACNO) AS AGE
            , 'HD' AS G
            , TO_CHAR(SIGUMGO_TRX_G) AS GG
            , SUM( DECODE(CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(IPJI_G, 2, -1, 1) * TRAMT ) AS AMT
        FROM ACL_SGGHANDO_SLV
        WHERE SIGUMGO_ACNO IN (SELECT ACNO FROM GYEJWA)
        AND TRXDT >= '2025' || '0101'
        GROUP BY TRXDT, GISDT, SIGUMGO_ACNO, SIGUMGO_TRX_G
    )
    WHERE (
                        (SUBSTR(ACNO, 16, 2) != 99) 
                            OR 
                        (SUBSTR(ACNO, 16, 2) = 99 AND GISDT <= '2025' || '1231')
                    )
  )

  -- 본청 => 본청지출, 일상경비
  SELECT 
    GYEJWA_NM
    , ACNO
    , '1' AS GUBUN_NM
    , SUM ( CASE WHEN GISDT < '20251201' AND GG IN ('670090', '91') THEN AMT * -1 ELSE 0 END ) AS JEONHANDO_BAEJEONG
    , SUM ( CASE WHEN GISDT < '20251201' AND GG IN ('179000', '45') THEN AMT * 1 ELSE 0 END ) AS JEONHANDO_HWANSU
    , SUM ( CASE WHEN GISDT BETWEEN '20251201'  AND '20251204' AND GG IN ('670090', '91') THEN AMT * -1 ELSE 0 END ) AS DANGHANDO_BAEJEONG
    , SUM ( CASE WHEN GISDT BETWEEN '20251201'  AND '20251204' AND GG IN ('179000', '45') THEN AMT * 1 ELSE 0 END ) AS DANGHANDO_HWANSU
    , SUM ( CASE WHEN GISDT < '20251201' AND GG IN ('670090', '670092') THEN AMT * -1 ELSE 0 END ) AS JEONSECHUL_JICHUL
    , SUM ( CASE WHEN GISDT < '20251201' AND GG IN ('179000', '179200') THEN AMT * 1 ELSE 0 END ) AS JEONSECHUL_BANNAB
    , SUM ( CASE WHEN GISDT BETWEEN '20251201'  AND '20251204' AND GG IN ('670090', '670092') THEN AMT * -1 ELSE 0 END ) AS DANGSECHUL_JICHUL
    , SUM ( CASE WHEN GISDT BETWEEN '20251201'  AND '20251204' AND GG IN ('179000', '179200') THEN AMT * 1 ELSE 0 END ) AS DANGSECHUL_BANNAB
  FROM SLV
  WHERE AGE = 1
  GROUP BY GYEJWA_NM, ACNO

  UNION ALL

  -- 본청외 => 사업소, 일상경비 손
  SELECT 
    GYEJWA_NM
    , ACNO
    , '2' AS GUBUN_NM
    , SUM ( CASE WHEN GISDT < '20251201' AND GG IN ('90') THEN AMT * -1 ELSE 0 END ) AS JEONHANDO_BAEJEONG
    , SUM ( CASE WHEN GISDT < '20251201' AND GG IN ('42') THEN AMT * 1 ELSE 0 END ) AS JEONHANDO_HWANSU
    , SUM ( CASE WHEN GISDT BETWEEN '20251201'  AND '20251204' AND GG IN ('90') THEN AMT * -1 ELSE 0 END ) AS DANGHANDO_BAEJEONG
    , SUM ( CASE WHEN GISDT BETWEEN '20251201'  AND '20251204' AND GG IN ('42') THEN AMT * 1 ELSE 0 END ) AS DANGHANDO_HWANSU
    , SUM ( CASE WHEN GISDT < '20251201' AND GG IN ('670091', '670093') THEN AMT * -1 ELSE 0 END ) AS JEONSECHUL_JICHUL
    , SUM ( CASE WHEN GISDT < '20251201' AND GG IN ('179100', '179300') THEN AMT * 1 ELSE 0 END ) AS JEONSECHUL_BANNAB
    , SUM ( CASE WHEN GISDT BETWEEN '20251201'  AND '20251204' AND GG IN ('670091', '670093') THEN AMT * -1 ELSE 0 END ) AS DANGSECHUL_JICHUL
    , SUM ( CASE WHEN GISDT BETWEEN '20251201'  AND '20251204' AND GG IN ('179100', '179300') THEN AMT * 1 ELSE 0 END ) AS DANGSECHUL_BANNAB
  FROM SLV
  WHERE AGE = 1
  GROUP BY GYEJWA_NM, ACNO

  UNION ALL

  -- 자계좌 
  SELECT 
    GYEJWA_NM
    , ACNO
    , '0' AS GUBUN_NM
    , SUM ( CASE WHEN GISDT < '20251201' AND GG IN ('40', '41', '91') THEN AMT
        ELSE 0 END ) AS JEONHANDO_BAEJEONG
    , SUM ( CASE WHEN GISDT < '20251201' AND GG IN ('45', '92', '95') THEN AMT * -1 ELSE 0 END ) AS JEONHANDO_HWANSU
    , SUM ( CASE WHEN GISDT BETWEEN '20251201'  AND '20251204' AND GG IN ('40', '41', '91') THEN AMT
        ELSE 0 END ) AS DANGHANDO_BAEJEONG
    , SUM ( CASE WHEN GISDT BETWEEN '20251201'  AND '20251204' AND GG IN ('45', '92', '95') THEN AMT * -1 ELSE 0 END ) AS DANGHANDO_HWANSU
    , SUM ( CASE WHEN GISDT < '20251201' AND GG IN ('670091', '670092', '670093') THEN AMT * -1 ELSE 0 END ) AS JEONSECHUL_JICHUL
    , SUM ( CASE WHEN GISDT < '20251201' AND GG IN ('179100', '179200', '179300') THEN AMT * 1 ELSE 0 END ) AS JEONSECHUL_BANNAB
    , SUM ( CASE WHEN GISDT BETWEEN '20251201'  AND '20251204' AND GG IN ('670091', '670092', '670093') THEN AMT * -1 ELSE 0 END ) AS DANGSECHUL_JICHUL
    , SUM ( CASE WHEN GISDT BETWEEN '20251201'  AND '20251204' AND GG IN ('179100', '179200', '179300') THEN AMT * 1 ELSE 0 END ) AS DANGSECHUL_BANNAB
  FROM SLV
  WHERE AGE IN (2, 3)
  GROUP BY GYEJWA_NM, ACNO

  UNION ALL

  -- 비한도계좌  
  SELECT 
    GYEJWA_NM
    , ACNO
    , '3' AS GUBUN_NM
    , 0 AS JEONHANDO_BAEJEONG
    , 0 AS JEONHANDO_HWANSU
    , 0 AS DANGHANDO_BAEJEONG
    , 0 AS DANGHANDO_HWANSU
    , SUM ( CASE WHEN GISDT < '20251201' AND GG IN ('670000') THEN AMT * -1 ELSE 0 END ) AS JEONSECHUL_JICHUL
    , SUM ( CASE WHEN GISDT < '20251201' AND GG IN ('170000') THEN AMT * 1 ELSE 0 END ) AS JEONSECHUL_BANNAB
    , SUM ( CASE WHEN GISDT BETWEEN '20251201'  AND '20251204' AND GG IN ('670000') THEN AMT * -1 ELSE 0 END ) AS DANGSECHUL_JICHUL
    , SUM ( CASE WHEN GISDT BETWEEN '20251201'  AND '20251204' AND GG IN ('170000') THEN AMT * 1 ELSE 0 END ) AS DANGSECHUL_BANNAB
  FROM SLV
  WHERE AGE IN (0)
  GROUP BY GYEJWA_NM, ACNO

 -- 거래내역이 없어도 목록이 보이도록 처리 
  UNION ALL
  SELECT 
    GYEJWA_NM
    ,ACNO
    ,'1' AS GUBUN_NM
    , 0 AS JEONHANDO_BAEJEONG
    , 0 AS JEONHANDO_HWANSU
    , 0 AS DANGHANDO_BAEJEONG
    , 0 AS DANGHANDO_HWANSU
    , 0 AS JEONSECHUL_JICHUL
    , 0 AS JEONSECHUL_BANNAB
    , 0 AS DANGSECHUL_JICHUL
    , 0 AS DANGSECHUL_BANNAB 
  FROM GYEJWA
  WHERE AGE = 1
  GROUP BY GYEJWA_NM, ACNO
  UNION ALL
  SELECT 
    GYEJWA_NM
    ,ACNO
    ,'2' AS GUBUN_NM
    , 0 AS JEONHANDO_BAEJEONG
    , 0 AS JEONHANDO_HWANSU
    , 0 AS DANGHANDO_BAEJEONG
    , 0 AS DANGHANDO_HWANSU
    , 0 AS JEONSECHUL_JICHUL
    , 0 AS JEONSECHUL_BANNAB
    , 0 AS DANGSECHUL_JICHUL
    , 0 AS DANGSECHUL_BANNAB 
  FROM GYEJWA
  WHERE AGE = 1
  GROUP BY GYEJWA_NM, ACNO
UNION ALL
  SELECT 
    GYEJWA_NM
    ,ACNO
    ,'0' AS GUBUN_NM
    , 0 AS JEONHANDO_BAEJEONG
    , 0 AS JEONHANDO_HWANSU
    , 0 AS DANGHANDO_BAEJEONG
    , 0 AS DANGHANDO_HWANSU
    , 0 AS JEONSECHUL_JICHUL
    , 0 AS JEONSECHUL_BANNAB
    , 0 AS DANGSECHUL_JICHUL
    , 0 AS DANGSECHUL_BANNAB 
  FROM GYEJWA
  WHERE AGE IN (2,3)
  GROUP BY GYEJWA_NM, ACNO
  UNION ALL
  SELECT 
    GYEJWA_NM
    ,ACNO
    ,'3' AS GUBUN_NM
    , 0 AS JEONHANDO_BAEJEONG
    , 0 AS JEONHANDO_HWANSU
    , 0 AS DANGHANDO_BAEJEONG
    , 0 AS DANGHANDO_HWANSU
    , 0 AS JEONSECHUL_JICHUL
    , 0 AS JEONSECHUL_BANNAB
    , 0 AS DANGSECHUL_JICHUL
    , 0 AS DANGSECHUL_BANNAB 
  FROM GYEJWA
  WHERE AGE IN (0)
  GROUP BY GYEJWA_NM, ACNO
) A
GROUP BY GYEJWA_NM, ACNO, GUBUN_NM
ORDER BY ACNO, GUBUN_NM


------------------------------------------------------------------------------------------------------------------------------------------------
-- 변경후

SELECT
 A.GYEJWA_NM AS GYEJWA_NM
 , A.ACNO
 , A.GUBUN_NM
 , SUM(NVL(TO_NUMBER(A.JEONHANDO_BAEJEONG), 0)) AS JEONHANDO_BAEJEONG
 , SUM(NVL(TO_NUMBER(A.JEONHANDO_HWANSU), 0)) AS JEONHANDO_HWANSU
 , SUM(NVL(TO_NUMBER(A.DANGHANDO_BAEJEONG), 0)) AS DANGHANDO_BAEJEONG
 , SUM(NVL(TO_NUMBER(A.DANGHANDO_HWANSU), 0)) AS DANGHANDO_HWANSU
 , SUM(NVL(TO_NUMBER(A.JEONSECHUL_JICHUL), 0)) AS JEONSECHUL_JICHUL
 , SUM(NVL(TO_NUMBER(A.JEONSECHUL_BANNAB), 0)) AS JEONSECHUL_BANNAB
 , SUM(NVL(TO_NUMBER(A.DANGSECHUL_JICHUL), 0)) AS DANGSECHUL_JICHUL
 , SUM(NVL(TO_NUMBER(A.DANGSECHUL_BANNAB), 0)) AS DANGSECHUL_BANNAB
FROM (

  WITH DEPT_GYEJWA AS (
 SELECT SGG_ACNO
   FROM
 (
   SELECT ROWNUM AS R_NUM
     , A.*
     FROM 
   (
       SELECT SGM.SIGUMGO_ACNO AS SGG_ACNO
      FROM (
   
       SELECT ADM.SGG_ACNO
      FROM SFI_ORG_DEPT_C_MNG ODC
     INNER JOIN SFI_ORG_BY_DEPT_MNG OBD
       ON OBD.PADM_STD_ORG_C = ODC.PADM_STD_ORG_C
     INNER JOIN RPT_JEONJA_AC_BY_DEPT_MNG ADM
       ON ADM.GEUMGO_CODE = '28'
         AND ADM.SL_GMGO_DEPT_C = OBD.G_CC_DEPT_C
         AND (ADM.HOIKYE_YEAR = '2025' OR ADM.HOIKYE_YEAR = '9999')
         AND (ADM.USE_G = '1' OR ADM.USE_G = '2')
         AND ADM.DEL_YN = 'N'
      WHERE ('all'  = 'all'            OR ODC.REP_ORG_C = 'all') 
        AND ('all'  = 'all'            OR OBD.PADM_STD_ORG_C = 'all')
        AND ('all'  = 'all'           OR ADM.SL_GMGO_DEPT_C = 'all')
        AND ODC.DEL_YN = 'N'
      GROUP BY ADM.SGG_ACNO
        
    ) ADM
     INNER JOIN ACL_SIGUMGO_MAS_SUB SGM
       ON SIGUMGO_ORG_C = '28'
         AND SGM.SIGUMGO_ACNO = ADM.SGG_ACNO
     WHERE 1=1
     AND ( '99' = '99' OR TO_CHAR(SGM.SIGUMGO_HOIKYE_C) = '99')
     GROUP BY SGM.SIGUMGO_ACNO
     ORDER BY SGM.SIGUMGO_ACNO
   ) A
   WHERE ROWNUM <= '2000'
 ) X
 WHERE X.R_NUM >= '0'
   AND (('02800001100000025' = 'all' AND SUBSTR(SGG_ACNO, 7, 4) <> '0110' ) OR  SGG_ACNO = '02800001100000025')
  )
  , GYEJWA AS (
    SELECT
      FIL_100_CTNT2 AS ACNO
      , SIGUMGO_AC_B AS ACB
      , SIGUMGO_AGE_AC_G AS AGE
      , SIGUMGO_AC_G AS ACG
      , SIGUMGO_AC_NM AS GYEJWA_NM
    FROM ACL_SIGUMGO_MAS
    WHERE ( '99' = '99' OR ICH_SIGUMGO_HOIKYE_C = '99')
      AND SIGUMGO_HOIKYE_YR IN( TO_NUMBER('2025'), 9999)
      AND ( 
  FIL_100_CTNT2 IN (SELECT SGG_ACNO FROM DEPT_GYEJWA)
    OR
  (
   SIGUMGO_AGE_AC_G = 3
  AND 
   FUND_BAEJUNG_SIGUMGO_MNG_NO IN (SELECT SGG_ACNO FROM DEPT_GYEJWA)
  )
    )
      AND MNG_NO = 1
      AND (
        (  '1' = 0 AND SIGUMGO_AC_G = 0 )           
        OR 
        (  '1' <> 0 AND SIGUMGO_AC_G <> 0)
       )
  )
  , SLV AS (
  SELECT
  TRXDT
  , GISDT
  , ACNO
  , GYEJWA_NM
  , ACB
  , ACG
  , AGE
  , G
  , GG
  , AMT
  FROM ( 
            SELECT
            TRXDT
            , GISDT
            , FIL_100_CTNT5 AS ACNO
            , (SELECT GYEJWA_NM FROM GYEJWA WHERE ACNO = FIL_100_CTNT5) AS GYEJWA_NM
            , (SELECT ACB FROM GYEJWA WHERE ACNO = FIL_100_CTNT5) AS ACB
            , (SELECT ACG FROM GYEJWA WHERE ACNO = FIL_100_CTNT5) AS ACG
            , (SELECT AGE FROM GYEJWA WHERE ACNO = FIL_100_CTNT5) AS AGE
            , 'JG' AS G
            , LPAD(SIGUMGO_TRX_G, 2, '0') || LPAD(SIGUMGO_IP_TRX_G, 2, '0') || LPAD(SIGUMGO_JI_TRX_G, 2, '0') AS GG
            , SUM( DECODE(CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(IPJI_G, 2, -1, 1) * TRAMT ) AS AMT
        FROM ACL_SIGUMGO_SLV
        WHERE FIL_100_CTNT5 IN (SELECT ACNO FROM GYEJWA)
        AND TRXDT >= '2025' || '0101'
        GROUP BY TRXDT, GISDT, FIL_100_CTNT5, LPAD(SIGUMGO_TRX_G, 2, '0') || LPAD(SIGUMGO_IP_TRX_G, 2, '0') || LPAD(SIGUMGO_JI_TRX_G, 2, '0')

        UNION ALL

        SELECT
            TRXDT
            , GISDT
            , SIGUMGO_ACNO AS ACNO
            , (SELECT GYEJWA_NM FROM GYEJWA WHERE ACNO = SIGUMGO_ACNO) AS GYEJWA_NM
            , (SELECT ACB FROM GYEJWA WHERE ACNO = SIGUMGO_ACNO) AS ACB
            , (SELECT ACG FROM GYEJWA WHERE ACNO = SIGUMGO_ACNO) AS ACG
            , (SELECT AGE FROM GYEJWA WHERE ACNO = SIGUMGO_ACNO) AS AGE
            , 'HD' AS G
            , TO_CHAR(SIGUMGO_TRX_G) AS GG
            , SUM( DECODE(CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(IPJI_G, 2, -1, 1) * TRAMT ) AS AMT
        FROM ACL_SGGHANDO_SLV
        WHERE SIGUMGO_ACNO IN (SELECT ACNO FROM GYEJWA)
        AND TRXDT >= '2025' || '0101'
        GROUP BY TRXDT, GISDT, SIGUMGO_ACNO, SIGUMGO_TRX_G
    )
    WHERE (
                        (SUBSTR(ACNO, 16, 2) != 99) 
                            OR 
                        (SUBSTR(ACNO, 16, 2) = 99 AND GISDT <= '2025' || '1231')
                    )
  )

  -- 본청 => 본청지출, 일상경비
  SELECT 
    GYEJWA_NM
    , ACNO
    , '1' AS GUBUN_NM
    , SUM ( CASE WHEN GISDT < '20251201' AND GG IN ('670090', '91') THEN AMT * -1 ELSE 0 END ) AS JEONHANDO_BAEJEONG
    , SUM ( CASE WHEN GISDT < '20251201' AND GG IN ('179000', '45') THEN AMT * 1 ELSE 0 END ) AS JEONHANDO_HWANSU
    , SUM ( CASE WHEN GISDT BETWEEN '20251201'  AND '20251204' AND GG IN ('670090', '91') THEN AMT * -1 ELSE 0 END ) AS DANGHANDO_BAEJEONG
    , SUM ( CASE WHEN GISDT BETWEEN '20251201'  AND '20251204' AND GG IN ('179000', '45') THEN AMT * 1 ELSE 0 END ) AS DANGHANDO_HWANSU
    , SUM ( CASE WHEN GISDT < '20251201' AND GG IN ('670090', '670092') THEN AMT * -1 ELSE 0 END ) AS JEONSECHUL_JICHUL
    , SUM ( CASE WHEN GISDT < '20251201' AND GG IN ('179000', '179200') THEN AMT * 1 ELSE 0 END ) AS JEONSECHUL_BANNAB
    , SUM ( CASE WHEN GISDT BETWEEN '20251201'  AND '20251204' AND GG IN ('670090', '670092') THEN AMT * -1 ELSE 0 END ) AS DANGSECHUL_JICHUL
    , SUM ( CASE WHEN GISDT BETWEEN '20251201'  AND '20251204' AND GG IN ('179000', '179200') THEN AMT * 1 ELSE 0 END ) AS DANGSECHUL_BANNAB
  FROM SLV
  WHERE AGE = 1
  AND ACG <> 0
  GROUP BY GYEJWA_NM, ACNO

  UNION ALL

  -- 본청외 => 사업소, 일상경비 손
  SELECT 
    GYEJWA_NM
    , ACNO
    , '2' AS GUBUN_NM
    , SUM ( CASE WHEN GISDT < '20251201' AND GG IN ('90') THEN AMT * -1 ELSE 0 END ) AS JEONHANDO_BAEJEONG
    , SUM ( CASE WHEN GISDT < '20251201' AND GG IN ('42') THEN AMT * 1 ELSE 0 END ) AS JEONHANDO_HWANSU
    , SUM ( CASE WHEN GISDT BETWEEN '20251201'  AND '20251204' AND GG IN ('90') THEN AMT * -1 ELSE 0 END ) AS DANGHANDO_BAEJEONG
    , SUM ( CASE WHEN GISDT BETWEEN '20251201'  AND '20251204' AND GG IN ('42') THEN AMT * 1 ELSE 0 END ) AS DANGHANDO_HWANSU
    , SUM ( CASE WHEN GISDT < '20251201' AND GG IN ('670091', '670093') THEN AMT * -1 ELSE 0 END ) AS JEONSECHUL_JICHUL
    , SUM ( CASE WHEN GISDT < '20251201' AND GG IN ('179100', '179300') THEN AMT * 1 ELSE 0 END ) AS JEONSECHUL_BANNAB
    , SUM ( CASE WHEN GISDT BETWEEN '20251201'  AND '20251204' AND GG IN ('670091', '670093') THEN AMT * -1 ELSE 0 END ) AS DANGSECHUL_JICHUL
    , SUM ( CASE WHEN GISDT BETWEEN '20251201'  AND '20251204' AND GG IN ('179100', '179300') THEN AMT * 1 ELSE 0 END ) AS DANGSECHUL_BANNAB
  FROM SLV
  WHERE AGE = 1
  AND ACG <> 0
  GROUP BY GYEJWA_NM, ACNO

  UNION ALL

  -- 자계좌 
  SELECT 
    GYEJWA_NM
    , ACNO
    , '0' AS GUBUN_NM
    , SUM ( CASE WHEN GISDT < '20251201' AND GG IN ('40', '41', '91') THEN AMT
        ELSE 0 END ) AS JEONHANDO_BAEJEONG
    , SUM ( CASE WHEN GISDT < '20251201' AND GG IN ('45', '92', '95') THEN AMT * -1 ELSE 0 END ) AS JEONHANDO_HWANSU
    , SUM ( CASE WHEN GISDT BETWEEN '20251201'  AND '20251204' AND GG IN ('40', '41', '91') THEN AMT
        ELSE 0 END ) AS DANGHANDO_BAEJEONG
    , SUM ( CASE WHEN GISDT BETWEEN '20251201'  AND '20251204' AND GG IN ('45', '92', '95') THEN AMT * -1 ELSE 0 END ) AS DANGHANDO_HWANSU
    , SUM ( CASE WHEN GISDT < '20251201' AND GG IN ('670091', '670092', '670093') THEN AMT * -1 ELSE 0 END ) AS JEONSECHUL_JICHUL
    , SUM ( CASE WHEN GISDT < '20251201' AND GG IN ('179100', '179200', '179300') THEN AMT * 1 ELSE 0 END ) AS JEONSECHUL_BANNAB
    , SUM ( CASE WHEN GISDT BETWEEN '20251201'  AND '20251204' AND GG IN ('670091', '670092', '670093') THEN AMT * -1 ELSE 0 END ) AS DANGSECHUL_JICHUL
    , SUM ( CASE WHEN GISDT BETWEEN '20251201'  AND '20251204' AND GG IN ('179100', '179200', '179300') THEN AMT * 1 ELSE 0 END ) AS DANGSECHUL_BANNAB
  FROM SLV
  WHERE AGE IN (2, 3)
  AND ACG <> 0
  GROUP BY GYEJWA_NM, ACNO

  UNION ALL

  -- 비한도계좌  
  SELECT 
    GYEJWA_NM
    , ACNO
    , '3' AS GUBUN_NM
    , 0 AS JEONHANDO_BAEJEONG
    , 0 AS JEONHANDO_HWANSU
    , 0 AS DANGHANDO_BAEJEONG
    , 0 AS DANGHANDO_HWANSU
    , SUM ( CASE WHEN GISDT < '20251201' AND GG IN ('670000') THEN AMT * -1 ELSE 0 END ) AS JEONSECHUL_JICHUL
    , SUM ( CASE WHEN GISDT < '20251201' AND GG IN ('170000') THEN AMT * 1 ELSE 0 END ) AS JEONSECHUL_BANNAB
    , SUM ( CASE WHEN GISDT BETWEEN '20251201'  AND '20251204' AND GG IN ('670000') THEN AMT * -1 ELSE 0 END ) AS DANGSECHUL_JICHUL
    , SUM ( CASE WHEN GISDT BETWEEN '20251201'  AND '20251204' AND GG IN ('170000') THEN AMT * 1 ELSE 0 END ) AS DANGSECHUL_BANNAB
  FROM SLV
  WHERE ACG = 0
  GROUP BY GYEJWA_NM, ACNO

 -- 거래내역이 없어도 목록이 보이도록 처리 
  UNION ALL
  SELECT 
    GYEJWA_NM
    ,ACNO
    ,'1' AS GUBUN_NM
    , 0 AS JEONHANDO_BAEJEONG
    , 0 AS JEONHANDO_HWANSU
    , 0 AS DANGHANDO_BAEJEONG
    , 0 AS DANGHANDO_HWANSU
    , 0 AS JEONSECHUL_JICHUL
    , 0 AS JEONSECHUL_BANNAB
    , 0 AS DANGSECHUL_JICHUL
    , 0 AS DANGSECHUL_BANNAB 
  FROM GYEJWA
  WHERE AGE = 1
  AND ACG <> 0
  GROUP BY GYEJWA_NM, ACNO
  UNION ALL
  SELECT 
    GYEJWA_NM
    ,ACNO
    ,'2' AS GUBUN_NM
    , 0 AS JEONHANDO_BAEJEONG
    , 0 AS JEONHANDO_HWANSU
    , 0 AS DANGHANDO_BAEJEONG
    , 0 AS DANGHANDO_HWANSU
    , 0 AS JEONSECHUL_JICHUL
    , 0 AS JEONSECHUL_BANNAB
    , 0 AS DANGSECHUL_JICHUL
    , 0 AS DANGSECHUL_BANNAB 
  FROM GYEJWA
  WHERE AGE = 1
  AND ACG <> 0
  GROUP BY GYEJWA_NM, ACNO
UNION ALL
  SELECT 
    GYEJWA_NM
    ,ACNO
    ,'0' AS GUBUN_NM
    , 0 AS JEONHANDO_BAEJEONG
    , 0 AS JEONHANDO_HWANSU
    , 0 AS DANGHANDO_BAEJEONG
    , 0 AS DANGHANDO_HWANSU
    , 0 AS JEONSECHUL_JICHUL
    , 0 AS JEONSECHUL_BANNAB
    , 0 AS DANGSECHUL_JICHUL
    , 0 AS DANGSECHUL_BANNAB 
  FROM GYEJWA
  WHERE AGE IN (2,3)
  AND ACG <> 0
  GROUP BY GYEJWA_NM, ACNO
  UNION ALL
  SELECT 
    GYEJWA_NM
    ,ACNO
    ,'3' AS GUBUN_NM
    , 0 AS JEONHANDO_BAEJEONG
    , 0 AS JEONHANDO_HWANSU
    , 0 AS DANGHANDO_BAEJEONG
    , 0 AS DANGHANDO_HWANSU
    , 0 AS JEONSECHUL_JICHUL
    , 0 AS JEONSECHUL_BANNAB
    , 0 AS DANGSECHUL_JICHUL
    , 0 AS DANGSECHUL_BANNAB 
  FROM GYEJWA
  WHERE ACG = 0
  GROUP BY GYEJWA_NM, ACNO
) A
GROUP BY GYEJWA_NM, ACNO, GUBUN_NM
ORDER BY ACNO, GUBUN_NM


--- 세출일계표 ------------------------------------------------------------------------------------------------------------------------------------------------
-- 변경전



SELECT
 A.GYEJWA_NM AS GYEJWA_NM
 , A.ACNO
 , A.GUBUN_NM
 , SUM(NVL(TO_NUMBER(A.JEONHANDO_BAEJEONG), 0)) AS JEONHANDO_BAEJEONG
 , SUM(NVL(TO_NUMBER(A.JEONHANDO_HWANSU), 0)) AS JEONHANDO_HWANSU
 , SUM(NVL(TO_NUMBER(A.DANGHANDO_BAEJEONG), 0)) AS DANGHANDO_BAEJEONG
 , SUM(NVL(TO_NUMBER(A.DANGHANDO_HWANSU), 0)) AS DANGHANDO_HWANSU
 , SUM(NVL(TO_NUMBER(A.JEONSECHUL_JICHUL), 0)) AS JEONSECHUL_JICHUL
 , SUM(NVL(TO_NUMBER(A.JEONSECHUL_BANNAB), 0)) AS JEONSECHUL_BANNAB
 , SUM(NVL(TO_NUMBER(A.DANGSECHUL_JICHUL), 0)) AS DANGSECHUL_JICHUL
 , SUM(NVL(TO_NUMBER(A.DANGSECHUL_BANNAB), 0)) AS DANGSECHUL_BANNAB
FROM (

  WITH DEPT_GYEJWA AS (
 SELECT SGG_ACNO
   FROM
 (
   SELECT ROWNUM AS R_NUM
     , A.*
     FROM 
   (
       SELECT SGM.SIGUMGO_ACNO AS SGG_ACNO
      FROM (
   
       SELECT ADM.SGG_ACNO
      FROM SFI_ORG_DEPT_C_MNG ODC
     INNER JOIN SFI_ORG_BY_DEPT_MNG OBD
       ON OBD.PADM_STD_ORG_C = ODC.PADM_STD_ORG_C
     INNER JOIN RPT_JEONJA_AC_BY_DEPT_MNG ADM
       ON ADM.GEUMGO_CODE = '28'
         AND ADM.SL_GMGO_DEPT_C = OBD.G_CC_DEPT_C
         AND (ADM.HOIKYE_YEAR = '2025' OR ADM.HOIKYE_YEAR = '9999')
         AND (ADM.USE_G = '1' OR ADM.USE_G = '2')
         AND ADM.DEL_YN = 'N'
      WHERE ('all'  = 'all'            OR ODC.REP_ORG_C = 'all') 
        AND ('all'  = 'all'            OR OBD.PADM_STD_ORG_C = 'all')
        AND ('all'  = 'all'           OR ADM.SL_GMGO_DEPT_C = 'all')
        AND ODC.DEL_YN = 'N'
      GROUP BY ADM.SGG_ACNO
        
    ) ADM
     INNER JOIN ACL_SIGUMGO_MAS_SUB SGM
       ON SIGUMGO_ORG_C = '28'
         AND SGM.SIGUMGO_ACNO = ADM.SGG_ACNO
     WHERE 1=1
       AND TO_CHAR(SGM.SIGUMGO_HOIKYE_C) = '1'
     GROUP BY SGM.SIGUMGO_ACNO
     ORDER BY SGM.SIGUMGO_ACNO
   ) A
   WHERE ROWNUM <= '2000'
 ) X
 WHERE X.R_NUM >= '0'
   AND (('02800001100000025' = 'all' AND SUBSTR(SGG_ACNO, 7, 4) <> '0110' ) OR  SGG_ACNO = '02800001100000025')
  )
  , GYEJWA AS (
  
  
    SELECT
      FIL_100_CTNT2 AS ACNO
      , SIGUMGO_AC_B AS ACB
      , SIGUMGO_AGE_AC_G AS AGE
      , SIGUMGO_AC_G AS ACG
      , SIGUMGO_AC_NM AS GYEJWA_NM
    FROM ACL_SIGUMGO_MAS
    WHERE ICH_SIGUMGO_HOIKYE_C = 1
      AND SIGUMGO_HOIKYE_YR = TO_NUMBER('2025')
      AND ( 
  FIL_100_CTNT2 IN (SELECT SGG_ACNO FROM DEPT_GYEJWA)
    OR
  (
   SIGUMGO_AGE_AC_G = 3
  AND 
   FUND_BAEJUNG_SIGUMGO_MNG_NO IN (SELECT SGG_ACNO FROM DEPT_GYEJWA)
  )
    )
      AND MNG_NO = 1      
  )
  , SLV AS (
    SELECT
        TRXDT
        , GISDT
        , FIL_100_CTNT5 AS ACNO
        , (SELECT GYEJWA_NM FROM GYEJWA WHERE ACNO = FIL_100_CTNT5) AS GYEJWA_NM
        , (SELECT ACB FROM GYEJWA WHERE ACNO = FIL_100_CTNT5) AS ACB
        , (SELECT AGE FROM GYEJWA WHERE ACNO = FIL_100_CTNT5) AS AGE
        , 'JG' AS G
        , LPAD(SIGUMGO_TRX_G, 2, '0') || LPAD(SIGUMGO_IP_TRX_G, 2, '0') || LPAD(SIGUMGO_JI_TRX_G, 2, '0') AS GG
        , SUM( DECODE(CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(IPJI_G, 2, -1, 1) * TRAMT ) AS AMT
      FROM ACL_SIGUMGO_SLV
      WHERE FIL_100_CTNT5 IN (SELECT ACNO FROM GYEJWA)
      AND TRXDT >= '2025' || '0101'
      GROUP BY TRXDT, GISDT, FIL_100_CTNT5, LPAD(SIGUMGO_TRX_G, 2, '0') || LPAD(SIGUMGO_IP_TRX_G, 2, '0') || LPAD(SIGUMGO_JI_TRX_G, 2, '0')

      UNION ALL

      SELECT
        TRXDT
        , GISDT
        , SIGUMGO_ACNO AS ACNO
        , (SELECT GYEJWA_NM FROM GYEJWA WHERE ACNO = SIGUMGO_ACNO) AS GYEJWA_NM
        , (SELECT ACB FROM GYEJWA WHERE ACNO = SIGUMGO_ACNO) AS ACB
        , (SELECT AGE FROM GYEJWA WHERE ACNO = SIGUMGO_ACNO) AS AGE
        , 'HD' AS G
        , TO_CHAR(SIGUMGO_TRX_G) AS GG
        , SUM( DECODE(CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(IPJI_G, 2, -1, 1) * TRAMT ) AS AMT
      FROM ACL_SGGHANDO_SLV
      WHERE SIGUMGO_ACNO IN (SELECT ACNO FROM GYEJWA)
      AND TRXDT >= '2025' || '0101'
      GROUP BY TRXDT, GISDT, SIGUMGO_ACNO, SIGUMGO_TRX_G
  )

  -- 본청 => 본청지출, 일상경비
  SELECT 
    GYEJWA_NM
    , ACNO
    , '1' AS GUBUN_NM
    , SUM ( CASE WHEN GISDT < '20251204' AND GG IN ('670090', '91') THEN AMT * -1 ELSE 0 END ) AS JEONHANDO_BAEJEONG
    , SUM ( CASE WHEN GISDT < '20251204' AND GG IN ('179000', '45') THEN AMT * 1 ELSE 0 END ) AS JEONHANDO_HWANSU
    , SUM ( CASE WHEN GISDT = '20251204' AND GG IN ('670090', '91') THEN AMT * -1 ELSE 0 END ) AS DANGHANDO_BAEJEONG
    , SUM ( CASE WHEN GISDT = '20251204' AND GG IN ('179000', '45') THEN AMT * 1 ELSE 0 END ) AS DANGHANDO_HWANSU
    , SUM ( CASE WHEN GISDT < '20251204' AND GG IN ('670090', '670092') THEN AMT * -1 ELSE 0 END ) AS JEONSECHUL_JICHUL
    , SUM ( CASE WHEN GISDT < '20251204' AND GG IN ('179000', '179200') THEN AMT * 1 ELSE 0 END ) AS JEONSECHUL_BANNAB
    , SUM ( CASE WHEN GISDT = '20251204' AND GG IN ('670090', '670092') THEN AMT * -1 ELSE 0 END ) AS DANGSECHUL_JICHUL
    , SUM ( CASE WHEN GISDT = '20251204' AND GG IN ('179000', '179200') THEN AMT * 1 ELSE 0 END ) AS DANGSECHUL_BANNAB
  FROM SLV
  WHERE AGE = 1
  GROUP BY GYEJWA_NM, ACNO

  UNION ALL

  -- 본청외 => 사업소, 일상경비 손
  SELECT 
    GYEJWA_NM
    , ACNO
    , '2' AS GUBUN_NM
    , SUM ( CASE WHEN GISDT < '20251204' AND GG IN ('90') THEN AMT * -1 ELSE 0 END ) AS JEONHANDO_BAEJEONG
    , SUM ( CASE WHEN GISDT < '20251204' AND GG IN ('42') THEN AMT * 1 ELSE 0 END ) AS JEONHANDO_HWANSU
    , SUM ( CASE WHEN GISDT = '20251204' AND GG IN ('90') THEN AMT * -1 ELSE 0 END ) AS DANGHANDO_BAEJEONG
    , SUM ( CASE WHEN GISDT = '20251204' AND GG IN ('42') THEN AMT * 1 ELSE 0 END ) AS DANGHANDO_HWANSU
    , SUM ( CASE WHEN GISDT < '20251204' AND GG IN ('670091', '670093') THEN AMT * -1 ELSE 0 END ) AS JEONSECHUL_JICHUL
    , SUM ( CASE WHEN GISDT < '20251204' AND GG IN ('179100', '179300') THEN AMT * 1 ELSE 0 END ) AS JEONSECHUL_BANNAB
    , SUM ( CASE WHEN GISDT = '20251204' AND GG IN ('670091', '670093') THEN AMT * -1 ELSE 0 END ) AS DANGSECHUL_JICHUL
    , SUM ( CASE WHEN GISDT = '20251204' AND GG IN ('179100', '179300') THEN AMT * 1 ELSE 0 END ) AS DANGSECHUL_BANNAB
  FROM SLV
  WHERE AGE = 1
  GROUP BY GYEJWA_NM, ACNO

  UNION ALL

  -- 자계좌 
  SELECT 
    GYEJWA_NM
    , ACNO
    , '0' AS GUBUN_NM
    , SUM ( CASE WHEN GISDT < '20251204' AND GG IN ('40', '41', '91') THEN AMT
        ELSE 0 END ) AS JEONHANDO_BAEJEONG
    , SUM ( CASE WHEN GISDT < '20251204' AND GG IN ('45', '92', '95') THEN AMT * -1 ELSE 0 END ) AS JEONHANDO_HWANSU
    , SUM ( CASE WHEN GISDT = '20251204' AND GG IN ('40', '41', '91') THEN AMT
        ELSE 0 END ) AS DANGHANDO_BAEJEONG
    , SUM ( CASE WHEN GISDT = '20251204' AND GG IN ('45', '92', '95') THEN AMT * -1 ELSE 0 END ) AS DANGHANDO_HWANSU
    , SUM ( CASE WHEN GISDT < '20251204' AND GG IN ('670091', '670092', '670093') THEN AMT * -1 ELSE 0 END ) AS JEONSECHUL_JICHUL
    , SUM ( CASE WHEN GISDT < '20251204' AND GG IN ('179100', '179200', '179300') THEN AMT * 1 ELSE 0 END ) AS JEONSECHUL_BANNAB
    , SUM ( CASE WHEN GISDT = '20251204' AND GG IN ('670091', '670092', '670093') THEN AMT * -1 ELSE 0 END ) AS DANGSECHUL_JICHUL
    , SUM ( CASE WHEN GISDT = '20251204' AND GG IN ('179100', '179200', '179300') THEN AMT * 1 ELSE 0 END ) AS DANGSECHUL_BANNAB
  FROM SLV
  WHERE AGE IN (2, 3)
  GROUP BY GYEJWA_NM, ACNO
-- 거래내역이 없어도 목록이 보이도록 처리 
  UNION ALL
  SELECT 
    GYEJWA_NM
    ,ACNO
    ,'1' AS GUBUN_NM
    , 0 AS JEONHANDO_BAEJEONG
    , 0 AS JEONHANDO_HWANSU
    , 0 AS DANGHANDO_BAEJEONG
    , 0 AS DANGHANDO_HWANSU
    , 0 AS JEONSECHUL_JICHUL
    , 0 AS JEONSECHUL_BANNAB
    , 0 AS DANGSECHUL_JICHUL
    , 0 AS DANGSECHUL_BANNAB 
  FROM GYEJWA
  WHERE AGE = 1
  GROUP BY GYEJWA_NM, ACNO
  UNION ALL
  SELECT 
    GYEJWA_NM
    ,ACNO
    ,'2' AS GUBUN_NM
    , 0 AS JEONHANDO_BAEJEONG
    , 0 AS JEONHANDO_HWANSU
    , 0 AS DANGHANDO_BAEJEONG
    , 0 AS DANGHANDO_HWANSU
    , 0 AS JEONSECHUL_JICHUL
    , 0 AS JEONSECHUL_BANNAB
    , 0 AS DANGSECHUL_JICHUL
    , 0 AS DANGSECHUL_BANNAB 
  FROM GYEJWA
  WHERE AGE = 1
  GROUP BY GYEJWA_NM, ACNO
UNION ALL
  SELECT 
    GYEJWA_NM
    ,ACNO
    ,'0' AS GUBUN_NM
    , 0 AS JEONHANDO_BAEJEONG
    , 0 AS JEONHANDO_HWANSU
    , 0 AS DANGHANDO_BAEJEONG
    , 0 AS DANGHANDO_HWANSU
    , 0 AS JEONSECHUL_JICHUL
    , 0 AS JEONSECHUL_BANNAB
    , 0 AS DANGSECHUL_JICHUL
    , 0 AS DANGSECHUL_BANNAB 
  FROM GYEJWA
  WHERE AGE IN (2,3)
  GROUP BY GYEJWA_NM, ACNO
  UNION ALL
  SELECT 
    GYEJWA_NM
    ,ACNO
    ,'3' AS GUBUN_NM
    , 0 AS JEONHANDO_BAEJEONG
    , 0 AS JEONHANDO_HWANSU
    , 0 AS DANGHANDO_BAEJEONG
    , 0 AS DANGHANDO_HWANSU
    , 0 AS JEONSECHUL_JICHUL
    , 0 AS JEONSECHUL_BANNAB
    , 0 AS DANGSECHUL_JICHUL
    , 0 AS DANGSECHUL_BANNAB 
  FROM GYEJWA
  WHERE AGE IN (0)
  GROUP BY GYEJWA_NM, ACNO
) A
GROUP BY GYEJWA_NM, ACNO, GUBUN_NM
ORDER BY ACNO, GUBUN_NM
------------------------------------------------------------------------------------------------------------------------------------------------
-- 변경후

SELECT
 A.GYEJWA_NM AS GYEJWA_NM
 , A.ACNO
 , A.GUBUN_NM
 , SUM(NVL(TO_NUMBER(A.JEONHANDO_BAEJEONG), 0)) AS JEONHANDO_BAEJEONG
 , SUM(NVL(TO_NUMBER(A.JEONHANDO_HWANSU), 0)) AS JEONHANDO_HWANSU
 , SUM(NVL(TO_NUMBER(A.DANGHANDO_BAEJEONG), 0)) AS DANGHANDO_BAEJEONG
 , SUM(NVL(TO_NUMBER(A.DANGHANDO_HWANSU), 0)) AS DANGHANDO_HWANSU
 , SUM(NVL(TO_NUMBER(A.JEONSECHUL_JICHUL), 0)) AS JEONSECHUL_JICHUL
 , SUM(NVL(TO_NUMBER(A.JEONSECHUL_BANNAB), 0)) AS JEONSECHUL_BANNAB
 , SUM(NVL(TO_NUMBER(A.DANGSECHUL_JICHUL), 0)) AS DANGSECHUL_JICHUL
 , SUM(NVL(TO_NUMBER(A.DANGSECHUL_BANNAB), 0)) AS DANGSECHUL_BANNAB
FROM (

  WITH DEPT_GYEJWA AS (
 SELECT SGG_ACNO
   FROM
 (
   SELECT ROWNUM AS R_NUM
     , A.*
     FROM 
   (
       SELECT SGM.SIGUMGO_ACNO AS SGG_ACNO
      FROM (
   
       SELECT ADM.SGG_ACNO
      FROM SFI_ORG_DEPT_C_MNG ODC
     INNER JOIN SFI_ORG_BY_DEPT_MNG OBD
       ON OBD.PADM_STD_ORG_C = ODC.PADM_STD_ORG_C
     INNER JOIN RPT_JEONJA_AC_BY_DEPT_MNG ADM
       ON ADM.GEUMGO_CODE = '28'
         AND ADM.SL_GMGO_DEPT_C = OBD.G_CC_DEPT_C
         AND (ADM.HOIKYE_YEAR = '2025' OR ADM.HOIKYE_YEAR = '9999')
         AND (ADM.USE_G = '1' OR ADM.USE_G = '2')
         AND ADM.DEL_YN = 'N'
      WHERE ('all'  = 'all'            OR ODC.REP_ORG_C = 'all') 
        AND ('all'  = 'all'            OR OBD.PADM_STD_ORG_C = 'all')
        AND ('all'  = 'all'           OR ADM.SL_GMGO_DEPT_C = 'all')
        AND ODC.DEL_YN = 'N'
      GROUP BY ADM.SGG_ACNO
        
    ) ADM
     INNER JOIN ACL_SIGUMGO_MAS_SUB SGM
       ON SIGUMGO_ORG_C = '28'
         AND SGM.SIGUMGO_ACNO = ADM.SGG_ACNO
     WHERE 1=1
       AND TO_CHAR(SGM.SIGUMGO_HOIKYE_C) = '1'
     GROUP BY SGM.SIGUMGO_ACNO
     ORDER BY SGM.SIGUMGO_ACNO
   ) A
   WHERE ROWNUM <= '2000'
 ) X
 WHERE X.R_NUM >= '0'
   AND (('02800001100000025' = 'all' AND SUBSTR(SGG_ACNO, 7, 4) <> '0110' ) OR  SGG_ACNO = '02800001100000025')
  )
  , GYEJWA AS (
  
  
    SELECT
      FIL_100_CTNT2 AS ACNO
      , SIGUMGO_AC_B AS ACB
      , SIGUMGO_AGE_AC_G AS AGE
      , SIGUMGO_AC_G AS ACG
      , SIGUMGO_AC_NM AS GYEJWA_NM
    FROM ACL_SIGUMGO_MAS
    WHERE ICH_SIGUMGO_HOIKYE_C = 1
      AND SIGUMGO_HOIKYE_YR = TO_NUMBER('2025')
      AND ( 
  FIL_100_CTNT2 IN (SELECT SGG_ACNO FROM DEPT_GYEJWA)
    OR
  (
   SIGUMGO_AGE_AC_G = 3
  AND 
   FUND_BAEJUNG_SIGUMGO_MNG_NO IN (SELECT SGG_ACNO FROM DEPT_GYEJWA)
  )
    )
      AND MNG_NO = 1      
  )
  , SLV AS (
    SELECT
        TRXDT
        , GISDT
        , FIL_100_CTNT5 AS ACNO
        , (SELECT GYEJWA_NM FROM GYEJWA WHERE ACNO = FIL_100_CTNT5) AS GYEJWA_NM
        , (SELECT ACB FROM GYEJWA WHERE ACNO = FIL_100_CTNT5) AS ACB
        , (SELECT ACG FROM GYEJWA WHERE ACNO = FIL_100_CTNT5) AS ACG
        , (SELECT AGE FROM GYEJWA WHERE ACNO = FIL_100_CTNT5) AS AGE
        , 'JG' AS G
        , LPAD(SIGUMGO_TRX_G, 2, '0') || LPAD(SIGUMGO_IP_TRX_G, 2, '0') || LPAD(SIGUMGO_JI_TRX_G, 2, '0') AS GG
        , SUM( DECODE(CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(IPJI_G, 2, -1, 1) * TRAMT ) AS AMT
      FROM ACL_SIGUMGO_SLV
      WHERE FIL_100_CTNT5 IN (SELECT ACNO FROM GYEJWA)
      AND TRXDT >= '2025' || '0101'
      GROUP BY TRXDT, GISDT, FIL_100_CTNT5, LPAD(SIGUMGO_TRX_G, 2, '0') || LPAD(SIGUMGO_IP_TRX_G, 2, '0') || LPAD(SIGUMGO_JI_TRX_G, 2, '0')

      UNION ALL

      SELECT
        TRXDT
        , GISDT
        , SIGUMGO_ACNO AS ACNO
        , (SELECT GYEJWA_NM FROM GYEJWA WHERE ACNO = SIGUMGO_ACNO) AS GYEJWA_NM
        , (SELECT ACB FROM GYEJWA WHERE ACNO = SIGUMGO_ACNO) AS ACB
        , (SELECT ACG FROM GYEJWA WHERE ACNO = SIGUMGO_ACNO) AS ACG
        , (SELECT AGE FROM GYEJWA WHERE ACNO = SIGUMGO_ACNO) AS AGE
        , 'HD' AS G
        , TO_CHAR(SIGUMGO_TRX_G) AS GG
        , SUM( DECODE(CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(IPJI_G, 2, -1, 1) * TRAMT ) AS AMT
      FROM ACL_SGGHANDO_SLV
      WHERE SIGUMGO_ACNO IN (SELECT ACNO FROM GYEJWA)
      AND TRXDT >= '2025' || '0101'
      GROUP BY TRXDT, GISDT, SIGUMGO_ACNO, SIGUMGO_TRX_G
  )

  -- 본청 => 본청지출, 일상경비
  SELECT 
    GYEJWA_NM
    , ACNO
    , '1' AS GUBUN_NM
    , SUM ( CASE WHEN GISDT < '20251204' AND GG IN ('670090', '91') THEN AMT * -1 ELSE 0 END ) AS JEONHANDO_BAEJEONG
    , SUM ( CASE WHEN GISDT < '20251204' AND GG IN ('179000', '45') THEN AMT * 1 ELSE 0 END ) AS JEONHANDO_HWANSU
    , SUM ( CASE WHEN GISDT = '20251204' AND GG IN ('670090', '91') THEN AMT * -1 ELSE 0 END ) AS DANGHANDO_BAEJEONG
    , SUM ( CASE WHEN GISDT = '20251204' AND GG IN ('179000', '45') THEN AMT * 1 ELSE 0 END ) AS DANGHANDO_HWANSU
    , SUM ( CASE WHEN GISDT < '20251204' AND GG IN ('670090', '670092') THEN AMT * -1 ELSE 0 END ) AS JEONSECHUL_JICHUL
    , SUM ( CASE WHEN GISDT < '20251204' AND GG IN ('179000', '179200') THEN AMT * 1 ELSE 0 END ) AS JEONSECHUL_BANNAB
    , SUM ( CASE WHEN GISDT = '20251204' AND GG IN ('670090', '670092') THEN AMT * -1 ELSE 0 END ) AS DANGSECHUL_JICHUL
    , SUM ( CASE WHEN GISDT = '20251204' AND GG IN ('179000', '179200') THEN AMT * 1 ELSE 0 END ) AS DANGSECHUL_BANNAB
  FROM SLV
  WHERE AGE = 1
  AND ACG <> 0
  GROUP BY GYEJWA_NM, ACNO

  UNION ALL

  -- 본청외 => 사업소, 일상경비 손
  SELECT 
    GYEJWA_NM
    , ACNO
    , '2' AS GUBUN_NM
    , SUM ( CASE WHEN GISDT < '20251204' AND GG IN ('90') THEN AMT * -1 ELSE 0 END ) AS JEONHANDO_BAEJEONG
    , SUM ( CASE WHEN GISDT < '20251204' AND GG IN ('42') THEN AMT * 1 ELSE 0 END ) AS JEONHANDO_HWANSU
    , SUM ( CASE WHEN GISDT = '20251204' AND GG IN ('90') THEN AMT * -1 ELSE 0 END ) AS DANGHANDO_BAEJEONG
    , SUM ( CASE WHEN GISDT = '20251204' AND GG IN ('42') THEN AMT * 1 ELSE 0 END ) AS DANGHANDO_HWANSU
    , SUM ( CASE WHEN GISDT < '20251204' AND GG IN ('670091', '670093') THEN AMT * -1 ELSE 0 END ) AS JEONSECHUL_JICHUL
    , SUM ( CASE WHEN GISDT < '20251204' AND GG IN ('179100', '179300') THEN AMT * 1 ELSE 0 END ) AS JEONSECHUL_BANNAB
    , SUM ( CASE WHEN GISDT = '20251204' AND GG IN ('670091', '670093') THEN AMT * -1 ELSE 0 END ) AS DANGSECHUL_JICHUL
    , SUM ( CASE WHEN GISDT = '20251204' AND GG IN ('179100', '179300') THEN AMT * 1 ELSE 0 END ) AS DANGSECHUL_BANNAB
  FROM SLV
  WHERE AGE = 1
  AND ACG <> 0
  GROUP BY GYEJWA_NM, ACNO

  UNION ALL

  -- 자계좌 
  SELECT 
    GYEJWA_NM
    , ACNO
    , '0' AS GUBUN_NM
    , SUM ( CASE WHEN GISDT < '20251204' AND GG IN ('40', '41', '91') THEN AMT
        ELSE 0 END ) AS JEONHANDO_BAEJEONG
    , SUM ( CASE WHEN GISDT < '20251204' AND GG IN ('45', '92', '95') THEN AMT * -1 ELSE 0 END ) AS JEONHANDO_HWANSU
    , SUM ( CASE WHEN GISDT = '20251204' AND GG IN ('40', '41', '91') THEN AMT
        ELSE 0 END ) AS DANGHANDO_BAEJEONG
    , SUM ( CASE WHEN GISDT = '20251204' AND GG IN ('45', '92', '95') THEN AMT * -1 ELSE 0 END ) AS DANGHANDO_HWANSU
    , SUM ( CASE WHEN GISDT < '20251204' AND GG IN ('670091', '670092', '670093') THEN AMT * -1 ELSE 0 END ) AS JEONSECHUL_JICHUL
    , SUM ( CASE WHEN GISDT < '20251204' AND GG IN ('179100', '179200', '179300') THEN AMT * 1 ELSE 0 END ) AS JEONSECHUL_BANNAB
    , SUM ( CASE WHEN GISDT = '20251204' AND GG IN ('670091', '670092', '670093') THEN AMT * -1 ELSE 0 END ) AS DANGSECHUL_JICHUL
    , SUM ( CASE WHEN GISDT = '20251204' AND GG IN ('179100', '179200', '179300') THEN AMT * 1 ELSE 0 END ) AS DANGSECHUL_BANNAB
  FROM SLV
  WHERE AGE IN (2, 3)
  AND ACG <> 0
  GROUP BY GYEJWA_NM, ACNO
-- 거래내역이 없어도 목록이 보이도록 처리 
  UNION ALL
  SELECT 
    GYEJWA_NM
    ,ACNO
    ,'1' AS GUBUN_NM
    , 0 AS JEONHANDO_BAEJEONG
    , 0 AS JEONHANDO_HWANSU
    , 0 AS DANGHANDO_BAEJEONG
    , 0 AS DANGHANDO_HWANSU
    , 0 AS JEONSECHUL_JICHUL
    , 0 AS JEONSECHUL_BANNAB
    , 0 AS DANGSECHUL_JICHUL
    , 0 AS DANGSECHUL_BANNAB 
  FROM GYEJWA
  WHERE AGE = 1
  AND ACG <> 0
  GROUP BY GYEJWA_NM, ACNO
  UNION ALL
  SELECT 
    GYEJWA_NM
    ,ACNO
    ,'2' AS GUBUN_NM
    , 0 AS JEONHANDO_BAEJEONG
    , 0 AS JEONHANDO_HWANSU
    , 0 AS DANGHANDO_BAEJEONG
    , 0 AS DANGHANDO_HWANSU
    , 0 AS JEONSECHUL_JICHUL
    , 0 AS JEONSECHUL_BANNAB
    , 0 AS DANGSECHUL_JICHUL
    , 0 AS DANGSECHUL_BANNAB 
  FROM GYEJWA
  WHERE AGE = 1
  AND ACG <> 0
  GROUP BY GYEJWA_NM, ACNO
UNION ALL
  SELECT 
    GYEJWA_NM
    ,ACNO
    ,'0' AS GUBUN_NM
    , 0 AS JEONHANDO_BAEJEONG
    , 0 AS JEONHANDO_HWANSU
    , 0 AS DANGHANDO_BAEJEONG
    , 0 AS DANGHANDO_HWANSU
    , 0 AS JEONSECHUL_JICHUL
    , 0 AS JEONSECHUL_BANNAB
    , 0 AS DANGSECHUL_JICHUL
    , 0 AS DANGSECHUL_BANNAB 
  FROM GYEJWA
  WHERE AGE IN (2,3)
  AND ACG <> 0
  GROUP BY GYEJWA_NM, ACNO
  UNION ALL
  SELECT 
    GYEJWA_NM
    ,ACNO
    ,'3' AS GUBUN_NM
    , 0 AS JEONHANDO_BAEJEONG
    , 0 AS JEONHANDO_HWANSU
    , 0 AS DANGHANDO_BAEJEONG
    , 0 AS DANGHANDO_HWANSU
    , 0 AS JEONSECHUL_JICHUL
    , 0 AS JEONSECHUL_BANNAB
    , 0 AS DANGSECHUL_JICHUL
    , 0 AS DANGSECHUL_BANNAB 
  FROM GYEJWA
  WHERE ACG = 0
  GROUP BY GYEJWA_NM, ACNO
) A
GROUP BY GYEJWA_NM, ACNO, GUBUN_NM
ORDER BY ACNO, GUBUN_NM