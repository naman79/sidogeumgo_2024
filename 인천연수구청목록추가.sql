SELECT
    REF_L_C     , REF_L_NM   , REF_M_C    ,
    REF_M_NM    , REF_S_C    , REF_S_NM   ,
    REF_D_C     , REF_D_NM   , YUHYO_YN   ,
    REF_CTNT1   , REF_CTNT2  , REF_CTNT3
FROM
    RPT_CODE_INFO
WHERE
    REF_L_C = 110
  AND REF_M_C = NVL(28, REF_M_C)
  AND REF_S_C = NVL(185, REF_S_C)
ORDER BY
    REF_L_C, REF_M_C, REF_S_C, REF_D_C


