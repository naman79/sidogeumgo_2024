select * from rpt_unyong_gyejwa
where 1=1
and mkdt >= '20240925'
and geumgo_code <> 11
order by mkdt desc


-- 기산일 변경 조회
SELECT *
FROM ACL_SIGUMGO_SLV
WHERE TRXDT <> GISDT
  AND TRXDT IN ('20241002')
  AND FIL_100_CTNT5 IN (SELECT GONGGEUM_GYEJWA FROM RPT_FISG_INFO_MAP WHERE FYR = '2024' AND USE_YN = 'Y')
-- 변경된 기산일 변경 데이터가 있을 경우 /shbftp/tom/rpt/snd/fin 경로에
-- 해당 지역, 날짜에 생성된 **004*.dat 파일을 열고 변경된 날짜부터 그 전까지 데이터가 잘 생성되었는지 확인한다.

-- 부서별 계좌관리 미등록 계좌 등록/수정 확인
SELECT *
FROM RPT_JEONJA_AC_BY_DEPT_MNG
WHERE DR_DTTM LIKE '202410%'
-- 데이터가 있을 경우 DEL_YN가 N으로 들어오는지, SIGUMGO_AC_G도 숫자로 들어오는지
-- SITAX_GUTAX_G, CT_GU_C도 제대로 들어오는지 확인한다.

SELECT 
  RNUM
 , SL_GMGO_MODL_C
 , USER_ID
 , USER_NM
 , DR_SER
 , MENU_ID
 , MENU_NM  
 , SCR_ID
 , SCR_NM
 , DR_DTTM
 , DROKJA_ID
 , UPD_DTTM
 , MODR_ID
FROM  (
 SELECT 
  ROWNUM AS RNUM
  , Z.SL_GMGO_MODL_C
  , Z.USER_ID
  , (SELECT MAX(B.USER_NM)  USER_NM
       FROM  SFI_USER_INF B
       WHERE Z.MODR_ID = B.USER_ID) AS USER_NM
  , Z.DR_SER
  , Z.MENU_ID
  ,B.MENU_NM
  , Z.SCR_ID
  , C.SCR_NM
  , Z.DR_DTTM
  , Z.DROKJA_ID
  , Z.UPD_DTTM
  , Z.MODR_ID
 FROM  SFI_SCR_LTST_HIS Z, RPT_MENU_INF B, SFI_SCR_INF C
 WHERE 
   Z.SL_GMGO_MODL_C = 'RPT'
  AND ((SELECT MAX(A.USER_NM) 
          FROM  SFI_USER_INF A 
         WHERE Z.MODR_ID = A.USER_ID) LIKE '%'||''||'%'
       OR Z.USER_ID LIKE '%'||''||'%' )
  AND ((SELECT MAX(E.MENU_NM)
          FROM    SFI_MENU_INF E
         WHERE  E.SL_GMGO_MODL_C = 'RPT'
           AND Z.MENU_ID = E.MENU_ID) LIKE '%'||''||'%'
       OR Z.MENU_ID LIKE '%'||''||'%' )
  AND ((SELECT MAX(F.SCR_NM)
          FROM    SFI_SCR_INF F
         WHERE  F.SL_GMGO_MODL_C = 'RPT'
           AND Z.SCR_ID = F.SCR_ID) LIKE '%'||'월별'||'%'
       OR Z.SCR_ID LIKE '%'||'월별'||'%' )
  AND Z.DR_DTTM LIKE '%'||'2024'||'%'
  AND Z.SL_GMGO_MODL_C = B.SL_GMGO_MODL_C
  AND Z.MENU_ID = B.MENU_ID
  AND Z.SL_GMGO_MODL_C = C.SL_GMGO_MODL_C
  AND Z.SCR_ID = C.SCR_ID
  AND ROWNUM <= 100
  ORDER BY UPD_DTTM DESC
) X
WHERE X.RNUM >= 0



인천 중구청 위생환경과 식품진흥기금 계좌 조회가 안됩니다.!
(계좌 2개)
28-110-75-20-00000-99
28-110-75-10-00000-99

2811075200000099
2811075100000099