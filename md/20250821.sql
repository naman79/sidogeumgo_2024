select
 X.dr_date
from (
 SELECT 
  substr(Z.DR_DTTM,1, 8) as dr_date
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
         WHERE Z.MODR_ID = A.USER_ID) LIKE '%'||'1027289'||'%'
       OR Z.USER_ID LIKE '%'||'1027289'||'%' )
  AND ((SELECT MAX(E.MENU_NM)
          FROM    SFI_MENU_INF E
         WHERE  E.SL_GMGO_MODL_C = 'RPT'
           AND Z.MENU_ID = E.MENU_ID) LIKE '%'||''||'%'
       OR Z.MENU_ID LIKE '%'||''||'%' )
  AND ((SELECT MAX(F.SCR_NM)
          FROM    SFI_SCR_INF F
         WHERE  F.SL_GMGO_MODL_C = 'RPT'
           AND Z.SCR_ID = F.SCR_ID) LIKE '%'||''||'%'
       OR Z.SCR_ID LIKE '%'||''||'%' )
  AND Z.DR_DTTM LIKE '%'||'2025'||'%'
  AND substr(Z.DR_DTTM, 9, 6) between '080000' and '091000'
  AND Z.SL_GMGO_MODL_C = B.SL_GMGO_MODL_C
  AND Z.MENU_ID = B.MENU_ID
  AND Z.SL_GMGO_MODL_C = C.SL_GMGO_MODL_C
  AND Z.SCR_ID = C.SCR_ID

  ) x
 group by x.dr_date
 order by x.dr_date desc
;

select 
DR_DTTM,
 substr(DR_DTTM, 9, 6) as dr_time
from SFI_SCR_LTST_HIS
;


select * from acl_sigumgo_mas