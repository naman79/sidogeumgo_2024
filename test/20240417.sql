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
      SELECT
              A.ICH_SIGUMGO_GUN_GU_C GUNGU_CODE,
              1 DATA_ROW,
              SUM(
              CASE WHEN (CASE WHEN GJDT > GISDT THEN GISDT ELSE  GJDT END) = '20240416'
                          AND A.SIGUMGO_TRX_G = 11 AND A.SIGUMGO_IP_TRX_G = 1 AND A.CRT_CAN_G <> 1 THEN DECODE(A.IPJI_G,1,A.TRAMT,0)
                   WHEN (CASE WHEN GJDT > GISDT THEN GISDT ELSE GJDT END) = '20240416'
                                                  AND A.SIGUMGO_TRX_G = 11 AND A.SIGUMGO_IP_TRX_G = 1 AND A.CRT_CAN_G = 1 THEN DECODE(A.IPJI_G,1,A.TRAMT,0)*-1
               ELSE 0 END) AMT1,
               0 AMT2,
               0 AMT3,
               0 AMT4,
               0 AMT5,
               0 AMT6,
               0 AMT7,
               0 AMT8,
               0 AMT9,
               0 AMT10,
               0 AMT11,
               0 AMT12,
               SUM(
               CASE WHEN A.SIGUMGO_TRX_G = 11 AND A.SIGUMGO_IP_TRX_G = 1 AND A.CRT_CAN_G <> 1 THEN DECODE(A.IPJI_G,1,A.TRAMT,0)
                    WHEN A.SIGUMGO_TRX_G = 11 AND A.SIGUMGO_IP_TRX_G = 1 AND A.CRT_CAN_G = 1 THEN DECODE(A.IPJI_G,1,A.TRAMT,0)*-1
               ELSE 0 END
              ) AMT13,
               0 AMT14,
               0 AMT15,
               0 AMT16,
               0 AMT17,
               0 AMT18,
               0 AMT19,
               0 AMT20,
               0 AMT21,
               0 AMT22,
               0 AMT23,
               0 AMT24,
               0 AMT25,
               0 AMT26,
               0 AMT27,
               0 AMT28
      FROM ACL_SIGUMGO_SLV A, ACL_SIGUMGO_MAS B, RPT_CODE_INFO C
    WHERE B.FIL_100_CTNT2 = A.FIL_100_CTNT5
      AND B.FIL_100_CTNT2 =  C.REF_CTNT3 
      AND C.REF_L_C = 887 AND C.REF_M_C = 28 AND C.REF_S_C = 10 AND C.REF_CTNT1 = 25 AND C.REF_CTNT2 = '2024' AND C.YUHYO_YN = 0
      AND B.SIGUMGO_ORG_C = 28
      AND  (CASE WHEN A.GJDT > A.GISDT THEN A.GISDT ELSE A.GJDT END) BETWEEN '202401' AND '20240416'
      AND  B.ICH_SIGUMGO_HOIKYE_C =  25
      AND  (CASE WHEN A.GJDT > A.GISDT THEN A.GISDT ELSE A.GJDT END) >= '2024'
      AND  (A.NEW_GU_YR_G IN (0, 1)  OR A.SIGUMGO_HOIKYE_YR = 9999)  
      AND B.MNG_NO = 1
      AND (
            (
                '1' = (CASE WHEN LENGTH(TRIM(NVL('', ''))) IS NULL THEN '1' ELSE '0' END)
            ) 
        OR 
            (
                '1' = (CASE WHEN A.ICH_SIGUMGO_GUN_GU_C = '' THEN '1' ELSE '0' END)
            ) 
        )                          
        GROUP  BY A.ICH_SIGUMGO_GUN_GU_C                        
      UNION ALL
      SELECT  GUNGU_CODE, 1 DATA_ROW,
           0 AMT1,
           SUM(CASE WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN  = 1 AND SUNAPIL = '20240416'  THEN NVL(JIBANGSE_AMT,0) * -1
                                WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN  = 2 AND SUNAPIL = '20240416'  THEN NVL(JIBANGSE_AMT,0)
                     ELSE 0 END) AMT2,
           SUM(CASE WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 1 AND SUNAPIL = '20240416'  THEN NVL(JIBANGSE_AMT,0)
                                WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 2 AND SUNAPIL = '20240416'  THEN NVL(JIBANGSE_AMT,0) * -1
                     ELSE 0 END) AMT3,
           0 AMT4,
           SUM(CASE WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN  = 1 AND SUNAPIL = '20240416'  THEN NVL(SEWOI_AMT,0) * -1
                                WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN  = 2 AND SUNAPIL = '20240416'  THEN NVL(SEWOI_AMT,0)
                     ELSE 0 END) AMT5,
           SUM(CASE WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 1 AND SUNAPIL = '20240416' THEN NVL(SEWOI_AMT,0)
                                WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 2 AND SUNAPIL = '20240416' THEN NVL(SEWOI_AMT,0) * -1
                     ELSE 0 END) AMT6,
           0 AMT7,
           SUM(CASE WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN  = 1 AND SUNAPIL = '20240416' THEN NVL(GYOYUKSE_AMT,0) * -1
                                WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN  = 2 AND SUNAPIL = '20240416' THEN NVL(GYOYUKSE_AMT,0)
                     ELSE 0 END) AMT8,
           SUM(CASE WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 1 AND SUNAPIL = '20240416' THEN NVL(GYOYUKSE_AMT,0)
                                WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 2 AND SUNAPIL = '20240416' THEN NVL(GYOYUKSE_AMT,0) * -1
                     ELSE 0 END) AMT9,
           0 AMT10,
           SUM(CASE WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN  = 1 AND SUNAPIL = '20240416' THEN NVL(NONGTEUKSE_AMT,0) * -1
                                WHEN JOJEONG_GUBUN = 2 AND IPJI_GUBUN  = 2 AND SUNAPIL = '20240416' THEN NVL(NONGTEUKSE_AMT,0)
                     ELSE 0 END) AMT11,
           SUM(CASE WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 1 AND SUNAPIL = '20240416' THEN NVL(NONGTEUKSE_AMT,0)
                                WHEN JOJEONG_GUBUN <> 2 AND IPJI_GUBUN = 2 AND SUNAPIL = '20240416' THEN NVL(NONGTEUKSE_AMT,0) * -1
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
           SUM(CASE WHEN (SUNAPIL BETWEEN SUBSTR('20240416',0,6)||'01' AND '20240416') AND IPJI_GUBUN = 1 THEN NVL(JIBANGSE_AMT,0)
                                WHEN (SUNAPIL BETWEEN SUBSTR('20240416',0,6)||'01' AND '20240416') AND IPJI_GUBUN <> 1 THEN NVL(JIBANGSE_AMT,0) * -1
                     ELSE 0 END) AMT25,
           SUM(CASE WHEN (SUNAPIL BETWEEN SUBSTR('20240416',0,6)||'01' AND '20240416') AND IPJI_GUBUN =  1 THEN NVL(SEWOI_AMT,0)
                                WHEN (SUNAPIL BETWEEN SUBSTR('20240416',0,6)||'01' AND '20240416') AND IPJI_GUBUN <> 1 THEN NVL(SEWOI_AMT,0) * -1
                     ELSE 0 END) AMT26,
           SUM(CASE WHEN (SUNAPIL BETWEEN SUBSTR('20240416',0,6)||'01' AND '20240416') AND IPJI_GUBUN =  1 THEN NVL(GYOYUKSE_AMT,0)
                                WHEN (SUNAPIL BETWEEN SUBSTR('20240416',0,6)||'01' AND '20240416') AND IPJI_GUBUN <> 1 THEN NVL(GYOYUKSE_AMT,0) * -1
                     ELSE 0 END) AMT27,
           SUM(CASE WHEN (SUNAPIL BETWEEN SUBSTR('20240416',0,6)||'00' AND '20240416') AND IPJI_GUBUN =  1 THEN NVL(NONGTEUKSE_AMT,0)
                                WHEN (SUNAPIL BETWEEN SUBSTR('20240416',0,6)||'00' AND '20240416') AND IPJI_GUBUN <> 1 THEN NVL(NONGTEUKSE_AMT,0) * -1
                     ELSE 0 END) AMT28
      FROM  RPT_DANGSEIPJOJEONG A
      WHERE  A.GEUMGO_CODE = 28 AND A.SUNAPIL BETWEEN SUBSTR('20240416',0,4)||'0101' AND '20240416'
      AND  A.JIBGYE_CODE = '212500'
      AND  SUNAPIL >= '2024'
      AND  (YEAR_GUBUN = 1 OR HOIGYE_YEAR = 9999)
      AND (
        (
            '1' = (CASE WHEN LENGTH(TRIM(NVL('', ''))) IS NULL THEN '1' ELSE '0' END)
        ) 
    OR 
        (
            '1' = (CASE WHEN GUNGU_CODE = '' THEN '1' ELSE '0' END)
        ) 
    )                          
      GROUP  BY GUNGU_CODE      
      UNION ALL     
      SELECT  9999 ICH_SIGUMGO_GUN_GU_C, 2 DATA_ROW,
          SUM(CASE WHEN  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE BAS_DT END) = '20240416'  THEN  BIZPLC_BAEJUNG_JI_AMT ELSE 0  END) 
            +SUM(CASE WHEN  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE BAS_DT END) = '20240416'  THEN  BIZPLC_GAM_BAEJUNG_IP_AMT ELSE 0  END) AMT1,  
          SUM(CASE WHEN  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE BAS_DT END) = '20240416' THEN  TAXO_FUND_BAEJUNG_JI_AMT+TAXO_HNDO_BAEJUNG_JI_AMT+TAXO_FUND_GETBK_JI_AMT
                                                                                                                            +TAXO_HNDO_JICHUL_JI_AMT+TAXO_HNDO_GETBK_JI_AMT ELSE 0 END) AMT2,
          SUM(CASE WHEN  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE BAS_DT END) = '20240416' THEN  TAXO_RTRN_AMT ELSE 0 END)*-1 AMT3,                                                                                       
          0 AMT4,  0 AMT5,  0 AMT6,  0 AMT7,  0 AMT8,  0 AMT9,  0 AMT10, 0 AMT11, 0 AMT12,                                     
          SUM(CASE WHEN SIGUMGO_AC_B = 10 THEN  BIZPLC_BAEJUNG_JI_AMT ELSE 0 END) 
              +SUM(BIZPLC_GAM_BAEJUNG_IP_AMT) AMT13,
          SUM(TAXO_FUND_BAEJUNG_JI_AMT+TAXO_HNDO_BAEJUNG_JI_AMT+TAXO_FUND_GETBK_JI_AMT
                                                        +TAXO_HNDO_JICHUL_JI_AMT+TAXO_HNDO_GETBK_JI_AMT) AMT14,
          SUM(TAXO_RTRN_AMT)*-1 AMT15,
          SUM(CASE WHEN '4' < 3    THEN  GA_IWOL_JI_AMT-GA_IWOL_IP_AMT                                                             
                                                             WHEN '4' >= 3 THEN 0 END) AMT16,
          0 AMT17,    
          SUM(PMNY_JAN_MVO_AMT-PMNY_JAN_MVI_AMT) AMT18,
          0 AMT19, 0 AMT20, 0 AMT21, 0 AMT22, 0 AMT23, 0 AMT24,
          0 AMT25, 0 AMT26, 0 AMT27, 0 AMT28
      FROM  RPT_TXIO_DDAC_TAB A
      WHERE  1=1      
      AND A.SGG_ACNO IN (SELECT REF_CTNT3 FROM RPT_CODE_INFO WHERE REF_L_C = 887 AND REF_M_C = 28 AND REF_CTNT1 = 25 AND REF_CTNT2 = '2024' AND YUHYO_YN = 0)
      AND (NEW_GU_YR_G IN (0, 1) OR A.SIGUMGO_HOIKYE_YR = '9999')     
      AND A.ICH_SIGUMGO_HOIKYE_C = 25     
      AND (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END) BETWEEN SUBSTR('20240416',0,4)||'0101' AND '20240416'
      AND A.SIGUMGO_ORG_C  = '28' 
      AND (
            (
                '1' = (CASE WHEN LENGTH(TRIM(NVL('', ''))) IS NULL THEN '1' ELSE '0' END)
            ) 
        OR 
            (
                '1' = (CASE WHEN ICH_SIGUMGO_GUN_GU_C = '' THEN '1' ELSE '0' END)
            ) 
        )  
    
) AA,  
(SELECT REF_D_C, REF_D_NM FROM RPT_CODE_INFO                                                                             
       WHERE REF_L_C=500                                                                                                      
         AND REF_M_C=28                                                                                                       
         AND REF_S_C = 1                                                                                                      
       UNION ALL                                                                                                              
         SELECT 9999 REF_D_C, '합계' REF_D_NM FROM DUAL                                                                       
) BB                                                                                                                    
WHERE AA.GUNGU_CODE(+) = BB.REF_D_C                                                                                        
GROUP BY REF_D_C, REF_D_NM, DATA_ROW                                                                                        
ORDER BY GUNGU_CODE
