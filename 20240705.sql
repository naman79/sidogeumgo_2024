select sigumgo_trx_g from acl_sigumgo_slv
where 1=1
and FIL_100_CTNT5 = '02800075690000099'
group by sigumgo_trx_g



SELECT  BB.SIGUMGO_HOIKYE_C,
  BB.HOIKYE_NM NUGYE_HOIGYE_NAME,
  NVL(SUM(SEIB_SUIP2),0) NUGYE_SEIB_SUIP,
  NVL(SUM(SEIB_BANNAB2),0) NUGYE_SEIB_BANNAB,
  NVL(SUM(SEIB_GYEONGJEONG_IB2),0) NUGYE_SEIB_GYEONGJEONG_IB,
  NVL(SUM(SEIB_GYEONGJEONG_JI2)*-1,0) NUGYE_SEIB_GYEONGJEONG_JI,
  NVL(SUM(SECHUL_BAEJEONG2),0) NUGYE_SECHUL_BAEJEONG,
  NVL(SUM(SECHUL_HWANSU2)*-1,0) NUGYE_SECHUL_HWANSU,
  NVL(SUM(SECHUL_JI2),0) NUGYE_SECHUL_JI,
  NVL(SUM(SECHUL_BANNAB2)*-1,0) NUGYE_SECHUL_BANNAB,
  NVL(SUM(SECHUL_GYEONGJEONG_IB2),0) NUGYE_SECHUL_GYEONGJEONG_IB,
  NVL(SUM(SECHUL_GYEONGJEONG_JI2),0) NUGYE_SECHUL_GYEONGJEONG_JI,
  NVL(SUM(SEIB_GYULSANBF_IIB2),0) NUGYE_SEIB_GYULSANBF_IIB,
  NVL(SUM(SECHUL_GYULSANBF_IWOL2),0) NUGYE_SECHUL_GYULSANBF_IWOL,
  NVL(SUM(DEP2),0) NUGYE_DEP,
  NVL(SUM(HWANIB2),0) NUGYE_HWANIB,
  NVL(SUM(MIICHE2),0) NUGYE_MIICHE,
  NVL(SUM(SEIB_SUIP),0) ILGYE_SEIB_SUIP,
  NVL(SUM(SEIB_BANNAB),0) ILGYE_SEIB_BANNAB,
  NVL(SUM(SEIB_GYEONGJEONG_IB),0) ILGYE_SEIB_GYEONGJEONG_IB,
  NVL(SUM(SEIB_GYEONGJEONG_JI)*-1,0) ILGYE_SEIB_GYEONGJEONG_JI,
  NVL(SUM(SECHUL_BAEJEONG),0) ILGYE_SECHUL_BAEJEONG,
  NVL(SUM(SECHUL_HWANSU)*-1,0) ILGYE_SECHUL_HWANSU,
  NVL(SUM(SECHUL_JI),0) ILGYE_SECHUL_JI,
  NVL(SUM(SECHUL_BANNAB)*-1,0) ILGYE_SECHUL_BANNAB,
  NVL(SUM(SECHUL_GYEONGJEONG_IB),0) ILGYE_SECHUL_GYEONGJEONG_IB,
  NVL(SUM(SECHUL_GYEONGJEONG_JI),0) ILGYE_SECHUL_GYEONGJEONG_JI,
  NVL(SUM(SEIB_GYULSANBF_IIB),0) ILGYE_SEIB_GYULSANBF_IIB,
  NVL(SUM(SECHUL_GYULSANBF_IWOL),0) ILGYE_SECHUL_GYULSANBF_IWOL,
  NVL(SUM(DEP),0) ILGYE_DEP,
  NVL(SUM(HWANIB),0) ILGYE_HWANIB,
  NVL(SUM(MIICHE),0) ILGYE_MIICHE  
FROM
(
 SELECT   
     HOIGYE_CODE,
     SIGUMGO_ORG_C,
     NVL(SUNP_AMT,0) + NVL(TAX_BAEJUNG_IP_AMT,0) + NVL(IWOL_GONGGEUM,0)                                   
    - (NVL(SUNP_AMT,0) - NVL(TAX_SUNP_IP_AMT,0) + NVL(IWOL_MIJUNGSAN,0)) AS SEIB_SUIP,             
    NVL(GWAON_PROC_JI_AMT,0) AS SEIB_BANNAB,             
    NVL(TAX_IP_CRT_IP_AMT,0) AS SEIB_GYEONGJEONG_IB,             
    NVL(TAX_IP_CRT_JI_AMT,0) AS SEIB_GYEONGJEONG_JI,             
    NVL(BIZPLC_BAEJUNG_JI_AMT,0) AS SECHUL_BAEJEONG,             
    NVL(BIZPLC_GAM_BAEJUNG_IP_AMT,0) AS SECHUL_HWANSU,             
    NVL(TAXO_JI_AMT,0) AS SECHUL_JI,             
    NVL(TAXO_RTRN_AMT,0) AS SECHUL_BANNAB,             
    NVL(KWA_CRRC_IP_AMT,0) AS SECHUL_GYEONGJEONG_IB,             
    NVL(KWA_CRRC_JI_AMT,0) AS SECHUL_GYEONGJEONG_JI,             
    NVL(GA_IWOL_IP_AMT,0) AS SEIB_GYULSANBF_IIB,             
    NVL(GA_IWOL_JI_AMT,0) AS SECHUL_GYULSANBF_IWOL,             
    NVL(DEP_MK_JI_AMT,0) + NVL(IWOL_GONGGEUM_DEP,0) AS DEP,             
    NVL(DEP_HJI_AMT,0) AS HWANIB,             
    NVL(SUNP_AMT,0) - NVL(TAX_SUNP_IP_AMT,0) + NVL(IWOL_MIJUNGSAN,0) AS MIICHE,   
    0 AS SEIB_SUIP2,             
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
    0 AS HWANIB2,             
    0 AS MIICHE2   
 FROM
 (
  SELECT   
      C.SIGUMGO_HOIKYE_C AS HOIGYE_CODE    
     ,A.SIGUMGO_ORG_C
     ,SUM(TAX_SUNP_IP_AMT) AS TAX_SUNP_IP_AMT         --세입_수입입금
     ,SUM(TAX_BAEJUNG_IP_AMT) TAX_BAEJUNG_IP_AMT       --세입_배정입금 
     ,SUM(GWAON_PROC_JI_AMT) AS GWAON_PROC_JI_AMT      --세입_과오납반환
     ,SUM(TAX_IP_CRT_IP_AMT) AS TAX_IP_CRT_IP_AMT        --세입_과목경정입금
     ,SUM(TAX_IP_CRT_JI_AMT) AS TAX_IP_CRT_JI_AMT        --세입_과목경정지급
     ,SUM(BIZPLC_BAEJUNG_JI_AMT) AS BIZPLC_BAEJUNG_JI_AMT     --자금_배정         
     ,SUM(BIZPLC_GAM_BAEJUNG_IP_AMT) AS BIZPLC_GAM_BAEJUNG_IP_AMT  --자금_환수                    
    ,SUM(TAXO_FUND_BAEJUNG_JI_AMT)
     +SUM(TAXO_HNDO_BAEJUNG_JI_AMT)
     +SUM(TAXO_FUND_GETBK_JI_AMT)
     +SUM(TAXO_HNDO_JICHUL_JI_AMT)
     +SUM(TAXO_HNDO_GETBK_JI_AMT)  AS TAXO_JI_AMT      --세출_지급
    ,SUM(TAXO_RTRN_AMT) AS TAXO_RTRN_AMT         --세출_반환
    ,SUM(KWA_CRRC_IP_AMT) AS KWA_CRRC_IP_AMT        --세출_과목경정입금      
    ,SUM(KWA_CRRC_JI_AMT) AS KWA_CRRC_JI_AMT        --세출_과목경정지급
    ,SUM(GA_IWOL_IP_AMT) AS GA_IWOL_IP_AMT         --결산전이입
    ,SUM(GA_IWOL_JI_AMT) AS GA_IWOL_JI_AMT         --결산전이월
    ,SUM(DEP_MK_JI_AMT) AS DEP_MK_JI_AMT          --예금등
    ,SUM(DEP_HJI_AMT) AS DEP_HJI_AMT           -- 환입     
    ,0 AS SUNP_AMT                -- 세입_수납집계
    ,0 AS IWOL_GONGGEUM              -- 이월_수납액          
    ,0 AS IWOL_MIJUNGSAN              -- 이월_미이체액          
    ,0 AS IWOL_MMDA               -- 이월_MMDA
    ,0 AS IWOL_GONGGEUM_DEP             -- 이월_예금등     
  FROM RPT_TXIO_DDAC_TAB A,  ACL_SIGUMGO_MAS  B, RPT_AC_BY_HOIKYE_MAPP C
  WHERE  A.SGG_ACNO = B.FIL_100_CTNT2
  AND A.ICH_SIGUMGO_HOIKYE_C = B.ICH_SIGUMGO_HOIKYE_C
  AND A.SIGUMGO_ORG_C = B.SIGUMGO_ORG_C  
  AND B.FIL_100_CTNT2 = C.SIGUMGO_ACNO(+)
  AND B.SIGUMGO_HOIKYE_YR = C.SIGUMGO_HOIKYE_YR(+)
  AND B.SIGUMGO_ORG_C = C.SIGUMGO_C(+)    
  AND A.ICH_SIGUMGO_GUN_GU_C = '0' 
 AND CASE WHEN A.SIGUMGO_HOIKYE_YR = 9999 THEN TO_NUMBER(SUBSTR(A.BAS_DT,1,4))
                   ELSE TO_NUMBER(A.SIGUMGO_HOIKYE_YR) END  = '2024'
  AND A.BAS_DT BETWEEN '20240701' AND '20240701' 
  AND A.SIGUMGO_ORG_C  = '440'
  AND B.MNG_NO = 1
  GROUP BY C.SIGUMGO_HOIKYE_C, A.SIGUMGO_ORG_C
  UNION ALL
  SELECT  TO_CHAR(ICH_SIGUMGO_HOIKYE_C) HOIGYE_CODE    
    ,A.SIGUMGO_ORG_C
    ,0 TAX_SUNP_IP_AMT         --세입_수입입금
    ,0 TAX_BAEJUNG_IP_AMT       --세입_배정입금 
    ,0 AS GWAON_PROC_JI_AMT       --세입_과오납반환
    ,0 AS TAX_IP_CRT_IP_AMT        --세입_과목경정입금
    ,0 AS TAX_IP_CRT_JI_AMT        --세입_과목경정지급
    ,0 AS BIZPLC_BAEJUNG_JI_AMT      --자금_배정         
    ,0 AS BIZPLC_GAM_BAEJUNG_IP_AMT     --자금환수                    
    ,0 TAXO_JI_AMT          --세출_지급
    ,0 AS TAXO_RTRN_AMT        --세출_반환
    ,0 AS KWA_CRRC_IP_AMT        --세출_과목경정입금      
    ,0 AS KWA_CRRC_JI_AMT        --세출_과목경정지급
    ,0 AS GA_IWOL_IP_AMT        --결산전이입
    ,0 AS GA_IWOL_JI_AMT        --결산전이월
    ,0 AS DEP_MK_JI_AMT        --예금등
    ,0 AS DEP_HJI_AMT         -- 환입     
    ,SUM(JIBANGSE_AMT)  AS SUNP_AMT     -- 세입수납집계
    ,0             -- 이월_수납액          
    ,0             -- 이월_미이체액          
    ,0             -- 이월_MMDA
    ,0             -- 이월_예금등     
   FROM   RPT_TXI_DDAC_TAB A
   WHERE  A.SIGUMGO_HOIKYE_YR = ( '2024' ) 
     AND A.SIGUMGO_ORG_C = '440'
     AND A.SUNAP_DT BETWEEN '20240701' AND '20240701'
     AND A.ICH_SIGUMGO_GUN_GU_C = 0    
     GROUP BY ICH_SIGUMGO_HOIKYE_C, A.SIGUMGO_ORG_C
  UNION ALL
  SELECT  TO_CHAR(HOIGYE_CODE) HOIGYE_CODE    
    ,GEUMGO_CODE
    ,0 TAX_SUNP_IP_AMT         --세입_수입입금
    ,0 TAX_BAEJUNG_IP_AMT       --세입_배정입금 
    ,0 AS GWAON_PROC_JI_AMT       --세입_과오납반환
    ,0 AS TAX_IP_CRT_IP_AMT        --세입_과목경정입금
    ,0 AS TAX_IP_CRT_JI_AMT        --세입_과목경정지급
    ,0 AS BIZPLC_BAEJUNG_JI_AMT      --자금_배정         
    ,0 AS BIZPLC_GAM_BAEJUNG_IP_AMT     --자금환수                    
    ,0 TAXO_JI_AMT          --세출_지급
    ,0 AS TAXO_RTRN_AMT        --세출_반환
    ,0 AS KWA_CRRC_IP_AMT        --세출_과목경정입금      
    ,0 AS KWA_CRRC_JI_AMT        --세출_과목경정지급
    ,0 AS GA_IWOL_IP_AMT        --결산전이입
    ,0 AS GA_IWOL_JI_AMT        --결산전이월
    ,0 AS DEP_MK_JI_AMT        --예금등
    ,0 AS DEP_HJI_AMT         -- 환입     
    ,0             -- 세입수납집계
    ,SUM(CASE WHEN GUBUN_CODE = 1 THEN AMT1 ELSE 0 END)   -- 이월_수납액          
    ,SUM(CASE WHEN GUBUN_CODE = 5 THEN AMT1 ELSE 0 END)   -- 이월_미이체액          
    ,SUM(CASE WHEN GUBUN_CODE = 4 THEN AMT1 ELSE 0 END)   -- 이월_MMDA
    ,SUM(CASE WHEN GUBUN_CODE = 2 THEN AMT1 ELSE 0 END)   -- 이월_예금등    
   FROM   RPT_HOIGYE_IWOL A
   WHERE  A.HOIGYE_YEAR = ( '2024' - 1 ) 
     AND A.GEUMGO_CODE = '440'            
     AND A.GUBUN_CODE IN (1, 2, 4, 5)  
     AND A.KIJUNIL BETWEEN '20240701' AND '20240701'   
     AND A.GUNGU_CODE = 0     
     GROUP BY HOIGYE_CODE, GEUMGO_CODE
 ) 
 UNION ALL 
 --누계
 SELECT   
    HOIGYE_CODE,    
    SIGUMGO_ORG_C,
    0 AS SEIB_SUIP,             
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
    0 AS HWANIB,             
    0 AS MIICHE, 
    NVL(SUNP_AMT,0) + NVL(TAX_BAEJUNG_IP_AMT,0) + NVL(IWOL_GONGGEUM,0)                                   
    - (NVL(SUNP_AMT,0) - NVL(TAX_SUNP_IP_AMT,0) + NVL(IWOL_MIJUNGSAN,0)) AS SEIB_SUIP2,             
    NVL(GWAON_PROC_JI_AMT,0) AS SEIB_BANNAB2,             
    NVL(TAX_IP_CRT_IP_AMT,0) AS SEIB_GYEONGJEONG_IB2,             
    NVL(TAX_IP_CRT_JI_AMT,0) AS SEIB_GYEONGJEONG_JI2,             
    NVL(BIZPLC_BAEJUNG_JI_AMT,0) AS SECHUL_BAEJEONG2,             
    NVL(BIZPLC_GAM_BAEJUNG_IP_AMT,0) AS SECHUL_HWANSU2,             
    NVL(TAXO_JI_AMT,0) AS SECHUL_JI2,             
    NVL(TAXO_RTRN_AMT,0) AS SECHUL_BANNAB2,             
    NVL(KWA_CRRC_IP_AMT,0) AS SECHUL_GYEONGJEONG_IB2,             
    NVL(KWA_CRRC_JI_AMT,0) AS SECHUL_GYEONGJEONG_JI2,             
    NVL(GA_IWOL_IP_AMT,0) AS SEIB_GYULSANBF_IIB2,             
    NVL(GA_IWOL_JI_AMT,0) AS SECHUL_GYULSANBF_IWOL2,             
    NVL(DEP_MK_JI_AMT,0) + NVL(IWOL_GONGGEUM_DEP,0) AS DEP2,             
    NVL(DEP_HJI_AMT,0) AS HWANIB2,             
    NVL(SUNP_AMT,0) - NVL(TAX_SUNP_IP_AMT,0) + NVL(IWOL_MIJUNGSAN,0) AS MIICHE2 
 FROM
 (
  SELECT   
      C.SIGUMGO_HOIKYE_C AS HOIGYE_CODE    
     ,A.SIGUMGO_ORG_C
     ,SUM(TAX_SUNP_IP_AMT) AS TAX_SUNP_IP_AMT         --세입_수입입금
     ,SUM(TAX_BAEJUNG_IP_AMT) AS TAX_BAEJUNG_IP_AMT       --세입_배정입금 
     ,SUM(GWAON_PROC_JI_AMT) AS GWAON_PROC_JI_AMT      --세입_과오납반환
     ,SUM(TAX_IP_CRT_IP_AMT) AS TAX_IP_CRT_IP_AMT        --세입_과목경정입금
     ,SUM(TAX_IP_CRT_JI_AMT) AS TAX_IP_CRT_JI_AMT        --세입_과목경정지급
     ,SUM(BIZPLC_BAEJUNG_JI_AMT) AS BIZPLC_BAEJUNG_JI_AMT     --자금_배정         
     ,SUM(BIZPLC_GAM_BAEJUNG_IP_AMT) AS BIZPLC_GAM_BAEJUNG_IP_AMT  --자금_환수                    
    ,SUM(TAXO_FUND_BAEJUNG_JI_AMT)
     +SUM(TAXO_HNDO_BAEJUNG_JI_AMT)
     +SUM(TAXO_FUND_GETBK_JI_AMT)
     +SUM(TAXO_HNDO_JICHUL_JI_AMT)
     +SUM(TAXO_HNDO_GETBK_JI_AMT)  AS TAXO_JI_AMT      --세출_지급
    ,SUM(TAXO_RTRN_AMT) AS TAXO_RTRN_AMT         --세출_반환
    ,SUM(KWA_CRRC_IP_AMT) AS KWA_CRRC_IP_AMT        --세출_과목경정입금      
    ,SUM(KWA_CRRC_JI_AMT) AS KWA_CRRC_JI_AMT        --세출_과목경정지급
    ,SUM(GA_IWOL_IP_AMT) AS GA_IWOL_IP_AMT         --결산전이입
    ,SUM(GA_IWOL_JI_AMT) AS GA_IWOL_JI_AMT         --결산전이월
    ,SUM(DEP_MK_JI_AMT) AS DEP_MK_JI_AMT          --예금등
    ,SUM(DEP_HJI_AMT) AS DEP_HJI_AMT           -- 환입     
    ,0 AS SUNP_AMT                -- 세입_수납집계
    ,0 AS IWOL_GONGGEUM              -- 이월_수납액          
    ,0 AS IWOL_MIJUNGSAN              -- 이월_미이체액          
    ,0 AS IWOL_MMDA               -- 이월_MMDA
    ,0 AS IWOL_GONGGEUM_DEP             -- 이월_예금등 
  FROM RPT_TXIO_DDAC_TAB A,  ACL_SIGUMGO_MAS  B, RPT_AC_BY_HOIKYE_MAPP C
  WHERE  A.SGG_ACNO = B.FIL_100_CTNT2
  AND A.ICH_SIGUMGO_HOIKYE_C = B.ICH_SIGUMGO_HOIKYE_C
  AND A.SIGUMGO_ORG_C = B.SIGUMGO_ORG_C  
  AND B.FIL_100_CTNT2 = C.SIGUMGO_ACNO(+)
  AND B.SIGUMGO_HOIKYE_YR = C.SIGUMGO_HOIKYE_YR(+)
  AND B.SIGUMGO_ORG_C = C.SIGUMGO_C(+)    
  AND A.ICH_SIGUMGO_GUN_GU_C = '0'  
   AND CASE WHEN A.SIGUMGO_HOIKYE_YR = 9999 THEN TO_NUMBER(SUBSTR(A.BAS_DT,1,4))
                   ELSE TO_NUMBER(A.SIGUMGO_HOIKYE_YR) END  = '2024'
  AND A.BAS_DT BETWEEN SUBSTR('20240101',0,4)||'0101' AND '20240701'
  AND A.SIGUMGO_ORG_C = '440'
  AND B.MNG_NO = 1
  GROUP BY C.SIGUMGO_HOIKYE_C, A.SIGUMGO_ORG_C
  UNION ALL
  SELECT  TO_CHAR(ICH_SIGUMGO_HOIKYE_C) HOIGYE_CODE    
    ,A.SIGUMGO_ORG_C
    ,0 TAX_SUNP_IP_AMT         --세입_수입입금
    ,0 TAX_BAEJUNG_IP_AMT       --세입_배정입금 
    ,0 AS GWAON_PROC_JI_AMT       --세입_과오납반환
    ,0 AS TAX_IP_CRT_IP_AMT        --세입_과목경정입금
    ,0 AS TAX_IP_CRT_JI_AMT        --세입_과목경정지급
    ,0 AS BIZPLC_BAEJUNG_JI_AMT      --자금_배정         
    ,0 AS BIZPLC_GAM_BAEJUNG_IP_AMT     --자금환수                    
    ,0 TAXO_JI_AMT          --세출_지급
    ,0 AS TAXO_RTRN_AMT        --세출_반환
    ,0 AS KWA_CRRC_IP_AMT        --세출_과목경정입금      
    ,0 AS KWA_CRRC_JI_AMT        --세출_과목경정지급
    ,0 AS GA_IWOL_IP_AMT        --결산전이입
    ,0 AS GA_IWOL_JI_AMT        --결산전이월
    ,0 AS DEP_MK_JI_AMT        --예금등
    ,0 AS DEP_HJI_AMT         -- 환입     
    ,SUM(JIBANGSE_AMT)  AS SUNP_AMT     -- 세입수납집계
    ,0             -- 이월_수납액          
    ,0             -- 이월_미이체액          
    ,0             -- 이월_MMDA
    ,0             -- 이월_예금등     
   FROM   RPT_TXI_DDAC_TAB A
   WHERE  A.SIGUMGO_HOIKYE_YR = ( '2024' ) 
     AND A.SIGUMGO_ORG_C = '440'     
     AND A.SUNAP_DT BETWEEN SUBSTR('20240101',0,4)||'0101'AND '20240701'
     AND A.ICH_SIGUMGO_GUN_GU_C = 0    
     GROUP BY ICH_SIGUMGO_HOIKYE_C, A.SIGUMGO_ORG_C
  UNION ALL 
  SELECT  TO_CHAR(HOIGYE_CODE) HOIGYE_CODE    
    ,A.GEUMGO_CODE
    ,0 TAX_SUNP_IP_AMT         --세입_수입입금
    ,0 TAX_BAEJUNG_IP_AMT       --세입_배정입금 
    ,0 AS GWAON_PROC_JI_AMT       --세입_과오납반환
    ,0 AS TAX_IP_CRT_IP_AMT        --세입_과목경정입금
    ,0 AS TAX_IP_CRT_JI_AMT        --세입_과목경정지급
    ,0 AS BIZPLC_BAEJUNG_JI_AMT      --자금_배정         
    ,0 AS BIZPLC_GAM_BAEJUNG_IP_AMT     --자금환수                    
    ,0 TAXO_JI_AMT          --세출_지급
    ,0 AS TAXO_RTRN_AMT        --세출_반환
    ,0 AS KWA_CRRC_IP_AMT        --세출_과목경정입금      
    ,0 AS KWA_CRRC_JI_AMT        --세출_과목경정지급
    ,0 AS GA_IWOL_IP_AMT        --결산전이입
    ,0 AS GA_IWOL_JI_AMT        --결산전이월
    ,0 AS DEP_MK_JI_AMT        --예금등
    ,0 AS DEP_HJI_AMT         -- 환입     
    ,0             -- 세입수납집계
    ,SUM(CASE WHEN GUBUN_CODE = 1 THEN AMT1 ELSE 0 END)   -- 이월_수납액          
    ,SUM(CASE WHEN GUBUN_CODE = 5 THEN AMT1 ELSE 0 END)   -- 이월_미이체액          
    ,SUM(CASE WHEN GUBUN_CODE = 4 THEN AMT1 ELSE 0 END)   -- 이월_MMDA
    ,SUM(CASE WHEN GUBUN_CODE = 2 THEN AMT1 ELSE 0 END)   -- 이월_예금등    
    FROM   RPT_HOIGYE_IWOL A
   WHERE  A.HOIGYE_YEAR = ( '2024' - 1 ) 
     AND A.GEUMGO_CODE = '440'
     AND A.GUBUN_CODE IN (1, 2, 4, 5)
     AND A.KIJUNIL BETWEEN SUBSTR('20240101',0,4)||'0101' AND '20240701'
     AND A.GUNGU_CODE = 0     
     GROUP BY HOIGYE_CODE, A.GEUMGO_CODE
 )
) AA, RPT_HOIKYE_CD BB
WHERE AA.SIGUMGO_ORG_C(+) = BB.SIGUMGO_C
AND AA.HOIGYE_CODE(+) = BB.SIGUMGO_HOIKYE_C
  AND BB.SIGUMGO_HOIKYE_C IN(
      
       '3'
       
         )
   
AND BB.SIGUMGO_C = '440'
AND BB.USE_YN = 'Y'
GROUP BY BB.SIGUMGO_HOIKYE_C, BB.HOIKYE_NM
ORDER BY TO_NUMBER(BB.SIGUMGO_HOIKYE_C), BB.HOIKYE_NM


----------------------------------------------------------------------

select * from RPT_SUNAP_JIBGYE
where GEUMGO_CODE = '440'
and sunapil like '2024%'


------------------------------------------------------------------------------

SELECT  BB.SIGUMGO_HOIKYE_C,
  BB.HOIKYE_NM NUGYE_HOIGYE_NAME,
  NVL(SUM(SEIB_SUIP2),0) NUGYE_SEIB_SUIP,
  NVL(SUM(SEIB_BANNAB2),0) NUGYE_SEIB_BANNAB,
  NVL(SUM(SEIB_GYEONGJEONG_IB2),0) NUGYE_SEIB_GYEONGJEONG_IB,
  NVL(SUM(SEIB_GYEONGJEONG_JI2)*-1,0) NUGYE_SEIB_GYEONGJEONG_JI,
  NVL(SUM(SECHUL_BAEJEONG2),0) NUGYE_SECHUL_BAEJEONG,
  NVL(SUM(SECHUL_HWANSU2)*-1,0) NUGYE_SECHUL_HWANSU,
  NVL(SUM(SECHUL_JI2),0) NUGYE_SECHUL_JI,
  NVL(SUM(SECHUL_BANNAB2)*-1,0) NUGYE_SECHUL_BANNAB,
  NVL(SUM(SECHUL_GYEONGJEONG_IB2),0) NUGYE_SECHUL_GYEONGJEONG_IB,
  NVL(SUM(SECHUL_GYEONGJEONG_JI2),0) NUGYE_SECHUL_GYEONGJEONG_JI,
  NVL(SUM(SEIB_GYULSANBF_IIB2),0) NUGYE_SEIB_GYULSANBF_IIB,
  NVL(SUM(SECHUL_GYULSANBF_IWOL2),0) NUGYE_SECHUL_GYULSANBF_IWOL,
  NVL(SUM(DEP2),0) NUGYE_DEP,
  NVL(SUM(HWANIB2),0) NUGYE_HWANIB,
  NVL(SUM(MIICHE2),0) NUGYE_MIICHE,
  NVL(SUM(SEIB_SUIP),0) ILGYE_SEIB_SUIP,
  NVL(SUM(SEIB_BANNAB),0) ILGYE_SEIB_BANNAB,
  NVL(SUM(SEIB_GYEONGJEONG_IB),0) ILGYE_SEIB_GYEONGJEONG_IB,
  NVL(SUM(SEIB_GYEONGJEONG_JI)*-1,0) ILGYE_SEIB_GYEONGJEONG_JI,
  NVL(SUM(SECHUL_BAEJEONG),0) ILGYE_SECHUL_BAEJEONG,
  NVL(SUM(SECHUL_HWANSU)*-1,0) ILGYE_SECHUL_HWANSU,
  NVL(SUM(SECHUL_JI),0) ILGYE_SECHUL_JI,
  NVL(SUM(SECHUL_BANNAB)*-1,0) ILGYE_SECHUL_BANNAB,
  NVL(SUM(SECHUL_GYEONGJEONG_IB),0) ILGYE_SECHUL_GYEONGJEONG_IB,
  NVL(SUM(SECHUL_GYEONGJEONG_JI),0) ILGYE_SECHUL_GYEONGJEONG_JI,
  NVL(SUM(SEIB_GYULSANBF_IIB),0) ILGYE_SEIB_GYULSANBF_IIB,
  NVL(SUM(SECHUL_GYULSANBF_IWOL),0) ILGYE_SECHUL_GYULSANBF_IWOL,
  NVL(SUM(DEP),0) ILGYE_DEP,
  NVL(SUM(HWANIB),0) ILGYE_HWANIB,
  NVL(SUM(MIICHE),0) ILGYE_MIICHE  
FROM
(
 SELECT   
     HOIGYE_CODE,
     SIGUMGO_ORG_C,
     NVL(SUNP_AMT,0) + NVL(TAX_BAEJUNG_IP_AMT,0) + NVL(IWOL_GONGGEUM,0)                                   
    - (NVL(SUNP_AMT,0) - NVL(TAX_SUNP_IP_AMT,0) + NVL(IWOL_MIJUNGSAN,0)) AS SEIB_SUIP,             
    NVL(GWAON_PROC_JI_AMT,0) AS SEIB_BANNAB,             
    NVL(TAX_IP_CRT_IP_AMT,0) AS SEIB_GYEONGJEONG_IB,             
    NVL(TAX_IP_CRT_JI_AMT,0) AS SEIB_GYEONGJEONG_JI,             
    NVL(BIZPLC_BAEJUNG_JI_AMT,0) AS SECHUL_BAEJEONG,             
    NVL(BIZPLC_GAM_BAEJUNG_IP_AMT,0) AS SECHUL_HWANSU,             
    NVL(TAXO_JI_AMT,0) AS SECHUL_JI,             
    NVL(TAXO_RTRN_AMT,0) AS SECHUL_BANNAB,             
    NVL(KWA_CRRC_IP_AMT,0) AS SECHUL_GYEONGJEONG_IB,             
    NVL(KWA_CRRC_JI_AMT,0) AS SECHUL_GYEONGJEONG_JI,             
    NVL(GA_IWOL_IP_AMT,0) AS SEIB_GYULSANBF_IIB,             
    NVL(GA_IWOL_JI_AMT,0) AS SECHUL_GYULSANBF_IWOL,             
    NVL(DEP_MK_JI_AMT,0) + NVL(IWOL_GONGGEUM_DEP,0) AS DEP,             
    NVL(DEP_HJI_AMT,0) AS HWANIB,             
    NVL(SUNP_AMT,0) - NVL(TAX_SUNP_IP_AMT,0) + NVL(IWOL_MIJUNGSAN,0) AS MIICHE,   
    0 AS SEIB_SUIP2,             
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
    0 AS HWANIB2,             
    0 AS MIICHE2   
 FROM
 (
  SELECT   
      C.SIGUMGO_HOIKYE_C AS HOIGYE_CODE    
     ,A.SIGUMGO_ORG_C
     ,SUM(TAX_SUNP_IP_AMT) AS TAX_SUNP_IP_AMT         --세입_수입입금
     ,SUM(TAX_BAEJUNG_IP_AMT) TAX_BAEJUNG_IP_AMT       --세입_배정입금 
     ,SUM(GWAON_PROC_JI_AMT) AS GWAON_PROC_JI_AMT      --세입_과오납반환
     ,SUM(TAX_IP_CRT_IP_AMT) AS TAX_IP_CRT_IP_AMT        --세입_과목경정입금
     ,SUM(TAX_IP_CRT_JI_AMT) AS TAX_IP_CRT_JI_AMT        --세입_과목경정지급
     ,SUM(BIZPLC_BAEJUNG_JI_AMT) AS BIZPLC_BAEJUNG_JI_AMT     --자금_배정         
     ,SUM(BIZPLC_GAM_BAEJUNG_IP_AMT) AS BIZPLC_GAM_BAEJUNG_IP_AMT  --자금_환수                    
    ,SUM(TAXO_FUND_BAEJUNG_JI_AMT)
     +SUM(TAXO_HNDO_BAEJUNG_JI_AMT)
     +SUM(TAXO_FUND_GETBK_JI_AMT)
     +SUM(TAXO_HNDO_JICHUL_JI_AMT)
     +SUM(TAXO_HNDO_GETBK_JI_AMT)  AS TAXO_JI_AMT      --세출_지급
    ,SUM(TAXO_RTRN_AMT) AS TAXO_RTRN_AMT         --세출_반환
    ,SUM(KWA_CRRC_IP_AMT) AS KWA_CRRC_IP_AMT        --세출_과목경정입금      
    ,SUM(KWA_CRRC_JI_AMT) AS KWA_CRRC_JI_AMT        --세출_과목경정지급
    ,SUM(GA_IWOL_IP_AMT) AS GA_IWOL_IP_AMT         --결산전이입
    ,SUM(GA_IWOL_JI_AMT) AS GA_IWOL_JI_AMT         --결산전이월
    ,SUM(DEP_MK_JI_AMT) AS DEP_MK_JI_AMT          --예금등
    ,SUM(DEP_HJI_AMT) AS DEP_HJI_AMT           -- 환입     
    ,0 AS SUNP_AMT                -- 세입_수납집계
    ,0 AS IWOL_GONGGEUM              -- 이월_수납액          
    ,0 AS IWOL_MIJUNGSAN              -- 이월_미이체액          
    ,0 AS IWOL_MMDA               -- 이월_MMDA
    ,0 AS IWOL_GONGGEUM_DEP             -- 이월_예금등     
  FROM RPT_TXIO_DDAC_TAB A,  ACL_SIGUMGO_MAS  B, RPT_AC_BY_HOIKYE_MAPP C
  WHERE  A.SGG_ACNO = B.FIL_100_CTNT2
  AND A.ICH_SIGUMGO_HOIKYE_C = B.ICH_SIGUMGO_HOIKYE_C
  AND A.SIGUMGO_ORG_C = B.SIGUMGO_ORG_C  
  AND B.FIL_100_CTNT2 = C.SIGUMGO_ACNO(+)
  AND B.SIGUMGO_HOIKYE_YR = C.SIGUMGO_HOIKYE_YR(+)
  AND B.SIGUMGO_ORG_C = C.SIGUMGO_C(+)    
  AND A.ICH_SIGUMGO_GUN_GU_C = '0' 
 AND CASE WHEN A.SIGUMGO_HOIKYE_YR = 9999 THEN TO_NUMBER(SUBSTR(A.BAS_DT,1,4))
                   ELSE TO_NUMBER(A.SIGUMGO_HOIKYE_YR) END  = '2024'
  AND A.BAS_DT BETWEEN '20240513' AND '20240513' 
  AND A.SIGUMGO_ORG_C  = '440'
  AND B.MNG_NO = 1
  GROUP BY C.SIGUMGO_HOIKYE_C, A.SIGUMGO_ORG_C
  UNION ALL
  SELECT  TO_CHAR(ICH_SIGUMGO_HOIKYE_C) HOIGYE_CODE    
    ,A.SIGUMGO_ORG_C
    ,0 TAX_SUNP_IP_AMT         --세입_수입입금
    ,0 TAX_BAEJUNG_IP_AMT       --세입_배정입금 
    ,0 AS GWAON_PROC_JI_AMT       --세입_과오납반환
    ,0 AS TAX_IP_CRT_IP_AMT        --세입_과목경정입금
    ,0 AS TAX_IP_CRT_JI_AMT        --세입_과목경정지급
    ,0 AS BIZPLC_BAEJUNG_JI_AMT      --자금_배정         
    ,0 AS BIZPLC_GAM_BAEJUNG_IP_AMT     --자금환수                    
    ,0 TAXO_JI_AMT          --세출_지급
    ,0 AS TAXO_RTRN_AMT        --세출_반환
    ,0 AS KWA_CRRC_IP_AMT        --세출_과목경정입금      
    ,0 AS KWA_CRRC_JI_AMT        --세출_과목경정지급
    ,0 AS GA_IWOL_IP_AMT        --결산전이입
    ,0 AS GA_IWOL_JI_AMT        --결산전이월
    ,0 AS DEP_MK_JI_AMT        --예금등
    ,0 AS DEP_HJI_AMT         -- 환입     
    ,SUM(JIBANGSE_AMT)  AS SUNP_AMT     -- 세입수납집계
    ,0             -- 이월_수납액          
    ,0             -- 이월_미이체액          
    ,0             -- 이월_MMDA
    ,0             -- 이월_예금등     
   FROM   RPT_TXI_DDAC_TAB A
   WHERE  A.SIGUMGO_HOIKYE_YR = ( '2024' ) 
     AND A.SIGUMGO_ORG_C = '440'
     AND A.SUNAP_DT BETWEEN '20240513' AND '20240513'
     AND A.ICH_SIGUMGO_GUN_GU_C = 0    
     GROUP BY ICH_SIGUMGO_HOIKYE_C, A.SIGUMGO_ORG_C
  UNION ALL
  SELECT  TO_CHAR(HOIGYE_CODE) HOIGYE_CODE    
    ,GEUMGO_CODE
    ,0 TAX_SUNP_IP_AMT         --세입_수입입금
    ,0 TAX_BAEJUNG_IP_AMT       --세입_배정입금 
    ,0 AS GWAON_PROC_JI_AMT       --세입_과오납반환
    ,0 AS TAX_IP_CRT_IP_AMT        --세입_과목경정입금
    ,0 AS TAX_IP_CRT_JI_AMT        --세입_과목경정지급
    ,0 AS BIZPLC_BAEJUNG_JI_AMT      --자금_배정         
    ,0 AS BIZPLC_GAM_BAEJUNG_IP_AMT     --자금환수                    
    ,0 TAXO_JI_AMT          --세출_지급
    ,0 AS TAXO_RTRN_AMT        --세출_반환
    ,0 AS KWA_CRRC_IP_AMT        --세출_과목경정입금      
    ,0 AS KWA_CRRC_JI_AMT        --세출_과목경정지급
    ,0 AS GA_IWOL_IP_AMT        --결산전이입
    ,0 AS GA_IWOL_JI_AMT        --결산전이월
    ,0 AS DEP_MK_JI_AMT        --예금등
    ,0 AS DEP_HJI_AMT         -- 환입     
    ,0             -- 세입수납집계
    ,SUM(CASE WHEN GUBUN_CODE = 1 THEN AMT1 ELSE 0 END)   -- 이월_수납액          
    ,SUM(CASE WHEN GUBUN_CODE = 5 THEN AMT1 ELSE 0 END)   -- 이월_미이체액          
    ,SUM(CASE WHEN GUBUN_CODE = 4 THEN AMT1 ELSE 0 END)   -- 이월_MMDA
    ,SUM(CASE WHEN GUBUN_CODE = 2 THEN AMT1 ELSE 0 END)   -- 이월_예금등    
   FROM   RPT_HOIGYE_IWOL A
   WHERE  A.HOIGYE_YEAR = ( '2024' - 1 ) 
     AND A.GEUMGO_CODE = '440'            
     AND A.GUBUN_CODE IN (1, 2, 4, 5)  
     AND A.KIJUNIL BETWEEN '20240513' AND '20240513'   
     AND A.GUNGU_CODE = 0     
     GROUP BY HOIGYE_CODE, GEUMGO_CODE
 ) 
 UNION ALL 
 --누계
 SELECT   
    HOIGYE_CODE,    
    SIGUMGO_ORG_C,
    0 AS SEIB_SUIP,             
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
    0 AS HWANIB,             
    0 AS MIICHE, 
    NVL(SUNP_AMT,0) + NVL(TAX_BAEJUNG_IP_AMT,0) + NVL(IWOL_GONGGEUM,0)                                   
    - (NVL(SUNP_AMT,0) - NVL(TAX_SUNP_IP_AMT,0) + NVL(IWOL_MIJUNGSAN,0)) AS SEIB_SUIP2,             
    NVL(GWAON_PROC_JI_AMT,0) AS SEIB_BANNAB2,             
    NVL(TAX_IP_CRT_IP_AMT,0) AS SEIB_GYEONGJEONG_IB2,             
    NVL(TAX_IP_CRT_JI_AMT,0) AS SEIB_GYEONGJEONG_JI2,             
    NVL(BIZPLC_BAEJUNG_JI_AMT,0) AS SECHUL_BAEJEONG2,             
    NVL(BIZPLC_GAM_BAEJUNG_IP_AMT,0) AS SECHUL_HWANSU2,             
    NVL(TAXO_JI_AMT,0) AS SECHUL_JI2,             
    NVL(TAXO_RTRN_AMT,0) AS SECHUL_BANNAB2,             
    NVL(KWA_CRRC_IP_AMT,0) AS SECHUL_GYEONGJEONG_IB2,             
    NVL(KWA_CRRC_JI_AMT,0) AS SECHUL_GYEONGJEONG_JI2,             
    NVL(GA_IWOL_IP_AMT,0) AS SEIB_GYULSANBF_IIB2,             
    NVL(GA_IWOL_JI_AMT,0) AS SECHUL_GYULSANBF_IWOL2,             
    NVL(DEP_MK_JI_AMT,0) + NVL(IWOL_GONGGEUM_DEP,0) AS DEP2,             
    NVL(DEP_HJI_AMT,0) AS HWANIB2,             
    NVL(SUNP_AMT,0) - NVL(TAX_SUNP_IP_AMT,0) + NVL(IWOL_MIJUNGSAN,0) AS MIICHE2 
 FROM
 (
  SELECT   
      C.SIGUMGO_HOIKYE_C AS HOIGYE_CODE    
     ,A.SIGUMGO_ORG_C
     ,SUM(TAX_SUNP_IP_AMT) AS TAX_SUNP_IP_AMT         --세입_수입입금
     ,SUM(TAX_BAEJUNG_IP_AMT) AS TAX_BAEJUNG_IP_AMT       --세입_배정입금 
     ,SUM(GWAON_PROC_JI_AMT) AS GWAON_PROC_JI_AMT      --세입_과오납반환
     ,SUM(TAX_IP_CRT_IP_AMT) AS TAX_IP_CRT_IP_AMT        --세입_과목경정입금
     ,SUM(TAX_IP_CRT_JI_AMT) AS TAX_IP_CRT_JI_AMT        --세입_과목경정지급
     ,SUM(BIZPLC_BAEJUNG_JI_AMT) AS BIZPLC_BAEJUNG_JI_AMT     --자금_배정         
     ,SUM(BIZPLC_GAM_BAEJUNG_IP_AMT) AS BIZPLC_GAM_BAEJUNG_IP_AMT  --자금_환수                    
    ,SUM(TAXO_FUND_BAEJUNG_JI_AMT)
     +SUM(TAXO_HNDO_BAEJUNG_JI_AMT)
     +SUM(TAXO_FUND_GETBK_JI_AMT)
     +SUM(TAXO_HNDO_JICHUL_JI_AMT)
     +SUM(TAXO_HNDO_GETBK_JI_AMT)  AS TAXO_JI_AMT      --세출_지급
    ,SUM(TAXO_RTRN_AMT) AS TAXO_RTRN_AMT         --세출_반환
    ,SUM(KWA_CRRC_IP_AMT) AS KWA_CRRC_IP_AMT        --세출_과목경정입금      
    ,SUM(KWA_CRRC_JI_AMT) AS KWA_CRRC_JI_AMT        --세출_과목경정지급
    ,SUM(GA_IWOL_IP_AMT) AS GA_IWOL_IP_AMT         --결산전이입
    ,SUM(GA_IWOL_JI_AMT) AS GA_IWOL_JI_AMT         --결산전이월
    ,SUM(DEP_MK_JI_AMT) AS DEP_MK_JI_AMT          --예금등
    ,SUM(DEP_HJI_AMT) AS DEP_HJI_AMT           -- 환입     
    ,0 AS SUNP_AMT                -- 세입_수납집계
    ,0 AS IWOL_GONGGEUM              -- 이월_수납액          
    ,0 AS IWOL_MIJUNGSAN              -- 이월_미이체액          
    ,0 AS IWOL_MMDA               -- 이월_MMDA
    ,0 AS IWOL_GONGGEUM_DEP             -- 이월_예금등 
  FROM RPT_TXIO_DDAC_TAB A,  ACL_SIGUMGO_MAS  B, RPT_AC_BY_HOIKYE_MAPP C
  WHERE  A.SGG_ACNO = B.FIL_100_CTNT2
  AND A.ICH_SIGUMGO_HOIKYE_C = B.ICH_SIGUMGO_HOIKYE_C
  AND A.SIGUMGO_ORG_C = B.SIGUMGO_ORG_C  
  AND B.FIL_100_CTNT2 = C.SIGUMGO_ACNO(+)
  AND B.SIGUMGO_HOIKYE_YR = C.SIGUMGO_HOIKYE_YR(+)
  AND B.SIGUMGO_ORG_C = C.SIGUMGO_C(+)    
  AND A.ICH_SIGUMGO_GUN_GU_C = '0'  
   AND CASE WHEN A.SIGUMGO_HOIKYE_YR = 9999 THEN TO_NUMBER(SUBSTR(A.BAS_DT,1,4))
                   ELSE TO_NUMBER(A.SIGUMGO_HOIKYE_YR) END  = '2024'
  AND A.BAS_DT BETWEEN SUBSTR('20240101',0,4)||'0101' AND '20240513'
  AND A.SIGUMGO_ORG_C = '440'
  AND B.MNG_NO = 1
  GROUP BY C.SIGUMGO_HOIKYE_C, A.SIGUMGO_ORG_C
  UNION ALL
  SELECT  TO_CHAR(ICH_SIGUMGO_HOIKYE_C) HOIGYE_CODE    
    ,A.SIGUMGO_ORG_C
    ,0 TAX_SUNP_IP_AMT         --세입_수입입금
    ,0 TAX_BAEJUNG_IP_AMT       --세입_배정입금 
    ,0 AS GWAON_PROC_JI_AMT       --세입_과오납반환
    ,0 AS TAX_IP_CRT_IP_AMT        --세입_과목경정입금
    ,0 AS TAX_IP_CRT_JI_AMT        --세입_과목경정지급
    ,0 AS BIZPLC_BAEJUNG_JI_AMT      --자금_배정         
    ,0 AS BIZPLC_GAM_BAEJUNG_IP_AMT     --자금환수                    
    ,0 TAXO_JI_AMT          --세출_지급
    ,0 AS TAXO_RTRN_AMT        --세출_반환
    ,0 AS KWA_CRRC_IP_AMT        --세출_과목경정입금      
    ,0 AS KWA_CRRC_JI_AMT        --세출_과목경정지급
    ,0 AS GA_IWOL_IP_AMT        --결산전이입
    ,0 AS GA_IWOL_JI_AMT        --결산전이월
    ,0 AS DEP_MK_JI_AMT        --예금등
    ,0 AS DEP_HJI_AMT         -- 환입     
    ,SUM(JIBANGSE_AMT)  AS SUNP_AMT     -- 세입수납집계
    ,0             -- 이월_수납액          
    ,0             -- 이월_미이체액          
    ,0             -- 이월_MMDA
    ,0             -- 이월_예금등     
   FROM   RPT_TXI_DDAC_TAB A
   WHERE  A.SIGUMGO_HOIKYE_YR = ( '2024' ) 
     AND A.SIGUMGO_ORG_C = '440'     
     AND A.SUNAP_DT BETWEEN SUBSTR('20240101',0,4)||'0101'AND '20240513'
     AND A.ICH_SIGUMGO_GUN_GU_C = 0    
     GROUP BY ICH_SIGUMGO_HOIKYE_C, A.SIGUMGO_ORG_C
  UNION ALL 
  SELECT  TO_CHAR(HOIGYE_CODE) HOIGYE_CODE    
    ,A.GEUMGO_CODE
    ,0 TAX_SUNP_IP_AMT         --세입_수입입금
    ,0 TAX_BAEJUNG_IP_AMT       --세입_배정입금 
    ,0 AS GWAON_PROC_JI_AMT       --세입_과오납반환
    ,0 AS TAX_IP_CRT_IP_AMT        --세입_과목경정입금
    ,0 AS TAX_IP_CRT_JI_AMT        --세입_과목경정지급
    ,0 AS BIZPLC_BAEJUNG_JI_AMT      --자금_배정         
    ,0 AS BIZPLC_GAM_BAEJUNG_IP_AMT     --자금환수                    
    ,0 TAXO_JI_AMT          --세출_지급
    ,0 AS TAXO_RTRN_AMT        --세출_반환
    ,0 AS KWA_CRRC_IP_AMT        --세출_과목경정입금      
    ,0 AS KWA_CRRC_JI_AMT        --세출_과목경정지급
    ,0 AS GA_IWOL_IP_AMT        --결산전이입
    ,0 AS GA_IWOL_JI_AMT        --결산전이월
    ,0 AS DEP_MK_JI_AMT        --예금등
    ,0 AS DEP_HJI_AMT         -- 환입     
    ,0             -- 세입수납집계
    ,SUM(CASE WHEN GUBUN_CODE = 1 THEN AMT1 ELSE 0 END)   -- 이월_수납액          
    ,SUM(CASE WHEN GUBUN_CODE = 5 THEN AMT1 ELSE 0 END)   -- 이월_미이체액          
    ,SUM(CASE WHEN GUBUN_CODE = 4 THEN AMT1 ELSE 0 END)   -- 이월_MMDA
    ,SUM(CASE WHEN GUBUN_CODE = 2 THEN AMT1 ELSE 0 END)   -- 이월_예금등    
    FROM   RPT_HOIGYE_IWOL A
   WHERE  A.HOIGYE_YEAR = ( '2024' - 1 ) 
     AND A.GEUMGO_CODE = '440'
     AND A.GUBUN_CODE IN (1, 2, 4, 5)
     AND A.KIJUNIL BETWEEN SUBSTR('20240101',0,4)||'0101' AND '20240513'
     AND A.GUNGU_CODE = 0     
     GROUP BY HOIGYE_CODE, A.GEUMGO_CODE
 )
) AA, RPT_HOIKYE_CD BB
WHERE AA.SIGUMGO_ORG_C(+) = BB.SIGUMGO_C
AND AA.HOIGYE_CODE(+) = BB.SIGUMGO_HOIKYE_C
  AND BB.SIGUMGO_HOIKYE_C IN(
      
       '9'
       
         )
   
AND BB.SIGUMGO_C = '440'
AND BB.USE_YN = 'Y'
GROUP BY BB.SIGUMGO_HOIKYE_C, BB.HOIKYE_NM
ORDER BY TO_NUMBER(BB.SIGUMGO_HOIKYE_C), BB.HOIKYE_NM

--------------------------------------------------------------------

  SELECT  TO_CHAR(ICH_SIGUMGO_HOIKYE_C) HOIGYE_CODE    
    ,A.SIGUMGO_ORG_C
    ,0 TAX_SUNP_IP_AMT         --세입_수입입금
    ,0 TAX_BAEJUNG_IP_AMT       --세입_배정입금 
    ,0 AS GWAON_PROC_JI_AMT       --세입_과오납반환
    ,0 AS TAX_IP_CRT_IP_AMT        --세입_과목경정입금
    ,0 AS TAX_IP_CRT_JI_AMT        --세입_과목경정지급
    ,0 AS BIZPLC_BAEJUNG_JI_AMT      --자금_배정         
    ,0 AS BIZPLC_GAM_BAEJUNG_IP_AMT     --자금환수                    
    ,0 TAXO_JI_AMT          --세출_지급
    ,0 AS TAXO_RTRN_AMT        --세출_반환
    ,0 AS KWA_CRRC_IP_AMT        --세출_과목경정입금      
    ,0 AS KWA_CRRC_JI_AMT        --세출_과목경정지급
    ,0 AS GA_IWOL_IP_AMT        --결산전이입
    ,0 AS GA_IWOL_JI_AMT        --결산전이월
    ,0 AS DEP_MK_JI_AMT        --예금등
    ,0 AS DEP_HJI_AMT         -- 환입     
    ,SUM(JIBANGSE_AMT)  AS SUNP_AMT     -- 세입수납집계
    ,0             -- 이월_수납액          
    ,0             -- 이월_미이체액          
    ,0             -- 이월_MMDA
    ,0             -- 이월_예금등     
   FROM   RPT_TXI_DDAC_TAB A
   WHERE  A.SIGUMGO_HOIKYE_YR = ( '2024' ) 
     AND A.SIGUMGO_ORG_C = '440'
     AND A.SUNAP_DT BETWEEN '20240513' AND '20240513'
     AND A.ICH_SIGUMGO_GUN_GU_C = 0    
     GROUP BY ICH_SIGUMGO_HOIKYE_C, A.SIGUMGO_ORG_C


-----------------------------------------------------------------------


select * from RPT_TXI_DDAC_TAB
where sigumgo_hoikye_yr = 2024
and SUNAP_DT = '20240513'
and SIGUMGO_ORG_C = '440'

select * from RPT_SUNAP_JIBGYE
where GEUMGO_CODE = '440'
and sunapil = '20240513'

select * from RPT_SUNAP_JIBGYE
where 1=1
and GEUMGO_CODE in ('440', '110')
and sunapil like '2024%'