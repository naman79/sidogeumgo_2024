SELECT *
FROM ACL_SIGUMGO_SLV
WHERE SIGUMGO_TRX_G = 61
  AND SIGUMGO_JI_TRX_G = 2
  AND gisdt LIKE '2024%'
  AND FIL_100_CTNT5 IN (SELECT GONGGEUM_GYEJWA FROM RPT_FISG_INFO_MAP WHERE FYR = '2024'
                                                                        AND USE_YN = 'Y')
order by gisdt                                                                        



select GEUMGO_CODE, JOJEONG_GUBUN, IPJI_GUBUN from RPT_DANGSEIPJOJEONG
where 1=1
group by GEUMGO_CODE, JOJEONG_GUBUN, IPJI_GUBUN

select * from RPT_DANGSEIPJOJEONG
where JOJEONG_GUBUN = 3
order by KEORAEIL desc