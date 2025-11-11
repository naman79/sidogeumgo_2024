-- 공금 계좌 조회 (Public Funds Account Lookup)
SELECT SGG_ACNO
     , SGG_ACNO_NM
     , SIGUMGO_AC_NM
     , HOIKYE_C
     , HOIKYE_NM
     , ORG_C_NM
     , ORG_C
  FROM rpt_gonggeum_gyejwa
 WHERE 1=1
   AND GEUMGO_CODE = '28'  -- 금고 코드
   -- AND HOIKYE_C = '1'   -- 회계 코드 (필요시 주석 해제)
   -- AND PADM_STD_ORG_C = '6280147'  -- 기관 코드 (필요시 주석 해제)
 ORDER BY SGG_ACNO;
