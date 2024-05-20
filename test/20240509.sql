SELECT
   T.HOIGYE_YEAR
   ,T.HOIGYE_CODE AS HOIGYE_CODE_VAL
   ,LPAD(T.HOIGYE_CODE,2,'0') AS HOIGYE_CODE
   ,U.HOIKYE_NM AS HOIGYE_NAME
     ,TO_CHAR(T.GUNGU_CODE) AS GUNGU_CODE_VAL
     ,LPAD(T.GUNGU_CODE,3,'0') AS GUNGU_CODE
     ,W.CMM_DTL_C_NM AS GUNGU_NAME
   ,T.KIJUNIL
     ,TO_CHAR(NVL(T.AMT1,0)) AS GONGGUEM
     ,TO_CHAR(NVL(T.AMT2,0)) AS JAGUEMUNYONG
     ,TO_CHAR(NVL(T.AMT3,0)) AS ETC 
     ,TO_CHAR(NVL(T.AMT4,0)) AS MMDA_MMF
     ,TO_CHAR(NVL(T.AMT5,0)) AS MIJUNGSAN
     ,TO_CHAR(NVL(T.AMT6,0)) AS JUNBUGUEM
     ,'0' AS KITA
     ,'0' AS BIGO
    FROM
   ( SELECT KIJUNIL, GUNGU_CODE, HOIGYE_YEAR, HOIGYE_CODE, GEUMGO_CODE,
        SUM(CASE WHEN GUBUN_CODE = 1 THEN AMT1 ELSE 0 END) AMT1, 
        SUM(CASE WHEN GUBUN_CODE = 2 THEN AMT1 ELSE 0 END) AMT2, 
        SUM(CASE WHEN GUBUN_CODE = 3 THEN AMT1 ELSE 0 END) AMT3, 
        SUM(CASE WHEN GUBUN_CODE = 4 THEN AMT1 ELSE 0 END) AMT4,
        SUM(CASE WHEN GUBUN_CODE = 5 THEN AMT1 ELSE 0 END) AMT5,
        SUM(CASE WHEN GUBUN_CODE = 6 THEN AMT1 ELSE 0 END) AMT6
         FROM RPT_HOIGYE_IWOL A
      WHERE 1=1
          AND HOIGYE_YEAR = '2023'
          AND GEUMGO_CODE = '130'
          AND GUNGU_CODE = '0'
          AND GUBUN_CODE IN (1, 2, 3, 4, 5, 6)
   AND DECODE(NVL('', 'ALL'), 'ALL', 9999, HOIGYE_CODE) = DECODE(NVL('', 'ALL'), 'ALL', 9999, '')
        GROUP BY KIJUNIL, HOIGYE_YEAR, HOIGYE_CODE, GUNGU_CODE, GEUMGO_CODE
   ) T,
   (SELECT SIGUMGO_HOIKYE_C , HOIKYE_NM
   FROM RPT_HOIKYE_CD
   WHERE SIGUMGO_C = '130'
   ) U,
   (SELECT HRNK_CMM_DTL_C,CMM_DTL_C_NM 
   FROM SFI_CMM_C_DAT
   WHERE CMM_C_NM =  'RPT군구코드'
   AND HRNK_CMM_DTL_C = '130'
   AND TO_NUMBER(CMM_DTL_C) = 0
   ) W
  WHERE T.HOIGYE_CODE = U.SIGUMGO_HOIKYE_C
    AND T.GEUMGO_CODE = W.HRNK_CMM_DTL_C
  ORDER BY T.HOIGYE_CODE

  --------------------------------------

SELECT *
         FROM RPT_HOIGYE_IWOL A
      WHERE 1=1
          AND HOIGYE_YEAR = '2023'
          AND GEUMGO_CODE = '130'
          AND GUNGU_CODE = '0'
          and HOIGYE_CODE = 4

KEORAEIL	KIJUNIL	GEUMGO_CODE	GUBUN_CODE	GUBUN_NAME	HOIGYE_CODE	GUNGU_CODE	HOIGYE_YEAR	GONGGEUM_GYEJWA	AMT1_NAME	AMT1
20240102	20240102	130	1	공금예금	4	0	2023	00000000000000000	공금예금	47509551
20240102	20240102	130	2	당행자금운용	4	0	2023	00000000000000000	당행자금운용	0
20240102	20240102	130	3	당행자금운용	4	0	2023	00000000000000000	당행자금운용	0
20240102	20240102	130	4	통합MMDA/MMF	4	0	2023	00000000000000000	통합MMDA/MMF	0
20240102	20240102	130	5	미정산분	4	0	2023	00000000000000000	미정산분	0


---------------------------------------
-- 회계이월 - 등록내역산출 - 원주시 - 통합재정안정화기금

SELECT
     T1.HOIGYE_CODE
    ,T2.HOIKYE_NM AS HOIGYE_NAME
    ,(
      (
         (SUM(T1.SEIP_SUNAP_JIBGYE) + SUM(T1.SEIP_BAEJEONG_IP) + SUM(T1.IWOL_SUNAP))
       - ((SUM(T1.SEIP_SUNAP_JIBGYE) - SUM(T1.SEIP_SUIP_AMT)) +SUM(T1.IWOL_MIICHE))
      ) - SUM(T1.SEIB_BANNAP)
      + (
         SUM(T1.SEIB_GYEONGJEONG_IB) - SUM(T1.SECHUL_GYEONGJEONG_IB)
        )
      - (
         SUM(T1.JAGEUM_BAEJEONG) - SUM(T1.JAGEUM_HWANSU)
        )
      - (
         SUM(T1.SECHUL_JIGEUB) - SUM(T1.SECHUL_BANHWAN)
        )
      + (
         SUM(T1.SECHUL_GYEONGJEONG_JI) - SUM(T1.SECHUL_GYEONGJEONG_IB)
        )
      - SUM(T1.JUN_IIB) - SUM(T1.JUN_IWOL)
     ) AS GONGGUEM
    ,(SUM(T1.YAEGEUM_SINGYU) + SUM(T1.IWOL_YAEGEUM)) - SUM(T1.HWANIP) AS JAGUEMUNYONG
    ,0 AS BIGO
    ,0 AS JUNBUGUEM
    ,0 AS MIJUNGSAN
    ,0 AS MMDA_MMF
FROM
     (
      SELECT
           TO_NUMBER(T2.SIGUMGO_HOIKYE_C) AS HOIGYE_CODE
          ,DECODE(T1.SIGUMGO_TRX_G, 11, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT, 0) AS SEIP_SUIP_AMT
          ,CASE
               WHEN T1.SIGUMGO_TRX_G IN (15, 16) THEN DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT
               ELSE 0
            END AS SEIP_BAEJEONG_IP
          ,DECODE(T1.SIGUMGO_TRX_G, 64, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT, 0) AS SEIB_BANNAP
          ,DECODE(T1.SIGUMGO_TRX_G, 19, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT, 0) AS SEIB_GYEONGJEONG_IB
          ,DECODE(T1.SIGUMGO_TRX_G, 69, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT, 0) AS SEIB_GYEONGJEONG_JI
          ,CASE
               WHEN T1.SIGUMGO_TRX_G = 61 AND T1.SIGUMGO_JI_TRX_G = 1 THEN DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT
               ELSE 0
            END AS JAGEUM_BAEJEONG
          ,CASE
               WHEN T1.SIGUMGO_TRX_G  = 14 AND T1.SIGUMGO_IP_TRX_G = 6 THEN DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT
               ELSE 0
            END AS JAGEUM_HWANSU
          ,DECODE(T1.SIGUMGO_TRX_G, 67, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT, 0) AS SECHUL_JIGEUB
          ,DECODE(T1.SIGUMGO_TRX_G, 17, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT, 0) AS SECHUL_BANHWAN
          ,DECODE(T1.SIGUMGO_TRX_G, 18, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT, 0) AS SECHUL_GYEONGJEONG_IB
          ,DECODE(T1.SIGUMGO_TRX_G, 65, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT, 0) AS SECHUL_GYEONGJEONG_JI
          ,CASE
               WHEN T1.SIGUMGO_TRX_G = 12 AND T1.SIGUMGO_IP_TRX_G = 4 THEN DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT
               ELSE 0
            END AS JUN_IIB
          ,CASE
               WHEN T1.SIGUMGO_TRX_G = 62 AND T1.SIGUMGO_JI_TRX_G = 4 THEN DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT
               ELSE 0
            END AS JUN_IWOL
          ,CASE
               WHEN T1.SIGUMGO_TRX_G = 62 AND T1.SIGUMGO_JI_TRX_G = 3 THEN DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT
               ELSE 0
            END AS YAEGEUM_SINGYU
          ,CASE
               WHEN T1.SIGUMGO_TRX_G = 12 AND T1.SIGUMGO_IP_TRX_G = 3 THEN DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT
               ELSE 0
            END AS HWANIP
          ,0 AS SEIP_SUNAP_JIBGYE
          ,0 AS IWOL_SUNAP
          ,0 AS IWOL_MIICHE
          ,0 AS IWOL_MMDA
          ,0 AS IWOL_YAEGEUM
      FROM
           ACL_SIGUMGO_SLV T1
          ,RPT_AC_BY_HOIKYE_MAPP T2
      WHERE 1=1
           AND T1.FIL_100_CTNT5 = T2.SIGUMGO_ACNO
           AND T1.SIGUMGO_ORG_C = T2.SIGUMGO_C
           AND T1.SIGUMGO_ORG_C = '130'
           AND T1.GJDT >= '20230101'
           AND T1.GJDT <= '20240509'
           AND DECODE(T1.SIGUMGO_HOIKYE_YR, '9999', SUBSTR(T1.GJDT, 1, 4), T1.SIGUMGO_HOIKYE_YR) = '2023'
 AND DECODE(NVL('4', '99'), '99', 1, T2.SIGUMGO_HOIKYE_C) = DECODE(NVL('4', '99'), '99', 1, '4')
      UNION ALL
      SELECT
           T1.JIBGYE_CODE AS HOIGYE_CODE
          ,0 AS SEIP_SUIP_AMT
          ,0 AS SEIP_BAEJEONG_IP
          ,0 AS SEIB_BANNAP
          ,0 AS SEIB_GYEONGJEONG_IB
          ,0 AS SEIB_GYEONGJEONG_JI
          ,0 AS JAGEUM_BAEJEONG
          ,0 AS JAGEUM_HWANSU
          ,0 AS SECHUL_JIGEUB
          ,0 AS SECHUL_BANHWAN
          ,0 AS SECHUL_GYEONGJEONG_IB
          ,0 AS SECHUL_GYEONGJEONG_JI
          ,0 AS JUN_IIB
          ,0 AS JUN_IWOL
          ,0 AS YAEGEUM_SINGYU
          ,0 AS HWANIP
          ,T1.BONSE_AMT AS SEIP_SUNAP_JIBGYE
          ,0 AS IWOL_SUNAP
          ,0 AS IWOL_MIICHE
          ,0 AS IWOL_MMDA
          ,0 AS IWOL_YAEGEUM
      FROM
           RPT_SUNAP_JIBGYE T1
      WHERE 1=1
           AND T1.SUNAPIL >= '20230101'
           AND T1.SUNAPIL <= '20240509'
           AND T1.GEUMGO_CODE = '130'
           AND T1.HOIGYE_YEAR = '2023'
           AND T1.GEORAE_GUBUN <> 3
           AND T1.GUNGU_CODE = 0
AND DECODE(NVL('4', '99'), '99', 1, T1.JIBGYE_CODE) = DECODE(NVL('4', '99'), '99', 1, '4')
      UNION ALL
      SELECT
           T1.HOIGYE_CODE
          ,0 AS SEIP_SUIP_AMT
          ,0 AS SEIP_BAEJEONG_IP
          ,0 AS SEIB_BANNAP
          ,0 AS SEIB_GYEONGJEONG_IB
          ,0 AS SEIB_GYEONGJEONG_JI
          ,0 AS JAGEUM_BAEJEONG
          ,0 AS JAGEUM_HWANSU
          ,0 AS SECHUL_JIGEUB
          ,0 AS SECHUL_BANHWAN
          ,0 AS SECHUL_GYEONGJEONG_IB
          ,0 AS SECHUL_GYEONGJEONG_JI
          ,0 AS JUN_IIB
          ,0 AS JUN_IWOL
          ,0 AS YAEGEUM_SINGYU
          ,0 AS HWANIP
          ,0 AS SEIP_SUNAP_JIBGYE
          ,DECODE(T1.GUBUN_CODE, 1, T1.AMT1, 0) AS IWOL_SUNAP
          ,DECODE(T1.GUBUN_CODE, 5, T1.AMT1, 0) AS IWOL_MIICHE
          ,DECODE(T1.GUBUN_CODE, 4, T1.AMT1, 0) AS IWOL_MMDA
          ,DECODE(T1.GUBUN_CODE, 2, T1.AMT1, 0) AS IWOL_YAEGEUM
      FROM
           RPT_HOIGYE_IWOL T1
      WHERE 1=1
           AND T1.KIJUNIL >= '20230101'
           AND T1.KIJUNIL <= '20240509'
           AND T1.GEUMGO_CODE = '130'
           AND T1.HOIGYE_YEAR = '2023' - 1
           AND T1.GUBUN_CODE IN (1, 2, 4, 5)
           AND T1.GUNGU_CODE = 0
     AND DECODE(NVL('4', '99'), '99', 1, T1.HOIGYE_CODE) = DECODE(NVL('4', '99'), '99', 1, '4')
      UNION ALL
      SELECT
           TO_NUMBER(T1.SIGUMGO_HOIKYE_C) AS HOIGYE_CODE
          ,0 AS SEIP_SUIP_AMT
          ,0 AS SEIP_BAEJEONG_IP
          ,0 AS SEIB_BANNAP
          ,0 AS SEIB_GYEONGJEONG_IB
          ,0 AS SEIB_GYEONGJEONG_JI
          ,0 AS JAGEUM_BAEJEONG
          ,0 AS JAGEUM_HWANSU
          ,0 AS SECHUL_JIGEUB
          ,0 AS SECHUL_BANHWAN
          ,0 AS SECHUL_GYEONGJEONG_IB
          ,0 AS SECHUL_GYEONGJEONG_JI
          ,0 AS JUN_IIB
          ,0 AS JUN_IWOL
          ,0 AS YAEGEUM_SINGYU
          ,0 AS HWANIP
          ,0 AS SEIP_SUNAP_JIBGYE
          ,0 AS IWOL_SUNAP
          ,0 AS IWOL_MIICHE
          ,0 AS IWOL_MMDA
          ,0 AS IWOL_YAEGEUM
      FROM
           RPT_HOIKYE_CD T1
      WHERE 1=1
           AND T1.SIGUMGO_C = '130'
           AND T1.USE_YN = 'Y'
    AND DECODE(NVL('4', '99'), '99', 1, T1.SIGUMGO_HOIKYE_C) = DECODE(NVL('4', '99'), '99', 1, '4')
     ) T1
    ,RPT_HOIKYE_CD T2
WHERE 1=1
     AND T1.HOIGYE_CODE = T2.SIGUMGO_HOIKYE_C
     AND T2.SIGUMGO_C = '130'
     AND T2.USE_YN = 'Y'
GROUP BY
     T1.HOIGYE_CODE
    ,T2.HOIKYE_NM
ORDER BY
     T1.HOIGYE_CODE
    ,T2.HOIKYE_NM 


---------------------------------------


SELECT LPAD(REF_D_C,4,'0') GUNGU_CODE, REF_D_NM GUNGU_NM, NVL(DATA_ROW,1) AS DATA_ROW,           
       SUM(NVL(AMT1 , 0)) AMT1 , SUM(NVL(AMT2 , 0)) AMT2 , SUM(NVL(AMT3 , 0)) AMT3 , 
       SUM(NVL(AMT4 , 0)) AMT4 , SUM(NVL(AMT5 , 0)) AMT5 , SUM(NVL(AMT6 , 0)) AMT6 , 
       SUM(NVL(AMT7 , 0)) AMT7 , SUM(NVL(AMT8 , 0)) AMT8 , SUM(NVL(AMT9 , 0)) AMT9 , 
       SUM(NVL(AMT10, 0)) AMT10, SUM(NVL(AMT11, 0)) AMT11, SUM(NVL(AMT12, 0)) AMT12, 
       SUM(NVL(AMT13, 0)) AMT13, SUM(NVL(AMT14, 0)) AMT14, SUM(NVL(AMT15, 0)) AMT15, 
       SUM(NVL(AMT16, 0)) AMT16, SUM(NVL(AMT17, 0)) AMT17, SUM(NVL(AMT18, 0)) AMT18, 
       SUM(NVL(AMT19, 0)) AMT19, SUM(NVL(AMT20, 0)) AMT20, SUM(NVL(AMT21, 0)) AMT21, 
       SUM(NVL(AMT22, 0)) AMT22, SUM(NVL(AMT23, 0)) AMT23, SUM(NVL(AMT24, 0)) AMT24, 
       SUM(NVL(AMT25, 0)) AMT25, SUM(NVL(AMT26, 0)) AMT26, SUM(NVL(AMT27, 0)) AMT27, 
       SUM(NVL(AMT28, 0)) AMT28                                                      
  FROM  (                                                                            
       SELECT GUNGU_CODE
               , DATA_ROW
               , AMT1,  AMT2,  AMT3,  AMT4,  AMT5,  AMT6,  AMT7,  AMT8,  AMT9,  AMT10
               , AMT11, AMT12, AMT13, AMT14, AMT15, AMT16, AMT17, AMT18, AMT19, AMT20
               , AMT21, AMT22, AMT23, AMT24, AMT25, AMT26, AMT27, AMT28
       FROM (
         SELECT  CASE WHEN GUNGU_CODE = 0  THEN 7100                                 
                    WHEN GUNGU_CODE = 7000 THEN 7100                                         
                    WHEN GUNGU_CODE < 7000 THEN GUNGU_CODE + 7000                    
                    WHEN GUNGU_CODE > 7000 THEN GUNGU_CODE                           
               END  GUNGU_CODE                                                       
               , DATA_ROW                                                            
               , AMT1,  AMT2,  AMT3,  AMT4,  AMT5,  AMT6,  AMT7,  AMT8,  AMT9,  AMT10
               , AMT11, AMT12, AMT13, AMT14, AMT15, AMT16, AMT17, AMT18, AMT19, AMT20
               , AMT21, AMT22, AMT23, AMT24, AMT25, AMT26, AMT27, AMT28              
         FROM  
           (       
             SELECT 
               ICH_SIGUMGO_GUN_GU_C GUNGU_CODE,
               1 DATA_ROW, 
               SUM(CASE WHEN (SUNAP_DT = '20240508')  THEN NVL(JIBANGSE_AMT,0) ELSE 0 END ) AMT1,
                    SUM(CASE WHEN (SUNAP_DT = '20240508' )  THEN NVL(JIBANGSE_GWAON_AMT,0) ELSE 0 END ) AMT2, 
                    SUM(CASE WHEN (SUNAP_DT = '20240508' )  THEN NVL(JIBANGSE_CRT_AMT,0) ELSE 0 END ) AMT3,
                    SUM(CASE WHEN (SUNAP_DT = '20240508' )  THEN NVL(SEWOI_AMT,0) ELSE 0 END ) AMT4,
                    SUM(CASE WHEN (SUNAP_DT = '20240508' )  THEN NVL(SEWOI_GWAON_AMT,0) ELSE 0 END ) AMT5,
                    SUM(CASE WHEN (SUNAP_DT = '20240508' )  THEN NVL(SEWOI_CRT_AMT,0) ELSE 0 END ) AMT6,
                    SUM(CASE WHEN (SUNAP_DT = '20240508' )  THEN NVL(GYOYUKSE_AMT,0) ELSE 0 END ) AMT7,
                    SUM(CASE WHEN (SUNAP_DT = '20240508' )  THEN NVL(GYOYUKSE_GWAON_AMT,0) ELSE 0 END ) AMT8,
                    SUM(CASE WHEN (SUNAP_DT = '20240508' )  THEN NVL(GYOYUKSE_CRT_AMT,0) ELSE 0 END ) AMT9,
                    SUM(CASE WHEN (SUNAP_DT = '20240508' )  THEN NVL(NONGTEUKSE_AMT,0) ELSE 0 END ) AMT10,
                    SUM(CASE WHEN (SUNAP_DT = '20240508' )  THEN NVL(NONGTEUKSE_GWAON_AMT,0) ELSE 0 END ) AMT11,
                    SUM(CASE WHEN (SUNAP_DT = '20240508' )  THEN NVL(NONGTEUKSE_CRT_AMT,0) ELSE 0 END ) AMT12,
                    SUM(NVL(JIBANGSE_AMT,0) ) AMT13,
                    SUM(NVL(JIBANGSE_GWAON_AMT,0)) AMT14, 
                    SUM(NVL(JIBANGSE_CRT_AMT,0 ) )AMT15,
                    SUM(SEWOI_AMT) AMT16,
                    SUM(SEWOI_GWAON_AMT) AMT17,
                    SUM(SEWOI_CRT_AMT) AMT18,
                    SUM(GYOYUKSE_AMT) AMT19,
                    SUM(GYOYUKSE_GWAON_AMT) AMT20,
                    SUM(GYOYUKSE_CRT_AMT) AMT21,
                    SUM(NONGTEUKSE_AMT) AMT22,
                    SUM(NONGTEUKSE_GWAON_AMT) AMT23,
                    SUM(NONGTEUKSE_CRT_AMT) AMT24,
               SUM(   CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(JIBANGSE_AMT,0) ELSE 0 END    
                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(JIBANGSE_GWAON_AMT,0) *-1 ELSE 0 END   
                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(JIBANGSE_CRT_AMT,0)  ELSE 0 END           
               ) AMT25,
                SUM(  CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(SEWOI_AMT,0) ELSE 0 END    
                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(SEWOI_GWAON_AMT,0) *-1 ELSE 0 END   
                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(SEWOI_CRT_AMT,0)  ELSE 0 END           
                ) AMT26,
                SUM(  CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(GYOYUKSE_AMT,0) ELSE 0 END    
                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(GYOYUKSE_GWAON_AMT,0) *-1 ELSE 0 END   
                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(GYOYUKSE_CRT_AMT,0)  ELSE 0 END           
                ) AMT27,
                SUM(  CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(NONGTEUKSE_AMT,0) ELSE 0 END    
                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(NONGTEUKSE_GWAON_AMT,0) *-1 ELSE 0 END   
                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(NONGTEUKSE_CRT_AMT,0)  ELSE 0 END           
                ) AMT28
             FROM RPT_TXI_DDAC_TAB
             WHERE 1=1
               AND SIGUMGO_ORG_C = 28
               AND SUNAP_DT BETWEEN '20240101' AND '20240508'   
               AND ICH_SIGUMGO_HOIKYE_C in ('22' , '62') 
               AND (
                    (
                        '1' = (CASE WHEN LENGTH(TRIM(NVL('170', ''))) IS NULL THEN '1' ELSE '0' END)
                    ) 
                OR 
                    (
                        '1' = (CASE WHEN ICH_SIGUMGO_GUN_GU_C = '170' THEN '1' ELSE '0' END)
                    ) 
                )
               AND (NEW_GU_YR_G = '1'  OR SIGUMGO_HOIKYE_YR = '9999')  
               GROUP BY ICH_SIGUMGO_GUN_GU_C
             UNION ALL
              SELECT TO_NUMBER(GUNGU_CD) GUNGU_CODE, 1 AS DATA_ROW,
                0 AMT1 , 0 AMT2 , 0 AMT3 ,
                SUM(CASE WHEN SUNP_DT = '20240508' THEN NVL(NAPBU_SIDO_TAX_AMT,0) ELSE 0 END) AMT4 , 0 AMT5 , 0 AMT6 ,
                0 AMT7 , 0 AMT8 , 0 AMT9 ,
                0 AMT10, 0 AMT11, 0 AMT12,
                0 AMT13, 0 AMT14, 0 AMT15,
                SUM(NVL(NAPBU_SIDO_TAX_AMT,0)) AMT16, 0 AMT17, 0 AMT18,
                0 AMT19, 0 AMT20, 0 AMT21,
                0 AMT22, 0 AMT23, 0 AMT24,
                0 AMT25,
                SUM(CASE WHEN (SUNP_DT BETWEEN '202405' || '01' AND '20240508') THEN NVL(NAPBU_SIDO_TAX_AMT,0) ELSE 0 END) AMT26,
                0 AMT27,
                0 AMT28
              FROM
              (
               SELECT SUNP_DT,
                  CASE  WHEN NEW_GU_YR_G = 1 THEN 1 WHEN NEW_GU_YR_G = 2 THEN 9  ELSE  99 END YEAR_GUBUN,
                  HOIKYE_CD, SMOK_CD,
                  CASE WHEN CVT_GUCHUNG_CD = '357' THEN '710'
                                           WHEN CVT_GUCHUNG_CD = '358' THEN '720'
                            ELSE CVT_GUCHUNG_CD END AS GUNGU_CD,
                NAPBU_TCNT, NAPBU_NTAX_AMT, NAPBU_SIDO_TAX_AMT, NAPBU_SIGNGU_TAX_AMT
               FROM NIO_STAX_MASTR_TAB
               WHERE SUNP_DT BETWEEN '2024' || '0101' AND '20240508' AND FORM_G <> '1' AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND SIDO_CD <> '628' AND (SUBSTR(SMOK_CD,1,3)  <> '299' OR   SUBSTR(SMOK_CD,4,3) <> '099')
                 AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358') AND HOIKYE_CD = '51' AND SMOK_CD = '281020'
               UNION
                SELECT A.SUNP_DT SUNP_DT,
                      CASE  WHEN NEW_GU_YR_G = 1 THEN 1  WHEN NEW_GU_YR_G = 2 THEN 9  ELSE  99 END YEAR_GUBUN,
                      A.HOIKYE_CD HOIKYE_CD, A.SMOK_CD SMOK_CD,
                      CASE WHEN CVT_GUCHUNG_CD = '357' THEN '710'
                                          WHEN CVT_GUCHUNG_CD = '358' THEN '720'
                            ELSE CVT_GUCHUNG_CD  END AS GUNGU_CD,
                      A.NAPBU_TCNT NAPBU_TCNT, A.NAPBU_NTAX_AMT NAPBU_NTAX_AMT, A.NAPBU_SIDO_TAX_AMT NAPBU_SIDO_TAX_AMT, A.NAPBU_SIGNGU_TAX_AMT NAPBU_SIGNGU_TAX_AMT
                  FROM NIO_STAX_MASTR_TAB A, NIO_DEPT_INF_TAB B
                  WHERE A.SUNP_DT BETWEEN '2024' || '0101' AND '20240508'  AND FORM_G <> '1' AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND SIDO_CD = '628' AND (SUBSTR(A.SMOK_CD,1,3) <> '299' OR  SUBSTR(A.SMOK_CD,4,3) <> '099')
                  AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358') AND A.HOIKYE_CD = '51' AND A.SMOK_CD = '281020'
                  AND A.SIDO_CD = B.GUCHUNG_CD(+) AND A.DEPT_CD = B.DEPT_CD(+) AND A.HOIKYE_CD = B.HOIKYE_CD(+) AND A.SMOK_CD = B.SMOK_CD(+)
                UNION
                SELECT
                      SUNP_DT,
                      CASE  WHEN NEW_GU_YR_G = 1 THEN 1 WHEN NEW_GU_YR_G = 2 THEN 9  ELSE  99 END YEAR_GUBUN,
                      HOIKYE_CD,
                      SMOK_CD,
                      CASE WHEN CVT_GUCHUNG_CD = '357' THEN '710'
                           WHEN CVT_GUCHUNG_CD = '358' THEN '720'
                           ELSE CVT_GUCHUNG_CD END  AS GUNGU_CD,
                      NAPBU_TCNT,
                      NVL(SUM(국세), 0) AS NAPBU_NTAX_AMT, NVL(SUM(시도세),0) AS NAPBU_SIDO_TAX_AMT, NVL(SUM(시군세),0) AS NAPBU_SIGNGU_TAX_AMT
                FROM
                  (
                     SELECT
                        BLK_NO, PROC_SEQ, SUNP_DT, NEW_GU_YR_G,
                               HOIKYE_CD, SMOK_CD,
                               CVT_GUCHUNG_CD,
                               NAPBU_TCNT,
                      CASE WHEN FILLER2 = '1' THEN NTAX_AMT + SIDO_TAX_AMT + SIGNGU_TAX_AMT - NAPGILT_AMT END AS 국세,
                      CASE WHEN FILLER2 = '2' THEN NTAX_AMT + SIDO_TAX_AMT + SIGNGU_TAX_AMT - NAPGILT_AMT END AS 시도세,
                      CASE WHEN FILLER2 = '3' THEN NTAX_AMT + SIDO_TAX_AMT + SIGNGU_TAX_AMT - NAPGILT_AMT END AS 시군세
                    FROM NIO_STAX_MASTR_TAB
                    WHERE SUNP_DT BETWEEN '2024' || '0101' AND '20240508'  AND FILLER2 > '0' AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND FORM_G <> '1'
                      AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358') AND HOIKYE_CD = '51' AND SMOK_CD = '281020'
                  )
                 GROUP BY SUNP_DT, NEW_GU_YR_G, HOIKYE_CD, SMOK_CD,CVT_GUCHUNG_CD, NAPBU_TCNT
                UNION
                SELECT
                   SUNP_DT,
                    CASE  WHEN NEW_GU_YR_G = 1 THEN 1  WHEN NEW_GU_YR_G = 2 THEN 9
                    ELSE  99 END YEAR_GUBUN,
                    HOIKYE_CD,
                    SMOK_CD,
                    CASE WHEN CVT_GUCHUNG_CD = '357' THEN '710'
                         WHEN CVT_GUCHUNG_CD = '358' THEN '720'
                    ELSE CVT_GUCHUNG_CD END  AS GUNGU_CD,
                    NAPBU_TCNT,
                    NVL(SUM(NAPBU_NTAX_AMT), 0) AS NAPBU_NTAX_AMT, NVL(SUM(NAPBU_SIDO_TAX_AMT), 0) AS NAPBU_SIDO_TAX_AMT, NVL(SUM(NAPBU_SIGNGU_TAX_AMT), 0) AS NAPBU_SIGNGU_TAX_AMT
                FROM
                  (
                    SELECT SUNP_DT, NEW_GU_YR_G, HOIKYE_CD, SMOK_CD,
                      CVT_GUCHUNG_CD, NAPBU_TCNT, NAPBU_NTAX_AMT, NAPBU_SIDO_TAX_AMT, NAPBU_SIGNGU_TAX_AMT
                    FROM  NIO_STAX_MASTR_TAB
                    WHERE SUNP_DT BETWEEN '2024' || '0101' AND '20240508'   
                      AND SUBSTR(SMOK_CD,1,3) = '299' AND SUBSTR(SMOK_CD,4,3)  = '099'  
                      AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND FORM_G <> '1'
                      AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358') 
                      AND HOIKYE_CD = '51' AND SMOK_CD = '281020'
                  )
                GROUP BY SUNP_DT, NEW_GU_YR_G, HOIKYE_CD, SMOK_CD,CVT_GUCHUNG_CD,NAPBU_TCNT
               )
              WHERE 1 = 1
              AND (
                    (
                        '1' = (CASE WHEN LENGTH(TRIM(NVL('170', ''))) IS NULL THEN '1' ELSE '0' END)
                    ) 
                OR 
                    (
                        '1' = (CASE WHEN GUNGU_CD = '170' THEN '1' ELSE '0' END)
                    ) 
                )
              GROUP BY GUNGU_CD
             UNION ALL
             SELECT  9999 ICH_SIGUMGO_GUN_GU_C, 2 DATA_ROW,
               SUM(CASE WHEN  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE BAS_DT END) = '20240508'  THEN  BIZPLC_BAEJUNG_JI_AMT ELSE 0  END) 
                 +SUM(CASE WHEN  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE BAS_DT END) = '20240508'  THEN  BIZPLC_GAM_BAEJUNG_IP_AMT ELSE 0  END) AMT1,  
               SUM(CASE WHEN  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE BAS_DT END) = '20240508' THEN  TAXO_FUND_BAEJUNG_JI_AMT+TAXO_HNDO_BAEJUNG_JI_AMT+TAXO_FUND_GETBK_JI_AMT
                                                                                                                                      +TAXO_HNDO_JICHUL_JI_AMT+TAXO_HNDO_GETBK_JI_AMT ELSE 0 END) AMT2,
               SUM(CASE WHEN  (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE BAS_DT END) = '20240508' THEN  TAXO_RTRN_AMT ELSE 0 END)*-1 AMT3,                                                                                       
               0 AMT4,  0 AMT5,  0 AMT6,  0 AMT7,  0 AMT8,  0 AMT9,  0 AMT10, 0 AMT11, 0 AMT12,                                     
               SUM(CASE WHEN SIGUMGO_AC_B = 10 THEN  BIZPLC_BAEJUNG_JI_AMT ELSE 0 END) 
                 +SUM(BIZPLC_GAM_BAEJUNG_IP_AMT) AMT13,
               SUM(TAXO_FUND_BAEJUNG_JI_AMT+TAXO_HNDO_BAEJUNG_JI_AMT+TAXO_FUND_GETBK_JI_AMT
                                                                  +TAXO_HNDO_JICHUL_JI_AMT+TAXO_HNDO_GETBK_JI_AMT) AMT14,
               SUM(TAXO_RTRN_AMT)*-1 AMT15,
               SUM(CASE WHEN '5' < 3 AND '1' = 1 AND '2024' < 2007 THEN  GA_IWOL_JI_AMT
                                    WHEN '5' < 3 AND '1' = 1 AND '2024' >=2007 THEN  GA_IWOL_JI_AMT-GA_IWOL_IP_AMT
                                    WHEN '5' < 3 AND '1' != 1 AND '2024' < 2007  AND (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END)  > '2024' || '0100' THEN GA_IWOL_JI_AMT
                             WHEN '5' < 3 AND '1' != 1 AND '2024' >=2007 AND (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END)  > '2024' || '0100' THEN GA_IWOL_JI_AMT-GA_IWOL_IP_AMT
                      WHEN '5' >= 3 THEN 0
                 END) AMT16, 
               0 AMT17,    
               SUM(PMNY_JAN_MVO_AMT-PMNY_JAN_MVI_AMT) AMT18,
               0 AMT19, 0 AMT20, 0 AMT21, 0 AMT22, 0 AMT23, 0 AMT24,
               0 AMT25, 0 AMT26, 0 AMT27, 0 AMT28
               FROM  RPT_TXIO_DDAC_TAB A   
               WHERE  1=1
               AND A.SIGUMGO_ORG_C  = 28
               AND (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END) BETWEEN SUBSTR('202401',0,4) || '0101' AND '20240508'
               AND A.ICH_SIGUMGO_HOIKYE_C = '22'   
               AND (
                    (
                        '1' = (CASE WHEN LENGTH(TRIM(NVL('170', ''))) IS NULL THEN '1' ELSE '0' END)
                    ) 
                OR 
                    (
                        '1' = (CASE WHEN ICH_SIGUMGO_GUN_GU_C = '170' THEN '1' ELSE '0' END)
                    ) 
                )
               AND A.SIGUMGO_AC_B IN('10','20')  
             UNION ALL
             SELECT  9999 GUNGU_CODE, 2 DATA_ROW,
                 0 AMT1,  0 AMT2,  0 AMT3,  0 AMT4,  0 AMT5,  0 AMT6,  0 AMT7,  0 AMT8,
                 0 AMT9,  0 AMT10, 0 AMT11, 0 AMT12, 0 AMT13, 0 AMT14, 0 AMT15, 0 AMT16, 
                 SUM(DEP_MK_JI_AMT-DEP_HJI_AMT) AMT17,
                 0 AMT18, 0 AMT19, 0 AMT20, 0 AMT21, 0 AMT22, 0 AMT23, 0 AMT24,
                 0 AMT25, 0 AMT26, 0 AMT27, 0 AMT28
               FROM  RPT_TXIO_DDAC_TAB A
               WHERE  1=1
               AND A.SIGUMGO_ORG_C = 28
               AND A.ICH_SIGUMGO_HOIKYE_C = '22'
               AND (
                    (
                        '1' = (CASE WHEN LENGTH(TRIM(NVL('170', ''))) IS NULL THEN '1' ELSE '0' END)
                    ) 
                OR 
                    (
                        '1' = (CASE WHEN ICH_SIGUMGO_GUN_GU_C = '170' THEN '1' ELSE '0' END)
                    ) 
                )
               AND A.SIGUMGO_AC_B IN('10','20')
             )
            ) 
          ) AA,
      (SELECT REF_D_C, REF_D_NM FROM RPT_CODE_INFO                                                                             
             WHERE REF_L_C=500                                                                                                      
               AND REF_M_C=28                                                                                                       
               AND REF_S_C = 5                                                                                                      
             UNION ALL                                                                                                              
               SELECT 9999 REF_D_C, '합계' REF_D_NM FROM DUAL                                                                       
      ) BB                                                                                                                    
    WHERE AA.GUNGU_CODE(+)   = BB.REF_D_C                                                                                
    GROUP BY REF_D_C, REF_D_NM, DATA_ROW                                                                                        
    ORDER BY GUNGU_CODE

------------------------------------------------------------------------

SELECT 
               ICH_SIGUMGO_GUN_GU_C GUNGU_CODE,
               1 DATA_ROW, 
               SUM(CASE WHEN (SUNAP_DT = '20240508')  THEN NVL(JIBANGSE_AMT,0) ELSE 0 END ) AMT1,
                    SUM(CASE WHEN (SUNAP_DT = '20240508' )  THEN NVL(JIBANGSE_GWAON_AMT,0) ELSE 0 END ) AMT2, 
                    SUM(CASE WHEN (SUNAP_DT = '20240508' )  THEN NVL(JIBANGSE_CRT_AMT,0) ELSE 0 END ) AMT3,
                    SUM(CASE WHEN (SUNAP_DT = '20240508' )  THEN NVL(SEWOI_AMT,0) ELSE 0 END ) AMT4,
                    SUM(CASE WHEN (SUNAP_DT = '20240508' )  THEN NVL(SEWOI_GWAON_AMT,0) ELSE 0 END ) AMT5,
                    SUM(CASE WHEN (SUNAP_DT = '20240508' )  THEN NVL(SEWOI_CRT_AMT,0) ELSE 0 END ) AMT6,
                    SUM(CASE WHEN (SUNAP_DT = '20240508' )  THEN NVL(GYOYUKSE_AMT,0) ELSE 0 END ) AMT7,
                    SUM(CASE WHEN (SUNAP_DT = '20240508' )  THEN NVL(GYOYUKSE_GWAON_AMT,0) ELSE 0 END ) AMT8,
                    SUM(CASE WHEN (SUNAP_DT = '20240508' )  THEN NVL(GYOYUKSE_CRT_AMT,0) ELSE 0 END ) AMT9,
                    SUM(CASE WHEN (SUNAP_DT = '20240508' )  THEN NVL(NONGTEUKSE_AMT,0) ELSE 0 END ) AMT10,
                    SUM(CASE WHEN (SUNAP_DT = '20240508' )  THEN NVL(NONGTEUKSE_GWAON_AMT,0) ELSE 0 END ) AMT11,
                    SUM(CASE WHEN (SUNAP_DT = '20240508' )  THEN NVL(NONGTEUKSE_CRT_AMT,0) ELSE 0 END ) AMT12,
                    SUM(NVL(JIBANGSE_AMT,0) ) AMT13,
                    SUM(NVL(JIBANGSE_GWAON_AMT,0)) AMT14, 
                    SUM(NVL(JIBANGSE_CRT_AMT,0 ) )AMT15,
                    SUM(SEWOI_AMT) AMT16,
                    SUM(SEWOI_GWAON_AMT) AMT17,
                    SUM(SEWOI_CRT_AMT) AMT18,
                    SUM(GYOYUKSE_AMT) AMT19,
                    SUM(GYOYUKSE_GWAON_AMT) AMT20,
                    SUM(GYOYUKSE_CRT_AMT) AMT21,
                    SUM(NONGTEUKSE_AMT) AMT22,
                    SUM(NONGTEUKSE_GWAON_AMT) AMT23,
                    SUM(NONGTEUKSE_CRT_AMT) AMT24,
               SUM(   CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(JIBANGSE_AMT,0) ELSE 0 END    
                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(JIBANGSE_GWAON_AMT,0) *-1 ELSE 0 END   
                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(JIBANGSE_CRT_AMT,0)  ELSE 0 END           
               ) AMT25,
                SUM(  CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(SEWOI_AMT,0) ELSE 0 END    
                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(SEWOI_GWAON_AMT,0) *-1 ELSE 0 END   
                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(SEWOI_CRT_AMT,0)  ELSE 0 END           
                ) AMT26,
                SUM(  CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(GYOYUKSE_AMT,0) ELSE 0 END    
                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(GYOYUKSE_GWAON_AMT,0) *-1 ELSE 0 END   
                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(GYOYUKSE_CRT_AMT,0)  ELSE 0 END           
                ) AMT27,
                SUM(  CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(NONGTEUKSE_AMT,0) ELSE 0 END    
                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(NONGTEUKSE_GWAON_AMT,0) *-1 ELSE 0 END   
                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(NONGTEUKSE_CRT_AMT,0)  ELSE 0 END           
                ) AMT28
             FROM RPT_TXI_DDAC_TAB
             WHERE 1=1
               AND SIGUMGO_ORG_C = 28
               AND SUNAP_DT BETWEEN '20240101' AND '20240508'   
               AND ICH_SIGUMGO_HOIKYE_C in ('22' , '62') 
               AND (
                    (
                        '1' = (CASE WHEN LENGTH(TRIM(NVL('170', ''))) IS NULL THEN '1' ELSE '0' END)
                    ) 
                OR 
                    (
                        '1' = (CASE WHEN ICH_SIGUMGO_GUN_GU_C = '170' THEN '1' ELSE '0' END)
                    ) 
                )
               AND (NEW_GU_YR_G = '1'  OR SIGUMGO_HOIKYE_YR = '9999')  
               GROUP BY ICH_SIGUMGO_GUN_GU_C

-------------------------------------------------------------------------------------

SELECT 
               ICH_SIGUMGO_GUN_GU_C GUNGU_CODE,
               1 DATA_ROW, 
               SUM(CASE WHEN (SUNAP_DT = '20240508')  THEN NVL(JIBANGSE_AMT,0) ELSE 0 END ) AMT1,
                    SUM(CASE WHEN (SUNAP_DT = '20240508' )  THEN NVL(JIBANGSE_GWAON_AMT,0) ELSE 0 END ) AMT2, 
                    SUM(CASE WHEN (SUNAP_DT = '20240508' )  THEN NVL(JIBANGSE_CRT_AMT,0) ELSE 0 END ) AMT3,
                    SUM(CASE WHEN (SUNAP_DT = '20240508' )  THEN NVL(SEWOI_AMT,0) ELSE 0 END ) AMT4,
                    SUM(CASE WHEN (SUNAP_DT = '20240508' )  THEN NVL(SEWOI_GWAON_AMT,0) ELSE 0 END ) AMT5,
                    SUM(CASE WHEN (SUNAP_DT = '20240508' )  THEN NVL(SEWOI_CRT_AMT,0) ELSE 0 END ) AMT6,
                    SUM(CASE WHEN (SUNAP_DT = '20240508' )  THEN NVL(GYOYUKSE_AMT,0) ELSE 0 END ) AMT7,
                    SUM(CASE WHEN (SUNAP_DT = '20240508' )  THEN NVL(GYOYUKSE_GWAON_AMT,0) ELSE 0 END ) AMT8,
                    SUM(CASE WHEN (SUNAP_DT = '20240508' )  THEN NVL(GYOYUKSE_CRT_AMT,0) ELSE 0 END ) AMT9,
                    SUM(CASE WHEN (SUNAP_DT = '20240508' )  THEN NVL(NONGTEUKSE_AMT,0) ELSE 0 END ) AMT10,
                    SUM(CASE WHEN (SUNAP_DT = '20240508' )  THEN NVL(NONGTEUKSE_GWAON_AMT,0) ELSE 0 END ) AMT11,
                    SUM(CASE WHEN (SUNAP_DT = '20240508' )  THEN NVL(NONGTEUKSE_CRT_AMT,0) ELSE 0 END ) AMT12,
                    SUM(NVL(JIBANGSE_AMT,0) ) AMT13,
                    SUM(NVL(JIBANGSE_GWAON_AMT,0)) AMT14, 
                    SUM(NVL(JIBANGSE_CRT_AMT,0 ) )AMT15,
                    SUM(SEWOI_AMT) AMT16,
                    SUM(SEWOI_GWAON_AMT) AMT17,
                    SUM(SEWOI_CRT_AMT) AMT18,
                    SUM(GYOYUKSE_AMT) AMT19,
                    SUM(GYOYUKSE_GWAON_AMT) AMT20,
                    SUM(GYOYUKSE_CRT_AMT) AMT21,
                    SUM(NONGTEUKSE_AMT) AMT22,
                    SUM(NONGTEUKSE_GWAON_AMT) AMT23,
                    SUM(NONGTEUKSE_CRT_AMT) AMT24,
               SUM(   CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(JIBANGSE_AMT,0) ELSE 0 END    
                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(JIBANGSE_GWAON_AMT,0) *-1 ELSE 0 END   
                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(JIBANGSE_CRT_AMT,0)  ELSE 0 END           
               ) AMT25,
                SUM(  CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(SEWOI_AMT,0) ELSE 0 END    
                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(SEWOI_GWAON_AMT,0) *-1 ELSE 0 END   
                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(SEWOI_CRT_AMT,0)  ELSE 0 END           
                ) AMT26,
                SUM(  CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(GYOYUKSE_AMT,0) ELSE 0 END    
                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(GYOYUKSE_GWAON_AMT,0) *-1 ELSE 0 END   
                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(GYOYUKSE_CRT_AMT,0)  ELSE 0 END           
                ) AMT27,
                SUM(  CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(NONGTEUKSE_AMT,0) ELSE 0 END    
                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(NONGTEUKSE_GWAON_AMT,0) *-1 ELSE 0 END   
                   +CASE WHEN (SUNAP_DT BETWEEN SUBSTR('20240508',0,6) || '01' AND '20240508')  THEN NVL(NONGTEUKSE_CRT_AMT,0)  ELSE 0 END           
                ) AMT28
             FROM RPT_TXI_DDAC_TAB
             WHERE 1=1
               AND SIGUMGO_ORG_C = 28
               AND SUNAP_DT BETWEEN '20240101' AND '20240508'   
               AND ICH_SIGUMGO_HOIKYE_C in ('22' , '62') 
               AND (
                    (
                        '1' = (CASE WHEN LENGTH(TRIM(NVL('170', ''))) IS NULL THEN '1' ELSE '0' END)
                    ) 
                OR 
                    (
                        '1' = (CASE WHEN ICH_SIGUMGO_GUN_GU_C = '170' THEN '1' ELSE '0' END)
                    ) 
                )
               AND (NEW_GU_YR_G = '1'  OR SIGUMGO_HOIKYE_YR = '9999')  
               GROUP BY ICH_SIGUMGO_GUN_GU_C

----------------------------------------------------------------------------------

 SELECT
                 DECODE(T1.ICH_SIGUMGO_HOIKYE_C,'62','22',T1.ICH_SIGUMGO_HOIKYE_C) AS HOIGYE_CD    
                , '' AS JIBGYE_CODE           
                ,T1.SIGUMGO_ORG_C

          ,SUM(
                    CASE
                        WHEN '1' = '1' AND T1.SUNAP_DT < TO_CHAR(TRUNC(TO_DATE('20240508', 'YYYYMMDD'), 'MM'), 'YYYYMMDD')
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        WHEN '1' = '2' AND T1.SUNAP_DT < TO_CHAR(TRUNC(TO_DATE('20240508', 'YYYYMMDD'), 'Q'), 'YYYYMMDD')
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        ELSE 0
                    END
                ) AS BEF_AMT
                ,SUM(
                    CASE
                        WHEN '1' = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE('20240508', 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= '20240508'
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT
                        WHEN '1' = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE('20240508', 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= '20240508'
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT
                        ELSE 0
                    END
                ) AS CUR_SUIB
                ,SUM(
                    CASE
                        WHEN '1' = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE('20240508', 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= '20240508'
                        THEN T1.JIBANGSE_GWAON_AMT + T1.SEWOI_GWAON_AMT
                        WHEN '1' = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE('20240508', 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= '20240508'
                        THEN T1.JIBANGSE_GWAON_AMT + T1.SEWOI_GWAON_AMT
                        ELSE 0
                    END
                ) AS CUR_BACK
                ,SUM(
                    CASE
                        WHEN '1' = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE('20240508', 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= '20240508'
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        WHEN '1' = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE('20240508', 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= '20240508'
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        ELSE 0
                    END
                ) AS CUR_AMT
            FROM
                RPT_TXI_DDAC_TAB T1                
            WHERE 1=1                
                AND T1.SIGUMGO_ORG_C = 28
                AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE('20240508', 'YYYYMMDD'), 'YYYY'), 'YYYYMMDD')
                AND T1.SUNAP_DT <= '20240508'

                AND T1.ICH_SIGUMGO_HOIKYE_C IN (22, 62)
                AND T1.SIGUTAX_G = NVL('', '1')


                AND  (  
                        OR (
                           22 = 22 
                           AND 170 NOT IN (0,9999) 
                           AND (
                                CASE WHEN T1.ICH_SIGUMGO_GUN_GU_C = 7100 THEN  0
                                      WHEN T1.ICH_SIGUMGO_GUN_GU_C > 7100 AND T1.ICH_SIGUMGO_GUN_GU_C < 7800 THEN T1.ICH_SIGUMGO_GUN_GU_C - 7000 
                                      ELSE T1.ICH_SIGUMGO_GUN_GU_C END
                                      ) 
                              = DECODE(170, 9999, T1.ICH_SIGUMGO_GUN_GU_C, 170) )
 )

            GROUP BY DECODE(T1.ICH_SIGUMGO_HOIKYE_C,'62','22',T1.ICH_SIGUMGO_HOIKYE_C),T1.SIGUMGO_ORG_C


----------------------------------------------------------------------------



SELECT
          T1.HOIGYE_CD AS HOIGYE_CODE,
          T1.HOIGYE_CD AS JIBGYE_CODE,
          T2.FIL_100_CTNT1 AS HOIGYE_NAME,
          T2.FIL_100_CTNT1 AS JIBGYE_NAME,
          SUM(BEF_AMT) AS BEF_AMT,
          SUM(CUR_SUIB) AS CUR_SUIB,
          SUM(CUR_BACK) AS CUR_BACK,
          0 AS KYONGJENONG,
          SUM(CUR_AMT) AS JAN_AMT,
          SUM(BEF_AMT) + SUM(CUR_AMT) AS NUGYE_AMT
FROM (
            SELECT
                 DECODE(T1.ICH_SIGUMGO_HOIKYE_C,'62','22',T1.ICH_SIGUMGO_HOIKYE_C) AS HOIGYE_CD    
                , '' AS JIBGYE_CODE           
                ,T1.SIGUMGO_ORG_C

          ,SUM(
                    CASE
                        WHEN '1' = '1' AND T1.SUNAP_DT < TO_CHAR(TRUNC(TO_DATE('20240508', 'YYYYMMDD'), 'MM'), 'YYYYMMDD')
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        WHEN '1' = '2' AND T1.SUNAP_DT < TO_CHAR(TRUNC(TO_DATE('20240508', 'YYYYMMDD'), 'Q'), 'YYYYMMDD')
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        ELSE 0
                    END
                ) AS BEF_AMT
                ,SUM(
                    CASE
                        WHEN '1' = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE('20240508', 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= '20240508'
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT
                        WHEN '1' = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE('20240508', 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= '20240508'
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT
                        ELSE 0
                    END
                ) AS CUR_SUIB
                ,SUM(
                    CASE
                        WHEN '1' = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE('20240508', 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= '20240508'
                        THEN T1.JIBANGSE_GWAON_AMT + T1.SEWOI_GWAON_AMT
                        WHEN '1' = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE('20240508', 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= '20240508'
                        THEN T1.JIBANGSE_GWAON_AMT + T1.SEWOI_GWAON_AMT
                        ELSE 0
                    END
                ) AS CUR_BACK
                ,SUM(
                    CASE
                        WHEN '1' = '1' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE('20240508', 'YYYYMMDD'), 'MM'), 'YYYYMMDD') AND T1.SUNAP_DT <= '20240508'
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        WHEN '1' = '2' AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE('20240508', 'YYYYMMDD'), 'Q'), 'YYYYMMDD') AND T1.SUNAP_DT <= '20240508'
                        THEN T1.JIBANGSE_AMT + T1.SEWOI_AMT + T1.JIBANGSE_CRT_AMT + T1.SEWOI_CRT_AMT - T1.JIBANGSE_GWAON_AMT - T1.SEWOI_GWAON_AMT
                        ELSE 0
                    END
                ) AS CUR_AMT
            FROM
                RPT_TXI_DDAC_TAB T1                
            WHERE 1=1                
                AND T1.SIGUMGO_ORG_C = 28
                AND T1.SUNAP_DT >= TO_CHAR(TRUNC(TO_DATE('20240508', 'YYYYMMDD'), 'YYYY'), 'YYYYMMDD')
                AND T1.SUNAP_DT <= '20240508'

                AND T1.ICH_SIGUMGO_HOIKYE_C IN (22, 62)
                AND T1.SIGUTAX_G = NVL('', '1')
                AND  (  ( '1' NOT IN (2,8,9) AND T1.SUNAP_DT BETWEEN SUBSTR('20240508',1,4)||'0100' AND '20240508' )
                     OR ( '1' in (2,9) AND SUBSTR('20240508',5,2) <  3  AND T1.SUNAP_DT BETWEEN (SUBSTR('20240508',1,4) - 1 )||'0301' AND '20240508')
                     OR ( '1' in (2,9) AND SUBSTR('20240508',5,2) >= 3  AND T1.SUNAP_DT BETWEEN SUBSTR('20240508',1,4)||'0101' AND '20240508')
                     OR ( '1' = 8 AND SUBSTR('20240508',5,2) <  3  AND T1.SUNAP_DT BETWEEN (SUBSTR('20240508',1,4) - 1 )||'0101' AND '20240508')
                     OR ( '1' = 8 AND SUBSTR('20240508',5,2) >= 3  AND T1.SUNAP_DT BETWEEN SUBSTR('20240508',1,4)||'0101' AND '20240508'))
                AND  (  ( '22' =  22  AND T1.ICH_SIGUMGO_HOIKYE_C IN (22, 62, 209332) ) OR
                        ( 22 =  213000  AND T1.ICH_SIGUMGO_HOIKYE_C IN (213000, 217100) ) OR
                        ( 22 =  99 )  OR
                        ( 22 NOT IN (22,213000,99) AND T1.ICH_SIGUMGO_HOIKYE_C = 22 ) )
                AND  (  ( 22 = 22 AND 170 = 0 AND T1.ICH_SIGUMGO_GUN_GU_C  IN (7000, 7040, 7810, 7055, 7830, 7840, 7850, 7100, 0) )
                        OR ( 22 IN (21,22,93) AND 170 = 9999 )
                        OR ( 22 = 22 AND 170 NOT IN (0,9999) AND ( CASE WHEN T1.ICH_SIGUMGO_GUN_GU_C = 7100 THEN  0
                                WHEN T1.ICH_SIGUMGO_GUN_GU_C > 7100 AND T1.ICH_SIGUMGO_GUN_GU_C < 7800 THEN T1.ICH_SIGUMGO_GUN_GU_C - 7000 ELSE T1.ICH_SIGUMGO_GUN_GU_C END) = DECODE(170, 9999, T1.ICH_SIGUMGO_GUN_GU_C, 170) )
                        OR (22 IN ( 21,93) AND 170 = 7100 AND T1.ICH_SIGUMGO_GUN_GU_C  IN (0, 7000, 100, 7100) )
                        OR (22 IN ( 21,93) AND 170 <> 7100 AND T1.ICH_SIGUMGO_GUN_GU_C IN (170, SUBSTR(170,2,3)) )
                        OR (22 NOT IN (21,22,93) AND T1.ICH_SIGUMGO_GUN_GU_C  = DECODE(170, 9999, T1.ICH_SIGUMGO_GUN_GU_C, 170) ) )
                AND (  ( '1' = 0 AND SUBSTR('20240508',5,2) < 3  AND T1.SUNAP_DT >= SUBSTR('20240508',1,4)||'0101'   )
                    OR ( '1' = 0 AND SUBSTR('20240508',5,2) >= 3 AND
                         (  ( T1.SUNAP_DT >= SUBSTR('20240508',1,4)||'0101' AND T1.NEW_GU_YR_G= 1)
                         OR ( T1.SUNAP_DT >= SUBSTR('20240508',1,4)||'0301' AND T1.NEW_GU_YR_G <> 1)))
                    OR  ( '1' = 1 AND  T1.SUNAP_DT >= SUBSTR('20240508',1,4)||'0101' AND  (T1.NEW_GU_YR_G = 1 OR T1.SIGUMGO_HOIKYE_YR = 9999 ) )
                    OR  ( '1' in (2,9) AND  SUBSTR('20240508',5,2) < 3  AND T1.SUNAP_DT >= (SUBSTR('20240508',1,4) - 1 )||'0301' AND T1.NEW_GU_YR_G = 9 )
                    OR  ( '1' in (2,9) AND  SUBSTR('20240508',5,2) >= 3 AND  T1.SUNAP_DT >= (SUBSTR('20240508',1,4))||'0301' AND  T1.NEW_GU_YR_G = 9 )
                    OR  ( '1' = 5 AND  SUBSTR('20240508',5,2) < 3  AND T1.SUNAP_DT >= (SUBSTR('20240508',1,4) - 1 )||'0301' AND T1.NEW_GU_YR_G = 5 )
                    OR  ( '1' = 5 AND  SUBSTR('20240508',5,2) >= 3 AND  T1.SUNAP_DT >= (SUBSTR('20240508',1,4))||'0301' AND  T1.NEW_GU_YR_G = 5 )
                    OR  ( '1' = 8 AND  SUBSTR('20240508',5,2) < 3  AND (
                                         (T1.SUNAP_DT BETWEEN (SUBSTR('20240508',1,4) - 1 )||'0001' AND (SUBSTR('20240508',1,4) - 1 )||'1231' AND T1.NEW_GU_YR_G = 1 )
                                      OR (T1.SUNAP_DT >= (SUBSTR('20240508',1,4) - 1 )||'0301' AND T1.NEW_GU_YR_G <> 1)))
                    OR  ( '1' = 8 AND  SUBSTR('20240508',5,2) >= 3 AND  T1.SUNAP_DT >= (SUBSTR('20240508',1,4))||'0301' AND  T1.NEW_GU_YR_G <> 1 ))
            GROUP BY DECODE(T1.ICH_SIGUMGO_HOIKYE_C,'62','22',T1.ICH_SIGUMGO_HOIKYE_C),T1.SIGUMGO_ORG_C
  
            UNION ALL
                SELECT '22' AS HOIGYE_CD, 
                       '22' JIBGYE_CODE, 
                       28 SIGUMGO_ORG_C,

                        SUM(CASE  WHEN '1' = '1' AND SUNAPIL < (SUBSTR('20240508',1,6))||'00' THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN '1' = '2' AND SUBSTR('20240508',5,2) >= 10 AND SUNAPIL < (SUBSTR('20240508',1,4))||'1000'  THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN '1' = '2' AND SUBSTR('20240508',5,2) >= 7  AND SUBSTR('20240508',5,2) < 10 AND SUNAPIL < (SUBSTR('20240508',1,4))||'0700'  THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN '1' = '2' AND SUBSTR('20240508',5,2) >= 4  AND SUBSTR('20240508',5,2) < 7 AND  SUNAPIL < (SUBSTR('20240508',1,4))||'0400'   THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                        ELSE 0 END)  BEF_AMT,
                        SUM(CASE WHEN '1' = '1' AND SUNAPIL BETWEEN (SUBSTR('20240508',1,6))||'01' AND '20240508'  THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN '1' = '2' AND SUBSTR('20240508',5,2) >= 10 AND SUNAPIL BETWEEN (SUBSTR('20240508',1,4))||'1001' AND '20240508' THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN '1' = '2' AND SUBSTR('20240508',5,2) >= 7 AND SUBSTR('20240508',5,2) < 10 AND SUNAPIL BETWEEN (SUBSTR('20240508',1,4))||'0701' AND '20240508' THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN '1' = '2' AND SUBSTR('20240508',5,2) >= 4 AND SUBSTR('20240508',5,2) < 7 AND SUNAPIL BETWEEN (SUBSTR('20240508',1,4))||'0401' AND '20240508'  THEN NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN '1' = '2' AND SUBSTR('20240508',5,2) <  4 AND SUNAPIL <= '20240508'  THEN NVL(NAPBU_SIDO_TAX_AMT,0) ELSE 0 END) CUR_SUIB,
                        0 CUR_BACK,
                        SUM(CASE WHEN '1' = '1' AND SUNAPIL BETWEEN (SUBSTR('20240508',1,6))||'01' AND '20240508' THEN  NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN '1' = '2' AND SUBSTR('20240508',5,2) >= 10 AND SUNAPIL BETWEEN (SUBSTR('20240508',1,4))||'1001' AND '20240508'  THEN  NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN '1' = '2' AND SUBSTR('20240508',5,2) >= 7  AND SUBSTR('20240508',5,2) < 10 AND  SUNAPIL BETWEEN (SUBSTR('20240508',1,4))||'0701' AND '20240508' THEN  NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN '1' = '2' AND SUBSTR('20240508',5,2) >= 4  AND SUBSTR('20240508',5,2) < 7 AND  SUNAPIL BETWEEN (SUBSTR('20240508',1,4))||'0401' AND '20240508' THEN  NVL(NAPBU_SIDO_TAX_AMT,0)
                                            WHEN '1' = '2' AND SUBSTR('20240508',5,2) <  4  AND SUNAPIL <= '20240508'  THEN  NVL(NAPBU_SIDO_TAX_AMT,0)
                        ELSE 0 END) CUR_AMT
                FROM
                (
                    SELECT SUNP_DT AS SUNAPIL,
                        CASE  WHEN NEW_GU_YR_G = 1 THEN 1 WHEN NEW_GU_YR_G = 2 THEN 9  ELSE  99 END YEAR_GUBUN,
                        HOIKYE_CD, SMOK_CD,
                        CASE WHEN CVT_GUCHUNG_CD = '357' THEN 710 WHEN CVT_GUCHUNG_CD = '358' THEN 720 ELSE TO_NUMBER(NVL(CVT_GUCHUNG_CD,0)) END AS GUNGU_CD,
                        NAPBU_TCNT, NAPBU_NTAX_AMT, NAPBU_SIDO_TAX_AMT, NAPBU_SIGNGU_TAX_AMT
                    FROM NIO_STAX_MASTR_TAB
                    WHERE SUNP_DT BETWEEN SUBSTR('20240508',1,4)||'0100' AND '20240508'  AND FORM_G <> '1' AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND SIDO_CD <> '628' AND (SUBSTR(SMOK_CD,1,3)  <> '299' OR   SUBSTR(SMOK_CD,4,3) <> '099')
                    AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358') AND HOIKYE_CD = '51' AND SMOK_CD = '281020'
                    UNION
                    SELECT A.SUNP_DT AS SUNAPIL,
                        CASE  WHEN NEW_GU_YR_G = 1 THEN 1 WHEN NEW_GU_YR_G = 2 THEN 9  ELSE  99 END YEAR_GUBUN,
                                        A.HOIKYE_CD HOIKYE_CD, A.SMOK_CD SMOK_CD,
                        CASE WHEN CVT_GUCHUNG_CD = '357' THEN 710 WHEN CVT_GUCHUNG_CD = '358' THEN 720 ELSE TO_NUMBER(NVL(CVT_GUCHUNG_CD,0))  END AS GUNGU_CD,
                        A.NAPBU_TCNT NAPBU_TCNT, A.NAPBU_NTAX_AMT NAPBU_NTAX_AMT, A.NAPBU_SIDO_TAX_AMT NAPBU_SIDO_TAX_AMT, A.NAPBU_SIGNGU_TAX_AMT NAPBU_SIGNGU_TAX_AMT
                    FROM NIO_STAX_MASTR_TAB A, NIO_DEPT_INF_TAB B
                            WHERE A.SUNP_DT BETWEEN SUBSTR('20240508',1,4)||'0100' AND '20240508'  AND FORM_G <> '1' AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND SIDO_CD = '628' AND (SUBSTR(A.SMOK_CD,1,3) <> '299' OR  SUBSTR(A.SMOK_CD,4,3) <> '099')
                            AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358') AND A.HOIKYE_CD = '51' AND A.SMOK_CD = '281020'
                            AND A.SIDO_CD = B.GUCHUNG_CD(+) AND A.DEPT_CD = B.DEPT_CD(+) AND A.HOIKYE_CD = B.HOIKYE_CD(+) AND A.SMOK_CD = B.SMOK_CD(+)
                            UNION
                            SELECT
                        SUNP_DT AS SUNAPIL,
                        CASE  WHEN NEW_GU_YR_G = 1 THEN 1    WHEN NEW_GU_YR_G = 2 THEN 9 ELSE  99 END YEAR_GUBUN,
                        HOIKYE_CD,
                        SMOK_CD,
                        CASE WHEN CVT_GUCHUNG_CD = '357' THEN 710 WHEN CVT_GUCHUNG_CD = '358' THEN 720 ELSE TO_NUMBER(NVL(CVT_GUCHUNG_CD,0)) END  AS GUNGU_CD,
                        NAPBU_TCNT,
                        NVL(SUM(GUKSAE), 0) AS NAPBU_NTAX_AMT, NVL(SUM(SIDOSAE),0) AS NAPBU_SIDO_TAX_AMT, NVL(SUM(SIGUNSAE),0) AS NAPBU_SIGNGU_TAX_AMT
                            FROM
                    (
                        SELECT
                                        BLK_NO, PROC_SEQ, SUNP_DT, NEW_GU_YR_G,
                                        HOIKYE_CD, SMOK_CD,
                                        CVT_GUCHUNG_CD,
                                        NAPBU_TCNT,
                                        CASE WHEN FILLER2 = '1' THEN NTAX_AMT + SIDO_TAX_AMT + SIGNGU_TAX_AMT - NAPGILT_AMT END AS GUKSAE,
                                        CASE WHEN FILLER2 = '2' THEN NTAX_AMT + SIDO_TAX_AMT + SIGNGU_TAX_AMT - NAPGILT_AMT END AS SIDOSAE,
                                        CASE WHEN FILLER2 = '3' THEN NTAX_AMT + SIDO_TAX_AMT + SIGNGU_TAX_AMT - NAPGILT_AMT END AS SIGUNSAE
                        FROM  NIO_STAX_MASTR_TAB
                        WHERE SUNP_DT BETWEEN SUBSTR('20240508',1,4)||'0100' AND '20240508'  AND FILLER2 > '0' AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND FORM_G <> '1'
                        AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358') AND HOIKYE_CD = '51' AND SMOK_CD = '281020'
                    )
                GROUP BY SUNP_DT, NEW_GU_YR_G, HOIKYE_CD, SMOK_CD,CVT_GUCHUNG_CD, NAPBU_TCNT
                    UNION
                    SELECT
                        SUNP_DT AS SUNAPIL,
                        CASE  WHEN NEW_GU_YR_G = 1 THEN 1  WHEN NEW_GU_YR_G = 2 THEN 9  ELSE  99 END YEAR_GUBUN,
                        HOIKYE_CD,
                        SMOK_CD,
                                        CASE WHEN CVT_GUCHUNG_CD = '357' THEN 710
                                            WHEN CVT_GUCHUNG_CD = '358' THEN 720
                                ELSE TO_NUMBER(NVL(CVT_GUCHUNG_CD,0)) END  AS GUNGU_CD,
                        NAPBU_TCNT,
                        NVL(SUM(NAPBU_NTAX_AMT), 0) AS NAPBU_NTAX_AMT, NVL(SUM(NAPBU_SIDO_TAX_AMT), 0) AS NAPBU_SIDO_TAX_AMT, 
                        NVL(SUM(NAPBU_SIGNGU_TAX_AMT), 0) AS NAPBU_SIGNGU_TAX_AMT
                    FROM
                    (
                        SELECT SUNP_DT, NEW_GU_YR_G,
                                                    HOIKYE_CD, SMOK_CD,
                                                    CVT_GUCHUNG_CD,
                                                    NAPBU_TCNT, NAPBU_NTAX_AMT, NAPBU_SIDO_TAX_AMT, NAPBU_SIGNGU_TAX_AMT
                        FROM NIO_STAX_MASTR_TAB
                        WHERE SUNP_DT BETWEEN SUBSTR('20240508',1,4)||'0100' AND '20240508'  AND SUBSTR(SMOK_CD,1,3) = '299' AND SUBSTR(SMOK_CD,4,3)  = '099'  AND INSIK_G <> 'D' AND INSIK_G <> 'R' AND FORM_G <> '1'
                        AND BLK_NO = '990' AND CVT_GUCHUNG_CD IN ('357','358') AND HOIKYE_CD = '51' AND SMOK_CD = '281020'
                    )
                    GROUP BY SUNP_DT, NEW_GU_YR_G, HOIKYE_CD, SMOK_CD,CVT_GUCHUNG_CD,NAPBU_TCNT
                )
                WHERE 1 = 1
                AND  (GUNGU_CD = 170 OR 9999 = 170 )
                GROUP BY GUNGU_CD

            ) T1, 
            RPT_HOIKYE_CD T2
    WHERE 1=1
    AND T1.HOIGYE_CD = T2.SIGUMGO_HOIKYE_C(+)
    AND T1.SIGUMGO_ORG_C = T2.SIGUMGO_C(+)
    GROUP BY T1.HOIGYE_CD, T1.SIGUMGO_ORG_C, T2.FIL_100_CTNT1


    select * from RPT_SUNAP_JIBGYE where SUNAPIL = '20240430'
    and HOIGYE_YEAR = '2024'
    and GEUMGO_CODE = 28
    and GUNGU_CODE = 0
    and seq_no = 854


    RPT_CORE_20240509
    RPT_CORE_20240510  



    select 
    *
    from 
    RPT_SUNAP_JIBGYE
    where SUNAPIL = '20240430'
    and GEUMGO_CODE = '28'
    and GEORAE_GUBUN = 4
    and GUNGU_CODE = 0
    and JIBGYE_CODE not in (300000, 304000, 3999999)




    select  * from rpt_gonggeum_jan
    where GEUMGO_CODE = '130'


    select * from rpt_unyong_jan
    where GEUMGO_CODE = '130'

    select  count(*) as cnt from rpt_gonggeum_jan
    where GEUMGO_CODE = '130'


    select count(*) as cnt from rpt_unyong_jan
    where GEUMGO_CODE = '130'

    