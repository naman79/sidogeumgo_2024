select 
    *
from RPT_SUNAP_JIBGYE
where 1=1

-------------------------------

select
    *
from ssi_mg_sunap
where 1=1
and sunapdate BETWEEN '20250101' and '20251031'
and local_gubun = '3'
and accountid = '1'
and seipdate > '20251031'
order by sunapdate, seipdate



select
    sunapdate,
    seipdate,
    sum(sunapamt) as sunapamt
from ssi_mg_sunap
where 1=1
and sunapdate BETWEEN '20250101' and '20251031'
and local_gubun = '3'
and accountid = '1'
and seipdate > '20251031'
group by sunapdate, seipdate
order by sunapdate, seipdate


select
    sunapdate,
    seipdate,
    sum(sunapamt) as sunapamt
from ssi_mg_sunap
where 1=1
and sunapdate BETWEEN '20250101' and '20251031'
and local_gubun = '3'
and accountid = '1'
group by sunapdate, seipdate
order by sunapdate, seipdate


------------------------------------------------------------


WITH AC_LIST AS (
  SELECT     
    T2.SIGUMGO_ORG_C
    ,T3.SIGUMGO_HOIKYE_C AS RPT_HOIKYE_C
    ,T2.GONGGEUM_GYEJWA
    ,T2.GONGGEUM_GYEJWA_NM
    ,T2.SIGUMGO_HOIKYE_YR
  FROM
    (
  SELECT
    T1.SIGUMGO_ORG_C
    ,T1.ICH_SIGUMGO_GUN_GU_C
    ,T1.ICH_SIGUMGO_HOIKYE_C
    ,T1.SIGUMGO_AC_B
    ,T1.SIGUMGO_AC_SER
    ,T1.SIGUMGO_HOIKYE_YR
    ,LPAD(T1.SIGUMGO_ORG_C, 3, 0)||LPAD(T1.ICH_SIGUMGO_GUN_GU_C, 3, 0)||LPAD(T1.ICH_SIGUMGO_HOIKYE_C, 2, 0)||RPAD(T1.SIGUMGO_AC_B, 2, 0)||LPAD(T1.SIGUMGO_AC_SER, 5, '0')||SUBSTR(T1.SIGUMGO_HOIKYE_YR, 3, 2) AS  GONGGEUM_GYEJWA    
    ,T1.LINKAC_KWA_C ||'000'|| T1.LINK_ACSER AS GONGGEUM_YUDONG_ACNO
    ,T1.SIGUMGO_AC_NM AS GONGGEUM_GYEJWA_NM
  FROM
    ACL_SIGUMGO_MAS T1
  WHERE 1=1
    AND T1.SIGUMGO_ORG_C = '110'
    AND T1.SIGUMGO_HOIKYE_YR IN ('2025', '9999')
    AND T1.MNG_NO = 1
    ) T2
    ,RPT_AC_BY_HOIKYE_MAPP T3
  WHERE 1=1
    AND T2.GONGGEUM_GYEJWA = T3.SIGUMGO_ACNO
    AND T2.SIGUMGO_HOIKYE_YR = T3.SIGUMGO_HOIKYE_YR
    AND T2.SIGUMGO_ORG_C = T3.SIGUMGO_C
 )
 SELECT
    HOIGYE_CODE,
    SIGUMGO_ORG_C,
           NVL(TAX_SUNP_IP_AMT,0) AS SEIB_SUIP,           
    NVL(TAX_BAEJUNG_IP_AMT,0) AS TAX_BAEJUNG_IP_AMT,    
    NVL(GWAON_PROC_JI_AMT,0) AS SEIB_BANNAB,                  
    NVL(TAX_IP_CRT_IP_AMT,0) AS SEIB_GYEONGJEONG_IB,       
    NVL(TAX_IP_CRT_JI_AMT,0) AS SEIB_GYEONGJEONG_JI,                  
    NVL(BIZPLC_BAEJUNG_JI_AMT,0)+NVL(GAM_BAEJUNG_JI_AMT,0) AS SECHUL_BAEJEONG,                 
    NVL(BIZPLC_GAM_BAEJUNG_IP_AMT,0) AS SECHUL_HWANSU,                
    NVL(TAXO_JI_AMT,0) AS SECHUL_JI,                       
    NVL(TAXO_RTRN_AMT,0) AS SECHUL_BANNAB,                    
    NVL(KWA_CRRC_IP_AMT,0) AS SECHUL_GYEONGJEONG_IB,                 
    NVL(KWA_CRRC_JI_AMT,0) AS SECHUL_GYEONGJEONG_JI,                 
    NVL(GA_IWOL_IP_AMT,0) AS SEIB_GYULSANBF_IIB,                   
    NVL(GA_IWOL_JI_AMT,0) AS SECHUL_GYULSANBF_IWOL,                  
    NVL(DEP_MK_JI_AMT,0) - NVL(DEP_HJI_AMT,0) AS DEP,                       
    NVL(MMDA,0) AS MMDA,                       
    NVL(SUNP_AMT,0) AS SUNP_AMT,           
    NVL(IWOL_GONGGEUM,0) AS IWOL_GONGGEUM,      
    NVL(IWOL_MIJUNGSAN,0) AS IWOL_MIJUNGSAN ,      
    NVL(IWOL_MMDA,0) AS IWOL_MMDA,         
     NVL(IWOL_GONGGEUM_DEP,0) AS IWOL_GONGGEUM_DEP,    
    0 AS SEIB_SUIP2,                
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
    0 AS MMDA2,                          
    0 AS SUNP_AMT2,              
    0 AS IWOL_GONGGEUM2,           
    0 AS IWOL_MIJUNGSAN2 ,            
    0 AS IWOL_MMDA2,             
     0 AS IWOL_GONGGEUM_DEP2          
 FROM
 (
  SELECT   
      RPT_HOIKYE_C AS HOIGYE_CODE
     ,A.SIGUMGO_ORG_C
     ,SUM(TAX_SUNP_IP_AMT) AS TAX_SUNP_IP_AMT
     ,SUM(SUIP_CHULNAP_BAEJUNG_AMT)
        +SUM(FUND_UNYONG_INT_AMT)
        +SUM(PMNY_DEP_INT_AMT)
        +SUM(BTDEP_INT_AMT)
        +SUM(JICULWO_BAEJUNG_IP_AMT) AS TAX_BAEJUNG_IP_AMT
     ,SUM(GWAON_PROC_JI_AMT) AS GWAON_PROC_JI_AMT
     ,SUM(TAX_IP_CRT_IP_AMT) AS TAX_IP_CRT_IP_AMT
     ,SUM(TAX_IP_CRT_JI_AMT) AS TAX_IP_CRT_JI_AMT
     ,SUM(BIZPLC_BAEJUNG_JI_AMT) AS BIZPLC_BAEJUNG_JI_AMT
     ,SUM(BIZPLC_GAM_BAEJUNG_IP_AMT) AS BIZPLC_GAM_BAEJUNG_IP_AMT
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
    ,SUM(MR_FUND_AMT) AS MMDA
    ,SUM(DEP_HJI_AMT) AS DEP_HJI_AMT
    ,0 AS SUNP_AMT
    ,0 AS IWOL_GONGGEUM
    ,0 AS IWOL_MIJUNGSAN
    ,0 AS IWOL_MMDA
    ,0 AS IWOL_GONGGEUM_DEP
    ,SUM(GAM_BAEJUNG_JI_AMT) GAM_BAEJUNG_JI_AMT
  FROM RPT_TXIO_DDAC_TAB A, AC_LIST B
  WHERE  A.SGG_ACNO(+) = B.GONGGEUM_GYEJWA 
       AND CASE WHEN A.SIGUMGO_HOIKYE_YR(+) = 9999 THEN TO_NUMBER(SUBSTR(A.BAS_DT(+),1,4))
                   ELSE TO_NUMBER(A.SIGUMGO_HOIKYE_YR(+)) END  = '2025'
  AND A.BAS_DT(+) BETWEEN SUBSTR('20250101',0,4)||'0101' AND '20251031'
  AND A.SIGUMGO_ORG_C(+)  = '110'  
  AND A.ICH_SIGUMGO_GUN_GU_C = 0
  and A.SGG_ACNO = '11000080900000199'
  GROUP BY RPT_HOIKYE_C, A.SIGUMGO_ORG_C
 )

---------------------------------

select 
    *
from RPT_TXIO_DDAC_TAB
where SIGUMGO_ORG_C = '110'
and ICH_SIGUMGO_GUN_GU_C = 0
and SGG_ACNO = '11000080900000199'
and BAS_DT BETWEEN SUBSTR('20250101',0,4)||'0101' AND '20251031'
and TAX_SUNP_IP_AMT > 0
order by BAS_DT


-----------------------------------------

select 
SGG_ACNO, 
    BAS_DT,
   PROC_DT,
   GISDT,
TAX_SUNP_IP_AMT 
from RPT_TXIO_DDAC_TAB
where SIGUMGO_ORG_C = '110'
and ICH_SIGUMGO_GUN_GU_C = 0
and SGG_ACNO = '11000080900000199'
and BAS_DT BETWEEN SUBSTR('20250101',0,4)||'0101' AND '20251031'
and TAX_SUNP_IP_AMT > 0
order by BAS_DT


-------------------------------------------------

