-- HRNK = Human Readable Name Key

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