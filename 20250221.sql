
SELECT X.RNUM
     , X.SL_GMGO_MODL_C
     , X.QSTN_ASK_SER
     , X.QSTN_ASK_G
     , X.REL_SER
     , X.REL_QSTN_SER
     , X.LVL
     , X.TTL
     , X.DISP_TTL
     , X.CTNT
     , X.USER_NM AS USER_ID
     , X.WRT_IP
     , X.WRT_DTTM
     , X.DEL_YN
     , X.ASK_CNT
     , X.INQR_CNT
     , X.ATTCH_FILE_MNG_NO
     , X.DROKJA_ID
     , X.DR_DTTM AS DR_DTTM
     , X.MODR_ID
     , X.UPD_DTTM AS UPD_DTTM
FROM (
         WITH IN_PARAM_INF AS
             (

                 SELECT A.IN_MODL_C, TRIM(A.IN_SEARCH_TITLE) AS IN_SEARCH_TITLE, TRIM(A.IN_SEARCH_USER) AS IN_SEARCH_USER
                      , A.IN_FROM_NUM AS IN_PAGE_STNO
                      , A.IN_TO_NUM   AS IN_PAGE_EDNO
                 FROM (SELECT 'RPT' AS IN_MODL_C, '' AS IN_SEARCH_TITLE, '' AS IN_SEARCH_USER, 1 AS IN_FROM_NUM, 100 AS IN_TO_NUM FROM DUAL) A
             )
            , WT_SEARCH_RST_REL_SER AS
             (

                 SELECT DISTINCT qna.sl_gmgo_modl_c, qna.rel_ser
                               , (SELECT MAX(z.wrt_dttm) FROM SFI_QSTN_ASK_HIS z WHERE z.sl_gmgo_modl_c = qna.sl_gmgo_modl_c AND z.QSTN_ASK_SER = qna.rel_ser) as fst_wrt_dttm
                 FROM SFI_QSTN_ASK_HIS qna
                          INNER JOIN IN_PARAM_INF inp ON 1=1
                          LEFT OUTER JOIN SFI_USER_INF usi
                                          ON qna.sl_gmgo_modl_c = usi.sl_gmgo_modl_c
                                              AND qna.user_id = usi.user_id
                 WHERE qna.sl_gmgo_modl_c = inp.IN_MODL_C
                   AND (   inp.IN_SEARCH_TITLE IS NULL
                     OR qna.ttl  LIKE '%' || inp.IN_SEARCH_TITLE || '%'
                     OR qna.ctnt LIKE '%' || inp.IN_SEARCH_TITLE || '%'
                     )
                   AND (   inp.IN_SEARCH_USER IS NULL
                     OR qna.user_id LIKE        inp.IN_SEARCH_USER || '%'
                     OR usi.user_nm LIKE '%' || inp.IN_SEARCH_USER || '%'
                     )
                   AND qna.del_yn = 'N'
             )
         SELECT *
         FROM
             (
                 SELECT ROWNUM AS RNUM
                      , A.*
                 FROM
                     (
                         SELECT qna.sl_gmgo_modl_c
                              , qna.qstn_ask_ser
                              , qna.qstn_ask_g
                              , qna.rel_ser
                              , qna.rel_qstn_ser
                              , LEVEL as lvl
                              , CASE WHEN qna.qstn_ask_g = 'Q' AND qna.modr_id = 'sfiadm' THEN '【'||'공지】'||qna.ttl
                                     ELSE LPAD(' ',(LEVEL-1)*2,' ')||DECODE(qna.qstn_ask_g, 'Q', '【'||'질문】','【'||'답변】')||qna.ttl END AS disp_ttl
                              , qna.ctnt
                              , usi.user_nm
                              , qna.wrt_ip

                              , qna.wrt_dttm AS wrt_dttm
                              , qna.del_yn
                              , qna.ask_cnt
                              , qna.inqr_cnt
                              , qna.attch_file_mng_no
                              , qna.drokja_id
                              , qna.dr_dttm as dr_dttm
                              , qna.modr_id
                              , qna.upd_dttm as upd_dttm
                              , qna.ttl
                         FROM SFI_QSTN_ASK_HIS qna
                                  INNER JOIN WT_SEARCH_RST_REL_SER rst
                                             ON qna.sl_gmgo_modl_c = rst.sl_gmgo_modl_c
                                                 AND qna.rel_ser = rst.rel_ser
                                  LEFT OUTER JOIN SFI_USER_INF usi
                                                  ON qna.sl_gmgo_modl_c = usi.sl_gmgo_modl_c
                                                      AND qna.user_id = usi.user_id
                             START WITH qna.qstn_ask_ser = rst.rel_ser
                         CONNECT BY NOCYCLE PRIOR qna.qstn_ask_ser = qna.rel_qstn_ser
                         ORDER SIBLINGS BY CASE WHEN qna.qstn_ask_g = 'Q' AND qna.modr_id = 'sfiadm' THEN '99999999'||LPAD(qna.qstn_ask_ser, 6, '0') ELSE rst.fst_wrt_dttm END DESC
                                 , qna.rel_ser, qna.rel_qstn_ser, qna.qstn_ask_ser
                     ) A
                 WHERE A.DEL_YN = 'N'
             ) A
                 INNER JOIN IN_PARAM_INF inp ON 1=1
         WHERE RNUM BETWEEN inp.IN_PAGE_STNO AND inp.IN_PAGE_EDNO
     ) X


SELECT * FROM SFI_QSTN_ASK_HIS


    WITH IN_PARAM_INF AS
             (

                 SELECT A.IN_MODL_C, TRIM(A.IN_SEARCH_TITLE) AS IN_SEARCH_TITLE, TRIM(A.IN_SEARCH_USER) AS IN_SEARCH_USER
                      , A.IN_FROM_NUM AS IN_PAGE_STNO
                      , A.IN_TO_NUM   AS IN_PAGE_EDNO
                 FROM (SELECT 'RPT' AS IN_MODL_C, '' AS IN_SEARCH_TITLE, '' AS IN_SEARCH_USER, 1 AS IN_FROM_NUM, 100 AS IN_TO_NUM FROM DUAL) A
             )
            , WT_SEARCH_RST_REL_SER AS
             (

                 SELECT DISTINCT qna.sl_gmgo_modl_c, qna.rel_ser
                               , (SELECT MAX(z.wrt_dttm) FROM SFI_QSTN_ASK_HIS z WHERE z.sl_gmgo_modl_c = qna.sl_gmgo_modl_c AND z.QSTN_ASK_SER = qna.rel_ser) as fst_wrt_dttm
                 FROM SFI_QSTN_ASK_HIS qna
                          INNER JOIN IN_PARAM_INF inp ON 1=1
                          LEFT OUTER JOIN SFI_USER_INF usi
                                          ON qna.sl_gmgo_modl_c = usi.sl_gmgo_modl_c
                                              AND qna.user_id = usi.user_id
                 WHERE qna.sl_gmgo_modl_c = inp.IN_MODL_C
                   AND (   inp.IN_SEARCH_TITLE IS NULL
                     OR qna.ttl  LIKE '%' || inp.IN_SEARCH_TITLE || '%'
                     OR qna.ctnt LIKE '%' || inp.IN_SEARCH_TITLE || '%'
                     )
                   AND (   inp.IN_SEARCH_USER IS NULL
                     OR qna.user_id LIKE        inp.IN_SEARCH_USER || '%'
                     OR usi.user_nm LIKE '%' || inp.IN_SEARCH_USER || '%'
                     )
                   AND qna.del_yn = 'N'
             )
SELECT qna.sl_gmgo_modl_c
     , qna.qstn_ask_ser
     , qna.qstn_ask_g
     , qna.rel_ser
     , qna.rel_qstn_ser
     , LEVEL as lvl
     , CASE WHEN qna.qstn_ask_g = 'Q' AND qna.modr_id = 'sfiadm' THEN '【'||'공지】'||qna.ttl
            ELSE LPAD(' ',(LEVEL-1)*2,' ')||DECODE(qna.qstn_ask_g, 'Q', '【'||'질문】','【'||'답변】')||qna.ttl END AS disp_ttl
     , qna.ctnt
     , usi.user_nm
     , qna.wrt_ip

     , qna.wrt_dttm AS wrt_dttm
     , qna.del_yn
     , qna.ask_cnt
     , qna.inqr_cnt
     , qna.attch_file_mng_no
     , qna.drokja_id
     , qna.dr_dttm as dr_dttm
     , qna.modr_id
     , qna.upd_dttm as upd_dttm
     , qna.ttl
FROM SFI_QSTN_ASK_HIS qna
         INNER JOIN WT_SEARCH_RST_REL_SER rst
                    ON qna.sl_gmgo_modl_c = rst.sl_gmgo_modl_c
                        AND qna.rel_ser = rst.rel_ser
         LEFT OUTER JOIN SFI_USER_INF usi
                         ON qna.sl_gmgo_modl_c = usi.sl_gmgo_modl_c
                             AND qna.user_id = usi.user_id
    START WITH qna.qstn_ask_ser = rst.rel_ser
CONNECT BY NOCYCLE PRIOR qna.qstn_ask_ser = qna.rel_qstn_ser
ORDER SIBLINGS BY CASE WHEN qna.qstn_ask_g = 'Q' AND qna.modr_id = 'sfiadm' THEN '99999999'||LPAD(qna.qstn_ask_ser, 6, '0') ELSE rst.fst_wrt_dttm END DESC
                                 , qna.rel_ser, qna.rel_qstn_ser, qna.qstn_ask_ser

UPDATE SFI_QSTN_ASK_HIS
SET DEL_YN = 'Y'
 WHERE DEL_YN = 'N'

