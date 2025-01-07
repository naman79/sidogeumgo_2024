WITH BIZDT AS (
    SELECT
        DW_BAS_DDT AS TDT,
        NEXT_BIZ_DT AS NDT
    FROM MAP_JOB_DATE
    WHERE DW_BAS_DDT = (SELECT TO_CHAR(SYSDATE, 'YYYYMMDD') FROM DUAL)
),
     MERGED_BIZDT AS (
         SELECT TDT AS DT FROM BIZDT
         UNION ALL
         SELECT NDT AS DT FROM BIZDT
     )
SELECT GJDT AS DT, '1.서구청' AS GUBUN, SUM(SUNP_AMT) AS AMT
FROM ACL_SUNAPMSG_SLV
WHERE GJDT IN (SELECT DT FROM MERGED_BIZDT)
  AND UPMU_G IN (1, 2, 4)
  AND RPT_TOT_C != '104901'
GROUP BY GJDT
UNION ALL
SELECT SIGUMGO_ICHE_KJ_DT AS DT, '2.7331' AS GUBUN, SUM(SIGUMGO_IP_AMT) AS AMT
FROM ACL_INCHICHE_CC
WHERE SIGUMGO_ICHE_KJ_DT IN (SELECT DT FROM MERGED_BIZDT)
  AND SIGUMGO_IP_REF_NO = '55291000670205'
  AND IPJI_G = 1
GROUP BY SIGUMGO_ICHE_KJ_DT
ORDER BY DT, GUBUN, AMT
;

              select A.*
               FROM  RPT_TXIO_DDAC_TAB A
               WHERE  1=1
               AND A.SIGUMGO_ORG_C  = 28
               AND (CASE WHEN BAS_DT > GISDT THEN GISDT  ELSE  BAS_DT END) BETWEEN SUBSTR('202401',0,4) || '0101' AND '20241231'
               AND A.ICH_SIGUMGO_HOIKYE_C = '22'
               AND A.SIGUMGO_AC_B IN('10','20')
              order by upd_dttm desc


 SELECT LIST.KEORAEIL
,LIST.KIJUNIL
,LIST.KISANIL
,LIST.GONGGEUM_GYEJWA
,LIST.GONGGEUM_GYEJWA_NM
,LIST.GONGGEUM_GYEJWA||' ('||LIST.GONGGEUM_GYEJWA_NM||')' AS GONGGEUM_GYEJWA_NM2
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
,LIST.TOTCNT
,LIST.JIGEUB_TOTAL
,LIST.IPGEUM_TOTAL
,LIST.JAN_TOTAL
,LIST.RN
,LIST.DAY_YMD
  FROM
(SELECT
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
    ,T9.TOTCNT
    ,T9.JIGEUB_TOTAL
    ,T9.IPGEUM_TOTAL
    ,T9.JAN_TOTAL
    ,ROWNUM AS RN
    ,DECODE('1', '1', T9.KEORAEIL, '2', T9.KIJUNIL, T9.KISANIL)  AS DAY_YMD
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
          ,T4.JIGEUB_AMT AS JIGEUB_AMT
          ,T4.IPGEUM_AMT AS IPGEUM_AMT
          ,T4.JAN + NVL(T6.BF_DAY_JAN,0) AS JAN_AMT
          ,T4.GEUMGWON_NO
          ,T4.SUNAP_BR
          ,T4.IPGEUM_GEORAE
          ,T4.JIGEUB_GEORAE
          ,T4.GEORAE_SEQ
          ,T4.RID
          ,T4.JIGEUB_ORDER1
          ,T4.JIGEUB_ORDER2
          ,CASE
                    WHEN T4.IPGEUM_GEORAE > 0 THEN T4.GEORAE_GUBUN||'-'||T4.IPGEUM_GEORAE||' '||T7.CMM_DTL_C_NM
                    WHEN T4.JIGEUB_GEORAE > 0 THEN T4.GEORAE_GUBUN||'-'||T4.JIGEUB_GEORAE||' '||T7.CMM_DTL_C_NM
             ELSE T4.GEORAE_GUBUN||' '||T7.CMM_DTL_C_NM
            END AS JIGUP_NM
          ,COUNT(T4.RID) OVER() AS TOTCNT
          ,SUM(NVL(T4.JIGEUB_AMT,0)) OVER() AS JIGEUB_TOTAL
          ,SUM(NVL(T4.IPGEUM_AMT,0)) OVER() AS IPGEUM_TOTAL
          ,SUM(NVL(T4.JAN,0)+NVL(T6.BF_DAY_JAN,0)) OVER() AS JAN_TOTAL
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
                     ,SUM(
                        DECODE(T3.CRT_CAN_G,1,-1,2,-1,33,-1,1) * DECODE(T3.IPJI_G , 2, -1 * T3.TRAMT, T3.TRAMT)
                      ) OVER (
                              PARTITION BY T2.GONGGEUM_GYEJWA
                              ORDER BY
                                      DECODE('1', 2, T3.GISDT, 3, T3.GJDT, T3.TRXDT)
                                     ,DECODE('1', 1, T3.TRXNO, T3.TRXDT)
                                     ,DECODE('1', 1, 1, T3.TRXNO)
                           ) AS JAN
                   FROM
                        (
                         SELECT
                              T1.SIGUMGO_ORG_C
                             ,T1.ICH_SIGUMGO_GUN_GU_C
                             ,T1.ICH_SIGUMGO_HOIKYE_C AS RPT_HOIKYE_C
                             ,T1.SIGUMGO_AC_B
                             ,T1.SIGUMGO_AC_SER
                             ,T1.SIGUMGO_HOIKYE_YR
                             ,T1.FIL_100_CTNT2  AS GONGGEUM_GYEJWA
                             ,T1.SIGUMGO_AC_NM AS GONGGEUM_GYEJWA_NM
                             ,LPAD(T1.LINKAC_KWA_C, 3, '0')||LPAD(T1.LINK_ACSER, 9, '0') AS GONGGEUM_YUDONG_ACNO
                         FROM
                              ACL_SIGUMGO_MAS T1
                         WHERE 1=1
                           AND T1.SIGUMGO_ORG_C = '28'
                           AND T1.SIGUMGO_HOIKYE_YR IN ('2024', '9999')
                           AND DECODE(NVL('02823701250000724', '9999'), '9999', 1, T1.FIL_100_CTNT2) = DECODE(NVL('02823701250000724', '9999'), '9999', 1, '02823701250000724')
                           AND T1.AC_GRBRNO LIKE '' ||'%'
                           AND DECODE(NVL('237', 'all'), 'all', 9999, T1.ICH_SIGUMGO_GUN_GU_C) = DECODE(NVL('237', 'all'), 'all', 9999, '237')
                           AND DECODE(NVL('', 'all'), 'all', 9999, T1.ICH_SIGUMGO_HOIKYE_C) = DECODE(NVL('', 'all'), 'all', 9999, '')
                           AND DECODE(NVL('25', 'all'), 'all', 9999, T1.SIGUMGO_AC_B) = DECODE(NVL('25', 'all'), 'all', 9999, '25')
                           AND T1.MNG_NO = 1
                        ) T2
                       ,ACL_SIGUMGO_SLV T3
                 WHERE 1=1
                   AND T2.GONGGEUM_GYEJWA = T3.FIL_100_CTNT5
                   AND DECODE('1', '1', T3.TRXDT, '2', T3.GISDT, T3.GJDT) >= '20241201'
                   AND DECODE('1', '1', T3.TRXDT, '2', T3.GISDT, T3.GJDT) <= '20241231'

                   AND T2.GONGGEUM_YUDONG_ACNO LIKE '' ||'%'

                   UNION ALL
                  SELECT
                      T3.TRXDT AS KEORAEIL
                     ,T3.GJDT AS KIJUNIL
                     ,T3.GISDT AS KISANIL
                     ,T2.GONGGEUM_GYEJWA
                     ,T2.GONGGEUM_GYEJWA_NM
                     ,T2.SIGUMGO_ORG_C
                     ,T2.ICH_SIGUMGO_GUN_GU_C
                     ,T3.SIGUMGO_TRX_G AS GEORAE_GUBUN
                     ,0 AS IPGEUM_GEORAE
                     ,0 AS JIGEUB_GEORAE
                     ,NULL AS JUKYO
                     ,T3.TRXNO AS GEORAE_SEQ
                     ,NULL AS GEUMGWON_NO
                     ,T3.TRXBRNO AS SUNAP_BR
                     ,0 AS SEQ_NO
                     ,T3.ROWID AS RID
                     ,LPAD(T3.SIGUMGO_TRX_G,2,'0')||'0000' AS KIND_CD
                     ,CASE
                          WHEN T3.IPJI_G = 1 THEN DECODE(T3.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T3.TRAMT
                          ELSE 0
                      END AS IPGEUM_AMT
                     ,CASE
                          WHEN T3.IPJI_G = 2 THEN DECODE(T3.CRT_CAN_G,1,-1,2,-1,33,-1,1) * T3.TRAMT
                          ELSE 0
                      END AS JIGEUB_AMT
                     ,NULL AS JIGEUB_ORDER1
                     ,NULL AS JIGEUB_ORDER2
                     ,SUM(
                        DECODE(T3.CRT_CAN_G,1,-1,2,-1,33,-1,1) * DECODE(T3.IPJI_G , 2, -1 * T3.TRAMT, T3.TRAMT)
                      ) OVER (
                              PARTITION BY T2.GONGGEUM_GYEJWA
                              ORDER BY
                                      DECODE('1', 2, T3.GISDT, 3, T3.GJDT, T3.TRXDT)
                                     ,DECODE('1', 1, T3.TRXNO, T3.TRXDT)
                                     ,DECODE('1', 1, 1, T3.TRXNO)
                           ) AS JAN
                   FROM
                        (
                         SELECT
                              T1.SIGUMGO_ORG_C
                             ,T1.ICH_SIGUMGO_GUN_GU_C
                             ,T1.ICH_SIGUMGO_HOIKYE_C AS RPT_HOIKYE_C
                             ,T1.SIGUMGO_AC_B
                             ,T1.SIGUMGO_AC_SER
                             ,T1.SIGUMGO_HOIKYE_YR
                             ,T1.FIL_100_CTNT2  AS GONGGEUM_GYEJWA
                             ,T1.SIGUMGO_AC_NM AS GONGGEUM_GYEJWA_NM
                             ,LPAD(T1.LINKAC_KWA_C, 3, '0')||LPAD(T1.LINK_ACSER, 9, '0') AS GONGGEUM_YUDONG_ACNO
                         FROM
                              ACL_SIGUMGO_MAS T1
                         WHERE 1=1
                           AND T1.SIGUMGO_ORG_C = '28'
                           AND T1.SIGUMGO_HOIKYE_YR IN ('2024', '9999')
                           AND DECODE(NVL('02823701250000724', '9999'), '9999', 1, T1.FIL_100_CTNT2) = DECODE(NVL('02823701250000724', '9999'), '9999', 1, '02823701250000724')
                           AND T1.AC_GRBRNO LIKE '' ||'%'
                           AND DECODE(NVL('237', 'all'), 'all', 9999, T1.ICH_SIGUMGO_GUN_GU_C) = DECODE(NVL('237', 'all'), 'all', 9999, '237')
                           AND DECODE(NVL('', 'all'), 'all', 9999, T1.ICH_SIGUMGO_HOIKYE_C) = DECODE(NVL('', 'all'), 'all', 9999, '')
                           AND DECODE(NVL('25', 'all'), 'all', 9999, T1.SIGUMGO_AC_B) = DECODE(NVL('25', 'all'), 'all', 9999, '25')
                           AND T1.MNG_NO = 1
                        ) T2
                       ,ACL_SGGHANDO_SLV T3
                 WHERE 1=1
                   AND '' = 'Y'
                   AND T2.SIGUMGO_ORG_C = T3.SIGUMGO_ORG_C
                   AND T2.ICH_SIGUMGO_GUN_GU_C = T3.ICH_SIGUMGO_GUN_GU_C
                   AND T2.RPT_HOIKYE_C = T3.ICH_SIGUMGO_HOIKYE_C
                   AND T2.SIGUMGO_AC_B = T3.SIGUMGO_AC_B
                   AND T2.SIGUMGO_AC_SER = T3.SIGUMGO_AC_SER
                   AND T2.SIGUMGO_HOIKYE_YR = T3.SIGUMGO_HOIKYE_YR
                   AND DECODE('1', '1', T3.TRXDT, '2', T3.GISDT, T3.GJDT) >= '20241201'
                   AND DECODE('1', '1', T3.TRXDT, '2', T3.GISDT, T3.GJDT) <= '20241231'
                   AND T2.GONGGEUM_YUDONG_ACNO LIKE '' ||'%'
           ) T4
          ,(
            SELECT
                 T5.GONGGEUM_GYEJWA
                ,T5.JANAEK AS BF_DAY_JAN
            FROM
                 RPT_GONGGEUM_JAN T5
                ,ACL_SIGUMGO_MAS T6
            WHERE 1=1
                 AND T5.GONGGEUM_GYEJWA = T6.FIL_100_CTNT2
                 AND T6.MNG_NO = 1
                 AND T5.GEUMGO_CODE = '28'
                 AND T5.KEORAEIL = TO_CHAR(TO_DATE('20241201','YYYYMMDD')-1,'YYYYMMDD')

                 AND T5.GUNGU_CODE = '237'

                 AND T5.GONGGEUM_GYEJWA = '02823701250000724'

                 AND T5.GYEJWA_BUNRYU = '25'


          ) T6
          ,SFI_CMM_C_DAT T7
          ,SFI_CMM_C_DAT T8
     WHERE 1=1
          AND T4.GONGGEUM_GYEJWA = T6.GONGGEUM_GYEJWA(+)
          AND T4.KIND_CD = T7.CMM_DTL_C(+)
          AND T7.CMM_C_NM(+) = 'RPT세입세출자금일계표집계용'
          AND T4.ICH_SIGUMGO_GUN_GU_C = T8.CMM_DTL_C
          AND T4.SIGUMGO_ORG_C = T8.HRNK_CMM_DTL_C
          AND T8.CMM_C_NM = 'RPT군구코드'

          AND DECODE(NVL('', 'all'), 'all', 9999, T4.GEORAE_GUBUN) = DECODE(NVL('', 'all'), 'all', 9999, '')


     ORDER BY
          T4.KEORAEIL
         ,T4.GEORAE_SEQ
     ) T9
WHERE 1=1
     AND ROWNUM <= '2000' ) LIST
WHERE LIST.RN > '0'



            SELECT
                 *
            FROM
                 RPT_GONGGEUM_JAN
            where gonggeum_gyejwa = '02823701250000724'
            and keoraeil  like '202412%'


            select * from rpt_dept_info
            where 1=1
