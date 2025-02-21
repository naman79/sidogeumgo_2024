-------------------------------------------------------------------------
-- 1

SELECT RPAD(NVL(A.LAF_CD, '0'), 7, ' ')
           || RPAD(NVL(A.GOF_CD, '0'), 4, ' ')
           || RPAD(NVL(A.GOF_NM, '0'), 300, ' ')
           || RPAD(NVL(A.FYR, '0'), 4, ' ')
           || RPAD(NVL(A.ACNT_DV_CD, '0'), 3, ' ')
           || RPAD(NVL(A.ACNT_DV_NM, '0'), 300, ' ')
           || RPAD(NVL(A.DTMK_CD, '0'), 6, ' ')
           || RPAD(NVL(A.DTMK_NM, '0'), 300, ' ')
           || RPAD(NVL(A.CAP_NTAX_DV_CD, '0'), 1, ' ')
           || RPAD(NVL(A.ACNT_YMD, '0'), 8, ' ')
           || RPAD(NVL(A.PSNTY_CNT, '0'), 20, ' ')
           || RPAD(NVL(A.PSNTY_AMT, '0'), 20, ' ')
           || RPAD(NVL(A.PSTY_CNT, '0'), 20, ' ')
           || RPAD(NVL(A.PSTY_AMT, '0'), 20, ' ')
           || RPAD(NVL(A.TXRV_SUM_CNT, '0'), 20, ' ')
           || RPAD(NVL(A.TXRV_TOTL_ANT, '0'), 20, ' ')
           || RPAD(NVL(A.STBX_BANK_CD, '0'), 3, ' ') AS DYMNSUM
FROM   (SELECT E.CMM_DTL_C AS LAF_CD,
               E.UPMU_HMK_3_SLV AS GOF_CD,
               E.UPMU_HMK_4_SLV AS GOF_NM,
               A.HOIGYE_YEAR AS FYR,
               C.ACNT_DV_CD AS ACNT_DV_CD,
               C.ACNT_DV_NM AS ACNT_DV_NM,
               A.HOIKYE_SMOK_C AS TRBI_CD,
               ' ' AS TRBI_NM,
               '0' AS CAP_NTAX_DV_CD,
               ' 20230110' AS ACNT_YMD,
               SUM(CASE
                       WHEN A.SUNAPIL BETWEEN '20230101' AND ' 20230110' THEN A.TOT_CNT
                       ELSE 0
                   END) PSNTY_CNT,
               SUM(CASE
                       WHEN A.SUNAPIL BETWEEN '20230101' AND ' 20230110' THEN A.TOT_AMT
                       ELSE 0
                   END) PSNTY_AMT,
               SUM(CASE
                       WHEN A.SUNAPIL BETWEEN '20220101' AND '20221231' THEN A.TOT_CNT
                       ELSE 0
                   END) PSTY_CNT,
               SUM(CASE
                       WHEN A.SUNAPIL BETWEEN '20220101' AND '20221231' THEN A.TOT_AMT
                       ELSE 0
                   END) PSTY_AMT,
               SUM(A.TOT_CNT) TXRV_SUM_CNT,
               SUM(A.TOT_AMT) TXRV_TOTL_ANT,
               A.HOIKYE_SMOK_C DTMK_CD,
               D.REF_D_NM DTMK_NM,
               '088' STBX_BANK_CD
        FROM   RPT_SUNAP_JIBGYE_SEIPE A,
               ACL_SIGUMGO_MAS B,
               RPT_FISG_INFO_MAP C,
               RPT_CODE_INFO D,
               SFI_CMM_C_DAT E
        WHERE  1 = 1
          AND A.SUNAPIL BETWEEN '20220101' AND ' 20230110'
          AND A.GEUMGO_CODE = 28
          AND 1 = ( CASE
                        WHEN B.SIGUMGO_ORG_C = '28'
                            AND A.HOIGYE_CODE = B.ICH_SIGUMGO_HOIKYE_C THEN 1
                        WHEN B.SIGUMGO_ORG_C != '28'
            AND B.FIL_100_CTNT2 = C.GONGGEUM_GYEJWA THEN 1
                           ELSE 0
                         END )
          AND C.GONGGEUM_GYEJWA = B.FIL_100_CTNT2
          AND B.MNG_NO = 1
          AND C.FYR = '2023'
          AND A.HOIGYE_CODE = D.REF_M_C
          AND A.HOIKYE_SMOK_C = D.REF_D_C
          AND E.CMM_C_NM = 'RPT자치단체코드분류'
          AND E.HRNK_CMM_DTL_C = A.GEUMGO_CODE
          AND E.UPMU_HMK_1_SLV = A.GUNGU_CODE
          AND E.CMM_DTL_C = C.LAF_CD
          AND NOT ( A.GEUMGO_CODE = 28
            AND A.GUNGU_CODE IN( '260', '710', '720' ) )
        GROUP  BY E.CMM_DTL_C,
                  E.UPMU_HMK_3_SLV,
                  E.UPMU_HMK_4_SLV,
                  A.HOIGYE_YEAR,
                  C.ACNT_DV_CD,
                  C.ACNT_DV_NM,
                  A.HOIKYE_SMOK_C,
                  D.REF_D_NM,
                  A.GEUMGO_CODE,
                  A.GUNGU_CODE) A


--------------------------------------------------------------------------
-------------------------------------------------------------------------
-- 2

SELECT
    RPAD(NVL(A.LAF_CD, '0'), 7, ' ')||
    RPAD(NVL(A.GOF_CD, '0'), 4, ' ')||
    RPAD(NVL(A.GOF_NM, '0'), 300, ' ')||
    RPAD(NVL(A.FYR, '0'), 4, ' ')||
    RPAD(NVL(A.ACNT_DV_CD, '0'), 3, ' ')||
    RPAD(NVL(A.ACNT_DV_NM, '0'), 300, ' ')||
    RPAD(NVL(A.DTMK_CD, '0'), 6, ' ')||
    RPAD(NVL(A.DTMK_NM, '0'), 300, ' ')||
    RPAD(NVL(A.CAP_NTAX_DV_CD, '0'), 1, ' ')||
    RPAD(NVL(A.ACNT_YMD, '0'), 8, ' ')||
    RPAD(NVL(A.RCVMT_AMT, '0'), 20, ' ')||
    RPAD(NVL(A.RFN_AMT, '0'), 20, ' ')||
    RPAD(NVL(A.TXRV_SBJ_RVSN_AMT, '0'), 20, ' ')||
    RPAD(NVL(A.TXRV_DD_SUM_AMT, '0'), 20, ' ')||
    RPAD(NVL(A.NTRCT_RCVMT_CNT, '0'), 20, ' ')||
    RPAD(NVL(A.NTRCT_RFN_CNT, '0'), 20, ' ')||
    RPAD(NVL(A.STBX_BANK_CD, '0'), 3, ' ') AS DYMNSUM
FROM
    (
        SELECT
            E.CMM_DTL_C AS LAF_CD,
            E.UPMU_HMK_3_SLV AS GOF_CD,
            E.UPMU_HMK_4_SLV AS GOF_NM,
            A.HOIGYE_YEAR AS FYR,
            C.ACNT_DV_CD AS ACNT_DV_CD,
            C.ACNT_DV_NM AS ACNT_DV_NM,
            A.HOIKYE_SMOK_C  AS TRBI_CD,
            ' ' AS TRBI_NM,
            '0' AS CAP_NTAX_DV_CD,
            ' 20230110' AS ACNT_YMD,
            SUM(TOT_AMT) AS RCVMT_AMT,
            SUM(GWAO_AMT) AS RFN_AMT,
            SUM(GJ_AMT) AS TXRV_SBJ_RVSN_AMT,
            SUM(TOT_AMT - GWAO_AMT - GJ_AMT) AS TXRV_DD_SUM_AMT,
            0 NTRCT_RCVMT_CNT,
            0 NTRCT_RFN_CNT,
            A.HOIKYE_SMOK_C DTMK_CD,
            D.REF_D_NM DTMK_NM,
            '088' STBX_BANK_CD
        FROM   RPT_SUNAP_JIBGYE_SEIPE A,
               ACL_SIGUMGO_MAS B,
               RPT_FISG_INFO_MAP C,
               RPT_CODE_INFO D,
               SFI_CMM_C_DAT E
        WHERE 1 = 1
          AND A.SUNAPIL = ' 20230110'
          AND A.GEUMGO_CODE = 28
          AND A.HOIGYE_CODE = B.ICH_SIGUMGO_HOIKYE_C
          AND C.GONGGEUM_GYEJWA = B.FIL_100_CTNT2
          AND B.MNG_NO = 1
          AND C.FYR = '2023'
          AND A.HOIGYE_CODE = D.REF_M_C
          AND A.HOIKYE_SMOK_C = D.REF_D_C
          AND D.REF_L_C = 901
          AND E.CMM_C_NM = 'RPT자치단체코드분류'
          AND E.HRNK_CMM_DTL_C = A.GEUMGO_CODE
          AND E.UPMU_HMK_1_SLV = A.GUNGU_CODE
          AND E.CMM_DTL_C = C.LAF_CD
          AND NOT (A.GEUMGO_CODE = 28 AND A.GUNGU_CODE IN('260','710','720'))
        GROUP BY E.CMM_DTL_C,E.UPMU_HMK_3_SLV,E.UPMU_HMK_4_SLV,A.HOIGYE_YEAR, C.ACNT_DV_CD, C.ACNT_DV_NM, A.HOIKYE_SMOK_C, D.REF_D_NM, A.GEUMGO_CODE, A.GUNGU_CODE
    ) A



--------------------------------------------------------------------------
-------------------------------------------------------------------------
-- 3

SELECT
    RPAD(NVL(A.LAF_CD, '0'), 7, ' ')||
    RPAD(NVL(A.GOF_CD, '0'), 4, ' ')||
    RPAD(NVL(A.GOF_NM, '0'), 300, ' ')||
    RPAD(NVL(A.FYR, '0'), 4, ' ')||
    RPAD(NVL(A.ACNT_DV_CD, '0'), 3, ' ')||
    RPAD(NVL(A.ACNT_DV_NM, '0'), 300, ' ')||
    RPAD(NVL(A.ACNT_YMD, '0'), 8, ' ')||
    RPAD(NVL(A.LDY_TXRV_AGGR_AMT, '0'), 20, ' ')||
    RPAD(NVL(A.RCVMT_AMT, '0'), 20, ' ')||
    RPAD(NVL(A.RFN_AMT, '0'), 20, ' ')||
    RPAD(NVL(A.TXRV_SBJ_RVSN_AMT, '0'), 20, ' ')||
    RPAD(NVL(A.TXRV_AMT, '0'), 20, ' ')||
    RPAD(NVL(A.TXRV_AGGR_AMT, '0'), 20, ' ')||
    RPAD(NVL(A.STBX_BANK_CD, '0'), 3, ' ') AS DYMNSUM
FROM
    (
        SELECT
            E.CMM_DTL_C AS LAF_CD,
            E.UPMU_HMK_3_SLV AS GOF_CD,
            E.UPMU_HMK_4_SLV AS GOF_NM,
            '2023' AS FYR,
            C.ACNT_DV_CD AS ACNT_DV_CD ,
            C.ACNT_DV_NM AS ACNT_DV_NM ,
            ' 20230110' AS ACNT_YMD
             , SUM((CASE WHEN GJDT < ' 20230110' AND A.SIGUMGO_TRX_G || '-' || A.SIGUMGO_IP_TRX_G IN ('10-0','11-1','11-2','12-4','13-0') THEN A.TRAMT ELSE 0 END) *  (DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)))
                   - SUM((CASE WHEN GJDT < ' 20230110' AND A.SIGUMGO_TRX_G || '-' || A.SIGUMGO_JI_TRX_G IN ('60-0','66-0','62-4','63-0','','','','','') THEN A.TRAMT ELSE 0 END) * (DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)))
                   +SUM((CASE WHEN GJDT < ' 20230110' AND A.SIGUMGO_TRX_G || '-' || A.SIGUMGO_IP_TRX_G IN ('15-0','16-0') THEN A.TRAMT ELSE 0 END) * (DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)))
            - SUM((CASE WHEN GJDT < ' 20230110' AND A.SIGUMGO_TRX_G || '-' || A.SIGUMGO_JI_TRX_G IN ('68-0') THEN A.TRAMT ELSE 0 END) * (DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1))) AS LDY_TXRV_AGGR_AMT
             ,SUM((CASE WHEN GJDT >= ' 20230110' AND A.SIGUMGO_TRX_G || '-' || A.SIGUMGO_IP_TRX_G IN ('10-0','11-1','11-2','12-4','13-0') THEN A.TRAMT ELSE 0 END) * (DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)))
                  - SUM((CASE WHEN GJDT >= ' 20230110' AND A.SIGUMGO_TRX_G || '-' || A.SIGUMGO_JI_TRX_G IN ('60-0','66-0','62-4','63-0','','','','','') THEN A.TRAMT ELSE 0 END) * (DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)))
                  +SUM((CASE WHEN GJDT >= ' 20230110' AND A.SIGUMGO_TRX_G || '-' || A.SIGUMGO_IP_TRX_G IN ('15-0','16-0') THEN A.TRAMT ELSE 0 END) * (DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)))
            - SUM((CASE WHEN GJDT >= ' 20230110' AND A.SIGUMGO_TRX_G || '-' || A.SIGUMGO_JI_TRX_G IN ('68-0') THEN A.TRAMT ELSE 0 END) * (DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1))) AS RCVMT_AMT
             ,SUM((CASE WHEN GJDT >= ' 20230110' AND A.SIGUMGO_TRX_G || '-' || A.SIGUMGO_IP_TRX_G IN ('24-0') THEN A.TRAMT ELSE 0 END) * (DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)))
            - SUM((CASE WHEN GJDT >= ' 20230110' AND A.SIGUMGO_TRX_G || '-' || A.SIGUMGO_JI_TRX_G IN ('64-0') THEN A.TRAMT ELSE 0 END) * (DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)))  AS RFN_AMT
             ,SUM((CASE WHEN GJDT >= ' 20230110' AND A.SIGUMGO_TRX_G || '-' || A.SIGUMGO_IP_TRX_G IN ('19-8','19-9') THEN A.TRAMT ELSE 0 END) * (DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)))
            - SUM((CASE WHEN GJDT >= ' 20230110' AND A.SIGUMGO_TRX_G || '-' || A.SIGUMGO_JI_TRX_G IN ('69-0') THEN A.TRAMT ELSE 0 END) * (DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1))) AS TXRV_SBJ_RVSN_AMT
             ,SUM((CASE WHEN GJDT >= ' 20230110' AND A.SIGUMGO_TRX_G || '-' || A.SIGUMGO_IP_TRX_G IN ('10-0','11-1','11-2','12-4','13-0') THEN A.TRAMT ELSE 0 END) * (DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)))
                  - SUM((CASE WHEN GJDT >= ' 20230110' AND A.SIGUMGO_TRX_G || '-' || A.SIGUMGO_JI_TRX_G IN ('60-0','66-0','62-4','63-0','','','','','') THEN A.TRAMT ELSE 0 END) * (DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)))
                  +SUM((CASE WHEN GJDT >= ' 20230110' AND A.SIGUMGO_TRX_G || '-' || A.SIGUMGO_IP_TRX_G IN ('15-0','16-0') THEN A.TRAMT ELSE 0 END) * (DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)))
                  - SUM((CASE WHEN GJDT >= ' 20230110' AND A.SIGUMGO_TRX_G || '-' || A.SIGUMGO_JI_TRX_G IN ('68-0') THEN A.TRAMT ELSE 0 END) * (DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)))
                  + SUM((CASE WHEN GJDT >= ' 20230110' AND A.SIGUMGO_TRX_G || '-' || A.SIGUMGO_IP_TRX_G IN ('24-0') THEN A.TRAMT ELSE 0 END) * (DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)))
                  - SUM((CASE WHEN GJDT >= ' 20230110' AND A.SIGUMGO_TRX_G || '-' || A.SIGUMGO_JI_TRX_G IN ('64-0') THEN A.TRAMT ELSE 0 END) * (DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)))
                  + SUM((CASE WHEN GJDT >= ' 20230110' AND A.SIGUMGO_TRX_G || '-' || A.SIGUMGO_IP_TRX_G IN ('19-8','19-9') THEN A.TRAMT ELSE 0 END) * (DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)))
            - SUM((CASE WHEN GJDT >= ' 20230110' AND A.SIGUMGO_TRX_G || '-' || A.SIGUMGO_JI_TRX_G IN ('69-0') THEN A.TRAMT ELSE 0 END) * (DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1))) AS TXRV_AMT
             ,SUM((CASE WHEN GJDT < ' 20230110' AND A.SIGUMGO_TRX_G || '-' || A.SIGUMGO_IP_TRX_G IN ('10-0','11-1','11-2','12-4','13-0') THEN A.TRAMT ELSE 0 END) * (DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)))
                  - SUM((CASE WHEN GJDT < ' 20230110' AND A.SIGUMGO_TRX_G || '-' || A.SIGUMGO_JI_TRX_G IN ('60-0','66-0','62-4','63-0','','','','','') THEN A.TRAMT ELSE 0 END) * (DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)))
                  +SUM((CASE WHEN GJDT < ' 20230110' AND A.SIGUMGO_TRX_G || '-' || A.SIGUMGO_IP_TRX_G IN ('15-0','16-0') THEN A.TRAMT ELSE 0 END) * (DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)))
                  - SUM((CASE WHEN GJDT < ' 20230110' AND A.SIGUMGO_TRX_G || '-' || A.SIGUMGO_JI_TRX_G IN ('68-0') THEN A.TRAMT ELSE 0 END) * (DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)))
                  + SUM((CASE WHEN GJDT >= ' 20230110' AND A.SIGUMGO_TRX_G || '-' || A.SIGUMGO_IP_TRX_G IN ('10-0','11-1','11-2','12-4','13-0') THEN A.TRAMT ELSE 0 END) * (DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)))
                  - SUM((CASE WHEN GJDT >= ' 20230110' AND A.SIGUMGO_TRX_G || '-' || A.SIGUMGO_JI_TRX_G IN ('60-0','66-0','62-4','63-0','','','','','') THEN A.TRAMT ELSE 0 END) * (DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)))
                  +SUM((CASE WHEN GJDT >= ' 20230110' AND A.SIGUMGO_TRX_G || '-' || A.SIGUMGO_IP_TRX_G IN ('15-0','16-0') THEN A.TRAMT ELSE 0 END) * (DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)))
                  - SUM((CASE WHEN GJDT >= ' 20230110' AND A.SIGUMGO_TRX_G || '-' || A.SIGUMGO_JI_TRX_G IN ('68-0') THEN A.TRAMT ELSE 0 END) * (DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)))
                  + SUM((CASE WHEN GJDT >= ' 20230110' AND A.SIGUMGO_TRX_G || '-' || A.SIGUMGO_IP_TRX_G IN ('24-0') THEN A.TRAMT ELSE 0 END) * (DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)))
                  - SUM((CASE WHEN GJDT >= ' 20230110' AND A.SIGUMGO_TRX_G || '-' || A.SIGUMGO_JI_TRX_G IN ('64-0') THEN A.TRAMT ELSE 0 END) * (DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)))
                  + SUM((CASE WHEN GJDT >= ' 20230110' AND A.SIGUMGO_TRX_G || '-' || A.SIGUMGO_IP_TRX_G IN ('19-8','19-9') THEN A.TRAMT ELSE 0 END) * (DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1)))
            - SUM((CASE WHEN GJDT >= ' 20230110' AND A.SIGUMGO_TRX_G || '-' || A.SIGUMGO_JI_TRX_G IN ('69-0') THEN A.TRAMT ELSE 0 END) * (DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1))) AS TXRV_AGGR_AMT
             , '10' AS DAY_MON_FG
             , '088' STBX_BANK_CD
        FROM ACL_SIGUMGO_SLV A, RPT_FISG_INFO_MAP C, SFI_CMM_C_DAT E
        WHERE 1=1
          AND C.GONGGEUM_GYEJWA= A.FIL_100_CTNT5
          AND E.CMM_C_NM = 'RPT자치단체코드분류'
          AND E.HRNK_CMM_DTL_C = A.SIGUMGO_ORG_C
          AND E.UPMU_HMK_1_SLV = A.ICH_SIGUMGO_GUN_GU_C
          AND E.CMM_DTL_C = C.LAF_CD
          AND NOT (A.SIGUMGO_ORG_C = 28 AND A.ICH_SIGUMGO_GUN_GU_C IN('260','710','720'))
          AND GJDT BETWEEN '20230101' AND ' 20230110'
          AND A.SIGUMGO_ORG_C = 28
          AND C.FYR = '2023'
        GROUP BY E.CMM_DTL_C, E.UPMU_HMK_3_SLV, E.UPMU_HMK_4_SLV, C.ACNT_DV_CD,  C.ACNT_DV_NM, A.SIGUMGO_ORG_C, A.ICH_SIGUMGO_GUN_GU_C
    ) A



--------------------------------------------------------------------------
-------------------------------------------------------------------------
-- 5

SELECT RPAD(NVL(A.LAF_CD, '0'), 7, ' ')
           || RPAD(NVL(A.GOF_CD, '0'), 4, ' ')
           || RPAD(NVL(A.GOF_NM, '0'), 300, ' ')
           || RPAD(NVL(A.FYR, '0'), 4, ' ')
           || RPAD(NVL(A.ACNT_DV_CD, '0'), 3, ' ')
           || RPAD(NVL(A.ACNT_DV_NM, '0'), 300, ' ')
           || RPAD(NVL(A.ACNT_YMD, '0'), 8, ' ')
           || RPAD(NVL(A.LDY_RLR_DPO_RAMT_AMT, '0'), 20, ' ')
           || RPAD(NVL(A.LDY_CASH_STG_RAMT_AMT, '0'), 20, ' ')
           || RPAD(NVL(A.LDY_RAMT_SUM_AMT, '0'), 20, ' ')
           || RPAD(NVL(A.RCVMT_CNT, '0'), 20, ' ')
           || RPAD(NVL(A.RCVMT_AMT, '0'), 20, ' ')
           || RPAD(NVL(A.GIVE_CNT, '0'), 20, ' ')
           || RPAD(NVL(A.GIVE_AMT, '0'), 20, ' ')
           || RPAD(NVL(A.RLR_DPO_RAMT_AMT, '0'), 20, ' ')
           || RPAD(NVL(A.CASH_STG_RAMT_AMT, '0'), 20, ' ')
           || RPAD(NVL(A.RAMT_SUM_AMT, '0'), 20, ' ')
           || RPAD(NVL(A.STBX_BANK_CD, '0'), 3, ' ')
           || RPAD(NVL(A.DPSV_DV_CD, '0'), 2, ' ')
           || RPAD(NVL(A.DPSV_KND_NM, '0'), 300, ' ')
           || RPAD(NVL(A.DEPT_CD, '0'), 7, ' ')
           || RPAD(NVL(A.DEPT_NM, '0'), 500, ' ')
           || RPAD(NVL(A.STBX_ECRP_ACTNO, '0'), 48, ' ')
           || RPAD(NVL(A.GCC_DEPT_CD, '0'), 7, ' ') AS DYMNSUM
FROM   (SELECT E.CMM_DTL_C AS LAF_CD,
               E.UPMU_HMK_3_SLV AS GOF_CD,
               E.UPMU_HMK_4_SLV AS GOF_NM,
               '2023' AS FYR,
               C.ACNT_DV_CD AS ACNT_DV_CD,
               C.ACNT_DV_NM AS ACNT_DV_NM,
               ' 20230110' AS ACNT_YMD,
               SUM(A.UNYONGJANAEG_JEONIL_JANAEG) AS LDY_RLR_DPO_RAMT_AMT,
               SUM(A.GONGGEUMJANAEG_JEONIL_JANAEG) AS LDY_CASH_STG_RAMT_AMT,
               SUM(A.JEONIL_JANAEG_SUM) AS LDY_RAMT_SUM_AMT,
               SUM(A.GONGGEUMJANAEG_IBGEUM_CNT) AS RCVMT_CNT,
               SUM(A.GONGGEUMJANAEG_IBGEUM_AMT) AS RCVMT_AMT,
               SUM(A.GONGGEUMJANAEG_JIGEUB_CNT) AS GIVE_CNT,
               SUM(A.GONGGEUMJANAEG_JIGEUB_AMT) AS GIVE_AMT,
               SUM(A.UNYONGJANAEG_HYEONJAE_JANAEG) AS RLR_DPO_RAMT_AMT,
               SUM(A.GONGGEUMJANAEG_HYEONJAE_JANAEG) AS CASH_STG_RAMT_AMT,
               SUM(A.HYEONJAE_JANAEG_SUM) AS RAMT_SUM_AMT,
               '088' STBX_BANK_CD,
               '' AS DPSV_DV_CD,
               '' AS DPSV_KND_NM,
               '' AS DEPT_CD,
               '' AS DEPT_NM,
               '' AS STBX_ECRP_ACTNO,
               '' AS GCC_DEPT_CD,
               '10' AS DAY_MON_FG
        FROM   (SELECT A.SIGUMGO_ORG_C GEUMGO_CODE,
                       A.ICH_SIGUMGO_GUN_GU_C GUNGU_CODE,
                       A.FIL_100_CTNT5 GONGGEUM_GYEJWA,
                       0 UNYONGJANAEG_JEONIL_JANAEG,
                       SUM(CASE WHEN GISDT < ' 20230110' THEN DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1) * (NVL(DECODE(A.IPJI_G,1,A.TRAMT,0) ,0)-NVL(DECODE(A.IPJI_G,2,A.TRAMT,0),0)) ELSE 0 END) GONGGEUMJANAEG_JEONIL_JANAEG ,
                       SUM(CASE WHEN GISDT < ' 20230110' THEN DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1) * (NVL(DECODE(A.IPJI_G,1,A.TRAMT,0) ,0)-NVL(DECODE(A.IPJI_G,2,A.TRAMT,0),0)) ELSE 0 END) JEONIL_JANAEG_SUM,
                       SUM(CASE WHEN GISDT = ' 20230110' THEN DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1) * 1 ELSE 0 END) GONGGEUMJANAEG_IBGEUM_CNT,
                       SUM(CASE WHEN GISDT = ' 20230110' THEN DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1) * NVL(DECODE(A.IPJI_G,1,A.TRAMT,0) ,0) ELSE 0 END) GONGGEUMJANAEG_IBGEUM_AMT,
                       SUM(CASE WHEN GISDT = ' 20230110' THEN DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1) * 1 ELSE 0 END) GONGGEUMJANAEG_JIGEUB_CNT,
                       SUM(CASE WHEN GISDT = ' 20230110' THEN DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1) * NVL(DECODE(A.IPJI_G,2,A.TRAMT,0),0) ELSE 0 END) GONGGEUMJANAEG_JIGEUB_AMT,
                       0 UNYONGJANAEG_HYEONJAE_JANAEG,
                       SUM(CASE WHEN GISDT <= ' 20230110' THEN DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1) * (NVL(DECODE(A.IPJI_G,1,A.TRAMT,0) ,0)-NVL(DECODE(A.IPJI_G,2,A.TRAMT,0),0)) ELSE 0 END) GONGGEUMJANAEG_HYEONJAE_JANAEG,
                       SUM(CASE WHEN GISDT <= ' 20230110' THEN DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1) * (NVL(DECODE(A.IPJI_G,1,A.TRAMT,0) ,0)-NVL(DECODE(A.IPJI_G,2,A.TRAMT,0),0)) ELSE 0 END) HYEONJAE_JANAEG_SUM
                FROM   ACL_SIGUMGO_SLV A
                WHERE  1 = 1
                  AND EXISTS (SELECT 1
                              FROM   ACL_SIGUMGO_MAS B
                              WHERE B.SIGUMGO_ORG_C = A.SIGUMGO_ORG_C
                                AND B.FIL_100_CTNT2 = A.FIL_100_CTNT5
                                AND B.SIGUMGO_AC_NM LIKE '%세입세출외현금%'
                                AND B.MNG_NO = 1)
                  AND A.GISDT <= ' 20230110'
                GROUP  BY A.SIGUMGO_ORG_C,
                          A.ICH_SIGUMGO_GUN_GU_C,
                          A.FIL_100_CTNT5
                UNION ALL
                SELECT A.GEUMGO_CODE,
                       B.ICH_SIGUMGO_GUN_GU_C,
                       A.GONGGEUM_GYEJWA,
                       SUM(CASE
                               WHEN KIJUNIL = TO_CHAR(TO_DATE( 20230110, 'YYYYMMDD') - 1, 'YYYYMMDD') THEN NVL(A.JANAEK, 0)
                               ELSE 0
                           END) UNYONGJANAEG_JEONIL_JANAEG,
                       0 GONGGEUMJANAEG_JEONIL_JANAEG,
                       SUM(CASE
                               WHEN KIJUNIL = TO_CHAR(TO_DATE( 20230110, 'YYYYMMDD') - 1, 'YYYYMMDD') THEN NVL(A.JANAEK, 0)
                               ELSE 0
                           END) JEONIL_JANAEG_SUM,
                       0 GONGGEUMJANAEG_IBGEUM_CNT,
                       0 GONGGEUMJANAEG_IBGEUM_AMT,
                       0 GONGGEUMJANAEG_JIGEUB_CNT,
                       0 GONGGEUMJANAEG_JIGEUB_AMT,
                       SUM(CASE
                               WHEN KIJUNIL = ' 20230110' THEN NVL(A.JANAEK, 0)
                               ELSE 0
                           END) UNYONGJANAEG_HYEONJAE_JANAEG,
                       0 GONGGEUMJANAEG_HYEONJAE_JANAEG,
                       SUM(CASE
                               WHEN KIJUNIL = ' 20230110' THEN NVL(A.JANAEK, 0)
                               ELSE 0
                           END) HYEONJAE_JANAEG_SUM
                FROM   RPT_UNYONG_JAN A,
                       ACL_SIGUMGO_MAS B
                WHERE  1 = 1
                  AND A.GONGGEUM_GYEJWA = B.FIL_100_CTNT2
                  AND A.GEUMGO_CODE = B.SIGUMGO_ORG_C
                  AND B.SIGUMGO_AC_NM LIKE '%세입세출외현금%'
                  AND B.MNG_NO = 1
                  AND A.KIJUNIL BETWEEN TO_CHAR(TO_DATE( 20230110, 'YYYYMMDD') - 1, 'YYYYMMDD') AND ' 20230110'
                GROUP  BY A.GEUMGO_CODE,
                          B.ICH_SIGUMGO_GUN_GU_C,
                          A.GONGGEUM_GYEJWA) A,
               ACL_SIGUMGO_MAS B,
               RPT_FISG_INFO_MAP C,
               SFI_CMM_C_DAT E
        WHERE  1 = 1
          AND A.GEUMGO_CODE = B.SIGUMGO_ORG_C
          AND A.GONGGEUM_GYEJWA = B.FIL_100_CTNT2
          AND C.GONGGEUM_GYEJWA = B.FIL_100_CTNT2
          AND B.MNG_NO = 1
          AND E.CMM_C_NM = 'RPT자치단체코드분류'
          AND E.HRNK_CMM_DTL_C = A.GEUMGO_CODE
          AND E.UPMU_HMK_1_SLV = A.GUNGU_CODE
          AND E.CMM_DTL_C = C.LAF_CD(+)
          AND NOT ( A.GEUMGO_CODE = 28
            AND A.GUNGU_CODE IN( '260', '710', '720' ) )
          AND A.GEUMGO_CODE = 28
          AND C.FYR = '2023'
        GROUP  BY E.CMM_DTL_C,
                  E.UPMU_HMK_3_SLV,
                  E.UPMU_HMK_4_SLV,
                  C.ACNT_DV_CD,
                  C.ACNT_DV_NM,
                  A.GEUMGO_CODE,
                  A.GUNGU_CODE) A



--------------------------------------------------------------------------
-------------------------------------------------------------------------
-- 6

SELECT RPAD(NVL(A.LAF_CD, '0'), 7, ' ')
           || RPAD(NVL(A.GOF_CD, '0'), 4, ' ')
           || RPAD(NVL(A.GOF_NM, '0'), 300, ' ')
           || RPAD(NVL(A.FYR, '0'), 4, ' ')
           || RPAD(NVL(A.ACNT_DV_CD, '0'), 3, ' ')
           || RPAD(NVL(A.ACNT_DV_NM, '0'), 300, ' ')
           || RPAD(NVL(A.ACNT_YMD, '0'), 8, ' ')
           || RPAD(NVL(A.LDY_RLR_DPO_RAMT_AMT, '0'), 20, ' ')
           || RPAD(NVL(A.LDY_CASH_STG_RAMT_AMT, '0'), 20, ' ')
           || RPAD(NVL(A.LDY_RAMT_SUM_AMT, '0'), 20, ' ')
           || RPAD(NVL(A.RCVMT_CNT, '0'), 20, ' ')
           || RPAD(NVL(A.RCVMT_AMT, '0'), 20, ' ')
           || RPAD(NVL(A.GIVE_CNT, '0'), 20, ' ')
           || RPAD(NVL(A.GIVE_AMT, '0'), 20, ' ')
           || RPAD(NVL(A.RLR_DPO_RAMT_AMT, '0'), 20, ' ')
           || RPAD(NVL(A.CASH_STG_RAMT_AMT, '0'), 20, ' ')
           || RPAD(NVL(A.RAMT_SUM_AMT, '0'), 20, ' ')
           || RPAD(NVL(A.STBX_BANK_CD, '0'), 3, ' ')
           || RPAD(NVL(A.DPSV_DV_CD, '0'), 2, ' ')
           || RPAD(NVL(A.DPSV_KND_NM, '0'), 300, ' ')
           || RPAD(NVL(A.DEPT_CD, '0'), 7, ' ')
           || RPAD(NVL(A.DEPT_NM, '0'), 500, ' ')
           || RPAD(NVL(A.STBX_ECRP_ACTNO, '0'), 48, ' ')
           || RPAD(NVL(A.GCC_DEPT_CD, '0'), 7, ' ') AS DYMNSUM
FROM   (SELECT E.CMM_DTL_C AS LAF_CD,
               E.UPMU_HMK_3_SLV AS GOF_CD,
               E.UPMU_HMK_4_SLV AS GOF_NM,
               '2023' AS FYR,
               C.ACNT_DV_CD AS ACNT_DV_CD,
               C.ACNT_DV_NM AS ACNT_DV_NM,
               ' 20230110' AS ACNT_YMD,
               SUM(A.UNYONGJANAEG_JEONIL_JANAEG) AS LDY_RLR_DPO_RAMT_AMT,
               SUM(A.GONGGEUMJANAEG_JEONIL_JANAEG) AS LDY_CASH_STG_RAMT_AMT,
               SUM(A.JEONIL_JANAEG_SUM) AS LDY_RAMT_SUM_AMT,
               SUM(A.GONGGEUMJANAEG_IBGEUM_CNT) AS RCVMT_CNT,
               SUM(A.GONGGEUMJANAEG_IBGEUM_AMT) AS RCVMT_AMT,
               SUM(A.GONGGEUMJANAEG_JIGEUB_CNT) AS GIVE_CNT,
               SUM(A.GONGGEUMJANAEG_JIGEUB_AMT) AS GIVE_AMT,
               SUM(A.UNYONGJANAEG_HYEONJAE_JANAEG) AS RLR_DPO_RAMT_AMT,
               SUM(A.GONGGEUMJANAEG_HYEONJAE_JANAEG) AS CASH_STG_RAMT_AMT,
               SUM(A.HYEONJAE_JANAEG_SUM) AS RAMT_SUM_AMT,
               '088' STBX_BANK_CD,
               '' AS DPSV_DV_CD,
               '' AS DPSV_KND_NM,
               '' AS DEPT_CD,
               '' AS DEPT_NM,
               '' AS STBX_ECRP_ACTNO,
               '' AS GCC_DEPT_CD,
               '10' AS DAY_MON_FG
        FROM   (SELECT A.SIGUMGO_ORG_C GEUMGO_CODE,
                       A.ICH_SIGUMGO_GUN_GU_C GUNGU_CODE,
                       A.FIL_100_CTNT5 GONGGEUM_GYEJWA,
                       0 UNYONGJANAEG_JEONIL_JANAEG,
                       SUM(CASE WHEN GISDT < ' 20230110' THEN DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1) * (NVL(DECODE(A.IPJI_G,1,A.TRAMT,0) ,0)-NVL(DECODE(A.IPJI_G,2,A.TRAMT,0),0)) ELSE 0 END) GONGGEUMJANAEG_JEONIL_JANAEG ,
                       SUM(CASE WHEN GISDT < ' 20230110' THEN DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1) * (NVL(DECODE(A.IPJI_G,1,A.TRAMT,0) ,0)-NVL(DECODE(A.IPJI_G,2,A.TRAMT,0),0)) ELSE 0 END) JEONIL_JANAEG_SUM,
                       SUM(CASE WHEN GISDT = ' 20230110' THEN DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1) * 1 ELSE 0 END) GONGGEUMJANAEG_IBGEUM_CNT,
                       SUM(CASE WHEN GISDT = ' 20230110' THEN DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1) * NVL(DECODE(A.IPJI_G,1,A.TRAMT,0) ,0) ELSE 0 END) GONGGEUMJANAEG_IBGEUM_AMT,
                       SUM(CASE WHEN GISDT = ' 20230110' THEN DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1) * 1 ELSE 0 END) GONGGEUMJANAEG_JIGEUB_CNT,
                       SUM(CASE WHEN GISDT = ' 20230110' THEN DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1) * NVL(DECODE(A.IPJI_G,2,A.TRAMT,0),0) ELSE 0 END) GONGGEUMJANAEG_JIGEUB_AMT,
                       0 UNYONGJANAEG_HYEONJAE_JANAEG,
                       SUM(CASE WHEN GISDT <= ' 20230110' THEN DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1) * (NVL(DECODE(A.IPJI_G,1,A.TRAMT,0) ,0)-NVL(DECODE(A.IPJI_G,2,A.TRAMT,0),0)) ELSE 0 END) GONGGEUMJANAEG_HYEONJAE_JANAEG,
                       SUM(CASE WHEN GISDT <= ' 20230110' THEN DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1) * (NVL(DECODE(A.IPJI_G,1,A.TRAMT,0) ,0)-NVL(DECODE(A.IPJI_G,2,A.TRAMT,0),0)) ELSE 0 END) HYEONJAE_JANAEG_SUM
                FROM   ACL_SIGUMGO_SLV A
                WHERE  1 = 1
                  AND EXISTS (SELECT 1
                              FROM   ACL_SIGUMGO_MAS B
                              WHERE B.SIGUMGO_ORG_C = A.SIGUMGO_ORG_C
                                AND B.FIL_100_CTNT2 = A.FIL_100_CTNT5
                                AND B.SIGUMGO_AC_NM LIKE '%세입세출외현금%'
                                AND B.MNG_NO = 1)
                  AND A.GISDT <= ' 20230110'
                GROUP  BY A.SIGUMGO_ORG_C,
                          A.ICH_SIGUMGO_GUN_GU_C,
                          A.FIL_100_CTNT5
                UNION ALL
                SELECT A.GEUMGO_CODE,
                       B.ICH_SIGUMGO_GUN_GU_C,
                       A.GONGGEUM_GYEJWA,
                       SUM(CASE
                               WHEN KIJUNIL = TO_CHAR(TO_DATE( 20230110, 'YYYYMMDD') - 1, 'YYYYMMDD') THEN NVL(A.JANAEK, 0)
                               ELSE 0
                           END) UNYONGJANAEG_JEONIL_JANAEG,
                       0 GONGGEUMJANAEG_JEONIL_JANAEG,
                       SUM(CASE
                               WHEN KIJUNIL = TO_CHAR(TO_DATE( 20230110, 'YYYYMMDD') - 1, 'YYYYMMDD') THEN NVL(A.JANAEK, 0)
                               ELSE 0
                           END) JEONIL_JANAEG_SUM,
                       0 GONGGEUMJANAEG_IBGEUM_CNT,
                       0 GONGGEUMJANAEG_IBGEUM_AMT,
                       0 GONGGEUMJANAEG_JIGEUB_CNT,
                       0 GONGGEUMJANAEG_JIGEUB_AMT,
                       SUM(CASE
                               WHEN KIJUNIL = ' 20230110' THEN NVL(A.JANAEK, 0)
                               ELSE 0
                           END) UNYONGJANAEG_HYEONJAE_JANAEG,
                       0 GONGGEUMJANAEG_HYEONJAE_JANAEG,
                       SUM(CASE
                               WHEN KIJUNIL = ' 20230110' THEN NVL(A.JANAEK, 0)
                               ELSE 0
                           END) HYEONJAE_JANAEG_SUM
                FROM   RPT_UNYONG_JAN A,
                       ACL_SIGUMGO_MAS B
                WHERE  1 = 1
                  AND A.GONGGEUM_GYEJWA = B.FIL_100_CTNT2
                  AND A.GEUMGO_CODE = B.SIGUMGO_ORG_C
                  AND B.SIGUMGO_AC_NM LIKE '%세입세출외현금%'
                  AND B.MNG_NO = 1
                  AND A.KIJUNIL BETWEEN TO_CHAR(TO_DATE( 20230110, 'YYYYMMDD') - 1, 'YYYYMMDD') AND ' 20230110'
                GROUP  BY A.GEUMGO_CODE,
                          B.ICH_SIGUMGO_GUN_GU_C,
                          A.GONGGEUM_GYEJWA) A,
               ACL_SIGUMGO_MAS B,
               RPT_FISG_INFO_MAP C,
               SFI_CMM_C_DAT E
        WHERE  1 = 1
          AND A.GEUMGO_CODE = B.SIGUMGO_ORG_C
          AND A.GONGGEUM_GYEJWA = B.FIL_100_CTNT2
          AND C.GONGGEUM_GYEJWA = B.FIL_100_CTNT2
          AND B.MNG_NO = 1
          AND E.CMM_C_NM = 'RPT자치단체코드분류'
          AND E.HRNK_CMM_DTL_C = A.GEUMGO_CODE
          AND E.UPMU_HMK_1_SLV = A.GUNGU_CODE
          AND E.CMM_DTL_C = C.LAF_CD(+)
          AND NOT ( A.GEUMGO_CODE = 28
            AND A.GUNGU_CODE IN( '260', '710', '720' ) )
          AND A.GEUMGO_CODE = 28
          AND C.FYR = '2023'
        GROUP  BY E.CMM_DTL_C,
                  E.UPMU_HMK_3_SLV,
                  E.UPMU_HMK_4_SLV,
                  C.ACNT_DV_CD,
                  C.ACNT_DV_NM,
                  A.GEUMGO_CODE,
                  A.GUNGU_CODE) A


--------------------------------------------------------------------------
-------------------------------------------------------------------------
-- 13

SELECT RPAD(NVL(A.LAF_CD, '0'), 7, ' ')
           || RPAD(NVL(A.FYR, '0'), 4, ' ')
           || RPAD(NVL(A.ACNT_DV_CD, '0'), 3, ' ')
           || RPAD(NVL(A.GOF_CD, '0'), 4, ' ')
           || RPAD(NVL(A.GCC_DEPT_CD, '0'), 7, ' ')
           || RPAD(NVL(A.EXE_YM, '0'), 6, ' ')
           || RPAD(NVL(A.ACC_SNUM, '0'), 10, ' ')
           || RPAD(NVL(A.DPI_ECRP_ACTNO, '0'), 48, ' ')
           || RPAD(NVL(A.ACNT_DV_NM, '0'), 300, ' ')
           || RPAD(NVL(A.LAF_NM, '0'), 500, ' ')
           || RPAD(NVL(A.GOF_NM, '0'), 300, ' ')
           || RPAD(NVL(A.DEPT_CD, '0'), 7, ' ')
           || RPAD(NVL(A.DEPT_NM, '0'), 500, ' ')
           || RPAD(NVL(A.RAMT_AMT, '0'), 20, ' ')
           || RPAD(NVL(A.DATA_RCTN_YN, '0'), 1, ' ')
           || RPAD(NVL(A.DATA_RCTN_DT, '0'), 14, ' ')
           || RPAD(NVL(A.RTN_RSLT_PRCS_STAT_CD, '0'), 1, ' ')
           || RPAD(NVL(A.RSLT_PRCS_USR_ID, '0'), 20, ' ')
           || RPAD(NVL(A.PRCS_RSLT_RCTN_DT, '0'), 14, ' ')
           || RPAD(NVL(A.STBX_BANK_CD, '0'), 3, ' ') AS DYMNSUM
FROM   (SELECT D.CMM_DTL_C AS LAF_CD,
               A.HOIGYE_YEAR AS FYR,
               C.ACNT_DV_CD AS ACNT_DV_CD,
               D.UPMU_HMK_3_SLV AS GOF_CD,
               '0010' AS GCC_DEPT_CD,
               SUBSTR(A.KEORAEIL, 1, 6) AS EXE_YM,
               B.FIL_100_CTNT2 AS ACC_SNUM,
               '' AS DPI_ECRP_ACTNO,
               C.ACNT_DV_NM AS ACNT_DV_NM,
               D.CMM_DTL_C_NM AS LAF_NM,
               D.UPMU_HMK_4_SLV AS GOF_NM,
               '' AS DEPT_CD,
               '' AS DEPT_NM,
               A.JANAEK AS RAMT_AMT,
               '' AS DATA_RCTN_YN,
               '' AS DATA_RCTN_DT,
               '' AS RTN_RSLT_PRCS_STAT_CD,
               '' AS RSLT_PRCS_USR_ID,
               '' AS PRCS_RSLT_RCTN_DT,
               '088' AS STBX_BANK_CD
        FROM   RPT_GONGGEUM_JAN A,
               ACL_SIGUMGO_MAS  B,
               RPT_FISG_INFO_MAP C,
               SFI_CMM_C_DAT D
        WHERE  A.GONGGEUM_GYEJWA = B.FIL_100_CTNT2
          AND A.GEUMGO_CODE = 28
          AND B.SIGUMGO_AC_B = 25
          AND C.GONGGEUM_GYEJWA = B.FIL_100_CTNT2
          AND C.FYR = '2023'
          AND D.CMM_C_NM = 'RPT자치단체코드분류'
          AND D.HRNK_CMM_DTL_C = A.GEUMGO_CODE
          AND D.CMM_DTL_C = C.LAF_CD
          AND B.ICH_SIGUMGO_GUN_GU_C = ( CASE WHEN D.UPMU_HMK_1_SLV = '000' THEN '0' ELSE D.UPMU_HMK_1_SLV END )
          AND B.MNG_NO = 1
          AND A.KEORAEIL = (
            SELECT BIZ_DT
            FROM   MAP_JOB_DATE
            WHERE  DW_BAS_DDT = TO_CHAR(TO_DATE(SUBSTR('20230101', 1, 6)||'01') - 1, 'yyyymmdd'))
       ) A

--------------------------------------------------------------------------
