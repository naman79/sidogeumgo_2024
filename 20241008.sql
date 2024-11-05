-- 02800001600000199 160-000-134960
-- 02800043210000224 160-000-134954
-- 02800075690003499 160-000-138187

select * from ACL_SIGUMGO_MAS
where 1=1
and LINK_ACSER in (134960, 134954, 138187)
and FIL_100_CTNT2 in ('02800001600000199', '02800043210000224', '02800075690003499')
order by FIL_100_CTNT2, MNG_NO


-- 해당 정기예금계좌 없음
select * from rpt_unyong_gyejwa
where 1=1
and GONGGEUM_GYEJWA in (
'02800001600000199', '02800043210000224', '02800075690003499'
)


SELECT A.RNUM                         
     , (CASE 
        WHEN  SUBSTR(TRIM(A.USER_U_C) ,4,1) = '0' THEN 'BANK'  
        WHEN  SUBSTR(TRIM(A.USER_U_C) ,4,1) = '1' THEN 'SIGU'  
      END) AS USER_GUBUN
     , A.SL_GMGO_MODL_C               
     , A.USER_U_C                     
     , A.PADM_STD_ORG_C
     , (CASE 
        WHEN  SUBSTR(TRIM(A.USER_U_C) ,4,1) = '0' THEN F.CMM_DTL_C_NM
        WHEN  SUBSTR(TRIM(A.USER_U_C) ,4,1) = '1' THEN E.PADM_STD_ORGNM
       END) AS PADM_STD_ORG_NM
     , A.SL_GMGO_DEPT_C
     , A.BR_C
     ,(CASE 
        WHEN  SUBSTR(TRIM(A.USER_U_C) ,4,1) = '0' THEN A.BR_C
        WHEN  SUBSTR(TRIM(A.USER_U_C) ,4,1) = '1' THEN A.SL_GMGO_DEPT_C
      END) AS DEPT_C
      ,(CASE 
        WHEN  SUBSTR(TRIM(A.USER_U_C) ,4,1) = '0' THEN C.HNG_BR_NM
        WHEN  SUBSTR(TRIM(A.USER_U_C) ,4,1) = '1' THEN DECODE(B.DEL_YN,'Y','(폐쇄)','')||B.G_CC_DEPT_NM
      END) AS DEPT_NM
     , A.USER_ID
     ,(CASE
         WHEN 'R' = 'R' THEN A.USER_NM
         WHEN 'R' = 'D' THEN SFIOWN.FUNC_CUS_INFO_CONV (A.USER_NM,'NAME')     
     END) AS USER_NM
     , A.DISTG
     , A.USER_RIGHT_G                 
     , REPLACE(A.USER_TELNO, '-', '') AS USER_TELNO                    
     , A.USER_EMAIL      
     , A.LST_LOGIN_DT                 
     , A.PSN_INF_JEGONG_YN            
     , A.JKGP_NM
     , A.PSN_INF_BRWS_YN                      
     , A.USE_YN                       
     , A.UPD_DTTM                     
     , D.USER_NM AS MODR_ID
FROM  
(
    SELECT ROWNUM AS RNUM
         , A.*                                           
    FROM 
    (
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
    ) A
    WHERE ROWNUM <= 100
) A
LEFT OUTER JOIN SFI_ORG_BY_DEPT_MNG B
  ON A.PADM_STD_ORG_C = B.PADM_STD_ORG_C
  AND A.SL_GMGO_DEPT_C = B.G_CC_DEPT_C
LEFT OUTER JOIN CST_JUM C
  ON C.GRPCO_C = 'S001'
  AND A.BR_C = C.BRNO
LEFT OUTER JOIN SFI_USER_INF D
  ON A.SL_GMGO_MODL_C = D.SL_GMGO_MODL_C
  AND A.MODR_ID        = D.USER_ID
LEFT OUTER JOIN SFI_ORG_DEPT_C_MNG E
  ON A.PADM_STD_ORG_C = E.PADM_STD_ORG_C
LEFT OUTER JOIN SFI_CMM_C_DAT F
  ON REPLACE(A.PADM_STD_ORG_C, '088') = LPAD(F.CMM_DTL_C,4,'0')
  AND F.CMM_C_NM = 'RPT시도금고코드'
  AND F.USE_YN = 'Y'
WHERE A.RNUM >= 0
ORDER BY A.RNUM

-- 211.253.98.34
-- hiyanara19

select * from sfi_user_inf
where 1=1
and user_id = 'hiyanara19'

select * from sfi_user_inf
where 1=1
and sl_gmgo_modl_c = 'RPT'
and drokja_id = '35400002007110000002'


select * from sfi_user_login_inf
where 1=1
and user_id = 'hiyanara19'

<MSFI010401P01In logID="211.253.98.34" serviceID="SSFI010401P01">
    <DISTG value="0611"/>
    <JKGP_NM value=""/>
    <PADM_STD_ORG_C value="3540000"/>
    <SL_GMGO_DEPT_NM value="도시재생과"/>
    <USER_RSA_SCNO_CONF value="8969ca3c8452e2e56d787994fac891a2c009ff6f920c26daac19de6ce4851210"/>
    <USER_EMAIL value="hiya20@korea.kr"/>
    <E_ORG_C value="3540000"/>
    <USER_ID value="hiyanara19"/>
    <BR_C value=""/>
    <PADM_STD_ORG_NM value="인천광역시 부평구"/>
    <USER_NM value="김경희"/>
    <USER_GUBUN value="SIGU"/>
    <SL_GMGO_DEPT_C value="3540150"/>
    <USER_TELNO value="01033784221"/>
    <PSN_INF_JEGONG_YN value="1"/>
    <SL_GMGO_MODL_C value="RPT"/>
    <E_USER_GUBUN value="SIGU"/>
    <E_USER_ID value="35400002007110000002"/>
    <DROKJA_ID value=""/>
    <SIGUMGO_C value="0880028"/>
    <USER_RSA_SCNO value="8969ca3c8452e2e56d787994fac891a2c009ff6f920c26daac19de6ce4851210"/>
    <E_DEPT_C value="3540150"/>
    <MSG_INF type="java.util.Vector" value="MSG_INF">
        <vector result="0"/>
    </MSG_INF>
    <TR_INF type="java.util.Vector" value="TR_INF">
        <vector result="1">
            <data type="Document" vectorkey="0">
                <TR_INF>
                    <SCR_ID value=""/>
                    <RE_SCR_ID value=""/>
                    <MENU_ID value=""/>
                    <MOB_UID value=""/>
                    <BIZREGNO value=""/>
                    <CUS_ID value=""/>
                    <SYS_U_FLG value=""/>
                    <OP_NO value=""/>
                    <CLIENT_MAC3 value=""/>
                    <RST_U value=""/>
                    <TRX_DTTM value="20241008140806809"/>
                    <FILLER value=""/>
                    <USER_G value=""/>
                    <CLIENT_MAC1 value=""/>
                    <CLIENT_MAC2 value=""/>
                    <CLIENT_IP_NO1 value="211.253.98.34"/>
                    <CUS_G value=""/>
                    <CLIENT_IP_NO2 value=""/>
                    <CLIENT_IP_NO3 value=""/>
                    <RST_RECV_SVC_C value=""/>
                    <TRX_OP_SOSOK_GRPCO_C value=""/>
                    <CUSNM value=""/>
                    <rowStatus value="R"/>
                    <BOJON value=""/>
                    <RECV_SVC_C value="SSFI010401P01"/>
                </TR_INF>
            </data>
        </vector>
    </TR_INF>
    <SYS_INF type="java.util.Vector" value="SYS_INF">
        <vector result="1">
            <data type="Document" vectorkey="0">
                <SYS_INF>
                    <MDIA_U value="KUX"/>
                    <MSG_LEN value=""/>
                    <GLOB_ID value=""/>
                    <NCRPT_FLG value=""/>
                    <RQST_RESP_G value="S"/>
                    <INFC_SYS_ID value=""/>
                    <SND_INFC_G value="U"/>
                    <rowStatus value="R"/>
                    <LANG_G value="KR"/>
                    <SYNC_G value="S"/>
                </SYS_INF>
            </data>
        </vector>
    </SYS_INF>
</MSFI010401P01In>