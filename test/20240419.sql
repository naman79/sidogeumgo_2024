-- 02818501250003524

-- 299014928026

select * from rpt_unyong_gyejwa
where unyong_gyejwa = '299014928026'



SELECT B.GOGAEK_NO
        , B.YUDONG_ACNO
        , B.UNYONG_GYEJWA_NM
        , NVL((A.BEF_JAN), 0) AS BEF_JAN
        , NVL((A.IPGEUM), 0) AS IPGEUM
        , NVL((A.JIGEUB), 0) AS JIGEUB
        , NVL((A.HYUN_JAN), 0) AS HYUN_JAN
        , A.MKDT
        , A.DUDT
        , B.DIV_GROUP1
        , B.DIV_GROUP2
 FROM (SELECT YUDONG_ACNO
                  , UNYONG_GYEJWA_NM
                  , SUM(BFJAN) AS BEF_JAN
                  , SUM(IPAMT) AS IPGEUM
                  , SUM(JIAMT) AS JIGEUB
                  , SUM(JANAEK) AS HYUN_JAN
                  , MKDT
                  , DUDT
           FROM (SELECT A.UNYONG_GYEJWA
                            , A.BFJAN
                            , A.JIAMT
                            , A.IPAMT
                            , A.JANAEK
                            , A.MKDT
                            , A.DUDT
                            , B.REF_CTNT1 AS UNYONG_GYEJWA_NM
                            , B.REF_D_NM YUDONG_ACNO
                     FROM RPT_UNYONG_JAN_GITA A
                            , RPT_CODE_INFO B
                    WHERE A.UNYONG_GYEJWA = B.REF_D_NM
                       AND A.GEUMGO_CODE = B.REF_M_C
                       AND B.REF_L_C=540 
                       AND B.REF_M_C= 28 
                       AND B.REF_S_C=1
                       AND A.KIJUNIL = '20240418'
                       AND A.GEUMGO_CODE = 28
                    )
           GROUP BY YUDONG_ACNO, UNYONG_GYEJWA_NM, MKDT, DUDT
          ) A
       , (SELECT REF_CTNT1 AS UNYONG_GYEJWA_NM
                 , REF_D_NM AS YUDONG_ACNO
                 , REF_S_NM AS GOGAEK_NO
                 , REF_CTNT2 AS DIV_GROUP1
                 , REF_CTNT3 AS DIV_GROUP2
                 , REF_M_C
           FROM RPT_CODE_INFO
          WHERE REF_L_C=540 
             AND REF_M_C= 28 
             AND REF_S_C=1
         ) B
 WHERE A.YUDONG_ACNO = B.YUDONG_ACNO
  
    AND B.YUDONG_ACNO = '299014928026' 
    
    AND SUBSTR(B.DIV_GROUP1,0,1) = '2'
 ORDER BY TO_NUMBER(B.DIV_GROUP1),TO_NUMBER(B.DIV_GROUP2)