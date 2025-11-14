SELECT
    FIL_100_CTNT5 AS GONGGEUM_GYEJWA
        , ICH_SIGUMGO_GUN_GU_C AS GUNGU_CD
        , SIGUMGO_TRX_G 
        , SIGUMGO_IP_TRX_G 
        , SIGUMGO_JI_TRX_G 
        , SUM(DECODE(CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(IPJI_G , 2, -1, 1) * TRAMT) AS TRAMT 
      FROM ACL_SIGUMGO_SLV
      WHERE 1 = 1
        AND FIL_100_CTNT5 = '02800021100000099'        
        AND TRXDT BETWEEN '20230101' AND '20231231'
        AND MNG_NO = 1
      GROUP BY FIL_100_CTNT5 
        ,ICH_SIGUMGO_GUN_GU_C 
        , SIGUMGO_TRX_G 
        , SIGUMGO_IP_TRX_G 
        , SIGUMGO_JI_TRX_G  
     ORDER BY 
        FIL_100_CTNT5
        , ICH_SIGUMGO_GUN_GU_C 
        , SIGUMGO_TRX_G 
        , SIGUMGO_IP_TRX_G 
        , SIGUMGO_JI_TRX_G    

----------------------------------------------------------------------------------------------------

SELECT
    FIL_100_CTNT5 AS GONGGEUM_GYEJWA
        , SUM(DECODE(CRT_CAN_G, 1, -1, 2, -1, 33, -1, 1) * DECODE(IPJI_G , 2, -1, 1) * TRAMT) AS TRAMT 
      FROM ACL_SIGUMGO_SLV
      WHERE 1 = 1
        AND FIL_100_CTNT5 = '02800021100000099'        
        AND TRXDT < '20230101' 
        AND MNG_NO = 1
      GROUP BY FIL_100_CTNT5    

select * from RPT_GONGGEUM_JAN
where gonggeum_gyejwa = '02800021100000099'
and KEORAEIL = '20221231'


select * from RPT_DANGSEIPJOJEONG
WHERE JIBGYE_CODE = '209330'
AND JUSEOK LIKE '%이월%'
ORDER BY SUNAPIL

----------------------------------------------------------------------------------------------------


SELECT 
    KEORAEIL,
    GONGGEUM_GYEJWA,
    JANAEK,
    IPAMT,
    JIAMT,
    BFJAN
FROM RPT_GONGGEUM_JAN
WHERE
gonggeum_gyejwa = '02800021100000099'
AND KEORAEIL IN (
    '20080102',
    '20090102',
    '20100104',
    '20110103',
    '20120102',
    '20130102',
    '20130102',
    '20140102',
    '20140102',
    '20150102',
    '20160104',
    '20170102',
    '20180102',
    '20190102',
    '20200102',
    '20210104',
    '20220103',
    '20230102',
    '20240102',
    '20250102'
) 
ORDER BY KEORAEIL

----------------------------------------------------------------------------------------------------


SELECT 
    KEORAEIL,
    GONGGEUM_GYEJWA,
    JANAEK,
    IPAMT,
    JIAMT,
    BFJAN
FROM RPT_GONGGEUM_JAN
WHERE
gonggeum_gyejwa LIKE '02800021%99'
AND gonggeum_gyejwa <> '02800021100000099'
AND KEORAEIL IN (
    '20080102',
    '20090102',
    '20100104',
    '20110103',
    '20120102',
    '20130102',
    '20130102',
    '20140102',
    '20140102',
    '20150102',
    '20160104',
    '20170102',
    '20180102',
    '20190102',
    '20200102',
    '20210104',
    '20220103',
    '20230102',
    '20240102',
    '20250102'
) 
ORDER BY KEORAEIL

----------------------------------------------------------------------------------------------------


SELECT 
    KIJUNIL,
    SUM(JANAEK) AS JANAEK
FROM RPT_UNYONG_JAN
WHERE GONGGEUM_GYEJWA = '02800021100000099'
AND KIJUNIL IN (
    '20080102',
    '20090102',
    '20100104',
    '20110103',
    '20120102',
    '20130102',
    '20130102',
    '20140102',
    '20140102',
    '20150102',
    '20160104',
    '20170102',
    '20180102',
    '20190102',
    '20200102',
    '20210104',
    '20220103',
    '20230102',
    '20240102',
    '20250102'    
)
GROUP BY KIJUNIL
ORDER BY KIJUNIL

----------------------------------------------------------------------------------------------------


SELECT 
    KIJUNIL,
    SUM(JANAEK) AS JANAEK
FROM RPT_UNYONG_JAN
WHERE GONGGEUM_GYEJWA LIKE '02800021%99'
AND GONGGEUM_GYEJWA <> '02800021100000099'
AND KIJUNIL IN (
    '20080102',
    '20090102',
    '20100104',
    '20110103',
    '20120102',
    '20130102',
    '20130102',
    '20140102',
    '20140102',
    '20150102',
    '20160104',
    '20170102',
    '20180102',
    '20190102',
    '20200102',
    '20210104',
    '20220103',
    '20230102',
    '20240102',
    '20250102'    
)
GROUP BY KIJUNIL
ORDER BY KIJUNIL

----------------------------------------------------------------------------------------------------


SELECT 
    KIJUNIL,
    SUM(JANAEK) AS JANAEK
FROM RPT_UNYONG_JAN
WHERE GONGGEUM_GYEJWA = '02800021100000099'
AND KIJUNIL IN (
    '20220104'   
)
GROUP BY KIJUNIL
ORDER BY KIJUNIL

----------------------------------------------------------------------------------------------------


 SELECT 
    *
FROM RPT_UNYONG_JAN
WHERE gonggeum_gyejwa LIKE '02800021%99'
AND gonggeum_gyejwa <> '02800021100000099'
AND KIJUNIL > '20210101'
ORDER BY KIJUNIL, UNYONG_GYEJWA