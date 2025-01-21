select * from map_job_date where dw_bas_ddt like '2025%'
order by dw_bas_ddt

select * from map_job_date where dw_bas_ddt = '20250127'

delete from map_job_date where dw_bas_ddt = '20250127' and dt_g = 0

select * from rpt_taxo_m_gye_tab
where 1=1

=========================== XDA ID:[tom.ich.rpt.xda.xSelectListICH030306By02]===============================
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
                      , SUM(JANAC ) AS JANAC
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
                             , BAEJUNG_NUGYE - (JUNWOL_JICHUL + DANGWOL_JICHUL - DANGWOL_YUIP - DANGWOL_GYULJUNG) AS JANAC
                          FROM
                          (
                               SELECT SGG_ACNO
                                    , SIGUMGO_AC_NM
                                    , AA.ICH_SIGUMGO_GUN_GU_C
                                    , CASE WHEN BAS_DT>= SUBSTR('20250101',1,6)||'01' THEN THMM_BAEJUNG_AMT ELSE 0 END  DANGWOL_BAEJUNG
                                    , THMM_BAEJUNG_AMT AS BAEJUNG_NUGYE
                                    , CASE WHEN BAS_DT< SUBSTR('20250101',1,6)||'01' THEN THMM_JI_AMT-THMM_RTRN_AMT  ELSE 0 END JUNWOL_JICHUL
                                    , CASE WHEN BAS_DT>= SUBSTR('20250101',1,6)||'01' THEN THMM_JI_AMT ELSE 0 END  DANGWOL_JICHUL
                                    , CASE WHEN BAS_DT>= SUBSTR('20250101',1,6)||'01' THEN THMM_RTRN_AMT ELSE 0 END  DANGWOL_YUIP
                                    , CASE WHEN BAS_DT>= SUBSTR('20250101',1,6)||'01' THEN THMM_CRRC_IP_AMT ELSE 0 END
                                        +CASE WHEN BAS_DT>= SUBSTR('20250101',1,6)||'01' THEN THMM_CRRC_JI_AMT ELSE 0 END  AS DANGWOL_GYULJUNG
                                    , ROW_NUMBER() OVER (PARTITION BY SUBSTR(AA.BAS_DT,1,6), AA.SGG_ACNO ORDER BY AA.BAS_DT DESC , AA.GISDT DESC , AA.PROC_DT DESC ) RN
                                 FROM RPT_TAXO_M_GYE_TAB AA, ACL_SIGUMGO_MAS BB
                                WHERE AA.SGG_ACNO = BB.FIL_100_CTNT2
                                  AND AA.ICH_SIGUMGO_HOIKYE_C = BB.ICH_SIGUMGO_HOIKYE_C
                                  AND AA.SIGUMGO_ORG_C = BB.SIGUMGO_ORG_C
                                  AND AA.SIGUMGO_ORG_C = '28'
                                  AND AA.BAS_DT BETWEEN SUBSTR('20250113' ,0,4)||'0101' AND '20250113'
                                  AND (SUBSTR(AA.SGG_ACNO,4,3)<>'900' OR SUBSTR(AA.SGG_ACNO,7,2)<>'90')
                                  AND BB.MNG_NO = 1
                                  AND (   ('1' = '0' AND AA.SIGUMGO_HOIKYE_YR IN (TO_CHAR(TO_NUMBER(SUBSTR('20250113',1,4))-1), SUBSTR('20250113',1,4), '9999'))
                                       OR ('1' = '1' AND AA.SIGUMGO_HOIKYE_YR IN (SUBSTR('20250113',1,4), '9999'))
                                       OR ('1' = '9' AND AA.SIGUMGO_HOIKYE_YR = TO_CHAR(TO_NUMBER(SUBSTR('20250113',1,4))-1))
                                      )
                                  AND ('ALL' = NVL('','ALL') OR AA.ICH_SIGUMGO_GUN_GU_C = '')
                                  AND ('99' = NVL('99','99') OR AA.ICH_SIGUMGO_HOIKYE_C = '99')
                                  AND ('ALL' = NVL('','ALL') OR AA.SIGUMGO_AC_B = '')
                                  AND ('ALL' = NVL('','ALL') OR BB.AC_GRBRNO = '')
                                  AND ('ALL' = NVL('02800001100000025','ALL') OR AA.SGG_ACNO = '02800001100000025')
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
============================================================================================

 SELECT SGG_ACNO
                                    , SIGUMGO_AC_NM
                                    , AA.ICH_SIGUMGO_GUN_GU_C
        ,AA.BAS_DT
                                    , CASE WHEN BAS_DT>= SUBSTR('20250101',1,6)||'01' THEN THMM_BAEJUNG_AMT ELSE 0 END  DANGWOL_BAEJUNG
                                    , THMM_BAEJUNG_AMT AS BAEJUNG_NUGYE
                                    , CASE WHEN BAS_DT< SUBSTR('20250101',1,6)||'01' THEN THMM_JI_AMT-THMM_RTRN_AMT  ELSE 0 END JUNWOL_JICHUL
                                    , CASE WHEN BAS_DT>= SUBSTR('20250101',1,6)||'01' THEN THMM_JI_AMT ELSE 0 END  DANGWOL_JICHUL
                                    , CASE WHEN BAS_DT>= SUBSTR('20250101',1,6)||'01' THEN THMM_RTRN_AMT ELSE 0 END  DANGWOL_YUIP
                                    , CASE WHEN BAS_DT>= SUBSTR('20250101',1,6)||'01' THEN THMM_CRRC_IP_AMT ELSE 0 END
                                        +CASE WHEN BAS_DT>= SUBSTR('20250101',1,6)||'01' THEN THMM_CRRC_JI_AMT ELSE 0 END  AS DANGWOL_GYULJUNG
                                    , ROW_NUMBER() OVER (PARTITION BY SUBSTR(AA.BAS_DT,1,6), AA.SGG_ACNO ORDER BY AA.BAS_DT DESC , AA.GISDT DESC , AA.PROC_DT DESC ) RN
                                 FROM RPT_TAXO_M_GYE_TAB AA, ACL_SIGUMGO_MAS BB
                                WHERE AA.SGG_ACNO = BB.FIL_100_CTNT2
                                  AND AA.ICH_SIGUMGO_HOIKYE_C = BB.ICH_SIGUMGO_HOIKYE_C
                                  AND AA.SIGUMGO_ORG_C = BB.SIGUMGO_ORG_C
                                  AND AA.SIGUMGO_ORG_C = '28'
                                  AND AA.BAS_DT BETWEEN SUBSTR('20250113' ,0,4)||'0101' AND '20250113'
                                  AND (SUBSTR(AA.SGG_ACNO,4,3)<>'900' OR SUBSTR(AA.SGG_ACNO,7,2)<>'90')
                                  AND BB.MNG_NO = 1
                                  AND (   ('1' = '0' AND AA.SIGUMGO_HOIKYE_YR IN (TO_CHAR(TO_NUMBER(SUBSTR('20250113',1,4))-1), SUBSTR('20250113',1,4), '9999'))
                                       OR ('1' = '1' AND AA.SIGUMGO_HOIKYE_YR IN (SUBSTR('20250113',1,4), '9999'))
                                       OR ('1' = '9' AND AA.SIGUMGO_HOIKYE_YR = TO_CHAR(TO_NUMBER(SUBSTR('20250113',1,4))-1))
                                      )
                                  AND ('ALL' = NVL('','ALL') OR AA.ICH_SIGUMGO_GUN_GU_C = '')
                                  AND ('99' = NVL('99','99') OR AA.ICH_SIGUMGO_HOIKYE_C = '99')
                                  AND ('ALL' = NVL('','ALL') OR AA.SIGUMGO_AC_B = '')
                                  AND ('ALL' = NVL('','ALL') OR BB.AC_GRBRNO = '')
                                  AND ('ALL' = NVL('02800001100000025','ALL') OR AA.SGG_ACNO = '02800001100000025')
                                  AND ('ALL' = NVL('','ALL') OR LPAD(BB.LINKAC_KWA_C, 3, '0')||LPAD(BB.LINK_ACSER, 9, '0') = '')