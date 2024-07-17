-- 부서 계좌 등록 신청합니다.

-- [소속 부서]
-- 인천광역시 계양구청 전략사업추진단

-- [조회 필요 계좌 (17자리)]
-- 028-245-80-10-00000-99 : 서운일반산업단지 특별회계
-- 028-245-80-90-00000-99 : 서운일반산업단지 특별회계배정
-- 028-245-42-10-00000-99 : 서운산업단지공공폐수처리시설특별회계
-- 028-245-42-20-00000-99 : 서운산업단지공공폐수처리서설특별회계 배정



-- [연락처]
-- 032-450-5715

-- 세출월계표 : 160-000-125130 으로 검색 후 출력했을 때 
--                   자금잔액으로 -2,941,840이 남아있습니다.  
--                   2024-01-15에 이호조에서 사업소감배정처리하엿는데
--                   왜 금액이 남아있는지도 확인부탁드립니다. 


select * from ACL_SIGUMGO_MAS
where 1=1
and LINK_ACSER = 125130
and MNG_NO = 1

-- 02824580900000099

SELECT LIST.RN
         , LIST.GONGGEUM_GYEJWA_NM
         , LIST.GUNGU_NAME
         , LIST.DANGWOL_BAEJUNG
         , LIST.BAEJUNG_NUGYE
         , LIST.JUNWOL_JICHUL
         , LIST.DANGWOL_JICHUL
         , LIST.MIJIGEUB
         , LIST.DANGWOL_YUIP
         , LIST.DANGWOL_GYULJUNG
         , LIST.JICHUL_NUGYE
         , LIST.JANAC
         , LIST.GONGGEUM_GYEJWA
      FROM 
    (
          SELECT ORG.*
            FROM 
         ( 
                 SELECT ROW_NUMBER() OVER (ORDER BY TA.SIGUMGO_AC_NM, TA.ICH_SIGUMGO_GUN_GU_C )  RN
                      , SIGUMGO_AC_NM AS GONGGEUM_GYEJWA_NM
                      ,  '( '||ICH_SIGUMGO_GUN_GU_C|| ' )' || TB.GUNGU_NAME GUNGU_NAME   
                      , SUM(DANGWOL_BAEJUNG) AS DANGWOL_BAEJUNG  
                      , SUM(BAEJUNG_NUGYE)  AS BAEJUNG_NUGYE   
                      , SUM(JUNWOL_JICHUL) AS JUNWOL_JICHUL   
                      , SUM(DANGWOL_JICHUL ) AS DANGWOL_JICHUL  
                      , 0 AS MIJIGEUB      
                      , SUM(DANGWOL_YUIP) AS DANGWOL_YUIP   
                      , SUM(DANGWOL_GYULJUNG) AS DANGWOL_GYULJUNG  
                      , SUM(JICHUL_NUGYE) AS JICHUL_NUGYE
                      , SUM(BAEJUNG_NUGYE - JICHUL_NUGYE ) AS JANAC
                      , SGG_ACNO AS GONGGEUM_GYEJWA
                   FROM
                 (
                        SELECT SGG_ACNO
                             , SIGUMGO_AC_NM
                             , ICH_SIGUMGO_GUN_GU_C
                             , DANGWOL_BAEJUNG   
                             , BAEJUNG_NUGYE      
                             , JUNWOL_JICHUL    
                             , DANGWOL_JICHUL    
                             , 0 AS MIJIGEUB    
                             , DANGWOL_YUIP    
                             , DANGWOL_GYULJUNG   
                             , JUNWOL_JICHUL + DANGWOL_JICHUL - DANGWOL_YUIP - DANGWOL_GYULJUNG AS JICHUL_NUGYE
 
                          FROM
                          (
                               SELECT SGG_ACNO
                                    , SIGUMGO_AC_NM
                                    , AA.ICH_SIGUMGO_GUN_GU_C
                                    , CASE WHEN BAS_DT>= SUBSTR('20240701',1,6)||'01' THEN THMM_BAEJUNG_AMT ELSE 0 END  DANGWOL_BAEJUNG
                                    , THMM_BAEJUNG_AMT AS BAEJUNG_NUGYE
                                    , CASE WHEN BAS_DT< SUBSTR('20240701',1,6)||'01' THEN THMM_JI_AMT-THMM_RTRN_AMT  ELSE 0 END JUNWOL_JICHUL
                                    , CASE WHEN BAS_DT>= SUBSTR('20240701',1,6)||'01' THEN THMM_JI_AMT ELSE 0 END  DANGWOL_JICHUL
                                    , CASE WHEN BAS_DT>= SUBSTR('20240701',1,6)||'01' THEN THMM_RTRN_AMT ELSE 0 END  DANGWOL_YUIP
                                    , CASE WHEN BAS_DT>= SUBSTR('20240701',1,6)||'01' THEN THMM_CRRC_IP_AMT ELSE 0 END
                                        +CASE WHEN BAS_DT>= SUBSTR('20240701',1,6)||'01' THEN THMM_CRRC_JI_AMT ELSE 0 END  AS DANGWOL_GYULJUNG
                                    , ROW_NUMBER() OVER (PARTITION BY SUBSTR(AA.BAS_DT,1,6), AA.SGG_ACNO ORDER BY AA.BAS_DT DESC , AA.GISDT DESC , AA.PROC_DT DESC ) RN
                                 FROM RPT_TAXO_M_GYE_TAB AA, ACL_SIGUMGO_MAS BB
                                WHERE AA.SGG_ACNO = BB.FIL_100_CTNT2
                                  AND AA.ICH_SIGUMGO_HOIKYE_C = BB.ICH_SIGUMGO_HOIKYE_C
                                  AND AA.SIGUMGO_ORG_C = BB.SIGUMGO_ORG_C
                                  AND AA.SIGUMGO_ORG_C = '28'
                                  AND AA.BAS_DT BETWEEN SUBSTR('20240708' ,0,4)||'0101' AND '20240708'
                                  AND (SUBSTR(AA.SGG_ACNO,4,3)<>'900' OR SUBSTR(AA.SGG_ACNO,7,2)<>'90')
                                  AND BB.MNG_NO = 1  
                                  AND (   ('1' = '0' AND AA.SIGUMGO_HOIKYE_YR IN (TO_CHAR(TO_NUMBER(SUBSTR('20240708',1,4))-1), SUBSTR('20240708',1,4), '9999'))   
                                       OR ('1' = '1' AND AA.SIGUMGO_HOIKYE_YR IN (SUBSTR('20240708',1,4), '9999')) 
                                       OR ('1' = '9' AND AA.SIGUMGO_HOIKYE_YR = TO_CHAR(TO_NUMBER(SUBSTR('20240708',1,4))-1))
                                      )
                                  AND ('ALL' = NVL('245','ALL') OR AA.ICH_SIGUMGO_GUN_GU_C = '245')
                                  AND ('99' = NVL('80','99') OR AA.ICH_SIGUMGO_HOIKYE_C = '80')
                                  AND ('ALL' = NVL('','ALL') OR AA.SIGUMGO_AC_B = '')
                                  AND ('ALL' = NVL('','ALL') OR BB.AC_GRBRNO = '')
                                  AND ('ALL' = NVL('02824580900000099','ALL') OR AA.SGG_ACNO = '02824580900000099')
                                  AND ('ALL' = NVL('','ALL') OR LPAD(BB.LINKAC_KWA_C, 3, '0')||LPAD(BB.LINK_ACSER, 9, '0') = '')
                           )
                         WHERE RN = 1 
                           AND (DANGWOL_BAEJUNG != 0 OR BAEJUNG_NUGYE != 0 OR JUNWOL_JICHUL != 0 OR DANGWOL_JICHUL != 0 OR DANGWOL_YUIP != 0 OR DANGWOL_GYULJUNG != 0)
                 ) TA
                 , (SELECT REF_D_C  AS GUNGU_CODE, REF_D_NM  AS GUNGU_NAME
                      FROM RPT_CODE_INFO
                     WHERE REF_L_C=500 AND REF_M_C=28 AND REF_S_C=1) TB
             WHERE TA.ICH_SIGUMGO_GUN_GU_C = TB.GUNGU_CODE
             GROUP BY TA.SGG_ACNO , TA.SIGUMGO_AC_NM,  TA.ICH_SIGUMGO_GUN_GU_C, TB.GUNGU_NAME
             ORDER BY TA.SIGUMGO_AC_NM, TA.ICH_SIGUMGO_GUN_GU_C,  TB.GUNGU_NAME, TA.SGG_ACNO
           ) ORG        
       WHERE ROWNUM <= '2000'
     ) LIST
 WHERE LIST.RN > '0'



 ---------------------------------------------------------------


 SELECT SGG_ACNO
                                    , SIGUMGO_AC_NM
                                    , AA.ICH_SIGUMGO_GUN_GU_C
                                    , CASE WHEN BAS_DT>= SUBSTR('20240701',1,6)||'01' THEN THMM_BAEJUNG_AMT ELSE 0 END  DANGWOL_BAEJUNG
                                    , THMM_BAEJUNG_AMT AS BAEJUNG_NUGYE
                                    , CASE WHEN BAS_DT< SUBSTR('20240701',1,6)||'01' THEN THMM_JI_AMT-THMM_RTRN_AMT  ELSE 0 END JUNWOL_JICHUL
                                    , CASE WHEN BAS_DT>= SUBSTR('20240701',1,6)||'01' THEN THMM_JI_AMT ELSE 0 END  DANGWOL_JICHUL
                                    , CASE WHEN BAS_DT>= SUBSTR('20240701',1,6)||'01' THEN THMM_RTRN_AMT ELSE 0 END  DANGWOL_YUIP
                                    , CASE WHEN BAS_DT>= SUBSTR('20240701',1,6)||'01' THEN THMM_CRRC_IP_AMT ELSE 0 END
                                        +CASE WHEN BAS_DT>= SUBSTR('20240701',1,6)||'01' THEN THMM_CRRC_JI_AMT ELSE 0 END  AS DANGWOL_GYULJUNG
                                    , ROW_NUMBER() OVER (PARTITION BY SUBSTR(AA.BAS_DT,1,6), AA.SGG_ACNO ORDER BY AA.BAS_DT DESC , AA.GISDT DESC , AA.PROC_DT DESC ) RN
                                 FROM RPT_TAXO_M_GYE_TAB AA, ACL_SIGUMGO_MAS BB
                                WHERE AA.SGG_ACNO = BB.FIL_100_CTNT2
                                  AND AA.ICH_SIGUMGO_HOIKYE_C = BB.ICH_SIGUMGO_HOIKYE_C
                                  AND AA.SIGUMGO_ORG_C = BB.SIGUMGO_ORG_C
                                  AND AA.SIGUMGO_ORG_C = '28'
                                  AND AA.BAS_DT BETWEEN SUBSTR('20240708' ,0,4)||'0101' AND '20240708'
                                  AND (SUBSTR(AA.SGG_ACNO,4,3)<>'900' OR SUBSTR(AA.SGG_ACNO,7,2)<>'90')
                                  AND BB.MNG_NO = 1  
                                  AND (   ('1' = '0' AND AA.SIGUMGO_HOIKYE_YR IN (TO_CHAR(TO_NUMBER(SUBSTR('20240708',1,4))-1), SUBSTR('20240708',1,4), '9999'))   
                                       OR ('1' = '1' AND AA.SIGUMGO_HOIKYE_YR IN (SUBSTR('20240708',1,4), '9999')) 
                                       OR ('1' = '9' AND AA.SIGUMGO_HOIKYE_YR = TO_CHAR(TO_NUMBER(SUBSTR('20240708',1,4))-1))
                                      )
                                  AND ('ALL' = NVL('245','ALL') OR AA.ICH_SIGUMGO_GUN_GU_C = '245')
                                  AND ('99' = NVL('80','99') OR AA.ICH_SIGUMGO_HOIKYE_C = '80')
                                  AND ('ALL' = NVL('','ALL') OR AA.SIGUMGO_AC_B = '')
                                  AND ('ALL' = NVL('','ALL') OR BB.AC_GRBRNO = '')
                                  AND ('ALL' = NVL('02824580900000099','ALL') OR AA.SGG_ACNO = '02824580900000099')
                                  AND ('ALL' = NVL('','ALL') OR LPAD(BB.LINKAC_KWA_C, 3, '0')||LPAD(BB.LINK_ACSER, 9, '0') = '')

----------------------------------------------------------------------

SELECT * FROM RPT_TAXO_M_GYE_TAB
WHERE 1=1
AND SGG_ACNO = '02824580900000099'
ORDER BY BAS_DT DESC 


-- 154837340 150852300 6926880   

-- 157779180 


SELECT
SIGUMGO_ORG_C, ICH_SIGUMGO_GUN_GU_C, FIL_100_CTNT5,
 SUM(DECODE(IPJI_G, 1, DECODE(CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1)*TRAMT, 0)) AS IP_AMT,
 SUM(DECODE(IPJI_G, 2, DECODE(CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1)*TRAMT, 0)) AS JI_AMT, 
 SUM(DECODE(IPJI_G, 1, DECODE(CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1)*TRAMT, 0) - DECODE(IPJI_G, 2, DECODE(CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1)*TRAMT, 0)) AS SUM_AMT
FROM ACL_SIGUMGO_SLV
WHERE 1=1   
AND SIGUMGO_ORG_C = 28
AND ICH_SIGUMGO_GUN_GU_C = 245
AND FIL_100_CTNT5 = '02824580900000099'
AND TRXDT BETWEEN '20240101' AND '20240708'
GROUP BY SIGUMGO_ORG_C, ICH_SIGUMGO_GUN_GU_C, FIL_100_CTNT5


SELECT
SIGUMGO_ORG_C, ICH_SIGUMGO_GUN_GU_C, FIL_100_CTNT5,
 SUM(DECODE(IPJI_G, 1, DECODE(CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1)*TRAMT, 0)) AS IP_AMT,
 SUM(DECODE(IPJI_G, 2, DECODE(CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1)*TRAMT, 0)) AS JI_AMT, 
 SUM(DECODE(IPJI_G, 1, DECODE(CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1)*TRAMT, 0) - DECODE(IPJI_G, 2, DECODE(CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1)*TRAMT, 0)) AS SUM_AMT
FROM ACL_SIGUMGO_SLV
WHERE 1=1   
AND SIGUMGO_ORG_C = 28
AND ICH_SIGUMGO_GUN_GU_C = 245
AND FIL_100_CTNT5 = '02824580900000099'
AND TRXDT < '20240101'
GROUP BY SIGUMGO_ORG_C, ICH_SIGUMGO_GUN_GU_C, FIL_100_CTNT5


-- 154,837,340	157,779,180

SELECT DW_BAS_DDT, COUNT(DW_BAS_DDT) AS CNT FROM MAP_JOB_DATE
WHERE 1=1
AND DW_BAS_DDT LIKE '2024%'
GROUP BY DW_BAS_DDT HAVING COUNT(*) > 1

-------------------------------------------------------------------------

SELECT DW_BAS_DDT, COUNT(DW_BAS_DDT) AS CNT FROM MAP_JOB_DATE
WHERE 1=1
GROUP BY DW_BAS_DDT HAVING COUNT(*) > 1

-------------------------------------------------------------------------

