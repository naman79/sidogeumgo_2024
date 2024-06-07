SELECT
     SUM(T1.SEIP_GYEJWA_JAN) AS SEIPGYEJWA_JANAEG
    ,SUM(T1.BAEJUNG_GYEJWA_JAN) AS BAEJEONGGYEJWA_JANAEG
    ,SUM(T1.JATA_BNK_SUNAB_ICHE_AMT) AS JATASUNAB_ICHEAEG
    ,SUM(T1.JOJEONG_IPGEUM_AMT) AS JOJEONG_IBGEUMAEG
    ,SUM(T1.CARD_AMT) AS CARD_GEUMAEG
    ,SUM(T1.ARS_CARD_AMT) AS ARSCARD_GEUMAEG
    ,SUM(T1.ARS_CARD_SEWOI_AMT) AS ARSCARD_SEWOI_GEUMAEG
    ,SUM(T1.ARS_CARD_HAND_PHONE_AMT) AS ARSHP_GEUMAEG
    ,SUM(T1.JOJEONG_JIGEUB_AMT) AS JOJEONGJI_GEUMAEG
    ,(
        SUM(T1.SEIP_GYEJWA_JAN) + SUM(T1.BAEJUNG_GYEJWA_JAN) +SUM(T1.JATA_BNK_SUNAB_ICHE_AMT)
      + SUM(T1.JOJEONG_IPGEUM_AMT) - SUM(T1.JOJEONG_JIGEUB_AMT)
     ) AS JEONGSANPYO_JANAEG
FROM
     (
      SELECT
           SUM(DECODE(T1.SIGUMGO_AC_B, 10, NVL(T2.JANAEK, 0), 0)) AS SEIP_GYEJWA_JAN
          ,SUM(DECODE(T1.SIGUMGO_AC_B, 20, NVL(T2.JANAEK, 0), 0)) AS BAEJUNG_GYEJWA_JAN
          ,0 AS JATA_BNK_SUNAB_ICHE_AMT
          ,0 AS JOJEONG_IPGEUM_AMT
          ,0 AS CARD_AMT
          ,0 AS ARS_CARD_AMT
          ,0 AS ARS_CARD_SEWOI_AMT
          ,0 AS ARS_CARD_HAND_PHONE_AMT
          ,0 AS JOJEONG_JIGEUB_AMT
      FROM
           ACL_SIGUMGO_MAS T1
          ,RPT_GONGGEUM_JAN T2
      WHERE 1=1
           AND T1.FIL_100_CTNT2 = T2.GONGGEUM_GYEJWA
           AND T1.SIGUMGO_ORG_C = T2.GEUMGO_CODE
           AND T1.ICH_SIGUMGO_GUN_GU_C = T2.GUNGU_CODE
           AND T1.SIGUMGO_ORG_C = '28'
           AND DECODE(NVL('0', '9999'), '9999', 1, DECODE(T1.ICH_SIGUMGO_GUN_GU_C, '0', 1, 0)) = 1
           AND T1.ICH_SIGUMGO_HOIKYE_C = '01'
           AND T1.SIGUMGO_AC_B IN (10,20)
           AND (
                CASE
                    WHEN '0' = 1 THEN DECODE(T1.SIGUMGO_HOIKYE_YR, '9999', 1, SUBSTR('20240329', 1, 4), 1, 0)
                    WHEN '0' IN (8, 9) THEN DECODE(T1.SIGUMGO_HOIKYE_YR, SUBSTR('20240329', 1, 4) - 1, 1, 0)
                    WHEN '0' = 0 THEN DECODE(T1.SIGUMGO_HOIKYE_YR, '9999', 1, SUBSTR('20240329', 1, 4), 1, SUBSTR('20240329', 1, 4) - 1, 1, 0)
                    ELSE 0
                 END
               ) = 1
           AND T1.MNG_NO = 1
           AND T2.KEORAEIL = '20240329'
      UNION ALL
      SELECT
           0 AS SEIP_GYEJWA_JAN
          ,0 AS BAEJUNG_GYEJWA_JAN
          ,SUM(NVL(T1.IPGEUM_AMT, 0)) AS JATA_BNK_SUNAB_ICHE_AMT
          ,0 AS JOJEONG_IPGEUM_AMT
          ,0 AS CARD_AMT
          ,0 AS ARS_CARD_AMT
          ,0 AS ARS_CARD_SEWOI_AMT
          ,0 AS ARS_CARD_HAND_PHONE_AMT
          ,0 AS JOJEONG_JIGEUB_AMT
      FROM
           (
            SELECT
                 T2.TRXDT AS KEORAEIL
                ,T2.GJDT AS KIJUNIL
                ,T2.GISDT AS KISANIL
                ,T2.TRXNO AS GEORAE_SEQ
                ,T2.CRT_CAN_G AS JEONGJEONG
                ,DECODE(T2.IPJI_G, 1, DECODE(T2.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T2.TRAMT, 0) AS IPGEUM_AMT
                ,DECODE(T2.IPJI_G, 1, 0, DECODE(T2.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T2.TRAMT) AS JIGEUB_AMT
                ,T2.CMMT_CTNT AS JUKYO
                ,T2.SIGUMGO_TRX_G AS GEORAE_GUBUN
                ,T2.SIGUMGO_IP_TRX_G AS IPGEUM_GEORAE
                ,T2.SIGUMGO_TAX_IP_MNG_NO AS HANDO_GYEJWA
            FROM
                 ACL_SIGUMGO_MAS T1
                ,ACL_SIGUMGO_SLV T2
            WHERE 1=1
                 AND T1.FIL_100_CTNT2 = T2.FIL_100_CTNT5
                 AND T1.SIGUMGO_ORG_C = '28'
                 AND DECODE(NVL('0', '9999'), '9999', 1, DECODE(T1.ICH_SIGUMGO_GUN_GU_C, '0', 1, 0)) = 1
                 AND T1.ICH_SIGUMGO_HOIKYE_C = '01'
                 AND T1.SIGUMGO_AC_B IN (10,20)
                 AND (
                      CASE
                          WHEN '0' = 1 THEN DECODE(T1.SIGUMGO_HOIKYE_YR, '9999', 1, SUBSTR('20240329', 1, 4), 1, 0)
                          WHEN '0' IN (8, 9) THEN DECODE(T1.SIGUMGO_HOIKYE_YR, SUBSTR('20240329', 1, 4) - 1, 1, 0)
                          WHEN '0' = 0 THEN DECODE(T1.SIGUMGO_HOIKYE_YR, '9999', 1, SUBSTR('20240329', 1, 4), 1, SUBSTR('20240329', 1, 4) - 1, 1, 0)
                          ELSE 0
                       END
                     ) = 1
                 AND T1.MNG_NO = 1
                 AND T2.TRXDT > '20240329'
                 AND T2.GJDT IN (
                                 SELECT
                                      T1.BIZ_DT
                                 FROM
                                      (
                                       SELECT
                                            T1.BIZ_DT                          
                                       FROM
                                            MAP_JOB_DATE T1
                                       WHERE 1=1
                                            AND T1.BIZ_DT <= '20240329'
                                            AND T1.DT_G = 0
                                       ORDER BY
                                            T1.BIZ_DT DESC
                                      ) T1
                                 WHERE 1=1
                                      AND ROWNUM < 7
                                )
                 AND T2.SIGUMGO_TRX_G = 11
                 AND T2.IMMD_PROC_DSYN <> 1
            UNION ALL
            SELECT
                 T2.TRXDT AS KEORAEIL
                ,T2.GJDT AS KIJUNIL
                ,T2.GISDT AS KISANIL
                ,T2.TRXNO AS GEORAE_SEQ
                ,T2.CRT_CAN_G AS JEONGJEONG
                ,DECODE(T2.IPJI_G, 1, DECODE(T2.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T2.TRAMT, 0) AS IPGEUM_AMT
                ,DECODE(T2.IPJI_G, 1, 0, DECODE(T2.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T2.TRAMT) AS JIGEUB_AMT
                ,NULL AS JUKYO
                ,T2.SIGUMGO_TRX_G AS GEORAE_GUBUN
                ,0 AS IPGEUM_GEORAE
                ,NULL AS HANDO_GYEJWA
            FROM
                 ACL_SIGUMGO_MAS T1
                ,ACL_SGGHANDO_SLV T2
            WHERE 1=1
                 AND T1.FIL_100_CTNT2 = T2.SIGUMGO_ACNO
                 AND T1.SIGUMGO_ORG_C = '28'
                 AND DECODE(NVL('0', '9999'), '9999', 1, DECODE(T1.ICH_SIGUMGO_GUN_GU_C, '0', 1, 0)) = 1
                 AND T1.ICH_SIGUMGO_HOIKYE_C = '01'
                 AND T1.SIGUMGO_AC_B IN (10,20)
                 AND (
                      CASE
                          WHEN '0' = 1 THEN DECODE(T1.SIGUMGO_HOIKYE_YR, '9999', 1, SUBSTR('20240329', 1, 4), 1, 0)
                          WHEN '0' IN (8, 9) THEN DECODE(T1.SIGUMGO_HOIKYE_YR, SUBSTR('20240329', 1, 4) - 1, 1, 0)
                          WHEN '0' = 0 THEN DECODE(T1.SIGUMGO_HOIKYE_YR, '9999', 1, SUBSTR('20240329', 1, 4), 1, SUBSTR('20240329', 1, 4) - 1, 1, 0)
                          ELSE 0
                       END
                     ) = 1
                 AND T1.MNG_NO = 1
                 AND T2.TRXDT > '20240329'
                 AND T2.GJDT IN (
                                 SELECT
                                      T1.BIZ_DT
                                 FROM
                                      (
                                       SELECT
                                            T1.BIZ_DT                          
                                       FROM
                                            MAP_JOB_DATE T1
                                       WHERE 1=1
                                            AND T1.BIZ_DT <= '20240329'
                                            AND T1.DT_G = 0
                                       ORDER BY
                                            T1.BIZ_DT DESC
                                      ) T1
                                 WHERE 1=1
                                      AND ROWNUM < 7
                                )
                 AND T2.SIGUMGO_TRX_G = 11
           ) T1
      UNION ALL
      SELECT
           0 AS SEIP_GYEJWA_JAN
          ,0 AS BAEJUNG_GYEJWA_JAN
          ,0 AS JATA_BNK_SUNAB_ICHE_AMT
          ,SUM(DECODE(T1.GEORAE_GUBUN, 13, T1.IPGEUM_AMT, 0)) AS JOJEONG_IPGEUM_AMT
          ,0 AS CARD_AMT
          ,0 AS ARS_CARD_AMT
          ,0 AS ARS_CARD_SEWOI_AMT
          ,0 AS ARS_CARD_HAND_PHONE_AMT
          ,SUM(
               CASE
                   WHEN T1.GEORAE_GUBUN IN (63, 64) THEN T1.JIGEUB_AMT
                   ELSE 0
                END
           ) AS JOJEONG_JIGEUB_AMT
      FROM
           (
            SELECT
                 T2.TRXDT AS KEORAEIL
                ,T2.GJDT AS KIJUNIL
                ,T2.GISDT AS KISANIL
                ,T2.TRXNO AS GEORAE_SEQ
                ,T2.CRT_CAN_G AS JEONGJEONG
                ,DECODE(T2.IPJI_G, 1, DECODE(T2.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T2.TRAMT, 0) AS IPGEUM_AMT
                ,DECODE(T2.IPJI_G, 1, 0, DECODE(T2.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T2.TRAMT) AS JIGEUB_AMT
                ,T2.CMMT_CTNT AS JUKYO
                ,T2.SIGUMGO_TRX_G AS GEORAE_GUBUN
                ,T2.SIGUMGO_TRX_G||LPAD(T2.SIGUMGO_IP_TRX_G, 2, 0)||LPAD(T2.SIGUMGO_JI_TRX_G, 2, 0) AS GEORAE_CODE
                ,T2.SIGUMGO_IP_TRX_G AS IPGEUM_GEORAE
                ,T2.SIGUMGO_TAX_IP_MNG_NO AS HANDO_GYEJWA
            FROM
                 ACL_SIGUMGO_MAS T1
                ,ACL_SIGUMGO_SLV T2
            WHERE 1=1
                 AND T1.FIL_100_CTNT2 = T2.FIL_100_CTNT5
                 AND T1.SIGUMGO_ORG_C = '28'
                 AND DECODE(NVL('0', '9999'), '9999', 1, DECODE(T1.ICH_SIGUMGO_GUN_GU_C, '0', 1, 0)) = 1
                 AND T1.ICH_SIGUMGO_HOIKYE_C = '01'
                 AND T1.SIGUMGO_AC_B = 10
                 AND (
                      CASE
                          WHEN '0' = 1 THEN DECODE(T1.SIGUMGO_HOIKYE_YR, '9999', 1, SUBSTR('20240329', 1, 4), 1, 0)
                          WHEN '0' IN (8, 9) THEN DECODE(T1.SIGUMGO_HOIKYE_YR, SUBSTR('20240329', 1, 4) - 1, 1, 0)
                          WHEN '0' = 0 THEN DECODE(T1.SIGUMGO_HOIKYE_YR, '9999', 1, SUBSTR('20240329', 1, 4), 1, SUBSTR('20240329', 1, 4) - 1, 1, 0)
                          ELSE 0
                       END
                     ) = 1
                 AND T1.MNG_NO = 1
                 AND T2.GISDT > '20240329'
                 AND T2.GJDT <= '20240329'
                 AND T2.SIGUMGO_TRX_G IN (13,63,64)
            UNION ALL
            SELECT
                 T2.TRXDT AS KEORAEIL
                ,T2.GJDT AS KIJUNIL
                ,T2.GISDT AS KISANIL
                ,T2.TRXNO AS GEORAE_SEQ
                ,T2.CRT_CAN_G AS JEONGJEONG
                ,DECODE(T2.IPJI_G, 1, DECODE(T2.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T2.TRAMT, 0) AS IPGEUM_AMT
                ,DECODE(T2.IPJI_G, 1, 0, DECODE(T2.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T2.TRAMT) AS JIGEUB_AMT
                ,NULL AS JUKYO
                ,T2.SIGUMGO_TRX_G AS GEORAE_GUBUN
                ,T2.SIGUMGO_TRX_G||'00' AS GEORAE_CODE
                ,0 AS IPGEUM_GEORAE
                ,NULL AS HANDO_GYEJWA
            FROM
                 ACL_SIGUMGO_MAS T1
                ,ACL_SGGHANDO_SLV T2
            WHERE 1=1
                 AND T1.FIL_100_CTNT2 = T2.SIGUMGO_ACNO
                 AND T1.SIGUMGO_ORG_C = '28'
                 AND DECODE(NVL('0', '9999'), '9999', 1, DECODE(T1.ICH_SIGUMGO_GUN_GU_C, '0', 1, 0)) = 1
                 AND T1.ICH_SIGUMGO_HOIKYE_C = '01'
                 AND T1.SIGUMGO_AC_B = 10
                 AND (
                      CASE
                          WHEN '0' = 1 THEN DECODE(T1.SIGUMGO_HOIKYE_YR, '9999', 1, SUBSTR('20240329', 1, 4), 1, 0)
                          WHEN '0' IN (8, 9) THEN DECODE(T1.SIGUMGO_HOIKYE_YR, SUBSTR('20240329', 1, 4) - 1, 1, 0)
                          WHEN '0' = 0 THEN DECODE(T1.SIGUMGO_HOIKYE_YR, '9999', 1, SUBSTR('20240329', 1, 4), 1, SUBSTR('20240329', 1, 4) - 1, 1, 0)
                          ELSE 0
                       END
                     ) = 1
                 AND T1.MNG_NO = 1
                 AND T2.GISDT > '20240329'
                 AND T2.GJDT <= '20240329'
                 AND T2.SIGUMGO_TRX_G IN (13,63,64)
           ) T1
      UNION ALL
      SELECT
           0 AS SEIP_GYEJWA_JAN
          ,0 AS BAEJUNG_GYEJWA_JAN
          ,0 AS JATA_BNK_SUNAB_ICHE_AMT
          ,0 AS JOJEONG_IPGEUM_AMT
          ,SUM(NVL(T1.BONSE_AMT, 0) + NVL(T1.GYOYUKSE_AMT, 0) + NVL(T1.NONGTEUKSE_AMT, 0) + NVL(T1.SEWOI_AMT, 0)) AS CARD_AMT
          ,0 AS ARS_CARD_AMT
          ,0 AS ARS_CARD_SEWOI_AMT
          ,0 AS ARS_CARD_HAND_PHONE_AMT
          ,0 AS JOJEONG_JIGEUB_AMT
      FROM
           RPT_SUNAP_JIBGYE T1
      WHERE 1=1
           AND NVL('0', 0) = 0
           AND T1.GEUMGO_CODE = '28'
           AND T1.SUNAPIL >= SUBSTR('20240329', 1, 6)||'01'
           AND T1.SUNAPIL <= '20240329'
           AND T1.BANK_GUBUN IN (94,95,96,97,98,44,381,361,364,365,366,367,368,369,370,371,372,373,374,389,390,391,392,393)
           AND '0' IN (1, 0)
           AND '01' = 1
      UNION ALL
      SELECT
           0 AS SEIP_GYEJWA_JAN
          ,0 AS BAEJUNG_GYEJWA_JAN
          ,0 AS JATA_BNK_SUNAB_ICHE_AMT
          ,0 AS JOJEONG_IPGEUM_AMT
          ,0 AS CARD_AMT
          ,CASE
               WHEN T1.BANK_GUBUN = 99 AND T1.MNGBR <> 9878
               THEN NVL(T1.BONSE_AMT, 0) + NVL(T1.GYOYUKSE_AMT, 0) + NVL(T1.NONGTEUKSE_AMT, 0)
               ELSE 0
            END AS ARS_CARD_AMT
          ,CASE
               WHEN T1.BANK_GUBUN = 99 AND T1.MNGBR <> 9878
               THEN NVL(T1.SEWOI_AMT, 0)
               ELSE 0
            END AS ARS_CARD_SEWOI_AMT
          ,CASE
               WHEN T1.BANK_GUBUN = 99 AND T1.MNGBR = 9878
               THEN NVL(T1.BONSE_AMT, 0) + NVL(T1.GYOYUKSE_AMT, 0) + NVL(T1.NONGTEUKSE_AMT, 0) + NVL(T1.SEWOI_AMT, 0)
               ELSE 0
            END AS ARS_CARD_HAND_PHONE_AMT
          ,0 AS JOJEONG_JIGEUB_AMT
      FROM
           RPT_SUNAP_JIBGYE T1
      WHERE 1=1
           AND NVL('0', 0) = 0
           AND T1.GEUMGO_CODE = '28'
           AND T1.SUNAPIL >= SUBSTR('20240329', 1, 6)||'01'
           AND T1.SUNAPIL <= '20240329'
           AND T1.BANK_GUBUN = 99
           AND '0' IN (1, 0)
           AND '01' = 1
     ) T1


     --------------------------------


           SELECT
           T2.GONGGEUM_GYEJWA
           ,SUM(DECODE(T1.SIGUMGO_AC_B, 10, NVL(T2.JANAEK, 0), 0)) AS SEIP_GYEJWA_JAN
          ,SUM(DECODE(T1.SIGUMGO_AC_B, 20, NVL(T2.JANAEK, 0), 0)) AS BAEJUNG_GYEJWA_JAN
          ,0 AS JATA_BNK_SUNAB_ICHE_AMT
          ,0 AS JOJEONG_IPGEUM_AMT
          ,0 AS CARD_AMT
          ,0 AS ARS_CARD_AMT
          ,0 AS ARS_CARD_SEWOI_AMT
          ,0 AS ARS_CARD_HAND_PHONE_AMT
          ,0 AS JOJEONG_JIGEUB_AMT
      FROM
           ACL_SIGUMGO_MAS T1
          ,RPT_GONGGEUM_JAN T2
      WHERE 1=1
           AND T1.FIL_100_CTNT2 = T2.GONGGEUM_GYEJWA
           AND T1.SIGUMGO_ORG_C = T2.GEUMGO_CODE
           AND T1.ICH_SIGUMGO_GUN_GU_C = T2.GUNGU_CODE
           AND T1.SIGUMGO_ORG_C = '28'
           AND DECODE(NVL('0', '9999'), '9999', 1, DECODE(T1.ICH_SIGUMGO_GUN_GU_C, '0', 1, 0)) = 1
           AND T1.ICH_SIGUMGO_HOIKYE_C = '01'
           AND T1.SIGUMGO_AC_B IN (10,20)
           AND (
                CASE
                    WHEN '0' = 1 THEN DECODE(T1.SIGUMGO_HOIKYE_YR, '9999', 1, SUBSTR('20240329', 1, 4), 1, 0)
                    WHEN '0' IN (8, 9) THEN DECODE(T1.SIGUMGO_HOIKYE_YR, SUBSTR('20240329', 1, 4) - 1, 1, 0)
                    WHEN '0' = 0 THEN DECODE(T1.SIGUMGO_HOIKYE_YR, '9999', 1, SUBSTR('20240329', 1, 4), 1, SUBSTR('20240329', 1, 4) - 1, 1, 0)
                    ELSE 0
                 END
               ) = 1
           AND T1.MNG_NO = 1
           AND T2.KEORAEIL = '20240329'
        group by T2.GONGGEUM_GYEJWA   


-------------------------------------------------

SELECT KBN 
    ,JUKYO
    ,BEF_JAN
    ,JIGEUB
    ,IPGEUM
    ,HYUN_JAN    
    ,MKDT
    ,DUDT
    ,IYUL
    ,NUM 
  FROM (
SELECT
     T1.KBN
    ,DECODE(T1.SUBKBN, 5, T1.JUKYO || '신한-' || COUNT(T1.SUBKBN) || '건)'
                     , 7, T1.JUKYO || '(' || COUNT(T1.SUBKBN) || '건)'
                        , T1.JUKYO) AS JUKYO
    ,SUM(T1.BEF_JAN) AS BEF_JAN
    ,SUM(T1.JIGEUB) AS JIGEUB
    ,SUM(T1.IPGEUM) AS IPGEUM
    ,SUM(T1.HYUN_JAN) AS HYUN_JAN    
    ,SUM(T1.MKDT) AS MKDT
    ,SUM(T1.DUDT) AS DUDT
    ,SUM(T1.IYUL) AS IYUL
    ,CASE
         WHEN T1.KBN = 1 AND T1.JUKYO = '잔액현황' THEN 1
         WHEN T1.KBN = 1 AND T1.JUKYO = '총지급입금누계' THEN 2
         WHEN T1.KBN = 2 THEN 3
         WHEN T1.KBN = 3 AND T1.JUKYO LIKE '%S드림 정기예금(인천광역시 전용)%' THEN 4
         WHEN T1.KBN = 3 AND T1.JUKYO LIKE '%S%드림%전용%' THEN 5
         WHEN T1.KBN = 3 AND T1.JUKYO LIKE '%S드림%' THEN 6
         ELSE 7
      END AS NUM
FROM
     (
      SELECT
           T1.KBN
          ,1 AS SUBKBN
          ,T1.JUKYO
          ,T1.BEF_JAN AS BEF_JAN
          ,T1.JIGEUB AS JIGEUB
          ,T1.IPGEUM AS IPGEUM
          ,T1.HYUN_JAN AS HYUN_JAN
          ,'' AS MKDT
          ,'' AS DUDT
          ,0 AS IYUL
      FROM
           (
             SELECT
                  1 AS KBN
                 ,'잔액현황' AS JUKYO
                 ,DECODE(SIGN(NVL(T1.GISDT, T1.TRXDT) - '20240329'), -1, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT * DECODE(T1.IPJI_G, 2, -1, 1), 0) AS BEF_JAN 
                 ,DECODE(SIGN(NVL(T1.GISDT, T1.TRXDT) - '20240329'), 0, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT * DECODE(T1.IPJI_G, 2, 1, 0), 0) AS JIGEUB
                 ,DECODE(SIGN(NVL(T1.GISDT, T1.TRXDT) - '20240329'), 0, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT * DECODE(T1.IPJI_G, 1, 1, 0), 0) AS IPGEUM
                 ,DECODE(SIGN(NVL(T1.GISDT, T1.TRXDT) - '20240329'), 1, 0, DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT * DECODE(T1.IPJI_G, 2, -1, 1)) AS HYUN_JAN 
             FROM
                  ACL_SIGUMGO_SLV T1
             WHERE 1=1
                  AND T1.FIL_100_CTNT5 = '02800001100000024'
                  AND NVL(T1.GISDT, T1.TRXDT) <= '20240329'
                  AND T1.TRXDT >= '20070205'
             UNION ALL
             SELECT
                  1 AS KBN
                 ,'총지급입금누계' AS JUKYO
                 ,0 AS BEF_JAN
                 ,DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT * DECODE(T1.IPJI_G, 2, 1, 0) AS JIGEUB
                 ,DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT * DECODE(T1.IPJI_G, 1, 1, 0) AS IPGEUM
                 ,0 AS HYUN_JAN
             FROM
                  ACL_SIGUMGO_SLV T1
             WHERE 1=1
                  AND T1.FIL_100_CTNT5 = '02800001100000024'
                  AND NVL(T1.GISDT, T1.TRXDT) >= '20240101'
                  AND NVL(T1.GISDT, T1.TRXDT) <= '20240329'
             UNION ALL
             SELECT
                  2 AS KBN
                 ,CASE
                      WHEN T1.KIND_CD LIKE '10%' AND T1.KEORAEIL < '20070401' THEN 'CITI 자금이월 및 기타입금'
                      WHEN T1.KIND_CD LIKE '10%' AND T1.KEORAEIL >= '20070401' THEN '기타입금'
                      WHEN T1.KIND_CD = '11010001' THEN '자행 모점수납분 입금'
                      WHEN T1.KIND_CD = '11010000' THEN '자행 타점수납분 입금'
                      WHEN T1.KIND_CD = '11020000' THEN '타행수납분 입금'
                      WHEN T1.KIND_CD = '12030000' THEN '자금운용 환입[예금해지]'
                      WHEN T1.KIND_CD = '12040000' THEN '자금운용 환입[가이월-신년도]'
                      WHEN T1.KIND_CD = '12050000' THEN '자금운용 환입[전용자금환입]'
                      WHEN T1.KIND_CD LIKE '13%' THEN '자금조정 입금'
                      WHEN T1.KIND_CD = '14060000' THEN '감배정 입금[사업소 감배정]'
                      WHEN T1.KIND_CD = '14070000' THEN '감배정 입금[지출원 감배정]'
                      WHEN T1.KIND_CD LIKE '15%' THEN '수입금 출납원 배정액입금(세무과)'
                      WHEN T1.KIND_CD LIKE '16%' THEN '지출원 배정액 입금(일상경비)'
                      WHEN T1.KIND_CD LIKE '17%' THEN '세출금 반납'
                      WHEN T1.KIND_CD LIKE '18%' THEN '과목경정 입금'
                      WHEN T1.KIND_CD LIKE '19%' THEN '수납계좌 오류분 입금'
                      WHEN T1.KIND_CD LIKE '24%' THEN '과오납 입금'
                      WHEN T1.KIND_CD LIKE '30%' THEN '공채 입금'
                      WHEN T1.KIND_CD LIKE '40%' THEN 'MR자금입금'
                      WHEN T1.KIND_CD LIKE '44%' THEN '전부금 입금'
                      WHEN T1.KIND_CD LIKE '60%' AND T1.KEORAEIL < '20070401' THEN '자금이월 및 기타지급'
                      WHEN T1.KIND_CD LIKE '60%' AND T1.KEORAEIL >= '20070401' THEN '기타지급'
                      WHEN T1.KIND_CD = '61000100' THEN '자금배정 지급[사업소배정]'
                      WHEN T1.KIND_CD = '61000200' THEN '자금배정 지급[지출원배정]'
                      WHEN T1.KIND_CD = '62000300' THEN '자금운용 지급[예금신규]'
                      WHEN T1.KIND_CD = '62000400' THEN '자금운용 지급[가이월]'
                      WHEN T1.KIND_CD = '62000500' THEN '자금운용 지급[전용자금지급]'
                      WHEN T1.KIND_CD LIKE '63%' THEN '자금조정 지급'
                      WHEN T1.KIND_CD LIKE '64%' THEN '과오납반환 지급'
                      WHEN T1.KIND_CD LIKE '65%' THEN '과목경정 지급'
                      WHEN T1.KIND_CD LIKE '66%' THEN '수납금 이체지급'
                      WHEN T1.KIND_CD LIKE '67%' THEN '세출금 지급'
                      WHEN T1.KIND_CD LIKE '68%' THEN '감배정 지급'
                      WHEN T1.KIND_CD LIKE '69%' THEN '수납계좌 오류분 지급'
                      WHEN T1.KIND_CD LIKE '80%' THEN '공채 지급'
                      WHEN T1.KIND_CD LIKE '90%' THEN 'MR자금지급'
                      WHEN T1.KIND_CD LIKE '94%' THEN '전부금 지급'
                      WHEN T1.KIND_CD LIKE '20%' THEN '서구청 충당분 입금'
                      WHEN T1.KIND_CD LIKE '70%' THEN '서구청 충당분 정산지급'
                   END AS JUKYO
                  ,0 AS BEF_JAN
                  ,T1.JIGEUB
                  ,T1.IPGEUM
                  ,0 AS HYUN_JAN
             FROM
                  (
                   SELECT
                        T1.TRXDT AS KEORAEIL
                       ,LPAD(T1.SIGUMGO_TRX_G,2,'0')||LPAD(T1.SIGUMGO_IP_TRX_G,2,'0')||LPAD(T1.SIGUMGO_JI_TRX_G,2,'0')||LPAD(NVL(T1.IMMD_PROC_DSYN, 0), 2, '0') AS KIND_CD
                       ,DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT * DECODE(T1.IPJI_G, 2, 1, 0) AS JIGEUB
                       ,DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT * DECODE(T1.IPJI_G, 1, 1, 0) AS IPGEUM
                   FROM
                        ACL_SIGUMGO_SLV T1
                   WHERE 1=1
                        AND T1.FIL_100_CTNT5 = '02800001100000024'
                        AND NVL(T1.GISDT, T1.TRXDT) = '20240329'
                        AND T1.TRXDT >= '20070205'
                  ) T1
            ) T1

            UNION ALL

            SELECT
                 3 AS KBN
                ,2 AS SUBKBN
                ,TRIM(T2.SANGPUM_NAME)||'(신한-'||TRIM(T2.UNYONG_GYEJWA)||')' AS JUKYO
                 ,0 AS BEF_JAN
                 ,0 AS JIGEUB
                 ,0 AS IPGEUM
                 ,NVL(T1.JANAEK,0) AS HYUN_JAN
                 ,T1.MKDT
                 ,T1.DUDT
                 ,T1.IYUL
            FROM
                 RPT_UNYONG_JAN T1
                ,RPT_UNYONG_GYEJWA T2
            WHERE 1=1
                 AND 'FALSE' = 'TRUE'
                 AND T1.GONGGEUM_GYEJWA = T2.GONGGEUM_GYEJWA
                 AND T1.UNYONG_GYEJWA = T2.UNYONG_GYEJWA
                 AND T2.GEUMGO_CODE = '28'
                 AND T2.BANK_GUBUN = 0
                 AND SUBSTR(NVL(T2.MKDT, T2.IN_DATE), 1, 8) <= '20240329'
                 AND NVL(T2.OUT_DATE, '99991231') > '20240329'
                 AND NVL(T2.HJI_DT, '99991231') > '20240329'
                 AND T1.KIJUNIL = '20240329'
                 AND T1.GEUMGO_CODE = '28'
                 AND (
                      CASE
                          WHEN '24' = '99'
                          THEN DECODE(T1.GONGGEUM_GYEJWA, '02800001100000024', 1, 0)
                          ELSE
                               CASE
                                   WHEN T1.GONGGEUM_GYEJWA IN (
                                                               SELECT
                                                                    FIL_100_CTNT2
                                                               FROM
                                                                    ACL_SIGUMGO_MAS
                                                               WHERE 1=1
                                                                    AND FIL_100_CTNT2 LIKE SUBSTR('02800001100000024', 1, 15)||'%'
                                                                    AND FIL_100_CTNT2 <= '02800001100000024'
                                                              )
                                   THEN 1
                                   ELSE 0
                                END
                       END
                     ) = 1
            UNION ALL
            SELECT
                 3 AS KBN
                ,3 AS SUBKBN                 
                ,'통합공금 (산한~'||T2.FIL_100_CTNT1||')' AS JUKYO
                 ,0 AS BEF_JAN
                 ,0 AS JIGEUB
                 ,0 AS IPGEUM
                 ,NVL(T1.JANAEK,0) AS HYUN_JAN
                 ,T3.MKDT
                 ,T3.DUDT
                 ,T3.IYUL
            FROM
                 RPT_UNYONG_JAN T1
                ,RPT_AC_BY_HOIKYE_MAPP T2
                ,RPT_UNYONG_JAN T3
            WHERE 1=1
                 AND 'FALSE' = 'TRUE'
                 AND T1.GONGGEUM_GYEJWA = '02800001100000024'
                 AND T1.UNYONG_GYEJWA = '000000000000'
                 AND T1.KIJUNIL = '20230206'
                 AND T2.SIGUMGO_ACNO = T3.GONGGEUM_GYEJWA
                 AND T2.FIL_100_CTNT1 = T3.UNYONG_GYEJWA
                 AND T3.KIJUNIL = '20240329'
                 AND T3.GEUMGO_CODE = '28'
            UNION ALL
            SELECT
                 3 AS KBN
                ,4 AS SUBKBN                 
                ,TRIM(T1.SANGPUM_NAME)||'('||TRIM(T1.BANK_NAME)||'-'||TRIM(T1.UNYONG_GYEJWA)||')' AS JUKYO
                ,0 AS BEF_JAN
                ,0 AS JIGEUB
                ,0 AS IPGEUM
                ,NVL(T1.GEUMAEK_AMT,0) AS HYUN_JAN
                ,'' AS MKDT
                ,'' AS DUDT
                ,0 AS IYUL
            FROM
                 RPT_UNYONG_GYEJWA T1
            WHERE 1=1
                 AND 'FALSE' = 'TRUE'
                 AND T1.BANK_GUBUN = 1
                 AND T1.IN_DATE <= '20240329'
                 AND NVL(T1.OUT_DATE, '99991231') > '20240329'
                 AND NVL(T1.HJI_DT, '99991231') > '20240329'
                 AND T1.GEUMGO_CODE = '28'
                 AND (
                      CASE
                          WHEN '24' = '99'
                          THEN DECODE(T1.GONGGEUM_GYEJWA, '02800001100000024', 1, 0)
                          ELSE
                               CASE
                                   WHEN T1.GONGGEUM_GYEJWA IN (
                                                               SELECT
                                                                    FIL_100_CTNT2
                                                               FROM
                                                                    ACL_SIGUMGO_MAS
                                                               WHERE 1=1
                                                                    AND FIL_100_CTNT2 LIKE SUBSTR('02800001100000024', 1, 15)||'%'
                                                                    AND FIL_100_CTNT2 <= '02800001100000024'
                                                              )
                                   THEN 1
                                   ELSE 0
                                END
                       END
                     ) = 1
            UNION ALL
            SELECT
                 3 AS KBN
                ,T1.SUBKBN                 
                ,T1.SANGPUM_NAME
                ,0 AS BEF_JAN
                ,0 AS JIGEUB
                ,0 AS IPGEUM
                ,NVL(T1.AMT,0) AS HYUN_JAN
                ,'' AS MKDT
                ,'' AS DUDT
                ,0 AS IYUL
            FROM
                 (
                  SELECT
                       T2.SANGPUM_NAME
                      ,5 AS SUBKBN
                      ,T1.JANAEK AS AMT
                  FROM
                       RPT_UNYONG_JAN T1
                      ,RPT_UNYONG_GYEJWA T2
                  WHERE 1=1
                       AND NVL('FALSE', 'FALSE') <> 'TRUE'
                       AND T1.GONGGEUM_GYEJWA = T2.GONGGEUM_GYEJWA
                       AND T1.UNYONG_GYEJWA = T2.UNYONG_GYEJWA
                       AND T2.GEUMGO_CODE = '28'
                       AND T2.BANK_GUBUN = 0
                       AND SUBSTR(NVL(T2.MKDT, T2.IN_DATE), 1, 8) <= '20240329'
                       AND NVL(T2.OUT_DATE, '99991231') > '20240329'
                       AND NVL(T2.HJI_DT, '99991231') > '20240329'
                       AND T1.KIJUNIL = '20240329'
                       AND T1.GEUMGO_CODE = '28'
                       AND (
                            CASE
                                WHEN '24' = '99'
                                THEN DECODE(T1.GONGGEUM_GYEJWA, '02800001100000024', 1, 0)
                                ELSE
                                     CASE
                                         WHEN T1.GONGGEUM_GYEJWA IN (
                                                                     SELECT
                                                                          FIL_100_CTNT2
                                                                     FROM
                                                                          ACL_SIGUMGO_MAS
                                                                     WHERE 1=1
                                                                          AND FIL_100_CTNT2 LIKE SUBSTR('02800001100000024', 1, 15)||'%'
                                                                          AND FIL_100_CTNT2 <= '02800001100000024'
                                                                    )
                                         THEN 1
                                         ELSE 0
                                      END
                             END
                           ) = 1

                  UNION ALL
                  SELECT
                       '통합공금 (1건)' AS SANGPUM_NAME
                       ,6 AS SUBKBN                       
                       ,T1.JANAEK AS AMT
                  FROM
                       RPT_UNYONG_JAN T1
                      ,RPT_AC_BY_HOIKYE_MAPP T2
                      ,RPT_UNYONG_JAN T3
                  WHERE 1=1
                       AND NVL('FALSE', 'FALSE') <> 'TRUE'
                       AND T1.GONGGEUM_GYEJWA = '02800001100000024'
                       AND T1.UNYONG_GYEJWA = '000000000000'
                       AND T1.KIJUNIL = '20230206'
                       AND T2.SIGUMGO_ACNO = T3.GONGGEUM_GYEJWA
                       AND T2.FIL_100_CTNT1 = T3.UNYONG_GYEJWA
                       AND T3.KIJUNIL = '20240329'
                       AND T3.GEUMGO_CODE = '28'
                  UNION ALL
                  SELECT
                       T1.SANGPUM_NAME AS SANGPUM_NAME
                      ,7 AS SUBKBN
                      ,T1.GEUMAEK_AMT AS AMT
                  FROM
                       RPT_UNYONG_GYEJWA T1
                  WHERE 1=1
                       AND NVL('FALSE', 'FALSE') <> 'TRUE'
                       AND T1.BANK_GUBUN = 1
                       AND T1.IN_DATE <= '20240329'
                       AND NVL(T1.OUT_DATE, '99991231') > '20240329'
                       AND NVL(T1.HJI_DT, '99991231') > '20240329'
                       AND T1.GEUMGO_CODE = '28'
                       AND (
                            CASE
                                WHEN '24' = '99'
                                THEN DECODE(T1.GONGGEUM_GYEJWA, '02800001100000024', 1, 0)
                                ELSE
                                     CASE
                                         WHEN T1.GONGGEUM_GYEJWA IN (
                                                                     SELECT
                                                                          FIL_100_CTNT2
                                                                     FROM
                                                                          ACL_SIGUMGO_MAS
                                                                     WHERE 1=1
                                                                          AND FIL_100_CTNT2 LIKE SUBSTR('02800001100000024', 1, 15)||'%'
                                                                          AND FIL_100_CTNT2 <= '02800001100000024'
                                                                    )
                                         THEN 1
                                         ELSE 0
                                      END
                             END
                           ) = 1
                 ) T1
     ) T1
GROUP BY KBN, SUBKBN, JUKYO
ORDER BY NUM,T1.JUKYO
)

-----------------------------------------------


SELECT
                  2 AS KBN
                 ,CASE
                      WHEN T1.KIND_CD LIKE '10%' AND T1.KEORAEIL < '20070401' THEN 'CITI 자금이월 및 기타입금'
                      WHEN T1.KIND_CD LIKE '10%' AND T1.KEORAEIL >= '20070401' THEN '기타입금'
                      WHEN T1.KIND_CD = '11010001' THEN '자행 모점수납분 입금'
                      WHEN T1.KIND_CD = '11010000' THEN '자행 타점수납분 입금'
                      WHEN T1.KIND_CD = '11020000' THEN '타행수납분 입금'
                      WHEN T1.KIND_CD = '12030000' THEN '자금운용 환입[예금해지]'
                      WHEN T1.KIND_CD = '12040000' THEN '자금운용 환입[가이월-신년도]'
                      WHEN T1.KIND_CD = '12050000' THEN '자금운용 환입[전용자금환입]'
                      WHEN T1.KIND_CD LIKE '13%' THEN '자금조정 입금'
                      WHEN T1.KIND_CD = '14060000' THEN '감배정 입금[사업소 감배정]'
                      WHEN T1.KIND_CD = '14070000' THEN '감배정 입금[지출원 감배정]'
                      WHEN T1.KIND_CD LIKE '15%' THEN '수입금 출납원 배정액입금(세무과)'
                      WHEN T1.KIND_CD LIKE '16%' THEN '지출원 배정액 입금(일상경비)'
                      WHEN T1.KIND_CD LIKE '17%' THEN '세출금 반납'
                      WHEN T1.KIND_CD LIKE '18%' THEN '과목경정 입금'
                      WHEN T1.KIND_CD LIKE '19%' THEN '수납계좌 오류분 입금'
                      WHEN T1.KIND_CD LIKE '24%' THEN '과오납 입금'
                      WHEN T1.KIND_CD LIKE '30%' THEN '공채 입금'
                      WHEN T1.KIND_CD LIKE '40%' THEN 'MR자금입금'
                      WHEN T1.KIND_CD LIKE '44%' THEN '전부금 입금'
                      WHEN T1.KIND_CD LIKE '60%' AND T1.KEORAEIL < '20070401' THEN '자금이월 및 기타지급'
                      WHEN T1.KIND_CD LIKE '60%' AND T1.KEORAEIL >= '20070401' THEN '기타지급'
                      WHEN T1.KIND_CD = '61000100' THEN '자금배정 지급[사업소배정]'
                      WHEN T1.KIND_CD = '61000200' THEN '자금배정 지급[지출원배정]'
                      WHEN T1.KIND_CD = '62000300' THEN '자금운용 지급[예금신규]'
                      WHEN T1.KIND_CD = '62000400' THEN '자금운용 지급[가이월]'
                      WHEN T1.KIND_CD = '62000500' THEN '자금운용 지급[전용자금지급]'
                      WHEN T1.KIND_CD LIKE '63%' THEN '자금조정 지급'
                      WHEN T1.KIND_CD LIKE '64%' THEN '과오납반환 지급'
                      WHEN T1.KIND_CD LIKE '65%' THEN '과목경정 지급'
                      WHEN T1.KIND_CD LIKE '66%' THEN '수납금 이체지급'
                      WHEN T1.KIND_CD LIKE '67%' THEN '세출금 지급'
                      WHEN T1.KIND_CD LIKE '68%' THEN '감배정 지급'
                      WHEN T1.KIND_CD LIKE '69%' THEN '수납계좌 오류분 지급'
                      WHEN T1.KIND_CD LIKE '80%' THEN '공채 지급'
                      WHEN T1.KIND_CD LIKE '90%' THEN 'MR자금지급'
                      WHEN T1.KIND_CD LIKE '94%' THEN '전부금 지급'
                      WHEN T1.KIND_CD LIKE '20%' THEN '서구청 충당분 입금'
                      WHEN T1.KIND_CD LIKE '70%' THEN '서구청 충당분 정산지급'
                   END AS JUKYO
                  ,0 AS BEF_JAN
                  ,T1.JIGEUB
                  ,T1.IPGEUM
                  ,0 AS HYUN_JAN
             FROM
                  (
                   SELECT
                        T1.TRXDT AS KEORAEIL
                       ,LPAD(T1.SIGUMGO_TRX_G,2,'0')||LPAD(T1.SIGUMGO_IP_TRX_G,2,'0')||LPAD(T1.SIGUMGO_JI_TRX_G,2,'0')||LPAD(NVL(T1.IMMD_PROC_DSYN, 0), 2, '0') AS KIND_CD
                       ,DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT * DECODE(T1.IPJI_G, 2, 1, 0) AS JIGEUB
                       ,DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT * DECODE(T1.IPJI_G, 1, 1, 0) AS IPGEUM
                   FROM
                        ACL_SIGUMGO_SLV T1
                   WHERE 1=1
                        AND T1.FIL_100_CTNT5 = '02800001100000024'
                        AND NVL(T1.GISDT, T1.TRXDT) = '20240329'
                        AND T1.TRXDT >= '20070205'
                  ) T1


      ----------------------------------------------------------

                         SELECT
                        T1.TRXDT AS KEORAEIL
                       ,LPAD(T1.SIGUMGO_TRX_G,2,'0')||LPAD(T1.SIGUMGO_IP_TRX_G,2,'0')||LPAD(T1.SIGUMGO_JI_TRX_G,2,'0')||LPAD(NVL(T1.IMMD_PROC_DSYN, 0), 2, '0') AS KIND_CD
                       , T1.SIGUMGO_TRX_G
                       , T1.SIGUMGO_IP_TRX_G
                       ,DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT * DECODE(T1.IPJI_G, 2, 1, 0) AS JIGEUB
                       ,DECODE(T1.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T1.TRAMT * DECODE(T1.IPJI_G, 1, 1, 0) AS IPGEUM
                   FROM
                        ACL_SIGUMGO_SLV T1
                   WHERE 1=1
                        AND T1.FIL_100_CTNT5 = '02800001100000024'
                        AND NVL(T1.GISDT, T1.TRXDT) = '20240329'
                        AND T1.TRXDT >= '20070205' 
                        and T1.SIGUMGO_TRX_G = '20'           



-- 2024/02/29
 select * from ACL_SIGUMGO_SLV
 where FIL_100_CTNT5 = '02800001100000024'
 and  TRAMT = 77180                      