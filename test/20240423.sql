SELECT GUNGU_CODE, GUNGU_NM, NVL(DATA_ROW,1) AS DATA_ROW,
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
          SELECT REF_D_C GUNGU_CODE, REF_D_NM GUNGU_NM, NVL(DATA_ROW,1) AS DATA_ROW,
                          SUM(NVL(CASE DATA_ROW WHEN 1 THEN ILGYE_SEIB_SUIP WHEN 2 THEN ILGYE_SECHUL_BAEJEONG - ILGYE_SECHUL_HWANSU ELSE 0 END, 0)) AMT1 ,
                          SUM(NVL(CASE DATA_ROW WHEN 1 THEN ILGYE_SEIB_BANNAB WHEN 2 THEN ILGYE_SECHUL_JI ELSE 0 END, 0)) AMT2 ,
                          SUM(NVL(CASE DATA_ROW WHEN 1 THEN 0 WHEN 2 THEN ILGYE_SECHUL_BANNAB ELSE 0 END, 0)) AMT3 ,
                          SUM(NVL(CASE DATA_ROW WHEN 1 THEN 0 WHEN 2 THEN ILGYE_SECHUL_GYULSANBF_IWOL - ILGYE_SEIB_GYULSANBF_IIB ELSE 0 END, 0)) AMT4,
                          SUM(NVL(CASE DATA_ROW WHEN 1 THEN 0 WHEN 2 THEN ILGYE_DEP - ILGYE_YEKEUM_HEAJI ELSE 0 END, 0)) AMT5,
                          SUM(NVL(CASE DATA_ROW WHEN 1 THEN 0 WHEN 2 THEN ILGYE_JEONYONG_JI - ILGYE_JEONYONG_IP ELSE 0 END, 0)) AMT6,
                          SUM(NVL(0 , 0)) AMT7 , SUM(NVL(0 , 0)) AMT8 , SUM(NVL(0 , 0)) AMT9 ,
                          SUM(NVL(0, 0)) AMT10, SUM(NVL(0, 0)) AMT11, SUM(NVL(0, 0)) AMT12,
                          SUM(NVL(CASE DATA_ROW WHEN 1 THEN NUGYE_SEIB_SUIP WHEN 2 THEN NUGYE_SECHUL_BAEJEONG - NUGYE_SECHUL_HWANSU ELSE 0 END, 0)) AMT13 ,
                          SUM(NVL(CASE DATA_ROW WHEN 1 THEN NUGYE_SEIB_BANNAB WHEN 2 THEN NUGYE_SECHUL_JI ELSE 0 END, 0)) AMT14 ,
                          SUM(NVL(CASE DATA_ROW WHEN 1 THEN 0 WHEN 2 THEN NUGYE_SECHUL_BANNAB ELSE 0 END, 0)) AMT15 ,
                          SUM(NVL(CASE DATA_ROW WHEN 1 THEN 0 WHEN 2 THEN NUGYE_SECHUL_GYULSANBF_IWOL - NUGYE_SEIB_GYULSANBF_IIB ELSE 0 END, 0)) AMT16,
                          SUM(NVL(CASE DATA_ROW WHEN 1 THEN 0 WHEN 2 THEN NUGYE_DEP - NUGYE_YEKEUM_HEAJI ELSE 0 END, 0)) AMT17,
                          SUM(NVL(CASE DATA_ROW WHEN 1 THEN 0 WHEN 2 THEN NUGYE_JEONYONG_JI - NUGYE_JEONYONG_IP ELSE 0 END, 0)) AMT18,
                          SUM(NVL(0, 0)) AMT19, SUM(NVL(0, 0)) AMT20, SUM(NVL(0, 0)) AMT21,
                          SUM(NVL(0, 0)) AMT22, SUM(NVL(0, 0)) AMT23, SUM(NVL(0, 0)) AMT24,
                          SUM(NVL(CASE DATA_ROW WHEN 1 THEN WOLGYE_SEIB_SUIP + WOLGYE_SEIB_BANNAB WHEN 2 THEN 0 ELSE 0 END, 0)) AMT25,
                          SUM(NVL(0, 0)) AMT26, SUM(NVL(0, 0)) AMT27, SUM(NVL(0, 0)) AMT28
          FROM  
   (
                 SELECT
                                    M.REF_D_C, M.REF_D_NM, M.DATA_ROW,
                                    K.GONGGEUM_GYEJWA_NM AS NUGYE_HOIGYE_NAME,
                                    K.GONGGEUM_GYEJWA AS GONGGEUM_GYEJWA,
                                    (SUM(NVL(TAX_SUNP_IP_AMT,0)) + SUM(NVL(TAX_BAEJUNG_IP_AMT,0))) AS NUGYE_SEIB_SUIP,
                                    SUM(NVL(SEIB_BANNAB,0)) AS NUGYE_SEIB_BANNAB,
                                    SUM(NVL(SEIB_GYEONGJEONG_IB,0)) AS NUGYE_SEIB_GYEONGJEONG_IB,
                                    SUM(NVL(SEIB_GYEONGJEONG_JI,0)) AS NUGYE_SEIB_GYEONGJEONG_JI,
                                    SUM(NVL(SECHUL_BAEJEONG,0)) AS NUGYE_SECHUL_BAEJEONG,
                                    SUM(NVL(SECHUL_HWANSU,0)) AS NUGYE_SECHUL_HWANSU,
                                    SUM(NVL(SECHUL_JI,0)) AS NUGYE_SECHUL_JI,
                                    SUM(NVL(SECHUL_BANNAB,0)) AS NUGYE_SECHUL_BANNAB,
                                    SUM(NVL(SECHUL_GYEONGJEONG_IB,0)) AS NUGYE_SECHUL_GYEONGJEONG_IB,
                                    SUM(NVL(SECHUL_GYEONGJEONG_JI,0)) AS NUGYE_SECHUL_GYEONGJEONG_JI,
                                    SUM(NVL(SEIB_GYULSANBF_IIB,0)) AS NUGYE_SEIB_GYULSANBF_IIB,
                                    SUM(NVL(SECHUL_GYULSANBF_IWOL,0)) AS NUGYE_SECHUL_GYULSANBF_IWOL,
                                    SUM(NVL(DEP,0)) AS NUGYE_DEP,
                                    SUM(NVL(YEKEUM_HEAJI,0)) AS NUGYE_YEKEUM_HEAJI,
                                    SUM(NVL(JEONYONG_JI,0)) AS NUGYE_JEONYONG_JI,
                                    SUM(NVL(JEONYONG_IP,0)) AS NUGYE_JEONYONG_IP,
                                    (SUM(NVL(TAX_SUNP_IP_AMT2,0)) + SUM(NVL(TAX_BAEJUNG_IP_AMT2,0))) AS ILGYE_SEIB_SUIP,
                                    SUM(NVL(SEIB_BANNAB2,0)) AS ILGYE_SEIB_BANNAB,
                                    SUM(NVL(SEIB_GYEONGJEONG_IB2,0)) AS ILGYE_SEIB_GYEONGJEONG_IB,
                                    SUM(NVL(SEIB_GYEONGJEONG_JI2,0)) AS ILGYE_SEIB_GYEONGJEONG_JI,
                                    SUM(NVL(SECHUL_BAEJEONG2,0)) AS ILGYE_SECHUL_BAEJEONG,
                                    SUM(NVL(SECHUL_HWANSU2,0)) AS ILGYE_SECHUL_HWANSU,
                                    SUM(NVL(SECHUL_JI2,0)) AS ILGYE_SECHUL_JI,
                                    SUM(NVL(SECHUL_BANNAB2,0)) AS ILGYE_SECHUL_BANNAB,
                                    SUM(NVL(SECHUL_GYEONGJEONG_IB2,0)) AS ILGYE_SECHUL_GYEONGJEONG_IB,
                                    SUM(NVL(SECHUL_GYEONGJEONG_JI2,0)) AS ILGYE_SECHUL_GYEONGJEONG_JI,
                                    SUM(NVL(SEIB_GYULSANBF_IIB2,0)) AS ILGYE_SEIB_GYULSANBF_IIB,
                                    SUM(NVL(SECHUL_GYULSANBF_IWOL2,0)) AS ILGYE_SECHUL_GYULSANBF_IWOL,
                                    SUM(NVL(DEP2,0)) AS ILGYE_DEP,
                                    SUM(NVL(YEKEUM_HEAJI2,0)) ILGYE_YEKEUM_HEAJI,
                                    SUM(NVL(JEONYONG_JI2,0)) AS ILGYE_JEONYONG_JI,
                                    SUM(NVL(JEONYONG_IP2,0)) ILGYE_JEONYONG_IP,
                                    (SUM(NVL(TAX_SUNP_IP_AMT3,0)) + SUM(NVL(TAX_BAEJUNG_IP_AMT3,0))) AS WOLGYE_SEIB_SUIP,
                                    (SUM(NVL(SEIB_BANNAB3,0))) AS WOLGYE_SEIB_BANNAB
                 FROM
                 (
                      SELECT
                                     GONGGEUM_GUNGU_CODE AS GUNGU_CODE,
                                      GONGGEUM_GYEJWA,
                                      CASE WHEN  GEORAE_GUBUN = 11  
                    THEN  IPGEUM_AMT * JO ELSE 0 END TAX_SUNP_IP_AMT,
                                               CASE WHEN  GEORAE_GUBUN IN (15,16) 
                    THEN  IPGEUM_AMT * JO ELSE 0 END TAX_BAEJUNG_IP_AMT,
                                               CASE WHEN  GEORAE_GUBUN = 64 
                    THEN  JIGEUB_AMT * JO ELSE 0 END SEIB_BANNAB,
                                               CASE WHEN  GEORAE_GUBUN = 19  
                    THEN  IPGEUM_AMT * JO ELSE 0 END SEIB_GYEONGJEONG_IB,    
                                               CASE WHEN  GEORAE_GUBUN = 69
                    THEN  JIGEUB_AMT * JO ELSE 0 END SEIB_GYEONGJEONG_JI, 
                                               CASE WHEN  ((GEORAE_GUBUN = 61 AND JIGEUB_GEORAE = 1) OR (GEORAE_GUBUN = 68 AND JIGEUB_GEORAE = 0))
                    THEN  JIGEUB_AMT * JO ELSE 0 END SECHUL_BAEJEONG,
                                               CASE WHEN  GEORAE_GUBUN = 14 AND IPGEUM_GEORAE = 6
                    THEN  IPGEUM_AMT * JO ELSE 0 END SECHUL_HWANSU,
                                               CASE WHEN  GEORAE_GUBUN = 67
                    THEN  JIGEUB_AMT * JO ELSE 0 END SECHUL_JI,
                                               CASE WHEN  GEORAE_GUBUN = 17
                    THEN  IPGEUM_AMT * JO ELSE 0 END SECHUL_BANNAB,
                                               CASE WHEN  GEORAE_GUBUN = 18
                    THEN  IPGEUM_AMT * JO ELSE 0 END SECHUL_GYEONGJEONG_IB,
                                               CASE WHEN  GEORAE_GUBUN = 65
                    THEN  JIGEUB_AMT * JO ELSE 0 END SECHUL_GYEONGJEONG_JI,
                                               CASE WHEN  GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 4
                    THEN  IPGEUM_AMT * JO ELSE 0 END SEIB_GYULSANBF_IIB,
                                               CASE WHEN  GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 4
                    THEN  JIGEUB_AMT * JO ELSE 0 END SECHUL_GYULSANBF_IWOL,
                                               CASE WHEN  GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 3
                    THEN  JIGEUB_AMT * JO ELSE 0 END DEP,
                                               CASE WHEN  GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 3
                    THEN  IPGEUM_AMT * JO ELSE 0 END YEKEUM_HEAJI,
                                               CASE WHEN  GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 5
                    THEN  JIGEUB_AMT * JO ELSE 0 END JEONYONG_JI,
                                               CASE WHEN  GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 5
                    THEN  IPGEUM_AMT * JO ELSE 0 END JEONYONG_IP,
                                      0 AS TAX_SUNP_IP_AMT2,
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
                                      0 AS YEKEUM_HEAJI2,
                                      0 AS JEONYONG_JI2,
                                      0 AS JEONYONG_IP2,
                                      CASE WHEN ILJA BETWEEN '00000101' AND '20231025' AND  GEORAE_GUBUN = 11  
                    THEN  IPGEUM_AMT * JO ELSE 0 END TAX_SUNP_IP_AMT3,        
                                               CASE WHEN ILJA BETWEEN '00000101' AND '20231025' AND  GEORAE_GUBUN IN (15,16)
                    THEN  IPGEUM_AMT * JO ELSE 0 END TAX_BAEJUNG_IP_AMT3,               
                                               CASE WHEN ILJA BETWEEN  '00000101' AND '20231025' AND  GEORAE_GUBUN = 64  
                    THEN  JIGEUB_AMT * JO ELSE 0 END SEIB_BANNAB3        
                      FROM 
        (
                                    SELECT
                                                   A.ICH_SIGUMGO_GUN_GU_C GONGGEUM_GUNGU_CODE, 
                                        A.FIL_100_CTNT5 GONGGEUM_GYEJWA, A.SIGUMGO_TRX_G GEORAE_GUBUN, 
                            DECODE(A.IPJI_G,1,A.TRAMT,0) IPGEUM_AMT, DECODE(A.IPJI_G,2,A.TRAMT,0) JIGEUB_AMT,
                                                   A.SIGUMGO_JI_TRX_G JIGEUB_GEORAE, A.SIGUMGO_IP_TRX_G IPGEUM_GEORAE,
                                                   A.GJDT ILJA,
                                                   DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1) AS JO,
                                                   CASE WHEN A.SIGUMGO_HOIKYE_YR = 9999 THEN TO_NUMBER(SUBSTR(A.GJDT,1,4))
                                                          ELSE TO_NUMBER(A.SIGUMGO_HOIKYE_YR) END R_HOIGYE_YEAR
                                    FROM  ACL_SIGUMGO_SLV A
                                    WHERE  A.GJDT BETWEEN (CASE WHEN A.SIGUMGO_HOIKYE_YR = 9999 THEN '20230101' ELSE '00000101' END) AND '20231025' 
                                    AND A.SIGUMGO_ORG_C = '28'                                    
                                    AND A.ICH_SIGUMGO_GUN_GU_C LIKE '' || '%'
                                    AND A.FIL_100_CTNT5 = '02800075690000699'
        )
                      UNION ALL         
                      SELECT
                                     GONGGEUM_GUNGU_CODE AS GUNGU_CODE,
                                     GONGGEUM_GYEJWA,
                                     0 AS TAX_SUNP_IP_AMT, 
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
                                     0 AS YEKEUM_HEAJI,              
                                     0 AS JEONYONG_JI,
                                     0 AS JEONYONG_IP,
                                     CASE WHEN  GEORAE_GUBUN = 11 
                   THEN  IPGEUM_AMT * JO ELSE 0 END TAX_SUNP_IP_AMT2,
                                              CASE WHEN  GEORAE_GUBUN IN (15,16)
                   THEN  IPGEUM_AMT * JO ELSE 0 END TAX_BAEJUNG_IP_AMT2,        
                                              CASE WHEN  GEORAE_GUBUN = 64
                   THEN  JIGEUB_AMT * JO ELSE 0 END SEIB_BANNAB2,
                                              CASE WHEN  GEORAE_GUBUN = 19
                   THEN  IPGEUM_AMT * JO ELSE 0 END SEIB_GYEONGJEONG_IB2,    
                                              CASE WHEN  GEORAE_GUBUN = 69
                   THEN  JIGEUB_AMT * JO ELSE 0 END SEIB_GYEONGJEONG_JI2, 
                                              CASE WHEN  ((GEORAE_GUBUN = 61 AND JIGEUB_GEORAE = 1) OR (GEORAE_GUBUN = 68 AND JIGEUB_GEORAE = 0))
                   THEN  JIGEUB_AMT * JO ELSE 0 END SECHUL_BAEJEONG2,
                                              CASE WHEN  GEORAE_GUBUN = 14 AND IPGEUM_GEORAE = 6
                   THEN  IPGEUM_AMT * JO ELSE 0 END SECHUL_HWANSU2,
                                              CASE WHEN  GEORAE_GUBUN = 67
                   THEN  JIGEUB_AMT * JO ELSE 0 END SECHUL_JI2,
                                              CASE WHEN  GEORAE_GUBUN = 17
                   THEN  IPGEUM_AMT * JO ELSE 0 END SECHUL_BANNAB2, 
                                              CASE WHEN  GEORAE_GUBUN = 18
                   THEN  IPGEUM_AMT * JO ELSE 0 END SECHUL_GYEONGJEONG_IB2,
                                              CASE WHEN  GEORAE_GUBUN = 65
                   THEN  JIGEUB_AMT * JO ELSE 0 END SECHUL_GYEONGJEONG_JI2,
                                              CASE WHEN  GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 4
                   THEN  IPGEUM_AMT * JO ELSE 0 END SEIB_GYULSANBF_IIB2,
                                              CASE WHEN  GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 4
                   THEN  JIGEUB_AMT * JO ELSE 0 END SECHUL_GYULSANBF_IWOL2,
                                              CASE WHEN  GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 3
                   THEN  JIGEUB_AMT * JO ELSE 0 END DEP2,             
                                              CASE WHEN  GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 3
                   THEN  IPGEUM_AMT * JO ELSE 0 END YEKEUM_HEAJI2,             
                                              CASE WHEN  GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 5
                   THEN  JIGEUB_AMT * JO ELSE 0 END JEONYONG_JI2,             
                                              CASE WHEN  GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 5
                   THEN  IPGEUM_AMT * JO ELSE 0 END JEONYONG_IP2,             
                                     0 TAX_SUNP_IP_AMT3,                                          
                                     0 TAX_BAEJUNG_IP_AMT3,                                                      
                                     0 SEIB_BANNAB3                                                
                      FROM 
        (
                         SELECT
                                          A.ICH_SIGUMGO_GUN_GU_C GONGGEUM_GUNGU_CODE, 
                      A.FIL_100_CTNT5 GONGGEUM_GYEJWA, A.SIGUMGO_TRX_G GEORAE_GUBUN,
                      DECODE(A.IPJI_G,1,A.TRAMT,0) IPGEUM_AMT, DECODE(A.IPJI_G,2,A.TRAMT,0) JIGEUB_AMT,
                                          A.SIGUMGO_JI_TRX_G JIGEUB_GEORAE, A.SIGUMGO_IP_TRX_G IPGEUM_GEORAE,
                                          A.GJDT ILJA,
                                          DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1) AS JO,
                                          CASE WHEN A.SIGUMGO_HOIKYE_YR = 9999 THEN TO_NUMBER(SUBSTR(A.GJDT,1,4))
                                                  ELSE TO_NUMBER(A.SIGUMGO_HOIKYE_YR) END R_HOIGYE_YEAR 
                         FROM ACL_SIGUMGO_SLV A
                         WHERE A.GJDT BETWEEN '20231025' AND '20231025'
                         AND A.SIGUMGO_ORG_C = '28'                         
                         AND A.ICH_SIGUMGO_GUN_GU_C LIKE '' || '%'
                         AND A.FIL_100_CTNT5 = '02800075690000699'
        )
        UNION ALL         
        SELECT
                                      9999 AS GUNGU_CODE,
                                      GONGGEUM_GYEJWA,
                                      CASE WHEN  GEORAE_GUBUN = 11 
                    THEN  IPGEUM_AMT * JO ELSE 0 END TAX_SUNP_IP_AMT,
                                               CASE WHEN  GEORAE_GUBUN IN (15,16)
                    THEN  IPGEUM_AMT * JO ELSE 0 END TAX_BAEJUNG_IP_AMT,        
                                               CASE WHEN  GEORAE_GUBUN = 64
                    THEN  JIGEUB_AMT * JO ELSE 0 END SEIB_BANNAB,
                                               CASE WHEN  GEORAE_GUBUN = 19
                    THEN  IPGEUM_AMT * JO ELSE 0 END SEIB_GYEONGJEONG_IB,    
                                               CASE WHEN  GEORAE_GUBUN = 69
                    THEN  JIGEUB_AMT * JO ELSE 0 END SEIB_GYEONGJEONG_JI, 
                                               CASE WHEN  ((GEORAE_GUBUN = 61 AND JIGEUB_GEORAE = 1) OR (GEORAE_GUBUN = 68 AND JIGEUB_GEORAE = 0))
                    THEN  JIGEUB_AMT * JO ELSE 0 END SECHUL_BAEJEONG,
                                               CASE WHEN  GEORAE_GUBUN = 14 AND IPGEUM_GEORAE = 6
                    THEN  IPGEUM_AMT * JO ELSE 0 END SECHUL_HWANSU,
                                               CASE WHEN  GEORAE_GUBUN = 67
                    THEN  JIGEUB_AMT * JO ELSE 0 END SECHUL_JI,
                                               CASE WHEN  GEORAE_GUBUN = 17
                    THEN  IPGEUM_AMT * JO ELSE 0 END SECHUL_BANNAB, 
                                               CASE WHEN  GEORAE_GUBUN = 18
                    THEN  IPGEUM_AMT * JO ELSE 0 END SECHUL_GYEONGJEONG_IB,
                                               CASE WHEN  GEORAE_GUBUN = 65
                    THEN  JIGEUB_AMT * JO ELSE 0 END SECHUL_GYEONGJEONG_JI,
                                               CASE WHEN  GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 4
                    THEN  IPGEUM_AMT * JO ELSE 0 END SEIB_GYULSANBF_IIB,
                                               CASE WHEN  GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 4
                    THEN  JIGEUB_AMT * JO ELSE 0 END SECHUL_GYULSANBF_IWOL,
                                               CASE WHEN  GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 3
                    THEN  JIGEUB_AMT * JO ELSE 0 END DEP,
                                               CASE WHEN  GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 3
                    THEN  IPGEUM_AMT * JO ELSE 0 END YEKEUM_HEAJI,             
                                               CASE WHEN  GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 5
                    THEN  JIGEUB_AMT * JO ELSE 0 END JEONYONG_JI,
                                               CASE WHEN  GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 5
                    THEN  IPGEUM_AMT * JO ELSE 0 END JEONYONG_IP, 
                                      0 AS TAX_SUNP_IP_AMT2, 
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
                                      0 AS YEKEUM_HEAJI2,
                                      0 AS JEONYONG_JI2,
                                      0 AS JEONYONG_IP2,
                                      CASE WHEN ILJA BETWEEN  '00000101' AND '20231025' AND  GEORAE_GUBUN = 11
                    THEN  IPGEUM_AMT * JO ELSE 0 END TAX_SUNP_IP_AMT3,
                                               CASE WHEN ILJA BETWEEN  '00000101' AND '20231025' AND  GEORAE_GUBUN IN (15,16)
                    THEN  IPGEUM_AMT * JO ELSE 0 END TAX_BAEJUNG_IP_AMT3,        
                                               CASE WHEN ILJA BETWEEN '00000101' AND '20231025' AND  GEORAE_GUBUN = 64
                    THEN  JIGEUB_AMT * JO ELSE 0 END SEIB_BANNAB3 
        FROM 
        (
                         SELECT
                                         A.ICH_SIGUMGO_GUN_GU_C GONGGEUM_GUNGU_CODE,
                      A.FIL_100_CTNT5 GONGGEUM_GYEJWA, A.SIGUMGO_TRX_G GEORAE_GUBUN, 
                      DECODE(A.IPJI_G,1,A.TRAMT,0) IPGEUM_AMT, DECODE(A.IPJI_G,2,A.TRAMT,0) JIGEUB_AMT,
                                         A.SIGUMGO_JI_TRX_G JIGEUB_GEORAE, A.SIGUMGO_IP_TRX_G IPGEUM_GEORAE,
                                         A.GJDT ILJA,
                                         DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1) AS JO,
                                         CASE WHEN A.SIGUMGO_HOIKYE_YR = 9999 THEN TO_NUMBER(SUBSTR(A.GJDT,1,4))
                                                ELSE TO_NUMBER(A.SIGUMGO_HOIKYE_YR) END R_HOIGYE_YEAR
                         FROM  ACL_SIGUMGO_SLV A
                         WHERE  A.GJDT BETWEEN (CASE WHEN A.SIGUMGO_HOIKYE_YR = 9999 THEN '20230101' ELSE '00000101' END) AND '20231025'
                         AND A.SIGUMGO_ORG_C = '28'
                         AND A.ICH_SIGUMGO_GUN_GU_C LIKE '' || '%'
                         AND A.FIL_100_CTNT5 = '02800075690000699'

        )
        UNION ALL         
        SELECT
                                         9999 AS GUNGU_CODE,
                                         GONGGEUM_GYEJWA,
                                         0 AS TAX_SUNP_IP_AMT, 
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
                                         0 AS YEKEUM_HEAJI,              
                                         0 AS JEONYONG_JI,
                                         0 AS JEONYONG_IP,
                                         CASE WHEN  GEORAE_GUBUN = 11 
                     THEN  IPGEUM_AMT * JO ELSE 0 END TAX_SUNP_IP_AMT2,
                                                   CASE WHEN  GEORAE_GUBUN IN (15,16)
                     THEN  IPGEUM_AMT * JO ELSE 0 END TAX_BAEJUNG_IP_AMT2,        
                                                   CASE WHEN  GEORAE_GUBUN = 64
                     THEN  JIGEUB_AMT * JO ELSE 0 END SEIB_BANNAB2,
                                                   CASE WHEN  GEORAE_GUBUN = 19
                     THEN  IPGEUM_AMT * JO ELSE 0 END SEIB_GYEONGJEONG_IB2,    
                                                   CASE WHEN  GEORAE_GUBUN = 69
                     THEN  JIGEUB_AMT * JO ELSE 0 END SEIB_GYEONGJEONG_JI2, 
                                                   CASE WHEN  ((GEORAE_GUBUN = 61 AND JIGEUB_GEORAE = 1) OR (GEORAE_GUBUN = 68 AND JIGEUB_GEORAE = 0))
                     THEN  JIGEUB_AMT * JO ELSE 0 END SECHUL_BAEJEONG2,
                                                   CASE WHEN  GEORAE_GUBUN = 14 AND IPGEUM_GEORAE = 6
                     THEN  IPGEUM_AMT * JO ELSE 0 END SECHUL_HWANSU2,
                                                   CASE WHEN  GEORAE_GUBUN = 67
                     THEN  JIGEUB_AMT * JO ELSE 0 END SECHUL_JI2,
                                                   CASE WHEN  GEORAE_GUBUN = 17
                     THEN  IPGEUM_AMT * JO ELSE 0 END SECHUL_BANNAB2, 
                                                   CASE WHEN  GEORAE_GUBUN = 18
                     THEN  IPGEUM_AMT * JO ELSE 0 END SECHUL_GYEONGJEONG_IB2,
                                                   CASE WHEN  GEORAE_GUBUN = 65
                     THEN  JIGEUB_AMT * JO ELSE 0 END SECHUL_GYEONGJEONG_JI2,
                                                   CASE WHEN  GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 4
                     THEN  IPGEUM_AMT * JO ELSE 0 END SEIB_GYULSANBF_IIB2,
                                                   CASE WHEN  GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 4
                     THEN  JIGEUB_AMT * JO ELSE 0 END SECHUL_GYULSANBF_IWOL2,
                                                   CASE WHEN  GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 3
                     THEN  JIGEUB_AMT * JO ELSE 0 END DEP2,             
                                                   CASE WHEN  GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 3
                     THEN  IPGEUM_AMT * JO ELSE 0 END YEKEUM_HEAJI2,             
                                                   CASE WHEN  GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 5
                     THEN  JIGEUB_AMT * JO ELSE 0 END JEONYONG_JI2,             
                                                   CASE WHEN  GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 5
                     THEN  IPGEUM_AMT * JO ELSE 0 END JEONYONG_IP2,             
                                         0 TAX_SUNP_IP_AMT3,                                          
                                         0 TAX_BAEJUNG_IP_AMT3,                                                      
                                         0 SEIB_BANNAB3                                                
        FROM 
        (
                           SELECT
                                         A.ICH_SIGUMGO_GUN_GU_C GONGGEUM_GUNGU_CODE,
                     A.FIL_100_CTNT5 GONGGEUM_GYEJWA, A.SIGUMGO_TRX_G GEORAE_GUBUN,
                     DECODE(A.IPJI_G,1,A.TRAMT,0) IPGEUM_AMT, DECODE(A.IPJI_G,2,A.TRAMT,0) JIGEUB_AMT,
                                         A.SIGUMGO_JI_TRX_G JIGEUB_GEORAE, A.SIGUMGO_IP_TRX_G IPGEUM_GEORAE,
                                         A.GJDT ILJA,
                                         DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1) AS JO,
                                         CASE WHEN A.SIGUMGO_HOIKYE_YR = 9999 THEN TO_NUMBER(SUBSTR(A.GJDT,1,4))
                                                ELSE TO_NUMBER(A.SIGUMGO_HOIKYE_YR) END R_HOIGYE_YEAR
                           FROM  ACL_SIGUMGO_SLV A
                           WHERE A.GJDT BETWEEN  '20231025' AND '20231025'
                           AND A.SIGUMGO_ORG_C = '28'                           
                           AND A.ICH_SIGUMGO_GUN_GU_C LIKE '' || '%'                  
                           AND A.FIL_100_CTNT5 = '02800075690000699'
        )
        UNION ALL         
        SELECT
                                         GUNGU_CODE,
                                         GONGGEUM_GYEJWA,
                                         JANAEK AS TAX_SUNP_IP_AMT, 
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
                                         0 AS YEKEUM_HEAJI,              
                                         0 AS JEONYONG_JI,
                                         0 AS JEONYONG_IP,
                                         0 AS TAX_SUNP_IP_AMT2, 
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
                                         0 AS YEKEUM_HEAJI2,
                                         0 AS JEONYONG_JI2,
                                         0 AS JEONYONG_IP2,
                                         0 TAX_SUNP_IP_AMT3,                                          
                                         0 TAX_BAEJUNG_IP_AMT3,                                                      
                                         0 SEIB_BANNAB3                                                
        FROM
        (
                             SELECT
                                         GUNGU_CODE,
                                         GONGGEUM_GYEJWA,
                                         JANAEK
                             FROM  RPT_GONGGEUM_JAN
                             WHERE  GEUMGO_CODE = '28'
                             AND GUNGU_CODE LIKE '' || '%'
                             AND HOIGYE_CODE = 75
                             AND HOIGYE_YEAR = '9999'
                             AND KEORAEIL IN (SELECT BIZ_DT FROM MAP_JOB_DATE WHERE DW_BAS_DDT = TO_CHAR(TO_NUMBER(SUBSTR('20231025',0,4)) -1)||'1231')
                             AND GONGGEUM_GYEJWA = '02800075690000699'
        )
 ) T,
 (
       SELECT SIGUMGO_AC_NM GONGGEUM_GYEJWA_NM, FIL_100_CTNT2 GONGGEUM_GYEJWA
       FROM ACL_SIGUMGO_MAS
       WHERE SIGUMGO_ORG_C = '28'
             AND FIL_100_CTNT2 = '02800075690000699'
      AND MNG_NO = 1
 ) K,
 (SELECT '' REF_D_C, (SELECT REF_D_NM FROM RPT_CODE_INFO WHERE REF_L_C = 500 AND REF_M_C = '28' AND REF_S_C = 1 AND REF_D_C = '0') REF_D_NM, 1 DATA_ROW FROM DUAL
   UNION ALL
   SELECT '9999' REF_D_C, '합계' REF_D_NM, 2 DATA_ROW FROM DUAL
 ) M
 WHERE T.GONGGEUM_GYEJWA = K.GONGGEUM_GYEJWA
 AND T.GUNGU_CODE(+) = M.REF_D_C
 AND K.GONGGEUM_GYEJWA = '02800075690000699'
 GROUP BY M.REF_D_C, REF_D_NM, M.DATA_ROW, K.GONGGEUM_GYEJWA_NM, K.GONGGEUM_GYEJWA
 ORDER BY M.REF_D_C, REF_D_NM, M.DATA_ROW, K.GONGGEUM_GYEJWA
 ) A
GROUP BY A.REF_D_C, A.REF_D_NM, A.DATA_ROW
UNION ALL
SELECT REF_D_C GUNGU_CODE, REF_D_NM GUNGU_NM, NVL(AA.DATA_ROW,1) AS DATA_ROW,
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
      SELECT  GUNGU_CODE, 1 DATA_ROW,
                       0 AMT1,
                       SUM(CASE WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN  = 1 AND SUNAPIL = '20231025' THEN NVL(JIBANGSE_AMT,0) * -1
                                            WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN  = 2 AND SUNAPIL = '20231025' THEN NVL(JIBANGSE_AMT,0)  ELSE 0 END) AMT2,
                       SUM(CASE WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 1 AND SUNAPIL = '20231025' THEN NVL(JIBANGSE_AMT,0)
                                            WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 2 AND SUNAPIL = '20231025' THEN NVL(JIBANGSE_AMT,0) * -1  ELSE 0 END) AMT3,
                       0 AMT4,
                       SUM(CASE WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN  = 1 AND SUNAPIL = '20231025' THEN NVL(SEWOI_AMT,0) * -1
                                            WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN  = 2 AND SUNAPIL = '20231025' THEN NVL(SEWOI_AMT,0)  ELSE 0 END) AMT5,
                       SUM(CASE WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 1 AND SUNAPIL = '20231025' THEN NVL(SEWOI_AMT,0)
                                            WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 2 AND SUNAPIL = '20231025' THEN NVL(SEWOI_AMT,0) * -1 ELSE 0 END) AMT6,
                       0 AMT7,
                       SUM(CASE WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN  = 1 AND SUNAPIL = '20231025' THEN NVL(GYOYUKSE_AMT,0) * -1
                                            WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN  = 2 AND SUNAPIL = '20231025' THEN NVL(GYOYUKSE_AMT,0) ELSE 0 END) AMT8,
                       SUM(CASE WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 1 AND SUNAPIL = '20231025' THEN NVL(GYOYUKSE_AMT,0)
                                            WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 2 AND SUNAPIL = '20231025' THEN NVL(GYOYUKSE_AMT,0) * -1 ELSE 0 END) AMT9,
                       0 AMT10,
                       SUM(CASE WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN  = 1 AND SUNAPIL = '20231025' THEN NVL(NONGTEUKSE_AMT,0) * -1
                                            WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN  = 2 AND SUNAPIL = '20231025' THEN NVL(NONGTEUKSE_AMT,0) ELSE 0 END) AMT11,
                       SUM(CASE WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 1 AND SUNAPIL = '20231025' THEN NVL(NONGTEUKSE_AMT,0)
                                            WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 2 AND SUNAPIL = '20231025' THEN NVL(NONGTEUKSE_AMT,0) * -1 ELSE 0 END) AMT12,
                       0 AMT13,
                       SUM(CASE WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN = 1 THEN NVL(JIBANGSE_AMT,0) * -1
                                            WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN = 2 THEN NVL(JIBANGSE_AMT,0) ELSE 0 END) AMT14,
                       SUM(CASE WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 1 THEN NVL(JIBANGSE_AMT,0)
                                            WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 2 THEN NVL(JIBANGSE_AMT,0) * -1 ELSE 0 END) AMT15,
                       0 AMT16,
                       SUM(CASE WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN = 1 THEN NVL(SEWOI_AMT,0) * -1
                                            WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN = 2 THEN NVL(SEWOI_AMT,0) ELSE 0 END) AMT17,
                       SUM(CASE WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 1 THEN NVL(SEWOI_AMT,0)
                                            WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 2 THEN NVL(SEWOI_AMT,0) * -1 ELSE 0 END) AMT18,
                       0 AMT19,
                       SUM(CASE WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN = 1 THEN NVL(GYOYUKSE_AMT,0) * -1
                                            WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN = 2 THEN NVL(GYOYUKSE_AMT,0) ELSE 0 END) AMT20,
                       SUM(CASE WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 1 THEN NVL(GYOYUKSE_AMT,0)
                                            WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 2 THEN NVL(GYOYUKSE_AMT,0) * -1 ELSE 0 END) AMT21,
                       0 AMT22,
                       SUM(CASE WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN = 1 THEN NVL(NONGTEUKSE_AMT,0) * -1
                                            WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN = 2 THEN NVL(NONGTEUKSE_AMT,0) ELSE 0 END) AMT23,
                       SUM(CASE WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 1 THEN NVL(NONGTEUKSE_AMT,0)
                                            WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 2 THEN NVL(NONGTEUKSE_AMT,0) * -1 ELSE 0 END) AMT24,
                       SUM(CASE WHEN (SUNAPIL BETWEEN '20231025' AND '20231025') AND IPJI_GUBUN = 1 THEN NVL(JIBANGSE_AMT,0)
                                            WHEN (SUNAPIL BETWEEN SUBSTR('20231025',0,6)||'01' AND '20231025') AND IPJI_GUBUN <> 1 THEN NVL(JIBANGSE_AMT,0) * -1 ELSE 0 END) AMT25,
                       SUM(CASE WHEN (SUNAPIL BETWEEN SUBSTR('20231025',0,6)||'01' AND '20231025') AND IPJI_GUBUN =  1 THEN NVL(SEWOI_AMT,0)
                                            WHEN (SUNAPIL BETWEEN SUBSTR('20231025',0,6)||'01' AND '20231025') AND IPJI_GUBUN <> 1 THEN NVL(SEWOI_AMT,0) * -1 ELSE 0 END) AMT26,
                       SUM(CASE WHEN (SUNAPIL BETWEEN SUBSTR('20231025',0,6)||'01' AND '20231025') AND IPJI_GUBUN =  1 THEN NVL(GYOYUKSE_AMT,0)
                                            WHEN (SUNAPIL BETWEEN SUBSTR('20231025',0,6)||'01' AND '20231025') AND IPJI_GUBUN <> 1 THEN NVL(GYOYUKSE_AMT,0) * -1 ELSE 0 END) AMT27,
                       SUM(CASE WHEN (SUNAPIL BETWEEN SUBSTR('20231025',0,6)||'00' AND '20231025') AND IPJI_GUBUN =  1 THEN NVL(NONGTEUKSE_AMT,0)
                                            WHEN (SUNAPIL BETWEEN SUBSTR('20231025',0,6)||'00' AND '20231025') AND IPJI_GUBUN <> 1 THEN NVL(NONGTEUKSE_AMT,0) * -1 ELSE 0 END) AMT28
      FROM  RPT_DANGSEIPJOJEONG A
       WHERE  A.GEUMGO_CODE = '28' 
       AND A.SUNAPIL <= '20231025'
      AND A.GUNGU_CODE LIKE '' || '%'
      AND A.JIBGYE_CODE = (SELECT REF_D_C FROM RPT_CODE_INFO WHERE REF_L_C = 879 AND REF_M_C = 28 AND REF_CTNT1 = '02800075690000699')
       GROUP BY A.GUNGU_CODE
 ) AA,
 (SELECT '' REF_D_C, (SELECT REF_D_NM FROM RPT_CODE_INFO WHERE REF_L_C = 500 AND REF_M_C = '28' AND REF_S_C = 1 AND REF_D_C = '0') REF_D_NM, 1 DATA_ROW FROM DUAL
   UNION ALL
   SELECT '9999' REF_D_C, '합계' REF_D_NM, 2 DATA_ROW FROM DUAL
 ) M
 WHERE
   AA.GUNGU_CODE(+) = M.REF_D_C
 GROUP BY  REF_D_C, REF_D_NM, AA.DATA_ROW
 ) A
 GROUP BY GUNGU_CODE, GUNGU_NM, DATA_ROW
 ORDER BY GUNGU_CODE, GUNGU_NM, DATA_ROW

================================================================================================

SELECT REF_D_C FROM RPT_CODE_INFO WHERE REF_L_C = 879 AND REF_M_C = 28 AND REF_CTNT1 = '02800075690000699'

759006

select
A.*
FROM  RPT_DANGSEIPJOJEONG A
       WHERE  A.GEUMGO_CODE = '28' 
       AND A.SUNAPIL <= '20231025'
      AND A.GUNGU_CODE LIKE '' || '%'
      AND A.JIBGYE_CODE = '759006'


select * from RPT_SUNAP_JIBGYE
where JIBGYE_CODE = '759006'


select 
A.*
  FROM  RPT_DANGSEIPJOJEONG A
 WHERE
   A.GEUMGO_CODE = '28' AND A.SUNAPIL BETWEEN '2023'||'0101' AND '20231025'
  AND A.GUNGU_CODE = '0'
  AND A.JIBGYE_CODE = (SELECT REF_D_C FROM RPT_CODE_INFO WHERE REF_L_C = 879 AND REF_M_C = 28 AND REF_CTNT1 = '02800075690000699')
  AND (A.YEAR_GUBUN = 1 OR HOIGYE_YEAR = 9999 )

============================================================================================
, 1713832372815
20240423treap1pRPTPWK0191437100

=========================== XDA ID:[tom.ich.rpt.xda.xSelectOneICH030102By02]===============================
SELECT 
      COUNT(*) AS CNT
FROM 
      RPT_EMPLOYEE
WHERE 
      HWNNO = '1016176'
      AND OBNK_JKGP_C IN ('4','Ma','Mb','SM')
============================================================================================
, 1713832372814
20240423treap1pRPTPWK0191437100

=========================== XDA ID:[tom.ich.rpt.xda.xSelectOneICH030102By07]===============================

SELECT ORG_C, ORG_NM, DEPT_C, DEPT_NM, BRNO, BR_NM, RPT_AC_G, SNO, RPT_TRN, RPT_PRC, RQST_DTTM, RQST_CTNT
     , RPT_DTTM, RPT_DT, RPT_CYCL_G, RPT_STEP_G, LST_GYLJ_S_G, LST_GYLJ_S_NM, APP_IMG_KEY_VAL, IMG_KEY_VAL
     , S1_GYLJ_S_G, S1_GYLJ_S_NM, S1_CONFJ_ID, S1_CONFJ_NM, S1_CONF_DT, S1_CONF_RST_DTL_NM
     , S2_GYLJ_S_G, S2_GYLJ_S_NM, S2_CONFJ_ID, S2_CONFJ_NM, S2_CONF_DT, S2_CONF_RST_DTL_NM
     , S3_GYLJ_S_G, S3_GYLJ_S_NM, S3_CONFJ_ID, S3_CONFJ_NM, S3_CONF_DT, S3_CONF_RST_DTL_NM
     , S4_GYLJ_S_G, S4_GYLJ_S_NM, S4_CONFJ_ID, S4_CONFJ_NM, S4_CONF_DT, S4_CONF_RST_DTL_NM
     ,HOIKYE_YEAR, RPT_ID, INQR_NM, RPT_DTTM AS COND_BAS_DT,SGG_ACNO, DTL_HOIKYE_C
FROM
(
    SELECT PADM_STD_ORG_C AS ORG_C, ORG_NM, SL_GMGO_DEPT_C AS DEPT_C, DEPT_NM, BRNO
         , (SELECT SIGUMGO_BR_NM FROM RPT_SIGUMGO_BR_INFO WHERE SIGUMGO_C = '28'  AND SIGUMGO_BR_C = RAH.BRNO) AS BR_NM
         , CASE WHEN RPT_STEP_G = '1' AND S1_GYLJ_S_G = '3' THEN '1'    
                WHEN RPT_STEP_G = '1' AND S1_GYLJ_S_G = '5' THEN '2'    
                WHEN RPT_STEP_G = '2' AND S2_GYLJ_S_G = '3' THEN '3'    
                WHEN RPT_STEP_G = '2' AND S2_GYLJ_S_G = '4' THEN '4'    
                WHEN RPT_STEP_G = '2' AND S2_GYLJ_S_G = '5' THEN '5'    
                WHEN RPT_STEP_G = '3' AND S3_GYLJ_S_G = '3' THEN '6'    
                WHEN RPT_STEP_G = '3' AND S3_GYLJ_S_G = '4' THEN '7'    
                WHEN RPT_STEP_G = '4' AND S4_GYLJ_S_G = '4' THEN '7'    
                ELSE '0' END AS RPT_PRC
         , RPT_AC_G, SNO, RPT_TRN, RPT_DTTM, RPT_DT, RPT_CYCL_G, RPT_STEP_G, RQST_DTTM, RQST_CTNT, APP_IMG_KEY_VAL, IMG_KEY_VAL
         , LST_GYLJ_S_G
         , S1_GYLJ_S_G
         , S1_CONFJ_ID, S1_CONFJ_NM, S1_CONF_DT, S1_CONF_RST_DTL_NM
         , S2_GYLJ_S_G
         , S2_CONFJ_ID, S2_CONFJ_NM, S2_CONF_DT, S2_CONF_RST_DTL_NM
         , S3_GYLJ_S_G
         , S3_CONFJ_ID, S3_CONFJ_NM, S3_CONF_DT, S3_CONF_RST_DTL_NM
         , S4_GYLJ_S_G
         , S4_CONFJ_ID, S4_CONFJ_NM, S4_CONF_DT, S4_CONF_RST_DTL_NM
         ,(SELECT CMM_DTL_C_NM FROM SFI_CMM_C_DAT WHERE CMM_C_NM = 'RPT보고서기간구분' AND USE_YN = 'Y' AND CMM_DTL_C = RPT_G) AS RPT_G_NM
         ,(SELECT CMM_DTL_C_NM FROM SFI_CMM_C_DAT WHERE CMM_C_NM = '보고주기구분' AND USE_YN = 'Y' AND CMM_DTL_C = RPT_CYCL_G) AS RPT_CYCL_G_NM
         ,(SELECT CMM_DTL_C_NM FROM SFI_CMM_C_DAT WHERE CMM_C_NM = 'RPT보고서보고구분' AND USE_YN = 'Y' AND CMM_DTL_C = RPT_AC_G) AS RPT_AC_G_NM
         ,(SELECT CMM_DTL_C_NM FROM SFI_CMM_C_DAT WHERE CMM_C_NM = 'RPT최종결재상태코드' AND USE_YN = 'Y' AND CMM_DTL_C = LST_GYLJ_S_G) AS LST_GYLJ_S_NM
         ,(SELECT CMM_DTL_C_NM FROM SFI_CMM_C_DAT WHERE CMM_C_NM = 'RPT최종결재상태코드' AND USE_YN = 'Y' AND CMM_DTL_C = S1_GYLJ_S_G) AS S1_GYLJ_S_NM
         ,(SELECT CMM_DTL_C_NM FROM SFI_CMM_C_DAT WHERE CMM_C_NM = 'RPT최종결재상태코드' AND USE_YN = 'Y' AND CMM_DTL_C = S2_GYLJ_S_G) AS S2_GYLJ_S_NM
         ,(SELECT CMM_DTL_C_NM FROM SFI_CMM_C_DAT WHERE CMM_C_NM = 'RPT최종결재상태코드' AND USE_YN = 'Y' AND CMM_DTL_C = S3_GYLJ_S_G) AS S3_GYLJ_S_NM
         ,(SELECT CMM_DTL_C_NM FROM SFI_CMM_C_DAT WHERE CMM_C_NM = 'RPT최종결재상태코드' AND USE_YN = 'Y' AND CMM_DTL_C = S4_GYLJ_S_G) AS S4_GYLJ_S_NM
         ,HOIKYE_YEAR, RPT_ID, INQR_NM,SGG_ACNO  , DTL_HOIKYE_C
    FROM
    (
        SELECT 
          RAH.GEUMGO_CODE
      ,RAH.PADM_STD_ORG_C
      ,RAH.SL_GMGO_DEPT_C
      ,RAH.BRNO
      ,RAH.RPT_ID
      ,RAH.RPT_AC_G
      ,RAH.HOIKYE_YEAR
      ,RAH.RPT_DTTM
      ,RAH.SNO
      ,RAH.RPT_TRN
      ,RAH.DTL_HOIKYE_C
      ,RAH.SGG_ACNO
      ,RAH.RPT_DISTG_C
      ,RAH.ORG_NM
      ,RAH.DEPT_NM
      ,RAH.BR_NM
      ,RAH.RPT_NM
      ,RAH.RPT_CYCL_G
      ,RAH.BAS_DT
      ,RAH.ORNO
      ,RAH.INQR_NM
      ,RAH.RPT_STEP_G
      ,RAH.LST_GYLJ_S_G
      ,RAH.S1_GYLJ_S_G
      ,RAH.S1_CONFJ_ID
      ,RAH.S1_CONFJ_NM
      ,RAH.S1_CONF_DT
      ,RAH.S1_CONF_RST_DTL_NM
      ,RAH.RQST_DTTM
      ,RAH.RQST_CTNT
      ,RAH.S2_GYLJ_S_G
      ,RAH.S2_CONFJ_ID
      ,RAH.S2_CONFJ_NM
      ,RAH.S2_CONF_DT
      ,RAH.S2_CONF_RST_DTL_NM
      ,RAH.S3_GYLJ_S_G
      ,RAH.S3_CONFJ_ID
      ,RAH.S3_CONFJ_NM
      ,RAH.S3_CONF_DT
      ,RAH.S3_CONF_RST_DTL_NM
      ,RAH.S4_GYLJ_S_G
      ,RAH.S4_CONFJ_ID
      ,RAH.S4_CONFJ_NM
      ,RAH.S4_CONF_DT
      ,RAH.S4_CONF_RST_DTL_NM
      ,RAH.RPT_DT
      ,RAH.BAS_QTR_G
      ,RAH.BAYM
      ,RAH.SIGUTAX_G
      ,RAH.RPT_G
      ,RAH.ORG_G
      ,RAH.JOGN_ORG_C
      ,RAH.JOGN_DEPT_C
      ,RAH.CHNGS_C
      ,RAH.RFDT
      ,RAH.DR_S
      ,RAH.APP_IMG_KEY_VAL
      ,RAH.IMG_KEY_VAL 
          ,ROW_NUMBER() OVER (PARTITION BY RAH.PADM_STD_ORG_C, RAH.SL_GMGO_DEPT_C, RAH.BRNO, RAH.RPT_ID, RAH.RPT_AC_G, RAH.HOIKYE_YEAR, RAH.RPT_DTTM ORDER BY RAH.SNO DESC, RAH.RPT_TRN DESC) AS GREP
        FROM RPT_JEONJA_APRV_HIS RAH
        WHERE GEUMGO_CODE = '28' 
          AND RAH.PADM_STD_ORG_C = ''
          AND RAH.SL_GMGO_DEPT_C = ''
          AND RAH.BRNO = ''
          AND RAH.RPT_ID = 'ICH030303M01'
          AND RAH.RPT_AC_G = '1'
          AND RAH.HOIKYE_YEAR = '2023'
          AND ('all' = 'all' OR RAH.SIGUTAX_G = 'all') 
          AND (('all' = '75' AND '1' != '2') OR RAH.DTL_HOIKYE_C = '75') 
          AND (('all' = 'all'     AND '1' != '1') OR RAH.SGG_ACNO = 'all')
          AND ('all' = '20231025'        OR RAH.RPT_DTTM = '20231025')
          AND ('all' = 'all'          OR RAH.BAYM = 'all')
          AND ('all' = 'all'     OR RAH.BAS_QTR_G = 'all')
    AND RAH.SNO = '0'
          AND DR_S = 0
    )  RAH
    
)


--------------------------------------------------------------------------------------------


SELECT GUNGU_CODE, GUNGU_NM, NVL(DATA_ROW,1) AS DATA_ROW,
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
SELECT REF_D_C GUNGU_CODE, REF_D_NM GUNGU_NM, NVL(DATA_ROW,1) AS DATA_ROW,
         SUM(NVL(CASE DATA_ROW WHEN 1 THEN ILGYE_SEIB_SUIP WHEN 2 THEN ILGYE_SECHUL_BAEJEONG - ILGYE_SECHUL_HWANSU ELSE 0 END, 0)) AMT1 ,
         SUM(NVL(CASE DATA_ROW WHEN 1 THEN ILGYE_SEIB_BANNAB WHEN 2 THEN ILGYE_SECHUL_JI ELSE 0 END, 0)) AMT2 ,
         SUM(NVL(CASE DATA_ROW WHEN 1 THEN 0 WHEN 2 THEN ILGYE_SECHUL_BANNAB ELSE 0 END, 0)) AMT3 ,
         SUM(NVL(CASE DATA_ROW WHEN 1 THEN 0 WHEN 2 THEN ILGYE_SECHUL_GYULSANBF_IWOL - ILGYE_SEIB_GYULSANBF_IIB ELSE 0 END, 0)) AMT4,
         SUM(NVL(CASE DATA_ROW WHEN 1 THEN 0 WHEN 2 THEN ILGYE_DEP - ILGYE_YEKEUM_HEAJI ELSE 0 END, 0)) AMT5,
         SUM(NVL(CASE DATA_ROW WHEN 1 THEN 0 WHEN 2 THEN ILGYE_JEONYONG_JI - ILGYE_JEONYONG_IP ELSE 0 END, 0)) AMT6,
         SUM(NVL(0 , 0)) AMT7 , SUM(NVL(0 , 0)) AMT8 , SUM(NVL(0 , 0)) AMT9 ,
         SUM(NVL(0, 0)) AMT10, SUM(NVL(0, 0)) AMT11, SUM(NVL(0, 0)) AMT12,
         SUM(NVL(CASE DATA_ROW WHEN 1 THEN NUGYE_SEIB_SUIP WHEN 2 THEN NUGYE_SECHUL_BAEJEONG - NUGYE_SECHUL_HWANSU ELSE 0 END, 0)) AMT13 ,
         SUM(NVL(CASE DATA_ROW WHEN 1 THEN NUGYE_SEIB_BANNAB WHEN 2 THEN NUGYE_SECHUL_JI ELSE 0 END, 0)) AMT14 ,
         SUM(NVL(CASE DATA_ROW WHEN 1 THEN 0 WHEN 2 THEN NUGYE_SECHUL_BANNAB ELSE 0 END, 0)) AMT15 ,
         SUM(NVL(CASE DATA_ROW WHEN 1 THEN 0 WHEN 2 THEN NUGYE_SECHUL_GYULSANBF_IWOL - NUGYE_SEIB_GYULSANBF_IIB ELSE 0 END, 0)) AMT16,
         SUM(NVL(CASE DATA_ROW WHEN 1 THEN 0 WHEN 2 THEN NUGYE_DEP - NUGYE_YEKEUM_HEAJI ELSE 0 END, 0)) AMT17,
         SUM(NVL(CASE DATA_ROW WHEN 1 THEN 0 WHEN 2 THEN NUGYE_JEONYONG_JI - NUGYE_JEONYONG_IP ELSE 0 END, 0)) AMT18,
         SUM(NVL(0, 0)) AMT19, SUM(NVL(0, 0)) AMT20, SUM(NVL(0, 0)) AMT21,
         SUM(NVL(0, 0)) AMT22, SUM(NVL(0, 0)) AMT23, SUM(NVL(0, 0)) AMT24,
         SUM(NVL(CASE DATA_ROW WHEN 1 THEN WOLGYE_SEIB_SUIP + WOLGYE_SEIB_BANNAB WHEN 2 THEN 0 ELSE 0 END, 0)) AMT25,
         SUM(NVL(0, 0)) AMT26, SUM(NVL(0, 0)) AMT27, SUM(NVL(0, 0)) AMT28
      FROM  (
 SELECT
     M.REF_D_C, M.REF_D_NM, M.DATA_ROW,
     K.GONGGEUM_GYEJWA_NM AS NUGYE_HOIGYE_NAME,
     K.GONGGEUM_GYEJWA AS GONGGEUM_GYEJWA,
     (SUM(NVL(세입_수입입금,0)) + SUM(NVL(세입_배정입금,0))) AS NUGYE_SEIB_SUIP,
     SUM(NVL(세입_과오납반환,0)) AS NUGYE_SEIB_BANNAB,
     SUM(NVL(세입_과목경정입금,0)) AS NUGYE_SEIB_GYEONGJEONG_IB,
     SUM(NVL(세입_과목경정지급,0)) AS NUGYE_SEIB_GYEONGJEONG_JI,
     SUM(NVL(자금_배정,0)) AS NUGYE_SECHUL_BAEJEONG,
     SUM(NVL(자금_환수,0)) AS NUGYE_SECHUL_HWANSU,
     SUM(NVL(세출_지급,0)) AS NUGYE_SECHUL_JI,
     SUM(NVL(세출_반환,0)) AS NUGYE_SECHUL_BANNAB,
     SUM(NVL(세출_과목경정입금,0)) AS NUGYE_SECHUL_GYEONGJEONG_IB,
     SUM(NVL(세출_과목경정지급,0)) AS NUGYE_SECHUL_GYEONGJEONG_JI,
     SUM(NVL(결산전이입,0)) AS NUGYE_SEIB_GYULSANBF_IIB,
     SUM(NVL(결산전이월,0)) AS NUGYE_SECHUL_GYULSANBF_IWOL,
     SUM(NVL(예금신규,0)) AS NUGYE_DEP,
     SUM(NVL(예금해지,0)) AS NUGYE_YEKEUM_HEAJI,
     SUM(NVL(전용자금_지급,0)) AS NUGYE_JEONYONG_JI,
     SUM(NVL(전용자금_환입,0)) AS NUGYE_JEONYONG_IP,
     (SUM(NVL(세입_수입입금2,0)) + SUM(NVL(세입_배정입금2,0))) AS ILGYE_SEIB_SUIP,
     SUM(NVL(세입_과오납반환2,0)) AS ILGYE_SEIB_BANNAB,
     SUM(NVL(세입_과목경정입금2,0)) AS ILGYE_SEIB_GYEONGJEONG_IB,
     SUM(NVL(세입_과목경정지급2,0)) AS ILGYE_SEIB_GYEONGJEONG_JI,
     SUM(NVL(자금_배정2,0)) AS ILGYE_SECHUL_BAEJEONG,
     SUM(NVL(자금_환수2,0)) AS ILGYE_SECHUL_HWANSU,
     SUM(NVL(세출_지급2,0)) AS ILGYE_SECHUL_JI,
     SUM(NVL(세출_반환2,0)) AS ILGYE_SECHUL_BANNAB,
     SUM(NVL(세출_과목경정입금2,0)) AS ILGYE_SECHUL_GYEONGJEONG_IB,
     SUM(NVL(세출_과목경정지급2,0)) AS ILGYE_SECHUL_GYEONGJEONG_JI,
     SUM(NVL(결산전이입2,0)) AS ILGYE_SEIB_GYULSANBF_IIB,
     SUM(NVL(결산전이월2,0)) AS ILGYE_SECHUL_GYULSANBF_IWOL,
     SUM(NVL(예금신규2,0)) AS ILGYE_DEP,
     SUM(NVL(예금해지2,0)) ILGYE_YEKEUM_HEAJI,
     SUM(NVL(전용자금_지급2,0)) AS ILGYE_JEONYONG_JI,
     SUM(NVL(전용자금_환입2,0)) ILGYE_JEONYONG_IP,
     (SUM(NVL(세입_수입입금3,0)) + SUM(NVL(세입_배정입금3,0))) AS WOLGYE_SEIB_SUIP,
     (SUM(NVL(세입_과오납반환3,0))) AS WOLGYE_SEIB_BANNAB
 FROM
 (
     SELECT
       GONGGEUM_GUNGU_CODE AS GUNGU_CODE,
       GONGGEUM_GYEJWA,
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 11
                 THEN  IPGEUM_AMT * JO ELSE 0 END 세입_수입입금,       -- 세입_수입입금
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN IN (15,16)
                 THEN  IPGEUM_AMT * JO ELSE 0 END 세입_배정입금,        -- 세입_배정입금
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 64
                 THEN  JIGEUB_AMT * JO ELSE 0 END 세입_과오납반환,      -- 세입_과오납반환
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 19
                 THEN  IPGEUM_AMT * JO ELSE 0 END 세입_과목경정입금,    -- 세입_과목경정입금
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 69
                 THEN  JIGEUB_AMT * JO ELSE 0 END 세입_과목경정지급,    -- 세입_과목경정지급
       CASE WHEN R_HOIGYE_YEAR = '2023' AND ((GEORAE_GUBUN = 61 AND JIGEUB_GEORAE = 1) OR (GEORAE_GUBUN = 68 AND JIGEUB_GEORAE = 0))
                 THEN  JIGEUB_AMT * JO ELSE 0 END 자금_배정,            -- 자금_배정
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 14 AND IPGEUM_GEORAE = 6
                 THEN  IPGEUM_AMT * JO ELSE 0 END 자금_환수,            -- 자금_환수
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 67
                 THEN  JIGEUB_AMT * JO ELSE 0 END 세출_지급,            -- 세출_지급
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 17
                 THEN  IPGEUM_AMT * JO ELSE 0 END 세출_반환,            -- 세출_반환
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 18
                 THEN  IPGEUM_AMT * JO ELSE 0 END 세출_과목경정입금,    -- 세출_과목경정입금
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 65
                 THEN  JIGEUB_AMT * JO ELSE 0 END 세출_과목경정지급,    -- 세출_과목경정지급
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 4
                 THEN  IPGEUM_AMT * JO ELSE 0 END 결산전이입,           -- 결산전이입
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 4
                 THEN  JIGEUB_AMT * JO ELSE 0 END 결산전이월,           -- 결산전이월
      CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 3
                THEN  JIGEUB_AMT * JO ELSE 0 END 예금신규,             -- 예금신규
      CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 3
                THEN  IPGEUM_AMT * JO ELSE 0 END 예금해지,             -- 예금해지
      CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 5
                THEN  JIGEUB_AMT * JO ELSE 0 END 전용자금_지급,             -- 전용자금_지급
      CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 5
                THEN  IPGEUM_AMT * JO ELSE 0 END 전용자금_환입,             -- 전용자금_환입
       0 AS 세입_수입입금2,        -- 세입_수입입금
       0 AS 세입_배정입금2,        -- 세입_배정입금
       0 AS 세입_과오납반환2,      -- 세입_과오납반환
       0 AS 세입_과목경정입금2,    -- 세입_과목경정입금
       0 AS 세입_과목경정지급2,    -- 세입_과목경정지급
       0 AS 자금_배정2,            -- 자금_배정
       0 AS 자금_환수2,            -- 자금_환수
       0 AS 세출_지급2,            -- 세출_지급
       0 AS 세출_반환2,            -- 세출_반환
       0 AS 세출_과목경정입금2,    -- 세출_과목경정입금
       0 AS 세출_과목경정지급2,    -- 세출_과목경정지급
       0 AS 결산전이입2,           -- 결산전이입
       0 AS 결산전이월2,           -- 결산전이월
       0 AS 예금신규2,                -- 예금신규
       0 AS 예금해지2,                                                 -- 예금해지
       0 AS 전용자금_지급2,                -- 전용자금_지급
       0 AS 전용자금_환입2,                                                 -- 전용자금_환입
       CASE WHEN ILJA BETWEEN  '20231001' AND '20231025' AND R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 11
                 THEN  IPGEUM_AMT * JO ELSE 0 END 세입_수입입금3,       -- 세입_수입입금
       CASE WHEN ILJA BETWEEN  '20231001' AND '20231025' AND R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN IN (15,16)
                 THEN  IPGEUM_AMT * JO ELSE 0 END 세입_배정입금3,        -- 세입_배정입금
       CASE WHEN ILJA BETWEEN  '20231001' AND '20231025' AND R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 64
                 THEN  JIGEUB_AMT * JO ELSE 0 END 세입_과오납반환3       -- 세입_과오납반환
     FROM (
       SELECT
         B.GONGGEUM_GUNGU_CODE, B.GONGGEUM_GYEJWA, A.GEORAE_GUBUN, A.IPGEUM_AMT, A.JIGEUB_AMT,
         A.JIGEUB_GEORAE, A.IPGEUM_GEORAE,
         A.KIJUNIL ILJA, A.JUKYO,
         CASE WHEN A.JEONGJEONG <> 1     THEN 1         ELSE -1        END JO,
         CASE WHEN A.HOIGYE_YEAR = 9999 THEN TO_NUMBER(SUBSTR(A.KIJUNIL,1,4))
                   ELSE TO_NUMBER(A.HOIGYE_YEAR) END R_HOIGYE_YEAR              -- 귀속회계년도
       FROM
         RPT_GONGGEUM_KEORAE A, RPT_GYEJWA_INFO B
       WHERE
         A.KIJUNIL BETWEEN  '20230101' AND '20231025'
         AND A.GEUMGO_CODE = '28'
         AND A.GONGGEUM_GYEJWA = B.GONGGEUM_GYEJWA
         AND A.GUNGU_CODE = '0'
      AND B.GONGGEUM_GYEJWA = '02800075690000699'
       )
         UNION ALL
         -------------------------- RPT_GONGGEUM_KEORAE START  일계 --------------------
     SELECT
       GONGGEUM_GUNGU_CODE AS GUNGU_CODE,
       GONGGEUM_GYEJWA,
       0 AS 세입_수입입금,        -- 세입_수입입금
       0 AS 세입_배정입금,        -- 세입_배정입금
       0 AS 세입_과오납반환,      -- 세입_과오납반환
       0 AS 세입_과목경정입금,    -- 세입_과목경정입금
       0 AS 세입_과목경정지급,    -- 세입_과목경정지급
       0 AS 자금_배정,            -- 자금_배정
       0 AS 자금_환수,            -- 자금_환수
       0 AS 세출_지급,            -- 세출_지급
       0 AS 세출_반환,            -- 세출_반환
       0 AS 세출_과목경정입금,    -- 세출_과목경정입금
       0 AS 세출_과목경정지급,    -- 세출_과목경정지급
       0 AS 결산전이입,           -- 결산전이입
       0 AS 결산전이월,           -- 결산전이월
       0 AS 예금신규,              -- 예금신규
       0 AS 예금해지,              -- 예금해지
       0 AS 전용자금_지급,              -- 전용자금_지급
       0 AS 전용자금_환입,              -- 전용자금_환입
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 11
                 THEN  IPGEUM_AMT * JO ELSE 0 END 세입_수입입금2,       -- 세입_수입입금
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN IN (15,16)
                 THEN  IPGEUM_AMT * JO ELSE 0 END 세입_배정입금2,        -- 세입_배정입금
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 64
                 THEN  JIGEUB_AMT * JO ELSE 0 END 세입_과오납반환2,      -- 세입_과오납반환
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 19
                 THEN  IPGEUM_AMT * JO ELSE 0 END 세입_과목경정입금2,    -- 세입_과목경정입금
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 69
                 THEN  JIGEUB_AMT * JO ELSE 0 END 세입_과목경정지급2,    -- 세입_과목경정지급
       CASE WHEN R_HOIGYE_YEAR = '2023' AND ((GEORAE_GUBUN = 61 AND JIGEUB_GEORAE = 1) OR (GEORAE_GUBUN = 68 AND JIGEUB_GEORAE = 0))
                 THEN  JIGEUB_AMT * JO ELSE 0 END 자금_배정2,            -- 자금_배정
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 14 AND IPGEUM_GEORAE = 6
                 THEN  IPGEUM_AMT * JO ELSE 0 END 자금_환수2,            -- 자금_환수
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 67
                 THEN  JIGEUB_AMT * JO ELSE 0 END 세출_지급2,            -- 세출_지급
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 17
                 THEN  IPGEUM_AMT * JO ELSE 0 END 세출_반환2,            -- 세출_반환
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 18
                 THEN  IPGEUM_AMT * JO ELSE 0 END 세출_과목경정입금2,    -- 세출_과목경정입금
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 65
                 THEN  JIGEUB_AMT * JO ELSE 0 END 세출_과목경정지급2,    -- 세출_과목경정지급
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 4
                 THEN  IPGEUM_AMT * JO ELSE 0 END 결산전이입2,           -- 결산전이입
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 4
                 THEN  JIGEUB_AMT * JO ELSE 0 END 결산전이월2,           -- 결산전이월
      CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 3
                THEN  JIGEUB_AMT * JO ELSE 0 END 예금신규2,             -- 예금신규
      CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 3
                THEN  IPGEUM_AMT * JO ELSE 0 END 예금해지2,             -- 예금해지
      CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 5
                THEN  JIGEUB_AMT * JO ELSE 0 END 전용자금_지급2,             -- 전용자금_지급
      CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 5
                THEN  IPGEUM_AMT * JO ELSE 0 END 전용자금_환입2,             -- 전용자금_환입
      0 세입_수입입금3,                                                 -- 세입_수입입금
      0 세입_배정입금3,                                                      -- 세입_배정입금
      0 세입_과오납반환3                                                      -- 세입_과오납반환
     FROM (
       SELECT
         B.GONGGEUM_GUNGU_CODE, B.GONGGEUM_GYEJWA, A.GEORAE_GUBUN, A.IPGEUM_AMT, A.JIGEUB_AMT,
         A.JIGEUB_GEORAE, A.IPGEUM_GEORAE,
         A.KIJUNIL ILJA, A.JUKYO,
         CASE WHEN A.JEONGJEONG <> 1     THEN 1         ELSE -1        END JO,
         CASE WHEN A.HOIGYE_YEAR = 9999 THEN TO_NUMBER(SUBSTR(A.KIJUNIL,1,4))
                   ELSE TO_NUMBER(A.HOIGYE_YEAR) END R_HOIGYE_YEAR              -- 귀속회계년도
       FROM
         RPT_GONGGEUM_KEORAE A, RPT_GYEJWA_INFO B
       WHERE
         A.KIJUNIL BETWEEN  '20231025' AND '20231025'
         AND A.GEUMGO_CODE = '28'
         AND A.GONGGEUM_GYEJWA = B.GONGGEUM_GYEJWA
         AND A.GUNGU_CODE = '0'
      AND B.GONGGEUM_GYEJWA = '02800075690000699'
       )
         UNION ALL
         -------------------------- RPT_GONGGEUM_KEORAE START 9999 누계 --------------------
     SELECT
       9999 AS GUNGU_CODE,
       GONGGEUM_GYEJWA,
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 11
                 THEN  IPGEUM_AMT * JO ELSE 0 END 세입_수입입금,       -- 세입_수입입금
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN IN (15,16)
                 THEN  IPGEUM_AMT * JO ELSE 0 END 세입_배정입금,        -- 세입_배정입금
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 64
                 THEN  JIGEUB_AMT * JO ELSE 0 END 세입_과오납반환,      -- 세입_과오납반환
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 19
                 THEN  IPGEUM_AMT * JO ELSE 0 END 세입_과목경정입금,    -- 세입_과목경정입금
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 69
                 THEN  JIGEUB_AMT * JO ELSE 0 END 세입_과목경정지급,    -- 세입_과목경정지급
       CASE WHEN R_HOIGYE_YEAR = '2023' AND ((GEORAE_GUBUN = 61 AND JIGEUB_GEORAE = 1) OR (GEORAE_GUBUN = 68 AND JIGEUB_GEORAE = 0))
                 THEN  JIGEUB_AMT * JO ELSE 0 END 자금_배정,            -- 자금_배정
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 14 AND IPGEUM_GEORAE = 6
                 THEN  IPGEUM_AMT * JO ELSE 0 END 자금_환수,            -- 자금_환수
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 67
                 THEN  JIGEUB_AMT * JO ELSE 0 END 세출_지급,            -- 세출_지급
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 17
                 THEN  IPGEUM_AMT * JO ELSE 0 END 세출_반환,            -- 세출_반환
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 18
                 THEN  IPGEUM_AMT * JO ELSE 0 END 세출_과목경정입금,    -- 세출_과목경정입금
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 65
                 THEN  JIGEUB_AMT * JO ELSE 0 END 세출_과목경정지급,    -- 세출_과목경정지급
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 4
                 THEN  IPGEUM_AMT * JO ELSE 0 END 결산전이입,           -- 결산전이입
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 4
                 THEN  JIGEUB_AMT * JO ELSE 0 END 결산전이월,           -- 결산전이월
      CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 3
                THEN  JIGEUB_AMT * JO ELSE 0 END 예금신규,             -- 예금신규
      CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 3
                THEN  IPGEUM_AMT * JO ELSE 0 END 예금해지,             -- 예금해지
      CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 5
                THEN  JIGEUB_AMT * JO ELSE 0 END 전용자금_지급,             -- 전용자금_지급
      CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 5
                THEN  IPGEUM_AMT * JO ELSE 0 END 전용자금_환입,             -- 전용자금_환입
       0 AS 세입_수입입금2,        -- 세입_수입입금
       0 AS 세입_배정입금2,        -- 세입_배정입금
       0 AS 세입_과오납반환2,      -- 세입_과오납반환
       0 AS 세입_과목경정입금2,    -- 세입_과목경정입금
       0 AS 세입_과목경정지급2,    -- 세입_과목경정지급
       0 AS 자금_배정2,            -- 자금_배정
       0 AS 자금_환수2,            -- 자금_환수
       0 AS 세출_지급2,            -- 세출_지급
       0 AS 세출_반환2,            -- 세출_반환
       0 AS 세출_과목경정입금2,    -- 세출_과목경정입금
       0 AS 세출_과목경정지급2,    -- 세출_과목경정지급
       0 AS 결산전이입2,           -- 결산전이입
       0 AS 결산전이월2,           -- 결산전이월
       0 AS 예금신규2,                -- 예금신규
       0 AS 예금해지2,                                                 -- 예금해지
       0 AS 전용자금_지급2,                -- 전용자금_지급
       0 AS 전용자금_환입2,                                                 -- 전용자금_환입
       CASE WHEN ILJA BETWEEN  '20231001' AND '20231025' AND R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 11
                 THEN  IPGEUM_AMT * JO ELSE 0 END 세입_수입입금3,       -- 세입_수입입금
       CASE WHEN ILJA BETWEEN  '20231001' AND '20231025' AND R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN IN (15,16)
                 THEN  IPGEUM_AMT * JO ELSE 0 END 세입_배정입금3,        -- 세입_배정입금
       CASE WHEN ILJA BETWEEN  '20231001' AND '20231025' AND R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 64
                 THEN  JIGEUB_AMT * JO ELSE 0 END 세입_과오납반환3       -- 세입_과오？낱忿？     FROM (
       SELECT
         B.GONGGEUM_GUNGU_CODE, B.GONGGEUM_GYEJWA, A.GEORAE_GUBUN, A.IPGEUM_AMT, A.JIGEUB_AMT,
         A.JIGEUB_GEORAE, A.IPGEUM_GEORAE,
         A.KIJUNIL ILJA, A.JUKYO,
         CASE WHEN A.JEONGJEONG <> 1     THEN 1         ELSE -1        END JO,
         CASE WHEN A.HOIGYE_YEAR = 9999 THEN TO_NUMBER(SUBSTR(A.KIJUNIL,1,4))
                   ELSE TO_NUMBER(A.HOIGYE_YEAR) END R_HOIGYE_YEAR              -- 귀속회계년도
       FROM
         RPT_GONGGEUM_KEORAE A, RPT_GYEJWA_INFO B
       WHERE
         A.KIJUNIL BETWEEN  '20230101' AND '20231025'
         AND A.GEUMGO_CODE = '28'
         AND A.GONGGEUM_GYEJWA = B.GONGGEUM_GYEJWA
         AND A.GUNGU_CODE = '0'
      AND B.GONGGEUM_GYEJWA = '02800075690000699'
       )
         UNION ALL
         -------------------------- RPT_GONGGEUM_KEORAE START 9999 일계 --------------------
     SELECT
       9999 AS GUNGU_CODE,
       GONGGEUM_GYEJWA,
       0 AS 세입_수입입금,        -- 세입_？痔纛逃？       0 AS 세입_배정입금,        -- 세입_배정입금
       0 AS 세입_과오납반환,      -- 세입_과오납반환
       0 AS 세입_과목경정입금,    -- 세입_과목경정입금
       0 AS 세입_과목경정지급,    -- 세입_과목경정지급
       0 AS 자금_배정,            -- 자금_배정
       0 AS 자금_환수,            -- 자금_환수
       0 AS 세출_지급,            -- 세출_지급
       0 AS 세출_반환,            -- 세출_반환
       0 AS 세출_과목경정입금,    -- 세출_과목경정입금
       0 AS 세출_과목경정지급,    -- 세출_과목경정지급
       0 AS 결산전이입,           -- 결산전이입
       0 AS 결산전이월,           -- 결산전이월
       0 AS 예금신규,              -- 예금신규
       0 AS 예금해지,              -- 예금해지
       0 AS 전용자금_지급,              -- 전용자금_지급
       0 AS 전용자금_환입,              -- 전용자금_환입
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 11
                 THEN  IPGEUM_AMT * JO ELSE 0 END 세입_수입입금2,       -- 세입_수입입금
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN IN (15,16)
                 THEN  IPGEUM_AMT * JO ELSE 0 END 세입_배정입금2,        -- 세입_배정입금
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 64
                 THEN  JIGEUB_AMT * JO ELSE 0 END 세입_과오납반환2,      -- 세입_과오납반환
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 19
                 THEN  IPGEUM_AMT * JO ELSE 0 END 세입_과목경정입금2,    -- 세입_과목경정입금
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 69
                 THEN  JIGEUB_AMT * JO ELSE 0 END 세입_과목경정지급2,    -- 세입_과목경정지급
       CASE WHEN R_HOIGYE_YEAR = '2023' AND ((GEORAE_GUBUN = 61 AND JIGEUB_GEORAE = 1) OR (GEORAE_GUBUN = 68 AND JIGEUB_GEORAE = 0))
                 THEN  JIGEUB_AMT * JO ELSE 0 END 자금_배정2,            -- 자금_배정
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 14 AND IPGEUM_GEORAE = 6
                 THEN  IPGEUM_AMT * JO ELSE 0 END 자금_환？？,            -- 자금_환수
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 67
                 THEN  JIGEUB_AMT * JO ELSE 0 END 세출_지급2,            -- 세출_지급
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 17
                 THEN  IPGEUM_AMT * JO ELSE 0 END 세출_반환2,            -- 세출_반환
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 18
                 THEN  IPGEUM_AMT * JO ELSE 0 END 세출_과목경정입금2,    -- 세출_과목경정입금
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 65
                 THEN  JIGEUB_AMT * JO ELSE 0 END 세출_과목경정지급2,    -- 세출_과목경정지급
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 4
                 THEN  IPGEUM_AMT * JO ELSE 0 END 결산전이입2,           -- 결산전이입
       CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 4
                 THEN  JIGEUB_AMT * JO ELSE 0 END 결산전이월2,           -- 결산전이월
      CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 3
                THEN  JIGEUB_AMT * JO ELSE 0 END 예금신규2,             -- 예금신규
      CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 3
                THEN  IPGEUM_AMT * JO ELSE 0 END 예금해지2,             -- 예금해지
      CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 5
                THEN  JIGEUB_AMT * JO ELSE 0 END 전용자금_지급2,             -- 전용자금_지급
      CASE WHEN R_HOIGYE_YEAR = '2023' AND GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 5
                THEN  IPGEUM_AMT * JO ELSE 0 END 전용자금_환입2,             -- 전용자금_환입
      0 세입_수입입금3,                                                 -- 세입_수입입금
      0 세입_배정입금3,                                                      -- 세입_배정입금
      0 세입_과오납반환3                                                      -- 세입_과오납반환
     FROM (
       SELECT
         B.GONGGEUM_GUNGU_CODE, B.GONGGEUM_GYEJWA, A.GEORAE_GUBUN, A.IPGEUM_AMT, A.JIGEUB_AMT,
         A.JIGEUB_GEORAE, A.IPGEUM_GEORAE,
         A.KIJUNIL ILJA, A.JUKYO,
         CASE WHEN A.JEONGJEONG <> 1     THEN 1         ELSE -1        END JO,
         CASE WHEN A.HOIGYE_YEAR = 9999 THEN TO_NUMBER(SUBSTR(A.KIJUNIL,1,4))
                   ELSE TO_NUMBER(A.HOIGYE_YEAR) END R_HOIGYE_YEAR              -- 귀속회계년도
       FROM
         RPT_GONGGEUM_KEORAE A, RPT_GYEJWA_INFO B
       WHERE
         A.KIJUNIL BETWEEN  '20231025' AND '20231025'
         AND A.GEUMGO_CODE = '28'
         AND A.GONGGEUM_GYEJWA = B.GONGGEUM_GYEJWA
         AND A.GUNGU_CODE = '0'
      AND B.GONGGEUM_GYEJWA = '02800075690000699'
       )
         UNION ALL
         -------------------------- RPT_GONGGEUM_KEORAE START  전년도 기금 잔액 --------------------
     SELECT
       GUNGU_CODE,
       GONGGEUM_GYEJWA,
       JANAEK AS 세입_수입입금,        -- 세입_수입입금
       0 AS 세입_배정입금,        -- 세입_배정입금
       0 AS 세입_과오납반환,      -- 세입_과오납반환
       0 AS 세입_과목경정입금,    -- 세입_과목경정입금
       0 AS 세입_과목경정지급,    -- 세입_과목경정지급
       0 AS 자금_배정,            -- 자금_배정
       0 AS 자금_환수,            -- 자금_환수
       0 AS 세출_지급,            -- 세출_지급
       0 AS 세출_반환,            -- 세출_반환
       0 AS 세출_과목경정입금,    -- 세출_과목경정입금
       0 AS 세출_과목경정지급,    -- 세？？과목경정지급
       0 AS 결산전이입,           -- 결산전이입
       0 AS 결산전이월,           -- 결산전이월
       0 AS 예금신규,              -- 예금신규
       0 AS 예금해지,              -- 예금해지
       0 AS 전용자금_지급,              -- 전용자금_지급
       0 AS 전용자금_환입,              -- 전용자금_환입
       0 AS 세입_수입입금2,        -- 세입_수입입금
       0 AS 세입_배정입금2,        -- 세입_배정입금
       0 AS 세입_과오납반환2,      -- 세입_과오납반환
       0 AS ？셈？과목경정입금2,    -- 세입_과목경정입금
       0 AS 세입_과목경정지급2,    -- 세입_과목경정지급
       0 AS 자금_배정2,            -- 자금_배정
       0 AS 자금_환수2,            -- 자금_환수
       0 AS 세출_지급2,            -- 세출_지급
       0 AS 세출_반환2,            -- 세출_반환
       0 AS 세출_과목경정입금2,    -- 세출_과목경정입금
       0 AS 세출_과목경정지급2,    -- 세출_과목경정지급
       0 AS 결산전이입2,           -- 결산전이입
       0 AS 결산전이월2,           -- 결산전이월
       0 AS 예금신규2,                -- 예금신규
       0 AS 예금해지2,                                                 -- 예금해지
       0 AS 전용자금_지급2,                -- 전용자금_지급
       0 AS 전용자금_환입2,                                                 -- 전용자금_환입
      0 세입_수입입금3,                                                 -- 세입_수입입금
      0 세입_배정입금3,                                                      -- 세입_배정입금
      0 세입_과오납반환3                                                      -- 세입_과오납반환
     FROM (
       SELECT
        GUNGU_CODE,
        GONGGEUM_GYEJWA,
        JANAEK
       FROM
        RPT_GONGGEUM_JAN
       WHERE
           GEUMGO_CODE = '28'
       AND GUNGU_CODE = '0'
       AND HOIGYE_CODE = 75
       AND HOIGYE_YEAR = '9999'
       AND KEORAEIL IN (SELECT BIZ_DT FROM MAP_JOB_DATE WHERE DW_BAS_DDT = TO_CHAR(TO_NUMBER('2023') -1)||'1231')
      AND GONGGEUM_GYEJWA = '02800075690000699'
       )
 ) T,
 (
       SELECT GONGGEUM_GYEJWA_NM, GONGGEUM_GYEJWA
       FROM RPT_GYEJWA_INFO
       WHERE GONGGEUM_GEUMGO_CD = '28'
             AND (GONGGEUM_HOIGYE_YEAR = '2023' OR GONGGEUM_HOIGYE_YEAR  = 9999)
             AND GONGGEUM_GYEJWA = '02800075690000699'
 ) K,
 (SELECT '0' REF_D_C, (SELECT REF_D_NM FROM RPT_CODE_INFO WHERE REF_L_C = 500 AND REF_M_C = '28' AND REF_S_C = 1 AND REF_D_C = '0') REF_D_NM, 1 DATA_ROW FROM DUAL
   UNION ALL
   SELECT '9999' REF_D_C, '합계' REF_D_NM, 2 DATA_ROW FROM DUAL
 ) M
 WHERE T.GONGGEUM_GYEJWA = K.GONGGEUM_GYEJWA
 AND T.GUNGU_CODE(+) = M.REF_D_C
   AND K.GONGGEUM_GYEJWA = '02800075690000699'
 GROUP BY M.REF_D_C, REF_D_NM, M.DATA_ROW, K.GONGGEUM_GYEJWA_NM, K.GONGGEUM_GYEJWA
 ORDER BY M.REF_D_C, REF_D_NM, M.DATA_ROW, K.GONGGEUM_GYEJWA
 ) A
 GROUP BY A.REF_D_C, A.REF_D_NM, A.DATA_ROW
     UNION ALL
    SELECT REF_D_C GUNGU_CODE, REF_D_NM GUNGU_NM, NVL(AA.DATA_ROW,1) AS DATA_ROW,
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
 SELECT  GUNGU_CODE, 1 DATA_ROW,
         0 AMT1,
         SUM(CASE WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN  = 1 AND SUNAPIL = '20231025'
                         THEN NVL(JIBANGSE_AMT,0) * -1
                  WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN  = 2 AND SUNAPIL = '20231025'
                         THEN NVL(JIBANGSE_AMT,0)
                  ELSE 0 END) AMT2,
         SUM(CASE WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 1 AND SUNAPIL = '20231025'
                         THEN NVL(JIBANGSE_AMT,0)
                  WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 2 AND SUNAPIL = '20231025'
                         THEN NVL(JIBANGSE_AMT,0) * -1
                  ELSE 0 END) AMT3,
         0 AMT4,
         SUM(CASE WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN  = 1 AND SUNAPIL = '20231025'
                         THEN NVL(SEWOI_AMT,0) * -1
                  WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN  = 2 AND SUNAPIL = '20231025'
                         THEN NVL(SEWOI_AMT,0)
                  ELSE 0 END) AMT5,
         SUM(CASE WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 1 AND SUNAPIL = '20231025'
                         THEN NVL(SEWOI_AMT,0)
                  WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 2 AND SUNAPIL = '20231025'
                         THEN NVL(SEWOI_AMT,0) * -1
                  ELSE 0 END) AMT6,
         0 AMT7,
         SUM(CASE WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN  = 1 AND SUNAPIL = '20231025'
                         THEN NVL(GYOYUKSE_AMT,0) * -1
                  WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN  = 2 AND SUNAPIL = '20231025'
                         THEN NVL(GYOYUKSE_AMT,0)
                  ELSE 0 END) AMT8,
         SUM(CASE WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 1 AND SUNAPIL = '20231025'
                         THEN NVL(GYOYUKSE_AMT,0)
                  WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 2 AND SUNAPIL = '20231025'
                         THEN NVL(GYOYUKSE_AMT,0) * -1
                  ELSE 0 END) AMT9,
         0 AMT10,
         SUM(CASE WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN  = 1 AND SUNAPIL = '20231025'
                         THEN NVL(NONGTEUKSE_AMT,0) * -1
                  WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN  = 2 AND SUNAPIL = '20231025'
                         THEN NVL(NONGTEUKSE_AMT,0)
                  ELSE 0 END) AMT11,
         SUM(CASE WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 1 AND SUNAPIL = '20231025'
                         THEN NVL(NONGTEUKSE_AMT,0)
                  WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 2 AND SUNAPIL = '20231025'
                         THEN NVL(NONGTEUKSE_AMT,0) * -1
                  ELSE 0 END) AMT12,
         0 AMT13,
         SUM(CASE WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN = 1 THEN NVL(JIBANGSE_AMT,0) * -1
                  WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN = 2 THEN NVL(JIBANGSE_AMT,0)
                  ELSE 0 END) AMT14,
         SUM(CASE WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 1 THEN NVL(JIBANGSE_AMT,0)
                  WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 2 THEN NVL(JIBANGSE_AMT,0) * -1
                  ELSE 0 END) AMT15,
         0 AMT16,
         SUM(CASE WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN = 1 THEN NVL(SEWOI_AMT,0) * -1
                  WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN = 2 THEN NVL(SEWOI_AMT,0)
                  ELSE 0 END) AMT17,
         SUM(CASE WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 1 THEN NVL(SEWOI_AMT,0)
                  WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 2 THEN NVL(SEWOI_AMT,0) * -1
                  ELSE 0 END) AMT18,
         0 AMT19,
         SUM(CASE WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN = 1 THEN NVL(GYOYUKSE_AMT,0) * -1
                  WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN = 2 THEN NVL(GYOYUKSE_AMT,0)
                  ELSE 0 END) AMT20,
         SUM(CASE WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 1 THEN NVL(GYOYUKSE_AMT,0)
                  WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 2 THEN NVL(GYOYUKSE_AMT,0) * -1
                  ELSE 0 END) AMT21,
         0 AMT22,
         SUM(CASE WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN = 1 THEN NVL(NONGTEUKSE_AMT,0) * -1
                  WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN = 2 THEN NVL(NONGTEUKSE_AMT,0)
                  ELSE 0 END) AMT23,
         SUM(CASE WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 1 THEN NVL(NONGTEUKSE_AMT,0)
                  WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 2 THEN NVL(NONGTEUKSE_AMT,0) * -1
                  ELSE 0 END) AMT24,
         SUM(CASE WHEN (SUNAPIL BETWEEN '202310'||'01' AND '20231025') AND IPJI_GUBUN = 1 THEN NVL(JIBANGSE_AMT,0)
                  WHEN (SUNAPIL BETWEEN '202310'||'01' AND '20231025') AND IPJI_GUBUN <> 1 THEN NVL(JIBANGSE_AMT,0) * -1
                  ELSE 0 END) AMT25,
         SUM(CASE WHEN (SUNAPIL BETWEEN '202310'||'01' AND '20231025') AND IPJI_GUBUN =  1 THEN NVL(SEWOI_AMT,0)
                  WHEN (SUNAPIL BETWEEN '202310'||'01' AND '20231025') AND IPJI_GUBUN <> 1 THEN NVL(SEWOI_AMT,0) * -1
                  ELSE 0 END) AMT26,
         SUM(CASE WHEN (SUNAPIL BETWEEN '202310'||'01' AND '20231025') AND IPJI_GUBUN =  1 THEN NVL(GYOYUKSE_AMT,0)
                  WHEN (SUNAPIL BETWEEN '202310'||'01' AND '20231025') AND IPJI_GUBUN <> 1 THEN NVL(GYOYUKSE_AMT,0) * -1
                  ELSE 0 END) AMT27,
         SUM(CASE WHEN (SUNAPIL BETWEEN '202310'||'00' AND '20231025')
                         AND IPJI_GUBUN =  1 THEN NVL(NONGTEUKSE_AMT,0)
                  WHEN (SUNAPIL BETWEEN '202310'||'00' AND '20231025')
                         AND IPJI_GUBUN <> 1 THEN NVL(NONGTEUKSE_AMT,0) * -1
                  ELSE 0 END) AMT28
   FROM  RPT_DANGSEIPJOJEONG A
 WHERE
   A.GEUMGO_CODE = '28' AND A.SUNAPIL BETWEEN '2023'||'0101' AND '20231025'
  AND A.GUNGU_CODE = '0'
  AND A.JIBGYE_CODE = (SELECT REF_D_C FROM RPT_CODE_INFO WHERE REF_L_C = 879 AND REF_M_C = 28 AND REF_CTNT1 = '02800075690000699')
  AND (A.YEAR_GUBUN = 1 OR HOIGYE_YEAR = 9999 )
 GROUP BY A.GUNGU_CODE
 ) AA,
 (SELECT '0' REF_D_C, (SELECT REF_D_NM FROM RPT_CODE_INFO WHERE REF_L_C = 500 AND REF_M_C = '28' AND REF_S_C = 1 AND REF_D_C = '0') REF_D_NM, 1 DATA_ROW FROM DUAL
   UNION ALL
   SELECT '9999' REF_D_C, '합계' REF_D_NM, 2 DATA_ROW FROM DUAL
 ) M
 WHERE
   AA.GUNGU_CODE(+)= M.REF_D_C
 GROUP BY  REF_D_C, REF_D_NM, AA.DATA_ROW
 ) A
 GROUP BY GUNGU_CODE, GUNGU_NM, DATA_ROW
 ORDER BY GUNGU_CODE, GUNGU_NM, DATA_ROW


 ---------------------------------------------------------------------------------

 SELECT
                                    M.REF_D_C, M.REF_D_NM, M.DATA_ROW,
                                    K.GONGGEUM_GYEJWA_NM AS NUGYE_HOIGYE_NAME,
                                    K.GONGGEUM_GYEJWA AS GONGGEUM_GYEJWA,
                                    (SUM(NVL(TAX_SUNP_IP_AMT,0)) + SUM(NVL(TAX_BAEJUNG_IP_AMT,0))) AS NUGYE_SEIB_SUIP,
                                    SUM(NVL(SEIB_BANNAB,0)) AS NUGYE_SEIB_BANNAB,
                                    SUM(NVL(SEIB_GYEONGJEONG_IB,0)) AS NUGYE_SEIB_GYEONGJEONG_IB,
                                    SUM(NVL(SEIB_GYEONGJEONG_JI,0)) AS NUGYE_SEIB_GYEONGJEONG_JI,
                                    SUM(NVL(SECHUL_BAEJEONG,0)) AS NUGYE_SECHUL_BAEJEONG,
                                    SUM(NVL(SECHUL_HWANSU,0)) AS NUGYE_SECHUL_HWANSU,
                                    SUM(NVL(SECHUL_JI,0)) AS NUGYE_SECHUL_JI,
                                    SUM(NVL(SECHUL_BANNAB,0)) AS NUGYE_SECHUL_BANNAB,
                                    SUM(NVL(SECHUL_GYEONGJEONG_IB,0)) AS NUGYE_SECHUL_GYEONGJEONG_IB,
                                    SUM(NVL(SECHUL_GYEONGJEONG_JI,0)) AS NUGYE_SECHUL_GYEONGJEONG_JI,
                                    SUM(NVL(SEIB_GYULSANBF_IIB,0)) AS NUGYE_SEIB_GYULSANBF_IIB,
                                    SUM(NVL(SECHUL_GYULSANBF_IWOL,0)) AS NUGYE_SECHUL_GYULSANBF_IWOL,
                                    SUM(NVL(DEP,0)) AS NUGYE_DEP,
                                    SUM(NVL(YEKEUM_HEAJI,0)) AS NUGYE_YEKEUM_HEAJI,
                                    SUM(NVL(JEONYONG_JI,0)) AS NUGYE_JEONYONG_JI,
                                    SUM(NVL(JEONYONG_IP,0)) AS NUGYE_JEONYONG_IP,
                                    (SUM(NVL(TAX_SUNP_IP_AMT2,0)) + SUM(NVL(TAX_BAEJUNG_IP_AMT2,0))) AS ILGYE_SEIB_SUIP,
                                    SUM(NVL(SEIB_BANNAB2,0)) AS ILGYE_SEIB_BANNAB,
                                    SUM(NVL(SEIB_GYEONGJEONG_IB2,0)) AS ILGYE_SEIB_GYEONGJEONG_IB,
                                    SUM(NVL(SEIB_GYEONGJEONG_JI2,0)) AS ILGYE_SEIB_GYEONGJEONG_JI,
                                    SUM(NVL(SECHUL_BAEJEONG2,0)) AS ILGYE_SECHUL_BAEJEONG,
                                    SUM(NVL(SECHUL_HWANSU2,0)) AS ILGYE_SECHUL_HWANSU,
                                    SUM(NVL(SECHUL_JI2,0)) AS ILGYE_SECHUL_JI,
                                    SUM(NVL(SECHUL_BANNAB2,0)) AS ILGYE_SECHUL_BANNAB,
                                    SUM(NVL(SECHUL_GYEONGJEONG_IB2,0)) AS ILGYE_SECHUL_GYEONGJEONG_IB,
                                    SUM(NVL(SECHUL_GYEONGJEONG_JI2,0)) AS ILGYE_SECHUL_GYEONGJEONG_JI,
                                    SUM(NVL(SEIB_GYULSANBF_IIB2,0)) AS ILGYE_SEIB_GYULSANBF_IIB,
                                    SUM(NVL(SECHUL_GYULSANBF_IWOL2,0)) AS ILGYE_SECHUL_GYULSANBF_IWOL,
                                    SUM(NVL(DEP2,0)) AS ILGYE_DEP,
                                    SUM(NVL(YEKEUM_HEAJI2,0)) ILGYE_YEKEUM_HEAJI,
                                    SUM(NVL(JEONYONG_JI2,0)) AS ILGYE_JEONYONG_JI,
                                    SUM(NVL(JEONYONG_IP2,0)) ILGYE_JEONYONG_IP,
                                    (SUM(NVL(TAX_SUNP_IP_AMT3,0)) + SUM(NVL(TAX_BAEJUNG_IP_AMT3,0))) AS WOLGYE_SEIB_SUIP,
                                    (SUM(NVL(SEIB_BANNAB3,0))) AS WOLGYE_SEIB_BANNAB
                 FROM
                 (
                      SELECT
                                     GONGGEUM_GUNGU_CODE AS GUNGU_CODE,
                                      GONGGEUM_GYEJWA,
                                      CASE WHEN  GEORAE_GUBUN = 11  
                    THEN  IPGEUM_AMT * JO ELSE 0 END TAX_SUNP_IP_AMT,
                                               CASE WHEN  GEORAE_GUBUN IN (15,16) 
                    THEN  IPGEUM_AMT * JO ELSE 0 END TAX_BAEJUNG_IP_AMT,
                                               CASE WHEN  GEORAE_GUBUN = 64 
                    THEN  JIGEUB_AMT * JO ELSE 0 END SEIB_BANNAB,
                                               CASE WHEN  GEORAE_GUBUN = 19  
                    THEN  IPGEUM_AMT * JO ELSE 0 END SEIB_GYEONGJEONG_IB,    
                                               CASE WHEN  GEORAE_GUBUN = 69
                    THEN  JIGEUB_AMT * JO ELSE 0 END SEIB_GYEONGJEONG_JI, 
                                               CASE WHEN  ((GEORAE_GUBUN = 61 AND JIGEUB_GEORAE = 1) OR (GEORAE_GUBUN = 68 AND JIGEUB_GEORAE = 0))
                    THEN  JIGEUB_AMT * JO ELSE 0 END SECHUL_BAEJEONG,
                                               CASE WHEN  GEORAE_GUBUN = 14 AND IPGEUM_GEORAE = 6
                    THEN  IPGEUM_AMT * JO ELSE 0 END SECHUL_HWANSU,
                                               CASE WHEN  GEORAE_GUBUN = 67
                    THEN  JIGEUB_AMT * JO ELSE 0 END SECHUL_JI,
                                               CASE WHEN  GEORAE_GUBUN = 17
                    THEN  IPGEUM_AMT * JO ELSE 0 END SECHUL_BANNAB,
                                               CASE WHEN  GEORAE_GUBUN = 18
                    THEN  IPGEUM_AMT * JO ELSE 0 END SECHUL_GYEONGJEONG_IB,
                                               CASE WHEN  GEORAE_GUBUN = 65
                    THEN  JIGEUB_AMT * JO ELSE 0 END SECHUL_GYEONGJEONG_JI,
                                               CASE WHEN  GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 4
                    THEN  IPGEUM_AMT * JO ELSE 0 END SEIB_GYULSANBF_IIB,
                                               CASE WHEN  GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 4
                    THEN  JIGEUB_AMT * JO ELSE 0 END SECHUL_GYULSANBF_IWOL,
                                               CASE WHEN  GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 3
                    THEN  JIGEUB_AMT * JO ELSE 0 END DEP,
                                               CASE WHEN  GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 3
                    THEN  IPGEUM_AMT * JO ELSE 0 END YEKEUM_HEAJI,
                                               CASE WHEN  GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 5
                    THEN  JIGEUB_AMT * JO ELSE 0 END JEONYONG_JI,
                                               CASE WHEN  GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 5
                    THEN  IPGEUM_AMT * JO ELSE 0 END JEONYONG_IP,
                                      0 AS TAX_SUNP_IP_AMT2,
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
                                      0 AS YEKEUM_HEAJI2,
                                      0 AS JEONYONG_JI2,
                                      0 AS JEONYONG_IP2,
                                      CASE WHEN ILJA BETWEEN '00000101' AND '20231025' AND  GEORAE_GUBUN = 11  
                    THEN  IPGEUM_AMT * JO ELSE 0 END TAX_SUNP_IP_AMT3,        
                                               CASE WHEN ILJA BETWEEN '00000101' AND '20231025' AND  GEORAE_GUBUN IN (15,16)
                    THEN  IPGEUM_AMT * JO ELSE 0 END TAX_BAEJUNG_IP_AMT3,               
                                               CASE WHEN ILJA BETWEEN  '00000101' AND '20231025' AND  GEORAE_GUBUN = 64  
                    THEN  JIGEUB_AMT * JO ELSE 0 END SEIB_BANNAB3        
                      FROM 
        (
                                    SELECT
                                                   A.ICH_SIGUMGO_GUN_GU_C GONGGEUM_GUNGU_CODE, 
                                        A.FIL_100_CTNT5 GONGGEUM_GYEJWA, A.SIGUMGO_TRX_G GEORAE_GUBUN, 
                            DECODE(A.IPJI_G,1,A.TRAMT,0) IPGEUM_AMT, DECODE(A.IPJI_G,2,A.TRAMT,0) JIGEUB_AMT,
                                                   A.SIGUMGO_JI_TRX_G JIGEUB_GEORAE, A.SIGUMGO_IP_TRX_G IPGEUM_GEORAE,
                                                   A.GJDT ILJA,
                                                   DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1) AS JO,
                                                   CASE WHEN A.SIGUMGO_HOIKYE_YR = 9999 THEN TO_NUMBER(SUBSTR(A.GJDT,1,4))
                                                          ELSE TO_NUMBER(A.SIGUMGO_HOIKYE_YR) END R_HOIGYE_YEAR
                                    FROM  ACL_SIGUMGO_SLV A
                                    WHERE  A.GJDT BETWEEN (CASE WHEN A.SIGUMGO_HOIKYE_YR = 9999 THEN '20230101' ELSE '00000101' END) AND '20231025' 
                                    AND A.SIGUMGO_ORG_C = '28'                                    
                                    AND A.ICH_SIGUMGO_GUN_GU_C LIKE '' || '%'
                                    AND A.FIL_100_CTNT5 = '02800075690000699'
        )
                      UNION ALL         
                      SELECT
                                     GONGGEUM_GUNGU_CODE AS GUNGU_CODE,
                                     GONGGEUM_GYEJWA,
                                     0 AS TAX_SUNP_IP_AMT, 
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
                                     0 AS YEKEUM_HEAJI,              
                                     0 AS JEONYONG_JI,
                                     0 AS JEONYONG_IP,
                                     CASE WHEN  GEORAE_GUBUN = 11 
                   THEN  IPGEUM_AMT * JO ELSE 0 END TAX_SUNP_IP_AMT2,
                                              CASE WHEN  GEORAE_GUBUN IN (15,16)
                   THEN  IPGEUM_AMT * JO ELSE 0 END TAX_BAEJUNG_IP_AMT2,        
                                              CASE WHEN  GEORAE_GUBUN = 64
                   THEN  JIGEUB_AMT * JO ELSE 0 END SEIB_BANNAB2,
                                              CASE WHEN  GEORAE_GUBUN = 19
                   THEN  IPGEUM_AMT * JO ELSE 0 END SEIB_GYEONGJEONG_IB2,    
                                              CASE WHEN  GEORAE_GUBUN = 69
                   THEN  JIGEUB_AMT * JO ELSE 0 END SEIB_GYEONGJEONG_JI2, 
                                              CASE WHEN  ((GEORAE_GUBUN = 61 AND JIGEUB_GEORAE = 1) OR (GEORAE_GUBUN = 68 AND JIGEUB_GEORAE = 0))
                   THEN  JIGEUB_AMT * JO ELSE 0 END SECHUL_BAEJEONG2,
                                              CASE WHEN  GEORAE_GUBUN = 14 AND IPGEUM_GEORAE = 6
                   THEN  IPGEUM_AMT * JO ELSE 0 END SECHUL_HWANSU2,
                                              CASE WHEN  GEORAE_GUBUN = 67
                   THEN  JIGEUB_AMT * JO ELSE 0 END SECHUL_JI2,
                                              CASE WHEN  GEORAE_GUBUN = 17
                   THEN  IPGEUM_AMT * JO ELSE 0 END SECHUL_BANNAB2, 
                                              CASE WHEN  GEORAE_GUBUN = 18
                   THEN  IPGEUM_AMT * JO ELSE 0 END SECHUL_GYEONGJEONG_IB2,
                                              CASE WHEN  GEORAE_GUBUN = 65
                   THEN  JIGEUB_AMT * JO ELSE 0 END SECHUL_GYEONGJEONG_JI2,
                                              CASE WHEN  GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 4
                   THEN  IPGEUM_AMT * JO ELSE 0 END SEIB_GYULSANBF_IIB2,
                                              CASE WHEN  GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 4
                   THEN  JIGEUB_AMT * JO ELSE 0 END SECHUL_GYULSANBF_IWOL2,
                                              CASE WHEN  GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 3
                   THEN  JIGEUB_AMT * JO ELSE 0 END DEP2,             
                                              CASE WHEN  GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 3
                   THEN  IPGEUM_AMT * JO ELSE 0 END YEKEUM_HEAJI2,             
                                              CASE WHEN  GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 5
                   THEN  JIGEUB_AMT * JO ELSE 0 END JEONYONG_JI2,             
                                              CASE WHEN  GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 5
                   THEN  IPGEUM_AMT * JO ELSE 0 END JEONYONG_IP2,             
                                     0 TAX_SUNP_IP_AMT3,                                          
                                     0 TAX_BAEJUNG_IP_AMT3,                                                      
                                     0 SEIB_BANNAB3                                                
                      FROM 
        (
                         SELECT
                                          A.ICH_SIGUMGO_GUN_GU_C GONGGEUM_GUNGU_CODE, 
                      A.FIL_100_CTNT5 GONGGEUM_GYEJWA, A.SIGUMGO_TRX_G GEORAE_GUBUN,
                      DECODE(A.IPJI_G,1,A.TRAMT,0) IPGEUM_AMT, DECODE(A.IPJI_G,2,A.TRAMT,0) JIGEUB_AMT,
                                          A.SIGUMGO_JI_TRX_G JIGEUB_GEORAE, A.SIGUMGO_IP_TRX_G IPGEUM_GEORAE,
                                          A.GJDT ILJA,
                                          DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1) AS JO,
                                          CASE WHEN A.SIGUMGO_HOIKYE_YR = 9999 THEN TO_NUMBER(SUBSTR(A.GJDT,1,4))
                                                  ELSE TO_NUMBER(A.SIGUMGO_HOIKYE_YR) END R_HOIGYE_YEAR 
                         FROM ACL_SIGUMGO_SLV A
                         WHERE A.GJDT BETWEEN '20231025' AND '20231025'
                         AND A.SIGUMGO_ORG_C = '28'                         
                         AND A.ICH_SIGUMGO_GUN_GU_C LIKE '' || '%'
                         AND A.FIL_100_CTNT5 = '02800075690000699'
        )
        UNION ALL         
        SELECT
                                      9999 AS GUNGU_CODE,
                                      GONGGEUM_GYEJWA,
                                      CASE WHEN  GEORAE_GUBUN = 11 
                    THEN  IPGEUM_AMT * JO ELSE 0 END TAX_SUNP_IP_AMT,
                                               CASE WHEN  GEORAE_GUBUN IN (15,16)
                    THEN  IPGEUM_AMT * JO ELSE 0 END TAX_BAEJUNG_IP_AMT,        
                                               CASE WHEN  GEORAE_GUBUN = 64
                    THEN  JIGEUB_AMT * JO ELSE 0 END SEIB_BANNAB,
                                               CASE WHEN  GEORAE_GUBUN = 19
                    THEN  IPGEUM_AMT * JO ELSE 0 END SEIB_GYEONGJEONG_IB,    
                                               CASE WHEN  GEORAE_GUBUN = 69
                    THEN  JIGEUB_AMT * JO ELSE 0 END SEIB_GYEONGJEONG_JI, 
                                               CASE WHEN  ((GEORAE_GUBUN = 61 AND JIGEUB_GEORAE = 1) OR (GEORAE_GUBUN = 68 AND JIGEUB_GEORAE = 0))
                    THEN  JIGEUB_AMT * JO ELSE 0 END SECHUL_BAEJEONG,
                                               CASE WHEN  GEORAE_GUBUN = 14 AND IPGEUM_GEORAE = 6
                    THEN  IPGEUM_AMT * JO ELSE 0 END SECHUL_HWANSU,
                                               CASE WHEN  GEORAE_GUBUN = 67
                    THEN  JIGEUB_AMT * JO ELSE 0 END SECHUL_JI,
                                               CASE WHEN  GEORAE_GUBUN = 17
                    THEN  IPGEUM_AMT * JO ELSE 0 END SECHUL_BANNAB, 
                                               CASE WHEN  GEORAE_GUBUN = 18
                    THEN  IPGEUM_AMT * JO ELSE 0 END SECHUL_GYEONGJEONG_IB,
                                               CASE WHEN  GEORAE_GUBUN = 65
                    THEN  JIGEUB_AMT * JO ELSE 0 END SECHUL_GYEONGJEONG_JI,
                                               CASE WHEN  GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 4
                    THEN  IPGEUM_AMT * JO ELSE 0 END SEIB_GYULSANBF_IIB,
                                               CASE WHEN  GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 4
                    THEN  JIGEUB_AMT * JO ELSE 0 END SECHUL_GYULSANBF_IWOL,
                                               CASE WHEN  GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 3
                    THEN  JIGEUB_AMT * JO ELSE 0 END DEP,
                                               CASE WHEN  GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 3
                    THEN  IPGEUM_AMT * JO ELSE 0 END YEKEUM_HEAJI,             
                                               CASE WHEN  GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 5
                    THEN  JIGEUB_AMT * JO ELSE 0 END JEONYONG_JI,
                                               CASE WHEN  GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 5
                    THEN  IPGEUM_AMT * JO ELSE 0 END JEONYONG_IP, 
                                      0 AS TAX_SUNP_IP_AMT2, 
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
                                      0 AS YEKEUM_HEAJI2,
                                      0 AS JEONYONG_JI2,
                                      0 AS JEONYONG_IP2,
                                      CASE WHEN ILJA BETWEEN  '00000101' AND '20231025' AND  GEORAE_GUBUN = 11
                    THEN  IPGEUM_AMT * JO ELSE 0 END TAX_SUNP_IP_AMT3,
                                               CASE WHEN ILJA BETWEEN  '00000101' AND '20231025' AND  GEORAE_GUBUN IN (15,16)
                    THEN  IPGEUM_AMT * JO ELSE 0 END TAX_BAEJUNG_IP_AMT3,        
                                               CASE WHEN ILJA BETWEEN '00000101' AND '20231025' AND  GEORAE_GUBUN = 64
                    THEN  JIGEUB_AMT * JO ELSE 0 END SEIB_BANNAB3 
        FROM 
        (
                         SELECT
                                         A.ICH_SIGUMGO_GUN_GU_C GONGGEUM_GUNGU_CODE,
                      A.FIL_100_CTNT5 GONGGEUM_GYEJWA, A.SIGUMGO_TRX_G GEORAE_GUBUN, 
                      DECODE(A.IPJI_G,1,A.TRAMT,0) IPGEUM_AMT, DECODE(A.IPJI_G,2,A.TRAMT,0) JIGEUB_AMT,
                                         A.SIGUMGO_JI_TRX_G JIGEUB_GEORAE, A.SIGUMGO_IP_TRX_G IPGEUM_GEORAE,
                                         A.GJDT ILJA,
                                         DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1) AS JO,
                                         CASE WHEN A.SIGUMGO_HOIKYE_YR = 9999 THEN TO_NUMBER(SUBSTR(A.GJDT,1,4))
                                                ELSE TO_NUMBER(A.SIGUMGO_HOIKYE_YR) END R_HOIGYE_YEAR
                         FROM  ACL_SIGUMGO_SLV A
                         WHERE  A.GJDT BETWEEN (CASE WHEN A.SIGUMGO_HOIKYE_YR = 9999 THEN '20230101' ELSE '00000101' END) AND '20231025'
                         AND A.SIGUMGO_ORG_C = '28'
                         AND A.ICH_SIGUMGO_GUN_GU_C LIKE '' || '%'
                         AND A.FIL_100_CTNT5 = '02800075690000699'

        )
        UNION ALL         
        SELECT
                                         9999 AS GUNGU_CODE,
                                         GONGGEUM_GYEJWA,
                                         0 AS TAX_SUNP_IP_AMT, 
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
                                         0 AS YEKEUM_HEAJI,              
                                         0 AS JEONYONG_JI,
                                         0 AS JEONYONG_IP,
                                         CASE WHEN  GEORAE_GUBUN = 11 
                     THEN  IPGEUM_AMT * JO ELSE 0 END TAX_SUNP_IP_AMT2,
                                                   CASE WHEN  GEORAE_GUBUN IN (15,16)
                     THEN  IPGEUM_AMT * JO ELSE 0 END TAX_BAEJUNG_IP_AMT2,        
                                                   CASE WHEN  GEORAE_GUBUN = 64
                     THEN  JIGEUB_AMT * JO ELSE 0 END SEIB_BANNAB2,
                                                   CASE WHEN  GEORAE_GUBUN = 19
                     THEN  IPGEUM_AMT * JO ELSE 0 END SEIB_GYEONGJEONG_IB2,    
                                                   CASE WHEN  GEORAE_GUBUN = 69
                     THEN  JIGEUB_AMT * JO ELSE 0 END SEIB_GYEONGJEONG_JI2, 
                                                   CASE WHEN  ((GEORAE_GUBUN = 61 AND JIGEUB_GEORAE = 1) OR (GEORAE_GUBUN = 68 AND JIGEUB_GEORAE = 0))
                     THEN  JIGEUB_AMT * JO ELSE 0 END SECHUL_BAEJEONG2,
                                                   CASE WHEN  GEORAE_GUBUN = 14 AND IPGEUM_GEORAE = 6
                     THEN  IPGEUM_AMT * JO ELSE 0 END SECHUL_HWANSU2,
                                                   CASE WHEN  GEORAE_GUBUN = 67
                     THEN  JIGEUB_AMT * JO ELSE 0 END SECHUL_JI2,
                                                   CASE WHEN  GEORAE_GUBUN = 17
                     THEN  IPGEUM_AMT * JO ELSE 0 END SECHUL_BANNAB2, 
                                                   CASE WHEN  GEORAE_GUBUN = 18
                     THEN  IPGEUM_AMT * JO ELSE 0 END SECHUL_GYEONGJEONG_IB2,
                                                   CASE WHEN  GEORAE_GUBUN = 65
                     THEN  JIGEUB_AMT * JO ELSE 0 END SECHUL_GYEONGJEONG_JI2,
                                                   CASE WHEN  GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 4
                     THEN  IPGEUM_AMT * JO ELSE 0 END SEIB_GYULSANBF_IIB2,
                                                   CASE WHEN  GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 4
                     THEN  JIGEUB_AMT * JO ELSE 0 END SECHUL_GYULSANBF_IWOL2,
                                                   CASE WHEN  GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 3
                     THEN  JIGEUB_AMT * JO ELSE 0 END DEP2,             
                                                   CASE WHEN  GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 3
                     THEN  IPGEUM_AMT * JO ELSE 0 END YEKEUM_HEAJI2,             
                                                   CASE WHEN  GEORAE_GUBUN = 62 AND JIGEUB_GEORAE = 5
                     THEN  JIGEUB_AMT * JO ELSE 0 END JEONYONG_JI2,             
                                                   CASE WHEN  GEORAE_GUBUN = 12 AND IPGEUM_GEORAE = 5
                     THEN  IPGEUM_AMT * JO ELSE 0 END JEONYONG_IP2,             
                                         0 TAX_SUNP_IP_AMT3,                                          
                                         0 TAX_BAEJUNG_IP_AMT3,                                                      
                                         0 SEIB_BANNAB3                                                
        FROM 
        (
                           SELECT
                                         A.ICH_SIGUMGO_GUN_GU_C GONGGEUM_GUNGU_CODE,
                     A.FIL_100_CTNT5 GONGGEUM_GYEJWA, A.SIGUMGO_TRX_G GEORAE_GUBUN,
                     DECODE(A.IPJI_G,1,A.TRAMT,0) IPGEUM_AMT, DECODE(A.IPJI_G,2,A.TRAMT,0) JIGEUB_AMT,
                                         A.SIGUMGO_JI_TRX_G JIGEUB_GEORAE, A.SIGUMGO_IP_TRX_G IPGEUM_GEORAE,
                                         A.GJDT ILJA,
                                         DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1) AS JO,
                                         CASE WHEN A.SIGUMGO_HOIKYE_YR = 9999 THEN TO_NUMBER(SUBSTR(A.GJDT,1,4))
                                                ELSE TO_NUMBER(A.SIGUMGO_HOIKYE_YR) END R_HOIGYE_YEAR
                           FROM  ACL_SIGUMGO_SLV A
                           WHERE A.GJDT BETWEEN  '20231025' AND '20231025'
                           AND A.SIGUMGO_ORG_C = '28'                           
                           AND A.ICH_SIGUMGO_GUN_GU_C LIKE '' || '%'                  
                           AND A.FIL_100_CTNT5 = '02800075690000699'
        )
        UNION ALL         
        SELECT
                                         GUNGU_CODE,
                                         GONGGEUM_GYEJWA,
                                         JANAEK AS TAX_SUNP_IP_AMT, 
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
                                         0 AS YEKEUM_HEAJI,              
                                         0 AS JEONYONG_JI,
                                         0 AS JEONYONG_IP,
                                         0 AS TAX_SUNP_IP_AMT2, 
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
                                         0 AS YEKEUM_HEAJI2,
                                         0 AS JEONYONG_JI2,
                                         0 AS JEONYONG_IP2,
                                         0 TAX_SUNP_IP_AMT3,                                          
                                         0 TAX_BAEJUNG_IP_AMT3,                                                      
                                         0 SEIB_BANNAB3                                                
        FROM
        (
                             SELECT
                                         GUNGU_CODE,
                                         GONGGEUM_GYEJWA,
                                         JANAEK
                             FROM  RPT_GONGGEUM_JAN
                             WHERE  GEUMGO_CODE = '28'
                             AND GUNGU_CODE LIKE '' || '%'
                             AND HOIGYE_CODE = 75
                             AND HOIGYE_YEAR = '9999'
                             AND KEORAEIL IN (SELECT BIZ_DT FROM MAP_JOB_DATE WHERE DW_BAS_DDT = TO_CHAR(TO_NUMBER(SUBSTR('20231025',0,4)) -1)||'1231')
                             AND GONGGEUM_GYEJWA = '02800075690000699'
        )
 )