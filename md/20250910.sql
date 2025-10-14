SELECT 
      TO_CHAR(B.HRNK_CMM_DTL_C) AS BANK_NO ,           
      TO_CHAR(NVL(B.HRNK_CMM_DTL_C,0)) || '.' || TRIM(C.CMM_DTL_C_NM) AS BANK_NM           ,       
      SUM(A.A01) AS JIBANGSE_CNT            ,   /* 지방세-계-건수           */            
      SUM(A.A02) AS JIBANGSE_AMT           ,   /* 지방세-계-금액           */             
      SUM(A.A03) AS SEWOI_CNT            ,   /* 세  외-계-건수           */               
      SUM(A.A04) AS SEWOI_AMT            ,   /* 세  외-계-금액           */               
      SUM(A.A05) AS GYOYUKSE_CNT            ,   /* 교육세-계-건수           */            
      SUM(A.A06) AS GYOYUKSE_AMT           ,   /* 교육세-계-금액           */             
      SUM(A.A07) AS NONGTEUKSE_CNT            ,   /* 농특세-계-건수           */          
      SUM(A.A08) AS NONGTEUKSE_AMT            ,   /* 농특세-계-금액           */          
      SUM(A.A09) AS JIBANGSE_JIBANGSE_CNT         ,   /* 지방세-지방세OCR-건수    */      
      SUM(A.A10) AS JIBANGSE_JIBANGSE_AMT           ,   /* 지방세-지방세OCR-금액    */    
      SUM(A.A11) AS SEWOI_JIBANGSE_CNT            ,   /* 세  외-지방세OCR-건수    */      
      SUM(A.A12) AS SEWOI_JIBANGSE_AMT            ,   /* 세  외-지방세OCR-금액    */      
      SUM(A.A13) AS GYOYUKSE_JIBANGSE_CNT            ,   /* 교육세-지방세OCR-건수    */   
      SUM(A.A14) AS GYOYUKSE_JIBANGSE_AMT            ,   /* 교육세-지방세OCR-금액    */   
      SUM(A.A15) AS NONGTEUKSE_JIBANGSE_CNT            ,   /* 농특세-지방세OCR-건수    */ 
      SUM(A.A16) AS NONGTEUKSE_JIBANGSE_AMT            ,   /* 농특세-지방세OCR-금액    */ 
      SUM(A.A17) AS JIBANGSE_SANGHASUDO_CNT            ,   /* 지방세-상하수도물OCR-건수   */              
      SUM(A.A18) AS JIBANGSE_SANGHASUDO_AMT            ,   /* 지방세-상하수도물OCR-금액   */              
      SUM(A.A19) AS JIBANGSE_OCR_CNT            ,   /* 지방세-환경개선OCR-건수  */        
      SUM(A.A20) AS JIBANGSE_OCR_AMT            ,   /* 지방세-환경개선OCR-금액  */        
      SUM(A.A21) AS JIBANGSE_SISE_CNT            ,   /* 지방세-시세-건수         */       
      SUM(A.A22) AS JIBANGSE_SISE_AMT            ,   /* 지방세-시세-금액         */       
      SUM(A.A23) AS SEWOI_SISE_CNT            ,   /* 세  외-시세-건수         */          
      SUM(A.A24) AS SEWOI_SISE_AMT            ,   /* 세  외-시세-금액         */          
      SUM(A.A25) AS GYOYUKSE_SISE_CNT            ,   /* 교육세-시세-건수         */       
      SUM(A.A26) AS GYOYUKSE_SISE_AMT            ,   /* 교육세-시세-금액         */       
      SUM(A.A27) AS NONGTEUKSE_SISE_CNT            ,   /* 농특세-시세-건수         */     
      SUM(A.A28) AS NONGTEUKSE_SISE_AMT            ,   /* 농특세-시세-금액         */     
      SUM(A.A29) AS JIBANGSE_GUSE_CNT            ,   /* 지방세-구세-건수         */       
      SUM(A.A30) AS JIBANGSE_GUSE_AMT            ,   /* 지방세-구세-금액         */       
      SUM(A.A31) AS SEWOI_GUSE_CNT            ,   /* 세  외-구세-건수         */          
      SUM(A.A32) AS SEWOI_GUSE_AMT            ,   /* 세  외-구세-금액         */          
      SUM(A.A33) AS GYOYUKSE_GUSE_CNT            ,   /* 교육세-구세-건수         */       
      SUM(A.A34) AS GYOYUKSE_GUSE_AMT            ,   /* 교육세-구세-금액         */       
      SUM(A.A35) AS NONGTEUKSE_GUSE_CNT            ,   /* 농특세-구세-건수         */     
      SUM(A.A36) AS NONGTEUKSE_GUSE_AMT            ,   /* 농특세-구세-금액         */     
      SUM(A.A37) AS JIBANGSE_SANGSUDO_CNT             ,   /* 지방세-상수도-건수       */  
      SUM(A.A38) AS JIBANGSE_SANGSUDO_AMT            ,   /* 지방세-상수도-금액       */   
      SUM(A.A39) AS JIBANGSE_HASUDO_CNT           ,   /* 지방세-하수도-건수       */      
      SUM(A.A40) AS JIBANGSE_HASUDO_AMT           ,   /* 지방세-하수도-금액       */      
      SUM(A.A41) AS JIBANGSE_MULIYONG_CNT            ,   /* 지방세-물이용부담금-건수  */  
      SUM(A.A42) AS JIBANGSE_MULIYONG_AMT            ,   /* 지방세-물이용부담금-금액 */   
      SUM(A.A43) AS JIBANGSE_TEUGBYEOL_CNT           ,   /* 지방세-특별회계-건수     */   
      SUM(A.A44) AS JIBANGSE_TEUGBYEOL_AMT            ,   /* 지방세-특별회계-금액     */  
      SUM(A.A45) AS JIBANGSE_JAGEUMJOJEONG_CNT            ,   /* 지방세-자금조정-건수     */              
      SUM(A.A46) AS JIBANGSE_JAGEUMJOJEONG_AMT           ,   /* 지방세-자금조정-금액     */               
      SUM(A.A47) AS SEWOI_JAGEUMJOJEONG_CNT            ,   /* 세  외-자금조정-건수     */ 
      SUM(A.A48) AS SEWOI_JAGEUMJOJEONG_AMT            ,   /* 세  외-자금조정-금액     */ 
      SUM(A.A49) AS GYOYUKSE_JAGEUMJOJEONG_CNT            ,   /* 교육세-자금조정-건수     */              
      SUM(A.A50) AS GYOYUKSE_JAGEUMJOJEONG_AMT            ,   /* 교육세-자금조정-금액     */              
      SUM(A.A51) AS NONGTEUKSE_JAGEUMJOJEONG_CNT            ,   /* 농특세-자금조정-건수     */            
      SUM(A.A52) AS NONGTEUKSE_JAGEUMJOJEONG_AMT            ,   /* 농특세-자금조정-금액     */            
      SUM(A.A53) AS JIBANGSE_JINGSUCHOGTAG_CNT           ,   /* 지방세-징수촉탁-건수     */               
      SUM(A.A54) AS JIBANGSE_JINGSUCHOGTAG_AMT            ,   /* 지방세-징수촉탁-금액     */              
      SUM(A.A55) AS SEWOI_JINGSUCHOGTAG_CNT            ,   /* 세  외-징수촉탁-건수     */ 
      SUM(A.A56) AS SEWOI_JINGSUCHOGTAG_AMT           ,   /* 세  외-징수촉탁-금액     */  
      SUM(A.A57) AS GYOYUKSE_JINGSUCHOGTAG_CNT            ,   /* 교육세-징수촉탁-건수     */              
      SUM(A.A58) AS GYOYUKSE_JINGSUCHOGTAG_AMT            ,   /* 교육세-징수촉탁-금액     */              
      SUM(A.A59) AS NONGTEUKSE_JINGSUCHOGTAG_CNT            ,   /* 농특세-징수촉탁-건수     */            
      SUM(A.A60) AS NONGTEUKSE_JINGSUCHOGTAG_AMT           /* 농특세-징수촉탁-금액     */ 
FROM
      (      
            SELECT 
                  A.BANK_GUBUN       
                  ,CASE WHEN GEORAE_GUBUN IN (1,2,4) AND NVL(GEORAE_CHANNEL,0) IN (0,1) THEN NVL(BONSE_CNT     ,0) ELSE 0 END A01  /* 지방세-계-건수 */          
                  ,CASE WHEN GEORAE_GUBUN IN (1,2,4) AND NVL(GEORAE_CHANNEL,0) IN (0,1) THEN NVL(BONSE_AMT     ,0) ELSE 0 END A02  /* 지방세-계-금액 */          
                  ,CASE WHEN GEORAE_GUBUN IN (1,2,4) AND NVL(GEORAE_CHANNEL,0) IN (0,1) THEN NVL(SEWOI_CNT     ,0) ELSE 0 END A03  /* 세  외-계-건수 */          
                  ,CASE WHEN GEORAE_GUBUN IN (1,2,4) AND NVL(GEORAE_CHANNEL,0) IN (0,1) THEN NVL(SEWOI_AMT     ,0) ELSE 0 END A04  /* 세  외-계-금액 */          
                  ,CASE WHEN GEORAE_GUBUN IN (1,2,4) AND NVL(GEORAE_CHANNEL,0) IN (0,1) THEN NVL(GYOYUKSE_CNT  ,0) ELSE 0 END A05  /* 교육세-계-건수 */          
                  ,CASE WHEN GEORAE_GUBUN IN (1,2,4) AND NVL(GEORAE_CHANNEL,0) IN (0,1) THEN NVL(GYOYUKSE_AMT  ,0) ELSE 0 END A06  /* 교육세-계-금액 */          
                  ,CASE WHEN GEORAE_GUBUN IN (1,2,4) AND NVL(GEORAE_CHANNEL,0) IN (0,1) THEN NVL(NONGTEUKSE_CNT,0) ELSE 0 END A07  /* 농특세-계-건수 */          
                  ,CASE WHEN GEORAE_GUBUN IN (1,2,4) AND NVL(GEORAE_CHANNEL,0) IN (0,1) THEN NVL(NONGTEUKSE_AMT,0) ELSE 0 END A08  /* 농특세-계-금액 */          
                  ,CASE WHEN JIBGYE_CODE NOT IN (200010, 200020, 209330, 209331, 209332, 209333) AND GEORAE_GUBUN =1 AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(BONSE_CNT     ,0) ELSE 0 END A09  /* 지방세-지방세OCR-건수 */  
                  ,CASE WHEN JIBGYE_CODE NOT IN (200010, 200020, 209330, 209331, 209332, 209333) AND GEORAE_GUBUN =1 AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(BONSE_AMT     ,0) ELSE 0 END A10  /* 지방세-지방세OCR-금액 */  
                  ,CASE WHEN JIBGYE_CODE NOT IN (200010, 200020, 209330, 209331, 209332, 209333) AND GEORAE_GUBUN =1 AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(SEWOI_CNT     ,0) ELSE 0 END A11  /* 세  외-지방세OCR-건수 */  
                  ,CASE WHEN JIBGYE_CODE NOT IN (200010, 200020, 209330, 209331, 209332, 209333) AND GEORAE_GUBUN =1 AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(SEWOI_AMT     ,0) ELSE 0 END A12  /* 세  외-지방세OCR-금액 */  
                  ,CASE WHEN JIBGYE_CODE NOT IN (200010, 200020, 209330, 209331, 209332, 209333) AND GEORAE_GUBUN =1 AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(GYOYUKSE_CNT  ,0) ELSE 0 END A13  /* 교육세-지방세OCR-건수 */  
                  ,CASE WHEN JIBGYE_CODE NOT IN (200010, 200020, 209330, 209331, 209332, 209333) AND GEORAE_GUBUN =1 AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(GYOYUKSE_AMT  ,0) ELSE 0 END A14  /* 교육세-지방세OCR-금액 */  
                  ,CASE WHEN JIBGYE_CODE NOT IN (200010, 200020, 209330, 209331, 209332, 209333) AND GEORAE_GUBUN =1 AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(NONGTEUKSE_CNT,0) ELSE 0 END A15  /* 농특세-지방세OCR-건수 */  
                  ,CASE WHEN JIBGYE_CODE NOT IN (200010, 200020, 209330, 209331, 209332, 209333) AND GEORAE_GUBUN =1 AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(NONGTEUKSE_AMT,0) ELSE 0 END A16  /* 농특세-지방세OCR-금액 */  
                  ,0  A17   /* 지방세-상하수도물OCR-건수*/        
                  ,0  A18   /* 지방세-상하수도물OCR-금액*/        
                  ,CASE WHEN JIBGYE_CODE IN (200010,200020) AND GEORAE_GUBUN = 1 AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(BONSE_CNT     ,0) ELSE 0 END   A19   /* 지방세-환경개선OCR-건수  */         
                  ,CASE WHEN JIBGYE_CODE IN (200010,200020) AND GEORAE_GUBUN = 1 AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(BONSE_AMT     ,0) ELSE 0 END   A20   /* 지방세-환경개선OCR-금액  */         
                  ,CASE WHEN JIBGYE_CODE = 103000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(BONSE_CNT     ,0) ELSE 0 END   A21   /* 지방세-시세-건수         */         
                  ,CASE WHEN JIBGYE_CODE = 103000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(BONSE_AMT     ,0) ELSE 0 END   A22   /* 지방세-시세-금액         */         
                  ,CASE WHEN JIBGYE_CODE = 103000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(SEWOI_CNT     ,0) ELSE 0 END   A23   /* 세  외-시세-건수         */         
                  ,CASE WHEN JIBGYE_CODE = 103000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(SEWOI_AMT     ,0) ELSE 0 END   A24   /* 세  외-시세-금액         */         
                  ,CASE WHEN JIBGYE_CODE = 103000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(GYOYUKSE_CNT  ,0) ELSE 0 END   A25   /* 교육세-시세-건수         */         
                  ,CASE WHEN JIBGYE_CODE = 103000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(GYOYUKSE_AMT  ,0) ELSE 0 END   A26   /* 교육세-시세-금액         */         
                  ,CASE WHEN JIBGYE_CODE = 103000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(NONGTEUKSE_CNT,0) ELSE 0 END   A27   /* 농특세-시세-건수         */         
                  ,CASE WHEN JIBGYE_CODE = 103000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(NONGTEUKSE_AMT,0) ELSE 0 END   A28   /* 농특세-시세-금액         */         
                  ,CASE WHEN JIBGYE_CODE = 104000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(BONSE_CNT     ,0) ELSE 0 END   A29   /* 지방세-구세-건수         */         
                  ,CASE WHEN JIBGYE_CODE = 104000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(BONSE_AMT     ,0) ELSE 0 END   A30   /* 지방세-구세-금액         */         
                  ,CASE WHEN JIBGYE_CODE = 104000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(SEWOI_CNT     ,0) ELSE 0 END   A31   /* 세  외-구세-건수         */         
                  ,CASE WHEN JIBGYE_CODE = 104000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(SEWOI_AMT     ,0) ELSE 0 END   A32   /* 세  외-구세-금액         */         
                  ,CASE WHEN JIBGYE_CODE = 104000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(GYOYUKSE_CNT  ,0) ELSE 0 END   A33   /* 교육세-구세-건수         */         
                  ,CASE WHEN JIBGYE_CODE = 104000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(GYOYUKSE_AMT  ,0) ELSE 0 END   A34   /* 교육세-구세-금액         */         
                  ,CASE WHEN JIBGYE_CODE = 104000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(NONGTEUKSE_CNT,0) ELSE 0 END   A35   /* 농특세-구세-건수         */         
                  ,CASE WHEN JIBGYE_CODE = 104000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(NONGTEUKSE_AMT,0) ELSE 0 END   A36   /* 농특세-구세-금액         */         
                  ,CASE WHEN JIBGYE_CODE = 209330 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(BONSE_CNT     ,0) ELSE 0 END   A37   /* 지방세-상수도-건수       */         
                  ,CASE WHEN JIBGYE_CODE = 209330 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(BONSE_AMT     ,0) ELSE 0 END   A38   /* 지방세-상수도-금액       */         
                  ,CASE WHEN JIBGYE_CODE IN (209331, 209332) AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(BONSE_CNT,0) ELSE 0 END  A39   /* 지방세-하수도-건수       */         
                  ,CASE WHEN JIBGYE_CODE IN (209331, 209332) AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(BONSE_AMT,0) ELSE 0 END  A40   /* 지방세-하수도-금액       */         
                  ,CASE WHEN JIBGYE_CODE = 209333 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(BONSE_CNT,0) ELSE 0 END             A41   /* 지방세-물이용부담금-건수 */         
                  ,CASE WHEN JIBGYE_CODE = 209333 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(BONSE_AMT,0) ELSE 0 END             A42   /* 지방세-물이용부담금-금액 */         
                  ,CASE WHEN JIBGYE_CODE > 210000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(BONSE_CNT,0) ELSE 0 END             A43   /* 지방세-특별회계-건수     */         
                  ,CASE WHEN JIBGYE_CODE > 210000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(BONSE_AMT,0) ELSE 0 END             A44   /* 지방세-특별회계-금액     */         
                  ,0  A45       /* 지방세-자금조정-건수     */            
                  ,0  A46       /* 지방세-자금조정-금액     */              
                  ,0  A47       /* 세  외-자금조정-건수     */              
                  ,0  A48       /* 세  외-자금조정-금액     */              
                  ,0  A49       /* 교육세-자금조정-건수     */              
                  ,0  A50       /* 교육세-자금조정-금액     */              
                  ,0  A51       /* 농특세-자금조정-건수     */              
                  ,0  A52       /* 농특세-자금조정-금액     */              
                  ,0  A53       /* 지방세-징수촉탁-건수     */              
                  ,0  A54       /* 지방세-징수촉탁-금액     */              
                  ,0  A55       /* 세  외-징수촉탁-건수     */              
                  ,0  A56       /* 세  외-징수촉탁-금액     */              
                  ,0  A57       /* 교육세-징수촉탁-건수     */              
                  ,0  A58       /* 교육세-징수촉탁-금액     */              
                  ,0  A59       /* 농특세-징수촉탁-건수     */              
                  ,0  A60       /* 농특세-징수촉탁-금액     */              
             FROM  
                  RPT_SUNAP_JIBGYE A        
             WHERE 
                  A.SUNAPIL = '20250903'             
                  AND A.GEUMGO_CODE = '28'         
                  AND A.JIBGYE_CODE NOT IN (212300, 212400, 212500, 212600)     
                  AND A.BANK_GUBUN NOT IN (0,21,26,88,94,95,96,97,98,99,44,381,361,364,365,366,367,368,369,370,371,372,373,374,389,390,391,392,393)             
                  -- 상수도/하수도/물이용 부담금 OCR 분은 제외하고 계산                  
                  AND NOT(JIBGYE_CODE IN (209330, 209331, 209332, 209333) AND GEORAE_GUBUN = 1 AND NVL(GEORAE_CHANNEL,0) IN (0, 1))
                  AND (   -- 총괄이면 모든 건을 대상으로 함     
                          ( '0' = 0 ) 
                          OR    -- 신년도에 3월 이전이면, 년도구분이 신년도인 것이나 9999년도 것만 대상으로 함        
                                ( '0' = 1 AND SUBSTR('20250903',5,2) < '03' AND ( A.YEAR_GUBUN = 1 OR A.HOIGYE_YEAR = 9999 ) ) 
                          OR  -- 신년도에 3월 이상이면, 모든 건을 대상으로 함       
                              ( '0' = 1 AND SUBSTR('20250903',5,2) >='03' ) 
                          OR  -- 구년도에 3월 이전이면, 년도구분이 과년도(5), 구년도(9)인 것만 대상으로 함          
                              ( '0' = 2 AND SUBSTR('20250903',5,2) < '03' AND ( A.YEAR_GUBUN IN (5,9) ) ) 
                          OR  -- 구년도에 3월 이상이면, 모든 건을 제외 함           
                              ( '0' = 2 AND SUBSTR('20250903',5,2) >='03' AND 1 = 2 )            
                      )  
                  
              UNION ALL       

            -- 지방세-상하수도/물이용 OCR 금액 (전당월 타지 않도록)
            SELECT 
                  A.BANK_GUBUN       
                  ,CASE WHEN GEORAE_GUBUN IN (1,2,4) AND NVL(GEORAE_CHANNEL,0) IN (0,1) THEN NVL(BONSE_CNT     ,0) ELSE 0 END A01  /* 지방세-계-건수 */          
                  ,CASE WHEN GEORAE_GUBUN IN (1,2,4) AND NVL(GEORAE_CHANNEL,0) IN (0,1) THEN NVL(BONSE_AMT     ,0) ELSE 0 END A02  /* 지방세-계-금액 */          
                  ,0 A03  /* 세  외-계-건수 */          
                  ,0 A04  /* 세  외-계-금액 */          
                  ,0 A05  /* 교육세-계-건수 */          
                  ,0 A06  /* 교육세-계-금액 */          
                  ,0 A07  /* 농특세-계-건수 */          
                  ,0 A08  /* 농특세-계-금액 */          
                  ,0 A09  /* 지방세-지방세OCR-건수 */  
                  ,0 A10  /* 지방세-지방세OCR-금액 */  
                  ,0 A11  /* 세  외-지방세OCR-건수 */  
                  ,0 A12  /* 세  외-지방세OCR-금액 */  
                  ,0 A13  /* 교육세-지방세OCR-건수 */  
                  ,0 A14  /* 교육세-지방세OCR-금액 */  
                  ,0 A15  /* 농특세-지방세OCR-건수 */  
                  ,0 A16  /* 농특세-지방세OCR-금액 */  
                  ,CASE WHEN JIBGYE_CODE IN (209330,209331,209332,209333) AND GEORAE_GUBUN = 1 AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(BONSE_CNT,0) ELSE 0 END  A17   /* 지방세-상하수도물OCR-건수*/        
                  ,CASE WHEN JIBGYE_CODE IN (209330,209331,209332,209333) AND GEORAE_GUBUN = 1 AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(BONSE_AMT,0) ELSE 0 END  A18   /* 지방세-상하수도물OCR-금액*/        
                  ,0   A19   /* 지방세-환경개선OCR-건수  */         
                  ,0   A20   /* 지방세-환경개선OCR-금액  */         
                  ,0   A21   /* 지방세-시세-건수         */         
                  ,0   A22   /* 지방세-시세-금액         */         
                  ,0   A23   /* 세  외-시세-건수         */         
                  ,0   A24   /* 세  외-시세-금액         */         
                  ,0   A25   /* 교육세-시세-건수         */         
                  ,0   A26   /* 교육세-시세-금액         */         
                  ,0   A27   /* 농특세-시세-건수         */         
                  ,0   A28   /* 농특세-시세-금액         */         
                  ,0   A29   /* 지방세-구세-건수         */         
                  ,0   A30   /* 지방세-구세-금액         */         
                  ,0   A31   /* 세  외-구세-건수         */         
                  ,0   A32   /* 세  외-구세-금액         */         
                  ,0   A33   /* 교육세-구세-건수         */         
                  ,0   A34   /* 교육세-구세-금액         */         
                  ,0   A35   /* 농특세-구세-건수         */         
                  ,0   A36   /* 농특세-구세-금액         */         
                  ,0   A37   /* 지방세-상수도-건수       */         
                  ,0   A38   /* 지방세-상수도-금액       */         
                  ,0  A39   /* 지방세-하수도-건수       */         
                  ,0  A40   /* 지방세-하수도-금액       */         
                  ,0             A41   /* 지방세-물이용부담금-건수 */         
                  ,0             A42   /* 지방세-물이용부담금-금액 */         
                  ,0             A43   /* 지방세-특별회계-건수     */         
                  ,0             A44   /* 지방세-특별회계-금액     */         
                  ,0  A45       /* 지방세-자금조정-건수     */            
                  ,0  A46       /* 지방세-자금조정-금액     */              
                  ,0  A47       /* 세  외-자금조정-건수     */              
                  ,0  A48       /* 세  외-자금조정-금액     */              
                  ,0  A49       /* 교육세-자금조정-건수     */              
                  ,0  A50       /* 교육세-자금조정-금액     */              
                  ,0  A51       /* 농특세-자금조정-건수     */              
                  ,0  A52       /* 농특세-자금조정-금액     */              
                  ,0  A53       /* 지방세-징수촉탁-건수     */              
                  ,0  A54       /* 지방세-징수촉탁-금액     */              
                  ,0  A55       /* 세  외-징수촉탁-건수     */              
                  ,0  A56       /* 세  외-징수촉탁-금액     */              
                  ,0  A57       /* 교육세-징수촉탁-건수     */              
                  ,0  A58       /* 교육세-징수촉탁-금액     */              
                  ,0  A59       /* 농특세-징수촉탁-건수     */              
                  ,0  A60       /* 농특세-징수촉탁-금액     */              
             FROM  
                  RPT_SUNAP_JIBGYE A        
             WHERE 
                  -- 전당월인지 판별 '20250903' 당월 첫 영업일자이며, 전월 말일과 마지막 영업일이 다른 경우 (말일이 휴일)
                   A.SUNAPIL = (SELECT NVL(MAX(BF1MM_LST_BIZ_DT), '20250903') AS SANG_DT
                        FROM MAP_JOB_DATE
                        WHERE DW_BAS_DDT = '20250903'
                        AND ST1_BIZ_DT = '20250903'
                        AND BF1MM_END_DT != BF1MM_LST_BIZ_DT)
                  -- 거래일은 화면 조회일 포함 6영업일자
                  AND A.KEORAEIL = (SELECT MAX(II.DW_BAS_DDT) FROM MAP_JOB_DATE II WHERE II.BF5_BIZ_DT = '20250903' AND II.DT_G = 0 )         
                  AND A.GEUMGO_CODE = '28'         
                  AND A.JIBGYE_CODE NOT IN (212300, 212400, 212500, 212600)     
                  AND A.BANK_GUBUN NOT IN (0,21,26,88,94,95,96,97,98,99,44,381,361,364,365,366,367,368,369,370,371,372,373,374,389,390,391,392,393)             
                  -- 상수도/하수도/물이용 부담금 OCR 분만 선택  
             AND JIBGYE_CODE IN (209330, 209331, 209332, 209333) AND GEORAE_GUBUN = 1 AND NVL(GEORAE_CHANNEL,0) IN (0, 1)
                  AND (   -- 총괄이면 모든 건을 대상으로 함     
                          ( '0' = 0 ) 
                          OR    -- 신년도에 3월 이전이면, 년도구분이 신년도인 것이나 9999년도 것만 대상으로 함        
                                ( '0' = 1 AND SUBSTR('20250903',5,2) < '03' AND ( A.YEAR_GUBUN = 1 OR A.HOIGYE_YEAR = 9999 ) ) 
                          OR  -- 신년도에 3월 이상이면, 모든 건을 대상으로 함       
                              ( '0' = 1 AND SUBSTR('20250903',5,2) >='03' ) 
                          OR  -- 구년도에 3월 이전이면, 년도구분이 과년도(5), 구년도(9)인 것만 대상으로 함          
                              ( '0' = 2 AND SUBSTR('20250903',5,2) < '03' AND ( A.YEAR_GUBUN IN (5,9) ) ) 
                          OR  -- 구년도에 3월 이상이면, 모든 건을 제외 함           
                              ( '0' = 2 AND SUBSTR('20250903',5,2) >='03' AND 1 = 2 )            
                      )  
                  
              UNION ALL       

              SELECT 
                    BANK_GUBUN               
                    ,0              A01    /* 지방세-계-건수           */     
                    ,0              A02    /* 지방세-계-금액           */     
                    ,0              A03    /* 세  외-계-건수           */     
                    ,0              A04    /* 세  외-계-금액           */     
                    ,0              A05    /* 교육세-계-건수           */     
                    ,0              A06    /* 교육세-계-금액           */     
                    ,0              A07    /* 농특세-계-건수           */     
                    ,0              A08    /* 농특세-계-금액           */     
                    ,0              A09    /* 지방세-지방세OCR-건수    */     
                    ,0              A10    /* 지방세-지방세OCR-금액    */     
                    ,0              A11    /* 세  외-지방세OCR-건수    */     
                    ,0              A12    /* 세  외-지방세OCR-금액    */     
                    ,0              A13    /* 교육세-지방세OCR-건수    */     
                    ,0              A14    /* 교육세-지방세OCR-금액    */     
                    ,0              A15    /* 농특세-지방세OCR-건수    */     
                    ,0              A16    /* 농특세-지방세OCR-금액    */     
                    ,0              A17    /* 지방세-상하수도물-건수   */     
                    ,0              A18    /* 지방세-상하수도물-금액   */     
                    ,0              A19    /* 지방세-환경개선OCR-건수  */     
                    ,0              A20    /* 지방세-환경개선OCR-금액  */     
                    ,0              A21    /* 지방세-시세-건수         */     
                    ,0              A22    /* 지방세-시세-금액         */     
                    ,0              A23    /* 세  외-시세-건수         */     
                    ,0              A24    /* 세  외-시세-금액         */     
                    ,0              A25    /* 교육세-시세-건수         */     
                    ,0              A26    /* 교육세-시세-금액         */     
                    ,0              A27    /* 농특세-시세-건수         */     
                    ,0              A28    /* 농특세-시세-금액         */     
                    ,0              A29    /* 지방세-구세-건수         */     
                    ,0              A30    /* 지방세-구세-금액         */     
                    ,0              A31    /* 세  외-구세-건수         */     
                    ,0              A32    /* 세  외-구세-금액         */     
                    ,0              A33    /* 교육세-구세-건수         */     
                    ,0              A34    /* 교육세-구세-금액         */     
                    ,0              A35    /* 농특세-구세-건수         */     
                    ,0              A36    /* 농특세-구세-금액         */     
                    ,0              A37    /* 지방세-하수도-건수       */     
                    ,0              A38    /* 세  외-하수도-금액       */     
                    ,0              A39    /* 지방세-물이용부담금-건수 */     
                    ,0              A40    /* 지방세-물이용부담금-금액 */     
                    ,0              A41    /* 지방세-특별회계-건수     */     
                    ,0              A42    /* 지방세-특별회계-금액     */     
                    ,0              A43    /* 지방세-특별회계-금액     */     
                    ,0              A44    /* 지방세-특별회계-건수     */     
                    ,(CASE WHEN A.IPJI_GUBUN=1 THEN NVL(A.JIBANGSE_CNT,0) ELSE 0 END) - (CASE WHEN A.IPJI_GUBUN=2 THEN NVL(A.JIBANGSE_CNT,0) ELSE 0 END) A45 /* 지방세-자금조정-건수 */ 
                    ,(CASE WHEN A.IPJI_GUBUN=1 THEN NVL(A.JIBANGSE_AMT,0) ELSE 0 END) - (CASE WHEN A.IPJI_GUBUN=2 THEN NVL(A.JIBANGSE_AMT,0) ELSE 0 END) A46 /* 지방세-자금조정-금액 */ 
                    ,(CASE WHEN A.IPJI_GUBUN=1 THEN NVL(A.SEWOI_CNT   ,0) ELSE 0 END) - (CASE WHEN A.IPJI_GUBUN=2 THEN NVL(A.SEWOI_CNT   ,0) ELSE 0 END) A47 /* 세  외-자금조정-건수 */ 
                    ,(CASE WHEN A.IPJI_GUBUN=1 THEN NVL(A.SEWOI_AMT   ,0) ELSE 0 END) - (CASE WHEN A.IPJI_GUBUN=2 THEN NVL(A.SEWOI_AMT   ,0) ELSE 0 END) A48 /* 세  외-자금조정-금액 */ 
                    ,0         A49 /* 교육세-자금조정-건수 */ 
                    ,(CASE WHEN A.IPJI_GUBUN=1 THEN NVL(A.GYOYUKSE_AMT,0) ELSE 0 END) - (CASE WHEN A.IPJI_GUBUN=2 THEN NVL(A.GYOYUKSE_AMT,0) ELSE 0 END)     A50 /* 교육세-자금조정-금액 */ 
                    ,0         A51 /* 농특세-자금조정-건수 */ 
                    ,(CASE WHEN A.IPJI_GUBUN=1 THEN NVL(A.NONGTEUKSE_AMT,0) ELSE 0 END) - (CASE WHEN A.IPJI_GUBUN=2 THEN NVL(A.NONGTEUKSE_AMT,0) ELSE 0 END) A52 /* 농특세-자금조정-금액 */ 
                    ,0              A53    /* 지방세-징수촉탁-건수     */     
                    ,0              A54    /* 지방세-징수촉탁-금액     */     
                    ,0              A55    /* 세  외-징수촉탁-건수     */     
                    ,0              A56    /* 세  외-징수촉탁-금액     */     
                    ,0              A57    /* 교육세-징수촉탁-건수     */     
                    ,0              A58    /* 교육세-징수촉탁-금액     */     
                    ,0              A59    /* 농특세-징수촉탁-건수     */     
                    ,0              A60    /* 농특세-징수촉탁-금액     */     
              FROM 
                    RPT_DANGSEIPJOJEONG A    
              WHERE 
                    A.SUNAPIL = '20250903'             
                    AND A.GEUMGO_CODE = '28'         
                    AND A.JIBGYE_CODE NOT IN (212300, 212400, 212500, 212600)     
                    AND A.BANK_GUBUN NOT IN (0,21,26,88,94,95,96,97,98,99,44,381,361,364,365,366,367,368,369,370,371,372,373,374,389,390,391,392,393)             
                    AND A.JOJEONG_GUBUN = 1       
                    
                    AND (   -- 총괄이면 모든 건을 대상으로 함     
                          ( '0' = 0 ) 
                          OR    -- 신년도에 3월 이전이면, 년도구분이 신년도인 것이나 9999년도 것만 대상으로 함        
                                ( '0' = 1 AND SUBSTR('20250903',5,2) < '03' AND ( A.YEAR_GUBUN = 1 OR A.HOIGYE_YEAR = 9999 ) ) 
                          OR  -- 신년도에 3월 이상이면, 모든 건을 대상으로 함       
                              ( '0' = 1 AND SUBSTR('20250903',5,2) >='03' ) 
                          OR  -- 구년도에 3월 이전이면, 년도구분이 과년도(5), 구년도(9)인 것만 대상으로 함          
                              ( '0' = 2 AND SUBSTR('20250903',5,2) < '03' AND ( A.YEAR_GUBUN IN (5,9) ) ) 
                          OR  -- 구년도에 3월 이상이면, 모든 건을 제외 함           
                              ( '0' = 2 AND SUBSTR('20250903',5,2) >='03' AND 1 = 2 )            
                        )
                                
              UNION ALL       
              SELECT 
                    A.BANK_GUBUN             
                    ,NVL(BONSE_CNT     ,0) A01    /* 지방세-계-건수           */               
                    ,NVL(BONSE_AMT     ,0) A02    /* 지방세-계-금액           */               
                    ,NVL(SEWOI_CNT     ,0) A03    /* 세  외-계-건수           */               
                    ,NVL(SEWOI_AMT     ,0) A04    /* 세  외-계-금액           */               
                    ,NVL(GYOYUKSE_CNT  ,0) A05    /* 교육세-계-건수           */               
                    ,NVL(GYOYUKSE_AMT  ,0) A06    /* 교육세-계-금액           */               
                    ,NVL(NONGTEUKSE_CNT,0) A07    /* 농특세-계-건수           */               
                    ,NVL(NONGTEUKSE_AMT,0) A08    /* 농특세-계-금액           */               
                    ,0     A09    /* 지방세-지방세OCR-건수    */               
                    ,0     A10    /* 지방세-지방세OCR-금액    */               
                    ,0     A11    /* 세  외-지방세OCR-건수    */               
                    ,0     A12    /* 세  외-지방세OCR-금액    */               
                    ,0     A13    /* 교육세-지방세OCR-건수    */               
                    ,0     A14    /* 교육세-지방세OCR-금액    */               
                    ,0     A15    /* 농특세-지방세OCR-건수    */               
                    ,0     A16    /* 농특세-지방세OCR-금액    */               
                    ,0     A17    /* 지방세-상하수도물-건수   */               
                    ,0     A18    /* 지방세-상하수도물-금액   */               
                    ,0     A19    /* 지방세-환경개선OCR-건수  */               
                    ,0     A20    /* 지방세-환경개선OCR-금액  */               
                    ,0     A21    /* 지방세-시세-건수         */               
                    ,0     A22    /* 지방세-시세-금액         */               
                    ,0     A23    /* 세  외-시세-건수         */               
                    ,0     A24    /* 세  외-시세-금액         */               
                    ,0     A25    /* 교육세-시세-건수         */               
                    ,0     A26    /* 교육세-시세-금액         */               
                    ,0     A27    /* 농특세-시세-건수         */               
                    ,0     A28    /* 농특세-시세-금액         */               
                    ,0     A29    /* 지방세-구세-건수         */               
                    ,0     A30    /* 지방세-구세-금액         */               
                    ,0     A31    /* 세  외-구세-건수         */               
                    ,0     A32    /* 세  외-구세-금액         */               
                    ,0     A33    /* 교육세-구세-건수         */               
                    ,0     A34    /* 교육세-구세-금액         */               
                    ,0     A35    /* 농특세-구세-건수         */               
                    ,0     A36    /* 농특세-구세-금액         */               
                    ,0     A37    /* 지방세-하수도-건수       */               
                    ,0     A38    /* 세  외-하수도-금액       */               
                    ,0     A39    /* 지방세-물이용부담금-건수 */               
                    ,0     A40    /* 지방세-물이용부담금-금액 */               
                    ,0     A41    /* 지방세-특별회계-건수     */               
                    ,0     A42    /* 지방세-특별회계-금액     */               
                    ,0     A43    /* 지방세-특별회계-금액     */               
                    ,0     A44    /* 지방세-특별회계-건수     */               
                    ,0     A45    /* 지방세-자금조정-건수     */               
                    ,0     A46    /* 지방세-자금조정-금액     */               
                    ,0     A47    /* 세  외-자금조정-건수     */               
                    ,0     A48    /* 세  외-자금조정-금액     */               
                    ,0     A49    /* 교육세-자금조정-건수     */               
                    ,0     A50    /* 교육세-자금조정-금액     */               
                    ,0     A51    /* 농특세-자금조정-건수     */               
                    ,0     A52    /* 농특세-자금조정-금액     */               
                    ,NVL(BONSE_CNT     ,0) A53    /* 지방세-징수촉탁-건수     */               
                    ,NVL(BONSE_AMT     ,0) A54    /* 지방세-징수촉탁-금액     */               
                    ,NVL(SEWOI_CNT     ,0) A55    /* 세  외-징수촉탁-건수     */               
                    ,NVL(SEWOI_AMT     ,0) A56    /* 세  외-징수촉탁-금액     */               
                    ,NVL(GYOYUKSE_CNT  ,0) A57    /* 교육세-징수촉탁-건수     */               
                    ,NVL(GYOYUKSE_AMT  ,0) A58    /* 교육세-징수촉탁-금액     */               
                    ,NVL(NONGTEUKSE_CNT,0) A59    /* 농특세-징수촉탁-건수     */               
                    ,NVL(NONGTEUKSE_AMT,0) A60    /* 농특세-징수촉탁-금액     */               
              FROM  
                    RPT_SUNAP_JIBGYE A        
              WHERE 
                    A.SUNAPIL = '20250903'             
                    AND A.GEUMGO_CODE = 99  -- 금고코드 99는 징수촉탁 전용        
                    AND A.BANK_GUBUN NOT IN (0,21,26,88,94,95,96,97,98,99,44,381,361,364,365,366,367,368,369,370,371,372,373,374,389,390,391,392,393)             
                    
                    AND (   -- 총괄이면 모든 건을 대상으로 함     
                          ( '0' = 0 ) OR            
                          -- 신년도에 3월 이전이면, 년도구분이 신년도인 것이나 9999년도 것만 대상으로 함        
                          ( '0' = 1 AND SUBSTR('20250903',5,2) < '03' AND ( A.YEAR_GUBUN = 1 OR A.HOIGYE_YEAR = 9999 ) ) OR  
                          -- 신년도에 3월 이상이면, 모든 건을 대상으로 함       
                          ( '0' = 1 AND SUBSTR('20250903',5,2) >='03' ) OR   
                          -- 구년도에 3월 이전이면, 년도구분이 과년도(5), 구년도(9)인 것만 대상으로 함          
                          ( '0' = 2 AND SUBSTR('20250903',5,2) < '03' AND ( A.YEAR_GUBUN IN (5,9) ) ) OR     
                          -- 구년도에 3월 이상이면, 모든 건을 제외 함           
                          ( '0' = 2 AND SUBSTR(?,5,2) >='03' AND 1 = 2 )            
                        )
                                
      ) A
      INNER JOIN SFI_CMM_C_DAT B                        
        ON B.CMM_C_NM = 'RPT은행코드'
        AND B.USE_YN = 'Y'
        AND TO_CHAR(A.BANK_GUBUN) = B.CMM_DTL_C
      INNER JOIN SFI_CMM_C_DAT C
        ON C.CMM_C_NM = 'RPT대표은행코드'
        AND B.USE_YN = 'Y'
        AND B.HRNK_CMM_DTL_C = C.CMM_DTL_C
GROUP BY 
      B.HRNK_CMM_DTL_C, C.CMM_DTL_C_NM
ORDER BY 
      TO_NUMBER(B.HRNK_CMM_DTL_C)


--------------------------------------------------------


SELECT 
      TO_CHAR(B.HRNK_CMM_DTL_C) AS BANK_NO ,           
      TO_CHAR(NVL(B.HRNK_CMM_DTL_C,0)) || '.' || TRIM(C.CMM_DTL_C_NM) AS BANK_NM           ,       
      SUM(A.A01) AS JIBANGSE_CNT            ,   /* 지방세-계-건수           */            
      SUM(A.A02) AS JIBANGSE_AMT           ,   /* 지방세-계-금액           */             
      SUM(A.A03) AS SEWOI_CNT            ,   /* 세  외-계-건수           */               
      SUM(A.A04) AS SEWOI_AMT            ,   /* 세  외-계-금액           */               
      SUM(A.A05) AS GYOYUKSE_CNT            ,   /* 교육세-계-건수           */            
      SUM(A.A06) AS GYOYUKSE_AMT           ,   /* 교육세-계-금액           */             
      SUM(A.A07) AS NONGTEUKSE_CNT            ,   /* 농특세-계-건수           */          
      SUM(A.A08) AS NONGTEUKSE_AMT            ,   /* 농특세-계-금액           */          
      SUM(A.A09) AS JIBANGSE_JIBANGSE_CNT         ,   /* 지방세-지방세OCR-건수    */      
      SUM(A.A10) AS JIBANGSE_JIBANGSE_AMT           ,   /* 지방세-지방세OCR-금액    */    
      SUM(A.A11) AS SEWOI_JIBANGSE_CNT            ,   /* 세  외-지방세OCR-건수    */      
      SUM(A.A12) AS SEWOI_JIBANGSE_AMT            ,   /* 세  외-지방세OCR-금액    */      
      SUM(A.A13) AS GYOYUKSE_JIBANGSE_CNT            ,   /* 교육세-지방세OCR-건수    */   
      SUM(A.A14) AS GYOYUKSE_JIBANGSE_AMT            ,   /* 교육세-지방세OCR-금액    */   
      SUM(A.A15) AS NONGTEUKSE_JIBANGSE_CNT            ,   /* 농특세-지방세OCR-건수    */ 
      SUM(A.A16) AS NONGTEUKSE_JIBANGSE_AMT            ,   /* 농특세-지방세OCR-금액    */ 
      SUM(A.A17) AS JIBANGSE_SANGHASUDO_CNT            ,   /* 지방세-상하수도물OCR-건수   */              
      SUM(A.A18) AS JIBANGSE_SANGHASUDO_AMT            ,   /* 지방세-상하수도물OCR-금액   */              
      SUM(A.A19) AS JIBANGSE_OCR_CNT            ,   /* 지방세-환경개선OCR-건수  */        
      SUM(A.A20) AS JIBANGSE_OCR_AMT            ,   /* 지방세-환경개선OCR-금액  */        
      SUM(A.A21) AS JIBANGSE_SISE_CNT            ,   /* 지방세-시세-건수         */       
      SUM(A.A22) AS JIBANGSE_SISE_AMT            ,   /* 지방세-시세-금액         */       
      SUM(A.A23) AS SEWOI_SISE_CNT            ,   /* 세  외-시세-건수         */          
      SUM(A.A24) AS SEWOI_SISE_AMT            ,   /* 세  외-시세-금액         */          
      SUM(A.A25) AS GYOYUKSE_SISE_CNT            ,   /* 교육세-시세-건수         */       
      SUM(A.A26) AS GYOYUKSE_SISE_AMT            ,   /* 교육세-시세-금액         */       
      SUM(A.A27) AS NONGTEUKSE_SISE_CNT            ,   /* 농특세-시세-건수         */     
      SUM(A.A28) AS NONGTEUKSE_SISE_AMT            ,   /* 농특세-시세-금액         */     
      SUM(A.A29) AS JIBANGSE_GUSE_CNT            ,   /* 지방세-구세-건수         */       
      SUM(A.A30) AS JIBANGSE_GUSE_AMT            ,   /* 지방세-구세-금액         */       
      SUM(A.A31) AS SEWOI_GUSE_CNT            ,   /* 세  외-구세-건수         */          
      SUM(A.A32) AS SEWOI_GUSE_AMT            ,   /* 세  외-구세-금액         */          
      SUM(A.A33) AS GYOYUKSE_GUSE_CNT            ,   /* 교육세-구세-건수         */       
      SUM(A.A34) AS GYOYUKSE_GUSE_AMT            ,   /* 교육세-구세-금액         */       
      SUM(A.A35) AS NONGTEUKSE_GUSE_CNT            ,   /* 농특세-구세-건수         */     
      SUM(A.A36) AS NONGTEUKSE_GUSE_AMT            ,   /* 농특세-구세-금액         */     
      SUM(A.A37) AS JIBANGSE_SANGSUDO_CNT             ,   /* 지방세-상수도-건수       */  
      SUM(A.A38) AS JIBANGSE_SANGSUDO_AMT            ,   /* 지방세-상수도-금액       */   
      SUM(A.A39) AS JIBANGSE_HASUDO_CNT           ,   /* 지방세-하수도-건수       */      
      SUM(A.A40) AS JIBANGSE_HASUDO_AMT           ,   /* 지방세-하수도-금액       */      
      SUM(A.A41) AS JIBANGSE_MULIYONG_CNT            ,   /* 지방세-물이용부담금-건수  */  
      SUM(A.A42) AS JIBANGSE_MULIYONG_AMT            ,   /* 지방세-물이용부담금-금액 */   
      SUM(A.A43) AS JIBANGSE_TEUGBYEOL_CNT           ,   /* 지방세-특별회계-건수     */   
      SUM(A.A44) AS JIBANGSE_TEUGBYEOL_AMT            ,   /* 지방세-특별회계-금액     */  
      SUM(A.A45) AS JIBANGSE_JAGEUMJOJEONG_CNT            ,   /* 지방세-자금조정-건수     */              
      SUM(A.A46) AS JIBANGSE_JAGEUMJOJEONG_AMT           ,   /* 지방세-자금조정-금액     */               
      SUM(A.A47) AS SEWOI_JAGEUMJOJEONG_CNT            ,   /* 세  외-자금조정-건수     */ 
      SUM(A.A48) AS SEWOI_JAGEUMJOJEONG_AMT            ,   /* 세  외-자금조정-금액     */ 
      SUM(A.A49) AS GYOYUKSE_JAGEUMJOJEONG_CNT            ,   /* 교육세-자금조정-건수     */              
      SUM(A.A50) AS GYOYUKSE_JAGEUMJOJEONG_AMT            ,   /* 교육세-자금조정-금액     */              
      SUM(A.A51) AS NONGTEUKSE_JAGEUMJOJEONG_CNT            ,   /* 농특세-자금조정-건수     */            
      SUM(A.A52) AS NONGTEUKSE_JAGEUMJOJEONG_AMT            ,   /* 농특세-자금조정-금액     */            
      SUM(A.A53) AS JIBANGSE_JINGSUCHOGTAG_CNT           ,   /* 지방세-징수촉탁-건수     */               
      SUM(A.A54) AS JIBANGSE_JINGSUCHOGTAG_AMT            ,   /* 지방세-징수촉탁-금액     */              
      SUM(A.A55) AS SEWOI_JINGSUCHOGTAG_CNT            ,   /* 세  외-징수촉탁-건수     */ 
      SUM(A.A56) AS SEWOI_JINGSUCHOGTAG_AMT           ,   /* 세  외-징수촉탁-금액     */  
      SUM(A.A57) AS GYOYUKSE_JINGSUCHOGTAG_CNT            ,   /* 교육세-징수촉탁-건수     */              
      SUM(A.A58) AS GYOYUKSE_JINGSUCHOGTAG_AMT            ,   /* 교육세-징수촉탁-금액     */              
      SUM(A.A59) AS NONGTEUKSE_JINGSUCHOGTAG_CNT            ,   /* 농특세-징수촉탁-건수     */            
      SUM(A.A60) AS NONGTEUKSE_JINGSUCHOGTAG_AMT           /* 농특세-징수촉탁-금액     */ 
FROM
      (      
            SELECT 
                  A.BANK_GUBUN       
                  ,CASE WHEN GEORAE_GUBUN IN (1,2,4) AND NVL(GEORAE_CHANNEL,0) IN (0,1) THEN NVL(BONSE_CNT     ,0) ELSE 0 END A01  /* 지방세-계-건수 */          
                  ,CASE WHEN GEORAE_GUBUN IN (1,2,4) AND NVL(GEORAE_CHANNEL,0) IN (0,1) THEN NVL(BONSE_AMT     ,0) ELSE 0 END A02  /* 지방세-계-금액 */          
                  ,CASE WHEN GEORAE_GUBUN IN (1,2,4) AND NVL(GEORAE_CHANNEL,0) IN (0,1) THEN NVL(SEWOI_CNT     ,0) ELSE 0 END A03  /* 세  외-계-건수 */          
                  ,CASE WHEN GEORAE_GUBUN IN (1,2,4) AND NVL(GEORAE_CHANNEL,0) IN (0,1) THEN NVL(SEWOI_AMT     ,0) ELSE 0 END A04  /* 세  외-계-금액 */          
                  ,CASE WHEN GEORAE_GUBUN IN (1,2,4) AND NVL(GEORAE_CHANNEL,0) IN (0,1) THEN NVL(GYOYUKSE_CNT  ,0) ELSE 0 END A05  /* 교육세-계-건수 */          
                  ,CASE WHEN GEORAE_GUBUN IN (1,2,4) AND NVL(GEORAE_CHANNEL,0) IN (0,1) THEN NVL(GYOYUKSE_AMT  ,0) ELSE 0 END A06  /* 교육세-계-금액 */          
                  ,CASE WHEN GEORAE_GUBUN IN (1,2,4) AND NVL(GEORAE_CHANNEL,0) IN (0,1) THEN NVL(NONGTEUKSE_CNT,0) ELSE 0 END A07  /* 농특세-계-건수 */          
                  ,CASE WHEN GEORAE_GUBUN IN (1,2,4) AND NVL(GEORAE_CHANNEL,0) IN (0,1) THEN NVL(NONGTEUKSE_AMT,0) ELSE 0 END A08  /* 농특세-계-금액 */          
                  ,CASE WHEN JIBGYE_CODE NOT IN (200010, 200020, 209330, 209331, 209332, 209333) AND GEORAE_GUBUN =1 AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(BONSE_CNT     ,0) ELSE 0 END A09  /* 지방세-지방세OCR-건수 */  
                  ,CASE WHEN JIBGYE_CODE NOT IN (200010, 200020, 209330, 209331, 209332, 209333) AND GEORAE_GUBUN =1 AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(BONSE_AMT     ,0) ELSE 0 END A10  /* 지방세-지방세OCR-금액 */  
                  ,CASE WHEN JIBGYE_CODE NOT IN (200010, 200020, 209330, 209331, 209332, 209333) AND GEORAE_GUBUN =1 AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(SEWOI_CNT     ,0) ELSE 0 END A11  /* 세  외-지방세OCR-건수 */  
                  ,CASE WHEN JIBGYE_CODE NOT IN (200010, 200020, 209330, 209331, 209332, 209333) AND GEORAE_GUBUN =1 AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(SEWOI_AMT     ,0) ELSE 0 END A12  /* 세  외-지방세OCR-금액 */  
                  ,CASE WHEN JIBGYE_CODE NOT IN (200010, 200020, 209330, 209331, 209332, 209333) AND GEORAE_GUBUN =1 AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(GYOYUKSE_CNT  ,0) ELSE 0 END A13  /* 교육세-지방세OCR-건수 */  
                  ,CASE WHEN JIBGYE_CODE NOT IN (200010, 200020, 209330, 209331, 209332, 209333) AND GEORAE_GUBUN =1 AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(GYOYUKSE_AMT  ,0) ELSE 0 END A14  /* 교육세-지방세OCR-금액 */  
                  ,CASE WHEN JIBGYE_CODE NOT IN (200010, 200020, 209330, 209331, 209332, 209333) AND GEORAE_GUBUN =1 AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(NONGTEUKSE_CNT,0) ELSE 0 END A15  /* 농특세-지방세OCR-건수 */  
                  ,CASE WHEN JIBGYE_CODE NOT IN (200010, 200020, 209330, 209331, 209332, 209333) AND GEORAE_GUBUN =1 AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(NONGTEUKSE_AMT,0) ELSE 0 END A16  /* 농특세-지방세OCR-금액 */  
                  ,0  A17   /* 지방세-상하수도물OCR-건수*/        
                  ,0  A18   /* 지방세-상하수도물OCR-금액*/        
                  ,CASE WHEN JIBGYE_CODE IN (200010,200020) AND GEORAE_GUBUN = 1 AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(BONSE_CNT     ,0) ELSE 0 END   A19   /* 지방세-환경개선OCR-건수  */         
                  ,CASE WHEN JIBGYE_CODE IN (200010,200020) AND GEORAE_GUBUN = 1 AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(BONSE_AMT     ,0) ELSE 0 END   A20   /* 지방세-환경개선OCR-금액  */         
                  ,CASE WHEN JIBGYE_CODE = 103000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(BONSE_CNT     ,0) ELSE 0 END   A21   /* 지방세-시세-건수         */         
                  ,CASE WHEN JIBGYE_CODE = 103000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(BONSE_AMT     ,0) ELSE 0 END   A22   /* 지방세-시세-금액         */         
                  ,CASE WHEN JIBGYE_CODE = 103000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(SEWOI_CNT     ,0) ELSE 0 END   A23   /* 세  외-시세-건수         */         
                  ,CASE WHEN JIBGYE_CODE = 103000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(SEWOI_AMT     ,0) ELSE 0 END   A24   /* 세  외-시세-금액         */         
                  ,CASE WHEN JIBGYE_CODE = 103000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(GYOYUKSE_CNT  ,0) ELSE 0 END   A25   /* 교육세-시세-건수         */         
                  ,CASE WHEN JIBGYE_CODE = 103000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(GYOYUKSE_AMT  ,0) ELSE 0 END   A26   /* 교육세-시세-금액         */         
                  ,CASE WHEN JIBGYE_CODE = 103000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(NONGTEUKSE_CNT,0) ELSE 0 END   A27   /* 농특세-시세-건수         */         
                  ,CASE WHEN JIBGYE_CODE = 103000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(NONGTEUKSE_AMT,0) ELSE 0 END   A28   /* 농특세-시세-금액         */         
                  ,CASE WHEN JIBGYE_CODE = 104000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(BONSE_CNT     ,0) ELSE 0 END   A29   /* 지방세-구세-건수         */         
                  ,CASE WHEN JIBGYE_CODE = 104000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(BONSE_AMT     ,0) ELSE 0 END   A30   /* 지방세-구세-금액         */         
                  ,CASE WHEN JIBGYE_CODE = 104000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(SEWOI_CNT     ,0) ELSE 0 END   A31   /* 세  외-구세-건수         */         
                  ,CASE WHEN JIBGYE_CODE = 104000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(SEWOI_AMT     ,0) ELSE 0 END   A32   /* 세  외-구세-금액         */         
                  ,CASE WHEN JIBGYE_CODE = 104000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(GYOYUKSE_CNT  ,0) ELSE 0 END   A33   /* 교육세-구세-건수         */         
                  ,CASE WHEN JIBGYE_CODE = 104000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(GYOYUKSE_AMT  ,0) ELSE 0 END   A34   /* 교육세-구세-금액         */         
                  ,CASE WHEN JIBGYE_CODE = 104000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(NONGTEUKSE_CNT,0) ELSE 0 END   A35   /* 농특세-구세-건수         */         
                  ,CASE WHEN JIBGYE_CODE = 104000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(NONGTEUKSE_AMT,0) ELSE 0 END   A36   /* 농특세-구세-금액         */         
                  ,CASE WHEN JIBGYE_CODE = 209330 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(BONSE_CNT     ,0) ELSE 0 END   A37   /* 지방세-상수도-건수       */         
                  ,CASE WHEN JIBGYE_CODE = 209330 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1)      THEN NVL(BONSE_AMT     ,0) ELSE 0 END   A38   /* 지방세-상수도-금액       */         
                  ,CASE WHEN JIBGYE_CODE IN (209331, 209332) AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(BONSE_CNT,0) ELSE 0 END  A39   /* 지방세-하수도-건수       */         
                  ,CASE WHEN JIBGYE_CODE IN (209331, 209332) AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(BONSE_AMT,0) ELSE 0 END  A40   /* 지방세-하수도-금액       */         
                  ,CASE WHEN JIBGYE_CODE = 209333 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(BONSE_CNT,0) ELSE 0 END             A41   /* 지방세-물이용부담금-건수 */         
                  ,CASE WHEN JIBGYE_CODE = 209333 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(BONSE_AMT,0) ELSE 0 END             A42   /* 지방세-물이용부담금-금액 */         
                  ,CASE WHEN JIBGYE_CODE > 210000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(BONSE_CNT,0) ELSE 0 END             A43   /* 지방세-특별회계-건수     */         
                  ,CASE WHEN JIBGYE_CODE > 210000 AND GEORAE_GUBUN IN (2,4) AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(BONSE_AMT,0) ELSE 0 END             A44   /* 지방세-특별회계-금액     */         
                  ,0  A45       /* 지방세-자금조정-건수     */            
                  ,0  A46       /* 지방세-자금조정-금액     */              
                  ,0  A47       /* 세  외-자금조정-건수     */              
                  ,0  A48       /* 세  외-자금조정-금액     */              
                  ,0  A49       /* 교육세-자금조정-건수     */              
                  ,0  A50       /* 교육세-자금조정-금액     */              
                  ,0  A51       /* 농특세-자금조정-건수     */              
                  ,0  A52       /* 농특세-자금조정-금액     */              
                  ,0  A53       /* 지방세-징수촉탁-건수     */              
                  ,0  A54       /* 지방세-징수촉탁-금액     */              
                  ,0  A55       /* 세  외-징수촉탁-건수     */              
                  ,0  A56       /* 세  외-징수촉탁-금액     */              
                  ,0  A57       /* 교육세-징수촉탁-건수     */              
                  ,0  A58       /* 교육세-징수촉탁-금액     */              
                  ,0  A59       /* 농특세-징수촉탁-건수     */              
                  ,0  A60       /* 농특세-징수촉탁-금액     */              
             FROM  
                  RPT_SUNAP_JIBGYE A        
             WHERE 
                  A.SUNAPIL = '20250903'             
                  AND A.GEUMGO_CODE = '28'         
                  AND A.JIBGYE_CODE NOT IN (212300, 212400, 212500, 212600)     
                  AND A.BANK_GUBUN NOT IN (0,21,26,88,94,95,96,97,98,99,44,381,361,364,365,366,367,368,369,370,371,372,373,374,389,390,391,392,393)             
                  -- 상수도/하수도/물이용 부담금 OCR 분은 제외하고 계산                  
                  AND NOT(JIBGYE_CODE IN (209330, 209331, 209332, 209333) AND GEORAE_GUBUN = 1 AND NVL(GEORAE_CHANNEL,0) IN (0, 1))
                  AND (   -- 총괄이면 모든 건을 대상으로 함     
                          ( '0' = 0 ) 
                          OR    -- 신년도에 3월 이전이면, 년도구분이 신년도인 것이나 9999년도 것만 대상으로 함        
                                ( '0' = 1 AND SUBSTR('20250903',5,2) < '03' AND ( A.YEAR_GUBUN = 1 OR A.HOIGYE_YEAR = 9999 ) ) 
                          OR  -- 신년도에 3월 이상이면, 모든 건을 대상으로 함       
                              ( '0' = 1 AND SUBSTR('20250903',5,2) >='03' ) 
                          OR  -- 구년도에 3월 이전이면, 년도구분이 과년도(5), 구년도(9)인 것만 대상으로 함          
                              ( '0' = 2 AND SUBSTR('20250903',5,2) < '03' AND ( A.YEAR_GUBUN IN (5,9) ) ) 
                          OR  -- 구년도에 3월 이상이면, 모든 건을 제외 함           
                              ( '0' = 2 AND SUBSTR('20250903',5,2) >='03' AND 1 = 2 )            
                      )  
                  
              UNION ALL       

            -- 지방세-상하수도/물이용 OCR 금액 (전당월 타지 않도록)
            SELECT 
                  A.BANK_GUBUN       
                  ,CASE WHEN GEORAE_GUBUN IN (1,2,4) AND NVL(GEORAE_CHANNEL,0) IN (0,1) THEN NVL(BONSE_CNT     ,0) ELSE 0 END A01  /* 지방세-계-건수 */          
                  ,CASE WHEN GEORAE_GUBUN IN (1,2,4) AND NVL(GEORAE_CHANNEL,0) IN (0,1) THEN NVL(BONSE_AMT     ,0) ELSE 0 END A02  /* 지방세-계-금액 */          
                  ,0 A03  /* 세  외-계-건수 */          
                  ,0 A04  /* 세  외-계-금액 */          
                  ,0 A05  /* 교육세-계-건수 */          
                  ,0 A06  /* 교육세-계-금액 */          
                  ,0 A07  /* 농특세-계-건수 */          
                  ,0 A08  /* 농특세-계-금액 */          
                  ,0 A09  /* 지방세-지방세OCR-건수 */  
                  ,0 A10  /* 지방세-지방세OCR-금액 */  
                  ,0 A11  /* 세  외-지방세OCR-건수 */  
                  ,0 A12  /* 세  외-지방세OCR-금액 */  
                  ,0 A13  /* 교육세-지방세OCR-건수 */  
                  ,0 A14  /* 교육세-지방세OCR-금액 */  
                  ,0 A15  /* 농특세-지방세OCR-건수 */  
                  ,0 A16  /* 농특세-지방세OCR-금액 */  
                  ,CASE WHEN JIBGYE_CODE IN (209330,209331,209332,209333) AND GEORAE_GUBUN = 1 AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(BONSE_CNT,0) ELSE 0 END  A17   /* 지방세-상하수도물OCR-건수*/        
                  ,CASE WHEN JIBGYE_CODE IN (209330,209331,209332,209333) AND GEORAE_GUBUN = 1 AND NVL(GEORAE_CHANNEL,0) IN (0, 1) THEN NVL(BONSE_AMT,0) ELSE 0 END  A18   /* 지방세-상하수도물OCR-금액*/        
                  ,0   A19   /* 지방세-환경개선OCR-건수  */         
                  ,0   A20   /* 지방세-환경개선OCR-금액  */         
                  ,0   A21   /* 지방세-시세-건수         */         
                  ,0   A22   /* 지방세-시세-금액         */         
                  ,0   A23   /* 세  외-시세-건수         */         
                  ,0   A24   /* 세  외-시세-금액         */         
                  ,0   A25   /* 교육세-시세-건수         */         
                  ,0   A26   /* 교육세-시세-금액         */         
                  ,0   A27   /* 농특세-시세-건수         */         
                  ,0   A28   /* 농특세-시세-금액         */         
                  ,0   A29   /* 지방세-구세-건수         */         
                  ,0   A30   /* 지방세-구세-금액         */         
                  ,0   A31   /* 세  외-구세-건수         */         
                  ,0   A32   /* 세  외-구세-금액         */         
                  ,0   A33   /* 교육세-구세-건수         */         
                  ,0   A34   /* 교육세-구세-금액         */         
                  ,0   A35   /* 농특세-구세-건수         */         
                  ,0   A36   /* 농특세-구세-금액         */         
                  ,0   A37   /* 지방세-상수도-건수       */         
                  ,0   A38   /* 지방세-상수도-금액       */         
                  ,0  A39   /* 지방세-하수도-건수       */         
                  ,0  A40   /* 지방세-하수도-금액       */         
                  ,0             A41   /* 지방세-물이용부담금-건수 */         
                  ,0             A42   /* 지방세-물이용부담금-금액 */         
                  ,0             A43   /* 지방세-특별회계-건수     */         
                  ,0             A44   /* 지방세-특별회계-금액     */         
                  ,0  A45       /* 지방세-자금조정-건수     */            
                  ,0  A46       /* 지방세-자금조정-금액     */              
                  ,0  A47       /* 세  외-자금조정-건수     */              
                  ,0  A48       /* 세  외-자금조정-금액     */              
                  ,0  A49       /* 교육세-자금조정-건수     */              
                  ,0  A50       /* 교육세-자금조정-금액     */              
                  ,0  A51       /* 농특세-자금조정-건수     */              
                  ,0  A52       /* 농특세-자금조정-금액     */              
                  ,0  A53       /* 지방세-징수촉탁-건수     */              
                  ,0  A54       /* 지방세-징수촉탁-금액     */              
                  ,0  A55       /* 세  외-징수촉탁-건수     */              
                  ,0  A56       /* 세  외-징수촉탁-금액     */              
                  ,0  A57       /* 교육세-징수촉탁-건수     */              
                  ,0  A58       /* 교육세-징수촉탁-금액     */              
                  ,0  A59       /* 농특세-징수촉탁-건수     */              
                  ,0  A60       /* 농특세-징수촉탁-금액     */              
             FROM  
                  RPT_SUNAP_JIBGYE A        
             WHERE 
                  -- 전당월인지 판별 '20250903' 당월 첫 영업일자이며, 전월 말일과 마지막 영업일이 다른 경우 (말일이 휴일)
                   A.SUNAPIL = (SELECT NVL(MAX(BF1MM_LST_BIZ_DT), '20250903') AS SANG_DT
                        FROM MAP_JOB_DATE
                        WHERE DW_BAS_DDT = '20250903'
                        AND ST1_BIZ_DT = '20250903'
                        AND BF1MM_END_DT != BF1MM_LST_BIZ_DT)
                  -- 거래일은 화면 조회일 포함 6영업일자
                  AND A.KEORAEIL = (SELECT MAX(II.DW_BAS_DDT) FROM MAP_JOB_DATE II WHERE II.BF5_BIZ_DT = '20250903' AND II.DT_G = 0 )         
                  AND A.GEUMGO_CODE = '28'         
                  AND A.JIBGYE_CODE NOT IN (212300, 212400, 212500, 212600)     
                  AND A.BANK_GUBUN NOT IN (0,21,26,88,94,95,96,97,98,99,44,381,361,364,365,366,367,368,369,370,371,372,373,374,389,390,391,392,393)             
                  -- 상수도/하수도/물이용 부담금 OCR 분만 선택  
             AND JIBGYE_CODE IN (209330, 209331, 209332, 209333) AND GEORAE_GUBUN = 1 AND NVL(GEORAE_CHANNEL,0) IN (0, 1)
                  AND (   -- 총괄이면 모든 건을 대상으로 함     
                          ( '0' = 0 ) 
                          OR    -- 신년도에 3월 이전이면, 년도구분이 신년도인 것이나 9999년도 것만 대상으로 함        
                                ( '0' = 1 AND SUBSTR('20250903',5,2) < '03' AND ( A.YEAR_GUBUN = 1 OR A.HOIGYE_YEAR = 9999 ) ) 
                          OR  -- 신년도에 3월 이상이면, 모든 건을 대상으로 함       
                              ( '0' = 1 AND SUBSTR('20250903',5,2) >='03' ) 
                          OR  -- 구년도에 3월 이전이면, 년도구분이 과년도(5), 구년도(9)인 것만 대상으로 함          
                              ( '0' = 2 AND SUBSTR('20250903',5,2) < '03' AND ( A.YEAR_GUBUN IN (5,9) ) ) 
                          OR  -- 구년도에 3월 이상이면, 모든 건을 제외 함           
                              ( '0' = 2 AND SUBSTR('20250903',5,2) >='03' AND 1 = 2 )            
                      )  
                  
              UNION ALL       

              SELECT 
                    BANK_GUBUN               
                    ,0              A01    /* 지방세-계-건수           */     
                    ,0              A02    /* 지방세-계-금액           */     
                    ,0              A03    /* 세  외-계-건수           */     
                    ,0              A04    /* 세  외-계-금액           */     
                    ,0              A05    /* 교육세-계-건수           */     
                    ,0              A06    /* 교육세-계-금액           */     
                    ,0              A07    /* 농특세-계-건수           */     
                    ,0              A08    /* 농특세-계-금액           */     
                    ,0              A09    /* 지방세-지방세OCR-건수    */     
                    ,0              A10    /* 지방세-지방세OCR-금액    */     
                    ,0              A11    /* 세  외-지방세OCR-건수    */     
                    ,0              A12    /* 세  외-지방세OCR-금액    */     
                    ,0              A13    /* 교육세-지방세OCR-건수    */     
                    ,0              A14    /* 교육세-지방세OCR-금액    */     
                    ,0              A15    /* 농특세-지방세OCR-건수    */     
                    ,0              A16    /* 농특세-지방세OCR-금액    */     
                    ,0              A17    /* 지방세-상하수도물-건수   */     
                    ,0              A18    /* 지방세-상하수도물-금액   */     
                    ,0              A19    /* 지방세-환경개선OCR-건수  */     
                    ,0              A20    /* 지방세-환경개선OCR-금액  */     
                    ,0              A21    /* 지방세-시세-건수         */     
                    ,0              A22    /* 지방세-시세-금액         */     
                    ,0              A23    /* 세  외-시세-건수         */     
                    ,0              A24    /* 세  외-시세-금액         */     
                    ,0              A25    /* 교육세-시세-건수         */     
                    ,0              A26    /* 교육세-시세-금액         */     
                    ,0              A27    /* 농특세-시세-건수         */     
                    ,0              A28    /* 농특세-시세-금액         */     
                    ,0              A29    /* 지방세-구세-건수         */     
                    ,0              A30    /* 지방세-구세-금액         */     
                    ,0              A31    /* 세  외-구세-건수         */     
                    ,0              A32    /* 세  외-구세-금액         */     
                    ,0              A33    /* 교육세-구세-건수         */     
                    ,0              A34    /* 교육세-구세-금액         */     
                    ,0              A35    /* 농특세-구세-건수         */     
                    ,0              A36    /* 농특세-구세-금액         */     
                    ,0              A37    /* 지방세-하수도-건수       */     
                    ,0              A38    /* 세  외-하수도-금액       */     
                    ,0              A39    /* 지방세-물이용부담금-건수 */     
                    ,0              A40    /* 지방세-물이용부담금-금액 */     
                    ,0              A41    /* 지방세-특별회계-건수     */     
                    ,0              A42    /* 지방세-특별회계-금액     */     
                    ,0              A43    /* 지방세-특별회계-금액     */     
                    ,0              A44    /* 지방세-특별회계-건수     */     
                    ,(CASE WHEN A.IPJI_GUBUN=1 THEN NVL(A.JIBANGSE_CNT,0) ELSE 0 END) - (CASE WHEN A.IPJI_GUBUN=2 THEN NVL(A.JIBANGSE_CNT,0) ELSE 0 END) A45 /* 지방세-자금조정-건수 */ 
                    ,(CASE WHEN A.IPJI_GUBUN=1 THEN NVL(A.JIBANGSE_AMT,0) ELSE 0 END) - (CASE WHEN A.IPJI_GUBUN=2 THEN NVL(A.JIBANGSE_AMT,0) ELSE 0 END) A46 /* 지방세-자금조정-금액 */ 
                    ,(CASE WHEN A.IPJI_GUBUN=1 THEN NVL(A.SEWOI_CNT   ,0) ELSE 0 END) - (CASE WHEN A.IPJI_GUBUN=2 THEN NVL(A.SEWOI_CNT   ,0) ELSE 0 END) A47 /* 세  외-자금조정-건수 */ 
                    ,(CASE WHEN A.IPJI_GUBUN=1 THEN NVL(A.SEWOI_AMT   ,0) ELSE 0 END) - (CASE WHEN A.IPJI_GUBUN=2 THEN NVL(A.SEWOI_AMT   ,0) ELSE 0 END) A48 /* 세  외-자금조정-금액 */ 
                    ,0         A49 /* 교육세-자금조정-건수 */ 
                    ,(CASE WHEN A.IPJI_GUBUN=1 THEN NVL(A.GYOYUKSE_AMT,0) ELSE 0 END) - (CASE WHEN A.IPJI_GUBUN=2 THEN NVL(A.GYOYUKSE_AMT,0) ELSE 0 END)     A50 /* 교육세-자금조정-금액 */ 
                    ,0         A51 /* 농특세-자금조정-건수 */ 
                    ,(CASE WHEN A.IPJI_GUBUN=1 THEN NVL(A.NONGTEUKSE_AMT,0) ELSE 0 END) - (CASE WHEN A.IPJI_GUBUN=2 THEN NVL(A.NONGTEUKSE_AMT,0) ELSE 0 END) A52 /* 농특세-자금조정-금액 */ 
                    ,0              A53    /* 지방세-징수촉탁-건수     */     
                    ,0              A54    /* 지방세-징수촉탁-금액     */     
                    ,0              A55    /* 세  외-징수촉탁-건수     */     
                    ,0              A56    /* 세  외-징수촉탁-금액     */     
                    ,0              A57    /* 교육세-징수촉탁-건수     */     
                    ,0              A58    /* 교육세-징수촉탁-금액     */     
                    ,0              A59    /* 농특세-징수촉탁-건수     */     
                    ,0              A60    /* 농특세-징수촉탁-금액     */     
              FROM 
                    RPT_DANGSEIPJOJEONG A    
              WHERE 
                    A.SUNAPIL = '20250903'             
                    AND A.GEUMGO_CODE = '28'         
                    AND A.JIBGYE_CODE NOT IN (212300, 212400, 212500, 212600)     
                    AND A.BANK_GUBUN NOT IN (0,21,26,88,94,95,96,97,98,99,44,381,361,364,365,366,367,368,369,370,371,372,373,374,389,390,391,392,393)             
                    AND A.JOJEONG_GUBUN = 1       
                    
                    AND (   -- 총괄이면 모든 건을 대상으로 함     
                          ( '0' = 0 ) 
                          OR    -- 신년도에 3월 이전이면, 년도구분이 신년도인 것이나 9999년도 것만 대상으로 함        
                                ( '0' = 1 AND SUBSTR('20250903',5,2) < '03' AND ( A.YEAR_GUBUN = 1 OR A.HOIGYE_YEAR = 9999 ) ) 
                          OR  -- 신년도에 3월 이상이면, 모든 건을 대상으로 함       
                              ( '0' = 1 AND SUBSTR('20250903',5,2) >='03' ) 
                          OR  -- 구년도에 3월 이전이면, 년도구분이 과년도(5), 구년도(9)인 것만 대상으로 함          
                              ( '0' = 2 AND SUBSTR('20250903',5,2) < '03' AND ( A.YEAR_GUBUN IN (5,9) ) ) 
                          OR  -- 구년도에 3월 이상이면, 모든 건을 제외 함           
                              ( '0' = 2 AND SUBSTR('20250903',5,2) >='03' AND 1 = 2 )            
                        )
                                
              UNION ALL       
              SELECT 
                    A.BANK_GUBUN             
                    ,NVL(BONSE_CNT     ,0) A01    /* 지방세-계-건수           */               
                    ,NVL(BONSE_AMT     ,0) A02    /* 지방세-계-금액           */               
                    ,NVL(SEWOI_CNT     ,0) A03    /* 세  외-계-건수           */               
                    ,NVL(SEWOI_AMT     ,0) A04    /* 세  외-계-금액           */               
                    ,NVL(GYOYUKSE_CNT  ,0) A05    /* 교육세-계-건수           */               
                    ,NVL(GYOYUKSE_AMT  ,0) A06    /* 교육세-계-금액           */               
                    ,NVL(NONGTEUKSE_CNT,0) A07    /* 농특세-계-건수           */               
                    ,NVL(NONGTEUKSE_AMT,0) A08    /* 농특세-계-금액           */               
                    ,0     A09    /* 지방세-지방세OCR-건수    */               
                    ,0     A10    /* 지방세-지방세OCR-금액    */               
                    ,0     A11    /* 세  외-지방세OCR-건수    */               
                    ,0     A12    /* 세  외-지방세OCR-금액    */               
                    ,0     A13    /* 교육세-지방세OCR-건수    */               
                    ,0     A14    /* 교육세-지방세OCR-금액    */               
                    ,0     A15    /* 농특세-지방세OCR-건수    */               
                    ,0     A16    /* 농특세-지방세OCR-금액    */               
                    ,0     A17    /* 지방세-상하수도물-건수   */               
                    ,0     A18    /* 지방세-상하수도물-금액   */               
                    ,0     A19    /* 지방세-환경개선OCR-건수  */               
                    ,0     A20    /* 지방세-환경개선OCR-금액  */               
                    ,0     A21    /* 지방세-시세-건수         */               
                    ,0     A22    /* 지방세-시세-금액         */               
                    ,0     A23    /* 세  외-시세-건수         */               
                    ,0     A24    /* 세  외-시세-금액         */               
                    ,0     A25    /* 교육세-시세-건수         */               
                    ,0     A26    /* 교육세-시세-금액         */               
                    ,0     A27    /* 농특세-시세-건수         */               
                    ,0     A28    /* 농특세-시세-금액         */               
                    ,0     A29    /* 지방세-구세-건수         */               
                    ,0     A30    /* 지방세-구세-금액         */               
                    ,0     A31    /* 세  외-구세-건수         */               
                    ,0     A32    /* 세  외-구세-금액         */               
                    ,0     A33    /* 교육세-구세-건수         */               
                    ,0     A34    /* 교육세-구세-금액         */               
                    ,0     A35    /* 농특세-구세-건수         */               
                    ,0     A36    /* 농특세-구세-금액         */               
                    ,0     A37    /* 지방세-하수도-건수       */               
                    ,0     A38    /* 세  외-하수도-금액       */               
                    ,0     A39    /* 지방세-물이용부담금-건수 */               
                    ,0     A40    /* 지방세-물이용부담금-금액 */               
                    ,0     A41    /* 지방세-특별회계-건수     */               
                    ,0     A42    /* 지방세-특별회계-금액     */               
                    ,0     A43    /* 지방세-특별회계-금액     */               
                    ,0     A44    /* 지방세-특별회계-건수     */               
                    ,0     A45    /* 지방세-자금조정-건수     */               
                    ,0     A46    /* 지방세-자금조정-금액     */               
                    ,0     A47    /* 세  외-자금조정-건수     */               
                    ,0     A48    /* 세  외-자금조정-금액     */               
                    ,0     A49    /* 교육세-자금조정-건수     */               
                    ,0     A50    /* 교육세-자금조정-금액     */               
                    ,0     A51    /* 농특세-자금조정-건수     */               
                    ,0     A52    /* 농특세-자금조정-금액     */               
                    ,NVL(BONSE_CNT     ,0) A53    /* 지방세-징수촉탁-건수     */               
                    ,NVL(BONSE_AMT     ,0) A54    /* 지방세-징수촉탁-금액     */               
                    ,NVL(SEWOI_CNT     ,0) A55    /* 세  외-징수촉탁-건수     */               
                    ,NVL(SEWOI_AMT     ,0) A56    /* 세  외-징수촉탁-금액     */               
                    ,NVL(GYOYUKSE_CNT  ,0) A57    /* 교육세-징수촉탁-건수     */               
                    ,NVL(GYOYUKSE_AMT  ,0) A58    /* 교육세-징수촉탁-금액     */               
                    ,NVL(NONGTEUKSE_CNT,0) A59    /* 농특세-징수촉탁-건수     */               
                    ,NVL(NONGTEUKSE_AMT,0) A60    /* 농특세-징수촉탁-금액     */               
              FROM  
                    RPT_SUNAP_JIBGYE A        
              WHERE 
                    A.SUNAPIL = '20250903'             
                    AND A.GEUMGO_CODE = 99  -- 금고코드 99는 징수촉탁 전용        
                    AND A.BANK_GUBUN NOT IN (0,21,26,88,94,95,96,97,98,99,44,381,361,364,365,366,367,368,369,370,371,372,373,374,389,390,391,392,393)             
                    
                    AND (   -- 총괄이면 모든 건을 대상으로 함     
                          ( '0' = 0 ) OR            
                          -- 신년도에 3월 이전이면, 년도구분이 신년도인 것이나 9999년도 것만 대상으로 함        
                          ( '0' = 1 AND SUBSTR('20250903',5,2) < '03' AND ( A.YEAR_GUBUN = 1 OR A.HOIGYE_YEAR = 9999 ) ) OR  
                          -- 신년도에 3월 이상이면, 모든 건을 대상으로 함       
                          ( '0' = 1 AND SUBSTR('20250903',5,2) >='03' ) OR   
                          -- 구년도에 3월 이전이면, 년도구분이 과년도(5), 구년도(9)인 것만 대상으로 함          
                          ( '0' = 2 AND SUBSTR('20250903',5,2) < '03' AND ( A.YEAR_GUBUN IN (5,9) ) )      
                          -- 구년도에 3월 이상이면, 모든 건을 제외 함                    
                        )
                                
      ) A
      INNER JOIN SFI_CMM_C_DAT B                        
        ON B.CMM_C_NM = 'RPT은행코드'
        AND B.USE_YN = 'Y'
        AND TO_CHAR(A.BANK_GUBUN) = B.CMM_DTL_C
      INNER JOIN SFI_CMM_C_DAT C
        ON C.CMM_C_NM = 'RPT대표은행코드'
        AND B.USE_YN = 'Y'
        AND B.HRNK_CMM_DTL_C = C.CMM_DTL_C
GROUP BY 
      B.HRNK_CMM_DTL_C, C.CMM_DTL_C_NM
ORDER BY 
      TO_NUMBER(B.HRNK_CMM_DTL_C)