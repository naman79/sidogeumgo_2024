select count(*) as cnt  from acl_sigumgo_slv
where 1=1 
and trxdt > '20240601'
and trxdt <> gisdt


select *  from acl_sigumgo_slv
where 1=1 
and trxdt > '20240601'
and trxdt <> gisdt
and FIL_100_CTNT5 in (
select GONGGEUM_GYEJWA from rpt_fisg_info_map
where 1=1
and fyr = 2024
)


select GONGGEUM_GYEJWA from rpt_fisg_info_map
where 1=1
and fyr = 2024
