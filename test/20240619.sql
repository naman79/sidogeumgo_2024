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
  FROM 
(
 WITH RPT_TXI_DDAC_TAB_PROVISION AS 
    (
          SELECT
               T2.SIGUMGO_ORG_C
              ,T2.ICH_SIGUMGO_GUN_GU_C
              ,T2.ICH_SIGUMGO_HOIKYE_C
              ,T2.SIGUMGO_AC_B
              ,T2.HOIGYE_YEAR AS SIGUMGO_HOIKYE_YR
              ,T2.BAS_DT AS SUNAP_DT
              ,DECODE(ICH_SIGUMGO_HOIKYE_C21,'209331','209331','209332','209332',ROW_NUMBER() OVER (PARTITION BY T2.SIGUMGO_ORG_C
                                                                                                     ,T2.ICH_SIGUMGO_GUN_GU_C
                                                                                                     ,T2.ICH_SIGUMGO_HOIKYE_C
                                                                                                     ,T2.SIGUMGO_AC_B
                                                                                                     ,T2.HOIGYE_YEAR
                                                                                                     ,T2.BAS_DT ORDER BY 1)) DR_SNO
              ,DECODE(T2.HOIGYE_YEAR, '9999', '1', T2.YEAR_G) AS NEW_GU_YR_G
              ,T2.SIGUTAX_G 
              ,SUM(
                   CASE WHEN T2.GEORAE_GUBUN IN ('1', '2', '4') THEN T2.BONSE_AMT + T2.SEWOI_AMT + T2.GYOYUKSE_AMT + T2.NONGTEUKSE_AMT
                   ELSE 0
                  END
               ) AS TAX_IP_AMT
              ,SUM(
               CASE
                    WHEN T2.GEORAE_GUBUN = '3' THEN T2.BONSE_AMT + T2.SEWOI_AMT + T2.GYOYUKSE_AMT + T2.NONGTEUKSE_AMT
                    WHEN T2.JOJEONG_GUBUN = '2' AND T2.IPJI_GUBUN  = 1 THEN (T2.JIBANGSE_AMT + T2.SEWOI_AMT + T2.GYOYUKSE_AMT + T2.NONGTEUKSE_AMT) * -1
                    WHEN T2.JOJEONG_GUBUN = '2' AND T2.IPJI_GUBUN  <> 1 THEN (T2.JIBANGSE_AMT + T2.SEWOI_AMT + T2.GYOYUKSE_AMT + T2.NONGTEUKSE_AMT)
                  ELSE 0
               END
               ) AS GWAON_AMT
              ,SUM(
                  CASE WHEN T2.JOJEONG_GUBUN IN ('0', '1', '3') AND T2.IPJI_GUBUN  = 1 THEN (T2.JIBANGSE_AMT + T2.SEWOI_AMT + T2.GYOYUKSE_AMT + T2.NONGTEUKSE_AMT)
                       WHEN T2.JOJEONG_GUBUN IN ('0', '1', '3') AND T2.IPJI_GUBUN  <> 1 THEN (T2.JIBANGSE_AMT + T2.SEWOI_AMT + T2.GYOYUKSE_AMT + T2.NONGTEUKSE_AMT) * -1
                  ELSE 0
                  END
               ) AS TAX_IP_CRT_AMT
              ,SUM( DECODE(T2.SIGUMGO_ORG_C,'28',
                                       CASE WHEN T2.GEORAE_GUBUN IN ('1', '2', '4') THEN T2.BONSE_AMT ELSE 0 END,
                                       CASE WHEN T2.GEORAE_GUBUN !=3 THEN T2.BONSE_AMT ELSE 0 END) ) AS JIBANGSE_AMT
              ,SUM(
                   CASE WHEN T2.GEORAE_GUBUN = '3' THEN T2.BONSE_AMT
                        WHEN T2.JOJEONG_GUBUN = '2' AND T2.IPJI_GUBUN  = 1 THEN T2.JIBANGSE_AMT * -1
                        WHEN T2.JOJEONG_GUBUN = '2' AND T2.IPJI_GUBUN  = 2 THEN T2.JIBANGSE_AMT
                     ELSE 0
                   END
               ) AS JIBANGSE_GWAON_AMT
              ,SUM(
                   CASE WHEN T2.JOJEONG_GUBUN <> 2 AND T2.IPJI_GUBUN  = 1 THEN T2.JIBANGSE_AMT
                        WHEN T2.JOJEONG_GUBUN <> 2 AND T2.IPJI_GUBUN  = 2 THEN T2.JIBANGSE_AMT * -1
                   ELSE 0
                   END
               ) AS JIBANGSE_CRT_AMT
              ,SUM(CASE WHEN T2.GEORAE_GUBUN IN ('1', '2', '4')THEN T2.SEWOI_AMT ELSE 0 END) AS SEWOI_AMT
              ,SUM(
                   CASE WHEN T2.GEORAE_GUBUN = '3' THEN T2.SEWOI_AMT
                        WHEN T2.JOJEONG_GUBUN = '2' AND T2.IPJI_GUBUN  = 1 THEN T2.SEWOI_AMT * -1
                        WHEN T2.JOJEONG_GUBUN = '2' AND T2.IPJI_GUBUN  = 2 THEN T2.SEWOI_AMT
                   ELSE 0
                   END
               ) AS SEWOI_GWAON_AMT
              ,SUM(
                   CASE
                        WHEN T2.JOJEONG_GUBUN IN ('0', '1', '3') AND T2.IPJI_GUBUN  = 1 THEN T2.SEWOI_AMT
                        WHEN T2.JOJEONG_GUBUN IN ('0', '1', '3') AND T2.IPJI_GUBUN  = 2 THEN T2.SEWOI_AMT * -1
                   ELSE 0
                   END
                ) AS SEWOI_CRT_AMT
              ,SUM(
                   CASE
                        WHEN T2.GEORAE_GUBUN IN ('1', '2', '4')THEN T2.GYOYUKSE_AMT
                   ELSE 0
                   END
               ) AS GYOYUKSE_AMT
              ,SUM(
                   CASE
                        WHEN T2.GEORAE_GUBUN = '3' THEN T2.GYOYUKSE_AMT
                        WHEN T2.JOJEONG_GUBUN = '2' AND T2.IPJI_GUBUN  = 1 THEN T2.GYOYUKSE_AMT * -1
                        WHEN T2.JOJEONG_GUBUN = '2' AND T2.IPJI_GUBUN  = 1 THEN T2.GYOYUKSE_AMT
                   ELSE 0
                   END
               ) AS GYOYUKSE_GWAON_AMT
              ,SUM(
                   CASE
                        WHEN T2.JOJEONG_GUBUN IN ('0', '1', '3') AND T2.IPJI_GUBUN  = 1 THEN T2.GYOYUKSE_AMT
                        WHEN T2.JOJEONG_GUBUN IN ('0', '1', '3') AND T2.IPJI_GUBUN  = 2 THEN T2.GYOYUKSE_AMT * -1
                   ELSE 0
                   END
               ) AS GYOYUKSE_CRT_AMT
              ,SUM(
                   CASE
                        WHEN T2.GEORAE_GUBUN IN ('1', '2', '4')THEN T2.NONGTEUKSE_AMT
                   ELSE 0
                   END
               ) AS NONGTEUKSE_AMT
              ,SUM(
                   CASE
                        WHEN T2.GEORAE_GUBUN = '3' THEN T2.NONGTEUKSE_AMT
                        WHEN T2.JOJEONG_GUBUN = '2' AND T2.IPJI_GUBUN  = 1 THEN T2.NONGTEUKSE_AMT * -1
                        WHEN T2.JOJEONG_GUBUN = '2' AND T2.IPJI_GUBUN  = 2 THEN T2.NONGTEUKSE_AMT
                   ELSE 0
                   END
               ) AS NONGTEUKSE_GWAON_AMT
              ,SUM(
                   CASE
                        WHEN T2.JOJEONG_GUBUN <> 2 AND T2.IPJI_GUBUN  = 1 THEN T2.NONGTEUKSE_AMT
                        WHEN T2.JOJEONG_GUBUN <> 2 AND T2.IPJI_GUBUN  = 2 THEN T2.NONGTEUKSE_AMT * -1
                   ELSE 0
                   END
               ) AS NONGTEUKSE_CRT_AMT
              ,TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS')
              ,'BATCH'
              ,TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS')
              ,'BATCH'
            FROM
            (
            SELECT
                 T1.GEUMGO_CODE AS SIGUMGO_ORG_C
               , T1.GUNGU_CODE AS ICH_SIGUMGO_GUN_GU_C
               , CASE WHEN T1.GEUMGO_CODE IN('28','41','302') THEN
                     (
                         CASE
                               WHEN T1.JIBGYE_CODE IN ('300000', '304000') THEN '1'
                         END) ELSE TO_CHAR(T1.JIBGYE_CODE) END  AS ICH_SIGUMGO_HOIKYE_C
               , DECODE(T1.JIBGYE_CODE,'209331','209331','209332','209332','')   ICH_SIGUMGO_HOIKYE_C21
               , '10' AS SIGUMGO_AC_B
               , T1.HOIGYE_YEAR
               , T1.YEAR_GUBUN AS YEAR_G
               , CASE
                      WHEN T1.JIBGYE_CODE  = '304000' THEN '2'
                 ELSE '1' END AS SIGUTAX_G
               , T1.SUNAPIL AS BAS_DT
               , T1.SUNAPIL AS PROC_DT
               , T1.SUNAPIL AS GISDT
               ,T1.GEORAE_GUBUN
               ,9999 AS JOJEONG_GUBUN
               ,9999 AS IPJI_GUBUN
               ,NVL(T1.BONSE_CNT, 0) AS BONSE_CNT
               ,NVL(T1.BONSE_AMT, 0) AS BONSE_AMT
               ,0 AS JIBANGSE_CNT
               ,0 AS JIBANGSE_AMT
               ,NVL(T1.SEWOI_CNT, 0) AS SEWOI_CNT
               ,NVL(T1.SEWOI_AMT, 0) AS SEWOI_AMT
               ,NVL(T1.GYOYUKSE_CNT, 0) AS GYOYUKSE_CNT
               ,NVL(T1.GYOYUKSE_AMT, 0) AS GYOYUKSE_AMT
               ,NVL(T1.NONGTEUKSE_CNT, 0) AS NONGTEUKSE_CNT
               ,NVL(T1.NONGTEUKSE_AMT, 0) AS NONGTEUKSE_AMT
            FROM
              ICTOWN.RPT_SUNAP_JIBGYE T1
            WHERE 1=1
            AND T1.SUNAPIL BETWEEN SUBSTR('202401',0,4) || '0101' AND '20240531'
            AND T1.JIBGYE_CODE IN ('300000', '304000')
            UNION ALL
            SELECT
                 T1.GEUMGO_CODE AS SIGUMGO_ORG_C
               , T1.GUNGU_CODE AS ICH_SIGUMGO_GUN_GU_C
               , CASE WHEN T1.GEUMGO_CODE IN('28','41','302') THEN
                     (
                         CASE
                               WHEN T1.JIBGYE_CODE IN ('300000', '304000') THEN '1'
                         END) ELSE TO_CHAR(T1.JIBGYE_CODE) END  AS ICH_SIGUMGO_HOIKYE_C
               , DECODE(T1.JIBGYE_CODE,'209331','209331','209332','209332','')   ICH_SIGUMGO_HOIKYE_C21
               , '10' AS SIGUMGO_AC_B
               , T1.HOIGYE_YEAR
               , T1.YEAR_GUBUN AS YEAR_G
               , CASE
               WHEN T1.JIBGYE_CODE = '304000' THEN '2'
               ELSE '1'
              END AS SIGUTAX_G
               , T1.SUNAPIL AS BAS_DT
               , T1.SUNAPIL AS PROC_DT
               , T1.SUNAPIL AS GISDT
               ,9999 AS GEORAE_GUBUN
               ,T1.JOJEONG_GUBUN
               ,T1.IPJI_GUBUN
               ,0 AS BONSE_CNT
               ,0 AS BONSE_AMT
               ,NVL(T1.JIBANGSE_CNT, 0) AS JIBANGSE_CNT
               ,NVL(T1.JIBANGSE_AMT, 0) AS JIBANGSE_AMT
               ,NVL(T1.SEWOI_CNT, 0) AS SEWOI_CNT
               ,NVL(T1.SEWOI_AMT, 0) AS SEWOI_AMT
               ,0 AS GYOYUKSE_CNT
               ,NVL(T1.GYOYUKSE_AMT, 0) AS GYOYUKSE_AMT
               ,0 AS NONGTEUKSE_CNT
               ,NVL(T1.NONGTEUKSE_AMT, 0) AS NONGTEUKSE_AMT
            FROM
              ICTOWN.RPT_DANGSEIPJOJEONG T1
            WHERE 1=1
            AND T1.SUNAPIL BETWEEN SUBSTR('202401',0,4) || '0101' AND '20240531'
               AND GEUMGO_CODE = '28'
               AND JIBGYE_CODE IN ('300000', '304000')
            ) T2, SFI_CMM_C_DAT T3
            WHERE 1=1
              AND T2.SIGUMGO_ORG_C = T3.CMM_DTL_C
              AND T3.CMM_C_NM = 'RPT시도금고코드'
              AND T3.USE_YN = 'Y'
              AND T2.ICH_SIGUMGO_HOIKYE_C IS NOT NULL
              AND T2.SIGUMGO_ORG_C IS NOT NULL
            GROUP BY
               T2.SIGUMGO_ORG_C
              ,T2.ICH_SIGUMGO_GUN_GU_C
              ,T2.ICH_SIGUMGO_HOIKYE_C
              ,T2.ICH_SIGUMGO_HOIKYE_C21
              ,T2.SIGUMGO_AC_B
              ,T2.HOIGYE_YEAR
              ,DECODE(T2.HOIGYE_YEAR, '9999', '1', T2.YEAR_G)
              ,T2.SIGUTAX_G
              ,T2.BAS_DT
              ,T2.PROC_DT
              ,T2.GISDT
    )
       SELECT ICH_SIGUMGO_GUN_GU_C GUNGU_CODE,
              1 DATA_ROW, 
              SUM(CASE WHEN (SUNAP_DT = '20240531')  THEN NVL(JIBANGSE_AMT,0) ELSE 0 END ) AMT1,
              SUM(CASE WHEN (SUNAP_DT = '20240531' )  THEN NVL(JIBANGSE_GWAON_AMT,0) ELSE 0 END ) AMT2, 
              SUM(CASE WHEN (SUNAP_DT = '20240531' )  THEN NVL(JIBANGSE_CRT_AMT,0) ELSE 0 END ) AMT3,
              SUM(CASE WHEN (SUNAP_DT = '20240531' )  THEN NVL(SEWOI_AMT,0) ELSE 0 END ) AMT4,
              SUM(CASE WHEN (SUNAP_DT = '20240531' )  THEN NVL(SEWOI_GWAON_AMT,0) ELSE 0 END ) AMT5,
              SUM(CASE WHEN (SUNAP_DT = '20240531' )  THEN NVL(SEWOI_CRT_AMT,0) ELSE 0 END ) AMT6,
              SUM(CASE WHEN (SUNAP_DT = '20240531' )  THEN NVL(GYOYUKSE_AMT,0) ELSE 0 END ) AMT7,
              SUM(CASE WHEN (SUNAP_DT = '20240531' )  THEN NVL(GYOYUKSE_GWAON_AMT,0) ELSE 0 END ) AMT8,
              SUM(CASE WHEN (SUNAP_DT = '20240531' )  THEN NVL(GYOYUKSE_CRT_AMT,0) ELSE 0 END ) AMT9,
              SUM(CASE WHEN (SUNAP_DT = '20240531' )  THEN NVL(NONGTEUKSE_AMT,0) ELSE 0 END ) AMT10,
              SUM(CASE WHEN (SUNAP_DT = '20240531' )  THEN NVL(NONGTEUKSE_GWAON_AMT,0) ELSE 0 END ) AMT11,
              SUM(CASE WHEN (SUNAP_DT = '20240531' )  THEN NVL(NONGTEUKSE_CRT_AMT,0) ELSE 0 END ) AMT12,
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
              SUM(   CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240531',0,6) || '01' AND '20240531')  THEN NVL(JIBANGSE_AMT,0)           ELSE 0 END    
                   + CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240531',0,6) || '01' AND '20240531')  THEN NVL(JIBANGSE_GWAON_AMT,0) *-1 ELSE 0 END   
                   + CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240531',0,6) || '01' AND '20240531')  THEN NVL(JIBANGSE_CRT_AMT,0)       ELSE 0 END           
                 ) AMT25,
               SUM(  CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240531',0,6) || '01' AND '20240531')  THEN NVL(SEWOI_AMT,0)           ELSE 0 END    
                   + CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240531',0,6) || '01' AND '20240531')  THEN NVL(SEWOI_GWAON_AMT,0) *-1 ELSE 0 END   
                   + CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240531',0,6) || '01' AND '20240531')  THEN NVL(SEWOI_CRT_AMT,0)       ELSE 0 END           
                  ) AMT26,
               SUM(  CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240531',0,6) || '01' AND '20240531')  THEN NVL(GYOYUKSE_AMT,0)           ELSE 0 END    
                   + CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240531',0,6) || '01' AND '20240531')  THEN NVL(GYOYUKSE_GWAON_AMT,0) *-1 ELSE 0 END   
                   + CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240531',0,6) || '01' AND '20240531')  THEN NVL(GYOYUKSE_CRT_AMT,0)       ELSE 0 END           
                  ) AMT27,
               SUM(  CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240531',0,6) || '01' AND '20240531')  THEN NVL(NONGTEUKSE_AMT,0)           ELSE 0 END    
                   + CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240531',0,6) || '01' AND '20240531')  THEN NVL(NONGTEUKSE_GWAON_AMT,0) *-1 ELSE 0 END   
                   + CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240531',0,6) || '01' AND '20240531')  THEN NVL(NONGTEUKSE_CRT_AMT,0)       ELSE 0 END           
                  ) AMT28
         FROM RPT_TXI_DDAC_TAB
        WHERE 1=1
          AND  SIGUMGO_ORG_C = '28' 
          AND (    '1' = (CASE WHEN 1  = '1' AND '1'     IN(8,9) AND SUNAP_DT BETWEEN ('2024')-1 ||  '0101' AND '20240531' THEN '1' ELSE '0' END)
                OR '1' = (CASE WHEN 1  = '1' AND '1' NOT IN(8,9) AND SUNAP_DT BETWEEN ('2024')   ||  '0101' AND '20240531' THEN '1' ELSE '0' END)
                OR '1' = (CASE WHEN 1 <> '1' AND SUNAP_DT BETWEEN ('2024') ||  '0101' AND '20240531' THEN '1' ELSE '0' END  )
              )    
          AND ICH_SIGUMGO_HOIKYE_C = '1'
          AND ICH_SIGUMGO_GUN_GU_C LIKE '110' || '%'
          AND (    ('1' = ( CASE WHEN'1' = 1 AND SIGUTAX_G ='2' THEN  '1' ELSE '0' END))  
                OR ('1' = ( CASE WHEN '1' <> 1 THEN  '1' ELSE '0' END))  
              )
          AND (    ('1' = (CASE WHEN '1'=1 AND SUNAP_DT >=  '2024'   AND  ( NEW_GU_YR_G = '1' OR  SIGUMGO_HOIKYE_YR =9999 )  THEN  '1' ELSE '0' END))   
                OR ('1' = (CASE WHEN '1' IN(5,9) AND '5'<3 AND  SUNAP_DT >=  ('2024')-1 || '0301'   AND  NEW_GU_YR_G = '1'   THEN  '1' ELSE '0' END))  
                OR ('1' = (CASE WHEN '1' IN(5,9) AND '5'>=3 AND  SUNAP_DT >=  '2024'  || '0301' AND  NEW_GU_YR_G = '1'    THEN  '1' ELSE '0' END))   
                OR (     '1' = (CASE WHEN '1'=8 AND '5'<3 AND (((SUNAP_DT BETWEEN ('2024')-1 || '0100' AND ('2024')-1 || '1231')) AND NEW_GU_YR_G =  1) THEN  '1' ELSE '0' END)
                     OR  '1' = (CASE WHEN '1'=8 AND '5'<3 AND SUNAP_DT >= ('2024')-1 || '0301' AND NEW_GU_YR_G <> 1 THEN '1' ELSE '0' END))   
                OR ('1' = (CASE WHEN '1'=8 AND '5'>=3 AND (((SUNAP_DT>= '2024'  ||  '0301'  AND NEW_GU_YR_G <>  1)) ) THEN  '1' ELSE '0' END)) 
                OR ('1' = (CASE WHEN '1'=0 AND (((SUNAP_DT>= '2024'))) THEN  '1' ELSE '0' END))
                OR ('1' = (CASE WHEN '1'=7 AND  (((SUNAP_DT>= '2024'))) THEN  '1' ELSE '0' END))
              )
        GROUP BY ICH_SIGUMGO_GUN_GU_C   

        UNION ALL
        SELECT ICH_SIGUMGO_GUN_GU_C GUNGU_CODE,
              1 DATA_ROW, 
              SUM(CASE WHEN (SUNAP_DT = '20240531')  THEN NVL(JIBANGSE_AMT,0) ELSE 0 END ) AMT1,
              SUM(CASE WHEN (SUNAP_DT = '20240531' )  THEN NVL(JIBANGSE_GWAON_AMT,0) ELSE 0 END ) AMT2, 
              SUM(CASE WHEN (SUNAP_DT = '20240531' )  THEN NVL(JIBANGSE_CRT_AMT,0) ELSE 0 END ) AMT3,
              SUM(CASE WHEN (SUNAP_DT = '20240531' )  THEN NVL(SEWOI_AMT,0) ELSE 0 END ) AMT4,
              SUM(CASE WHEN (SUNAP_DT = '20240531' )  THEN NVL(SEWOI_GWAON_AMT,0) ELSE 0 END ) AMT5,
              SUM(CASE WHEN (SUNAP_DT = '20240531' )  THEN NVL(SEWOI_CRT_AMT,0) ELSE 0 END ) AMT6,
              SUM(CASE WHEN (SUNAP_DT = '20240531' )  THEN NVL(GYOYUKSE_AMT,0) ELSE 0 END ) AMT7,
              SUM(CASE WHEN (SUNAP_DT = '20240531' )  THEN NVL(GYOYUKSE_GWAON_AMT,0) ELSE 0 END ) AMT8,
              SUM(CASE WHEN (SUNAP_DT = '20240531' )  THEN NVL(GYOYUKSE_CRT_AMT,0) ELSE 0 END ) AMT9,
              SUM(CASE WHEN (SUNAP_DT = '20240531' )  THEN NVL(NONGTEUKSE_AMT,0) ELSE 0 END ) AMT10,
              SUM(CASE WHEN (SUNAP_DT = '20240531' )  THEN NVL(NONGTEUKSE_GWAON_AMT,0) ELSE 0 END ) AMT11,
              SUM(CASE WHEN (SUNAP_DT = '20240531' )  THEN NVL(NONGTEUKSE_CRT_AMT,0) ELSE 0 END ) AMT12,
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
              SUM(   CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240531',0,6) || '01' AND '20240531')  THEN NVL(JIBANGSE_AMT,0)           ELSE 0 END    
                   + CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240531',0,6) || '01' AND '20240531')  THEN NVL(JIBANGSE_GWAON_AMT,0) *-1 ELSE 0 END   
                   + CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240531',0,6) || '01' AND '20240531')  THEN NVL(JIBANGSE_CRT_AMT,0)       ELSE 0 END           
                 ) AMT25,
               SUM(  CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240531',0,6) || '01' AND '20240531')  THEN NVL(SEWOI_AMT,0)           ELSE 0 END    
                   + CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240531',0,6) || '01' AND '20240531')  THEN NVL(SEWOI_GWAON_AMT,0) *-1 ELSE 0 END   
                   + CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240531',0,6) || '01' AND '20240531')  THEN NVL(SEWOI_CRT_AMT,0)       ELSE 0 END           
                  ) AMT26,
               SUM(  CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240531',0,6) || '01' AND '20240531')  THEN NVL(GYOYUKSE_AMT,0)           ELSE 0 END    
                   + CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240531',0,6) || '01' AND '20240531')  THEN NVL(GYOYUKSE_GWAON_AMT,0) *-1 ELSE 0 END   
                   + CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240531',0,6) || '01' AND '20240531')  THEN NVL(GYOYUKSE_CRT_AMT,0)       ELSE 0 END           
                  ) AMT27,
               SUM(  CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240531',0,6) || '01' AND '20240531')  THEN NVL(NONGTEUKSE_AMT,0)           ELSE 0 END    
                   + CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240531',0,6) || '01' AND '20240531')  THEN NVL(NONGTEUKSE_GWAON_AMT,0) *-1 ELSE 0 END   
                   + CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240531',0,6) || '01' AND '20240531')  THEN NVL(NONGTEUKSE_CRT_AMT,0)       ELSE 0 END           
                  ) AMT28
         FROM RPT_TXI_DDAC_TAB_PROVISION
        WHERE 1=1
          AND  SIGUMGO_ORG_C = '28' 
          AND (    '1' = (CASE WHEN 1  = '1' AND '1'     IN(8,9) AND SUNAP_DT BETWEEN ('2024')-1 ||  '0101' AND '20240531' THEN '1' ELSE '0' END)
                OR '1' = (CASE WHEN 1  = '1' AND '1' NOT IN(8,9) AND SUNAP_DT BETWEEN ('2024')   ||  '0101' AND '20240531' THEN '1' ELSE '0' END)
                OR '1' = (CASE WHEN 1 <> '1' AND SUNAP_DT BETWEEN ('2024') ||  '0101' AND '20240531' THEN '1' ELSE '0' END  )
              )    
          AND ICH_SIGUMGO_HOIKYE_C = '1'
          AND ICH_SIGUMGO_GUN_GU_C LIKE '110' || '%'
          AND (    ('1' = ( CASE WHEN'1' = 1 AND SIGUTAX_G ='2' THEN  '1' ELSE '0' END))  
                OR ('1' = ( CASE WHEN '1' <> 1 THEN  '1' ELSE '0' END))  
              )
          AND (    ('1' = (CASE WHEN '1'=1 AND SUNAP_DT >=  '2024'   AND  ( NEW_GU_YR_G = '1' OR  SIGUMGO_HOIKYE_YR =9999 )  THEN  '1' ELSE '0' END))   
                OR ('1' = (CASE WHEN '1' IN(5,9) AND '5'<3 AND  SUNAP_DT >=  ('2024')-1 || '0301'   AND  NEW_GU_YR_G = '1'   THEN  '1' ELSE '0' END))  
                OR ('1' = (CASE WHEN '1' IN(5,9) AND '5'>=3 AND  SUNAP_DT >=  '2024'  || '0301' AND  NEW_GU_YR_G = '1'    THEN  '1' ELSE '0' END))   
                OR (     '1' = (CASE WHEN '1'=8 AND '5'<3 AND (((SUNAP_DT BETWEEN ('2024')-1 || '0100' AND ('2024')-1 || '1231')) AND NEW_GU_YR_G =  1) THEN  '1' ELSE '0' END)
                     OR  '1' = (CASE WHEN '1'=8 AND '5'<3 AND SUNAP_DT >= ('2024')-1 || '0301' AND NEW_GU_YR_G <> 1 THEN '1' ELSE '0' END))   
                OR ('1' = (CASE WHEN '1'=8 AND '5'>=3 AND (((SUNAP_DT>= '2024'  ||  '0301'  AND NEW_GU_YR_G <>  1)) ) THEN  '1' ELSE '0' END)) 
                OR ('1' = (CASE WHEN '1'=0 AND (((SUNAP_DT>= '2024'))) THEN  '1' ELSE '0' END))
                OR ('1' = (CASE WHEN '1'=7 AND  (((SUNAP_DT>= '2024'))) THEN  '1' ELSE '0' END))
              )
        GROUP BY ICH_SIGUMGO_GUN_GU_C   
        UNION ALL

       SELECT 9999 ICH_SIGUMGO_GUN_GU_C, 2 DATA_ROW,
              SUM(CASE WHEN  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE BAS_DT END) = '20240531'  THEN  BIZPLC_BAEJUNG_JI_AMT ELSE 0  END) 
              +SUM(CASE WHEN  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE BAS_DT END) = '20240531'  THEN  BIZPLC_GAM_BAEJUNG_IP_AMT ELSE 0  END) AMT1,  
              SUM(CASE WHEN  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE BAS_DT END) = '20240531' THEN TAXO_FUND_BAEJUNG_JI_AMT+TAXO_HNDO_BAEJUNG_JI_AMT+TAXO_FUND_GETBK_JI_AMT
                                                                                                               +TAXO_HNDO_JICHUL_JI_AMT+TAXO_HNDO_GETBK_JI_AMT ELSE 0 END) AMT2,
              SUM(CASE WHEN  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE BAS_DT END) = '20240531' THEN  TAXO_RTRN_AMT ELSE 0 END)*-1 AMT3,
              0 AMT4,  0 AMT5,  0 AMT6,  0 AMT7,  0 AMT8,  0 AMT9,  0 AMT10, 0 AMT11, 0 AMT12,
              SUM(CASE WHEN SIGUMGO_AC_B = 10 THEN  BIZPLC_BAEJUNG_JI_AMT ELSE 0 END) + SUM(BIZPLC_GAM_BAEJUNG_IP_AMT) AMT13,
              SUM(TAXO_FUND_BAEJUNG_JI_AMT+TAXO_HNDO_BAEJUNG_JI_AMT+TAXO_FUND_GETBK_JI_AMT+TAXO_HNDO_JICHUL_JI_AMT+TAXO_HNDO_GETBK_JI_AMT) AMT14,
              SUM(TAXO_RTRN_AMT)*-1 AMT15,
              SUM(CASE WHEN '5' < 3 AND '1'  = 1 AND '2024' < 2007 THEN  GA_IWOL_JI_AMT
                       WHEN '5' < 3 AND '1'  = 1 AND '2024' >=2007 THEN  GA_IWOL_JI_AMT-GA_IWOL_IP_AMT 
                       WHEN '5' < 3 AND '1' != 1 AND '2024' < 2007 AND (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END)  > '2024'  ||  '0100' THEN GA_IWOL_JI_AMT
                       WHEN '5' < 3 AND '1' != 1 AND '2024' >=2007 AND (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END)  > '2024'  ||  '0100' THEN GA_IWOL_JI_AMT-GA_IWOL_IP_AMT 
                       WHEN '5' >= 3 THEN 0
                  END) AMT16, 
              0 AMT17,    
              SUM(PMNY_JAN_MVO_AMT-PMNY_JAN_MVI_AMT) AMT18,
              0 AMT19, 0 AMT20, 0 AMT21, 0 AMT22, 0 AMT23, 0 AMT24,
              0 AMT25, 0 AMT26, 0 AMT27, 0 AMT28
         FROM RPT_TXIO_DDAC_TAB A   
        WHERE 1=1
          AND A.SIGUMGO_ORG_C  = '28'
          AND (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) BETWEEN SUBSTR('202401',0,4) || '0101' AND '20240531'
          AND A.ICH_SIGUMGO_HOIKYE_C = '1'   
          AND ( ( '1' IN (21,22) AND ICH_SIGUMGO_GUN_GU_C = 0) OR  ( '1' = 1  AND ICH_SIGUMGO_GUN_GU_C <> 0) OR ( '1' NOT IN (1, 21,22) )) 
          AND ICH_SIGUMGO_GUN_GU_C LIKE '110' || '%' 
          AND (    ('1' = (CASE WHEN '1' = 1 AND (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) >= '2024' AND (NEW_GU_YR_G ='1' OR SIGUMGO_HOIKYE_YR= 9999 ) THEN  '1' ELSE '0' END))   
                OR ('1' = (CASE WHEN '1' IN (5,9) AND '5' <3  AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) >= ('2024')-1 || '0301' AND NEW_GU_YR_G ='1'  THEN  '1' ELSE '0' END))   
                OR ('1' = (CASE WHEN '1' IN (5,9) AND '5' >=3  AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) >= '2024' || '0301'  AND NEW_GU_YR_G ='1'  THEN  '1' ELSE '0' END))   
                OR (    ('1' = (CASE WHEN '1' = 8 AND '5' <3  AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) BETWEEN ('2024')-1 || '0100' AND ('2024')-1 || '1231' AND NEW_GU_YR_G = '1'  THEN  '1' ELSE '0' END))   
                     OR ('1' = (CASE WHEN '1' = 8 AND '5' <3  AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) >= ('2024')-1 || '0301'  AND NEW_GU_YR_G <> '1'  THEN  '1' ELSE '0' END)))
                OR ('1' = (CASE WHEN '1' = 8 AND '5' >=3  AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) >= '2024'  ||  '0301'  AND NEW_GU_YR_G <> '1'  THEN  '1' ELSE '0' END))   
                OR ('1' = (CASE WHEN '1' = 0 AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) >= '2024' THEN  '1' ELSE '0' END))   
                OR ('1' = (CASE WHEN '1' = 7 AND '5' <3  AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) >= '2024' THEN  '1' ELSE '0' END))   
                OR ('1' = (CASE WHEN '1' = 7 AND '5' >=3  AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) >= '2024' AND NEW_GU_YR_G =1 THEN  '1' ELSE '0' END))   
              )   
         AND A.SIGUMGO_AC_B IN('10','20')  

       UNION ALL

      SELECT 9999 GUNGU_CODE, 2 DATA_ROW,
             0 AMT1,  0 AMT2,  0 AMT3,  0 AMT4,  0 AMT5,  0 AMT6,  0 AMT7,  0 AMT8,
             0 AMT9,  0 AMT10, 0 AMT11, 0 AMT12, 0 AMT13, 0 AMT14, 0 AMT15, 0 AMT16, 
             SUM(DEP_MK_JI_AMT-DEP_HJI_AMT) AMT17,
             0 AMT18, 0 AMT19, 0 AMT20, 0 AMT21, 0 AMT22, 0 AMT23, 0 AMT24,
             0 AMT25, 0 AMT26, 0 AMT27, 0 AMT28
        FROM RPT_TXIO_DDAC_TAB A
       WHERE 1=1
         AND A.SIGUMGO_ORG_C  = '28'
         AND A.ICH_SIGUMGO_HOIKYE_C = '1'
         AND ( ( '1' IN (21,22) AND ICH_SIGUMGO_GUN_GU_C = 0) OR  ( '1' = 1  AND ICH_SIGUMGO_GUN_GU_C <> 0) OR ( '1' NOT IN (1, 21,22) )) 
         AND ICH_SIGUMGO_GUN_GU_C LIKE '110' || '%' 
         AND (   (    ('1' = (CASE WHEN '5' < 3  AND '1' IN(1,30) AND '1' IN(0,7) AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) <  SUBSTR('20240531',0,4) || '0100' THEN  '1' ELSE '0' END))   
                   OR ('1' = (CASE WHEN '5' < 3  AND '1' IN(1,30) AND '1' IN(0,7) AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) BETWEEN SUBSTR('20240531',0,4) || '0100' AND '20240531'  AND  NEW_GU_YR_G = 9  THEN  '1' ELSE '0' END)) 
                   OR ('1' = (CASE WHEN '5' < 3  AND '1' IN(1,30) AND '1' IN(0,7) AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) BETWEEN SUBSTR('20240531',0,4) || '0100' AND '20240531' AND (NEW_GU_YR_G = 1 OR SIGUMGO_HOIKYE_YR = 9999)  THEN  '1' ELSE '0' END)) 
                 )   
              OR ('1' = (CASE WHEN '5' < 3  AND '1' IN(1,30) AND '1' = 1 AND (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) BETWEEN SUBSTR('20240531',0,4) || '0100' AND '20240531'  THEN  '1' ELSE '0' END))   
              OR ('1' = (CASE WHEN '5' < 3  AND '1' IN(1,30) AND '1' = 5 AND NEW_GU_YR_G = 5 THEN  '1' ELSE '0' END))   
              OR (    ('1' = (CASE WHEN '5' < 3  AND '1' IN(1,30) AND '1' IN(8,9) AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) <  SUBSTR('20240531',0,4) || '0100' THEN  '1' ELSE '0' END))   
                   OR ('1' = (CASE WHEN '5' < 3  AND '1' IN(1,30) AND '1' IN(8,9) AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) BETWEEN SUBSTR('20240531',0,4) || '0100' AND '20240531'  AND  NEW_GU_YR_G = 9  THEN  '1' ELSE '0' END)) 
                 )   
              OR ('1' = (CASE WHEN '1'  = 23  AND (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) BETWEEN '20061231' AND '20240531' THEN  '1' ELSE '0' END))   
              OR ('1' = (CASE WHEN ('1' NOT IN(1,23,30) OR ('5' >= 3 AND '1' IN(1,30))) AND (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) <= '20240531' THEN  '1' ELSE '0' END))   
             )
         AND A.SIGUMGO_AC_B IN('10','20')  
     ) AA
     , (SELECT REF_D_C, REF_D_NM FROM RPT_CODE_INFO
         WHERE REF_L_C=500
           AND REF_M_C=28
           AND REF_S_C = 1
        UNION ALL
       SELECT 9999 REF_D_C, '합계' REF_D_NM FROM DUAL) BB
 WHERE AA.GUNGU_CODE(+)   = BB.REF_D_C
 GROUP BY REF_D_C, REF_D_NM, DATA_ROW
 ORDER BY GUNGU_CODE


 ----------------------------------------------------------------


       SELECT   A.SGG_ACNO,
                A.BAS_DT,
                A.DEP_MK_JI_AMT,
                A.DEP_HJI_AMT,
                SUM(DEP_MK_JI_AMT-DEP_HJI_AMT) SUM_AMT
        FROM RPT_TXIO_DDAC_TAB A
       WHERE 1=1
         AND A.SIGUMGO_ORG_C  = '28'
         AND A.ICH_SIGUMGO_HOIKYE_C = '1'
         AND ( ( '1' IN (21,22) AND ICH_SIGUMGO_GUN_GU_C = 0) OR  ( '1' = 1  AND ICH_SIGUMGO_GUN_GU_C <> 0) OR ( '1' NOT IN (1, 21,22) )) 
         AND ICH_SIGUMGO_GUN_GU_C LIKE '110' || '%' 
         AND (   (    ('1' = (CASE WHEN '5' < 3  AND '1' IN(1,30) AND '1' IN(0,7) AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) <  SUBSTR('20240531',0,4) || '0100' THEN  '1' ELSE '0' END))   
                   OR ('1' = (CASE WHEN '5' < 3  AND '1' IN(1,30) AND '1' IN(0,7) AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) BETWEEN SUBSTR('20240531',0,4) || '0100' AND '20240531'  AND  NEW_GU_YR_G = 9  THEN  '1' ELSE '0' END)) 
                   OR ('1' = (CASE WHEN '5' < 3  AND '1' IN(1,30) AND '1' IN(0,7) AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) BETWEEN SUBSTR('20240531',0,4) || '0100' AND '20240531' AND (NEW_GU_YR_G = 1 OR SIGUMGO_HOIKYE_YR = 9999)  THEN  '1' ELSE '0' END)) 
                 )   
              OR ('1' = (CASE WHEN '5' < 3  AND '1' IN(1,30) AND '1' = 1 AND (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) BETWEEN SUBSTR('20240531',0,4) || '0100' AND '20240531'  THEN  '1' ELSE '0' END))   
              OR ('1' = (CASE WHEN '5' < 3  AND '1' IN(1,30) AND '1' = 5 AND NEW_GU_YR_G = 5 THEN  '1' ELSE '0' END))   
              OR (    ('1' = (CASE WHEN '5' < 3  AND '1' IN(1,30) AND '1' IN(8,9) AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) <  SUBSTR('20240531',0,4) || '0100' THEN  '1' ELSE '0' END))   
                   OR ('1' = (CASE WHEN '5' < 3  AND '1' IN(1,30) AND '1' IN(8,9) AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) BETWEEN SUBSTR('20240531',0,4) || '0100' AND '20240531'  AND  NEW_GU_YR_G = 9  THEN  '1' ELSE '0' END)) 
                 )   
              OR ('1' = (CASE WHEN '1'  = 23  AND (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) BETWEEN '20061231' AND '20240531' THEN  '1' ELSE '0' END))   
              OR ('1' = (CASE WHEN ('1' NOT IN(1,23,30) OR ('5' >= 3 AND '1' IN(1,30))) AND (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) <= '20240531' THEN  '1' ELSE '0' END))   
             )
         AND A.SIGUMGO_AC_B IN('10','20')
         AND (
                A.DEP_MK_JI_AMT > 0 
                OR  
                A.DEP_HJI_AMT > 0
         )
         ORDER BY BAS_DT, SGG_ACNO



                SELECT   A.SGG_ACNO,
                A.BAS_DT,
                SUM(DEP_MK_JI_AMT-DEP_HJI_AMT) SUM_AMT
        FROM RPT_TXIO_DDAC_TAB A
       WHERE 1=1
         AND A.SIGUMGO_ORG_C  = '28'
         AND A.ICH_SIGUMGO_HOIKYE_C = '1'
         AND ( ( '1' IN (21,22) AND ICH_SIGUMGO_GUN_GU_C = 0) OR  ( '1' = 1  AND ICH_SIGUMGO_GUN_GU_C <> 0) OR ( '1' NOT IN (1, 21,22) )) 
         AND ICH_SIGUMGO_GUN_GU_C LIKE '110' || '%' 
         AND (   (    ('1' = (CASE WHEN '5' < 3  AND '1' IN(1,30) AND '1' IN(0,7) AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) <  SUBSTR('20240531',0,4) || '0100' THEN  '1' ELSE '0' END))   
                   OR ('1' = (CASE WHEN '5' < 3  AND '1' IN(1,30) AND '1' IN(0,7) AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) BETWEEN SUBSTR('20240531',0,4) || '0100' AND '20240531'  AND  NEW_GU_YR_G = 9  THEN  '1' ELSE '0' END)) 
                   OR ('1' = (CASE WHEN '5' < 3  AND '1' IN(1,30) AND '1' IN(0,7) AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) BETWEEN SUBSTR('20240531',0,4) || '0100' AND '20240531' AND (NEW_GU_YR_G = 1 OR SIGUMGO_HOIKYE_YR = 9999)  THEN  '1' ELSE '0' END)) 
                 )   
              OR ('1' = (CASE WHEN '5' < 3  AND '1' IN(1,30) AND '1' = 1 AND (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) BETWEEN SUBSTR('20240531',0,4) || '0100' AND '20240531'  THEN  '1' ELSE '0' END))   
              OR ('1' = (CASE WHEN '5' < 3  AND '1' IN(1,30) AND '1' = 5 AND NEW_GU_YR_G = 5 THEN  '1' ELSE '0' END))   
              OR (    ('1' = (CASE WHEN '5' < 3  AND '1' IN(1,30) AND '1' IN(8,9) AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) <  SUBSTR('20240531',0,4) || '0100' THEN  '1' ELSE '0' END))   
                   OR ('1' = (CASE WHEN '5' < 3  AND '1' IN(1,30) AND '1' IN(8,9) AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) BETWEEN SUBSTR('20240531',0,4) || '0100' AND '20240531'  AND  NEW_GU_YR_G = 9  THEN  '1' ELSE '0' END)) 
                 )   
              OR ('1' = (CASE WHEN '1'  = 23  AND (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) BETWEEN '20061231' AND '20240531' THEN  '1' ELSE '0' END))   
              OR ('1' = (CASE WHEN ('1' NOT IN(1,23,30) OR ('5' >= 3 AND '1' IN(1,30))) AND (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) <= '20240531' THEN  '1' ELSE '0' END))   
             )
         AND A.SIGUMGO_AC_B IN('10','20')
         AND (
                A.DEP_MK_JI_AMT > 0 
                OR  
                A.DEP_HJI_AMT > 0
         )
         GROUP BY BAS_DT, SGG_ACNO
         ORDER BY BAS_DT, SGG_ACNO