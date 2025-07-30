-- 인천이외의 지역에서 기산일 거래가 있었던 경우를 조사하기

select LPAD(SIGUMGO_TRX_G, 2, '0') || LPAD(SIGUMGO_IP_TRX_G, 2, '0') || LPAD(SIGUMGO_JI_TRX_G, 2, '0') AS GG from acl_sigumgo_slv where rownum = 1

select count(*) as cnt from acl_sigumgo_slv
where trxdt > gisdt
and trxdt >= '20250101'
and sigumgo_org_c in ('42','43','110','130','150','439','440')


select max(A.trxdt) as max_trxdt, A.sigumgo_org_c, A.fil_100_ctnt5, B.acnt_dv_cd from acl_sigumgo_slv A
inner join rpt_fisg_info_map B on A.fil_100_ctnt5 = B.gonggeum_gyejwa
where A.trxdt <> A.gisdt
and A.trxdt >= '20250101'
and A.sigumgo_org_c = '28'
and LPAD(A.SIGUMGO_TRX_G, 2, '0') || LPAD(A.SIGUMGO_IP_TRX_G, 2, '0') || LPAD(A.SIGUMGO_JI_TRX_G, 2, '0') in (
    SELECT 
        CMM_DTL_C
    FROM  SFI_CMM_C_DAT 
    WHERE CMM_C_NM = '이호조세입세출송신용'
    and USE_YN = 'Y'
)
group by A.sigumgo_org_c, A.fil_100_ctnt5, B.acnt_dv_cd
order by A.sigumgo_org_c, A.fil_100_ctnt5


select max(A.trxdt) as max_trxdt, A.sigumgo_org_c, A.fil_100_ctnt5, B.acnt_dv_cd from acl_sigumgo_slv A
inner join rpt_fisg_info_map B on A.fil_100_ctnt5 = B.gonggeum_gyejwa
where A.trxdt <> A.gisdt
and A.trxdt >= '20250101'
and A.sigumgo_org_c in ('42','43','110','130','150','439','440')
and LPAD(A.SIGUMGO_TRX_G, 2, '0') || LPAD(A.SIGUMGO_IP_TRX_G, 2, '0') || LPAD(A.SIGUMGO_JI_TRX_G, 2, '0') in (
    SELECT 
        CMM_DTL_C
    FROM  SFI_CMM_C_DAT 
    WHERE CMM_C_NM = '이호조세입세출송신용'
    and USE_YN = 'Y'
)

group by A.sigumgo_org_c, A.fil_100_ctnt5, B.acnt_dv_cd
order by A.sigumgo_org_c, A.fil_100_ctnt5


select max(A.gisdt) as max_gisdt, A.sigumgo_org_c, A.fil_100_ctnt5, B.acnt_dv_cd from acl_sigumgo_slv A
inner join rpt_fisg_info_map B on A.fil_100_ctnt5 = B.gonggeum_gyejwa
where A.trxdt <> A.gisdt
and A.trxdt >= '20250101'
and A.sigumgo_org_c in ('42','43','110','130','150','439','440')
group by A.sigumgo_org_c, A.fil_100_ctnt5, B.acnt_dv_cd
order by A.sigumgo_org_c, A.fil_100_ctnt5

select min(trxdt) as min_trxdt, sigumgo_org_c from acl_sigumgo_slv
where trxdt <> gisdt
and trxdt >= '20240101'
and sigumgo_org_c in ('42','43','110','130','150','439','440')
group by sigumgo_org_c

SELECT 
                                          GONGGEUM_GYEJWA,
                                          USE_YN
                                    FROM RPT_FISG_INFO_MAP E
                                   WHERE E.FYR = '2025'
                                   and USE_YN = 'Y'

-- MAX_TRXDT	SIGUMGO_ORG_C	FIL_100_CTNT5	ACNT_DV_CD
-- 20250210	     42	        04200080900004024	212
-- 20250113	     110	    11000080900000199	310
-- 20250717	     110	    11000080900000299	310
-- 20250113	     110	    11000080900000499	320
-- 20250724	     110	    11000080900001325	225
-- 20250103	     110	    11000080900001424	220
-- 20250108	     110	    11000080900001524	215
-- 20250108	     110	    11000080900001525	215
-- 20250116	     110	    11000080900001624	240
-- 20250116	     110	    11000080900001625	240
-- 20250507	     110	    11000080900001725	250
-- 20250120	     130	    13000080900000199	310
-- 20250416	     150	    15000080900001525	206
-- 20250416	     150	    15000080900003925	206
-- 20250115	     439	    43900080900000224	210
-- 20250115	     439	    43900080900000225	210
-- 20250115	     439	    43900080900000825	230
-- 20250306	     439	    43900080900001624	245
-- 20250109	     439	    43900080900001625	245
-- 20250115	     439	    43900080900001724	245
-- 20250109	     439	    43900080900001725	245
-- 20250115	     439	    43900080900002624	315
-- 20250121	     439	    43900080900002625	315
-- 20250306	     439	    43900080900003924	305
-- 20250207	     439	    43900080900003925	305
-- 20250108	     439	    43900080900004225	305



select * from acl_sigumgo_slv where trxdt = '20250210' and trxdt <> gisdt and sigumgo_org_c = '42'
and fil_100_ctnt5 in (
    SELECT 
                                          GONGGEUM_GYEJWA
                                    FROM RPT_FISG_INFO_MAP
                                   WHERE FYR = '2025'
                                   and USE_YN = 'Y'
)

select * from acl_sigumgo_slv where trxdt = '20250724' and trxdt <> gisdt and sigumgo_org_c = '110'
and fil_100_ctnt5 in (
    SELECT 
                                          GONGGEUM_GYEJWA
                                    FROM RPT_FISG_INFO_MAP
                                   WHERE FYR = '2025'
                                   and USE_YN = 'Y'
)

select * from acl_sigumgo_slv where trxdt = '20250120' and trxdt <> gisdt and sigumgo_org_c = '130'
and fil_100_ctnt5 in (
    SELECT 
                                          GONGGEUM_GYEJWA
                                    FROM RPT_FISG_INFO_MAP
                                   WHERE FYR = '2025'
                                   and USE_YN = 'Y'
)

select * from acl_sigumgo_slv where trxdt = '20250416' and trxdt <> gisdt and sigumgo_org_c = '150'
and fil_100_ctnt5 in (
    SELECT 
                                          GONGGEUM_GYEJWA
                                    FROM RPT_FISG_INFO_MAP
                                   WHERE FYR = '2025'
                                   and USE_YN = 'Y'
)

select LPAD(SIGUMGO_TRX_G, 2, '0') || LPAD(SIGUMGO_IP_TRX_G, 2, '0') || LPAD(SIGUMGO_JI_TRX_G, 2, '0') AS GG from acl_sigumgo_slv where trxdt = '20250707' and trxdt <> gisdt and sigumgo_org_c = '439'
and fil_100_ctnt5 in (
    SELECT 
                                          GONGGEUM_GYEJWA
                                    FROM RPT_FISG_INFO_MAP
                                   WHERE FYR = '2025'
                                   and USE_YN = 'Y'
)


--------------------------------------------------------------------------------------------------------------------------------------------------
-- 순번	MAX_TRXDT	SIGUMGO_ORG_C	FIL_100_CTNT5
-- 1	20240514	42	04200080900002999
-- 2	20250113	110	11000080900000199
-- 3	20250113	110	11000080900000499
-- 4	20250724	110	11000080900001325
-- 5	20250108	110	11000080900001525
-- 6	20250116	110	11000080900001625
-- 7	20250507	110	11000080900001725
-- 8	20250120	130	13000080900000199
-- 9	20250416	150	15000080900001525
-- 10	20250416	150	15000080900003925
-- 11	20250115	439	43900080900000225
-- 12	20250115	439	43900080900000825
-- 13	20250109	439	43900080900001625
-- 14	20250109	439	43900080900001725

SELECT 
    CMM_C_NM
   , CMM_DTL_C
   , CMM_DTL_C_NM
   , SORT_SNO
   , DECODE(USE_YN,'Y','1','0') AS USE_YN
   , HRNK_CMM_C_NM
   , HRNK_CMM_DTL_C
   , UPMU_HMK_1_SLV
   , UPMU_HMK_2_SLV
   , UPMU_HMK_3_SLV
   , UPMU_HMK_4_SLV
   , UPMU_HMK_5_SLV
   , UPMU_HMK_6_SLV
   , UPMU_HMK_7_SLV
   , UPMU_HMK_8_SLV
   , UPMU_HMK_9_SLV
   , DR_DTTM
   , DROKJA_ID
   , UPD_DTTM
   , MODR_ID
FROM  SFI_CMM_C_DAT 
WHERE CMM_C_NM = '이호조세입세출송신용'
ORDER BY SORT_SNO

--------------------------------------------------

SELECT 
 CMM_DTL_C
FROM  SFI_CMM_C_DAT 
WHERE CMM_C_NM = '이호조세입세출송신용'
and USE_YN = 'Y'




        SELECT A.SL_GMGO_MODL_C       
             , A.USER_ID              
             , A.USER_NM              
             , A.DISTG                
             , A.USER_U_C             
             , A.USER_RIGHT_G         
             , A.PADM_STD_ORG_C       
             , A.SL_GMGO_DEPT_C       
             , A.BR_C
             , A.USER_TELNO           
             , A.USER_EMAIL           
             , A.LST_LOGIN_DT         
             , A.PSN_INF_JEGONG_YN    
             , A.JKGP_NM
             , A.PSN_INF_BRWS_YN              
             , A.USE_YN               
             , A.UPD_DTTM             
             , A.MODR_ID              
        FROM  SFI_USER_INF A                     
        WHERE A.SL_GMGO_MODL_C = 'RPT'               
          AND (A.USER_ID LIKE '%'|| '' ||'%' OR A.USER_NM LIKE '%'|| '' ||'%')
          AND ( NVL('','0') = '0' OR A.USER_U_C = '' )
          AND ( NVL('', '0') = '0' OR A.PADM_STD_ORG_C = '' )
          AND ( NVL('', '0') = '0' OR A.SL_GMGO_DEPT_C = '' )
          AND ( NVL('', '0') = '0' OR A.BR_C = '' )
          AND A.LST_LOGIN_DT BETWEEN '00000000' AND '99999999'
          AND A.UPD_DTTM BETWEEN '00000000' AND '99999999' || '999999'
          AND A.PADM_STD_ORG_C <> '0000000'  
        ORDER BY A.USER_U_C, A.PADM_STD_ORG_C, A.SL_GMGO_DEPT_C, A.BR_C, A.USER_ID


select *
                FROM  SFI_USER_INF A                     
        WHERE A.SL_GMGO_MODL_C = 'RPT' 
        and DROKJA_ID <> USER_ID  
