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
                                      CASE WHEN ILJA BETWEEN '00000101' AND '20240709' AND  GEORAE_GUBUN = 11  
                    THEN  IPGEUM_AMT * JO ELSE 0 END TAX_SUNP_IP_AMT3,        
                                               CASE WHEN ILJA BETWEEN '00000101' AND '20240709' AND  GEORAE_GUBUN IN (15,16)
                    THEN  IPGEUM_AMT * JO ELSE 0 END TAX_BAEJUNG_IP_AMT3,               
                                               CASE WHEN ILJA BETWEEN  '00000101' AND '20240709' AND  GEORAE_GUBUN = 64  
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
                                    WHERE  A.GJDT BETWEEN (CASE WHEN A.SIGUMGO_HOIKYE_YR = 9999 THEN '20240101' ELSE '00000101' END) AND '20240709' 
                                    AND A.SIGUMGO_ORG_C = '28'                                    
                                    AND A.ICH_SIGUMGO_GUN_GU_C LIKE '0' || '%'
                                    AND A.FIL_100_CTNT5 = '02800075690000624'
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
                         WHERE A.GJDT BETWEEN '20240709' AND '20240709'
                         AND A.SIGUMGO_ORG_C = '28'                         
                         AND A.ICH_SIGUMGO_GUN_GU_C LIKE '0' || '%'
                         AND A.FIL_100_CTNT5 = '02800075690000624'
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
                                      CASE WHEN ILJA BETWEEN  '00000101' AND '20240709' AND  GEORAE_GUBUN = 11
                    THEN  IPGEUM_AMT * JO ELSE 0 END TAX_SUNP_IP_AMT3,
                                               CASE WHEN ILJA BETWEEN  '00000101' AND '20240709' AND  GEORAE_GUBUN IN (15,16)
                    THEN  IPGEUM_AMT * JO ELSE 0 END TAX_BAEJUNG_IP_AMT3,        
                                               CASE WHEN ILJA BETWEEN '00000101' AND '20240709' AND  GEORAE_GUBUN = 64
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
                         WHERE  A.GJDT BETWEEN (CASE WHEN A.SIGUMGO_HOIKYE_YR = 9999 THEN '20240101' ELSE '00000101' END) AND '20240709'
                         AND A.SIGUMGO_ORG_C = '28'
                         AND A.ICH_SIGUMGO_GUN_GU_C LIKE '0' || '%'
                         AND A.FIL_100_CTNT5 = '02800075690000624'

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
                           WHERE A.GJDT BETWEEN  '20240709' AND '20240709'
                           AND A.SIGUMGO_ORG_C = '28'                           
                           AND A.ICH_SIGUMGO_GUN_GU_C LIKE '0' || '%'                  
                           AND A.FIL_100_CTNT5 = '02800075690000624'
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
                             AND GUNGU_CODE LIKE '0' || '%'
                             AND HOIGYE_CODE = 75
                             AND HOIGYE_YEAR = '9999'
                             AND KEORAEIL IN (SELECT BIZ_DT FROM MAP_JOB_DATE WHERE DW_BAS_DDT = TO_CHAR(TO_NUMBER(SUBSTR('20240709',0,4)) -1)||'1231')
                             AND GONGGEUM_GYEJWA = '02800075690000624'
        )
 ) T,
 (
       SELECT SIGUMGO_AC_NM GONGGEUM_GYEJWA_NM, FIL_100_CTNT2 GONGGEUM_GYEJWA
       FROM ACL_SIGUMGO_MAS
       WHERE SIGUMGO_ORG_C = '28'
             AND FIL_100_CTNT2 = '02800075690000624'
      AND MNG_NO = 1
 ) K,
 (SELECT '0' REF_D_C, (SELECT REF_D_NM FROM RPT_CODE_INFO WHERE REF_L_C = 500 AND REF_M_C = '28' AND REF_S_C = 1 AND REF_D_C = '0') REF_D_NM, 1 DATA_ROW FROM DUAL
   UNION ALL
   SELECT '9999' REF_D_C, '합계' REF_D_NM, 2 DATA_ROW FROM DUAL
 ) M
 WHERE T.GONGGEUM_GYEJWA = K.GONGGEUM_GYEJWA
 AND T.GUNGU_CODE(+) = M.REF_D_C
 AND K.GONGGEUM_GYEJWA = '02800075690000624'
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
                       SUM(CASE WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN  = 1 AND SUNAPIL = '20240709' THEN NVL(JIBANGSE_AMT,0) * -1
                                            WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN  = 2 AND SUNAPIL = '20240709' THEN NVL(JIBANGSE_AMT,0)  ELSE 0 END) AMT2,
                       SUM(CASE WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 1 AND SUNAPIL = '20240709' THEN NVL(JIBANGSE_AMT,0)
                                            WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 2 AND SUNAPIL = '20240709' THEN NVL(JIBANGSE_AMT,0) * -1  ELSE 0 END) AMT3,
                       0 AMT4,
                       SUM(CASE WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN  = 1 AND SUNAPIL = '20240709' THEN NVL(SEWOI_AMT,0) * -1
                                            WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN  = 2 AND SUNAPIL = '20240709' THEN NVL(SEWOI_AMT,0)  ELSE 0 END) AMT5,
                       SUM(CASE WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 1 AND SUNAPIL = '20240709' THEN NVL(SEWOI_AMT,0)
                                            WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 2 AND SUNAPIL = '20240709' THEN NVL(SEWOI_AMT,0) * -1 ELSE 0 END) AMT6,
                       0 AMT7,
                       SUM(CASE WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN  = 1 AND SUNAPIL = '20240709' THEN NVL(GYOYUKSE_AMT,0) * -1
                                            WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN  = 2 AND SUNAPIL = '20240709' THEN NVL(GYOYUKSE_AMT,0) ELSE 0 END) AMT8,
                       SUM(CASE WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 1 AND SUNAPIL = '20240709' THEN NVL(GYOYUKSE_AMT,0)
                                            WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 2 AND SUNAPIL = '20240709' THEN NVL(GYOYUKSE_AMT,0) * -1 ELSE 0 END) AMT9,
                       0 AMT10,
                       SUM(CASE WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN  = 1 AND SUNAPIL = '20240709' THEN NVL(NONGTEUKSE_AMT,0) * -1
                                            WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN  = 2 AND SUNAPIL = '20240709' THEN NVL(NONGTEUKSE_AMT,0) ELSE 0 END) AMT11,
                       SUM(CASE WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 1 AND SUNAPIL = '20240709' THEN NVL(NONGTEUKSE_AMT,0)
                                            WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 2 AND SUNAPIL = '20240709' THEN NVL(NONGTEUKSE_AMT,0) * -1 ELSE 0 END) AMT12,
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
                       SUM(CASE WHEN (SUNAPIL BETWEEN '20240709' AND '20240709') AND IPJI_GUBUN = 1 THEN NVL(JIBANGSE_AMT,0)
                                            WHEN (SUNAPIL BETWEEN SUBSTR('20240709',0,6)||'01' AND '20240709') AND IPJI_GUBUN <> 1 THEN NVL(JIBANGSE_AMT,0) * -1 ELSE 0 END) AMT25,
                       SUM(CASE WHEN (SUNAPIL BETWEEN SUBSTR('20240709',0,6)||'01' AND '20240709') AND IPJI_GUBUN =  1 THEN NVL(SEWOI_AMT,0)
                                            WHEN (SUNAPIL BETWEEN SUBSTR('20240709',0,6)||'01' AND '20240709') AND IPJI_GUBUN <> 1 THEN NVL(SEWOI_AMT,0) * -1 ELSE 0 END) AMT26,
                       SUM(CASE WHEN (SUNAPIL BETWEEN SUBSTR('20240709',0,6)||'01' AND '20240709') AND IPJI_GUBUN =  1 THEN NVL(GYOYUKSE_AMT,0)
                                            WHEN (SUNAPIL BETWEEN SUBSTR('20240709',0,6)||'01' AND '20240709') AND IPJI_GUBUN <> 1 THEN NVL(GYOYUKSE_AMT,0) * -1 ELSE 0 END) AMT27,
                       SUM(CASE WHEN (SUNAPIL BETWEEN SUBSTR('20240709',0,6)||'00' AND '20240709') AND IPJI_GUBUN =  1 THEN NVL(NONGTEUKSE_AMT,0)
                                            WHEN (SUNAPIL BETWEEN SUBSTR('20240709',0,6)||'00' AND '20240709') AND IPJI_GUBUN <> 1 THEN NVL(NONGTEUKSE_AMT,0) * -1 ELSE 0 END) AMT28
      FROM  RPT_DANGSEIPJOJEONG A
       WHERE  A.GEUMGO_CODE = '28' 
       AND A.SUNAPIL <= '20240709'
      AND A.GUNGU_CODE LIKE '0' || '%'
      AND A.JIBGYE_CODE = (SELECT REF_D_C FROM RPT_CODE_INFO WHERE REF_L_C = 879 AND REF_M_C = 28 AND REF_CTNT1 = '02800075690000624')
       GROUP BY A.GUNGU_CODE
 ) AA,
 (SELECT '0' REF_D_C, (SELECT REF_D_NM FROM RPT_CODE_INFO WHERE REF_L_C = 500 AND REF_M_C = '28' AND REF_S_C = 1 AND REF_D_C = '0') REF_D_NM, 1 DATA_ROW FROM DUAL
   UNION ALL
   SELECT '9999' REF_D_C, '합계' REF_D_NM, 2 DATA_ROW FROM DUAL
 ) M
 WHERE
   AA.GUNGU_CODE(+) = M.REF_D_C
 GROUP BY  REF_D_C, REF_D_NM, AA.DATA_ROW
 ) A
 GROUP BY GUNGU_CODE, GUNGU_NM, DATA_ROW
 ORDER BY GUNGU_CODE, GUNGU_NM, DATA_ROW