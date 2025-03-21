SELECT A.BAS_YYMM
     , A.GUNGU_CODE
     , A.TOT_GYOYUKSE
     , A.TOT_NONGTEUKSE
     , A.TOT_HAPGYE
     , A.HWAN_GYOYUKSE
     , A.HWAN_NONGTEUKSE
     , (CASE WHEN MOD((A.TOT_GYOYUKSE + A.HWAN_GYOYUKSE) , 10) <> 0 THEN '국고끝전있음'
             ELSE TO_CHAR(A.TOT_GYOYUKSE + A.HWAN_GYOYUKSE) END) SOONAEK_GYOYUKSE
     , (CASE WHEN MOD((A.TOT_NONGTEUKSE + A.HWAN_NONGTEUKSE) , 10) <> 0 THEN '국고끝전있음'
             ELSE TO_CHAR(A.TOT_NONGTEUKSE + A.HWAN_NONGTEUKSE) END) SOONAEK_NONGTEUKSE
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
     , (A.JOONG_YANGYEO + (CASE WHEN MOD((A.TOT_GYOYUKSE + A.HWAN_GYOYUKSE) , 10) <> 0 THEN 9999999999
                                ELSE (A.TOT_GYOYUKSE + A.HWAN_GYOYUKSE) END) + (CASE WHEN MOD((A.TOT_NONGTEUKSE + A.HWAN_NONGTEUKSE) , 10) <> 0 THEN 9999999999
                                                                                     ELSE (A.TOT_NONGTEUKSE + A.HWAN_NONGTEUKSE) END) + A.JOONG_ICHE) JOONG_CHONGAEK
     , A.JOONG_YANGYEO
     , (CASE WHEN MOD((A.TOT_GYOYUKSE + A.HWAN_GYOYUKSE) , 10) <> 0 THEN 9999999999 ELSE (A.TOT_GYOYUKSE + A.HWAN_GYOYUKSE) END) JOONG_GYOYUK
     , (CASE WHEN MOD((A.TOT_NONGTEUKSE + A.HWAN_NONGTEUKSE) , 10) <> 0 THEN 9999999999 ELSE (A.TOT_NONGTEUKSE + A.HWAN_NONGTEUKSE) END) JOONG_NONGTEUK
     , A.JOONG_ICHE
     , (((CASE WHEN MOD((A.TOT_GYOYUKSE + A.HWAN_GYOYUKSE) , 10) <> 0 THEN 9999999999 ELSE (A.TOT_GYOYUKSE + A.HWAN_GYOYUKSE) END) - A.ETC_GYOYUK) + A.ETC_GYOYUK) GYOYUK_CHONGAEK
     , A.GYOYUK_YANGYEO
     , ((CASE WHEN MOD((A.TOT_GYOYUKSE + A.HWAN_GYOYUKSE) , 10) <> 0 THEN 9999999999 ELSE (A.TOT_GYOYUKSE + A.HWAN_GYOYUKSE) END) - A.ETC_GYOYUK) GYOYUK_GYOYUK
     , A.GYOYUK_NONGTEUK
     , A.GYOYUK_ICHE
     , A.ETC_CHONGAEK
     , A.ETC_YANGYEO
     , A.ETC_GYOYUK
     , A.ETC_NONGTEUK
     , A.ETC_ICHE
     , (((CASE WHEN MOD((A.TOT_NONGTEUKSE + A.HWAN_NONGTEUKSE) , 10) <> 0 THEN 9999999999 ELSE (A.TOT_NONGTEUKSE + A.HWAN_NONGTEUKSE) END) - A.ETCNONGTEUK_NONGTEUK) + A.ETCNONGTEUK_NONGTEUK) NONGTEUK_CHONGAEK
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
      WHERE A.BAS_YYMM = '202411'
        AND A.GUNGU_CODE = '170'
      GROUP BY A.BAS_YYMM, A.GUNGU_CODE) A

-----------------------------------------------------


SELECT A.BAS_YYMM
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
WHERE A.BAS_YYMM = '202411'
  AND A.GUNGU_CODE = '170'
GROUP BY A.BAS_YYMM, A.GUNGU_CODE

