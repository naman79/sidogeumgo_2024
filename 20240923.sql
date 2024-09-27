select * from rpt_dept_info 
where 1=1
and laf_nm like '%중구%'
and dept_nm like '%재무과%'

----------------------------------------------------

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
          AND (A.USER_ID LIKE '%'|| '정지훈' ||'%' OR A.USER_NM LIKE '%'|| '정지훈' ||'%')
          AND ( NVL('','0') = '0' OR A.USER_U_C = '' )
          AND ( NVL('', '0') = '0' OR A.PADM_STD_ORG_C = '' )
          AND ( NVL('', '0') = '0' OR A.SL_GMGO_DEPT_C = '' )
          AND ( NVL('', '0') = '0' OR A.BR_C = '' )
          AND A.LST_LOGIN_DT BETWEEN '00000000' AND '99999999'
          AND A.UPD_DTTM BETWEEN '00000000' AND '99999999' || '999999'
          AND A.PADM_STD_ORG_C <> '0000000'  
        ORDER BY A.USER_U_C, A.PADM_STD_ORG_C, A.SL_GMGO_DEPT_C, A.BR_C, A.USER_ID


-------------------------------------------------------------

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
          AND (A.USER_ID LIKE '%'|| '정지훈' ||'%' OR A.USER_NM LIKE '%'|| '정지훈' ||'%')
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


-------------------------------------------------------------

SELECT A.RNUM                           /* 순번             */
     , A.PADM_STD_ORG_C                 /* 행정표준기관CODE */
     , A.ALL_ORGNM                      /* 전체기관명       */
     , DECODE(A.TLRK_ORGNM, '서울특별시', '본청', A.TLRK_ORGNM)
                    AS TLRK_ORGNM       /* 최하위기관명     */
     , A.ODR_G                          /* 차수구분         */
     , A.ORD_G                          /* 서열구분         */
     , A.SOSOK_ORG_ODR_G                /* 소속기관차수구분 */
     , A.CHA_HRNK_ORG_C                 /* 차상위기관CODE   */
     , A.THNK_ORG_C                     /* 최상위기관CODE   */
     , A.REP_ORG_C                      /* 대표기관CODE     */
     , A.LG_B_U_C                       /* 대분류유형CODE   */
     , A.MD_B_U_C                       /* 중분류유형CODE   */
     , A.SM_B_U_C                       /* 소분류유형CODE   */
     , A.TELNO                          /* 전화번호         */
     , A.FAXNO                          /* 팩스번호         */
     , A.MK_DT                          /* 생성일자         */
     , A.MG_DT                          /* 폐지일자         */
     , A.CDT                            /* 변경일자         */
     , A.MNTNAB_YN                      /* 존폐여부         */
     , A.MV_ORG_C                       /* 이전기관CODE     */
     , A.ORG_G                          /* 기관구분         */
     , A.OCR_C                          /* OCRCODE          */
     , A.CHNGS_C                        /* 청소CODE         */
     , A.BIZNO                          /* 사업자번호       */
     , A.UPD_DTTM                       /* 수정일시         */
     , B.USER_NM  AS MODR_ID            /* 수정자ID         */
  FROM  (SELECT RANK() OVER(ORDER BY PADM_STD_ORG_C) AS RNUM
             , PADM_STD_ORG_C           /* 행정표준기관CODE */
             , ALL_ORGNM                /* 전체기관명       */
             , TLRK_ORGNM               /* 최하위기관명     */
             , ODR_G                    /* 차수구분         */
             , ORD_G                    /* 서열구분         */
             , SOSOK_ORG_ODR_G          /* 소속기관차수구분 */
             , CHA_HRNK_ORG_C           /* 차상위기관CODE   */
             , THNK_ORG_C               /* 최상위기관CODE   */
             , REP_ORG_C                /* 대표기관CODE     */
             , LG_B_U_C                 /* 대분류유형CODE   */
             , MD_B_U_C                 /* 중분류유형CODE   */
             , SM_B_U_C                 /* 소분류유형CODE   */
             , TELNO                    /* 전화번호         */
             , FAXNO                    /* 팩스번호         */
             , MK_DT                    /* 생성일자         */
             , MG_DT                    /* 폐지일자         */
             , CDT                      /* 변경일자         */
             , MNTNAB_YN                /* 존폐여부         */
             , MV_ORG_C                 /* 이전기관CODE     */
             , ORG_G                    /* 기관구분         */
             , OCR_C                    /* OCRCODE          */
             , CHNGS_C                  /* 청소CODE         */
             , BIZNO                    /* 사업자번호       */
             , DR_DTTM                  /* 등록일시         */
             , DROKJA_ID                /* 등록자ID         */
             , UPD_DTTM                 /* 수정일시         */
             , MODR_ID                  /* 수정자ID         */
          FROM  SFI_PADM_ORG_INF         /* 행정기관정보     */
         WHERE REP_ORG_C      LIKE '%'||''||'%'  /* 대표기관CODE     */
           AND ALL_ORGNM      LIKE '%'||''||'%'  /* 전체기관명       */
           AND ORG_G          LIKE '%'||''||'%'  /* 기관구분         */
           AND MNTNAB_YN      LIKE '%'||''||'%'  /* 존폐여부         */
           AND PADM_STD_ORG_C LIKE '%'||''||'%'  /* 행정표준기관CODE */
       ) A
     , SFI_USER_INF B
 WHERE A.RNUM >= 0 AND A.RNUM <= 100
   AND B.USER_ID(+) = A.MODR_ID
   AND B.SL_GMGO_MODL_C(+) = 'RPT'
   AND B.USE_YN(+) = 'Y'
 ORDER BY A.RNUM



select 
            *                /* 수정자ID         */
          FROM  SFI_PADM_ORG_INF         /* 행정기관정보     */
         WHERE REP_ORG_C      LIKE '%'||''||'%'  /* 대표기관CODE     */
           AND ALL_ORGNM      LIKE '%'||''||'%'  /* 전체기관명       */
           AND ORG_G          LIKE '%'||''||'%'  /* 기관구분         */
           AND MNTNAB_YN      LIKE '%'||''||'%'  /* 존폐여부         */
           AND PADM_STD_ORG_C LIKE '%'||''||'%'  /* 행정표준기관CODE */



select count(*) as cnt
          FROM  SFI_PADM_ORG_INF   
where UPD_DTTM like '20240923%'                     

-- https://rpt.shinhan.com/SSOLogin.do?user_id=3540000201900000026&user_name=김윤선&org_id=3540000&dept_id=3540107&key_id=ea0183f905eecb51019e2d75f46d28efb57ef1a9f37e4ec02ddf0acc1b8b4abd


-- https://rpt.shinhan.com/SSOLogin.do?user_id=3540000201900000026&user_name=김윤선&org_id=3490000&dept_id=3490238&key_id=ea0183f905eecb51019e2d75f46d28efb57ef1a9f37e4ec02ddf0acc1b8b4abd


select count(*) as cnt from SFI_ORG_BY_DEPT_MNG
where PADM_STD_ORG_C = 3490000
and G_CC_DEPT_C = 3490238


select * from sfi_user_inf where 1=1
and user_id = 'hanna1721'

211.253.98.34

select * from sfi_user_inf where 1=1
and DROKJA_ID = '34900002023020000007'

select * from sfi_user_inf where 1=1
and user_id = 'hanna1721'

SELECT *
                    FROM SFI_USER_INF
                   WHERE  DROKJA_ID = '34900002023020000007'

SELECT COUNT(1) AS TOT_CNT
       , MAX(USR2.USER_ID) AS LST_USER_ID
       , MAX(USR3.USR_INF_VL) AS USR_INF_VL
    FROM SFIOWN.SFI_USER_INF USR1
       , (SELECT USER_ID
            FROM (SELECT USER_ID
                    FROM SFIOWN.SFI_USER_INF
                   WHERE SL_GMGO_MODL_C = 'RPT'
                     AND DROKJA_ID = '34900002023020000007'
                     AND USE_YN = 'Y'
                ORDER BY LST_LOGIN_DT DESC
                       , UPD_DTTM DESC)
          WHERE ROWNUM = 1) USR2
       , (SELECT USR_INF_VL
            FROM ICOOWN.NIO_KTC_USER_INFO_TAB
           WHERE USR_ID = ?
             AND ROWNUM = 1) USR3
   WHERE USR1.SL_GMGO_MODL_C = 'RPT'
     AND USR1.DROKJA_ID = '34900002023020000007'
     AND USR1.USE_YN = 'Y'


select * from SFI_ORG_BY_DEPT_MNG where 1=1
and PADM_STD_ORG_C = 3490000

select * from rpt_dept_info where 1=1
and laf_cd = 3490000
and GCC_DEPT_CD not in (
  select G_CC_DEPT_C from SFI_ORG_BY_DEPT_MNG where 1=1
and PADM_STD_ORG_C = 3490000
)

  select G_CC_DEPT_C from SFI_ORG_BY_DEPT_MNG where 1=1
and PADM_STD_ORG_C = 3490000
and G_CC_DEPT_C not in (
  select G_CC_DEPT_C from SFI_ORG_BY_DEPT_MNG where 1=1
and PADM_STD_ORG_C = 3490000
)


select * from rpt_dept_info where 1=1
and laf_cd = 6280000
and GCC_DEPT_CD not in (
  select G_CC_DEPT_C from SFI_ORG_BY_DEPT_MNG where 1=1
and PADM_STD_ORG_C = 6280000
)