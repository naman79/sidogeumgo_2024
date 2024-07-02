SELECT 
             GONGGEUM_GYEJWA GONGGEUM_GYEJWA,
            
             TO_CHAR(SUM(NVL(SEIP_BAEJUNGIPGUM,0)+NVL(SEIP_SUNAPICHE,0))) AS NUGYE_SUIBAEG ,              
             TO_CHAR(SUM(NVL(SEIP_GWAONAPBANWHAN,0))) AS NUGYE_SEIB_GWAONAB,                  
             TO_CHAR(SUM(NVL(SEIP_GWAMOKKYUNGJUNG,0)))   AS NUGYE_SEIB_JEONGJEONG,                
             TO_CHAR(SUM(NVL(SEIP_GWAOEDIT,0)))   AS NUGYE_SEIB_GWOEDIT,                        
             TO_CHAR(SUM(NVL(SECHUL_JAGUMBAEJUNG,0)))  AS NUGYE_SECHUL_BAEJEONGAEG,               
             TO_CHAR(SUM(NVL(SECHUL_JAGUMHWANSU,0)))  AS NUGYE_SECHUL_HWANSU,                 
             TO_CHAR(SUM(NVL(SECHUL_JICHUL,0)))   AS NUGYE_SECHUL_JIBULAEG,                     
             TO_CHAR(SUM(NVL(SECHUL_BANNAP,0)))  AS NUGYE_SECHUL_JICHUL,                        
             TO_CHAR(SUM(NVL(JUNBUGUM,0)))  AS NUGYE_JEONBUGEUM,                          
             TO_CHAR(SUM(NVL(JUNYONG_JUNCHUL,0)))  AS NUGYE_JEONCHUL,                       
             TO_CHAR(SUM(NVL(JUNYONG_JUNIP,0))) AS NUGYE_JEONIB,                            
             TO_CHAR(SUM(NVL(JUNYONG_GAIWOLEIP,0)))  AS NUGYE_GAIWOL_IIB,                       
             TO_CHAR(SUM(NVL(JUNYONG_GAIWOLJIGUP,0)))  AS NUGYE_GAIWOL_JIGEUB,                    
             TO_CHAR(SUM(NVL(JAGUM_SHINGYU,0)))  AS NUGYE_SINGYU,                           
             TO_CHAR(SUM(NVL(JAGUM_HAEJI,0))) AS NUGYE_HAEJI,                             
             TO_CHAR(SUM(NVL(BON_HANDOBAEJUNG,0) + NVL(BONWOI_HANDOBAEJUNG,0))) AS NUGYE_HANDO_BAEJEONG,                
             TO_CHAR(SUM(NVL(BON_HANDOSAYONG,0) + NVL(BONWOI_HANDOSAYONG,0))) AS NUGYE_HANDO_SAYONG,                  
             TO_CHAR(SUM(NVL(BON_HANDOBAEJUNG,0) + NVL(BONWOI_HANDOBAEJUNG,0) - NVL(BON_HANDOSAYONG,0) - NVL(BONWOI_HANDOSAYONG,0))) AS NUGYE_JANYEOHANDO,             
             TO_CHAR( SUM(NVL(BON_HANDOBAEJUNG,0))) AS NUGYE_BON_HANDO_BAEJEONG ,                           
             TO_CHAR(SUM(NVL(BON_HANDOSAYONG,0))) AS NUGYE_BON_HANDO_SAYONG,                            
             TO_CHAR(SUM(NVL(BON_HANDOBAEJUNG,0)-NVL(BON_HANDOSAYONG,0))) AS NUGYE_BON_JANYEOHANDO,                 
             TO_CHAR( SUM(NVL(BONWOI_HANDOBAEJUNG,0))) AS NUGYE_BONWOI_HANDO_BAEJEONG,                        
             TO_CHAR(SUM(NVL(BONWOI_HANDOSAYONG,0))) AS NUGYE_BONWOI_HANDO_SAYONG,                          
             TO_CHAR(SUM(NVL(BONWOI_HANDOBAEJUNG,0)-NVL(BONWOI_HANDOSAYONG,0))) AS NUGYE_BONWOI_JANYEOHANDO,         
               
             TO_CHAR(SUM(NVL(SEIP_BAEJUNGIPGUM2,0)+NVL(SEIP_SUNAPICHE2,0))) AS ILGYE_SUIBAEG ,              
             TO_CHAR(SUM(NVL(SEIP_GWAONAPBANWHAN2,0))) AS ILGYE_SEIB_GWAONAB,                     
             TO_CHAR(SUM(NVL(SEIP_GWAMOKKYUNGJUNG2,0)))   AS ILGYE_SEIB_JEONGJEONG,                 
             TO_CHAR(SUM(NVL(SEIP_GWAOEDIT2,0)))   AS ILGYE_SEIB_GWOEDIT,                         
             TO_CHAR(SUM(NVL(SECHUL_JAGUMBAEJUNG2,0)))  AS ILGYE_SECHUL_BAEJEONGAEG,                
             TO_CHAR(SUM(NVL(SECHUL_JAGUMHWANSU2,0)))  AS ILGYE_SECHUL_HWANSU,                  
             TO_CHAR(SUM(NVL(SECHUL_JICHUL2,0)))   AS ILGYE_SECHUL_JIBULAEG,                      
             TO_CHAR(SUM(NVL(SECHUL_BANNAP2,0)))  AS ILGYE_SECHUL_JICHUL,                         
             TO_CHAR(SUM(NVL(JUNBUGUM2,0)))  AS ILGYE_JEONBUGEUM,                           
             TO_CHAR(SUM(NVL(JUNYONG_JUNCHUL2,0)))  AS ILGYE_JEONCHUL,                        
             TO_CHAR(SUM(NVL(JUNYONG_JUNIP2,0))) AS ILGYE_JEONIB,                           
             TO_CHAR(SUM(NVL(JUNYONG_GAIWOLEIP2,0)))  AS ILGYE_GAIWOL_IIB,                        
             TO_CHAR(SUM(NVL(JUNYONG_GAIWOLJIGUP2,0)))  AS ILGYE_GAIWOL_JIGEUB,                     
             TO_CHAR(SUM(NVL(JAGUM_SHINGYU2,0)))  AS ILGYE_SINGYU,                            
             TO_CHAR(SUM(NVL(JAGUM_HAEJI2,0))) AS ILGYE_HAEJI,                              
             TO_CHAR(SUM(NVL(HANDOBAEJUNG2,0))) AS ILGYE_HANDO_BAEJEONG,                      
             TO_CHAR(SUM(NVL(HANDOSAYONG2,0)))   AS ILGYE_HANDO_SAYONG,                        
             TO_CHAR(SUM(NVL(HANDOBAEJUNG2,0)-NVL(HANDOSAYONG2,0)))  AS ILGYE_JANYEOHANDO,                  
             TO_CHAR( SUM(NVL(BON_HANDOBAEJUNG2,0))) AS ILGYE_BON_HANDO_BAEJEONG ,                            
             TO_CHAR(SUM(NVL(BON_HANDOSAYONG2,0))) AS ILGYE_BON_HANDO_SAYONG,                               
             TO_CHAR(SUM(NVL(BON_HANDOBAEJUNG2,0)-NVL(BON_HANDOSAYONG2,0))) AS ILGYE_BON_JANYEOHANDO,                 
             TO_CHAR( SUM(NVL(BONWOI_HANDOBAEJUNG2,0))) AS ILGYE_BONWOI_HANDO_BAEJEONG,                         
             TO_CHAR(SUM(NVL(BONWOI_HANDOSAYONG2,0))) AS ILGYE_BONWOI_HANDO_SAYONG,                           
             TO_CHAR(SUM(NVL(BONWOI_HANDOBAEJUNG2,0)-NVL(BONWOI_HANDOSAYONG2,0))) AS ILGYE_BONWOI_JANYEOHANDO          
FROM
              (
                SELECT   
                                GONGGEUM_GYEJWA AS GONGGEUM_GYEJWA
                               ,SEIP_SUNAPICHE AS SEIP_SUNAPICHE
                               ,SEIP_BAEJUNGIPGUM AS SEIP_BAEJUNGIPGUM
                               ,SEIP_GWAONAPBANWHAN AS SEIP_GWAONAPBANWHAN
                               ,SEIP_GWAMOKKYUNGJUNG AS SEIP_GWAMOKKYUNGJUNG
                               ,SEIP_GWAOEDIT AS SEIP_GWAOEDIT
                               ,SECHUL_JAGUMBAEJUNG AS SECHUL_JAGUMBAEJUNG
                               ,0  AS SECHUL_JAGUMHWANSU
                               ,SECHUL_JICHUL AS SECHUL_JICHUL
                               ,SECHUL_BANNAP*-1 AS SECHUL_BANNAP
                               ,JUNBUGUM AS JUNBUGUM
                               ,JUNYONG_JUNCHUL AS JUNYONG_JUNCHUL
                               ,JUNYONG_JUNIP AS JUNYONG_JUNIP        
                               ,JUNYONG_GAIWOLJIGUP AS JUNYONG_GAIWOLJIGUP
                               ,JUNYONG_GAIWOLEIP AS JUNYONG_GAIWOLEIP
                               ,JAGUM_SHINGYU AS JAGUM_SHINGYU
                               ,JAGUM_HAEJI AS JAGUM_HAEJI         
                               ,HANDOBAEJUNG AS HANDOBAEJUNG
                               ,HANDOSAYONG AS HANDOSAYONG
                               ,BON_HANDOBAEJUNG AS BON_HANDOBAEJUNG
                               ,BON_HANDOSAYONG AS BON_HANDOSAYONG
                               ,BONWOI_HANDOBAEJUNG AS BONWOI_HANDOBAEJUNG
                               ,BONWOI_HANDOSAYONG AS BONWOI_HANDOSAYONG             
                               ,0 AS SEIP_SUNAPICHE2
                               ,0 SEIP_BAEJUNGIPGUM2
                               ,0 AS SEIP_GWAONAPBANWHAN2
                               ,0 AS SEIP_GWAMOKKYUNGJUNG2
                               ,0 AS SEIP_GWAOEDIT2
                               ,0 AS SECHUL_JAGUMBAEJUNG2
                               ,0  AS SECHUL_JAGUMHWANSU2
                               ,0 AS SECHUL_JICHUL2
                               ,0 AS SECHUL_BANNAP2
                               ,0 AS JUNBUGUM2
                               ,0 AS JUNYONG_JUNCHUL2
                               ,0 AS JUNYONG_JUNIP2     
                               ,0 AS JUNYONG_GAIWOLJIGUP2
                               ,0 AS JUNYONG_GAIWOLEIP2
                               ,0 AS JAGUM_SHINGYU2
                               ,0 AS JAGUM_HAEJI2
                               ,0 AS HANDOBAEJUNG2
                               ,0 AS HANDOSAYONG2
                               ,0 AS BON_HANDOBAEJUNG2
                               ,0 AS BON_HANDOSAYONG2
                               ,0 AS BONWOI_HANDOBAEJUNG2
                               ,0 AS BONWOI_HANDOSAYONG2
                FROM
                              (
                                SELECT   
                                          A.SGG_ACNO AS GONGGEUM_GYEJWA
                                         ,SUM(TAX_SUNP_IP_AMT) AS SEIP_SUNAPICHE
                                         ,SUM(FUND_ADJ_IP_AMT) AS SEIP_BAEJUNGIPGUM
                                         ,SUM(GWAON_PROC_JI_AMT+GWAON_PROC_IP_AMT) AS SEIP_GWAONAPBANWHAN
                                         ,SUM(TAX_IP_CRT_AMT) AS SEIP_GWAMOKKYUNGJUNG
                                         ,SUM(TAX_IP_CRT_JI_AMT) AS SEIP_GWAOEDIT
                                         ,SUM(TAXO_FUND_BAEJUNG_AMT) AS SECHUL_JAGUMBAEJUNG
                                         ,0  AS SECHUL_JAGUMHWANSU
                                         ,SUM(TAXO_JIBUL_AMT) AS SECHUL_JICHUL
                                         ,SUM(TAXO_RTRN_AMT) AS SECHUL_BANNAP
                                         ,SUM(JEONBU_AMT_IP_AMT) AS JUNBUGUM
                                         ,SUM(PMNY_JAN_MVO_AMT) AS JUNYONG_JUNCHUL
                                         ,SUM(PMNY_JAN_MVI_AMT) AS JUNYONG_JUNIP        
                                         ,SUM(GA_IWOL_JI_AMT) AS JUNYONG_GAIWOLJIGUP
                                         ,SUM(GA_IWOL_IP_AMT) AS JUNYONG_GAIWOLEIP
                                         ,SUM(DEP_MK_JI_AMT) AS JAGUM_SHINGYU
                                         ,SUM(DEP_HJI_AMT) AS JAGUM_HAEJI        
                                         ,SUM(HNDO_BAEJUNG_AMT+BONWOI_HNDO_BAEJUNG_AMT) AS HANDOBAEJUNG
                                         ,SUM(HNDO_USE_JI_AMT+HNDO_USE_IP_AMT) AS HANDOSAYONG
                                         ,SUM(BON_HNDO_BAEJUNG_AMT) AS BON_HANDOBAEJUNG
                                         ,SUM(BON_HNDO_USE_JI_AMT+BON_HNDO_USE_IP_AMT) AS BON_HANDOSAYONG
                                         ,SUM(BONWOI_HNDO_BAEJUNG_AMT) AS BONWOI_HANDOBAEJUNG
                                         ,SUM(BONWOI_HNDO_USE_JI_AMT+BONWOI_HNDO_USE_IP_AMT) AS BONWOI_HANDOSAYONG
                                  FROM 
                                          RPT_TXIO_DDAC_TAB A
                                  WHERE 
                                          A.GISDT BETWEEN '2024'||'0101' AND '20240531'
                                          AND A.SGG_ACNO = '02800001100000024'
                                          AND (CASE WHEN A.SIGUMGO_HOIKYE_YR = 9999 THEN TO_NUMBER(SUBSTR(A.BAS_DT, 1, 4)) ELSE TO_NUMBER(A.SIGUMGO_HOIKYE_YR) END) = '2024'
                                  GROUP BY A.SGG_ACNO
                                  UNION ALL
                                  SELECT  
                                          GONGGEUM_GYEJWA,
                                           0 AS SEIP_SUNAPICHE,
                                           SUM(CASE WHEN GUBUN_CODE = 1 THEN AMT1 ELSE 0 END) AS SEIP_BAEJUNGIPGUM,
                                           0 AS SEIP_GWAONAPBANWHAN,
                                           0 AS SEIP_GWAMOKKYUNGJUNG,
                                           0 AS SEIP_GWAOEDIT,
                                           0 AS SECHUL_JAGUMBAEJUNG,
                                           0 AS SECHUL_JAGUMHWANSU,
                                           0 AS SECHUL_JICHUL,
                                           0 AS SECHUL_BANNAP,
                                           SUM(CASE WHEN GUBUN_CODE = 6 THEN AMT1 ELSE 0 END) AS JUNBUGUM,
                                           0 AS JUNYONG_JUNCHUL,
                                           0 AS JUNYONG_JUNIP,
                                           0 AS JUNYONG_GAIWOLJIGUP,
                                           0 AS JUNYONG_GAIWOLEIP,
                                           SUM(CASE WHEN GUBUN_CODE IN ( 2, 3 ) THEN AMT1 ELSE 0 END) AS JAGUM_SHINGYU,
                                           0 AS JAGUM_HAEJI,
                                           0 AS HANDOBAEJUNG,
                                           0 AS HANDOSAYONG,        
                                           0 AS BON_HANDOBAEJUNG,
                                           0 AS BON_HANDOSAYONG,
                                           0 AS BONWOI_HANDOBAEJUNG,
                                           0 AS BONWOI_HANDOSAYONG    
                                    FROM   
                                          RPT_HOIGYE_IWOL A
                                    WHERE  
                                            A.HOIGYE_YEAR = ( 2024 - 1 ) 
                                            AND A.GONGGEUM_GYEJWA = '02800001100000024'          
                                            AND A.GUBUN_CODE IN (1, 2, 3, 5, 6)
                                            AND A.KIJUNIL BETWEEN '2024'||'0101' AND '20240531'
                                    GROUP BY GONGGEUM_GYEJWA
                              )       
                UNION ALL
                SELECT   
                                GONGGEUM_GYEJWA AS GONGGEUM_GYEJWA
                               ,0 AS SEIP_SUNAPICHE
                               ,0 SEIP_BAEJUNGIPGUM
                               ,0 AS SEIP_GWAONAPBANWHAN
                               ,0 AS SEIP_GWAMOKKYUNGJUNG
                               ,0 AS SEIP_GWAOEDIT
                               ,0 AS SECHUL_JAGUMBAEJUNG
                               ,0  AS SECHUL_JAGUMHWANSU
                               ,0 AS SECHUL_JICHUL
                               ,0 AS SECHUL_BANNAP
                               ,0 AS JUNBUGUM
                               ,0 AS JUNYONG_JUNCHUL
                               ,0 AS JUNYONG_JUNIP    
                               ,0 AS JUNYONG_GAIWOLJIGUP
                               ,0 AS JUNYONG_GAIWOLEIP
                               ,0 AS JAGUM_SHINGYU
                               ,0 AS JAGUM_HAEJI
                               ,0 AS HANDOBAEJUNG
                               ,0 AS HANDOSAYONG
                               ,0 AS BON_HANDOBAEJUNG
                               ,0 AS BON_HANDOSAYONG2
                               ,0 AS BONWOI_HANDOBAEJUNG
                               ,0 AS BONWOI_HANDOSAYONG            
                               ,SEIP_SUNAPICHE AS SEIP_SUNAPICHE2
                               ,SEIP_BAEJUNGIPGUM AS SEIP_BAEJUNGIPGUM2
                               ,SEIP_GWAONAPBANWHAN AS SEIP_GWAONAPBANWHAN2
                               ,SEIP_GWAMOKKYUNGJUNG AS SEIP_GWAMOKKYUNGJUNG2
                               ,SEIP_GWAOEDIT AS SEIP_GWAOEDIT2
                               ,SECHUL_JAGUMBAEJUNG AS SECHUL_JAGUMBAEJUNG2
                               ,0  AS SECHUL_JAGUMHWANSU2
                               ,SECHUL_JICHUL AS SECHUL_JICHUL2
                               ,SECHUL_BANNAP*-1 AS SECHUL_BANNAP2
                               ,JUNBUGUM AS JUNBUGUM2
                               ,JUNYONG_JUNCHUL AS JUNYONG_JUNCHUL2
                               ,JUNYONG_JUNIP AS JUNYONG_JUNIP2
                               ,JUNYONG_GAIWOLJIGUP AS JUNYONG_GAIWOLJIGUP2
                               ,JUNYONG_GAIWOLEIP AS JUNYONG_GAIWOLEIP2
                               ,JAGUM_SHINGYU AS JAGUM_SHINGYU2
                               ,JAGUM_HAEJI AS JAGUM_HAEJI2
                               ,HANDOBAEJUNG AS HANDOBAEJUNG2
                               ,HANDOSAYONG AS HANDOSAYONG2
                               ,BON_HANDOBAEJUNG AS BON_HANDOBAEJUNG2
                               ,BON_HANDOSAYONG AS BON_HANDOSAYONG2
                               ,BONWOI_HANDOBAEJUNG AS BONWOI_HANDOBAEJUNG2
                               ,BONWOI_HANDOSAYONG AS BONWOI_HANDOSAYONG2
                FROM
                                (
                                  SELECT   
                                          A.SGG_ACNO AS GONGGEUM_GYEJWA
                                         ,SUM(TAX_SUNP_IP_AMT) AS SEIP_SUNAPICHE
                                         ,SUM(FUND_ADJ_IP_AMT) AS SEIP_BAEJUNGIPGUM
                                         ,SUM(GWAON_PROC_JI_AMT+GWAON_PROC_IP_AMT) AS SEIP_GWAONAPBANWHAN
                                         ,SUM(TAX_IP_CRT_AMT) AS SEIP_GWAMOKKYUNGJUNG
                                         ,SUM(TAX_IP_CRT_JI_AMT) AS SEIP_GWAOEDIT
                                         ,SUM(TAXO_FUND_BAEJUNG_AMT) AS SECHUL_JAGUMBAEJUNG
                                         ,0  AS SECHUL_JAGUMHWANSU
                                         ,SUM(TAXO_JIBUL_AMT) AS SECHUL_JICHUL
                                         ,SUM(TAXO_RTRN_AMT) AS SECHUL_BANNAP
                                         ,SUM(JEONBU_AMT_IP_AMT) AS JUNBUGUM
                                         ,SUM(PMNY_JAN_MVO_AMT) AS JUNYONG_JUNCHUL
                                         ,SUM(PMNY_JAN_MVI_AMT) AS JUNYONG_JUNIP        
                                         ,SUM(GA_IWOL_JI_AMT) AS JUNYONG_GAIWOLJIGUP
                                         ,SUM(GA_IWOL_IP_AMT) AS JUNYONG_GAIWOLEIP
                                         ,SUM(DEP_MK_JI_AMT) AS JAGUM_SHINGYU
                                         ,SUM(DEP_HJI_AMT) AS JAGUM_HAEJI        
                                         ,SUM(HNDO_BAEJUNG_AMT) AS HANDOBAEJUNG
                                         ,SUM(HNDO_USE_JI_AMT+HNDO_USE_IP_AMT) AS HANDOSAYONG
                                         ,SUM(BON_HNDO_BAEJUNG_AMT) AS BON_HANDOBAEJUNG
                                         ,SUM(BON_HNDO_USE_JI_AMT+BON_HNDO_USE_IP_AMT) AS BON_HANDOSAYONG
                                         ,SUM(BONWOI_HNDO_BAEJUNG_AMT) AS BONWOI_HANDOBAEJUNG
                                         ,SUM(BONWOI_HNDO_USE_JI_AMT+BONWOI_HNDO_USE_IP_AMT) AS BONWOI_HANDOSAYONG
                                  FROM 
                                          RPT_TXIO_DDAC_TAB A 
                                  WHERE 
                                          A.GISDT BETWEEN '20240531' AND '20240531' 
                                          AND A.SGG_ACNO = '02800001100000024'
                                          AND (CASE WHEN A.SIGUMGO_HOIKYE_YR = 9999 THEN TO_NUMBER(SUBSTR(A.BAS_DT, 1, 4)) ELSE TO_NUMBER(A.SIGUMGO_HOIKYE_YR) END) = '2024'
                                  GROUP BY A.SGG_ACNO   
                                  UNION ALL 
                                  SELECT  
                                           GONGGEUM_GYEJWA AS GONGGEUM_GYEJWA,
                                           0 AS SEIP_SUNAPICHE,
                                           SUM(CASE WHEN GUBUN_CODE = 1 THEN AMT1 ELSE 0 END) AS SEIP_BAEJUNGIPGUM,
                                           0 AS SEIP_GWAONAPBANWHAN,
                                           0 AS SEIP_GWAMOKKYUNGJUNG,
                                           0 AS SEIP_GWAOEDIT,
                                           0 AS SECHUL_JAGUMBAEJUNG,
                                           0 AS SECHUL_JAGUMHWANSU,
                                           0 AS SECHUL_JICHUL,
                                           0 AS SECHUL_BANNAP,
                                           SUM(CASE WHEN GUBUN_CODE = 6 THEN AMT1 ELSE 0 END) AS JUNBUGUM,
                                           0 AS JUNYONG_JUNCHUL,
                                           0 AS JUNYONG_JUNIP,
                                           0 AS JUNYONG_GAIWOLJIGUP,
                                           0 AS JUNYONG_GAIWOLEIP,
                                           SUM(CASE WHEN GUBUN_CODE IN ( 2, 3 ) THEN AMT1 ELSE 0 END) AS JAGUM_SHINGYU,
                                           0 AS JAGUM_HAEJI,
                                           0 AS HANDOBAEJUNG,
                                           0 AS HANDOSAYONG,        
                                           0 AS BON_HANDOBAEJUNG,
                                           0 AS BON_HANDOSAYONG,
                                           0 AS BONWOI_HANDOBAEJUNG,
                                           0 AS BONWOI_HANDOSAYONG          
                                  FROM   
                                           RPT_HOIGYE_IWOL A
                                  WHERE  
                                           A.HOIGYE_YEAR = ( 2024 - 1 ) 
                                           AND A.GONGGEUM_GYEJWA = '02800001100000024'
                                           AND A.GUBUN_CODE IN (1, 2, 3, 5, 6)
                                           AND A.KIJUNIL BETWEEN '20240531' AND '20240531'
                                  GROUP BY GONGGEUM_GYEJWA
                                )
              ) AA
GROUP BY GONGGEUM_GYEJWA
