SELECT
  B.RN
  , B.KEORAEIL
  , B.KIJUNIL
  , B.KISANIL
  , B.GEORAE_SEQ
  , REGEXP_REPLACE(B.GONGGEUM_GYEJWA,  '(.{3})(.{3})(.{2})(.{2})(.{5})(.{2})', '\1-\2-\3-\4-\5-\6') || ' ('||E.SIGUMGO_AC_NM||')' AS GONGGEUM_GYEJWA_NM2
  , D.GUNGU_NM
  , B.JUKYO
  , B.JEONGJEONG
  , B.IPJI
  , CASE
      WHEN B.SIGUMGO_IP_TRX_G > 0 THEN B.SIGUMGO_TRX_G || '-' || B.SIGUMGO_IP_TRX_G || ' ' || C.TRX_NM
      WHEN B.SIGUMGO_JI_TRX_G > 0 THEN B.SIGUMGO_TRX_G || '-' || B.SIGUMGO_JI_TRX_G || ' ' || C.TRX_NM
      ELSE B.SIGUMGO_TRX_G || ' ' || C.TRX_NM
    END AS JIGUP_NM
  , B.HD_YN
  , B.JIGEUB_AMT
  , B.IPGEUM_AMT
  , B.JAN_AMT
  , B.HD_JAN_AMT
  , REGEXP_REPLACE(B.LINK_SECHUL,  '(.{3})(.{3})(.{2})(.{2})(.{5})(.{2})', '\1-\2-\3-\4-\5-\6') AS LINK_SECHUL
  , B.JIGEUB_ORDER1
  , B.JIGEUB_ORDER2
  , B.SUNAP_BR
  , B.RID
  , B.TOTCNT
  , B.JIGEUB_TOTAL
  , B.IPGEUM_TOTAL
FROM (
  SELECT 
    ROWNUM AS RN
    , KEORAEIL
    , KIJUNIL
    , KISANIL
    , GEORAE_SEQ
    , GONGGEUM_GYEJWA
    , GUNGU_CD
    , JUKYO
    , JEONGJEONG
    , IPJI
    , SIGUMGO_TRX_G
    , SIGUMGO_IP_TRX_G
    , SIGUMGO_JI_TRX_G
    , GEORAE_GUBUN
    , HD_YN
    , JIGEUB_AMT
    , IPGEUM_AMT
    , JAN_AMT
    , HD_JAN_AMT
    , LINK_SECHUL
    , JIGEUB_ORDER1
    , JIGEUB_ORDER2
    , SUNAP_BR
    , RID
    , COUNT(*) OVER() AS TOTCNT
    , SUM(CASE WHEN HD_YN = 'N' THEN NVL(JIGEUB_AMT, 0) ELSE 0 END) OVER() AS JIGEUB_TOTAL
    , SUM(CASE WHEN HD_YN = 'N' THEN NVL(IPGEUM_AMT, 0) ELSE 0 END) OVER() AS IPGEUM_TOTAL
  FROM (

    SELECT
      A.TRXDT AS KEORAEIL
      , A.GJDT AS KIJUNIL
      , A.GISDT AS KISANIL
      , A.TRXNO AS GEORAE_SEQ
      , A.GONGGEUM_GYEJWA
      , A.GUNGU_CD
      , A.CMMT_CTNT AS JUKYO
      , A.CRT_CAN_G AS JEONGJEONG
      , A.IPJI_G AS IPJI
      , A.SIGUMGO_TRX_G
      , A.SIGUMGO_IP_TRX_G
      , A.SIGUMGO_JI_TRX_G
      , LPAD(A.SIGUMGO_TRX_G, 2, '0') || LPAD(A.SIGUMGO_IP_TRX_G, 2, '0') || LPAD(A.SIGUMGO_JI_TRX_G, 2, '0') AS GEORAE_GUBUN
      , A.HD_YN AS HD_YN
      , CASE WHEN A.IPJI_G = 2 THEN A.TRAMT ELSE 0 END AS JIGEUB_AMT
      , CASE WHEN A.IPJI_G = 1 THEN A.TRAMT ELSE 0 END AS IPGEUM_AMT
      , A.LINKAC_JAN AS JAN_AMT
      , A.TRXAF_HNDO_JAN AS HD_JAN_AMT
      , A.OPP_SIGUMGO_MNG_NO AS LINK_SECHUL
      , A.JIGEUB_ORDER1
      , A.JIGEUB_ORDER2
      , A.SUNAP_BR
      , A.RID
    FROM (
      SELECT
        TRXDT 
        , GJDT 
        , GISDT 
        , TRXNO
        , FIL_100_CTNT5 AS GONGGEUM_GYEJWA
        , ICH_SIGUMGO_GUN_GU_C AS GUNGU_CD
        , CMMT_CTNT 
        , CRT_CAN_G 
        , IPJI_G 
        , SIGUMGO_TRX_G 
        , SIGUMGO_IP_TRX_G 
        , SIGUMGO_JI_TRX_G 
        , 'N' AS HD_YN 
        , DECODE(CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * TRAMT AS TRAMT 
        , LINKAC_JAN 
        , TRXAF_HNDO_JAN 
        , SIGUMGO_TAX_IP_MNG_NO AS OPP_SIGUMGO_MNG_NO 
        , JI_ORDR_DOC_STT_NO AS JIGEUB_ORDER1 
        , JI_ORDR_DOC_END_NO AS JIGEUB_ORDER2 
        , TRXBRNO AS SUNAP_BR
        , ROWID AS RID
      FROM ACL_SIGUMGO_SLV
      WHERE 1 = 1
        AND FIL_100_CTNT5 = '02814075690001799'        
        AND (NVL('', 'all') = 'all' OR 
        (SIGUMGO_TRX_G = '' AND (SIGUMGO_IP_TRX_G = NVL('', 0) OR SIGUMGO_JI_TRX_G = NVL('', 0))))
        AND DECODE('1', '1', TRXDT, '2', GISDT, GJDT) >= '20220301'
        AND DECODE('1', '1', TRXDT, '2', GISDT, GJDT) <= '20220731'
        AND MNG_NO = 1

      UNION ALL

      SELECT 
        TRXDT 
        , GJDT 
        , GISDT 
        , FIL_10_NO1 AS TRXNO 
        , SIGUMGO_ACNO AS GONGGEUM_GYEJWA
        , ICH_SIGUMGO_GUN_GU_C AS GUNGU_CD
        , JKYO AS CMMT_CTNT 
        , CRT_CAN_G 
        , IPJI_G 
        , SIGUMGO_TRX_G 
        , 0 AS SIGUMGO_IP_TRX_G 
        , 0 AS SIGUMGO_JI_TRX_G 
        , 'Y' AS HD_YN 
        , DECODE(CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * TRAMT AS TRAMT 
        , FIL_18_AMT1 AS LINKAC_JAN 
        , HDAMT 
        , OPP_SIGUMGO_MNG_NO AS OPP_SIGUMGO_MNG_NO 
        , TO_CHAR(TO_NUMBER(SIGUMGO_JI_ORDR_NO)) AS JIGEUB_ORDER1 
        , '0' AS JIGEUB_ORDER2 
        , TRXBRNO AS SUNAP_BR
        , ROWID AS RID
      FROM ACL_SGGHANDO_SLV 
      WHERE 1 = 1
        AND SIGUMGO_ACNO = '02814075690001799'
        AND (NVL('', 'all') = 'all' OR SIGUMGO_TRX_G = '')
        AND DECODE('1', '1', TRXDT, '2', GISDT, GJDT) >= '20220301'
        AND DECODE('1', '1', TRXDT, '2', GISDT, GJDT) <= '20220731'
        AND FIL_5_NO1= 0 
    ) A
    ORDER BY GEORAE_SEQ, HD_YN
  )
) B

LEFT JOIN (
 SELECT 
  CMM_DTL_C AS TRX_G
  , CMM_DTL_C_NM AS TRX_NM
 FROM SFI_CMM_C_DAT
 WHERE CMM_C_NM = 'RPT세입세출자금일계표집계용' 
) C
ON B.GEORAE_GUBUN = C.TRX_G

LEFT JOIN  (
 SELECT 
  CMM_DTL_C AS GUNGU_CODE
  , CMM_DTL_C_NM AS GUNGU_NM
 FROM SFI_CMM_C_DAT
 WHERE CMM_C_NM = 'RPT군구코드'
   AND HRNK_CMM_DTL_C = 28
) D
ON B.GUNGU_CD = D.GUNGU_CODE

LEFT JOIN ACL_SIGUMGO_MAS E
ON B.GONGGEUM_GYEJWA = E.FIL_100_CTNT2
AND E.MNG_NO = 1

WHERE 1=1
  AND RN > '0'
  AND RN <= '2000'


  ------------------------------------------------------


   SELECT
        TRXDT 
        , GJDT 
        , GISDT 
        , TRXNO
        , FIL_100_CTNT5 AS GONGGEUM_GYEJWA
        , ICH_SIGUMGO_GUN_GU_C AS GUNGU_CD
        , CMMT_CTNT 
        , CRT_CAN_G 
        , IPJI_G 
        , SIGUMGO_TRX_G 
        , SIGUMGO_IP_TRX_G 
        , SIGUMGO_JI_TRX_G 
        , 'N' AS HD_YN 
        , DECODE(CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * TRAMT AS TRAMT 
        , LINKAC_JAN 
        , TRXAF_HNDO_JAN 
      FROM ACL_SIGUMGO_SLV
      WHERE 1 = 1
        AND FIL_100_CTNT5 = '02814075690001799'  

-------------------------------------------------------------


select count(*) as cnt from ACL_SIGUMGO_SLV
where sigumgo_org_c = 28 
and ICH_SIGUMGO_HOIKYE_C = 75
and drokja_id is null
and IPJI_G = 1
and LINKAC_JAN = 0

--------------------------------------------------------------

