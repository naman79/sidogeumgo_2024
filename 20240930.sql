select * from rpt_unyong_gyejwa
where 1=1
and mkdt >= '20240927'
and GEUMGO_CODE = 110
order by mkdt desc

------------------------------------------------------------------\
-- 구청별수납일계표 충당금 확인 요청건

SELECT
              G.GUNGU_CODE
             ,G.GUNGU_NAME
             ,G.LVL KUBUN
             ,SUM(NVL(BONSE_CNT,0) ) AS BONSE_CNT
             ,SUM(NVL(BONSE_AMT ,0) ) AS BONSE_AMT
             ,SUM(NVL(SEWOI_CNT ,0) ) AS SEWOI_CNT
             ,SUM(NVL(SEWOI_AMT ,0) ) AS SEWOI_AMT
             ,SUM(NVL(GYOYUKSE_AMT ,0) ) AS GYOYUKSE_AMT
             ,SUM(NVL(NONGTEUKSE_AMT,0) ) AS NONGTEUKSE_AMT
             ,SUM(NVL(BONSE_CNT,0) + NVL(SEWOI_CNT ,0)) AS SUM_CNT
             ,SUM(NVL(BONSE_AMT ,0) + NVL(SEWOI_AMT ,0) + NVL(GYOYUKSE_AMT ,0) + NVL(NONGTEUKSE_AMT,0)) AS SUM_AMT
        FROM (
    

       SELECT (CASE WHEN T.GUNGU_CODE > 7000 THEN T.GUNGU_CODE-7000 ELSE T.GUNGU_CODE END) GUNGU_CODE
             ,T.JIBGYE_CODE, T.KUBUN
             ,SUM(NVL(BONSE_CNT,0) ) AS BONSE_CNT
             ,SUM(NVL(BONSE_AMT ,0) ) AS BONSE_AMT
             ,SUM(NVL(SEWOI_CNT ,0) ) AS SEWOI_CNT
             ,SUM(NVL(SEWOI_AMT ,0) ) AS SEWOI_AMT
             ,SUM(NVL(GYOYUKSE_AMT ,0) ) AS GYOYUKSE_AMT
             ,SUM(NVL(NONGTEUKSE_AMT,0) ) AS NONGTEUKSE_AMT
         FROM(
             SELECT CASE WHEN A.GUNGU_CODE = 7000 THEN 7100 ELSE A.GUNGU_CODE END GUNGU_CODE,
                    CASE WHEN A.JIBGYE_CODE = 213000 THEN 217100 ELSE A.JIBGYE_CODE END JIBGYE_CODE,
                    CASE WHEN A.GEORAE_GUBUN = 1 THEN 2
                         WHEN A.GEORAE_GUBUN = 3 THEN 6
                                                 ELSE 1 END KUBUN,
                    A.BONSE_CNT,
                    A.BONSE_AMT * DECODE(A.GEORAE_GUBUN,3,-1,1) BONSE_AMT,
                    A.SEWOI_CNT,
                    A.SEWOI_AMT * DECODE(A.GEORAE_GUBUN,3,-1,1) SEWOI_AMT,
                    A.GYOYUKSE_AMT * DECODE(A.GEORAE_GUBUN,3,-1,1) GYOYUKSE_AMT,
                    A.NONGTEUKSE_AMT * DECODE(A.GEORAE_GUBUN,3,-1,1) NONGTEUKSE_AMT
               FROM RPT_SUNAP_JIBGYE A
              WHERE A.GEUMGO_CODE = '28'
                AND A.SUNAPIL = '20240909'
                AND A.JIBGYE_CODE IN
                   (103000, 104000, 209330, 209331, 209332, 209333, 200010, 200020, 213000, 215300, 217100, 300000, 304000)
                AND NOT ( A.JIBGYE_CODE = 213000 AND A.KEORAEIL <> A.SUNAPIL )
                AND ( ( 0 IN (1,5,9) AND A.YEAR_GUBUN = 0 ) OR
                      ( 0 = 8        AND A.YEAR_GUBUN IN (5,9) ) OR
                      ( 0 = 0 ) )
        
                         AND A.GUNGU_CODE IN ( 60 , (60 + 7000) )
                       

    
             UNION ALL

             SELECT CASE WHEN A.GUNGU_CODE = 7000 THEN 7100 ELSE A.GUNGU_CODE END GUNGU_CODE,
                    CASE WHEN A.JIBGYE_CODE = 213000 THEN 217100 ELSE A.JIBGYE_CODE END JIBGYE_CODE,
                    CASE WHEN A.JOJEONG_GUBUN <> 2 THEN 3 ELSE 7 END KUBUN,
                    A.JIBANGSE_CNT BONSE_CNT,
                    A.JIBANGSE_AMT * DECODE(A.IPJI_GUBUN,1,1,-1) BONSE_AMT,
                    0 SEWOI_CNT,
                    A.SEWOI_AMT * DECODE(A.IPJI_GUBUN,1,1,-1) SEWOI_AMT,
                    A.GYOYUKSE_AMT * DECODE(A.IPJI_GUBUN,1,1,-1) GYOYUKSE_AMT,
                    A.NONGTEUKSE_AMT * DECODE(A.IPJI_GUBUN,1,1,-1) NONGTEUKSE_AMT
               FROM RPT_DANGSEIPJOJEONG A
              WHERE A.GEUMGO_CODE = '28'
                AND A.SUNAPIL = '20240909'
                AND A.JIBGYE_CODE IN
                   (103000, 104000, 209330, 209331, 209332, 209333, 200010, 200020, 213000, 215300, 217100, 300000, 304000)
                AND ( ( 0 IN (1,5,9) AND A.YEAR_GUBUN = 0 ) OR
                      ( 0 = 8        AND A.YEAR_GUBUN IN (5,9) ) OR
                      ( 0 = 0 ) )
        
                         AND A.GUNGU_CODE IN ( 60 , (60 + 7000) )
                       
             UNION ALL
             SELECT CASE WHEN A.GUNGU_CODE = 7000 THEN 7100 ELSE A.GUNGU_CODE END GUNGU_CODE,
                    CASE WHEN A.JIBGYE_CODE = 213000 THEN 217100 ELSE A.JIBGYE_CODE END JIBGYE_CODE,
                    CASE WHEN A.GEORAE_GUBUN = 1 THEN 5
                         WHEN A.GEORAE_GUBUN = 3 THEN 8
                                                 ELSE 4 END KUBUN,
                    A.BONSE_CNT,
                    A.BONSE_AMT * DECODE(A.GEORAE_GUBUN,3,-1,1) BONSE_AMT,
                    A.SEWOI_CNT,
                    A.SEWOI_AMT * DECODE(A.GEORAE_GUBUN,3,-1,1) SEWOI_AMT,
                    A.GYOYUKSE_AMT * DECODE(A.GEORAE_GUBUN,3,-1,1) GYOYUKSE_AMT,
                    A.NONGTEUKSE_AMT * DECODE(A.GEORAE_GUBUN,3,-1,1) NONGTEUKSE_AMT
               FROM RPT_SUNAP_JIBGYE A
              WHERE A.GEUMGO_CODE = '28'
                AND A.SUNAPIL BETWEEN '20240901' AND '20240909'
                AND A.JIBGYE_CODE IN
                    (103000, 104000, 209330, 209331, 209332, 209333, 200010, 200020, 213000, 215300, 217100, 300000, 304000)
                AND NOT ( A.JIBGYE_CODE = 213000 AND A.KEORAEIL <> A.SUNAPIL )
                AND ( ( 0 IN (1,5,9) AND A.YEAR_GUBUN = 0 ) OR
                      ( 0 = 8        AND A.YEAR_GUBUN IN (5,9) ) OR
                      ( 0 = 0 ) )
        
                         AND A.GUNGU_CODE IN ( 60 , (60 + 7000) )
                       
             UNION ALL
             SELECT CASE WHEN A.GUNGU_CODE = 7000 THEN 7100 ELSE A.GUNGU_CODE END GUNGU_CODE,
                    CASE WHEN A.JIBGYE_CODE = 213000 THEN 217100 ELSE A.JIBGYE_CODE END JIBGYE_CODE,
                    CASE WHEN A.JOJEONG_GUBUN <> 2 THEN 4 ELSE 8 END KUBUN,
                    A.JIBANGSE_CNT BONSE_CNT,
                    A.JIBANGSE_AMT * DECODE(A.IPJI_GUBUN,1,1,-1) BONSE_AMT,
                    0 SEWOI_CNT,
                    A.SEWOI_AMT * DECODE(A.IPJI_GUBUN,1,1,-1) SEWOI_AMT,
                    A.GYOYUKSE_AMT * DECODE(A.IPJI_GUBUN,1,1,-1) GYOYUKSE_AMT,
                    A.NONGTEUKSE_AMT * DECODE(A.IPJI_GUBUN,1,1,-1) NONGTEUKSE_AMT
               FROM RPT_DANGSEIPJOJEONG A
              WHERE A.GEUMGO_CODE = '28'
                AND A.SUNAPIL BETWEEN '20240901' AND '20240909'
                AND A.JIBGYE_CODE IN
                   (103000, 104000, 209330, 209331, 209332, 209333, 200010, 200020, 213000, 215300, 217100, 300000, 304000)
                AND ( ( 0 IN (1,5,9) AND A.YEAR_GUBUN = 0 ) OR
                      ( 0 = 8        AND A.YEAR_GUBUN IN (5,9) ) OR
                      ( 0 = 0 ) )
        
                         AND A.GUNGU_CODE IN ( 60 , (60 + 7000) )
                       
             ) T
           GROUP BY GUNGU_CODE, JIBGYE_CODE, KUBUN
        ) X,
        (
           SELECT REF_M_C AS GEUMGO_CODE,
                  REF_D_C AS GUNGU_CODE,
                  REF_D_NM AS GUNGU_NAME,
                  BB.*
           FROM   RPT_CODE_INFO A,
                  (SELECT REF_D_C JIBGYE_CODE,
                          REF_D_NM JIBGYE_NM,
                          LVL
                   FROM   (SELECT REF_D_C,
                                  REF_D_NM
                           FROM   RPT_CODE_INFO
                           WHERE  REF_L_C = 500
                                  AND REF_M_C = 28
                                  AND REF_S_C = 6) AA,
                          (SELECT LEVEL LVL
                           FROM   DUAL
                           CONNECT BY LEVEL < 9) BB) BB
           WHERE  REF_L_C = 500
                  AND REF_M_C = 28

        AND REF_S_C = 1
  
      
          
            AND BB.JIBGYE_CODE IN (300000)
        
    
    AND A.REF_D_C IN ( '0060' )

         ) G
         WHERE X.GUNGU_CODE(+) = G.GUNGU_CODE
           AND X.JIBGYE_CODE(+) = G.JIBGYE_CODE
           AND X.KUBUN(+) = G.LVL
         GROUP BY G.GUNGU_CODE,G.GUNGU_NAME,G.LVL
         ORDER BY G.GUNGU_CODE,G.GUNGU_NAME,G.LVL

-------------------------------------------------------------


SELECT
              G.GUNGU_CODE
             ,G.GUNGU_NAME
             ,G.LVL KUBUN
             ,SUM(NVL(BONSE_CNT,0) ) AS BONSE_CNT
             ,SUM(NVL(BONSE_AMT ,0) ) AS BONSE_AMT
             ,SUM(NVL(SEWOI_CNT ,0) ) AS SEWOI_CNT
             ,SUM(NVL(SEWOI_AMT ,0) ) AS SEWOI_AMT
             ,SUM(NVL(GYOYUKSE_AMT ,0) ) AS GYOYUKSE_AMT
             ,SUM(NVL(NONGTEUKSE_AMT,0) ) AS NONGTEUKSE_AMT
             ,SUM(NVL(BONSE_CNT,0) + NVL(SEWOI_CNT ,0)) AS SUM_CNT
             ,SUM(NVL(BONSE_AMT ,0) + NVL(SEWOI_AMT ,0) + NVL(GYOYUKSE_AMT ,0) + NVL(NONGTEUKSE_AMT,0)) AS SUM_AMT
        FROM (
    

       SELECT (CASE WHEN T.GUNGU_CODE > 7000 THEN T.GUNGU_CODE-7000 ELSE T.GUNGU_CODE END) GUNGU_CODE
             ,T.JIBGYE_CODE, T.KUBUN
             ,SUM(NVL(BONSE_CNT,0) ) AS BONSE_CNT
             ,SUM(NVL(BONSE_AMT ,0) ) AS BONSE_AMT
             ,SUM(NVL(SEWOI_CNT ,0) ) AS SEWOI_CNT
             ,SUM(NVL(SEWOI_AMT ,0) ) AS SEWOI_AMT
             ,SUM(NVL(GYOYUKSE_AMT ,0) ) AS GYOYUKSE_AMT
             ,SUM(NVL(NONGTEUKSE_AMT,0) ) AS NONGTEUKSE_AMT
         FROM(
             SELECT CASE WHEN A.GUNGU_CODE = 7000 THEN 7100 ELSE A.GUNGU_CODE END GUNGU_CODE,
                    CASE WHEN A.JIBGYE_CODE = 213000 THEN 217100 ELSE A.JIBGYE_CODE END JIBGYE_CODE,
                    CASE WHEN A.GEORAE_GUBUN = 1 THEN 2
                         WHEN A.GEORAE_GUBUN = 3 THEN 6
                                                 ELSE 1 END KUBUN,
                    A.BONSE_CNT,
                    A.BONSE_AMT * DECODE(A.GEORAE_GUBUN,3,-1,1) BONSE_AMT,
                    A.SEWOI_CNT,
                    A.SEWOI_AMT * DECODE(A.GEORAE_GUBUN,3,-1,1) SEWOI_AMT,
                    A.GYOYUKSE_AMT * DECODE(A.GEORAE_GUBUN,3,-1,1) GYOYUKSE_AMT,
                    A.NONGTEUKSE_AMT * DECODE(A.GEORAE_GUBUN,3,-1,1) NONGTEUKSE_AMT
               FROM RPT_SUNAP_JIBGYE A
              WHERE A.GEUMGO_CODE = '28'
                AND A.SUNAPIL = '20240909'
                AND A.JIBGYE_CODE IN
                   (103000, 104000, 209330, 209331, 209332, 209333, 200010, 200020, 213000, 215300, 217100, 300000, 304000)
                AND NOT ( A.JIBGYE_CODE = 213000 AND A.KEORAEIL <> A.SUNAPIL )
                AND ( ( 0 IN (1,5,9) AND A.YEAR_GUBUN = 0 ) OR
                      ( 0 = 8        AND A.YEAR_GUBUN IN (5,9) ) OR
                      ( 0 = 0 ) )
        
                         AND A.GUNGU_CODE IN ( 60 , (60 + 7000) )
                       
                       
             ) T
           GROUP BY GUNGU_CODE, JIBGYE_CODE, KUBUN
        ) X,
        (
           SELECT REF_M_C AS GEUMGO_CODE,
                  REF_D_C AS GUNGU_CODE,
                  REF_D_NM AS GUNGU_NAME,
                  BB.*
           FROM   RPT_CODE_INFO A,
                  (SELECT REF_D_C JIBGYE_CODE,
                          REF_D_NM JIBGYE_NM,
                          LVL
                   FROM   (SELECT REF_D_C,
                                  REF_D_NM
                           FROM   RPT_CODE_INFO
                           WHERE  REF_L_C = 500
                                  AND REF_M_C = 28
                                  AND REF_S_C = 6) AA,
                          (SELECT LEVEL LVL
                           FROM   DUAL
                           CONNECT BY LEVEL < 9) BB) BB
           WHERE  REF_L_C = 500
                  AND REF_M_C = 28

        AND REF_S_C = 1
  
      
          
            AND BB.JIBGYE_CODE IN (300000)
        
    
    AND A.REF_D_C IN ( '0060' )

         ) G
         WHERE X.GUNGU_CODE(+) = G.GUNGU_CODE
           AND X.JIBGYE_CODE(+) = G.JIBGYE_CODE
           AND X.KUBUN(+) = G.LVL
         GROUP BY G.GUNGU_CODE,G.GUNGU_NAME,G.LVL
         ORDER BY G.GUNGU_CODE,G.GUNGU_NAME,G.LVL
         
-------------------------------------------------------------

SELECT (CASE WHEN T.GUNGU_CODE > 7000 THEN T.GUNGU_CODE-7000 ELSE T.GUNGU_CODE END) GUNGU_CODE
             ,T.JIBGYE_CODE, T.KUBUN
             ,SUM(NVL(BONSE_CNT,0) ) AS BONSE_CNT
             ,SUM(NVL(BONSE_AMT ,0) ) AS BONSE_AMT
             ,SUM(NVL(SEWOI_CNT ,0) ) AS SEWOI_CNT
             ,SUM(NVL(SEWOI_AMT ,0) ) AS SEWOI_AMT
             ,SUM(NVL(GYOYUKSE_AMT ,0) ) AS GYOYUKSE_AMT
             ,SUM(NVL(NONGTEUKSE_AMT,0) ) AS NONGTEUKSE_AMT
         FROM(
             SELECT CASE WHEN A.GUNGU_CODE = 7000 THEN 7100 ELSE A.GUNGU_CODE END GUNGU_CODE,
                    CASE WHEN A.JIBGYE_CODE = 213000 THEN 217100 ELSE A.JIBGYE_CODE END JIBGYE_CODE,
                    CASE WHEN A.GEORAE_GUBUN = 1 THEN 2
                         WHEN A.GEORAE_GUBUN = 3 THEN 6
                                                 ELSE 1 END KUBUN,
                    A.BONSE_CNT,
                    A.BONSE_AMT * DECODE(A.GEORAE_GUBUN,3,-1,1) BONSE_AMT,
                    A.SEWOI_CNT,
                    A.SEWOI_AMT * DECODE(A.GEORAE_GUBUN,3,-1,1) SEWOI_AMT,
                    A.GYOYUKSE_AMT * DECODE(A.GEORAE_GUBUN,3,-1,1) GYOYUKSE_AMT,
                    A.NONGTEUKSE_AMT * DECODE(A.GEORAE_GUBUN,3,-1,1) NONGTEUKSE_AMT
               FROM RPT_SUNAP_JIBGYE A
              WHERE A.GEUMGO_CODE = '28'
                AND A.SUNAPIL = '20240909'
                AND A.JIBGYE_CODE IN
                   (103000, 104000, 209330, 209331, 209332, 209333, 200010, 200020, 213000, 215300, 217100, 300000, 304000)
                AND NOT ( A.JIBGYE_CODE = 213000 AND A.KEORAEIL <> A.SUNAPIL )
                AND ( ( 0 IN (1,5,9) AND A.YEAR_GUBUN = 0 ) OR
                      ( 0 = 8        AND A.YEAR_GUBUN IN (5,9) ) OR
                      ( 0 = 0 ) )
        
                         AND A.GUNGU_CODE IN ( 60 , (60 + 7000) )
                       
                       
             ) T
           GROUP BY GUNGU_CODE, JIBGYE_CODE, KUBUN


select * from rpt_sunap_jibgye
where 1=1
and GEUMGO_CODE = 28
and SUNAPIL = '20240909'
and JIBGYE_CODE = 300000  
and GUNGU_CODE = 60

-------------------------------------------------------------
select 
*
FROM
ACL_SIGUMGO_SLV
WHERE  1=1
AND  TRXDT  BETWEEN  '20240909'  AND '20240909'
AND  SIGUMGO_ORG_C  =  28  
AND  GJDT  >=  '20240213'
AND  SIGUMGO_TRX_G4  =  10
and SUNP_ICH_SIGUMGO_GUN_GU_C = 60
and SUNP_SIGUMGO_HOIKYE_SMOK_C  =  3000
-------------------------------------------------------------

SELECT
        SEQ_NO
      ,KEORAEIL
      ,KIJUNIL
      ,HOIGYE_YEAR
      ,YEAR_GUBUN
      ,GEUMGO_CODE
      ,BANK_GUBUN
      ,MNGBR
      ,SUNAP_BR
      ,GEORAE_GUBUN
      ,GEORAE_CHANNEL
      ,GUNGU_CODE
      ,JIBGYE_CODE
      ,SUM(BONSE_CNT) as BONSE_CNT
      ,SUM(BONSE_AMT) as BONSE_AMT
      ,SUM(SEWOI_CNT) as SEWOI_CNT
      ,SUM(SEWOI_AMT) as SEWOI_AMT
      ,SUM(GYOYUKSE_CNT) as GYOYUKSE_CNT
      ,SUM(GYOYUKSE_AMT) as GYOYUKSE_AMT
      ,SUM(NONGTEUKSE_CNT) as NONGTEUKSE_CNT
      ,SUM(NONGTEUKSE_AMT) as NONGTEUKSE_AMT
      ,GONGGEUM_GYEJWA
      ,JUSEOK
      ,''
  FROM      (
SELECT  
  1  SEQ_NO
,  TRXDT  KEORAEIL
  ,CASE  WHEN  GJDT  >  GISDT  THEN  GISDT  ELSE  GJDT  END  KIJUNIL
  ,SIGUMGO_HOIKYE_YR  HOIGYE_YEAR
,  DECODE(NEW_GU_YR_G,  0,  1,  NEW_GU_YR_G)      YEAR_GUBUN
,SIGUMGO_ORG_C  GEUMGO_CODE
,26                        BANK_GUBUN
,TRXBRNO            MNGBR
,TRXBRNO            SUNAP_BR
,1                        GEORAE_GUBUN
,0                          GEORAE_CHANNEL
,SUNP_ICH_SIGUMGO_GUN_GU_C  GUNGU_CODE
,CASE  WHEN  SUNP_SIGUMGO_HOIKYE_SMOK_C  =  3000  THEN  300000  
            WHEN  SUNP_SIGUMGO_HOIKYE_SMOK_C  =  4000  THEN  304000  
            ELSE  399999  END    JIBGYE_CODE
    ,MTAX_CNT  BONSE_CNT
    ,DECODE(CRT_CAN_G,1,-1,2,-1,33,-1,1)  *  MTAX_AMT  BONSE_AMT  
    ,TAX_OI_SUIP_CNT  SEWOI_CNT  
    ,DECODE(CRT_CAN_G,1,-1,2,-1,33,-1,1)  *  TAX_OI_SUIP_AMT  SEWOI_AMT  
    ,MTAX_CNT  GYOYUKSE_CNT  
    ,DECODE(CRT_CAN_G,1,-1,2,-1,33,-1,1)  *  EDTAX_AMT  GYOYUKSE_AMT  
    ,MTAX_CNT  NONGTEUKSE_CNT  
    ,DECODE(CRT_CAN_G,1,-1,2,-1,33,-1,1)  *  NTTAX_AMT  NONGTEUKSE_AMT  
    ,OCR_G
    ,OCR_CNT
    ,OCR_AMT
    ,FIL_100_CTNT5  GONGGEUM_GYEJWA
    ,'충당금'  JUSEOK
    ,''  ICHEIL
FROM
ACL_SIGUMGO_SLV
WHERE  1=1
AND  TRXDT  BETWEEN  '20240909'  AND '20240909'
AND  SIGUMGO_ORG_C  =  28  
AND  GJDT  >=  '20240213'
AND  SIGUMGO_TRX_G4  =  10
  )  T
  GROUP  BY    SEQ_NO
                    ,KEORAEIL
                    ,KIJUNIL
                    ,HOIGYE_YEAR
                    ,YEAR_GUBUN
                    ,GEUMGO_CODE
                    ,BANK_GUBUN
                    ,MNGBR
                    ,SUNAP_BR
                    ,GEORAE_GUBUN
                    ,GEORAE_CHANNEL
                    ,GUNGU_CODE
                    ,JIBGYE_CODE
                    ,GONGGEUM_GYEJWA
                    ,JUSEOK

-------------------------------------------------------------

INSERT    INTO  RPT_SUNAP_JIBGYE
(
SEQ_NO,
    KEORAEIL,
    SUNAPIL,
    HOIGYE_YEAR,
    YEAR_GUBUN,
    GEUMGO_CODE,
    BANK_GUBUN,
    MNGBR,
    ORG_MNGBR,
    GEORAE_GUBUN,
    GEORAE_CHANNEL,
    GUNGU_CODE,
    JIBGYE_CODE,
    BONSE_CNT,
    BONSE_AMT,
    SEWOI_CNT,
    SEWOI_AMT,
    GYOYUKSE_CNT,
    GYOYUKSE_AMT,
    NONGTEUKSE_CNT,
    NONGTEUKSE_AMT,
    SEIPGYEJWA,
    JUSEOK,
    ICHEIL
)
(
  SELECT
        SEQ_NO
      ,KEORAEIL
      ,KIJUNIL
      ,HOIGYE_YEAR
      ,YEAR_GUBUN
      ,GEUMGO_CODE
      ,BANK_GUBUN
      ,MNGBR
      ,SUNAP_BR
      ,GEORAE_GUBUN
      ,GEORAE_CHANNEL
      ,GUNGU_CODE
      ,JIBGYE_CODE
      ,SUM(BONSE_CNT)
      ,SUM(BONSE_AMT)
      ,SUM(SEWOI_CNT)
      ,SUM(SEWOI_AMT)
      ,SUM(GYOYUKSE_CNT)
      ,SUM(GYOYUKSE_AMT)
      ,SUM(NONGTEUKSE_CNT)
      ,SUM(NONGTEUKSE_AMT)
      ,GONGGEUM_GYEJWA
      ,JUSEOK
      ,''
  FROM      (
SELECT  
  1  SEQ_NO
,  TRXDT  KEORAEIL
  ,CASE  WHEN  GJDT  >  GISDT  THEN  GISDT  ELSE  GJDT  END  KIJUNIL
  ,SIGUMGO_HOIKYE_YR  HOIGYE_YEAR
,  DECODE(NEW_GU_YR_G,  0,  1,  NEW_GU_YR_G)      YEAR_GUBUN
,SIGUMGO_ORG_C  GEUMGO_CODE
,26                        BANK_GUBUN
,TRXBRNO            MNGBR
,TRXBRNO            SUNAP_BR
,1                        GEORAE_GUBUN
,0                          GEORAE_CHANNEL
,SUNP_ICH_SIGUMGO_GUN_GU_C  GUNGU_CODE
,CASE  WHEN  SUNP_SIGUMGO_HOIKYE_SMOK_C  =  3000  THEN  300000  
            WHEN  SUNP_SIGUMGO_HOIKYE_SMOK_C  =  4000  THEN  304000  
            ELSE  399999  END    JIBGYE_CODE
    ,MTAX_CNT  BONSE_CNT
    ,DECODE(CRT_CAN_G,1,-1,2,-1,33,-1,1)  *  MTAX_AMT  BONSE_AMT  
    ,TAX_OI_SUIP_CNT  SEWOI_CNT  
    ,DECODE(CRT_CAN_G,1,-1,2,-1,33,-1,1)  *  TAX_OI_SUIP_AMT  SEWOI_AMT  
    ,MTAX_CNT  GYOYUKSE_CNT  
    ,DECODE(CRT_CAN_G,1,-1,2,-1,33,-1,1)  *  EDTAX_AMT  GYOYUKSE_AMT  
    ,MTAX_CNT  NONGTEUKSE_CNT  
    ,DECODE(CRT_CAN_G,1,-1,2,-1,33,-1,1)  *  NTTAX_AMT  NONGTEUKSE_AMT  
    ,OCR_G
    ,OCR_CNT
    ,OCR_AMT
    ,FIL_100_CTNT5  GONGGEUM_GYEJWA
    ,'충당금'  JUSEOK
    ,''  ICHEIL
FROM
ACL_SIGUMGO_SLV
WHERE  1=1
AND  TRXDT  BETWEEN  :START_DATE  AND  :END_DATE
AND  SIGUMGO_ORG_C  =  28  
AND  GJDT  >=  '20240213'
AND  SIGUMGO_TRX_G4  =  10
  )  T
  GROUP  BY    SEQ_NO
                    ,KEORAEIL
                    ,KIJUNIL
                    ,HOIGYE_YEAR
                    ,YEAR_GUBUN
                    ,GEUMGO_CODE
                    ,BANK_GUBUN
                    ,MNGBR
                    ,SUNAP_BR
                    ,GEORAE_GUBUN
                    ,GEORAE_CHANNEL
                    ,GUNGU_CODE
                    ,JIBGYE_CODE
                    ,GONGGEUM_GYEJWA
                    ,JUSEOK
)