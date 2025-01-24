select * from acl_sgghando_slv
where 1=1
and sigumgo_acno = '02800001250000225'

select * from acl_sgghando_slv
where 1=1
and opp_sigumgo_mng_no = '02800001250000224'
and sigumgo_acno = '02800001100000024'

select sigumgo_acno, SIGUMGO_TRX_G from acl_sgghando_slv
WHERE 1=1
AND SIGUMGO_HOIKYE_YR = '2024'
GROUP BY sigumgo_acno, SIGUMGO_TRX_G
ORDER BY sigumgo_acno, SIGUMGO_TRX_G

select * from acl_sgghando_slv
where 1=1
and sigumgo_acno = '02800001210000224'

select * from acl_sigumgo_mas
where 1=1
and fil_100_ctnt5 = '02800001210000025'

SELECT * FROM ACL_SIGUMGO_MAS_SUB
WHERE 1=1
AND SIGUMGO_ACNO = '02800001210000025'

----------------------------------------------------------

SELECT * FROM ACL_SGGHANDO_SLV
WHERE 1=1
AND SIGUMGO_ACNO = '02800001100000024'
AND TRXDT = '20240103'
AND SIGUMGO_TRX_G IN (94)



-- 손계좌 찾기
SELECT * FROM ACL_SIGUMGO_MAS
WHERE 1=1
AND MNG_NO = 1
AND SIGUMGO_AGE_AC_G = 3
AND SIGUMGO_HOIKYE_YR = '2024'




SELECT SIGUMGO_ACNO, OPP_SIGUMGO_MNG_NO, SIGUMGO_TRX_G FROM ACL_SGGHANDO_SLV
WHERE 1=1
AND SIGUMGO_ACNO IN (SELECT FIL_100_CTNT2
                     FROM ACL_SIGUMGO_MAS
                     WHERE 1 = 1
                       AND MNG_NO = 1
                       AND SIGUMGO_AGE_AC_G = 3
                       AND SIGUMGO_HOIKYE_YR = '2024')
GROUP BY SIGUMGO_ACNO, OPP_SIGUMGO_MNG_NO, SIGUMGO_TRX_G
ORDER BY SIGUMGO_ACNO, OPP_SIGUMGO_MNG_NO, SIGUMGO_TRX_G

-- 손계좌
-- 02811001250004725
select * from acl_sgghando_slv
where 1=1
and sigumgo_acno = '02811001250004725'

-- 02811001210000025

select * from acl_sgghando_slv
where 1=1
and sigumgo_acno = '02811001210000025'

-- 일괄잔액 대사표에서 한도계좌에 대한 판단이 없음


SELECT GUBUN
     , GYEJWA_NAME
     , GONGGEUM_GYEJWA
     , SANGPUM_NAME
     , UNYONG_GYEJWA
     , TRIM(MKDT) AS MKDT
     , TRIM(DUDT) AS DUDT
     , HYUN_JAN
     , IYUL
     , GONGGEUM_YUDONG_ACNO
     , RN
     , CNT
     , TOT_JAN
  FROM (
        SELECT ORG.*, ROWNUM RN
          FROM (
               SELECT ORG.*
                    , SUM(HYUN_JAN) OVER() AS TOT_JAN
                 FROM (
                      SELECT GUBUN
                           , DECODE(GUBUN, 1, '공금예금'||CHR(58)||' '||GYEJWA_NAME, '자금운용'||CHR(58)||''||SANGPUM_NAME) AS GYEJWA_NAME
                           , GONGGEUM_GYEJWA
                           , SANGPUM_NAME
                           , UNYONG_GYEJWA
                           , MKDT
                           , DUDT
                           , NVL(SUM(HYUN_JAN),0) AS HYUN_JAN
                           , IYUL
                           , GONGGEUM_YUDONG_ACNO
                           , COUNT(1) OVER() AS CNT
                      FROM (
                               WITH WT_GYEJWA_INFO AS
                               (
                                    SELECT SIGUMGO_ORG_C AS GONGGEUM_GEUMGO_CD
                                         , SIGUMGO_GUN_GU_C AS GONGGEUM_GUNGU_CODE
                                         , SIGUMGO_HOIKYE_C AS GONGGEUM_HOIGYE_CODE
                                         , SIGUMGO_HOIKYE_YR AS GONGGEUM_HOIGYE_YEAR
                                         , SIGUMGO_ACNO AS GONGGEUM_GYEJWA
                                         , SIGUMGO_AC_NM AS GONGGEUM_GYEJWA_NM
                                         , LPAD(LINKAC_KWA_C, 3, '0')||LPAD(LINKAC_SER, 9, '0') AS GONGGEUM_YUDONG_ACNO
                                         , TO_NUMBER(NVL(HRNK_CMM_DTL_C,'0')) AS IYUL
                                      FROM ACL_SIGUMGO_MAS_SUB
                                      LEFT OUTER JOIN SFI_CMM_C_DAT
                                                   ON CMM_C_NM =  'RPT공금예금약정이율'
                                                  AND DECODE(SIGUMGO_HOIKYE_YR,'9999',SUBSTR('20250121',1,4),SIGUMGO_HOIKYE_YR) BETWEEN UPMU_HMK_1_SLV AND UPMU_HMK_2_SLV
                                                  AND UPMU_HMK_3_SLV = SIGUMGO_GUN_GU_C
                                                  AND USE_YN = 'Y'
                                     WHERE SIGUMGO_ORG_C = '28'
                                       AND SIGUMGO_HOIKYE_YR IN ('2025', '9999')
                                       AND (NVL('', 'ALL')          = 'ALL' OR '' = AC_GRBRNO)
                                       AND (NVL('02800001210000025', 'ALL')       = 'ALL' OR '02800001210000025' = SIGUMGO_ACNO)
                                       AND (NVL('', 'ALL')        = 'ALL' OR '' = SIGUMGO_HOIKYE_C)
                                       AND (NVL('', 'ALL')      = 'ALL' OR '' = SIGUMGO_GUN_GU_C)
                                       AND (NVL('', 'ALL') = 'ALL' OR '' = SIGUMGO_AC_B)
                                       AND (NVL('', 'ALL')     = 'ALL' OR '' = LPAD(LINKAC_KWA_C, 3, '0')||LPAD(LINKAC_SER, 9, '0'))
                               )
                               SELECT 1 GUBUN, B.GONGGEUM_GYEJWA, B.GONGGEUM_GYEJWA_NM GYEJWA_NAME,
                                      '' UNYONG_GYEJWA, '' SANGPUM_NAME,
                                      '' MKDT, '' DUDT,
                                      SUM(NVL((DECODE(A.CRT_CAN_G,1,-1,2,-1,33,-1,1) *  DECODE(A.IPJI_G,1,1,-1) * A.TRAMT), 0)) + NVL(MAX(C.JANAEK), 0) AS HYUN_JAN,
                                      B.IYUL, B.GONGGEUM_YUDONG_ACNO
                                 FROM ACL_SIGUMGO_SLV A, WT_GYEJWA_INFO B,
                                      (SELECT GONGGEUM_GYEJWA, JANAEK
                                         FROM RPT_GONGGEUM_JAN
                                        WHERE KEORAEIL = TO_CHAR(TO_DATE('20250121' ,'YYYYMMDD')-1,'YYYYMMDD')
                                          AND HOIGYE_YEAR IN ('2025' ,'9999')
                                          AND GEUMGO_CODE = '28'
                                        ) C
                                WHERE 1 = 1
                                  AND B.GONGGEUM_GYEJWA = A.FIL_100_CTNT5(+)
                                  AND B.GONGGEUM_GYEJWA = C.GONGGEUM_GYEJWA(+)
                                  AND A.GISDT(+) = '20250121'
                                GROUP BY B.GONGGEUM_GYEJWA, B.GONGGEUM_GYEJWA_NM, B.IYUL, C.JANAEK, B.GONGGEUM_YUDONG_ACNO

                                UNION ALL

                               SELECT 1 GUBUN, B.GONGGEUM_GYEJWA, B.GONGGEUM_GYEJWA_NM GYEJWA_NAME,
                                      '' UNYONG_GYEJWA, '' SANGPUM_NAME,
                                      '' MKDT, '' DUDT, 0 HYUN_JAN, B.IYUL, B.GONGGEUM_YUDONG_ACNO
                                 FROM WT_GYEJWA_INFO B

                                UNION ALL

                               SELECT 2 GUBUN, A.GONGGEUM_GYEJWA, A.GONGGEUM_GYEJWA_NM AS GYEJWA_NAME,
                                      B.UNYONG_GYEJWA,
                                      B.SANGPUM_NAME, C.MKDT, C.DUDT, C.JANAEK, C.IYUL, A.GONGGEUM_YUDONG_ACNO
                                 FROM WT_GYEJWA_INFO A, RPT_UNYONG_GYEJWA B, RPT_UNYONG_JAN C
                                WHERE B.GONGGEUM_GYEJWA = C.GONGGEUM_GYEJWA
                                  AND A.GONGGEUM_GYEJWA >= B.GONGGEUM_GYEJWA
                                  AND B.GONGGEUM_GYEJWA LIKE SUBSTR(A.GONGGEUM_GYEJWA, 1, 15) ||'%'
                                  AND SUBSTR(A.GONGGEUM_GYEJWA,1,15) = SUBSTR(B.GONGGEUM_GYEJWA,1,15)
                                  AND (    (A.GONGGEUM_HOIGYE_YEAR <> 9999 AND A.GONGGEUM_GYEJWA >= B.GONGGEUM_GYEJWA)
                                        OR (A.GONGGEUM_HOIGYE_YEAR  = 9999 AND A.GONGGEUM_GYEJWA  = B.GONGGEUM_GYEJWA ))
                                  AND B.UNYONG_GYEJWA = C.UNYONG_GYEJWA
                                  AND SUBSTR(NVL(B.MKDT,B.IN_DATE),1,8) <= '20250121'
                                  AND (B.OUT_DATE IS NULL OR B.OUT_DATE > '20250121')
                                  AND (B.HJI_DT IS NULL OR B.HJI_DT > '20250121')
                                  AND B.BANK_GUBUN = 0
                                  AND C.KIJUNIL = '20250121'
                                  AND NVL('0', '9999') <> '9999'

                                UNION ALL

                               SELECT 1 GUBUN, A.GONGGEUM_GYEJWA, A.GYEJWA_NAME AS GYEJWA_NAME,
                                      '' UNYONG_GYEJWA, '' SANGPUM_NAME,
                                      '' MKDT, '' DUDT, 0 HYUN_JAN, 0 IYUL, '' GONGGEUM_YUDONG_ACNO
                                 FROM ( SELECT B.REF_D_NM GONGGEUM_GYEJWA, B.REF_CTNT1 GYEJWA_NAME,
                                               B.REF_S_C MNGBR, TO_NUMBER(SUBSTR(B.REF_D_NM,4,3)) GUNGU_CODE,
                                               99 HOIGYE_CODE, 99 GYEJWA_BUNRYU
                                         FROM  RPT_CODE_INFO B
                                         WHERE B.REF_L_C = 50
                                           AND B.REF_M_C = '28'
                                           AND B.YUHYO_YN = 0 ) A
                                WHERE 1 = 1
                                  AND NVL('0', '9999') <> '9999'
                                  AND (NVL('', 'ALL') = 'ALL' OR '' = A.MNGBR)
                                  AND (NVL('', 'ALL') = 'ALL' OR '' = A.HOIGYE_CODE)
                                  AND (NVL('02800001210000025', 'ALL') = 'ALL' OR '02800001210000025' = A.GONGGEUM_GYEJWA)
                                  AND (NVL('', 'ALL') = 'ALL' OR '' = A.GUNGU_CODE)
                                  AND (NVL('', 'ALL') = 'ALL' OR '' = A.GYEJWA_BUNRYU)
                                  AND (NVL('', 'ALL') = 'ALL' OR A.GONGGEUM_GYEJWA IN (SELECT SIGUMGO_ACNO FROM ACL_SIGUMGO_MAS_SUB
                                                                                                WHERE SIGUMGO_ORG_C = '28'
                                                                                                  AND LPAD(LINKAC_KWA_C, 3, '0')||LPAD(LINKAC_SER, 9, '0') = ''))

                                UNION ALL

                               SELECT 2 GUBUN, A.GONGGEUM_GYEJWA, A.GYEJWA_NAME, B.UNYONG_GYEJWA,
                                      B.SANGPUM_NAME, C.MKDT, C.DUDT, C.JANAEK, 0 IYUL, '' GONGGEUM_YUDONG_ACNO
                                 FROM ( SELECT B.REF_D_NM GONGGEUM_GYEJWA, B.REF_CTNT1 GYEJWA_NAME,
                                              B.REF_S_C MNGBR, TO_NUMBER(SUBSTR(B.REF_D_NM,4,3)) GUNGU_CODE,
                                              99 HOIGYE_CODE, 99 GYEJWA_BUNRYU
                                        FROM  RPT_CODE_INFO B
                                        WHERE B.REF_L_C = 50
                                          AND B.REF_M_C = '28'
                                          AND B.YUHYO_YN = 0 ) A
                                    , RPT_UNYONG_GYEJWA B
                                    , RPT_UNYONG_JAN C
                                WHERE A.GONGGEUM_GYEJWA = B.GONGGEUM_GYEJWA
                                  AND B.GONGGEUM_GYEJWA = C.GONGGEUM_GYEJWA
                                  AND SUBSTR(A.GONGGEUM_GYEJWA,1,15) = SUBSTR(B.GONGGEUM_GYEJWA,1,15)
                                  AND B.UNYONG_GYEJWA = C.UNYONG_GYEJWA
                                  AND SUBSTR(NVL(B.MKDT,B.IN_DATE),1,8) <= '20250121'
                                  AND (B.OUT_DATE IS NULL OR B.OUT_DATE > '20250121')
                                  AND (B.HJI_DT IS NULL OR B.HJI_DT > '20250121')
                                  AND B.BANK_GUBUN = 0
                                  AND C.KIJUNIL = '20250121'
                                  AND NVL('0', '9999') <> '9999'
                                  AND (NVL('', 'ALL') = 'ALL' OR '' = A.MNGBR)
                                  AND (NVL('', 'ALL') = 'ALL' OR '' = A.HOIGYE_CODE)
                                  AND (NVL('02800001210000025', 'ALL') = 'ALL' OR '02800001210000025' = A.GONGGEUM_GYEJWA)
                                  AND (NVL('', 'ALL') = 'ALL' OR '' = A.GUNGU_CODE)
                                  AND (NVL('', 'ALL') = 'ALL' OR '' = A.GYEJWA_BUNRYU)
                                  AND (NVL('', 'ALL') = 'ALL' OR A.GONGGEUM_GYEJWA IN (SELECT SIGUMGO_ACNO FROM ACL_SIGUMGO_MAS_SUB
                                                                                                WHERE SIGUMGO_ORG_C = '28'
                                                                                                  AND LPAD(LINKAC_KWA_C, 3, '0')||LPAD(LINKAC_SER, 9, '0') = ''))


                                UNION ALL

                               SELECT 2 GUBUN, C.GONGGEUM_GYEJWA_NM AS GYEJWA_NAME,
                                      A.GONGGEUM_GYEJWA, D.UNYONG_GYEJWA,
                                       '통합공금' SANGPUM_NAME, D.MKDT, D.DUDT, A.JANAEK, D.IYUL, C.GONGGEUM_YUDONG_ACNO
                                 FROM RPT_UNYONG_JAN A, RPT_AC_BY_HOIKYE_MAPP B, WT_GYEJWA_INFO C, RPT_UNYONG_JAN D
                                WHERE A.GONGGEUM_GYEJWA = C.GONGGEUM_GYEJWA
                                  AND B.SIGUMGO_ACNO = D.GONGGEUM_GYEJWA

                                  AND A.GEUMGO_CODE = '28'
                                  AND A.UNYONG_GYEJWA = '000000000000'
                                  AND A.KIJUNIL = '20250121'
                                  AND B.SIGUMGO_HOIKYE_YR = '9999'
                                  AND B.SIGUMGO_HOIKYE_C = '99'
                                  AND D.GEUMGO_CODE = '28'
                                  AND D.KIJUNIL = '20250121'
                                  AND NVL('0', '9999') <> '9999'
                           ) MAS
                           GROUP BY GUBUN, GYEJWA_NAME, GONGGEUM_GYEJWA,
                                    SANGPUM_NAME, UNYONG_GYEJWA, MKDT, DUDT, IYUL, GONGGEUM_YUDONG_ACNO
                           ORDER BY GONGGEUM_GYEJWA, GUBUN, UNYONG_GYEJWA, SANGPUM_NAME
                 ) ORG
          ) ORG
         WHERE ROWNUM <= '100'
  ) LIST
 WHERE LIST.RN > '0'