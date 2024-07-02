-- =========================== XDA ID:[tom.kwd.rpt.xda.xSelectListKWD130301By01]===============================

SELECT 
  BB.SIGUMGO_HOIKYE_C HOIGYE_CODE,
  BB.HOIKYE_NM NUGYE_HOIGYE_NAME,
  NVL(SUM(NUGYE_SEIB_SUIP),0) AS NUGYE_SEIB_SUIP,      
  NVL(SUM(NUGYE_SEIB_BANNAB),0) AS NUGYE_SEIB_BANNAB,
  NVL(SUM(NUGYE_SEIB_GYEONGJEONG_IB),0) AS NUGYE_SEIB_GYEONGJEONG_IB,
  NVL(SUM(NUGYE_SEIB_GYEONGJEONG_JI)*-1,0) AS NUGYE_SEIB_GYEONGJEONG_JI,
  ABS(NVL(SUM(NUGYE_SECHUL_BAEJEONG),0)) AS NUGYE_SECHUL_BAEJEONG,
  NVL(SUM(NUGYE_SECHUL_HWANSU),0) AS NUGYE_SECHUL_HWANSU,
  NVL(SUM(NUGYE_SECHUL_JI),0) AS  NUGYE_SECHUL_JI,
  NVL(SUM(NUGYE_SECHUL_BANNAB)*-1,0) AS NUGYE_SECHUL_BANNAB,
  NVL(SUM(NUGYE_SECHUL_GYEONGJEONG_IB),0) AS NUGYE_SECHUL_GYEONGJEONG_IB,
  NVL(SUM(NUGYE_SECHUL_GYEONGJEONG_JI),0) AS NUGYE_SECHUL_GYEONGJEONG_JI,
  NVL(SUM(NUGYE_SEIB_GYULSANBF_IIB),0) AS NUGYE_SEIB_GYULSANBF_IIB,
  NVL(SUM(NUGYE_SECHUL_GYULSANBF_IWOL),0) AS NUGYE_SECHUL_GYULSANBF_IWOL,
  NVL(SUM(NUGYE_DEP),0) AS NUGYE_DEP,
  NVL(SUM(NUGYE_MIICHE),0) AS NUGYE_MIICHE,  
  NVL(SUM(NUGYE_YEKEUM_HEAJI),0) AS NUGYE_YEKEUM_HEAJI,
  NVL(SUM(ILGYE_SEIB_SUIP),0) AS ILGYE_SEIB_SUIP,        
  NVL(SUM(ILGYE_SEIB_BANNAB),0) AS ILGYE_SEIB_BANNAB,
  NVL(SUM(ILGYE_SEIB_GYEONGJEONG_IB),0) AS ILGYE_SEIB_GYEONGJEONG_IB,
  NVL(SUM(ILGYE_SEIB_GYEONGJEONG_JI)*-1,0) AS ILGYE_SEIB_GYEONGJEONG_JI,
  ABS(NVL(SUM(ILGYE_SECHUL_BAEJEONG),0)) AS ILGYE_SECHUL_BAEJEONG,
  NVL(SUM(ILGYE_SECHUL_HWANSU),0) AS ILGYE_SECHUL_HWANSU,
  NVL(SUM(ILGYE_SECHUL_JI),0) AS  ILGYE_SECHUL_JI,
  NVL(SUM(ILGYE_SECHUL_BANNAB)*-1,0) AS ILGYE_SECHUL_BANNAB,
  NVL(SUM(ILGYE_SECHUL_GYEONGJEONG_IB),0) AS ILGYE_SECHUL_GYEONGJEONG_IB,
  NVL(SUM(ILGYE_SECHUL_GYEONGJEONG_JI),0) AS ILGYE_SECHUL_GYEONGJEONG_JI,
  NVL(SUM(ILGYE_SEIB_GYULSANBF_IIB),0) AS ILGYE_SEIB_GYULSANBF_IIB,
  NVL(SUM(ILGYE_SECHUL_GYULSANBF_IWOL),0) AS ILGYE_SECHUL_GYULSANBF_IWOL,
  NVL(SUM(ILGYE_DEP),0)AS ILGYE_DEP,
  NVL(SUM(ILGYE_MIICHE),0) AS ILGYE_MIICHE,
  NVL(SUM(ILGYE_YEKEUM_HEAJI),0) AS ILGYE_YEKEUM_HEAJI
FROM
(
       SELECT  
     '42' SIGUMGO_C,
     HOIGYE_CODE,     
     0 AS NUGYE_SEIB_SUIP,                                                                                                
     0 AS NUGYE_SEIB_BANNAB,
     0 AS NUGYE_SEIB_GYEONGJEONG_IB,
     0 AS NUGYE_SEIB_GYEONGJEONG_JI,                                                  
     0 AS NUGYE_SECHUL_BAEJEONG,
     0 AS NUGYE_SECHUL_HWANSU,
     0 AS NUGYE_SECHUL_JI,
     0 AS NUGYE_SECHUL_BANNAB,
     0 AS NUGYE_SECHUL_GYEONGJEONG_IB,
     0 AS NUGYE_SECHUL_GYEONGJEONG_JI,
     0 AS NUGYE_SEIB_GYULSANBF_IIB,
     0 AS NUGYE_SECHUL_GYULSANBF_IWOL,
     0  AS NUGYE_DEP,
     0 AS NUGYE_MIICHE,
     0 AS NUGYE_YEKEUM_HEAJI,
     NVL(TAX_IP_SUIB_AMT,0)+NVL(IWOL_GONGGEUM_DEP,0) AS ILGYE_SEIB_SUIP,                                                                                                
     NVL(GWAON_PROC_JI_AMT,0) AS ILGYE_SEIB_BANNAB,
     NVL(TAX_IP_CRT_IP_AMT,0) AS ILGYE_SEIB_GYEONGJEONG_IB,
     NVL(TAX_IP_CRT_JI_AMT,0) AS ILGYE_SEIB_GYEONGJEONG_JI,                                                  
     NVL(BIZPLC_BAEJUNG_IP_AMT,0) AS ILGYE_SECHUL_BAEJEONG,
     NVL(BIZPLC_BAEJUNG_JI_AMT,0) AS ILGYE_SECHUL_HWANSU,
     NVL(TAXO_JI_AMT,0) AS ILGYE_SECHUL_JI,
     NVL(TAXO_RTRN_AMT,0) AS ILGYE_SECHUL_BANNAB,
     NVL(KWA_CRRC_IP_AMT,0) AS ILGYE_SECHUL_GYEONGJEONG_IB,
     NVL(KWA_CRRC_JI_AMT,0) AS ILGYE_SECHUL_GYEONGJEONG_JI,
     NVL(GA_IWOL_IP_AMT,0) AS ILGYE_SEIB_GYULSANBF_IIB,
     NVL(GA_IWOL_JI_AMT,0) AS ILGYE_SECHUL_GYULSANBF_IWOL,
     NVL(DEP_MK_JI_AMT+IWOL_DANGHANG_JAGUM,0)  AS ILGYE_DEP,
     NVL(MR_FUND_AMT+IWOL_MMDA,0) AS ILGYE_MIICHE,
     NVL(DEP_HJI_AMT,0) AS ILGYE_YEKEUM_HEAJI     
  FROM
  (
   SELECT   
       C.SIGUMGO_HOIKYE_C AS HOIGYE_CODE    
      ,SUM(TAX_IP_SUIB_AMT) AS TAX_IP_SUIB_AMT         
      ,SUM(GWAON_PROC_JI_AMT) AS GWAON_PROC_JI_AMT      
      ,SUM(TAX_IP_CRT_IP_AMT) AS TAX_IP_CRT_IP_AMT        
      ,SUM(TAX_IP_CRT_JI_AMT) AS TAX_IP_CRT_JI_AMT        
      ,SUM(GAM_BAEJUNG_JI_AMT) 
      +SUM(BIZPLC_BAEJUNG_JI_AMT)
      +SUM(JICULWO_BAEJUNG_JI_AMT)  AS BIZPLC_BAEJUNG_JI_AMT 
      ,SUM(BIZPLC_GAM_BAEJUNG_IP_AMT) 
      +SUM(JICULWO_GAM_BAEJUNG_IP_AMT)
      +SUM(SUIP_CHULNAP_BAEJUNG_AMT)
      +SUM(FUND_UNYONG_INT_AMT)
      +SUM(PMNY_DEP_INT_AMT)
      +SUM(BTDEP_INT_AMT) AS  BIZPLC_BAEJUNG_IP_AMT      
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
      ,SUM(DEP_HJI_AMT) AS DEP_HJI_AMT           
      ,SUM(MR_FUND_IP_AMT+MR_FUND_JI_AMT) AS MR_FUND_AMT   
      ,0 IWOL_GONGGEUM_DEP
      ,0 IWOL_DANGHANG_JAGUM
      ,0 IWOL_MMDA
   FROM RPT_TXIO_DDAC_TAB A, ACL_SIGUMGO_MAS  B, RPT_AC_BY_HOIKYE_MAPP C
   WHERE  A.SGG_ACNO = B.FIL_100_CTNT2
   AND A.ICH_SIGUMGO_HOIKYE_C = B.ICH_SIGUMGO_HOIKYE_C
   AND A.SIGUMGO_ORG_C = B.SIGUMGO_ORG_C  
   AND B.FIL_100_CTNT2 = C.SIGUMGO_ACNO(+)
   AND B.SIGUMGO_HOIKYE_YR = C.SIGUMGO_HOIKYE_YR(+)
   AND B.SIGUMGO_ORG_C = C.SIGUMGO_C(+)    
   AND A.ICH_SIGUMGO_GUN_GU_C = '0'   
    AND CASE WHEN A.SIGUMGO_HOIKYE_YR = 9999 THEN TO_NUMBER(SUBSTR(A.BAS_DT,1,4))
                   ELSE TO_NUMBER(A.SIGUMGO_HOIKYE_YR) END  = '2024'
   AND A.BAS_DT BETWEEN '20240620' AND '20240620' 
    AND A.SIGUMGO_ORG_C  = '42'
    AND B.MNG_NO = 1
    GROUP BY C.SIGUMGO_HOIKYE_C
UNION ALL 
         SELECT  TO_CHAR(HOIGYE_CODE) HOIGYE_CODE,     
     0,                                                               
     0,                                                               
     0,                                                               
     0,                                                               
     0,                                                               
     0,                                                               
     0,                                                               
     0,                                                               
     0,                                                               
     0,                                                               
     0,                                                               
     0,                                                               
     0,                                                               
     0,                                                               
     0,                                                               
     SUM(CASE WHEN GUBUN_CODE = 1 THEN AMT1 ELSE 0 END),                   
     SUM(CASE WHEN GUBUN_CODE = 2 THEN AMT1 ELSE 0 END),                   
     SUM(CASE WHEN GUBUN_CODE = 4 THEN AMT1 ELSE 0 END)                    
         FROM   RPT_HOIGYE_IWOL A
         WHERE  1=1
         AND A.HOIGYE_YEAR = ( '2024' - 1 ) 
         AND A.GEUMGO_CODE = '42'            
         AND A.GUBUN_CODE IN (1, 2, 4)         
           AND A.KIJUNIL BETWEEN '20240620' AND '20240620'    
         AND A.GUNGU_CODE = 0             
         GROUP BY HOIGYE_CODE
 )
UNION ALL
 SELECT    
      '42' SIGUMGO_C,
     HOIGYE_CODE,     
     NVL(TAX_IP_SUIB_AMT,0)+NVL(IWOL_GONGGEUM_DEP,0) AS NUGYE_SEIB_SUIP,                                                                                                
     NVL(GWAON_PROC_JI_AMT,0) AS NUGYE_SEIB_BANNAB,
     NVL(TAX_IP_CRT_IP_AMT,0) AS NUGYE_SEIB_GYEONGJEONG_IB,
     NVL(TAX_IP_CRT_JI_AMT,0) AS NUGYE_SEIB_GYEONGJEONG_JI,                                                  
     NVL(BIZPLC_BAEJUNG_IP_AMT,0) AS NUGYE_SECHUL_BAEJEONG,
     NVL(BIZPLC_BAEJUNG_JI_AMT,0) AS NUGYE_SECHUL_HWANSU,
     NVL(TAXO_JI_AMT,0) AS NUGYE_SECHUL_JI,
     NVL(TAXO_RTRN_AMT,0) AS NUGYE_SECHUL_BANNAB,
     NVL(KWA_CRRC_IP_AMT,0) AS NUGYE_SECHUL_GYEONGJEONG_IB,
     NVL(KWA_CRRC_JI_AMT,0) AS NUGYE_SECHUL_GYEONGJEONG_JI,
     NVL(GA_IWOL_IP_AMT,0) AS NUGYE_SEIB_GYULSANBF_IIB,
     NVL(GA_IWOL_JI_AMT,0) AS NUGYE_SECHUL_GYULSANBF_IWOL,
     NVL(DEP_MK_JI_AMT+IWOL_DANGHANG_JAGUM,0)  AS NUGYE_DEP,
     NVL(MR_FUND_AMT+IWOL_MMDA,0) AS NUGYE_MIICHE,
     NVL(DEP_HJI_AMT,0) AS NUGYE_YEKEUM_HEAJI,
     0 AS NUGYE_SEIB_SUIP,                                                                                               
     0 AS NUGYE_SEIB_BANNAB,
     0 AS NUGYE_SEIB_GYEONGJEONG_IB,
     0 AS NUGYE_SEIB_GYEONGJEONG_JI,                                                  
     0 AS NUGYE_SECHUL_BAEJEONG,
     0 AS NUGYE_SECHUL_HWANSU,
     0 AS NUGYE_SECHUL_JI,
     0 AS NUGYE_SECHUL_BANNAB,
     0 AS NUGYE_SECHUL_GYEONGJEONG_IB,
     0 AS NUGYE_SECHUL_GYEONGJEONG_JI,
     0 AS NUGYE_SEIB_GYULSANBF_IIB,
     0 AS NUGYE_SECHUL_GYULSANBF_IWOL,
     0 AS NUGYE_DEP,
     0 AS NUGYE_MIICHE,
     0 AS NUGYE_YEKEUM_HEAJI
 FROM
 (
  SELECT   
      C.SIGUMGO_HOIKYE_C AS HOIGYE_CODE     
     ,SUM(TAX_IP_SUIB_AMT) AS TAX_IP_SUIB_AMT         
     ,SUM(GWAON_PROC_JI_AMT) AS GWAON_PROC_JI_AMT      
     ,SUM(TAX_IP_CRT_IP_AMT) AS TAX_IP_CRT_IP_AMT        
     ,SUM(TAX_IP_CRT_JI_AMT) AS TAX_IP_CRT_JI_AMT        
      ,SUM(GAM_BAEJUNG_JI_AMT) 
      +SUM(BIZPLC_BAEJUNG_JI_AMT)
      +SUM(JICULWO_BAEJUNG_JI_AMT)  AS BIZPLC_BAEJUNG_JI_AMT   
     ,SUM(BIZPLC_GAM_BAEJUNG_IP_AMT) 
     +SUM(JICULWO_GAM_BAEJUNG_IP_AMT)
     +SUM(SUIP_CHULNAP_BAEJUNG_AMT)
     +SUM(FUND_UNYONG_INT_AMT)
     +SUM(PMNY_DEP_INT_AMT)
     +SUM(BTDEP_INT_AMT) AS  BIZPLC_BAEJUNG_IP_AMT       
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
     ,SUM(DEP_HJI_AMT) AS DEP_HJI_AMT           
     ,SUM(MR_FUND_IP_AMT+MR_FUND_JI_AMT) AS MR_FUND_AMT   
     ,0 IWOL_GONGGEUM_DEP
     ,0 IWOL_DANGHANG_JAGUM
     ,0 IWOL_MMDA
  FROM RPT_TXIO_DDAC_TAB A, ACL_SIGUMGO_MAS  B, RPT_AC_BY_HOIKYE_MAPP C
  WHERE  A.SGG_ACNO = B.FIL_100_CTNT2
  AND A.ICH_SIGUMGO_HOIKYE_C = B.ICH_SIGUMGO_HOIKYE_C
  AND A.SIGUMGO_ORG_C = B.SIGUMGO_ORG_C  
  AND B.FIL_100_CTNT2 = C.SIGUMGO_ACNO(+)
  AND B.SIGUMGO_HOIKYE_YR = C.SIGUMGO_HOIKYE_YR(+)
  AND B.SIGUMGO_ORG_C = C.SIGUMGO_C(+)  
  AND A.ICH_SIGUMGO_GUN_GU_C = '0'  
    AND CASE WHEN A.SIGUMGO_HOIKYE_YR = 9999 THEN TO_NUMBER(SUBSTR(A.BAS_DT,1,4))
                   ELSE TO_NUMBER(A.SIGUMGO_HOIKYE_YR) END  = '2024'
  AND A.BAS_DT BETWEEN SUBSTR('20240101',0,4)||'0101' AND '20240620'
  AND A.SIGUMGO_ORG_C(+) = '42'
  AND B.MNG_NO = 1
  GROUP BY C.SIGUMGO_HOIKYE_C
UNION ALL 
  SELECT  TO_CHAR(HOIGYE_CODE) HOIGYE_CODE,    
    0,                                                               
    0,                                                               
    0,                                                               
    0,                                                               
    0,                                                               
    0,                                                               
    0,                                                               
    0,                                                               
    0,                                                               
    0,                                                               
    0,                                                               
    0,                                                               
    0,                                                               
    0,                                                               
    0,                                                               
    SUM(CASE WHEN GUBUN_CODE = 1 THEN AMT1 ELSE 0 END),                   
    SUM(CASE WHEN GUBUN_CODE = 2 THEN AMT1 ELSE 0 END),                   
    SUM(CASE WHEN GUBUN_CODE = 4 THEN AMT1 ELSE 0 END)                    
    FROM   RPT_HOIGYE_IWOL A
   WHERE  1=1
     AND  A.HOIGYE_YEAR = ( '2024' - 1 ) 
     AND A.GEUMGO_CODE = '42'
     AND A.GUBUN_CODE IN (1, 2, 4)
     AND A.KIJUNIL BETWEEN SUBSTR('20240101',0,4)||'0101' AND '20240620'
     AND A.GUNGU_CODE = 0 
     GROUP BY HOIGYE_CODE
 )
) AA, RPT_HOIKYE_CD BB
WHERE 1=1
AND AA.SIGUMGO_C(+) = BB.SIGUMGO_C
AND AA.HOIGYE_CODE(+) = BB.SIGUMGO_HOIKYE_C
AND BB.USE_YN = 'Y'
AND BB.SIGUMGO_C = '42'
  AND BB.SIGUMGO_HOIKYE_C IN ( 
      
       '41'
       
         )
   
GROUP BY BB.SIGUMGO_HOIKYE_C, BB.HOIKYE_NM
ORDER BY HOIGYE_CODE 

-- ============================================================================================

SELECT    
      '42' SIGUMGO_C,
     HOIGYE_CODE,     
     NVL(TAX_IP_SUIB_AMT,0)+NVL(IWOL_GONGGEUM_DEP,0) AS NUGYE_SEIB_SUIP,                                                                                                
     NVL(GWAON_PROC_JI_AMT,0) AS NUGYE_SEIB_BANNAB,
     NVL(TAX_IP_CRT_IP_AMT,0) AS NUGYE_SEIB_GYEONGJEONG_IB,
     NVL(TAX_IP_CRT_JI_AMT,0) AS NUGYE_SEIB_GYEONGJEONG_JI,                                                  
     NVL(BIZPLC_BAEJUNG_IP_AMT,0) AS NUGYE_SECHUL_BAEJEONG,
     NVL(BIZPLC_BAEJUNG_JI_AMT,0) AS NUGYE_SECHUL_HWANSU,
     NVL(TAXO_JI_AMT,0) AS NUGYE_SECHUL_JI,
     NVL(TAXO_RTRN_AMT,0) AS NUGYE_SECHUL_BANNAB,
     NVL(KWA_CRRC_IP_AMT,0) AS NUGYE_SECHUL_GYEONGJEONG_IB,
     NVL(KWA_CRRC_JI_AMT,0) AS NUGYE_SECHUL_GYEONGJEONG_JI,
     NVL(GA_IWOL_IP_AMT,0) AS NUGYE_SEIB_GYULSANBF_IIB,
     NVL(GA_IWOL_JI_AMT,0) AS NUGYE_SECHUL_GYULSANBF_IWOL,
     NVL(DEP_MK_JI_AMT+IWOL_DANGHANG_JAGUM,0)  AS NUGYE_DEP,
     NVL(MR_FUND_AMT+IWOL_MMDA,0) AS NUGYE_MIICHE,
     NVL(DEP_HJI_AMT,0) AS NUGYE_YEKEUM_HEAJI
 FROM
 (
  SELECT   
      C.SIGUMGO_HOIKYE_C AS HOIGYE_CODE     
     ,SUM(TAX_IP_SUIB_AMT) AS TAX_IP_SUIB_AMT         
     ,SUM(GWAON_PROC_JI_AMT) AS GWAON_PROC_JI_AMT      
     ,SUM(TAX_IP_CRT_IP_AMT) AS TAX_IP_CRT_IP_AMT        
     ,SUM(TAX_IP_CRT_JI_AMT) AS TAX_IP_CRT_JI_AMT        
      ,SUM(GAM_BAEJUNG_JI_AMT) 
      +SUM(BIZPLC_BAEJUNG_JI_AMT)
      +SUM(JICULWO_BAEJUNG_JI_AMT)  AS BIZPLC_BAEJUNG_JI_AMT   
     ,SUM(BIZPLC_GAM_BAEJUNG_IP_AMT) 
     +SUM(JICULWO_GAM_BAEJUNG_IP_AMT)
     +SUM(SUIP_CHULNAP_BAEJUNG_AMT)
     +SUM(FUND_UNYONG_INT_AMT)
     +SUM(PMNY_DEP_INT_AMT)
     +SUM(BTDEP_INT_AMT) AS  BIZPLC_BAEJUNG_IP_AMT       
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
     ,SUM(DEP_HJI_AMT) AS DEP_HJI_AMT           
     ,SUM(MR_FUND_IP_AMT+MR_FUND_JI_AMT) AS MR_FUND_AMT   
     ,0 IWOL_GONGGEUM_DEP
     ,0 IWOL_DANGHANG_JAGUM
     ,0 IWOL_MMDA
  FROM RPT_TXIO_DDAC_TAB A, ACL_SIGUMGO_MAS  B, RPT_AC_BY_HOIKYE_MAPP C
  WHERE  A.SGG_ACNO = B.FIL_100_CTNT2
  AND A.ICH_SIGUMGO_HOIKYE_C = B.ICH_SIGUMGO_HOIKYE_C
  AND A.SIGUMGO_ORG_C = B.SIGUMGO_ORG_C  
  AND B.FIL_100_CTNT2 = C.SIGUMGO_ACNO(+)
  AND B.SIGUMGO_HOIKYE_YR = C.SIGUMGO_HOIKYE_YR(+)
  AND B.SIGUMGO_ORG_C = C.SIGUMGO_C(+)  
  AND A.ICH_SIGUMGO_GUN_GU_C = '0'  
    AND CASE WHEN A.SIGUMGO_HOIKYE_YR = 9999 THEN TO_NUMBER(SUBSTR(A.BAS_DT,1,4))
                   ELSE TO_NUMBER(A.SIGUMGO_HOIKYE_YR) END  = '2024'
  AND A.BAS_DT BETWEEN SUBSTR('20240101',0,4)||'0101' AND '20240620'
  AND A.SIGUMGO_ORG_C(+) = '42'
  AND B.MNG_NO = 1
  GROUP BY C.SIGUMGO_HOIKYE_C
UNION ALL 
  SELECT  TO_CHAR(HOIGYE_CODE) HOIGYE_CODE,    
    0,                                                               
    0,                                                               
    0,                                                               
    0,                                                               
    0,                                                               
    0,                                                               
    0,                                                               
    0,                                                               
    0,                                                               
    0,                                                               
    0,                                                               
    0,                                                               
    0,                                                               
    0,                                                               
    0,                                                               
    SUM(CASE WHEN GUBUN_CODE = 1 THEN AMT1 ELSE 0 END) as NUGYE_SEIB_SUIP,                   
    SUM(CASE WHEN GUBUN_CODE = 2 THEN AMT1 ELSE 0 END) as NUGYE_SEIB_BANNAB,                   
    SUM(CASE WHEN GUBUN_CODE = 4 THEN AMT1 ELSE 0 END) as NUGYE_SEIB_GYEONGJEONG_IB                   
    FROM   RPT_HOIGYE_IWOL A
   WHERE  1=1
     AND  A.HOIGYE_YEAR = ( '2024' - 1 ) 
     AND A.GEUMGO_CODE = '42'
     AND A.GUBUN_CODE IN (1, 2, 4)
     AND A.KIJUNIL BETWEEN SUBSTR('20240101',0,4)||'0101' AND '20240620'
     AND A.GUNGU_CODE = 0 
     GROUP BY HOIGYE_CODE
 ) 
 where 1=1
 and HOIGYE_CODE = '41'
 
---------------------------------------------

SELECT   
      C.SIGUMGO_HOIKYE_C AS HOIGYE_CODE     
     ,SUM(TAX_IP_SUIB_AMT) AS TAX_IP_SUIB_AMT         
     ,SUM(GWAON_PROC_JI_AMT) AS GWAON_PROC_JI_AMT      
     ,SUM(TAX_IP_CRT_IP_AMT) AS TAX_IP_CRT_IP_AMT        
     ,SUM(TAX_IP_CRT_JI_AMT) AS TAX_IP_CRT_JI_AMT        
      ,SUM(GAM_BAEJUNG_JI_AMT) 
      +SUM(BIZPLC_BAEJUNG_JI_AMT)
      +SUM(JICULWO_BAEJUNG_JI_AMT)  AS BIZPLC_BAEJUNG_JI_AMT   
     ,SUM(BIZPLC_GAM_BAEJUNG_IP_AMT) 
     +SUM(JICULWO_GAM_BAEJUNG_IP_AMT)
     +SUM(SUIP_CHULNAP_BAEJUNG_AMT)
     +SUM(FUND_UNYONG_INT_AMT)
     +SUM(PMNY_DEP_INT_AMT)
     +SUM(BTDEP_INT_AMT) AS  BIZPLC_BAEJUNG_IP_AMT       
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
     ,SUM(DEP_HJI_AMT) AS DEP_HJI_AMT           
     ,SUM(MR_FUND_IP_AMT+MR_FUND_JI_AMT) AS MR_FUND_AMT   
     ,0 IWOL_GONGGEUM_DEP
     ,0 IWOL_DANGHANG_JAGUM
     ,0 IWOL_MMDA
  FROM RPT_TXIO_DDAC_TAB A, ACL_SIGUMGO_MAS  B, RPT_AC_BY_HOIKYE_MAPP C
  WHERE  A.SGG_ACNO = B.FIL_100_CTNT2
  AND A.ICH_SIGUMGO_HOIKYE_C = B.ICH_SIGUMGO_HOIKYE_C
  AND A.SIGUMGO_ORG_C = B.SIGUMGO_ORG_C  
  AND B.FIL_100_CTNT2 = C.SIGUMGO_ACNO(+)
  AND B.SIGUMGO_HOIKYE_YR = C.SIGUMGO_HOIKYE_YR(+)
  AND B.SIGUMGO_ORG_C = C.SIGUMGO_C(+)  
  AND A.ICH_SIGUMGO_GUN_GU_C = '0'  
    AND CASE WHEN A.SIGUMGO_HOIKYE_YR = 9999 THEN TO_NUMBER(SUBSTR(A.BAS_DT,1,4))
                   ELSE TO_NUMBER(A.SIGUMGO_HOIKYE_YR) END  = '2024'
  AND A.BAS_DT BETWEEN SUBSTR('20240101',0,4)||'0101' AND '20240620'
  AND A.SIGUMGO_ORG_C(+) = '42'
  AND B.MNG_NO = 1
  and C.SIGUMGO_HOIKYE_C = '41'
  GROUP BY C.SIGUMGO_HOIKYE_C

-- =========================== XDA ID:[tom.kwd.fmt.xda.xSelectListKWD140206By01]===============================
SELECT
       T2.SIGUMGO_HOIKYE_C  AS HOIGYE_CODE
      ,SUM(CASE WHEN GWAMOK =  -1                 THEN 1      ELSE 0 END) AS GONGGEUM_GEONSU
      ,SUM(CASE WHEN GWAMOK =  -1                 THEN JANAEK ELSE 0 END) AS GONGGEUM_GEUMAEG
      ,SUM(CASE WHEN GWAMOK =  140                THEN 1      ELSE 0 END) AS MMDA_GEONSU
      ,SUM(CASE WHEN GWAMOK =  140                THEN JANAEK ELSE 0 END) AS MMDA_GEUMAEG
      ,SUM(CASE WHEN GWAMOK BETWEEN 200 AND 209   THEN 1      ELSE 0 END) AS JEONGGI_GEONSU
      ,SUM(CASE WHEN GWAMOK BETWEEN 200 AND 209   THEN JANAEK ELSE 0 END) AS JEONGGI_GEUMAEG
      ,SUM(CASE WHEN GWAMOK =  214                THEN 1      ELSE 0 END) AS RP_GEONSU
      ,SUM(CASE WHEN GWAMOK =  214                THEN JANAEK ELSE 0 END) AS RP_GEUMAEG
      ,SUM(CASE WHEN GWAMOK BETWEEN 210 AND 212   THEN 1      ELSE 0 END) AS CD_GEONSU
      ,SUM(CASE WHEN GWAMOK BETWEEN 210 AND 212   THEN JANAEK ELSE 0 END) AS CD_GEUMAEG
      ,SUM(CASE WHEN GWAMOK =  160  THEN 1      ELSE 0 END) AS MMF_GEONSU
      ,SUM(CASE WHEN GWAMOK =  160  THEN JANAEK ELSE 0 END) AS MMF_GEUMAEG
      ,SUM(CASE WHEN GWAMOK =  100    THEN 1      ELSE 0 END) AS BOTONG_GEONSU
      ,SUM(CASE WHEN GWAMOK =  100    THEN JANAEK ELSE 0 END) AS BOTONG_GEUMAEG
      ,T2.HOIKYE_NM AS HOIGYE_NAME
FROM
     (
      SELECT 
           TO_NUMBER(T4.SIGUMGO_HOIKYE_C) AS GONGGEUM_HOIGYE_CODE
          ,T3.GONGGEUM_GYEJWA
          ,-1 AS IYUL
          ,SUM(
               CASE
                   WHEN T5.IPJI_G = 1 THEN DECODE(T5.CRT_CAN_G, 1,-1,2,-1,33,-1,1) * T5.TRAMT
                   ELSE DECODE(T5.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T5.TRAMT * -1
               END
           ) AS JANAEK
          ,-1 AS GWAMOK
      FROM
      (
      SELECT
           T1.FIL_100_CTNT2 AS GONGGEUM_GYEJWA
          ,T1.SIGUMGO_ORG_C
          ,T1.ICH_SIGUMGO_GUN_GU_C
          ,T1.ICH_SIGUMGO_HOIKYE_C
          ,T1.SIGUMGO_AC_B
          ,T1.SIGUMGO_AC_SER
          ,T1.SIGUMGO_HOIKYE_YR
      FROM
           ACL_SIGUMGO_MAS T1
          ,RPT_AC_BY_HOIKYE_MAPP T2
      WHERE 1=1
           AND T1.FIL_100_CTNT2 = T2.SIGUMGO_ACNO
           AND T1.SIGUMGO_HOIKYE_YR = T2.SIGUMGO_HOIKYE_YR
           AND T1.SIGUMGO_ORG_C = 42
           AND (   (T1.SIGUMGO_HOIKYE_YR = '2024')
                OR (SUBSTR('20240620', 1, 4) = 2024 AND T1.SIGUMGO_HOIKYE_YR = '9999'))
           AND T1.MNG_NO = 1
           AND (
                      CASE
                          WHEN '41' = 'ALL' THEN 1
                          ELSE
                               CASE
                                   WHEN LENGTH('41') = 4
                                   THEN
                                        CASE
                                            WHEN T2.SIGUMGO_HOIKYE_C IN (
                                                                         SELECT
                                                                              TO_NUMBER(SIGUMGO_HOIKYE_C)
                                                                         FROM
                                                                              RPT_HOIKYE_GRP_HOIKYE_CD
                                                                         WHERE 1=1
                                                                              AND SIGUMGO_C = 42
                                                                              AND HOIKYE_GRP_ID = '41'
                                                                        )
                                            THEN 1
                                            ELSE 0
                                         END
                                   ELSE DECODE(T2.SIGUMGO_HOIKYE_C, '41', 1, 0)
                                END
                       END
                     ) = 1 
      ) T3
      ,RPT_AC_BY_HOIKYE_MAPP T4
      ,ACL_SIGUMGO_SLV T5
      WHERE 1=1
        AND T3.GONGGEUM_GYEJWA = T4.SIGUMGO_ACNO
        AND T3.GONGGEUM_GYEJWA = T5.FIL_100_CTNT5
        AND T3.SIGUMGO_ORG_C = T5.SIGUMGO_ORG_C
        AND T3.ICH_SIGUMGO_GUN_GU_C = T5.ICH_SIGUMGO_GUN_GU_C
        AND T3.ICH_SIGUMGO_HOIKYE_C = T5.ICH_SIGUMGO_HOIKYE_C
        AND T3.SIGUMGO_AC_B = T5.SIGUMGO_AC_B
        AND T3.SIGUMGO_AC_SER = T5.SIGUMGO_AC_SER
        AND T5.GISDT >= '20070205'
        AND T5.GISDT <= '20240620'
      GROUP BY T4.SIGUMGO_HOIKYE_C, T3.GONGGEUM_GYEJWA
      UNION ALL
      SELECT
           TO_NUMBER(T8.SIGUMGO_HOIKYE_C)
          ,T8.GONGGEUM_GYEJWA
          ,T9.IYUL
          ,T9.JANAEK
          ,TO_NUMBER(SUBSTR(T9.UNYONG_GYEJWA, 1, 3)) AS GWAMOK
       FROM
            (
             SELECT
                  T5.GONGGEUM_GYEJWA
                 ,T5.SIGUMGO_HOIKYE_C
                 ,T6.GONGGEUM_GYEJWA AS YUDONG_GONGGEUM_GYEJWA
                 ,T6.UNYONG_GYEJWA
             FROM
                  (
                   SELECT
                        T2.SIGUMGO_HOIKYE_YR
                       ,T2.GONGGEUM_GYEJWA
                       ,T3.SIGUMGO_HOIKYE_C
                   FROM
                        (
                         SELECT
                              LPAD(T1.SIGUMGO_ORG_C, 3, '0')||LPAD(T1.ICH_SIGUMGO_GUN_GU_C, 3, '0')||LPAD(T1.ICH_SIGUMGO_HOIKYE_C, 2, '0')||LPAD(T1.SIGUMGO_AC_B, 2, '0')||LPAD(T1.SIGUMGO_AC_SER, 5, '0')||SUBSTR(T1.SIGUMGO_HOIKYE_YR, 3, 2)  AS GONGGEUM_GYEJWA
                             ,T1.LINKAC_KWA_C ||'000'|| T1.LINK_ACSER AS GONGGEUM_YUDONG_ACNO
                             ,T1.SIGUMGO_ORG_C
                             ,T1.ICH_SIGUMGO_GUN_GU_C
                             ,T1.SIGUMGO_HOIKYE_YR
                             ,T1.SIGUMGO_AC_NM AS GONGGEUM_GYEJWA_NM
                         FROM
                              ACL_SIGUMGO_MAS T1
                             ,(
                               SELECT
                                    T2.SIGUMGO_ORG_C
                                   ,T2.ICH_SIGUMGO_GUN_GU_C
                                   ,T2.ICH_SIGUMGO_HOIKYE_C
                                   ,T2.SIGUMGO_AC_B
                                   ,T2.SIGUMGO_AC_SER
                                   ,T2.SIGUMGO_HOIKYE_YR
                               FROM
                                    ACL_SIGUMGO_MAS T2
                                   ,RPT_HOIGYE_IWOL T3
                               WHERE 1=1
                                    AND T2.SIGUMGO_ORG_C = T3.GEUMGO_CODE
                                    AND T2.ICH_SIGUMGO_GUN_GU_C = T3.GUNGU_CODE
                                    AND T2.SIGUMGO_HOIKYE_YR = TO_CHAR(T3.HOIGYE_YEAR + 1)
                                    AND T2.SIGUMGO_ORG_C = 42
                                    AND T2.SIGUMGO_HOIKYE_YR IN ('2024', '9999')
                                    AND T2.MNG_NO = 1
                                    AND T3.HOIGYE_CODE = (
                                                          SELECT
                                                               T4.SIGUMGO_HOIKYE_C
                                                          FROM
                                                               RPT_AC_BY_HOIKYE_MAPP T4
                                                          WHERE 1=1
                                                               AND T4.SIGUMGO_ACNO = T2.FIL_100_CTNT2
                                                         )
                                    AND T3.KIJUNIL <= '20240620'
                                    AND T3.GUBUN_CODE = 1
                              ) T4
                         WHERE 1=1
                              AND T1.SIGUMGO_ORG_C = T4.SIGUMGO_ORG_C
                              AND T1.ICH_SIGUMGO_GUN_GU_C = T4.ICH_SIGUMGO_GUN_GU_C
                              AND T1.ICH_SIGUMGO_HOIKYE_C = T4.ICH_SIGUMGO_HOIKYE_C
                              AND T1.SIGUMGO_AC_B = T4.SIGUMGO_AC_B
                              AND T1.SIGUMGO_AC_SER = T4.SIGUMGO_AC_SER
                              AND T1.SIGUMGO_HOIKYE_YR < T4.SIGUMGO_HOIKYE_YR
                              AND T1.SIGUMGO_ORG_C = 42
                              AND T1.MNG_NO = 1
                         UNION
                         SELECT
                              LPAD(T1.SIGUMGO_ORG_C, 3, '0')||LPAD(T1.ICH_SIGUMGO_GUN_GU_C, 3, '0')||LPAD(T1.ICH_SIGUMGO_HOIKYE_C, 2, '0')||LPAD(T1.SIGUMGO_AC_B, 2, '0')||LPAD(T1.SIGUMGO_AC_SER, 5, '0')||SUBSTR(T1.SIGUMGO_HOIKYE_YR, 3, 2)  AS GONGGEUM_GYEJWA
                             ,T1.LINKAC_KWA_C ||'000'|| T1.LINK_ACSER AS GONGGEUM_YUDONG_ACNO
                             ,T1.SIGUMGO_ORG_C
                             ,T1.ICH_SIGUMGO_GUN_GU_C
                             ,T1.SIGUMGO_HOIKYE_YR
                             ,T1.SIGUMGO_AC_NM AS GONGGEUM_GYEJWA_NM
                         FROM
                              ACL_SIGUMGO_MAS T1
                         WHERE 1=1
                              AND T1.SIGUMGO_ORG_C = 42
                              AND T1.SIGUMGO_HOIKYE_YR IN ('2024', '9999')
                              AND T1.MNG_NO = 1
                        ) T2
                       ,RPT_AC_BY_HOIKYE_MAPP T3
                   WHERE 1=1
                        AND T2.GONGGEUM_GYEJWA = T3.SIGUMGO_ACNO
                        AND T2.SIGUMGO_HOIKYE_YR = T3.SIGUMGO_HOIKYE_YR
                        AND (
                             CASE
                                 WHEN '41' = 'ALL' THEN 1
                                 ELSE
                                      CASE
                                          WHEN LENGTH('41') = 4
                                          THEN
                                               CASE
                                                   WHEN T3.SIGUMGO_HOIKYE_C IN (
                                                                                SELECT
                                                                                     TO_NUMBER(SIGUMGO_HOIKYE_C)
                                                                                FROM
                                                                                     RPT_HOIKYE_GRP_HOIKYE_CD
                                                                                WHERE 1=1
                                                                                     AND SIGUMGO_C = 42
                                                                                     AND HOIKYE_GRP_ID = '41'
                                                                               )
                                                   THEN 1
                                                   ELSE 0
                                                END
                                          ELSE DECODE(T3.SIGUMGO_HOIKYE_C, '41', 1, 0)
                                       END
                              END
                            ) = 1 
                  ) T5
                 ,RPT_UNYONG_GYEJWA T6
                  WHERE 1=1
                       AND T5.GONGGEUM_GYEJWA = T6.GONGGEUM_GYEJWA
                       AND (
                          CASE
                             WHEN T5.SIGUMGO_HOIKYE_YR = '9999' THEN DECODE(SIGN(T5.GONGGEUM_GYEJWA - T6.GONGGEUM_GYEJWA), 0, 1, 0)
                             ELSE    DECODE(SIGN(T5.GONGGEUM_GYEJWA - T6.GONGGEUM_GYEJWA), -1, 0, 1)
                           END
                         ) = 1
                       AND NVL(T6.MKDT,T6.IN_DATE) <= '20240620'
                       AND NVL(T6.OUT_DATE, '99991231') > '20240620'
                       AND NVL(T6.HJI_DT, '99991231') > '20240620'
                       AND T6.BANK_GUBUN = 0
                 ) T8
                ,RPT_UNYONG_JAN T9
             WHERE 1=1
                  AND T8.YUDONG_GONGGEUM_GYEJWA = T9.GONGGEUM_GYEJWA
                  AND T8.UNYONG_GYEJWA = T9.UNYONG_GYEJWA
                  AND T9.KIJUNIL = '20240620'
      UNION ALL
      SELECT
           TO_NUMBER(T4.SIGUMGO_HOIKYE_C) AS GONGGEUM_HOIGYE_CODE
          ,T4.GONGGEUM_GYEJWA
          ,NVL(T8.IYUL, 0) AS IYUL
          ,T5.JANAEK
          ,TO_NUMBER(SUBSTR(T8.UNYONG_GYEJWA,1,3)) GWAMOK
      FROM
           (
            SELECT
              T2.SIGUMGO_HOIKYE_YR
             ,T2.GONGGEUM_GYEJWA
             ,T2.GONGGEUM_GYEJWA_NM
             ,T2.GONGGEUM_YUDONG_ACNO
             ,T3.SIGUMGO_HOIKYE_C
            FROM
                (
                 SELECT 
                   LPAD(T1.SIGUMGO_ORG_C, 3, '0')||LPAD(T1.ICH_SIGUMGO_GUN_GU_C, 3, '0')||LPAD(T1.ICH_SIGUMGO_HOIKYE_C, 2, '0')||LPAD(T1.SIGUMGO_AC_B, 2, '0')||LPAD(T1.SIGUMGO_AC_SER, 5, '0')||SUBSTR(T1.SIGUMGO_HOIKYE_YR, 3, 2)  AS GONGGEUM_GYEJWA
                  ,T1.LINKAC_KWA_C ||'000'|| T1.LINK_ACSER AS GONGGEUM_YUDONG_ACNO
                  ,T1.SIGUMGO_ORG_C
                  ,T1.ICH_SIGUMGO_GUN_GU_C
                  ,T1.SIGUMGO_HOIKYE_YR
                  ,T1.SIGUMGO_AC_NM AS GONGGEUM_GYEJWA_NM
                 FROM
                   ACL_SIGUMGO_MAS T1
                 WHERE 1=1
                   AND T1.SIGUMGO_ORG_C = 42
                   AND T1.SIGUMGO_HOIKYE_YR IN ('2024', '9999')
                   AND T1.MNG_NO = 1
                ) T2
               ,RPT_AC_BY_HOIKYE_MAPP T3
            WHERE 1=1
                 AND T2.GONGGEUM_GYEJWA = T3.SIGUMGO_ACNO
                 AND T2.SIGUMGO_HOIKYE_YR = T3.SIGUMGO_HOIKYE_YR
                 AND (
                      CASE
                          WHEN '41' = 'ALL' THEN 1
                          ELSE
                               CASE
                                   WHEN LENGTH('41') = 4
                                   THEN
                                        CASE
                                            WHEN T3.SIGUMGO_HOIKYE_C IN (
                                                                         SELECT
                                                                              TO_NUMBER(SIGUMGO_HOIKYE_C)
                                                                         FROM
                                                                              RPT_HOIKYE_GRP_HOIKYE_CD
                                                                         WHERE 1=1
                                                                              AND SIGUMGO_C = 42
                                                                              AND HOIKYE_GRP_ID = '41'
                                                                        )
                                            THEN 1
                                            ELSE 0
                                         END
                                   ELSE DECODE(T3.SIGUMGO_HOIKYE_C, '41', 1, 0)
                                END
                       END
                     ) = 1 

           ) T4
          ,RPT_UNYONG_JAN T5
          ,(
            SELECT
                 '통합공금' AS SANGPUM_NAME
                ,T6.UNYONG_GYEJWA
                ,T6.MKDT
                ,T6.DUDT
                ,T6.IYUL
            FROM
                 RPT_UNYONG_JAN T6
                ,RPT_AC_BY_HOIKYE_MAPP T7
            WHERE 1=1
                 AND T6.GONGGEUM_GYEJWA = T7.SIGUMGO_ACNO
                 AND T6.GEUMGO_CODE = T7.SIGUMGO_C
                 AND T6.GEUMGO_CODE = 42
                 AND T6.KIJUNIL = '20240620'
                 AND T7.SIGUMGO_HOIKYE_YR = '9999'
                 AND T7.SIGUMGO_HOIKYE_C = '99'
          ) T8
      WHERE 1=1
           AND T4.GONGGEUM_GYEJWA = T5.GONGGEUM_GYEJWA
           AND T5.KIJUNIL = '20240620'
           AND T5.UNYONG_GYEJWA = '000000000000'
      UNION ALL
      SELECT
           T5.HOIGYE_CODE AS HOIGYE_CODE
          ,T5.GONGGEUM_GYEJWA
          ,NVL(T6.IYUL, 0) AS IYUL
          ,T6.JANAEK
          ,TO_NUMBER(SUBSTR(T6.UNYONG_GYEJWA, 1, 3)) AS GWAMOK
      FROM
           (
            SELECT
                 T2.GONGGEUM_GYEJWA
                ,T2.HOIGYE_CODE
                ,T3.UNYONG_GYEJWA
                ,T3.SANGPUM_NAME
            FROM
                 (
                  SELECT
                       T1.REF_D_NM AS GONGGEUM_GYEJWA
                      ,T1.REF_CTNT1 AS GONGGEUM_GYEJWA_NM
                      ,T1.REF_S_C AS MNGR
                      ,TO_NUMBER(T1.REF_D_NM, 4, 3) AS GUNGU_CODE
                      ,900+T1.REF_D_C HOIGYE_CODE
                      ,99 AS GYEJWA_BUNRYU
                  FROM
                       RPT_CODE_INFO T1
                  WHERE 1=1
                       AND T1.REF_L_C = '50'
                       AND T1.REF_M_C = 42
                       AND T1.YUHYO_YN = 0
                  ) T2
                 ,RPT_UNYONG_GYEJWA T3
            WHERE 1=1
                  AND T2.GONGGEUM_GYEJWA = T3.GONGGEUM_GYEJWA
                  AND NVL(T3.MKDT,T3.IN_DATE) <= '20240620'
                  AND NVL(T3.OUT_DATE, '99991231') > '20240620'
                  AND NVL(T3.HJI_DT, '99991231') > '20240620'
                  AND T3.BANK_GUBUN = 0
           ) T5
          ,RPT_UNYONG_JAN T6
      WHERE 1=1
           AND T5.GONGGEUM_GYEJWA = T6.GONGGEUM_GYEJWA
           AND T5.UNYONG_GYEJWA = T6.UNYONG_GYEJWA
           AND T6.KIJUNIL = '20240620'
     ) T1
    ,RPT_HOIKYE_CD T2
WHERE 1=1
     AND T1.GONGGEUM_HOIGYE_CODE(+) = T2.SIGUMGO_HOIKYE_C
     AND T1.GONGGEUM_HOIGYE_CODE(+) != 98
     AND T2.SIGUMGO_C = 42
     AND T2.SIGUMGO_HOIKYE_C != 98
     AND T2.USE_YN = 'Y'
     AND (
           CASE
               WHEN '41' = 'ALL' THEN 1
               ELSE
                    CASE
                        WHEN LENGTH('41') = 4
                        THEN
                             CASE
                                 WHEN T2.SIGUMGO_HOIKYE_C IN (
                                                              SELECT
                                                                   TO_NUMBER(SIGUMGO_HOIKYE_C)
                                                              FROM
                                                                   RPT_HOIKYE_GRP_HOIKYE_CD
                                                              WHERE 1=1
                                                                   AND SIGUMGO_C = 42
                                                                   AND HOIKYE_GRP_ID = '41'
                                                             )
                                 THEN 1
                                 ELSE 0
                              END
                        ELSE DECODE(T2.SIGUMGO_HOIKYE_C, '41', 1, 0)
                     END
            END
          ) = 1 
GROUP BY
     T2.SIGUMGO_HOIKYE_C
    ,T2.HOIKYE_NM
ORDER BY
     TO_NUMBER(T2.SIGUMGO_HOIKYE_C)

-----------------------------------------------------------------------------------------------

SELECT
           TO_NUMBER(T4.SIGUMGO_HOIKYE_C) AS GONGGEUM_HOIGYE_CODE
          ,T4.GONGGEUM_GYEJWA
          ,NVL(T8.IYUL, 0) AS IYUL
          ,T5.JANAEK
          ,TO_NUMBER(SUBSTR(T8.UNYONG_GYEJWA,1,3)) GWAMOK
      FROM
           (
            SELECT
              T2.SIGUMGO_HOIKYE_YR
             ,T2.GONGGEUM_GYEJWA
             ,T2.GONGGEUM_GYEJWA_NM
             ,T2.GONGGEUM_YUDONG_ACNO
             ,T3.SIGUMGO_HOIKYE_C
            FROM
                (
                 SELECT 
                   LPAD(T1.SIGUMGO_ORG_C, 3, '0')||LPAD(T1.ICH_SIGUMGO_GUN_GU_C, 3, '0')||LPAD(T1.ICH_SIGUMGO_HOIKYE_C, 2, '0')||LPAD(T1.SIGUMGO_AC_B, 2, '0')||LPAD(T1.SIGUMGO_AC_SER, 5, '0')||SUBSTR(T1.SIGUMGO_HOIKYE_YR, 3, 2)  AS GONGGEUM_GYEJWA
                  ,T1.LINKAC_KWA_C ||'000'|| T1.LINK_ACSER AS GONGGEUM_YUDONG_ACNO
                  ,T1.SIGUMGO_ORG_C
                  ,T1.ICH_SIGUMGO_GUN_GU_C
                  ,T1.SIGUMGO_HOIKYE_YR
                  ,T1.SIGUMGO_AC_NM AS GONGGEUM_GYEJWA_NM
                 FROM
                   ACL_SIGUMGO_MAS T1
                 WHERE 1=1
                   AND T1.SIGUMGO_ORG_C = 42
                   AND T1.SIGUMGO_HOIKYE_YR IN ('2024', '9999')
                   AND T1.MNG_NO = 1
                ) T2
               ,RPT_AC_BY_HOIKYE_MAPP T3
            WHERE 1=1
                 AND T2.GONGGEUM_GYEJWA = T3.SIGUMGO_ACNO
                 AND T2.SIGUMGO_HOIKYE_YR = T3.SIGUMGO_HOIKYE_YR
                 AND (
                      CASE
                          WHEN '41' = 'ALL' THEN 1
                          ELSE
                               CASE
                                   WHEN LENGTH('41') = 4
                                   THEN
                                        CASE
                                            WHEN T3.SIGUMGO_HOIKYE_C IN (
                                                                         SELECT
                                                                              TO_NUMBER(SIGUMGO_HOIKYE_C)
                                                                         FROM
                                                                              RPT_HOIKYE_GRP_HOIKYE_CD
                                                                         WHERE 1=1
                                                                              AND SIGUMGO_C = 42
                                                                              AND HOIKYE_GRP_ID = '41'
                                                                        )
                                            THEN 1
                                            ELSE 0
                                         END
                                   ELSE DECODE(T3.SIGUMGO_HOIKYE_C, '41', 1, 0)
                                END
                       END
                     ) = 1 

           ) T4
          ,RPT_UNYONG_JAN T5
          ,(
            SELECT
                 '통합공금' AS SANGPUM_NAME
                ,T6.UNYONG_GYEJWA
                ,T6.MKDT
                ,T6.DUDT
                ,T6.IYUL
            FROM
                 RPT_UNYONG_JAN T6
                ,RPT_AC_BY_HOIKYE_MAPP T7
            WHERE 1=1
                 AND T6.GONGGEUM_GYEJWA = T7.SIGUMGO_ACNO
                 AND T6.GEUMGO_CODE = T7.SIGUMGO_C
                 AND T6.GEUMGO_CODE = 42
                 AND T6.KIJUNIL = '20240620'
                 AND T7.SIGUMGO_HOIKYE_YR = '9999'
                 AND T7.SIGUMGO_HOIKYE_C = '99'
          ) T8
      WHERE 1=1
           AND T4.GONGGEUM_GYEJWA = T5.GONGGEUM_GYEJWA
           AND T5.KIJUNIL = '20240620'
           AND T5.UNYONG_GYEJWA = '000000000000'

     
-- ============================================================================================

select * from rpt_unyong_gyejwa
where unyong_gyejwa = '160000125420'

select * from rpt_unyong_jan
where gonggeum_gyejwa = '04200080900004199'
and unyong_gyejwa = '000000000000'
and KIJUNIL = '20240620'

select * from rpt_unyong_jan
where gonggeum_gyejwa = '04200080900004199'
and unyong_gyejwa = '000000000000'
and KIJUNIL = '20240619'


select * from rpt_unyong_jan
where gonggeum_gyejwa = '04200080900004199'
and unyong_gyejwa = '000000000000'
and KIJUNIL LIKE '2024%'
ORDER BY KIJUNIL DESC

--------------------------------------------------------------------------------------------

INSERT INTO RPT_UNYONG_JAN
SELECT A.DW_BAS_DDT, A.GONGGEUM_GYEJWA, '000000000000' AS UNYONG_GYEJWA, NVL(B.JANAEK, 0) AS JANAEK,
 NVL(B.MKDT, '') AS MKDT, NVL(B.DUDT, '') AS DUDT, NVL(B.HJI_DT, '') AS HJI_DT,,
 NVL(B.BBK_BKKP_NM, '') AS BBK_BKKP_NM, NVL(B.PRDT_BKKP_NM, '') AS PRDT_BKKP_NM,
 :TRXDT AS LST_TRXDT, NVL(B.IYUL, 0) AS IYUL, A.GEUMGO_CODE, 0 IPAMT, 0 JIAMT, 0 JI_IJA
 FROM 
 (
    SELECT DISTINCT A.FIL_100_CTNT5 AS GONGGEUM_GYEJWA, D.DW_BAS_DDT, D.BIZ_DT, D.BF1_BIZ_DT, A.SIGUMGO_ORG_C AS GEUMGO_CODE
    FROM ACL_SIGUMGO_SLV A, MAP_JOB_DATE D 
    WHERE D.DW_BAS_DDT BETWEEN A.GISDT AND :TRXDT
    AND A.TRXDT = :TRXDT
    AND A.SIGUMGO_TRX_G IN (40, 90)
    AND A.FIL_2_NO3 = 9
    AND D.DW_BAS_DDT NOT IN 
    (
        SELECT TRIM(KIJUNIL)
        FROM RPT_UNYONG_JAN
        WHERE UNYONG_GYEJWA = '000000000000'
        AND GEUMGO_CODE = A.SIGUMGO_ORG_C
        AND GONGGEUMG_GYEJWA = A.FIL_100_CTNT5
        AND KIJUNIL BETWEEN A.GISDT AND :TRXDT
        UNION ALL SELECT '99991231' FROM DUAL
    )
 )


SELECT * FROM 
 ACL_SIGUMGO_SLV
 WHERE FIL_100_CTNT5 = '04200080900004199'
AND SIGUMGO_TRX_G IN (40, 90)
 AND TRXDT = '20240620'
 
