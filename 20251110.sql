SELECT SGG_ACNO
     , SGG_ACNO_NM
     , SIGUMGO_AC_NM
     , HOIKYE_C
     , HOIKYE_NM
     , ORG_C_NM
     , ORG_C
  FROM
(
        WITH WT_ICH_ASID_CODE AS 
        (
          SELECT (CASE WHEN SUBSTR(REF_D_NM,16,2) = 'YY' THEN SUBSTR(REF_D_NM,0,15)||TO_CHAR(TO_NUMBER(SUBSTR('2025',3,2))) 
                       ELSE REF_D_NM END) AS GONGGEUM_GYEJWA
            FROM RPT_CODE_INFO
           WHERE REF_L_C=520 
             AND REF_M_C=28
             AND REF_S_C = NVL('','1')
        ),
        WT_RPT_ACNO_RST AS
        (
           SELECT SGG_ACNO
             FROM RPT_JEONJA_ACNO_LIST
           WHERE GEUMGO_CODE = '28'
             AND PADM_STD_ORG_C = 'all'
             AND ('all' = 'all' OR SL_GMGO_DEPT_C = 'all')
             AND (-1 = -1 OR BRNO = -1)
             AND RPT_ID = ''
             AND RPT_AC_G = ''
           GROUP BY SGG_ACNO         
        ),
        WT_ACNO_RST AS
        (
           SELECT ADM.SGG_ACNO
             FROM SFI_ORG_DEPT_C_MNG ODC
            INNER JOIN SFI_ORG_BY_DEPT_MNG OBD
                    ON OBD.PADM_STD_ORG_C = ODC.PADM_STD_ORG_C
            INNER JOIN RPT_JEONJA_AC_BY_DEPT_MNG ADM
                    ON ADM.GEUMGO_CODE = '28'
                   AND ADM.SL_GMGO_DEPT_C = OBD.G_CC_DEPT_C
                   AND (ADM.HOIKYE_YEAR = '2025' OR ADM.HOIKYE_YEAR = '9999')
                   AND (ADM.USE_G = '1' OR ADM.USE_G = '2')
                   AND ADM.DEL_YN = 'N'
             WHERE ('all'  = 'all'            OR ODC.REP_ORG_C = 'all') 
               AND ('all'  = 'all'            OR OBD.PADM_STD_ORG_C = 'all')
               AND ('all'  = 'all'           OR ADM.SL_GMGO_DEPT_C = 'all')
               AND ODC.DEL_YN = 'N'
             GROUP BY ADM.SGG_ACNO
        ),
        WT_SSO_RST AS
        (
           SELECT FIL_100_CTNT2 AS SGG_ACNO
             FROM ACL_SIGUMGO_MAS
            WHERE (SIGUMGO_HOIKYE_YR = '2025' OR SIGUMGO_HOIKYE_YR = '9999')
              AND FIL_YN4 = 4
        )
        SELECT ROWNUM AS R_NUM
             , A.*
          FROM 
        (
               SELECT SGM.SIGUMGO_ACNO AS SGG_ACNO
                    , REGEXP_REPLACE(SGM.SIGUMGO_ACNO, '([[:digit:]]{3})([[:digit:]]{3})([[:digit:]]{2})([[:digit:]]{2})([[:digit:]]{5})([[:digit:]]{2})','\1-\2-\3-\4-\5-\6')|| ' [' || TRIM(SGM.SIGUMGO_AC_NM) || ']'  AS SGG_ACNO_NM
                    , TRIM(SGM.SIGUMGO_AC_NM) AS SIGUMGO_AC_NM
                    , SGM.SIGUMGO_HOIKYE_C AS HOIKYE_C
                    , TRIM(HKC.HOIKYE_NM) AS HOIKYE_NM
                    , '' ORG_C_NM
                    , '' ORG_C
                 FROM WT_ACNO_RST ADM
                INNER JOIN ACL_SIGUMGO_MAS_SUB SGM
                        ON SIGUMGO_ORG_C = '28'
                       AND SGM.SIGUMGO_ACNO = ADM.SGG_ACNO
                INNER JOIN RPT_HOIKYE_CD HKC
                        ON SGM.SIGUMGO_HOIKYE_C = HKC.SIGUMGO_HOIKYE_C
                       AND HKC.SIGUMGO_C = '28'
                       AND HKC.USE_YN = 'Y'
                WHERE ('-1'  = '-1'      OR TO_CHAR(SGM.SIGUMGO_AC_B) = '-1')
                  AND ('-1'  = '-1'  OR (TO_CHAR(SGM.SIGUMGO_AC_B) != '-1') AND SGM.SIGUMGO_AC_B NOT IN (60,69,80,90))
                  AND ('1'  = '-1'          OR TO_CHAR(SGM.SIGUMGO_HOIKYE_C) = '1')
                  AND ('all' = 'all'         OR REGEXP_LIKE(HKC.HOIKYE_NM, 'all'))
                  AND ('all' != '50'         OR SGM.SIGUMGO_ACNO IN (SELECT GONGGEUM_GYEJWA FROM WT_ICH_ASID_CODE))
                  AND ('all' = 'all'       OR SGM.SIGUMGO_ACNO IN (SELECT SGG_ACNO FROM WT_RPT_ACNO_RST))
                  AND (-1 = -1             OR SGM.SIGUMGO_AGE_AC_G = -1)
                  AND ('all' = 'all'     OR REGEXP_LIKE(SGM.SIGUMGO_ACNO, 'all') OR REGEXP_LIKE(SGM.SIGUMGO_AC_NM, 'all'))
                  AND (-1 = -1              OR (SGM.AC_GRBRNO = -1 OR SGM.SIGUMGO_AGE_JI_BRNO = -1))
                  AND (-1 = -1              OR SGM.SIGUMGO_ACNO IN (SELECT SGG_ACNO FROM WT_SSO_RST))
                GROUP BY SGM.SIGUMGO_ACNO, SGM.SIGUMGO_AC_NM, SGM.SIGUMGO_HOIKYE_C, HKC.HOIKYE_NM
                ORDER BY SGM.SIGUMGO_ACNO
        ) A
        WHERE ROWNUM <= '2000'
) X
WHERE X.R_NUM >= '0'
ORDER BY X.R_NUM


-------------------------------



SELECT SGG_ACNO
     , SGG_ACNO_NM
     , SIGUMGO_AC_NM
     , HOIKYE_C
     , HOIKYE_NM
     , ORG_C_NM
     , ORG_C
  FROM
(
        WITH WT_ICH_ASID_CODE AS 
        (
          SELECT (CASE WHEN SUBSTR(REF_D_NM,16,2) = 'YY' THEN SUBSTR(REF_D_NM,0,15)||TO_CHAR(TO_NUMBER(SUBSTR('2025',3,2))) 
                       ELSE REF_D_NM END) AS GONGGEUM_GYEJWA
            FROM RPT_CODE_INFO
           WHERE REF_L_C=520 
             AND REF_M_C=28
             AND REF_S_C = NVL('','1')
        ),
        WT_RPT_ACNO_RST AS
        (
           SELECT SGG_ACNO
             FROM RPT_JEONJA_ACNO_LIST
           WHERE GEUMGO_CODE = '28'
             AND PADM_STD_ORG_C = '6280147'
             AND ('6280147' = 'all' OR SL_GMGO_DEPT_C = '6280147')
             AND (-1 = -1 OR BRNO = -1)
             AND RPT_ID = 'ICH030320M01'
             AND RPT_AC_G = ''
           GROUP BY SGG_ACNO         
        ),
        WT_ACNO_RST AS
        (
           SELECT ADM.SGG_ACNO
             FROM SFI_ORG_DEPT_C_MNG ODC
            INNER JOIN SFI_ORG_BY_DEPT_MNG OBD
                    ON OBD.PADM_STD_ORG_C = ODC.PADM_STD_ORG_C
            INNER JOIN RPT_JEONJA_AC_BY_DEPT_MNG ADM
                    ON ADM.GEUMGO_CODE = '28'
                   AND ADM.SL_GMGO_DEPT_C = OBD.G_CC_DEPT_C
                   AND (ADM.HOIKYE_YEAR = '2025' OR ADM.HOIKYE_YEAR = '9999')
                   AND (ADM.USE_G = '1' OR ADM.USE_G = '2')
                   AND ADM.DEL_YN = 'N'
             WHERE ('6280000'  = 'all'            OR ODC.REP_ORG_C = '6280000') 
               AND ('6280147'  = 'all'            OR OBD.PADM_STD_ORG_C = '6280147')
               AND ('6280147'  = 'all'           OR ADM.SL_GMGO_DEPT_C = '6280147')
               AND ODC.DEL_YN = 'N'
             GROUP BY ADM.SGG_ACNO
        ),
        WT_SSO_RST AS
        (
           SELECT FIL_100_CTNT2 AS SGG_ACNO
             FROM ACL_SIGUMGO_MAS
            WHERE (SIGUMGO_HOIKYE_YR = '2025' OR SIGUMGO_HOIKYE_YR = '9999')
              AND FIL_YN4 = 4
        )
        SELECT ROWNUM AS R_NUM
             , A.*
          FROM 
        (
               SELECT SGM.SIGUMGO_ACNO AS SGG_ACNO
                    , REGEXP_REPLACE(SGM.SIGUMGO_ACNO, '([[:digit:]]{3})([[:digit:]]{3})([[:digit:]]{2})([[:digit:]]{2})([[:digit:]]{5})([[:digit:]]{2})','\1-\2-\3-\4-\5-\6')|| ' [' || TRIM(SGM.SIGUMGO_AC_NM) || ']'  AS SGG_ACNO_NM
                    , TRIM(SGM.SIGUMGO_AC_NM) AS SIGUMGO_AC_NM
                    , SGM.SIGUMGO_HOIKYE_C AS HOIKYE_C
                    , TRIM(HKC.HOIKYE_NM) AS HOIKYE_NM
                    , '' ORG_C_NM
                    , '' ORG_C
                 FROM WT_ACNO_RST ADM
                INNER JOIN ACL_SIGUMGO_MAS_SUB SGM
                        ON SIGUMGO_ORG_C = '28'
                       AND SGM.SIGUMGO_ACNO = ADM.SGG_ACNO
                INNER JOIN RPT_HOIKYE_CD HKC
                        ON SGM.SIGUMGO_HOIKYE_C = HKC.SIGUMGO_HOIKYE_C
                       AND HKC.SIGUMGO_C = '28'
                       AND HKC.USE_YN = 'Y'
                WHERE ('-1'  = '-1'      OR TO_CHAR(SGM.SIGUMGO_AC_B) = '-1')
                  AND ('-1'  = '-1'  OR (TO_CHAR(SGM.SIGUMGO_AC_B) != '-1') AND SGM.SIGUMGO_AC_B NOT IN (60,69,80,90))
                  AND ('1'  = '-1'          OR TO_CHAR(SGM.SIGUMGO_HOIKYE_C) = '1')
                  AND ('all' = 'all'         OR REGEXP_LIKE(HKC.HOIKYE_NM, 'all'))
                  AND ('all' != '50'         OR SGM.SIGUMGO_ACNO IN (SELECT GONGGEUM_GYEJWA FROM WT_ICH_ASID_CODE))
                  AND ('all' = 'all'       OR SGM.SIGUMGO_ACNO IN (SELECT SGG_ACNO FROM WT_RPT_ACNO_RST))
                  AND (-1 = -1             OR SGM.SIGUMGO_AGE_AC_G = -1)
                  AND ('all' = 'all'     OR REGEXP_LIKE(SGM.SIGUMGO_ACNO, 'all') OR REGEXP_LIKE(SGM.SIGUMGO_AC_NM, 'all'))
                  AND (-1 = -1              OR (SGM.AC_GRBRNO = -1 OR SGM.SIGUMGO_AGE_JI_BRNO = -1))
                  AND (-1 = -1              OR SGM.SIGUMGO_ACNO IN (SELECT SGG_ACNO FROM WT_SSO_RST))
                GROUP BY SGM.SIGUMGO_ACNO, SGM.SIGUMGO_AC_NM, SGM.SIGUMGO_HOIKYE_C, HKC.HOIKYE_NM
                ORDER BY SGM.SIGUMGO_ACNO
        ) A
        WHERE ROWNUM <= '2000'
) X
WHERE X.R_NUM >= '0'
ORDER BY X.R_NUM









WITH WT_ICH_ASID_CODE AS 
        (
          SELECT (CASE WHEN SUBSTR(REF_D_NM,16,2) = 'YY' THEN SUBSTR(REF_D_NM,0,15)||TO_CHAR(TO_NUMBER(SUBSTR('2025',3,2))) 
                       ELSE REF_D_NM END) AS GONGGEUM_GYEJWA
            FROM RPT_CODE_INFO
           WHERE REF_L_C=520 
             AND REF_M_C=28
             AND REF_S_C = NVL('','1')
        ),
        WT_RPT_ACNO_RST AS
        (
           SELECT SGG_ACNO
             FROM RPT_JEONJA_ACNO_LIST
           WHERE GEUMGO_CODE = '28'
             AND PADM_STD_ORG_C = '6280147'
             AND ('6280147' = 'all' OR SL_GMGO_DEPT_C = '6280147')
             AND (-1 = -1 OR BRNO = -1)
             AND RPT_ID = 'ICH030320M01'
             AND RPT_AC_G = ''
           GROUP BY SGG_ACNO         
        ),
        WT_ACNO_RST AS
        (
           SELECT ADM.SGG_ACNO
             FROM SFI_ORG_DEPT_C_MNG ODC
            INNER JOIN SFI_ORG_BY_DEPT_MNG OBD
                    ON OBD.PADM_STD_ORG_C = ODC.PADM_STD_ORG_C
            INNER JOIN RPT_JEONJA_AC_BY_DEPT_MNG ADM
                    ON ADM.GEUMGO_CODE = '28'
                   AND ADM.SL_GMGO_DEPT_C = OBD.G_CC_DEPT_C
                   AND (ADM.HOIKYE_YEAR = '2025' OR ADM.HOIKYE_YEAR = '9999')
                   AND (ADM.USE_G = '1' OR ADM.USE_G = '2')
                   AND ADM.DEL_YN = 'N'
             WHERE ('6280000'  = 'all'            OR ODC.REP_ORG_C = '6280000') 
               AND ('6280147'  = 'all'            OR OBD.PADM_STD_ORG_C = '6280147')
               AND ('6280147'  = 'all'           OR ADM.SL_GMGO_DEPT_C = '6280147')
               AND ODC.DEL_YN = 'N'
             GROUP BY ADM.SGG_ACNO
        ),
        WT_SSO_RST AS
        (
           SELECT FIL_100_CTNT2 AS SGG_ACNO
             FROM ACL_SIGUMGO_MAS
            WHERE (SIGUMGO_HOIKYE_YR = '2025' OR SIGUMGO_HOIKYE_YR = '9999')
              AND FIL_YN4 = 4
        )
               SELECT SGM.SIGUMGO_ACNO AS SGG_ACNO
                    , REGEXP_REPLACE(SGM.SIGUMGO_ACNO, '([[:digit:]]{3})([[:digit:]]{3})([[:digit:]]{2})([[:digit:]]{2})([[:digit:]]{5})([[:digit:]]{2})','\1-\2-\3-\4-\5-\6')|| ' [' || TRIM(SGM.SIGUMGO_AC_NM) || ']'  AS SGG_ACNO_NM
                    , TRIM(SGM.SIGUMGO_AC_NM) AS SIGUMGO_AC_NM
                    , SGM.SIGUMGO_HOIKYE_C AS HOIKYE_C
                    , TRIM(HKC.HOIKYE_NM) AS HOIKYE_NM
                    , '' ORG_C_NM
                    , '' ORG_C
                 FROM WT_ACNO_RST ADM
                INNER JOIN ACL_SIGUMGO_MAS_SUB SGM
                        ON SIGUMGO_ORG_C = '28'
                       AND SGM.SIGUMGO_ACNO = ADM.SGG_ACNO
                INNER JOIN RPT_HOIKYE_CD HKC
                        ON SGM.SIGUMGO_HOIKYE_C = HKC.SIGUMGO_HOIKYE_C
                       AND HKC.SIGUMGO_C = '28'
                       AND HKC.USE_YN = 'Y'
                WHERE ('-1'  = '-1'      OR TO_CHAR(SGM.SIGUMGO_AC_B) = '-1')
                  AND ('-1'  = '-1'  OR (TO_CHAR(SGM.SIGUMGO_AC_B) != '-1') AND SGM.SIGUMGO_AC_B NOT IN (60,69,80,90))
                  AND ('1'  = '-1'          OR TO_CHAR(SGM.SIGUMGO_HOIKYE_C) = '1')
                  AND ('all' = 'all'         OR REGEXP_LIKE(HKC.HOIKYE_NM, 'all'))
                  AND ('all' != '50'         OR SGM.SIGUMGO_ACNO IN (SELECT GONGGEUM_GYEJWA FROM WT_ICH_ASID_CODE))
                  AND ('all' = 'all'       OR SGM.SIGUMGO_ACNO IN (SELECT SGG_ACNO FROM WT_RPT_ACNO_RST))
                  AND (-1 = -1             OR SGM.SIGUMGO_AGE_AC_G = -1)
                  AND ('all' = 'all'     OR REGEXP_LIKE(SGM.SIGUMGO_ACNO, 'all') OR REGEXP_LIKE(SGM.SIGUMGO_AC_NM, 'all'))
                  AND (-1 = -1              OR (SGM.AC_GRBRNO = -1 OR SGM.SIGUMGO_AGE_JI_BRNO = -1))
                  AND (-1 = -1              OR SGM.SIGUMGO_ACNO IN (SELECT SGG_ACNO FROM WT_SSO_RST))
                GROUP BY SGM.SIGUMGO_ACNO, SGM.SIGUMGO_AC_NM, SGM.SIGUMGO_HOIKYE_C, HKC.HOIKYE_NM
                ORDER BY SGM.SIGUMGO_ACNO


---------------------------------------------------------------


WITH WT_ICH_ASID_CODE AS 
        (
          SELECT (CASE WHEN SUBSTR(REF_D_NM,16,2) = 'YY' THEN SUBSTR(REF_D_NM,0,15)||TO_CHAR(TO_NUMBER(SUBSTR('2025',3,2))) 
                       ELSE REF_D_NM END) AS GONGGEUM_GYEJWA
            FROM RPT_CODE_INFO
           WHERE REF_L_C=520 
             AND REF_M_C=28
             AND REF_S_C = NVL('','1')
        ),
                WT_ACNO_RST AS
        (
           SELECT ADM.SGG_ACNO
             FROM SFI_ORG_DEPT_C_MNG ODC
            INNER JOIN SFI_ORG_BY_DEPT_MNG OBD
                    ON OBD.PADM_STD_ORG_C = ODC.PADM_STD_ORG_C
            INNER JOIN RPT_JEONJA_AC_BY_DEPT_MNG ADM
                    ON ADM.GEUMGO_CODE = '28'
                   AND ADM.SL_GMGO_DEPT_C = OBD.G_CC_DEPT_C
                   AND (ADM.HOIKYE_YEAR = '2025' OR ADM.HOIKYE_YEAR = '9999')
                   AND (ADM.USE_G = '1' OR ADM.USE_G = '2')
                   AND ADM.DEL_YN = 'N'
             WHERE ('6280000'  = 'all'            OR ODC.REP_ORG_C = '6280000') 
               AND ('6280147'  = 'all'            OR OBD.PADM_STD_ORG_C = '6280147')
               AND ('6280147'  = 'all'           OR ADM.SL_GMGO_DEPT_C = '6280147')
               AND ODC.DEL_YN = 'N'
             GROUP BY ADM.SGG_ACNO
        )
               SELECT SGM.SIGUMGO_ACNO AS SGG_ACNO
                    , REGEXP_REPLACE(SGM.SIGUMGO_ACNO, '([[:digit:]]{3})([[:digit:]]{3})([[:digit:]]{2})([[:digit:]]{2})([[:digit:]]{5})([[:digit:]]{2})','\1-\2-\3-\4-\5-\6')|| ' [' || TRIM(SGM.SIGUMGO_AC_NM) || ']'  AS SGG_ACNO_NM
                    , TRIM(SGM.SIGUMGO_AC_NM) AS SIGUMGO_AC_NM
                    , SGM.SIGUMGO_HOIKYE_C AS HOIKYE_C
                    , TRIM(HKC.HOIKYE_NM) AS HOIKYE_NM
                    , '' ORG_C_NM
                    , '' ORG_C
                 FROM WT_ACNO_RST ADM
                INNER JOIN ACL_SIGUMGO_MAS_SUB SGM
                        ON SIGUMGO_ORG_C = '28'
                       AND SGM.SIGUMGO_ACNO = ADM.SGG_ACNO
                INNER JOIN RPT_HOIKYE_CD HKC
                        ON SGM.SIGUMGO_HOIKYE_C = HKC.SIGUMGO_HOIKYE_C
                       AND HKC.SIGUMGO_C = '28'
                       AND HKC.USE_YN = 'Y'
                WHERE ('-1'  = '-1'      OR TO_CHAR(SGM.SIGUMGO_AC_B) = '-1')
                  AND ('-1'  = '-1'  OR (TO_CHAR(SGM.SIGUMGO_AC_B) != '-1') AND SGM.SIGUMGO_AC_B NOT IN (60,69,80,90))
                  AND ('1'  = '-1'          OR TO_CHAR(SGM.SIGUMGO_HOIKYE_C) = '1')
                  AND ('all' = 'all'         OR REGEXP_LIKE(HKC.HOIKYE_NM, 'all'))
                  AND ('all' != '50'         OR SGM.SIGUMGO_ACNO IN (SELECT GONGGEUM_GYEJWA FROM WT_ICH_ASID_CODE))
                  AND (-1 = -1             OR SGM.SIGUMGO_AGE_AC_G = -1)
                  AND ('all' = 'all'     OR REGEXP_LIKE(SGM.SIGUMGO_ACNO, 'all') OR REGEXP_LIKE(SGM.SIGUMGO_AC_NM, 'all'))
                  AND (-1 = -1              OR (SGM.AC_GRBRNO = -1 OR SGM.SIGUMGO_AGE_JI_BRNO = -1))
                GROUP BY SGM.SIGUMGO_ACNO, SGM.SIGUMGO_AC_NM, SGM.SIGUMGO_HOIKYE_C, HKC.HOIKYE_NM
                ORDER BY SGM.SIGUMGO_ACNO