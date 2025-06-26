



-- 금액 대사
-- 잔액 데이터가 있는 가장 최근 날짜 조회
SELECT
    MAX(TRXDT) AS TRXDT
FROM ACL_SIGUMGO_SLV
WHERE 1=1
AND TRXDT <= '20250530'
AND FIL_100_CTNT5 = '02800021100000099'

-- 해당일자 잔액 조회
WITH MAX_SLV AS (
    SELECT
        SIGUMGO_ORG_C,
        ICH_SIGUMGO_GUN_GU_C,
        SIGUMGO_AC_B,
        SIGUMGO_AC_SER,
        SIGUMGO_HOIKYE_YR,
        MNG_NO,
        TRXDT,
        FIL_100_CTNT5,
        MAX(TRXNO) TRXNO
    FROM ACL_SIGUMGO_SLV
    WHERE 1=1
    AND TRXDT BETWEEN '20240101' AND '20250530'
    AND FIL_100_CTNT5 = '02800022100000099'
    GROUP BY SIGUMGO_ORG_C,
        ICH_SIGUMGO_GUN_GU_C,
        SIGUMGO_AC_B,
        SIGUMGO_AC_SER,
        SIGUMGO_HOIKYE_YR,
        MNG_NO,
        TRXDT,
        FIL_100_CTNT5
) SELECT 
 A.FIL_100_CTNT5 AS ACC_NO,
 A.TRXDT,
 A.LINKAC_JAN
 FROM ACL_SIGUMGO_SLV A,
 MAX_SLV B
 WHERE 1=1
 AND A.SIGUMGO_ORG_C = B.SIGUMGO_ORG_C
 AND A.ICH_SIGUMGO_GUN_GU_C = B.ICH_SIGUMGO_GUN_GU_C
 AND A.SIGUMGO_AC_B = B.SIGUMGO_AC_B
 AND A.SIGUMGO_AC_SER = B.SIGUMGO_AC_SER
 AND A.SIGUMGO_HOIKYE_YR = B.SIGUMGO_HOIKYE_YR
 AND A.MNG_NO = B.MNG_NO
 AND A.TRXDT = B.TRXDT
 AND A.FIL_100_CTNT5 = B.FIL_100_CTNT5
 AND A.TRXNO = B.TRXNO
ORDER BY TRXDT
-- 금액 조회

SELECT 
             GONGGEUM_GYEJWA AS GONGGEUM_GYEJWA,
            
             TO_CHAR(SUM(NVL(세입_세입,0))) AS NUGYE_SUIBAEG ,              
             TO_CHAR(SUM(NVL(세입_과오납,0))) AS NUGYE_SEIB_GWAONAB,                  
             TO_CHAR(SUM(NVL(세입_세입정정,0)))   AS NUGYE_SEIB_JEONGJEONG,                
             TO_CHAR(SUM(NVL(세입_과오납정정,0)))   AS NUGYE_SEIB_GWOEDIT,                        
             TO_CHAR(SUM(NVL(세입_계,0))) AS NUGYE_SEIB_CHAGAM,
             
             TO_CHAR(SUM(NVL(세출_배정_지출,0)))  AS NUGYE_SECHUL_BAEJEONGAEG,               
             TO_CHAR(SUM(NVL(세출_배정_반납,0)))  AS NUGYE_SECHUL_HWANSU,                 
             TO_CHAR(SUM(NVL(세출_지출_계,0)))   AS NUGYE_SECHUL_JIBULAEG,                     
             TO_CHAR(SUM(NVL(세출_지출_계,0)))  AS NUGYE_SECHUL_JICHUL, 
             TO_CHAR(SUM(NVL(세출_반납_계,0))) AS NUGYE_SECHUL_BANNAB,
             TO_CHAR(SUM(NVL(세출_계,0))) AS NUGYE_SECHUL_HAP,

             TO_CHAR(SUM(NVL(세출_전부금,0)))  AS NUGYE_JEONBUGEUM,                          
             TO_CHAR(SUM(NVL(전용_전출,0)))  AS NUGYE_JEONCHUL,                       
             TO_CHAR(SUM(NVL(전용_전입,0))) AS NUGYE_JEONIB,                            
             TO_CHAR(SUM(NVL(전용_일시차입금,0)))  AS NUGYE_GAIWOL_IIB,                       
             TO_CHAR(SUM(NVL(전용_이월지급,0)))  AS NUGYE_GAIWOL_JIGEUB,                    
             
             TO_CHAR(SUM(NVL(예금_정기예금신규,0)))  AS NUGYE_SINGYU,                           
             TO_CHAR(SUM(NVL(예금_정기예금해지,0))) AS NUGYE_HAEJI,                             
             TO_CHAR(SUM(NVL(예금_MMDA신규,0)))  AS NUGYE_MMDA_SINGYU,                           
             TO_CHAR(SUM(NVL(예금_MMDA해지,0))) AS NUGYE_MMDA_HAEJI,                             
             TO_CHAR(SUM(NVL(예금_정기예금계,0))) AS NUGYE_JEONGGI,
             TO_CHAR(SUM(NVL(예금_MMDA계,0))) AS NUGYE_MMDA,

             TO_CHAR(SUM(NVL(공금잔액,0))) AS BANK_JAN,
             TO_CHAR(SUM(NVL(실공금잔액,0))) AS GONGGEUM_JAN,

             TO_CHAR(SUM(NVL(본청_한도배정,0) + NVL(본청외_한도배정,0))) AS NUGYE_HANDO_BAEJEONG,                
             TO_CHAR(SUM(NVL(본청_한도사용,0) + NVL(본청외_한도사용,0))) AS NUGYE_HANDO_SAYONG,                  
             TO_CHAR(SUM(NVL(본청_한도잔여,0) + NVL(본청외_한도잔여,0))) AS NUGYE_JANYEOHANDO,             
             TO_CHAR( SUM(NVL(본청_한도배정,0))) AS NUGYE_BON_HANDO_BAEJEONG ,                           
             TO_CHAR(SUM(NVL(본청_한도사용,0))) AS NUGYE_BON_HANDO_SAYONG,                            
             TO_CHAR(SUM(NVL(본청_한도잔여,0))) AS NUGYE_BON_JANYEOHANDO,                 
             TO_CHAR( SUM(NVL(본청외_한도배정,0))) AS NUGYE_BONWOI_HANDO_BAEJEONG,                        
             TO_CHAR(SUM(NVL(본청외_한도사용,0))) AS NUGYE_BONWOI_HANDO_SAYONG,                          
             TO_CHAR(SUM(NVL(본청외_한도잔여,0))) AS NUGYE_BONWOI_JANYEOHANDO,         
               
             TO_CHAR(SUM(NVL(세입_세입_일계,0))) AS ILGYE_SUIBAEG ,              
             TO_CHAR(SUM(NVL(세입_과오납_일계,0))) AS ILGYE_SEIB_GWAONAB,                     
             TO_CHAR(SUM(NVL(세입_세입정정_일계,0)))   AS ILGYE_SEIB_JEONGJEONG,                 
             TO_CHAR(SUM(NVL(세입_과오납정정_일계,0)))   AS ILGYE_SEIB_GWOEDIT,           
             TO_CHAR(SUM(NVL(세입_계_일계,0))) AS ILGYE_SEIB_CHAGAM,

             TO_CHAR(SUM(NVL(세출_배정_지출_일계,0)))  AS ILGYE_SECHUL_BAEJEONGAEG,                
             TO_CHAR(SUM(NVL(세출_배정_반납_일계,0)))  AS ILGYE_SECHUL_HWANSU,                  
             TO_CHAR(SUM(NVL(세출_지출_계_일계,0)))   AS ILGYE_SECHUL_JIBULAEG,                      
             TO_CHAR(SUM(NVL(세출_지출_계_일계,0)))  AS ILGYE_SECHUL_JICHUL,              
             TO_CHAR(SUM(NVL(세출_반납_계_일계,0))) AS ILGYE_SECHUL_BANNAB,
             TO_CHAR(SUM(NVL(세출_계_일계,0))) AS ILGYE_SECHUL_HAP,
                                        

             TO_CHAR(SUM(NVL(세출_전부금_일계,0)))  AS ILGYE_JEONBUGEUM,                           
             TO_CHAR(SUM(NVL(전용_전출_일계,0)))  AS ILGYE_JEONCHUL,                        
             TO_CHAR(SUM(NVL(전용_전입_일계,0))) AS ILGYE_JEONIB,                           
             
             TO_CHAR(SUM(NVL(전용_일시차입금_일계,0)))  AS ILGYE_GAIWOL_IIB,                        
             TO_CHAR(SUM(NVL(전용_이월지급_일계,0)))  AS ILGYE_GAIWOL_JIGEUB,                     
             TO_CHAR(SUM(NVL(예금_정기예금신규_일계,0)))  AS ILGYE_SINGYU,                            
             TO_CHAR(SUM(NVL(예금_정기예금해지_일계,0))) AS ILGYE_HAEJI,
             TO_CHAR(SUM(NVL(예금_MMDA신규_일계,0)))  AS ILGYE_MMDA_SINGYU,                           
             TO_CHAR(SUM(NVL(예금_MMDA해지_일계,0))) AS ILGYE_MMDA_HAEJI,  

                                           
             TO_CHAR(SUM(NVL(본청_한도배정_일계,0) + NVL(본청외_한도배정_일계,0))) AS ILGYE_HANDO_BAEJEONG,                      
             TO_CHAR(SUM(NVL(본청_한도사용_일계,0) + NVL(본청외_한도사용_일계,0)))   AS ILGYE_HANDO_SAYONG,                        
             TO_CHAR(SUM(NVL(본청_한도잔여_일계,0) + NVL(본청외_한도잔여_일계,0)))  AS ILGYE_JANYEOHANDO,                  
             TO_CHAR( SUM(NVL(본청_한도배정_일계,0))) AS ILGYE_BON_HANDO_BAEJEONG ,                            
             TO_CHAR(SUM(NVL(본청_한도사용_일계,0))) AS ILGYE_BON_HANDO_SAYONG,                               
             TO_CHAR(SUM(NVL(본청_한도잔여_일계,0))) AS ILGYE_BON_JANYEOHANDO,                 
             TO_CHAR( SUM(NVL(본청외_한도배정_일계,0))) AS ILGYE_BONWOI_HANDO_BAEJEONG,                         
             TO_CHAR(SUM(NVL(본청외_한도사용_일계,0))) AS ILGYE_BONWOI_HANDO_SAYONG,                           
             TO_CHAR(SUM(NVL(본청외_한도잔여_일계,0))) AS ILGYE_BONWOI_JANYEOHANDO          
FROM
              (
WITH PARAM_DATA AS (
    SELECT
      '02800022100000099' AS ACNO
      , '2024' AS HOIKYE_YEAR
      , '20240109' AS KEORAEIL
    FROM DUAL
    )
  , 
GYEJWA AS (
    SELECT
      FIL_100_CTNT2 AS ACNO
      , SIGUMGO_AC_B AS ACB
      , SIGUMGO_AGE_AC_G AS AGE
      , SIGUMGO_AC_G AS ACG
      , SIGUMGO_AC_NM AS GYEJWA_NM
    FROM ACL_SIGUMGO_MAS,
    PARAM_DATA
    WHERE 1=1
    AND MNG_NO = 1
    AND SIGUMGO_AGE_AC_G IN (0, 1)
    AND FIL_100_CTNT2 = ACNO
    )
  , DANGSEIPJOJEONG AS (
      SELECT
        A.KEORAEIL AS TRXDT
        , A.KEORAEIL AS GISDT
        , ('028000011000000' || SUBSTR(NVL(B.HOIKYE_YEAR , '0000'), 3, 2)) AS ACNO
        , (SELECT GYEJWA_NM FROM GYEJWA WHERE ACNO = ('028000011000000' || SUBSTR(NVL(B.HOIKYE_YEAR , '0000'), 3, 2))) AS GYEJWA_NM
        , (SELECT ACB FROM GYEJWA WHERE ACNO = ('028000011000000' || SUBSTR(NVL(B.HOIKYE_YEAR , '0000'), 3, 2))) AS ACB
        , (SELECT AGE FROM GYEJWA WHERE ACNO = ('028000011000000' || SUBSTR(NVL(B.HOIKYE_YEAR , '0000'), 3, 2))) AS AGE
        , 'SJ' AS G
        , CASE WHEN A.IPJI_GUBUN = 1 THEN '249999' ELSE '649999' END AS GG
        , DECODE(A.IPJI_GUBUN, 2, -1, 1) * (A.GYOYUKSE_AMT + A.NONGTEUKSE_AMT + A.JIBANGSE_AMT + A.SEWOI_AMT) AS AMT
      FROM RPT_DANGSEIPJOJEONG A,
      PARAM_DATA B
      WHERE SUNAPIL BETWEEN  B.HOIKYE_YEAR || '0101' AND B.KEORAEIL
        AND JOJEONG_GUBUN = 2
  )
  , SLV AS (
    SELECT
        TRXDT
        , GISDT
        , FIL_100_CTNT5 AS ACNO
        , (SELECT GYEJWA_NM FROM GYEJWA WHERE ACNO = FIL_100_CTNT5) AS GYEJWA_NM
        , (SELECT ACB FROM GYEJWA WHERE ACNO = FIL_100_CTNT5) AS ACB
        , (SELECT AGE FROM GYEJWA WHERE ACNO = FIL_100_CTNT5) AS AGE
        , 'JG' AS G
        , LPAD(SIGUMGO_TRX_G, 2, '0') || LPAD(SIGUMGO_IP_TRX_G, 2, '0') || LPAD(SIGUMGO_JI_TRX_G, 2, '0') AS GG
        , SUM( DECODE(CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(IPJI_G, 2, -1, 1) * TRAMT ) AS AMT
      FROM ACL_SIGUMGO_SLV,
      PARAM_DATA
      WHERE SIGUMGO_HOIKYE_YR <> 9999 
      AND FIL_100_CTNT5 IN (SELECT ACNO FROM GYEJWA)
      AND TRXDT >=  HOIKYE_YEAR || '0101' 
      GROUP BY TRXDT, GISDT, FIL_100_CTNT5, LPAD(SIGUMGO_TRX_G, 2, '0') || LPAD(SIGUMGO_IP_TRX_G, 2, '0') || LPAD(SIGUMGO_JI_TRX_G, 2, '0')

      UNION ALL

    SELECT
        TRXDT
        , GISDT
        , FIL_100_CTNT5 AS ACNO
        , (SELECT GYEJWA_NM FROM GYEJWA WHERE ACNO = FIL_100_CTNT5) AS GYEJWA_NM
        , (SELECT ACB FROM GYEJWA WHERE ACNO = FIL_100_CTNT5) AS ACB
        , (SELECT AGE FROM GYEJWA WHERE ACNO = FIL_100_CTNT5) AS AGE
        , 'JG' AS G
        , LPAD(SIGUMGO_TRX_G, 2, '0') || LPAD(SIGUMGO_IP_TRX_G, 2, '0') || LPAD(SIGUMGO_JI_TRX_G, 2, '0') AS GG
        , SUM( DECODE(CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(IPJI_G, 2, -1, 1) * TRAMT ) AS AMT
      FROM ACL_SIGUMGO_SLV,
      PARAM_DATA
      WHERE SIGUMGO_HOIKYE_YR = 9999 
      AND FIL_100_CTNT5 IN (SELECT ACNO FROM GYEJWA)
      GROUP BY TRXDT, GISDT, FIL_100_CTNT5, LPAD(SIGUMGO_TRX_G, 2, '0') || LPAD(SIGUMGO_IP_TRX_G, 2, '0') || LPAD(SIGUMGO_JI_TRX_G, 2, '0')

      UNION ALL

      SELECT
        TRXDT
        , GISDT
        , SIGUMGO_ACNO AS ACNO
        , (SELECT GYEJWA_NM FROM GYEJWA WHERE ACNO = SIGUMGO_ACNO) AS GYEJWA_NM
        , (SELECT ACB FROM GYEJWA WHERE ACNO = SIGUMGO_ACNO) AS ACB
        , (SELECT AGE FROM GYEJWA WHERE ACNO = SIGUMGO_ACNO) AS AGE
        , 'HD' AS G
        , TO_CHAR(SIGUMGO_TRX_G) AS GG
        , SUM( DECODE(CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(IPJI_G, 2, -1, 1) * TRAMT ) AS AMT
      FROM ACL_SGGHANDO_SLV,
      PARAM_DATA
      WHERE SIGUMGO_ACNO IN (SELECT ACNO FROM GYEJWA)
      AND TRXDT >=  HOIKYE_YEAR || '0101'
      GROUP BY TRXDT, GISDT, SIGUMGO_ACNO, SIGUMGO_TRX_G

      UNION ALL

      SELECT 
        TRXDT
        ,GISDT
        ,ACNO
        ,GYEJWA_NM
        ,ACB
        ,AGE
        ,G
        ,GG
        ,AMT
      FROM DANGSEIPJOJEONG
      WHERE ACNO IN (
        SELECT ACNO FROM GYEJWA
      )
  )

SELECT 
  ACNO AS GONGGEUM_GYEJWA
  , GYEJWA_NM
  , 세입_세입_일계
  , 세입_세입정정_일계
  , 세입_과오납_일계
  , 세입_과오납정정_일계
  , 세입_계_일계
  , 세출_배정_지출_일계
  , 세출_배정_반납_일계
  , 세출_배정_계_일계
  , 세출_일상경비_지출_일계
  , 세출_일상경비_반납_일계
  , 세출_일상경비_계_일계
  , 세출_전부금_일계
  , 세출_지출_계_일계
  , 세출_반납_계_일계
  , 세출_계_일계
  , 세입_계_일계 - 세출_배정_계_일계 - 세출_일상경비_계_일계 - 세출_전부금_일계 AS 공금잔액_일계
  , 전용_전출_일계
  , 전용_전입_일계
  , 전용_전용계_일계
  , 전용_일시차입금_일계
  , 전용_이월지급_일계
  , 전용_계_일계
  , 세입_계_일계 - 세출_배정_계_일계 - 세출_일상경비_계_일계 - 세출_전부금_일계 + 전용_계_일계 AS 은행공금잔액_일계
  , 예금_정기예금신규_일계
  , 예금_정기예금해지_일계
  , 예금_정기예금계_일계
  , 예금_MMDA신규_일계
  , 예금_MMDA해지_일계
  , 예금_MMDA계_일계
  , 예금_계_일계
  , 세입_계_일계 - 세출_배정_계_일계 - 세출_일상경비_계_일계 - 세출_전부금_일계 - 전용_계_일계 - 예금_정기예금계_일계 - 예금_MMDA계_일계 AS 실공금잔액_일계
    ,본청_한도배정_일계 - 본청_한도환수_일계 AS 본청_한도배정_일계
  ,본청_한도지출_일계 - 본청_한도반납_일계 AS 본청_한도사용_일계
  ,본청_한도배정_일계 - 본청_한도환수_일계 - (본청_한도지출_일계 - 본청_한도반납_일계) AS 본청_한도잔여_일계
  ,본청외_한도배정_일계 - 본청외_한도환수_일계 AS 본청외_한도배정_일계
  ,본청외_한도지출_일계 - 본청외_한도반납_일계 AS 본청외_한도사용_일계
  ,본청외_한도배정_일계 - 본청외_한도환수_일계 - (본청외_한도지출_일계 - 본청외_한도반납_일계) AS 본청외_한도잔여_일계
  , 세입_세입
  , 세입_세입정정
  , 세입_과오납
  , 세입_과오납정정
  , 세입_계
  , 세출_배정_지출
  , 세출_배정_반납
  , 세출_배정_계
  , 세출_일상경비_지출
  , 세출_일상경비_반납
  , 세출_일상경비_계
  , 세출_전부금
  , 세출_지출_계
  , 세출_반납_계
  , 세출_계
  , 세입_계 - 세출_배정_계 - 세출_일상경비_계 - 세출_전부금 AS 공금잔액
  , 전용_전출
  , 전용_전입
  , 전용_전용계
  , 전용_일시차입금
  , 전용_이월지급
  , 전용_계
  , 세입_계 - 세출_배정_계 - 세출_일상경비_계 - 세출_전부금 + 전용_계 AS 은행공금잔액
  , 예금_정기예금신규
  , 예금_정기예금해지
  , 예금_정기예금계
  , 예금_MMDA신규
  , 예금_MMDA해지
  , 예금_MMDA계
  , 예금_계
  , 세입_계 - 세출_배정_계 - 세출_일상경비_계 - 세출_전부금 - 전용_계 - 예금_정기예금계 - 예금_MMDA계 AS 실공금잔액
  ,본청_한도배정 - 본청_한도환수 AS 본청_한도배정
  ,본청_한도지출 - 본청_한도반납 AS 본청_한도사용
  ,본청_한도배정 - 본청_한도환수 - (본청_한도지출 - 본청_한도반납) AS 본청_한도잔여
  ,본청외_한도배정 - 본청외_한도환수 AS 본청외_한도배정
  ,본청외_한도지출 - 본청외_한도반납 AS 본청외_한도사용
  ,본청외_한도배정 - 본청외_한도환수 - (본청외_한도지출 - 본청외_한도반납) AS 본청외_한도잔여
FROM (
  SELECT
    ACNO
    , GYEJWA_NM
    , 세입_일계 AS 세입_세입_일계
    , 세입정정_일계 AS 세입_세입정정_일계
    , 과오납_일계 * -1 AS 세입_과오납_일계
    , 과오납정정_일계 * -1 AS 세입_과오납정정_일계
    , (세입_일계 + 세입정정_일계 + 과오납_일계 + 과오납정정_일계) AS 세입_계_일계
    , 사업소지출_일계 * -1 AS 세출_배정_지출_일계
    , 사업소반납_일계 AS 세출_배정_반납_일계
    , (사업소지출_일계 + 사업소반납_일계) * -1 AS 세출_배정_계_일계
    , 일상경비지출_일계 * -1 AS 세출_일상경비_지출_일계
    , 일상경비반납_일계 AS 세출_일상경비_반납_일계
    , (일상경비지출_일계 + 일상경비반납_일계) * -1 AS 세출_일상경비_계_일계
    , (일상경비지출_일계)*-1 AS 세출_지출_계_일계
    , (일상경비반납_일계) AS 세출_반납_계_일계
    , (사업소지출_일계 + 사업소반납_일계 + 일상경비지출_일계 + 일상경비반납_일계)*-1 AS 세출_계_일계
    , 전부금_일계 AS 세출_전부금_일계
    , 전출_일계 * -1 AS 전용_전출_일계
    , 전입_일계 AS 전용_전입_일계
    , (전출_일계 + 전입_일계) * -1 AS 전용_전용계_일계
    , 일시차입금_일계 AS 전용_일시차입금_일계
    , 이월지급_일계 * -1 AS 전용_이월지급_일계
    , (전출_일계 + 전입_일계 + 일시차입금_일계 + 이월지급_일계) * -1  AS 전용_계_일계
    
    , 정기예금신규_일계 * -1 AS 예금_정기예금신규_일계
    , 정기예금해지_일계 AS 예금_정기예금해지_일계
    , (정기예금신규_일계 + 정기예금해지_일계) * -1 AS 예금_정기예금계_일계
    , MMDA신규_일계 * -1 AS 예금_MMDA신규_일계
    , MMDA해지_일계 AS 예금_MMDA해지_일계
    , (MMDA신규_일계 + MMDA해지_일계) * -1 AS 예금_MMDA계_일계
    , (정기예금신규_일계 + 정기예금해지_일계 + MMDA신규_일계 + MMDA해지_일계 + (전출_일계 + 전입_일계 + 일시차입금_일계 + 이월지급_일계)) * -1 AS 예금_계_일계
    ,(모_본청_배정_일계 + 자_본청_배정_일계) AS 본청_한도배정_일계
    ,(모_본청_환수_일계 + 자_본청_환수_일계) AS 본청_한도환수_일계
    ,(모_본청_지출_일계 + 자_본청_지출_일계) AS 본청_한도지출_일계
    ,(모_본청_반납_일계 + 자_본청_반납_일계) AS 본청_한도반납_일계
    ,(모_본청외_배정_일계) AS 본청외_한도배정_일계
    ,(모_본청외_환수_일계) AS 본청외_한도환수_일계
    ,(모_본청외_지출_일계) AS 본청외_한도지출_일계
    ,(모_본청외_반납_일계) AS 본청외_한도반납_일계

    , 세입 AS 세입_세입
    , 세입정정 AS 세입_세입정정    
    , 과오납 * -1 AS 세입_과오납
    , 과오납정정 * -1 AS 세입_과오납정정
    , (세입 + 세입정정 + 과오납 + 과오납정정) AS 세입_계
    , 사업소지출 * -1 AS 세출_배정_지출
    , 사업소반납 AS 세출_배정_반납
    , (사업소지출 + 사업소반납) * -1 AS 세출_배정_계
    , 일상경비지출 * -1 AS 세출_일상경비_지출
    , 일상경비반납 AS 세출_일상경비_반납
    , (일상경비지출 + 일상경비반납) * -1 AS 세출_일상경비_계
    , (일상경비지출)*-1 AS 세출_지출_계
    , (일상경비반납) AS 세출_반납_계
    , (사업소지출 + 사업소반납 + 일상경비지출 + 일상경비반납)*-1 AS 세출_계
    , 전부금 AS 세출_전부금
    , 전출 * -1 AS 전용_전출
    , 전입 AS 전용_전입
    , (전출 + 전입) * -1 AS 전용_전용계
    , 일시차입금 AS 전용_일시차입금
    , 이월지급 * -1 AS 전용_이월지급
    , (전출 + 전입 + 일시차입금 + 이월지급) * -1  AS 전용_계
    , 정기예금신규 * -1 AS 예금_정기예금신규
    , 정기예금해지 AS 예금_정기예금해지
    , (정기예금신규 + 정기예금해지) * -1 AS 예금_정기예금계
    , MMDA신규 * -1 AS 예금_MMDA신규
    , MMDA해지 AS 예금_MMDA해지
    , (MMDA신규 + MMDA해지) * -1 AS 예금_MMDA계
    , (정기예금신규 + 정기예금해지 + MMDA신규 + MMDA해지 + (전출 + 전입 + 일시차입금 + 이월지급)) * -1 AS 예금_계
    , ( 
     (세입_일계 + 세입정정 + 과오납 + 과오납정정)
     + (사업소지출 + 사업소반납)
     + (일상경비지출 + 일상경비반납) 
     + (정기예금신규 + 정기예금해지 + MMDA신규 + MMDA해지 + (전출 + 전입 + 일시차입금 + 이월지급))       
    ) 공금잔액_계
    ,(모_본청_배정 + 자_본청_배정) AS 본청_한도배정
    ,(모_본청_환수 + 자_본청_환수) AS 본청_한도환수
    ,(모_본청_지출 + 자_본청_지출) AS 본청_한도지출
    ,(모_본청_반납 + 자_본청_반납) AS 본청_한도반납
    ,(모_본청외_배정) AS 본청외_한도배정
    ,(모_본청외_환수) AS 본청외_한도환수
    ,(모_본청외_지출) AS 본청외_한도지출
    ,(모_본청외_반납) AS 본청외_한도반납  
  FROM (
    SELECT
     A.ACNO
      , A.GYEJWA_NM
      , SUM(
        CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('100000', '110100', '110200', '111300', '120400', '200000', '700000') THEN A.AMT 
        WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('111100', '111200', '121400', '120700', '150000', '160000', '190800', '190900', '300000') THEN A.AMT
        ELSE 0 END
        ) AS 세입_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('130000', '630000') THEN A.AMT ELSE 0 END) + SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('249999', '649999') THEN -A.AMT ELSE 0 END) AS 세입정정_일계      
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('240000', '640000') THEN A.AMT ELSE 0 END) AS 과오납_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('249999', '649999') THEN A.AMT ELSE 0 END) AS 과오납정정_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('670091', '670093','610001') THEN A.AMT ELSE 0 END) AS 사업소지출_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('179100', '179300','140600','140700') THEN A.AMT ELSE 0 END) AS 사업소반납_일계
      , SUM(
        CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('670090', '670092', '670000') THEN A.AMT
        WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('610002', '620006', '650000', '660000', '680000', '690000', '800000', '940000') THEN A.AMT
        ELSE 0 END
        ) AS 일상경비지출_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('179000', '179200', '170000') THEN A.AMT ELSE 0 END) AS 일상경비반납_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('') THEN A.AMT ELSE 0 END) AS 전부금_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('620005') THEN A.AMT ELSE 0 END) AS 전출_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('120500') THEN A.AMT ELSE 0 END) AS 전입_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('') THEN A.AMT ELSE 0 END) AS 일시차입금_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('600000', '620004') THEN A.AMT ELSE 0 END) AS 이월지급_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('620003') THEN A.AMT ELSE 0 END) AS 정기예금신규_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('120300') THEN A.AMT ELSE 0 END) AS 정기예금해지_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('620007') THEN A.AMT ELSE 0 END) AS MMDA신규_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('121500') THEN A.AMT ELSE 0 END) AS MMDA해지_일계 -- 분류 애매해서 임시로 MMDA에 포함 

      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND SUBSTR(A.ACNO, 7, 4) = '0110' AND A.GG IN ('670090','91') THEN -A.AMT ELSE 0 END) AS 모_본청_배정_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND SUBSTR(A.ACNO, 7, 4) = '0110' AND A.GG IN ('179000','45') THEN A.AMT ELSE 0 END) AS 모_본청_환수_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND SUBSTR(A.ACNO, 7, 4) = '0110' AND A.GG IN ('670090','670092') THEN -A.AMT ELSE 0 END) AS 모_본청_지출_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND SUBSTR(A.ACNO, 7, 4) = '0110' AND A.GG IN ('179000','179200') THEN A.AMT ELSE 0 END) AS 모_본청_반납_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('90') THEN -A.AMT ELSE 0 END) AS 모_본청외_배정_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('42') THEN A.AMT ELSE 0 END) AS 모_본청외_환수_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('670091', '670093') THEN -A.AMT ELSE 0 END) AS 모_본청외_지출_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('179100', '179300') THEN A.AMT ELSE 0 END) AS 모_본청외_반납_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND SUBSTR(A.ACNO, 7, 4) <> '0110'  AND A.GG IN ('40','41','91') THEN A.AMT ELSE 0 END) AS 자_본청_배정_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND SUBSTR(A.ACNO, 7, 4) <> '0110'  AND A.GG IN ('45','92','95') THEN -A.AMT ELSE 0 END) AS 자_본청_환수_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND SUBSTR(A.ACNO, 7, 4) <> '0110'  AND A.GG IN ('670091', '670092', '670093') THEN -A.AMT ELSE 0 END) AS 자_본청_지출_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND SUBSTR(A.ACNO, 7, 4) <> '0110'  AND A.GG IN ('179100', '179200', '179300') THEN A.AMT ELSE 0 END) AS 자_본청_반납_일계

      , SUM(
        CASE WHEN A.GG IN ('100000', '110100', '110200', '111300', '120400', '200000', '700000') THEN A.AMT  
        WHEN A.GG IN ('111100', '111200', '121400', '120700', '150000', '160000', '190800', '190900', '300000') THEN A.AMT
        ELSE 0 END
        ) AS 세입
      , SUM(CASE WHEN A.GG IN ('130000', '630000') THEN A.AMT ELSE 0 END) + SUM(CASE WHEN A.GG IN ('249999', '649999') THEN -A.AMT ELSE 0 END) AS 세입정정
      , SUM(CASE WHEN A.GG IN ('240000', '640000') THEN A.AMT ELSE 0 END) AS 과오납
      , SUM(CASE WHEN A.GG IN ('249999', '649999') THEN A.AMT ELSE 0 END) AS 과오납정정      
      , SUM(CASE WHEN A.GG IN ('670091', '670093', '610001') THEN A.AMT ELSE 0 END) AS 사업소지출
      , SUM(CASE WHEN A.GG IN ('179100', '179300', '140600', '140700') THEN A.AMT ELSE 0 END) AS 사업소반납
      , SUM(
        CASE WHEN A.GG IN ('670090', '670092', '670000', '660000') THEN A.AMT 
        WHEN A.GG IN ('610002', '620006', '650000', '660000', '680000', '690000', '800000', '940000') THEN A.AMT
        ELSE 0 END
        ) AS 일상경비지출
      , SUM(CASE WHEN A.GG IN ('179000', '179200', '170000') THEN A.AMT ELSE 0 END) AS 일상경비반납
      , SUM(CASE WHEN A.GG IN ('') THEN A.AMT ELSE 0 END) AS 전부금
      , SUM(CASE WHEN A.GG IN ('620005') THEN A.AMT ELSE 0 END) AS 전출
      , SUM(CASE WHEN A.GG IN ('120500') THEN A.AMT ELSE 0 END) AS 전입
      , SUM(CASE WHEN A.GG IN ('') THEN A.AMT ELSE 0 END) AS 일시차입금
      , SUM(CASE WHEN A.GG IN ('600000', '620004') THEN A.AMT ELSE 0 END) AS 이월지급
      , SUM(CASE WHEN A.GG IN ('620003') THEN A.AMT ELSE 0 END) AS 정기예금신규
      , SUM(CASE WHEN A.GG IN ('120300') THEN A.AMT ELSE 0 END) AS 정기예금해지
      , SUM(CASE WHEN A.GG IN ('620007') THEN A.AMT ELSE 0 END) AS MMDA신규
      , SUM(CASE WHEN A.GG IN ('121500') THEN A.AMT ELSE 0 END) AS MMDA해지 -- 분류 애매해서 임시로 MMDA에 포함
      , SUM(CASE WHEN SUBSTR(A.ACNO, 7, 4) = '0110'  AND A.GG IN ('670090','91') THEN -A.AMT ELSE 0 END) AS 모_본청_배정
      , SUM(CASE WHEN SUBSTR(A.ACNO, 7, 4) = '0110'  AND A.GG IN ('179000','45') THEN A.AMT ELSE 0 END) AS 모_본청_환수
      , SUM(CASE WHEN SUBSTR(A.ACNO, 7, 4) = '0110'  AND A.GG IN ('670090','670092') THEN -A.AMT ELSE 0 END) AS 모_본청_지출
      , SUM(CASE WHEN SUBSTR(A.ACNO, 7, 4) = '0110'  AND A.GG IN ('179000','179200') THEN A.AMT ELSE 0 END) AS 모_본청_반납
      , SUM(CASE WHEN A.GG IN ('90') THEN -A.AMT ELSE 0 END) AS 모_본청외_배정
      , SUM(CASE WHEN A.GG IN ('42') THEN A.AMT ELSE 0 END) AS 모_본청외_환수
      , SUM(CASE WHEN A.GG IN ('670091', '670093') THEN -A.AMT ELSE 0 END) AS 모_본청외_지출
      , SUM(CASE WHEN A.GG IN ('179100', '179300') THEN A.AMT ELSE 0 END) AS 모_본청외_반납
      , SUM(CASE WHEN SUBSTR(A.ACNO, 7, 4) <> '0110'  AND A.GG IN ('40','41','91') THEN A.AMT ELSE 0 END) AS 자_본청_배정
      , SUM(CASE WHEN SUBSTR(A.ACNO, 7, 4) <> '0110'  AND A.GG IN ('45','92','95') THEN -A.AMT ELSE 0 END) AS 자_본청_환수
      , SUM(CASE WHEN SUBSTR(A.ACNO, 7, 4) <> '0110'  AND A.GG IN ('670091', '670092', '670093') THEN -A.AMT ELSE 0 END) AS 자_본청_지출
      , SUM(CASE WHEN SUBSTR(A.ACNO, 7, 4) <> '0110'  AND A.GG IN ('179100', '179200', '179300') THEN A.AMT ELSE 0 END) AS 자_본청_반납       
    FROM SLV  A,
    PARAM_DATA  B
    WHERE A.GISDT <= B.KEORAEIL
    GROUP BY A.ACNO, A.GYEJWA_NM
  )
)
              ) AA
GROUP BY GONGGEUM_GYEJWA

-----------------------------------------------------------



-- 하수도 30,000 찾기

SELECT 
 *
FROM ACL_SIGUMGO_SLV
WHERE 1=1
AND FIL_100_CTNT5 = '02800022100000099'
and TRAMT = 30000
order by TRXDT
