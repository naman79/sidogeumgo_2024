select * from rpt_sunap_jibgye_seipe
order by sunapil desc


select * from RPT_SUNAP_JIBGYE
order by sunapil desc


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
                                    WHEN ILJA >= '20240401'  AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 90 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401'  AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 90 THEN IPGEUM_AMT*-1
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 91 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 45  THEN  IPGEUM_AMT*-1
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 90 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 42  THEN  IPGEUM_AMT*-1
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 40 THEN  IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 92  THEN  JIGEUB_AMT*-1
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 41 THEN  IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 95  THEN  JIGEUB_AMT*-1                                    
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 41 THEN  IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 95  THEN  JIGEUB_AMT*-1
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
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 90 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 90 THEN IPGEUM_AMT*-1
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 91 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 45 THEN IPGEUM_AMT*-1
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 91 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 91 THEN IPGEUM_AMT * -1
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT * -1
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 91 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 91 THEN IPGEUM_AMT * -1
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 91 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 45 THEN IPGEUM_AMT*-1
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 92 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 92 THEN IPGEUM_AMT * -1
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT * -1
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT * -1
                                    ELSE 0 END JUNWOL_JICHUL,
                                CASE 
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 90 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 91 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 91 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 91 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 91 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 92 THEN JIGEUB_AMT            
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    ELSE 0 END DANGWOL_JICHUL,
                                CASE 
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 90 THEN IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 91 THEN IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 45  THEN  IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 91 THEN IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 45  THEN  IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 92 THEN IPGEUM_AMT                                                
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT
                                    ELSE 0 END DANGWOL_YUIP,
                                0 DANGWOL_GYULJUNG             
                        FROM (
                                SELECT  A.FIL_100_CTNT5 GONGGEUM_GYEJWA, B.SIGUMGO_AC_NM GONGGEUM_GYEJWA_NM,
                                A.ICH_SIGUMGO_HOIKYE_C HOIGYE_CODE, A.ICH_SIGUMGO_GUN_GU_C GUNGU_CODE,
                                                B.SIGUMGO_AGE_AC_G,
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
                                  AND A.GISDT BETWEEN '20230101'  AND '20240417'
                                  AND A.SIGUMGO_TRX_G IN (17, 67)
                                  AND (SUBSTR(A.FIL_100_CTNT5,4,3) <> '900' OR SUBSTR(A.FIL_100_CTNT5,7,2) <> '90')
                                  AND A.ICH_SIGUMGO_HOIKYE_C = B.ICH_SIGUMGO_HOIKYE_C
                                  AND A.SIGUMGO_HOIKYE_YR = '2023'
    
                                            AND A.ICH_SIGUMGO_HOIKYE_C = '1'
                                              
                                        AND A.FIL_100_CTNT5 = '02800001100000023'
                                    
                        UNION ALL
                            SELECT A.SIGUMGO_ACNO GONGGEUM_GYEJWA, B.SIGUMGO_AC_NM GONGGEUM_GYEJWA_NM
                                , A.ICH_SIGUMGO_HOIKYE_C HOIGYE_CODE, A.ICH_SIGUMGO_GUN_GU_C GUNGU_CODE,
                                B.SIGUMGO_AGE_AC_G,
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
                                AND A.GISDT BETWEEN '20230101'  AND '20240417'  
                                AND A.SIGUMGO_TRX_G IN (90,91,92,95,40,41,42,45)
                                AND (SUBSTR(A.SIGUMGO_ACNO,4,3) <> '900' OR SUBSTR(A.SIGUMGO_ACNO,7,2) <> '90')
                                AND A.ICH_SIGUMGO_HOIKYE_C = B.ICH_SIGUMGO_HOIKYE_C
                                AND A.SIGUMGO_HOIKYE_YR = '2023'          
    
                                            AND A.ICH_SIGUMGO_HOIKYE_C = '1'
                                              
                                        AND A.SIGUMGO_ACNO = '02800001100000023'
                                                      
                        UNION ALL

                        SELECT A.FIL_100_CTNT2 GONGGEUM_GYEJWA,
                               A.SIGUMGO_AC_NM GONGGEUM_GYEJWA_NM, 
                               ICH_SIGUMGO_HOIKYE_C GONGGEUM_HOIGYE_CODE,
                               A.ICH_SIGUMGO_GUN_GU_C GONGGEUM_GUNGU_CODE,
                               A.SIGUMGO_AGE_AC_G, 
                               B.GUNGU_NAME,
                               TO_CHAR(A.SIGUMGO_HOIKYE_YR), 
                               0 YEAR_GUBUN, 
                               67 GEORAE_GUBUN, 
                               0 IPGEUM_GEORAE, 
                               0 JIGEUB_GEORAE,
                               '20240417'  AS ILJA,
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
                           AND A.SIGUMGO_HOIKYE_YR = '2023'
    
                                        AND A.ICH_SIGUMGO_HOIKYE_C = '1'
                                          
                                    AND A.FIL_100_CTNT2 = '02800001100000023'
                                       
                        
                        ) A
                ) A
                GROUP BY A.GONGGEUM_GYEJWA_NM, A.GUNGU_CODE, A.GUNGU_NAME, A.GONGGEUM_GYEJWA
                ORDER BY A.GONGGEUM_GYEJWA_NM, A.GUNGU_CODE, A.GUNGU_NAME, A.GONGGEUM_GYEJWA
        ) ORG
    WHERE ROWNUM  <=  '2000') LIST
WHERE LIST.RN  >  '0'

-----------------------------

SELECT LIST.RN
        , LIST.BAEJUNG_NUGYE 
        , LIST.BON_ILSANG_NUGYE 
        , LIST.BON_NOTILSANG_NUGYE       
    FROM ( 
        SELECT ORG.*
         FROM (
                SELECT  ROW_NUMBER() OVER (ORDER BY A.GONGGEUM_GYEJWA_NM, A.GUNGU_NAME )  RN
                        ,A.GONGGEUM_GYEJWA_NM                                                                            
                        ,'(' || A.GUNGU_CODE || ')' ||  A.GUNGU_NAME AS GUNGU_NAME                                         
                        ,SUM(A.DANGWOL_BAEJUNG) AS DANGWOL_BAEJUNG                                                                
                        ,SUM(A.BAEJUNG_NUGYE) AS BAEJUNG_NUGYE   
                        ,SUM(A.BON_ILSANG_NUGYE) AS BON_ILSANG_NUGYE 
                        ,SUM(A.BON_NOTILSANG_NUGYE) AS BON_NOTILSANG_NUGYE                                                                
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
                                    WHEN ILJA >= '20240401'  AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 90 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401'  AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 90 THEN IPGEUM_AMT*-1
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 91 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 45  THEN  IPGEUM_AMT*-1
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 90 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 42  THEN  IPGEUM_AMT*-1
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 40 THEN  IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 92  THEN  JIGEUB_AMT*-1
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 41 THEN  IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 95  THEN  JIGEUB_AMT*-1                                    
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 41 THEN  IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 95  THEN  JIGEUB_AMT*-1
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
                                    WHEN SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 90 THEN JIGEUB_AMT
                                    WHEN SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 90 THEN IPGEUM_AMT*-1                                        
                                    ELSE 0 END BON_ILSANG_NUGYE,    
CASE                                      
                                    WHEN SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 91 THEN JIGEUB_AMT
                                    WHEN SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 45  THEN  IPGEUM_AMT*-1
                                    WHEN SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 90 THEN JIGEUB_AMT
                                    WHEN SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 42  THEN  IPGEUM_AMT*-1
                                    ELSE 0 END BON_NOTILSANG_NUGYE,                                    
                                CASE 
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 90 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 90 THEN IPGEUM_AMT*-1
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 91 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 45 THEN IPGEUM_AMT*-1
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 91 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 91 THEN IPGEUM_AMT * -1
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT * -1
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 91 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 91 THEN IPGEUM_AMT * -1
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 91 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 45 THEN IPGEUM_AMT*-1
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 92 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 92 THEN IPGEUM_AMT * -1
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT * -1
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT * -1
                                    ELSE 0 END JUNWOL_JICHUL,
                                CASE 
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 90 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 91 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 91 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 91 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 91 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 92 THEN JIGEUB_AMT            
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    ELSE 0 END DANGWOL_JICHUL,
                                CASE 
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 90 THEN IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 91 THEN IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 45  THEN  IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 91 THEN IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 45  THEN  IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 92 THEN IPGEUM_AMT                                                
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT
                                    ELSE 0 END DANGWOL_YUIP,
                                0 DANGWOL_GYULJUNG             
                        FROM (
                                SELECT  A.FIL_100_CTNT5 GONGGEUM_GYEJWA, B.SIGUMGO_AC_NM GONGGEUM_GYEJWA_NM,
                                A.ICH_SIGUMGO_HOIKYE_C HOIGYE_CODE, A.ICH_SIGUMGO_GUN_GU_C GUNGU_CODE,
                                                B.SIGUMGO_AGE_AC_G,
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
                                  AND A.GISDT BETWEEN '20230101'  AND '20240417'
                                  AND A.SIGUMGO_TRX_G IN (17, 67)
                                  AND (SUBSTR(A.FIL_100_CTNT5,4,3) <> '900' OR SUBSTR(A.FIL_100_CTNT5,7,2) <> '90')
                                  AND A.ICH_SIGUMGO_HOIKYE_C = B.ICH_SIGUMGO_HOIKYE_C
                                  AND A.SIGUMGO_HOIKYE_YR = '2023'
    
                                            AND A.ICH_SIGUMGO_HOIKYE_C = '1'
                                              
                                        AND A.FIL_100_CTNT5 = '02800001100000023'
                                    
                        UNION ALL
                            SELECT A.SIGUMGO_ACNO GONGGEUM_GYEJWA, B.SIGUMGO_AC_NM GONGGEUM_GYEJWA_NM
                                , A.ICH_SIGUMGO_HOIKYE_C HOIGYE_CODE, A.ICH_SIGUMGO_GUN_GU_C GUNGU_CODE,
                                B.SIGUMGO_AGE_AC_G,
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
                                AND A.GISDT BETWEEN '20230101'  AND '20240417'  
                                AND A.SIGUMGO_TRX_G IN (90,91,92,95,40,41,42,45)
                                AND (SUBSTR(A.SIGUMGO_ACNO,4,3) <> '900' OR SUBSTR(A.SIGUMGO_ACNO,7,2) <> '90')
                                AND A.ICH_SIGUMGO_HOIKYE_C = B.ICH_SIGUMGO_HOIKYE_C
                                AND A.SIGUMGO_HOIKYE_YR = '2023'          
    
                                            AND A.ICH_SIGUMGO_HOIKYE_C = '1'
                                              
                                        AND A.SIGUMGO_ACNO = '02800001100000023'
                                                      
                        UNION ALL

                        SELECT A.FIL_100_CTNT2 GONGGEUM_GYEJWA,
                               A.SIGUMGO_AC_NM GONGGEUM_GYEJWA_NM, 
                               ICH_SIGUMGO_HOIKYE_C GONGGEUM_HOIGYE_CODE,
                               A.ICH_SIGUMGO_GUN_GU_C GONGGEUM_GUNGU_CODE,
                               A.SIGUMGO_AGE_AC_G, 
                               B.GUNGU_NAME,
                               TO_CHAR(A.SIGUMGO_HOIKYE_YR), 
                               0 YEAR_GUBUN, 
                               67 GEORAE_GUBUN, 
                               0 IPGEUM_GEORAE, 
                               0 JIGEUB_GEORAE,
                               '20240417'  AS ILJA,
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
                           AND A.SIGUMGO_HOIKYE_YR = '2023'
    
                                        AND A.ICH_SIGUMGO_HOIKYE_C = '1'
                                          
                                    AND A.FIL_100_CTNT2 = '02800001100000023'
                                       
                        
                        ) A
                ) A
                GROUP BY A.GONGGEUM_GYEJWA_NM, A.GUNGU_CODE, A.GUNGU_NAME, A.GONGGEUM_GYEJWA
                ORDER BY A.GONGGEUM_GYEJWA_NM, A.GUNGU_CODE, A.GUNGU_NAME, A.GONGGEUM_GYEJWA
        ) ORG
    WHERE ROWNUM  <=  '2000') LIST
WHERE LIST.RN  >  '0'


-- 10342259384816
-- 9241939382253
-- 1100320002563

--------------------------


SELECT LIST.RN
        , LIST.BAEJUNG_NUGYE 
        , LIST.BON_ILSANG_NUGYE 
        , LIST.BON_NOTILSANG_NUGYE      
    FROM ( 
        SELECT ORG.*
         FROM (
                SELECT  ROW_NUMBER() OVER (ORDER BY A.GONGGEUM_GYEJWA_NM, A.GUNGU_NAME )  RN
                        ,A.GONGGEUM_GYEJWA_NM                                                                            
                        ,'(' || A.GUNGU_CODE || ')' ||  A.GUNGU_NAME AS GUNGU_NAME                                         
                        ,SUM(A.DANGWOL_BAEJUNG) AS DANGWOL_BAEJUNG                                                                
                        ,SUM(A.BAEJUNG_NUGYE) AS BAEJUNG_NUGYE  
                        ,SUM(A.BON_ILSANG_NUGYE) AS BON_ILSANG_NUGYE 
                        ,SUM(A.BON_NOTILSANG_NUGYE) AS BON_NOTILSANG_NUGYE                                                                   
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
                                    WHEN ILJA >= '20240401'  AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 90 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401'  AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 90 THEN IPGEUM_AMT*-1
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 91 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 45  THEN  IPGEUM_AMT*-1
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 90 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 42  THEN  IPGEUM_AMT*-1
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 40 THEN  IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 92  THEN  JIGEUB_AMT*-1
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 41 THEN  IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 95  THEN  JIGEUB_AMT*-1                                    
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 41 THEN  IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 95  THEN  JIGEUB_AMT*-1
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
                                    WHEN SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 90 THEN JIGEUB_AMT
                                    WHEN SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 90 THEN IPGEUM_AMT*-1                                        
                                    ELSE 0 END BON_ILSANG_NUGYE,    
CASE                                      
                                    WHEN SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 91 THEN JIGEUB_AMT
                                    WHEN SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 45  THEN  IPGEUM_AMT*-1
                                    WHEN SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 90 THEN JIGEUB_AMT
                                    WHEN SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 42  THEN  IPGEUM_AMT*-1
                                    ELSE 0 END BON_NOTILSANG_NUGYE,                                      
                                CASE 
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 90 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 90 THEN IPGEUM_AMT*-1
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 91 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 45 THEN IPGEUM_AMT*-1
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 91 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 91 THEN IPGEUM_AMT * -1
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT * -1
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 91 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 91 THEN IPGEUM_AMT * -1
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 91 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 45 THEN IPGEUM_AMT*-1
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 92 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 92 THEN IPGEUM_AMT * -1
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT * -1
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT * -1
                                    ELSE 0 END JUNWOL_JICHUL,
                                CASE 
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 90 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 91 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 91 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 91 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 91 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 92 THEN JIGEUB_AMT            
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    ELSE 0 END DANGWOL_JICHUL,
                                CASE 
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 90 THEN IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 91 THEN IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 45  THEN  IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 91 THEN IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 45  THEN  IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 92 THEN IPGEUM_AMT                                                
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT
                                    ELSE 0 END DANGWOL_YUIP,
                                0 DANGWOL_GYULJUNG             
                        FROM (
                                SELECT  A.FIL_100_CTNT5 GONGGEUM_GYEJWA, B.SIGUMGO_AC_NM GONGGEUM_GYEJWA_NM,
                                A.ICH_SIGUMGO_HOIKYE_C HOIGYE_CODE, A.ICH_SIGUMGO_GUN_GU_C GUNGU_CODE,
                                                B.SIGUMGO_AGE_AC_G,
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
                                  AND A.GISDT BETWEEN '20230101'  AND '20240417'
                                  AND A.SIGUMGO_TRX_G IN (17, 67)
                                  AND (SUBSTR(A.FIL_100_CTNT5,4,3) <> '900' OR SUBSTR(A.FIL_100_CTNT5,7,2) <> '90')
                                  AND A.ICH_SIGUMGO_HOIKYE_C = B.ICH_SIGUMGO_HOIKYE_C
                                  AND A.SIGUMGO_HOIKYE_YR = '2023'
  
                                        AND A.ICH_SIGUMGO_GUN_GU_C = '237'
                                        
                                            AND A.ICH_SIGUMGO_HOIKYE_C = '1'
                                              
                                        AND A.FIL_100_CTNT5 = '02823701100000023'
                                    
                        UNION ALL
                            SELECT A.SIGUMGO_ACNO GONGGEUM_GYEJWA, B.SIGUMGO_AC_NM GONGGEUM_GYEJWA_NM
                                , A.ICH_SIGUMGO_HOIKYE_C HOIGYE_CODE, A.ICH_SIGUMGO_GUN_GU_C GUNGU_CODE,
                                B.SIGUMGO_AGE_AC_G,
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
                                AND A.GISDT BETWEEN '20230101'  AND '20240417'  
                                AND A.SIGUMGO_TRX_G IN (90,91,92,95,40,41,42,45)
                                AND (SUBSTR(A.SIGUMGO_ACNO,4,3) <> '900' OR SUBSTR(A.SIGUMGO_ACNO,7,2) <> '90')
                                AND A.ICH_SIGUMGO_HOIKYE_C = B.ICH_SIGUMGO_HOIKYE_C
                                AND A.SIGUMGO_HOIKYE_YR = '2023'          
  
                                        AND A.ICH_SIGUMGO_GUN_GU_C = '237'
                                        
                                            AND A.ICH_SIGUMGO_HOIKYE_C = '1'
                                              
                                        AND A.SIGUMGO_ACNO = '02823701100000023'
                                                      
                        UNION ALL

                        SELECT A.FIL_100_CTNT2 GONGGEUM_GYEJWA,
                               A.SIGUMGO_AC_NM GONGGEUM_GYEJWA_NM, 
                               ICH_SIGUMGO_HOIKYE_C GONGGEUM_HOIGYE_CODE,
                               A.ICH_SIGUMGO_GUN_GU_C GONGGEUM_GUNGU_CODE,
                               A.SIGUMGO_AGE_AC_G, 
                               B.GUNGU_NAME,
                               TO_CHAR(A.SIGUMGO_HOIKYE_YR), 
                               0 YEAR_GUBUN, 
                               67 GEORAE_GUBUN, 
                               0 IPGEUM_GEORAE, 
                               0 JIGEUB_GEORAE,
                               '20240417'  AS ILJA,
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
                           AND A.SIGUMGO_HOIKYE_YR = '2023'
  
                                    AND A.ICH_SIGUMGO_GUN_GU_C = '237'
                                    
                                        AND A.ICH_SIGUMGO_HOIKYE_C = '1'
                                          
                                    AND A.FIL_100_CTNT2 = '02823701100000023'
                                       
                        
                        ) A
                ) A
                GROUP BY A.GONGGEUM_GYEJWA_NM, A.GUNGU_CODE, A.GUNGU_NAME, A.GONGGEUM_GYEJWA
                ORDER BY A.GONGGEUM_GYEJWA_NM, A.GUNGU_CODE, A.GUNGU_NAME, A.GONGGEUM_GYEJWA
        ) ORG
    WHERE ROWNUM  <=  '2000') LIST
WHERE LIST.RN  >  '0'

-------------------------------------------------------

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
                                    WHEN ILJA >= '20240401'  AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 90 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401'  AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 90 THEN IPGEUM_AMT*-1
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 91 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 45  THEN  IPGEUM_AMT*-1
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 90 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 42  THEN  IPGEUM_AMT*-1
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 40 THEN  IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 92  THEN  JIGEUB_AMT*-1
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 41 THEN  IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 95  THEN  JIGEUB_AMT*-1                                    
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 41 THEN  IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 95  THEN  JIGEUB_AMT*-1
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
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 90 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 90 THEN IPGEUM_AMT*-1
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 91 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 45 THEN IPGEUM_AMT*-1
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 91 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 91 THEN IPGEUM_AMT * -1
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT * -1
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 91 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 91 THEN IPGEUM_AMT * -1
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 91 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 45 THEN IPGEUM_AMT*-1
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 92 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 92 THEN IPGEUM_AMT * -1
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT * -1
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    WHEN ILJA < '20240401' AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT * -1
                                    ELSE 0 END JUNWOL_JICHUL,
                                CASE 
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 90 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 91 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 91 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 91 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 91 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 92 THEN JIGEUB_AMT            
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 67 AND JIGEUB_GEORAE = 93 THEN JIGEUB_AMT
                                    ELSE 0 END DANGWOL_JICHUL,
                                CASE 
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 90 THEN IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 91 THEN IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 1 AND GEORAE_GUBUN = 45  THEN  IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 91 THEN IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 45  THEN  IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 92 THEN IPGEUM_AMT                                                
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 2 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT
                                    WHEN ILJA >= '20240401' AND SIGUMGO_AGE_AC_G = 3 AND GEORAE_GUBUN = 17 AND IPGEUM_GEORAE = 93 THEN IPGEUM_AMT
                                    ELSE 0 END DANGWOL_YUIP,
                                0 DANGWOL_GYULJUNG             
                        FROM (
                                SELECT  A.FIL_100_CTNT5 GONGGEUM_GYEJWA, B.SIGUMGO_AC_NM GONGGEUM_GYEJWA_NM,
                                A.ICH_SIGUMGO_HOIKYE_C HOIGYE_CODE, A.ICH_SIGUMGO_GUN_GU_C GUNGU_CODE,
                                                B.SIGUMGO_AGE_AC_G,
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
                                  AND A.GISDT BETWEEN '20230101'  AND '20240417'
                                  AND A.SIGUMGO_TRX_G IN (17, 67)
                                  AND (SUBSTR(A.FIL_100_CTNT5,4,3) <> '900' OR SUBSTR(A.FIL_100_CTNT5,7,2) <> '90')
                                  AND A.ICH_SIGUMGO_HOIKYE_C = B.ICH_SIGUMGO_HOIKYE_C
                                  AND A.SIGUMGO_HOIKYE_YR = '2023'
  
                                        AND A.ICH_SIGUMGO_GUN_GU_C = '237'
                                        
                                            AND A.ICH_SIGUMGO_HOIKYE_C = '1'
                                              
                                        AND A.FIL_100_CTNT5 = '02823701100000023'
                                    
                        UNION ALL
                            SELECT A.SIGUMGO_ACNO GONGGEUM_GYEJWA, B.SIGUMGO_AC_NM GONGGEUM_GYEJWA_NM
                                , A.ICH_SIGUMGO_HOIKYE_C HOIGYE_CODE, A.ICH_SIGUMGO_GUN_GU_C GUNGU_CODE,
                                B.SIGUMGO_AGE_AC_G,
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
                                AND A.GISDT BETWEEN '20230101'  AND '20240417'  
                                AND A.SIGUMGO_TRX_G IN (90,91,92,95,40,41,42,45)
                                AND (SUBSTR(A.SIGUMGO_ACNO,4,3) <> '900' OR SUBSTR(A.SIGUMGO_ACNO,7,2) <> '90')
                                AND A.ICH_SIGUMGO_HOIKYE_C = B.ICH_SIGUMGO_HOIKYE_C
                                AND A.SIGUMGO_HOIKYE_YR = '2023'          
  
                                        AND A.ICH_SIGUMGO_GUN_GU_C = '237'
                                        
                                            AND A.ICH_SIGUMGO_HOIKYE_C = '1'
                                              
                                        AND A.SIGUMGO_ACNO = '02823701100000023'
                                                      
                        UNION ALL

                        SELECT A.FIL_100_CTNT2 GONGGEUM_GYEJWA,
                               A.SIGUMGO_AC_NM GONGGEUM_GYEJWA_NM, 
                               ICH_SIGUMGO_HOIKYE_C GONGGEUM_HOIGYE_CODE,
                               A.ICH_SIGUMGO_GUN_GU_C GONGGEUM_GUNGU_CODE,
                               A.SIGUMGO_AGE_AC_G, 
                               B.GUNGU_NAME,
                               TO_CHAR(A.SIGUMGO_HOIKYE_YR), 
                               0 YEAR_GUBUN, 
                               67 GEORAE_GUBUN, 
                               0 IPGEUM_GEORAE, 
                               0 JIGEUB_GEORAE,
                               '20240417'  AS ILJA,
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
                           AND A.SIGUMGO_HOIKYE_YR = '2023'
  
                                    AND A.ICH_SIGUMGO_GUN_GU_C = '237'
                                    
                                        AND A.ICH_SIGUMGO_HOIKYE_C = '1'
                                          
                                    AND A.FIL_100_CTNT2 = '02823701100000023'
                                       
                        
                        ) A
                ) A
                GROUP BY A.GONGGEUM_GYEJWA_NM, A.GUNGU_CODE, A.GUNGU_NAME, A.GONGGEUM_GYEJWA
                ORDER BY A.GONGGEUM_GYEJWA_NM, A.GUNGU_CODE, A.GUNGU_NAME, A.GONGGEUM_GYEJWA
        ) ORG
    WHERE ROWNUM  <=  '2000') LIST
WHERE LIST.RN  >  '0'

