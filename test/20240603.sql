select * from
RPT_SUNAP_JIBGYE
where 1=1
and JIBGYE_CODE = 215300
and SUNAPIL = '20240102'
and HOIKYE_SMOK_C NOT IN (
    288215,
    288342,
    288824,
    219016,
    281020,
    260040
)



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
                AND A.SUNAPIL = '20240304'
                AND A.JIBGYE_CODE IN
                   (103000, 104000, 209330, 209331, 209332, 209333, 200010, 200020, 213000, 215300, 217100, 300000, 304000)
                AND NOT ( A.JIBGYE_CODE = 213000 AND A.KEORAEIL <> A.SUNAPIL )
                AND ( ( 0 IN (1,5,9) AND A.YEAR_GUBUN = 0 ) OR
                      ( 0 = 8        AND A.YEAR_GUBUN IN (5,9) ) OR
                      ( 0 = 0 ) )
        
                         AND A.GUNGU_CODE IN ( 200 , (200 + 7000) )
                       

    
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
                AND A.SUNAPIL = '20240304'
                AND A.JIBGYE_CODE IN
                   (103000, 104000, 209330, 209331, 209332, 209333, 200010, 200020, 213000, 215300, 217100, 300000, 304000)
                AND ( ( 0 IN (1,5,9) AND A.YEAR_GUBUN = 0 ) OR
                      ( 0 = 8        AND A.YEAR_GUBUN IN (5,9) ) OR
                      ( 0 = 0 ) )
        
                         AND A.GUNGU_CODE IN ( 200 , (200 + 7000) )
                       
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
                AND A.SUNAPIL BETWEEN '20240301' AND '20240304'
                AND A.JIBGYE_CODE IN
                    (103000, 104000, 209330, 209331, 209332, 209333, 200010, 200020, 213000, 215300, 217100, 300000, 304000)
                AND NOT ( A.JIBGYE_CODE = 213000 AND A.KEORAEIL <> A.SUNAPIL )
                AND ( ( 0 IN (1,5,9) AND A.YEAR_GUBUN = 0 ) OR
                      ( 0 = 8        AND A.YEAR_GUBUN IN (5,9) ) OR
                      ( 0 = 0 ) )
        
                         AND A.GUNGU_CODE IN ( 200 , (200 + 7000) )
                       
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
                AND A.SUNAPIL BETWEEN '20240301' AND '20240304'
                AND A.JIBGYE_CODE IN
                   (103000, 104000, 209330, 209331, 209332, 209333, 200010, 200020, 213000, 215300, 217100, 300000, 304000)
                AND ( ( 0 IN (1,5,9) AND A.YEAR_GUBUN = 0 ) OR
                      ( 0 = 8        AND A.YEAR_GUBUN IN (5,9) ) OR
                      ( 0 = 0 ) )
        
                         AND A.GUNGU_CODE IN ( 200 , (200 + 7000) )
                       
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
  
      
          
            AND BB.JIBGYE_CODE IN (104000)
        
    
    AND A.REF_D_C IN ( '0200' )

         ) G
         WHERE X.GUNGU_CODE(+) = G.GUNGU_CODE
           AND X.JIBGYE_CODE(+) = G.JIBGYE_CODE
           AND X.KUBUN(+) = G.LVL
         GROUP BY G.GUNGU_CODE,G.GUNGU_NAME,G.LVL
         ORDER BY G.GUNGU_CODE,G.GUNGU_NAME,G.LVL



SELECT  * FROM RPT_TXI_DDAC_TAB
WHERE 1=1
AND SUNAP_DT = '20240102'
AND SIGUMGO_ORG_C = 28
AND ICH_SIGUMGO_HOIKYE_C IS NULL