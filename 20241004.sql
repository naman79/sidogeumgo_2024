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

