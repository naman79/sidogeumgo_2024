[1729125947832
20241017treap1pRPTPWK0362441100

=========================== XDA ID:[tom.ich.fmt.xda.xSelectListICH040301By01]===============================
SELECT A.GUNGU_CODE
     , A.GUNGU_NAME GUNGU_NM
     , (A.TOT_SISE - (A.SIWOLGYE_JIBANGSE + A.SIWOLGYE_OCR_JIBANGSE)) SIGONGGEUM_JIBANGSE
     , (A.TOT_SISEWOI - (A.SIWOLGYE_SEWOISUIP + A.SIWOLGYE_OCR_SEWOISUIP)) SIGONGGEUM_SEWOISUIP
     , 0 SIGONGGEUM_GYOYUKSE
     , 0 SIGONGGEUM_NONGTEUKSE
     , ((A.TOT_SISE - (A.SIWOLGYE_JIBANGSE + A.SIWOLGYE_OCR_JIBANGSE)) + (A.TOT_SISEWOI - (A.SIWOLGYE_SEWOISUIP + A.SIWOLGYE_OCR_SEWOISUIP)) + 0 + 0) SIGONGGEUM_HAPGYE
     , (A.HWAN_SISE - (A.SIWOLGYE_GWAONAP_JIBANGSE)) SIGWAONAP_JIBANGSE
     , (A.HWAN_SISEWOI - (A.SIWOLGYE_GWAONAP_SEWOISUIP)) SIGWAONAP_SEWOISUIP 
     , (A.HWAN_GYOYUKSE - (A.SIWOLGYE_GWAONAP_GYOYUKSE  + A.GUWOLGYE_GWAONAP_GYOYUKSE)) SIGWAONAP_GYOYUKSE 
     , (A.HWAN_NONGTEUKSE - (A.SIWOLGYE_GWAONAP_NONGTEUKSE + A.GUWOLGYE_GWAONAP_NONGTEUKSE)) SIGWAONAP_NONGTEUKSE 
     , ((A.HWAN_SISE - (A.SIWOLGYE_GWAONAP_JIBANGSE)) + (A.HWAN_SISEWOI - (A.SIWOLGYE_GWAONAP_SEWOISUIP))  + (A.HWAN_GYOYUKSE - (A.SIWOLGYE_GWAONAP_GYOYUKSE + A.GUWOLGYE_GWAONAP_GYOYUKSE))  
                                                      + (A.HWAN_NONGTEUKSE - (A.SIWOLGYE_GWAONAP_NONGTEUKSE + A.GUWOLGYE_GWAONAP_NONGTEUKSE)) ) SIGWAONAP_HAPGYE
     , (A.TOT_GUSE - (A.GUWOLGYE_JIBANGSE + A.GUWOLGYE_OCR_JIBANGSE)) GUGONGGEUM_JIBANGSE 
     , (A.TOT_GUSEWOI - (A.GUWOLGYE_SEWOISUIP + A.GUWOLGYE_OCR_SEWOISUIP)) GUGONGGEUM_SEWOISUIP
     , 0 GUGONGGEUM_GYOYUKSE 
     , 0 GUGONGGEUM_NONGTEUKSE 
     , ((A.TOT_GUSE - (A.GUWOLGYE_JIBANGSE + A.GUWOLGYE_OCR_JIBANGSE)) + (A.TOT_GUSEWOI - (A.GUWOLGYE_SEWOISUIP + A.GUWOLGYE_OCR_SEWOISUIP)) + 0 + 0) GUGONGGEUM_HAPGYE 
     , (A.HWAN_GUSE - (A.GUWOLGYE_GWAONAP_JIBANGSE)) GUGWAONAP_JIBANGSE
     , (A.HWAN_GUSEWOI - (A.GUWOLGYE_GWAONAP_SEWOISUIP)) GUGWAONAP_SEWOISUIP
     , 0 GUGWAONAP_GYOYUKSE
     , 0 GUGWAONAP_NONGTEUKSE
     , ((A.HWAN_GUSE - (A.GUWOLGYE_GWAONAP_JIBANGSE)) + (A.HWAN_GUSEWOI - (A.GUWOLGYE_GWAONAP_SEWOISUIP)) + 0 + 0) GUGWAONAP_HAPGYE
     , 0 GYONONG_JIBANGSE
     , 0 GYONONG_SEWOISUIP 
     , (A.TOT_GYOYUKSE + 0 - (A.SIWOLGYE_GYOYUKSE + A.SIWOLGYE_OCR_GYOYUKSE + A.GUWOLGYE_GYOYUKSE + A.GUWOLGYE_OCR_GYOYUKSE)) GYONONG_GYOYUKSE 
     , (A.TOT_NONGTEUKSE - (A.SIWOLGYE_NONGTEUKSE + A.SIWOLGYE_OCR_NONGTEUKSE + A.GUWOLGYE_NONGTEUKSE + A.GUWOLGYE_OCR_NONGTEUKSE)) GYONONG_NONGTEUKSE 
     , ((A.TOT_GYOYUKSE + 0 - (A.SIWOLGYE_GYOYUKSE + A.SIWOLGYE_OCR_GYOYUKSE + A.GUWOLGYE_GYOYUKSE + A.GUWOLGYE_OCR_GYOYUKSE)) 
                        + (A.TOT_NONGTEUKSE - (A.SIWOLGYE_NONGTEUKSE + A.SIWOLGYE_OCR_NONGTEUKSE + A.GUWOLGYE_NONGTEUKSE + A.GUWOLGYE_OCR_NONGTEUKSE)))GYONONG_HAPGYE 
     , 0 SEIPJOJEONG_WOOCHEGUK 
     , (((A.TOT_GUSE - A.GUWOLGYE_JIBANGSE - 0 - (A.OCR_SEWOISUIP - A.GUWOLGYE_OCR_SEWOISUIP) - 0) + 0 + 0 + 0) - (((A.HWAN_SISE - (A.SIWOLGYE_GWAONAP_JIBANGSE)) + (A.HWAN_SISEWOI - (A.SIWOLGYE_GWAONAP_SEWOISUIP)) 
       + (A.HWAN_GYOYUKSE - (A.SIWOLGYE_GWAONAP_GYOYUKSE + A.GUWOLGYE_GWAONAP_GYOYUKSE)) + (A.HWAN_NONGTEUKSE - (A.SIWOLGYE_GWAONAP_NONGTEUKSE + A.GUWOLGYE_GWAONAP_NONGTEUKSE))) 
       + ((A.TOT_GUSE - (A.GUWOLGYE_JIBANGSE + A.GUWOLGYE_OCR_JIBANGSE)) + (A.TOT_GUSEWOI - (A.GUWOLGYE_SEWOISUIP + A.GUWOLGYE_OCR_SEWOISUIP)) + 0 + 0) +((A.HWAN_GUSE - (A.GUWOLGYE_GWAONAP_JIBANGSE)) 
       + (A.HWAN_GUSEWOI - (A.GUWOLGYE_GWAONAP_SEWOISUIP)) + 0 + 0) + 0 + 0 + 0)) SEIPJOJEONG_CHAAEK
     , (( (A.HWAN_SISE - (A.SIWOLGYE_GWAONAP_JIBANGSE)) + (A.HWAN_SISEWOI - (A.SIWOLGYE_GWAONAP_SEWOISUIP)) + (A.HWAN_GYOYUKSE - (A.SIWOLGYE_GWAONAP_GYOYUKSE + A.GUWOLGYE_GWAONAP_GYOYUKSE)) 
        + (A.HWAN_NONGTEUKSE - (A.SIWOLGYE_GWAONAP_NONGTEUKSE + A.GUWOLGYE_GWAONAP_NONGTEUKSE))) + ((A.TOT_GUSE - (A.GUWOLGYE_JIBANGSE + A.GUWOLGYE_OCR_JIBANGSE))
        + (A.TOT_GUSEWOI - (A.GUWOLGYE_SEWOISUIP + A.GUWOLGYE_OCR_SEWOISUIP)) + 0 + 0) +((A.HWAN_GUSE - (A.GUWOLGYE_GWAONAP_JIBANGSE)) + (A.HWAN_GUSEWOI - (A.GUWOLGYE_GWAONAP_SEWOISUIP)) + 0 + 0 ) + 0 + 0 + 0 ) SEIPJOJEONG_HAPGYE
     , (A.TOT_GUSE - A.GUWOLGYE_JIBANGSE - 0 - (A.OCR_SEWOISUIP - A.GUWOLGYE_OCR_SEWOISUIP) - 0) JEONPYO_JIBANGSE 
     , 0 JEONPYO_SEWOISUIP 
     , 0 JEONPYO_GYOYUKSE
     , 0 JEONPYO_NONGTEUKSE
     , ((A.TOT_GUSE - A.GUWOLGYE_JIBANGSE - 0 - (A.OCR_SEWOISUIP - A.GUWOLGYE_OCR_SEWOISUIP) - 0) + 0 + 0 + 0) JEONPYO_HAPGYE 
  FROM (SELECT P.GUNGU_CODE 
             , P.GUNGU_NAME
             , P.SIWOLGYE_JIBANGSE 
             , P.SIWOLGYE_SEWOISUIP
             , P.SIWOLGYE_GYOYUKSE 
             , P.SIWOLGYE_NONGTEUKSE 
             , P.SIWOLGYE_HAPGYE 
             , P.GUWOLGYE_JIBANGSE 
             , P.GUWOLGYE_SEWOISUIP
             , P.GUWOLGYE_GYOYUKSE 
             , P.GUWOLGYE_NONGTEUKSE 
             , P.GUWOLGYE_HAPGYE 
             , 0 WOOCHEGUK_JIBANGSE
             , 0 WOOCHEGUK_SEWOISUIP 
             , 0 WOOCHEGUK_GYOYUKSE
             , 0 WOOCHEGUK_NONGTEUKSE
             , 0 WOOCHEGUK_HAPGYE
             , P.OCR_JIBANGSE
             , P.OCR_SEWOISUIP 
             , P.OCR_GYOYUKSE
             , P.OCR_NONGTEUKSE
             , P.OCR_HAPGYE
             , P.HAPGYE_JIBANGSE 
             , P.HAPGYE_SEWOISUIP
             , P.HAPGYE_GYOYUKSE 
             , P.HAPGYE_NONGTEUKSE 
             , P.HAPGYE_HAPGYE 
             , Q.JEONGDANG_SIGUSE_AMT DANGGU_JIBANGSE
             , 0 DANGGU_SEWOISUIP
             , Q.JEONGDANG_GYOYUKSE_AMT DANGGU_GYOYUKSE
             , Q.JEONGDANG_NONGTEUKSE_AMT DANGGU_NONGTEUKSE
             , Q.JEONGDANG_HAPGYE_AMT DANGGU_HAPGYE
             , Q.BANSONG_SIGUSE_AMT TAGU_JIBANGSE
             , 0 TAGU_SEWOISUIP
             , Q.BANSONG_GYOYUKSE_AMT TAGU_GYOYUKSE
             , Q.BANSONG_NONGTEUKSE_AMT TAGU_NONGTEUKSE
             , Q.BANSONG_HAPGYE_AMT TAGU_HAPGYE
             , Q.BANKJOJEONG_SIGUSE_AMT BANK_JIBANGSE
             , 0 BANK_SEWOISUIP
             , Q.BANKJOJEONG_GYOYUKSE_AMT BANK_GYOYUKSE
             , Q.BANKJOJEONG_NONGTEUKSE_AMT BANK_NONGTEUKSE
             , Q.BANKJOJEONG_HAPGYE_AMT BANK_HAPGYE
             , Q.TADO_SIGUSE_AMT TADO_JIBANGSE 
             , 0 TADO_SEWOISUIP
             , Q.TADO_GYOYUKSE_AMT TADO_GYOYUKSE 
             , Q.TADO_NONGTEUKSE_AMT TADO_NONGTEUKSE 
             , Q.TADO_HAPGYE_AMT TADO_HAPGYE 
             , 0 JADONG_JIBANGSE 
             , 0 JADONG_SEWOISUIP
             , 0 JADONG_GYOYUKSE 
             , 0 JADONG_NONGTEUKSE 
             , 0 JADONG_HAPGYE 
             , (NVL(Q.JEONGDANG_SIGUSE_AMT,0) + NVL(Q.BANSONG_SIGUSE_AMT,0) + NVL(Q.BANKJOJEONG_SIGUSE_AMT,0) + NVL(Q.TADO_SIGUSE_AMT,0) + 0) HAPGYE2_JIBANGSE 
             , (0 + 0 + 0 + 0 + 0) HAPGYE2_SEWOISUIP 
             , (NVL(Q.JEONGDANG_GYOYUKSE_AMT,0) + NVL(Q.BANSONG_GYOYUKSE_AMT,0) + NVL(Q.BANKJOJEONG_GYOYUKSE_AMT,0) + NVL(Q.TADO_GYOYUKSE_AMT,0) + 0) HAPGYE2_GYOYUKSE 
             , (NVL(Q.JEONGDANG_NONGTEUKSE_AMT,0) + NVL(Q.BANSONG_NONGTEUKSE_AMT,0) + NVL(Q.BANKJOJEONG_NONGTEUKSE_AMT,0) + NVL(Q.TADO_NONGTEUKSE_AMT,0) + 0) HAPGYE2_NONGTEUKSE 
             , (NVL(Q.JEONGDANG_HAPGYE_AMT,0) + NVL(Q.BANSONG_HAPGYE_AMT,0) + NVL(Q.BANKJOJEONG_HAPGYE_AMT,0) + NVL(Q.TADO_HAPGYE_AMT,0) + 0) HAPGYE2_HAPGYE 
             , (P.HAPGYE_JIBANGSE + (NVL(Q.JEONGDANG_SIGUSE_AMT,0) + NVL(Q.BANSONG_SIGUSE_AMT,0) + NVL(Q.BANKJOJEONG_SIGUSE_AMT,0) + NVL(Q.TADO_SIGUSE_AMT,0) + 0)) GYE_JIBANGSE
             , (P.HAPGYE_SEWOISUIP + (0 + 0 + 0 + 0 + 0)) GYE_SEWOISUIP 
             , (P.HAPGYE_GYOYUKSE + (NVL(Q.JEONGDANG_GYOYUKSE_AMT,0) + NVL(Q.BANSONG_GYOYUKSE_AMT,0) + NVL(Q.BANKJOJEONG_GYOYUKSE_AMT,0) + NVL(Q.TADO_GYOYUKSE_AMT,0) + 0)) GYE_GYOYUKSE
             , (P.HAPGYE_NONGTEUKSE  + (NVL(Q.JEONGDANG_NONGTEUKSE_AMT,0) + NVL(Q.BANSONG_NONGTEUKSE_AMT,0) + NVL(Q.BANKJOJEONG_NONGTEUKSE_AMT,0) + NVL(Q.TADO_NONGTEUKSE_AMT,0) + 0)) GYE_NONGTEUKSE
             , (P.HAPGYE_HAPGYE  + (NVL(Q.JEONGDANG_HAPGYE_AMT,0) + NVL(Q.BANSONG_HAPGYE_AMT,0) + NVL(Q.BANKJOJEONG_HAPGYE_AMT,0) + NVL(Q.TADO_HAPGYE_AMT,0) + 0)) GYE_HAPGYE 
             , R.TOT_GYOYUKSE
             , R.TOT_NONGTEUKSE
             , ((P.HAPGYE_GYOYUKSE  + (NVL(Q.JEONGDANG_GYOYUKSE_AMT,0) + NVL(Q.BANSONG_GYOYUKSE_AMT,0) + NVL(Q.BANKJOJEONG_GYOYUKSE_AMT,0) + NVL(Q.TADO_GYOYUKSE_AMT,0) + 0))
              + (P.HAPGYE_NONGTEUKSE  + (NVL(Q.JEONGDANG_NONGTEUKSE_AMT,0) + NVL(Q.BANSONG_NONGTEUKSE_AMT,0) + NVL(Q.BANKJOJEONG_NONGTEUKSE_AMT,0) + NVL(Q.TADO_NONGTEUKSE_AMT,0) + 0))) TOT_HAPGYE
             , R.HWAN_GYOYUKSE 
             , R.HWAN_NONGTEUKSE 
             , R.SOONAEK_GYOYUKSE
             , R.SOONAEK_NONGTEUKSE
             , R.JONGHAP 
             , R.TOT_SISE
             , R.TOT_SISEWOI 
             , R.TOT_GUSE
             , R.TOT_GUSEWOI 
             , R.HWAN_SISE 
             , R.HWAN_SISEWOI
             , R.HWAN_GUSE 
             , R.HWAN_GUSEWOI
             , R.HWAN_HAPGYE 
             , R.SOON_SISE 
             , R.SOON_SISEWOI
             , R.SOON_GUSE 
             , R.SOON_GUSEWOI
             , R.SOON_HAPGYE 
             , R.JOONG_CHONGAEK
             , R.JOONG_YANGYEO 
             , R.JOONG_GYOYUK
             , R.JOONG_NONGTEUK
             , R.JOONG_ICHE
             , R.GYOYUK_CHONGAEK 
             , R.GYOYUK_YANGYEO
             , R.GYOYUK_GYOYUK 
             , R.GYOYUK_NONGTEUK 
             , R.GYOYUK_ICHE 
             , R.ETC_CHONGAEK
             , R.ETC_YANGYEO 
             , R.ETC_GYOYUK
             , R.ETC_NONGTEUK
             , R.ETC_ICHE
             , R.NONGTEUK_CHONGAEK 
             , R.NONGTEUK_YANGYEO
             , R.NONGTEUK_GYOYUK
             , R.NONGTEUK_NONGTEUK
             , R.NONGTEUK_ICHE
             , R.ETCNONGTEUK_CHONGAEK
             , R.ETCNONGTEUK_YANGYEO
             , R.ETCNONGTEUK_GYOYUK
             , R.ETCNONGTEUK_NONGTEUK
             , R.ETCNONGTEUK_ICHE
             , R.ETCBANGWI_CHONGAEK
             , R.ETCBANGWI_YANGYEO 
             , R.ETCBANGWI_GYOYUK
             , R.ETCBANGWI_NONGTEUK
             , R.ETCBANGWI_ICHE
             , P.SIWOLGYE_OCR_JIBANGSE 
             , P.SIWOLGYE_OCR_SEWOISUIP
             , P.SIWOLGYE_OCR_GYOYUKSE 
             , P.SIWOLGYE_OCR_NONGTEUKSE 
             , P.SIWOLGYE_OCR_HAPGYE 
             , P.SIWOLGYE_GWAONAP_JIBANGSE 
             , P.SIWOLGYE_GWAONAP_SEWOISUIP
             , P.SIWOLGYE_GWAONAP_GYOYUKSE 
             , P.SIWOLGYE_GWAONAP_NONGTEUKSE 
             , P.SIWOLGYE_GWAONAP_HAPGYE 
             , P.GUWOLGYE_OCR_JIBANGSE 
             , P.GUWOLGYE_OCR_SEWOISUIP
             , P.GUWOLGYE_OCR_GYOYUKSE 
             , P.GUWOLGYE_OCR_NONGTEUKSE 
             , P.GUWOLGYE_OCR_HAPGYE
             , P.GUWOLGYE_GWAONAP_JIBANGSE 
             , P.GUWOLGYE_GWAONAP_SEWOISUIP
             , P.GUWOLGYE_GWAONAP_GYOYUKSE 
             , P.GUWOLGYE_GWAONAP_NONGTEUKSE 
             , P.GUWOLGYE_GWAONAP_HAPGYE 
          FROM (SELECT A.GUNGU_CODE
                     , A.GUNGU_NAME
                     , SUM(CASE WHEN A.KUBUN = 4 AND A.JIBGYE_CODE = 103000 THEN A.BONSE_AMT ELSE 0 END) SIWOLGYE_JIBANGSE 
                     , SUM(CASE WHEN A.KUBUN = 4 AND A.JIBGYE_CODE = 103000 THEN A.SEWOI_AMT ELSE 0 END) SIWOLGYE_SEWOISUIP
                     , SUM(CASE WHEN A.KUBUN = 4 AND A.JIBGYE_CODE = 103000 THEN A.GYOYUKSE_AMT ELSE 0 END) SIWOLGYE_GYOYUKSE
                     , SUM(CASE WHEN A.KUBUN = 4 AND A.JIBGYE_CODE = 103000 THEN A.NONGTEUKSE_AMT ELSE 0 END) SIWOLGYE_NONGTEUKSE
                     , SUM(CASE WHEN A.KUBUN = 4 AND A.JIBGYE_CODE = 103000 THEN A.BONSE_AMT + A.SEWOI_AMT + A.GYOYUKSE_AMT + A.NONGTEUKSE_AMT ELSE 0 END) SIWOLGYE_HAPGYE 
                     , SUM(CASE WHEN A.KUBUN = 4 AND A.JIBGYE_CODE = 104000 THEN A.BONSE_AMT ELSE 0 END) GUWOLGYE_JIBANGSE
                     , SUM(CASE WHEN A.KUBUN = 4 AND A.JIBGYE_CODE = 104000 THEN A.SEWOI_AMT ELSE 0 END) GUWOLGYE_SEWOISUIP
                     , SUM(CASE WHEN A.KUBUN = 4 AND A.JIBGYE_CODE = 104000 THEN A.GYOYUKSE_AMT ELSE 0 END) GUWOLGYE_GYOYUKSE
                     , SUM(CASE WHEN A.KUBUN = 4 AND A.JIBGYE_CODE = 104000 THEN A.NONGTEUKSE_AMT ELSE 0 END) GUWOLGYE_NONGTEUKSE
                     , SUM(CASE WHEN A.KUBUN = 4 AND A.JIBGYE_CODE = 104000 THEN A.BONSE_AMT + A.SEWOI_AMT + A.GYOYUKSE_AMT + A.NONGTEUKSE_AMT ELSE 0 END) GUWOLGYE_HAPGYE 
                     , (SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 103000 THEN A.BONSE_AMT ELSE 0 END) + SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 103000 THEN A.SEWOI_AMT ELSE 0 END)) OCR_JIBANGSE
                     , (SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 104000 THEN A.BONSE_AMT ELSE 0 END) + SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 104000 THEN A.SEWOI_AMT ELSE 0 END)) OCR_SEWOISUIP 
                     , (SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 103000 THEN A.GYOYUKSE_AMT ELSE 0 END) + SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 104000 THEN A.GYOYUKSE_AMT ELSE 0 END)) OCR_GYOYUKSE
                     , (SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 103000 THEN A.NONGTEUKSE_AMT ELSE 0 END) + SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 104000 THEN A.NONGTEUKSE_AMT ELSE 0 END)) OCR_NONGTEUKSE
                     , (SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 103000 THEN A.BONSE_AMT ELSE 0 END) + SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 103000 THEN A.SEWOI_AMT ELSE 0 END) 
                      + SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 104000 THEN A.BONSE_AMT ELSE 0 END) + SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 104000 THEN A.SEWOI_AMT ELSE 0 END) 
                      + SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 103000 THEN A.GYOYUKSE_AMT ELSE 0 END) + SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 104000 THEN A.GYOYUKSE_AMT ELSE 0 END)
                      + SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 103000 THEN A.NONGTEUKSE_AMT ELSE 0 END)+ SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 104000 THEN A.NONGTEUKSE_AMT ELSE 0 END)) OCR_HAPGYE
                     , (SUM(CASE WHEN A.KUBUN = 4 AND A.JIBGYE_CODE = 103000 THEN A.BONSE_AMT ELSE 0 END) + SUM(CASE WHEN A.KUBUN = 4 AND A.JIBGYE_CODE = 104000 THEN A.BONSE_AMT ELSE 0 END) 
                      + SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 103000 THEN A.BONSE_AMT ELSE 0 END) + SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 103000 THEN A.SEWOI_AMT ELSE 0 END)) HAPGYE_JIBANGSE 
                     , (SUM(CASE WHEN A.KUBUN = 4 AND A.JIBGYE_CODE = 103000 THEN A.SEWOI_AMT ELSE 0 END) + SUM(CASE WHEN A.KUBUN = 4 AND A.JIBGYE_CODE = 104000 THEN A.SEWOI_AMT ELSE 0 END) 
                      + SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 104000 THEN A.BONSE_AMT ELSE 0 END) + SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 104000 THEN A.SEWOI_AMT ELSE 0 END)) HAPGYE_SEWOISUIP
                     , (SUM(CASE WHEN A.KUBUN = 4 AND A.JIBGYE_CODE = 103000 THEN A.GYOYUKSE_AMT ELSE 0 END) + SUM(CASE WHEN A.KUBUN = 4 AND A.JIBGYE_CODE = 104000 THEN A.GYOYUKSE_AMT ELSE 0 END)
                      + SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 103000 THEN A.GYOYUKSE_AMT ELSE 0 END) + SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 104000 THEN A.GYOYUKSE_AMT ELSE 0 END)) HAPGYE_GYOYUKSE 
                     , (SUM(CASE WHEN A.KUBUN = 4 AND A.JIBGYE_CODE = 103000 THEN A.NONGTEUKSE_AMT ELSE 0 END) + SUM(CASE WHEN A.KUBUN = 4 AND A.JIBGYE_CODE = 104000 THEN A.NONGTEUKSE_AMT ELSE 0 END)
                      + SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 103000 THEN A.NONGTEUKSE_AMT ELSE 0 END) + SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 104000 THEN A.NONGTEUKSE_AMT ELSE 0 END)) HAPGYE_NONGTEUKSE 
                     , (SUM(CASE WHEN A.KUBUN = 4 AND A.JIBGYE_CODE = 103000 THEN A.BONSE_AMT + A.SEWOI_AMT + A.GYOYUKSE_AMT + A.NONGTEUKSE_AMT ELSE 0 END)  
                      + SUM(CASE WHEN A.KUBUN = 4 AND A.JIBGYE_CODE = 104000 THEN A.BONSE_AMT + A.SEWOI_AMT + A.GYOYUKSE_AMT + A.NONGTEUKSE_AMT ELSE 0 END) 
                      + SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 103000 THEN A.BONSE_AMT ELSE 0 END) + SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 103000 THEN A.SEWOI_AMT ELSE 0 END) 
                      + SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 104000 THEN A.BONSE_AMT ELSE 0 END) + SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 104000 THEN A.SEWOI_AMT ELSE 0 END) 
                      + SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 103000 THEN A.GYOYUKSE_AMT ELSE 0 END) + SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 104000 THEN A.GYOYUKSE_AMT ELSE 0 END)
                      + SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 103000 THEN A.NONGTEUKSE_AMT ELSE 0 END) + SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 104000 THEN A.NONGTEUKSE_AMT ELSE 0 END)) HAPGYE_HAPGYE 
                     , SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 103000 THEN A.BONSE_AMT ELSE 0 END) SIWOLGYE_OCR_JIBANGSE 
                     , SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 103000 THEN A.SEWOI_AMT ELSE 0 END) SIWOLGYE_OCR_SEWOISUIP
                     , SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 103000 THEN A.GYOYUKSE_AMT ELSE 0 END) SIWOLGYE_OCR_GYOYUKSE
                     , SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 103000 THEN A.NONGTEUKSE_AMT ELSE 0 END) SIWOLGYE_OCR_NONGTEUKSE
                     , SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 103000 THEN A.BONSE_AMT + A.SEWOI_AMT + A.GYOYUKSE_AMT + A.NONGTEUKSE_AMT ELSE 0 END) SIWOLGYE_OCR_HAPGYE 
                     , SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 104000 THEN A.BONSE_AMT ELSE 0 END) GUWOLGYE_OCR_JIBANGSE 
                     , SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 104000 THEN A.SEWOI_AMT ELSE 0 END) GUWOLGYE_OCR_SEWOISUIP
                     , SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 104000 THEN A.GYOYUKSE_AMT ELSE 0 END) GUWOLGYE_OCR_GYOYUKSE
                     , SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 104000 THEN A.NONGTEUKSE_AMT ELSE 0 END) GUWOLGYE_OCR_NONGTEUKSE
                     , SUM(CASE WHEN A.KUBUN = 5 AND A.JIBGYE_CODE = 104000 THEN A.BONSE_AMT + A.SEWOI_AMT + A.GYOYUKSE_AMT + A.NONGTEUKSE_AMT ELSE 0 END) GUWOLGYE_OCR_HAPGYE 
                     , SUM(CASE WHEN A.KUBUN = 8 AND A.JIBGYE_CODE = 103000 THEN A.BONSE_AMT ELSE 0 END) SIWOLGYE_GWAONAP_JIBANGSE 
                     , SUM(CASE WHEN A.KUBUN = 8 AND A.JIBGYE_CODE = 103000 THEN A.SEWOI_AMT ELSE 0 END) SIWOLGYE_GWAONAP_SEWOISUIP
                     , SUM(CASE WHEN A.KUBUN = 8 AND A.JIBGYE_CODE = 103000 THEN A.GYOYUKSE_AMT ELSE 0 END) SIWOLGYE_GWAONAP_GYOYUKSE
                     , SUM(CASE WHEN A.KUBUN = 8 AND A.JIBGYE_CODE = 103000 THEN A.NONGTEUKSE_AMT ELSE 0 END) SIWOLGYE_GWAONAP_NONGTEUKSE
                     , SUM(CASE WHEN A.KUBUN = 8 AND A.JIBGYE_CODE = 103000 THEN A.BONSE_AMT + A.SEWOI_AMT + A.GYOYUKSE_AMT + A.NONGTEUKSE_AMT ELSE 0 END) SIWOLGYE_GWAONAP_HAPGYE 
                     , SUM(CASE WHEN A.KUBUN = 8 AND A.JIBGYE_CODE = 104000 THEN A.BONSE_AMT ELSE 0 END) GUWOLGYE_GWAONAP_JIBANGSE 
                     , SUM(CASE WHEN A.KUBUN = 8 AND A.JIBGYE_CODE = 104000 THEN A.SEWOI_AMT ELSE 0 END) GUWOLGYE_GWAONAP_SEWOISUIP
                     , SUM(CASE WHEN A.KUBUN = 8 AND A.JIBGYE_CODE = 104000 THEN A.GYOYUKSE_AMT ELSE 0 END) GUWOLGYE_GWAONAP_GYOYUKSE
                     , SUM(CASE WHEN A.KUBUN = 8 AND A.JIBGYE_CODE = 104000 THEN A.NONGTEUKSE_AMT ELSE 0 END) GUWOLGYE_GWAONAP_NONGTEUKSE
                     , SUM(CASE WHEN A.KUBUN = 8 AND A.JIBGYE_CODE = 104000 THEN A.BONSE_AMT + A.SEWOI_AMT + A.GYOYUKSE_AMT + A.NONGTEUKSE_AMT ELSE 0 END) GUWOLGYE_GWAONAP_HAPGYE 
                  FROM (SELECT G.GUNGU_CODE 
                             , G.GUNGU_NAME
                             , G.LVL KUBUN
                             , G.JIBGYE_CODE
                             , SUM(NVL(BONSE_CNT,0) ) AS BONSE_CNT
                             , SUM(NVL(BONSE_AMT ,0) ) AS BONSE_AMT 
                             , SUM(NVL(SEWOI_CNT ,0) ) AS SEWOI_CNT 
                             , SUM(NVL(SEWOI_AMT ,0) ) AS SEWOI_AMT 
                             , SUM(NVL(GYOYUKSE_AMT ,0) ) AS GYOYUKSE_AMT
                             , SUM(NVL(NONGTEUKSE_AMT,0) ) AS NONGTEUKSE_AMT
                          FROM (SELECT (CASE WHEN T.GUNGU_CODE>7000 THEN T.GUNGU_CODE-7000 ELSE T.GUNGU_CODE END)GUNGU_CODE 
                                     , T.JIBGYE_CODE, T.KUBUN 
                                     , SUM(NVL(BONSE_CNT,0) ) AS BONSE_CNT
                                     , SUM(NVL(BONSE_AMT ,0) ) AS BONSE_AMT 
                                     , SUM(NVL(SEWOI_CNT ,0) ) AS SEWOI_CNT 
                                     , SUM(NVL(SEWOI_AMT ,0) ) AS SEWOI_AMT 
                                     , SUM(NVL(GYOYUKSE_AMT ,0) ) AS GYOYUKSE_AMT 
                                     , SUM(NVL(NONGTEUKSE_AMT,0) ) AS NONGTEUKSE_AMT
                                  FROM (SELECT CASE WHEN A.GUNGU_CODE = 7000 THEN 7100 ELSE A.GUNGU_CODE END GUNGU_CODE
                                             , CASE WHEN A.JIBGYE_CODE = 213000 THEN 217100 ELSE A.JIBGYE_CODE END JIBGYE_CODE
                                             , CASE WHEN A.GEORAE_GUBUN = 1 THEN 2 WHEN A.GEORAE_GUBUN = 3 THEN 6 ELSE 1 END KUBUN 
                                             , A.BONSE_CNT
                                             , A.BONSE_AMT * DECODE(A.GEORAE_GUBUN,3,-1,1) BONSE_AMT
                                             , A.SEWOI_CNT
                                             , A.SEWOI_AMT * DECODE(A.GEORAE_GUBUN,3,-1,1) SEWOI_AMT
                                             , A.GYOYUKSE_AMT * DECODE(A.GEORAE_GUBUN,3,-1,1) GYOYUKSE_AMT
                                             , A.NONGTEUKSE_AMT * DECODE(A.GEORAE_GUBUN,3,-1,1) NONGTEUKSE_AMT
                                          FROM RPT_SUNAP_JIBGYE A 
                                         WHERE A.GEUMGO_CODE = '28' 
                                           AND A.SUNAPIL = '20240630'
                                           AND A.JIBGYE_CODE IN (103000, 104000, 209330, 209331, 209332, 209333, 200010, 200020, 213000, 215300, 217100)
                                           AND NOT (A.JIBGYE_CODE = 213000 AND A.KEORAEIL <> A.SUNAPIL) 
                                           AND (('0' IN (1,5,9) AND A.YEAR_GUBUN = '0') OR ('0' = 8 AND A.YEAR_GUBUN IN (5,9)) OR ( '0' = 0 ))
                                           AND A.GUNGU_CODE IN ( '260' , '7' || '260' ) 
                                               UNION ALL 
                                        SELECT CASE WHEN A.GUNGU_CODE = 7000 THEN 7100 ELSE A.GUNGU_CODE END GUNGU_CODE
                                             , CASE WHEN A.JIBGYE_CODE = 213000 THEN 217100 ELSE A.JIBGYE_CODE END JIBGYE_CODE
                                             , CASE WHEN A.JOJEONG_GUBUN <> 2 THEN 3 ELSE 7 END KUBUN
                                             , A.JIBANGSE_CNT BONSE_CNT
                                             , A.JIBANGSE_AMT * DECODE(A.IPJI_GUBUN,1,1,-1) BONSE_AMT
                                             , 0 SEWOI_CNT
                                             , A.SEWOI_AMT * DECODE(A.IPJI_GUBUN,1,1,-1) SEWOI_AMT
                                             , A.GYOYUKSE_AMT * DECODE(A.IPJI_GUBUN,1,1,-1) GYOYUKSE_AMT
                                             , A.NONGTEUKSE_AMT * DECODE(A.IPJI_GUBUN,1,1,-1) NONGTEUKSE_AMT
                                          FROM RPT_DANGSEIPJOJEONG A
                                         WHERE A.GEUMGO_CODE = '28' 
                                           AND A.SUNAPIL = '20240630'
                                           AND A.JIBGYE_CODE IN (103000, 104000, 209330, 209331, 209332, 209333, 200010, 200020, 213000, 215300, 217100)
                                           AND (( '0' IN (1,5,9) AND A.YEAR_GUBUN = '0') OR ('0' = 8 AND A.YEAR_GUBUN IN (5,9)) OR ('0' = 0))
                                           AND A.GUNGU_CODE IN ( '260', '7' || '260' )
                                               UNION ALL
                                        SELECT CASE WHEN A.GUNGU_CODE = 7000 THEN 7100 ELSE A.GUNGU_CODE END GUNGU_CODE
                                             , CASE WHEN A.JIBGYE_CODE = 213000 THEN 217100 ELSE A.JIBGYE_CODE END JIBGYE_CODE
                                             , CASE WHEN A.GEORAE_GUBUN = 1 THEN 5 WHEN A.GEORAE_GUBUN = 3 THEN 8 ELSE 4 END KUBUN
                                             , A.BONSE_CNT
                                             , A.BONSE_AMT * DECODE(A.GEORAE_GUBUN,3,-1,1) BONSE_AMT
                                             , A.SEWOI_CNT
                                             , A.SEWOI_AMT * DECODE(A.GEORAE_GUBUN,3,-1,1) SEWOI_AMT
                                             , A.GYOYUKSE_AMT * DECODE(A.GEORAE_GUBUN,3,-1,1) GYOYUKSE_AMT
                                             , A.NONGTEUKSE_AMT * DECODE(A.GEORAE_GUBUN,3,-1,1) NONGTEUKSE_AMT
                                          FROM RPT_SUNAP_JIBGYE A 
                                         WHERE A.GEUMGO_CODE = '28' 
                                           AND A.SUNAPIL BETWEEN '20240601' AND '20240630'
                                           AND A.JIBGYE_CODE IN (103000, 104000, 209330, 209331, 209332, 209333, 200010, 200020, 213000, 215300, 217100) 
                                           AND NOT (A.JIBGYE_CODE = 213000 AND A.KEORAEIL <> A.SUNAPIL) 
                                           AND (('0' IN (1,5,9) AND A.YEAR_GUBUN = '0') OR ('0' = 8 AND A.YEAR_GUBUN IN (5,9)) OR ('0' = 0)) AND A.GUNGU_CODE IN ( '260', '7' || '260' )
                                               UNION ALL 
                                        SELECT CASE WHEN A.GUNGU_CODE = 7000 THEN 7100 ELSE A.GUNGU_CODE END GUNGU_CODE
                                             , CASE WHEN A.JIBGYE_CODE = 213000 THEN 217100 ELSE A.JIBGYE_CODE END JIBGYE_CODE
                                             , CASE WHEN A.JOJEONG_GUBUN <> 2 THEN 4 ELSE 8 END KUBUN
                                             , A.JIBANGSE_CNT BONSE_CNT
                                             , A.JIBANGSE_AMT * DECODE(A.IPJI_GUBUN,1,1,-1) BONSE_AMT
                                             , 0 SEWOI_CNT
                                             , A.SEWOI_AMT * DECODE(A.IPJI_GUBUN,1,1,-1) SEWOI_AMT
                                             , A.GYOYUKSE_AMT * DECODE(A.IPJI_GUBUN,1,1,-1) GYOYUKSE_AMT
                                             , A.NONGTEUKSE_AMT * DECODE(A.IPJI_GUBUN,1,1,-1) NONGTEUKSE_AMT
                                          FROM RPT_DANGSEIPJOJEONG A
                                         WHERE A.GEUMGO_CODE = '28' 
                                           AND A.SUNAPIL BETWEEN '20240601' AND '20240630'
                                           AND A.JIBGYE_CODE IN (103000, 104000, 209330, 209331, 209332, 209333, 200010, 200020, 213000, 215300, 217100)
                                           AND (('0' IN (1,5,9) AND A.YEAR_GUBUN = '0') OR ('0' = 8 AND A.YEAR_GUBUN IN (5,9)) OR ('0' = 0))
                                           AND A.GUNGU_CODE IN ( '260', '7' || '260' )
                                            
                                            
                                            
                                            
                                            UNION ALL 
                                           SELECT CASE WHEN A.GUNGU_CODE = 7000 THEN 7100 ELSE A.GUNGU_CODE END GUNGU_CODE
                                             , CASE WHEN A.JIBGYE_CODE = 300000 THEN 103000 ELSE 104000 END JIBGYE_CODE
                                             , CASE WHEN A.GEORAE_GUBUN = 1 THEN 2 WHEN A.GEORAE_GUBUN = 3 THEN 6 ELSE 1 END KUBUN 
                                             , A.BONSE_CNT
                                             , A.BONSE_AMT * DECODE(A.GEORAE_GUBUN,3,-1,1) BONSE_AMT
                                             , A.SEWOI_CNT
                                             , A.SEWOI_AMT * DECODE(A.GEORAE_GUBUN,3,-1,1) SEWOI_AMT
                                             , A.GYOYUKSE_AMT * DECODE(A.GEORAE_GUBUN,3,-1,1) GYOYUKSE_AMT
                                             , A.NONGTEUKSE_AMT * DECODE(A.GEORAE_GUBUN,3,-1,1) NONGTEUKSE_AMT
                                          FROM RPT_SUNAP_JIBGYE A 
                                         WHERE A.GEUMGO_CODE = '28' 
                                           AND A.SUNAPIL = '20240630'
                                           AND A.JIBGYE_CODE IN (300000, 304000)
                                           AND (('0' IN (1,5,9) AND A.YEAR_GUBUN = '0') OR ('0' = 8 AND A.YEAR_GUBUN IN (5,9)) OR ( '0' = 0 ))
                                           AND A.GUNGU_CODE IN ( '260' , '7' || '260' ) 
                                               UNION ALL 
                                        SELECT CASE WHEN A.GUNGU_CODE = 7000 THEN 7100 ELSE A.GUNGU_CODE END GUNGU_CODE
                                             , CASE WHEN A.JIBGYE_CODE = 300000 THEN 103000 ELSE 104000 END JIBGYE_CODE
                                             , CASE WHEN A.JOJEONG_GUBUN <> 2 THEN 3 ELSE 7 END KUBUN
                                             , A.JIBANGSE_CNT BONSE_CNT
                                             , A.JIBANGSE_AMT * DECODE(A.IPJI_GUBUN,1,1,-1) BONSE_AMT
                                             , 0 SEWOI_CNT
                                             , A.SEWOI_AMT * DECODE(A.IPJI_GUBUN,1,1,-1) SEWOI_AMT
                                             , A.GYOYUKSE_AMT * DECODE(A.IPJI_GUBUN,1,1,-1) GYOYUKSE_AMT
                                             , A.NONGTEUKSE_AMT * DECODE(A.IPJI_GUBUN,1,1,-1) NONGTEUKSE_AMT
                                          FROM RPT_DANGSEIPJOJEONG A
                                         WHERE A.GEUMGO_CODE = '28' 
                                           AND A.SUNAPIL = '20240630'
                                           AND A.JIBGYE_CODE IN (300000, 304000)
                                           AND (( '0' IN (1,5,9) AND A.YEAR_GUBUN = '0') OR ('0' = 8 AND A.YEAR_GUBUN IN (5,9)) OR ('0' = 0))
                                           AND A.GUNGU_CODE IN ( '260', '7' || '260' )
                                               UNION ALL
                                        SELECT CASE WHEN A.GUNGU_CODE = 7000 THEN 7100 ELSE A.GUNGU_CODE END GUNGU_CODE
                                             , CASE WHEN A.JIBGYE_CODE = 300000 THEN 103000 ELSE 104000 END JIBGYE_CODE
                                             , CASE WHEN A.GEORAE_GUBUN = 1 THEN 5 WHEN A.GEORAE_GUBUN = 3 THEN 8 ELSE 4 END KUBUN
                                             , A.BONSE_CNT
                                             , A.BONSE_AMT * DECODE(A.GEORAE_GUBUN,3,-1,1) BONSE_AMT
                                             , A.SEWOI_CNT
                                             , A.SEWOI_AMT * DECODE(A.GEORAE_GUBUN,3,-1,1) SEWOI_AMT
                                             , A.GYOYUKSE_AMT * DECODE(A.GEORAE_GUBUN,3,-1,1) GYOYUKSE_AMT
                                             , A.NONGTEUKSE_AMT * DECODE(A.GEORAE_GUBUN,3,-1,1) NONGTEUKSE_AMT
                                          FROM RPT_SUNAP_JIBGYE A 
                                         WHERE A.GEUMGO_CODE = '28' 
                                           AND A.SUNAPIL BETWEEN '20240601' AND '20240630'
                                           AND A.JIBGYE_CODE IN (300000, 304000)
                                           AND NOT (A.JIBGYE_CODE = 213000 AND A.KEORAEIL <> A.SUNAPIL) 
                                           AND (('0' IN (1,5,9) AND A.YEAR_GUBUN = '0') OR ('0' = 8 AND A.YEAR_GUBUN IN (5,9)) OR ('0' = 0)) AND A.GUNGU_CODE IN ( '260', '7' || '260' )
                                               UNION ALL 
                                        SELECT CASE WHEN A.GUNGU_CODE = 7000 THEN 7100 ELSE A.GUNGU_CODE END GUNGU_CODE
                                             , CASE WHEN A.JIBGYE_CODE = 300000 THEN 103000 ELSE 104000 END JIBGYE_CODE
                                             , CASE WHEN A.JOJEONG_GUBUN <> 2 THEN 4 ELSE 8 END KUBUN
                                             , A.JIBANGSE_CNT BONSE_CNT
                                             , A.JIBANGSE_AMT * DECODE(A.IPJI_GUBUN,1,1,-1) BONSE_AMT
                                             , 0 SEWOI_CNT
                                             , A.SEWOI_AMT * DECODE(A.IPJI_GUBUN,1,1,-1) SEWOI_AMT
                                             , A.GYOYUKSE_AMT * DECODE(A.IPJI_GUBUN,1,1,-1) GYOYUKSE_AMT
                                             , A.NONGTEUKSE_AMT * DECODE(A.IPJI_GUBUN,1,1,-1) NONGTEUKSE_AMT
                                          FROM RPT_DANGSEIPJOJEONG A
                                         WHERE A.GEUMGO_CODE = '28' 
                                           AND A.SUNAPIL BETWEEN '20240601' AND '20240630'
                                           AND A.JIBGYE_CODE IN (300000, 304000)
                                           AND (('0' IN (1,5,9) AND A.YEAR_GUBUN = '0') OR ('0' = 8 AND A.YEAR_GUBUN IN (5,9)) OR ('0' = 0))
                                           AND A.GUNGU_CODE IN ( '260', '7' || '260' )
                                           
                                           ) T 
                                         GROUP BY GUNGU_CODE, JIBGYE_CODE, KUBUN) X
                                     , (SELECT REF_M_C AS GEUMGO_CODE
                                             , REF_D_C AS GUNGU_CODE
                                             , REF_D_NM AS GUNGU_NAME
                                             , BB.JIBGYE_CODE
                                             , BB.JIBGYE_NM
                                             , BB.LVL
                                          FROM RPT_CODE_INFO A
                                             , (SELECT REF_D_C JIBGYE_CODE
                                                     , REF_D_NM JIBGYE_NM
                                                     , LVL
                                                  FROM (SELECT REF_D_C
                                                             , REF_D_NM 
                                                          FROM RPT_CODE_INFO
                                                         WHERE REF_L_C = 500
                                                           AND REF_M_C = 28
                                                           AND REF_S_C = 6) AA
                                                     , (SELECT LEVEL LVL
                                                          FROM DUAL 
                                                               CONNECT BY LEVEL < 9) BB) BB
                                                 WHERE REF_L_C = 500
                                                   AND REF_M_C = 28 
                                                   AND REF_S_C = 1
                                                   AND BB.JIBGYE_CODE IN (103000, 104000) 
                                                   AND A.REF_D_C IN ( '260' ) ) G 
                                 WHERE X.GUNGU_CODE(+) = G.GUNGU_CODE
                                   AND X.JIBGYE_CODE(+) =G.JIBGYE_CODE 
                                   AND X.KUBUN(+) =G.LVL 
                                       GROUP BY G.GUNGU_CODE,G.GUNGU_NAME,G.LVL,G.JIBGYE_CODE
                                       ORDER BY G.GUNGU_CODE,G.GUNGU_NAME,G.LVL,G.JIBGYE_CODE) A
                              GROUP BY A.GUNGU_CODE, A.GUNGU_NAME) P
                          , (SELECT A.BAS_YYMM
                                  , A.JEONGDANG_CHEONG 
                                  , SUM(A.JEONGDANG_SIGUSE_AMT) JEONGDANG_SIGUSE_AMT 
                                  , SUM(A.JEONGDANG_GYOYUKSE_AMT) JEONGDANG_GYOYUKSE_AMT 
                                  , SUM(A.JEONGDANG_NONGTEUKSE_AMT) JEONGDANG_NONGTEUKSE_AMT 
                                  , SUM(A.JEONGDANG_HAPGYE_AMT) JEONGDANG_HAPGYE_AMT 
                                  , SUM(A.BANSONG_SIGUSE_AMT) * -1 BANSONG_SIGUSE_AMT 
                                  , SUM(A.BANSONG_GYOYUKSE_AMT) BANSONG_GYOYUKSE_AMT 
                                  , SUM(A.BANSONG_NONGTEUKSE_AMT) BANSONG_NONGTEUKSE_AMT 
                                  , SUM(A.BANSONG_HAPGYE_AMT) BANSONG_HAPGYE_AMT 
                                  , SUM(A.TADO_SIGUSE_AMT) TADO_SIGUSE_AMT 
                                  , SUM(A.TADO_GYOYUKSE_AMT) TADO_GYOYUKSE_AMT 
                                  , SUM(A.TADO_NONGTEUKSE_AMT) TADO_NONGTEUKSE_AMT 
                                  , SUM(A.TADO_HAPGYE_AMT) TADO_HAPGYE_AMT 
                                  , SUM(A.BANKJOJEONG_SIGUSE_AMT) BANKJOJEONG_SIGUSE_AMT 
                                  , SUM(A.BANKJOJEONG_GYOYUKSE_AMT) BANKJOJEONG_GYOYUKSE_AMT 
                                  , SUM(A.BANKJOJEONG_NONGTEUKSE_AMT) BANKJOJEONG_NONGTEUKSE_AMT 
                                  , SUM(A.BANKJOJEONG_HAPGYE_AMT) BANKJOJEONG_HAPGYE_AMT 
                               FROM (SELECT A.BAS_YYMM
                                          , A.JEONGDANG_CHEONG 
                                          , SUM(NVL(A.FIL_18_AMT1,0) + NVL(A.FIL_18_AMT2,0)) JEONGDANG_SIGUSE_AMT 
                                          , SUM(A.GYOYUKSE_AMT) JEONGDANG_GYOYUKSE_AMT 
                                          , SUM(A.NONGTEUKSE_AMT) JEONGDANG_NONGTEUKSE_AMT 
                                          , (SUM(NVL(A.FIL_18_AMT1,0) + NVL(A.FIL_18_AMT2,0)) + SUM(A.GYOYUKSE_AMT) + SUM(A.NONGTEUKSE_AMT)) JEONGDANG_HAPGYE_AMT 
                                          , 0 BANSONG_SIGUSE_AMT 
                                          , 0 BANSONG_GYOYUKSE_AMT 
                                          , 0 BANSONG_NONGTEUKSE_AMT 
                                          , 0 BANSONG_HAPGYE_AMT 
                                          , 0 TADO_SIGUSE_AMT
                                          , 0 TADO_GYOYUKSE_AMT
                                          , 0 TADO_NONGTEUKSE_AMT
                                          , 0 TADO_HAPGYE_AMT
                                          , 0 BANKJOJEONG_SIGUSE_AMT 
                                          , 0 BANKJOJEONG_GYOYUKSE_AMT 
                                          , 0 BANKJOJEONG_NONGTEUKSE_AMT 
                                          , 0 BANKJOJEONG_HAPGYE_AMT 
                                       FROM RPT_JOJEONG_INFO A
                                      WHERE A.BAS_YYMM = '202406'
                                        AND A.JEONGDANG_CHEONG = '260'
                                        AND A.JOJEONG_GUBUN IN (1)
                                            GROUP BY A.BAS_YYMM, A.JEONGDANG_CHEONG 
                                            UNION ALL 
                                     SELECT A.BAS_YYMM
                                          , A.BANSONG_CHEONG 
                                          , 0 JEONGDANG_SIGUSE_AMT 
                                          , 0 JEONGDANG_GYOYUKSE_AMT 
                                          , 0 JEONGDANG_NONGTEUKSE_AMT 
                                          , 0 JEONGDANG_HAPGYE_AMT 
                                          , SUM(CASE WHEN A.JOJEONG_GUBUN = 1 THEN NVL(A.FIL_18_AMT1,0) + NVL(A.FIL_18_AMT2,0) ELSE 0 END) BANSONG_SIGUSE_AMT 
                                          , SUM(CASE WHEN A.JOJEONG_GUBUN = 1 THEN A.GYOYUKSE_AMT ELSE 0 END) BANSONG_GYOYUKSE_AMT 
                                          , SUM(CASE WHEN A.JOJEONG_GUBUN = 1 THEN A.NONGTEUKSE_AMT ELSE 0 END) BANSONG_NONGTEUKSE_AMT 
                                          , (SUM(CASE WHEN A.JOJEONG_GUBUN = 1 THEN NVL(A.FIL_18_AMT1,0) + NVL(A.FIL_18_AMT2,0) ELSE 0 END) + SUM(CASE WHEN A.JOJEONG_GUBUN = 1 THEN A.GYOYUKSE_AMT ELSE 0 END) 
                                           + SUM(CASE WHEN A.JOJEONG_GUBUN = 1 THEN A.NONGTEUKSE_AMT ELSE 0 END)) BANSONG_HAPGYE_AMT 
                                          , SUM(CASE WHEN A.JOJEONG_GUBUN = 2 THEN NVL(A.FIL_18_AMT1,0) + NVL(A.FIL_18_AMT2,0) ELSE 0 END) TADO_SIGUSE_AMT
                                          , SUM(CASE WHEN A.JOJEONG_GUBUN = 2 THEN A.GYOYUKSE_AMT ELSE 0 END) TADO_GYOYUKSE_AMT
                                          , SUM(CASE WHEN A.JOJEONG_GUBUN = 2 THEN A.NONGTEUKSE_AMT ELSE 0 END) TADO_NONGTEUKSE_AMT
                                          , (SUM(CASE WHEN A.JOJEONG_GUBUN = 2 THEN NVL(A.FIL_18_AMT1,0) + NVL(A.FIL_18_AMT2,0) ELSE 0 END)  + SUM(CASE WHEN A.JOJEONG_GUBUN = 2 THEN A.GYOYUKSE_AMT ELSE 0 END)
                                           + SUM(CASE WHEN A.JOJEONG_GUBUN = 2 THEN A.NONGTEUKSE_AMT ELSE 0 END)) TADO_HAPGYE_AMT
                                          , SUM(CASE WHEN A.JOJEONG_GUBUN = 3 THEN NVL(A.FIL_18_AMT1,0) + NVL(A.FIL_18_AMT2,0) ELSE 0 END) BANKJOJEONG_SIGUSE_AMT 
                                          , SUM(CASE WHEN A.JOJEONG_GUBUN = 3 THEN A.GYOYUKSE_AMT ELSE 0 END) BANKJOJEONG_GYOYUKSE_AMT 
                                          , SUM(CASE WHEN A.JOJEONG_GUBUN = 3 THEN A.NONGTEUKSE_AMT ELSE 0 END) BANKJOJEONG_NONGTEUKSE_AMT 
                                          , (SUM(CASE WHEN A.JOJEONG_GUBUN = 3 THEN NVL(A.FIL_18_AMT1,0) + NVL(A.FIL_18_AMT2,0) ELSE 0 END)  + SUM(CASE WHEN A.JOJEONG_GUBUN = 3 THEN A.GYOYUKSE_AMT ELSE 0 END)
                                           + SUM(CASE WHEN A.JOJEONG_GUBUN = 3 THEN A.NONGTEUKSE_AMT ELSE 0 END)) BANKJOJEONG_HAPGYE_AMT 
                                       FROM RPT_JOJEONG_INFO A
                                      WHERE A.BAS_YYMM = '202406'
                                        AND A.BANSONG_CHEONG = '260'
                                        AND A.JOJEONG_GUBUN IN (1,2,3)
                                            GROUP BY A.BAS_YYMM, A.BANSONG_CHEONG) A 
                                      GROUP BY A.BAS_YYMM,A.JEONGDANG_CHEONG) Q
                                  , (SELECT A.BAS_YYMM
                                          , A.GUNGU_CODE 
                                          , A.TOT_GYOYUKSE 
                                          , A.TOT_NONGTEUKSE 
                                          , A.TOT_HAPGYE 
                                          , A.HWAN_GYOYUKSE
                                          , A.HWAN_NONGTEUKSE
                                          , (CASE WHEN MOD((A.TOT_GYOYUKSE + A.HWAN_GYOYUKSE) , 10) <> 0 THEN '국고끝전있음'  ELSE TO_CHAR(A.TOT_GYOYUKSE + A.HWAN_GYOYUKSE) END) SOONAEK_GYOYUKSE 
                                          , (CASE WHEN MOD((A.TOT_NONGTEUKSE + A.HWAN_NONGTEUKSE) , 10) <> 0 THEN '국고끝전있음' ELSE TO_CHAR(A.TOT_NONGTEUKSE + A.HWAN_NONGTEUKSE) END) SOONAEK_NONGTEUKSE 
                                          , (A.TOT_GYOYUKSE + A.TOT_NONGTEUKSE + A.TOT_SISE + A.TOT_SISEWOI + A.TOT_GUSE + A.TOT_GUSEWOI) JONGHAP 
                                          , A.TOT_SISE 
                                          , A.TOT_SISEWOI
                                          , A.TOT_GUSE 
                                          , A.TOT_GUSEWOI
                                          , A.HWAN_SISE
                                          , A.HWAN_SISEWOI 
                                          , A.HWAN_GUSE
                                          , A.HWAN_GUSEWOI 
                                          , (A.HWAN_SISE + A.HWAN_SISEWOI + A.HWAN_GUSE + A.HWAN_GUSEWOI + A.HWAN_GYOYUKSE + A.HWAN_NONGTEUKSE) HWAN_HAPGYE
                                          , (A.TOT_SISE + A.HWAN_SISE) SOON_SISE 
                                          , (A.TOT_SISEWOI + A.HWAN_SISEWOI) SOON_SISEWOI
                                          , (A.TOT_GUSE + A.HWAN_GUSE) SOON_GUSE 
                                          , (A.TOT_GUSEWOI + A.HWAN_GUSEWOI) SOON_GUSEWOI
                                          , ((A.TOT_SISE + A.HWAN_SISE) + (A.TOT_SISEWOI + A.HWAN_SISEWOI) + (A.TOT_GUSE + A.HWAN_GUSE) + (A.TOT_GUSEWOI + A.HWAN_GUSEWOI)) SOON_HAPGYE
                                          , (A.JOONG_YANGYEO + (CASE WHEN MOD((A.TOT_GYOYUKSE + A.HWAN_GYOYUKSE) , 10) <> 0 THEN 9999999999  ELSE (A.TOT_GYOYUKSE + A.HWAN_GYOYUKSE) END) 
                                                             + (CASE WHEN MOD((A.TOT_NONGTEUKSE + A.HWAN_NONGTEUKSE) , 10) <> 0 THEN 9999999999 ELSE (A.TOT_NONGTEUKSE + A.HWAN_NONGTEUKSE) END) + A.JOONG_ICHE) JOONG_CHONGAEK 
                                          , A.JOONG_YANGYEO
                                          , (CASE WHEN MOD((A.TOT_GYOYUKSE + A.HWAN_GYOYUKSE) , 10) <> 0 THEN '국고끝전있음' ELSE TO_CHAR(A.TOT_GYOYUKSE + A.HWAN_GYOYUKSE) END) JOONG_GYOYUK 
                                          , (CASE WHEN MOD((A.TOT_NONGTEUKSE + A.HWAN_NONGTEUKSE) , 10) <> 0 THEN '국고끝전있음'  ELSE TO_CHAR(A.TOT_NONGTEUKSE + A.HWAN_NONGTEUKSE) END) JOONG_NONGTEUK 
                                          , A.JOONG_ICHE 
                                          , (((CASE WHEN MOD((A.TOT_GYOYUKSE + A.HWAN_GYOYUKSE) , 10) <> 0 THEN 9999999999 ELSE (A.TOT_GYOYUKSE + A.HWAN_GYOYUKSE) END) - A.ETC_GYOYUK) + A.ETC_GYOYUK) GYOYUK_CHONGAEK
                                          , A.GYOYUK_YANGYEO 
                                          ,((CASE WHEN MOD((A.TOT_GYOYUKSE + A.HWAN_GYOYUKSE) , 10) <> 0 THEN 9999999999 ELSE (A.TOT_GYOYUKSE + A.HWAN_GYOYUKSE) END) - A.ETC_GYOYUK) GYOYUK_GYOYUK
                                          , A.GYOYUK_NONGTEUK
                                          , A.GYOYUK_ICHE
                                          , A.ETC_CHONGAEK 
                                          , A.ETC_YANGYEO
                                          , A.ETC_GYOYUK 
                                          , A.ETC_NONGTEUK 
                                          , A.ETC_ICHE 
                                          , (((CASE WHEN MOD((A.TOT_NONGTEUKSE + A.HWAN_NONGTEUKSE) , 10) <> 0 THEN 9999999999 ELSE (A.TOT_NONGTEUKSE + A.HWAN_NONGTEUKSE) END) - A.ETCNONGTEUK_NONGTEUK) + A.ETCNONGTEUK_NONGTEUK ) NONGTEUK_CHONGAEK
                                          , A.NONGTEUK_YANGYEO 
                                          , A.NONGTEUK_GYOYUK
                                          , ((CASE WHEN MOD((A.TOT_NONGTEUKSE + A.HWAN_NONGTEUKSE) , 10) <> 0 THEN 9999999999 ELSE (A.TOT_NONGTEUKSE + A.HWAN_NONGTEUKSE) END) - A.ETCNONGTEUK_NONGTEUK) NONGTEUK_NONGTEUK
                                          , A.NONGTEUK_ICHE
                                          , A.ETCNONGTEUK_CHONGAEK 
                                          , A.ETCNONGTEUK_YANGYEO
                                          , A.ETCNONGTEUK_GYOYUK 
                                          , A.ETCNONGTEUK_NONGTEUK 
                                          , A.ETCNONGTEUK_ICHE 
                                          , A.ETCBANGWI_CHONGAEK 
                                          , A.ETCBANGWI_YANGYEO
                                          , A.ETCBANGWI_GYOYUK 
                                          , A.ETCBANGWI_NONGTEUK 
                                          , A.ETCBANGWI_ICHE 
                                       FROM (SELECT A.BAS_YYMM
                                                  , A.GUNGU_CODE 
                                                  , SUM(CASE WHEN a.chonggwal_gubun = 11 THEN a.chonggwal_amt ELSE 0 END) TOT_GYOYUKSE 
                                                  , SUM(CASE WHEN a.chonggwal_gubun = 12 THEN a.chonggwal_amt ELSE 0 END) TOT_NONGTEUKSE 
                                                  , 0 TOT_HAPGYE 
                                                  , SUM(CASE WHEN a.chonggwal_gubun = 13 THEN a.chonggwal_amt ELSE 0 END) HWAN_GYOYUKSE
                                                  , SUM(CASE WHEN a.chonggwal_gubun = 14 THEN a.chonggwal_amt ELSE 0 END) HWAN_NONGTEUKSE
                                                  , 0 SOONAEK_GYOYUKSE 
                                                  , 0 SOONAEK_NONGTEUKSE 
                                                  , 0 JONGHAP
                                                  , SUM(CASE WHEN a.chonggwal_gubun = 15 THEN a.chonggwal_amt ELSE 0 END) TOT_SISE 
                                                  , SUM(CASE WHEN a.chonggwal_gubun = 16 THEN a.chonggwal_amt ELSE 0 END) TOT_SISEWOI
                                                  , SUM(CASE WHEN a.chonggwal_gubun = 17 THEN a.chonggwal_amt ELSE 0 END) TOT_GUSE 
                                                  , SUM(CASE WHEN a.chonggwal_gubun = 18 THEN a.chonggwal_amt ELSE 0 END) TOT_GUSEWOI
                                                  , SUM(CASE WHEN a.chonggwal_gubun = 19 THEN a.chonggwal_amt ELSE 0 END) HWAN_SISE
                                                  , SUM(CASE WHEN a.chonggwal_gubun = 20 THEN a.chonggwal_amt ELSE 0 END) HWAN_SISEWOI 
                                                  , SUM(CASE WHEN a.chonggwal_gubun = 21 THEN a.chonggwal_amt ELSE 0 END) HWAN_GUSE
                                                  , SUM(CASE WHEN a.chonggwal_gubun = 22 THEN a.chonggwal_amt ELSE 0 END) HWAN_GUSEWOI 
                                                  , 0 HWAN_HAPGYE
                                                  , 0 SOON_SISE
                                                  , 0 SOON_SISEWOI 
                                                  , 0 SOON_GUSE
                                                  , 0 SOON_GUSEWOI 
                                                  , 0 SOON_HAPGYE
                                                  , 0 JOONG_CHONGAEK 
                                                  , 0 JOONG_YANGYEO
                                                  , 0 JOONG_GYOYUK 
                                                  , 0 JOONG_NONGTEUK 
                                                  , 0 JOONG_ICHE 
                                                  , 0 GYOYUK_CHONGAEK
                                                  , 0 GYOYUK_YANGYEO 
                                                  , 0 GYOYUK_GYOYUK
                                                  , 0 GYOYUK_NONGTEUK
                                                  , 0 GYOYUK_ICHE
                                                  , 0 ETC_CHONGAEK 
                                                  , 0 ETC_YANGYEO
                                                  , SUM(CASE WHEN a.chonggwal_gubun = 23 THEN a.chonggwal_amt ELSE 0 END) ETC_GYOYUK 
                                                  , 0 ETC_NONGTEUK 
                                                  , 0 ETC_ICHE 
                                                  , 0 NONGTEUK_CHONGAEK
                                                  , 0 NONGTEUK_YANGYEO 
                                                  , 0 NONGTEUK_GYOYUK
                                                  , 0 NONGTEUK_NONGTEUK
                                                  , 0 NONGTEUK_ICHE
                                                  , 0 ETCNONGTEUK_CHONGAEK 
                                                  , 0 ETCNONGTEUK_YANGYEO
                                                  , 0 ETCNONGTEUK_GYOYUK 
                                                  , SUM(CASE WHEN a.chonggwal_gubun = 24 THEN a.chonggwal_amt ELSE 0 END) ETCNONGTEUK_NONGTEUK 
                                                  , 0 ETCNONGTEUK_ICHE 
                                                  , 0 ETCBANGWI_CHONGAEK 
                                                  , 0 ETCBANGWI_YANGYEO
                                                  , 0 ETCBANGWI_GYOYUK 
                                                  , 0 ETCBANGWI_NONGTEUK 
                                                  , 0 ETCBANGWI_ICHE 
                                               FROM RPT_JAGEUM_DAESA A
                                              WHERE A.BAS_YYMM = '202406'
                                                AND A.GUNGU_CODE = '260'
                                                      GROUP BY A.BAS_YYMM, A.GUNGU_CODE) A ) R
                         WHERE P.GUNGU_CODE = Q.JEONGDANG_CHEONG(+)
                           AND P.GUNGU_CODE = R.GUNGU_CODE(+)) A
============================================================================================
]