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
           AND T1.GJDT <= '20231231'
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
           AND T1.SUNAPIL <= '20231231'
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
           AND T1.KIJUNIL <= '20231231'
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
           AND T1.KIJUNIL <= '20231231'
           AND T1.GEUMGO_CODE = '130'
           AND T1.HOIGYE_YEAR = '2023' - 1
           AND T1.GUBUN_CODE IN (1, 2, 4, 5)
           AND T1.GUNGU_CODE = 0
     AND DECODE(NVL('4', '99'), '99', 1, T1.HOIGYE_CODE) = DECODE(NVL('4', '99'), '99', 1, '4')   


            SELECT
          T1.HOIGYE_YEAR
          , T1.HOIGYE_CODE
          ,0 AS SEIP_SUIP_AMT
          ,0 AS SEIP_BAEJEONG_IP
          ,0 AS SEIB_BANNAP
          ,0 AS SEIB
          
          _GYEONGJEONG_IB
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
           AND T1.KIJUNIL <= '20231231'
           AND T1.GEUMGO_CODE = '130'
           AND T1.GUBUN_CODE IN (1, 2, 4, 5)
           AND T1.GUNGU_CODE = 0


select 
*
from 
RPT_HOIGYE_IWOL
where 1=1
and GEUMGO_CODE = '130'
order by HOIGYE_YEAR

select * from ACL_SIGUMGO_SLV
where SIGUMGO_ORG_C = 130
and trxdt = '20230703'


SELECT 
  LIST.RN
 ,LIST.KEORAEIL 
 ,LIST.KIJUNIL
 ,LIST.KISANIL
 ,LIST.GONGGEUM_GYEJWA
 ,LIST.GONGGEUM_GYEJWA_NM
 ,LIST.GUNGU_NM
 ,LIST.JUKYO
 ,LIST.GEORAE_GUBUN
 ,LIST.JIGEUB_AMT
 ,LIST.IPGEUM_AMT
 ,LIST.JAN_AMT
 ,LIST.GEUMGWON_NO
 ,LIST.SUNAP_BR
 ,LIST.IPGEUM_GEORAE
 ,LIST.JIGEUB_GEORAE
 ,LIST.GEORAE_SEQ
 ,LIST.RID
 ,LIST.JIGEUB_ORDER1
 ,LIST.JIGEUB_ORDER2
 ,LIST.JIGUP_NM
  FROM 
      (
SELECT 
    ORG.*, ROWNUM RN      
    FROM  (
    SELECT
         T9.KEORAEIL
        ,T9.KIJUNIL
        ,T9.KISANIL
        ,T9.GONGGEUM_GYEJWA
        ,T9.GONGGEUM_GYEJWA_NM
        ,T9.GUNGU_NM 
        ,T9.JUKYO
        ,T9.GEORAE_GUBUN
        ,T9.JIGEUB_AMT
        ,T9.IPGEUM_AMT
        ,T9.JAN_AMT
        ,T9.GEUMGWON_NO
        ,T9.SUNAP_BR
        ,T9.IPGEUM_GEORAE
        ,T9.JIGEUB_GEORAE
        ,T9.GEORAE_SEQ
        ,T9.RID
        ,T9.JIGEUB_ORDER1
        ,T9.JIGEUB_ORDER2
        ,T9.JIGUP_NM
    FROM
         (
          SELECT
               TO_CHAR(TO_DATE(T4.KEORAEIL,'YYYYMMDD'),'YYYY-MM-DD') AS KEORAEIL
              ,TO_CHAR(TO_DATE(T4.KIJUNIL,'YYYYMMDD'),'YYYY-MM-DD')  AS KIJUNIL
              ,TO_CHAR(TO_DATE(T4.KISANIL,'YYYYMMDD'),'YYYY-MM-DD')  AS KISANIL
              ,REGEXP_REPLACE(T4.GONGGEUM_GYEJWA,  '(.{3})(.{3})(.{2})(.{2})(.{5})(.{2})', '\1-\2-\3-\4-\5-\6') AS GONGGEUM_GYEJWA
              ,T4.GONGGEUM_GYEJWA_NM
              ,T8.CMM_DTL_C_NM AS GUNGU_NM 
              ,T4.JUKYO
              ,T4.GEORAE_GUBUN
              ,T4.JIGEUB_AMT 
              ,T4.IPGEUM_AMT
              ,TRIM(T4.JAN + NVL(T6.BF_DAY_JAN,0)) AS JAN_AMT
              ,T4.GEUMGWON_NO
              ,T4.SUNAP_BR
              ,T4.IPGEUM_GEORAE
              ,T4.JIGEUB_GEORAE
              ,T4.GEORAE_SEQ
              ,T4.RID
              ,T4.JIGEUB_ORDER1
              ,T4.JIGEUB_ORDER2
              ,CASE
                        WHEN SIGN(T4.IPGEUM_GEORAE) > 0 THEN T4.GEORAE_GUBUN||'-'||T4.IPGEUM_GEORAE||' '||T7.CMM_DTL_C_NM
                        WHEN SIGN(T4.JIGEUB_GEORAE) > 0 THEN T4.GEORAE_GUBUN||'-'||T4.JIGEUB_GEORAE||' '||T7.CMM_DTL_C_NM
                 ELSE T4.GEORAE_GUBUN||' '||T7.CMM_DTL_C_NM
                END AS JIGUP_NM
          FROM
               (
                     SELECT
                          T3.TRXDT AS KEORAEIL
                         ,T3.GJDT AS KIJUNIL
                         ,T3.GISDT AS KISANIL
                         ,T2.GONGGEUM_GYEJWA
                         ,T2.GONGGEUM_GYEJWA_NM
                         ,T2.SIGUMGO_ORG_C
                         ,T2.ICH_SIGUMGO_GUN_GU_C
                         ,T3.SIGUMGO_TRX_G AS GEORAE_GUBUN
                         ,T3.SIGUMGO_IP_TRX_G AS IPGEUM_GEORAE
                         ,T3.SIGUMGO_JI_TRX_G AS JIGEUB_GEORAE
                         ,T3.CMMT_CTNT AS JUKYO
                         ,T3.TRXNO AS GEORAE_SEQ
                         ,T3.GDSN_NO AS GEUMGWON_NO
                         ,T3.TRXBRNO AS SUNAP_BR
                         ,0 AS SEQ_NO
                         ,T3.ROWID AS RID
                         ,LPAD(T3.SIGUMGO_TRX_G,2,'0')||LPAD(T3.SIGUMGO_IP_TRX_G,2,'0')||LPAD(T3.SIGUMGO_JI_TRX_G,2,'0') AS KIND_CD
                                ,CASE
                                      WHEN T3.IPJI_G = 1 THEN DECODE(T3.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T3.TRAMT
                                      ELSE 0
                                   END AS IPGEUM_AMT
                                ,CASE
                                      WHEN T3.IPJI_G = 2 THEN DECODE(T3.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T3.TRAMT
                                      ELSE 0
                                   END AS JIGEUB_AMT
                         ,T3.JI_ORDR_DOC_STT_NO AS JIGEUB_ORDER1
                         ,T3.JI_ORDR_DOC_END_NO AS JIGEUB_ORDER2
                        ,CASE
          WHEN '1' = '1'  
       THEN SUM(DECODE(T3.CRT_CAN_G,1,-1,2,-1,33,-1,1) * DECODE(T3.IPJI_G , 2, -1 * T3.TRAMT, T3.TRAMT) ) 
               OVER (PARTITION BY T2.GONGGEUM_GYEJWA ORDER BY T3.TRXDT, T3.TRXNO) 
          WHEN '1' = '2' 
       THEN SUM(DECODE(T3.CRT_CAN_G,1,-1,2,-1,33,-1,1) * DECODE(T3.IPJI_G , 2, -1 * T3.TRAMT, T3.TRAMT) ) 
               OVER (PARTITION BY T2.GONGGEUM_GYEJWA ORDER BY T3.GISDT, T3.TRXDT, T3.TRXNO) 
          ELSE SUM(DECODE(T3.CRT_CAN_G,1,-1,2,-1,33,-1,1) * DECODE(T3.IPJI_G , 2, -1 * T3.TRAMT, T3.TRAMT) ) 
               OVER (PARTITION BY T2.GONGGEUM_GYEJWA ORDER BY T3.GJDT, T3.TRXDT, T3.TRXNO) 
      END AS JAN
                       FROM
                            (
                             SELECT
                                  T1.SIGUMGO_ORG_C
                                 ,T1.ICH_SIGUMGO_GUN_GU_C
                                 ,T1.ICH_SIGUMGO_HOIKYE_C
                                 ,T2.SIGUMGO_HOIKYE_C AS RPT_HOIKYE_C
                                 ,T1.SIGUMGO_AC_B
                                 ,T1.SIGUMGO_AC_SER
                                 ,T1.SIGUMGO_HOIKYE_YR
                                 ,LPAD(T1.SIGUMGO_ORG_C, 3, '0')||LPAD(T1.ICH_SIGUMGO_GUN_GU_C, 3, '0')||LPAD(T1.ICH_SIGUMGO_HOIKYE_C, 2, '0')||LPAD(T1.SIGUMGO_AC_B, 2, '0')||LPAD(T1.SIGUMGO_AC_SER, 5, '0')||SUBSTR(T1.SIGUMGO_HOIKYE_YR, 3, 2)  AS GONGGEUM_GYEJWA
                                 ,T1.SIGUMGO_AC_NM AS GONGGEUM_GYEJWA_NM
                             FROM
                                  ACL_SIGUMGO_MAS T1
                                 ,RPT_AC_BY_HOIKYE_MAPP T2
                             WHERE 1=1
                               AND T1.SIGUMGO_ORG_C = T2.SIGUMGO_C
                               AND T1.ICH_SIGUMGO_HOIKYE_C = TO_NUMBER(SUBSTR(T2.SIGUMGO_ACNO, 7, 2))
                               AND T1.SIGUMGO_AC_B = TO_NUMBER(SUBSTR(T2.SIGUMGO_ACNO, 9, 2))
                               AND T1.SIGUMGO_AC_SER = TO_NUMBER(SUBSTR(T2.SIGUMGO_ACNO, 10, 6))
                               AND T1.SIGUMGO_HOIKYE_YR = T2.SIGUMGO_HOIKYE_YR
                               AND T1.SIGUMGO_ORG_C = '130'
                               AND T1.SIGUMGO_HOIKYE_YR IN ('2023', '9999')
                               AND T1.MNG_NO = '1' 

                
                            ) T2
                           ,ACL_SIGUMGO_SLV T3
                     WHERE 1=1
                       AND T2.SIGUMGO_ORG_C = T3.SIGUMGO_ORG_C(+)
                       AND T2.ICH_SIGUMGO_GUN_GU_C = T3.ICH_SIGUMGO_GUN_GU_C(+)
                       AND T2.ICH_SIGUMGO_HOIKYE_C = T3.ICH_SIGUMGO_HOIKYE_C(+)
                       AND T2.SIGUMGO_AC_B = T3.SIGUMGO_AC_B(+)
                       AND T2.SIGUMGO_AC_SER = T3.SIGUMGO_AC_SER(+)
                       AND T2.SIGUMGO_HOIKYE_YR = T3.SIGUMGO_HOIKYE_YR(+)
                       AND DECODE('1', '1', T3.TRXDT, '2', T3.GISDT, T3.GJDT) >= '20230703' 
                       AND DECODE('1', '1', T3.TRXDT, '2', T3.GISDT, T3.GJDT)  <=   '20230703'
         
               ) T4
              ,(
                SELECT
                     T5.GONGGEUM_GYEJWA
                    ,T5.JANAEK AS BF_DAY_JAN
                FROM
                     RPT_GONGGEUM_JAN T5
                WHERE 1=1
                     AND T5.KEORAEIL = TO_CHAR(TO_DATE('20230703','YYYYMMDD')-1,'YYYYMMDD') 
          
         
              ) T6
              ,SFI_CMM_C_DAT T7
              ,SFI_CMM_C_DAT T8
         WHERE 1=1
              AND T4.GONGGEUM_GYEJWA = T6.GONGGEUM_GYEJWA(+)
              AND T4.KIND_CD = T7.CMM_DTL_C(+)
              AND T7.CMM_C_NM(+) = 'RPT세입세출자금일계표집계용'
              AND T4.ICH_SIGUMGO_GUN_GU_C = T8.CMM_DTL_C(+)
              AND T4.SIGUMGO_ORG_C = T8.HRNK_CMM_DTL_C(+)
              AND T8.CMM_C_NM(+) = 'RPT군구코드'
              ORDER BY DECODE('1', '1', T4.KEORAEIL, '2', T4.KISANIL, T4.KIJUNIL)  ,T4.GEORAE_SEQ 
         ) T9
         
         WHERE 1 = 1
             
         
         
       ) ORG                      
      WHERE ROWNUM  <= '2000'
     ) LIST 
       WHERE RN  >= '0'



                             SELECT
                                  T1.SIGUMGO_ORG_C
                                 ,T1.ICH_SIGUMGO_GUN_GU_C
                                 ,T1.ICH_SIGUMGO_HOIKYE_C
                                 ,T2.SIGUMGO_HOIKYE_C AS RPT_HOIKYE_C
                                 ,T1.SIGUMGO_AC_B
                                 ,T1.SIGUMGO_AC_SER
                                 ,T1.SIGUMGO_HOIKYE_YR
                                 ,LPAD(T1.SIGUMGO_ORG_C, 3, '0')||LPAD(T1.ICH_SIGUMGO_GUN_GU_C, 3, '0')||LPAD(T1.ICH_SIGUMGO_HOIKYE_C, 2, '0')||LPAD(T1.SIGUMGO_AC_B, 2, '0')||LPAD(T1.SIGUMGO_AC_SER, 5, '0')||SUBSTR(T1.SIGUMGO_HOIKYE_YR, 3, 2)  AS GONGGEUM_GYEJWA
                                 ,T1.SIGUMGO_AC_NM AS GONGGEUM_GYEJWA_NM
                             FROM
                                  ACL_SIGUMGO_MAS T1
                                 ,RPT_AC_BY_HOIKYE_MAPP T2
                             WHERE 1=1
                               AND T1.SIGUMGO_ORG_C = T2.SIGUMGO_C
                               AND T1.ICH_SIGUMGO_HOIKYE_C = TO_NUMBER(SUBSTR(T2.SIGUMGO_ACNO, 7, 2))
                               AND T1.SIGUMGO_AC_B = TO_NUMBER(SUBSTR(T2.SIGUMGO_ACNO, 9, 2))
                               AND T1.SIGUMGO_AC_SER = TO_NUMBER(SUBSTR(T2.SIGUMGO_ACNO, 10, 6))
                               AND T1.SIGUMGO_HOIKYE_YR = T2.SIGUMGO_HOIKYE_YR
                               AND T1.SIGUMGO_ORG_C = '130'
                               AND T1.SIGUMGO_HOIKYE_YR IN ('2023', '9999')
                               AND T1.MNG_NO = '1'


                               select * from RPT_AC_BY_HOIKYE_MAPP
                               where 1=1
                               and sigumgo_c = 130




                               select SIGUMGO_ACNO from RPT_AC_BY_HOIKYE_MAPP
                               where 1=1
                               GROUP by SIGUMGO_ACNO having count(SIGUMGO_ACNO) > 1
                               order by SIGUMGO_ACNO                              

SELECT 
      Z.ROW_NUM,
      Z.SIGUMGO_ORG_C,
      Z.ICH_SIGUMGO_GUN_GU_C,
      Z.ICH_SIGUMGO_HOIKYE_C,
      Z.SIGUMGO_HOIKYE_C,
      Z.SIGUMGO_AC_B,
      Z.SIGUMGO_AC_SER,
      Z.SIGUMGO_HOIKYE_YR,
      Z.GONGGEUM_GYEJWA,
      Z.GONGGEUM_YUDONG_ACNO,
      Z.AC_GRBRNO,
      Z.HNG_BR_NM,
      Z.SIGUMGO_AC_NM,
      Z.UPD_DTTM,
      Z.MODR_ID

FROM
      (
        SELECT 
              ROW_NUMBER() OVER(ORDER BY X.GONGGEUM_GYEJWA) AS ROW_NUM,
              X.SIGUMGO_ORG_C,
              X.ICH_SIGUMGO_GUN_GU_C,
              X.ICH_SIGUMGO_HOIKYE_C,
              Y.SIGUMGO_HOIKYE_C,
              X.SIGUMGO_AC_B,
              X.SIGUMGO_AC_SER,
              X.SIGUMGO_HOIKYE_YR,
              X.GONGGEUM_GYEJWA,
              X.GONGGEUM_YUDONG_ACNO,
              X.AC_GRBRNO,
              X.HNG_BR_NM,
              X.SIGUMGO_AC_NM,
              Y.UPD_DTTM,
              Y.MODR_ID
        FROM
              (
                SELECT  
                      A.SIGUMGO_ORG_C,
                      A.ICH_SIGUMGO_GUN_GU_C,
                      A.ICH_SIGUMGO_HOIKYE_C,
                      A.SIGUMGO_AC_B,
                      A.SIGUMGO_AC_SER,
                      A.SIGUMGO_HOIKYE_YR,
                      LPAD(A.SIGUMGO_ORG_C, 3, '0')||
                      LPAD(A.ICH_SIGUMGO_GUN_GU_C, 3, '0')||
                      LPAD(A.ICH_SIGUMGO_HOIKYE_C, 2, '0')||
                      LPAD(A.SIGUMGO_AC_B, 2, '0')||
                      LPAD(A.SIGUMGO_AC_SER, 5, '0')||
                      SUBSTR(A.SIGUMGO_HOIKYE_YR, 3, 2) AS GONGGEUM_GYEJWA,
                      A.LINKAC_KWA_C ||'000'||A.LINK_ACSER AS GONGGEUM_YUDONG_ACNO,
                      A.AC_GRBRNO,
                      B.HNG_BR_NM,
                      A.SIGUMGO_AC_NM,
                      A.UPD_DTTM,
                      A.MODR_ID
                FROM 
                      ACL_SIGUMGO_MAS A
                      LEFT OUTER JOIN CST_JUM B
                        ON A.AC_GRBRNO = B.BRNO
                        AND B.GRPCO_C = 'S001'
                WHERE
                      A.SIGUMGO_ORG_C = 130
                      AND A.SIGUMGO_HOIKYE_YR IN ('2024','9999')
                      AND A.MNG_NO = '1'
                      AND (-1 = -1 OR A.ICH_SIGUMGO_GUN_GU_C = -1)
                      AND (-1 = -1 OR A.SIGUMGO_AC_B = -1)
                      AND (-1 = -1 OR A.AC_GRBRNO = -1)
                      AND (-1 = 80 OR A.ICH_SIGUMGO_HOIKYE_C = 80)
              ) X
              LEFT OUTER JOIN RPT_AC_BY_HOIKYE_MAPP Y
                  ON X.SIGUMGO_ORG_C = Y.SIGUMGO_C 
                  AND X.SIGUMGO_HOIKYE_YR = Y.SIGUMGO_HOIKYE_YR
                  AND X.GONGGEUM_GYEJWA = Y.SIGUMGO_ACNO
             WHERE 1 = 1
                   AND (-1 = -1 OR Y.SIGUMGO_HOIKYE_C = -1)
      ) Z
WHERE
      Z.ROW_NUM >= 0
      AND Z.ROW_NUM <= 100                               


select 
*
from RPT_AC_BY_HOIKYE_MAPP
where
SIGUMGO_HOIKYE_C = 80 
AND SIGUMGO_ACNO IN (
     '13000080900000499',
'13000080900000599',
'13000080900001099',
'13000080900001199',
'13000080900001299'
)      


DELETE
from RPT_AC_BY_HOIKYE_MAPP
where
SIGUMGO_HOIKYE_C = 80 
AND SIGUMGO_ACNO IN (
     '13000080900000499',
'13000080900000599',
'13000080900001099',
'13000080900001199',
'13000080900001299'
)      

SELECT * FROM ACL_SIGUMGO_MAS
WHERE 1=1
AND FIL_100_CTNT2 = '02818501250005724'

SELECT RNUM
     , SGG_ACNO
     , SGG_ACNO_NM
     , SIDO_C
     , CT_GU_C
     , SL_GMGO_HOIKYE_C
     , DTL_HOIKYE_C
     , DTL_HOIKYE_C_NM
     , SITAX_GUTAX_G
     , SITAX_GUTAX_G_NM
     , SIGUMGO_AC_G
     , HOIKYE_YEAR
     , GIGUM_YN
     , USE_G
     , ORG_C
     , ORG_C_NM
     , SL_GMGO_DEPT_C
     , SL_GMGO_DEPT_NM
     , SL_GMGO_DEPT_C AS ORG_SL_GMGO_DEPT_C
     , GUCHUNG_BIZPLC_C
     , GIGUM_USER_IDS
     , GIGUM_USER_NMS
     , BIGO
     , MG_DT
     , TOT_CNT
FROM
(
    WITH AC_BY_DEPT AS
    (
        SELECT DISTINCT ADM.SGG_ACNO, ADM.SITAX_GUTAX_G, HCD.SIGUMGO_HOIKYE_C, HCD.HOIKYE_NM
        FROM RPT_JEONJA_AC_BY_DEPT_MNG ADM
        INNER JOIN RPT_HOIKYE_CD HCD
                ON ADM.SL_GMGO_HOIKYE_C = HCD.SIGUMGO_HOIKYE_C
               AND ADM.GEUMGO_CODE = HCD.SIGUMGO_C
        WHERE ('all' = 'all' OR ADM.SITAX_GUTAX_G = 'all')
     
          AND ADM.SGG_ACNO ='02818501250005724'
    )
    SELECT ADM.RNUM
         , ADM.SGG_ACNO
         , ADM.SIGUMGO_AC_NM AS SGG_ACNO_NM
         , ADM.SIDO_C
         , LPAD(ADM.SIGUMGO_GUN_GU_C,3,'0') AS CT_GU_C
         , LPAD(ADM.SIGUMGO_HOIKYE_C,2,'0') AS SL_GMGO_HOIKYE_C
         , '' AS DTL_HOIKYE_C
         , ADM.HOIKYE_NM AS DTL_HOIKYE_C_NM
         , ADM.SITAX_GUTAX_G
         , NVL((SELECT CMM_DTL_C_NM FROM SFI_CMM_C_DAT WHERE CMM_C_NM='시세구세구분' AND CMM_DTL_C = ADM.SITAX_GUTAX_G),'기타') AS SITAX_GUTAX_G_NM
         , ADM.SIGUMGO_AC_G
         , ADM.SIGUMGO_HOIKYE_YR AS HOIKYE_YEAR
         , DECODE(ADM.OCR_HOIKYE_G, '4', 'Y', 'N') AS GIGUM_YN
         , ADM.USE_G
         , ADM.PADM_STD_ORG_C AS ORG_C
         , ADM.PADM_STD_ORGNM AS ORG_C_NM
         , ADM.SL_GMGO_DEPT_C AS SL_GMGO_DEPT_C
         , CASE WHEN ADM.SL_GMGO_DEPT_C = ADM.PADM_STD_ORG_C THEN ADM.PADM_STD_ORGNM
                ELSE TRIM(REPLACE(POI.ALL_ORGNM, OPOI.ALL_ORGNM, ''))
                END AS SL_GMGO_DEPT_NM
         , ADM.GUCHUNG_BIZPLC_C
         , '' AS GIGUM_USER_IDS
         , '' AS GIGUM_USER_NMS
         , ADM.BIGO
         , POI.MG_DT
         , ADM.TOT_CNT
    FROM
    (
        SELECT A.*
        FROM
        (
            SELECT ROWNUM AS RNUM
                 , A.*
            FROM
            (
                SELECT ADM.SGG_ACNO
                     , SGM.SIGUMGO_AC_NM
                     , ADM.SIDO_C
                     , SGM.SIGUMGO_GUN_GU_C
                     , SGM.SIGUMGO_HOIKYE_C
                     , ABD.HOIKYE_NM
                     , '' AS SIGUMGO_HOIKYE_NO
                     , SGM.SIGUMGO_AC_G
                     , SGM.SIGUMGO_HOIKYE_YR
                     , ABD.SITAX_GUTAX_G
                     , '' AS OCR_HOIKYE_G
                     , ADM.USE_G
                     , OCM.PADM_STD_ORG_C
                     , OCM.PADM_STD_ORGNM
                     , ADM.SL_GMGO_DEPT_C
                     , ADM.GUCHUNG_BIZPLC_C
                     , ADM.BIGO
                     , COUNT(1) OVER () AS TOT_CNT
                FROM RPT_JEONJA_AC_BY_DEPT_MNG ADM
                INNER JOIN AC_BY_DEPT ABD
                        ON ADM.SGG_ACNO = ABD.SGG_ACNO
                INNER JOIN ACL_SIGUMGO_MAS_SUB SGM
                        ON SGM.SIGUMGO_ORG_C = '28'
                       AND ADM.SGG_ACNO = SGM.SIGUMGO_ACNO
                LEFT OUTER JOIN SFI_ORG_BY_DEPT_MNG OBD
                        ON ADM.SL_GMGO_DEPT_C = OBD.G_CC_DEPT_C
                LEFT OUTER JOIN SFI_ORG_DEPT_C_MNG OCM
                        ON OBD.PADM_STD_ORG_C = OCM.PADM_STD_ORG_C
                WHERE (-1 = -1 OR SGM.SIGUMGO_AC_B = -1)
                  AND ('' IS NULL OR REGEXP_LIKE(SGM.SIGUMGO_ACNO, ''))
                  AND ('' IS NULL OR REGEXP_LIKE(SGM.SIGUMGO_AC_NM, ''))
                ORDER BY ADM.SGG_ACNO, OCM.CT_GU_C, ADM.SL_GMGO_DEPT_C
            ) A
            WHERE ROWNUM <= '2000'
        ) A
        WHERE RNUM >= '1'
    ) ADM
    LEFT OUTER JOIN SFI_PADM_ORG_INF OPOI
            ON ADM.PADM_STD_ORG_C = OPOI.PADM_STD_ORG_C
    LEFT OUTER JOIN SFI_PADM_ORG_INF POI
            ON ADM.SL_GMGO_DEPT_C = POI.PADM_STD_ORG_C
)
ORDER BY RNUM




        SELECT DISTINCT ADM.SGG_ACNO, ADM.SITAX_GUTAX_G, HCD.SIGUMGO_HOIKYE_C, HCD.HOIKYE_NM
        FROM RPT_JEONJA_AC_BY_DEPT_MNG ADM
        INNER JOIN RPT_HOIKYE_CD HCD
                ON ADM.SL_GMGO_HOIKYE_C = HCD.SIGUMGO_HOIKYE_C
               AND ADM.GEUMGO_CODE = HCD.SIGUMGO_C
        WHERE ('all' = 'all' OR ADM.SITAX_GUTAX_G = 'all')
     
          AND ADM.SGG_ACNO ='02818501250005724'


          SELECT * FROM RPT_JEONJA_AC_BY_DEPT_MNG
          WHERE SGG_ACNO ='02818501250005724'

          SELECT  * FROM RPT_HOIKYE_CD


          
        SELECT DISTINCT ADM.SGG_ACNO, ADM.SITAX_GUTAX_G, HCD.SIGUMGO_HOIKYE_C, HCD.HOIKYE_NM
        FROM RPT_JEONJA_AC_BY_DEPT_MNG ADM
        INNER JOIN RPT_HOIKYE_CD HCD
                ON  ADM.GEUMGO_CODE = HCD.SIGUMGO_C
        WHERE ('all' = 'all' OR ADM.SITAX_GUTAX_G = 'all')
     
          AND ADM.SGG_ACNO ='02818501250005724'

      
        SELECT DISTINCT ADM.SGG_ACNO, ADM.SITAX_GUTAX_G, HCD.SIGUMGO_HOIKYE_C, HCD.HOIKYE_NM
        FROM RPT_JEONJA_AC_BY_DEPT_MNG ADM
        INNER JOIN RPT_HOIKYE_CD HCD
                ON ADM.SL_GMGO_HOIKYE_C = HCD.SIGUMGO_HOIKYE_C
               AND ADM.GEUMGO_CODE = HCD.SIGUMGO_C
        WHERE ('all' = 'all' OR ADM.SITAX_GUTAX_G = 'all')
     
          AND ADM.SGG_ACNO ='02818501250005724'



 SELECT RNUM
     , SGG_ACNO
     , SGG_ACNO_NM
     , SIDO_C
     , CT_GU_C
     , SL_GMGO_HOIKYE_C
     , DTL_HOIKYE_C
     , DTL_HOIKYE_C_NM
     , SITAX_GUTAX_G
     , SITAX_GUTAX_G_NM
     , SIGUMGO_AC_G
     , HOIKYE_YEAR
     , GIGUM_YN
     , USE_G
     , ORG_C
     , ORG_C_NM
     , SL_GMGO_DEPT_C
     , SL_GMGO_DEPT_NM
     , SL_GMGO_DEPT_C AS ORG_SL_GMGO_DEPT_C
     , GUCHUNG_BIZPLC_C
     , GIGUM_USER_IDS
     , GIGUM_USER_NMS
     , BIGO
     , MG_DT
     , TOT_CNT
FROM
(
    WITH AC_BY_DEPT AS
    (
        SELECT DISTINCT ADM.SGG_ACNO, ADM.SITAX_GUTAX_G, HCD.SIGUMGO_HOIKYE_C, HCD.HOIKYE_NM
        FROM RPT_JEONJA_AC_BY_DEPT_MNG ADM
        INNER JOIN RPT_HOIKYE_CD HCD
                ON ADM.SL_GMGO_HOIKYE_C = HCD.SIGUMGO_HOIKYE_C
               AND ADM.GEUMGO_CODE = HCD.SIGUMGO_C
        WHERE ('all' = 'all' OR ADM.SITAX_GUTAX_G = 'all')
          AND ('all' = '1' OR ADM.USE_G = '1')
          AND (ADM.HOIKYE_YEAR = '2024' OR ADM.HOIKYE_YEAR = '9999')
          AND ADM.SL_GMGO_DEPT_C = '9999999'
    )
    SELECT ADM.RNUM
         , ADM.SGG_ACNO
         , ADM.SIGUMGO_AC_NM AS SGG_ACNO_NM
         , ADM.SIDO_C
         , LPAD(ADM.SIGUMGO_GUN_GU_C,3,'0') AS CT_GU_C
         , LPAD(ADM.SIGUMGO_HOIKYE_C,2,'0') AS SL_GMGO_HOIKYE_C
         , '' AS DTL_HOIKYE_C
         , ADM.HOIKYE_NM AS DTL_HOIKYE_C_NM
         , ADM.SITAX_GUTAX_G
         , NVL((SELECT CMM_DTL_C_NM FROM SFI_CMM_C_DAT WHERE CMM_C_NM='시세구세구분' AND CMM_DTL_C = ADM.SITAX_GUTAX_G),'기타') AS SITAX_GUTAX_G_NM
         , ADM.SIGUMGO_AC_G
         , ADM.SIGUMGO_HOIKYE_YR AS HOIKYE_YEAR
         , DECODE(ADM.OCR_HOIKYE_G, '4', 'Y', 'N') AS GIGUM_YN
         , ADM.USE_G
         , ADM.PADM_STD_ORG_C AS ORG_C
         , ADM.PADM_STD_ORGNM AS ORG_C_NM
         , ADM.SL_GMGO_DEPT_C AS SL_GMGO_DEPT_C
         , CASE WHEN ADM.SL_GMGO_DEPT_C = ADM.PADM_STD_ORG_C THEN ADM.PADM_STD_ORGNM
                ELSE TRIM(REPLACE(POI.ALL_ORGNM, OPOI.ALL_ORGNM, ''))
                END AS SL_GMGO_DEPT_NM
         , ADM.GUCHUNG_BIZPLC_C
         , '' AS GIGUM_USER_IDS
         , '' AS GIGUM_USER_NMS
         , ADM.BIGO
         , POI.MG_DT
         , ADM.TOT_CNT
    FROM
    (
        SELECT A.*
        FROM
        (
            SELECT ROWNUM AS RNUM
                 , A.*
            FROM
            (
                SELECT ADM.SGG_ACNO
                     , SGM.SIGUMGO_AC_NM
                     , ADM.SIDO_C
                     , SGM.SIGUMGO_GUN_GU_C
                     , SGM.SIGUMGO_HOIKYE_C
                     , ABD.HOIKYE_NM
                     , '' AS SIGUMGO_HOIKYE_NO
                     , SGM.SIGUMGO_AC_G
                     , SGM.SIGUMGO_HOIKYE_YR
                     , ABD.SITAX_GUTAX_G
                     , '' AS OCR_HOIKYE_G
                     , ADM.USE_G
                     , OCM.PADM_STD_ORG_C
                     , OCM.PADM_STD_ORGNM
                     , ADM.SL_GMGO_DEPT_C
                     , ADM.GUCHUNG_BIZPLC_C
                     , ADM.BIGO
                     , COUNT(1) OVER () AS TOT_CNT
                FROM RPT_JEONJA_AC_BY_DEPT_MNG ADM
                INNER JOIN AC_BY_DEPT ABD
                        ON ADM.SGG_ACNO = ABD.SGG_ACNO
                INNER JOIN ACL_SIGUMGO_MAS_SUB SGM
                        ON SGM.SIGUMGO_ORG_C = '28'
                       AND ADM.SGG_ACNO = SGM.SIGUMGO_ACNO
                LEFT OUTER JOIN SFI_ORG_BY_DEPT_MNG OBD
                        ON ADM.SL_GMGO_DEPT_C = OBD.G_CC_DEPT_C
                LEFT OUTER JOIN SFI_ORG_DEPT_C_MNG OCM
                        ON OBD.PADM_STD_ORG_C = OCM.PADM_STD_ORG_C
                WHERE (-1 = -1 OR SGM.SIGUMGO_AC_B = -1)
                  AND ('' IS NULL OR REGEXP_LIKE(SGM.SIGUMGO_ACNO, ''))
                  AND ('' IS NULL OR REGEXP_LIKE(SGM.SIGUMGO_AC_NM, ''))
                ORDER BY ADM.SGG_ACNO, OCM.CT_GU_C, ADM.SL_GMGO_DEPT_C
            ) A
            WHERE ROWNUM <= '2000'
        ) A
        WHERE RNUM >= '1'
    ) ADM
    LEFT OUTER JOIN SFI_PADM_ORG_INF OPOI
            ON ADM.PADM_STD_ORG_C = OPOI.PADM_STD_ORG_C
    LEFT OUTER JOIN SFI_PADM_ORG_INF POI
            ON ADM.SL_GMGO_DEPT_C = POI.PADM_STD_ORG_C
)
ORDER BY RNUM             


        SELECT DISTINCT ADM.SGG_ACNO, ADM.SITAX_GUTAX_G, HCD.SIGUMGO_HOIKYE_C, HCD.HOIKYE_NM
        FROM RPT_JEONJA_AC_BY_DEPT_MNG ADM
        INNER JOIN RPT_HOIKYE_CD HCD
                ON TO_NUMBER(ADM.SL_GMGO_HOIKYE_C) = HCD.SIGUMGO_HOIKYE_C
               AND ADM.GEUMGO_CODE = HCD.SIGUMGO_C
        WHERE ('all' = 'all' OR ADM.SITAX_GUTAX_G = 'all')
          AND ('all' = '1' OR ADM.USE_G = '1')
          AND (ADM.HOIKYE_YEAR = '2024' OR ADM.HOIKYE_YEAR = '9999')
          AND ADM.SL_GMGO_DEPT_C = '9999999'
          AND ADM.SGG_ACNO ='02818501250005724'


 
SELECT RNUM
     , SGG_ACNO
     , SGG_ACNO_NM
     , SIDO_C
     , CT_GU_C
     , SL_GMGO_HOIKYE_C
     , DTL_HOIKYE_C
     , DTL_HOIKYE_C_NM
     , SITAX_GUTAX_G
     , SITAX_GUTAX_G_NM
     , SIGUMGO_AC_G
     , HOIKYE_YEAR
     , GIGUM_YN
     , USE_G
     , ORG_C
     , ORG_C_NM
     , SL_GMGO_DEPT_C
     , SL_GMGO_DEPT_NM
     , SL_GMGO_DEPT_C AS ORG_SL_GMGO_DEPT_C 
     , GUCHUNG_BIZPLC_C
     , '' AS GIGUM_USER_IDS
     , '' AS GIGUM_USER_NMS
     , BIGO
     , MG_DT
     , TOT_CNT
FROM
(
    WITH AC_BY_DEPT AS
    (
        SELECT DISTINCT ADM.SGG_ACNO, ADM.USE_G, ADM.SITAX_GUTAX_G
        FROM SFI_ORG_DEPT_C_MNG OCM
        INNER JOIN SFI_ORG_BY_DEPT_MNG OBD
                ON OCM.PADM_STD_ORG_C = OBD.PADM_STD_ORG_C
        INNER JOIN RPT_JEONJA_AC_BY_DEPT_MNG ADM
                ON OBD.G_CC_DEPT_C = ADM.SL_GMGO_DEPT_C
               AND ADM.HOIKYE_YEAR IN ('2024', DECODE('2024', TO_CHAR(SYSDATE, 'YYYY'), '9999', ''))
        INNER JOIN SFI_PADM_ORG_INF POI
                ON OBD.G_CC_DEPT_C = POI.PADM_STD_ORG_C      
        WHERE ('all' = NVL('', 'all') OR OCM.REP_ORG_C = '')
          AND ('all' = NVL('', 'all') OR OCM.PADM_STD_ORG_C = '')
          AND ('all' = NVL('', 'all') OR OBD.G_CC_DEPT_C = '')
          AND ('all' = NVL('all', 'all') OR ADM.SITAX_GUTAX_G = 'all')
          AND ('all' = NVL('1', 'all') OR ADM.USE_G = '1')
          AND ('all' = NVL('all', 'all') OR POI.MG_DT >= 0 )        
    )
    SELECT ADM.RNUM
         , ADM.SGG_ACNO
         , ADM.SIGUMGO_AC_NM AS SGG_ACNO_NM
         , ADM.SIDO_C
         , LPAD(ADM.SIGUMGO_GUN_GU_C,3,'0') AS CT_GU_C
         , LPAD(ADM.SIGUMGO_HOIKYE_C,2,'0') AS SL_GMGO_HOIKYE_C
         , ADM.SIGUMGO_HOIKYE_NO AS DTL_HOIKYE_C
         , NVL( (SELECT CMM_DTL_C_NM FROM SFI_CMM_C_DAT A WHERE A.CMM_C_NM = '보고서구청별회계명' AND A.CMM_DTL_C = ADM.PADM_STD_ORG_C||ADM.SIGUMGO_HOIKYE_NO AND A.USE_YN = 'Y')
               ,(SELECT CMM_DTL_C_NM FROM SFI_CMM_C_DAT B WHERE B.CMM_C_NM = '상세회계번호'     AND B.CMM_DTL_C = ADM.SIGUMGO_HOIKYE_NO AND B.USE_YN = 'Y')) AS DTL_HOIKYE_C_NM
         , ADM.SITAX_GUTAX_G
         , NVL((SELECT CMM_DTL_C_NM FROM SFI_CMM_C_DAT WHERE CMM_C_NM='시세구세구분' AND CMM_DTL_C = ADM.SITAX_GUTAX_G),'기타') AS SITAX_GUTAX_G_NM
         , ADM.SIGUMGO_AC_G
         , ADM.SIGUMGO_HOIKYE_YR AS HOIKYE_YEAR   
         , DECODE(ADM.OCR_HOIKYE_G, '4', 'Y', 'N') AS GIGUM_YN
         , ADM.USE_G
         , ADM.PADM_STD_ORG_C AS ORG_C
         , ADM.PADM_STD_ORGNM AS ORG_C_NM
         , ADM.SL_GMGO_DEPT_C AS SL_GMGO_DEPT_C
         , CASE WHEN ADM.SL_GMGO_DEPT_C = ADM.PADM_STD_ORG_C THEN ADM.PADM_STD_ORGNM
                ELSE TRIM(REPLACE(POI.ALL_ORGNM, OPOI.ALL_ORGNM, ''))
                END AS SL_GMGO_DEPT_NM
         , ADM.GUCHUNG_BIZPLC_C
         , ADM.BIGO
         , POI.MG_DT
         , ADM.TOT_CNT
    FROM
    (
        SELECT A.*
        FROM
        (
            SELECT ROWNUM AS RNUM
                 , A.*
            FROM
            (
                SELECT ADM.SGG_ACNO
                     , SGM.SIGUMGO_AC_NM
                     , ADM.SIDO_C
                     , SGM.SIGUMGO_GUN_GU_C
                     , SGM.SIGUMGO_HOIKYE_C
                     , '' AS SIGUMGO_HOIKYE_NO
                     , SGM.SIGUMGO_AC_G
                     , SGM.SIGUMGO_HOIKYE_YR
                     , ABD.SITAX_GUTAX_G
                     , '' AS OCR_HOIKYE_G
                     , ADM.USE_G
                     , OCM.PADM_STD_ORG_C
                     , OCM.PADM_STD_ORGNM
                     , ADM.SL_GMGO_DEPT_C
                     , ADM.GUCHUNG_BIZPLC_C
                     , ADM.BIGO
                     , COUNT(1) OVER () AS TOT_CNT
                FROM RPT_JEONJA_AC_BY_DEPT_MNG ADM
                INNER JOIN AC_BY_DEPT ABD
                        ON ADM.SGG_ACNO = ABD.SGG_ACNO
                INNER JOIN ACL_SIGUMGO_MAS_SUB SGM
                        ON SGM.SIGUMGO_ORG_C = 28
                       AND ADM.SGG_ACNO = SGM.SIGUMGO_ACNO
                LEFT OUTER JOIN SFI_ORG_BY_DEPT_MNG OBD
                        ON ADM.SL_GMGO_DEPT_C = OBD.G_CC_DEPT_C
                LEFT OUTER JOIN SFI_ORG_DEPT_C_MNG OCM
                        ON OBD.PADM_STD_ORG_C = OCM.PADM_STD_ORG_C
                WHERE (-1 = -1 OR SGM.SIGUMGO_AC_B = -1)
                  AND (-1 = -1 OR SGM.SIGUMGO_AGE_AC_G = -1)
                  AND ('02811001240000024' IS NULL OR REGEXP_LIKE(SGM.SIGUMGO_ACNO, '02811001240000024'))
                  AND ('' IS NULL OR REGEXP_LIKE(SGM.SIGUMGO_AC_NM, ''))
                ORDER BY ADM.SGG_ACNO, OCM.CT_GU_C, ADM.SL_GMGO_DEPT_C
            ) A
            WHERE ROWNUM <= 2000
        ) A
        WHERE RNUM >= 1
    ) ADM
    LEFT OUTER JOIN SFI_PADM_ORG_INF OPOI
            ON ADM.PADM_STD_ORG_C = OPOI.PADM_STD_ORG_C
    LEFT OUTER JOIN SFI_PADM_ORG_INF POI
            ON ADM.SL_GMGO_DEPT_C = POI.PADM_STD_ORG_C
)
ORDER BY RNUM         


-- 3520205

select * from RPT_JEONJA_AC_BY_DEPT_MNG
where SL_GMGO_HOIKYE_C = '01'
and SL_GMGO_DEPT_C = '9999999'


update RPT_JEONJA_AC_BY_DEPT_MNG
set SL_GMGO_HOIKYE_C = 1
where SL_GMGO_HOIKYE_C = '01'
and SL_GMGO_DEPT_C = '9999999'


SELECT RNUM
     , SGG_ACNO
     , SGG_ACNO_NM
     , SIDO_C
     , CT_GU_C
     , SL_GMGO_HOIKYE_C
     , DTL_HOIKYE_C
     , DTL_HOIKYE_C_NM
     , SITAX_GUTAX_G
     , SITAX_GUTAX_G_NM
     , SIGUMGO_AC_G
     , HOIKYE_YEAR
     , GIGUM_YN
     , USE_G
     , ORG_C
     , ORG_C_NM
     , SL_GMGO_DEPT_C
     , SL_GMGO_DEPT_NM
     , SL_GMGO_DEPT_C AS ORG_SL_GMGO_DEPT_C
     , GUCHUNG_BIZPLC_C
     , GIGUM_USER_IDS
     , GIGUM_USER_NMS
     , BIGO
     , MG_DT
     , TOT_CNT
FROM
(
    WITH AC_BY_DEPT AS
    (
        SELECT DISTINCT ADM.SGG_ACNO, ADM.SITAX_GUTAX_G, HCD.SIGUMGO_HOIKYE_C, HCD.HOIKYE_NM
        FROM RPT_JEONJA_AC_BY_DEPT_MNG ADM
        INNER JOIN RPT_HOIKYE_CD HCD
                ON ADM.SL_GMGO_HOIKYE_C = HCD.SIGUMGO_HOIKYE_C
               AND ADM.GEUMGO_CODE = HCD.SIGUMGO_C
        WHERE ('all' = 'all' OR ADM.SITAX_GUTAX_G = 'all')
          AND ('all' = '1' OR ADM.USE_G = '1')
          AND (ADM.HOIKYE_YEAR = '2024' OR ADM.HOIKYE_YEAR = '9999')
          AND ADM.SL_GMGO_DEPT_C = '9999999'
    )
    SELECT ADM.RNUM
         , ADM.SGG_ACNO
         , ADM.SIGUMGO_AC_NM AS SGG_ACNO_NM
         , ADM.SIDO_C
         , LPAD(ADM.SIGUMGO_GUN_GU_C,3,'0') AS CT_GU_C
         , LPAD(ADM.SIGUMGO_HOIKYE_C,2,'0') AS SL_GMGO_HOIKYE_C
         , '' AS DTL_HOIKYE_C
         , ADM.HOIKYE_NM AS DTL_HOIKYE_C_NM
         , ADM.SITAX_GUTAX_G
         , NVL((SELECT CMM_DTL_C_NM FROM SFI_CMM_C_DAT WHERE CMM_C_NM='시세구세구분' AND CMM_DTL_C = ADM.SITAX_GUTAX_G),'기타') AS SITAX_GUTAX_G_NM
         , ADM.SIGUMGO_AC_G
         , ADM.SIGUMGO_HOIKYE_YR AS HOIKYE_YEAR
         , DECODE(ADM.OCR_HOIKYE_G, '4', 'Y', 'N') AS GIGUM_YN
         , ADM.USE_G
         , ADM.PADM_STD_ORG_C AS ORG_C
         , ADM.PADM_STD_ORGNM AS ORG_C_NM
         , ADM.SL_GMGO_DEPT_C AS SL_GMGO_DEPT_C
         , CASE WHEN ADM.SL_GMGO_DEPT_C = ADM.PADM_STD_ORG_C THEN ADM.PADM_STD_ORGNM
                ELSE TRIM(REPLACE(POI.ALL_ORGNM, OPOI.ALL_ORGNM, ''))
                END AS SL_GMGO_DEPT_NM
         , ADM.GUCHUNG_BIZPLC_C
         , '' AS GIGUM_USER_IDS
         , '' AS GIGUM_USER_NMS
         , ADM.BIGO
         , POI.MG_DT
         , ADM.TOT_CNT
    FROM
    (
        SELECT A.*
        FROM
        (
            SELECT ROWNUM AS RNUM
                 , A.*
            FROM
            (
                SELECT ADM.SGG_ACNO
                     , SGM.SIGUMGO_AC_NM
                     , ADM.SIDO_C
                     , SGM.SIGUMGO_GUN_GU_C
                     , SGM.SIGUMGO_HOIKYE_C
                     , ABD.HOIKYE_NM
                     , '' AS SIGUMGO_HOIKYE_NO
                     , SGM.SIGUMGO_AC_G
                     , SGM.SIGUMGO_HOIKYE_YR
                     , ABD.SITAX_GUTAX_G
                     , '' AS OCR_HOIKYE_G
                     , ADM.USE_G
                     , OCM.PADM_STD_ORG_C
                     , OCM.PADM_STD_ORGNM
                     , ADM.SL_GMGO_DEPT_C
                     , ADM.GUCHUNG_BIZPLC_C
                     , ADM.BIGO
                     , COUNT(1) OVER () AS TOT_CNT
                FROM RPT_JEONJA_AC_BY_DEPT_MNG ADM
                INNER JOIN AC_BY_DEPT ABD
                        ON ADM.SGG_ACNO = ABD.SGG_ACNO
                INNER JOIN ACL_SIGUMGO_MAS_SUB SGM
                        ON SGM.SIGUMGO_ORG_C = '28'
                       AND ADM.SGG_ACNO = SGM.SIGUMGO_ACNO
                LEFT OUTER JOIN SFI_ORG_BY_DEPT_MNG OBD
                        ON ADM.SL_GMGO_DEPT_C = OBD.G_CC_DEPT_C
                LEFT OUTER JOIN SFI_ORG_DEPT_C_MNG OCM
                        ON OBD.PADM_STD_ORG_C = OCM.PADM_STD_ORG_C
                WHERE (-1 = -1 OR SGM.SIGUMGO_AC_B = -1)
                  AND ('' IS NULL OR REGEXP_LIKE(SGM.SIGUMGO_ACNO, ''))
                  AND ('' IS NULL OR REGEXP_LIKE(SGM.SIGUMGO_AC_NM, ''))
                ORDER BY ADM.SGG_ACNO, OCM.CT_GU_C, ADM.SL_GMGO_DEPT_C
            ) A
            WHERE ROWNUM <= '2000'
        ) A
        WHERE RNUM >= '1'
    ) ADM
    LEFT OUTER JOIN SFI_PADM_ORG_INF OPOI
            ON ADM.PADM_STD_ORG_C = OPOI.PADM_STD_ORG_C
    LEFT OUTER JOIN SFI_PADM_ORG_INF POI
            ON ADM.SL_GMGO_DEPT_C = POI.PADM_STD_ORG_C
)
ORDER BY RNUM



select * from ACL_SIGUMGO_SLV
where SIGUMGO_ORG_C = 28
and ICH_SIGUMGO_GUN_GU_C = 110
and trxdt = '20240307'
and tramt = 2790176000


select * from ACL_SIGUMGO_SLV
where SIGUMGO_ORG_C = 28
and ICH_SIGUMGO_GUN_GU_C = 110
and trxdt = '20240307'
and tramt = 2790176000
and sigumgo_trx_g4 = 10

select * from RPT_SUNAP_JIBGYE
where SUNAPIL = '20240307'
and KEORAEIL = '20240308'
and GUNGU_CODE = 110