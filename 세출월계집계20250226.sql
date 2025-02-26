
SELECT
    SGG_ACNO
     , NVL(BAS_DT,' ') BAS_DT
     , PROC_DT
     , NVL(GISDT,' ') GISDT
     , ROW_NUMBER() OVER(PARTITION BY  SGG_ACNO, BAS_DT, PROC_DT ,GISDT  ORDER BY SGG_ACNO, BAS_DT, PROC_DT ,GISDT) DR_SNO       
       , SIGUMGO_ORG_C
     , ICH_SIGUMGO_GUN_GU_C
     , ICH_SIGUMGO_HOIKYE_C
     , SIGUMGO_AC_B
     , SIGUMGO_HOIKYE_YR
     , DECODE(SIGUMGO_HOIKYE_YR,9999,'1', DECODE(SUBSTR(PROC_DT,0,4),  SIGUMGO_HOIKYE_YR, '1', '9')) NEW_GU_YR_G
     , SIGUTAX_G
     , 0 MNGBR
     , SUM(THMM_BAEJUNG_AMT) OVER(PARTITION BY SGG_ACNO ORDER BY BAS_DT, GISDT, PROC_DT) AS BAEJUNG_TOT_AMT                                                                       
       , SUM(HNDO_BAEJUNG_AMT) OVER(PARTITION BY SGG_ACNO ORDER BY BAS_DT, GISDT, PROC_DT) AS HNDO_BAEJUNG_TOT_AMT                                                 
       , SUM(THMM_BAEJUNG_AMT) OVER(PARTITION BY SGG_ACNO ORDER BY BAS_DT, GISDT, PROC_DT) 
            - SUM(THMM_BAEJUNG_AMT) OVER(PARTITION BY SUBSTR(BAS_DT,0,6), SGG_ACNO ORDER BY BAS_DT, GISDT, PROC_DT) AS BFMM_BAEJUNG_AMT                    
       , SUM(THMM_BAEJUNG_AMT) OVER(PARTITION BY SUBSTR(BAS_DT,0,6), SGG_ACNO ORDER BY BAS_DT, GISDT, PROC_DT) AS THMM_BAEJUNG_AMT                         
       , SUM(THMM_BAEJUNG_AMT) OVER(PARTITION BY SGG_ACNO ORDER BY BAS_DT, GISDT, PROC_DT) 
            -SUM(HNDO_BAEJUNG_AMT) OVER(PARTITION BY SUBSTR(BAS_DT,0,6), SGG_ACNO ORDER BY BAS_DT, GISDT, PROC_DT) AS BFMM_HNDO_BAEJUNG_AMT              
       , SUM(HNDO_BAEJUNG_AMT) OVER(PARTITION BY SUBSTR(BAS_DT,0,6), SGG_ACNO ORDER BY BAS_DT, GISDT, PROC_DT) AS THMM_HNDO_BAEJUNG_AMT        
       , SUM(BFMM_JI_AMT) OVER(PARTITION BY SGG_ACNO ORDER BY BAS_DT, GISDT, PROC_DT)
             -SUM(THMM_JI_AMT) OVER(PARTITION BY SUBSTR(BAS_DT,0,6), SGG_ACNO ORDER BY BAS_DT, GISDT, PROC_DT)
             +CASE WHEN SIGUMGO_ORG_C IN('28') THEN SUM(THMM_RTRN_AMT) OVER(PARTITION BY SGG_ACNO ORDER BY BAS_DT, GISDT, PROC_DT) ELSE 0 END AS BFMM_JI_AMT               
        , SUM(THMM_JI_AMT) OVER(PARTITION BY SUBSTR(BAS_DT,0,6), SGG_ACNO ORDER BY BAS_DT, GISDT, PROC_DT) AS THMM_JI_AMT                                                      
        , SUM(BFMM_HNDO_JI_AMT) OVER(PARTITION BY SGG_ACNO ORDER BY BAS_DT, GISDT, PROC_DT)
             -SUM(BFMM_HNDO_JI_AMT) OVER(PARTITION BY SUBSTR(BAS_DT,0,6), SGG_ACNO ORDER BY BAS_DT, GISDT, PROC_DT) AS BFMM_HNDO_JI_AMT                               
        , SUM(THMM_HNDO_JI_AMT) OVER(PARTITION BY SUBSTR(BAS_DT,0,6), SGG_ACNO ORDER BY BAS_DT, GISDT, PROC_DT) AS THMM_HNDO_JI_AMT                            
        , SUM(THMM_RTRN_AMT) OVER(PARTITION BY SGG_ACNO ORDER BY BAS_DT, GISDT, PROC_DT)
             -SUM(THMM_RTRN_AMT) OVER(PARTITION BY SUBSTR(BAS_DT,0,6), SGG_ACNO ORDER BY BAS_DT, GISDT, PROC_DT) AS BFMM_RTRN_AMT                      
        , SUM(THMM_RTRN_AMT) OVER(PARTITION BY SUBSTR(BAS_DT,0,6), SGG_ACNO ORDER BY BAS_DT, GISDT, PROC_DT) AS THMM_RTRN_AMT                                          
        , SUM(HNDO_RTRN_AMT) OVER(PARTITION BY SGG_ACNO ORDER BY BAS_DT, GISDT, PROC_DT)
             -SUM(HNDO_RTRN_AMT) OVER(PARTITION BY SUBSTR(BAS_DT,0,6), SGG_ACNO ORDER BY BAS_DT, GISDT, PROC_DT) AS BFMM_HNDO_RTRN_AMT   
        , SUM(HNDO_RTRN_AMT) OVER(PARTITION BY SUBSTR(BAS_DT,0,6), SGG_ACNO ORDER BY BAS_DT, GISDT, PROC_DT) AS THMM_HNDO_RTRN_AMT                     
        , SUM(CRRC_IP_AMT) OVER(PARTITION BY SGG_ACNO ORDER BY BAS_DT, GISDT, PROC_DT) 
             -SUM(CRRC_IP_AMT) OVER(PARTITION BY SUBSTR(BAS_DT,0,6), SGG_ACNO ORDER BY BAS_DT, GISDT, PROC_DT) AS BFMM_CRRC_IP_AMT                                                                                  
       , SUM(CRRC_IP_AMT) OVER(PARTITION BY SUBSTR(BAS_DT,0,6), SGG_ACNO ORDER BY BAS_DT, GISDT, PROC_DT) AS THMM_CRRC_IP_AMT                                     
       , SUM(CRRC_JI_AMT) OVER(PARTITION BY SGG_ACNO ORDER BY GISDT) 
             -SUM(CRRC_JI_AMT) OVER(PARTITION BY SUBSTR(BAS_DT,0,6), SGG_ACNO ORDER BY BAS_DT, GISDT, PROC_DT) AS BFMM_CRRC_JI_AMT                                     
       , SUM(CRRC_JI_AMT) OVER(PARTITION BY SUBSTR(BAS_DT,0,6), SGG_ACNO ORDER BY BAS_DT, GISDT, PROC_DT) AS THMM_CRRC_JI_AMT                                        
       , SUM(FUND_RTRN_AMT) OVER(PARTITION BY SGG_ACNO ORDER BY BAS_DT, GISDT, PROC_DT)
             -SUM(FUND_RTRN_AMT) OVER(PARTITION BY SUBSTR(BAS_DT,0,6), SGG_ACNO ORDER BY BAS_DT, GISDT, PROC_DT) AS BFMM_FUND_RTRN_AMT                      
       , SUM(FUND_RTRN_AMT) OVER(PARTITION BY SUBSTR(BAS_DT,0,6), SGG_ACNO ORDER BY GISDT) AS THMM_FUND_RTRN_AMT                              
       , SUM(KS_TRNS_IWOL_AMT) OVER(PARTITION BY SGG_ACNO ORDER BY BAS_DT, GISDT, PROC_DT) 
             -SUM(KS_TRNS_IWOL_AMT) OVER(PARTITION BY SUBSTR(BAS_DT,0,6), SGG_ACNO ORDER BY BAS_DT, GISDT, PROC_DT) AS BFMM_KS_TRNS_IWOL_AMT           
       , SUM(KS_TRNS_IWOL_AMT) OVER(PARTITION BY SUBSTR(BAS_DT,0,6), SGG_ACNO ORDER BY BAS_DT, GISDT, PROC_DT) AS THMM_KS_TRNS_IWOL_AMT              
       , TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') DR_DTTM
     , 'BATCH'  DROKJA_ID
     , TO_CHAR(SYSDATE,'YYYYMMDDHH24MISS') UPD_DTTM
     , 'BATCH' MODR_ID
FROM
    (
        WITH PROC_LST AS
                 (
                     SELECT SGS.FIL_100_CTNT5 AS SIGUMGO_ACNO, SGS.TRXDT
                     FROM   ICTOWN.ACL_SIGUMGO_SLV SGS
                     WHERE (CASE WHEN SGS.GJDT > SGS.GISDT THEN SGS.GISDT ELSE SGS.GJDT END)  BETWEEN SUBSTR(:START_DATE,0,4)||'0101' AND :END_DATE
                       AND SGS.TRXDT  BETWEEN SUBSTR(:START_DATE,0,4)-1||'0101' AND SUBSTR(:END_DATE,0,4)+1||'1231'
                       AND SIGUMGO_ORG_C = '28'
                     GROUP  BY SGS.FIL_100_CTNT5, SGS.TRXDT
                     UNION
                     SELECT SGS.SIGUMGO_ACNO, SGS.TRXDT
                     FROM   ICTOWN.ACL_SGGHANDO_SLV SGS
                     WHERE (CASE WHEN SGS.GJDT > SGS.GISDT THEN SGS.GISDT ELSE SGS.GJDT END)  BETWEEN SUBSTR(:START_DATE,0,4)||'0101' AND :END_DATE
                       AND SGS.TRXDT  BETWEEN SUBSTR(:START_DATE,0,4)-1||'0101' AND SUBSTR(:END_DATE,0,4)+1||'1231'
                       AND SIGUMGO_ORG_C = '28'
                     GROUP  BY SGS.SIGUMGO_ACNO, SGS.TRXDT
                 ),
             SLVTOT_DATA  AS
                 (
                     SELECT
                         SGS.SGG_ACNO
                          ,SGS.PROC_DT
                          ,SGS.BAS_DT
                          ,SGS.GISDT
                          ,SGS.SIGUMGO_ORG_C
                          ,SGS.ICH_SIGUMGO_GUN_GU_C
                          ,SGS.ICH_SIGUMGO_HOIKYE_C
                          ,SGS.SIGUMGO_AC_B
                          ,SGS.SIGUMGO_HOIKYE_YR
                          ,SGS.SIGUTAX_G
                          ,CASE WHEN SGS.SIGUMGO_ORG_C IN('28')  THEN THMM_BAEJUNG_AMT_28
                                ELSE THMM_BAEJUNG_AMT_ELSE END
                         AS THMM_BAEJUNG_AMT
                          ,CASE WHEN SGS.SIGUMGO_ORG_C IN('28')  THEN BFMM_JI_AMT_28
                                ELSE BFMM_JI_AMT_ELSE END
                         AS BFMM_JI_AMT
                          ,CASE WHEN SGS.SIGUMGO_ORG_C IN('28')  THEN THMM_JI_AMT
                                ELSE THMM_JI_AMT END
                         AS THMM_JI_AMT
                          ,THMM_RTRN_AMT
                          , CRRC_IP_AMT
                          , CRRC_JI_AMT
                          , FUND_RTRN_AMT
                          , KS_TRNS_IWOL_AMT
                          , HNDO_BAEJUNG_AMT
                          , BFMM_HNDO_JI_AMT
                          , THMM_HNDO_JI_AMT
                          , HNDO_RTRN_AMT
                     FROM
                         (
                             SELECT   SGS.SGG_ACNO
                                  , SGS.PROC_DT
                                  , SGS.BAS_DT
                                  , SGS.GISDT
                                  , SGS.SIGUMGO_ORG_C
                                  , SGS.ICH_SIGUMGO_GUN_GU_C
                                  , SGS.ICH_SIGUMGO_HOIKYE_C
                                  , SGS.SIGUMGO_AC_B
                                  , SGS.SIGUMGO_HOIKYE_YR
                                  , SIGUTAX_G
                                  , SUM(CASE WHEN TCD.CMM_DTL_C IN('150000', '151000', '151100', '151200','160000') THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                                             WHEN TCD.CMM_DTL_C IN('680000') THEN SGS.TRAMT * -1 ELSE 0 END) AS THMM_BAEJUNG_AMT_28
                                  , SUM(CASE WHEN TCD.CMM_DTL_C IN('610001') THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV) ELSE 0 END) AS THMM_BAEJUNG_AMT_ELSE
                                  , SUM(CASE WHEN TCD.CMM_DTL_C IN('670000','670090', '670091', '670092', '670093','670095') THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                                             WHEN TCD.CMM_DTL_C IN('170000','179000','179100','179200','179300','180000','650000') THEN SGS.TRAMT * -1 ELSE 0 END) AS BFMM_JI_AMT_28
                                  , SUM(CASE WHEN TCD.CMM_DTL_C IN('670000','670090', '670091', '670092', '670093','670095') THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV) ELSE 0 END) AS BFMM_JI_AMT_ELSE
                                  , SUM(CASE WHEN TCD.CMM_DTL_C IN('670000','670090', '670091', '670092', '670093','670095') THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV) ELSE 0 END) AS THMM_JI_AMT
                                  , SUM(CASE WHEN TCD.CMM_DTL_C IN('170000', '179000', '179100', '179200', '179300') THEN SGS.TRAMT * 1 ELSE 0 END) AS THMM_RTRN_AMT
                                  , SUM(CASE WHEN TCD.CMM_DTL_C IN('180000') THEN SGS.TRAMT * 1 ELSE 0 END) AS CRRC_IP_AMT
                                  , SUM(CASE WHEN TCD.CMM_DTL_C IN('650000') THEN SGS.TRAMT * -1 ELSE 0 END) AS CRRC_JI_AMT
                                  , SUM(CASE WHEN TCD.CMM_DTL_C IN('140600') THEN SGS.TRAMT * 1 ELSE 0 END) AS FUND_RTRN_AMT
                                  , SUM(CASE WHEN TCD.CMM_DTL_C IN('620004') THEN SGS.TRAMT * 1 ELSE 0 END) AS KS_TRNS_IWOL_AMT
                                  , SUM(CASE WHEN (TCD.CMM_DTL_C IN('450000', '458100', '458200', '910000', '420000', '428000','900000','908000') AND SGS.ICH_SIGUMGO_HOIKYE_C = '1'  AND SIGUMGO_AC_B = '10' ) THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                                             WHEN (TCD.CMM_DTL_C IN('410000', '418100', '418200', '950000', '958100', '958200', '400000', '408000', '920000', '928000') AND SGS.ICH_SIGUMGO_HOIKYE_C = '1'  AND SIGUMGO_AC_B != '10' )
                                                 THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                                             WHEN TCD.CMM_DTL_C IN('670090', '179000') THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV) ELSE 0 END) AS HNDO_BAEJUNG_AMT
                                  , SUM(CASE WHEN (TCD.CMM_DTL_C IN('910000', '918100', '918200') AND SGS.ICH_SIGUMGO_HOIKYE_C = '1'  AND SIGUMGO_AC_B = '21' ) THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                                             WHEN (TCD.CMM_DTL_C IN('910000', '918100', '918200', '450000', '458100', '458200') AND SGS.ICH_SIGUMGO_HOIKYE_C = '1'  AND SIGUMGO_AC_B = '10' )  THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                                             WHEN (TCD.CMM_DTL_C IN('410000', '418100', '418200', '950000', '958100', '958200') AND SGS.ICH_SIGUMGO_HOIKYE_C = '1'  AND SIGUMGO_AC_B != '10' )  THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                                             WHEN TCD.CMM_DTL_C IN('670090', '670091', '670093', '179000', '170091', '170093') THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV) ELSE 0 END) AS BFMM_HNDO_JI_AMT
                                  , SUM(CASE WHEN (TCD.CMM_DTL_C IN('910000', '918100', '918200') AND SGS.ICH_SIGUMGO_HOIKYE_C = '1'  AND SIGUMGO_AC_B = '21' ) THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                                             WHEN (TCD.CMM_DTL_C IN('910000', '918100', '918200') AND SGS.ICH_SIGUMGO_HOIKYE_C = '1'  AND SIGUMGO_AC_B = '10' )  THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                                             WHEN (TCD.CMM_DTL_C IN('410000', '418100', '418200') AND SGS.ICH_SIGUMGO_HOIKYE_C = '1'  AND SIGUMGO_AC_B != '10' )  THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                                             WHEN TCD.CMM_DTL_C IN('670090', '670091', '670093') THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV) ELSE 0 END) AS THMM_HNDO_JI_AMT
                                  , SUM(CASE WHEN (TCD.CMM_DTL_C IN('450000', '458100', '458200') AND SGS.ICH_SIGUMGO_HOIKYE_C = '1'  AND SIGUMGO_AC_B = '10' )  THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                                             WHEN (TCD.CMM_DTL_C IN('950000', '958100', '958200') AND SGS.ICH_SIGUMGO_HOIKYE_C = '1'  AND SIGUMGO_AC_B != '10' )  THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                                             WHEN TCD.CMM_DTL_C IN('170090', '170091', '170093') THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV) ELSE 0 END) AS HNDO_RTRN_AMT
                                  , MAX(SGS.UPD_DTTM) AS UPD_DTTM
                             FROM
                                 (
                                     SELECT   SGS.FIL_100_CTNT5 AS SGG_ACNO
                                          , SGS.TRXDT AS PROC_DT
                                          , SGS.GISDT AS GISDT
                                          , CASE WHEN SGS.GJDT > SGS.GISDT THEN SGS.GISDT  ELSE SGS.GJDT  END AS BAS_DT
                                          , SGS.SIGUMGO_ORG_C
                                          , SGS.ICH_SIGUMGO_GUN_GU_C
                                          , SGS.ICH_SIGUMGO_HOIKYE_C
                                          , SGS.SIGUMGO_AC_B
                                          , SGS.SIGUMGO_HOIKYE_YR
                                          , CASE WHEN ICH_SIGUMGO_HOIKYE_C < 50 THEN '1'
                                                 WHEN ICH_SIGUMGO_HOIKYE_C = 90 THEN '3' ELSE '2' END AS SIGUTAX_G
                                          , LPAD(SGS.SIGUMGO_TRX_G,2,'0')||LPAD(SGS.SIGUMGO_IP_TRX_G,2,'0')||LPAD(SGS.SIGUMGO_JI_TRX_G,2,'0') AS KIND_CD
                                          , SGS.SIGUMGO_SUNP_TRX_G
                                          , SUM(SGS.FIL_18_AMT1 * DECODE(SGS.CRT_CAN_G,1,-1,2,-1,33,-1,1)  ) AS CSH_AMT
                                          , SUM(SGS.TRAMT * DECODE(SGS.CRT_CAN_G,1,-1,2,-1,33,-1,1)  )AS TRAMT
                                          , SUM(CASE  WHEN SGS.SIGUMGO_TAX_IP_MNG_NO IS NOT NULL
                                                          THEN SGS.TRAMT * DECODE(SGS.CRT_CAN_G,1,-1,2,-1,33,-1,1) * DECODE(SGS.IPJI_G,1,1,-1)
                                                      ELSE 0  END) AS HNDO_USE_AMT
                                          , MAX(SGS.LST_CDT || NVL(SGS.LST_CHG_TIME,'000000')) AS UPD_DTTM
                                     FROM ICTOWN.ACL_SIGUMGO_SLV SGS
                                              INNER JOIN PROC_LST PCL
                                                         ON SGS.FIL_100_CTNT5 = PCL.SIGUMGO_ACNO
                                                             AND SGS.TRXDT = PCL.TRXDT
                                     WHERE 1=1
                                       AND  (CASE WHEN SGS.GJDT > SGS.GISDT  THEN SGS.GISDT  ELSE SGS.GJDT END BETWEEN SUBSTR(:START_DATE,0,4)||'0101' AND :END_DATE)
                                       AND  (SUBSTR(SGS.FIL_100_CTNT5,4,3)<>'900' OR SUBSTR(SGS.FIL_100_CTNT5,7,2)<>'90')
                                       AND  (CASE WHEN SIGUMGO_ORG_C = 28 AND SIGUMGO_TRX_G IN(15, 16, 17, 18, 65, 67, 68)  THEN  '1'
                                                  WHEN SIGUMGO_ORG_C = 28 AND SIGUMGO_TRX_G NOT IN(15, 16, 17, 18, 65, 67, 68) THEN '0' ELSE '1' END) = '1'

                                     GROUP BY SGS.FIL_100_CTNT5, SGS.TRXDT, SGS.GISDT, SGS.SIGUMGO_AC_B
                                            ,CASE WHEN SGS.GJDT > SGS.GISDT  THEN SGS.GISDT  ELSE SGS.GJDT END
                                            , SGS.SIGUMGO_ORG_C
                                            , SGS.ICH_SIGUMGO_GUN_GU_C
                                            , SGS.ICH_SIGUMGO_HOIKYE_C
                                            , SGS.SIGUMGO_AC_B
                                            , SGS.SIGUMGO_HOIKYE_YR
                                            , SGS.SIGUMGO_TRX_G, SGS.SIGUMGO_IP_TRX_G, SGS.SIGUMGO_JI_TRX_G, SGS.SIGUMGO_SUNP_TRX_G, SGS.NEW_GU_YR_G
                                     UNION ALL
                                     SELECT
                                         SGS.SIGUMGO_ACNO AS SGG_ACNO
                                          , SGS.TRXDT AS PROC_DT
                                          , SGS.GISDT AS GISDT
                                          , CASE WHEN SGS.GJDT > SGS.GISDT THEN SGS.GISDT
                                                 WHEN SGS.GJDT IS NULL THEN SGS.GISDT ELSE SGS.GJDT END AS BAS_DT
                                          , SGS.SIGUMGO_ORG_C
                                          , SGS.ICH_SIGUMGO_GUN_GU_C
                                          , SGS.ICH_SIGUMGO_HOIKYE_C
                                          , SGS.SIGUMGO_AC_B
                                          , SGS.SIGUMGO_HOIKYE_YR
                                          , CASE WHEN ICH_SIGUMGO_HOIKYE_C < 50 THEN '1'
                                                 WHEN ICH_SIGUMGO_HOIKYE_C = 90 THEN '3' ELSE '2' END AS SIGUTAX_G
                                          , LPAD(SGS.SIGUMGO_TRX_G,2,'0')||'0000' AS KIND_CD
                                          , 0 AS SIGUMGO_SUNP_TRX_G
                                          , 0 AS CSH_AMT
                                          , SUM(SGS.TRAMT * DECODE(SGS.CRT_CAN_G,1,-1,2,-1,33,-1,1) ) AS TRAMT
                                          , 0 AS HNDO_USE_AMT
                                          , MAX(SGS.LST_CDT || NVL(SGS.LST_CHG_TIME,'000000')) AS UPD_DTTM
                                     FROM ICTOWN.ACL_SGGHANDO_SLV SGS
                                              INNER JOIN PROC_LST PCL
                                                         ON SGS.SIGUMGO_ACNO = PCL.SIGUMGO_ACNO
                                                             AND SGS.TRXDT = PCL.TRXDT
                                     WHERE 1=1
                                       AND SGS.GISDT BETWEEN SUBSTR(:START_DATE,0,4)||'0101' AND :END_DATE
                                       AND (SUBSTR(SGS.SIGUMGO_ACNO,4,3)<>'900' OR SUBSTR(SGS.SIGUMGO_ACNO,7,2)<>'90')
                                       AND SIGUMGO_TRX_G  IN (90,91,92,95,40,41,42,45)
                                     GROUP BY SGS.SIGUMGO_ACNO, SGS.TRXDT, SGS.GISDT
                                            , CASE WHEN SGS.GJDT > SGS.GISDT THEN SGS.GISDT
                                                   WHEN SGS.GJDT IS NULL THEN SGS.GISDT ELSE SGS.GJDT END
                                            , SGS.SIGUMGO_ORG_C
                                            , SGS.ICH_SIGUMGO_GUN_GU_C
                                            , SGS.ICH_SIGUMGO_HOIKYE_C
                                            , SGS.SIGUMGO_AC_B
                                            , SGS.SIGUMGO_HOIKYE_YR
                                            , SGS.SIGUMGO_TRX_G, SGS.FIL_5_NO3
                                 ) SGS
                                     INNER JOIN  SFI_CMM_C_DAT  TCD
                                                 ON TCD.CMM_C_NM = 'RPT세입세출자금일계표집계용'
                                                     AND SGS.KIND_CD = TCD.CMM_DTL_C
                             GROUP BY SGS.SGG_ACNO, SGS.PROC_DT, SGS.BAS_DT, SGS.GISDT
                                    , SGS.SIGUMGO_ORG_C
                                    , SGS.ICH_SIGUMGO_GUN_GU_C
                                    , SGS.ICH_SIGUMGO_HOIKYE_C
                                    , SGS.SIGUMGO_AC_B
                                    , SGS.SIGUMGO_HOIKYE_YR
                                    , SGS.SIGUTAX_G
                         ) SGS
                 )
        SELECT
            SGG_ACNO
             , PROC_DT
             , BAS_DT
             , GISDT
             , SIGUMGO_ORG_C
             , ICH_SIGUMGO_GUN_GU_C
             , ICH_SIGUMGO_HOIKYE_C
             , SIGUMGO_AC_B
             , SIGUMGO_HOIKYE_YR
             , SIGUTAX_G
             , '' NEW_GU_YR_G
             ,SUM(THMM_BAEJUNG_AMT) THMM_BAEJUNG_AMT
             ,SUM(BFMM_JI_AMT) BFMM_JI_AMT
             ,SUM(THMM_JI_AMT) THMM_JI_AMT
             ,SUM(THMM_RTRN_AMT) THMM_RTRN_AMT
             ,SUM(CRRC_IP_AMT) CRRC_IP_AMT
             ,SUM(CRRC_JI_AMT ) CRRC_JI_AMT
             ,SUM(FUND_RTRN_AMT) FUND_RTRN_AMT
             ,SUM(KS_TRNS_IWOL_AMT) KS_TRNS_IWOL_AMT
             ,SUM(HNDO_BAEJUNG_AMT) HNDO_BAEJUNG_AMT
             ,SUM(BFMM_HNDO_JI_AMT) BFMM_HNDO_JI_AMT
             ,SUM(THMM_HNDO_JI_AMT) THMM_HNDO_JI_AMT
             ,SUM(HNDO_RTRN_AMT)  HNDO_RTRN_AMT
        FROM   SLVTOT_DATA A
        WHERE  1=1
        GROUP  BY SGG_ACNO
                , PROC_DT
                , BAS_DT
                , GISDT
                , SIGUMGO_ORG_C
                , ICH_SIGUMGO_GUN_GU_C
                , ICH_SIGUMGO_HOIKYE_C
                , SIGUMGO_AC_B
                , SIGUMGO_HOIKYE_YR
                , SIGUTAX_G
    ) A
WHERE 1=1
  AND BAS_DT>= (
    SELECT MIN(BAS_DT)
    FROM
        (
            SELECT MIN(CASE WHEN SGS.GJDT > SGS.GISDT THEN SGS.GISDT ELSE SGS.GJDT END) BAS_DT
            FROM   ICTOWN.ACL_SIGUMGO_SLV SGS
            WHERE (CASE WHEN SGS.GJDT > SGS.GISDT THEN SGS.GISDT ELSE SGS.GJDT END)  BETWEEN SUBSTR(:START_DATE,0,4)||'0101' AND :END_DATE
              AND SGS.TRXDT  BETWEEN SUBSTR(:START_DATE,0,4)-1||'0101' AND SUBSTR(:END_DATE,0,4)+1||'1231'
              AND  (SUBSTR(SGS.FIL_100_CTNT5,4,3)<>'900' OR SUBSTR(SGS.FIL_100_CTNT5,7,2)<>'90')
              AND SIGUMGO_ORG_C = '28'
            UNION
            SELECT MIN(CASE WHEN SGS.GJDT > SGS.GISDT THEN SGS.GISDT ELSE SGS.GJDT END) BAS_DT
            FROM   ICTOWN.ACL_SGGHANDO_SLV SGS
            WHERE (CASE WHEN SGS.GJDT > SGS.GISDT THEN SGS.GISDT ELSE SGS.GJDT END)  BETWEEN SUBSTR(:START_DATE,0,4)||'0101' AND :END_DATE
              AND SGS.TRXDT  BETWEEN SUBSTR(:START_DATE,0,4)-1||'0101' AND SUBSTR(:END_DATE,0,4)+1||'1231'
              AND  (SUBSTR(SGS.SIGUMGO_ACNO,4,3)<>'900' OR SUBSTR(SGS.SIGUMGO_ACNO,7,2)<>'90')
              AND SIGUMGO_ORG_C = '28'

        )
)