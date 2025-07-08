SELECT A.RNUM                         
     , (CASE 
        WHEN  SUBSTR(TRIM(A.USER_U_C) ,4,1) = '0' THEN 'BANK'  
        WHEN  SUBSTR(TRIM(A.USER_U_C) ,4,1) = '1' THEN 'SIGU'  
      END) AS USER_GUBUN
     , A.SL_GMGO_MODL_C               
     , A.USER_U_C                     
     , A.PADM_STD_ORG_C
     , (CASE 
        WHEN  SUBSTR(TRIM(A.USER_U_C) ,4,1) = '0' THEN F.CMM_DTL_C_NM
        WHEN  SUBSTR(TRIM(A.USER_U_C) ,4,1) = '1' THEN E.PADM_STD_ORGNM
       END) AS PADM_STD_ORG_NM
     , A.SL_GMGO_DEPT_C
     , A.BR_C
     ,(CASE 
        WHEN  SUBSTR(TRIM(A.USER_U_C) ,4,1) = '0' THEN A.BR_C
        WHEN  SUBSTR(TRIM(A.USER_U_C) ,4,1) = '1' THEN A.SL_GMGO_DEPT_C
      END) AS DEPT_C
      ,(CASE 
        WHEN  SUBSTR(TRIM(A.USER_U_C) ,4,1) = '0' THEN C.HNG_BR_NM
        WHEN  SUBSTR(TRIM(A.USER_U_C) ,4,1) = '1' THEN DECODE(B.DEL_YN,'Y','(폐쇄)','')||B.G_CC_DEPT_NM
      END) AS DEPT_NM
     , A.USER_ID
     ,(CASE
         WHEN 'R' = 'R' THEN A.USER_NM
         WHEN 'R' = 'D' THEN SFIOWN.FUNC_CUS_INFO_CONV (A.USER_NM,'NAME')     
     END) AS USER_NM
     , A.DISTG
     , A.USER_RIGHT_G                 
     , REPLACE(A.USER_TELNO, '-', '') AS USER_TELNO                    
     , A.USER_EMAIL      
     , A.LST_LOGIN_DT                 
     , A.PSN_INF_JEGONG_YN            
     , A.JKGP_NM
     , A.PSN_INF_BRWS_YN                      
     , A.USE_YN                       
     , A.UPD_DTTM                     
     , D.USER_NM AS MODR_ID
FROM  
(
    SELECT ROWNUM AS RNUM
         , A.*                                           
    FROM 
    (
        SELECT A.SL_GMGO_MODL_C       
             , A.USER_ID              
             , A.USER_NM              
             , A.DISTG                
             , A.USER_U_C             
             , A.USER_RIGHT_G         
             , A.PADM_STD_ORG_C       
             , A.SL_GMGO_DEPT_C       
             , A.BR_C
             , A.USER_TELNO           
             , A.USER_EMAIL           
             , A.LST_LOGIN_DT         
             , A.PSN_INF_JEGONG_YN    
             , A.JKGP_NM
             , A.PSN_INF_BRWS_YN              
             , A.USE_YN               
             , A.UPD_DTTM             
             , A.MODR_ID              
        FROM  SFI_USER_INF A                     
        WHERE A.SL_GMGO_MODL_C = 'RPT'               
          AND (A.USER_ID LIKE '%'|| '정세현' ||'%' OR A.USER_NM LIKE '%'|| '정세현' ||'%')
          AND ( NVL('','0') = '0' OR A.USER_U_C = '' )
          AND ( NVL('', '0') = '0' OR A.PADM_STD_ORG_C = '' )
          AND ( NVL('', '0') = '0' OR A.SL_GMGO_DEPT_C = '' )
          AND ( NVL('', '0') = '0' OR A.BR_C = '' )
          AND A.LST_LOGIN_DT BETWEEN '00000000' AND '99999999'
          AND A.UPD_DTTM BETWEEN '00000000' AND '99999999' || '999999'
          AND A.PADM_STD_ORG_C <> '0000000'  
        ORDER BY A.USER_U_C, A.PADM_STD_ORG_C, A.SL_GMGO_DEPT_C, A.BR_C, A.USER_ID
    ) A
    WHERE ROWNUM <= 100
) A
LEFT OUTER JOIN SFI_ORG_BY_DEPT_MNG B
  ON A.PADM_STD_ORG_C = B.PADM_STD_ORG_C
  AND A.SL_GMGO_DEPT_C = B.G_CC_DEPT_C
LEFT OUTER JOIN CST_JUM C
  ON C.GRPCO_C = 'S001'
  AND A.BR_C = C.BRNO
LEFT OUTER JOIN SFI_USER_INF D
  ON A.SL_GMGO_MODL_C = D.SL_GMGO_MODL_C
  AND A.MODR_ID        = D.USER_ID
LEFT OUTER JOIN SFI_ORG_DEPT_C_MNG E
  ON A.PADM_STD_ORG_C = E.PADM_STD_ORG_C
LEFT OUTER JOIN SFI_CMM_C_DAT F
  ON REPLACE(A.PADM_STD_ORG_C, '088') = LPAD(F.CMM_DTL_C,4,'0')
  AND F.CMM_C_NM = 'RPT시도금고코드'
  AND F.USE_YN = 'Y'
WHERE A.RNUM >= 0
ORDER BY A.RNUM


-------------------------------------

select * from SFI_USER_INF A                     
        WHERE A.SL_GMGO_MODL_C = 'RPT'
        AND A.USER_NM = '정세현'
        