SELECT 
             GONGGEUM_GYEJWA AS GONGGEUM_GYEJWA,
            
             TO_CHAR(SUM(NVL(세입_세입,0))) AS NUGYE_SUIBAEG ,              
             TO_CHAR(SUM(NVL(세입_과오납,0))) AS NUGYE_SEIB_GWAONAB,                  
             TO_CHAR(SUM(NVL(세입_세입정정,0)))   AS NUGYE_SEIB_JEONGJEONG,                
             TO_CHAR(SUM(NVL(세입_과오납정정,0)))   AS NUGYE_SEIB_GWOEDIT,                        
             TO_CHAR(SUM(NVL(세입_계,0))) AS NUGYE_SEIB_CHAGAM,
             
             TO_CHAR(SUM(NVL(세출_배정_지출 - 세출_배정_반납,0)))  AS NUGYE_SECHUL_BAEJEONGAEG,               
             TO_CHAR(SUM(NVL(세출_배정_반납,0)))  AS NUGYE_SECHUL_HWANSU,                 
             TO_CHAR(SUM(NVL(세출_일상경비_지출,0)))   AS NUGYE_SECHUL_JIBULAEG,                     
             TO_CHAR(SUM(NVL(세출_일상경비_지출,0)))  AS NUGYE_SECHUL_JICHUL, 
             TO_CHAR(SUM(NVL(세출_일상경비_반납,0))) AS NUGYE_SECHUL_BANNAB,
             TO_CHAR(SUM(NVL(세출_배정_계 + 세출_일상경비_계,0))) AS NUGYE_SECHUL_HAP,

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

             TO_CHAR(SUM(NVL(세출_배정_지출_일계 - 세출_배정_반납_일계,0)))  AS ILGYE_SECHUL_BAEJEONGAEG,                
             TO_CHAR(SUM(NVL(세출_배정_반납_일계,0)))  AS ILGYE_SECHUL_HWANSU,                  
             TO_CHAR(SUM(NVL(세출_일상경비_지출_일계,0)))   AS ILGYE_SECHUL_JIBULAEG,                      
             TO_CHAR(SUM(NVL(세출_일상경비_지출_일계,0)))  AS ILGYE_SECHUL_JICHUL,              
             TO_CHAR(SUM(NVL(세출_일상경비_반납_일계,0))) AS ILGYE_SECHUL_BANNAB,
             TO_CHAR(SUM(NVL(세출_배정_계_일계 + 세출_일상경비_계_일계,0))) AS ILGYE_SECHUL_HAP,
                                        

             TO_CHAR(SUM(NVL(세출_전부금_일계,0)))  AS ILGYE_JEONBUGEUM,                           
             TO_CHAR(SUM(NVL(전용_전출_일계,0)))  AS ILGYE_JEONCHUL,                        
             TO_CHAR(SUM(NVL(전용_전입_일계,0))) AS ILGYE_JEONIB,                           
             
             TO_CHAR(SUM(NVL(전용_일시차입금_일계,0)))  AS ILGYE_GAIWOL_IIB,                        
             TO_CHAR(SUM(NVL(전용_이월지급_일계,0)))  AS ILGYE_GAIWOL_JIGEUB,                     
             TO_CHAR(SUM(NVL(예금_정기예금신규_일계,0)))  AS ILGYE_SINGYU,                            
             TO_CHAR(SUM(NVL(예금_정기예금해지_일계,0))) AS ILGYE_HAEJI,
             TO_CHAR(SUM(NVL(예금_MMDA신규_일계,0)))  AS ILGYE_MMDA_SINGYU,                        
             TO_CHAR(SUM(NVL(예금_MMDA해지_일계,0))) AS ILGYE_MMDA_HAEJI,  

             TO_CHAR(SUM(NVL(예금_정기예금계_일계,0))) AS ILGYE_JEONGGI,  
             TO_CHAR(SUM(NVL(예금_MMDA계_일계,0))) AS ILGYE_MMDA,  

                                           
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
      '02824501100000025' AS ACNO
      , '28' AS GEUMGO_CD
      , '2025' AS HOIKYE_YEAR
      , '20251027' AS KEORAEIL
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
        , (
  SELECT 
    (CASE WHEN SUBSTR(NVL(B.UPMU_HMK_3_SLV, '00000000000000000'), 16, 2) = '99' THEN NVL(B.UPMU_HMK_3_SLV, '00000000000000000')
   ELSE SUBSTR(NVL(B.UPMU_HMK_3_SLV, '00000000000000000'), 1, 15) || SUBSTR(NVL(C.HOIKYE_YEAR , '0000'), 3, 2) 
   END)
   AS ACNO
  FROM SFI_CMM_C_DAT B
  WHERE B.CMM_C_NM = 'RPT세입조정계좌매핑'
  AND B.USE_YN = 'Y'
  AND B.HRNK_CMM_DTL_C = A.GEUMGO_CODE
  AND B.UPMU_HMK_1_SLV = A.JIBGYE_CODE
  AND B.UPMU_HMK_2_SLV = A.GUNGU_CODE
  AND ROWNUM = 1
 ) AS ACNO
        , 'SJ' AS G
        , CASE WHEN A.IPJI_GUBUN = 1 THEN '249999' ELSE '649999' END AS GG
        , DECODE(A.IPJI_GUBUN, 2, -1, 1) * (A.GYOYUKSE_AMT + A.NONGTEUKSE_AMT + A.JIBANGSE_AMT + A.SEWOI_AMT) AS AMT
      FROM RPT_DANGSEIPJOJEONG A,
      PARAM_DATA C
      WHERE A.SUNAPIL BETWEEN  C.HOIKYE_YEAR || '0101' AND C.KEORAEIL
 AND A.GEUMGO_CODE = C.GEUMGO_CD
        AND A.JOJEONG_GUBUN = 2
  )
  , SLV AS (
    -- YY계좌 공금거래
    SELECT
        A.TRXDT
        , A.GISDT
        , A.FIL_100_CTNT5 AS ACNO
        , (SELECT GYEJWA_NM FROM GYEJWA WHERE ACNO = A.FIL_100_CTNT5) AS GYEJWA_NM
        , (SELECT ACB FROM GYEJWA WHERE ACNO = A.FIL_100_CTNT5) AS ACB
        , (SELECT AGE FROM GYEJWA WHERE ACNO = A.FIL_100_CTNT5) AS AGE
        , 'JG' AS G
        , LPAD(A.SIGUMGO_TRX_G, 2, '0') || LPAD(A.SIGUMGO_IP_TRX_G, 2, '0') || LPAD(A.SIGUMGO_JI_TRX_G, 2, '0') AS GG
        , SUM( DECODE(A.CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(A.IPJI_G, 2, -1, 1) * A.TRAMT ) AS AMT
      FROM ACL_SIGUMGO_SLV A,
      PARAM_DATA B
      WHERE A.FIL_100_CTNT5 IN (SELECT ACNO FROM GYEJWA)
      AND A.GISDT >=  B.HOIKYE_YEAR || '0101'
      AND A.SIGUMGO_HOIKYE_YR <> 9999
      GROUP BY A.TRXDT, A.GISDT, A.FIL_100_CTNT5, LPAD(A.SIGUMGO_TRX_G, 2, '0') || LPAD(A.SIGUMGO_IP_TRX_G, 2, '0') || LPAD(A.SIGUMGO_JI_TRX_G, 2, '0')

      UNION ALL

      -- 99계좌 공금거래 / 기준일, 기산일 당년도분

    SELECT
        A.TRXDT
        , A.GISDT
        , A.FIL_100_CTNT5 AS ACNO
        , (SELECT GYEJWA_NM FROM GYEJWA WHERE ACNO = A.FIL_100_CTNT5) AS GYEJWA_NM
        , (SELECT ACB FROM GYEJWA WHERE ACNO = A.FIL_100_CTNT5) AS ACB
        , (SELECT AGE FROM GYEJWA WHERE ACNO = A.FIL_100_CTNT5) AS AGE
        , 'JG' AS G
        , LPAD(A.SIGUMGO_TRX_G, 2, '0') || LPAD(A.SIGUMGO_IP_TRX_G, 2, '0') || LPAD(A.SIGUMGO_JI_TRX_G, 2, '0') AS GG
        , SUM( DECODE(A.CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(A.IPJI_G, 2, -1, 1) * A.TRAMT ) AS AMT
      FROM ACL_SIGUMGO_SLV A,
      PARAM_DATA B
      WHERE A.FIL_100_CTNT5 IN (SELECT ACNO FROM GYEJWA)
      AND A.GJDT >=  B.HOIKYE_YEAR || '0101'
      AND A.GJDT <= (CASE WHEN B.KEORAEIL > B.HOIKYE_YEAR || '1231' THEN B.HOIKYE_YEAR || '1231' ELSE B.KEORAEIL END)
      AND A.GISDT >= B.HOIKYE_YEAR || '0101'
      AND A.SIGUMGO_HOIKYE_YR = 9999
      GROUP BY A.TRXDT, A.GISDT, A.FIL_100_CTNT5, LPAD(A.SIGUMGO_TRX_G, 2, '0') || LPAD(A.SIGUMGO_IP_TRX_G, 2, '0') || LPAD(A.SIGUMGO_JI_TRX_G, 2, '0')

      UNION ALL

      -- 99계좌 공금거래 / 기준일 전년도, 기산일 당년도분 - 일별로 세입처리 (110199)
      SELECT
        A.TRXDT
        , A.GISDT
        , A.FIL_100_CTNT5 AS ACNO
        , (SELECT GYEJWA_NM FROM GYEJWA WHERE ACNO = A.FIL_100_CTNT5) AS GYEJWA_NM
        , (SELECT ACB FROM GYEJWA WHERE ACNO = A.FIL_100_CTNT5) AS ACB
        , (SELECT AGE FROM GYEJWA WHERE ACNO = A.FIL_100_CTNT5) AS AGE
        , 'JG' AS G
        , '110199' AS GG
        , SUM( DECODE(A.CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(A.IPJI_G, 2, -1, 1) * A.TRAMT ) AS AMT
      FROM ACL_SIGUMGO_SLV A,
      PARAM_DATA B
      WHERE A.FIL_100_CTNT5 IN (SELECT ACNO FROM GYEJWA)
      AND A.GJDT < B.HOIKYE_YEAR || '0101'
      AND A.GISDT >= B.HOIKYE_YEAR || '0101'
      AND A.SIGUMGO_HOIKYE_YR = 9999
      GROUP BY A.TRXDT, A.GISDT, A.FIL_100_CTNT5

      UNION ALL

      -- 99계좌 공금거래 / 기준일 당년도, 기산일 익년도분 - 일별로 가이월지급처리 (629904)
      SELECT
        A.TRXDT
        , A.GISDT
        , A.FIL_100_CTNT5 AS ACNO
        , (SELECT GYEJWA_NM FROM GYEJWA WHERE ACNO = A.FIL_100_CTNT5) AS GYEJWA_NM
        , (SELECT ACB FROM GYEJWA WHERE ACNO = A.FIL_100_CTNT5) AS ACB
        , (SELECT AGE FROM GYEJWA WHERE ACNO = A.FIL_100_CTNT5) AS AGE
        , 'JG' AS G
        , '629904' AS GG
        , SUM( DECODE(A.CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(A.IPJI_G, 2, -1, 1) * A.TRAMT ) * -1 AS AMT
      FROM ACL_SIGUMGO_SLV A,
      PARAM_DATA B
      WHERE A.FIL_100_CTNT5 IN (SELECT ACNO FROM GYEJWA)
      AND A.GJDT >=  B.HOIKYE_YEAR || '0101'
      AND A.GJDT <= (CASE WHEN B.KEORAEIL > B.HOIKYE_YEAR || '1231' THEN B.HOIKYE_YEAR || '1231' ELSE B.KEORAEIL END)
      AND A.GISDT > B.HOIKYE_YEAR || '1231'
      AND A.SIGUMGO_HOIKYE_YR = 9999
      GROUP BY A.TRXDT, A.GISDT, A.FIL_100_CTNT5
      
      UNION ALL

      -- 한도거래
      SELECT
        A.TRXDT
        , A.GISDT
        , A.SIGUMGO_ACNO AS ACNO
        , (SELECT GYEJWA_NM FROM GYEJWA WHERE ACNO = A.SIGUMGO_ACNO) AS GYEJWA_NM
        , (SELECT ACB FROM GYEJWA WHERE ACNO = A.SIGUMGO_ACNO) AS ACB
        , (SELECT AGE FROM GYEJWA WHERE ACNO = A.SIGUMGO_ACNO) AS AGE
        , 'HD' AS G
        , TO_CHAR(A.SIGUMGO_TRX_G) AS GG
        , SUM( DECODE(A.CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(A.IPJI_G, 2, -1, 1) * A.TRAMT ) AS AMT
      FROM ACL_SGGHANDO_SLV A,
      PARAM_DATA B
      WHERE A.SIGUMGO_ACNO IN (SELECT ACNO FROM GYEJWA)
      AND A.TRXDT >=  B.HOIKYE_YEAR || '0101'
      GROUP BY A.TRXDT, A.GISDT, A.SIGUMGO_ACNO, A.SIGUMGO_TRX_G

      UNION ALL

      -- 과오납조정 거래
      SELECT
        A.TRXDT
        , A.GISDT
        , A.ACNO
        , B.GYEJWA_NM
        , B.ACB 
        , B.AGE
        , A.G
        , A.GG
        , A.AMT
      FROM DANGSEIPJOJEONG A, GYEJWA B
      WHERE A.ACNO = B.ACNO

      UNION ALL
      
      -- 운용잔액 / 전년자 말일금액을 익년 첫영업일자로 가져옴 (629903) - 지급거래형식으로, 마이너스 곱해줌
      SELECT
        TRXDT AS TRXDT
        , TRXDT AS GISDT
        , GONGGEUM_GYEJWA AS ACNO
        , (SELECT GYEJWA_NM FROM GYEJWA WHERE ACNO = GONGGEUM_GYEJWA) AS GYEJWA_NM
        , (SELECT ACB FROM GYEJWA WHERE ACNO = GONGGEUM_GYEJWA) AS ACB
        , (SELECT AGE FROM GYEJWA WHERE ACNO = GONGGEUM_GYEJWA) AS AGE
        , 'JG' AS G
        , '629903' AS GG
        , JANAEK * -1 AS AMT
      FROM (
        SELECT
          (SELECT BIZ_DT
          FROM MAP_JOB_DATE
          WHERE DW_BAS_DDT = B.HOIKYE_YEAR || '0101') AS TRXDT
          , CASE
            WHEN SUBSTR(A.GONGGEUM_GYEJWA, 16, 2) <> 99 THEN SUBSTR(A.GONGGEUM_GYEJWA, 1, 15) || SUBSTR(B.HOIKYE_YEAR, 3, 2)
            ELSE A.GONGGEUM_GYEJWA
          END AS GONGGEUM_GYEJWA
          , SUM(A.JANAEK) AS JANAEK
        FROM RPT_UNYONG_JAN A,
        RPT_UNYONG_GYEJWA C,
        PARAM_DATA B
        WHERE 1=1
          AND A.GEUMGO_CODE = B.GEUMGO_CD
          AND A.KIJUNIL = (SELECT
                  CASE
                    WHEN DT_G = 0 THEN BIZ_DT
                    ELSE BF1_BIZ_DT
                  END AS BIZ_DT
                  FROM MAP_JOB_DATE
                  WHERE DW_BAS_DDT = B.HOIKYE_YEAR - 1 || '1231')
          AND A.JANAEK > 0
          AND A.GEUMGO_CODE = C.GEUMGO_CODE
          AND A.GONGGEUM_GYEJWA = C.GONGGEUM_GYEJWA
          AND A.UNYONG_GYEJWA = C.UNYONG_GYEJWA
          AND NVL(C.HJI_DT, '99999999') > (SELECT
                  CASE
                    WHEN DT_G = 0 THEN BIZ_DT
                    ELSE BF1_BIZ_DT
                  END AS BIZ_DT
                  FROM MAP_JOB_DATE
                  WHERE DW_BAS_DDT = B.HOIKYE_YEAR - 1 || '1231')
        GROUP BY A.GONGGEUM_GYEJWA, B.HOIKYE_YEAR
      )
      WHERE GONGGEUM_GYEJWA IN (SELECT ACNO FROM GYEJWA)

      UNION ALL

      -- 운용잔액 / 당해 말일금액을 말일에 해지처리해줌 (120399)
      SELECT
        TRXDT AS TRXDT
        , TRXDT AS GISDT
        , GONGGEUM_GYEJWA AS ACNO
        , (SELECT GYEJWA_NM FROM GYEJWA WHERE ACNO = GONGGEUM_GYEJWA) AS GYEJWA_NM
        , (SELECT ACB FROM GYEJWA WHERE ACNO = GONGGEUM_GYEJWA) AS ACB
        , (SELECT AGE FROM GYEJWA WHERE ACNO = GONGGEUM_GYEJWA) AS AGE
        , 'JG' AS G
        , '120399' AS GG
        , JANAEK AS AMT
      FROM (
        SELECT
          (SELECT BIZ_DT
          FROM MAP_JOB_DATE
          WHERE DW_BAS_DDT = B.HOIKYE_YEAR + 1 || '0101') AS TRXDT
          , CASE
            WHEN SUBSTR(A.GONGGEUM_GYEJWA, 16, 2) <> 99 THEN SUBSTR(A.GONGGEUM_GYEJWA, 1, 15) || SUBSTR(B.HOIKYE_YEAR, 3, 2)
            ELSE A.GONGGEUM_GYEJWA
          END AS GONGGEUM_GYEJWA
          , SUM(A.JANAEK) AS JANAEK
        FROM RPT_UNYONG_JAN A,
        PARAM_DATA B
        WHERE 1=1
          AND A.KIJUNIL = (SELECT
                  CASE
                    WHEN DT_G = 0 THEN BIZ_DT
                    ELSE BF1_BIZ_DT
                  END AS BIZ_DT
                  FROM MAP_JOB_DATE
                  WHERE DW_BAS_DDT = B.HOIKYE_YEAR || '1231')
          AND JANAEK > 0
        GROUP BY A.GONGGEUM_GYEJWA, B.HOIKYE_YEAR
      )
      WHERE GONGGEUM_GYEJWA IN (SELECT ACNO FROM GYEJWA)

      UNION ALL

      -- 공금잔액 / 전년자 말일금액을 익년 첫영업일자로 가져옴 (99회계 대상, 110199)
      SELECT
        TRXDT AS TRXDT
        , TRXDT AS GISDT
        , GONGGEUM_GYEJWA AS ACNO
              , (SELECT GYEJWA_NM FROM GYEJWA WHERE ACNO = GONGGEUM_GYEJWA) AS GYEJWA_NM
              , (SELECT ACB FROM GYEJWA WHERE ACNO = GONGGEUM_GYEJWA) AS ACB
              , (SELECT AGE FROM GYEJWA WHERE ACNO = GONGGEUM_GYEJWA) AS AGE
        , 'JG' AS G
        , '110199' AS GG
        , JANAEK AS AMT
      FROM (
        SELECT /*+ INDEX(T1 RPT_GONGGEUM_JAN_IX_01) */
          (SELECT BIZ_DT
          FROM MAP_JOB_DATE
          WHERE DW_BAS_DDT = B.HOIKYE_YEAR || '0101') AS TRXDT
          , A.GONGGEUM_GYEJWA
          , A.JANAEK
        FROM RPT_GONGGEUM_JAN A,
        PARAM_DATA B
        WHERE 1=1
        AND A.KEORAEIL = B.HOIKYE_YEAR - 1 || '1231'
        AND A.HOIGYE_YEAR = 9999
        AND A.GONGGEUM_GYEJWA IN (SELECT ACNO FROM GYEJWA)
      )

      UNION ALL

      -- 공금잔액 / 당해 말일금액을 말일에 가이월지급처리해줌 (99회계 대상, 629904)
      SELECT
        TRXDT AS TRXDT
        , TRXDT AS GISDT
        , GONGGEUM_GYEJWA AS ACNO
              , (SELECT GYEJWA_NM FROM GYEJWA WHERE ACNO = GONGGEUM_GYEJWA) AS GYEJWA_NM
              , (SELECT ACB FROM GYEJWA WHERE ACNO = GONGGEUM_GYEJWA) AS ACB
              , (SELECT AGE FROM GYEJWA WHERE ACNO = GONGGEUM_GYEJWA) AS AGE
        , 'JG' AS G
        , '629904' AS GG
        , JANAEK * -1 AS AMT
      FROM (
        SELECT /*+ INDEX(T1 RPT_GONGGEUM_JAN_IX_01) */
          (SELECT BIZ_DT
          FROM MAP_JOB_DATE
          WHERE DW_BAS_DDT = B.HOIKYE_YEAR + 1 || '0101') AS TRXDT
          ,A.GONGGEUM_GYEJWA
          , A.JANAEK
        FROM RPT_GONGGEUM_JAN A,
        PARAM_DATA B
        WHERE 1=1
        AND A.KEORAEIL = B.HOIKYE_YEAR || '1231'
        AND A.HOIGYE_YEAR = 9999
        AND A.GONGGEUM_GYEJWA IN (SELECT ACNO FROM GYEJWA)
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
    , (일상경비지출_일계 + 사업소지출_일계)*-1 AS 세출_지출_계_일계
    , (일상경비반납_일계 + 사업소반납_일계) AS 세출_반납_계_일계
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
    , (일상경비지출 + 사업소지출)*-1 AS 세출_지출_계
    , (일상경비반납 + 사업소반납) AS 세출_반납_계
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
        CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('100000', '110100', '110200', '111300', '120400', '200000') THEN A.AMT
        -- 입금 중에 애매한 분류 세입에 포함 20250602
        WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('111100', '111200', '150000', '160000', '180000', '190800', '190900', '300000') THEN A.AMT
        -- 전년도 이월분 처리 / 운용잔액은 정기예금에서 차감되므로 반대 부호로 더해줌
        WHEN A.GISDT = B.KEORAEIL AND A.GG = '110199' THEN A.AMT
        WHEN A.GISDT = B.KEORAEIL AND A.GG = '629903' THEN A.AMT * -1
        ELSE 0 END
        ) AS 세입_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('130000', '630000', '650000', '660000', '700000') THEN A.AMT ELSE 0 END) + SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('249999', '649999') THEN -A.AMT ELSE 0 END) AS 세입정정_일계      
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('240000', '640000') THEN A.AMT ELSE 0 END) AS 과오납_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('249999', '649999') THEN A.AMT ELSE 0 END) AS 과오납정정_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('670091', '670093','610001') THEN A.AMT ELSE 0 END) AS 사업소지출_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('179100', '179300','140600') THEN A.AMT ELSE 0 END) AS 사업소반납_일계
      , SUM(
        CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('670090', '670092', '670000') THEN A.AMT 
        -- 지급 중에 애매한 분류 지출에 포함 20250602
        WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('610002', '680000', '690000', '800000', '940000') THEN A.AMT 
        ELSE 0 END
        ) AS 일상경비지출_일계 
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('179000', '179200', '170000','140700') THEN A.AMT ELSE 0 END) AS 일상경비반납_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('') THEN A.AMT ELSE 0 END) AS 전부금_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('620005') THEN A.AMT ELSE 0 END) AS 전출_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('120500') THEN A.AMT ELSE 0 END) AS 전입_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('') THEN A.AMT ELSE 0 END) AS 일시차입금_일계
      , SUM(CASE 
              WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('600000', '620004', '629904') THEN A.AMT
              WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('120399') THEN A.AMT * -1
              ELSE 0
            END) AS 이월지급_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('620003', '629903') THEN A.AMT ELSE 0 END) AS 정기예금신규_일계 -- 629903 전년도 이월분
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('120300', '120399') THEN A.AMT ELSE 0 END) AS 정기예금해지_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('620007', '620006') THEN A.AMT ELSE 0 END) AS MMDA신규_일계 -- 620006 별단예금 항목 분리 필요
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('121500', '121400') THEN A.AMT ELSE 0 END) AS MMDA해지_일계 -- 121400 별단예금 항목 분리 필요

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
        CASE WHEN A.GG IN ('100000', '110100', '110200', '111300', '120400', '200000') THEN A.AMT
        -- 입금 중에 애매한 분류 세입에 포함 20250602
        WHEN A.GG IN ('111100', '111200', '150000', '160000', '180000', '190800', '190900', '300000') THEN A.AMT
        -- 전년도 이월분 처리 / 운용잔액은 정기예금에서 차감되므로 반대 부호로 더해줌
        WHEN A.GG = '110199' THEN A.AMT
        WHEN A.GG = '629903' THEN A.AMT * -1
        ELSE 0 END
        ) AS 세입 
      , SUM(CASE WHEN A.GG IN ('130000', '630000', '650000', '660000', '700000') THEN A.AMT ELSE 0 END) + SUM(CASE WHEN A.GG IN ('249999', '649999') THEN -A.AMT ELSE 0 END) AS 세입정정
      , SUM(CASE WHEN A.GG IN ('240000', '640000') THEN A.AMT ELSE 0 END) AS 과오납
      , SUM(CASE WHEN A.GG IN ('249999', '649999') THEN A.AMT ELSE 0 END) AS 과오납정정      
      , SUM(CASE WHEN A.GG IN ('670091', '670093', '610001') THEN A.AMT ELSE 0 END) AS 사업소지출
      , SUM(CASE WHEN A.GG IN ('179100', '179300','140600') THEN A.AMT ELSE 0 END) AS 사업소반납
      , SUM(
        CASE WHEN A.GG IN ('670090', '670092', '670000') THEN A.AMT 
        -- 지급 중에 애매한 분류 지출에 포함 20250602
        WHEN A.GG IN ('610002', '680000', '690000', '800000', '940000') THEN A.AMT 
        ELSE 0 END
        ) AS 일상경비지출 
      , SUM(CASE WHEN A.GG IN ('179000', '179200', '170000','140700') THEN A.AMT ELSE 0 END) AS 일상경비반납
      , SUM(CASE WHEN A.GG IN ('') THEN A.AMT ELSE 0 END) AS 전부금
      , SUM(CASE WHEN A.GG IN ('620005') THEN A.AMT ELSE 0 END) AS 전출
      , SUM(CASE WHEN A.GG IN ('120500') THEN A.AMT ELSE 0 END) AS 전입
      , SUM(CASE WHEN A.GG IN ('') THEN A.AMT ELSE 0 END) AS 일시차입금
      , SUM(CASE 
              WHEN A.GG IN ('600000', '620004', '629904') THEN A.AMT
              WHEN A.GG IN ('120399') THEN A.AMT * -1
              ELSE 0
            END) AS 이월지급
      , SUM(CASE WHEN A.GG IN ('620003', '629903') THEN A.AMT ELSE 0 END) AS 정기예금신규 -- 629903 전년도 이월분
      , SUM(CASE WHEN A.GG IN ('120300', '120399') THEN A.AMT ELSE 0 END) AS 정기예금해지
      , SUM(CASE WHEN A.GG IN ('620007', '620006') THEN A.AMT ELSE 0 END) AS MMDA신규 -- 620006 별단예금 항목 분리 필요
      , SUM(CASE WHEN A.GG IN ('121500', '121400') THEN A.AMT ELSE 0 END) AS MMDA해지 -- 121400 별단예금 항목 분리 필요
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



---------------------------------------------------------

WITH PARAM_DATA AS (
    SELECT
      '02824501100000025' AS ACNO
      , '28' AS GEUMGO_CD
      , '2025' AS HOIKYE_YEAR
      , '20251027' AS KEORAEIL
    FROM DUAL
    )
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

------------------------------------------------------------

WITH PARAM_DATA AS (
    SELECT
      '02824501100000025' AS ACNO
      , '28' AS GEUMGO_CD
      , '2025' AS HOIKYE_YEAR
      , '20251027' AS KEORAEIL
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
          
      -- 운용잔액 / 전년자 말일금액을 익년 첫영업일자로 가져옴 (629903) - 지급거래형식으로, 마이너스 곱해줌
      SELECT
        TRXDT AS TRXDT
        , TRXDT AS GISDT
        , GONGGEUM_GYEJWA AS ACNO
        , (SELECT GYEJWA_NM FROM GYEJWA WHERE ACNO = GONGGEUM_GYEJWA) AS GYEJWA_NM
        , (SELECT ACB FROM GYEJWA WHERE ACNO = GONGGEUM_GYEJWA) AS ACB
        , (SELECT AGE FROM GYEJWA WHERE ACNO = GONGGEUM_GYEJWA) AS AGE
        , 'JG' AS G
        , '629903' AS GG
        , JANAEK * -1 AS AMT
      FROM (
        SELECT
          (SELECT BIZ_DT
          FROM MAP_JOB_DATE
          WHERE DW_BAS_DDT = B.HOIKYE_YEAR || '0101') AS TRXDT
          , CASE
            WHEN SUBSTR(A.GONGGEUM_GYEJWA, 16, 2) <> 99 THEN SUBSTR(A.GONGGEUM_GYEJWA, 1, 15) || SUBSTR(B.HOIKYE_YEAR, 3, 2)
            ELSE A.GONGGEUM_GYEJWA
          END AS GONGGEUM_GYEJWA
          , SUM(A.JANAEK) AS JANAEK
        FROM RPT_UNYONG_JAN A,
        RPT_UNYONG_GYEJWA C,
        PARAM_DATA B
        WHERE 1=1
          AND A.GEUMGO_CODE = B.GEUMGO_CD
          AND A.KIJUNIL = (SELECT
                  CASE
                    WHEN DT_G = 0 THEN BIZ_DT
                    ELSE BF1_BIZ_DT
                  END AS BIZ_DT
                  FROM MAP_JOB_DATE
                  WHERE DW_BAS_DDT = B.HOIKYE_YEAR - 1 || '1231')
          AND A.JANAEK > 0
          AND A.GEUMGO_CODE = C.GEUMGO_CODE
          AND A.GONGGEUM_GYEJWA = C.GONGGEUM_GYEJWA
          AND A.UNYONG_GYEJWA = C.UNYONG_GYEJWA
          AND NVL(C.HJI_DT, '99999999') > (SELECT
                  CASE
                    WHEN DT_G = 0 THEN BIZ_DT
                    ELSE BF1_BIZ_DT
                  END AS BIZ_DT
                  FROM MAP_JOB_DATE
                  WHERE DW_BAS_DDT = B.HOIKYE_YEAR - 1 || '1231')
        GROUP BY A.GONGGEUM_GYEJWA, B.HOIKYE_YEAR
      )
      WHERE GONGGEUM_GYEJWA IN (SELECT ACNO FROM GYEJWA)

      UNION ALL
      SELECT
        TRXDT AS TRXDT
        , TRXDT AS GISDT
        , GONGGEUM_GYEJWA AS ACNO
        , (SELECT GYEJWA_NM FROM GYEJWA WHERE ACNO = GONGGEUM_GYEJWA) AS GYEJWA_NM
        , (SELECT ACB FROM GYEJWA WHERE ACNO = GONGGEUM_GYEJWA) AS ACB
        , (SELECT AGE FROM GYEJWA WHERE ACNO = GONGGEUM_GYEJWA) AS AGE
        , 'JG' AS G
        , '120399' AS GG
        , JANAEK AS AMT
      FROM (
        SELECT
          (SELECT BIZ_DT
          FROM MAP_JOB_DATE
          WHERE DW_BAS_DDT = B.HOIKYE_YEAR + 1 || '0101') AS TRXDT
          , CASE
            WHEN SUBSTR(A.GONGGEUM_GYEJWA, 16, 2) <> 99 THEN SUBSTR(A.GONGGEUM_GYEJWA, 1, 15) || SUBSTR(B.HOIKYE_YEAR, 3, 2)
            ELSE A.GONGGEUM_GYEJWA
          END AS GONGGEUM_GYEJWA
          , SUM(A.JANAEK) AS JANAEK
        FROM RPT_UNYONG_JAN A,
        PARAM_DATA B
        WHERE 1=1
          AND A.KIJUNIL = (SELECT
                  CASE
                    WHEN DT_G = 0 THEN BIZ_DT
                    ELSE BF1_BIZ_DT
                  END AS BIZ_DT
                  FROM MAP_JOB_DATE
                  WHERE DW_BAS_DDT = B.HOIKYE_YEAR || '1231')
          AND JANAEK > 0
        GROUP BY A.GONGGEUM_GYEJWA, B.HOIKYE_YEAR
      )
      WHERE GONGGEUM_GYEJWA IN (SELECT ACNO FROM GYEJWA)

----------------------------------------------------------------------


SELECT 
             GONGGEUM_GYEJWA AS GONGGEUM_GYEJWA,
            
             TO_CHAR(SUM(NVL(세입_세입,0))) AS NUGYE_SUIBAEG ,              
             TO_CHAR(SUM(NVL(세입_과오납,0))) AS NUGYE_SEIB_GWAONAB,                  
             TO_CHAR(SUM(NVL(세입_세입정정,0)))   AS NUGYE_SEIB_JEONGJEONG,                
             TO_CHAR(SUM(NVL(세입_과오납정정,0)))   AS NUGYE_SEIB_GWOEDIT,                        
             TO_CHAR(SUM(NVL(세입_계,0))) AS NUGYE_SEIB_CHAGAM,
             
             TO_CHAR(SUM(NVL(세출_배정_지출 - 세출_배정_반납,0)))  AS NUGYE_SECHUL_BAEJEONGAEG,               
             TO_CHAR(SUM(NVL(세출_배정_반납,0)))  AS NUGYE_SECHUL_HWANSU,                 
             TO_CHAR(SUM(NVL(세출_일상경비_지출,0)))   AS NUGYE_SECHUL_JIBULAEG,                     
             TO_CHAR(SUM(NVL(세출_일상경비_지출,0)))  AS NUGYE_SECHUL_JICHUL, 
             TO_CHAR(SUM(NVL(세출_일상경비_반납,0))) AS NUGYE_SECHUL_BANNAB,
             TO_CHAR(SUM(NVL(세출_배정_계 + 세출_일상경비_계,0))) AS NUGYE_SECHUL_HAP,

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

             TO_CHAR(SUM(NVL(세출_배정_지출_일계 - 세출_배정_반납_일계,0)))  AS ILGYE_SECHUL_BAEJEONGAEG,                
             TO_CHAR(SUM(NVL(세출_배정_반납_일계,0)))  AS ILGYE_SECHUL_HWANSU,                  
             TO_CHAR(SUM(NVL(세출_일상경비_지출_일계,0)))   AS ILGYE_SECHUL_JIBULAEG,                      
             TO_CHAR(SUM(NVL(세출_일상경비_지출_일계,0)))  AS ILGYE_SECHUL_JICHUL,              
             TO_CHAR(SUM(NVL(세출_일상경비_반납_일계,0))) AS ILGYE_SECHUL_BANNAB,
             TO_CHAR(SUM(NVL(세출_배정_계_일계 + 세출_일상경비_계_일계,0))) AS ILGYE_SECHUL_HAP,
                                        

             TO_CHAR(SUM(NVL(세출_전부금_일계,0)))  AS ILGYE_JEONBUGEUM,                           
             TO_CHAR(SUM(NVL(전용_전출_일계,0)))  AS ILGYE_JEONCHUL,                        
             TO_CHAR(SUM(NVL(전용_전입_일계,0))) AS ILGYE_JEONIB,                           
             
             TO_CHAR(SUM(NVL(전용_일시차입금_일계,0)))  AS ILGYE_GAIWOL_IIB,                        
             TO_CHAR(SUM(NVL(전용_이월지급_일계,0)))  AS ILGYE_GAIWOL_JIGEUB,                     
             TO_CHAR(SUM(NVL(예금_정기예금신규_일계,0)))  AS ILGYE_SINGYU,                            
             TO_CHAR(SUM(NVL(예금_정기예금해지_일계,0))) AS ILGYE_HAEJI,
             TO_CHAR(SUM(NVL(예금_MMDA신규_일계,0)))  AS ILGYE_MMDA_SINGYU,                        
             TO_CHAR(SUM(NVL(예금_MMDA해지_일계,0))) AS ILGYE_MMDA_HAEJI,  

             TO_CHAR(SUM(NVL(예금_정기예금계_일계,0))) AS ILGYE_JEONGGI,  
             TO_CHAR(SUM(NVL(예금_MMDA계_일계,0))) AS ILGYE_MMDA      
FROM
              (
WITH PARAM_DATA AS (
    SELECT
      '02824501100000025' AS ACNO
      , '28' AS GEUMGO_CD
      , '2025' AS HOIKYE_YEAR
      , '20251027' AS KEORAEIL
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
        , (
  SELECT 
    (CASE WHEN SUBSTR(NVL(B.UPMU_HMK_3_SLV, '00000000000000000'), 16, 2) = '99' THEN NVL(B.UPMU_HMK_3_SLV, '00000000000000000')
   ELSE SUBSTR(NVL(B.UPMU_HMK_3_SLV, '00000000000000000'), 1, 15) || SUBSTR(NVL(C.HOIKYE_YEAR , '0000'), 3, 2) 
   END)
   AS ACNO
  FROM SFI_CMM_C_DAT B
  WHERE B.CMM_C_NM = 'RPT세입조정계좌매핑'
  AND B.USE_YN = 'Y'
  AND B.HRNK_CMM_DTL_C = A.GEUMGO_CODE
  AND B.UPMU_HMK_1_SLV = A.JIBGYE_CODE
  AND B.UPMU_HMK_2_SLV = A.GUNGU_CODE
  AND ROWNUM = 1
 ) AS ACNO
        , 'SJ' AS G
        , CASE WHEN A.IPJI_GUBUN = 1 THEN '249999' ELSE '649999' END AS GG
        , DECODE(A.IPJI_GUBUN, 2, -1, 1) * (A.GYOYUKSE_AMT + A.NONGTEUKSE_AMT + A.JIBANGSE_AMT + A.SEWOI_AMT) AS AMT
      FROM RPT_DANGSEIPJOJEONG A,
      PARAM_DATA C
      WHERE A.SUNAPIL BETWEEN  C.HOIKYE_YEAR || '0101' AND C.KEORAEIL
 AND A.GEUMGO_CODE = C.GEUMGO_CD
        AND A.JOJEONG_GUBUN = 2
  )
  , SLV AS (
    -- YY계좌 공금거래
    SELECT
        A.TRXDT
        , A.GISDT
        , A.FIL_100_CTNT5 AS ACNO
        , (SELECT GYEJWA_NM FROM GYEJWA WHERE ACNO = A.FIL_100_CTNT5) AS GYEJWA_NM
        , (SELECT ACB FROM GYEJWA WHERE ACNO = A.FIL_100_CTNT5) AS ACB
        , (SELECT AGE FROM GYEJWA WHERE ACNO = A.FIL_100_CTNT5) AS AGE
        , 'JG' AS G
        , LPAD(A.SIGUMGO_TRX_G, 2, '0') || LPAD(A.SIGUMGO_IP_TRX_G, 2, '0') || LPAD(A.SIGUMGO_JI_TRX_G, 2, '0') AS GG
        , SUM( DECODE(A.CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(A.IPJI_G, 2, -1, 1) * A.TRAMT ) AS AMT
      FROM ACL_SIGUMGO_SLV A,
      PARAM_DATA B
      WHERE A.FIL_100_CTNT5 IN (SELECT ACNO FROM GYEJWA)
      AND A.GISDT >=  B.HOIKYE_YEAR || '0101'
      AND A.SIGUMGO_HOIKYE_YR <> 9999
      GROUP BY A.TRXDT, A.GISDT, A.FIL_100_CTNT5, LPAD(A.SIGUMGO_TRX_G, 2, '0') || LPAD(A.SIGUMGO_IP_TRX_G, 2, '0') || LPAD(A.SIGUMGO_JI_TRX_G, 2, '0')

      UNION ALL

      -- 99계좌 공금거래 / 기준일, 기산일 당년도분

    SELECT
        A.TRXDT
        , A.GISDT
        , A.FIL_100_CTNT5 AS ACNO
        , (SELECT GYEJWA_NM FROM GYEJWA WHERE ACNO = A.FIL_100_CTNT5) AS GYEJWA_NM
        , (SELECT ACB FROM GYEJWA WHERE ACNO = A.FIL_100_CTNT5) AS ACB
        , (SELECT AGE FROM GYEJWA WHERE ACNO = A.FIL_100_CTNT5) AS AGE
        , 'JG' AS G
        , LPAD(A.SIGUMGO_TRX_G, 2, '0') || LPAD(A.SIGUMGO_IP_TRX_G, 2, '0') || LPAD(A.SIGUMGO_JI_TRX_G, 2, '0') AS GG
        , SUM( DECODE(A.CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(A.IPJI_G, 2, -1, 1) * A.TRAMT ) AS AMT
      FROM ACL_SIGUMGO_SLV A,
      PARAM_DATA B
      WHERE A.FIL_100_CTNT5 IN (SELECT ACNO FROM GYEJWA)
      AND A.GJDT >=  B.HOIKYE_YEAR || '0101'
      AND A.GJDT <= (CASE WHEN B.KEORAEIL > B.HOIKYE_YEAR || '1231' THEN B.HOIKYE_YEAR || '1231' ELSE B.KEORAEIL END)
      AND A.GISDT >= B.HOIKYE_YEAR || '0101'
      AND A.SIGUMGO_HOIKYE_YR = 9999
      GROUP BY A.TRXDT, A.GISDT, A.FIL_100_CTNT5, LPAD(A.SIGUMGO_TRX_G, 2, '0') || LPAD(A.SIGUMGO_IP_TRX_G, 2, '0') || LPAD(A.SIGUMGO_JI_TRX_G, 2, '0')

      UNION ALL

      -- 99계좌 공금거래 / 기준일 전년도, 기산일 당년도분 - 일별로 세입처리 (110199)
      SELECT
        A.TRXDT
        , A.GISDT
        , A.FIL_100_CTNT5 AS ACNO
        , (SELECT GYEJWA_NM FROM GYEJWA WHERE ACNO = A.FIL_100_CTNT5) AS GYEJWA_NM
        , (SELECT ACB FROM GYEJWA WHERE ACNO = A.FIL_100_CTNT5) AS ACB
        , (SELECT AGE FROM GYEJWA WHERE ACNO = A.FIL_100_CTNT5) AS AGE
        , 'JG' AS G
        , '110199' AS GG
        , SUM( DECODE(A.CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(A.IPJI_G, 2, -1, 1) * A.TRAMT ) AS AMT
      FROM ACL_SIGUMGO_SLV A,
      PARAM_DATA B
      WHERE A.FIL_100_CTNT5 IN (SELECT ACNO FROM GYEJWA)
      AND A.GJDT < B.HOIKYE_YEAR || '0101'
      AND A.GISDT >= B.HOIKYE_YEAR || '0101'
      AND A.SIGUMGO_HOIKYE_YR = 9999
      GROUP BY A.TRXDT, A.GISDT, A.FIL_100_CTNT5

      UNION ALL

      -- 99계좌 공금거래 / 기준일 당년도, 기산일 익년도분 - 일별로 가이월지급처리 (629904)
      SELECT
        A.TRXDT
        , A.GISDT
        , A.FIL_100_CTNT5 AS ACNO
        , (SELECT GYEJWA_NM FROM GYEJWA WHERE ACNO = A.FIL_100_CTNT5) AS GYEJWA_NM
        , (SELECT ACB FROM GYEJWA WHERE ACNO = A.FIL_100_CTNT5) AS ACB
        , (SELECT AGE FROM GYEJWA WHERE ACNO = A.FIL_100_CTNT5) AS AGE
        , 'JG' AS G
        , '629904' AS GG
        , SUM( DECODE(A.CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(A.IPJI_G, 2, -1, 1) * A.TRAMT ) * -1 AS AMT
      FROM ACL_SIGUMGO_SLV A,
      PARAM_DATA B
      WHERE A.FIL_100_CTNT5 IN (SELECT ACNO FROM GYEJWA)
      AND A.GJDT >=  B.HOIKYE_YEAR || '0101'
      AND A.GJDT <= (CASE WHEN B.KEORAEIL > B.HOIKYE_YEAR || '1231' THEN B.HOIKYE_YEAR || '1231' ELSE B.KEORAEIL END)
      AND A.GISDT > B.HOIKYE_YEAR || '1231'
      AND A.SIGUMGO_HOIKYE_YR = 9999
      GROUP BY A.TRXDT, A.GISDT, A.FIL_100_CTNT5
      
      UNION ALL

      -- 한도거래
      SELECT
        A.TRXDT
        , A.GISDT
        , A.SIGUMGO_ACNO AS ACNO
        , (SELECT GYEJWA_NM FROM GYEJWA WHERE ACNO = A.SIGUMGO_ACNO) AS GYEJWA_NM
        , (SELECT ACB FROM GYEJWA WHERE ACNO = A.SIGUMGO_ACNO) AS ACB
        , (SELECT AGE FROM GYEJWA WHERE ACNO = A.SIGUMGO_ACNO) AS AGE
        , 'HD' AS G
        , TO_CHAR(A.SIGUMGO_TRX_G) AS GG
        , SUM( DECODE(A.CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(A.IPJI_G, 2, -1, 1) * A.TRAMT ) AS AMT
      FROM ACL_SGGHANDO_SLV A,
      PARAM_DATA B
      WHERE A.SIGUMGO_ACNO IN (SELECT ACNO FROM GYEJWA)
      AND A.TRXDT >=  B.HOIKYE_YEAR || '0101'
      GROUP BY A.TRXDT, A.GISDT, A.SIGUMGO_ACNO, A.SIGUMGO_TRX_G

      UNION ALL

      -- 과오납조정 거래
      SELECT
        A.TRXDT
        , A.GISDT
        , A.ACNO
        , B.GYEJWA_NM
        , B.ACB 
        , B.AGE
        , A.G
        , A.GG
        , A.AMT
      FROM DANGSEIPJOJEONG A, GYEJWA B
      WHERE A.ACNO = B.ACNO

      UNION ALL
      
      -- 운용잔액 / 전년자 말일금액을 익년 첫영업일자로 가져옴 (629903) - 지급거래형식으로, 마이너스 곱해줌
      SELECT
        TRXDT AS TRXDT
        , TRXDT AS GISDT
        , GONGGEUM_GYEJWA AS ACNO
        , (SELECT GYEJWA_NM FROM GYEJWA WHERE ACNO = GONGGEUM_GYEJWA) AS GYEJWA_NM
        , (SELECT ACB FROM GYEJWA WHERE ACNO = GONGGEUM_GYEJWA) AS ACB
        , (SELECT AGE FROM GYEJWA WHERE ACNO = GONGGEUM_GYEJWA) AS AGE
        , 'JG' AS G
        , '629903' AS GG
        , JANAEK * -1 AS AMT
      FROM (
        SELECT
          (SELECT BIZ_DT
          FROM MAP_JOB_DATE
          WHERE DW_BAS_DDT = B.HOIKYE_YEAR || '0101') AS TRXDT
          , CASE
            WHEN SUBSTR(A.GONGGEUM_GYEJWA, 16, 2) <> 99 THEN SUBSTR(A.GONGGEUM_GYEJWA, 1, 15) || SUBSTR(B.HOIKYE_YEAR, 3, 2)
            ELSE A.GONGGEUM_GYEJWA
          END AS GONGGEUM_GYEJWA
          , SUM(A.JANAEK) AS JANAEK
        FROM RPT_UNYONG_JAN A,
        RPT_UNYONG_GYEJWA C,
        PARAM_DATA B
        WHERE 1=1
          AND A.GEUMGO_CODE = B.GEUMGO_CD
          AND A.KIJUNIL = (SELECT
                  CASE
                    WHEN DT_G = 0 THEN BIZ_DT
                    ELSE BF1_BIZ_DT
                  END AS BIZ_DT
                  FROM MAP_JOB_DATE
                  WHERE DW_BAS_DDT = B.HOIKYE_YEAR - 1 || '1231')
          AND A.JANAEK > 0
          AND A.GEUMGO_CODE = C.GEUMGO_CODE
          AND A.GONGGEUM_GYEJWA = C.GONGGEUM_GYEJWA
          AND A.UNYONG_GYEJWA = C.UNYONG_GYEJWA
          AND NVL(C.HJI_DT, '99999999') > (SELECT
                  CASE
                    WHEN DT_G = 0 THEN BIZ_DT
                    ELSE BF1_BIZ_DT
                  END AS BIZ_DT
                  FROM MAP_JOB_DATE
                  WHERE DW_BAS_DDT = B.HOIKYE_YEAR - 1 || '1231')
        GROUP BY A.GONGGEUM_GYEJWA, B.HOIKYE_YEAR
      )
      WHERE GONGGEUM_GYEJWA IN (SELECT ACNO FROM GYEJWA)

      UNION ALL

      -- 운용잔액 / 당해 말일금액을 말일에 해지처리해줌 (120399)
      SELECT
        TRXDT AS TRXDT
        , TRXDT AS GISDT
        , GONGGEUM_GYEJWA AS ACNO
        , (SELECT GYEJWA_NM FROM GYEJWA WHERE ACNO = GONGGEUM_GYEJWA) AS GYEJWA_NM
        , (SELECT ACB FROM GYEJWA WHERE ACNO = GONGGEUM_GYEJWA) AS ACB
        , (SELECT AGE FROM GYEJWA WHERE ACNO = GONGGEUM_GYEJWA) AS AGE
        , 'JG' AS G
        , '120399' AS GG
        , JANAEK AS AMT
      FROM (
        SELECT
          (SELECT BIZ_DT
          FROM MAP_JOB_DATE
          WHERE DW_BAS_DDT = B.HOIKYE_YEAR + 1 || '0101') AS TRXDT
          , CASE
            WHEN SUBSTR(A.GONGGEUM_GYEJWA, 16, 2) <> 99 THEN SUBSTR(A.GONGGEUM_GYEJWA, 1, 15) || SUBSTR(B.HOIKYE_YEAR, 3, 2)
            ELSE A.GONGGEUM_GYEJWA
          END AS GONGGEUM_GYEJWA
          , SUM(A.JANAEK) AS JANAEK
        FROM RPT_UNYONG_JAN A,
        PARAM_DATA B
        WHERE 1=1
          AND A.KIJUNIL = (SELECT
                  CASE
                    WHEN DT_G = 0 THEN BIZ_DT
                    ELSE BF1_BIZ_DT
                  END AS BIZ_DT
                  FROM MAP_JOB_DATE
                  WHERE DW_BAS_DDT = B.HOIKYE_YEAR || '1231')
          AND JANAEK > 0
        GROUP BY A.GONGGEUM_GYEJWA, B.HOIKYE_YEAR
      )
      WHERE GONGGEUM_GYEJWA IN (SELECT ACNO FROM GYEJWA)

      UNION ALL

      -- 공금잔액 / 전년자 말일금액을 익년 첫영업일자로 가져옴 (99회계 대상, 110199)
      SELECT
        TRXDT AS TRXDT
        , TRXDT AS GISDT
        , GONGGEUM_GYEJWA AS ACNO
              , (SELECT GYEJWA_NM FROM GYEJWA WHERE ACNO = GONGGEUM_GYEJWA) AS GYEJWA_NM
              , (SELECT ACB FROM GYEJWA WHERE ACNO = GONGGEUM_GYEJWA) AS ACB
              , (SELECT AGE FROM GYEJWA WHERE ACNO = GONGGEUM_GYEJWA) AS AGE
        , 'JG' AS G
        , '110199' AS GG
        , JANAEK AS AMT
      FROM (
        SELECT /*+ INDEX(T1 RPT_GONGGEUM_JAN_IX_01) */
          (SELECT BIZ_DT
          FROM MAP_JOB_DATE
          WHERE DW_BAS_DDT = B.HOIKYE_YEAR || '0101') AS TRXDT
          , A.GONGGEUM_GYEJWA
          , A.JANAEK
        FROM RPT_GONGGEUM_JAN A,
        PARAM_DATA B
        WHERE 1=1
        AND A.KEORAEIL = B.HOIKYE_YEAR - 1 || '1231'
        AND A.HOIGYE_YEAR = 9999
        AND A.GONGGEUM_GYEJWA IN (SELECT ACNO FROM GYEJWA)
      )

      UNION ALL

      -- 공금잔액 / 당해 말일금액을 말일에 가이월지급처리해줌 (99회계 대상, 629904)
      SELECT
        TRXDT AS TRXDT
        , TRXDT AS GISDT
        , GONGGEUM_GYEJWA AS ACNO
              , (SELECT GYEJWA_NM FROM GYEJWA WHERE ACNO = GONGGEUM_GYEJWA) AS GYEJWA_NM
              , (SELECT ACB FROM GYEJWA WHERE ACNO = GONGGEUM_GYEJWA) AS ACB
              , (SELECT AGE FROM GYEJWA WHERE ACNO = GONGGEUM_GYEJWA) AS AGE
        , 'JG' AS G
        , '629904' AS GG
        , JANAEK * -1 AS AMT
      FROM (
        SELECT /*+ INDEX(T1 RPT_GONGGEUM_JAN_IX_01) */
          (SELECT BIZ_DT
          FROM MAP_JOB_DATE
          WHERE DW_BAS_DDT = B.HOIKYE_YEAR + 1 || '0101') AS TRXDT
          ,A.GONGGEUM_GYEJWA
          , A.JANAEK
        FROM RPT_GONGGEUM_JAN A,
        PARAM_DATA B
        WHERE 1=1
        AND A.KEORAEIL = B.HOIKYE_YEAR || '1231'
        AND A.HOIGYE_YEAR = 9999
        AND A.GONGGEUM_GYEJWA IN (SELECT ACNO FROM GYEJWA)
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
    , (일상경비지출_일계 + 사업소지출_일계)*-1 AS 세출_지출_계_일계
    , (일상경비반납_일계 + 사업소반납_일계) AS 세출_반납_계_일계
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
    , (일상경비지출 + 사업소지출)*-1 AS 세출_지출_계
    , (일상경비반납 + 사업소반납) AS 세출_반납_계
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
        CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('100000', '110100', '110200', '111300', '120400', '200000') THEN A.AMT
        -- 입금 중에 애매한 분류 세입에 포함 20250602
        WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('111100', '111200', '150000', '160000', '180000', '190800', '190900', '300000') THEN A.AMT
        -- 전년도 이월분 처리 / 운용잔액은 정기예금에서 차감되므로 반대 부호로 더해줌
        WHEN A.GISDT = B.KEORAEIL AND A.GG = '110199' THEN A.AMT
        WHEN A.GISDT = B.KEORAEIL AND A.GG = '629903' THEN A.AMT * -1
        ELSE 0 END
        ) AS 세입_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('130000', '630000', '650000', '660000', '700000') THEN A.AMT ELSE 0 END) + SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('249999', '649999') THEN -A.AMT ELSE 0 END) AS 세입정정_일계      
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('240000', '640000') THEN A.AMT ELSE 0 END) AS 과오납_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('249999', '649999') THEN A.AMT ELSE 0 END) AS 과오납정정_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('670091', '670093','610001') THEN A.AMT ELSE 0 END) AS 사업소지출_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('179100', '179300','140600') THEN A.AMT ELSE 0 END) AS 사업소반납_일계
      , SUM(
        CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('670090', '670092', '670000') THEN A.AMT 
        -- 지급 중에 애매한 분류 지출에 포함 20250602
        WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('610002', '680000', '690000', '800000', '940000') THEN A.AMT 
        ELSE 0 END
        ) AS 일상경비지출_일계 
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('179000', '179200', '170000','140700') THEN A.AMT ELSE 0 END) AS 일상경비반납_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('') THEN A.AMT ELSE 0 END) AS 전부금_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('620005') THEN A.AMT ELSE 0 END) AS 전출_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('120500') THEN A.AMT ELSE 0 END) AS 전입_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('') THEN A.AMT ELSE 0 END) AS 일시차입금_일계
      , SUM(CASE 
              WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('600000', '620004', '629904') THEN A.AMT
              WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('120399') THEN A.AMT * -1
              ELSE 0
            END) AS 이월지급_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('620003', '629903') THEN A.AMT ELSE 0 END) AS 정기예금신규_일계 -- 629903 전년도 이월분
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('120300', '120399') THEN A.AMT ELSE 0 END) AS 정기예금해지_일계
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('620007', '620006') THEN A.AMT ELSE 0 END) AS MMDA신규_일계 -- 620006 별단예금 항목 분리 필요
      , SUM(CASE WHEN A.GISDT = B.KEORAEIL AND A.GG IN ('121500', '121400') THEN A.AMT ELSE 0 END) AS MMDA해지_일계 -- 121400 별단예금 항목 분리 필요

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
        CASE WHEN A.GG IN ('100000', '110100', '110200', '111300', '120400', '200000') THEN A.AMT
        -- 입금 중에 애매한 분류 세입에 포함 20250602
        WHEN A.GG IN ('111100', '111200', '150000', '160000', '180000', '190800', '190900', '300000') THEN A.AMT
        -- 전년도 이월분 처리 / 운용잔액은 정기예금에서 차감되므로 반대 부호로 더해줌
        WHEN A.GG = '110199' THEN A.AMT
        WHEN A.GG = '629903' THEN A.AMT * -1
        ELSE 0 END
        ) AS 세입 
      , SUM(CASE WHEN A.GG IN ('130000', '630000', '650000', '660000', '700000') THEN A.AMT ELSE 0 END) + SUM(CASE WHEN A.GG IN ('249999', '649999') THEN -A.AMT ELSE 0 END) AS 세입정정
      , SUM(CASE WHEN A.GG IN ('240000', '640000') THEN A.AMT ELSE 0 END) AS 과오납
      , SUM(CASE WHEN A.GG IN ('249999', '649999') THEN A.AMT ELSE 0 END) AS 과오납정정      
      , SUM(CASE WHEN A.GG IN ('670091', '670093', '610001') THEN A.AMT ELSE 0 END) AS 사업소지출
      , SUM(CASE WHEN A.GG IN ('179100', '179300','140600') THEN A.AMT ELSE 0 END) AS 사업소반납
      , SUM(
        CASE WHEN A.GG IN ('670090', '670092', '670000') THEN A.AMT 
        -- 지급 중에 애매한 분류 지출에 포함 20250602
        WHEN A.GG IN ('610002', '680000', '690000', '800000', '940000') THEN A.AMT 
        ELSE 0 END
        ) AS 일상경비지출 
      , SUM(CASE WHEN A.GG IN ('179000', '179200', '170000','140700') THEN A.AMT ELSE 0 END) AS 일상경비반납
      , SUM(CASE WHEN A.GG IN ('') THEN A.AMT ELSE 0 END) AS 전부금
      , SUM(CASE WHEN A.GG IN ('620005') THEN A.AMT ELSE 0 END) AS 전출
      , SUM(CASE WHEN A.GG IN ('120500') THEN A.AMT ELSE 0 END) AS 전입
      , SUM(CASE WHEN A.GG IN ('') THEN A.AMT ELSE 0 END) AS 일시차입금
      , SUM(CASE 
              WHEN A.GG IN ('600000', '620004', '629904') THEN A.AMT
              WHEN A.GG IN ('120399') THEN A.AMT * -1
              ELSE 0
            END) AS 이월지급
      , SUM(CASE WHEN A.GG IN ('620003', '629903') THEN A.AMT ELSE 0 END) AS 정기예금신규 -- 629903 전년도 이월분
      , SUM(CASE WHEN A.GG IN ('120300', '120399') THEN A.AMT ELSE 0 END) AS 정기예금해지
      , SUM(CASE WHEN A.GG IN ('620007', '620006') THEN A.AMT ELSE 0 END) AS MMDA신규 -- 620006 별단예금 항목 분리 필요
      , SUM(CASE WHEN A.GG IN ('121500', '121400') THEN A.AMT ELSE 0 END) AS MMDA해지 -- 121400 별단예금 항목 분리 필요
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


-------------------------------------------

SELECT
 A.USER_ID,
 A.USER_NM,
 SUBSTR(A.DR_DTTM, 1, 8) AS DR_DATE,
 TO_CHAR(TO_DATE(MIN(A.DR_DTTM), 'YYYYMMDDHH24MISS'),
               'YYYY"년" MM"월" DD"일" HH24"시" MI"분" SS"초"') AS DR_DATE_TIME,
 MIN(A.DR_DTTM) AS DR_DTTM,
 SUBSTR(MIN(A.DR_DTTM), 9, 6) AS DR_TIME,
 CASE WHEN SUBSTR(MIN(A.DR_DTTM), 9, 6) < '085566' THEN 'Y' ELSE 'N' END AS DE_YN
FROM 
(
SELECT 
  SL_GMGO_MODL_C
 , USER_ID
 , USER_NM
 , DR_SER
 , MENU_ID
 , MENU_NM  
 , SCR_ID
 , SCR_NM
 , DR_DTTM
 , DROKJA_ID
 , UPD_DTTM
 , MODR_ID
FROM  (
 SELECT 
  ROWNUM AS RNUM
  , Z.SL_GMGO_MODL_C
  , Z.USER_ID
  , (SELECT MAX(B.USER_NM)  USER_NM
       FROM  SFI_USER_INF B
       WHERE Z.MODR_ID = B.USER_ID) AS USER_NM
  , Z.DR_SER
  , Z.MENU_ID
  ,B.MENU_NM
  , Z.SCR_ID
  , C.SCR_NM
  , Z.DR_DTTM
  , Z.DROKJA_ID
  , Z.UPD_DTTM
  , Z.MODR_ID
 FROM  SFI_SCR_LTST_HIS Z, RPT_MENU_INF B, SFI_SCR_INF C
 WHERE 
   Z.SL_GMGO_MODL_C = 'RPT'
  AND ((SELECT MAX(A.USER_NM) 
          FROM  SFI_USER_INF A 
         WHERE Z.MODR_ID = A.USER_ID) LIKE '%'||''||'%'
       OR Z.USER_ID LIKE '%'||''||'%' )
  AND ((SELECT MAX(E.MENU_NM)
          FROM    SFI_MENU_INF E
         WHERE  E.SL_GMGO_MODL_C = 'RPT'
           AND Z.MENU_ID = E.MENU_ID) LIKE '%'||''||'%'
       OR Z.MENU_ID LIKE '%'||''||'%' )
  AND ((SELECT MAX(F.SCR_NM)
          FROM    SFI_SCR_INF F
         WHERE  F.SL_GMGO_MODL_C = 'RPT'
           AND Z.SCR_ID = F.SCR_ID) LIKE '%'||''||'%'
       OR Z.SCR_ID LIKE '%'||''||'%' )
  AND Z.DR_DTTM LIKE '%'||'2025'||'%'
  AND Z.SL_GMGO_MODL_C = B.SL_GMGO_MODL_C
  AND Z.MENU_ID = B.MENU_ID
  AND Z.SL_GMGO_MODL_C = C.SL_GMGO_MODL_C
  AND Z.SCR_ID = C.SCR_ID
  ORDER BY UPD_DTTM DESC
) X
WHERE X.USER_NM = '김그루'
) A
GROUP BY  A.USER_ID,
 A.USER_NM,
 SUBSTR(A.DR_DTTM, 1, 8)
ORDER BY SUBSTR(A.DR_DTTM, 1, 8) 