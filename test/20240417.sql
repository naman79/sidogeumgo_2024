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


---------------------------------------


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
       SELECT ICH_SIGUMGO_GUN_GU_C GUNGU_CODE,
              1 DATA_ROW, 
              SUM(CASE WHEN (SUNAP_DT = '20240416')  THEN NVL(JIBANGSE_AMT,0) ELSE 0 END ) AMT1,
              SUM(CASE WHEN (SUNAP_DT = '20240416' )  THEN NVL(JIBANGSE_GWAON_AMT,0) ELSE 0 END ) AMT2, 
              SUM(CASE WHEN (SUNAP_DT = '20240416' )  THEN NVL(JIBANGSE_CRT_AMT,0) ELSE 0 END ) AMT3,
              SUM(CASE WHEN (SUNAP_DT = '20240416' )  THEN NVL(SEWOI_AMT,0) ELSE 0 END ) AMT4,
              SUM(CASE WHEN (SUNAP_DT = '20240416' )  THEN NVL(SEWOI_GWAON_AMT,0) ELSE 0 END ) AMT5,
              SUM(CASE WHEN (SUNAP_DT = '20240416' )  THEN NVL(SEWOI_CRT_AMT,0) ELSE 0 END ) AMT6,
              SUM(CASE WHEN (SUNAP_DT = '20240416' )  THEN NVL(GYOYUKSE_AMT,0) ELSE 0 END ) AMT7,
              SUM(CASE WHEN (SUNAP_DT = '20240416' )  THEN NVL(GYOYUKSE_GWAON_AMT,0) ELSE 0 END ) AMT8,
              SUM(CASE WHEN (SUNAP_DT = '20240416' )  THEN NVL(GYOYUKSE_CRT_AMT,0) ELSE 0 END ) AMT9,
              SUM(CASE WHEN (SUNAP_DT = '20240416' )  THEN NVL(NONGTEUKSE_AMT,0) ELSE 0 END ) AMT10,
              SUM(CASE WHEN (SUNAP_DT = '20240416' )  THEN NVL(NONGTEUKSE_GWAON_AMT,0) ELSE 0 END ) AMT11,
              SUM(CASE WHEN (SUNAP_DT = '20240416' )  THEN NVL(NONGTEUKSE_CRT_AMT,0) ELSE 0 END ) AMT12,
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
              SUM(   CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240416',0,6) || '01' AND '20240416')  THEN NVL(JIBANGSE_AMT,0)           ELSE 0 END    
                   + CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240416',0,6) || '01' AND '20240416')  THEN NVL(JIBANGSE_GWAON_AMT,0) *-1 ELSE 0 END   
                   + CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240416',0,6) || '01' AND '20240416')  THEN NVL(JIBANGSE_CRT_AMT,0)       ELSE 0 END           
                 ) AMT25,
               SUM(  CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240416',0,6) || '01' AND '20240416')  THEN NVL(SEWOI_AMT,0)           ELSE 0 END    
                   + CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240416',0,6) || '01' AND '20240416')  THEN NVL(SEWOI_GWAON_AMT,0) *-1 ELSE 0 END   
                   + CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240416',0,6) || '01' AND '20240416')  THEN NVL(SEWOI_CRT_AMT,0)       ELSE 0 END           
                  ) AMT26,
               SUM(  CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240416',0,6) || '01' AND '20240416')  THEN NVL(GYOYUKSE_AMT,0)           ELSE 0 END    
                   + CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240416',0,6) || '01' AND '20240416')  THEN NVL(GYOYUKSE_GWAON_AMT,0) *-1 ELSE 0 END   
                   + CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240416',0,6) || '01' AND '20240416')  THEN NVL(GYOYUKSE_CRT_AMT,0)       ELSE 0 END           
                  ) AMT27,
               SUM(  CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240416',0,6) || '01' AND '20240416')  THEN NVL(NONGTEUKSE_AMT,0)           ELSE 0 END    
                   + CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240416',0,6) || '01' AND '20240416')  THEN NVL(NONGTEUKSE_GWAON_AMT,0) *-1 ELSE 0 END   
                   + CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240416',0,6) || '01' AND '20240416')  THEN NVL(NONGTEUKSE_CRT_AMT,0)       ELSE 0 END           
                  ) AMT28
         FROM RPT_TXI_DDAC_TAB
        WHERE 1=1
          AND  SIGUMGO_ORG_C = '28' 
          AND (    '1' = (CASE WHEN 1  = '43' AND '1'     IN(8,9) AND SUNAP_DT BETWEEN ('2024')-1 ||  '0101' AND '20240416' THEN '1' ELSE '0' END)
                OR '1' = (CASE WHEN 1  = '43' AND '1' NOT IN(8,9) AND SUNAP_DT BETWEEN ('2024')   ||  '0101' AND '20240416' THEN '1' ELSE '0' END)
                OR '1' = (CASE WHEN 1 <> '43' AND SUNAP_DT BETWEEN ('2024') ||  '0101' AND '20240416' THEN '1' ELSE '0' END  )
              )    
          AND ICH_SIGUMGO_HOIKYE_C = '43'
          AND ICH_SIGUMGO_GUN_GU_C LIKE '' || '%'
          AND (    ('1' = ( CASE WHEN'43' = 1 AND SIGUTAX_G ='2' THEN  '1' ELSE '0' END))  
                OR ('1' = ( CASE WHEN '43' <> 1 THEN  '1' ELSE '0' END))  
              )
          AND (    ('1' = (CASE WHEN '1'=1 AND SUNAP_DT >=  '2024'   AND  ( NEW_GU_YR_G = '1' OR  SIGUMGO_HOIKYE_YR =9999 )  THEN  '1' ELSE '0' END))   
                OR ('1' = (CASE WHEN '1' IN(5,9) AND '4'<3 AND  SUNAP_DT >=  ('2024')-1 || '0301'   AND  NEW_GU_YR_G = '1'   THEN  '1' ELSE '0' END))  
                OR ('1' = (CASE WHEN '1' IN(5,9) AND '4'>=3 AND  SUNAP_DT >=  '2024'  || '0301' AND  NEW_GU_YR_G = '1'    THEN  '1' ELSE '0' END))   
                OR (     '1' = (CASE WHEN '1'=8 AND '4'<3 AND (((SUNAP_DT BETWEEN ('2024')-1 || '0100' AND ('2024')-1 || '1231')) AND NEW_GU_YR_G =  1) THEN  '1' ELSE '0' END)
                     OR  '1' = (CASE WHEN '1'=8 AND '4'<3 AND SUNAP_DT >= ('2024')-1 || '0301' AND NEW_GU_YR_G <> 1 THEN '1' ELSE '0' END))   
                OR ('1' = (CASE WHEN '1'=8 AND '4'>=3 AND (((SUNAP_DT>= '2024'  ||  '0301'  AND NEW_GU_YR_G <>  1)) ) THEN  '1' ELSE '0' END)) 
                OR ('1' = (CASE WHEN '1'=0 AND (((SUNAP_DT>= '2024'))) THEN  '1' ELSE '0' END))
                OR ('1' = (CASE WHEN '1'=7 AND  (((SUNAP_DT>= '2024'))) THEN  '1' ELSE '0' END))
              )
        GROUP BY ICH_SIGUMGO_GUN_GU_C   

        UNION ALL

       SELECT 9999 ICH_SIGUMGO_GUN_GU_C, 2 DATA_ROW,
              SUM(CASE WHEN  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE BAS_DT END) = '20240416'  THEN  BIZPLC_BAEJUNG_JI_AMT ELSE 0  END) 
              +SUM(CASE WHEN  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE BAS_DT END) = '20240416'  THEN  BIZPLC_GAM_BAEJUNG_IP_AMT ELSE 0  END) AMT1,  
              SUM(CASE WHEN  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE BAS_DT END) = '20240416' THEN TAXO_FUND_BAEJUNG_JI_AMT+TAXO_HNDO_BAEJUNG_JI_AMT+TAXO_FUND_GETBK_JI_AMT
                                                                                                               +TAXO_HNDO_JICHUL_JI_AMT+TAXO_HNDO_GETBK_JI_AMT ELSE 0 END) AMT2,
              SUM(CASE WHEN  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE BAS_DT END) = '20240416' THEN  TAXO_RTRN_AMT ELSE 0 END)*-1 AMT3,
              0 AMT4,  0 AMT5,  0 AMT6,  0 AMT7,  0 AMT8,  0 AMT9,  0 AMT10, 0 AMT11, 0 AMT12,
              SUM(CASE WHEN SIGUMGO_AC_B = 10 THEN  BIZPLC_BAEJUNG_JI_AMT ELSE 0 END) + SUM(BIZPLC_GAM_BAEJUNG_IP_AMT) AMT13,
              SUM(TAXO_FUND_BAEJUNG_JI_AMT+TAXO_HNDO_BAEJUNG_JI_AMT+TAXO_FUND_GETBK_JI_AMT+TAXO_HNDO_JICHUL_JI_AMT+TAXO_HNDO_GETBK_JI_AMT) AMT14,
              SUM(TAXO_RTRN_AMT)*-1 AMT15,
              SUM(CASE WHEN '4' < 3 AND '1'  = 1 AND '2024' < 2007 THEN  GA_IWOL_JI_AMT
                       WHEN '4' < 3 AND '1'  = 1 AND '2024' >=2007 THEN  GA_IWOL_JI_AMT-GA_IWOL_IP_AMT 
                       WHEN '4' < 3 AND '1' != 1 AND '2024' < 2007 AND (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END)  > '2024'  ||  '0100' THEN GA_IWOL_JI_AMT
                       WHEN '4' < 3 AND '1' != 1 AND '2024' >=2007 AND (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END)  > '2024'  ||  '0100' THEN GA_IWOL_JI_AMT-GA_IWOL_IP_AMT 
                       WHEN '4' >= 3 THEN 0
                  END) AMT16, 
              0 AMT17,    
              SUM(PMNY_JAN_MVO_AMT-PMNY_JAN_MVI_AMT) AMT18,
              0 AMT19, 0 AMT20, 0 AMT21, 0 AMT22, 0 AMT23, 0 AMT24,
              0 AMT25, 0 AMT26, 0 AMT27, 0 AMT28
         FROM RPT_TXIO_DDAC_TAB A   
        WHERE 1=1
          AND A.SIGUMGO_ORG_C  = '28'
          AND (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) BETWEEN SUBSTR('202401',0,4) || '0101' AND '20240416'
          AND A.ICH_SIGUMGO_HOIKYE_C = '43'   
          AND ( ( '43' IN (21,22) AND ICH_SIGUMGO_GUN_GU_C = 0) OR  ( '43' = 1  AND ICH_SIGUMGO_GUN_GU_C <> 0) OR ( '43' NOT IN (1, 21,22) )) 
          AND ICH_SIGUMGO_GUN_GU_C LIKE '' || '%' 
          AND (    ('1' = (CASE WHEN '1' = 1 AND (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) >= '2024' AND (NEW_GU_YR_G ='1' OR SIGUMGO_HOIKYE_YR= 9999 ) THEN  '1' ELSE '0' END))   
                OR ('1' = (CASE WHEN '1' IN (5,9) AND '4' <3  AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) >= ('2024')-1 || '0301' AND NEW_GU_YR_G ='1'  THEN  '1' ELSE '0' END))   
                OR ('1' = (CASE WHEN '1' IN (5,9) AND '4' >=3  AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) >= '2024' || '0301'  AND NEW_GU_YR_G ='1'  THEN  '1' ELSE '0' END))   
                OR (    ('1' = (CASE WHEN '1' = 8 AND '4' <3  AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) BETWEEN ('2024')-1 || '0100' AND ('2024')-1 || '1231' AND NEW_GU_YR_G = '1'  THEN  '1' ELSE '0' END))   
                     OR ('1' = (CASE WHEN '1' = 8 AND '4' <3  AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) >= ('2024')-1 || '0301'  AND NEW_GU_YR_G <> '1'  THEN  '1' ELSE '0' END)))
                OR ('1' = (CASE WHEN '1' = 8 AND '4' >=3  AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) >= '2024'  ||  '0301'  AND NEW_GU_YR_G <> '1'  THEN  '1' ELSE '0' END))   
                OR ('1' = (CASE WHEN '1' = 0 AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) >= '2024' THEN  '1' ELSE '0' END))   
                OR ('1' = (CASE WHEN '1' = 7 AND '4' <3  AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) >= '2024' THEN  '1' ELSE '0' END))   
                OR ('1' = (CASE WHEN '1' = 7 AND '4' >=3  AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) >= '2024' AND NEW_GU_YR_G =1 THEN  '1' ELSE '0' END))   
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
         AND A.ICH_SIGUMGO_HOIKYE_C = '43'
         AND ( ( '43' IN (21,22) AND ICH_SIGUMGO_GUN_GU_C = 0) OR  ( '43' = 1  AND ICH_SIGUMGO_GUN_GU_C <> 0) OR ( '43' NOT IN (1, 21,22) )) 
         AND ICH_SIGUMGO_GUN_GU_C LIKE '' || '%' 
         AND (   (    ('1' = (CASE WHEN '4' < 3  AND '43' IN(1,30) AND '1' IN(0,7) AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) <  SUBSTR('20240416',0,4) || '0100' THEN  '1' ELSE '0' END))   
                   OR ('1' = (CASE WHEN '4' < 3  AND '43' IN(1,30) AND '1' IN(0,7) AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) BETWEEN SUBSTR('20240416',0,4) || '0100' AND '20240416'  AND  NEW_GU_YR_G = 9  THEN  '1' ELSE '0' END)) 
                   OR ('1' = (CASE WHEN '4' < 3  AND '43' IN(1,30) AND '1' IN(0,7) AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) BETWEEN SUBSTR('20240416',0,4) || '0100' AND '20240416' AND (NEW_GU_YR_G = 1 OR SIGUMGO_HOIKYE_YR = 9999)  THEN  '1' ELSE '0' END)) 
                 )   
              OR ('1' = (CASE WHEN '4' < 3  AND '43' IN(1,30) AND '1' = 1 AND (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) BETWEEN SUBSTR('20240416',0,4) || '0100' AND '20240416'  THEN  '1' ELSE '0' END))   
              OR ('1' = (CASE WHEN '4' < 3  AND '43' IN(1,30) AND '1' = 5 AND NEW_GU_YR_G = 5 THEN  '1' ELSE '0' END))   
              OR (    ('1' = (CASE WHEN '4' < 3  AND '43' IN(1,30) AND '1' IN(8,9) AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) <  SUBSTR('20240416',0,4) || '0100' THEN  '1' ELSE '0' END))   
                   OR ('1' = (CASE WHEN '4' < 3  AND '43' IN(1,30) AND '1' IN(8,9) AND  (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) BETWEEN SUBSTR('20240416',0,4) || '0100' AND '20240416'  AND  NEW_GU_YR_G = 9  THEN  '1' ELSE '0' END)) 
                 )   
              OR ('1' = (CASE WHEN '43'  = 23  AND (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) BETWEEN '20061231' AND '20240416' THEN  '1' ELSE '0' END))   
              OR ('1' = (CASE WHEN ('43' NOT IN(1,23,30) OR ('4' >= 3 AND '43' IN(1,30))) AND (CASE WHEN BAS_DT > TRIM(GISDT) THEN TRIM(GISDT)  ELSE  BAS_DT END) <= '20240416' THEN  '1' ELSE '0' END))   
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


 select * from ACL_SIGUMGO_MAS
 where mng_no = 1
 and SIGUMGO_ORG_C = 28
 and ICH_SIGUMGO_HOIKYE_C = 43



 SELECT RNUM
     , SGG_ACNO
     , SGG_ACNO_NM
     , SIDO_C
     , CT_GU_C
     , SL_GMGO_HOIKYE_C
     , DTL_HOIKYE_C
     , DTL_HOIKYE_C_NM
     , SITAX_GUTAX_G
     , SITAX_GUTAX_G_NM
     , SIGUMGO_AC_G
     , HOIKYE_YEAR
     , GIGUM_YN
     , USE_G
     , ORG_C
     , ORG_C_NM
     , SL_GMGO_DEPT_C
     , SL_GMGO_DEPT_NM
     , SL_GMGO_DEPT_C AS ORG_SL_GMGO_DEPT_C
     , GUCHUNG_BIZPLC_C
     , GIGUM_USER_IDS
     , GIGUM_USER_NMS
     , BIGO
     , MG_DT
     , TOT_CNT
FROM
(
    WITH AC_BY_DEPT AS
    (
        SELECT DISTINCT ADM.SGG_ACNO, ADM.SITAX_GUTAX_G, HCD.SIGUMGO_HOIKYE_C, HCD.HOIKYE_NM
        FROM RPT_JEONJA_AC_BY_DEPT_MNG ADM
        INNER JOIN RPT_HOIKYE_CD HCD
                ON ADM.SL_GMGO_HOIKYE_C = HCD.SIGUMGO_HOIKYE_C
               AND ADM.GEUMGO_CODE = HCD.SIGUMGO_C
        WHERE ('all' = 'all' OR ADM.SITAX_GUTAX_G = 'all')
          AND ('all' = '1' OR ADM.USE_G = '1')
          AND (ADM.HOIKYE_YEAR = '2024' OR ADM.HOIKYE_YEAR = '9999')
          AND ADM.SL_GMGO_DEPT_C = '9999999'
    )
    SELECT ADM.RNUM
         , ADM.SGG_ACNO
         , ADM.SIGUMGO_AC_NM AS SGG_ACNO_NM
         , ADM.SIDO_C
         , LPAD(ADM.SIGUMGO_GUN_GU_C,3,'0') AS CT_GU_C
         , LPAD(ADM.SIGUMGO_HOIKYE_C,2,'0') AS SL_GMGO_HOIKYE_C
         , '' AS DTL_HOIKYE_C
         , ADM.HOIKYE_NM AS DTL_HOIKYE_C_NM
         , ADM.SITAX_GUTAX_G
         , NVL((SELECT CMM_DTL_C_NM FROM SFI_CMM_C_DAT WHERE CMM_C_NM='시세구세구분' AND CMM_DTL_C = ADM.SITAX_GUTAX_G),'기타') AS SITAX_GUTAX_G_NM
         , ADM.SIGUMGO_AC_G
         , ADM.SIGUMGO_HOIKYE_YR AS HOIKYE_YEAR
         , DECODE(ADM.OCR_HOIKYE_G, '4', 'Y', 'N') AS GIGUM_YN
         , ADM.USE_G
         , ADM.PADM_STD_ORG_C AS ORG_C
         , ADM.PADM_STD_ORGNM AS ORG_C_NM
         , ADM.SL_GMGO_DEPT_C AS SL_GMGO_DEPT_C
         , CASE WHEN ADM.SL_GMGO_DEPT_C = ADM.PADM_STD_ORG_C THEN ADM.PADM_STD_ORGNM
                ELSE TRIM(REPLACE(POI.ALL_ORGNM, OPOI.ALL_ORGNM, ''))
                END AS SL_GMGO_DEPT_NM
         , ADM.GUCHUNG_BIZPLC_C
         , '' AS GIGUM_USER_IDS
         , '' AS GIGUM_USER_NMS
         , ADM.BIGO
         , POI.MG_DT
         , ADM.TOT_CNT
    FROM
    (
        SELECT A.*
        FROM
        (
            SELECT ROWNUM AS RNUM
                 , A.*
            FROM
            (
                SELECT ADM.SGG_ACNO
                     , SGM.SIGUMGO_AC_NM
                     , ADM.SIDO_C
                     , SGM.SIGUMGO_GUN_GU_C
                     , SGM.SIGUMGO_HOIKYE_C
                     , ABD.HOIKYE_NM
                     , '' AS SIGUMGO_HOIKYE_NO
                     , SGM.SIGUMGO_AC_G
                     , SGM.SIGUMGO_HOIKYE_YR
                     , ABD.SITAX_GUTAX_G
                     , '' AS OCR_HOIKYE_G
                     , ADM.USE_G
                     , OCM.PADM_STD_ORG_C
                     , OCM.PADM_STD_ORGNM
                     , ADM.SL_GMGO_DEPT_C
                     , ADM.GUCHUNG_BIZPLC_C
                     , ADM.BIGO
                     , COUNT(1) OVER () AS TOT_CNT
                FROM RPT_JEONJA_AC_BY_DEPT_MNG ADM
                INNER JOIN AC_BY_DEPT ABD
                        ON ADM.SGG_ACNO = ABD.SGG_ACNO
                INNER JOIN ACL_SIGUMGO_MAS_SUB SGM
                        ON SGM.SIGUMGO_ORG_C = '42'
                       AND ADM.SGG_ACNO = SGM.SIGUMGO_ACNO
                LEFT OUTER JOIN SFI_ORG_BY_DEPT_MNG OBD
                        ON ADM.SL_GMGO_DEPT_C = OBD.G_CC_DEPT_C
                LEFT OUTER JOIN SFI_ORG_DEPT_C_MNG OCM
                        ON OBD.PADM_STD_ORG_C = OCM.PADM_STD_ORG_C
                WHERE (-1 = -1 OR SGM.SIGUMGO_AC_B = -1)
                  AND ('' IS NULL OR REGEXP_LIKE(SGM.SIGUMGO_ACNO, ''))
                  AND ('' IS NULL OR REGEXP_LIKE(SGM.SIGUMGO_AC_NM, ''))
                ORDER BY ADM.SGG_ACNO, OCM.CT_GU_C, ADM.SL_GMGO_DEPT_C
            ) A
            WHERE ROWNUM <= '2000'
        ) A
        WHERE RNUM >= '1'
    ) ADM
    LEFT OUTER JOIN SFI_PADM_ORG_INF OPOI
            ON ADM.PADM_STD_ORG_C = OPOI.PADM_STD_ORG_C
    LEFT OUTER JOIN SFI_PADM_ORG_INF POI
            ON ADM.SL_GMGO_DEPT_C = POI.PADM_STD_ORG_C
)
ORDER BY RNUM



SELECT 
      Z.ROW_NUM,
      Z.SIGUMGO_ORG_C,
      Z.ICH_SIGUMGO_GUN_GU_C,
      Z.ICH_SIGUMGO_HOIKYE_C,
      Z.SIGUMGO_HOIKYE_C,
      Z.SIGUMGO_AC_B,
      Z.SIGUMGO_AC_SER,
      Z.SIGUMGO_HOIKYE_YR,
      Z.GONGGEUM_GYEJWA,
      Z.GONGGEUM_YUDONG_ACNO,
      Z.AC_GRBRNO,
      Z.HNG_BR_NM,
      Z.SIGUMGO_AC_NM,
      Z.UPD_DTTM,
      Z.MODR_ID

FROM
      (
        SELECT 
              ROW_NUMBER() OVER(ORDER BY X.GONGGEUM_GYEJWA) AS ROW_NUM,
              X.SIGUMGO_ORG_C,
              X.ICH_SIGUMGO_GUN_GU_C,
              X.ICH_SIGUMGO_HOIKYE_C,
              Y.SIGUMGO_HOIKYE_C,
              X.SIGUMGO_AC_B,
              X.SIGUMGO_AC_SER,
              X.SIGUMGO_HOIKYE_YR,
              X.GONGGEUM_GYEJWA,
              X.GONGGEUM_YUDONG_ACNO,
              X.AC_GRBRNO,
              X.HNG_BR_NM,
              X.SIGUMGO_AC_NM,
              Y.UPD_DTTM,
              Y.MODR_ID
        FROM
              (
                SELECT  
                      A.SIGUMGO_ORG_C,
                      A.ICH_SIGUMGO_GUN_GU_C,
                      A.ICH_SIGUMGO_HOIKYE_C,
                      A.SIGUMGO_AC_B,
                      A.SIGUMGO_AC_SER,
                      A.SIGUMGO_HOIKYE_YR,
                      LPAD(A.SIGUMGO_ORG_C, 3, '0')||
                      LPAD(A.ICH_SIGUMGO_GUN_GU_C, 3, '0')||
                      LPAD(A.ICH_SIGUMGO_HOIKYE_C, 2, '0')||
                      LPAD(A.SIGUMGO_AC_B, 2, '0')||
                      LPAD(A.SIGUMGO_AC_SER, 5, '0')||
                      SUBSTR(A.SIGUMGO_HOIKYE_YR, 3, 2) AS GONGGEUM_GYEJWA,
                      A.LINKAC_KWA_C ||'000'||A.LINK_ACSER AS GONGGEUM_YUDONG_ACNO,
                      A.AC_GRBRNO,
                      B.HNG_BR_NM,
                      A.SIGUMGO_AC_NM,
                      A.UPD_DTTM,
                      A.MODR_ID
                FROM 
                      ACL_SIGUMGO_MAS A
                      LEFT OUTER JOIN CST_JUM B
                        ON A.AC_GRBRNO = B.BRNO
                        AND B.GRPCO_C = 'S001'
                WHERE
                      A.SIGUMGO_ORG_C = 42
                      AND A.SIGUMGO_HOIKYE_YR IN ('2024','9999')
                      AND A.MNG_NO = '1'
                      AND (-1 = -1 OR A.ICH_SIGUMGO_GUN_GU_C = -1)
                      AND (-1 = -1 OR A.SIGUMGO_AC_B = -1)
                      AND (-1 = -1 OR A.AC_GRBRNO = -1)
                      AND (-1 = 80 OR A.ICH_SIGUMGO_HOIKYE_C = 80)
              ) X
              LEFT OUTER JOIN RPT_AC_BY_HOIKYE_MAPP Y
                  ON X.SIGUMGO_ORG_C = Y.SIGUMGO_C 
                  AND X.SIGUMGO_HOIKYE_YR = Y.SIGUMGO_HOIKYE_YR
                  AND X.GONGGEUM_GYEJWA = Y.SIGUMGO_ACNO
             WHERE 1 = 1
                   AND (-1 = -1 OR Y.SIGUMGO_HOIKYE_C = -1)
      ) Z
WHERE
      Z.ROW_NUM >= 0
      AND Z.ROW_NUM <= 100