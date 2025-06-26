SELECT A.RNUM
     , A.SL_GMGO_MODL_C         /* 서울시금고모듈CODE */
     , A.SL_GMGO_MODL_C AS SL_GMGO_MODL_NM
                                /* 서울시금고모듈명   */
     , A.SCR_ID                 /* 화면ID             */
     , A.SCR_NM                 /* 화면명             */
     , A.SVR_FILE_PATH          /* 서버파일경로       */
  , A.PSN_INF_BOYU_YN        /* 개인정보보유여부    */
     , A.USE_YN                 /* 사용여부           */
     , A.UPD_DTTM               /* 수정일시           */
     , B.USER_NM  AS MODR_ID    /* 수정자ID           */
  FROM  (SELECT RANK() OVER(ORDER BY SCR_ID) AS RNUM
             , SL_GMGO_MODL_C     /* 서울시금고모듈CODE */
             , SCR_ID             /* 화면ID             */
             , SCR_NM             /* 화면명             */
             , SVR_FILE_PATH      /* 서버파일경로       */
             , PSN_INF_BOYU_YN    /* 개인정보보유여부    */
             , USE_YN             /* 사용여부           */
             , UPD_DTTM           /* 수정일시           */
             , MODR_ID            /* 수정자ID           */
          FROM  SFI_SCR_INF        /* 화면정보           */
         WHERE SL_GMGO_MODL_C = 'RPT' /* 서울시금고모듈CODE */ 
           AND (SCR_ID LIKE '%'|| '' ||'%' OR SCR_ID IS NULL
            OR  SCR_NM LIKE '%'|| '' ||'%' OR SCR_NM IS NULL)
--         AND USE_YN = 'Y'   /* 전체 다 보여주도록 수정함 2018-08-22 */
       ) A
     , SFI_USER_INF B
 WHERE A.RNUM >= '101' AND A.RNUM <= '600'
   AND A.SL_GMGO_MODL_C = B.SL_GMGO_MODL_C(+)
   AND A.MODR_ID = B.USER_ID(+)
   AND B.USE_YN(+) = 'Y'
 ORDER BY A.RNUM