MERGE INTO SFIOWN.SFI_TXIO_DDAC_TAB A
USING (
    WITH PROC_LST AS
                (SELECT SGS.FIL_100_CTNT5 AS SIGUMGO_ACNO, SGS.TRXDT
                 FROM SFIOWN.ACL_SIGUMGO_SLV SGS
                 WHERE (
                     (SGS.TRXDT BETWEEN :TRXFDT AND :TRXDT)
                         OR (SGS.LST_CDT BETWEEN :TRXFDT AND :TRXDT)
                         -- UPD_DTTM 경우에만 시분초를 고려해서 범위를 설정
                         OR (SGS.UPD_DTTM BETWEEN :TRXFDT AND :TRXDT || '235959')
                     )
                   -- 정보변경이 일어난 시간이 특정 시점 이전임경우로 대상을 제한(최종 업데이트 시점 이후의 시간으로 해야하지 않나?.......)
                   -- BSFITxioDDACTab에서는 UPD_DTTM에 currentDate 데이터를 매핑해줌
                   AND SGS.UPD_DTTM <= :UPD_DTTM
                   -- 최소 단위가 회계단위인듯
                   AND (:HOKYE_C = '-1' OR SGS.ICH_SIGUMGO_HOIKYE_C = :HOKYE_C)
                 GROUP BY SGS.FIL_100_CTNT5, SGS.TRXDT
                 UNION
                 SELECT SGS.SIGUMGO_ACNO, SGS.TRXDT AS PROC_DT
                 FROM SFIOWN.ACL_SGGHANDO_SLV SGS
                 WHERE (
                     (SGS.TRXDT BETWEEN :TRXFDT AND :TRXDT)
                         OR (SGS.LST_CDT BETWEEN :TRXFDT AND :TRXDT)
                         OR (SGS.UPD_DTTM BETWEEN :TRXFDT AND :TRXDT || '235959')
                     )
                   AND SGSG.UPD_DTTM <= :UPD_DTTM
                   AND (:HOKYE_C = '-1' OR SGS.ICH_SIGUMGO_HOIKYE_C = :HOKYE_C)
                 GROUP BY SGS.SIGUMGO_ACNO, SGS.TRXDT),
            SLVTOT_DATA AS
                (SELECT SGS.*
                      , (SGS.TAX_IP_AMT + SGS.TAX_IP_CRT_AMT - SGS.GWAON_AMT - SGS.GWAON_CRT_AMT)           AS SUB_TAX_IP_AMT
                      , (SGS.TAX_IP_JKNP_AMT + SGS.TAX_IP_CRT_JKNP_AMT - SGS.GWAON_AMT -
                         SGS.GWAON_CRT_AMT)                                                                 AS SUB_TAX_IP_JKNP_AMT
                      , (SGS.HNDO_BASEJUNG - SGS.HNDO_USE_AMT)                                              AS REMD_HNDO_AMT
                      , (SGS.TAXO_FUND_BAEJUNG_AMT + SGS.TAXO_JIBUL_AMT +
                         SGS.JEONBU_AMT_TDAY_DDAC_AMT)                                                      AS JICHUL_AMT
                      , ((SGS.TAXO_FUND_BAEJUNG_AMT + SGS.TAXO_JIBUL_AMT + SGS.JEONBU_AMT_TDAY_DDAC_AMT) -
                         SGS.RTRN_AMT)                                                                      AS JICHUL_SAMT
                      , (SGS.MVI_AMT - SGS.MVO_AMT)                                                         AS MVO_DDAC_AMT
                      , ((SGS.MVI_AMT - SGS.MVO_AMT) + SGS.DTTM_CHAIP_DDAC_AMT -
                         SGS.GA_IWOL_DDAC_AMT)                                                              AS JEONYONG_TOT_DDAC_AMT
                      , (SGS.MK_DDAC_AMT - SGS.HJI_DDAC_AMT)                                                AS TDEP_AMT
                      , (SGS.MMDA_MKAMT - SGS.MMDA_HJI_AMT)                                                 AS MMDA_MK_HJI_AMT
                      , (SGS.TDEP_MKAMT - STGS.TDEP_HJI_AMT)                                                AS TDEP_MK_HJI_AMT
                      , (SGS.ZP_JIAMT - SGS.ZP_CLRAMT)                                                      AS ZP_HABSAN_AMT
                      , (SGS.CHCK_JIAMT - SGS.CKCD_CLRAMT)                                                  AS CHCK_HABSAN_AMT
                      , (SGS.BD_DEP_IPAMT - SGS.BD_DEP_JIAMT)                                               AS BD_DEP_JAN_AMT
                      , (SGS.KEEP_TDEP_IPAMT - SGS.KEEP_TDEP_JIAMT)                                         AS KEEP_FXTM_JAN_AMT
                 FROM (SELECT SGS.SGG_ACNO
                            , SGS.PROC_DT
                            , SGS.BAS_DT
                            , SGS.GISDT
                            , SUM(SGS.CSH_AMT)    AS CSH_JKBUL_AMT
                            , SUM(CASE
                                      WHEN TCD.HRNK_CMM_DTL_C = '세입' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                                      ELSE 0 END) AS TAX_IP_AMT
                            , SUM(CASE
                                      WHEN TCD.HRNK_CMM_DTL_C = '세입정정' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                                      ELSE 0 END) AS TAX_IP_CRT_AMT
                            , SUM(CASE
                                      WHEN TCD.HRNK_CMM_DTL_C = '세입' AND SGS.SIGUMGO_SUNP_TRX_G = 0
                                          THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                                      ELSE 0 END) AS TAX_IP_JKNP_AMT
                            , SUM(CASE
                                      WHEN TCD.HRNK_CMM_DTL_C = '세입정정' AND SGS.SIGUMGO_SUNP_TRX_G = 0
                                          THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                                      ELSE 0 END) AS TAX_IP_CRT_JKNP_AMT
                            , SUM(CASE
                                      WHEN TCD.HRNK_CMM_DTL_C = '과오납환불' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                                      ELSE 0 END) AS GWAON_AMT
                            , SUM(CASE
                                      WHEN TCD.HRNK_CMM_DTL_C = '과오납환불정정' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                                      ELSE 0 END) AS GWAON_CRT_AMT
                            , SUM(CASE
                                      WHEN TCD.HRNK_CMM_DTL_C = '자금배정지출' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                                      ELSE 0 END) AS TAXO_FUND_BAEJUNG_AMT
                            , SUM(CASE
                                      WHEN TCD.HRNK_CMM_DTL_C = '자금지출' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                                      ELSE 0 END) AS TAXO_JIBUL_AMT
                            , SUM(CASE
                                      WHEN TCD.HRNK_CMM_DTL_C = '자금반납' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                                      ELSE 0 END) AS RTRN_AMT
                            , SUM(CASE
                                      WHEN TCD.HRNK_CMM_DTL_C = '자금전부금'
                                          THEN SGS.TRAMT * TO_NUMBER납TCD.UPMU_HMK_5_SLV) ELSE 0 END) AS JEONBU_AMT_TDAY_DDAC_AMT
                    , SUM(CASE
                              WHEN TCD.HRNK_CMM_DTL_C = '이월지급' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                              ELSE 0 END) AS GA_IWOL_DDAC_AMT
                    , SUM(CASE
                              WHEN TCD.HRNK_CMM_DTL_C IN ('MMDA신규', '정기예금신규')
                                  THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                              ELSE 0 END) AS MK_DDAC_AMT
                    , SUM(CASE
                              WHEN TCD.HRNK_CMM_DTL_C IN ('MMDA해지', '정기예금해지')
                                  THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                              ELSE 0 END) AS HJI_DDAC_AMT
                    , SUM(CASE
                              WHEN TCD.HRNK_CMM_DTL_C = '정기예금신규' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                              ELSE 0 END) AS TDEP_MKAMT
                    , SUM(CASE
                              WHEN TCD.HRNK_CMM_DTL_C = '정기예금해지' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                              ELSE 0 END) AS TDEP_HJI_AMT
                    , SUM(CASE
                              WHEN TCD.HRNK_CMM_DTL_C = 'MMDA신규' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                              ELSE 0 END) AS MMDA_MKAMT
                    , SUM(CASE
                              WHEN TCD.HRNK_CMM_DTL_C = 'MMDA해지' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                              ELSE 0 END) AS MMDA_HJI_AMT
                    , SUM(CASE
                              WHEN TCD.HRNK_CMM_DTL_C = '전용자금지급' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                              ELSE 0 END) AS MVO_AMT
                    , SUM(CASE
                              WHEN TCD.HRNK_CMM_DTL_C = '전용자금환입' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                              ELSE 0 END) AS MVI_AMT
                    , SUM(CASE
                              WHEN TCD.HRNK_CMM_DTL_C = '일시차입금금' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                              ELSE 0 END) AS DTTM_CHAIP_DDAC_AMT
                    , SUM(CASE
                              WHEN TCD.CMM_DTL_C_NM = '제로페이지급' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                              ELSE 0 END) AS ZP_JIAMT
                    , SUM(CASE
                              WHEN TCD.CMM_DTL_C_NM = '제로페이환입' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                              ELSE 0 END) AS ZP_CLRAMT
                    , SUM(CASE
                              WHEN TCD.CMM_DTL_C_NM = '체크카드지급' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                              ELSE 0 END) AS CKCD_JIAMT
                    , SUM(CASE
                              WHEN TCD.CMM_DTL_C_NM = '체크카드환입' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                              ELSE 0 END) AS CKCD_CLRAMT
                    , SUM(CASE
                              WHEN TCD.HRNK_CMM_DTL_C = '한도배정' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                              ELSE 0 END) AS HNDO_BASEJUNG_AMT
                    , SUM(CASE
                              WHEN TCD.HRNK_CMM_DTL_C = '한도사용' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                              ELSE 0 END) AS HNDO_USE_AMT
                    , SUM(CASE
                              WHEN TCD.CMM_DTL_C_NM IN ('가이월입금' '본이월입금' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV) ELSE 0 END) AS
                          KS_TRNS_IP_AMT
                     , SUM(CASE
                               WHEN TCD.HRNK_CMM_DTL_C = '시금고한도배정거래' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                               ELSE 0 END) AS FUND_BAEJUNG_AMT
                     , SUM(CASE
                               WHEN TCD.HRNK_CMM_DTL_C = '시금고한도환수거래' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                               ELSE 0 END) AS FUND_GETBK_AMT
                     , SUM(CASE
                               WHEN TCD.HRNK_CMM_DTL_C = '시금고본청지출거래' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                               ELSE 0 END) AS FUND_JICHUL_AMT
                     , SUM(CASE
                               WHEN TCD.HRNK_CMM_DTL_C = '시금고본청반납거래' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                               ELSE 0 END) AS FUND_RTRN_AMT
                     , SUM(CASE
                               WHEN TCD.CMM_DTL_C_NM = '정기예금이자' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                               ELSE 0 END) AS TDEP_INT_AMT
                     , SUM(CASE
                               WHEN TCD.CMM_DTL_C_NM = '공금예금이자' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                               ELSE 0 END) AS PMNY_INT_AMT
                     , SUM(CASE
                               WHEN TCD.CMM_DTL_C_NM = '보통예금이자' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                               ELSE 0 END) AS BTDEP_INT_AMT
                     , SUM(CASE
                               WHEN TCD.CMM_DTL_C_NM = 'MMDA이자' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                               ELSE 0 END) AS MMDA_INT_AMT
                     , SUM(CASE
                               WHEN TCD.CMM_DTL_C_NM = '기타예금이자' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                               ELSE 0 END) AS ETC_DEP_INT_AMT
                     , SUM(CASE
                               WHEN TCD.CMM_DTL_C_NM = '별단예금지급(보관금)' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                               ELSE 0 END) AS BD_DEP_JIAMT
                     , SUM(CASE
                               WHEN TCD.CMM_DTL_C_NM = '별단예금입금(보관금)' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                               ELSE 0 END) AS BD_DEP_IPAMT
                     , SUM(CASE
                               WHEN TCD.CMM_DTL_C_NM = '정기예금해지(보관금)' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                               ELSE 0 END) AS KEEP_TDEP_JIAMT
                     , SUM(CASE
                               WHEN TCD.CMM_DTL_C_NM = '정기예금신규(보관금)' THEN SGS.TRAMT * TO_NUMBER(TCD.UPMU_HMK_5_SLV)
                               ELSE 0 END) AS KEEP_TDEP_IPAMT
                     , MAX(SGS.UPD_DTTM) AS UPD_DTTM
                          FROM
                          (SELECT SGS.FIL_100_CTNT5                                   AS SGG_ACNO
                                , SGG.TRXDT                                           AS PROC_DT
                                , SGG.GISDT                                           AS GISDT
                                -- 금통은 신구년도 구분 개념이 아니고 0, 1, 2 이렇게 있으며 전월 또는 전전월 마지막 일자를 구하기 위해서 사용함.( 인천에서는 그대로 적용할 수 없음)
                                -- BAS_DT 는 NEW_GU_YR 가 1, 2 인 경우에는 전월말, 전전월말로 적용됨.
                                , CASE
                                      WHEN SGS.SIGUMGO_AC_B = 10 AND SGS.NEW_GU_YR > 0
                                     THEN TO_CHAR(
                                              LAST_DAY(
                                                      ADD_MONTHS(
                                                              TO_DATE(
                                                                      CASE
                                                                          WHEN SGS.SIGUMGO_HOIKYE_YR >= 2023 THEN SGS.GISDT
                                                                          ELSE SGS.TRXDT END
                                                               ,'YYYYMMDD'),
                                                              - SGS.NEW_GU_YR_G
                                                      )
                                              ),
                                           'YYYYMMDD')
                                      ELSE SGS.GISDT END                             AS BAS_DT
                                , LAPD(SGS.SIGUMGO_TRX_G, 2, '0') || LAPD(SGS.SIGUMGO_IP_TRX_G, 2, '0') ||
                                  LAPD(SGS.SIGUMGO_JI_TRX_G, 2, '0')                  AS KIND_CD
                                , SGS.SIGUMGO_SUNP_TRX_G
                                , SUM(SGS.FIL_18_AMT1 * DECODE(SGS.CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) *
                                      DECODE(SGS.IPJI_G, 1, 1, -1))                   AS CSH_AMT
                                , SUM(SGS.TRAMT * DECODE(SGS.CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) *
                                      DECODE(SGS.IPJI_G, 1, 1, -1))                   AS TRAMT
                                -- 실제 데이터 변경 시점이 아닌 통단의 데이터 변경시점을 변경시점으로 보고 있음
                                , MAX(SGS.LST_CDT || NVL(SGS.LST_CHG_TIME, '000000')) AS UPD_DTTM
                           FROM SFIOWN.ACL_SIGUMGO_SLV SGS
                                    INNER JOIN PROC_LST PCL
                                               ON SGS.FIL_100_CTNT5 = PCL.SIGUMGO_ACNO
                                                   AND SGS.TRXDT = PCL.TRXDT
                           WHERE SGS_UPD_DTTM < :UPD_DTTM
                           GROUP BY SGS.FIL_100_CTNT5, SGG.TRXDT, SGG_GISDT,
                                    CASE
                                        WHEN SGS.SIGUMGO_AC_B = 10 ANS SGS.NEW_GU_YR > 0
                                     THEN TO_CHAR(LAST_DAY(ADD_MONTHS(TO_DATE(CASE
                                                                                                                                                     WHEN SGS.SIGUMGO_HOIKYE_YR >= 2023
                                                                                                                                                         THEN SGS.GISDT
                                                                                                                                                     ELSE SGS.TRXDT END,
                                                                              'YYYYMMDD'), - SGS.NEW_GU_YR)),
                                                  'YYYYMMDD')
                                        ELSE SGS.GISDT END,
                                    SGS.SIGUMGO_TRX_G, SGS.SIGUMGO_IP_TRX_G, SGS.SIGUMGO_JI_TRX_G,
                                    SGS.SIGUMGO_SUNP_TRX_G, SGS.NEW_GU_YR_G
                           UNION ALL
                           SELECT SGS.SIGUMGO_ACNO                                               AS SGG_ACNO
                                , SGS.TRXDT                                                      AS PROC_DT
                                , SGS.GISDT                                                      AS GISDT
                                , SGS.GISDT                                                      AS BAS_DT
                                , LAPD(SGS.SIGUMGO_TRX_G, 2, '0') || LAPD(SGS.FIL_5_NO3, 2, '0') AS KIND_CD
                                , 0                                                              AS SIGUMGO_SUNP_TRX_G
                                , 0                                                              AS CSH_AMT
                                , SUM(SGS.TRAMT * DECODE(SGS.CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) *
                                      DECODE(SGS.IPJI_G, 1, 1, -1))                              AS TRAMT
                                , MAX(SGS.LST_CDT || NVL(SGS.LST_CHG_TIME, '000000'))            AS UPD_DTTM
                           FROM SFIOWN.ACL_SGGHANDO_SLV SGS
                                    INNER JOIN PROC_LST PCL
                                               ON SGS.SIGUMGO_ACNO = PCL.SIGUMGO_ACNO
                                                   AND SGS.TRXDT = PCL.TRXDT
                           WHERE SGS.UPD_DTTM < :UPD_DTTM
                           GROUP BY SGS.SIGUMGO_ACNO, SGS.TRXDT, SGS.GISDT, SGS.SIGUMGO_TRX_G, SGS.FIL_5_NO3) SGS
                          INNER JOIN CTMOWN.CTM_CMM_C_DAT TCD
                          ON TCD.CMM_C_NM = '세입세출자금일계표집계용'
                              AND SGS.KIND_CD = TCD.CMM_DTL_C
                              AND TCD.USE_YN = 'Y'
                          LEFT OUTER JOIN CTMOWN.CTM_CMM_C_DAT HCD
                          ON HCD.CMM_C_NM = '회계별자금배정및지출현황집계용'
                              AND SGS.KIND_CD = HCD.CMM_DTL_C
                              AND HCD.USE_YN = 'Y'
                          GROUP BY SGS.SGG_ACNO, SGS.PROC_DT, SGS.GISDT, SGS.BAS_DT
                      ) SGS)
       SELECT SGS.SGG_ACNO
            , SGS.PROC_DT
            , SGS.BAS_DT
            , SGS.GISDT
            , 1                                                                                                 AS DR_SNO
            , SGM.SIGUMGO_HOIKYE_YR                                                                             AS HOIKYE_YEAR
            , SGM.PADM_STD_ORG_C
            , SGM_SIGUMGO_CHNGS_C                                                                               AS CHNGS_C
            , TO_CHAR(SGM.SIGUMGO_HOIKYE_C)                                                                     AS SL_GMGO_HOIKYE_C
            , SGM_SIGUMGO_HOIKYE_NO                                                                             AS HOIKYE_NO
            , CASE
                  WHEN SGM.SIGUMGO_HOIKYE_C < 50 THEN '1'
                  WHEN SGM.SIGUMGO_HOIKYE_C = 90 THEN '3'
                  ELSE '2' END                                                                                  AS SIGUTAX_G
            , TO_CHAR(SGM.SIGUMGO_AGE_AC_G)                                                                     AS AGE_AC_G
            , SGS.TAX_IP_AMT
            , SGS.TAX_IP_CRT_AMT
            , SGS.TAX_IP_JKNP_AMT
            , SGS.TAX_IP_CRT_JKNP_AMT
            , SGS.GWAON_AMT
            , SGS.GWAON_CRT_AMT
            , SGS.KS_TRNS_IP_AMT
            , SGS.SUB_TAX_IP_AMT
            , SGS.SUB_TAX_IP_AMT                                                                                AS TAX_IP_DDAC_AMT
            , SGS.SUB_TAX_IP_JKNP_AMT
            , SGS.HNDO_BAEJUNG_AMT
            , SGS.HNDO_USE_AMT
            , SGS.REMDR_HNDO_AMT
            , SGS.FUND_BAEJUNG_AMT
            , SGS.FUND_GETBK_AMT
            , SGS.FUND_JICHUL_AMT
            , SGS.FUND_RTRN_AMT
            , SGS.CSH_JKBUL_AMT
            , SGS.TAXO_FUND_BAEJUNG_AMT
            , SGS.TAXO_JIBUL_AMT
            , SGS.JICHUL_AMT
            , SGS.RTRN_AMT
            , SGS.JEONBU_AMT_TDAY_DDAC_AMT
            , SGS.JICHUL_SAMT
            , (SGS.SUB_TAX_IP_AMT - SGS.JICHUL_SAMT)                                                            AS PMNY_DEP_AMT
            , SGS.MK_DDAC_AMT
            , SGS.HJI_DDAC_AMT
            , SGS.TDEP_AMT
            , SGS.TDEP_MKAMT
            , SGS.TDEP_HJI_AMT
            , SGS.TDEP_MK_HJI_AMT
            , SGS.MMDA_MKAMT
            , SGS.MMDA_HJI_AMT
            , SGS.MMDA_MK_HJI_AMT
            , SGS.BD_DEP_JIAMT
            , SGS.BD_DEP_IPAMT
            , SGS.BD_DEP_JAN_AMT
            , SGS.KEEP_TDEP_JIAMT
            , SGS.KEEP_TDEP_IPAMT
            , SGS.KEEP_FXTM_JAN_AMT
            , SGS.ZP_JIAMT
            , SGS.ZP_CLRAMT
            , SGS.ZP_HABSAN_AMT
            , SGS.CKCD_JIAMT
            , SGS.CKCD_CLRAMT
            , SGS.CKCD_HABSAN_AMT
            , (((SGS.SUB_TAX_IP_AMT - SGS.JICHUL_SAMT) + SGS.JEONYONG_TOT_DDAC_AMT) - SGS.TDEP_AMT - SGS.ZP_HABSAN_AMT -
               SGS.CKCD_HABSAN_AMT)                                                                             AS REAL_PMNY_JAN
            , SGS.PMNY_DEP_INT_AMT
            , SGS.TDEP_INT_AMT
            , SGS.MMDA_INT_AMT
            , SGS.BTDEP_INT_AMT
            , SGS.ETC_DEP_INT_AMT
            , 'N'                                                                                               AS DEL_YN
            , 1                                                                                                 AS DR_S
            , TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS')                                                              AS DR_DTTM
            , :TBL_ID                                                                                           AS DROKJA_ID
            , SGS.UPD_DTTM
            , :TBL_ID                                                                                           AS MODR_ID
       FROM SLVTOT_DATA SGS
                INNER JOIN SFIOWN.SFI_SIGUMGO_MAS_SUB SGM
                           ON SGM.SIGUMGO_ORG_C = 11
                               AND SGS.SGG_ACNO = SGM.SIGUMGO_ACNO
       UNION ALL
       SELECT TXO.SGG_ACNO
            , TXO.PROC_DT
            , TXO.BAS_DT
            , TXO.GISDT
            , TXO.DR_SNO
            , TXO.HOIKYE_YEAR
            , TXO.PADM_STD_ORG_C
            , TXO.CHNGS_C
            , TXO.SL_GMGO_HOIKYE_C
            , TXO.HOIKYE_NO
            , TXO.SIGUTAX_G
            , TXO.AGE_AC_G
            , 0   AS TAX_IP_AMT
            , 0   AS TAX_IP_CRT_AMT
            , 0   AS TAX_IP_JKNP_AMT
            , 0   AS TAX_IP_CRT_JKNP_AMT
            , 0   AS GWAON_AMT
            , 0   AS GWAON_CRT_AMT
            , 0   AS KS_TRNS_IP_AMT
            , 0   AS SUB_TAX_IP_AMT
            , 0   AS TAX_IP_DDAC_AMT
            , 0   AS SUB_TAX_IP_JKNP_AMT
            , 0   AS HNDO_BAEJUNG_AMT
            , 0   AS HNDO_USE_AMT
            , 0   AS REMDR_HNDO_AMT
            , 0   AS FUND_BAEJUNG_AMT
            , 0   AS FUND_GETBK_AMT
            , 0   AS FUND_JICHUL_AMT
            , 0   AS FUND_RTRN_AMT
            , 0   AS CSH_JKBUL_AMT
            , 0   AS TAXO_FUND_BAEJUNG_AMT
            , 0   AS TAXO_JIBUL_AMT
            , 0   AS JICHUL_AMT
            , 0   AS RTRN_AMT
            , 0   AS JEONBU_AMT_TDAY_DDAC_AMT
            , 0   AS JICHUL_SAMT
            , 0   AS PMNY_DEP_AMT
            , 0   AS MK_DDAC_AMT
            , 0   AS HJI_DDAC_AMT
            , 0   AS TDEP_AMT
            , 0   AS TDEP_MKAMT
            , 0   AS TDEP_HJI_AMT
            , 0   AS TDEP_MK_HJI_AMT
            , 0   AS MMDA_MKAMT
            , 0   AS MMDA_HJI_AMT
            , 0   AS MMDA_MK_HJI_AMT
            , 0   AS BD_DEP_JIAMT
            , 0   AS BD_DEP_IPAMT
            , 0   AS BD_DEP_JAN_AMT
            , 0   AS KEEP_TDEP_JIAMT
            , 0   AS KEEP_TDEP_IPAMT
            , 0   AS KEEP_FXTM_JAN_AMT
            , 0   AS ZP_JIAMT
            , 0   AS ZP_CLRAMT
            , 0   AS ZP_HABSAN_AMT
            , 0   AS CKCD_JIAMT
            , 0   AS CKCD_CLRAMT
            , 0   AS CKCD_HABSAN_AMT
            , 0   AS REAL_PMNY_JAN
            , 0   AS PMNY_DEP_INT_AMT
            , 0   AS TDEP_INT_AMT
            , 0   AS MMDA_INT_AMT
            , 0   AS BTDEP_INT_AMT
            , 0   AS ETC_DEP_INT_AMT
            , 'N' AS DEL_YN
            , TXO.DR_S
            , TXO.DR_DTTM
            , TXO.DROKJA_ID
            , TXO.UPD_DTTM
            , TXO.MODR_ID
       FROM SFIOWN.SFI_TXIO_DDAC_TAB TXO
                INNER JOIN PROC_LST PCL
                           ON TXO.SGG_ACNO = PCL.SIGUMGO_ACNO
                               AND TXO.PROC_DT = PCL.TRXDT
       WHERE NOT EXISTS(SELECT 1
                        FROM SLVTOT_DATA SGS
                        WHERE SGS.SGG_ACNO = TXO.SGG_ACNO
                          AND SGS.PROC_DT = TXO.PROC_DT
                          AND SGS.BAS_DT = TXO.BAS_DT
                          AND SGS.GISDT = TXO.GISDT)
       ) B
ON (
    A.SGG_ACNO = B.SGG_ACNO
    AND A.PROC_DT = B.PROC_DT
    AND A.BAS_DT = B.BAS_DT
    AND A.GISDT = B.GISDT
    )
WHEN MATCHED THEN
     UPDATE SET A.PADM_STD_ORG_C = B.PADM_STD_ORG_C
            , A.CHNGS_C = B.CHNGS_C
            , A.SL_GMGO_HOIKYE_C = B.SL_GMGO_HOIKYE_C
            , A.HOIKYE_NO = B.HOIKYE_NO
            , A.SIGUTAX_G = B.SIGUTAX_G
            , A.AGE_AC_G = B.AGE_AC_G
            , A.TAX_IP_AMT = B.TAX_IP_AMT
            , A.TAX_IP_CRT_AMT = B.TAX_IP_CRT_AMT
            , A.TAX_IP_JKNP_AMT = B.TAX_IP_JKNP_AMT
            , A.TAX_IP_CRT_JKNP_AMT = B.TAX_IP_CRT_JKNP_AMT
            , A.GWAON_AMT = B.GWAON_AMT
            , A.GWAON_CRT_AMT = B.GWAON_CRT_AMT
            , A.KS_TRNS_IP_AMT = B.KS_TRNS_IP_AMT
            , A.SUB_TAX_IP_AMT = B.SUB_TAX_IP_AMT
            , A.TAX_IP_DDAC_AMT = B.TAX_IP_DDAC_AMT
            , A.SUB_TAX_IP_JKNP_AMT = B.SUB_TAX_IP_JKNP_AMT
            , A.HNDO_BAEJUNG_AMT = B.HNDO_BAEJUNG_AMT
            , A.HNDO_USE_AMT = B.HNDO_USE_AMT
            , A.REMDR_HNDO_AMT = B.REMDR_HNDO_AMT
            , A.FUND_BAEJUNG_AMT = B.FUND_BAEJUNG_AMT
            , A.FUND_GETBK_AMT = B.FUND_GETBK_AMT
            , A.FUND_JICHUL_AMT = B.FUND_JICHUL_AMT
            , A.FUND_RTRN_AMT = B.FUND_RTRN_AMT
            , A.CSH_JKBUL_AMT = B.CSH_JKBUL_AMT
            , A.TAXO_FUND_BAEJUNG_AMT = B.TAXO_FUND_BAEJUNG_AMT
            , A.TAXO_JIBUL_AMT = B.TAXO_JIBUL_AMT
            , A.JICHUL_AMT = B.JICHUL_AMT
            , A.RTRN_AMT = B.RTRN_AMT
            , A.JEONBU_AMT_TDAY_DDAC_AMT = B.JEONBU_AMT_TDAY_DDAC_AMT
            , A.JICHUL_SAMT = B.JICHUL_SAMT
            , A.PMNY_DEP_AMT = B.PMNY_DEP_AMT
            , A.MK_DDAC_AMT = B.MK_DDAC_AMT
            , A.HJI_DDAC_AMT = B.HJI_DDAC_AMT
            , A.TDEP_AMT = B.TDEP_AMT
            , A.TDEP_MKAMT = B.TDEP_MKAMT
            , A.TDEP_HJI_AMT = B.TDEP_HJI_AMT
            , A.TDEP_MK_HJI_AMT = B.TDEP_MK_HJI_AMT
            , A.MMDA_MKAMT = B.MMDA_MKAMT
            , A.MMDA_HJI_AMT = B.MMDA_HJI_AMT
            , A.MMDA_MK_HJI_AMT = B.MMDA_MK_HJI_AMT
            , A.BD_DEP_JIAMT = B.BD_DEP_JIAMT
            , A.BD_DEP_IPAMT = B.BD_DEP_IPAMT
            , A.BD_DEP_JAN_AMT = B.BD_DEP_JAN_AMT
            , A.KEEP_TDEP_JIAMT = B.KEEP_TDEP_JIAMT
            , A.KEEP_TDEP_IPAMT = B.KEEP_TDEP_IPAMT
            , A.KEEP_FXTM_JAN_AMT = B.KEEP_FXTM_JAN_AMT
            , A.ZP_JIAMT = B.ZP_JIAMT
            , A.ZP_CLRAMT = B.ZP_CLRAMT
            , A.ZP_HABSAN_AMT = B.ZP_HABSAN_AMT
            , A.CKCD_JIAMT = B.CKCD_JIAMT
            , A.CKCD_CLRAMT = B.CKCD_CLRAMT
            , A.CKCD_HABSAN_AMT = B.CKCD_HABSAN_AMT
            , A.REAL_PMNY_JAN = B.REAL_PMNY_JAN
            , A.PMNY_DEP_INT_AMT = B.PMNY_DEP_INT_AMT
            , A.TDEP_INT_AMT = B.TDEP_INT_AMT
            , A.MMDA_INT_AMT = B.MMDA_INT_AMT
            , A.BTDEP_INT_AMT = B.BTDEP_INT_AMT
            , A.ETC_DEP_INT_AMT = B.ETC_DEP_INT_AMT
            , A.DR_S = B.DR_S
            , A.DR_DTTM = B.DR_DTTM
            , A.MODR_ID = B.MODR_ID
DELETE WHERE B.DEL_YN = 'Y' AND (B.PROC_DT <> B.BAS_DT OR B.PROC_DT <> B.GISDT)
WHEN NOT MATCHED THEN
       INSERT
            (
        SGG_ACNO
        , PROC_DT
        , BAS_DT
        , GISDT
        , DR_SNO
        , HOIKYE_YEAR
        , PADM_STD_ORG_C
        , CHNGS_C
        , SL_GMGO_HOIKYE_C
        , HOIKYE_NO
        , SIGUTAX_G
        , AGE_AC_G
        , TAX_IP_AMT
        , TAX_IP_CRT_AMT
        , TAX_IP_JKNP_AMT
        , TAX_IP_CRT_JKNP_AMT
        , GWAON_AMT
        , GWAON_CRT_AMT
        , KS_TRNS_IP_AMT
        , SUB_TAX_IP_AMT
        , TAX_IP_DDAC_AMT
        , SUB_TAX_IP_JKNP_AMT
        , HNDO_BAEJUNG_AMT
        , HNDO_USE_AMT
        , REMDR_HNDO_AMT
        , FUND_BAEJUNG_AMT
        , FUND_GETBK_AMT
        , FUND_JICHUL_AMT
        , FUND_RTRN_AMT
        , CSH_JKBUL_AMT
        , TAXO_FUND_BAEJUNG_AMT
        , TAXO_JIBUL_AMT
        , JICHUL_AMT
        , RTRN_AMT
        , JEONBU_AMT_TDAY_DDAC_AMT
        , JICHUL_SAMT
        , PMNY_DEP_AMT
        , MVO_AMT
        , MVI_AMT
        , MVO_DDAC_AMT
        , DTTM_CHAIP_DDAC_AMT
        , GA_IWOL_DDAC_AMT
        , JEONYONG_TOT_DDAC_AMT
        , BNK_PMNY_JAN_AMT
        , MK_DDAC_AMT
        , HJI_DDAC_AMT
        , TDEP_AMT
        , TDEP_MKAMT
        , TDEP_HJI_AMT
        , TDEP_MK_HJI_AMT
        , MMDA_MKAMT
        , MMDA_HJI_AMT
        , MMDA_MK_HJI_AMT
        , BD_DEP_JIAMT
        , BD_DEP_IPAMT
        , BD_DEP_JAN_AMT
        , KEEP_TDEP_JIAMT
        , KEEP_TDEP_IPAMT
        , KEEP_FXTM_JAN_AMT
        , ZP_JIAMT
        , ZP_CLRAMT
        , ZP_HABSAN_AMT
        , CKCD_JIAMT
        , CKCD_CLRAMT
        , CKCD_HABSAN_AMT
        , REAL_PMNY_JAN
        , PMNY_DEP_INT_AMT
        , TDEP_INT_AMT
        , MMDA_INT_AMT
        , BTDEP_INT_AMT
        , ETC_DEP_INT_AMT
        , DR_S
        , DR_DTTM
        , DROKJA_ID
        , UPD_DTTM
        , MODR_ID
        )
    VALUES
        (
        B.SGG_ACNO
        , B.PROC_DT
        , B.BAS_DT
        , B.GISDT
        , B.DR_SNO
        , B.HOIKYE_YEAR
        , B.PADM_STD_ORG_C
        , B.CHNGS_C
        , B.SL_GMGO_HOIKYE_C
        , B.HOIKYE_NO
        , B.SIGUTAX_G
        , B.AGE_AC_G
        , B.TAX_IP_AMT
        , B.TAX_IP_CRT_AMT
        , B.TAX_IP_JKNP_AMT
        , B.TAX_IP_CRT_JKNP_AMT
        , B.GWAON_AMT
        , B.GWAON_CRT_AMT
        , B.KS_TRNS_IP_AMT
        , B.SUB_TAX_IP_AMT
        , B.TAX_IP_DDAC_AMT
        , B.SUB_TAX_IP_JKNP_AMT
        , B.HNDO_BAEJUNG_AMT
        , B.HNDO_USE_AMT
        , B.REMDR_HNDO_AMT
        , B.FUND_BAEJUNG_AMT
        , B.FUND_GETBK_AMT
        , B.FUND_JICHUL_AMT
        , B.FUND_RTRN_AMT
        , B.CSH_JKBUL_AMT
        , B.TAXO_FUND_BAEJUNG_AMT
        , B.TAXO_JIBUL_AMT
        , B.JICHUL_AMT
        , B.RTRN_AMT
        , B.JEONBU_AMT_TDAY_DDAC_AMT
        , B.JICHUL_SAMT
        , B.PMNY_DEP_AMT
        , B.MVO_AMT
        , B.MVI_AMT
        , B.MVO_DDAC_AMT
        , B.DTTM_CHAIP_DDAC_AMT
        , B.GA_IWOL_DDAC_AMT
        , B.JEONYONG_TOT_DDAC_AMT
        , B.BNK_PMNY_JAN_AMT
        , B.MK_DDAC_AMT
        , B.HJI_DDAC_AMT
        , B.TDEP_AMT
        , B.TDEP_MKAMT
        , B.TDEP_HJI_AMT
        , B.TDEP_MK_HJI_AMT
        , B.MMDA_MKAMT
        , B.MMDA_HJI_AMT
        , B.MMDA_MK_HJI_AMT
        , B.BD_DEP_JIAMT
        , B.BD_DEP_IPAMT
        , B.BD_DEP_JAN_AMT
        , B.KEEP_TDEP_JIAMT
        , B.KEEP_TDEP_IPAMT
        , B.KEEP_FXTM_JAN_AMT
        , B.ZP_JIAMT
        , B.ZP_CLRAMT
        , B.ZP_HABSAN_AMT
        , B.CKCD_JIAMT
        , B.CKCD_CLRAMT
        , B.CKCD_HABSAN_AMT
        , B.REAL_PMNY_JAN
        , B.PMNY_DEP_INT_AMT
        , B.TDEP_INT_AMT
        , B.MMDA_INT_AMT
        , B.BTDEP_INT_AMT
        , B.ETC_DEP_INT_AMT
        , B.DR_S
        , B.DR_DTTM
        , B.DROKJA_ID
        , B.UPD_DTTM
        , B.MODR_ID
        )

