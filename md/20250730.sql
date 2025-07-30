select count(*) as cnt from rpt_usrf_info where 1=1
and sync_date = '20250730'
and laf_cd in (
 select
  laf_cd
 from rpt_dept_info where laf_nm like '인천%'
group by laf_cd
)