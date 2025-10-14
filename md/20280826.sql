    select * from rpt_gita_jipgye
    where 1=1


    select * from rpt_gita_jipgye
where 1=1
and keoraeil like '2025082%'


select * from rpt_gita_jipgye where jigye_name1 = '담배세'



  SELECT A.*             
        FROM  SFI_USER_INF A                     
        WHERE A.SL_GMGO_MODL_C = 'RPT'               
          AND (A.USER_ID LIKE '%'|| '송은희' ||'%' OR A.USER_NM LIKE '%'|| '송은희' ||'%')
          AND ( NVL('','0') = '0' OR A.USER_U_C = '' )
          AND ( NVL('', '0') = '0' OR A.PADM_STD_ORG_C = '' )
          AND ( NVL('', '0') = '0' OR A.SL_GMGO_DEPT_C = '' )
          AND ( NVL('', '0') = '0' OR A.BR_C = '' )
          AND A.LST_LOGIN_DT BETWEEN '00000000' AND '99999999'
          AND A.UPD_DTTM BETWEEN '00000000' AND '99999999' || '999999'
          AND A.PADM_STD_ORG_C <> '0000000'  
        ORDER BY A.USER_U_C, A.PADM_STD_ORG_C, A.SL_GMGO_DEPT_C, A.BR_C, A.USER_ID


        59.7.254.200


    SELECT 
        SUM(NAPBU_TCNT) AS DAMBE_CNT,
        SUM(BON_AMT) AS DAMBE_AMT,
        SUM(KYO_AMT) AS KYOUK_AMT
    FROM (
    select 
     NAPBU_TCNT,
     DATA04 AS BON_AMT,
     DATA05 AS KYO_AMT 
    from nio_ai_mastr_tab
    where sunp_dt = '20250818'
    and forms_g = '2' and nvl(insik_g, '0') not in ('D', 'R')
    and guchung_cd not in ('710', '720')
    and smok_cd = '110000'
    and hoikye_cd = '39'
    )