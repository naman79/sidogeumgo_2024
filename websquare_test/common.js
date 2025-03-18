/**
 * @file 전체 Scope에서 공유되는 Global 전역 변수, 상수, 공통 함수를 정의한다.
 * @version 3.0
 * @author InswaveSystems
 */
 
 /**
 * @type gcm
 * @class gcm
 * @namespace gcm
 */
;
requires("uiplugin.popup");

var windowsLength = 0;
var allWindowsLength = 0;

var gcm = {
    // 서버 통신 서비스 호출을 위한 Context Path
    CONTEXT_PATH : "",

    // 서버 통신 서비스 호출을 위한 Service Url (Context Path 이하 경로)
    SERVICE_URL : "",

    // 서버 통신 기본 모드 ( "asynchronous" / "synchronous")
    DEFAULT_OPTIONS_MODE : "asynchronous",

    // 서버 통신 기본 미디어 타입
    DEFAULT_OPTIONS_MEDIATYPE : "application/json",

    // 2018-08-10 : 언어속성 정보 생성
    LAN_G : "KR",

    // 2018-09-18 : 문석길 : leftMenu.xml 에서 클릭한 메뉴의 화면ID를 보관한다.
    SCR_ID : "",

    // 2018-10-08 : 문석길 : leftMenu.xml 에서 클릭한 메뉴의 메뉴ID를 보관한다.
    MENU_ID : "",

    // 2018-10-15 : 문석길 : 즐겨찾기를 각 화면의 별포를 눌러서 호출했는지, 왼쪽메뉴를 통해서 호출했지에 대한 괸리변수
    FAVORATE_STAR_CALL : "",

    // 2018-09-19 : 문석길 : 이중 브라우저 재로그인 여부
    RELOGIN_YN : "",

    // 2018-10-18 : 문석길 : '세션복구거래구분' 0:준비, 1:복구시작, 2:복구완료, 9:복구에러
    SESSION_RECOVERY_TR_G : 0,

    // 2018-11-26 : 문석길 : 관리자가 특정사용자로 접속하는 경우에 'Y' (로그인 조회구분 3:관리자 사용자 자동접속 기능임)
    USER_LINK_YN : "",

    // 통신 상태 코드
    MESSAGE_CODE : {
        STATUS_ERROR : "E",
        STATUS_SUCCESS : "S",
        STATUS_WARNING : "W"
    },

    // 공통 코드 저장을 위한 DataList 속성 정보
    DATA_PREFIX : "dlt_CommonCode",

    // 2018-08-17 : 문석길 : 에러처리후 메인화면의 포커스를 받을 메인화면 컴포넌트 변수
    FOCUS_COMPONENT : "",
    FOCUS_GRID_COMPONENT : "",
    FOCUS_GRID_COMPONENT_ROW : 0,
    FOCUS_GRID_COMPONENT_COL : 0,

    // 2018-11-01 : 문석길 : SFI 법인카드 업무에서 사용하는 비밀번호검증여부
    SFI_CCD_SCNO_CHECK_YN : "",
    
    // 2019-08-06 : 정보경 : 본인인증 검증 여부
    BONIN_AUTH_CHECK_YN : "N",    
    BONIN_AUTH_STT_DTTM : "",
    LOGIN_DTTM : "",	//로그인 일시

    // 2018-09-06 : 문석길 : 확인 레이어팝업창 호출후 확인버튼 클릭시 사용하는 데이터
    CONFIRM_YN : "",
    CONFIRM_CALLBACK : "",
    CONFIRM_MSGBOX_YN : "", // 2018-11-26 : 문석길 : 확인메시지박스 여부

    // 2018-12-07 : 문석길 : 그리드 다음거래 레이어팝업에서 사용하는 변수 추가
    GRID_SEARCH_GB : "",    // 그리드조회구분 N:Next Search, A:All Search, X:No Search

    COMMON_CODE_INFO : {
        LABEL : "NAME",
        VALUE : "CODE",
        LABELV : "CODENM",
        LABELLPAD : "LP_CODENM",
        FILED_ARR : [ "NAME", "CODE", "CMM_C_NM", "CMM_C_ENG_NM", "SORT_SNO","USE_YN" ,"CODENM","LP_CODENM"]
    },

    // 유효성 검사 상태 정보 저장
    valStatus : {
        isValid : true,
        objectType : "", // 유효성 검사를 수행하는 컴포넌트 타입 : gridView, group
        objectName : "",
        columnId : "",
        rowIndex : 0,
        message : ""
    },

    // 메인 프레임 ID
    MAIN_FRAME_ID : "wc_mainContainer",

    // 업무 화면 오픈 Frame Mode 설정 ("iframe", "wframe")
    FRAME_MODE : "wframe",

    GNB_MENU_CODE : "SFI010000M00", // 현재 설정되어있은 gnbmenu의 코드

    // 전문 기본 action_Url
    ACTION_URL : "/ProworksBaseServlet.do",

    FILE_ACTION_URL : "/Shdownload.do",
    // ACTION_URL : "/websquare/engine/servlet/jsonProworksService.jsp",

    IS_TR : false, // 전문 submission 여부

    IS_FILEDOWN : false, // 파일 다운로드 여부

    // 서브미션 정보
    root_info_createDataObj : function() {
        com.createDataObj("dataMap", "root_info", [ "serviceID", "msgID" ]);
    },

    //--------------------------------------------------------------------------------------------------------------------------------------
    // □ 시스템공통부 (최종수정 : 2018-08-27 : 문석길)
    //--------------------------------------------------------------------------------------------------------------------------------------
    SYS_INF_createDataObj : function() {
        com.createDataObj("dataList", "SYS_INF", [
        "MSG_LEN",                  // 시스템정보 - 전문전체길이       [○] : totalLen 필드 5바이트를 제외한 전체 전문의 길이
        "GLOB_ID",                  // 시스템정보 - GlobalID           [○] : 거래의 유일한 값 - 최 앞단 Caller에서 설정
        "RQST_RESP_G",              // 시스템정보 - 요청응답구분       [○] : 요청/응답 구분 - S: 요청 , R: 응답
        "SYNC_G",                   // 시스템정보 - 동기구분           [○] : 호출 유형 정보 - Sync : 'S', Async : 'A'
        "INFC_SYS_ID",              // 시스템정보 - 인터페이스ID       [○] : 호출하고자 하는 시스템 - Callee 서버의 hostName
        "SND_INFC_G",               // 시스템정보 - 송신인터페이스구분 [○] : 사용하고자 하는 인터페이스 유형 - E : 대내연계, U : UI, A: 대외연계
        "MDIA_U",                   // 시스템정보 - 매체유형           [○] : Caller서버의 ID - 대내 시스템별 아이디(별첨 참조) UI는 'KUX'
        "NCRPT_FLG",                // 시스템정보 - 암호압축구분플래그 [○] : 암호화/압축/IP4, IP6 구분 플래그
        "LANG_G"                    // 시스템정보 - 언어구분           [○] : UI 언어 구분 - 'KR' 한글, 'EN' 영문페이지
        ]);
    },

    //--------------------------------------------------------------------------------------------------------------------------------------
    // □ 거래공통부 (최종수정 : 2018-08-27 : 문석길)
    //--------------------------------------------------------------------------------------------------------------------------------------
    TR_INF_createDataObj : function() {
        com.createDataObj("dataList", "TR_INF", [
        "RECV_SVC_C",               // 거래정보   - 수신서비스CODE     [○] : 거래 식별자 - 수신 서비스 ID
        "RST_RECV_SVC_C",           // 거래정보   - 결과수신서비스CODE [△] : 거래 식별자 - Async거래인 경우에만 해당
        "SCR_ID",                   // 거래정보   - 화면ID             [△] : 화면ID
        "RE_SCR_ID",                // 거래정보   - 재지향화면번호     [▲] : 리다이렉션(Redirect) 화면번호 및 명령
        "TRX_DTTM",                 // 거래정보   - 거래상세일시       [○] : 거래일자(8)+거래시간(9)
        "RST_U",                    // 거래정보   - 결과유형           [×] : Return Code - 0:성공, 1:RunTime Error, 2:Business Error
        "SYS_U_FLG",                // 거래정보   - 시스템유형플래그   [○] : 개발, 검증, 운영 플래그 - D:개발, T:검증, R:운영
        "USER_G",                   // 거래정보   - 사용자구분         [○] : 사용자 구분 - C:고객,  A:관리자
        "TRX_OP_SOSOK_GRPCO_C",     // 거래정보   - 조작자소속부서코드 [△] : 조작자 소속 부서코드
        "OP_NO",                    // 거래정보   - 조작자사번         [△] : 조작자 사번
        "CUS_ID",                   // 거래정보   - CID                [△] : 고객식별번호 - 고객식별번호:주민(법인)등록번호
        "CUSNM",                    // 거래정보   - 고객명             [△] : 고객명(법인명)
        "CUS_G",                    // 거래정보   - 고객구분           [△] : 고객구분 - 1:개인, 2: 법인
        "BIZREGNO",                 // 거래정보   - 사업자등록번호     [△] : 사업자등록번호
        "CLIENT_MAC1",              // 거래정보   - MAC주소1           [○] : 단말의 Mac Address 1
        "CLIENT_MAC2",              // 거래정보   - MAC주소2           [○] : 단말의 Mac Address 2
        "CLIENT_MAC3",              // 거래정보   - MAC주소3           [○] : 단말의 Mac Address 3
        "CLIENT_IP_NO1",            // 거래정보   - ClientIP1          [○] : 단말의 공인 IP 주소 1 - IP4 : 12자리까지 채움(뒷자리 패딩)
        "CLIENT_IP_NO2",            // 거래정보   - ClientIP2          [○] : 단말의 공인 IP 주소 2 - IP6 : 40자리
        "CLIENT_IP_NO3",            // 거래정보   - ClientIP3          [○] : 단말의 공인 IP 주소 3
        "MOB_UID",                  // 거래정보   - 앱ID               [△] : 모바일기기 앱 UID
        "BOJON",                    // 거래정보   - 보존영역           [△] : 클라이언트에서 보존 필요한 데이터(키값등..) 보관용
        "FILLER",                   // 거래정보   - 예비영역           [×] : 예비 영역
        "MENU_ID"                   // 거래정보   - 메뉴ID             [△] : 메뉴ID : 2018-10-08 : 문석길 추가
        ]);
    },

    // 2018-08-03 : 문석길 : 메시지부 추가
    MSG_INF_createDataObj : function() {
        com.createDataObj("dataList", "MSG_INF", [ "MSG_TYPE", "MSG_C", "BAS_MSG_DATA", "MSG_LEN" ]);
    },

    // 2018-08-03 : 문석길 : 로그인정보 NODE 생성
    // 2018-10-02 : 문석길 : 기관구분 - 사업자명 8개 항목 추가 (SFI 최황연 대리 요청)
    LOGIN : {
        USER_IP         : "", // 사용자IP            : 2018-09-03 추가
        SL_GMGO_MODL_C  : "", // 서울시금고모듈코드
        USER_ID         : "", // 사용자ID
        USER_NM         : "", // 사용자명
        USER_U_C        : "", // 사용자유형CODE
        USER_RIGHT_G    : "", // 사용자권한구분
        PADM_STD_ORG_C  : "", // 행정표준기관CODE
        ORG_NM          : "", // 기관명
        SL_GMGO_DEPT_C  : "", // 서울시금고부서CODE
        DEPT_NM         : "", // 부서명
        BR_C            : "", // 영업점CODE
        BR_NM           : "", // 영업점명
        ORG_G           : "", // 기관구분           2018-10-02 추가 (SFI 최황연 대리 요청)
        CT_GU_C         : "", // 시구CODE(징수기관) 2018-10-02 추가 (SFI 최황연 대리 요청)
        CT_GUSANG_TAX_C : "", // 시구상세CODE       2018-10-02 추가 (SFI 최황연 대리 요청)
        CHNGS_C         : "", // 청소CODE           2018-10-02 추가 (SFI 최황연 대리 요청)
        BIZNO           : "", // 사업자번호         2018-10-02 추가 (SFI 최황연 대리 요청)
        PROVR_NM        : "", // 사업자명           2018-10-02 추가 (SFI 최황연 대리 요청)
        SYS_U_FLG       : "", // 시스템유형플래그   2018-12-10 추가 (TRS 이태식 과장 요청) - D:개발, T:검증, R:운영
        GRID_PAGE_UNIT_CNT_SM   : "", // 그리드페이지단위건수(소)     100건 2018-12-11 문석길 추가
        GRID_PAGE_UNIT_CNT_MD   : "", // 그리드페이지단위건수(중)     500건 2018-12-11 문석길 추가
        GRID_PAGE_UNIT_CNT_LRGE : "", // 그리드페이지단위건수(대)    2000건 2018-12-11 문석길 추가
        GRID_PAGE_UNIT_CNT_MAX  : ""  // 그리드페이지단위건수(최대) 50000건 2018-12-11 문석길 추가
    },

    // 2018-09-03 : 문석길 : 로그인정보중 사용자별특화상세 datalist 생성 (사용자특화CODE, 사용자특화범위CODE)
    // 2018-10-31 : 문석길 : 사용자특화명, 사용자특화범위명 추가
    LOGIN_USER_BY_SPZ_HIS_createDataObj : function() {
        com.createDataObj("dataList", "LOGIN_USER_BY_SPZ_HIS", ["USER_SPZ_C", "USER_SPZ_NM", "USER_SPZ_SCOP_C", "USER_SPZ_SCOP_NM"]);
    },

    clear_header : function() {
        try {
            root_info.reset();
            root_info.reform();
            SYS_INF.removeAll();
            SYS_INF.reform();
            TR_INF.removeAll();
            TR_INF.reform();
            MSG_INF.removeAll();
            MSG_INF.reform();
        } catch (e) {
            console.error("[common.js][gcm.clear_header] clear_header_err:" + e);
        }
    },

    init_header : function() {
        try {
            gcm.root_info_createDataObj();
            gcm.SYS_INF_createDataObj();
            gcm.TR_INF_createDataObj();
            gcm.MSG_INF_createDataObj();
            gcm.LOGIN_USER_BY_SPZ_HIS_createDataObj(); // 2018-09-03 : 문석길 : 로그인정보중 사용자별특화상세 datalist 생성
        } catch (e) {
            console.error("[common.js][gcm.init_header] init_header_err:" + e);
        }
    },
    isTest: false,

    //--------------------------------------------------------------------------------------------------------------------------------------
    // □ 도움말 이미지 경로 (최종수정 : 2018-10-11 : 변상필)
    //--------------------------------------------------------------------------------------------------------------------------------------
    SIM_SFI_IMG_PATH : "/img/help/sim/sfi/",
    OCR_TRS_IMG_PATH : "/img/help/ocr/trs/",
    EBS_TRE_IMG_PATH : "/img/help/ebs/tre/",
    EBS_EPE_IMG_PATH : "/img/help/ebs/epe/"

};

/**
 * 메인 화면에서 업무 화면을 오픈하는 Frame Mode 정보를 반환한다.
 *
 * @date 2018.05.18
 * @private
 * @memberOf gcm
 * @author InswaveSystems
 */
gcm.getFrameMode = function() {
    return gcm.FRAME_MODE;
};

/**
 * _com 객체에 정의된 공개 API들을 com 객체에 $p 객체를 첫번째 파라미터로 전달하면서 바인딩 시킨다.
 *
 * @date 2018.05.01
 * @private
 * @param {Object}
 *            com 객체
 * @memberOf gcm
 * @author InswaveSystems
 */
gcm._bindAPI = function(com, $p) {

    for (var i in window.com) {

        if(window.com[i]._identifier == "wframe_scope"){
            continue;
        }
        com[i] = WebSquare.core.cloneObject(window.com[i]);
    }
    com.$p = $p;
    com.initWframeId = $p.getFrameId();
    
    Geumgo.init();
};

/**
 * 유효성 검사 실패에 대한 Alert 메시지 창이 닫힌 후에 수행되는 콜백 함수이다.
 *
 * @date 2018.04.15
 * @private
 * @memberOf gcm
 * @author InswaveSystems
 * @returns null
 */
gcm._groupValidationCallback = function() {
    if ((gcm.valStatus.objectName !== "") && (gcm.valStatus.isValid === false)) {
        var obj = $p.getComponentById(gcm.valStatus.objectName);
        if (gcm.valStatus.objectType === "gridView") {
            obj.setFocusedCell(gcm.valStatus.rowIndex, gcm.valStatus.columnId);
        } else if (gcm.valStatus.objectType === "group") {
            obj.focus();
        }
    }
};

/**
 * submission의 공통 설정에서 사용. submisison 통신 직전 호출. return true일 경우 통신 수행, return
 * false일 경우 통신 중단
 *
 * @date 2016.11.11
 * @private
 * @param {Object}
 *            sbmObj 서브미션 객체
 * @memberOf gcm
 * @author InswaveSystems
 * @return {Boolean} true or false
 */
gcm._sbm_preSubmission = function(sbmObj) {

//m_    console.log(com.getPrintTime()+"[common.js][gcm._sbm_preSubmission] 선행 Submission 시작함. sbmObj.id [" + sbmObj.id + "]");
    if (gcm.IS_TR) { // 전문 통신만 처리

        sbmObj.errorHandler = "gcm._errorHandler";

        gcm.IS_TR = false;

//        sbmObj.action = gcm.ACTION_URL;

        // 파일 다운 시 적용
        if (gcm.IS_FILEDOWN) {
            sbmObj.action = gcm.FILE_ACTION_URL;
            gcm.IS_FILEDOWN = false;
        }

        /* 전문 헤더부 처리 start */
        if (!com.isEmpty(sbmObj.userData1)) {

            // 헤더 정보 클리어
            gcm.clear_header();

            var svcObj = sbmObj.userData1[0]; // [0] :
                                              // svcOBj,[1]:requestData,[2]:compObj
            // root_info
            root_info.set("serviceID", svcObj.svc_id);

            sbmObj.action = gcm.ACTION_URL+"?svc_id="+svcObj.svc_id;


            root_info.set("msgID"    , svcObj.msg_id);

            //console.log(com.getPrintTime()+"[common.js][gcm._sbm_preSubmission] SVC_ID ["+ svcObj.svc_id + "], MSG_ID [" + svcObj.msg_id + "]");

            // SYS_INF
            SYS_INF.setJSON(com.setReq_SYS_INF());
            // TR_INF
            svcObj['scr_id'] = WebSquare.w2xPath.split(WebSquare.w2xHome)[1].split(".xml")[0];

            //console.log(com.getPrintTime()+"[common.js][gcm._sbm_preSubmission] SCR_ID ["+ svcObj['scr_id'] + "]");

            TR_INF.setJSON(com.setReq_TR_INF(svcObj));
        }
        var header = 'root_info,SYS_INF,TR_INF,MSG_INF';
        /* 전문 헤더부 처리 finish */

        var sRef = sbmObj.ref.replaceAll(",root_info,SYS_INF,TR_INF,MSG_INF","");
        if (com.isEmpty(sRef)) {
            sbmObj.ref = "data:json,[" + header + "]";
        } else {
            var preRef = sRef.substring(0, sRef.indexOf(","));
            var postRef = sRef.substring(sRef.indexOf(",") + 1);

            var ref_data = postRef.replaceAll("[", "").replaceAll("]", "");

            postRef = "[" + ref_data + "," + header + "]";

            sbmObj.ref = preRef + "," + postRef;
        }

//debugger; // 2018-10-10 : 문석길 : SES 에러메시지 비정상 작동을 잡기위한 디거깅 실시. 10/11까지 사용 ==> 해결함.

        var rtn_header = 'root_info,SYS_INF,TR_INF,MSG_INF';
        var sTarget = sbmObj.target.replaceAll(",root_info,SYS_INF,TR_INF,MSG_INF","");

        // 2018-08-28 : 무조건으로 변경
        /*if (com.isEmpty(sTarget)) {
            sbmObj.target = "data:json,[]";
        }*/
        if (com.isEmpty(sTarget)) {

            //sTarget = sTarget.replaceAll("data:json,","");
            sbmObj.target = "data:json,[" + rtn_header + "]";
        } else {

            var preTarget = sTarget.substring(0, sTarget.indexOf(","));
            var postTarget = sTarget.substring(sTarget.indexOf(",") + 1);

            var target_data = postTarget.replaceAll("[", "").replaceAll("]", "").replaceAll("data:json","");

            if(com.isEmpty(target_data.trim())){
                sbmObj.target = "data:json,[" + rtn_header + "]";
            }else{
                postTarget = "[" + target_data + "," + rtn_header + "]";
                sbmObj.target = preTarget + "," + postTarget;
            }

        }
    }

    return true;
};

/**
 * 모든 submission의 defaultCallback - com.sbm_errorHandler 보다 먼저 수행됨. (400 Error)
 * config.xml에 설정
 *
 * @private
 * @date 2016.11.15
 * @param {Object}
 *            resObj responseData 객체
 * @param {Object}
 *            subObj Submission 객체
 * @memberOf gcm
 * @author InswaveSystems
 */
gcm._sbm_defCallbackSubmission = function(resObj, subObj) {
	
	if(com.isEmpty(TR_INF.getRowJSON(0).FILLER)) {
		TR_INF.setRowJSON(0, resObj.responseJSON.TR_INF[0]);
	}
	
    var _tr_inf = TR_INF.getRowJSON(0);
    var _msg_inf = MSG_INF.getRowJSON(0);
    /*
       var _50 = $W.document.getElementById("___processbar2");
       if(!com.isEmpty(_50)){
           _50.remove();
       }

       var _51 = $W.document.getElementById("___processbar2_i");
       if(!com.isEmpty(_51)){
           _51.remove();
       }
       */


// 2018-10-10 : 문석길 : SES 에러메시지 비정상 작동을 잡기위한 디거깅 실시. 10/11까지 사용 ==> 해결함.
//if (com.getUserIP() == "192.168.87.116") { // 문석길/김민 차장만
//    debugger;
//}
    
    // 로그인 시간 초기화
    if(!com.isEmpty(gcm.mainHeaderMenu)) {
    	gcm.mainHeaderMenu.getObj("scsObj").loginTimeInit();
    }

    var _this = gcm._getScope(subObj).com;

    // server와 연결을 할 수 없을 경우 responseStatusCode가 0으로 발생.
    if (resObj.responseStatusCode == 0) {

        var detailStr = "HTTP STATUS INFO";
        detailStr += resObj.responseStatusCode;
        detailStr += "URI:";
        detailStr += resObj.resourceUri;

        var msgObj = {
            statusCode : "E",
            errorCode : "E9998",
            message : "서버와 연결할 수 없습니다. 자세한 내용은 관리자에게 문의하시기 바랍니다.",
            messageDetail : detailStr
        };

        _this.resultMsg(msgObj);

        return false;
    }

    //debugger;
    
    var rsJSON = resObj.responseJSON || null;
    if (rsJSON && rsJSON.rsMsg) {
        _this.resultMsg(rsJSON.rsMsg);
    }

    // 2018-09-06 : 문석길 : 서버에서 거래공통부.보존영역 항목에 포커스 컴포넌트 명을 넣어주면 포커스 처리한다.
    if (! com.isEmpty(_tr_inf.BOJON)) {
        var focusComp = subObj.userData2 + _tr_inf.BOJON;
        gcm.FOCUS_COMPONENT = focusComp;
      //m_        console.log(com.getPrintTime()+"[common.js][gcm._sbm_defCallbackSubmission][TR_INF.BOJON] ["+focusComp+"]으로 포커스 이동 준비완료!!");
    }

    // 2018-08-03 : 문석길 : 메시지데이터 하단부에 SET
    // 2018-08-07 : 문석길 : 정상외에는 레이어팝업을 띄우도록 수정함.
    // 메시지종류구분 : N:정상, E:에러, W:경고, I:정보, C:확인
    //console.log(com.getPrintTime()+"[common.js][gcm._sbm_defCallbackSubmission] MSG_INF.MSG_C = "+MSG_INF.getCellData(0, "MSG_C"));
    //console.log(com.getPrintTime()+"[common.js][gcm._sbm_defCallbackSubmission] MSG_INF.BAS_MSG_DATA = "+MSG_INF.getCellData(0, "BAS_MSG_DATA"));

    if (!com.isEmpty(_msg_inf.MSG_C)) {

        // 2018-11-23 : 문석길 : 메시지코드가 비정상일 경우 ECTM0011 : {0} {1}로 대체한다.
        if (_msg_inf.MSG_C.length < 8) {
            _msg_inf.MSG_C = "ECTM0011";
        }

        var MSG_C_1 = _msg_inf.MSG_C.substr(0, 1);
        // 정의되지 않는 메시지종류일 경우 'E' 유형으로 처리한다.
        // (예. 프로웍스 에러 FWERR1X11 - "XDA 등록정보를 확인하세요.
        // (ebs.epe.xda.xSelectListEpeRtrnGojis01) (ORA-00904:
        // &quot;CNTCT_ORG_G&quot;: 부적합한 식별자&#xa;)"
        if (_msg_inf.MSG_C.substr(0, 1) == "F") {
            MSG_C_1 = "E";
        }

        // 2018-08-28 : SES 업무에서는 정상(N)을 알림(I) 메시지박스로 처리하도록 함.
        // 2018-10-22 : 문석길 : MSG_C_1 == "N" 조건 추가함.
        if (com.getSlGmgoModlC() == "SES" && MSG_C_1 == "N") {
            MSG_C_1 = "I";
        }
        
        //debugger;
        
        //console.log(com.getPrintTime()+"[common.js][gcm._sbm_defCallbackSubmission] MSG_C_1 = "+MSG_C_1);
        if (MSG_C_1 == "N") {
            // main_frame.xml 의 tbx_MSG_BAR_CTNT (2018-08-10 : 메인화면 없이 혼자 화면을 연 경우에는
            // SKIP 함)
        		
	        	var tbxObj = "";
	            var tbxGrpObj = "";
	            
        		if(gcm.mainFrame != undefined){
        			tbxObj = gcm.mainFrame.getObj("tbx_MSG_BAR_CTNT");
                    tbxGrpObj = gcm.mainFrame.getObj("grp_MSG_BAR");
        		}
        	
                
            //if (!com.isEmpty(mf_tbx_MSG_BAR_CTNT)) {
                if (!com.isEmpty(tbxObj)) {
                /*
                 mf_tbx_MSG_BAR_CTNT.setValue(MSG_INF.getCellData(0, "MSG_C")+" - "+MSG_INF.getCellData(0, "BAS_MSG_DATA"));
                mf_grp_MSG_BAR.show(); // 하단바를 보여준다.
                */
                    tbxObj.setValue(_msg_inf.MSG_C+" - "+_msg_inf.BAS_MSG_DATA);
                    tbxGrpObj.show(); // 하단바를 보여준다.

                //-----------------------------------------------------------------------------------------------------
                // □ 2018-09-11 : 문석길 : 4초후에 하단 메시지바를 숨기도록 한다.
                //    2018-10-18 : 문석길 : 4초에서 2초로 줄였음.
                //-----------------------------------------------------------------------------------------------------
                $p.setTimeout(function(){
                    //mf_grp_MSG_BAR.hide();
                    tbxGrpObj.hide();
                  //m_                    console.log(com.getPrintTime()+"[common.js][_sbm_defCallbackSubmission] 3초후에 하단 메시지바를 숨겼습니다.");
                    $p.clearTimeout("MSG_BAR");
                }, {delay:2000, key:"MSG_BAR"});
            }
        } else {

// 2018-11-20 : 문석길 : 문석길IP일 경우 에러메시지 강제로 변환하여 테스트함.
//if (com.getUserIP() == "192.168.87.116" || com.getUserIP() == "192.168.87.115" || com.getUserIP() == "192.168.87.141") { // 문석길/김민 차장만
//    if (com.getScrId() == "SFI030301M01") {
//        MSG_INF.setCellData(0, "MSG_C", "ECOMS90001");
//    }
//}

            // alert(MSG_INF.getCellData(0, "MSG_C") + " - " +
            // MSG_INF.getCellData(0, "BAS_MSG_DATA"));

            // 2018-10-25 : 문석길 : 출력방식 변경
            //var messageStr = MSG_INF.getCellData(0, "MSG_C") + " - " + MSG_INF.getCellData(0, "BAS_MSG_DATA");
            //var messageStr = MSG_INF.getCellData(0, "BAS_MSG_DATA")+"["+MSG_INF.getCellData(0, "MSG_C")+"]";
            //var messageStr = "<span style=\"color: #0071b7; font-size: 14px; font-weight: bold;\">"

            //var messageStr = "<span style=\"color: #333333; font-size: 13px; font-weight: bold;\">"
            //               + MSG_INF.getCellData(0, "BAS_MSG_DATA")
            //               + "</span>"
            //               + "<br>"
            //               + "<span style=\"color: #888888; font-size: 12px;\">"
            //               + "["+MSG_INF.getCellData(0, "MSG_C")+"]"
            //               + "</span>";

            var messageStr = {MSG_DATA:_msg_inf.BAS_MSG_DATA, MSG_C:_msg_inf.MSG_C};

            // com.messagBox("confirm", "보낼 메시지", "callback", true, "팝업 타이틀");
            // //isReturnValue속성에 false 사용가능
            var dataObject = {
                type : "json",
                data : JSON.stringify(messageStr),
                name : "POPUP_DATA"
            };

            var h = 0;
            var w = 0;
            if (MSG_C_1 == "E") {
                //h = "388"; // 2018-10-31 : 문석길 : 182 -> 157로 변경함
            	h = "415";
                w = "482";
            } else {
                h = "385"; // 2018-10-31 : 문석길 : 182 -> 153로 변경함
                w = "482";
            }

            var options = {
                id : "Layer_popup_" + MSG_C_1,
                title : false,
                height : h,
                width: w
            };

            var layerPopupName = "/uicom/common/Layer_popup_" + MSG_C_1 + ".xml";

            //console.log(com.getPrintTime()+"[common.js][gcm._sbm_defCallbackSubmission] messageStr = "+messageStr);
            //console.log(com.getPrintTime()+"[common.js][gcm._sbm_defCallbackSubmission] layerPopupName = "+layerPopupName);

            //-------------------------------------------------------------------------------------------------------------
            // □ 에러메시지코드에 따른 처리 방식을 각각 구현함.
            // 2018-09-21 : 방현승 차장 : SEE 오류코드 : ESES0003 발생시 메인화면으로 이동 처리 요청
            // 2018-10-04 : 문석길 차장 : ECOMS90001 : 세션정보가 끊어졌을 경우 SFI 팀은 복원서비스를 호출하여 세션을 복원한다.
            //-------------------------------------------------------------------------------------------------------------
            // 2018-09-21 : 방현승 차장 : SEE 오류코드 : ESES0003 발생시 메인화면으로 이동 처리 요청
            if (_msg_inf.MSG_C == "ESES0003") {
                alert(_msg_inf.BAS_MSG_DATA);
                location.href = "/";
                return false;
            //-------------------------------------------------------------------------------------------------------------
            // □ 세션정보가 끊어졌을 경우 SFI 팀은 복원서비스를 호출하여 세션을 복원한다.
            //    프로웍스 시스템에러코드 ECOMS90001 : "해당 서비스["+serviceId+"("+serviceName+")]의 세션이 유효하지 않습니다.."
            // 2018-10-18 : 즐겨찾기(SSFI010603XXX), 최근이력(SSFI010604XXX) 서비스들은 세션에러나도 SKIP 하도록 한다.
            //              세션복원은 업무용 서비스인 경우만 복원하고, 재조회 알림팝업을 띄우도록 한다.
            //-------------------------------------------------------------------------------------------------------------
            } else if (_msg_inf.MSG_C == "ECOMS90001") {

                // 즐겨찾기(SSFI010603XXX), 최근이력(SSFI010604XXX) 서비스들은 세션에러나도 SKIP 하도록 한다.
                // 세션복원은 업무용 서비스인 경우만 복원하고, 재조회 알림팝업을 띄우도록 한다.
                /*if (_tr_inf.RECV_SVC_C == "SSFI010401R01" || // 로그인정보 조회
                        _tr_inf.RECV_SVC_C == "SSFI020101R99" || // 공통코드 콤보적용 조회
                    TR_INF.getCellData(0, "RECV_SVC_C") == "SSFI010603R01" || // 즐겨찾기 조회(메인좌측)
                    TR_INF.getCellData(0, "RECV_SVC_C") == "SSFI010603R02" || // 즐겨찾기 여부조회(공통)
                    TR_INF.getCellData(0, "RECV_SVC_C") == "SSFI010603C01" || // 즐겨찾기 등록(공통)
                    TR_INF.getCellData(0, "RECV_SVC_C") == "SSFI010603D01" || // 즐겨찾기 삭제(공통)
                    TR_INF.getCellData(0, "RECV_SVC_C") == "SSFI010604R02" || // 최근화면이력 조회(메인좌측)
                    TR_INF.getCellData(0, "RECV_SVC_C") == "SSFI010604C01") { // 최근화면이력 등록
                    */
            	
            	
            	
                if (_tr_inf.RECV_SVC_C == ("SSFI010401R01" || "SSFI020101R99" || "SSFI010603R01" || "SSFI010603R02" || "SSFI010603C01" || "SSFI010603D01" || "SSFI010604R02" || "SSFI010604C01")) {
                	; // SKIP 처리
                }else if (_tr_inf.RECV_SVC_C == "SCommonComboR20"){
                	// 공통코드 변형 조회 SKIP 처리
                }else if (_tr_inf.RECV_SVC_C == "SCommonComboR22"){
                	// 지자체 코드 조회 SKIP 처리
                } else {
                	/*
                    if (com.getSlGmgoModlC() == "RPT") { // 세션복원기능을 사용하는 시스템 묘듈

                        //---------------------------------------------------------------------------------------------------------
                        // ※ 주의 : 이 곳은 개별 Submitdone으로 가는 중간 지점이다. 따라서, 이 곳에서 executeSubmission_dynamic을
                        //           호출할 경우 무한루프에 빠지게 된다. 따라서, setTimeout 0.5초후에 세션복원하도록 한다.
                        //---------------------------------------------------------------------------------------------------------

                        // 2018-10-18 : 문석길 : '세션복구거래구분' 0:준비, 1:복구시작, 2:복구완료, 9:복구에러
//                        console.log(com.getPrintTime()+"[common.js][gcm._sbm_defCallbackSubmission] (세션복원용) 원천서비스 = "+_tr_inf.RECV_SVC_C+", SESSION_RECOVERY_TR_G = "+gcm.SESSION_RECOVERY_TR_G+" (0:준비, 1:복구시작, 2:복구완료)");
                        if (gcm.SESSION_RECOVERY_TR_G == 0 || gcm.SESSION_RECOVERY_TR_G == 2) {

                            gcm.SESSION_RECOVERY_TR_G = 1; // 세션복구거래구분 0:준비, 1:복구시작, 2:복구완료, 9:복구에러

                            //debugger;
                            
                            var confirmMsg = "장시간 사용하지 않아 서버와의 연결이 끊어졌습니다."
                                           + "\n확인버튼을 누르면 다시 연결됩니다."
                                           + "\n※ 재연결 후 조회조건이 설정되지않는 등 화면이 비정상적으로"
                                           + "\n   동작하면 화면을 닫고 다시 화면을 열어서 사용하시기 바랍니다.";
                            if( confirm(confirmMsg) ) {
                                var timeoutResult = setTimeout(function() {
                                    
                                	//debugger;
                                	
                                	//---------------------------------------------------------------------------------------------------------
                                    // □ 재로그인 Datalist가 없을 경우 새로 생성한다.
                                    //---------------------------------------------------------------------------------------------------------
                                    if (typeof MSFI010401R01In_relogin == "undefined") {
                                        com.createDataObj("dataMap", "MSFI010401R01In_relogin" , [ "INQR_G", "SL_GMGO_MODL_C", "USER_ID", "USER_NM", "USER_U_C", "USER_RIGHT_G", "PADM_STD_ORG_C", "ORG_NM", "SL_GMGO_DEPT_C", "DEPT_NM", "BR_C", "BR_NM", "DISTG", "USER_RSA_SCNO", "SCNO_ERR_CNT" ]);
                                        com.createDataObj("dataMap", "MSFI010401R01Out_relogin", [ "SL_GMGO_MODL_C", "USER_ID", "USER_NM", "USER_U_C", "USER_RIGHT_G", "PADM_STD_ORG_C", "ORG_NM", "SL_GMGO_DEPT_C", "DEPT_NM",
                                                                                                   "BR_C", "BR_NM", "DISTG", "USER_RSA_SCNO", "SCNO_ERR_CNT", "USER_TELNO", "USER_EMAIL", "LST_LOGIN_DT", "EMAIL_INF_JEGONG_YN",
                                                                                                   "TEL_INF_JEGONG_YN", "PSN_INF_JEGONG_YN", "PSN_INF_JEGONG_DTTM", "SCNO_CDT", "SCNO_INITL_DT", "SCNO_INITL_SYS_YN", "TOT_CNT" ]);
                                        com.createDataObj("dataList", "MSFI010401R01OutList_relogin" , [ "USER_SPZ_C", "USER_SPZ_SCOP_C" ]);
                                    }

                                    //---------------------------------------------------------------------------------------------------------
                                    // □ 사용자정보조회 (SSFI010401R01)
                                    //---------------------------------------------------------------------------------------------------------
//                                    console.log(com.getPrintTime()+"[common.js][gcm._sbm_defCallbackSubmission] (세션복원용) 사용자정보조회 (SSFI010401R01) CALL!!! 원천서비스 = "+_tr_inf.RECV_SVC_C);

                                    MSFI010401R01In_relogin.setEmptyValue();
                                    MSFI010401R01Out_relogin.setEmptyValue();
                                    MSFI010401R01In_relogin.set("INQR_G"        , "2"                 ); // 조회구분 2:재로그인(세션복원용)
                                    MSFI010401R01In_relogin.set("SL_GMGO_MODL_C", com.getSlGmgoModlC()); // 서울시금고모듈코드
                                    MSFI010401R01In_relogin.set("USER_ID"       , com.getUserId()     ); // 사용자ID

                                    // 사용자명을 ""값으로 처리해서 사용자관리 TABLE을 다시 SELECT해서 세션정보를 복구하도록 하였음.
                                    MSFI010401R01In_relogin.set("USER_NM"       , ""                   ); // 사용자명

                                    // 출력메시지 : "현재 세션이 종료되었습니다만,", "<br>자동으로 세션을 복원하였으니, 재거래 하시길 바랍니다."
                                    MSFI010401R01In_relogin.set("ORG_NM"        , "출력메시지금지"     ); // 기관명

                                    var sbm_LOGIN_RECOVERY_Option = {
                                        mode : "asynchronous",   // asynchronous, synchronous
                                        id : "sbm_LOGIN_RECOVERY",
                                        ref : 'data:json,[MSFI010401R01In_relogin]',
                                        target : 'data:json,[{"id":"MSFI010401R01Out_relogin","key":"MSFI010401R01Out"}, {"id":"MSFI010401R01OutList_relogin","key":"MSFI010401R01OutList"}]',
                                        userData1 : [{svc_id:"SSFI010401R01", msg_id:"MSFI010401R01In_relogin", sbm_id:"sbm_LOGIN_RECOVERY", isshowMsg:false}]
                                    };

                                    sbm_LOGIN_RECOVERY_Option.submitDoneHandler = function(e) {
//                                        console.log(com.getPrintTime()+"[common.js][gcm._sbm_defCallbackSubmission] (세션복원용) 사용자정보조회 (SSFI010401R01) END !!! ==> 서버세션 복원됨.");
                                        
                                    	//debugger;
                                    	
                                    	gcm.SESSION_RECOVERY_TR_G = 2; // 세션복구거래구분 0:준비, 1:복구시작, 2:복구완료, 9:복구에러
                                    	
                                    	com.setSessionData("USER_INFO" , JSON.stringify(e.responseJSON.MSFI010401R01Out_relogin.getJSON())); // 로그인 정보 재삽입
                                    	
                                    };
                                    sbm_LOGIN_RECOVERY_Option.submitErrorHandler = function(e) {
//                                        console.log(com.getPrintTime()+"[common.js][gcm._sbm_defCallbackSubmission] (세션복원용) 사용자정보조회 (SSFI010401R01) ERROR !!! ==> LOGIN으로 처리합니다.");
                                        gcm.SESSION_RECOVERY_TR_G = 9; // 세션복구거래구분 0:준비, 1:복구시작, 2:복구완료, 9:복구에러
                                        
                                        //debugger;
                                        
                                        //com.removeSessionData("SL_GMGO_MODL_C"); // 서울시금고모듈코드
                                        //location.reload();
                                        com.removeSessionData("USER_NM"); // 사용자명
                                        com.removeSessionData("USER_INFO"); // 2018-10-18 : 문석길 : 사용자정보 전체 세션에서 삭제 추가
                                        var ss = gcm.mainFrame.getObj("scsObj");
                                        ss.onpageload();
                                    };
                                    gcm.IS_TR = true;
                                    
                                    //debugger;
                                    
                                    com.executeSubmission_dynamic(sbm_LOGIN_RECOVERY_Option);
                                }, {delay:500, key:"relogin_setTimeout"}); // setTimeout 0.5초후 기동함.
                                
                                console.log(timeoutResult);
                                
                            } else {
                                // confirm 취소 거래일 경우 정상로그아웃 처리한다.
                                var ss = gcm.mainHeaderMenu.getObj("scsObj");   // 메인헤더정보 선언
                                ss.btn_logout_onclick();                    // header.xml scsObj.btn_logout_onclick(); 이벤트 호출
                            }
                        }
                    } else {
                    	
                        if (gcm.CONFIRM_MSGBOX_YN != "X") {
                            gcm.CONFIRM_MSGBOX_YN = "X"; // 현재 Alert이 진행중이면, 다음 Alert을 띄우지 않도록 하기 위한 변수
                            var alertMsg = "현재 세션이 종료 되었습니다. 재로그인 하세요.";
                            alert(alertMsg);
                            var ss = gcm.mainHeaderMenu.getObj("scsObj");   // 메인헤더정보 선언
                            ss.btn_logout_onclick();                    // header.xml scsObj.btn_logout_onclick(); 이벤트 호출
                            gcm.CONFIRM_MSGBOX_YN = "";
                        }
                        
                    }
                    
                    */
                	 
                	
                	if (gcm.CONFIRM_MSGBOX_YN != "X") {
                        gcm.CONFIRM_MSGBOX_YN = "X"; // 현재 Alert이 진행중이면, 다음 Alert을 띄우지 않도록 하기 위한 변수
                        var alertMsg = "현재 세션이 종료 되었습니다. 재로그인 하세요.";
                        alert(alertMsg);
                        var ss = gcm.mainHeaderMenu.getObj("scsObj");   // 메인헤더정보 선언
                        ss.btn_logout_onclick();                    // header.xml scsObj.btn_logout_onclick(); 이벤트 호출
                        //gcm.CONFIRM_MSGBOX_YN = "";
                    }
                	 
                	
                	
                } // 즐겨찾기(SSFI010603XXX), 최근이력(SSFI010604XXX) 서비스 if문 끝.

            } else { // 에러메시지코드가 ESES0003, ECOMS90001 아닐 경우

                // 2018-12-19 : 동일한 ID의 레이어 팝업이 이미 있을 경우 기존 팝업을 close시키고 새로운 레이어 팝업을 띄운다.
                if (com.isEmpty($("#"+options.id))) {
                    // 나머지 에러메시지는 레이어팝업을 띄운다.
                    com.openPopup(layerPopupName, options, dataObject);
                } else {
//                    console.log(com.getPrintTime()+"[common.js][gcm._sbm_defCallbackSubmission] 기존 팝업이 존재하므로 종료후 새로운 팝업을 띄웁니다.");
                    var comp = $p.comp[$("#"+options.id)[0].id];
                    comp.close();

                    // 나머지 에러메시지는 레이어팝업을 띄운다.
                    setTimeout(function(){com.openPopup(layerPopupName, options, dataObject);}, 100);
                }
            }
        } // 에러메시지일 경우 if문 끝.
    }
};

/**
 * submission중 에러가 발생한 경우 호출되는 함수 - 서버 오류(500 error)
 *
 * @date 2016.11.15
 * @private
 * @param {Object}
 *            resObj responseData 객체
 * @memberOf gcm
 * @author InswaveSystems
 */
gcm._sbm_errorHandler = function(resObj) {
    return false;
    var _this = gcm._getScope(resObj.id).com;

    var detailStr = "HTTP STATUS INFO";
    detailStr += resObj.responseReasonPhrase;
    detailStr += " ";
    detailStr += resObj.responseStatusCode;
    detailStr += "URI:";
    detailStr += resObj.resourceUri;
    detailStr += resObj.responseBody;

    var msgObj = {
        statusCode : "E",
        errorCode : "E9998",
        message : "서버 오류입니다. 자세한 내용은 관리자에게 문의하시기 바랍니다.",
        messageDetail : detailStr
    };

    _this.resultMsg(msgObj);
};

gcm._errorHandler = function(resObj) {

    // 2018-08-23 : 거래유형이 정상('0')이 아닐 경우 submitdone을 수행하지 않는다.
    var e = resObj;
    if(!com.isEmpty(e.TR_INF)&&!com.isEmpty(e.TR_INF[0])){
        if(e.TR_INF[0].RST_U != "0"){
            return true;
        }
    }

    return false;
};



/**
 * 다국어 처리함수
 *
 * @date 2016.08.02
 * @private
 * @param {String}
 *            xmlUrl 전체 URL중 w2xPath이하의 경로
 * @memberOf gcm
 * @author InswaveSystems
 * @example com.getI18NUrl( "/ui/DEV/result.xml" ); //return
 *          예시)"/websquare/I18N?w2xPath=/ui/DEV/result.xml" gcm._getI18NUrl(
 *          "/ui/SW/request.xml" ); //return
 *          예시)"/websquare/I18N?w2xPath=/ui/SW/request.xml"
 */
gcm._getI18NUrl = function(xmlUrl) {
    var baseURL = gcm.CONTEXT_PATH + "/I18N"; // org"/websquare/engine/servlet/I18N.jsp?w2xPath=";
    var rsURL;
    var locale = WebSquare.cookie.getCookie("locale");
    var bXml = "/blank.xml";
    xmlUrl = xmlUrl.replace(/\?.*/, '');
    xmlUrl = xmlUrl.replace(gcm.CONTEXT_PATH, '');

    // 엔진 버그로 인해 WebSquare.baseURI를 붙이지 않고 피일을 호출하여 404 error 처리 로직.
    if (xmlUrl.search(bXml) > -1 && xmlUrl.search(WebSquare.baseURI) == -1) {
        xmlUrl = WebSquare.baseURI + "/blank.xml";
    }
    rsURL = baseURL + "?w2xPath=" + xmlUrl;

    if (locale != null && locale != '') {
        rsURL = rsURL + "&locale=" + unescape(locale);
    }

    return rsURL;
};

/**
 * 컴포넌트가 속한 Scope을 반환한다.
 *
 * @date 2018.06.11
 * @private
 * @param {Object}
 *            컴포넌트 객체 또는 아이디(WFrame Scope 경로를 포함한 Full Path Id)
 * @memberOf gcm
 * @author InswaveSystems
 * @example var _this = gcm._getScopeCom(dlt_commonCode); _this.alert("데이터 처리가
 *          완료 되었습니다.");
 */
gcm._getScope = function(comObj) {
    if (typeof comObj === "string") {
        var _comObj = $p.getComponentById(comObj);
        if (_comObj !== null) {
            return _comObj.getScopeWindow();
        }
    } else {
        return comObj.getScopeWindow();
    }
};

/**
 * @file 각 Scope별로 공유되는 Scope 전역 변수와 공통 함수를 정의한다.
 * @version 3.0
 * @author InswaveSystems
 */

 /**
 * @type com
 * @class com
 * @namespace com
 */

var com = {

    MESSAGE_BOX_SEQ : 1 // Message Box ID 생성을 위한 순번
    ,SCR_ID : "" // 현재 스크린 ID
};

/**
 * 팝업 공통 처리 함수
 */
com.popup = com.popup || {};

// 전체화면 사용
com.FULL_COVER = false;
com.USE_IFRAME = false;

/**
 * Object 의 빈값 여부를 반환 한다. null, undefined, '', {}, [] 일때 true
 *
 * @memberOf com
 * @param {Object:Y}
 *            obj
 * @return {boolean}
 * @example com.isEmpty({"foo":"bar"});
 */
com.isEmpty = function(obj) {

    if (obj == null || typeof obj == "undefined")
        return true;
    if (typeof obj === 'number' || typeof obj === 'boolean')
        return false;
    if (obj === '')
        return true;
    if (WebSquare.util.isArray(obj) && obj.length == 0)
        return true;
    if (obj == "{}")
        return true;

    return $.isEmptyObject(obj);
};


/**
 * GridView의 행을 Remove한다.
 *
 * @date 2018.01.11
 * @memberOf com
 * @param {Object}
 *            gridViewObj GridView 객체
 * @example // GridView의 행 삭제를 위한 checkBox 컬럼의 아이디를 "chkStatus"로 하고 값은 1:
 *          checked, 0: unchecked로 설정해야 한다. com.removeGridView(grdCodeGrp);
 */
com.removeGridView = function(gridViewObj) {
    try {
        if ((typeof gridViewObj === "object") && (gridViewObj !== "")) {

            var dltObj = this.getGridViewDataList(gridViewObj);

            if (dltObj === null) {
                return;
            }

            var checkedIdxArr = dltObj.getMatchedIndex("CHK", "1", true, 0, dltObj.getRowCount());

            if (checkedIdxArr.length > 0) {
                for (var i = (checkedIdxArr.length - 1); i >= 0; i--) {
                    dltObj.removeRow(checkedIdxArr[i]);
                }
            } else {
                var focusedRowIdx = gridViewObj.getFocusedRowIndex();
                dltObj.removeRow(checkedIdxArr[focusedRowIdx]);
            }
        }
    } catch (e) {
        //m_        console.log("[com.removeGridView] Exception :: " + e.message);
    } finally {
        dltObj = null;
    }
};

/**
 * GridView의 행을 Delete한다.
 *
 * @date 2018.02.05
 * @memberOf com
 * @param {Object}
 *            gridViewObj GridView 객체
 * @example // GridView의 행 삭제를 위한 checkBox 컬럼의 아이디를 "chkStatus"로 하고 값은 1:
 *          checked, 0: unchecked로 설정해야 한다. com.deleteGridView(grdCodeGrp);
 */
com.deleteGridView = function(gridViewObj) {
    try {
        if ((typeof gridViewObj === "object") && (gridViewObj !== "")) {

            var dltObj = this.getGridViewDataList(gridViewObj);

            if (dltObj === null) {
                return;
            }

            var checkedIdxArr = dltObj.getMatchedIndex("CHK", "1", true, 0,
                    dltObj.getRowCount());

            if (checkedIdxArr.length > 0) {
                for (var i = (checkedIdxArr.length - 1); i >= 0; i--) {
                    dltObj.deleteRow(checkedIdxArr[i]);
                }
            } else {
                var focusedRowIdx = gridViewObj.getFocusedRowIndex();
                dltObj.deleteRow(checkedIdxArr[focusedRowIdx]);
            }
        }
    } catch (e) {
        //m_        console.log("[com.deleteGridView] Exception :: " + e.message);
    } finally {
        dltObj = null;
    }
};

/**
 * dataList를 동적으로 생성하기 위한 옵션 정보를 반환한다.
 *
 * @date 2018.01.11
 * @private
 * @param {Object}
 *            infoArr 생성할 DataList의 옵션 정보
 * @memberOf com
 * @author InswaveSystems
 * @example com._getCodeDataListOptions([ "GRP_CD", "COM_CD", "CODE_NM" ]);
 */
com._getCodeDataListOptions = function(infoArr) {
    var option = {
        "type" : "dataList",
        "option" : {
            "baseNode" : "list",
            "repeatNode" : "map"
        },
        "columnInfo" : []
    };

    for ( var idx in infoArr) {
        option.columnInfo.push({
            "id" : infoArr[idx]
        });
    }
    return option;
};

/**
 * GridView와 바인딩된 DataList 객체를 반환한다.
 *
 * @date 2018.01.11
 * @param {Object}
 *            gridViewObj 바인딩 된 DataList가 존재하는지 검증할 GridView 객체
 * @memberOf com
 * @author InswaveSystems
 * @return {Object} 바인딩 된 DataList 객체 반환 (바인된 객체가 없을 경우 null 반환)
 * @example // 바인딩 되어있는 경우 com.getGridViewDataList(grd_First); // return 예시)
 *          "dlt_First"
 *  // 바인딩 되어있지 않은 경우 com.getGridViewDataList(grd_First); // return 예시)
 * undefined
 */
com.getGridViewDataList = function(gridViewObj) {
    var dataListId = gridViewObj.getDataList();

    if (dataListId !== "") {
        var dataList = WebSquare.util.getComponentById(dataListId);
        if ((typeof dataList === "undefined") || (dataList === null)) {
            //m_            console.log("DataList(" + dataListId + ")를 찾을 수 없습니다.");
            return null;
        } else {
            return dataList;
        }
    } else {
        //m_        console.log(gridViewObj.getID() + "는 DataList가 세팅되어 있지 않습니다.");
        return null;
    }
};

/**
 * 특정 컴포넌트에 바인된 DataList나 DataMap의 컬럼 이름을 반환한다.
 *
 * @date 2018.01.15
 * @memberOf com
 * @param {Object}
 *            comObj 컴포넌트 객체
 * @return {String} 컬럼명
 */
com.getColumnName = function(comObj) {
    try {
        if ((typeof comObj.getRef) === "function") {
            var ref = comObj.getRef();
            var refArray = ref.substring(5).split(".");
            var dataCollectionName = refArray[0];
            var columnId = refArray[1];

            if ((typeof refArray !== "undefined") && (refArray.length === 2)) {
                var scsObj = comObj.getScopeWindow().scsObj;
                var dataCollection = scsObj.$p
                        .getComponentById(dataCollectionName);
                var dataType = dataCollection.getObjectType().toLowerCase();
                if (dataType === "datamap") {
                    return dataCollection.getName(columnId);
                } else if (dataType === 'datalist') {
                    return dataCollection.getColumnName(columnId);
                }
            } else {
                return "";
            }
        }
    } catch (e) {
        //m_        console.log("[com.getColumnName] Exception :: " + e.message);
    } finally {
        dataCollection = null;
    }
};

/**
 * 특정 컴포넌트에 바인된 DataList나 DataMap의 정보를 반환한다.
 *
 * @date 2018.01.15
 * @memberOf com
 * @param {Object}
 *            comObj callerObj 컴포넌트 객체
 * @returns {Object} dataCollection정보
 */
com.getDataCollection = function(comObj) {
    try {
        if ((typeof comObj !== "undefined")
                && (typeof comObj.getRef === "function")) {
            var ref = comObj.options.ref;
            if ((typeof ref !== "undefined") && (ref !== "")) {
                var refArray = ref.substring(5).split(".");
                if ((typeof refArray !== "undefined")
                        && (refArray.length === 2)) {
                    var dataObjInfo = {};
                    dataObjInfo.runtimeDataCollectionId = comObj.getScope().id
                            + "_" + refArray[0];
                    dataObjInfo.dataColletionId = refArray[0];
                    dataObjInfo.columnId = refArray[1];
                    return dataObjInfo;
                } else {
                    return null;
                }
            } else {
                return null;
            }
        }
    } catch (e) {
        //m_        console.log(com.getPrintTime()+"[common.js][com.getDataCollection] Exception :: " + e.message);
    } finally {
        dataCollection = null;
    }
};

/**
 * 문자열 왼쪽에 일정길이(maxLen) 만큼 '0'으로 채우기
 *
 * @date 2014.12.10
 * @param {String}
 *            str 포멧터를 적용할 문자열
 * @param {Number}
 *            maxLen 0 으로 채울 길이
 * @memberOf com
 * @author InswaveSystems
 * @return {String} 일정길이 만큼 0 으로 채워진 문자열
 * @example com.fillZero("24", 4); // return 예시) "0024"
 *
 * com.fillZero("11321", 8); // return 예시) "00011321"
 */
com.fillZero = function(str, maxLen) {
    var len = str;
    var zero = "";

    if (typeof str == 'number')
        len = '' + str;

    if (len.length < maxLen) {
        for (var i = len.length; i < maxLen; i++) {
            zero += "0";
        }
    }
    return (zero + '' + str);
};

/**
 * JSON Object로 변환해서 반환한다.
 *
 * @date 2014.12.09
 * @param {String}
 *            str JSON 문자열
 * @memberOf com
 * @author InswaveSystems
 * @return {Object} JSON 객체 or null
 * @example // 유효하지 않은 JSON 문자열 일 경우 com.getJSON(""); // return 예시) null
 *  // 유효한 JSON 문자열 var json =
 * '{"tbx_sPrjNm":"1","tbx_sPrtLv":"2","tbx_sReqLv":"3"}'; com.getJSON(json); //
 * return 예시) {tbx_sPrjNm: "1", tbx_sPrtLv: "2", tbx_sReqLv: "3"}
 */
com.getJSON = function(str) {
    try {
        return JSON.parse(str);
    } catch (e) {
        return str;
    }
};

/**
 * XML, JSON 객체를 String 타입으로 반환한다.
 *
 * @date 2014.12.09
 * @param {Object}
 *            object String으로 변환할 JSON 객체
 * @memberOf com
 * @author InswaveSystems
 * @return {String} String으로 변환된 객체
 */
com.strSerialize = function(object) {
    if (typeof object == 'string') {
        return object;
    } else if (this.isJSON(object)) {
        return JSON.stringify(object);
    } else if (this.isXmlDoc(object)) {
        return WebSquare.xml.serialize(object);
    } else {
        return object;
    }
};

/**
 * JSON Object인지 여부를 검사한다.
 *
 * @date 2014.12.09
 * @param {Object}
 *            jsonObj JSON Object가 맞는지 검사할 JSON Object
 * @memberOf com
 * @author InswaveSystems
 * @return {Boolean} true or false
 * @example com.isJSON(""); // return 예시) false com.isJSON( {"tbx_sPrjNm": "1",
 *          "tbx_sPrtLv": "2", "tbx_sReqLv": "3"} ); // return 예시) true
 */
com.isJSON = function(jsonObj) {
    if (typeof jsonObj !== 'object')
        return false;
    try {
        JSON.stringify(jsonObj);
        return true;
    } catch (e) {
        return false;
    }
};

/**
 * XML Document 객체인지 여부를 검사한다.
 *
 * @date 2014.12.09
 * @memberOf com
 * @param {Object}
 *            data XML Document 객체인지 여부를 검사한다.
 * @author InswaveSystems
 * @return {Boolean} true or false
 */
com.isXmlDoc = function(data) {
    if (typeof data != 'object')
        return false;
    if ((typeof data.documentElement != 'undefined' && data.nodeType == 9)
            || (typeof data.documentElement == 'undefined' && data.nodeType == 1)) {
        return true;
    }
    return false;
};

/**
 * 객체의 typeof 값을 반환하며 typeof의 값이 object인 경우 array, json, xml, null로 체크하여 반환한다.
 *
 * @date 2016.12.20
 * @param {Object}
 *            obj type을 반환 받을 객체(string,boolean,number,object 등)
 * @author InswaveSystems
 * @return {String} 객체의 타입으로 typeof가 object인 경우 array, json, xml, null로 세분화하여
 *         반환한다. 그외 object타입이 아닌경우 원래의 type(string,boolean,number 등)을 반환한다.
 * @example com.getObjectType("WebSquare"); // return 예시) "string"
 *          com.getObjectType({"name":"WebSquare"}); // return 예시) "json"
 *          com.getObjectType(["1","2"]); // return 예시) "array"
 */
com.getObjectType = function(obj) {
    var objType = typeof obj;
    if (objType !== 'object') {
        return objType;
    } else if (obj.constructor === {}.constructor) {
        return 'json';
    } else if (obj.constructor === [].constructor) {
        return 'array';
    } else if (obj === null) {
        return 'null';
    } else {
        var tmpDoc = WebSquare.xml.parse("<data></data>");
        if (obj.constructor === tmpDoc.constructor
                || obj.constructor === tmpDoc.firstElementChild.constructor) {
            return 'xml';
        } else {
            return objType;
        }
    }
};

/**
 * 코드그룹 하위(코드)의 공통코드를 조회한다.
 *
 * @date 2016.11.15
 * @private
 * @param {String}
 *            actionUrl 요청 URL
 * @param {String}
 *            reqData 보낼 데이터(String or JSON)
 * @param {Object}
 *            callbackFn Default 콜백 함수명
 * @param {Object}
 *            errorFn Error 콜백 함수명
 * @param {Boolean}
 *            autoSetBoolean true or false (true일 경우 $p.data.set실행)
 * @param {Object}
 *            userCallbackFunc 콜백 함수명
 * @memberOf com
 * @author InswaveSystems
 */
com.send = function(actionUrl, reqData, callbackFn, errorFn, autoSetBoolean,
        userCallbackFunc) {
    reqData = reqData || "";
    autoSetBoolean = autoSetBoolean || true;

    var sendOpt = {};
    sendOpt.action = actionUrl;
    sendOpt.mediatype = "application/json";
    sendOpt.method = "post";
    sendOpt.type = "json";
    sendOpt.requestHeader = {
        insUserData : "commonCode"
    };
    sendOpt.beforeAjax = function(e) {
        try {
            sendOpt.requestData = typeof reqData === "string" ? reqData : JSON
                    .stringify(reqData);
        } catch (ex) {
            this.alert("[common.js][com.send] JSON 데이터 및 JSON string 데이터만 전송 가능합니다.");
            return false;
        }
        return true;
    };

    sendOpt.success = function(e) {
        //m_        console.log("======================================================");
        //m_        console.log("success requestData:::::::::::");
        //m_        console.log(e.responseText);
        //m_        console.log("======================================================");

        if (autoSetBoolean == true) {
            this.$p.data.set("JSON", e.responseJSON);
        }

        if (typeof callbackFn == "function") {
            callbackFn(e.responseJSON, e);
        }

        if (typeof userCallbackFunc == "function") {
            userCallbackFunc();
        }
    };

    sendOpt.error = function(e) {
        if (typeof errorFn == "function") {
            errorFn(e.responseJSON, e);
        }
        this.alert("[common.js][com.send] error\n" + "errorType:" + e.errorType + "\n"
                + "statusCode:" + e.responseStatusCode);
      //m_        console.log("======================================================");
      //m_        console.log("error requestData:::::::::::");
      //m_        console.log(e.responseText);
      //m_        console.log("======================================================");
    };

    this.$p.ajax(sendOpt);
};

/**
 * Submission를 실행합니다.
 *
 * @date 2017.01.19
 * @param {Object}
 *            options com.createSubmission의 options 참고
 * @param {Object}
 *            requestData 요청 데이터
 * @param {Object}
 *            obj 전송중 disable시킬 컴퍼넌트
 * @memberOf com
 * @author InswaveSystems
 * @example var searchCodeGrpOption = { id : "sbm_SearchCodeGrp", action :
 *          "serviceId=CD0001&action=R", target :
 *          'data:json,{"id":"dlt_CodeGrp","key":"data"}', submitDoneHandler :
 *          scsObj.searchCodeGrpCallback, isShowMeg : false };
 *          com.executeSubmission_dynamic(searchCodeGrpOption);
 */
com.executeSubmission_dynamic = function(options, requestData, obj) {

    var now = this.$p || $p;

    var submissionObj = now.getSubmission(options.id);

    if (submissionObj === null) {
        this.createSubmission(options);
        submissionObj = now.getSubmission(options.id);
    } else {
        now.deleteSubmission(options.id);
        this.createSubmission(options);
        submissionObj = now.getSubmission(options.id);
    }

    this.executeSubmission(submissionObj, requestData, obj);
};

/**
 * Submission 객체를 동적으로 생성한다.
 *
 * @date 2017.11.30
 * @param {Object}
 *            options Submission 생성 옵션 JSON 객체
 * @param {String}
 *            options.id submission 객체의 ID. 통신 모듈 실행 시 필요.
 * @param {String}
 *            options.ref 서버로 보낼(request) DataCollection의 조건 표현식.(조건에 때라 표현식이
 *            복잡하다) 또는 Instance Data의 XPath.
 * @param {String}
 *            options.target 서버로 응답(response) 받은 데이터가 위치 할 DataCollection의 조건
 *            표현식. 또는 Instance Data의 XPath.
 * @param {String}
 *            options.action 통신 할 서버 측 URI.(브라우저 보안 정책으로 crossDomain은 지원되지 않는다.)
 * @param {String}
 *            options.method [default: get, post, urlencoded-post] - get : 파라메타를
 *            url에 붙이는 방식 (HTML과 동일). - post : 파라메타를 body 구간에 담는 방식 (HTML과 동일) -
 *            urlencoded-post : urlencoded-post.
 * @param {String}
 *            options.mediatype [default: application/xml, text/xml,
 *            application/json, application/x-www-form-urlencoded]
 *            application/x-www-form-urlencoded 웹 form 방식(HTML방식).
 *            application/json : json 방식. application/xml : XML 방식. text/xml :
 *            xml방식 (두 개 차이는 http://stackoverflow._com/questions/4832357 참조)
 * @param {String}
 *            options.mode [default: synchronous, synchronous] 서버와의 통신 방식.
 *            asynchronous:비동기식. synchronous:동기식
 * @param {String}
 *            options.encoding [default: utf-8, euc-kr, utf-16] 서버 측 encoding 타입
 *            설정 (euc-kr/utf-16/utf-8)
 * @param {String}
 *            options.replace [default: none, all, instance] action으로부터 받은
 *            response data를 적용 구분 값. - all : 문서 전체를 서버로부터 온 응답데이터로 교체. -
 *            instance : 해당되는 데이터 구간. - none : 교체안함.
 * @param {String}
 *            options.processMsg submission 통신 중 보여줄 메세지.
 * @param {String}
 *            options.errorHandler submission오류 발생 시 실행 할 함수명.
 * @param {String}
 *            options.customHandler submssion호출 시 실행 할 함수명.
 * @param {requestCallback}
 *            options.submitHandler {script type="javascript"
 *            ev:event="xforms-submit"} 에 대응하는 함수.
 * @param {requestCallback}
 *            options.submitDoneHandler {script type="javascript"
 *            ev:event="xforms-submit-done"} 에 대응하는 함수
 * @param {requestCallback}
 *            options.submitErrorHandler {script type="javascript"
 *            ev:event="xforms-submit-error"} 에 대응하는 함수
 * @memberOf com
 * @author InswaveSystems
 * @example com.createSubmission(options);
 */
com.createSubmission = function(options) {
    var now = this.$p || $p;

    var ref = options.ref || "";
    var target = options.target || "";
    var action = gcm.CONTEXT_PATH + gcm.SERVICE_URL + options.action; // ajax
                                                                        // 요청주소
    var mode = options.mode || gcm.DEFAULT_OPTIONS_MODE; // asynchronous(default)/synchronous
    var mediatype = options.mediatype || gcm.DEFAULT_OPTIONS_MEDIATYPE; // application/x-www-form-urlencoded
    var method = (options.method || "post").toLowerCase(); // get/post/put/delete
    var processMsg = options.processMsg || "";
    var instance = options.instance || "none";

    var submitHandler = (typeof options.submitHandler === "function") ? options.submitHandler
            : ((typeof options.submitHandler === "string") ? now.id
                    + options.submitHandler : "");
    var submitDoneHandler = (typeof options.submitDoneHandler === "function") ? options.submitDoneHandler
            : ((typeof options.submitDoneHandler === "string") ? now.id
                    + options.submitDoneHandler : "");
    var submitErrorHandler = (typeof options.submitErrorHandler === "function") ? options.submitErrorHandler
            : ((typeof options.submitErrorHandler === "string") ? now.id
                    + options.submitErrorHandler : "");

    var isShowMeg = false;
    //var resJson = null; // 2018-10-16 : 문석길 : 미사용하므로 주석처리함.

    if ((options.isProcessMsg === true) && (processMsg === "")) {
        processMsg = "해당 작업을 처리중입니다";
    }

// 2018-10-18 isshowMsg 테스트용 log
//console.log(com.getPrintTime()+"[common.js][com.createSubmission] userData1 svc_id ["+options.userData1[0].svc_id+"] sbm_id ["+options.userData1[0].sbm_id+"] isshowMsg ["+options.userData1[0].isshowMsg+"]");

    if (! options.userData1[0].isshowMsg){
        processMsg = "$blank";
    }


    if (typeof options.isShowMeg !== "undefined") {
        isShowMeg = options.isShowMeg;
    }

    var submissionObj = {
        "id" : options.id, // submission 객체의 ID. 통신 모듈 실행 시 필요.
        "ref" : ref, // 서버로 보낼(request) DataCollection의 조건 표현식.(조건에 때라 표현식이
                        // 복잡하다) 또는 Instance Data의 XPath.
        "target" : target, // 서버로 응답(response) 받은 데이터가 위치 할 DataCollection의 조건
                            // 표현식. 또는 Instance Data의 XPath.
        "action" : action, // 통신 할 서버 측 URI.(브라우저 보안 정책으로 crossDomain은 지원되지
                            // 않는다.)
        "method" : method, // [default: post, get, urlencoded-post] get:파라메타를
                            // url에 붙이는 방식 (HTML과 동일).
        // post:파라메타를 body 구간에 담는 방식 (HTML과 동일).
        // urlencoded-post:urlencoded-post.
        "mediatype" : mediatype, // application/json
        "encoding" : "UTF-8", // [default: utf-8, euc-kr, utf-16] 서버 측
                                // encoding 타입 설정 (euc-kr/utf-16/utf-8)
        "mode" : mode, // [default: synchronous, synchronous] 서버와의 통신 방식.
                        // asynchronous:비동기식. synchronous:동기식
        "processMsg" : processMsg, // submission 통신 중 보여줄 메세지.
        "submitHandler" : submitHandler,
        "submitDoneHandler" : submitDoneHandler,
        "submitErrorHandler" : submitErrorHandler,
        "userData1" : options.userData1
    // 사용자 정의 데이터 추가
    };

    now.createSubmission(submissionObj);
};

/**
 * 서버 통신 확장 모듈, Submission를 실행합니다.
 *
 * @date 2017.11.30
 * @param {Object}
 *            sbmObj submission 객체
 * @param {Object}
 *            requestData [Default : null, JSON, XML] 요청 데이터로 submission에 등록된
 *            ref를 무시하고 현재의 값이 할당된다.
 * @param {Object}
 *            compObj [Default : null] 전송중 disable시킬 컴퍼넌트
 * @memberOf com
 * @author InswaveSystems
 * @example // Submission ID : sbm_init 존재할 경우 com.executeSubmission(sbm_Init); //
 *          return 예시) sbm_init 통신 실행
 *  // Submission ID : sbm_init 존재하지 않을 경우
 * com.executeSubmission(sbm_Init); // return 예시) alert - submission
 * 객체[sbm_init]가 존재하지 않습니다.
 */
com.executeSubmission = function(sbmObj, requestData, compObj) {

    var now = this.$p || $p;
    if (sbmObj.action.indexOf(gcm.CONTEXT_PATH) < -1) {
        sbmObj.action = gcm.CONTEXT_PATH + sbmObj.action;
    }
    now.executeSubmission(sbmObj, requestData, compObj);
};

/**
 * 서버에서 전송한 통신 결과 코드를 반환한다. 화면에 정의한 submission의 submitdone이벤트에서 호출하여 사용한다.
 *
 * @date 2016.07.29
 * @param {Object}
 *            e submission 후 callback의 상태값
 * @memberOf com
 * @author InswaveSystems
 * @return {String} 상태 코드
 * @example // 통신결과 코드가 있을 경우 com.getResultCode(e); // return 예시) E || S || W
 *  // 통신결과 코드가 없을 경우 com.getResultCode(e); // return 예시) 웹스퀘어5 로그창 -
 * 결과 상태 메세지가 없습니다.: com.getResultCode
 */
com.getResultCode = function(e) {
    var rsCode = this.STATUS_ERROR;
    try {
        rsCode = e.responseJSON.rsMsg.statusCode;
    } catch (ex) {
        //m_        console.log("결과 상태 메세지가 없습니다.: com.getResultCode");
    }

    return rsCode;
};

/**
 * 현재 화면의 웹스퀘어 page 경로를 반환한다.
 *
 * @date 2016.07.19
 * @memberOf com
 * @author InswaveSystems
 * @return {String} 현재 페이지의 경로
 * @example com.getPageUrl(); // return 예시) "/ui/BM/BM001M01.xml"
 */
com.getPageUrl = function() {
    var pArr = document.location.href.split("w2xPath=");
    var oArr = pArr[1].split("&");
    return oArr[0];
};

/**
 * DataCollection 객체의 변경된 데이터가 있는지 검사한다.
 *
 * @date 2018.01.16
 * @memberOf com
 * @param {Object}
 *            dcObjArr DataCollection 또는 배열
 * @author InswaveSystems
 * @returns {Boolean} 검사결과 (true or false)
 */
com.checkModified = function(dcObjArr) {
    if (this.getObjectType(dcObjArr) === "array") {
        for ( var dcObj in dcObjArr) {
            if (this.getObjectType(dcObj) === "object") {
                if (checkModfied(dcObj) === false) {
                    return false;
                }
            }
        }
    } else if (this.getObjectType(dcObjArr) === "object") {
        return checkModfied(dcObj);
    }

    return true;

    function checkModfied(dcObj) {
        if ((typeof dcObj !== "undefined") && (typeof dcObj !== null)) {
            var modifiedIndex = dcObj.getModifiedIndex();
            if (modifiedIndex.length === 0) {
                this.alert("[common.js][com.checkModified] 변경된 데이터가 없습니다.");
                return false;
            } else {
                return true;
            }
        } else {
            return true;
        }
    }
};

/**
 * 주민번호 문자열에 Formatter(######-#######)를 적용하여 반환한다.
 *
 * @date 2016.08.02
 * @param {String}
 *            str 주민번호 문자열
 * @memberOf com
 * @author InswaveSystems
 * @return {String} 포멧터가 적용된 주민번호 문자열
 * @example com.transIdNum("1234561234567"); // return 예시) "123456-1234567"
 */
com.transIdNum = function(str) {
    var front = String(str).substr(0, 6);
    var back = String(str).substr(6, 7);
    var output = front + "-" + back;

    return output;
};

/**
 * 전화번호, setDisplayFormat("###-####-####") - 입력된 str에 포메터를 적용하여 반환한다.
 *
 * @date 2016.08.02
 * @param {String}
 *            str 포멧터를 적용할 문자열
 * @memberOf com
 * @author InswaveSystems
 * @return {String} 포멧터가 적용된 문자열
 * @example com.transPhone("0212345678"); // return 예시) "02-1234-5678"
 *          com.transPhone("021234567"); // return 예시) "02-123-4567"
 *          com.transPhone("03112345678"); // return 예시) "031-1234-5678"
 *          com.transPhone("0311234567"); // return 예시) "031-123-4567"
 */
com.transPhone = function(str) {
    return str.replace(
            /^(01[016789]{1}|02|0[3-9]{1}[0-9]{1})-?([0-9]{3,4})-?([0-9]{4})$/,
            "$1-$2-$3");
};

/**
 * 시간 - 입력된 String 또는 Number에 포메터를 적용하여 반환한다.
 *
 * @date 2016.08.02
 * @param {String}
 *            value 시간 Formatter를 적용한 값 (String 또는 Number 타입 지원)
 * @memberOf com
 * @author InswaveSystems
 * @return {String} 포멧터가 적용된 문자열
 * @example com.transTime("123402"); // return 예시) "12:34:02"
 */
com.transTime = function(value) {
    var hour = String(value).substr(0, 2);
    var minute = String(value).substr(2, 2);
    var second = String(value).substr(4, 2);
    var output = hour + ":" + minute + ":" + second;

    return output;
};

/**
 * 소수점 2자리에서 반올림 처리를 한다.
 *
 * @date 2016.08.02
 * @param {String}
 *            value 소수점 2자리 반올림 처리를 할 값 (String 또는 Number 타입 지원)
 * @memberOf com
 * @author InswaveSystems
 * @return {String} 소숫점 2자리 반올림 처리를 한 숫자 값
 * @example com.transRound( "23.4567" ); // return 예시) "23.46"
 */
com.transRound = function(value) {
    return Math.round(Number(value) * 100) / 100;
};

/**
 * 소수점 2자리에서 내림 처리를 한다.
 *
 * @date 2016.08.02
 * @param {String}
 *            value 소수점 2자리 내림 처리를 할 값 (String 또는 Number 타입 지원)
 * @memberOf com
 * @author InswaveSystems
 * @return {Number} 소숫점 2자리 내림 처리를 한 숫자 값
 * @example com.transFloor(23.4567); // return 예시) 23.45
 */
com.transFloor = function(value) {
    return Math.floor(Number(str) * value) / 100;
};

/**
 * 소수점 2자리에서 반올림 후 퍼센트(%)를 붙여서 반환한다.
 *
 * @date 2016.08.02
 * @param {String}
 *            value Percent(%) 포맷터를 적용할 값 (String 또는 Number 타입 지원)
 * @param {String}
 *            type 적용할 포멧터 형식
 * @memberOf com
 * @author InswaveSystems
 * @return {String} 포멧터가 적용된 문자열
 * @example com.transCeil(23.4567); // return 예시) 23.46 com.transCeil(78.567,
 *          "percent"); // return 예시) 78.57%
 */
com.transCeil = function(value, type) {
    var output = "";
    if (type == "percent") {
        output = Math.ceil(Number(value) * 100) / 100 + "%";
    } else {
        output = Math.ceil(Number(value) * 100) / 100;
    }
    return output;
};

/**
 * ex)세번째자리마다 콤마 표시, 금액, setDisplayFormat("#,###&#46##0", "fn_userFormatter2") -
 * 입력된 str에 포메터를 적용하여 반환한다.
 * <p>
 *
 * @date 2016.08.02
 * @param {String}
 *            value String or Number 포멧터를 적용할 값 (String 또는 Number 타입 지원)
 * @param {String}
 *            type 적용할 포멧터 형식(Default:null,dollar,plusZero,won)
 * @memberOf com
 * @author InswaveSystems
 * @return {String} 포멧터가 적용된 문자열
 * @example com.transComma("12345"); // return 예시) 12,345
 *          com.transComma("12345", "dollar"); // return 예시) $12,345
 *          com.transComma("12345", "plusZero"); // return 예시) 123,450
 *          com.transComma("12345", "won"); // return 예시) 12,345원
 */
com.transComma = function(value, type) {
    var amount;

    if (type == "plusZero") {
        amount = new String(value) + "0";
    } else {
        amount = new String(value);
    }

    amount = amount.split(".");

    var amount1 = amount[0].split("").reverse();
    var amount2 = amount[1];

    var output = "";
    for (var i = 0; i <= amount1.length - 1; i++) {
        output = amount1[i] + output;
        if ((i + 1) % 3 == 0 && (amount1.length - 1) !== i)
            output = ',' + output;
    }

    if (type == "dollar") {
        if (!amount2) {
            output = "$ " + output;
        } else {
            output = "$ " + output + "." + amount2;
        }
    } else if (type == "won") {
        if (!amount2) {
            output = output + "원";
        } else {
            output = output + "." + amount2 + "원";
        }
    } else {
        if (!amount2) {
            //output = output;
        } else {
            output = output + "." + amount2;
        }
    }

    return output;
};

/**
 * 금액 콤마 삽입(3자리마다 콤마를 삽입 한다.)
 *
 * @memberOf com
 * @param <String:Y>
 *            sValue
 * @param <boolean:N>
 *            isAbs 음수 사용 여부.
 * @return {String}
 * @example com.formatComma("-123456789","false");
 */
com.formatComma = function(sValue, isAbs) {
    if (com.isEmpty(sValue))
        return "";
    var parts = sValue.toString().split(".");
    var regStr = com.getBoolean(isAbs) ? /[^0-9]+/ : /[^-0-9]+/;
    parts[0] = (parseInt(parts[0], 10) + "").replace(regStr, "").replace(
            /\B(?=(\d{3})+(?!\d))/g, ",");
    return parts.join(".");
};

com.getBoolean = function(boolStr) {
    return WebSquare.util.getBoolean(boolStr);
};


/**
 * 텍스트 - 입력된 str에 포메터를 적용하여 반환한다.
 *
 * @date 2016.08.02
 * @param {String}
 *            str String or Number 포멧터를 적용할 값
 * @memberOf com
 * @author InswaveSystems
 * @return {String} 포멧터가 적용된 문자열
 * @example com.transText("1"); // return 예시) 1 com.transText("12"); // return
 *          예시) 12 com.transText("123"); // return 예시) 1.23
 *          com.transText("1234"); // return 예시) 12.34 com.transText("12345"); //
 *          return 예시) 123.345 com.transText("123456"); // return 예시) 1234.56
 *          com.transText("1234567"); // return 예시) 12345.67
 */
com.transText = function(str) {
    var amount = new String(str);
    var result;

    if (amount.length < 3) {
        result = amount.substr(0, amount.length);
    } else {
        result = amount.substr(0, amount.length - 2) + "."
                + amount.substr(amount.length - 2, amount.length);
    }
    return result;
};

/**
 * 날짜 - 입력된 str에 포메터를 적용하여 반환한다.
 *
 * @date 2016.08.02
 * @param {String}
 *            str 포멧터를 적용할 파라메터 (String 또는 Number 타입 지원)
 * @param {String}
 *            type 적용할 포멧터 형식 Default:null,slash,date
 * @memberOf com
 * @author InswaveSystems
 * @return {String} 포멧터가 적용된 문자열
 * @example com.transDate(20120319, "slash"); // return 예시) 12/03/19
 *          com.transDate(20120319, "date"); // return 예시) 2012/03/19
 *          com.transDate(20120319, "colon"); // return 예시) 2012:03:19
 *          com.transDate(20120319); // return 예시) 2012년 03월 19일
 */
com.transDate = function(str, type) {
    var output = "";
    var date = new String(str);

    if (type == "slash") {
        date = date.substring(2, date.length);
        for (var i = 0; i <= date.length - 1; i++) {
            output = output + date[i];
            if ((i + 1) % 2 == 0 && (date.length - 1) !== i)
                output = output + "/";
        }
    } else if (type == "date") {
        if (date.length == 8) {
            output = date.substr(0, 4) + "/" + date.substr(4, 2) + "/"
                    + date.substr(6, 2);
        }
    } else if (type == "colon") {
        if (date.length == 8) {
            output = date.substr(0, 4) + ":" + date.substr(4, 2) + ":"
                    + date.substr(6, 2);
        }
    } else {
        var year = date.substr(0, 4);
        var month = date.substr(4, 2);
        var day = date.substr(6, 2);
        output = year + "년 " + month + "월 " + day + "일";
    }
    return output;
};

/**
 * displayFormatter - 입력된 str에 포메터를 적용하여 반환한다.
 *
 * @date 2016.08.03
 * @param {String}
 *            str 포멧터를 적용할 문자열
 * @memberOf com
 * @author InswaveSystems
 * @return {String} 포멧터가 적용된 문자열
 * @example com.transUpper("google.com"); // return 예시) "GOOGLE.COM"
 */
com.transUpper = function(str) {
    return str.toUpperCase();
};

/**
 * 해당 그룹 안의 컴포넌트에서 엔터키가 발생하면 해당 컴포넌트의 값을 DataColletion에 저장하고 objFunc 함수를 실행한다.
 *
 * @date 2018.02.15
 * @param {Object}
 *            grpObj 그룹 객체
 * @param {Object}
 *            objFunc 함수 객체
 * @param {Number}
 *            rowIndex DataList가 바인딩된 gridView인 경우 ==> 현재 포커스된 focusedRowIndex
 *            [ex. gridViewId.getFocusedRowIndex()] <br/>아닌 경우 ==> rowIndex는 생략
 * @memberOf com
 * @author InswaveSystems
 * @example com.setEnterKeyEvent(grp_AuthorityDetail, scsObj.search); // return
 *          예시) "엔터키가 발생 -> 해당 함수 실행 및 DataColletion에 UI 컴포넌트에 입력된 데이터를
 *          DataCollection에 저장"
 */
com.setEnterKeyEvent = function(grpObj, objFunc) {
    var objArr = WebSquare.util.getChildren(grpObj, {
        excludePlugin : "group trigger textbox output calendar image span",
        recursive : true
    });

    try {
        for (var i = 0; i < objArr.length; i++) {
            try {
                if (typeof objFunc === "function") {
                    objArr[i]
                            .bind(
                                    "onkeyup",
                                    function(e) {
                                        if (e.keyCode === 13) {
                                            if (typeof this.getRef === "function") {
                                                var ref = this.getRef();
                                                var refArray = ref.substring(5)
                                                        .split(".");
                                                if ((typeof refArray !== "undefined")
                                                        && (refArray.length === 2)) {
                                                    var dataCollectionName = refArray[0];
                                                    var columnId = refArray[1];
                                                    var dataCollection = this
                                                            .getScopeWindow().$p
                                                            .getComponentById(dataCollectionName);
                                                    var dataType = dataCollection
                                                            .getObjectType()
                                                            .toLowerCase();
                                                    if (dataType === "datamap") {
                                                        dataCollection
                                                                .set(
                                                                        columnId,
                                                                        this
                                                                                .getValue());
                                                    } else if ((dataType === 'datalist')
                                                            && (typeof rowIndex !== "undefined")) {
                                                        dataCollection
                                                                .setCellData(
                                                                        dataCollection
                                                                                .getRowPosition(),
                                                                        columnId,
                                                                        this
                                                                                .getValue());
                                                    }
                                                }
                                                objFunc();
                                            }
                                        }
                                    });
                }
            } catch (e) {
                //m_                console.log("[com.setEnterKeyEvent] Exception :: " + e.message);
            } finally {
                dataCollection = null;
            }
        }
    } catch (e) {
        //m_        console.log("[com.setEnterKeyEvent] Exception :: " + e.message);
    } finally {
        objArr = null;
    }
};

/**
 * 문자(char)의 유형을 리턴한다.
 *
 * @date 2016 08.02
 * @param {String}
 *            str 어떤 유형인지 리턴받을 문자
 * @memberOf com
 * @author InswaveSystems
 * @return {Number} 유니코드 기준 <br>
 *         <br>
 *         한글음절[ 44032 ~ 55203 ] => 1 <br>
 *         한글자모[ 4352 ~ 4601 ] => 2 <br>
 *         숫자[ 48 ~ 57 ] => 4 <br>
 *         특수문자[ 32 ~ 47 || 58 ~ 64 || 91 ~ 96 || 123 ~ 126 ] => 8 <br>
 *         영문대[ 65 ~ 90 ] => 16 <br>
 *         영문소[ 97 ~ 122 ] => 32 <br>
 *         기타[그외 나머지] => 48
 * @example com.getLocale("가"); // return 예시)1 com.getLocale("ㅏ"); // return
 *          예시)2 com.getLocale("1"); // return 예시)4 com.getLocale("!"); //
 *          return 예시)8 com.getLocale("A"); // return 예시)16 com.getLocale("a"); //
 *          return 예시)32 com.getLocale("¿"); // return 예시)48
 */
com.getLocale = function(str) {
    var locale = 0;
    if (str.length > 0) {
        var charCode = str.charCodeAt(0);

        if (charCode >= 0XAC00 && charCode <= 0XD7A3) { // 한글음절.[ 44032 ~ 55203
                                                        // ]
            locale = 0X1; // 1
        } else if ((charCode >= 0X1100 && charCode <= 0X11F9)
                || (charCode >= 0X3131 && charCode <= 0X318E)) { // 한글자모.[
                                                                    // 4352 ~
                                                                    // 4601 ]
            locale = 0X2; // 2
        } else if (charCode >= 0X30 && charCode <= 0X39) { // 숫자.[ 48 ~ 57 ]
            locale = 0X4; // 4
        } else if ((charCode >= 0X20 && charCode <= 0X2F)
                || (charCode >= 0X3A && charCode <= 0X40)
                || (charCode >= 0X5B && charCode <= 0X60)
                || (charCode >= 0X7B && charCode <= 0X7E)) { // 특수문자
            locale = 0X8; // 8
        } else if (charCode >= 0X41 && charCode <= 0X5A) { // 영문 대.[ 65 ~ 90 ]
            locale = 0X10; // 16
        } else if (charCode >= 0X61 && charCode <= 0X7A) { // 영문 소.[ 97 ~ 122 ]
            locale = 0X20; // 32
        } else { // 기타
            locale = 0X30; // 48
        }
    }
    return locale;
};

/**
 * 입력받은 문자열이 한글이면 true, 아니면 false를 리턴한다.
 *
 * @date 2016.08.02
 * @param {String}
 *            str 한글 유형인지 검증할 문자열
 * @memberOf com
 * @author InswaveSystems
 * @return {Boolean} true or false
 * @example com.isKorean(""); // return 예시) false com.isKorean("무궁화꽃이"); //
 *          return 예시) true
 */
com.isKorean = function(str) {
    if (str != null && str.length > 0) {
        var locale = 0;
        for (var i = 0; i < str.length; i++) {
            locale = this.getLocale(str.charAt(i));
        }
        if ((locale & ~0x3) == 0) {
            return true;
        }
    }
    return false;
};

/**
 * 종성이 존재하는지 여부를 검사한다.
 *
 * @date 2016.08.02
 * @param {String}
 *            str 종성의 여부를 검사할 문자열
 * @memberOf com
 * @author InswaveSystems
 * @return {Boolean} true or false
 * @example com.isFinalConsonant("종서") // return 예시) false
 *          com.isFinalConsonant("종성") // return 예시) true
 *          com.isFinalConsonant("입니다") // return 예시) false
 *          com.isFinalConsonant("입니당") // return 예시) true
 */
com.isFinalConsonant = function(str) {
    var code = str.charCodeAt(str.length - 1);
    if ((code < 44032) || (code > 55197)) {
        return false;
    }
    if ((code - 16) % 28 == 0) {
        return false;
    }
    return true;
};

/**
 * 단어 뒤에 '은'이나 '는'을 붙여서 반환한다.
 *
 * @date 2016.08.02
 * @param {String}
 *            str 은, 는 붙일 문자열
 * @memberOf com
 * @author InswaveSystems
 * @return {String} 변환된 문자열
 * @example com.attachPostposition("나"); // return 예시)"나는"
 *          com.attachPostposition("나와 너"); // return 예시)"나와 너는"
 *          com.attachPostposition("그래서"); // return 예시)"그래서는"
 *          com.attachPostposition("그랬습니다만"); // return 예시)"그랬습니다만은"
 */
com.attachPostposition = function(str) {
    if (this.isFinalConsonant(str)) {
        str = str + "은 ";
    } else {
        str = str + "는 ";
    }
    return str;
};

/**
 * 입력받은 문자열에 한글이 포함되어 있으면 true, 아니면 false를 리턴한다.
 *
 * @date 2016.08.02
 * @param {String}
 *            str 한글이 포함되어 있는지 검증 받을 문자열
 * @memberOf com
 * @author InswaveSystems
 * @return {Boolean} true or false
 * @example com.isKoreanWord("abcd무궁화"); //return 예시) true
 *          com.isKoreanWord("abcd"); //return 예시) false
 */
com.isKoreanWord = function(str) {
    var c;
    for (var i = 0; i < str.length; i++) {
        c = str.charAt(i);
        if (this.isKorean(c)) {
            return true;
        }
    }
    return false;
};

/**
 * 최상위 page를 index화면으로 이동 (/)
 *
 * @date 2016.08.05
 * @memberOf com
 * @author InswaveSystems
 */
com.goHome = function() {
    if (gcm.CONTEXT_PATH == "") {
        top.window.location.href = "/";
    } else {
        top.window.location.href = gcm.CONTEXT_PATH;
    }
};

/**
 * 로그아웃으로 WAS의 사용자 session을 삭제한다. 정상 처리 : /로 이동. 오류 발생 : 기존 화면으로 오류 메세지 전송
 *
 * @date 2016.08.08
 * @memberOf com
 * @author InswaveSystems
 * @example com.logout();
 */
com.logout = function() {
    var logoutGrpOption = {
        id : "sbm_Logout",
        action : "/main/logout",
        target : "",
        submitDoneHandler : "com.goHome",
        isShowMeg : false
    };
    this.executeSubmission_dynamic(logoutGrpOption);
};

/**
 * contextRoot가 포함된 path를 반환한다.
 *
 * @date 2016.11.16
 * @memberOf com
 * @param {String}
 *            path 파일경로(Context가 포함되지 않은)
 * @return {String} Context가 포함된 파일경로
 * @example // context가 /sample 인경우
 *          com.getFullPath("/ui/SP/Parameter/confirm.xml"); // return 예시)
 *          "/sample/ui/SP/Parameter/confirm.xml"
 */
com.getFullPath = function(path) {
    var rtn_path = "";
    if (gcm.CONTEXT_PATH == "") {
        rtn_path = path;
    } else {
        rtn_path = gcm.CONTEXT_PATH + path;
    }
    return rtn_path;
};

/**
 * 엑셀 다운로드 옵션을 설정하고 확장자 별로 다른 함수(downLoadCSV || downLoadExcel)를 호출한다.
 *
 * @date 2016.11.16
 * @param {Object}
 *            grdObj GridView Object
 * @param {Array}
 *            options JSON형태로 저장된 그리드의 엑셀 다운로드 옵션
 * @param {Array}
 *            infoArr 그리드에 대한 내용을 추가로 다른 셀에 표현하는 경우 사용하는 배열
 * @memberOf com
 * @author InswaveSystems
 * @example var gridId = "grd_AdvancedExcel"; var infoArr = {}; var options = {
 *          fileName : "gridDataDownLoad.xlsx" //[defalut: excel.xlsx] 다운로드하려는
 *          파일의 이름으로 필수 입력 값 (지원하는 타입 => xls, xlsx, csv) };
 *          com.gridDataDownLoad( gridId, options, infoArr); //return 예시)
 *          common.js의 다른 함수(downLoadCSV, downLoadExcel)로 이동하거나 alert 발생
 */
com.gridDataDownLoad = function(grdObj, options, infoArr) {
    var fileName = options.fileName;
    if (fileName.length == 0) {
        options.fileName = "excel.xlsx";
    } else {
        fileName = fileName.toLowerCase();
        if ((fileName.indexOf(".csv") > -1) || (fileName.indexOf(".txt") > -1)) {
            this.downLoadCSV(grdObj, options);
        } else if (fileName.indexOf(".xlsx") > -1
                || fileName.indexOf(".xls") > -1) {
            this.downLoadExcel(grdObj, options, infoArr);
        } else if (fileName.indexOf(".cell") > -1
                || fileName.indexOf(".cel") > -1) {
            this.downLoadExcel(grdObj, options, infoArr);
        } else {
            alert("[common.js][com.gridDataDownLoad] 알수없는 파일 형식입니다");
        }
    }
};

/**
 * 설정된 옵션으로 엑셀을 다운로드 한다.
 *
 * @date 2017.11.30
 * @param {Object}
 *            grdObj GridView 객체
 * @param {Object}
 *            options JSON형태로 저장된 그리드의 엑셀 다운로드 옵션
 * @param {String}
 *            options.fileName [defalut: excel.xlsx] 다운로드하려는 파일의 이름으로 필수 입력 값
 *            <br>
 *            지원하는 타입 => xls, xlsx
 * @param {String}
 *            [options.sheetName] [defalut: sheet] excel의 sheet의 이름
 * @param {String}
 *            [options.type] [defalut: 0] type 0 => 실제 데이터 <br>
 *            1 => 눈에 보이는 데이터<br>
 *            2 => 들어가 있는 data 그대로(filter무시 expression 타입의 셀은 나오지 않음)
 * @param {String}
 *            [options.removeColumns] [defalut: 없음] 다운로드시 excel에서 삭제하려는 열의 번호(여러
 *            개일 경우 ,로 구분)
 * @param {String}
 *            [options.removeHeaderRows] [defalut: 없음] 다운로드시 excel에서 삭제하려는
 *            Header의 row index(여러 개일 경우 ,로 구분)
 * @param {String}
 *            [options.foldColumns] [defalut: 없음] 다운로드시 excel에서 fold하려는 열의 번호(여러
 *            개일 경우 ,로 구분)
 * @param {Number}
 *            [options.startRowIndex] excel 파일에서 그리드의 데이터가 시작되는 행의 번호(헤더 포함)
 * @param {Number}
 *            [options.startColumnIndex] excel 파일에서 그리드의 데이터가 시작되는 열의 번호(헤더 포함)
 * @param {String}
 *            [options.headerColor] excel 파일에서 그리드의 header부분의 색
 * @param {String}
 *            [options.headerFontName] [defalut: 없음] excel파일에서 그리드의 header부분의
 *            font name
 * @param {String}
 *            [options.headerFontSize] excel 파일에서 그리드의 header부분의 font size
 * @param {String}
 *            [options.headerFontColor] excel 파일에서 그리드의 header부분의 font색
 * @param {String}
 *            [options.bodyColor] excel 파일에서 그리드의 body부분의 색
 * @param {String}
 *            [options.bodyFontName] [defalut: 없음] excel파일에서 그리드의 body부분의 font
 *            name
 * @param {String}
 *            [options.bodyFontSize] excel 파일에서 그리드의 body부분의 font size
 * @param {String}
 *            [options.bodyFontColor] excel 파일에서 그리드의 body부분의 font색
 * @param {String}
 *            [options.subTotalColor] [defalut: #CCFFCC] excel파일에서 그리드의
 *            subtotal부분의 색
 * @param {String}
 *            [options.subTotalFontName] [defalut: 없음] excel파일에서 그리드의
 *            subtotal부분의 font name
 * @param {String}
 *            [options.subTotalFontSize] [defalut: 10] excel파일에서 그리드의
 *            subtotal부분의 font size
 * @param {String}
 *            [options.subTotalFontColor] [defalut: 없음] excel파일에서 그리드의
 *            subtotal부분의 font색
 * @param {String}
 *            [options.footerColor] [defalut: #008000] excel파일에서 그리드의 footer부분의
 *            색
 * @param {String}
 *            [options.footerFontName] [defalut: 없음] excel파일에서 그리드의 footer부분의
 *            font name
 * @param {String}
 *            [options.footerFontSize] [defalut: 10] excel파일에서 그리드의 footer부분의
 *            font size
 * @param {String}
 *            [options.footerFontColor] [defalut: 없음] excel파일에서 그리드의 footer부분의
 *            font색
 * @param {String}
 *            [options.oddRowBackgroundColor] excel 파일에서 그리드 body의 홀수줄의 배경색
 * @param {String}
 *            [options.evenRowBackgroundColor] [defalut: 없음] excel파일에서 그리드 body의
 *            짝수줄의 배경색
 * @param {String}
 *            [options.rowNumHeaderColor] [defalut: 없음] rowNumVisible 속성이 true인
 *            경우 순서출력 header 영역의 배경색
 * @param {String}
 *            [options.rowNumHeaderFontName] [defalut: 없음] rowNumVisible 속성이
 *            true인 경우 순서출력 header 영역의 폰트이름
 * @param {String}
 *            [options.rowNumHeaderFontSize] [defalut: 없음] rowNumVisible 속성이
 *            true인 경우 순서출력 header 영역의 폰트크기
 * @param {String}
 *            [options.rowNumHeaderFontColor] [defalut: 없음] rowNumVisible 속성이
 *            true인 경우 순서출력 header 영역의 폰트색상
 * @param {String}
 *            [options.rowNumBodyColor] [defalut: 없음] rowNumVisible 속성이 true인 경우
 *            순서출력 Body 영역의 배경색
 * @param {String}
 *            [options.rowNumBodyFontName] [defalut: 없음] rowNumVisible 속성이 true인
 *            경우 순서출력 Body 영역의 폰트이름
 * @param {String}
 *            [options.rowNumBodyFontSize] [defalut: 없음] rowNumVisible 속성이 true인
 *            경우 순서출력 Body 영역의 폰트크기
 * @param {String}
 *            [options.rowNumBodyFontColor] [defalut: 없음] rowNumVisible 속성이
 *            true인 경우 순서출력 Body 영역의 폰트색상
 * @param {String}
 *            [options.rowNumFooterColor] [defalut: 없음] rowNumVisible 속성이 true인
 *            경우 순서출력 Footer 영역의 배경색
 * @param {String}
 *            [options.rowNumFooterFontName] [defalut: 없음] rowNumVisible 속성이
 *            true인 경우 순서출력 Footer 영역의 폰트이름
 * @param {String}
 *            [options.rowNumFooterFontSize] [defalut: 없음] rowNumVisible 속성이
 *            true인 경우 순서출력 Footer 영역의 폰트크기
 * @param {String}
 *            [options.rowNumFooterFontColor] [defalut: 없음] rowNumVisible 속성이
 *            true인 경우 순서출력 Footer 영역의 폰트색상
 * @param {String}
 *            [options.rowNumSubTotalColor] [defalut: 없음] rowNumVisible 속성이
 *            true인 경우 순서출력 Subtotal 영역의 배경색
 * @param {String}
 *            [options.rowNumSubTotalFontName] [defalut: 없음] rowNumVisible 속성이
 *            true인 경우 순서출력 Subtotal 영역의 폰트이름
 * @param {String}
 *            [options.rowNumSubTotalFontSize] [defalut: 없음] rowNumVisible 속성이
 *            true인 경우 순서출력 Subtotal 영역의 폰트크기
 * @param {String}
 *            [options.rowNumSubTotalFontColo] [defalut: 없음] rowNumVisible 속성이
 *            true인 경우 순서출력 Subtotal 영역의 폰트색상
 * @param {String}
 *            [options.rowNumHeaderValue] [defalut: 없음] rowNumVisible 속성이 true인
 *            경우 순서출력 Header 영역의 출력값
 * @param {String}
 *            [options.rowNumVisible] [defalut: false] 순서출력 유무
 * @param {String}
 *            [options.showProcess] [defalut: true] 다운로드 시 프로세스 창을 보여줄지 여부
 * @param {String}
 *            [options.massStorage] [defalut: true] 대용량 다운로드 여부 <br>
 *            (default는 true 이 옵션을 true로 하고 showConfirm을 false로 한 경우에 IE에서 신뢰할만한
 *            사이트를 체크하는 옵션이 뜬다.)
 * @param {String}
 *            [options.showConfirm] [defalut: false] 다운로드 확인창을 띄울지 여부 <br>
 *            (옵션을 킨 경우 advancedExcelDownload를 호출후 사용자가 window의 버튼을 한번더 클릭해야 한다.
 *            massStorage는 자동으로 true가 된다)
 * @param {String}
 *            [options.dataProvider] [defalut: 없음] 대량데이터 처리 및 사용자 데이터를 가공할 수 있는
 *            Provider Package
 * @param {String}
 *            [options.providerRequestXml] [defalut: 없음] Provider 내부에서 사용할 XML
 *            문자열
 * @param {String}
 *            [options.userDataXml] [defalut: 없음] 사용자가 서버모듈 개발 시 필요한 데이터를 전송 할 수
 *            있는 변수
 * @param {String}
 *            [options.bodyWordwrap] [defalut: false] 다운로드시 바디의 줄 바꿈 기능
 * @param {String}
 *            [options.useEuroLocal] [defalut: false] 다운로드시 유로화 처리 기능(,와 .이 반대인
 *            경우처리)
 * @param {String}
 *            [options.useHeader] [defalut: true] 다운로드시 Header를 출력 할지 여부<br>
 *            "true" => 출력 <br>
 *            "false" => 미출력
 * @param {String}
 *            [options.useSubTotal] [defalut: false] 다운로드시 SubTotal을 출력 할지 여부<br>
 *            "true" => 출력 <br>
 *            "false" => 미출력<br>
 *            expression을 지정한 경우 avg,sum,min,max,targetColValue,숫자를 지원 함.
 * @param {String}
 *            [options.useFooter] [defalut: true] 다운로드시 Footer를 출력 할지 여부<br>
 *            "true" => 출력<br>
 *            "false" => 미출력
 * @param {String}
 *            [options.separator] [defalut: ,] 다운로드시 서버로 데이터 전송할때, 데이터를 구분짓는
 *            구분자, default는 comma(,)
 * @param {Number}
 *            [options.subTotalScale] [defalut: -1] 다운로드시 subTotal 평균계산시 소수점
 *            자리수를 지정
 * @param {String}
 *            [options.subTotalRoundingMode] [defalut: 없음] 다운로드시 subTotal 평균계산시
 *            Round를 지정 한다. <br>
 *            "CEILING" => 소수점 올림 <br>
 *            "FLOOR" => 소수점 버림 <br>
 *            "HALF_UP" => 소수점 반올림
 * @param {String}
 *            [options.useStyle] [defalut: false] 다운로드시 css를 제외한, style을 excel에도
 *            적용할 지 여부 (배경색,폰트)
 * @param {String}
 *            [options.freezePane] [defalut: ""] 틀고정을 위한 좌표값 및 좌표값의 오픈셋 <br>
 *            freezePane="3,4" => X축 3, Y축 4에서 틀고정<br>
 *            freezePane="0,1,0,5" => X축 0, Y축 1에서 X축으로 0, Y축으로 5로 틀고정
 * @param {String}
 *            [options.autoSizeColumn] [defalut: false] 너비자동맞춤 설정 유무 -
 *            2016.08.18 옵션 설정을 true로 변경
 * @param {String}
 *            [options.displayGridlines] [defalut: false] 엑셀 전체 셀의 눈금선 제거 유무
 * @param {String}
 *            [options.colMerge] [defalut: false] colMerge된 컬럼을 Merge해서 출력 할 지
 *            여부
 * @param {String}
 *            [options.useDataFormat] [defalut: 없음] 그리드 dataType이 text인 경우, 엑셀의
 *            표시형식 '텍스트' 출력 유무<br>
 *            "true" => 표시형식 텍스트<br>
 *            "false" => 표시형식 일반 출력)
 * @param {String}
 *            [options.indent] [defalut: 0] 그리드 dataType이 drilldown인 경우, indent
 *            표시를 위한 공백 삽입 개수
 * @param {String}
 *            [options.columnMove] [defalut: false] 그리드 컬럼이동시 이동된 상태로 다운로드 유무
 *            <br>
 *            "true" => 컬럼이동 순서대로 출력
 * @param {String}
 *            [options.columnOrder] [defalut: 없음] 엑셀 다운로드시 다운로드되는 컬럼 순서를 지정 할 수
 *            있는 속성 ( "0,3,2,1"로 지정시 지정한 순서로 다운로드된다 )
 * @param {String}
 *            [options.fitToPage] [defalut: false] 엑셀 프린터 출력시 쪽맞춤 사용 유무
 * @param {String}
 *            [options.landScape] [defalut: false] 엑셀 프린터 출력시 가로 방향 출력 유무
 * @param {String}
 *            [options.fitWidth] [defalut: 1] 엑셀 프린터 출력시 용지너비
 * @param {String}
 *            [options.fitHeight] [defalut: 1] 엑셀 프린터 출력시 용지높이
 * @param {String}
 *            [options.scale] [defalut: 100] 엑셀 프린터 출력시 확대/축소 배율<br>
 *            scale을 사용할 경우 fitToPage는 false로 설정 해야 한다.
 * @param {String}
 *            [options.pageSize] [defalut: A4] 엑셀 프린터 출력시 인쇄용지 설정 <br>
 *            "A3", "A4", "A5", "B4"
 * @param {Object[]}
 *            [infoArr] subTotalFontName 그리드에 대한 내용을 추가로 다른 셀에 표현하는 경우 사용하는 배열
 * @param {Number}
 *            [infoArr.rowIndex] [defalut: ""] 내용을 표시할 행번호
 * @param {Number}
 *            [infoArr.colIndex] [defalut: ""] 내용을 표시할 열번호
 * @param {Number}
 *            [infoArr.rowSpan] [defalut: ""] 병합할 행의 수
 * @param {Number}
 *            [infoArr.colSpan] [defalut: ""] 병합할 열의 수
 * @param {String}
 *            [infoArr.text] [defalut: ""] 표시할 내용
 * @param {String}
 *            [infoArr.textAlign] [defalut: "right"] 표시할 내용의 정렬 방법 <br>
 *            left => 좌측 정렬 <br>
 *            center => 가운데 정렬 <br>
 *            right => 우측 정렬
 * @param {String}
 *            [infoArr.fontSize] [defalut: "10px"] font size 설정 20px, 10px, 5px
 * @param {String}
 *            [infoArr.fontName] [defalut: ""] font name 설정
 * @param {String}
 *            [infoArr.color] [defalut: ""] font color 설정 red, blue, green
 * @param {String}
 *            [infoArr.fontWeight] [defalut: ""] font weight 설정 bold
 * @param {String}
 *            [infoArr.drawBorder] [defalut: "true"] cell의 border지정 true, false
 * @param {String}
 *            [infoArr.wordWrap] [defalut: ""] cell의 줄 바꿈 기능 true, false
 * @param {String}
 *            [infoArr.bgColor] [defalut: ""] cell의 배경 color 설정 red, blue, green
 * @memberOf com
 * @return {file} <b>Excel file</b>
 * @author InswaveSystems
 * @example var gridId = "grd_AdvancedExcel"; var infoArr = {}; var options = {
 *          fileName : "downLoadExcel.xlsx" //[default : excel.xlsx]
 *          options.fileName 값이 없을 경우 default값 세팅 }; com.downLoadExcel(grdObj,
 *          options, infoArr );
 */
com.downLoadExcel = function(grdObj, options, infoArr) {
    // excel 다운로드시 기본 설정으로 화면내의 hidden컬럼을 removeColumns에 포함시킨다.
    // 이를 원치 않을 경우 options.hiddenVisible = 'true' 로 설정한다.
    if (!options.hiddenVisible) {
        var grdCnt = grdObj.getTotalCol();

        var hiddenColIndex = [];
        for (var idx = 0; idx < grdCnt; idx++) {
            if (!grdObj.getColumnVisible(idx)) {
                hiddenColIndex.push(idx);
            }
        }
        // hidden 컬럼이 있는 경우만 추가할 수 있도록 (2016.10.28 추가)
        if (hiddenColIndex.length > 0) {
            if(com.isEmpty(options.removeColumns)){
                options.removeColumns = hiddenColIndex.join(',');
            }else{
                if (options.removeColumns.length > 0) {
                    options.removeColumns = options.removeColumns + ","
                            + hiddenColIndex.join(',');
                }
            }

            // 중복 요소 제거
            var _removeColumnArr = options.removeColumns.split(",");
            options.removeColumns = _removeColumnArr.reduce(function(a, b) {
                if (a.indexOf(b) < 0) {
                    a.push(b);
                }
                return a;
            }, []).join(',');
        }
    }
    var defaultFontName = "맑은 고딕";

    var options = {
        fileName : encodeURI(options.fileName || "excel.xlsx"), // String, [defalut: excel.xlsx] - 크롬에서 한글 깨짐 수정
                                                                // 다운로드하려는 파일의 이름으로 필수 입력 값이다.
        sheetName : options.sheetName || "sheet", // String, [defalut: sheet]
                                                    // excel의 sheet의 이름
        type : options.type || "0", // String, [defalut: 0] type이 0인 경우 실제 데이터
                                    // 1인 경우 눈에 보이는 데이터를 2이면 들어가 있는 data
                                    // 그대로(filter무시 expression 타입의 셀은 나오지 않음)
        removeColumns : options.removeColumns || "", // String, [defalut: 없음]
                                                        // 다운로드시 excel에서 삭제하려는
                                                        // 열의 번호(여러 개일 경우 ,로 구분)
        removeHeaderRows : options.removeHeaderRows || "", // String, [defalut:
                                                            // 없음] 다운로드시 excel에서
                                                            // 삭제하려는 Header의 row
                                                            // index(여러 개일 경우 ,로
                                                            // 구분)
        foldColumns : options.foldColumns || "", // String, [defalut: 없음]
                                                    // 다운로드시 excel에서 fold하려는 열의
                                                    // 번호(여러 개일 경우 ,로 구분)
        startRowIndex : options.startRowIndex || 3, // Number, excel파일에서 그리드의
                                                    // 데이터가 시작되는 행의 번호(헤더 포함)
        startColumnIndex : options.startColumnIndex || 0, // Number, excel파일에서
                                                            // 그리드의 데이터가 시작되는 열의
                                                            // 번호(헤더 포함)
        headerColor : options.headerColor || "#edf2f5", // String, excel파일에서
                                                        // 그리드의 header부분의 색
        headerFontName : options.headerFontName || defaultFontName, // String, [defalut: 없음]
                                                        // excel파일에서 그리드의
                                                        // header부분의 font name
        headerFontSize : options.headerFontSize || "10", // String, excel파일에서
                                                            // 그리드의 header부분의
                                                            // font size
        headerFontColor : options.headerFontColor || "", // String, excel파일에서
                                                            // 그리드의 header부분의
                                                            // font색
        bodyColor : options.bodyColor || "#FFFFFF", // String, excel파일에서 그리드의
                                                    // body부분의 색
        bodyFontName : options.bodyFontName || defaultFontName, // String, [defalut: 없음]
                                                    // excel파일에서 그리드의 body부분의
                                                    // font name
        bodyFontSize : options.bodyFontSize || "10", // String, excel파일에서
                                                        // 그리드의 body부분의 font
                                                        // size
        bodyFontColor : options.bodyFontColor || "", // String, excel파일에서
                                                        // 그리드의 body부분의 font색
        subTotalColor : options.subTotalColor || "#CCFFCC", // String, [defalut:
                                                            // #CCFFCC]
                                                            // excel파일에서 그리드의
                                                            // subtotal부분의 색
        subTotalFontName : options.subTotalFontName || defaultFontName, // String, [defalut:
                                                            // 없음] excel파일에서
                                                            // 그리드의 subtotal부분의
                                                            // font name
        subTotalFontSize : options.subTotalFontSize || "10", // String,
                                                                // [defalut: 10]
                                                                // excel파일에서
                                                                // 그리드의
                                                                // subtotal부분의
                                                                // font size
        subTotalFontColor : options.subTotalFontColor || "", // String,
                                                                // [defalut: 없음]
                                                                // excel파일에서
                                                                // 그리드의
                                                                // subtotal부분의
                                                                // font색
        footerColor : options.footerColor || "#d6eaff", // String, [defalut:
                                                        // #008000] excel파일에서
                                                        // 그리드의 footer부분의 색
        footerFontName : options.footerFontName || "맑은 고딕", // String, [defalut: 없음]
                                                        // excel파일에서 그리드의
                                                        // footer부분의 font name
        footerFontSize : options.footerFontSize || "10", // String, [defalut:
                                                            // 10] excel파일에서
                                                            // 그리드의 footer부분의
                                                            // font size
        footerFontColor : options.footerFontColor || "", // String, [defalut:
                                                            // 없음] excel파일에서
                                                            // 그리드의 footer부분의
                                                            // font색
        oddRowBackgroundColor : options.oddRowBackgroundColor || "", // String,
                                                                        // excel파일에서
                                                                        // 그리드
                                                                        // body의
                                                                        // 홀수줄의
                                                                        // 배경색
        evenRowBackgroundColor : options.evenRowBackgroundColor || "", // String,
                                                                        // [defalut:
                                                                        // 없음]
                                                                        // excel파일에서
                                                                        // 그리드
                                                                        // body의
                                                                        // 짝수줄의
                                                                        // 배경색
        rowNumHeaderColor : options.rowNumHeaderColor || "#edf2f5", // String,
                                                                // [defalut: 없음]
                                                                // rowNumVisible
                                                                // 속성이 true인 경우
                                                                // 순서출력 header
                                                                // 영역의 배경색
        rowNumHeaderFontName : options.rowNumHeaderFontName || defaultFontName, // String,
                                                                    // [defalut:
                                                                    // 없음]
                                                                    // rowNumVisible
                                                                    // 속성이 true인
                                                                    // 경우 순서출력
                                                                    // header
                                                                    // 영역의 폰트이름
        rowNumHeaderFontSize : options.rowNumHeaderFontSize || "", // String,
                                                                    // [defalut:
                                                                    // 없음]
                                                                    // rowNumVisible
                                                                    // 속성이 true인
                                                                    // 경우 순서출력
                                                                    // header
                                                                    // 영역의 폰트크기
        rowNumHeaderFontColor : options.rowNumHeaderFontColor || "", // String,
                                                                        // [defalut:
                                                                        // 없음]
                                                                        // rowNumVisible
                                                                        // 속성이
                                                                        // true인
                                                                        // 경우
                                                                        // 순서출력
                                                                        // header
                                                                        // 영역의
                                                                        // 폰트색상
        rowNumBodyColor : options.rowNumBodyColor || "", // String, [defalut:
                                                            // 없음] rowNumVisible
                                                            // 속성이 true인 경우 순서출력
                                                            // Body 영역의 배경색
        rowNumBodyFontName : options.rowNumBodyFontName || defaultFontName, // String,
                                                                // [defalut: 없음]
                                                                // rowNumVisible
                                                                // 속성이 true인 경우
                                                                // 순서출력 Body 영역의
                                                                // 폰트이름
        rowNumBodyFontSize : options.rowNumBodyFontSize || "", // String,
                                                                // [defalut: 없음]
                                                                // rowNumVisible
                                                                // 속성이 true인 경우
                                                                // 순서출력 Body 영역의
                                                                // 폰트크기
        rowNumBodyFontColor : options.rowNumBodyFontColor || "", // String,
                                                                    // [defalut:
                                                                    // 없음]
                                                                    // rowNumVisible
                                                                    // 속성이 true인
                                                                    // 경우 순서출력
                                                                    // Body 영역의
                                                                    // 폰트색상
        rowNumFooterColor : options.rowNumFooterColor || "#d6eaff", // String,
                                                                // [defalut: 없음]
                                                                // rowNumVisible
                                                                // 속성이 true인 경우
                                                                // 순서출력 Footer
                                                                // 영역의 배경색
        rowNumFooterFontName : options.rowNumFooterFontName || defaultFontName, // String,
                                                                    // [defalut:
                                                                    // 없음]
                                                                    // rowNumVisible
                                                                    // 속성이 true인
                                                                    // 경우 순서출력
                                                                    // Footer
                                                                    // 영역의 폰트이름
        rowNumFooterFontSize : options.rowNumFooterFontSize || "", // String,
                                                                    // [defalut:
                                                                    // 없음]
                                                                    // rowNumVisible
                                                                    // 속성이 true인
                                                                    // 경우 순서출력
                                                                    // Footer
                                                                    // 영역의 폰트크기
        rowNumFooterFontColor : options.rowNumFooterFontColor || "", // String,
                                                                        // [defalut:
                                                                        // 없음]
                                                                        // rowNumVisible
                                                                        // 속성이
                                                                        // true인
                                                                        // 경우
                                                                        // 순서출력
                                                                        // Footer
                                                                        // 영역의
                                                                        // 폰트색상
        rowNumSubTotalColor : options.rowNumSubTotalColor || "", // String,
                                                                    // [defalut:
                                                                    // 없음]
                                                                    // rowNumVisible
                                                                    // 속성이 true인
                                                                    // 경우 순서출력
                                                                    // Subtotal
                                                                    // 영역의 배경색
        rowNumSubTotalFontName : options.rowNumSubTotalFontName || defaultFontName, // String,
                                                                        // [defalut:
                                                                        // 없음]
                                                                        // rowNumVisible
                                                                        // 속성이
                                                                        // true인
                                                                        // 경우
                                                                        // 순서출력
                                                                        // Subtotal
                                                                        // 영역의
                                                                        // 폰트이름
        rowNumSubTotalFontSize : options.rowNumSubTotalFontSize || "", // String,
                                                                        // [defalut:
                                                                        // 없음]
                                                                        // rowNumVisible
                                                                        // 속성이
                                                                        // true인
                                                                        // 경우
                                                                        // 순서출력
                                                                        // Subtotal
                                                                        // 영역의
                                                                        // 폰트크기
        rowNumSubTotalFontColor : options.rowNumSubTotalFontColor || "", // String,
                                                                            // [defalut:
                                                                            // 없음]
                                                                            // rowNumVisible
                                                                            // 속성이
                                                                            // true인
                                                                            // 경우
                                                                            // 순서출력
                                                                            // Subtotal
                                                                            // 영역의
                                                                            // 폰트색상
        rowNumHeaderValue : options.rowNumHeaderValue || "", // String,
                                                                // [defalut: 없음]
                                                                // rowNumVisible
                                                                // 속성이 true인 경우
                                                                // 순서출력 Header
                                                                // 영역의 출력값
        rowNumVisible : options.rowNumVisible || "false", // String, [defalut:
                                                            // false] 순서출력 유무
        showProcess : WebSquare.util.getBoolean(options.showProcess) || true, // Boolean,
                                                                                // [defalut:
                                                                                // true]
                                                                                // 다운로드
                                                                                // 시
                                                                                // 프로세스
                                                                                // 창을
                                                                                // 보여줄지
                                                                                // 여부
        massStorage : WebSquare.util.getBoolean(options.massStorage) || true, // Boolean,
                                                                                // [defalut:
                                                                                // true]
                                                                                // 대용량
                                                                                // 다운로드
                                                                                // 여부
                                                                                // (default는
                                                                                // true
                                                                                // 이
                                                                                // 옵션을
                                                                                // true로
                                                                                // 하고
                                                                                // showConfirm을
                                                                                // false로
                                                                                // 한
                                                                                // 경우에
                                                                                // IE에서
                                                                                // 신뢰할만한
                                                                                // 사이트를
                                                                                // 체크하는
                                                                                // 옵션이
                                                                                // 뜬다.)
        showConfirm : WebSquare.util.getBoolean(options.showConfirm) || false, // Boolean,
                                                                                // [defalut:
                                                                                // false]
                                                                                // 다운로드
                                                                                // 확인창을
                                                                                // 띄울지
                                                                                // 여부(옵션을
                                                                                // 킨 경우
                                                                                // advancedExcelDownload를
                                                                                // 호출후
                                                                                // 사용자가
                                                                                // window의
                                                                                // 버튼을
                                                                                // 한번더
                                                                                // 클릭해야
                                                                                // 한다.
                                                                                // massStorage는
                                                                                // 자동으로
                                                                                // true가
                                                                                // 된다)
        dataProvider : options.dataProvider || "", // String, [defalut: 없음]
                                                    // 대량데이터 처리 및 사용자 데이터를 가공할 수
                                                    // 있는 Provider Package
        providerRequestXml : options.providerRequestXml || "", // String,
                                                                // [defalut: 없음]
                                                                // Provider 내부에서
                                                                // 사용할 XML 문자열
        userDataXml : options.userDataXml || "", // String, [defalut: 없음]
                                                    // 사용자가 서버모듈 개발 시 필요한 데이터를
                                                    // 전송 할 수 있는 변수
        bodyWordwrap : WebSquare.util.getBoolean(options.bodyWordwrap) || false, // Boolean,
                                                                                    // [defalut:
                                                                                    // false]
                                                                                    // 다운로드시
                                                                                    // 바디의
                                                                                    // 줄 바꿈
                                                                                    // 기능
        useEuroLocale : options.useEuroLocale || "false", // String, [defalut:
                                                            // false] 다운로드시 유로화
                                                            // 처리 기능(,와 .이 반대인
                                                            // 경우처리)
        useHeader : options.useHeader || "true", // String, [defalut: true]
                                                    // 다운로드시 Header를 출력 할지 여부(
                                                    // "true"인경우 출력, "false"인경우
                                                    // 미출력)
        useSubTotal : options.useSubTotal || "false", // String, [defalut:
                                                        // false] 다운로드시
                                                        // SubTotal을 출력 할지 여부(
                                                        // "true"인경우 출력,
                                                        // "false"인경우 미출력),
                                                        // expression을 지정한 경우
                                                        // avg,sum,min,max,targetColValue,숫자를
                                                        // 지원 함.
        useSubTotalData : options.useSubTotalData ||"false",
        useFooter : options.useFooter || true, // String, [defalut: true]
                                                    // 다운로드시 Footer를 출력 할지 여부(
                                                    // "true"인경우 출력, "false"인경우
                                                    // 미출력)

        useFooterData : options.useFooterData|| "false",
        separator : options.separator || ",", // String, [defalut: ,] 다운로드시
                                                // 서버로 데이터 전송할때, 데이터를 구분짓는 구분자,
                                                // default는 comma(,)
        subTotalScale : options.subTotalScale || -1, // Number, [defalut: -1]
                                                        // 다운로드시 subTotal 평균계산시
                                                        // 소수점 자리수를 지정
        subTotalRoundingMode : options.subTotalRoundingMode || "", // String,
                                                                    // [defalut:
                                                                    // 없음] 다운로드시
                                                                    // subTotal
                                                                    // 평균계산시
                                                                    // Round를 지정
                                                                    // 한다.
                                                                    // ("CEILING","FLOOR","HALF_UP")
        useStyle : options.useStyle || "", // String, [defalut: false] 다운로드시
                                            // css를 제외한, style을 excel에도 적용할 지 여부
                                            // (배경색,폰트)
        freezePane : options.freezePane || "", // String, [defalut: ""] 틀고정을 위한
                                                // 좌표값 및 좌표값의 오픈셋 ( ex)
                                                // freezePane="3,4" X축 3, Y축 4에서
                                                // 틀고정, freezePane="0,1,0,5" X축
                                                // 0, Y축 1에서 X축으로 0, Y축으로 5로 틀공정
                                                // )
        autoSizeColumn : options.autoSizeColumn || "true", // String, [defalut:
                                                            // false] 너비자동맞춤 설정
                                                            // 유무 - 2016.08.18
                                                            // 옵션 설정을 true로 변경
        displayGridlines : options.displayGridlines || "", // String, [defalut:
                                                            // false] 엑셀 전체 셀의
                                                            // 눈금선 제거 유무
        mergeCell : options.mergeCell || "true", // String, [defalut: false]
        
        colMerge : options.colMerge || "", // String, [defalut: false]
                                            // colMerge된 컬럼을 Merge해서 출력 할 지 여부
        useDataFormat : options.useDataFormat || "", // String, [defalut: 없음]
                                                        // 그리드 dataType이 text인
                                                        // 경우, 엑셀의 표시형식 '텍스트' 출력
                                                        // 유무( "true"인 경우 표시형식
                                                        // 텍스트, "false"인 경우 표시형식
                                                        // 일반 출력)
        indent : options.indent || "", // String, [defalut: 없음] 그리드 dataType이
                                        // drilldown인 경우, indent 표시를 위한 공백 삽입
                                        // 개수, default값은 0
        columnMove : options.columnMove || "", // String, [defalut: false] 그리드
                                                // 컬럼이동시 이동된 상태로 다운로드 유무 (
                                                // "true"인경우 컬럼이동 순서대로 출력 )
        columnOrder : options.columnOrder || "", // String, [defalut: 없음] 엑셀
                                                    // 다운로드시 다운로드되는 컬럼 순서를 지정 할
                                                    // 수 있는 속성 ( ex) "0,3,2,1"로
                                                    // 지정시 지정한 순서로 다운로드된다 )
        fitToPage : options.fitToPage || "false", // String, [defalut: false]
                                                    // 엑셀 프린터 출력시 쪽맞춤 사용 유무
        landScape : options.landScape || "false", // String, [defalut: false]
                                                    // 엑셀 프린터 출력시 가로 방향 출력 유무
        fitWidth : options.fitWidth || "1", // String, [defalut: 1] 엑셀 프린터 출력시
                                            // 용지너비
        fitHeight : options.fitHeight || "1", // String, [defalut: 1] 엑셀 프린터
                                                // 출력시 용지높이
        scale : options.scale || "100", // String, [defalut: 100] 엑셀 프린터 출력시
                                        // 확대/축소 배율, scale을 사용할 경우 fitToPage는
                                        // false로 설정 해야 한다.
        pageSize : options.pageSize || "A4" // String, [defalut: A4] 엑셀 프린터 출력시
                                            // 인쇄용지 설정 ( ex) "A3", "A4", "A5",
                                            // "B4" )
    };


    // 정보 표시
    var ia = [];
    for (var ar = 0 ;ar < infoArr.length; ar++){
        var arrObj = infoArr[ar];
        var _info = {
                rowIndex : arrObj.rowIndex || 0, // Number, 내용을 표시할 행번호
                colIndex : arrObj.colIndex || 0, // Number, 내용을 표시할 열번호
                rowSpan : arrObj.rowSpan || 0, // Number, 병합할 행의 수
                colSpan : arrObj.colSpan || 0, // Number, 병합할 열의 수
                text : arrObj.text || " ", // String, 표시할 내용
                textAlign : arrObj.textAlign || "right", // String, 표시할 내용의 정렬 방법
                                                            // left, center, right
                fontSize : arrObj.fontSize || "10px", // String, font size 설정 20px,
                                                        // 10px, 5px
                fontName : arrObj.fontName || defaultFontName, // String, font name 설정
                color : arrObj.color || "", // String, font color 설정 red, blue,
                                                // green
                fontWeight : arrObj.fontWeight || "", // String, font weight 설정 bold
                drawBorder : arrObj.drawBorder || "true", // String, cell의 border지정
                                                            // true, false
                wordWrap : arrObj.wordWrap || "", // String, cell의 줄 바꿈 기능 true, false
                bgColor : arrObj.bgColor || "" // String, cell의 배경 color 설정 red, blue,                                              // green
            };
        ia.push(_info);
    }
    grdObj.advancedExcelDownload(options, ia);
};

/**
 * 설정된 옵션으로 CSV파일을 다운로드 한다.
 *
 * @date 2017.11.30
 * @param {Object}
 *            grdObj GridView Object
 * @param {Object[]}
 *            options JSON형태로 저장된 그리드의 엑셀 다운로드 옵션
 * @param {String}
 *            options.fileName [default: excel.csv] 저장 될 파일 이름
 * @param {String}
 *            [options.type] [default: 1] Grid 저장 형태 (0이면 데이터 형태,1이면 표시 방식)
 * @param {String}
 *            [options.delim] [default: ,] CSV 파일에서 데이터를 구분할 구분자
 * @param {String}
 *            [options.removeColumns] [default: 없음] 저장 하지 않을 columns index,
 *            여러컬럼인 경우 콤마(,)로 구분해서 정의 한다.
 * @param {String}
 *            [options.header] [default: 1] Grid의 숨겨진 Column에 대한 저장 여부(0이면 저장 하지
 *            않음,1이면 저장)
 * @param {String}
 *            [options.hidden] [defalut: 0] Grid의 숨겨진 Column에 대한 저장 여부(0이면 저장 하지
 *            않음,1이면 저장)
 * @param {String}
 *            [options.checkButton] [default: 1] Grid의 Control(Check, Radio,
 *            Button) Column에 대해 히든 여부 (0이면 control Column히든,1이면 보여줌)
 * @param {String}
 *            [options.saveList] [default: 없음] hidden에 관계없이 저장할 column id들의
 *            array
 * @memberOf com
 * @return {file} CSV file
 * @author InswaveSystems
 * @example var gridId = "grd_AdvancedExcel"; var options = { fileName :
 *          "downLoadCSV.csv" //[default : excel.csv] options.fileName 값이 없을 경우
 *          default값 세팅 }; com.downLoadCSV(grdObj, options); //return 예시) 엑셀 파일
 *          다운로드
 */
com.downLoadCSV = function(grdObj, options) {

    var options = {
        fileName : options.fileName || "excel.csv", // [default: excel.csv] 저장 될
                                                    // 파일 이름
        type : options.type || "1", // [default: 1] Grid 저장 형태 (0이면 데이터 형태,1이면
                                    // 표시 방식)
        delim : options.delim || ",", // [default: ,] CSV 파일에서 데이터를 구분할 구분자
        removeColumns : options.removeColumns || "", // [default: 없음] 저장 하지
                                                        // 않을 columns index,
                                                        // 여러컬럼인 경우 콤마(,)로 구분해서
                                                        // 정의 한다.
        header : options.header || "1", // [default: 1] Grid의 숨겨진 Column에 대한 저장
                                        // 여부(0이면 저장 하지 않음,1이면 저장)
        hidden : options.hidden || 0, // [defalut: 0] Grid의 숨겨진 Column에 대한 저장
                                        // 여부(0이면 저장 하지 않음,1이면 저장)
        checkButton : options.checkButton || "1", // [default: 1] Grid의
                                                    // Control(Check, Radio,
                                                    // Button) Column에 대해 히든 여부
                                                    // (0이면 control Column히든,1이면
                                                    // 보여줌)
        saveList : options.saveList || "" // [default: 없음] hidden에 관계없이 저장할
                                            // column id들의 array
    };
    if(options.removeColumns.length == 0 ){
        options.removeColumns = "";
    }


    grdObj.saveCSV(options);
};

/**
 * 엑셀 업로드 옵션을 설정하고 확장자 별로 다른 함수(uploadCSV || uploadExcel)를 호출한다.
 *
 * @date 2018.08.30
 * @param {Object}
 *            grdObj 그리드뷰 아이디
 * @param {Array}
 *            options JSON형태로 저장된 그리드의 엑셀 업로드 옵션
 * @param {String}
 *            type 타입(xls, xlsx, csv, cell)을 구분 후, 적합한 API를 사용하여 업로드 한다.
 * @memberOf com
 * @author InswaveSystems
 * @example

 *          var type = "xlsx";
 *          var options = {
 *                          fileName : "gridDataUpload.xlsx" // default값이 존재하지 않으므로 꼭 fileName
 *                                                              값을 넣어야 한다.
 *                        };
 *         com.gridDataUpload(grdObj, type, options);
 */
com.gridDataUpload = function(grdObj, type, options) {
    type = type.toLowerCase();

    if (type == "csv") {
        this.uploadCSV(grdObj, options);
    } else if (type == "xls" || type == "xlsx") {
        this.uploadExcel(grdObj, options);
    } else if (type == "cell" || type == "cel") {
        this.uploadExcel(grdObj, options);
    } else {
        alert("[common.js][com.gridDataUpload] 지원하지 않는 파일 형식입니다."); //
    }
};

/**
 * 엑셀 xls, xlsx 업로드
 *
 * @date 2017.11.30
 * @param {Object}
 *            grdObj GridView Object
 * @param {Object}
 *            options JSON형태로 저장된 그리드의 엑셀 업로드 옵션
 *
 * @param {String}
 *            [options.type] 1 => 엑셀 파일이 그리드의 보이는 결과로 만들어져있을때 <br>
 *            0 => 엑셀 파일이 그리드의 실제 데이터로 구성되어있을때
 * @param {Number}
 *            [options.sheetNo] excel파일에서 그리드의 데이터가 있는 sheet번호
 * @param {Number}
 *            [options.startRowIndex] [defalut:0] excel파일에서 그리드의 데이터가 시작되는 행의
 *            번호(헤더 포함)
 * @param {Number}
 *            [options.startColumnIndex] [defalut:0] excel파일에서 그리드의 데이터가 시작되는 열의
 *            번호
 * @param {Number}
 *            [options.endColumnIndex] [defalut: 0] excel파일에서 그리드의 데이터가 끝나는 열의
 *            index<br>
 *            (엑셀컬럼수가 그리드컬럼수 보다 작은 경우 그리드 컬러수를 설정)
 * @param {String}
 *            [options.headerExist] [defalut:0] excel파일에서 그리드의 데이터에 header가 있는지
 *            여부<br>
 *            1 => header 존재 <br>
 *            0 => 없음)
 * @param {String}
 *            [options.footerExis] [defalut: 1] excel파일에서 그리드의 데이터에 footer가 있는지
 *            여부 <br>
 *            1 => footer 존재 <br>
 *            0 => 없음 <br>
 *            (그리드에 footer가 없으면 적용되지 않음)
 * @param {String}
 *            [options.append] [defalut: 0] excel파일에서 가져온 데이터를 그리드에 append시킬지 여부
 *            <br>
 *            1 => 현재 그리드에 데이터를 추가로 넣어줌 <br>
 *            0 => 현재 그리드의 데이터를 삭제하고 넣음)
 * @param {String}
 *            [options.hidden] [defalut: 0] 읽어들이려는 엑셀파일에 hidden column이 저장되어 있는지
 *            여부를 설정하는 int형 숫자<br>
 *            0 => 엑셀파일에 hidden 데이터가 없으므로 그리드 hidden column에 빈 데이터를 삽입 <br>
 *            1 => 엑셀파일에 hidden 데이터가 있으므로 엑셀 파일로부터 hidden 데이터를 삽입
 * @param {String}
 *            [options.fillHidden] [defalut: 0] Grid에 hiddenColumn에 빈 값을 넣을지를
 *            결정하기 위한 int형 숫자<br>
 *            1 => hidden Column에 빈 값을 저장하지 않음 <br>
 *            0 => hiddcolumn이 저장되어있지 않은 Excel File이라 간주하고 hidden Column에 값을 넣어줌
 *            <br>
 *            (hidden이 0인 경우에는 fillhidden은 영향을 끼치지 않음)
 * @param {String}
 *            [options.skipSpace] [defalut: 0] 공백무시 여부 <br>
 *            1 => 무시 <br>
 *            0 => 포함
 * @param {String}
 *            [options.insertColumns] radio, checkbox와 같은 컬럼을 엑셀에서 받아 오지 않고 <br>
 *            사용자 컬럼 설정 으로 업로드 ( 데이터 구조 : [ { columnIndex:1, columnValue:"1" } ] )
 * @param {String}
 *            [options.popupUrl] 업로드시에 호출할 popup의 url
 * @param {String}
 *            [options.status] [defalut: R]업로드된 데이터의 초기 상태값, 설정하지 않으면 "R"로 설정되며
 *            "C"값을 설정 할 수 있다.
 * @param {String}
 *            [options.pwd] 엑셀파일에 암호가 걸려 있는 경우, 비밀번호
 * @memberOf com
 * @author InswaveSystems
 * @example var options = { type : "0" ,sheetNo : 0 };
 *          com.uploadExcel(grd_basicInfo, options);
 */
com.uploadExcel = function(grdObj, options) {
    var options = {
        type : options.type || "0", // String, 1이면 엑셀 파일이 그리드의 보이는 결과로 만들어져있을때
                                    // 0이면 엑셀 파일이 그리드의 실제 데이터로 구성되어있을때
        sheetNo : options.sheetNo || 0, // Number, excel파일에서 그리드의 데이터가 있는
                                        // sheet번호
        startRowIndex : options.startRowIndex || 1, // Number, [defalut:0]
                                                    // excel파일에서 그리드의 데이터가 시작되는
                                                    // 행의 번호(헤더 포함)
        startColumnIndex : options.startColumnIndex || 0, // Number,
                                                            // [defalut:0]
                                                            // excel파일에서 그리드의
                                                            // 데이터가 시작되는 열의 번호
        endColumnIndex : options.endColumnIndex || 0, // Number, [defalut: 0]
                                                        // excel파일에서 그리드의 데이터가
                                                        // 끝나는 열의 index
        // ( 엑셀컬럼수가 그리드컬럼수 보다 작은 경우 그리드 컬러수를 설정)
        headerExist : options.headerExist || "0", // String, [defalut:0]
                                                    // excel파일에서 그리드의 데이터에
                                                    // header가 있는지 여부
        // (1이면 header 존재 0이면 없음)
        footerExist : options.footerExist || "1", // String, [defalut: 1]
                                                    // excel파일에서 그리드의 데이터에
                                                    // footer가 있는지 여부
        // (1이면 footer 존재 0이면 없음 기본값은 1 그리드에 footer가 없으면 적용되지 않음)
        append : options.append || "0", // String, [defalut: 0] excel파일에서 가져온
                                        // 데이터를 그리드에 append시킬지 여부
        // (1이면 현재 그리드에 데이터를 추가로 넣어줌 0이면 현재 그리드의 데이터를 삭제하고 넣음)
        hidden : options.hidden || "0", // String, [defalut: 0] 읽어들이려는 엑셀파일에
                                        // hidden column이 저장되어 있는지 여부를 설정하는 int형
                                        // 숫자(0이면
        // 엑셀파일에 hidden 데이터가 없으므로 그리드 hidden column에 빈 데이터를 삽입
        // 1 : 엑셀파일에 hidden 데이터가 있으므로 엑셀 파일로부터 hidden 데이터를 삽입 )
        fillHidden : options.fillHidden || "0", // String, [defalut: 0] Grid에
                                                // hiddenColumn에 빈 값을 넣을지를 결정하기
        // 위한 int형 숫자(1이면 hidden Column에 빈 값을 저장하지 않음,0이면 hidden
        // column이 저장되어있지 않은 Excel File이라 간주하고 hidden Column에 빈
        // 값을 넣어줌)(hidden이 0인 경우에는 fillhidden은 영향을 끼치지 않음)
        skipSpace : options.skipSpace || "0", // String, [defalut: 0] 공백무시
                                                // 여부(1이면 무시 0이면 포함)
        insertColumns : options.insertColumns || "",// Array, radio, checkbox와
                                                    // 같은 컬럼을 엑셀에서 받아 오지 않고
        // 사용자 컬럼 설정 으로 업로드 ( 데이터 구조 : [ { columnIndex:1, columnValue:"1" } ] )
        popupUrl : options.popupUrl || "", // String, 업로드시에 호출할 popup의 url
        status : options.status || "R", // String, [defalut: R]업로드된 데이터의 초기 상태값,
                                        // 설정하지 않으면 "R"로 설정되며 "C"값을 설정 할 수 있다.
        pwd : options.pwd || "" // String, 엑셀파일에 암호가 걸려 있는 경우, 비밀번호
    };

    grdObj.advancedExcelUpload(options);

};

/**
 * 엑셀 CSV 업로드
 *
 * @date 2017.11.30
 * @param {Object}
 *            grdObj GridView Object
 * @param {Object}
 *            options JSON형태로 저장된 그리드의 엑셀 업로드 옵션
 * @param {String}
 *            [options.type] [default: 1, 0] 데이터 형태 (0이면 실 데이터 형태,1이면 display 표시
 *            방식)
 * @param {String}
 *            [options.header] [default: 1, 0] Grid header 존재 유무 (0이면 header
 *            row수를 무시하고 전부 업로드하고 1이면 header row수 만큼 skip한다.)
 * @param {String}
 *            [options.delim] [default: ','] CSV 파일에서 데이터를 구분할 구분자
 * @param {String}
 *            [options.escapeChar] CSV 데이터에서 제거해야 되는 문자셋 ( ex) '\'' )
 * @param {Number}
 *            [options.startRowIndex] [defalut: 0] csv파일에서 그리드의 데이터가 시작되는 행의 번호,
 *            startRowIndex가 설정되면, header 설정은 무시된다.
 * @param {String}
 *            [options.append] [defalut: 0, 1] csv파일에서 가져온 데이터를 그리드에 append시킬지
 *            여부(1이면 현재 그리드에 데이터를 추가로 넣어줌 0이면 현재 그리드의 데이터를 삭제하고 넣음)
 * @param {Number}
 *            [options.hidden] [defalut: 0, 1] hidden Column에 대한 저장 여부(0이면
 *            저장하지않음,1이면 저장)
 * @param {String}
 *            [options.fillHidden] [defalut: 0, 1] hidden Column에 빈 값을 넣을지를 결정하기
 *            위한 int형 숫자(1이면 hidden Column에 빈 값을 저장하지 않음,0이면 hidden column이
 *            저장되어있지 않은 csv File이라 간주하고 hidden Column에 빈 값을 넣어줌)(hidden이 0인 경우에는
 *            fillhidden은 영향을 끼치지 않음)
 * @param {String}
 *            [options.skipSpace] [defalut: 0, 1] 공백무시 여부(1이면 무시 0이면 포함)
 * @param {String}
 *            [options.expression] [defalut: 1, 0] expression 컬럼 데이터를 포함하고 있는지
 *            여부, 기본값은 미포함(1이면 미포함, 0이면 포함)
 * @param {String}
 *            [options.popupUrl] 업로드시에 호출할 popup의 url
 * @memberOf com
 * @author InswaveSystems
 * @example var gridId = "grd_AdvancedExcel"; var options = {}; com.uploadCSV(
 *          gridId, options); //return 예시) 엑셀 파일(.CSV) 업로드
 */
com.uploadCSV = function(grdObj, options) {
    var options = {
        type : options.type || "0", // String, [default: 1, 0]데이터 형태 (0이면 실 데이터
                                    // 형태,1이면 display 표시 방식)
        header : options.header || "0", // String, [default: 1, 0]Grid header 존재
                                        // 유무 (0이면 header row수를 무시하고 전부 업로드하고
                                        // 1이면 header row수 만큼 skip한다.)
        delim : options.delim || ",", // String, [default: ',']CSV 파일에서 데이터를
                                        // 구분할 구분자
        escapeChar : options.escapeChar || "", // String, CSV 데이터에서 제거해야 되는 문자셋
                                                // ( ex) '\'' )
        startRowIndex : options.startRowIndex || 0, // Number, [defalut: 0]
                                                    // csv파일에서 그리드의 데이터가 시작되는 행의
                                                    // 번호, startRowIndex가 설정되면,
                                                    // header 설정은 무시된다.
        append : options.append || "0", // String, [defalut: 0, 1]csv파일에서 가져온
                                        // 데이터를 그리드에 append시킬지 여부(1이면 현재 그리드에
                                        // 데이터를 추가로 넣어줌 0이면 현재 그리드의 데이터를 삭제하고
                                        // 넣음)
        hidden : options.hidden || 1, // Number, [defalut: 0, 1]hidden Column에
                                        // 대한 저장 여부(0이면 저장하지않음,1이면 저장)
        fillHidden : options.fillHidden || "0", // String, [defalut: 0, 1]hidden
                                                // Column에 빈 값을 넣을지를 결정하기 위한
                                                // int형 숫자(1이면 hidden Column에 빈
                                                // 값을 저장하지 않음,0이면 hidden column이
                                                // 저장되어있지 않은 csv File이라 간주하고
                                                // hidden Column에 빈 값을
                                                // 넣어줌)(hidden이 0인 경우에는
                                                // fillhidden은 영향을 끼치지 않음)
        skipSpace : options.skipSpace || "0", // String, [defalut: 0, 1]공백무시
                                                // 여부(1이면 무시 0이면 포함)
        expression : options.expression || "1", // String, [defalut: 1,
                                                // 0]expression 컬럼 데이터를 포함하고 있는지
                                                // 여부, 기본값은 미포함(1이면 미포함, 0이면 포함)
        popupUrl : options.popupUrl || "" // String, 업로드시에 호출할 popup의 url
    }
    grdObj.readCSV(options);
};

/**
 * statusCode값에 따라 message를 출력한다.
 *
 * @private
 * @date 2016.08.09
 * @param {Object}
 *            resultData 상태코드값 및 메시지가 담긴 JSON.
 * @param {String}
 *            resultData.message 메시지
 * @param {String}
 *            resultData.statusCode 상태코드값
 * @memberOf com
 * @author InswaveSystems
 */
com.resultMsg = function(resultData) {
    resultData.message = resultData.message || "";
    var msgCode = gcm.MESSAGE_CODE;

    switch (resultData.statusCode) {
    case msgCode.STATUS_ERROR:
        if (resultData.errorCode == "E0001") {
            this.alert("[common.js][com.resultMsg] " + resultData.message + " 로그인 화면으로 이동하겠습니다.", "com.goHome");
        } else if (resultData.errorCode == "E9998") { // HTTP ERROR
                                                        // ex)404,500,0
            resultData.message = resultData.message;
        } else if (resultData.errorCode == "E9999") { // business logic error
            resultData.message = resultData.message;
        }
        break;
    case "N":
        resultData.statusCode = msgCode.STATUS_ERROR;
        resultData.message = "서버가 정지된 상태입니다. 자세한 내용은 관리자에게 문의하시기 바랍니다.";
        break;
    default:
    }
};

/**
 * Alert 메시지 창을 호출한다.
 *
 * @date 2017.12.30
 * @memberOf com
 * @param {String}
 *            messageStr 메시지
 * @param {String}
 *            closeCallbackFncName 콜백 함수명
 * @author Inswave Systems
 * @example com.alert("우편번호를 선택하시기 바랍니다."); com.alert("우편번호를 선택하시기 바랍니다.",
 *          "scsObj.alertCallBack");
 */
com.alert = function(messageStr, closeCallbackFncName) {
    this.messagBox("alert", messageStr, closeCallbackFncName);
};

/**
 * 메세지 팝업을 호출한다.
 *
 * @date 2017.12.30
 * @param {String}
 *            messageType 팝업창 타입 (alert || confirm)
 * @param {String}
 *            messageStr 메시지
 * @param {String}
 *            closeCallbackFncName 콜백 함수명
 * @param {Boolean}
 *            isReturnValue Confirm 창인 경우 선택 결과(boolean)을 반환할지 여부
 * @param {String}
 *            title 팝업창 타이틀
 * @memberOf com
 * @author Inswave Systems
 * @example //alert창을 띄울 경우 scsObj.callback = function(){ console.log("콜백
 *          함수입니다."); }; com.messagBox("alert", "보낼 메시지", "callback", false, "팝업
 *          타이틀");
 *
 * //confirm창을 띄울 경우 scsObj.callback = function(){ console.log("콜백 함수입니다."); };
 * com.messagBox("confirm", "보낼 메시지", "callback", true, "팝업 타이틀");
 * //isReturnValue속성에 false 사용가능
 */
com.messagBox = function(messageType, messageStr, closeCallbackFncName,
        isReturnValue, title) {
    var messageStr = messageStr || "";
    var messageType = messageType || "alert";
    var defaultTitle = null;
    var popId = messageType || "Tmp";
    popId = popId + this.MESSAGE_BOX_SEQ++;

    if (messageType === "alert") {
        defaultTitle = "Alert";
    } else {
        defaultTitle = "Confirm";
    }

    if (typeof isReturnValue === "undefined") {
        isReturnValue = false;
    }

    var dataObject = {
        type : "json",
        data : {
            "message" : messageStr,
            "callbackFn" : closeCallbackFncName,
            "isReturnValue" : isReturnValue,
            "messageType" : defaultTitle
        },
        name : "message_param"
    };
    var options = {
        id : popId,
        popupName : "결과",
        title : title || defaultTitle,
        width : 340,
        height : 150
    };
    this.openPopup(gcm.CONTEXT_PATH + "/cm/common/message_box.xml", options,
            dataObject);
};

/**
 * Confirm 메시지 창을 호출한다.
 *
 * @date 2016.10.09
 * @memberOf com
 * @param {String}
 *            messageStr 메시지
 * @param {String}
 *            closeCallbackFncName 콜백 함수명
 * @author Inswave Systems
 * @example com.confirm("변경된 코드 그룹 정보를 저장하시겠습니까?",
 *          "scsObj.saveCodeGrpConfirmCallback"); com.confirm("하위에 새로운 조직을
 *          추가하시겠습니까?", "scsObj.insertConfirmCallBack");
 */
com.confirm = function(messageStr, closeCallbackFncName) {
    this.messagBox("confirm", messageStr, closeCallbackFncName);
};

/**
 * 팝업창을 닫는다. callbackStr을 이용하여 부모창의 callback함수를 호출한다.
 *
 * @date 2016.10.09
 * @memberOf com
 * @param {String}
 *            popId popup창 id로 값이 없을 경우 현재창의 아이디(this.popupID) close.
 * @param {String}
 *            [callbackStr] callbackFunction명으로 부모 객체는 opener || parent으로 참조한다.
 *            opener || parent가 없을 경우 window 참조.
 * @param {String}
 *            [returnValue] callbackFunction에 넘겨줄 파라메터로 String타입을 권장한다.
 * @author Inswave Systems
 * @example com.closePopup(); com.closePopup("zipPopup");
 *          com.closePopup("zipPopup", "scsObj.zipPopupCallback" ,
 *          '{message:"정상처리되었습니다"}'); com.closePopup("zipPopup",
 *          "scsObj.zipPopupCallback" , '정상처리되었습니다.');
 */
com.closePopup = function(popId, callbackFnStr, retObj, callbackYn, selectedIdx) {
    var winobj = opener || parent;
     if (gcm.USER_LINK_YN == com.getUserId() + "_Y") {
         winobj = parent;
     }

     if (popId.indexOf("mainContainer") == -1) {
         winobj = parent;
     }

    //this._closePopup(popId, callbackFnStr, this.strSerialize(retObj), window); // IFrame일
    this._closePopup(popId, callbackFnStr, this.strSerialize(retObj), winobj); // IFrame일
                                                                                // 경우,
                                                                                // 메모리릭을
                                                                                // 없애기
                                                                                // 위한
                                                                                // 코딩.
                                                                                // (부모/자식
                                                                                // 간
                                                                                // 페이지로
                                                                                // 객체
                                                                                // 파라미터
                                                                                // 전달
                                                                                // 방식은
                                                                                // 비권장.
                                                                                // 문자열
                                                                                // 전달
                                                                                // 권장.)
};

com._closePopup = function(popId, callbackFnStr, retStr, winObj) {
//debugger;
	
    var nowObj = opener || this;
    if (gcm.USER_LINK_YN == com.getUserId() + "_Y") {
        nowObj = this;
     }

    if (popId.indexOf("mainContainer") == -1) {
        nowObj = this;
    }
    if ((typeof callbackFnStr !== "undefined") && (callbackFnStr !== "")) {
        //var func = winObj.WebSquare.util.getGlobalFunction(callbackFnStr);
        var func = WebSquare.util.getGlobalFunction(callbackFnStr); // 2019-01-10 : 문석길 : winObj.WebSquare 대신 WebSquare 사용함.

        if (func) {
                func(com.getJSON(retStr));
                $p.closePopup(popId); // 2019-01-10 : 문석길 : nowObj.$p.closePopup(popId) 대신 $p.closePopup(popId) 사용함.
        } else {
                if (winObj.$p.getParameter("w2xPath") !== winObj.parent.$p
                        .getParameter("w2xPath")) {
                    nowObj._closePopup(popId, callbackFnStr, retStr, winObj.parent);
                    return;
                }
                
                // 2019-01-04 : nowObj.$p 값이 없는 경우가 있어서 방어로직 넣었음. (법인카드 비밀번호 확인창)
                if (! com.isEmpty(nowObj.$p)) {
                    nowObj.$p.closePopup(popId);
                } else {
                    $p.closePopup(popId);
                }
        }

    } else {
        if (! com.isEmpty(nowObj.$p)) {
            nowObj.$p.closePopup(popId);
        } else {
            $p.closePopup(popId);
        }
    }
};

/**
 *
 * 팝업창을 연다.
 *
 * @date 2016.10.09
 * @param {String}
 *            url url 화면경로
 * @param {Array}
 *            options Popup창 옵션
 * @param {String}
 *            [options.id] Popup창 아이디
 * @param {String}
 *            [options.type] 화면 오픈 타입 ("iframePopup", "wframePopup",
 *            "browserPopup")
 * @param {String}
 *            [options.width] Popup창 넓이
 * @param {String}
 *            [options.height] Popup창 높이
 * @param {String}
 *            [options.popupName] useIframe : true시 popup 객체의 이름으로 popup 프레임의
 *            표시줄에 나타납니다.
 * @param {String}
 *            [options.useIFrame] [default : false] true : IFrame 을 사용하는
 *            WebSquare popup / false: window.open 을 사용하는 popup
 * @param {String}
 *            [options.style] Popup의 스타일을 지정합니다. 값이 있으면 left top width height는
 *            적용되지 않습니다.
 * @param {String}
 *            [options.resizable] [default : false]
 * @param {String}
 *            [options.modal] [default : false]
 * @param {String}
 *            [options.scrollbars] [default : false]
 * @param {String}
 *            [options.title] [default : false]
 * @memberOf com
 * @author Inswave Systems
 * @example var dataObj = { id : "I0001", deptCd : "DS001" }; var options = {};
 *          com.openPopup("/template/common/xml/zzAlertPop.xml", options,
 *          dataObj);
 *
 * var dataObj = { type : "json", data : { data : dma_Authority.getJSON(),
 * callbackFn : "scsObj.insertMember" }, name : "authObj" }; var options = { id :
 * "AuthorityMemberPop", popupName : "직원 조회", modal : true, width : 560, height:
 * 400 }; com.openPopup("/ui/BM/BM002P01.xml", options, dataObj);
 */
com.openPopup = function(url, opt, dataObj) {
    this._openPopup(url, opt, dataObj);
};

com._openPopup = function(url, opt, dataObj) {
    var _dataObj = dataObj || {};
    _dataObj.data = _dataObj.data || {};

    var width = opt.width || 500;
    var height = opt.height || 500;

    var top = ((document.body.offsetHeight / 2) - (parseInt(height) / 2) + $(
            document).scrollTop())
            + "px";
    var left = ((document.body.offsetWidth / 2) - (parseInt(width) / 2) + $(
            document).scrollLeft())
            + "px";

    if (typeof _dataObj.data.callbackFn === "undefined") {
        _dataObj.data.callbackFn = "";
    } else if (_dataObj.data.callbackFn.indexOf("gcm") !== 0) {
        _dataObj.data.callbackFn = _dataObj.data.callbackFn;
        // _dataObj.data.callbackFn = this.$p.id + _dataObj.data.callbackFn;
    }

    var options = {
        // id : this.$p.id + opt.id,
        id : opt.id,
        type : opt.type || "wframePopup",
        width : width + "px",
        height : height + "px",
        top : opt.top || top || "140px",
        left : opt.left || left || "500px",
        popupName : opt.popupName || '',
        title : opt.title || "",
        modal : (opt.modal == false) ? false : true,
        useIFrame : opt.useIFrame || false,
        dataObject : _dataObj, // litewindow 에서 사용 가능 기능
        alwaysOnTop : opt.alwaysOnTop || false,
        useModalStack : (opt.useModalStack == false) ? false : true,
        resizable : (opt.resizable == false) ? false : true,
        useMaximize : opt.useMaximize || false
    };

    $p.openPopup(url, options);

    if(options.type != "window" && !opt.useHeader){
        $("#"+options.id).addClass("no_header");
    }

    if(options.dataObject.name == "POPUP_DATA"){
        // 버튼에 포커스 주기
        setTimeout(function(){
            //$("#"+options.id+" .con")[0].focus();
         var _comp = $p.comp[$("#"+options.id+" .con")[0].id]

           _comp.focus();
        },300);
        /*
        //$("#"+options.id+" .con")[0].focus();
         var _comp = $p.comp[$("#"+options.id+" .con")[0].id]

        _comp.focus();
         */
    }



    // this.$p.openPopup(url, options);

};

com.openPopup_R = function(url, opt, dataObj) {
    this._openPopup_R(url, opt, dataObj);
};

com.popup_popId = "";
com.popup_popCallBack = "";
com.popup_pframeId = "";
com.popup_pType = "";

// 열리는 팝업에서 파라미터를 받습니다.
com.popup_param = function() {

var rtnObj = null;
    if(!$p.isWFramePopup() && $p.isPopup()){
    	//window popup
        this.popup_popId = this.$p.getParameter("popupID");
        
        if (typeof JSON.parse(this.$p.getParameter("paramObj")).callbackFn === "undefined") {
        	this.popup_popCallBack = "";
        }else{
        	this.popup_popCallBack = JSON.parse(this.$p.getParameter("paramObj")).callbackFn;
        }
        
        rtnObj = JSON.parse(this.$p.getParameter("paramObj"));

    }else{
    	this.popup_popId = this.$p.getParameter("popupID");
    	
    	if (typeof this.$p.getParameter("paramObj").callbackFn === "undefined") {
        	this.popup_popCallBack = "";
        }else{
        	this.popup_popCallBack = this.$p.getParameter("paramObj").callbackFn;
        }
    	
        rtnObj = this.$p.getParameter("paramObj");
    }

    return rtnObj;
};

com.popup_data = function() {
	
    var rtnObj = null;

    //alert("$p.isWFramePopup()="+$p.isWFramePopup() + "  $p.isPopup()=" + $p.isPopup());
    
    if(!$p.isWFramePopup() && $p.isPopup()){
        //window popup
    	
    	if(this.$p.getParameter("popupID") == undefined){
    		rtnObj= "";
    	}else{
    		this.popup_popId = this.$p.getParameter("popupID");
            var _jsn = this.$p.getParameter("paramObj");
            if(!com.isJSON(_jsn)){
                _jsn = JSON.parse(_jsn);
            }
            
            if (typeof _jsn.callbackFn === "undefined") {
            	this.popup_popCallBack = "";
            }else{
            	this.popup_popCallBack = _jsn.callbackFn;
            }
            
            rtnObj = _jsn.data; 
    	}
    	
        
     
    }else{
    	
    	if(this.$p.getParameter("popupID") == undefined){
    		rtnObj= "";
    	}else{
    		this.popup_popId = this.$p.getParameter("popupID");
            
    		if (typeof this.$p.getParameter("paramObj").callbackFn === "undefined") {
            	this.popup_popCallBack = "";
            }else{
            	this.popup_popCallBack = this.$p.getParameter("paramObj").callbackFn;
            }
    		
            rtnObj = this.$p.getParameter("paramObj").data;
    	}
    }
    
    
    return rtnObj || "{}";
};
//sessionStorage.getItem("browser_Param"

com.popup_close = function(val) {
	//debugger;
	
    if (this.popup_popCallBack) {
        this.closePopup(this.popup_popId, this.popup_popCallBack, val);
    }
    this.closePopup(this.popup_popId);
};

com._openPopup_R = function(url, opt, dataObj) {
    var _dataObj = dataObj || {};
    _dataObj.data = _dataObj.data || {};

    var width = opt.width || 500;
    var height = opt.height || 500;

    var top = ((document.body.offsetHeight / 2) - (parseInt(height) / 2) + $(
            document).scrollTop())
            + "px";
    var left = ((document.body.offsetWidth / 2) - (parseInt(width) / 2) + $(
            document).scrollLeft())
            + "px";

    if (typeof _dataObj.data.callbackFn === "undefined") {
        _dataObj.data.callbackFn = "";
    } else if (_dataObj.data.callbackFn.indexOf("gcm") !== 0) {
        _dataObj.data.callbackFn = this.$p.id + _dataObj.data.callbackFn;
    }
    
    
    var popId = "";
    
    if(opt.popupIdUseYn == "Y"){
    	popId = opt.id;
    }else{
    	popId = this.$p.id + opt.id;
    }
    
    
    opt.frameMode = "wframe";

    if(opt.type == "window"){
        opt.useIFrame = false;
        opt.frameMode = "";
        sessionStorage.setItem("winpopParam", JSON.stringify({popId:popId,opt:opt,dataObj:dataObj,s_path:url}));
    }

    var options = {
        id : popId,
        //id : opt.id,
        type : opt.type || "wframePopup",
        width : width + "px",
        height : height + "px",
        top : opt.top || top || "140px",
        left : opt.left || left || "500px",
        popupName : opt.popupName || '',
        title : opt.title || "",
        modal : (opt.modal == false) ? false : true,
        useIFrame : opt.useIFrame || false,
        dataObject : _dataObj, // litewindow 에서 사용 가능 기능
        alwaysOnTop : opt.alwaysOnTop || false,
        useModalStack : (opt.useModalStack == false) ? false : true,
        resizable : (opt.resizable == false) ? false : true,
        useMaximize : opt.useMaximize || false,
        frameMode : opt.frameMode,
        method : "post",
        popupUrl : gcm.popup_open_URL || "popup.html"

    };


    this.$p.openPopup(url, options);


    // 이후에 설정되어야함..
    if(options.type != "window" && !opt.useHeader){
        $("#"+options.id).addClass("no_header");
    }
    if(options.type == "window"){
        $("#"+options.id).addClass("winpop");
    }

    if(options.type == "litewindow" && opt.useHeader){
        $("#"+options.id).addClass("black_title");
        if($("#"+options.id).position().top < 0){
            $("#"+options.id).css("top",100);

        }
    }

    if(popId.indexOf("gridsearch") > -1){
        var _popObj = $("#"+options.id);
        var iw = _popObj.width();
        var ih = _popObj.height();
        var grdOffset = $("#"+_dataObj.data.data.grd).offset();
        var grdWidth = $("#"+_dataObj.data.data.grd).width();
        _popObj.offset({top:grdOffset.top -(ih+10),left:(grdWidth/2-iw/2)+grdOffset.left });
    }

    var p_id = this.popup_pframeId;
    
    if(opt.closeAction){
        var _tPopArr = $(".w2window_close");
        for(var c = 0;c < _tPopArr.length;c++){
            var _pObj = _tPopArr[c];
            if(_pObj.id.indexOf(popId) > -1){
                _pObj.onclick = function(){
	            	var frame = $p.comp[p_id];
	                var tmpArr = opt.closeAction.split(".");
	                var _sObj = frame.getObj(tmpArr[0]);
	                _sObj[tmpArr[1]]();
	                  
	                if (opt.closeAction) {
	                	com.closePopup(popId, opt.closeAction, "");
	                  	
	                }else{
	                	com.closePopup(popId);
	                }
                };
            }

        }
    }
};

com.popup_closeAction = function(popId,callback){

    var cb = !com.isEmpty(callback) ? eval(callback):function(){};
    if(!com.isEmpty(cb))cb();
};
/**
 * 팝업창을 오픈합니다.
 *
 * @date 2018.08.10
 * @memberOf com
 * @param {String} url[필수] popup으로 열 화면의 화면 경로 포함한 파일 명이되겠습니다.
 * @param {String} callbackFn[옵션] 팝업창으로 부터 받을 콜백을 등록합니다. [default:""]
 * @param {String} data[옵션] 팝업창에 던질 데이터를 등록합니다.[default:""]
 * @param {String} width[옵션] 팝업창의 가로 크기.[default:"500"]
 * @param {String} height[옵션] 팝업창의 세로 크기.[default:"500"]
 * @param {String} type[옵션] 팝업창의 종류 window일경우만 기재.[default:"wframePopup"]
 * @param {String} popup_name[옵션] 팝업창의 종류가 window일경우 필수. 타이틀로 사용할 내용 기재.[default:""]
 *
 * @author Inswave Systems
 * @example
 *
 * // case 1) 팝업 화면만 띄우는경우[URL만 입력]
 * var popOps = {
 *                  url:"/ui/tom/smp/xml/test2.xml"
 *              };
 * com.popup_open(popOps);
 *
 * // case 2) 콜백을 포함하는 경우 [url,callbackFn ]
 *            - 팝업으로 부터 데이터를 받을경우
 *            - 팝업이 수행되고 나서 다른 프로세스를 수행하는경우
 * var popOps = {
 *                  url:"/ui/tom/smp/xml/test2.xml"
 *                  ,callbackFn : "scsObj.popCallback"
 *              };
 * com.popup_open(popOps);
 *
 * // case 3) 데이터를 전달 하는 경우 [url,data ]
 *
 * var popOps = {
 *                  url:"/ui/tom/smp/xml/test2.xml"
 *                  ,data : "팝업에 넘길 string 데이터" || {"팝업에 넘길 Json 데이터"}
 *              };
 * com.popup_open(popOps);
 *
 *
 * // case 4) 사이즈를 지정하고자 하는 경우 [url,width,height ]
 *
 * var popOps = {
 *                  url:"/ui/tom/smp/xml/test2.xml"
 *                  width:"450"
 *                  height:"300"
 *              };
 * com.popup_open(popOps);
 *
 * // case 5) window 팝업으로 호출하고자 하는 경우 [url,type,popup_name ]
 *
 * var popOps = {
 *                  url:"/ui/tom/smp/xml/test2.xml"
 *                  type:"window"
 *                  popup_name:"팝업 타이틀"
 *              };
 * com.popup_open(popOps);
 *
 * // case 6) browser 용 팝업으로 호출하는경우
 *
 * var popOps = {
 *                  url:"/ui/tom/smp/xml/test2.xml"
 *                  type:"browser"
 *                  modal : true || false
 *                  popup_name:"팝업 타이틀"
 *              };
 * com.popup_open(popOps);
 *
 *
 *
 */
com.popup_open = function(popOps) {

    if (!this.isEmpty(popOps)) {
        var _url = popOps.url;
        if (this.isEmpty(_url)) {
            alert("[common.js][com.popup_open] 팝업 파일경로가 없습니다.");
            return false;
        }
        var popId = _url.substring(_url.lastIndexOf("/") + 1, _url
                .lastIndexOf("."))
                + "_" + new Date().getTime();

        //추가
        //2023-08-03
        if(popOps.popupId != null && popOps.popupId != ""){
        	popId = popOps.popupId; 
        }
        
        var useYn = "N";
        if(popOps.popupIdUseYn != null && popOps.popupIdUseYn != ""){
        	useYn = popOps.popupIdUseYn; 
        }
        
        var pop_modal = true;
        var popName = popOps.popup_name || popId;
        if(popOps.type == "window"){
            popOps.useHeader = true;
            pop_modal = popOps.modal ;
        }
        var pop_type = "wframePopup";

        if(popOps.type == "browser"){
            pop_type = "window";
            pop_modal = popOps.modal ;
            if(!pop_modal){// modal less인경우 하나만 띄우도록
                popId = _url.substring(_url.lastIndexOf("/") + 1, _url.lastIndexOf("."));
            }
        }else if(popOps.type == "gridsearch"){
            pop_type = "wframePopup";
            popId = "gridsearch";
            popOps.useHeader = true;
            pop_modal = popOps.modal ;
        }
        
        var opt = {
            id : popId,
            popupIdUseYn : useYn,
            //confirmYn : popOps.confirmYn || "",
            //confirmCallBackFunc : popOps.confirmCallBackFunc || "",
            //confirmTxtMst : popOps.confirmTxtMst || "",
            popupName : popName,
            left : popOps.left,
            modal : pop_modal,
            width : popOps.width || 500,
            height : popOps.height || 500,
            type : pop_type,
            useHeader : popOps.useHeader || false
            ,closeAction : popOps.closeAction || ""
        };
        var dataObj = {
            type : "json",
            data : {
                data : popOps.data,
                callbackFn : popOps.callbackFn || ""
            },
            name : "paramObj"
        };

        this.popup_pframeId = this.getFrameId() || gcm.initWframeId;
        this.popup_pType = opt.type;
        this.openPopup_R(_url, opt, dataObj);



    } else {
        alert("[common.js][com.popup_open] 팝업을 열기위한 정보가 없습니다.");
    }
};


/**
 * 팝업창에 넘긴 데이터를 가져온다.
 *
 * @memberOf com
 * @returns {Object}
 */
com.getPopParam = function() {
    requires("uiplugin.popup");
    try {
        var popupParam = $p.getPopupParam();
        return JSON.parse(popupParam).data;
    } catch (e) {
        $p.log('!! exception occurred [com.getPopParam] ' + e.message);
        return {};
    } finally {
        popupParam = null;
    }
};


/**
 * 에러처리후 메인화면에서 포커스로 받을 컴포넌트 설정
 *
 * @date 2018.08.17
 * @memberOf com
 * @param {String} 컴포넌트ID
 * @author Inswave Systems
 * @example
 * com.setFocus("컴포넌트ID");
 */
com.setFocus = function(component) {
    if (com.isEmpty(component)) {
        return false;
    }
    gcm.FOCUS_COMPONENT = this.$p.id + component;

    // 2018-11-16 : 그리드뷰가 아닐 경우만 처리하도록 로직 보완함.
    var comp = $p.comp[gcm.FOCUS_COMPONENT];

    if (comp.getPluginName() == "gridView") {
        console.log(com.getPrintTime()+"[common.js][com.setFocus] 입력된 컴포넌트가 잘못되었습니다. ["
                                      +component+"] 컴포넌트는 ["+gridViewComp.getPluginName()+"] 입니다.");
        console.log(com.getPrintTime()+"[common.js][com.setFocus] (조치필요) "+com.getScrId()+".xml("+com.getMenuNm()
                                      +") 소스에서 com.setFocus 함수를 찾아서 첫번째 인자를 수정하세요!");
    } else {
        comp.focus();
    }

  //m_    console.log(com.getPrintTime()+"[common.js][com.setFocus] gcm.FOCUS_COMPONENT = " + gcm.FOCUS_COMPONENT);
}

/**
 * 에러처리후 메인화면의 그리드 컬럼에 포커스로 받을 컴포넌트 설정
 *
 * @date 2018.10.19
 * @memberOf com
 * @param {String} 그리드컴포넌트ID, 행번호, 열번호
 * @author Inswave Systems
 * @example
 * com.setFocusGrid("그리드컴포넌트ID", 행번호, 열번호);
 */
com.setFocusGrid = function(grdComponent, rowIndex, colIndex) {
    if (com.isEmpty(grdComponent)) {
        return false;
    }
    gcm.FOCUS_GRID_COMPONENT = this.$p.id + grdComponent;
    gcm.FOCUS_GRID_COMPONENT_ROW = WebSquare.util.parseInt(rowIndex, 0);
    gcm.FOCUS_GRID_COMPONENT_COL = WebSquare.util.parseInt(colIndex, 0);

    // 2018-11-16 : 그리드뷰 컴포넌트가 아닐 경우 로그출력하고, 값을 모두 지워버리도록 함.
    var gridViewComp = $p.comp[gcm.FOCUS_GRID_COMPONENT];

    if (gridViewComp.getPluginName() != "gridView") {

        console.log(com.getPrintTime()+"[common.js][com.setFocusGrid] 입력된 컴포넌트가 잘못되었습니다. ["
                                      +grdComponent+"] 컴포넌트는 ["+gridViewComp.getPluginName()+"] 입니다.");
        console.log(com.getPrintTime()+"[common.js][com.setFocusGrid] (조치필요) "+com.getScrId()+".xml("+com.getMenuNm()
                                      +") 소스에서 com.setFocusGrid 함수를 찾아서 첫번째 인자를 수정하세요!");

        gcm.FOCUS_GRID_COMPONENT = "";
        gcm.FOCUS_GRID_COMPONENT_ROW = 0;
        gcm.FOCUS_GRID_COMPONENT_COL = 0;
    }

  //m_    console.log(com.getPrintTime()+"[common.js][com.setFocusGrid] gcm.FOCUS_GRID_COMPONENT = "+gcm.FOCUS_GRID_COMPONENT+", ROW = "+gcm.FOCUS_GRID_COMPONENT_ROW+", COL = "+gcm.FOCUS_GRID_COMPONENT_COL);
}

/**
 * 레이어팝업에서 현재의 메인화면으로 포커스로 발생시킨다. (일반 컴포넌트용)
 *
 * @date 2018.11.16
 * @memberOf com
 * @param
 * @author Inswave Systems
 * @example
 * com.exeFocus();
 */
com.exeFocus = function() {

    // 메인화면으로 포커스 발생시킨다.
    if (! com.isEmpty(gcm.FOCUS_COMPONENT)) {

        // 2018-11-16 : 그리드뷰가 아닐 경우만 처리하도록 로직 보완함.
        var comp = $p.comp[gcm.FOCUS_COMPONENT];

        // 2018-12-12 : 반드시 comp의 null값을 검증하도록 한다. (화면전체가 다운됨)
        if (com.isEmpty(comp)) {
            ;
        } else {
            if (comp.getPluginName() != "gridView") {
                comp.focus();
            }
        }

        gcm.FOCUS_COMPONENT = "";
    }
}

/**
 * 레이어팝업에서 현재의 메인화면으로 포커스로 발생시킨다. (그리드뷰 컴포넌트용)
 *
 * @date 2018.11.16
 * @memberOf com
 * @param
 * @author Inswave Systems
 * @example
 * com.exeFocusGrid();
 */
com.exeFocusGrid = function() {

    // 메인화면으로 포커스 발생시킨다.
    if (! com.isEmpty(gcm.FOCUS_GRID_COMPONENT)) {

        // 2018-11-16 : 그리드뷰일 경우만 처리하도록 로직 보완함.
        var gridViewComp = $p.comp[gcm.FOCUS_GRID_COMPONENT];

        // 2018-12-12 : 반드시 comp의 null값을 검증하도록 한다. (화면전체가 다운됨)
        if (com.isEmpty(gridViewComp)) {
            ;
        } else {
            if (gridViewComp.getPluginName() == "gridView") {
                gridViewComp.setFocusedCell(gcm.FOCUS_GRID_COMPONENT_ROW, gcm.FOCUS_GRID_COMPONENT_COL, true);
            }
        }

        gcm.FOCUS_GRID_COMPONENT = "";
        gcm.FOCUS_GRID_COMPONENT_ROW = 0;
        gcm.FOCUS_GRID_COMPONENT_COL = 0;
    }
}

/**
 * 화면에서 메시지정보에 대한 레이어 팝업 창을 호출한다.
 *
 * @date 2018.08.13
 * @memberOf com
 * @param {String} msgId 메시지ID 8자리
 * @param {String} parmStr1-3 {0}{1}{2} 치환값
 * @author Inswave Systems
 * @example
 * com.message("ECTM0003", "모듈코드");
 */
com.message = function(msgId, parmStr1, parmStr2, parmStr3) {
    console.log(com.getPrintTime()+"[common.js][com.message] msgId = "+msgId+", parmStr1 = "+parmStr1+", parmStr2 = "+parmStr2+", parmStr3 = "+parmStr3);
    //debugger;
    
    //-----------------------------------------------------------------------------------------------------------------
    // □ 메시지코드 전체 정보 Datalist가 없을 경우 새로 생성한다.
    //-----------------------------------------------------------------------------------------------------------------
    if (typeof MSG_CODE_INF == "undefined") {
        com.createDataObj("dataMap", "MSG_CODE_INF_In", [ "LAN_G","SL_GMGO_MODL_C","MSG_K_G","MSG_TYP_G" ]);
        com.createDataObj("dataMap", "MSG_CODE_INF_Out", [ "TOT_CNT" ]);
        com.createDataObj("dataList", "MSG_CODE_INF", [ "MSG_ID","MSG_NM","SL_GMGO_MODL_C","MSG_K_G","MSG_TYP_G" ]);
        //console.log(com.getPrintTime()+"[common.js][com.message] MSG_CODE_INF Datalist가 없어서 새로 생성하였습니다.");
    }

    //-----------------------------------------------------------------------------------------------------------------
    // □ 메시지코드 전체 정보가 없을 경우, 서버에서 데이터를 조회한다.
    //-----------------------------------------------------------------------------------------------------------------
    if (MSG_CODE_INF.getTotalRow() == 0) {
    	
    	//debugger;

        //console.log(com.getPrintTime()+"[common.js][com.message] 메시지코드 전체 정보가 없습니다. 재적재합니다.");

        // 메시지코드 전체 정보를 조회한다. (
        MSG_CODE_INF_In.set("LAN_G"         , gcm.LAN_G           ); // 언어구분
        MSG_CODE_INF_In.set("SL_GMGO_MODL_C", com.getSlGmgoModlC()); // 서울시금고모듈코드

        // 메시지종류구분 N:정상, E:에러, I:정보, W:경고, C:확인
        //MSG_CODE_INF_In.set("MSG_K_G"       , "");
        // 메시지타입구분 1:화면메시지, 2:채널메시지, 3:대외메시지
        //MSG_CODE_INF_In.set("MSG_TYP_G"     , "");

        var msgCdSearchOption = {
            mode : "synchronous",   // asynchronous, synchronous
            id : "sbm_MsgCdSearch",
            ref : 'data:json,[MSG_CODE_INF_In]',
            target : 'data:json,[{"id":"MSG_CODE_INF","key":"MSFI020201R99OutList"}]',
            userData1 : [{svc_id:"SSFI020201R99", msg_id:"MSG_CODE_INF_In", sbm_id:"sbm_MsgCdSearch", isshowMsg:true}]
        };

        msgCdSearchOption.submitDoneHandler = function(e) {
            //console.log(com.getPrintTime()+"[common.js][com.message] 조회된 메시지코드 전체 건수는 "+MSG_CODE_INF.getTotalRow()+"건 입니다.");
            com.messageProcess(msgId, parmStr1, parmStr2, parmStr3);
        }
        msgCdSearchOption.submitErrorHandler = function(e) {
            console.log(com.getPrintTime()+"[common.js][com.message] 메시지코드 전체 조회 오류발생!!!");
        }
        gcm.IS_TR = true;
        this.executeSubmission_dynamic(msgCdSearchOption);
    } else {
        //console.log(com.getPrintTime()+"[common.js][com.message] 메시지코드 전체 정보가 이미 존재합니다. 총건수 = "+MSG_CODE_INF.getTotalRow());
        com.messageProcess(msgId, parmStr1, parmStr2, parmStr3);
    }
};

/**
 * com.messageProcess
 * com.message에서 분기처리하는 함수
 *
 * @date 2018.12.27
 * @memberOf com
 * @param {String} msgId 메시지ID 8자리
 * @param {String} parmStr1-3 {0}{1}{2} 치환값
 * @author Inswave Systems
 * @example
 * com.message("ECTM0003", "모듈코드");
 */
com.messageProcess = function(msgId, parmStr1, parmStr2, parmStr3) {

    var msgKind = "E";  // 초기값 Error로 설정
    var msgStr  = "";
    var closeCallbackFncName = gcm.CONFIRM_CALLBACK;

    //-----------------------------------------------------------------------------------------------------------------
    // □ 메시지ID가 없을 경우 경고 메시지 처리한다.
    //-----------------------------------------------------------------------------------------------------------------
    if (com.isEmpty(msgId)) {
        msgStr = "메시지코드가 없습니다.";
    }

    msgKind = msgId.substr(0,1);
  //m_    console.log(com.getPrintTime()+"[common.js][com.message] msgKind = "+msgKind);

    //-----------------------------------------------------------------------------------------------------------------
    // □ 비정상 메시지종류일 경우 경고메시지를 자체 조립한다.
    //-----------------------------------------------------------------------------------------------------------------
    if (msgKind == "N" || msgKind == "E" || msgKind == "W" || msgKind == "I" || msgKind == "C" || msgKind == "A") {
        // SKIP
    } else {
        msgStr = "메시지코드는 N:정상, E:에러, W:경고, I:정보, C:확인, A:그리드만 사용 가능합니다.";
    }

    // 메시지코드 전체 정보를 조회하지 못 한 경우 에러처리 한다.
    if (MSG_CODE_INF.getTotalRow() == 0) {
        msgStr = "메시지코드 정보를 읽어올 수 없습니다.";
    }
    
    //debugger;

    // 메시지내용이 없을 경우 메시지ID를 검색하여 메시지내용을 가져온다.
    if (com.isEmpty(msgStr)) {

        // 메시지코드 전체 정보가 메모리에 로드되어 있는 경우
        for (i = 0; i < MSG_CODE_INF.getTotalRow(); i++) {
        	console.log("***********"+ msgId+" / "+MSG_CODE_INF.getColData("MSG_ID")[i]);
            if (MSG_CODE_INF.getColData("MSG_ID")[i] == msgId) {
                msgStr = MSG_CODE_INF.getColData("MSG_NM")[i];
                //debugger;
                break;
            }
        }

        // {0}{1}{2} 에 대한 파라미터를 변환한다.
        msgStr = msgStr.replace("{0}", parmStr1);
        msgStr = msgStr.replace("{1}", parmStr2);
        msgStr = msgStr.replace("{2}", parmStr3);

    }

  //m_    console.log(com.getPrintTime()+"[common.js][com.message] 변환후 msgId = "+msgId+", msgStr = "+msgStr);

    //-----------------------------------------------------------------------------------------------------------------
    // 메시지종류중 '정상(N)'일 경우 하단바에 표시하고, 그 외에는 레이어 팝업으로 처리한다.
    //-----------------------------------------------------------------------------------------------------------------
    if (msgKind == "N") {
        // 하단바 컴포넌트가 존재할 경우만 set 한다. (개별화면 직접 호출시 하단바가 없음!!!)
        var tbxObj = gcm.mainFrame.getObj("tbx_MSG_BAR_CTNT");
        var tbxGrpObj = gcm.mainFrame.getObj("grp_MSG_BAR");

        if (! com.isEmpty(tbxObj)) {
            tbxObj.setValue(msgStr);
            tbxGrpObj.show(); // 하단바를 보여준다.
        }
    } else {
        var h = 0;
        var w = '482';
        if (msgKind == "E") {
        	h = "388";
        } else if (msgKind == "I") {
        	h = "408";
        } else {
            h = "385";
        }

        // 화면에서 직접 메시지 팝업을 사용할 경우
        //var messageStr = "<span style=\"color: #333333; font-size: 13px; font-weight: bold;\">"
        //               + msgStr
        //               + "</span>"
        //               + "<br>"
        //               + "<span style=\"color: #888888; font-size: 12px;\">"
        //               + "["+msgId+"]"
        //               + "</span>";
        var messageStr = {MSG_DATA:msgStr, MSG_C:msgId};

        var options = { id : "Layer_popup_" + msgKind
                      , title : false, height : h,width:w };
        var dataObject = { type : "json", name : "POPUP_DATA", data : JSON.stringify(messageStr), "callbackFn" : closeCallbackFncName };

        // I:정보메시지, E:에러메시지, W:경고메시지, C:확인메시지, A:그리드조회
        var layerPopupName = "/uicom/common/Layer_popup_" + msgKind + ".xml";

        // 2018-12-19 : 동일한 ID의 레이어 팝업이 이미 있을 경우 기존 팝업을 close시키고 새로운 레이어 팝업을 띄운다.
        if (com.isEmpty($("#"+options.id))) {
            // 나머지 에러메시지는 레이어팝업을 띄운다.
            com.openPopup(layerPopupName, options, dataObject);
        } else {
            console.log(com.getPrintTime()+"[common.js][com.message] 기존 팝업이 존재하므로 종료후 새로운 팝업을 띄웁니다.");
            var comp = $p.comp[$("#"+options.id)[0].id];
            comp.close();

            // 나머지 에러메시지는 레이어팝업을 띄운다.
            setTimeout(function(){com.openPopup(layerPopupName, options, dataObject);}, 100);
        }
    }

    return true;
};

/**
 * 즐겨찾기 등록/삭제
 *
 * @date 2018.09.07
 * @private 변상필
 * @memberOf com
 * @param {String} str 문자열
 * @returns {Boolean} true : 종성이 존재, false 그외
 */
com.setBkmk = function(jsnData) {


    var bkmkG = jsnData.BKMK_ON; //즐겨찾기 off 이면 등록 처리, on 이면 삭제 처리

    // 즐겨찾기 등록처리
    scsObj.parentControl = this.parentControl;
    
  
    if (bkmkG == "0") {
        //grp.addClass("on");
        //this.parentControl.addClass("on");
        if (typeof MSFI010603C01In == "undefined") {
            com.createDataObj("dataMap", "MSFI010603C01In", [ "SL_GMGO_MODL_C","USER_ID","MENU_ID","SCR_ID","USE_YN" ]);
            com.createDataObj("dataMap", "MSFI010603C01Out", [ "SL_GMGO_MODL_C","USER_ID","MENU_ID","SCR_ID","USE_YN" ]);
        }
        MSFI010603C01In.set( "SL_GMGO_MODL_C" , com.getSlGmgoModlC() );
        MSFI010603C01In.set( "USER_ID" , com.getUserId() );
        MSFI010603C01In.set( "MENU_ID" , jsnData.MENU_ID );
        MSFI010603C01In.set( "SCR_ID" , jsnData.SCR_ID );
        MSFI010603C01In.set( "USE_YN" , "Y" );

        var BkmkInsertOption = {
            mode : "synchronous",   // asynchronous, synchronous
            id : "sbm_BkmkInsert",
            ref : 'data:json,[MSFI010603C01In]',
            target : 'data:json,[MSFI010603C01Out]',
            userData1 : [{svc_id:"SSFI010603C01", msg_id:"MSFI010603C01In", sbm_id:"sbm_BkmkInsert", isshowMsg:true}]
        };

        BkmkInsertOption.submitDoneHandler = function(e) {
            //별표 on 처리
            scsObj.parentControl.addClass("on");
            

            //두번 이상 별표클릭시 별표 데이터 on 처리
            var _comp = $p.comp[$("#"+scsObj.parentControl.id+" .fvr-group")[0].id];
            
            var _compUserData = JSON.parse(_comp.getUserData("menuInfo"));
            _compUserData.BKMK_ON = "1";
            _comp.setUserData("menuInfo",JSON.stringify(_compUserData));

        }
        gcm.IS_TR = true;
        this.executeSubmission_dynamic(BkmkInsertOption);


    // 삭제처리
    } else {
        //grp.addClass("");
        //this.parentControl.removeClass("on");
    	
    	
        MSFI010603D01In.set( "SL_GMGO_MODL_C" , com.getSlGmgoModlC() );
        MSFI010603D01In.set( "USER_ID" , com.getUserId() );
        MSFI010603D01In.set( "MENU_ID" , jsnData.MENU_ID );
        MSFI010603D01In.set( "SCR_ID" , jsnData.SCR_ID );
        var svcObj = {svc_id:"SSFI010603D01", msg_id:"MSFI010603D01In", sbm_id:"sbm_Delete_Click", isshowMsg:true};

        com.executeSvc(svcObj);  //서비스 호출
    }

    return true;
};

/**
 * 종성이 존재하는지 여부를 검사한다.
 *
 * @date 2018.01.15
 * @private
 * @memberOf com
 * @param {String}
 *            str 문자열
 * @returns {Boolean} true : 종성이 존재, false 그외
 */
com._isFinalConsonant = function(str) {
    var code = str.charCodeAt(str.length - 1);
    if ((code < 44032) || (code > 55197)) {
        return false;
    }
    if ((code - 16) % 28 == 0) {
        return false;
    }
    return true;
};

/**
 * 그룹안에 포함된 컴포넌트의 입력 값에 대한 유효성을 검사한다. 컴포넌트 속성 유효성 검사를 수행하고, valInfoArr 유효성 검사
 * 옵션에 대해서 유효성 검사를 수행한다. valInfoArr 유효성 검사 옵션 파라미터를 전달하지 않은 경우 컴포넌트
 * 속성(mandatory, allowChar, ignoreChar, maxLength, maxByteLength, minLength,
 * minByteLength)에 대해서만 유효성 검사를 수행한다.
 *
 * @date 2018.01.19
 * @memberOf com
 * @param {Object}
 *            grpObj 그룹 컴포넌트 객체
 * @param {Object[]}
 *            options 유효성 검사 옵션 <br/>
 * @param {String}
 *            options[].id : 유효성 검사 대상 DataCollection 컬럼 아이디 <br/>
 * @param {Boolean}
 *            options[].mandatory : 필수 입력 값 여부 <br/>
 * @param {Number}
 *            options[].minLength : 최소 입력 자리수 <br/>
 * @param {requestCallback}
 *            options[].valFunc : 사용자 유효성 검사 함수 <br/>
 * @param {String}
 *            tacId 그룹이 포함된 TabControl 컴포넌트 아이디
 * @param {String}
 *            tabId 그룹이 포함된 TabControl 컴포넌트의 Tab 아이디
 * @returns {Boolean} 유효성 검사 결과
 * @since 2015.08.05
 * @example
 *
 * if (com.validateGroup(grp_LoginInfo)) { if (confirm("변경된 데이터를 저장하시겠습니까?")) {
 * ajaxLib.executeSubmission("WS0201U04"); } }
 *
 * var valInfo = [ { id : "grpCd", mandatory : true, minLength : 5 }, { id :
 * "grpNm", mandatory : true } ];
 *
 * if (com.validateGroup(grp_LoginInfo, valInfo)) { if (confirm("변경된 데이터를
 * 저장하시겠습니까?")) { ajaxLib.executeSubmission("WS0201U04"); } }
 *
 * var valInfo = [ { id : "totWeight", mandatory : true }, { id :
 * "totWeightPwr", mandatory : true }, { id : "totWeightPwr", mandatory : true }, {
 * id : "ibxWeight1", mandatory : true, valFunc : function() { if
 * (numLib.parseInt(ibxTotWeight.getValue()) <
 * numLib.parseInt(ibxWeight1.getValue())) { return "총 중량이 세부 중량보다 커야 합니다."; } } }, {
 * id : "winding", mandatory : true } ];
 *
 * if (com.validateGroup(grpCsInfo, valInfo, tacCsInfo, "tabCsInfo1") == false) {
 * return false; }
 *
 * var valInfo = [ { id : "prntMenuCd", mandatory : true }, { id : "menuCd",
 * mandatory : true, valFunc : function() { if (dmaMenu.get("prntMenuCd") ==
 * dmaMenu.get("menuCd")) { return "상위 메뉴 코드와 메뉴 코드가 같아서는 안됩니다."; } } }, { id :
 * "menuNm", mandatory : true }, { id : "menuLevel", mandatory : true }, { id :
 * "menuSeq", mandatory : true }, { id : "urlPath", mandatory : true }, { id :
 * "isUse", mandatory : true } ];
 *
 * if (com.validateGroup(tblMenuInfo, valInfo, tacMenuInfo, "tabMenuInfo1") ==
 * false) { return false; }
 *
 * @description ※ 필수 입력, 입력 허용 문자, 입력 허용 불가 문자, 최대, 최소 입력 문자수 설정은 컴포넌트의 속성에서
 *              설정한다. <br/> - mandatory : 필수 입력 항목 여부 <br/> - allowChar : 입력 허용
 *              문자 <br/> - ignoreChar : 입력 허용 불가 문자 <br/> - maxLength : 최대 입력
 *              문자수 <br/> - maxByteLength : 최대 입력 바이트수 <br/> - minLength : 최소 입력
 *              문자수 <br/> - minByteLength : 최소 입력 바이트수 <br/>
 */
com.validateGroup = function(grpObj, valInfoArr, tacObj, tabId) {
    var objArr = WebSquare.util
            .getChildren(
                    grpObj,
                    {
                        excludePlugin : "group trigger textbox output calendar image span anchor pageInherit wframe itemTable",
                        recursive : true
                    });

    var valStatus = {
        isValid : true,
        message : "",
        error : []
    // { columnId: "", comObjId: "", columnNam : "", message: "" }
    };

    try {
        for ( var objIdx in objArr) {
            var obj = objArr[objIdx];

            if (objArr[objIdx].validate() === false) {
                return false;
            }

            var dataObjInfo = this.getDataCollection(obj);
            var dataCollection = null;
            var columnId = null;
            var value = null;

            if ((dataObjInfo !== undefined) && (dataObjInfo !== null)) {
                dataCollection = WebSquare.util
                        .getComponentById(dataObjInfo.runtimeDataCollectionId);
                columnId = dataObjInfo.columnId;
            }

            if ((dataCollection !== null)
                    && (dataCollection.getObjectType() === "dataMap")) {
                value = dataCollection.get(dataObjInfo.columnId);
            } else {
                var tempIdArr = obj.getID().split("_");
                if (obj.getPluginName() !== "editor") {
                    value = obj.getValue();
                } else {
                    value = obj.getText();
                }
            }

            for ( var valIdx in valInfoArr) {
                var valInfo = valInfoArr[valIdx];
                if ((typeof valInfo.id !== "undefined")
                        && (valInfo.id === columnId)) {
                    if ((typeof valInfo.mandatory !== "undefined")
                            && (valInfo.mandatory === true)
                            && (value.length === 0)) {
                        _setResult(dataCollection, valInfo.id, obj.getID(),
                                "필수 입력 항목 입니다.");
                    } else if ((typeof valInfo.minLength !== "undefined")
                            && (valInfo.minLength > 0)
                            && (value.length < valInfo.minLength)) {
                        _setResult(dataCollection, valInfo.id, obj.getID(),
                                "최소 길이 " + valInfo.minLength
                                        + "자리 이상으로 입력해야 합니다.");
                    } else if (typeof valInfo.valFunc === "function") {
                        var resultMsg = valInfo.valFunc(value);
                        if ((typeof resultMsg !== "undefined")
                                && (resultMsg !== "")) {
                            _setResult(dataCollection, valInfo.id, obj.getID(),
                                    resultMsg);
                        }
                    }
                }
            }
        }

        if (valStatus.error.length > 0) {
            valStatus.isValid = false;
            valStatus.message = "유효하지 않은 값이 입력 되었습니다";

            if ((typeof tacObj !== "undefined")
                    && (typeof tabId !== "undefined") && (tabId !== "")) {
                var tabIndex = tacObj.getTabIndex(tabId);
                tacObj.setSelectedTabIndex(tabIndex);
            }

            gcm.valStatus.objectType = "group";
            gcm.valStatus.isValid = false;
            gcm.valStatus.objectName = valStatus.error[0].comObjId;

            this.alert("[common.js][com.validateGroup] " + valStatus.error[0].message,
                    "gcm._groupValidationCallback");
        }

        return valStatus.isValid;

        function _setResult(dataCollection, columnId, comObjId, message) {
            var _this = gcm._getScope(dataCollection).com;
            var $p = gcm._getScope(dataCollection).$p;

            var errIdx = valStatus.error.length;
            valStatus.error[errIdx] = {};
            valStatus.error[errIdx].columnId = columnId;
            valStatus.error[errIdx].comObjId = comObjId;

            if (dataCollection !== null) {
                var comObj = $p.getComponentById(comObjId);
                valStatus.error[errIdx].columnName = _this
                        .getColumnName(comObj);
            } else {
                valStatus.error[errIdx].columnName = comObj.getInvalidMessage();
            }
            valStatus.error[errIdx].message = _this
                    .attachPostposition(valStatus.error[errIdx].columnName)
                    + " " + message;
        }
    } catch (e) {
        //m_        console.log(com.getPrintTime()+"[common.js][com.validateGroup] Exception :: Object Id : "
        //m_                + obj.getID() + ", Plug-in Name: " + obj.getPluginName() + ", "
        //m_                + e.message);
    } finally {
        objArr = null;
    }
};

/**
 * GridView를 통해서 입력된 데이터에 대해서 유효성을 검증한다.
 *
 * @date 2018.01.19
 * @memberOf com
 * @param {Object}
 *            gridViewObj GridView 객체
 * @param {Object[]}
 *            options 데이터 유효성 검증 옵션
 * @param {String}
 *            options[].id 유효성 검사 대상 DataCollection 컬럼 아이디
 * @param {Boolean}
 *            options[].mandatory 필수 입력 값 여부
 * @param {Number}
 *            options[].minLength 최소 입력 자리수
 * @param {requestCallback}
 *            options[].valFunc 사용자 유효성 검사 함수
 * @param {Object}
 *            tacObj GridView가 포함된 TabControl 컴포넌트 객체
 * @param {String}
 *            tabId GridView가 포함된 TabControl 컴포넌트의 Tab 아이디
 * @returns {Boolean} 유효성검사 결과
 * @since 2015.08.05
 * @example var valInfo = [ {id: "grpCd", mandatory: true, minLength: 5}, {id:
 *          "grpNm", mandatory: true} ];
 *
 * if (com.validateGridView(grd_MenuAuthority, valInfo)) { if (confirm("변경된 데이터를
 * 저장하시겠습니까?")) { scsObj.saveGroup(); } }
 *
 * var valInfo = [ { id : "prntMenuCd", mandatory : true }, { id : "menuCd",
 * mandatory : true, valFunc : function() { if (dmaMenu.get("prntMenuCd") ==
 * dmaMenu.get("menuCd")) { return "상위 메뉴 코드와 메뉴 코드가 같아서는 안됩니다."; } } }, { id :
 * "menuNm", mandatory : true }, { id : "menuLevel", mandatory : true }, { id :
 * "menuSeq", mandatory : true }, { id : "urlPath", mandatory : true }, { id :
 * "isUse", mandatory : true } ];
 *
 * if (com.validateGridView(grd_MenuAuthority, valInfo, tacMenuInfo,
 * "tabMenuInfo1") == false) { return false; }
 * @description * 입력 허용 문자, 입력 허용 불가 문자, 최대 입력 문자수 설정은 GridView의 Column의 속성에서
 *              설정한다. <br/> - allowChar : 입력 허용 문자 <br/> - ignoreChar : 입력 허용 불가
 *              문자 <br/> - maxLength : 최대 입력 문자수 <br/>
 */
com.validateGridView = function(gridViewObj, valInfoArr, tacObj, tabId) {

    if (gridViewObj === null) {
        return false;
    }

    var dataList = this.getGridViewDataList(gridViewObj);
    if (dataList === null) {
        //m_        console.log("Can not find the datalist of '" + gridViewObjId
        //m_                + "' object.");
        return false;
    }

    var valStatus = {
        isValid : true,
        message : "",
        error : []
    // { columnId: "", columnName: "", rowIndex: 0, message: "" }
    };

    try {
        var modifiedIdx = dataList.getModifiedIndex();

        for (var dataIdx = 0; dataIdx < modifiedIdx.length; dataIdx++) {
            var modifiedData = dataList.getRowJSON(modifiedIdx[dataIdx]);
            if (modifiedData.rowStatus === "D") {
                continue;
            }
            for ( var valIdx in valInfoArr) {
                var valInfo = valInfoArr[valIdx];
                if ((typeof valInfo.id !== "undefined")
                        && (typeof modifiedData[valInfo.id] !== "undefined")) {
                    var value = modifiedData[valInfo.id];
                    if ((typeof valInfo.mandatory !== "undefined")
                            && (valInfo.mandatory === true)
                            && (value.length === 0)) {
                        _setResult(modifiedIdx[dataIdx], dataList, gridViewObj
                                .getID(), valInfo.id, "필수 입력 항목 입니다.");
                    } else if ((typeof valInfo.minLength !== "undefined")
                            && (valInfo.minLength > 0)
                            && (value.length < valInfo.minLength)) {
                        _setResult(modifiedIdx[dataIdx], dataList, gridViewObj
                                .getID(), valInfo.id, "최소 길이 "
                                + valInfo.minLength + "자리 이상으로 입력해야 합니다.");
                    } else if (typeof valInfo.valFunc === "function") {
                        var resultMsg = valInfo.valFunc(value, modifiedData);
                        if ((typeof resultMsg !== "undefined")
                                && (resultMsg !== "")) {
                            _setResult(modifiedIdx[dataIdx], dataList,
                                    gridViewObj.getID(), valInfo.id, resultMsg);
                        }
                    }
                }

                if (valStatus.error.length > 0) {
                    break;
                }
            }
        }

        if (valStatus.error.length > 0) {
            valStatus.isValid = false;
            valStatus.message = "유효하지 않은 값이 입력 되었습니다";

            if ((typeof tacObj !== "undefined")
                    && (typeof tabId !== "undefined") && (tabId !== "")) {
                var tabIndex = tacObj.getTabIndex(tabId);
                tacObj.setSelectedTabIndex(tabIndex);
            }

            gcm.valStatus.isValid = false;
            gcm.valStatus.objectType = "gridView";
            gcm.valStatus.objectName = valStatus.error[0].comObjId;
            gcm.valStatus.columnId = valStatus.error[0].columnId;
            gcm.valStatus.rowIndex = valStatus.error[0].rowIndex;

            this.alert("[common.js][com.validateGridView] " + valStatus.error[0].message,
                    "gcm._groupValidationCallback");

        }

        return valStatus.isValid;

        function _setResult(rowIndex, dataList, gridViewObjId, columnId,
                message) {
            var errIdx = valStatus.error.length;
            valStatus.error[errIdx] = {};
            valStatus.error[errIdx].columnId = columnId;
            valStatus.error[errIdx].comObjId = gridViewObjId;
            valStatus.error[errIdx].columnName = dataList
                    .getColumnName(columnId);
            valStatus.error[errIdx].rowIndex = rowIndex;
            valStatus.error[errIdx].message = com
                    .attachPostposition(valStatus.error[errIdx].columnName)
                    + " " + message;
        }
    } catch (e) {
        //m_        console.log("[com.validateGridView] Exception :: " + e.message);
    } finally {
        modifiedData = null;
        modifiedIdx = null;
        dataList = null;
        gridViewObj = null;
    }
};

/**
 * 유효성 검사 실패시 출력할 메시지를 반환한다.
 *
 * @date 2014.12.10
 * @private
 * @memberOf com
 * @author InswaveSystems
 * @returns {String} 유효성 검사 결과 메시지
 */
com.validateMsg = function() {
    var msg = "";
    var invalidType = this.getType(); // invalid 타입
    var invalidValue = this.getValue(); // invalid 타입별 설정값

    var callerObj = null;
    if (typeof this.getCaller === "function") {
        callerObj = this.getCaller();
    } else if (typeof this.userFunc !== "undefined") {
        callerObj = this.$p.getComponentById(this.userFunc.arguments[1]);
    } else {
        return;
    }

    var _this = gcm._getScope(callerObj).com;
    var columnName = _this.getColumnName(callerObj);

    switch (invalidType) {
    case "mandatory":
        msg = _this.attachPostposition(columnName) + "필수 입력 항목 입니다.";
        break;
    case "minLength":
        msg = _this.attachPostposition(columnName) + "최소 길이 " + invalidValue
                + "자리 이상으로 입력해야 합니다.";
        break;
    case "minByteLength":
        msg = _this.attachPostposition(columnName) + "최소 길이 " + invalidValue
                + "바이트 이상으로 입력해야 합니다.";
        break;
    default:
        msg = _this.attachPostposition(columnName) + "유효하지 않은 값이 입력 되었습니다.";
        break;
    }

    if (msg !== "") {
        gcm.valStatus.isValid = false;
    }

    gcm.valStatus.objectType = "group";
    gcm.valStatus.objectName = callerObj.getID();

    _this.alert("[common.js][com.validateMsg] " + msg, "gcm._groupValidationCallback");
    return msg;
};

/**
 * dataList에서 특정 컬럼의 값이 일치하는 행의 JSON 반환
 *
 * @date 2020.07.21 설성윤
 * @memberOf com
 * @param {Array}
 *            str 사업자번호 문자열
 * @returns {Array} 일치하는 index를 담은 1차원 배열
 */
com.getMatchedFirstJSON = function(dataList, colInfo, dataValue) {
	
	var tmpRsData;
	var tmpArray = dataList.getMatchedJSON(colInfo, dataValue);
	if(tmpArray.length > 0) tmpRsData = tmpArray[0];

	return tmpRsData;
};

/**
 * 사업자번호 유효성을 검사한다.
 *
 * @date 2014.12.10
 * @memberOf com
 * @param {String}
 *            str 사업자번호 문자열
 * @returns {Boolean} 올바른 번호가 아닌경우 false
 * @example com.checkBizID("1102112345");
 */
com.checkBizID = function(str) {
    var sum = 0;
    var aBizID = new Array(10);
    var checkID = new Array("1", "3", "7", "1", "3", "7", "1", "3", "5");

    for (var i = 0; i < 10; i++) {
        aBizID[i] = str.substring(i, i + 1);
    }
    for (var i = 0; i < 9; i++) {
        sum += aBizID[i] * checkID[i];
    }
    sum = sum + parseInt((aBizID[8] * 5) / 10);
    temp = sum % 10;
    temp1 = 0;

    if (temp != 0) {
        temp1 = 10 - temp;
    } else {
        temp1 = 0;
    }
    if (temp1 != aBizID[9]) {
        return false;
    }
    return true;
};

/**
 * 법인등록번호 유효성을 검사한다.
 *
 * @date 2014. 12. 10.
 * @memberOf com
 * @param {String}
 *            str 문자열
 * @returns {Boolean} 올바른 번호가 아닌경우 false
 * @example com.checkCorpID("110211234567");
 */
com.checkCorpID = function(str) {
    var checkID = new Array(1, 2, 1, 2, 1, 2, 1, 2, 1, 2, 1, 2);
    var sCorpNo = str;
    var lV1 = 0;
    var nV2 = 0;
    var nV3 = 0;

    for (var i = 0; i < 12; i++) {
        lV1 = parseInt(sCorpNo.substring(i, i + 1)) * checkID[i];

        if (lV1 >= 10) {
            nV2 += lV1 % 10;
        } else {
            nV2 += lV1;
        }
    }
    nV3 = nV2 % 10;

    if (nV3 > 0) {
        nV3 = 10 - nV3;
    } else {
        nV3 = 0;
    }
    if (sCorpNo.substring(12, 13) != nV3) {
        return false;
    }
    return true;
};

/**
 * 내외국인 주민등록번호 유효성을 검사한다.
 *
 * @date 2014. 12. 10.
 * @memberOf com
 * @param {String}
 *            str 문자열
 * @returns {Boolean} 올바른 번호가 아닌경우 false
 * @example com.checkPersonID("9701011234567");
 */
com.checkPersonID = function(str) {
    var checkID = new Array(2, 3, 4, 5, 6, 7, 8, 9, 2, 3, 4, 5);
    var i = 0, sum = 0;
    var temp = 0;
    var yy = "";

    if (str.length != 13) {
        return false;
    }
    for (i = 0; i < 13; i++) {
        if (str.charAt(i) < '0' || str.charAt(i) > '9') {
            return false;
        }
    }

    // foreigner PersonID Pass
    if (str.substring(6, 13) == "5000000" || str.substring(6, 13) == "6000000"
            || str.substring(6, 13) == "7000000"
            || str.substring(6, 13) == "8000000") {
        return true;
    }
    for (i = 0; i < 12; i++) {
        sum += str.charAt(i) * checkID[i];
    }
    temp = sum - Math.floor(sum / 11) * 11;
    temp = 11 - temp;
    temp = temp - Math.floor(temp / 10) * 10;

    // 나이 (-) 체크
    if (str.charAt(6) == '1' || str.charAt(6) == '2' || str.charAt(6) == '5'
            || str.charAt(6) == '6') {
        yy = "19";
    } else {
        yy = "20";
    }

    if (parseInt(common_util.getCurrentDate('yyyy'))
            - parseInt(yy + str.substring(0, 2)) < 0) {
        return false;
    }

    // 외국인 주민번호 체크로직 추가
    if (str.charAt(6) != '5' && str.charAt(6) != '6' && str.charAt(6) != '7'
            && str.charAt(6) != '8') {
        if (temp == eval(str.charAt(12))) {
            return true;
        } else {
            return false;
        }
    } else {
        if ((temp + 2) % 10 == eval(str.charAt(12))) {
            return true;
        } else {
            return false;
        }
    }
    return false;
};

/**
 * 메일주소 체크한다.
 *
 * @date 2014. 12. 10.
 * @memberOf com
 * @param {String}
 *            str 메일주소
 * @return {Boolean} 정상이면 공백("")을 반환, 그외는 에러 메시지 반환
 * @example com.isEmail("emailTest@email.com")
 */
com.checkEmail = function(str) {
    if (typeof str != "undefined" && str != "") {
        var format = /^([a-zA-Z0-9_\.\-])+\@(([a-zA-Z0-9\-])+\.)+([a-zA-Z0-9]{2,4})+$/;

        if (format.test(str)) {
            return true;
        } else {
            return false;
        }
    }
    return true;
};

/**
 * 동적으로 component를 생성합니다.
 *
 * @private
 * @date 2018. 05. 10.
 * @memberOf com
 * @author InswaveSystems
 * @example
 *
 * var newCompArr = [{ id : 'ipt_newComp' ,inputType : 'input' ,style :
 * "width:100px; height:21px; float:left; margin : 5px;" //style-string ,target :
 * parent_obj ,itemSet : { // 해당하는 component에 itemset이 필요한 경우 // 필요없는 경우 제외
 * nodeset : 'data:dlt_newComp' ,label : 'codeNm' ,value : 'codeId' } },...]
 *
 * com.createCmpnt = com.createCmpnt(newCompArr);
 */
com.createCmpnt = function(newCompArr) {

    if (com.isEmpty(newCompArr) || newCompArr.length == 0) {
        //m_        console.log(com.getPrintTime()+"[common.js][com.createCmpnt] 생성할 정보가 없습니다.");
        return;
    }
    var idArr = [];
    try {

        for ( var key in newCompArr) {
            if (!newCompArr.hasOwnProperty(key))
                continue;
            var cmp_info = newCompArr[key];
            if (com.isEmpty(cmp_info.id) || com.isEmpty(cmp_info.inputType)
                    || com.isEmpty(cmp_info.style)) {
                //m_                console.log(com.getPrintTime()+"[common.js][com.createCmpnt] 생성하기 위한 정보가 부족합니다.");
                return;
            }
            $p.dynamicCreate(cmp_info.id, cmp_info.inputType, {
                style : cmp_info.style
            }, cmp_info.target, cmp_info.itemSet || {});
            idArr.push(cmp_info.id);
        }
    } catch (e) {
        console.error("[common.js][com.createCmpnt] Exception:"+e);
    }

    return idArr;
};

/**
 * 전역에 사용할 데이터를 저장한다.[use sessionStorage]
 *
 * @memberOf com
 * @param {String}key
 *            저장할 문자열 키값
 * @param {Object}options
 *            저장할 데이터 object
 * @example var opt = {};
 * com.setSessionData(key,opt);
 */
com.setSessionData = function(key, obj) {
    if (com.isEmpty(key) || com.isEmpty(obj)) {
        //alert("[common.js][com.setSessionData] 저장하실 데이터를 입력하십시오! key ["+key+"], obj ["+obj+"]");
        return;
    }
    sessionStorage.setItem(key, JSON.stringify(obj));
};

/**
 * 특정 데이터를 삭제한다.
 *
 * @memberOf com
 * @param {String}key
 *            저장할 문자열 키값
 *
 * @example var key = "";
 * com.removeSessionData(key);
 */
com.removeSessionData = function(key) {
    if (com.isEmpty(key) ) {
        alert("[common.js][com.removeSessionData] 삭제하실 데이터를 입력하십시오");
        return;
    }
    sessionStorage.removeItem(key);
};



/**
 * 전역에 사용할 데이터를 호출한다.[use sessionStorage]
 *
 * @memberOf com
 * @param {String}key
 *            저장한 문자열 키값
 * @example var options = {}; com.getSessionData(key);
 */
com.getSessionData = function(key) {
    var storageObject = {};
    try {
        storageObject = JSON.parse(sessionStorage.getItem(key), "{}");
    } catch (e) {
        storageObject = {};
    }
    return storageObject;
};




/**
 * 전역에 사용할 데이터를 저장한다.
 *
 * @memberOf com
 * @param {String}key
 *            저장할 문자열 키값
 * @param {Object}options
 *            저장할 데이터 object
 * @example var options = {}; com.setPageData(key,options);
 */
com.setPageData = function(key, obj) {
    if (com.isEmpty(key) || com.isEmpty(obj)) {
        alert("[common.js][com.setPageData] 저장하실 데이터를 입력하십시오");
        return;
    }
    WebSquare.localStorage.setItem(key, JSON.stringify(obj));
};

/**
 * 전역에 사용할 데이터를 호출한다.
 *
 * @memberOf com
 * @param {String}
 *            key 호출할 키값
 * @example var options = {}; com.getPageData(key);
 */
com.getPageData = function(key) {
    var storageObject = {};
    try {
        storageObject = JSON.parse(WebSquare.localStorage.getItem(key), "{}");
    } catch (e) {
        storageObject = {};
    }
    return storageObject;
};

/**
 * Cookie 값 설정
 *
 * @memberOf com
 * @param {String}
 *            cName Cookie 이름
 * @param {String}cValue
 *            Cookie 값
 * @param {int}days
 *            유효기간 (지정하지 않으면 Browse 종료떄까지)
 * @example com.setCookie("intro_notice", "Y", 1);
 */
com.setCookie = function(cName, cValue, days) {
    var expires = "";
    if (days) {
        var date = new Date();
        date.setTime(date.getTime() + (days * 24 * 60 * 60 * 1000));
        expires = "; expires=" + date.toGMTString();
    }
    document.cookie = escape(cName) + "=" + escape(cValue) + expires
            + "; path=/";
};

/**
 * Cookie 값 가져 오기
 *
 * @memberOf com
 * @param {String}
 *            cName Cookie 이름
 * @return {String}
 * @example com.getCookie("intro_notice");
 */
com.getCookie = function(cName) {
    var _name = escape(cName) + "=";
    var ca = document.cookie.split(';');
    for (var idx = 0, iCnt = ca.length; idx < iCnt; idx++) {
        var c = ca[idx];
        while (c.charAt(0) == ' ') {
            c = c.substring(1, c.length);
        }

        if (c.indexOf(_name) == 0) {
            return unescape(c.substring(_name.length, c.length));
        }
    }
    return "";
};

/**
 *
 * open대상 페이지를 미리 점검한다.
 *
 * @date 2018. 05. 18.
 * @memberOf com
 * @author archie
 * @return boolean
 * @example var openUrl = "ui/test/abcd.xml"; com.chkWidow(openUrl);
 *
 */
com.chkWidow = function(openUrl) {
    /*
    var http = WebSquare.BootLoader.getXMLHTTPObject();
    http.open("GET", openUrl, false);
    http.send(null);
    if (http.status == 404 || com.isEmpty(openUrl)) {
        var msg = "해당페이지 정보가 없습니다.\n[" + openUrl + "]";
        alert("[common.js][com.chkWidow] " + msg);
        return false;
    }*/
    return true;
};

/**
 *
 * Request Header : SYS_INF
 *
 * @date 2018. 07. 30.
 * @memberOf com
 * @author archie
 * @return object
 * @example com.setReq_SYS_INF();
 *
 *
 */
com.setReq_SYS_INF = function() {
    return [ {
        "RQST_RESP_G" : "S",
        "SYNC_G" : "S",
        "SND_INFC_G" : "U",
        "MDIA_U" : "KUX",
        "LANG_G" : gcm.LAN_G
    // 2018-08-10 : 문석길 : 언어구분을 gcm 변수로 대체함.
    } ];

};

/**
 *
 * Request Header : TR_INF
 *
 * @date 2018. 07. 30.
 * @memberOf com
 * @author archie
 * @return object
 * @example com.setReq_TR_INF();
 *
 *
 */
com.setReq_TR_INF = function(svcObj) {

    return [ {
        "RECV_SVC_C"           : svcObj.svc_id   || "",
        "SCR_ID"               : com.getScrId()  || "", // 2018-09-18 수정함. svcObj.scr_id || "",
        "MENU_ID"              : com.getMenuId() || "", // 2018-10-08 문석길 추가함.
        "RE_SCR_ID"            : svcObj.rescrId  || "",
        "USER_G"               : "",                    // 이하 user_info로부터 set정보를 받아 처리합니다.
        "TRX_OP_SOSOK_GRPCO_C" : "",
        "OP_NO"                : com.getUserId(),
        "CUSNM"                : com.getUserNm(),
        "CUS_G"                : "",
        "BIZREGNO"             : "",
        "CLIENT_IP_NO1"        : com.getUserIP(),
        "SYS_U_FLG"            : com.getSysUFlg(),  // 2018-12-10 시스템유형 (D:개발, T:검증, R:운영)
        "TRX_DTTM"             : dateLib.getDate()  // 2018-12-12 : 거래상세일시 : 거래일자(8)+거래시간(9) : "20181212090621993"
    } ];
};

/**
 *
 * 전문 서비스 호출
 *
 * @date 2018. 07. 31.
 * @memberOf com
 * @author archie
 * @return object
 * @example var svcObj = { svc_id : "SSFI050101R01", msg_id: "MSFI050101R01In",
 *          sbm_id : "sbm_MenuSearch" }; com.executeSvc(svcObj);
 *
 *
 */
com.executeSvc = function(svcObj, requestData, compObj) {

// 2018-10-18 isshowMsg 테스트용 log
//console.log(com.getPrintTime()+"[common.js][com.executeSvc] svcObj svc_id ["+svcObj.svc_id+"] sbm_id ["+svcObj.sbm_id+"] isshowMsg ["+svcObj.isshowMsg+"]");

    var now = this.$p || $p;
    var sbmObj = now.getSubmission(svcObj.sbm_id);
    sbmObj.userData1 = arguments;
    // sbmObj.ref
    if (sbmObj.action.indexOf(gcm.CONTEXT_PATH) < -1) {
        sbmObj.action = gcm.CONTEXT_PATH + sbmObj.action;
    }
    sbmObj.isShowMsg = (typeof svcObj.isshowMsg === "undefined")?true:svcObj.isshowMsg;
    sbmObj.processMsg =(typeof svcObj.isshowMsg === "undefined")?"처리중":"$blank";
    sbmObj.userData2 = now.id; // 2018-09-06 : 문석길 wframe id 를 보관한다.

    gcm.IS_TR = true;

    now.executeSubmission(sbmObj, requestData, compObj);

};


/**
*
* 전문 서비스 호출
*
* @date 2018. 07. 31.
* @memberOf com
* @author archie
* @return object
* @example
*   var svcObj = {svc_id:"SSFI050101R01", msg_id:"MSFI050101R01In", sbm_id:"sbm_MenuSearch"};
*    com.executeFileSvc(svcObj);
*/
com.executeFileSvc = function(svcObj, requestData, compObj) {
    gcm.IS_FILEDOWN = true;
    var now = this.$p || $p;
    var sbmObj = now.getSubmission(svcObj.sbm_id);
    sbmObj.userData1 = arguments;
    // sbmObj.ref
    if (sbmObj.action.indexOf(gcm.CONTEXT_PATH) < -1) {
        sbmObj.action = gcm.CONTEXT_PATH + sbmObj.action;
    }
    sbmObj.isShowMeg = true;
    gcm.IS_TR = true;
    now.executeSubmission(sbmObj, requestData, compObj);

};


/**
*
* 파일 다운로드 호출
*
* @date 2018. 08. 30.
* @memberOf com
* @author archie
* @return object
* @example
*   var downInfo = {
*                   DOWNLOAD_WRK_GBN : "SFI",
*                   ...,
*                   ...
*    };
*
*    com.fileDownload(downInfo);
*/
com.fileDownload = function(downInfo){
//console.log("com.fileDownload start");
	
	console.log("downInfo="+JSON.stringify(downInfo));
	console.log("downInfo.DOWNLOAD_WRK_GBN="+downInfo.DOWNLOAD_WRK_GBN);
	
    if(com.isEmpty(downInfo)){
        alert("[common.js][com.fileDownload] 파일 다운로드 정보가 없습니다.");
        return false;
    }
    if(com.isEmpty(downInfo.DOWNLOAD_WRK_GBN)){
        alert("[common.js][com.fileDownload] DOWNLOAD_WRK_GBN 정보가 없습니다.");
        return false;
    }
    
    //debugger;
    
    var userInfo = JSON.parse(com.getSessionData("USER_INFO"));
    var userId = "";
    
    if ( !com.isEmpty(userInfo) ) {
    	userId = userInfo.USER_ID;
    }
    
    var iJsn = downInfo;
    var $iframe = $('<iframe height=1></iframe>'); //SFI 요청 수정.by BYON 2018.11.30
        $iframe.attr("name","filedownIfrm")
        $iframe.appendTo('body');
        var $form = $("<form></form>");
        $form.attr("action", "/ShDownload.do");
        $form.attr("method", "POST");
        $form.attr("encoding", "text/html");
        $form.attr("target", "filedownIfrm");
        $form.attr("charset", "UTF-8");

        for( var key in iJsn){
            var $input = $("<input></input>");
            $input.attr({type:"hidden",  name:key,  id:key,  value:iJsn[key]});
            $input.appendTo($form);
        }
        var $input = $("<input></input>");
        $form.appendTo('body');
        $input.appendTo($form);
        $form.append("<input type='hidden' name='CLIENT_ENCODEING_STR' value='UTF-8' />");
        $form.append("<input type='hidden' name='USER_ID' value='" + userId + "' />");
        $form.submit();
        $form.empty();

        setTimeout(function(){

            /**파일up/down 처리시 메시지 못받아 임시처리.AA에서 webtobe에서 팝업띄우게 변경예정 추후삭제 by BYON.2018.11.28*/
            var _code = $iframe[0].contentDocument.title.split(" ")[0] ; //==> code ==> 499==> 파일다운로드시 에러
            if($iframe[0].contentDocument.body.innerHTML.indexOf("ECTM0006") > -1 && _code == "499"){
                com.message("ECTM0006", "적절치 않은 파일명 사용으로"); // {0} 실패하였습니다
            }

            $iframe.remove();
            $form.remove();
        },100);
};

/**
*
* 다건 파일 다운로드 호출(get방식) : 보안 취약성으로 사용안함.
*
* @date 2018. 08. 30.
* @memberOf com
* @author archie
* @return object
* @example
*   var downInfo = {
*                   DOWNLOAD_WRK_GBN : "SFI",
*                   ...,
*                   ...
*    };
*
*    com.fileDownloadMulti(downInfo);
*/
com.fileDownloadMulti = function(downInfo){
    if(com.isEmpty(downInfo)){
        alert("[common.js][com.fileDownloadMulti] 파일 다운로드 정보가 없습니다.");
        return false;
    }
    
    //debugger;
    
    if(com.isEmpty(downInfo.DOWNLOAD_WRK_GBN)){
        alert("DOWNLOAD_WRK_GBN 정보가 없습니다.");
        return false;
    }
    var iJsn = downInfo;
    var url = "/ShDownload.do?";
    for( var key in iJsn){
        url += key +"="+ iJsn[key] +"&";
    }
    var files = url;
    files = [files.substring(0,files.length-1)];
    $.each(files,function(key,value){
        $('<iframe></iframe>').hide().attr('src',value).appendTo($('body')).load(function(){
            var that = this;
            setTimeout(function(){
                $(that).remove();
            },100);
        });
    });
};

/**
*
* 다건 파일 다운로드 호출(post방식)
*
* @date 2018. 11. 08.
* @memberOf com
* @author archie
* @return object
* @example
*   var downInfoArr = [{
*                   DOWNLOAD_WRK_GBN : "SFI",
*                   ...,
*                   ...
*    },...];
*
*    com.fileDownloadMulti_post(downInfoArr);
*/
com.fileDownloadMulti_post = function(downInfo){
    function download_next(i){
        var iJsn = downInfo[i];
        if(com.isEmpty(iJsn)){
            return false;
        }
        
        //debugger;
        
        var $iframe = $('<iframe></iframe>');
            $iframe.attr("name","filedownIfrm")
            $iframe.appendTo('body');
            var $form = $("<form></form>");
            $form.attr("action", "/ShDownload.do");
            $form.attr("method", "POST");
            $form.attr("encoding", "text/html");
            $form.attr("target", "filedownIfrm");
            $form.attr("charset", "UTF-8");

            for( var key in iJsn){
                var $input = $("<input></input>");
                $input.attr({type:"hidden",  name:key,  id:key,  value:iJsn[key]});
                $input.appendTo($form);
            }
            var $input = $("<input></input>");
            $form.appendTo('body');
            $input.appendTo($form);
            $form.append("<input type='hidden' name='CLIENT_ENCODEING_STR' value='UTF-8' />");
            $form.submit();
            $form.empty();

            setTimeout(function(){
                //debugger;

                /**파일up/down 처리시 메시지 못받아 임시처리.AA에서 webtobe에서 팝업띄우게 변경예정 추후삭제 by BYON.2018.11.28*/
                var _code = $iframe[0].contentDocument.title.split(" ")[0] ; //==> code ==> 499==> 파일다운로드시 에러
                if($iframe[0].contentDocument.body.innerHTML.indexOf("ECTM0006") > -1 && _code == "499"){
                    com.message("ECTM0006", "적절치 않은 파일명 사용으로"); // {0} 실패하였습니다
                }

                $iframe.remove();
                $form.remove();
                download_next(i+1);
            },1000);
    };
    download_next(0);
};


/**
 * 데이터객체 동적 생성
 *
 * @memberOf com
 * @param {String}
 *            dataType "dataList" || "dataMap"
 * @param {String}
 *            id 데이터객체에 부여할 id
 * @param {Array}
 *            columnArr column배열 정보
 * @example //List 타입의 데이터[=DataList] //CASE 1. id만 지정하는경우 var columnArr_id =
 *          ["key","code","codeName"];
 *          com.createDataObj("dataList","dlt_sample",columnArr_id); //CASE 2.
 *          id와 name정보를 지정하는경우 var columnArr_idname =
 *          [["key","키값"],["code","코드값"],["codeName","코드네임값"]];
 *          com.createDataObj("dataList","dlt_sample",columnArr_idname);
 *
 *
 * //Map 타입의 데이터[=DataMap] //CASE 1. id만 지정하는경우 var columnArr =
 * ["key","code","codeName"];
 * com.createDataObj("dataMap","dma_sample",columnArr); //CASE 2. id와 name정보를
 * 지정하는경우 var columnArr_idname =
 * [["key","키값"],["code","코드값"],["codeName","코드네임값"]];
 * com.createDataObj("dataMap","dma_sample",columnArr_idname);
 *
 */
com.createDataObj = function(type, id, columnArr) {
    var dataStr = "";
    if (typeof $p.data[id] !== 'undefined')
        $p.data.remove(id);
    var dl_op = {
        dataMap : [ "Map", "key" ],
        dataList : [ "List", "column" ]
    };
    var t = dl_op[type];
    dataStr += "<w2:data" + t[0] + " id=\"" + id + "\"><w2:" + t[1] + "Info>";
    for (var i = 0; i < columnArr.length; i++) {
        if (typeof columnArr[i] == "string") {// id로만 들어온경우로 판단함
            dataStr += "<w2:" + t[1] + " id=\"" + columnArr[i]
                    + "\" dataType=\"text\" />";
        } else {// object형태로 들어옴{id:"",name:""}==> ["",""]//[0]:id,[1]:name으로 변경
            dataStr += "<w2:" + t[1] + " id=\"" + columnArr[i][0]
                    + "\" name=\"" + columnArr[i][1]
                    + "\" dataType=\"text\" />";
        }
    }

    dataStr += "</w2:" + t[1] + "Info></w2:data" + t[0] + ">";
    $p.data.create(dataStr);

};

com.createDataObj_page = function(type, id, columnArr, page_p) {

    var dataStr = "";
    var now = this.$p || page_p || $p;
    if (typeof now.data[id] !== 'undefined')
        now.data.remove(id);
    var dl_op = {
        dataMap : [ "Map", "key" ],
        dataList : [ "List", "column" ]
    };
    var t = dl_op[type];
    dataStr += "<w2:data" + t[0] + " id=\"" + id + "\"><w2:" + t[1] + "Info>";
    for (var i = 0; i < columnArr.length; i++) {
        if (typeof columnArr[i] == "string") {// id로만 들어온경우로 판단함
            dataStr += "<w2:" + t[1] + " id=\"" + columnArr[i]
                    + "\" dataType=\"text\" />";
        } else {// object형태로 들어옴{id:"",name:""}==> ["",""]//[0]:id,[1]:name으로 변경
            dataStr += "<w2:" + t[1] + " id=\"" + columnArr[i][0]
                    + "\" name=\"" + columnArr[i][1]
                    + "\" dataType=\"text\" />";
        }
    }

    dataStr += "</w2:" + t[1] + "Info></w2:data" + t[0] + ">";
    now.data.create(dataStr);

};

/**
 *
 * 로그인정보중 서울시금고모듈코드 제공
 *
 * @date 2018. 08. 03.
 * @memberOf com
 * @author 문석길
 * @return 서울시금고모듈코드
 * @example com.getSlGmgoModlC
 */
com.getSlGmgoModlC = function() {

    // 모듈코드가 없을 경우 ScsServlet에서 가져온 모듈코드를 reset한 후 return 한다.
    if (com.isEmpty(gcm.LOGIN.SL_GMGO_MODL_C)) {
        if (typeof WebSquareParam == "undefined") {
            ;
        } else {
            if (WebSquareParam.SL_GMGO_MODL_C != "null") {
                gcm.LOGIN.SL_GMGO_MODL_C = WebSquareParam.SlGmgoModlC;
            }
        }
    }

    return gcm.LOGIN.SL_GMGO_MODL_C;
};

/**
 *
 * 사용자의 IP를 가져온다. (서울시금고모듈코드도 같이 가져온다.)
 *
 * @date 2018. 09. 03.
 * @memberOf com
 * @author 문석길
 * @return 사용자IP
 * @example com.getUserIP
 */
com.getUserIP = function() {

    //-----------------------------------------------------------------------------------------------------------------
    // □ 2018-11-05 : 문석길 : 사용자IP, 서울시금고모듈코드를 ScsServlet.java -> websquare.jsp 항목 추가
    //                          위의 항목값을 대체한 후 바로 return 한다.
    //-----------------------------------------------------------------------------------------------------------------
    if (typeof WebSquareParam == "undefined") {
        ;
    } else {
        if (WebSquareParam.UserIp != "null") {
            gcm.LOGIN.USER_IP = WebSquareParam.UserIp;
            gcm.LOGIN.SL_GMGO_MODL_C = WebSquareParam.SlGmgoModlC;
            return gcm.LOGIN.USER_IP;
        }
    }

    // REMOTE_ADDR 쿠키에 값이 없을 경우 서버에서 IP를 읽어와서 쿠키에 저장한다.
    if (com.isEmpty(gcm.LOGIN.USER_IP)) {

        if (typeof USER_IP_INF_In == "undefined") {
            com.createDataObj("dataMap", "USER_IP_INF_In", [ "SL_GMGO_MODL_C" ]);
            com.createDataObj("dataMap", "USER_IP_INF_Out", [ "SL_GMGO_MODL_C", "USER_IP" ]);
            console.log(com.getPrintTime()+"[common.js][com.getUserIP] USER_IP_INF DataMap이 없어서 새로 생성하였습니다.");
        }
        USER_IP_INF_In.set("SL_GMGO_MODL_C", "SFI"); // 서울시금고모듈코드

        var userIPSearchOption = {
            mode : "synchronous",   // asynchronous, synchronous
            id : "sbm_UserIPSearch",
            ref : 'data:json,[USER_IP_INF_In]',
            target : 'data:json,[{"id":"USER_IP_INF_Out","key":"MSFI010401R00Out"}]',
            userData1 : [{svc_id:"SSFI010401R00", msg_id:"USER_IP_INF_In", sbm_id:"sbm_UserIPSearch", isshowMsg:false}]
        };

        userIPSearchOption.submitDoneHandler = function(e) {
            //m_            console.log(com.getPrintTime()+"[common.js][com.getUserIP] 조회된 서울시금고모듈코드는 ["+USER_IP_INF_Out.get("SL_GMGO_MODL_C")+"] 입니다.");
            //m_            console.log(com.getPrintTime()+"[common.js][com.getUserIP] 조회된 사용자IP는 ["+USER_IP_INF_Out.get("USER_IP")+"] 입니다.");
        }
        gcm.IS_TR = true;
        this.executeSubmission_dynamic(userIPSearchOption);

        gcm.LOGIN.SL_GMGO_MODL_C = USER_IP_INF_Out.get("SL_GMGO_MODL_C"); // 2018-09-17 추가
        gcm.LOGIN.USER_IP = USER_IP_INF_Out.get("USER_IP");
        
    }

    return gcm.LOGIN.USER_IP;
};

/**
 *
 * 로그인정보중 사용자ID 제공
 *
 * @date 2018. 08. 03.
 * @memberOf com
 * @author 문석길
 * @return 사용자ID
 * @example com.getUserId
 */
com.getUserId = function() {
	return gcm.LOGIN.USER_ID;
};

/**
 *
 * 로그인정보중 사용자명 제공
 *
 * @date 2018. 08. 08.
 * @memberOf com
 * @author 문석길
 * @return 사용자명
 * @example com.getUserNm
 */
com.getUserNm = function() {
    return gcm.LOGIN.USER_NM;
};

/**
 *
 * 로그인정보중 사용자유형CODE 제공
 *
 * @date 2018. 08. 08.
 * @memberOf com
 * @author 문석길
 * @return 사용자유형CODE
 * @example com.getUserUC
 */
com.getUserUC = function() {
    return gcm.LOGIN.USER_U_C;
};

/**
 *
 * 로그인정보중 사용자권한구분 제공
 *
 * @date 2018. 08. 08.
 * @memberOf com
 * @author 문석길
 * @return 사용자권한구분
 * @example com.getUserRightG
 */
com.getUserRightG = function() {
    return gcm.LOGIN.USER_RIGHT_G;
};

/**
 *
 * 로그인정보중 서울시금고기관CODE 제공
 *
 * @date 2018. 08. 14.
 * @memberOf com
 * @author 문석길
 * @return 행정표준기관CODE
 * @example com.getPadmStdOrgC
 */
com.getPadmStdOrgC = function() {
    return gcm.LOGIN.PADM_STD_ORG_C;
};

/**
 *
 * 로그인정보중 기관명 제공
 *
 * @date 2018. 08. 08.
 * @memberOf com
 * @author 문석길
 * @return 기관명
 * @example com.getOrgNm
 */
com.getOrgNm = function() {
    return gcm.LOGIN.ORG_NM;
};

/**
 *
 * 로그인정보중 서울시금고부서CODE 제공
 *
 * @date 2018. 08. 08.
 * @memberOf com
 * @author 문석길
 * @return 서울시금고부서CODE
 * @example com.getSlGmgoDeptC
 */
com.getSlGmgoDeptC = function() {
    return gcm.LOGIN.SL_GMGO_DEPT_C;
};

/**
 *
 * 로그인정보중 부서명 제공
 *
 * @date 2018. 08. 08.
 * @memberOf com
 * @author 문석길
 * @return 부서명
 * @example com.getDeptNm
 */
com.getDeptNm = function() {
    return gcm.LOGIN.DEPT_NM;
};

/**
 *
 * 로그인정보중 영업점CODE 제공
 *
 * @date 2018. 08. 08.
 * @memberOf com
 * @author 문석길
 * @return 영업점CODE
 * @example com.getBrC
 */
com.getBrC = function() {
    return gcm.LOGIN.BR_C;
};

/**
 *
 * 로그인정보중 영업점명 제공
 *
 * @date 2018. 08. 08.
 * @memberOf com
 * @author 문석길
 * @return 영업점명
 * @example com.getBrNm
 */
com.getBrNm = function() {
    return gcm.LOGIN.BR_NM;
};

/**
 *
 * 로그인정보중 사용자별특화내역(배열) 제공
 *
 * @date 2018. 09. 04.
 * @memberOf com
 * @author 문석길
 * @return 사용자별특화내역(배열)
 * @example com.getUserBySpzHis
 */
com.getUserBySpzHis = function() {
    return gcm.LOGIN_USER_BY_SPZ_HIS;
};

/**
 * 로그인정보중 기관구분 제공
 *
 * @date 2018. 10. 02.
 * @memberOf com
 * @author 문석길 (SFI 최황연 대리 요청)
 * @return 기관구분
 * @example com.getOrgG
 */
com.getOrgG = function() {
    return gcm.LOGIN.ORG_G;
};

/**
 * 로그인정보중 시구CODE(징수기관) 제공
 *
 * @date 2018. 10. 02.
 * @memberOf com
 * @author 문석길 (SFI 최황연 대리 요청)
 * @return 시구CODE(징수기관)
 * @example com.getCtGuC
 */
com.getCtGuC = function() {
    return gcm.LOGIN.CT_GU_C;
};

/**
 * 로그인정보중 시구상세CODE 제공
 *
 * @date 2018. 10. 02.
 * @memberOf com
 * @author 문석길 (SFI 최황연 대리 요청)
 * @return 시구상세CODE
 * @example com.getCtGusangTaxC
 */
com.getCtGusangTaxC = function() {
    return gcm.LOGIN.CT_GUSANG_TAX_C;
};

/**
 * 로그인정보중 청소CODE 제공
 *
 * @date 2018. 10. 02.
 * @memberOf com
 * @author 문석길 (SFI 최황연 대리 요청)
 * @return 청소CODE
 * @example com.getChngsC
 */
com.getChngsC = function() {
    return gcm.LOGIN.CHNGS_C;
};

/**
 * 로그인정보중 사업자번호 제공
 *
 * @date 2018. 10. 02.
 * @memberOf com
 * @author 문석길 (SFI 최황연 대리 요청)
 * @return 사업자번호
 * @example com.getBizno
 */
com.getBizno = function() {
    return gcm.LOGIN.BIZNO;
};

/**
 * 로그인정보중 사업자명 제공
 *
 * @date 2018. 10. 02.
 * @memberOf com
 * @author 문석길 (SFI 최황연 대리 요청)
 * @return 사업자명
 * @example com.getProvrNm
 */
com.getProvrNm = function() {
    return gcm.LOGIN.PROVR_NM;
};

/**
 * 로그인정보중 시스템유형 제공
 *
 * @date 2018. 12. 10.
 * @memberOf com
 * @author 문석길 (TRS 이태식 과장 요청)
 * @return 시스템유형 (D:개발, T:검증, R:운영)
 * @example com.getSysUFlg
 */
com.getSysUFlg = function() {
    return gcm.LOGIN.SYS_U_FLG;
};

/**
 * 로그인정보중 그리드페이지단위건수(소) 제공
 *
 * @date 2018. 12. 11.
 * @memberOf com
 * @author 문석길
 * @return 그리드페이지단위건수(소) 100건
 * @example com.getGridPageUnitCntSm
 */
com.getGridPageUnitCntSm = function() {
    // 만약에 데이터를 DB에서 가져오지 못 할 경우 20건으로 return한다.
    if (com.isEmpty(gcm.LOGIN.GRID_PAGE_UNIT_CNT_SM)) {
        //return "20";
    	return "100";
    }
    return gcm.LOGIN.GRID_PAGE_UNIT_CNT_SM;
};

/**
 * 로그인정보중 그리드페이지단위건수(중) 제공
 *
 * @date 2018. 12. 11.
 * @memberOf com
 * @author 문석길
 * @return 그리드페이지단위건수(중) 500건
 * @example com.getGridPageUnitCntMd
 */
com.getGridPageUnitCntMd = function() {
    // 만약에 데이터를 DB에서 가져오지 못 할 경우 100건으로 return한다.
    if (com.isEmpty(gcm.LOGIN.GRID_PAGE_UNIT_CNT_MD)) {
        return "100";
    }
    return gcm.LOGIN.GRID_PAGE_UNIT_CNT_MD;
};

/**
 * 로그인정보중 그리드페이지단위건수(대) 제공
 *
 * @date 2018. 12. 11.
 * @memberOf com
 * @author 문석길
 * @return 그리드페이지단위건수(대) 2000건
 * @example com.getGridPageUnitCntLrge
 */
com.getGridPageUnitCntLrge = function() {
    // 만약에 데이터를 DB에서 가져오지 못 할 경우 400건으로 return한다.
    if (com.isEmpty(gcm.LOGIN.GRID_PAGE_UNIT_CNT_LRGE)) {
        return "400";
    }
    return gcm.LOGIN.GRID_PAGE_UNIT_CNT_LRGE;
};

/**
 * 로그인정보중 그리드페이지단위건수(최대) 제공
 *
 * @date 2018. 12. 11.
 * @memberOf com
 * @author 문석길
 * @return 그리드페이지단위건수(최대) 50000건
 * @example com.getGridPageUnitCntMax
 */
com.getGridPageUnitCntMax = function() {
    // 만약에 데이터를 DB에서 가져오지 못 할 경우 10000건으로 return한다.
    if (com.isEmpty(gcm.LOGIN.GRID_PAGE_UNIT_CNT_MAX)) {
        return "10000";
    }
    return gcm.LOGIN.GRID_PAGE_UNIT_CNT_MAX;
};

/**
 * 메뉴정보중 메뉴ID 제공
 *
 * @date 2018. 10. 12.
 * @memberOf com
 * @author 문석길
 * @return 메뉴ID
 * @example com.getMenuId
 */
com.getMenuId = function() {
    return gcm.MENU_ID;
};

/**
 * 메뉴정보중 메뉴명 제공
 *
 * @date 2018. 10. 12.
 * @memberOf com
 * @author 문석길
 * @return 메뉴명
 * @example com.getMenuNm
 */
com.getMenuNm = function(inMenuId) {
    var _dltObj = null;
    var scrinfo = null;

    // 입력된 메뉴ID가 존재할 경우 입력메뉴ID로 메뉴명을 검색하고
    // 없을 경우 현재 화면의 메뉴ID로 메뉴명을 검색하여 제공한다.
    if (com.isEmpty(inMenuId)) {
        if (com.isEmpty(gcm.MENU_ID)) {
            return null;
        }

        _dltObj = gcm.mainFrame.getObj("MSFI010601R01OutList");
        scrinfo = _dltObj.getMatchedJSON("MENU_ID", gcm.MENU_ID)[0];
    } else {
        _dltObj = gcm.mainFrame.getObj("MSFI010601R01OutList");
        scrinfo = _dltObj.getMatchedJSON("MENU_ID", inMenuId)[0];
    }
    return scrinfo.MENU_NM;
};

/**
 * 메뉴정보중 화면명 제공
 *
 * @date 2018. 11. 02.
 * @memberOf com
 * @author 문석길
 * @return 메뉴명
 * @example com.getScrNm
 */
com.getScrNm = function(inMenuId) {
    var _dltObj = null;
    var scrinfo = null;

    // 입력된 메뉴ID가 존재할 경우 입력메뉴ID로 메뉴명을 검색하고
    // 없을 경우 현재 화면의 메뉴ID로 화면명을 검색하여 제공한다.
    if (com.isEmpty(inMenuId)) {
        if (com.isEmpty(gcm.MENU_ID)) {
            return null;
        }

        _dltObj = gcm.mainFrame.getObj("MSFI010601R01OutList");
        scrinfo = _dltObj.getMatchedJSON("MENU_ID", gcm.MENU_ID)[0];
    } else {
        _dltObj = gcm.mainFrame.getObj("MSFI010601R01OutList");
        scrinfo = _dltObj.getMatchedJSON("MENU_ID", inMenuId)[0];
    }
    return scrinfo.SCR_NM;
};

/**
 * 메뉴정보중 화면ID 제공
 *
 * @date 2018. 10. 12.
 * @memberOf com
 * @author 문석길
 * @return 화면ID
 * @example com.getScrId
 */
com.getScrId = function() {
    return gcm.SCR_ID;
};

/**
 * 사용자권한범위구분 제공
 * 메뉴정보중에서 사용자권한범위구분 1:입력, 2:조회 정보를 제공한다.
 * 메뉴ID가 없을 경우 null 값으로 제공한다.
 *
 * @date 2018. 10. 12.
 * @memberOf com
 * @author 문석길
 * @return 사용자권한범위구분
 * @example com.getUserRightScopG()
 */
com.getUserRightScopG = function() {

    if (com.isEmpty(gcm.MENU_ID)) {
        return null;
    }

    // 메뉴정보 datalist 안에서 동일 메뉴ID 존재시 사용자권한범위구분를 제공한다.
    var _dltObj = gcm.mainFrame.getObj("MSFI010601R01OutList");
    var scrinfo = _dltObj.getMatchedJSON("MENU_ID", gcm.MENU_ID)[0];
    return scrinfo.USER_RIGHT_SCOP_G;
};

/**
 * 사용자특화범위CODE 제공
 * 세션정보중에서 사용자특화범위CODE (예. 법인카드일 경우  L3:사용자(L3)) 값을 제공한다.
 *
 * @date 2018. 10. 31.
 * @memberOf com
 * @author 문석길
 * @return 사용자특화범위CODE
 * @example com.getUserRightScopG("사용자특화CODE 한글명") --> '카드', '기금', '환경' 등등
 */
com.getUserSpzScopC = function(SpzNm) {

    // 특화명이 없을 경우 바로 return 한다.
    if (com.isEmpty(SpzNm)) {
        return null;
    }

    // 세션의 사용자별특화내역을 반복 처리하면서 입력.특화명이 포함될 경우 사용자특화범위CODE를 return한다..
    //console.log(com.getPrintTime()+"[common.js][com.getUserSpzScopC()] 입력.특화명 (SpzNm) = "+SpzNm);
    //console.log(com.getPrintTime()+"[common.js][com.getUserSpzScopC()] com.getUserBySpzHis().length = "+com.getUserBySpzHis().length); // 사용자별특화내역건수
    for (var i = 0; i < com.getUserBySpzHis().length; i++) {
        if (com.getUserBySpzHis()[i].USER_SPZ_NM.indexOf(SpzNm) > -1) {
            return com.getUserBySpzHis()[i].USER_SPZ_SCOP_C;
        }
    }

    return null;
};

/**
 * getPrintTime : 출력용 시각 구하기
 * @date 2018. 10. 12.
 * @memberOf com
 * @author 문석길
 * @return 사용자권한범위구분
 * @example com.getPrintTime()
 */
com.getPrintTime = function() {
    var datetime = new Date();
    var datetimeStr = "["+WebSquare.date.toTimestampString (datetime)+"]";
    return datetimeStr;
};

/**
 * 코드성 데이터와 컴포넌트의 nodeSet(아이템 리스트)연동 기능을 제공한다. code별로 JSON객체를 생성하여 array에 담아 첫번째
 * 파라메터로 넘겨준다.
 *
 * @date 2018.08.09
 * @param {Object}
 *            codeOptions {"code" : "코드넘버", "compID" : "적용할 컴포넌트명"}
 * @param {requestCallback}
 *            callbackFunc 콜백 함수
 * @memberOf com
 * @author scs
 * @example var codeOptions = [ { code : "01", compID : "sbx_Duty" }, { code :
 *          "02", compID : "sbx_Postion,grd:col" }, { code : "21", compID :
 *          "sbx_JoinClass" }, { code : "05", compID : "sbx_CommCodePart1,
 *          sbx_CommCodePart2"}, { code : "24", compID
 *          :"grd_CommCodeSample:JOB_CD"} ]; com.setCommCode(codeOptions);
 */

com.setCommCode = function(codeObjArr, callbackFunc) {

    var codeObjLen = 0;

    if (codeObjArr) {
        codeObjLen = codeObjArr.length;
    } else {
        //m_        console.log("=== com.setCommCode Parameter Type Error ===\nex) com.setCommCode([{\"code:\":\"04\",\"compID\":\"sbx_Gender\"}],\"scsObj.callbackFunction\")\n===================================");
        return;
    }

    var i, j, codeObj, dltId, dltIdArr = [], paramCode = "", compArr, compArrLen, tmpIdArr, codeOrg = [];
    var dataListOption = this._getCodeDataListOptions(gcm.COMMON_CODE_INFO.FILED_ARR);

    for (var i = 0; i < codeObjLen; i++) {
        codeObj = codeObjArr[i];
        try {
            dltId = gcm.DATA_PREFIX + "_" + codeObj.code;
            $p.top().scsObj.commonCodeList = $p.top().scsObj.commonCodeList
                    || [];
            if (typeof $p.top().scsObj.commonCodeList[dltId] === "undefined") {// 받아온
                                                                                // 데이터가
                                                                                // 없을경우
                codeOrg.push(codeObj.code);
                dltIdArr.push(dltId);
                if (i > 0) {
                    paramCode += ",";
                }
                paramCode += codeObj.code;
                dataListOption.id = dltId;
                com.createDataObj("dataList", dataListOption.id,
                        gcm.COMMON_CODE_INFO.FILED_ARR);
            } else {// 받아온 데이터가 있을경우
                dataListOption.id = dltId;
                /*com.createDataObj("dataList", dataListOption.id,
                        gcm.COMMON_CODE_INFO.FILED_ARR);*/
                //var dataListObj = this.$p.getComponentById(dataListOption.id);
                //dataListObj.setJSON(this.getJSON($p.top().scsObj.commonCodeList[dltId]));
            }
            if (codeObj.compID) {
                compArr = (codeObj.compID).replaceAll(" ", "").split(",");
                compArrLen = compArr.length;
                for (j = 0; j < compArrLen; j++) {
                    tmpIdArr = compArr[j].split(":");
                    // 기본 컴포넌트
                    if (tmpIdArr.length === 1) {
                        var comp = this.$p.getComponentById(tmpIdArr[0]);
                        comp.setNodeSet("data:" + dltId,
                                gcm.COMMON_CODE_INFO.LABEL,
                                gcm.COMMON_CODE_INFO.VALUE);
                        // gridView 컴포넌트
                    } else {
                        var gridObj = this.$p.getComponentById(tmpIdArr[0]);
                        gridObj.setColumnNodeSet(tmpIdArr[1], "data:" + dltId,
                                gcm.COMMON_CODE_INFO.LABEL,
                                gcm.COMMON_CODE_INFO.VALUE);
                    }
                }
            }
        } catch (ex) {
            //m_            console.log("com.setCommCode Error");
            //m_            console.log(JSON.stringify(codeObj));
            //m_            console.log(ex);
            continue;
        }
    }

    // ///////////////////////////////////////////
    // 1. 데이터 객체 생성
    // 2. 맵핑할 component에 setting
    // 3. submission 생성
    // ///////////////////////////////////////////
    // 공통코드 MSFI020101R99In 생성
    com.createDataObj("dataMap", "MSFI020101R99In", [ "CMM_C_NM" ]);
    com.createDataObj("dataMap", "MSFI020101R99Out", [ "TOT_CNT" ]);
    com.createDataObj("dataList", "MSFI020101R99OutList", gcm.COMMON_CODE_INFO.FILED_ARR);
    MSFI020101R99In.set("CMM_C_NM", codeOrg.join());

    var searchCodeGrpOption = {
        mode : "synchronous",   // asynchronous, synchronous
        id : "sbm_SearchCode",
        ref : "data:json,MSFI020101R99In",
        action : "",
        target : "data:json," + this.strSerialize(dltIdArr),
        userData1 : [ {svc_id:"SSFI020101R99", msg_id:"MSFI020101R99In", sbm_id:"sbm_CommonCode", isshowMsg:true} ]
    };

    searchCodeGrpOption.submitDoneHandler = function(e) {
        for (codeGrpDataListId in e.responseJSON) {
            if (codeGrpDataListId.indexOf(gcm.DATA_PREFIX) > -1) {
                $p.top().scsObj.commonCodeList[codeGrpDataListId] = com
                        .strSerialize(e.responseJSON[codeGrpDataListId]);
            }
        }
        if (typeof callbackFunc === "function") {
            callbackFunc();
        }
    }
    gcm.IS_TR = true;
    this.executeSubmission_dynamic(searchCodeGrpOption);
};




com.getFrameId = function() {
    return this.$p.getFrameId();
};


/*
 * UDC의 내부component의 값을 읽습니다.
 * */
com.getUdcValue = function(udc_id,comp_id){
        var nowFrame = this.$p.getFrame();
        var udcObj = nowFrame.getObj(udc_id);
        var udc_incomp = comp_id;
        var udc_incomp_id = udcObj.id +"_"+ udc_incomp;
        var comp = $p.comp[udc_incomp_id];
        return comp.getValue();
};


/*
 * UDC의 내부component의 값을 set합니다.
 * */
com.setUdcValue = function(udc_id,comp_id,val){
        var nowFrame = this.$p.getFrame();
        var udcObj = nowFrame.getObj(udc_id);
        var udc_incomp = comp_id;
        var udc_incomp_id = udcObj.id +"_"+ udc_incomp;
        var comp = $p.comp[udc_incomp_id];
        comp.setValue(val);
};


/*
 * tab 화면을 업니다.
 * @date 2018.08.20
 * @param {String} url[필수] "/ui/tom/smp/xml/CTMXXXXXXM01.xml"
 * @param {String} gbn[옵션] "now" or "new"  ==> now : 현채탭에서 , new : 새탭으로
 * @param {String} title[(gbn==new)필수] "새탭으로 열때 사용할 제목"
 * @memberOf com
 * @author scs
 * @example
 * CASE 1 ) 새탭으로 열때
 *          var _url = "/ui/tom/smp/xml/CTMXXXXXXM01.xml";
 *          var gbn = "new";
 *          var title = "새탭 타이틀"
 *
 *          com.openTab(_url, gbn, title);
 *
 * CASE 2 ) 현재 탭에서 다른 화면으로 변경할때
 *          var _url = "/ui/tom/smp/xml/CTMXXXXXXM01.xml";
 *          var gbn = "now";
 *          com.openTab(_url, gbn);
 *
 * */
com.openTab = function(_url, gbn, title){

    if(this.isEmpty(_url)){
        alert("url 정보가 없습니다.");
        return false;
    }

    var _gbn = gbn || "";
    if(gbn == "now"){//현재 탭에서
        var _frame = this.$p.getFrame();
        _frame.setSrc(_url);
    }else{
        var rId = dateLib.getDate();
        var _main = this.$p.top();
        var _mainTab = _main[gcm.MAIN_FRAME_ID];
        // 새탭으로

        _mainTab.createWindow( title                // (필수) title         : 툴바의 네임레이어에 표시되는 타이틀.
                             , null                 // (필수) iconUrl       : 현재는 사용되지 않으며 null로 입력한다.(각 윈도우의 아이콘 url 문자열)
                             , _url                 // (필수) src           : window에 link할 페이지의 URL.
                             , title                // (옵션) windowTitle   : window의 헤더에 표시될 타이틀로 null 이나 ""입력시 title값이 출력.
                             , rId                  // (옵션) windowId      : window ID로 null 이나 ""입력시 title이 id로 생성.
                             //, "existWindow"      // (옵션) openAction    : [existWindow, newWindow, selectWindow]existWindow : id가 동일한 윈도우가 떠있으면 그 윈도우를 사용하여 다시 표시 / newWindow : 항상 새로운 창을 생성 / selectWindow : id가 동일한 창이 있으면 그 윈도우를 선택
                             // 2018-10-04 : SFI 이광옥 수석 요청으로 existWindow -> selectWindow 변경
                             , "selectWindow"       // (옵션) openAction    : [existWindow, newWindow, selectWindow]existWindow : id가 동일한 윈도우가 떠있으면 그 윈도우를 사용하여 다시 표시 / newWindow : 항상 새로운 창을 생성 / selectWindow : id가 동일한 창이 있으면 그 윈도우를 선택
                             , "com.closeScreen"    // (옵션) closeAction   : window가 닫힐 때 동작을 지정하는 함수명(return은 boolean으로 하여야 함 false일 경우 닫기 중지, true일 경우 닫기)
                             , null                 // (옵션) windowTooltip : 툴바의 네임레이어에 표현될 tooltip.(미입력시 windowTitle이 tooltip으로 셋팅됨)
/*                             , null
                             , null
                             , "wframe"*/
                             );
    }
};

/*
 * 파일 업로드 후 콜백 호출
 * @date 2018.08.21
 * @param {String} multiCompId 파일 업로드 컴포넌트 id
 * @param {String} callbackFunction 콜백 펑션 명
 * @memberOf com
 * @author scs
 * @example
 *-
 * // multi_upload_id 의 파일을 업로드 한후
 * // scsObj.callback 콜백에 업로드한 결과를 던져 줍니다.
 * com.fileUploadPromise("multi_upload_id","scsObj.callback");
 *
 *
 * */
com.fileUploadPromise = function(multiCompId, callbackFunction, AttchFileMngNo){
//debugger;
    var fr = this.$p.getFrame();
    var _AttchFileMngNo = AttchFileMngNo||"";
    var promise = new Promise(function(resolve,reject,_AttchFileMngNo){
        var m = fr.getObj(multiCompId);
        if(m.getFileCount() === 0){
            console.log(com.getPrintTime()+"[common.js][com.fileUploadPromise] 업로드할 파일이 없습니다.promise1");//없을수도 있다.
            resolve("");
            return;
        }
        m.unbind("ondone");
        m.bind("ondone",function(data){
        	
        resolve({frame:fr,_data:data});});
        //debugger;
        m.startUpload();

    });


    //파일 db저장 process
    promise = promise.then(function(res){
    	//debugger;

        if(res == ""){
            console.log(com.getPrintTime()+"[common.js][com.fileUploadPromise] 업로드할 파일이 없습니다.promise2");//없을수도 있다.
            return "";
        }
        var fileInfo = res._data;
        var frr = res.frame;

        return new Promise(function(resolve,reject){
            // 데이터 객체 생성
//            com.createDataObj("dataList", "MSFI010201C99InList", [ "SL_GMGO_MODL_C", "ATTCH_FILE_MNG_NO","ATTCH_FILE_SER", "SVR_FILE_PATH", "SVR_FILE_NM" ,"CLNT_FILE_NM","ATTCH_FILE_SIZE","BIGO_CTNT","USE_YN"]);
            com.createDataObj("dataList", "MSFI010201C99InList", [ "ATTCH_FILE_MNG_NO","ATTCH_FILE_SER", "SVR_FILE_NM" ,"CLNT_FILE_NM","ATTCH_FILE_SIZE","BIGO_CTNT","USE_YN", "USER_ID"]);  //(보안취약성으로 인한 처리.by BYON.2018.11.27)
            com.createDataObj("dataMap" , "MSFI010201C99In"    , [ "TOT_CNT"]);
            com.createDataObj("dataMap" , "MSFI010201C99Out"   , [ "ATTCH_FILE_MNG_NO"]);

            MSFI010201C99InList.removeAll();
            MSFI010201C99InList.reform();

            var _userId = "";

            //보조금 로그인 안 된 경우 파일upload 처리 추가
            if(com.getSlGmgoModlC().length < 1){
                _userId = "SES_GUEST";
            } else {
                _userId = com.getUserId();
            }

            var jsnData = [];
            for(var i=0; i<fileInfo.length; i++){
                var temp = fileInfo[i];

//              첨부파일 테이블 저장을 위한 In 정보 담기
                jsnData.push({
//                     "SL_GMGO_MODL_C"     : com.getSlGmgoModlC()   // 서울시금고모듈코드(보안취약성으로 인한 처리.by BYON.2018.11.26)
                    "ATTCH_FILE_MNG_NO" : _AttchFileMngNo
                    , "ATTCH_FILE_SER"    : (i+1)
//                    , "SVR_FILE_PATH"     : temp.key              // 서버파일경로(보안취약성으로 인한 처리.by BYON.2018.11.26)
                    , "SVR_FILE_NM"       : temp.file               // 서버파일명
                    , "CLNT_FILE_NM"      : temp.localFile          // 클라이언트파일명
                    , "ATTCH_FILE_SIZE"   : temp.size               // 첨부파일크기
                    , "BIGO_CTNT"         : ""                      // 비고내용
                    , "USE_YN"            : "Y"                     // 사용여부
                    , "USER_ID"           : _userId         // 사용자ID(보안취약성으로 인한 처리.by BYON.2018.11.27)
                 });
            }

            MSFI010201C99InList.setJSON(jsnData);
            MSFI010201C99In.set("TOT_CNT", jsnData.length); // 총건수 세팅

            // submission 객체 생성
            var fileSaveOption = {
                mode : "synchronous",   // asynchronous, synchronous
                id : "sbm_fileSave",
                ref : "data:json,[MSFI010201C99In,MSFI010201C99InList]",
                action : "",
                userData1 : [ {svc_id:"SSFI010201C99", msg_id:"MSFI010201C99In", sbm_id:"sbm_fileSave", isshowMsg:true} ]
            };

            fileSaveOption.submitDoneHandler = function(e) {
                resolve(e);
            }
            gcm.IS_TR = true;

            var _com  = frr.getObj("com");
            _com.executeSubmission_dynamic(fileSaveOption);

        });

    });


    promise = promise.then(function(res){
        if(com.isEmpty(res)){
            var rtn_v = _AttchFileMngNo || "";
            callbackFunction(rtn_v);
        }else{
            var file_MngNo = "";
            if(!com.isEmpty(res.responseJSON)){
                if(!com.isEmpty(res.responseJSON.MSFI010201C99Out)){
                    file_MngNo = res.responseJSON.MSFI010201C99Out.ATTCH_FILE_MNG_NO;
                }else if(!com.isEmpty(res.responseJSON.MSFI010201R99Out)){
                    file_MngNo = res.responseJSON.MSFI010201R99Out.ATTCH_FILE_MNG_NO;
                }
            }
            callbackFunction(file_MngNo);
        }
    });
};

com.resizeTarget_id = "";
com.setGridResize = function(obj_id){

    if(com.isEmpty(obj_id)){
        return false;
    }
    var nf = this.$p.getFrame();
    $(window).resize(function(){
        //var obj_id = com.resizeTarget_id;

        var grd = nf.getObj(obj_id);
        var t = $(".re_top").height()+5;
        $(".re_gridbox").css("top",t);
        var h = $(".re_gridbox").height();
        grd.setSize(null,h);

    });



};

com.setGrdTop = function(_nf){


var now = this.$p || $p;
    var nf = now.getFrame() || _nf;
    var h = $("#"+nf.id+" .re_top").height();
    var gridObj = $("#"+nf.id+" .re_gridbox .cm_grid")[0] || $("#"+nf.id+" .re_tabbox .cm_grid")[0];

    if(h == 0){
        setTimeout(function() {
            com.setGrdTop(nf);
        }, 500);
    }else{
//      var _comp = $p.comp[gridObj.id];
//        _comp._dataList.insertRow();
        $("#"+nf.id+" .re_gridbox").css("top",h+5);
        $("#"+nf.id+" .re_tabbox").css("top",h+5);
        try{
//        _comp._dataList.removeAll();
//        _comp._dataList.reform();
        }catch(e){
            console.log("chk :"+e.toString());
        }
    }





};

com.setGrdTop_test = function(_nf){

    var now = this.$p || $p;
        var nf = now.getFrame() || _nf;
        var h = $("#"+nf.id+" .re_top").height();
//      var gridObj = $("#"+nf.id+" .re_gridbox .cm_grid")[0] || $("#"+nf.id+" .re_tabbox .cm_grid")[0];

        if(h == 0){
            setTimeout(function() {
                com.setGrdTop(nf);
            }, 500);
        }else{
//          var _comp = $p.comp[gridObj.id];
//          _comp._dataList.insertRow();
            $("#"+nf.id+" .re_gridbox").css("top",h+5);
            $("#"+nf.id+" .re_tabbox").css("top",h+5);
            try{
//          _comp._dataList.removeAll();
//          _comp._dataList.reform();
            }catch(e){
                console.log("chk :"+e.toString());
            }
        }


    };


com.setGrdtabTop = function(){
    var h = $(".re_tabtop").height();
    if(h == 0){
        setTimeout(function() {
            com.setGrdtabTop();
        }, 500);
    }
    $(".re_tabgridbox").css("top",h+5);

};




/* gridView 동적 생선 start */
/**
 * 동적 그리드 생성/스타일 변경
 * 기본적인 정보를 통해 그리드를 동적으로 생성하거나 스타일을 변경합니다.
 *
 * @date 2018. 08. 30.
 * @param {Array} gridOptionsArr JSONArray  형태로 데이터 동적 그리드생성및 스타일변경할 데이터 구조체
 * @param {String=} gridOptionsArr.id 그리드ID
 * @param {String=} gridOptionsArr.ref 참조할 데이터셋
 * @param {String=} gridOptionsArr.colNmType 그리드의 헤더를 생성할때 id로 할것인지 name으로 할것인지 정의
 * @param {String=} gridOptionsArr.colTpJsn 그리드의 바디 컬럼의 inputType="text"를 제외한 정보를 지정합니다.
 * @param {String=} gridOptionsArr.type 플래그 "C":새로생성,"R":기존 그리드의 스타일변경
 * @param {String=} gridOptionsArr.parentObj type="C"인경우 생성될 그리드의 부모,"R"인경우 없어도무관
 * @param {String=} gridOptionsArr.style 그리드에 적용할 스타일
 *
 * @memberOf com
 * @author InswaveSystems
 * @example
 *
 * var gridViewInfo = [{ //gridview동적생성
 *       id:"grd_Create"
 *       ,ref:"dlt_Create"
 *       ,colNmType:"id" 또는 "name"// header의 name을 datalist의 컬럼정보중 id로 할것인지 name으로 할것인지 default:"name"
 *       ,colTpJsn: {colid:inputType,colid2:inputType2,...}//default column의 inputType은 'text' 입니다. 기타 inputType에 대해 기술합니다.
 *                   // ex) {bttonId:'select',bttonchk:'check',...}
 *       ,colExp:["progrmId",...] // 그리드 생성시 제외할 컬럼
 *       ,type:"C"|"R" //"C": parent밑에 생성,"R":이미 생성된 그리드뷰의 스타일을 변경
 *       ,parentObj:"grp_parent" // type이 "R"인경우 없어도됩니다.
 *       ,style:"width: 500px;height: 150px;" //
 *  },...]
 * com.createGridView(gridViewInfo);
 *
 */
com.createGridView = function(gridOptionsArr){
        if(com.isEmpty(gridOptionsArr) || gridOptionsArr.length == 0){
            //m_                console.log(com.getPrintTime()+"[common.js][com.createGridView] 생성할 그리드 정보가 없습니다.");
                return;
        }
        var fr = this.$p.getFrame();

        for(var key in gridOptionsArr){
                if(!gridOptionsArr.hasOwnProperty(key)) continue;
                var gridObj = gridOptionsArr[key];
                var dl_info = {
                        id :gridObj.ref
                        ,type : gridObj.colNmType || "name"  // header의 name을 datalist의 컬럼정보중 id로 할것인지 name으로 할것인지 default:"name"
                };
                var _colTpJsn = gridObj.colTpJsn;
                var _colExp = gridObj.colExp;

                //var grdStrObj  = com.grdHeaderBodyStr(dl_info,_colTpJsn,_colExp);
                var grdStrObj  = this.grdHeaderBodyStr(dl_info,_colTpJsn,_colExp);
                var subgridObj = {
                        id : gridObj.id
                        ,ref:gridObj.ref
                        ,style:gridObj.style
                        ,headerStr :grdStrObj.strH
                        ,bodyStr:grdStrObj.strB
                }
                var gridStr = com.getGridViewSrc(subgridObj);
                if(gridObj.type == "C"){

                        //var pComp = $p.comp[gridObj.parentObj];
                        var pComp = fr.getObj(gridObj.parentObj);
                        //WebSquare.util.dynamicCreate(gridObj.id, "gridView", gridStr, pComp );
                        this.$p.dynamicCreate(gridObj.id, "gridView", gridStr, pComp );
                }else if(gridObj.type == "R"){
                        //var _g_view = $p.comp[gridObj.id];
                    var _g_view = fr.getObj(gridObj.id);
                        _g_view.setGridStyle(WebSquare.xml.parse( gridStr , true ));

                }else{
                    //m_                        console.log(com.getPrintTime()+"[common.js][com.createGridView] 타입이 지정되어있지않습니다.");
                }

        }
};

/**
 * 데이터리스트로부터 그리드에 적용할 header/body string정보 얻어오기
 *
 * @private
 * @param {JSON} dl_info 데이터 정보
 * @param {String=} dl_info.id 데이터리스트 아이디
 * @param {String=} dl_info.type 그리드의 헤더셀의 값을 결정한다. default:"name" "id"
  * @date 2018. 08. 30.
 * @memberOf com
 * @author InswaveSystems
 * @example
 *
 * var dl_info = {
 *                 id :"dlt_datalistid"
 *                 ,type : "name||id"  // header의 name을 datalist의 컬럼정보중 id로 할것인지 name으로 할것인지 default:"name"
 *                }
 * var colTpJsn = {colid1:'select',colid2:'radio',...}//input type 결정
 * var colExp = ['colid1','colid2',...]               // 제외할 컬럼 결정
 * com.grdHeaderBodyStr(dl_id,colTpJsn);
 */
com.grdHeaderBodyStr = function(dl_info,colTpJsn,colExp){
    var rtnObj = {strH:"",strB:""};
    if(com.isEmpty(dl_info.id)){
        //m_        console.log(com.getPrintTime()+"[common.js][com.grdHeaderBodyStr] 데이터리스트 아이디가 없습니다.");
        return;
    }
    var fr = this.$p.getFrame();

    var dlObj = fr.getObj(dl_info.id)|| $p.data[dl_info.id] || {};

    //var dlObj = $p.data[dl_info.id] || {};
    if(com.isEmpty(dlObj)){
        //m_        console.log(com.getPrintTime()+"[common.js][com.grdHeaderBodyStr] 데이터리스가 없습니다.");
        return;
    }
    var _type = dl_info.type || "name";
    var _colTpJsn = colTpJsn || {};
    var _colExp = colExp || [];
    var _colExpJsn = {};
    if(_colExp.length>0){
        for(var key in _colExp){
            if(!_colExp.hasOwnProperty(key)) continue;
            _colExpJsn[_colExp[key]] = "Y";
        }
    }

    var colIdArr = dlObj.cellIdList;

    var gridHeader = '';
    var gridBody = '';
    ////데이터리스트 기준으로 컬럼을 만든다.
    for (var k in colIdArr){
            if(!colIdArr.hasOwnProperty(k)) continue;
            var colid = colIdArr[k];
            if(_colExpJsn[colid] == "Y") continue;
            var colNm = _type == "name" ? dlObj.getColumnName(colid) : colid;
            gridHeader +='<w2:column blockSelect="false" id="'+'h'+colid+'" style="height:20px" inputType="text" width="70" value="'+colNm+'"></w2:column>';

            var inputType = _colTpJsn[colid] || "text";
            gridBody += '<w2:column blockSelect="false" id="'+colid+'" style="height:20px" inputType="'+inputType+'" width="70"></w2:column>';
    }
    rtnObj.strH = gridHeader;
    rtnObj.strB = gridBody;
    return rtnObj;
};



/**
 * 생성할 그리드의 기본 문자열
 * @private
 * @date 2018. 08. 30.
 * @memberOf com
 * @author InswaveSystems
 * @example
 *
 * var obj = [{ //gridview동적생성
 *       id:"grd_Create"  //  생성할 그리드의 id
 *       ,ref:"dlt_Create" // 참조할 데이터리스트의 id
 *       ,style:"width: 500px;height: 150px;" //
 *       ,headerStr :"헤더에 적용할 스트링" || "";
         ,bodyStr :"바디에 적용할 스트링"|| "";
 *  },...]
 * com.getGridViewSrc(obj);
 */
com.getGridViewSrc = function(obj){
        var _id = obj.id ;
        var _datalist = obj.ref ;
        var _style = obj.style || "width: 500px;height: 150px;";
        var gridHeader = obj.headerStr || "";
        var gridBody = obj.bodyStr || "";
             var gridStr = '<w2:gridView xmlns:w2="http://www.inswave.com/websquare" xmlns:ev="http://www.w3.org/2001/xml-events" dataList="data:'
                + _datalist
                + '" scrollByColumn="false" id="'
                + _id
                + '" style="'
                + _style
                + '" fixedColumnWithHidden="true" useShiftKey="false" autoFit="allColumn">'
                + '<w2:header id="header1" style="">'
                + '<w2:row id="row1" style="">'
                + gridHeader
                + '</w2:row>'
                +'</w2:header>'
                +'<w2:gBody id="gBody1" style="">'
                +'<w2:row id="row2" style="">'
                + gridBody
                +'</w2:row>'
                +'</w2:gBody>'
                +'</w2:gridView>' ;
        return gridStr ;
};
/* gridView 동적 생성 finish */

/* contextMenu 생성 start */
/**
 *
 * gridView의 contextMenu를 setting한다.
 * @date 2018. 09. 05.
 * @memberOf com
 * @author archie
 * @example
 * //step 1
 * // contextMenu에 적용할 정보를 기록합니다.
 * var contextArr = [{
    id:"grd_fmmtrpay",//grid의 id
    set:true/false,   //contextMenu를 설정할지 여부
    hideSystemMenu:["ColumnHide","Group","ColumnFix","ColumnAdjustWidth","ColumnAdjustAuto"],// 특정항목의 시스템 메뉴를 숨김니다
    appendMenu:[{
                            label:"엑셀다운로드",//사용자 메뉴의 표시 문자열
                            userMenuId:"excelDownLoad",//사용자 메뉴의 id, 해당 컨텍스트메뉴가 클릭될때 입력값으로 전달됨
                            className:"",//사용자 메뉴의 스타일 클래스 이름
                            callback:"scwin.exceldown",// 이벤트를 클릭했을때 실행되는 콜백
                            param:{}// callback에 넘겨줄 param Object
                    },...]//시스템 메뉴 아래에 사용자 메뉴를 추가합니다.:
    },{
        id:"grd_fmmtrpaySub",
        set:true,
        hideSystemMenu:["ColumnHide"],//["ColumnHide","Group","ColumnFix","ColumnAdjustWidth","ColumnAdjustAuto"],// 특정항목의 시스템 메뉴를
        appendMenu:[{
                                        label:"기타 사용자 정의",//사용자 메뉴의 표시 문자열
                                        userMenuId:"etcUserDefine",//사용자 메뉴의 id, 해당 컨텍스트메뉴가 클릭될때 입력값으로 전달됨
                                        className:"",//사용자 메뉴의 스타일 클래스 이름
                                        callback:"scwin.userDfnCallback",// 이벤트를 클릭했을때 실행되는 콜백
                                        param:{}// callback에 넘겨줄 param Object
                                    },...]//시스템 메뉴 아래에 사용자 메뉴를 추가합니다.:
    }];
    // step2
    // 사용하려는 시점에 다름과 같이 기술합니다.
 *  com.setContext.init(contextArr);
 *
 */
com.setContext = {
        menuSet:[],
        init : function(contextArr){
        this.menuSet = [];
            for(var key =0;key<contextArr.length;key++){
                var obj = contextArr[key];
                var grd_Comp = $p.comp[obj.id];
                grd_Comp.options.contextMenu = obj.set || false ;
                this.menuSet.push({
                                id:obj.id
                                ,hide:obj.hideSystemMenu
                                ,append:obj.appendMenu
                                });

                grd_Comp.bind('oncontextopen',this.oncontextopen,this);
                grd_Comp.bind('oncontextclick',this.oncontextclick,this);

            }},
        oncontextopen  : function(row,col){
            var obj = com.setContext.getMenuInfo(this.id);
            return {
                        hideSystemMenu:obj.hide,
                        appendMenu:obj.append
            };

        },
        oncontextclick : function(r,c,u,i,s){
            var obj = com.setContext.getMenuInfo(this.id);
            var appendMenu = obj.append;
            for(var i=0;i<appendMenu.length;i++){
                if(u == appendMenu[i].userMenuId){
                    if(!com.isEmpty(appendMenu[i].callback)){
                        var cb = appendMenu[i].callback;
                        var cArr = cb.split(".");//cb의 구조는 scwin.sampleFunc와 같이 "."하나만
                        var cf = window[cArr[0]][cArr[1]];
                        appendMenu[i].param = appendMenu[i].param || {};
                        cf(this.id,appendMenu[i].param);
                    }
                }
            }
        },
        getMenuInfo : function(_id){
            var rtnObj = {};
            for(var i=0;i<this.menuSet.length;i++){
                if(_id == this.menuSet[i].id){
                    rtnObj.hide = this.menuSet[i].hide;
                    rtnObj.append = this.menuSet[i].append;
                    break;
                }
            }
            return rtnObj;
        }
    };
/**
 *
 * gridView의 contextMenu를 setting한다.
 * @date 2018. 09. 05.
 * @memberOf com
 * @author archie
 * @example
 * //step 1
 * // contextMenu에 적용할 정보를 기록합니다.
 * var contextArr = [{
    id:"grd_fmmtrpay",//grid의 id
    set:true/false,   //contextMenu를 설정할지 여부
    hideSystemMenu:["ColumnHide","Group","ColumnFix","ColumnAdjustWidth","ColumnAdjustAuto"],// 특정항목의 시스템 메뉴를 숨김니다
    appendMenu:[{
                            label:"엑셀다운로드",//사용자 메뉴의 표시 문자열
                            userMenuId:"excelDownLoad",//사용자 메뉴의 id, 해당 컨텍스트메뉴가 클릭될때 입력값으로 전달됨
                            className:"",//사용자 메뉴의 스타일 클래스 이름
                            callback:"scwin.exceldown",// 이벤트를 클릭했을때 실행되는 콜백
                            param:{}// callback에 넘겨줄 param Object
                    },...]//시스템 메뉴 아래에 사용자 메뉴를 추가합니다.:
    },{
        id:"grd_fmmtrpaySub",
        set:true,
        hideSystemMenu:["ColumnHide"],//["ColumnHide","Group","ColumnFix","ColumnAdjustWidth","ColumnAdjustAuto"],// 특정항목의 시스템 메뉴를
        appendMenu:[{
                                        label:"기타 사용자 정의",//사용자 메뉴의 표시 문자열
                                        userMenuId:"etcUserDefine",//사용자 메뉴의 id, 해당 컨텍스트메뉴가 클릭될때 입력값으로 전달됨
                                        className:"",//사용자 메뉴의 스타일 클래스 이름
                                        callback:"scwin.userDfnCallback",// 이벤트를 클릭했을때 실행되는 콜백
                                        param:{}// callback에 넘겨줄 param Object
                                    },...]//시스템 메뉴 아래에 사용자 메뉴를 추가합니다.:
    }];
    // step2
    // 사용하려는 시점에 다름과 같이 기술합니다.
 *  com.setContext.init(contextArr);
 *
 */
com.setContext_menuSet=[];

//com.setContext_nowf={};

com.setContext_init = function(contextArr, nowFrame){
    com.setContext_menuSet = [];
    com.setContext_nowf = nowFrame;
        var sObj = com.setContext_nowf.getFrame();
        for(var key =0;key<contextArr.length;key++){
            var obj = contextArr[key];
            //var grd_Comp = $p.comp[obj.id];

            var grd_Comp = sObj.getObj(obj.id);

            grd_Comp.options.contextMenu = obj.set || false ;
            com.setContext_menuSet.push({
                            id:obj.id
                            ,hide:obj.hideSystemMenu
                            ,append:obj.appendMenu
                            });

            grd_Comp.bind('oncontextopen',this.setContext_oncontextopen,this);
            grd_Comp.bind('oncontextclick',this.setContext_oncontextclick,this);

        }};

com.setContext_oncontextopen = function(row,col){//--> gridcomponent

    var obj = com.setContext_getMenuInfo(this.org_id);
    return {
                hideSystemMenu:obj.hide,
                appendMenu:obj.append
    };

};

com.setContext_oncontextclick = function(r,c,u,i,s){

    var obj = com.setContext_getMenuInfo(this.org_id);
    var appendMenu = obj.append;
    for(var i=0;i<appendMenu.length;i++){
        if(u == appendMenu[i].userMenuId){
            if(!com.isEmpty(appendMenu[i].callback)){
                var cb = appendMenu[i].callback;
                var cArr = cb.split(".");//cb의 구조는 scwin.sampleFunc와 같이 "."하나만

                var nf = com.setContext_nowf.getFrame();
                var sc = nf.getObj(cArr[0]);
                appendMenu[i].param = appendMenu[i].param || {};

                sc[cArr[1]](this.id,appendMenu[i].param)


                /*var cf = window[cArr[0]][cArr[1]];
                appendMenu[i].param = appendMenu[i].param || {};
                cf(this.id,appendMenu[i].param);
                */
            }
        }
    }
};

com.setContext_getMenuInfo = function(_id){
    var rtnObj = {};
    for(var i=0;i<com.setContext_menuSet.length;i++){
        if(_id == com.setContext_menuSet[i].id){
            rtnObj.hide = com.setContext_menuSet[i].hide;
            rtnObj.append = com.setContext_menuSet[i].append;
            break;
        }
    }
    return rtnObj;
};


//


/**
 * 그리드의 contextMenu를 설정한다.
 * @private
 * @date 2018. 08. 30.
 * @memberOf com
 * @author InswaveSystems
 * @example
 *
 * var _options = {
        grd:"그리드의 아이디"
        ,req:"조회버튼의 아이디"
        ,add:"addRow의 버튼 아이디"
        ,ins:"insertRow의 버튼 아이디"
        ,del:"deleteRow의 버튼 아이디"
        ,sav:"저장버튼의 아이디"
        ,exl:"엑셀다운로드버튼의 아이디"
        ,hcl:"한셀다운로드버튼의 아이디"
    }

 * com.setGrdContext(_options);
 */

com.setGrdContext = function(_options){
    if(com.isEmpty(_options)){
        alert("[common.js][com.setGrdContext] context에 적용할 정보가 없습니다.");
        return false;
    }

    if(com.isEmpty(_options.grd)){
        alert("[common.js][com.setGrdContext] context에 적용할 그리드 정보가 없습니다.");
        return false;
    }

    var _opt = {
            grd_id : _options.grd || ""
            ,req_id : _options.req || ""
            ,add_id : _options.add || ""
            ,ins_id : _options.ins || ""
            ,del_id : _options.del || ""
            ,sav_id : _options.sav || ""
            ,exl_id : _options.exl || ""
            ,hcl_id : _options.hcl || ""
    };
    var cbObj = this.getCallBack(JSON.stringify(_opt));
    //step 1
  // contextMenu에 적용할 정보를 기록합니다.
  var contextArr = [{
    id:_opt.grd_id,//grid의 id
    set:true,   //contextMenu를 설정할지 여부
//  hideSystemMenu:["ColumnHide","Group","ColumnFix","ColumnAdjustWidth","ColumnAdjustAuto"],// 특정항목의 시스템 메뉴를 숨김니다
    hideSystemMenu:[""],// 특정항목의 시스템 메뉴를 숨김니다
    appendMenu:[{
                            label:"찾기",//사용자 메뉴의 표시 문자열
                            userMenuId:"search",//사용자 메뉴의 id, 해당 컨텍스트메뉴가 클릭될때 입력값으로 전달됨
                            className:"ico_grdrm_find bt1_dce",//사용자 메뉴의 스타일 클래스 이름
                            callback:"com.gridViewSearch",// 이벤트를 클릭했을때 실행되는 콜백
                            param:{"grid_id":_opt.grd_id}// callback에 넘겨줄 param Object
                },
                {
                            label:"조회",//사용자 메뉴의 표시 문자열
                            userMenuId:"require",//사용자 메뉴의 id, 해당 컨텍스트메뉴가 클릭될때 입력값으로 전달됨
                            className:cbObj.req_cls + " bt1_dce",//사용자 메뉴의 스타일 클래스 이름
                            callback:cbObj.req_cb,// 이벤트를 클릭했을때 실행되는 콜백
                            param:{}// callback에 넘겨줄 param Object
                },{
                            label:"추가",//사용자 메뉴의 표시 문자열
                            userMenuId:"addRow",//사용자 메뉴의 id, 해당 컨텍스트메뉴가 클릭될때 입력값으로 전달됨
                            className:cbObj.add_cls,//사용자 메뉴의 스타일 클래스 이름
                            callback:cbObj.add_cb,// 이벤트를 클릭했을때 실행되는 콜백
                            param:{}// callback에 넘겨줄 param Object
                },{
                            label:"삽입",//사용자 메뉴의 표시 문자열
                            userMenuId:"insertRow",//사용자 메뉴의 id, 해당 컨텍스트메뉴가 클릭될때 입력값으로 전달됨
                            className:cbObj.ins_cls,//사용자 메뉴의 스타일 클래스 이름
                            callback:cbObj.ins_cb,// 이벤트를 클릭했을때 실행되는 콜백
                            param:{}// callback에 넘겨줄 param Object
                },{
                            label:"삭제",//사용자 메뉴의 표시 문자열
                            userMenuId:"deleteRow",//사용자 메뉴의 id, 해당 컨텍스트메뉴가 클릭될때 입력값으로 전달됨
                            className:cbObj.del_cls + "",//사용자 메뉴의 스타일 클래스 이름
                            callback:cbObj.del_cb,// 이벤트를 클릭했을때 실행되는 콜백
                            param:{}// callback에 넘겨줄 param Object
                },{
                            label:"저장",//사용자 메뉴의 표시 문자열
                            userMenuId:"save",//사용자 메뉴의 id, 해당 컨텍스트메뉴가 클릭될때 입력값으로 전달됨
                            className:cbObj.sav_cls+ "",//사용자 메뉴의 스타일 클래스 이름
                            callback:cbObj.sav_cb,// 이벤트를 클릭했을때 실행되는 콜백
                            param:{}// callback에 넘겨줄 param Object
                },
                {
                            label:"엑셀변환",//사용자 메뉴의 표시 문자열
                            userMenuId:"excelDownLoad",//사용자 메뉴의 id, 해당 컨텍스트메뉴가 클릭될때 입력값으로 전달됨
                            className:cbObj.exl_cls+" bt1_dce",//사용자 메뉴의 스타일 클래스 이름
                            callback:cbObj.exl_cb,// 이벤트를 클릭했을때 실행되는 콜백
                            param:{}// callback에 넘겨줄 param Object
                },{
                            label:"한셀변환",//사용자 메뉴의 표시 문자열
                            userMenuId:"hcellDownLoad",//사용자 메뉴의 id, 해당 컨텍스트메뉴가 클릭될때 입력값으로 전달됨
                            className:cbObj.hcl_cls,//사용자 메뉴의 스타일 클래스 이름
                            callback:cbObj.hcl_cb,// 이벤트를 클릭했을때 실행되는 콜백
                            param:{}// callback에 넘겨줄 param Object
                }]//시스템 메뉴 아래에 사용자 메뉴를 추가합니다.:
    }];
    // step2
    // 사용하려는 시점에 다름과 같이 기술합니다.
   com.setContext_init(contextArr,this.$p);
};

com.getCallBack = function(str_options){
var nf = this.$p.getFrame();
var ops = JSON.parse(str_options);
    for(var key in ops){

        var _k = key.split("_");
        var _new_key = _k[0]+"_cb";
        var _new_cls = _k[0]+"_cls";

        var addObj = nf.getObj(ops[key]);
        //ops[key] = "";
        ops[_new_key] = "";
        ops[_new_cls] = "ico_grdrm_"+_k[0]+ " dis";
        if(com.isEmpty(addObj)){
            continue;
        }

        if(addObj.getDisabled()){
            continue;
        }



        var evList = addObj.userEventList;
        var _cb  = "";

        for(var i=0;i<evList.length;i++){
            var eObj = evList[i];
            if(eObj.name == "onclick"){
                //ops[key] = eObj.param.handler;
                ops[_new_key] = eObj.param.handler;
                ops[_new_cls] = ops[_new_cls].replaceAll(" dis","");
                break;
            }
        }
    }

return ops;

};

com.gridViewSearch = function(g,d){
        if(!com.checkGridSearchPopup("gridsearch")){
                var popOps = {
                                   url:"/uicom/common/gridsearch.xml"
                                   ,type:"gridsearch"
                                   ,modal :false
                                   ,width:"240"
                                   ,height:"184"
                                   ,data:{grd:g,data:d}
                                   ,popup_name:"그리드 검색"
                               };
                  this.popup_open(popOps);
        }else{
            alert("이미 열려있습니다.");
        }
    };
//




/* contextMenu 생성 finish */


/**
 * 화면의 팝업을 Clear.
 */
com.clearPopup = function() {
    try {
        var popIdArr = WebSquare.uiplugin.popup.popupList;
        for ( var k in popIdArr) {
            $p.closePopup(popIdArr[k].id);
        }
    } catch (e) {
        //m_ console.log("닫을 팝업이 없습니다." + e);
    }
};


/**
 * 화면의 팝업을 Clear.
 */
com.clearGridSearchPopup = function() {
    try {
        var popIdArr = WebSquare.uiplugin.popup.popupList;
        for ( var k =0 ; k < popIdArr.length ; k++ ) {
            if(popIdArr[k].id.indexOf("gridsearch") > -1){
                $p.closePopup(popIdArr[k].id);
            }
        }
    } catch (e) {
        //m_        console.log("닫을 팝업이 없습니다." + e);
    }
};

/**
 * 화면의 팝업을 Clear.
 */
com.checkGridSearchPopup = function(search) {
    var rtn = false;
    try {
        var popIdArr = WebSquare.uiplugin.popup.popupList;
        for ( var k =0 ; k < popIdArr.length ; k++ ) {
                if(popIdArr[k].id.indexOf(search) > -1){
                    rtn = true;
                    break;
                }
            }
    } catch (e) {
        //m_        console.log("닫을 팝업이 없습니다." + e);
    }
    return rtn;
};

com.closeScreen = function(){

	//debugger;
    com.clearPopup();
    
    let closeAll = "N";
    if(gcm.mainFrame != undefined) {
    	closeAll = gcm.mainFrame.getObj("scsObj").closeAll;
    }
    
    /*
    console.log("==================================="
    		+"\n1 : allWindowsLength="+allWindowsLength
    		+"\n1 : windowsLength="+windowsLength    
    		+"\n1 : gcm._container.windows.length="+gcm._container.windows.length
    		+"\n1 : closeAll="+closeAll
    );
    */
    
    
    //전체 닫기
	if(closeAll == "Y"){
		
		if(allWindowsLength == 0){
			allWindowsLength = gcm._container.windows.length - 1;
		}else{
			allWindowsLength = allWindowsLength - 1;
		}
		
		windowsLength = allWindowsLength;
	//단건 닫기
	}else{
		windowsLength = gcm._container.windows.length - 1;
	}	
    
    
	/*
    console.log("2 : windowsLength="+windowsLength
    		+"\n2 : allWindowsLength="+allWindowsLength
    );
    */
    
    //if (gcm._container.windows.length <= 1) {	
    if (windowsLength <= 1 ) {
        var mainPage = "";
        var mainPageNm = "";
        var mainPageId = "";
        
        mainPage = "/ui/tom/rpt/sys/xml/RPT000000M01.xml";
        mainPageNm = "메인화면";
        mainPageId = "RPT000000M01";
        
        gcm.MENU_ID = mainPageId; // 닫히면서 변경되는 화면정보 업데이트
        
        setTimeout(function(){
            //if (gcm._container.windows.length == 0) {
            if (windowsLength == 0) {
            	
            	windowsLength = 0;
            	allWindowsLength = 0;
            	
            	if(gcm.mainFrame != undefined) {
            		gcm.mainFrame.getObj("scsObj").closeAll = "N";
                }

            	
            	gcm._container.createWindow( mainPageNm // (필수) title         : 툴바의 네임레이어에 표시되는 타이틀.
                                               , null                // (필수) iconUrl       : 현재는 사용되지 않으며 null로 입력한다.(각 윈도우의 아이콘 url 문자열)
                                               , mainPage             // (필수) src           : window에 link할 페이지의 URL.
                                               , null                // (옵션) windowTitle   : window의 헤더에 표시될 타이틀로 null 이나 ""입력시 title값이 출력.
                                               , mainPageId+WebSquare.date.getCurrentServerDate("yyyyMMddHHss") // (옵션) windowId      : window ID로 null 이나 ""입력시 title이 id로 생성.
                                               , "selectWindow"      // (옵션) openAction    : [existWindow, newWindow, selectWindow]existWindow : id가 동일한 윈도우가 떠있으면 그 윈도우를 사용하여 다시 표시 / newWindow : 항상 새로운 창을 생성 / selectWindow : id가 동일한 창이 있으면 그 윈도우를 선택
                                               , "com.closeScreen"   // (옵션) closeAction   : window가 닫힐 때 동작을 지정하는 함수명(return은 boolean으로 하여야 함 false일 경우 닫기 중지, true일 경우 닫기)
                                               , null                // (옵션) windowTooltip : 툴바의 네임레이어에 표현될 tooltip.(미입력시 windowTitle이 tooltip으로 셋팅됨)
/*                                               , null
                                               , null
                                               , "wframe"*/
                                               );
            }
        }, 200);

        //-------------------------------------------------------------------------------------------------------------
        // □ 2018-11-12 : 문석길 : TRS팀만 메인페이지 첫 화면 왼쪽메뉴 슬라이드 접기한다. 0.5초후에 기동시킨다.
        //-------------------------------------------------------------------------------------------------------------
        setTimeout(function(){
            if (com.getSlGmgoModlC() == "TRS") {

                // 2018-11-08 : 고정핀이 켜져있을때만 click 이벤트 처리하도록 변경함.
                var lfmg_btn_MenuFixpin = gcm.mainLeft.getObj("btn_MenuFixpin");
                if (lfmg_btn_MenuFixpin.hasClass("on")) {
                    $(".btn_fix").click();                      // 왼쪽 슬라이드그룹 고정핀 클릭 처리
                }

                // 2018-11-12 : leftSlideBtn : 왼쪽슬라이드버튼 무조건 오른쪽으로 펼쳐지게 한 다음 클릭 이벤트 처리한다.
                var lfmg_leftSlideBtn = gcm.mainLeft.getObj("leftSlideBtn");
                lfmg_leftSlideBtn.removeClass("on");

                var lfmg_scsObj = gcm.mainLeft.getObj("scsObj");
                lfmg_scsObj.leftSlideBtn_onclick();             // 왼쪽슬라이드버튼 클릭 처리
                $(".sm_footer.cb").addClass("on");              // 메인내용그룹의 하단내용에 on 추가 (하단내용이 길어짐)
            }

            // 2018-12-17 : SFI 메인 reload시 왼쪽슬라이드가 접혀있다면(전체화면) 하단내용에 on 추가
            if (com.getSlGmgoModlC() == "SFI") {
                var lfmg_btn_MenuFixpin = gcm.mainLeft.getObj("btn_MenuFixpin");
                var lfmg_leftSlideBtn = gcm.mainLeft.getObj("leftSlideBtn");

                if (lfmg_btn_MenuFixpin.hasClass("on") == false) { // 고정핀이 없을 경우
                    if (lfmg_leftSlideBtn.hasClass("on") == true) { // 전체화면일 경우
                        var lfmg_scsObj = gcm.mainLeft.getObj("scsObj");
                        $(".sm_footer.cb").addClass("on");              // 메인내용그룹의 하단내용에 on 추가 (하단내용이 길어짐)
                    }
                }
            }
        }, 500);
    }
    
    
    //debugger;
    
    return true;
};

/**
 * 정보제공동의여부 클릭 이벤트 : 입력된 항목을 모두 초기화한다.
 * @date 2018.09.05
 * @memberOf scsObj
 * @param
 * @returns
 * @author SGO1008279(문석길)
 * @example
 */
com.callback_PsnInfJegongYn = function() {
    var popOps = { popup_name:"로그인 사용자 정보"
                 , url:"/ui/tom/sfi/sfi/xml/SFI010701P01.xml"  //오픈할 팝업 경로/파일명 설정
                 , width:"780", height:"440", useHeader:true
                 , data:JSON.stringify({"USER_ID":com.getUserId()})
                 , callbackFn:"scsObj.popCallBack"
    };
    com.popup_open(popOps);
};

/**
 * 정보제공동의여부 확인 함수
 * @date 2018.10.25
 * @memberOf
 * @param
 * @returns
 * @author SGO1008279(문석길)
 * @example
 */
com.confirm_PsnInfJegongYn = function() {

    //-----------------------------------------------------------------------------------------------------------------
    // □ 2018-10-25 : 문석길 : 정보제공동의여부 확인 함수 호출
    //    사용자로그인 후 정보제공동의 없는 사용자는 반드시 정보제공동의 후 사용하도록 처리
    //    메뉴 클릭 이벤트에서 확인하고, 정보동의 없이는 화면을 못 열도록 처리함.
    //    mf_MSFI010401R01Out.PSN_INF_JEGONG_YN 값 사용함.
    //-----------------------------------------------------------------------------------------------------------------
    var userInfo = JSON.parse(com.getSessionData("USER_INFO"));
    //console.log(com.getPrintTime()+"[common.js][com.confirm_PsnInfJegongYn] 정보제공동의여부(PSN_INF_JEGONG_YN) = "+userInfo.PSN_INF_JEGONG_YN);
    if (! com.isEmpty(userInfo)) {
        if (! com.isEmpty(userInfo.PSN_INF_JEGONG_YN)) {
            if (userInfo.PSN_INF_JEGONG_YN == "N") {

                if (gcm.CONFIRM_MSGBOX_YN == "비밀번호변경중") {
                    ;
                } else {
                    gcm.CONFIRM_MSGBOX_YN = "정보동의중"; // 현재 Confirm이 진행중이면, 다음 Confirm을 띄우지 않도록 하기 위한 변수
                    var confirmMsg = userInfo.USER_NM + "(" + userInfo.USER_ID + ") 님!!!"
                                   + "<br>개인정보 제공에 동의가 필요합니다."
                                   + "<br>로그인 사용자 정보화면에서 정보제공 동의를"
                                   + "<br>처리하신후 거래하시길 바랍니다."
                                   + "<br>"
                                   + "<br>확인버튼 누르시면 화면이 연결됩니다.";

                    // 확인시 로그인사용자 수정팝업(SFI010701P01)을 호출한다.
                    gcm.CONFIRM_CALLBACK = "com.SFI010701P01_confirm_callback()";
                    // 2018-12-26 : 문석길 : 세션 정보가 정확하지 않아서 일시적으로 막았음. 12/27 다시 가동함.
                    com.message("ICTM0007", confirmMsg, ""); // ICTM0007 : {0} {1}

                    // 무조건 false 처리하여 화면을 열지 못하다록 한다.
                    return false;
                }
            } else {
                gcm.CONFIRM_MSGBOX_YN == "정보동의완료"
            }
        }
    }

    return true;
};

/**
 * 비밀번호변경여부 확인 함수
 * @date 2018.10.26
 * @memberOf
 * @param
 * @returns
 * @author SGO1008279(문석길)
 * @example
 */
com.confirm_ScnoInitlCYn = function() {

    //-----------------------------------------------------------------------------------------------------------------
    // □ 2018-10-26 : 문석길
    //    비밀번호를 초기화한 후 사용자에게 비밀번호변경 안내메시지를 띄우도록 한다. (초화면 1회만, 화면열때마다)
    //    메뉴 클릭 이벤트에서 확인하고, 비밀번호초기화일자가 당일일경우 안내메시지를 띄운다.
    //    mf_MSFI010401R01Out.SCNO_INITL_DT, SCNO_CDT 값 사용함.
    //-----------------------------------------------------------------------------------------------------------------

    var userInfo = JSON.parse(com.getSessionData("USER_INFO"));
    //console.log(com.getPrintTime()+"[common.js][com.confirm_ScnoInitlCYn] 비밀번호초기화일자 = "
    //           +userInfo.SCNO_INITL_DT+", 비밀번호변경일자 = "+userInfo.SCNO_CDT+", 현재일자 = "+WebSquare.date.getCurrentServerDate("yyyyMMdd"));

    // userInfo 존재시 로직처리
    if (! com.isEmpty(userInfo)) {

        // [SKIP조건] 자동로그인 사용자는 제외한다. (2018-10-29 : 자동로그인 사용자도 변경하도록 함. 제외로직보류)
        //if (WebSquareUrlParam.enc_val != "null") {
        //    return true;
        //}

        // 비밀번호초기화일자가 당일이고
        if (! com.isEmpty(userInfo.SCNO_INITL_DT)) {
            if (userInfo.SCNO_INITL_DT == WebSquare.date.getCurrentServerDate("yyyyMMdd")) {

                // (2019-01-10 : 폐기함) 비밀번호변경일자가 초기값이나, 당일이 아닐 경우 확인메시지 띄운다.
                //if (userInfo.SCNO_CDT == "00000000" ||
                //    userInfo.SCNO_CDT != WebSquare.date.getCurrentServerDate("yyyyMMdd")) {

                    if (gcm.CONFIRM_MSGBOX_YN == "정보동의중") {
                        ;
                    } else {
                        gcm.CONFIRM_MSGBOX_YN = "비밀번호변경중"; // 현재 Confirm이 진행중이면, 다음 Confirm을 띄우지 않도록 하기 위한 변수

                        var confirmMsg = userInfo.USER_NM + "(" + userInfo.USER_ID + ") 님!!!"
                                       + "<br>비밀번호를 ["
                                       + userInfo.SCNO_INITL_DT.substr(0, 4) + "-"
                                       + userInfo.SCNO_INITL_DT.substr(4, 2) + "-"
                                       + userInfo.SCNO_INITL_DT.substr(6, 2) + "]일에 초기화하신후"
                                       + "<br>비밀번호를 변경하지 않으셨습니다."
                                       + "<br>로그인 사용자 정보화면에서 임시비밀번호를"
                                       + "<br>정상 비밀번호로 변경하시길 바랍니다."
                                       + "<br>"
                                       + "<br>확인버튼 누르시면 화면이 연결됩니다.";

                        // 확인시 로그인사용자 수정팝업(SFI010701P01)을 호출한다.
                        gcm.CONFIRM_CALLBACK = "com.SFI010701P01_confirm_callback()";
                        com.message("ICTM0007", confirmMsg, ""); // ICTM0007 : {0} {1}

                        // 무조건 false 처리하여 화면을 열지 못하다록 한다.
                        return false;
                    }
                //} else {
                //    gcm.CONFIRM_MSGBOX_YN == "비밀번호변경완료"
                //}
            }
        }
    }

    return true;
};

/**
 * 비밀번호변경여부 확인 함수 : 비밀번호 변경일자가 3개월이 지난경우 유도메시지 처리한다.
 * @date 2018.10.29
 * @memberOf
 * @param
 * @returns
 * @author SGO1008279(문석길)
 * @example
 */
com.confirm_Scno3MmCYn = function() {

    //-----------------------------------------------------------------------------------------------------------------
    // □ 2018-10-26 : 문석길
    //    비밀번호를 변경한지 3개월이상 될 경우 사용자에게 비밀번호변경 안내메시지를 띄우도록 한다.
    //    mf_MSFI010401R01Out.SCNO_CDT 값 사용함.
    //-----------------------------------------------------------------------------------------------------------------

    var userInfo = JSON.parse(com.getSessionData("USER_INFO"));

    // userInfo 존재시 로직처리
    if (! com.isEmpty(userInfo)) {

        // [SKIP조건] 비밀번호변경일자가 NULL 또는 '00000000'일 경우 제외한다.
        if (userInfo.SCNO_CDT == null || userInfo.SCNO_CDT == "00000000") {
            return true;
        }

        // [SKIP조건] 자동로그인 사용자는 제외한다. (2018-10-29 : 자동로그인 사용자도 변경하도록 함. 제외로직보류)
        //if (WebSquareUrlParam.enc_val != "null") {
        //    return true;
        //}

        if (! com.isEmpty(userInfo.SCNO_CDT)) {
            var diff = WebSquare.date.dateDiff(userInfo.SCNO_CDT, WebSquare.date.getCurrentServerDate("yyyyMMdd")); // 일수차이 산출
            //console.log(com.getPrintTime()+"[common.js][com.confirm_Scno3MmCYn] 비밀번호변경일자 = "+userInfo.SCNO_CDT
            //                              +", 현재일자 = "+WebSquare.date.getCurrentServerDate("yyyyMMdd")
            //                              +", 차이일수 = "+diff);

            // 차이일수가 90일이상일 경우
            if (WebSquare.util.parseInt(diff, 0) >= 90) {

                if (gcm.CONFIRM_MSGBOX_YN == "정보동의중" || gcm.CONFIRM_MSGBOX_YN == "비밀번호변경중") {
                    ;
                } else {
                    gcm.CONFIRM_MSGBOX_YN = "비밀번호3개월변경중"; // 현재 Confirm이 진행중이면, 다음 Confirm을 띄우지 않도록 하기 위한 변수

                    var confirmMsg = userInfo.USER_NM + "(" + userInfo.USER_ID + ") 님!!!"
                                   + "<br>비밀번호를 ["
                                   + userInfo.SCNO_CDT.substr(0, 4) + "-"
                                   + userInfo.SCNO_CDT.substr(4, 2) + "-"
                                   + userInfo.SCNO_CDT.substr(6, 2) + "]일에 변경하신후"
                                   + "<br>90일이 넘었습니다. (총 "+diff+"일)"
                                   + "<br>로그인 사용자 정보화면에서"
                                   + "<br>비밀번호를 변경하시길 바랍니다."
                                   + "<br>"
                                   + "<br>확인버튼 누르시면 화면이 연결됩니다.";

                    // 확인시 로그인사용자 수정팝업(SFI010701P01)을 호출한다.
                    gcm.CONFIRM_CALLBACK = "com.SFI010701P01_confirm_callback()";
                    com.message("CCTM0002", confirmMsg, ""); // CCTM0002 : {0} {1}

                    // 무조건 false 처리하여 화면을 열지 못하다록 한다.
                    return false;
                }
            } else {
                gcm.CONFIRM_MSGBOX_YN == "비밀번호3개월변경완료"
            }
        }
    }

    return true;
};

/**
 * 로그인사용자팝업 호출 확인 콜백 : 확인시 로그인사용자 수정팝업(SFI010701P01)을 호출한다.
 * @date 2018.11.27
 * @memberOf scsObj
 * @param
 * @returns
 * @author SGO1008279(문석길)
 * @example
 */
com.SFI010701P01_confirm_callback = function() {
    if (gcm.CONFIRM_YN != "Y") {
        return false;
    }

    // 로그인사용자 수정팝업(SFI010701P01)을 호출한다.
    var ss = gcm.mainHeaderMenu.getObj("scsObj");
    ss.btn_searchUser_onclick();
};
com.menuClickFlag = true;
/**
 * 메뉴클릭 이벤트 함수 : 상단/왼쪽 메뉴그룹에서 메뉴를 클릭한 경우 해당 함수가 처리된다.
 * @date 2018.10.25
 * @memberOf
 * @param
 * @returns
 * @author 김민, SGO1008279(문석길)
 * @example
 */
com.menuClick = function(_arg){

	if(com.menuClickFlag){
		//console.log("클릭");
		com.menuClickFlag = !com.menuClickFlag;
		setTimeout(function(){
			com.menuClickFlag = true;
		},2000);
	} else {
		//console.log("더블 클릭");
		return false;
	}
	
	//debugger;
	
    //$W.layer.showProcessMessage("menu_click");
    //console.log('showprocess');

//console.log(com.getPrintTime()+"[common.js][com.menuClick] 메뉴클릭 함수 시작합니다.");

	//메뉴 중복 호출 방지...
	var dbl_open = false;
	{
		var userDataJson = null;
		
		if( typeof this.getUserData !== "undefined" ) {
			// getUserData 사용가능시
			
			userDataJson = this.getUserData("menuInfo");
			
		} else {
			
			userDataJson = { "MENU_ID": com.getMenuId() };
		}
		
		var menuInfoJsn1 = _arg || JSON.parse(userDataJson);
		var isExist = $.grep(gcm._container.windows,function(_jsn){if(_jsn.windowId == menuInfoJsn1.MENU_ID){return _jsn;}})
		if(isExist.length != 0){
			dbl_open = true;
		}
	}

    //-----------------------------------------------------------------------------------------------------------------
    // □ 2018-10-25 : 문석길
    //    사용자정보중 서울시금고모듈코드가 없을 경우(=이상현상발생) 경고메시지로 로그아웃 처리한다.
    //-----------------------------------------------------------------------------------------------------------------
    var userInfo = JSON.parse(com.getSessionData("USER_INFO"));
    
    //debugger;
    
    if (com.isEmpty(userInfo) ||
        userInfo.SL_GMGO_MODL_C == "" ||
        userInfo.SL_GMGO_MODL_C != com.getSlGmgoModlC()) {
        var alertMsg = "해당 시스템의 모듈코드가 비정상 상태입니다. 자동로그아웃 처리합니다.";
        alert(alertMsg);
        var ss = gcm.mainHeaderMenu.getObj("scsObj");   // 메인헤더정보 선언
        ss.btn_logout_onclick();                    // header.xml scsObj.btn_logout_onclick(); 이벤트 호출

        // 무조건 false 처리하여 화면을 열지 못하다록 한다.
        return false;
    }

    //-----------------------------------------------------------------------------------------------------------------
    // □ 2018-10-25 : 문석길 : 정보제공동의여부 확인 함수 호출
    //    사용자로그인 후 정보제공동의 없는 사용자는 반드시 정보제공동의 후 화면을 사용하도록 처리
    //    메뉴 클릭 이벤트에서 확인하고, 정보동의 없이는 화면을 못 열도록 처리함.
    //-----------------------------------------------------------------------------------------------------------------
    if (com.confirm_PsnInfJegongYn() == false) {
        return false;
    }

    //-----------------------------------------------------------------------------------------------------------------
    // □ 2018-10-26 : 문석길 : 비밀번호초기화변경여부 확인 함수 호출
    //    비밀번호를 초기화한 후 사용자에게 비밀번호변경 안내메시지를 띄우도록 한다. (초화면 1회만, 화면열때마다)
    //    메뉴 클릭 이벤트에서 확인하고, 비밀번호초기화일자가 당일일경우 안내메시지를 띄운다.
    //-----------------------------------------------------------------------------------------------------------------
    if (com.confirm_ScnoInitlCYn() == false) {
        return false;
    }

    //-----------------------------------------------------------------------------------------------------------------
    // □ 2018-10-29 : 문석길 : 비밀번호3개월변경여부 확인 함수 호출
    //    비밀번호를 변경한지 3개월이상 될 경우 사용자에게 비밀번호변경 안내메시지를 띄우도록 한다.
    //-----------------------------------------------------------------------------------------------------------------
    if (com.confirm_Scno3MmCYn() == false) {
        return false;
    }
    
    
    // 본인확인팝업
    if (menuInfoJsn1.MENU_ID.substr(0, 5) == "RPT06")
    {
    	if (gcm.BONIN_AUTH_CHECK_YN != "Y") 
    	{
            var _frame = $p.comp[gcm.mainHeaderMenu.scope_id];// 이 컴포넌트의 frame을 갖고온다.
            var _c = _frame.getObj("com"); // 이 frame의 com을 갖고온다.
                        
            //gcm.MENU_ID = menuInfoJsn1.MENU_ID;
            _c.popup_open(_c.BoninAuthNo_popUp("com.popBoninAuthBack", menuInfoJsn1));
    		
    		return false;
    	}
	}
    
    //-----------------------------------------------------------------------------------------------------------------
    // □ main_frame의 windowContainer의 옵션중 windowMaxNum 값 만큼 윈도우가 열릴 경우 처음 화면을 닫고 신규화면을 오픈
    //-----------------------------------------------------------------------------------------------------------------
    // 2018-10-15 : 문석길 : 총 열람메뉴개수가 초과될 경우 최초화면을 닫도록 처리함.
    // 2018-10-24 : 총 15개 윈도우중 하나를 닫았으므로 재조회하여 클릭한 메뉴가 열리도록 한다.
    // 2018-10-25 : windowMaxNum을 16으로 설정하고, 15개 화면 도달시 화면을 닫고, 바로 열도록 함.
    //              사유 : 웹스퀘어 엔진에서 15개 도달시 "화면은 총 15개 까지만 허용됩니다." Alert 나오게 됨.
    //-----------------------------------------------------------------------------------------------------------------
    if (gcm._container.windows.length >= (gcm._container.options.windowMaxNum - 1)) {
        //alert("화면은 총 "+gcm._container.options.windowMaxNum+"개 까지만 허용됩니다.");
        gcm._container.closeWindow(gcm._container.windows[0].windowId);
    }

    // ※ 주의사항 : 최대화면수는 위에서 반응하기전에 해당 로직을 타므로 '<'에서 '<='로 처리해야 함.
    if (gcm._container.windows.length <= gcm._container.options.windowMaxNum) {

        //좌측 메뉴 로 돌아가게 클릭
        //mf_leftMenuGrp_grp_group_menu.click();

        var menuInfoJsn = _arg || JSON.parse(this.getUserData("menuInfo"));

        var gbn = menuInfoJsn.SL_GMGO_MODL_C ||  com.getSlGmgoModlC();
        //menuInfoJsn.SL_GMGO_MODL_C

        //gcm.GNB_MENU_CODE = menuInfoJsn.PARENT_ID;

        // 2018-09-18 : 문석길 : submission시 사용할 거래공통부의 화면ID를 gcm 변수에 보관한다.
        //console.log(com.getPrintTime()+"[common.js][com.menuClick] menuInfoJsn.SCR_ID = "+menuInfoJsn.SCR_ID);
        gcm.SCR_ID = menuInfoJsn.SCR_ID;

        // 2018-10-08 : 문석길 : submission시 사용할 거래공통부의 메뉴ID를 gcm 변수에 보관한다.
        //console.log(com.getPrintTime()+"[common.js][com.menuClick] menuInfoJsn.MENU_ID = "+menuInfoJsn.MENU_ID);
        gcm.MENU_ID = menuInfoJsn.MENU_ID;


        //var scrinfo = mf_MSFI010601R01OutList.getMatchedJSON("SCR_ID",menuInfoJsn.SCR_ID);
        var _dltObj = gcm.mainFrame.getObj("MSFI010601R01OutList");
        var scrinfo = _dltObj.getMatchedJSON("MENU_ID",menuInfoJsn.MENU_ID);

        var now_scrinfo = scrinfo[0];
        now_scrinfo.SL_GMGO_MODL_C = gbn;
        //var parentId = now_scrinfo.MENU_ID.substring(0,5) + "0000M00";
        var parentId = now_scrinfo.M1_ID;
        gcm.GNB_MENU_CODE = parentId;


        var scr_url = "/"+now_scrinfo.SVR_FILE_PATH + "/"+now_scrinfo.SCR_ID+".xml";

        gcm._container.doMaximizeAll();
        //var container = $p.comp['mf_wc_mainContainer'];

        //-------------------------------------------------------------------------------------------------------------
        // 2018-11-23 : 문석길 : 상단메뉴클릭시 메뉴HOVER를 먼저 닫고, 0.1초후 클릭화면을 열도록 처리함.
        //-------------------------------------------------------------------------------------------------------------
        setTimeout(function(){

            //---------------------------------------------------------------------------------------------------------
            // 2019-01-09 : 문석길 : TRS시스템일 경우 특정메인에서 특정화면을 열 경우 항상 닫고 새로 열도록 조정함.
            // 예) TRS060801M01(업무처리현황) -> 수납처리그리드 수납일자 더블클릭시 -> TRS010201M01.xml(OCR 수납정보수신)
            // 세션값으로 주고 받도록 처리함. 호출하기전 com.setSesstionData("openAction", "existWindow"); 주면 아래로직 적용함.
            //---------------------------------------------------------------------------------------------------------
            var openAction = "selectWindow";
            if (! com.isEmpty(com.getSessionData("openAction"))) {
                openAction = com.getSessionData("openAction");
                com.removeSessionData("openAction");
            }
            var tooltip = null;
            if(com.getSysUFlg() == "D") {
            	tooltip = scr_url;
            }
            gcm._container.createWindow( now_scrinfo.MENU_NM // (필수) title         : 툴바의 네임레이어에 표시되는 타이틀.
                                       , null                // (필수) iconUrl       : 현재는 사용되지 않으며 null로 입력한다.(각 윈도우의 아이콘 url 문자열)
                                       , scr_url             // (필수) src           : window에 link할 페이지의 URL.
                                       , now_scrinfo.MENU_NM                // (옵션) windowTitle   : window의 헤더에 표시될 타이틀로 null 이나 ""입력시 title값이 출력.
                                       , now_scrinfo.MENU_ID // (옵션) windowId      : window ID로 null 이나 ""입력시 title이 id로 생성.
                                       //, "existWindow"     // (옵션) openAction    : [existWindow, newWindow, selectWindow]existWindow : id가 동일한 윈도우가 떠있으면 그 윈도우를 사용하여 다시 표시 / newWindow : 항상 새로운 창을 생성 / selectWindow : id가 동일한 창이 있으면 그 윈도우를 선택
                                       // 2018-10-04 : SFI 이광옥 수석 요청으로 existWindow -> selectWindow 변경
                                       , openAction          // (옵션) openAction    : [existWindow, newWindow, selectWindow]existWindow : id가 동일한 윈도우가 떠있으면 그 윈도우를 사용하여 다시 표시 / newWindow : 항상 새로운 창을 생성 / selectWindow : id가 동일한 창이 있으면 그 윈도우를 선택
                                       , "com.closeScreen"   // (옵션) closeAction   : window가 닫힐 때 동작을 지정하는 함수명(return은 boolean으로 하여야 함 false일 경우 닫기 중지, true일 경우 닫기)
                                       , tooltip                // (옵션) windowTooltip : 툴바의 네임레이어에 표현될 tooltip.(미입력시 windowTitle이 tooltip으로 셋팅됨)
                                       /*, null
                                       , null
                                       , "wframe"
                                       */
                                       );

            gcm._container.options.sequentialArrangeColNum = 0;
            gcm._container.options.sequentialArrangeRowNum = 0;

            gcm._container.options.verticalArrangeNum = 0;
            gcm._container.options.horizontalArrangeNum = 0;

            // 페이지 info
            com.setSessionData("nowPageInfo", now_scrinfo);

//            var t = gcm.mainLeft.getObj("firstMenuGen");
//            t.removeAll();

            // 좌측 메뉴 설정하기
//            var o = gcm.mainLeft.getObj("scsObj");
//            o.fn_setToggleMenu("MSFI010601R01OutList", now_scrinfo);

            //scrinfo  = scrinfo[0];

            if(!dbl_open){//중복호출...

	            com.createDataObj("dataMap", "MSFI010604C01In", [ "SL_GMGO_MODL_C", "USER_ID" ,"MENU_ID" , "SCR_ID", "USE_YN"]);

	            //**최근이력 일때 서비스..태운다.
	            MSFI010604C01In.set( "SL_GMGO_MODL_C" , com.getSlGmgoModlC() );
	            MSFI010604C01In.set( "USER_ID" , com.getUserId() );
	            MSFI010604C01In.set( "MENU_ID" , now_scrinfo.MENU_ID );
	            MSFI010604C01In.set( "SCR_ID" , now_scrinfo.SCR_ID );
	            //debugger;
	            var sbm_RtstInsertOption = {
	                mode : "asynchronous",
	                id : "sbm_RtstInsert",
	                ref : 'data:json,[MSFI010604C01In]',
	                target : '',
	                userData1 : [{svc_id:"SSFI010604C01", msg_id:"MSFI010604C01In", sbm_id:"sbm_RtstInsert", isshowMsg:true}]
	            };
	            sbm_RtstInsertOption.submitDoneHandler = function(e) {
	                
	            	if( e.responseJSON.SH ) {
	            		//console.log( "test " + e.responseJSON.SH );
	            		
	            		if( scr_url.indexOf( e.responseJSON.SH.SCR_ID ) === -1 ) {
	            			alert("올바르지 않은 방법으로 화면을 여셨습니다. 화면을 닫습니다.");
	            			com.selfCloseByWindowId( now_scrinfo.MENU_ID );
	            		}
	            		
	            	} else {
	            		alert("업무 화면이 비정상적으로 열렸습니다.\n다시 시도하셔도 동일한 에러가 발생할 경우 시스템 운영팀에 문의 바랍니다.");
	            		com.selfCloseByWindowId( now_scrinfo.MENU_ID );
	            	}
	            	
	            }
	            sbm_RtstInsertOption.submitErrorHandler = function(e) {
	            	//debugger;
	            	if (e.responseJSON.MSG_INF[0].MSG_C != "ECOMS90001") {
		            	alert(e.responseJSON.MSG_INF[0].BAS_MSG_DATA);
		            	com.selfCloseByWindowId(gcm._container.getSelectedWindowId());
		            	return false;
	            	}
	            	//gcm._container.closeWindow();
	                //console.log(com.getPrintTime()+"[common.js][com.menuClick] 이력등록 후처리 오류");
	            }
	            gcm.IS_TR = true;
	            com.executeSubmission_dynamic(sbm_RtstInsertOption);

	            //즐겨찾기
	            com.setFavStatus("MSFI010603R02In","R02");
            }

            //---------------------------------------------------------------------------------------------------------
            // 2018-10-08 : 문석길 : 왼쪽 그림자패널 사용시 메뉴를 클릭한 후 해당 메뉴판을 모두 닫도록 함.
            //---------------------------------------------------------------------------------------------------------
            if (gcm.mainLeft.hasClass("r_shadow") == true) {
                gcm.mainLeft.removeClass("r_shadow");         // mf_leftMenuGrp : 메인왼쪽메뉴 : 그림자형태의 패널 숨기기
                var left_slideGrp           = gcm.mainLeft.getObj("slideGrp");
                var left_slideMenuGrp       = gcm.mainLeft.getObj("slideMenuGrp");

                var left_grp_group_favorate = gcm.mainLeft.getObj("grp_group_favorate");
                var left_img_FavorateStar   = gcm.mainLeft.getObj("img_FavorateStar");

                var left_grp_group_recent   = gcm.mainLeft.getObj("grp_group_recent");
                var left_img_RecentClock    = gcm.mainLeft.getObj("img_RecentClock");

                left_slideGrp.addClass("on");         // slideGrp       : 왼쪽슬라이드그룹 숨기기
                left_slideMenuGrp.removeClass("on");  // slideMenuGrp   : 왼쪽슬라이드메뉴그룹 숨기기

                left_grp_group_favorate.removeClass("on");              // 즐겨찾기버튼그룹 on 삭제
                left_img_FavorateStar.setSrc("/img/icon/star.png");     // 즐겨찾기버튼이미지 on이미지 삭제

                left_grp_group_recent.removeClass("on");                // 최근메뉴버튼그룹 on 삭제
                left_img_RecentClock.setSrc("/img/icon/time.png");      // 최근메뉴버튼이미지 on이미지 삭제
            }
            $(".w2windowContainer_name").css("width",(parseInt($(".w2windowContainer_name").css("width").replaceAll("px",""),10)+100)+"px");

        }, 300); // setTimeout End
    }

   // $W.layer.hideProcessMessage("menu_click");
   // console.log('hideprocess');

};

/**도움말 공통 스크립트*/
com.helpPop = function(){

    if(com.getSessionData("isPop")==true){
        var _frame = $p.comp[com.getSessionData("scope_id")];// 이 컴포넌트의 frame을 갖고온다.
        var _c = _frame.getObj("com"); // 이 frame의 com을 갖고온다.
        //팝업이면 파라미터를 세팅.pdf명

    } else{
        var _frame = $p.comp[this.scope_id];// 이 컴포넌트의 frame을 갖고온다.
        var _c = _frame.getObj("com"); // 이 frame의 com을 갖고온다.
        //세션에 도움말정보를 세팅.pdf명
        com.setSessionData("pdfname",com.getScrId()+".pdf");
        com.setSessionData("titlename",com.getScrNm());
    }

    //세션 팝업여부 원위치
    com.setSessionData("isPop", false);

    var popOps = {
            url:"/ui/tom/sfi/sfi/xml/SFI030101P01.xml", //오픈할 팝업 경로/파일명 설정
            width : "980",
            height : "740",
            type : "browser",
            useHeader:true,
            popup_name:"",
            modal : false
            };
    _c.popup_open(popOps);

};

//즐겨찾기 여부 조회  config.xml에서 오출
com.setFavStatus = function(m_id,s_id){
    //서비스ID:  SSFI010603R02
    //IN map: MSFI010603R02In
    //OUT map: MSFI010603R02Out
	
	
	
    if( com.isEmpty(s_id)){
        var _favObj = $p.comp[this.id];
        //등록 ? , 삭제?
        var f_info = _favObj.getUserData("favInfo");
        
        console.log("f_info="+JSON.stringify(f_info));
        if(!com.isEmpty(f_info)){
            if(f_info.stat == "on"){
                m_id = "MSFI010603D01In";
                s_id = "D01";
            }else{
                m_id = "MSFI010603C01In";
                s_id = "C01";
            }
        }
    }
    
    

    com.createDataObj("dataMap", m_id, [ "SL_GMGO_MODL_C", "USER_ID" ,"MENU_ID","SCR_ID"]);

    var _dma = $p.data[m_id];
    var _svcPrefix = "SSFI010603";
    var _svcId = _svcPrefix+ s_id;
    
    
    var nowMenuInfo = com.getSessionData("nowPageInfo") || f_info;

    com.removeSessionData("nowPageInfo");


    //**최근이력 일때 서비스..태운다.
    _dma.set( "SL_GMGO_MODL_C" , com.getSlGmgoModlC() );
    _dma.set( "USER_ID" , com.getUserId() );
    _dma.set( "MENU_ID" , nowMenuInfo.MENU_ID );
    _dma.set( "SCR_ID" , nowMenuInfo.SCR_ID);

    var sbm_setFavStatusOption = {
        mode : "asynchronous",
        id : "sbm_setFavStatus",
        ref : 'data:json,['+m_id+']',
        target : '',
        userData1 : [{svc_id:_svcId, msg_id:m_id, sbm_id:"sbm_setFavStatus", isshowMsg:true, fav_id:this.id}]
    };
    
    
    sbm_setFavStatusOption.submitDoneHandler = function(e) {
        // 2018-10-15 : 문석길 : 즐겨찾기를 각 화면의 별포를 눌러서 호출했는지, 왼쪽메뉴를 통해서 호출했지에 대한 괸리변수
        //                       common.js에서 호출하는 경우와 왼쪽메뉴바에서 호출하는 경우에 따라 이벤트 처리가 달라진다.
        gcm.FAVORATE_STAR_CALL = "FAVORATE_STAR";
        
        if(m_id == "MSFI010603R02In"){//조회
            try{
               
            	
            	
            	//var _favObj = $("#"+gcm.initWframeId+" .fav");
            	
    /////////////////////////////////////////////////////////////////////
              //---------------------------------------------------------------------------------------------------------
                // 2018-10-12 : 문석길 : 각 개별화면에서 도움말 왼쪽옆에 메뉴경로명을 출력하도록 한다.
                // 관련 class 는 textbox class="location"이며 해당 컴포넌트가 없을 경우 출력되지 않는다.
                // 예) 세출e-뱅킹 > 가상계좌 > 수납관리 > <span style="color:#0071b7;float:right;font-size:12px;font-weight:bold;">반납고지</span>
                //---------------------------------------------------------------------------------------------------------
                // 2018-10-23 : 문석길 : 아래의 로직은 main_frame.xml scsObj.wc_mainContainer_onwindowtabclick()에도 동일로직이 있습니다.
                //---------------------------------------------------------------------------------------------------------

                // 2018-11-21 : gcm.initWframeId 에서 gcm._container.nowWindow로 변경함.
                //var _comp = $p.comp[$("#"+gcm.initWframeId+" .location")[0].id];
//                var _comp = $p.comp[$("#"+gcm._container.nowWindow+" .location")[0].id];
//                _comp.options.escape = false;
//                _comp.setValue(nowMenuInfo.MENU_PATH_NM);


                // 도움말 공통적용.by byon
//                var _helpcomp = $p.comp[$("#"+gcm.initWframeId+" .help")[0].id];
//                _helpcomp.bind("click",com.helpPop);


    //////////////////////////////////////////////////////////////////////////////////////////////
                
                //대메뉴
                var _navObj = $("#"+gcm._container.nowWindow+" .nav_m1_nm");
                if(!com.isEmpty(_navObj) && _navObj.length > 0) {
                    var _navMenuObj = $p.getComponentById(_navObj[0].id);
                    if(!com.isEmpty(_navMenuObj)) {
                        _navMenuObj.options.escape = false;
                        _navMenuObj.setValue(nowMenuInfo.M1_NM);
                    }
                }
                
                
                //중메뉴
                _navObj = $("#"+gcm._container.nowWindow+" .nav_m2_nm");
                if(!com.isEmpty(_navObj) && _navObj.length > 0) {
                    var _navMenuObj = $p.getComponentById(_navObj[0].id);
                    if(!com.isEmpty(_navMenuObj)) {
                        _navMenuObj.options.escape = false;
                        _navMenuObj.setValue(nowMenuInfo.M2_NM);
                    }
                }
                
                //메뉴
                _navObj = $("#"+gcm._container.nowWindow+" .nav_m3_nm");
                if(!com.isEmpty(_navObj) && _navObj.length > 0) {
                    var _navMenuObj = $p.getComponentById(_navObj[0].id);
                    if(!com.isEmpty(_navMenuObj)) {
                        _navMenuObj.options.escape = false;
                        _navMenuObj.setValue(nowMenuInfo.MENU_NM);
                    }
                }
                
                //메뉴타이틀
                _navObj = $("#"+gcm._container.nowWindow+" .nav_menu_nm");
                if(!com.isEmpty(_navObj) && _navObj.length > 0) {
                    var _navMenuObj = $p.getComponentById(_navObj[0].id);
                    if(!com.isEmpty(_navMenuObj)) {
                        _navMenuObj.options.escape = false;
                        _navMenuObj.setValue(nowMenuInfo.MENU_NM);
                    }
                }



    //////////////////////////////////////////////////////////////////////////////////////////////
                var _favObj = $("#"+gcm.initWframeId+" .fvr-group");
                var _comp = $p.getComponentById(_favObj[0].id);
                var _fav = $("#"+_favObj[0].id+" .fvr-group");
                
                if(e.responseJSON.MSFI010603R02Out.BKMK_ON == "1"){//on
                    _favObj.addClass("on");
                    
                    //삭제
                    _favObj.bind("click",com.setFavStatus);
                    
                    _comp.setUserData("favInfo",{stat:"on",MENU_ID:nowMenuInfo.MENU_ID,SCR_ID:nowMenuInfo.SCR_ID,frame_id:gcm.initWframeId});

                }else{//등록
                    _favObj.removeClass("on");
                    _favObj.bind("click",com.setFavStatus);
                    
                    _comp.setUserData("favInfo",{stat:"off",MENU_ID:nowMenuInfo.MENU_ID,SCR_ID:nowMenuInfo.SCR_ID,frame_id:gcm.initWframeId});
                }

                // 스케쥴캘린더 두줄 처리
                $(".w2scheduleCalendar").bind("click",function(){
                    $(".fc-day-grid").html($(".fc-day-grid").html().replaceAll("\\n", "<br>"));
                });

            }catch(ex){
                console.log("fav location help error : "+ex);
            }

        }else if(m_id == "MSFI010603C01In"){//저장

            var _favObj = $p.getComponentById(this.userData1[0].fav_id);
            
            if(e.responseJSON.TR_INF[0].RST_U == "0"){
                //_favObj.parentControl.addClass("on");
                
                _favObj.addClass("on");
                _favObj.setUserData("favInfo",{stat:"on",MENU_ID:nowMenuInfo.MENU_ID,SCR_ID:nowMenuInfo.SCR_ID,frame_id:gcm.initWframeId});
                //즐겨찾기 왼쪽 갱신
                //mf_leftMenuGrp_img_FavorateStar.click();
                var iFaqObj = gcm.mainLeft.getObj("scsObj");
                iFaqObj.grp_group_favorate_onclick();

            }

        }else if(m_id == "MSFI010603D01In"){//삭제
            var _favObj = $p.getComponentById(this.userData1[0].fav_id);
            if(e.responseJSON.TR_INF[0].RST_U == "0"){
                //_favObj.parentControl.removeClass("on");
                _favObj.removeClass("on");
                _favObj.setUserData("favInfo",{stat:"off",MENU_ID:nowMenuInfo.MENU_ID,SCR_ID:nowMenuInfo.SCR_ID,frame_id:gcm.initWframeId});
                //즐겨찾기 왼쪽 갱신
                //mf_leftMenuGrp_img_FavorateStar.click();
                var iFaqObj = gcm.mainLeft.getObj("scsObj");
                iFaqObj.grp_group_favorate_onclick();

            }

        }


    }

    sbm_setFavStatusOption.submitErroreHandler = function(e) {
        //m_        console.log("즐겨찾기 에러");
        if(m_id == "MSFI010603R02In"){

        }
    }
    gcm.IS_TR = true;
    com.executeSubmission_dynamic(sbm_setFavStatusOption);

};

com.reinitial = function(){
    /*초기화
                var _testObj = $("#"+gcm.initWframeId+" .help");
                _testObj.bind("click",com.reinitial);
                var _cmp = $p.comp[_testObj[0].id];
                _cmp.setUserData("testInfo",{frame_id:gcm.initWframeId});

     * */

    var c = $p.comp[this.id];
    var _info = c.getUserData("testInfo");
    var f_id = c.getUserData("testInfo").frame_id;
    var nf = $p.comp["mf_wc_mainContainer_subWindow1_wframe"];
    var _p = nf.getObj("$p");
    _p.reinitialize(true);
};

/**
 * Object 값이 숫자인지 여부를 반환 한다. 숫자 일때 true
 *
 * @author 변상필
 * @memberOf com
 * @param {Object:Y}
 *            obj
 * @return {boolean}
 * @example com.isNumber("1234");
 */
com.isNumber = function(obj) {
    obj += '';  //문자열로 변환
    obj = obj.replace(/^\s*|\s*$/g, ''); //좌우 공백 제거
    if(obj == '' || isNaN(obj)) return false;
    return true;
};

/**
 * Object 문자열의 byte 길이를 리턴 한다.
 *
 * @author 변상필
 * @memberOf com
 * @param stirng str
 *
 * @return {byte}
 * @example com.isNumber("1234");
 */
com.getStringtoByteLength = function(str) {
    var l = 0;
    for(var i=0; i < str.length; i++){
        var c = escape(str.charAt(i));
        if(c.length==1) l++;
        else if(c.indexOf("%u")!=-1) l+=2;
        else if(c.indexOf("%")!=-1) l+=c.length/3;
    }
    return l;
};

/**
 * 파일사이즈 byte => kbyte로 변경한다.
 *
 * @memberOf com
 * @param {Object:data}
 *            obj
 * @return 1 (변경된 kbyte 사이즈)
 * @example byte2Kb("1024");
 */
com.byte2Kb = function(data){

    if(!com.isNumber(data)){
        return 0;
    }
    return parseInt(Math.round(data/1024),10);
};


/**
 * 두개이상의 그리드 데이터를 하나의 엑셀파일에 여려개의 시트로 다운로드한다.
 *
 * @memberOf com
 * @param {Object:data}
 *            var _opt = {
                fileName :  "sample.xlsx",//엑셀 파일 정보
                grdArr : [
                            {
                                grdObj:gridView1
                                ,sheetName:"sheetName1"
                                ,type:"1"
                                ,removeColumns :
                                   ,foldColumns :
                                   ,startRowIndex :
                                   ,startColumnIndex :
                                   ,headerColor :
                                   ,bodyColor :
                                   ,infoArr :
                            }
                            ,{
                                grdObj:gridView2
                                ,sheetName:"sheetName2"
                                ,type:"1"
                            }
                        ]
            }
 * @return {}
 * @example
 *
 *  var _opt = {
                fileName :  "mm.xlsx",
                grdArr : [
                            {
                                grdObj:grd_USER_INF_LIST
                                ,sheetName:"sheet1k"
                                ,type:"1"

                                //option
                                ,removeColumns :
                                   ,foldColumns :
                                   ,startRowIndex :
                                   ,startColumnIndex :
                                   ,headerColor :
                                   ,bodyColor :
                                   ,infoArr :  [
                                                    {
                                                        rowIndex : 0
                                                        , colIndex : 0
                                                        , rowSpan : 2
                                                        , colSpan : 2
                                                        , text : "Grid2 Data"
                                                        , textAlign : "center"
                                                    }
                                                ]
                            }
                            ,{
                                grdObj:grd_USER_CRET_MENU_LIST
                                ,sheetName:"sheet2k"
                                ,type:"1"
                            }
                        ]
        };
    com.downLoadExcel_MultiSheet(_opt);
 */
com.downLoadExcel_MultiSheet = function(_opt){
    var _exlInfo = [] ;
    var defaultFontName = "맑은 고딕";
    $.each(_opt.grdArr,function(i,v){
            var info ={
                        gridId : v.grdObj.id,
                        sheetName : v.sheetName,
                        type : v.type,
                        rowsByN : v.grdObj.getRowCount(),
                        infoArr : v.infoArr || [],

                        removeColumns : v.removeColumns || "",
                        removeHeaderRows : v.removeHeaderRows || "",
                        foldColumns : v.foldColumns || "",
                        startRowIndex : v.startRowIndex || 3,
                        startColumnIndex : v.startColumnIndex || 0,
                        headerColor : v.headerColor || "#c8cad0",
                        headerFontName : v.headerFontName || defaultFontName,
                        headerFontSize : v.headerFontSize || "10",
                        headerFontColor : v.headerFontColor || "",
                        bodyColor : v.bodyColor || "#FFFFFF",
                        bodyFontName : v.bodyFontName || defaultFontName,
                        bodyFontSize : v.bodyFontSize || "10",
                        bodyFontColor : v.bodyFontColor || "",
                        subTotalColor : v.subTotalColor || "#CCFFCC",
                        subTotalFontName : v.subTotalFontName || defaultFontName,
                        subTotalFontSize : v.subTotalFontSize || "10",
                        subTotalFontColor : v.subTotalFontColor || "",
                        footerColor : v.footerColor || "#d6eaff",
                        footerFontName : v.footerFontName || "맑은 고딕",
                        footerFontSize : v.footerFontSize || "10",
                        footerFontColor : v.footerFontColor || "",
                        oddRowBackgroundColor : v.oddRowBackgroundColor || "",
                        evenRowBackgroundColor : v.evenRowBackgroundColor || "",
                        rowNumHeaderColor : v.rowNumHeaderColor || "",
                        rowNumHeaderFontName : v.rowNumHeaderFontName || defaultFontName,
                        rowNumHeaderFontSize : v.rowNumHeaderFontSize || "",
                        rowNumHeaderFontColor : v.rowNumHeaderFontColor || "",
                        rowNumBodyColor : v.rowNumBodyColor || "",
                        rowNumBodyFontName : v.rowNumBodyFontName || defaultFontName,
                        rowNumBodyFontSize : v.rowNumBodyFontSize || "",
                        rowNumBodyFontColor : v.rowNumBodyFontColor || "",
                        rowNumFooterColor : v.rowNumFooterColor || "",
                        rowNumFooterFontName : v.rowNumFooterFontName || defaultFontName,
                        rowNumFooterFontSize : v.rowNumFooterFontSize || "",
                        rowNumFooterFontColor : v.rowNumFooterFontColor || "",
                        rowNumSubTotalColor : v.rowNumSubTotalColor || "",
                        rowNumSubTotalFontName : v.rowNumSubTotalFontName || defaultFontName,
                        rowNumSubTotalFontSize : v.rowNumSubTotalFontSize || "",
                        rowNumSubTotalFontColor : v.rowNumSubTotalFontColor || "",
                        rowNumHeaderValue : v.rowNumHeaderValue || "",
                        rowNumVisible : v.rowNumVisible || "false",
                        showProcess : WebSquare.util.getBoolean(v.showProcess) || true,
                        massStorage : WebSquare.util.getBoolean(v.massStorage) || true,
                        showConfirm : WebSquare.util.getBoolean(v.showConfirm) || false,
                        dataProvider : v.dataProvider || "",
                        providerRequestXml : v.providerRequestXml || "",
                        userDataXml : v.userDataXml || "",
                        bodyWordwrap : WebSquare.util.getBoolean(v.bodyWordwrap) || false,
                        useEuroLocale : v.useEuroLocale || "false",
                        useHeader : v.useHeader || "true",
                        useSubTotal : v.useSubTotal || "false",
                        useSubTotalData : v.useSubTotalData ||"false",
                        useFooter : v.useFooter || true,
                        useFooterData : v.useFooterData|| "false",
                        separator : v.separator || ",",
                        subTotalScale : v.subTotalScale || -1,
                        subTotalRoundingMode : v.subTotalRoundingMode || "",
                        useStyle : v.useStyle || "",
                        freezePane : v.freezePane || "",
                        autoSizeColumn : v.autoSizeColumn || "true",
                        displayGridlines : v.displayGridlines || "",
                        colMerge : v.colMerge || "",
                        useDataFormat : v.useDataFormat || "",
                        indent : v.indent || "",
                        columnMove : v.columnMove || "",
                        columnOrder : v.columnOrder || "",
                        fitToPage : v.fitToPage || "false",
                        landScape : v.landScape || "false",
                        fitWidth : v.fitWidth || "1",
                        fitHeight : v.fitHeight || "1",
                        scale : v.scale || "100",
                        pageSize : v.pageSize || "A4"

                    }
                    _exlInfo.push(info);
                });

    var options = {
        common : {
                    fileName : _opt.fileName || "MultiExcelDown.xlsx"
                    ,showProcess : true
        },
        excelInfo : _exlInfo
    };
    WebSquare.util.multipleExcelDownload( options );
};

com.selfClose = function(){
    setTimeout(function(){
        gcm._container.closeWindow(gcm._container.getSelectedWindowId());
    },100);
};

/**
 * WebSqaure WindowId로 화면 탭 닫기(WindowContainer)
 *
 * @memberOf com
 * @param  windowId
 * @return void
 * @example com.selfCloseByWindowId("SFI010401M01"); // 보통 MENU_ID 를 WindowId로 잡는다
 */
com.selfCloseByWindowId = function(windowId){
    setTimeout(function(){
        if( windowId ) {
        	gcm._container.closeWindow(windowId);
        } else {
        	gcm._container.closeWindow(); // 활성화된 마지막 탭이 닫힘
        }
    },100);
};

/**
 * 관리자 메뉴 정상 open 여부 확인
 *
 * @memberOf com
 * @param  scrId
 * @return void
 * @example com.menuValidation("SFI010401M01"); // 보통 MENU_ID 를 WindowId로 잡는다
 */
com.menuValidation = function(scrId){
    setTimeout(function(){
    	if( gcm.SCR_ID !== scrId ) {
    		alert("올바르지 않은 방법으로 화면을 여셨습니다.");
    		com.selfCloseByWindowId(gcm.MENU_ID);
    	}
    },100);
};

com.deCode = function(str){
    return WebSquare.xml.decode(str);
};

/*
 * 스크립트상에서 xssCheck argument[0] : val1 확인 대상 value argument[1] : chkArr 검증 유형
 *
 * @author 김민
 * @memberOf com
 * @param
 * @return true/false
 * @example if (!com.xssCheck(chkVal3)) {
 *              alert("해당경로는 접근이 불가합니다.");
 *              return;
 *          }
 */
com.xssCheck = function(a) {
    var isx = true;
    var t_val = a;
    var t_arr = [ "./", "/.", "..", "//" ];

    for ( var i = 0; i < t_arr.length; i++) {
        if (t_val.indexOf(t_arr[i]) > -1) {
            isx = false;
            break;
        }
    }
    return isx;
};

/*
 * sleep 함수
 *
 * @date 2018-12-12
 * @author 문석길
 * @memberOf com
 * @param 1000 = 1초
 * @return
 * @example com.sleep(1000);
 */
com.sleep = function(delay) {
    var start = new Date().getTime();
    while (new Date().getTime() < start + delay);
};


/*
 * 첨부파일시 지정 확장자가 아니면 체크
 *
 * @date 2019-01-11
 * @author 변상필
 * @memberOf com
 * @param fileOps = 첨부파일정보
 * @return (배열)비지정파일종류 해당index
 * @example com.attchFileChk(fileOps);
 */
com.attchFileChk = function(fileOps){
	
	var delArr = [];
	var filedataLeng = fileOps.data.length;
	
	for(var i=0; i<filedataLeng; i++){
		var fName	= fileOps.data[i].name;
		var idx = fName.lastIndexOf(".");
		var fileExt = "";
		if ( idx > 0 ) {
			fileExt = fName.substring(idx+1, fName.length ).toUpperCase();
		}
//		var fileExt = fileOps.data[i].name.split(".")[1];
		if( fileExt=="GIF"  || fileExt=="JPG"  || fileExt=="PNG" || fileExt=="JPEG" || fileExt=="BMP" || fileExt=="TIF" || fileExt=="PDF" 
		 || fileExt=="DOC"  || fileExt=="DOCX" || fileExt=="XLS" || fileExt=="CSV" || fileExt=="XLSX" 
		 || fileExt=="PPT"  || fileExt=="PPTX" || fileExt=="TXT" || fileExt=="XML" || fileExt=="ZIP"
		 || fileExt=="MP4"  || fileExt=="AVI"  || fileExt=="MPG"     
		 || fileExt=="CELL" || fileExt=="HWP"  || fileExt=="HTM"  || fileExt=="HTML"  ){
		 } else {
			delArr.push(fileOps.data[i].name);
		 }
	}
	return delArr;
};


/*
 * Object 문자열의 byte 길이를 리턴 한다.
 *
 * @author 변상필
 * @memberOf com
 * @param stirng str
 *
 * @return {byte}
 * @example com.isNumber("1234");
 */
com.getByteLength = function(s,b,i,c) {
	for(b=i=0;c=s.charCodeAt(i++);b+=c>>11?2:c>>7?2:1);
	return b;
};


//본인인증번호 확인 팝업
com.BoninAuthNo_popUp = function(callBackNm, menuData ) {
	
	menuData.TEL_NO = rpt.getTelNo();
	menuData.MENU_CLICK_YN = "Y";
	
	var popOps = { 
					//url:"/ui/tom/sfi/sfi/xml/SFI010901P01.xml"
					//,width:"420"
					//,height:"200"
						
					url:"/ui/tom/rpt/sys/xml/RPT060101P06.xml"
					,width:"560"
					,height:"372"	
					,data: menuData	
					,useHeader:true
					,popup_name:"추가본인인증" 
					//,closeAction : callBackNm 
					,callbackFn:callBackNm
				};
	
	return popOps;	
};

com.popBoninAuthBack = function(e){

//	debugger;
	
	var sysFlag = com.getSysUFlg(); // (D:개발, T:검증, R:운영)
	
	if ( e != null ){
//		var mskOn = gcm.mainHeaderMenu.getObj("btn_msk_On");
//		var mskOff = gcm.mainHeaderMenu.getObj("btn_msk_Off");
		if (gcm.BONIN_AUTH_CHECK_YN == "Y" ) 
		{
//			if(mskOn)
//				mskOn.hide();
//			
//			if(mskOff)
//				mskOff.show("inline-block");
			
			if (e.MENU_ID.substr(0, 5) == "RPT06") 
			{
				
				if( sysFlag == "R" ) {
					// 운영
					
					com.menuClick(e); // 팝업 호출시 전달한 메뉴정보 전체
				
				} else {
					// 개발은 바로 인증이 성공하여 간혹 비정상 동작
					
					setTimeout(function(){
						com.menuClick(e); // 팝업 호출시 전달한 메뉴정보 전체
		    		}, 800); // 0.8초후 작업함
					
				}
				
			}
		}
		else 
		{
//			if(mskOn)
//				mskOn.show("inline-block");
//			
//			if(mskOff)
//				mskOff.hide();			
		}
    } else {
    	;
    }
};



/**
 * 공통코드 LABEL 표시 추가 -> CODE - LABEL 형태로 조회 적용
 * SGO1023863(김태호)
 * 2023.07.10
 */
com.setCommCodeNm = function(codeObjArr, callbackFunc, flag) {

    var codeObjLen = 0;

    if (codeObjArr) {
        codeObjLen = codeObjArr.length;
    } else {
        //m_        console.log("=== com.setCommCode Parameter Type Error ===\nex) com.setCommCode([{\"code:\":\"04\",\"compID\":\"sbx_Gender\"}],\"scsObj.callbackFunction\")\n===================================");
        return;
    }

    var i, j, codeObj, dltId, dltIdArr = [], paramCode = "", compArr, compArrLen, tmpIdArr, codeOrg = [];
    var dataListOption = this._getCodeDataListOptions(gcm.COMMON_CODE_INFO.FILED_ARR);

    for (var i = 0; i < codeObjLen; i++) {
        codeObj = codeObjArr[i];
        try {
            dltId = gcm.DATA_PREFIX + "_" + codeObj.code;
            $p.top().scsObj.commonCodeList = $p.top().scsObj.commonCodeList
                    || [];
            if (typeof $p.top().scsObj.commonCodeList[dltId] === "undefined") {// 받아온
                                                                                // 데이터가
                                                                                // 없을경우
                codeOrg.push(codeObj.code);
                dltIdArr.push(dltId);
                if (i > 0) {
                    paramCode += ",";
                }
                paramCode += codeObj.code;
                dataListOption.id = dltId;
                com.createDataObj("dataList", dataListOption.id,
                        gcm.COMMON_CODE_INFO.FILED_ARR);
            } else {// 받아온 데이터가 있을경우
                dataListOption.id = dltId;
                /*com.createDataObj("dataList", dataListOption.id,
                        gcm.COMMON_CODE_INFO.FILED_ARR);*/
                //var dataListObj = this.$p.getComponentById(dataListOption.id);
                //dataListObj.setJSON(this.getJSON($p.top().scsObj.commonCodeList[dltId]));
            }
            if (codeObj.compID) {
                compArr = (codeObj.compID).replaceAll(" ", "").split(",");
                compArrLen = compArr.length;
                for (j = 0; j < compArrLen; j++) {
                    tmpIdArr = compArr[j].split(":");
                    // 기본 컴포넌트
                    if (tmpIdArr.length === 1) {
                        var comp = this.$p.getComponentById(tmpIdArr[0]);
                        comp.setNodeSet("data:" + dltId,
                        		gcm.COMMON_CODE_INFO.LABELV,
                                gcm.COMMON_CODE_INFO.VALUE);
                        // gridView 컴포넌트
                    } else {
                        var gridObj = this.$p.getComponentById(tmpIdArr[0]);
                        
                        if(flag = "lpad"){
                        	gridObj.setColumnNodeSet(tmpIdArr[1], "data:" + dltId,
                            		gcm.COMMON_CODE_INFO.LABELLPAD,
                                    gcm.COMMON_CODE_INFO.VALUE);
                        }else{
                        	gridObj.setColumnNodeSet(tmpIdArr[1], "data:" + dltId,
                            		gcm.COMMON_CODE_INFO.LABEL,
                                    gcm.COMMON_CODE_INFO.VALUE);
                        }
                    }
                }
            }
        } catch (ex) {
            //m_            console.log("com.setCommCode Error");
            //m_            console.log(JSON.stringify(codeObj));
            //m_            console.log(ex);
            continue;
        }
    }

    // ///////////////////////////////////////////
    // 1. 데이터 객체 생성
    // 2. 맵핑할 component에 setting
    // 3. submission 생성
    // ///////////////////////////////////////////
    // 공통코드 MSFI020101R99In 생성
    com.createDataObj("dataMap", "MSFI020101R99In", [ "CMM_C_NM" ]);
    com.createDataObj("dataMap", "MSFI020101R99Out", [ "TOT_CNT" ]);
    com.createDataObj("dataList", "MSFI020101R99OutList", gcm.COMMON_CODE_INFO.FILED_ARR);
    MSFI020101R99In.set("CMM_C_NM", codeOrg.join());

    var searchCodeGrpOption = {
        mode : "synchronous",   // asynchronous, synchronous
        id : "sbm_SearchCode",
        ref : "data:json,MSFI020101R99In",
        action : "",
        target : "data:json," + this.strSerialize(dltIdArr),
        userData1 : [ {svc_id:"SSFI020101R99", msg_id:"MSFI020101R99In", sbm_id:"sbm_CommonCode", isshowMsg:true} ]
    };

    searchCodeGrpOption.submitDoneHandler = function(e) {
        for (codeGrpDataListId in e.responseJSON) {
            if (codeGrpDataListId.indexOf(gcm.DATA_PREFIX) > -1) {
                $p.top().scsObj.commonCodeList[codeGrpDataListId] = com
                        .strSerialize(e.responseJSON[codeGrpDataListId]);
            }
        }
        if (typeof callbackFunc === "function") {
            callbackFunc();
        }
    }
    gcm.IS_TR = true;
    this.executeSubmission_dynamic(searchCodeGrpOption);
};

/**
*
* 계좌번호 콤보박스 
*
* @date 2023. 07. 17.
* @memberOf com
* @author 박용준
* @return 메시지
*/	
com.getAcctNo = function (codeObjArr, callbackFunc, isAll, sel_acct, gyejwa_cd, fis_year, hg_dsc, gungu_cd, brno, gyejwa_nm ) { 	
   var codeObjLen = 0;

   if (codeObjArr) {
       codeObjLen = codeObjArr.length;
   } else {
       //m_        console.log("=== com.setCommCode Parameter Type Error ===\nex) com.setCommCode([{\"code:\":\"04\",\"compID\":\"sbx_Gender\"}],\"scsObj.callbackFunction\")\n===================================");
       return;
   }

   var i, j, codeObj, dltId, dltIdArr = [], paramCode = "", compArr, compArrLen, tmpIdArr, codeOrg = [];
   var dataListOption = this._getCodeDataListOptions([ "CODE", "NAME" ]);		// ************** 변경됨 ************** 

   for (var i = 0; i < codeObjLen; i++) {
       codeObj = codeObjArr[i];
       try {
           dltId = "MCommonComboR05OutList";									// ************** 변경됨 ************** 
           $p.top().scsObj.commonCodeList = $p.top().scsObj.commonCodeList || [];
           if (typeof $p.top().scsObj.commonCodeList[dltId] === "undefined") {// 받아온
                                                                               // 데이터가
                                                                               // 없을경우
               codeOrg.push(codeObj.code);
               dltIdArr.push(dltId);
               if (i > 0) {
                   paramCode += ",";
               }
               paramCode += codeObj.code;
               dataListOption.id = dltId;
               com.createDataObj("dataList", dataListOption.id, [ "CODE", "NAME" ]);	// ************** 변경됨 ************** 
           } else {// 받아온 데이터가 있을경우
               dataListOption.id = dltId;
               /*com.createDataObj("dataList", dataListOption.id,
                       gcm.COMMON_CODE_INFO.FILED_ARR);*/
               //var dataListObj = this.$p.getComponentById(dataListOption.id);
               //dataListObj.setJSON(this.getJSON($p.top().scsObj.commonCodeList[dltId]));
           }
           if (codeObj.compID) {
               compArr = (codeObj.compID).replaceAll(" ", "").split(",");
               compArrLen = compArr.length;
               for (j = 0; j < compArrLen; j++) {
                   tmpIdArr = compArr[j].split(":");
                   // 기본 컴포넌트
                   if (tmpIdArr.length === 1) {
                       var comp = this.$p.getComponentById(tmpIdArr[0]);
                       comp.setNodeSet("data:" + dltId, "NAME", "CODE");		// ************** 변경됨 **************
                       // gridView 컴포넌트
                   } else {
                       var gridObj = this.$p.getComponentById(tmpIdArr[0]);
                       gridObj.setColumnNodeSet(tmpIdArr[1], "data:" + dltId, "NAME", "CODE");		// ************** 변경됨 **************
                   }
               }
           }
       } catch (ex) {
           //m_            console.log("com.setCommCode Error");
           //m_            console.log(JSON.stringify(codeObj));
           //m_            console.log(ex);
           continue;
       }
   }

//   // ///////////////////////////////////////////
//   // 1. 데이터 객체 생성
//   // 2. 맵핑할 component에 setting
//   // 3. submission 생성
//   // ///////////////////////////////////////////
   com.createDataObj("dataMap", "MCommonComboR05In", [ "ACCT_DSC", "GEUMGO_CD", "GUNGU_CD", "HOIGYE_YEAR", "HOIGYE_CODE", "GYEJWA_CD", "GYEJWA_NM", "BRNO" ]);
   //com.createDataObj("dataList", "MCommonComboR05OutList", [ "CODE", "NAME" ]);		// ************** 변경됨 **************
   
   MCommonComboR05In.set("ACCT_DSC", "99");					// ************** 변경됨 **************
   MCommonComboR05In.set("GEUMGO_CD", rpt.getSigumgoC());
   MCommonComboR05In.set("GUNGU_CD", gungu_cd);
   MCommonComboR05In.set("HOIGYE_YEAR", fis_year);
   MCommonComboR05In.set("HOIGYE_CODE", hg_dsc);
   MCommonComboR05In.set("HOIKYE_C", hg_dsc);
   MCommonComboR05In.set("GYEJWA_CD", gyejwa_cd);
   MCommonComboR05In.set("GYEJWA_NM", gyejwa_nm);
   MCommonComboR05In.set("BRNO", brno);

   var searchCodeGrpOption = {									// ************** 변경됨 **************
       mode : "synchronous",   // asynchronous, synchronous
       id : "sbm_AcctNo",
       ref : "data:json,MCommonComboR05In",
       action : "",
       target : "data:json,MCommonComboR05OutList",
       userData1 : [ {svc_id:"SCommonComboR05", msg_id:"MCommonComboR05In", sbm_id:"sbm_AcctNo", isshowMsg:true} ]
   };

   searchCodeGrpOption.submitDoneHandler = function(e) {
       for (codeGrpDataListId in e.responseJSON) {
           if (codeGrpDataListId.indexOf(gcm.DATA_PREFIX) > -1) {
               $p.top().scsObj.commonCodeList[codeGrpDataListId] = com.strSerialize(e.responseJSON[codeGrpDataListId]);
           }
       }
       if (typeof callbackFunc === "function") {
           callbackFunc();
       }
   }
   gcm.IS_TR = true;
   this.executeSubmission_dynamic(searchCodeGrpOption);
};

/**
* 메뉴정보를 조회
* @date 2023. 07. 14.
* @memberOf com
* @author 박서찬
*/
com.getMenuInfo = function(menuId) {
    var _menuId = menuId || com.getMenuId();
    var _dltObj = gcm.mainFrame.getObj("MSFI010601R01OutList");
    var menuInfo = _dltObj.getMatchedJSON("MENU_ID", _menuId);
    if(menuInfo.length > 0) {
        menuInfo = menuInfo[0];
    }
    return menuInfo;
};


//************************
//데이터 0 으로 채우는 함수
//************************
com.lpad = function (str,maxlength) {
	if(!com.isEmpty(str)) {
		str = str.toString();
	}
	var sReStr = "";
	if(str.length != maxlength)
	{	
		var iMin =  maxlength - str.length ;
		for(var i = 0 ; i < iMin ;i++){
			sReStr += "0";
		}
		sReStr = sReStr.concat(str);
	}
	else
	{
		sReStr = str;
	}	
	return sReStr;
};

/**
 * Base64 인코딩
 * <BR/>JavaScript Global API 사용
 * <BR/>- Internet Explorer 등 구형 브라우저 사용불가
 * <BR/>- Unicode 문자열 사용 가능하도록 조치함(MDN Web Doc Base64 참고)
 * <BR/>
 * @param  str  BASE64 인코딩할 문자열<BR/>
 * @return BASE64 인코딩된 문자열<BR/>
 * @example com.base64Encode("test스트링");
 */
com.base64Encode = function(str) {
	
	// 값이 비어있으면 처리 안함
	if(com.isEmpty(str)) return "";
	
	// 혹시 미지원 브라우저라면 처리 안함
	if( typeof btoa === undefined ) return "";
	if( typeof String === undefined ) return "";
	if( typeof TextEncoder === undefined ) return "";
	
	// Unicode handling
	// https://developer.mozilla.org/en-US/docs/Glossary/Base64
	const uniString = (new TextEncoder().encode(str));
	const binString = String.fromCodePoint(...uniString);
	return btoa(binString);
};

/**
 * Base64 디코딩
 * <BR/>JavaScript Global API 사용
 * <BR/>- Internet Explorer 등 구형 브라우저 사용불가
 * <BR/>- Unicode 문자열 사용 가능하도록 조치함(MDN Web Doc Base64 참고)
 * <BR/>
 * @param  enStr  BASE64 디코딩할 문자열<BR/>
 * @return BASE64 디코딩된 문자열<BR/>
 * @example com.base64Decode("dGVzdO2FjOyKpO2KuA==");
 */
com.base64Decode = function(enStr) {
	
	// 값이 비어있으면 처리 안함
	if(com.isEmpty(enStr)) return "";
	
	// 혹시 미지원 브라우저라면 처리 안함
	if( typeof atob === undefined ) return "";
	if( typeof Uint8Array === undefined ) return "";
	if( typeof TextDecoder === undefined ) return "";
	
	// Unicode handling
	// https://developer.mozilla.org/en-US/docs/Glossary/Base64
	const binString = atob(enStr);
	const uniString = Uint8Array.from(binString, (m) => m.codePointAt(0));
	return (new TextDecoder().decode(uniString));
};

/**
 * 입력한 값이 숫자인지 판별
 * <BR/>JavaScript Global API 사용
 * <BR/>- Internet Explorer 등 구형 브라우저 사용불가
 * <BR/>- 16자리를 초과하는 숫자에 대한 처리 확인
 * <BR/>
 * @param  value  숫자인지 판별할 문자열<BR/>
 * @return 숫자일 경우 true, 숫자가 아닐 경우 false<BR/>
 * @example com.check_isNumber("123456eeea");
 */
com.check_isNumber = function(value) {
    
    // 값이 비어있으면 처리 안함
	if(com.isEmpty(value)) return false;
    
    // 혹시 미지원 브라우저라면 처리 안함
	if( typeof isNaN === undefined ) {
		alert("구형 브라우저 사용으로 일부 기능이 정상 동작하지 않습니다.\n마이크로소프트 엣지, 구글 크롬 등의 최신 브라우저 사용바랍니다.");
		return false;
	}

    return !isNaN(value);
};

/**
 * 입력한 값의 부호 판별
 * <BR/>JavaScript Global API 사용
 * <BR/>- Internet Explorer 등 구형 브라우저 사용불가
 * <BR/>- 16자리를 초과하는 숫자에 대한 처리 확인
 * <BR/>
 * @param  value  부호를 판별할 문자열<BR/>
 * @return 음수일 경우 -1, 양수일 경우 1, 어느쪽도 아니면 0<BR/>
 * @example com.check_sign("-123456");
 */
com.check_sign = function(value) {
    
    // 값이 비어있으면 처리 안함
	if(com.isEmpty(value)) return 0;

    // 값이 숫자가 아니면 처리 안함
	if(!com.check_isNumber(value)) return 0;
    
    // 혹시 미지원 브라우저라면 처리 안함
	if( typeof Math === undefined ) return 0;

    return Math.sign(value);
};

/**
 * 절대값 계산
 * <BR/>JavaScript Global API 사용
 * <BR/>- Internet Explorer 등 구형 브라우저 사용불가
 * <BR/>- 16자리를 초과하는 숫자에 대한 처리 확인
 * <BR/>
 * @param  value  절대값을 계산할 문자열<BR/>
 * @return 0 혹은 양수값<BR/>
 * @example com.calNumberAbs("-1234567890123456789");
 */
com.calNumberAbs = function(value) {
    
    // 값이 비어있으면 처리 안함
	if(com.isEmpty(value)) return 0;

    // 값이 숫자가 아니면 처리 안함
	if(!com.check_isNumber(value)) return 0;
    
    // 혹시 미지원 브라우저라면 처리 안함
	if( (typeof BigInt === undefined) || (typeof Number === undefined) || (typeof Math === undefined) ) {
		alert("구형 브라우저 사용으로 일부 기능이 정상 동작하지 않습니다.\n마이크로소프트 엣지, 구글 크롬 등의 최신 브라우저 사용바랍니다.");
		return 0;
	}
	
	if( (Number(value) <= Number.MIN_SAFE_INTEGER) || (Number.MAX_SAFE_INTEGER <= Number(value)) ) {
		// 안전하게 처리할 수 있는 정수값을 넘어서면 BigInt로 계산
		
		const calValue = BigInt(value);
		return ((calValue < 0n) ? -calValue : calValue).toString(10);
	} else {
		// 그 이외 정수는 기존 방식대로
		return Math.abs(value);
	}

};


/**
 * 인천OCR 공통 콤보정보를 조회한다.
 *
 * @date 2018.08.09
 * @param {Object} 조회구분(JINGSU_ORG_C:징수기관, SUNP_ORG_C:수납기관, MECHE1_C_NM:매체코드1, MECHE2_C_NM:매체코드2, SUNAP_LEND_DATE:최종마감수납일) 신규코드 추가시 추가작업 필요
 * @param {Object} $p
 * @param {requestCallback} callbackFunc 콜백 함수
 * @memberOf com
 * @author scs
 * @example 
 * var codeOptions = { code : "GUCHUNG", compID : "sbx_SunpOrgC", cond : {TAX_K:'JB'} }
 * com.setCommCodeNio(codeOptions);
 */
com.setCommCodeNio = function(codeObj, page_p, callbackFunc) {

	//debugger;
	if (com.isEmpty(codeObj)) {
		return
	}
	
	var dltInfo = {};
	if(codeObj.code == 'NIO_TAX_ORG_C') {			// 인천OCR 구청코드조회(지방세+상하수도)_NIO_TAX_IP_CLR_TOT 조회용
		dltInfo = {"LABEL" : "GUCHUNG_NM", "VALUE" : "GUCHUNG_CD_G", "FILED_ARR" : ["TAX_G", "GUCHUNG_CD", "CVT_GUCHUNG_CD", "GUCHUNG_NM", "GUCHUNG_CD_G"]};
	} else if(codeObj.code == 'JINGSU_ORG_C') {		// 징수기관
		dltInfo = {"LABEL" : "GUCHUNG_NM", "VALUE" : "GUCHUNG_CD", "FILED_ARR" : ["TAX_K", "GUCHUNG_CD", "CVT_GUCHUNG_CD", "GUCHUNG_NM"]};
		// 지방세 기준으로 구청코드 셋팅
		if (com.isEmpty(codeObj.cond)) {
			codeObj.cond = {TAX_K:'JB'};
		}
	} else if(codeObj.code == 'SUNP_ORG_C') {		// 수납기관
		dltInfo = {"LABEL" : "BNK_NM", "VALUE" : "BNK_CD", "FILED_ARR" : ["BNK_CD", "BNK_NM", "BNK_LIST"]};
	} else if(codeObj.code == 'MECHE1_C_NM') {		// 매체코드1
		dltInfo = {"LABEL" : "MECHE1_C_NM", "VALUE" : "MECHE1_C", "FILED_ARR" : ["MECHE1_C", "MECHE1_C_NM"]};
	} else if(codeObj.code == 'MECHE2_C_NM') {		// 매체코드2
		dltInfo = {"LABEL" : "MECHE2_C_NM", "VALUE" : "MECHE2_C", "FILED_ARR" : ["MECHE2_C", "MECHE2_C_NM"]};
	} else if(codeObj.code == 'HOIKYE_C') {			// 회계번호
		dltInfo = {"LABEL" : "HOIKYE_NM", "VALUE" : "HOIKYE_CD", "FILED_ARR" : ["HOIKYE_CD", "HOIKYE_NM"]};
	} else if(codeObj.code == 'SMOK_CD') {			// 세목코드
		dltInfo = {"LABEL" : "SMOK_NM", "VALUE" : "SMOK_CD", "FILED_ARR" : ["HOIKYE_CD", "SMOK_CD", "SMOK_NM"]};
	} else if(codeObj.code == 'DEPT_C') {			// 부서코드
		dltInfo = {"LABEL" : "DEPT_NM", "VALUE" : "DEPT_CD", "FILED_ARR" : ["GUCHUNG_CD", "GUCHUNG_NM", "DEPT_CD", "DEPT_NM"]};
	} else if(codeObj.code == 'ACCNO') {			// 계좌정보
		// default 지급계좌 조회 (1:지급계좌, 2:입금계좌)
		if (com.isEmpty(codeObj.cond)) {
			codeObj.cond = {IPGI_G:'1'};
		}
		if(codeObj.cond.IPGI_G == '1') {	//지급계좌
			dltInfo = {"LABEL" : "ACCNO_NM", "VALUE" : "JI_ACCNO_G", "FILED_ARR" : ["ACCNO", "ACCNO_NM", "JI_ACCNO_G"]};
		} else {
			dltInfo = {"LABEL" : "ACCNO_NM", "VALUE" : "ACCNO", "FILED_ARR" : ["ACCNO", "ACCNO_NM", "JI_ACCNO_G"]};
		}
		codeObj.code = codeObj.code + codeObj.cond.IPGI_G
	} else if(codeObj.code == 'SUNAP_LEND_DATE') {	//최종수납일
		dltInfo = {"FILED_ARR" : ["JOB_DT"]};
	}
	
//    try {
        dltId = gcm.DATA_PREFIX + "_Nio" + codeObj.code;
        if(typeof page_p.getComponentById(dltId) == 'undefined') {
        	com.createDataObj_page("dataList", dltId, dltInfo.FILED_ARR, page_p);
        }
        
        if (codeObj.compID) {
            compArr = (codeObj.compID).replaceAll(" ", "").split(",");
            compArrLen = compArr.length;
            for (var j = 0; j < compArrLen; j++) {
                tmpIdArr = compArr[j].split(":");
                // 기본 컴포넌트
                if (tmpIdArr.length === 1) {
                    var comp = this.$p.getComponentById(tmpIdArr[0]);
                    comp.setNodeSet("data:" + dltId, dltInfo.LABEL, dltInfo.VALUE);
                
                // gridView 컴포넌트
                } else {
                    var gridObj = this.$p.getComponentById(tmpIdArr[0]);
                    gridObj.setColumnNodeSet(tmpIdArr[1], "data:" + dltId, dltInfo.LABEL, dltInfo.VALUE);
                }
            }
        }
//    } catch (ex) {
//        continue;
//    }

    // 검색조건 dataMap생성
    var columnArr = ["CODE"];    
    // 추가 조회조건이 있으면 생성
    if (!com.isEmpty(codeObj.cond)) {
    	for(key in codeObj.cond) {
    		if(!com.isEmpty(key)) {
    			columnArr.push(key);
    		}
    	}
	}
    com.createDataObj("dataMap", "MCommonComboNioR01In", columnArr);    
    MCommonComboNioR01In.set("CODE", codeObj.code);
    // 추가 조회조건에 값 셋팅
    if (!com.isEmpty(codeObj.cond)) {
    	for(key in codeObj.cond) { 
    		MCommonComboNioR01In.set(key, codeObj.cond[key]);
    	}
	}

    var searchCodeGrpOption = {
        mode : "synchronous",   // asynchronous, synchronous
        id : "sbm_CommonCodeNio",
        ref : "data:json,MCommonComboNioR01In",
        action : "",
        target : "data:json," + dltId,
        userData1 : [ {svc_id:"SCommonComboNioR01", msg_id:"MCommonComboNioR01In", sbm_id:"sbm_CommonCodeNio", isshowMsg:true} ]
    };
    
    searchCodeGrpOption.submitDoneHandler = function(e) {
    	//debugger;
    	var rtnObj = {};
        for (codeGrpDataListId in e.responseJSON) {
            if (codeGrpDataListId.indexOf("SH") > -1) {
            	rtnObj = e.responseJSON.SH
            }
        }
        if (typeof callbackFunc === "function") {
            callbackFunc(rtnObj);
        }
    }
    gcm.IS_TR = true;
    this.executeSubmission_dynamic(searchCodeGrpOption);
};