/***************************************************************
 * 파일명 : ICH030306M01.xml
 * 프로그램명 : 세출월계표 (분기보)
 * 설 명 : 세출월계표 (분기보)을 조회하고 인쇄물을 출력하는 화면이다.
 * 작성자 : SGO1023133(박용준)
 * 작성일 : 2023.
 
 * 수정일자			수정자					수정내용
   =====================================================================
   2023.   SGO1023133(박용준)    최초작성
	
 ****************************************************************/

// 전역변수 선언
scsObj.userInfo = JSON.parse(com.getSessionData("USER_INFO"));
scsObj.slGmgoModlC = com.getSlGmgoModlC(); // "RPT"
scsObj.sigumgoC = rpt.getSigumgoC();       // 인천 28
scsObj.today = $p.getCurrentServerDate("yyyyMMdd");
scsObj.isReport = "N";
scsObj.gunC = "";//군구코드

scsObj.pageMaxNum = 2000;      // 조회시 500 
scsObj.reportMaxNum = 2000;     // 출력시 XDA의 한계치인 2000

scsObj.fromRow = 0;                     // 초기값은 조회모드로 설정
scsObj.toRow = scsObj.pageMaxNum;     // 초기값은 조회모드로 설정

scsObj.totalCnt = 0;

scsObj.isFirstSearch = true;

// 스스로 초기화를 해서 오류가 발생
// scsObj.dataIn = null;

scsObj.chooseOptionTxt = "전체";    // 계좌번호 셀렉트 박스의 문구 

//결재 전역변수(必) Start ---------------------------------------------
scsObj.isPopup = "N";//팝업여부
scsObj.ifrApp = "";
//결재 전역변수(必) End -----------------------------------------------

// ******************************************************
// 초기화 함수
// ******************************************************

// onpageload
scsObj.onpageload = function () {
    grd_Main.setNoResultMessage(rpt.NoResultMsg());
    scsObj.searchCombo26();     // 회계명
    var codeObjArr = [
                        { "code": "RPT계좌분류코드", "compID": "sbx_AcctBr" },
                        {"code":"보고서보고구분_계좌회계별", "compID":"sbx_RptAcG"}
                     ];
    com.setCommCodeNm(codeObjArr, null);
    scsObj.setCommonCombo();//공통Combo

    //결재 추가 시 추가 설정(必) 실행 위치 확인
    scsObj.separateSetting();

    rpt.setGridFooterRowDisplay("ICH030306M01_footer_row", "hide");
};


//공통Combo 설정
scsObj.setCommonCombo = function(){
    
    //Data Object 정의
    rpt.comboList_createDataObj($p);// 공통코드용 RPT 데이터 컬렉션 생성 함수 및 조회
    
    //DataMap 설정
    scsObj.dataIn = MICH030306R01In;//해당 화면 In Data 기본 설정

    //값 별도 세팅 시 추가
    scsObj.dataIn.set("SIGUMGO_C", rpt.getSigumgoC());
    scsObj.dataIn.set("HOIKYE_YEAR", cal_TrnxYmd.getValue().substring(0,4));
    scsObj.dataIn.set("REF_M_C", rpt.getSigumgoC());
    scsObj.dataIn.set("DTL_HOIKYE_C", sbx_Hoigye.getValue());
    scsObj.dataIn.set("BR_NO", sbx_Brno.getValue());
    scsObj.dataIn.set("RPT_ID", "ICH030306M01");	// 보고서ID
    

    //Combo NodeSet
    sbx_Brno.setNodeSet("data:MCommonComboR56OutList","BRNM","BRNO"); //보고영업점
    sbx_OrgG.setNodeSet("data:MCommonComboR51OutList","ORG_G_NM","ORG_G"); //기관구분
    sbx_OrgC.setNodeSet("data:MCommonComboR41OutList","ORG_C_NM","ORG_C"); //기관
    sbx_DeptC.setNodeSet("data:MCommonComboR47OutList","DEPT_C_NM","DEPT_C"); //부서
    sbx_AcctNo.setNodeSet("data:MCommonComboR49OutList","SGG_ACNO_NM","SGG_ACNO"); //계좌

    //보고서 기본정보(必)
    rpt.initRpt(scsObj);

    //보고서 직인(必)
	rpt.getBranchStamp(scsObj);
    
    // scsObj.dataIn 초기화 이후 및 sfi.pageLoadSearch 호출 이전에 처리되어야 함
	rpt.pageLoadInit($p, scsObj.dataIn);
    
    //Combo 서비스 실행
    rpt.pageLoadSearch("APRV_BRNO", scsObj.dataIn, $p);//보고영업점Combo 서비스 호출
    rpt.pageLoadSearch("ORG_G", scsObj.dataIn, $p);//기관구분Combo 서비스 호출
    rpt.pageLoadSearch("GOV_G_09", scsObj.dataIn, $p);//군구(AS-IS GUNGU_CD_LIST) 서비스 호출
    
    // 사용자 소속 및 권한한에 따른 onpageload 시 UI 초기 설정 공통함수 호출
    // rpt.pageLoadSearch 호출 후에 처리되어야 함
    rpt.pageLoadDefault($p);
};

//결재 세팅 함수(必)
scsObj.separateSetting = function(){

     //현재 프레임 정의
    scsObj.nf = $p.getFrame();
    gcm.mFrame = scsObj.nf;

    //결재겸용 화면용 그리드 높이 조절(必)
    //grid-scroll -> grid-scroll-app 변경 필수
    setGridHeight.init();

    //결재화면에서 넘긴 데이터 세팅(必)
    if(!com.isEmpty(com.popup_data())){
        scsObj.param_data = JSON.parse(com.popup_data());
        scsObj.isPopup = scsObj.param_data.IS_POPUP;//팝업여부
    }

    if(typeof scsObj.isPopup == "undefined"){scsObj.isPopup = "N";}
    scsObj.setApprovalHidden();//결재진행상태 숨김
    scsObj.dataIn.set("IS_POPUP", scsObj.isPopup); 

    //메인
    if(scsObj.isPopup == "N"){
        tr_App1.hide();//보고영업점,보고구분,조회대상 숨김
        scsObj.getSysJunDate();

    //팝업
    }else{

        //결재화면에서 팝업으로 호출(必) Start ==================================================================
        tr_App1.show('');//보고영업점,보고구분,조회대상 보임
        
        grd_Main.hide();
        grp_htr.hide();//메뉴경로 숨김(ID 지정 필요)
        grp_hd.hide();//메뉴명 숨김(ID 지정 필요)
        grid_info.hide();//조회건, 총건 + 버튼 영역 숨김(ID 지정 필요)
        grp_BtnGroup.hide();//결재 버튼 영역 숨김

        // 아래 SETTING 순서중요
        let acSearchG = "";
        
        if(scsObj.param_data.RPT_DTTM != undefined && scsObj.param_data.RPT_DTTM != ""){ cal_TrnxYmd.setValue(scsObj.param_data.RPT_DTTM);scsObj.dataIn.set("BAS_DT", scsObj.param_data.RPT_DTTM);scsObj.dataIn.set("RPT_DTTM", scsObj.param_data.RPT_DTTM);}
        else{scsObj.getSysJunDate();}
        if(scsObj.param_data.BRNO != undefined && scsObj.param_data.BRNO != "") {sbx_Brno.setValue(scsObj.param_data.BRNO);scsObj.dataIn.set("BRNO", scsObj.param_data.BRNO);}
        if(scsObj.param_data.ORG_G != undefined && scsObj.param_data.ORG_G != "") {sbx_OrgG.setValue(scsObj.param_data.ORG_G);scsObj.dataIn.set("ORG_G", scsObj.param_data.ORG_G);}
        if(scsObj.param_data.ORG_C != undefined && scsObj.param_data.ORG_C != "") {sbx_OrgC.setValue(scsObj.param_data.ORG_C);scsObj.dataIn.set("ORG_C", scsObj.param_data.ORG_C);}
        if(scsObj.param_data.DEPT_C != undefined && scsObj.param_data.DEPT_C != "") {sbx_DeptC.setValue(scsObj.param_data.DEPT_C);scsObj.dataIn.set("DEPT_C", scsObj.param_data.DEPT_C);}
        if(scsObj.param_data.DTL_HOIKYE_C != undefined && scsObj.param_data.DTL_HOIKYE_C != "") {sbx_Hoigye.setValue(scsObj.param_data.DTL_HOIKYE_C);scsObj.dataIn.set("DTL_HOIKYE_C", scsObj.param_data.DTL_HOIKYE_C);}
        if(scsObj.param_data.SIGUMGO_AC_B != undefined && scsObj.param_data.SIGUMGO_AC_B != "") {sbx_AcctBr.setValue(scsObj.param_data.SIGUMGO_AC_B);scsObj.dataIn.set("SIGUMGO_AC_B", scsObj.param_data.SIGUMGO_AC_B);}
        if(scsObj.param_data.SIGUMGO_AC_NM != undefined && scsObj.param_data.SIGUMGO_AC_NM != "") {ibx_GyejwaNm.setValue(scsObj.param_data.SIGUMGO_AC_NM);scsObj.dataIn.set("SIGUMGO_AC_NM", scsObj.param_data.SIGUMGO_AC_NM);}
        if(scsObj.param_data.SGG_ACNO != undefined && scsObj.param_data.SGG_ACNO != "") {sbx_AcctNo.setValue(scsObj.param_data.SGG_ACNO);scsObj.dataIn.set("SGG_ACNO", scsObj.param_data.SGG_ACNO);}
        
        debugger;
        
        //팝업이 아닐 때 셋팅
        if(scsObj.isPopup == "MP"){
            scsObj.dataIn.set("AC_SEARCH_G", "all");			// (순서1)계좌조회구분 all:전체, R:보고서등록계좌, I.이자입금계좌
            scsObj.dataIn.set("RPT_AC_G", "1");					// (순서2)보고서보고구분  :   1.계좌별, 2.회계별, 3.회계일괄, 4.계좌일괄 
            
            ifm_rpt_app.setSize(null, 520);
            grp_srcWrap.setStyle("margin-top", "0px");
            rpt.clipReportAppView("CLIP", "", "", ifm_rpt_app, false, $p);//(必)
         
        //보고서 결재에서 팝업
        }else if(scsObj.isPopup == "Y"){
            if(sbx_RptAcG != undefined) sbx_RptAcG.setDisabled(true);//보고구분 사용금지
            if(sbx_AcSearchG != undefined) sbx_AcSearchG.setDisabled(true);//조회대상 사용금지
            if(sbx_Brno != undefined) sbx_Brno.setDisabled(true);//영업점 사용금지

            if(scsObj.param_data.RPT_AC_G != undefined && scsObj.param_data.RPT_AC_G != "") {
                sbx_RptAcG.setValue(scsObj.param_data.RPT_AC_G);
                scsObj.dataIn.set("RPT_AC_G", scsObj.param_data.RPT_AC_G);// (순서1)보고구분   필수(2020.08.16 설성윤 추가)

                if(scsObj.param_data.RPT_AC_G == "1" || scsObj.param_data.RPT_AC_G == '2'){acSearchG = "all";		// (순서2)보고구분이 1.계좌별, 2.회계별인 경우 조회구분을 all:전체 로 고정
                }else{acSearchG = "R";}

                scsObj.dataIn.set("AC_SEARCH_G", acSearchG);
                sbx_AcSearchG.setValue(acSearchG);
            }
            
            scsObj.btn_Print_onclick();//로딩 시 리포트 호출(iframe, popup 분기 필요)   
        }
        //결재화면에서 팝업으로 호출(必) End ====================================================================
    }   
};

//조회 조건 설정(必)
//RPT_JEONJA_APRV_HIS_COND 등록 
scsObj.setCondition = function (){
    var tempObj = {};
    var tempArr = [];

    tempObj = {"COND_ID":"sbx_Brno","COND_VAL":sbx_Brno.getValue(),"COND_NAME":sbx_Brno.getText()};
    tempArr.push(tempObj);
    tempObj = {"COND_ID":"sbx_RptAcG","COND_VAL":sbx_RptAcG.getValue(),"COND_NAME":sbx_RptAcG.getText()};
    tempArr.push(tempObj);
    tempObj = {"COND_ID":"sbx_AcSearchG","COND_VAL":sbx_AcSearchG.getValue(),"COND_NAME":sbx_AcSearchG.getText()};
    tempArr.push(tempObj);
    tempObj = {"COND_ID":"sbx_OrgG","COND_VAL":sbx_OrgG.getValue(),"COND_NAME":sbx_OrgG.getText()};
    tempArr.push(tempObj);
    tempObj = {"COND_ID":"sbx_OrgC","COND_VAL":sbx_OrgC.getValue(),"COND_NAME":sbx_OrgC.getText()};
    tempArr.push(tempObj);
    tempObj = {"COND_ID":"sbx_DeptC","COND_VAL":sbx_DeptC.getValue(),"COND_NAME":sbx_DeptC.getText()};
    tempArr.push(tempObj);
    tempObj = {"COND_ID":"cal_TrnxYmd","COND_VAL":cal_TrnxYmd.getValue(),"COND_NAME":cal_TrnxYmd.getValue()};
    tempArr.push(tempObj);
    tempObj = {"COND_ID":"sbx_YearGubun","COND_VAL":sbx_YearGubun.getValue(),"COND_NAME":sbx_YearGubun.getText()};
    tempArr.push(tempObj);
    tempObj = {"COND_ID":"sbx_Report","COND_VAL":sbx_Report.getValue(),"COND_NAME":sbx_Report.getText()};
    tempArr.push(tempObj);
    tempObj = {"COND_ID":"ibx_ConnAcct","COND_VAL":ibx_ConnAcct.getValue(),"COND_NAME":ibx_ConnAcct.getValue()};
    tempArr.push(tempObj);
    tempObj = {"COND_ID":"sbx_Hoigye","COND_VAL":sbx_Hoigye.getValue(),"COND_NAME":sbx_Hoigye.getText()};
    tempArr.push(tempObj);
    tempObj = {"COND_ID":"sbx_AcctBr","COND_VAL":sbx_AcctBr.getValue(),"COND_NAME":sbx_AcctBr.getText()};
    tempArr.push(tempObj);
    tempObj = {"COND_ID":"ibx_GyejwaNm","COND_VAL":ibx_GyejwaNm.getValue(),"COND_NAME":ibx_GyejwaNm.getValue()};
    tempArr.push(tempObj);
    tempObj = {"COND_ID":"sbx_AcctNo","COND_VAL":sbx_AcctNo.getValue(),"COND_NAME":sbx_AcctNo.getText()};
    tempArr.push(tempObj);
    
    return tempArr;
};


//결재영역 숨김 처리(必)
scsObj.setApprovalHidden = function(){
    appin.hide();
    appin.setSize(null, "0");//높이
    appin.setSrc("");//공통 파일 호출
};


//결재영역 보임 처리(必)
scsObj.setApprovalShow  = function(){
    rpt.searchRpt(scsObj);//보고서 결재 정보 조회

    if(scsObj.isPopup != "N"){
        appin.show('');
        appin.setSize(null, "125");//높이
    
        //결재 프레임 설정
        appin.setSrc("/uicom/common/Approval.xml");//공통 파일 호출
        scsObj.app = scsObj.nf.getObj("appin");//Approval.xml 프레임 ID
        scsObj.ifrApp = scsObj.app.getObj("scsObj");//Approval.xml 객체 정의
        scsObj.ifrApp.setAppStatus(MICH030102R07Out.getJSON());
    }
};


//결재 팝업
scsObj.btn_App_onclick = function(e) {

    MICH030102R07Out.set("IS_POPUP","MP");//메인에서 팝업 호출 구분값 : MP

    let menuUrl = "/ui/tom/ich/rpt/xml/ICH030306M01.xml";//메뉴 URL
    let menuNm = "세출월계표 (분기보)";//메뉴명
    let dataParam = JSON.stringify(MICH030102R07Out.getJSON());//고정
    let closeActionNm = "";//팝업 닫기 Action
    let callBackNm = "scsObj.btn_Search_onclick";//팝업 콜백

    //결재 공통팝업 호출
    var popOps = rpt.app_popUp(menuUrl, menuNm, dataParam, closeActionNm, callBackNm);
    com.popup_open(popOps);	
};


//영업일을 구해온다
scsObj.getSysJunDate = function (e) {
    //원하는 영업일이 있을경우 set 해준다.(ex:5일전)
    //dlt_getSysJunDateIn.set("CAL_DT", "5");
    var svcObj = { svc_id: "SCommonUtilR01", msg_id: "dlt_getSysJunDateIn", sbm_id: "sbm_CommonUtil01" };
    com.executeSvc(svcObj);
};

//영업일 셋팅
scsObj.sbm_CommonUtil01_submitdone = function (e) {
    //전영업일 셋팅
    cal_TrnxYmd.setValue(MCommonUtilR01Out.get("PREV_JOB_DT"));
};


//세출월계표 회계코드 콤보박스 출력
scsObj.searchCombo26 = function (e) {
    dma_CommonIn.reform();
    dma_CommonIn.set("SIGUMGO_C", scsObj.sigumgoC);  //시금고기관 코드
    var svcObj = { svc_id: "SCommonComboR26", msg_id: "dma_CommonIn", sbm_id: "sbm_CommonCode26" };
    com.executeSvc(svcObj);
};

scsObj.searchCombo26_submitdone = function (e) {
    sbx_Hoigye.setValue("99");
}

// ******************************************************
// 이벤트 처리 함수
// ******************************************************

// 검색버턴 클릭 이벤트
scsObj.btn_Search_onclick = function (e) {
    //결재 팝업에서 호출 시(必)
    if(scsObj.isPopup != "N"){
        if(com.isEmpty(sbx_OrgG.getValue())) {com.message("ICTM0007","기관구분을 선택하세요.","");return false;}
        if(com.isEmpty(sbx_OrgC.getValue())) {com.message("ICTM0007","기관명을 선택하세요.","");return false;}
        if(com.isEmpty(sbx_DeptC.getValue())) {com.message("ICTM0007","부서명을 선택하세요.","");return false;}

        scsObj.btn_Print_onclick();
    } else {
        if(!scsObj.validate()) return false;
        
        scsObj.isReport = "N"

        tbx_SubTotal.setValue("0");
        tbx_Total.setValue("0");

        dlt_Main.removeAll();
        dlt_Main.reform();

        scsObj.isFirstSearch = true;
        scsObj.setScrollPaging("sbm_Search");
    }
};

// 인쇄버턴 클릭 이벤트
scsObj.btn_Print_onclick = function (e) {
    scsObj.isReport = "Y"

    tbx_SubTotal.setValue("0");
    tbx_Total.setValue("0");

    report_result.removeAll();
    report_result.reform();

    scsObj.isFirstSearch = true;
    scsObj.setScrollPaging("sbm_Report");
};

// 조회 및 인쇄 서브 미션 호출
scsObj.setScrollPaging = function (sbmId) {

    scsObj.setApprovalShow();//결재선, 결재 정보 조회(必) 조회 클릭 시 실행 되도록 위치

    scsObj.fromRow = WebSquare.util.parseInt(tbx_SubTotal.getValue(), 0);  	// 다음 시작 페이지 세팅(단, 쿼리상에 시작행번호에 부등호(ROWNUM > FROM_NUM)를 사용해야 함에 주의)
    scsObj.toRow = scsObj.fromRow + scsObj.pageMaxNum; 							// 다음 끝페이지 세팅    

    var report = sbx_Report.getValue();
    var month_st = "";
    var fis_year = "";

    if ("1" == report) {
        month_st = cal_TrnxYmd.getValue().substring(0, 6) + "01";
    } else if ("2" == report) {
        var bungi = cal_TrnxYmd.getValue().substring(4, 6);

        if (bungi > 0 && bungi < 4) { // 1,2,3
            month_st = cal_TrnxYmd.getValue().substring(0, 4) + "0101";
        } else if (bungi > 3 && bungi < 7) { //4,5,6
            month_st = cal_TrnxYmd.getValue().substring(0, 4) + "0401";
        } else if (bungi > 6 && bungi < 10) { //7,8,9
            month_st = cal_TrnxYmd.getValue().substring(0, 4) + "0701";
        } else if (bungi > 9 && bungi < 13) { //10,11,12
            month_st = cal_TrnxYmd.getValue().substring(0, 4) + "1001";
        }
    } else if ("3" == report) {
        month_st = cal_TrnxYmd.getValue().substring(0, 6) + "01";
    }

    fis_year = cal_TrnxYmd.getValue().substring(0, 4); //신년,총괄인경우

    if ("9" == sbx_YearGubun.getValue()) {
        fis_year = String(Number(cal_TrnxYmd.getValue().substring(0, 4)) - 1);
    }

    MICH030306R01In.set("SL_GMGO_MODL_C", scsObj.slGmgoModlC);  //모듈코드 세션정보 세팅
    MICH030306R01In.set("GEUMGO_CD", scsObj.sigumgoC);  //금고코드 : 인천 "28"
    MICH030306R01In.set("TRNX_YMD", cal_TrnxYmd.getValue());  //금고코드 : 인천 "28"
    MICH030306R01In.set("YEAR_GUBUN", sbx_YearGubun.getValue());
    MICH030306R01In.set("BRNO", sbx_Brno.getValue());
    MICH030306R01In.set("REPORT", sbx_Report.getValue());
    MICH030306R01In.set("GUNGU_CD", scsObj.gunC);
    MICH030306R01In.set("HOIGYE", sbx_Hoigye.getValue());
    MICH030306R01In.set("ACCT_BR", sbx_AcctBr.getValue());
    MICH030306R01In.set("ACCT_NO", sbx_AcctNo.getValue());
    MICH030306R01In.set("CONN_ACCT", ibx_ConnAcct.getValue()); 
    MICH030306R01In.set("MONTH_ST", month_st);
    MICH030306R01In.set("TRNX_YMD_ST", fis_year + "0101");
    MICH030306R01In.set("FROM_ROW", scsObj.fromRow);
    MICH030306R01In.set("TO_ROW", scsObj.toRow);
    MICH030306R01In.set("IS_REPORT", scsObj.isReport);

    var svcObj = {
        svc_id: "SICH030306R01",
        msg_id: "MICH030306R01In",
        sbm_id: sbmId
    };

    com.executeSvc(svcObj);
};

// 조회 서브 미션 호출 후 처리 함수
// 조회된 데이터를 그리드에 추가함. 스크롤 엔드 이벤트에 의한 조회는 전체건수를 조회하지 않음
scsObj.sbm_Search_submitdone = function (e) {    
    dlt_Main.setJSON(e.responseJSON.MICH030306R01OutList, true);

    tbx_SubTotal.setValue(dlt_Main.getTotalRow());

    // 첫 조회시 전체 건수 저장 - 이후 스크롤엔드시 발생하는 이벤트에 대해서는 건수 조회 안함
    if (scsObj.isFirstSearch == true) {
        tbx_Total.setValue(e.responseJSON.MICH030306R01Out.TOT_CNT);
        scsObj.totalCnt = parseInt(tbx_Total.getValue(), 10);
        scsObj.isFirstSearch = false;
    }

    //-------------------------------------------------------------------------------------------------------------
    // □ 다음건이 더 있을 경우 그리드 다음조회 확인창을 호출한다.
    //-------------------------------------------------------------------------------------------------------------
    if (scsObj.totalCnt > parseInt(tbx_SubTotal.getValue())) {
        // 그리드조회구분(N:Next Search, A:All Search, X:No Search)에 따라 다음조회 분기처리한다.
        if (gcm.GRID_SEARCH_GB == "" || gcm.GRID_SEARCH_GB == "X" || gcm.GRID_SEARCH_GB == "N") {
            gcm.CONFIRM_CALLBACK = $p.id + "scsObj.sbm_AutoSearch_callback()";
            com.message("ACTM0001", "조회할 수 있는 데이터가 더 있습니다."
                , "<br>(총 " + com.formatComma(tbx_Total.getValue()) + " 건중 " + com.formatComma(tbx_SubTotal.getValue()) + " 건 조회함)"); // ACTM0001 : {0} {1}
        }
        else if (gcm.GRID_SEARCH_GB == "A") {
            scsObj.grd_scrollEnd_onscrollend();
        }
    }
    else {
        gcm.GRID_SEARCH_GB = "";
    }

    if (dlt_Main.getTotalRow() < 1) {
        grd_Main.setNoResultMessage(rpt.NoResultMsg());
        rpt.setGridFooterRowDisplay("ICH030306M01_footer_row", "hide");
    } else {
        rpt.setGridFooterRowDisplay("ICH030306M01_footer_row", "show");
        scsObj.grdColor();
    }
};

// 다음 조회 콜백 : 확인시 다음 조회할지 처리한다.
scsObj.sbm_AutoSearch_callback = function () {
    if (gcm.CONFIRM_YN != "Y") {
        return false;
    }

    // 조회공용 서비스를 호출한다.
    scsObj.setScrollPaging("sbm_Search");
};

// 인쇄 서브 미션 호출 후 처리 함수
// 조회된 데이터를 인쇄용 데이터에 추가함. 전체 데이터를 모두 조회할때까지 계속 실행됨
scsObj.sbm_Report_submitdone = function (e) {
    
    tbx_SubTotal.setValue(report_result.getTotalRow());          // 현재건수 저장

    // 첫 조회시 전체 건수 저장 - 이후 스크롤엔드시 발생하는 이벤트에 대해서는 건수 조회 안함
    if (scsObj.isFirstSearch == true) {
        tbx_Total.setValue(e.responseJSON.MICH030306R01Out.TOT_CNT); 	// 총건수 저장
        scsObj.totalCnt = parseInt(tbx_Total.getValue(), 10);
        scsObj.isFirstSearch = false;
    }

    // 전체건수보다 적으면 다시 조회(2000건)
    if (scsObj.totalCnt > report_result.getTotalRow()) {
        // scsObj.fromRow = parseInt(scsObj.toRow, 10) + 1;    //다음 시작 페이지 세팅
        // scsObj.toRow = parseInt(scsObj.toRow, 10) + parseInt(scsObj.reportMaxNum, 10); //다음 끝페이지 세팅
        scsObj.setScrollPaging("sbm_Report");               // 조회 함수 호출
    } else {
        //JSON SET 및 형변환
        var cmdNm = "BNK031020602CMD";                              //Report 반복노드명(*Report 파일 내 확인 필요)
        var result = report_result.getAllJSON();                    //Report 결과 JSON 형태
        var reportJson = rpt.setReportJsonToString(cmdNm, result);  //(반복노드명 + JSON) String 형변환

        //Report JSON 결과를 Session에 setAttribute 하는 CommonUtil 서비스 실행
        MCommonUtilR04In.set("REPORT_JSON", reportJson);
        var svcObj = {
            svc_id: "SCommonUtilR04",
            msg_id: "MCommonUtilR04In",
            sbm_id: "sbm_CommonUtil04"
        };
        com.executeSvc(svcObj);
    }
};

//Report JSON Data Session에 setAttribute 하는 CommonUtil 서비스 콜백
//Report 팝업 호출
scsObj.sbm_CommonUtil04_submitdone = function (e) {

    //업무별 설정 Start=================================================================================
    if (sbx_Report.getValue() == '3' && sbx_YearGubun.getValue() != '9') {
        com.message("ICTM0000", "최종분은 구년도일 경우에만 인쇄 가능합니다.", "");
        sbx_YearGubun.focus();
    } else {
        var trnx_ymd = cal_TrnxYmd.getValue();

        var param1 = "";

        //보고서 회계구분
        if (sbx_Report.getValue() == 1) {
            param1 = "기준월 : " + trnx_ymd.substring(0, 4) + "년 " + trnx_ymd.substring(4, 6) + "월 분";
        } else if (sbx_Report.getValue() == 2) {
            if (parseInt(trnx_ymd.substring(4, 6), 10) < 4) {
                param1 = "기준분기 : " + trnx_ymd.substring(0, 4) + "년 1분기분";
            } else if (parseInt(trnx_ymd.substring(4, 6), 10) < 7) {
                param1 = "기준분기 : " + trnx_ymd.substring(0, 4) + "년 2분기분";
            } else if (parseInt(trnx_ymd.substring(4, 6), 10) <= 9) {
                param1 = "기준분기 : " + trnx_ymd.substring(0, 4) + "년 3분기분";
            } else if (parseInt(trnx_ymd.substring(4, 6), 10) <= 12) {
                param1 = "기준분기 : " + trnx_ymd.substring(0, 4) + "년 4분기분";
            }
        } else if (sbx_Report.getValue() == 3) {
            param1 = "기준최종 : " + trnx_ymd.substring(0, 4) + "년 최종분";
        }

        var param2 = trnx_ymd.substring(0, 4) + "년 " + trnx_ymd.substring(4, 6) + "월 " + trnx_ymd.substring(6, 8) + "일";
        var param3 = sbx_YearGubun.getText().substring(2);
        var param4 = sbx_Hoigye.getText().substring(3);
        var param5 = sbx_OrgC.getText();

        if (param5.split(" - ").length > 1) {
            param5 = param5.split(" - ")[1];
        }

        var param6 = "";
        var param7 = sbx_AcctNo.getText();

        //회계구분시 변경되는 컬럼 설정
        if (sbx_Report.getValue() == "1") {
            param6 = "전 월 계";
        } else if (sbx_Report.getValue() == "2") {
            param6 = "전 분 기 계";
        } else if (sbx_Report.getValue() == "3") {
            param6 = "전 년 계";
        }

        //날짜양식 설정
        //$("#trnx_ymd").mask("9999-99-99");

        //보고서에 전달하는 Parameter
        var paramStrVal = param1 + ',' + param2 + ',' + param3 + ',' + param4 + ',' + param5 + ',' + param6 + ',' + param7;
        var reportCrf = "crRPT031020602";     //Report 파일명
        var reportCmd = "BNK031020602CMD";    //Report 반복노드명(*Report 파일 내 확인 필요)
        var titleTxt = param1;
        //업무별 설정 End=================================================================================

        let filePath = MICH030102R08Out.get("SVR_FILE_PATH")+"/"+MICH030102R08Out.get("SVR_FILE_NM");

        //결재 팝업에서 호출 시(必)
        if(scsObj.isPopup != "N"){
            rpt.clipReportAppView(reportCrf, reportCmd, paramStrVal, ifm_rpt_app, false, filePath);
            
        }else{
            var popOps = rpt.clipReportPopUp(reportCrf, titleTxt, reportCmd, paramStrVal, false, "", "", filePath);
            com.popup_open(popOps);
        }
    }
};

// 다건 조회 페이징1방식 ScrollEnd 이벤트 
scsObj.grd_scrollEnd_onscrollend = function () {
    if (dlt_Main.getTotalRow() == scsObj.totalCnt) {   // 추가 조회 내용이 없는 경우
        return false;
    }

    // scsObj.fromRow = parseInt(scsObj.toRow, 10) + 1;  //다음 시작 페이지 세팅
    // scsObj.toRow = parseInt(scsObj.toRow, 10) + parseInt(scsObj.pageMaxNum, 10); //다음 끝페이지 세팅
    scsObj.setScrollPaging("sbm_Search"); //함수 호출
};

// ******************************************************
// 키보드 이벤트 처리 함수
// ******************************************************
scsObj.ibx_GyejwaNm_onkeydown = function (e) {
    // 계좌번호 조회
    if (e.keyCode == 13) {
        //scsObj.changeAcctNo();
    }
};

scsObj.ibx_ConnAcct_onkeydown = function (e) {
    // 계좌번호 조회
    if (e.keyCode == 13) {
        scsObj.setScrollPaging("sbm_Search");
    }
};

// ******************************************************
// 유틸리티 함수
// ******************************************************
// 셀컬러 변경
scsObj.grdColor = function () { debugger;
    var dltTemp = dlt_Main.getAllJSON();
    rpt.removeClassTxtRed();//Footer 'txt-red' All Remove Class  

    for (var i = 0; i < dltTemp.length; i++) {
        if (Number(dltTemp[i].DANGWOL_BAEJUNG) < 0) grd_Main.setCellClass(i, "DANGWOL_BAEJUNG", "txt-red");
        if (Number(dltTemp[i].BAEJUNG_NUGYE) < 0) grd_Main.setCellClass(i, "BAEJUNG_NUGYE", "txt-red");
        if (Number(dltTemp[i].JUNWOL_JICHUL) < 0) grd_Main.setCellClass(i, "JUNWOL_JICHUL", "txt-red");
        if (Number(dltTemp[i].DANGWOL_JICHUL) < 0) grd_Main.setCellClass(i, "DANGWOL_JICHUL", "txt-red");
        if (Number(dltTemp[i].MIJIGEUB) < 0) grd_Main.setCellClass(i, "MIJIGEUB", "txt-red");
        if (Number(dltTemp[i].DANGWOL_YUIP) < 0) grd_Main.setCellClass(i, "DANGWOL_YUIP", "txt-red");
        if (Number(dltTemp[i].DANGWOL_GYULJUNG) < 0) grd_Main.setCellClass(i, "DANGWOL_GYULJUNG", "txt-red");
        if (Number(dltTemp[i].JICHUL_NUGYE) < 0) grd_Main.setCellClass(i, "JICHUL_NUGYE", "txt-red");
        if (Number(dltTemp[i].JANAC) < 0) grd_Main.setCellClass(i, "JANAC", "txt-red");
    }

    //Footer 음수 Css 적용
    var v_DANGWOL_BAEJUNG  = Number(grd_Main.getFooterData("DANGWOL_BAEJUNG_HAP"));
    var v_BAEJUNG_NUGYE    = Number(grd_Main.getFooterData("BAEJUNG_NUGYE_HAP"));
    var v_JUNWOL_JICHUL    = Number(grd_Main.getFooterData("JUNWOL_JICHUL_HAP"));
    var v_DANGWOL_JICHUL   = Number(grd_Main.getFooterData("DANGWOL_JICHUL_HAP"));
    var v_MIJIGEUB         = Number(grd_Main.getFooterData("MIJIGEUB_HAP"));
    var v_DANGWOL_YUIP     = Number(grd_Main.getFooterData("DANGWOL_YUIP_HAP"));
    var v_DANGWOL_GYULJUNG = Number(grd_Main.getFooterData("DANGWOL_GYULJUNG_HAP"));
    var v_JICHUL_NUGYE     = Number(grd_Main.getFooterData("JICHUL_NUGYE_HAP"));
    var v_JANAC            = Number(grd_Main.getFooterData("JANAC_HAP"));

    //GridId_FooterCellId 조합
    var clsId1 = document.getElementById($p.id + "grd_Main" + "_" + "DANGWOL_BAEJUNG_HAP");
    var clsId2 = document.getElementById($p.id + "grd_Main" + "_" + "BAEJUNG_NUGYE_HAP");
    var clsId3 = document.getElementById($p.id + "grd_Main" + "_" + "JUNWOL_JICHUL_HAP");
    var clsId4 = document.getElementById($p.id + "grd_Main" + "_" + "DANGWOL_JICHUL_HAP");
    var clsId5 = document.getElementById($p.id + "grd_Main" + "_" + "MIJIGEUB_HAP");
    var clsId6 = document.getElementById($p.id + "grd_Main" + "_" + "DANGWOL_YUIP_HAP");
    var clsId7 = document.getElementById($p.id + "grd_Main" + "_" + "DANGWOL_GYULJUNG_HAP");
    var clsId8 = document.getElementById($p.id + "grd_Main" + "_" + "JICHUL_NUGYE_HAP");
    var clsId9 = document.getElementById($p.id + "grd_Main" + "_" + "JANAC_HAP");

    //0보다 작으면 css 적용
    if (v_DANGWOL_BAEJUNG  < 0) clsId1.classList.add("txt-red");   
    if (v_BAEJUNG_NUGYE    < 0) clsId2.classList.add("txt-red");
    if (v_JUNWOL_JICHUL    < 0) clsId3.classList.add("txt-red");
    if (v_DANGWOL_JICHUL   < 0) clsId4.classList.add("txt-red");
    if (v_MIJIGEUB         < 0) clsId5.classList.add("txt-red");
    if (v_DANGWOL_YUIP     < 0) clsId6.classList.add("txt-red");
    if (v_DANGWOL_GYULJUNG < 0) clsId7.classList.add("txt-red");
    if (v_JICHUL_NUGYE     < 0) clsId8.classList.add("txt-red");
    if (v_JANAC            < 0) clsId9.classList.add("txt-red");
};


//공통Combo 데이터 변경 이벤트
scsObj.MICH030306R01In_onmodelchange = function(info) {
    if(scsObj.dataIn == undefined) return;
    
    //DataMap 재설정
    scsObj.dataIn = MICH030306R01In;//해당 화면 In Data 기본 설정

    //DataMap 재설정 필요시
    scsObj.dataIn.set("SIGUMGO_C", rpt.getSigumgoC());
    scsObj.dataIn.set("HOIKYE_YEAR", cal_TrnxYmd.getValue().substring(0,4));
    scsObj.dataIn.set("REF_M_C", rpt.getSigumgoC());
    scsObj.dataIn.set("DTL_HOIKYE_C", sbx_Hoigye.getValue());
    scsObj.dataIn.set("BR_NO", sbx_Brno.getValue());

    //기관구분 변경 시  
    if(info.key == "ORG_G"){
        rpt.dataChangeSearch("ORG_C", scsObj.dataIn, $p);//부서Combo 재조회
        rpt.dataChangeSearch("SGG_ACNO", scsObj.dataIn, $p);//계좌Combo 재조회
        scsObj.gunC = MCommonComboR00In.get("GOV_G");//군구코드 

    //기관명 변경 시
    }else if(info.key == "ORG_C"){
        rpt.dataChangeSearch("DEPT_C", scsObj.dataIn, $p);//부서Combo 재조회
		rpt.dataChangeSearch("SGG_ACNO", scsObj.dataIn, $p);//계좌Combo 재조회
        scsObj.gunC = MCommonComboR00In.get("GOV_G");//군구코드 

    //부서, 군구, 회계년도, 계좌분류, 회계명, 영업점 변경 시 
    }else if(info.key == "DEPT_C" || info.key == "GOV_G" || info.key == "HOIKYE_YEAR" || info.key == "SIGUMGO_AC_B" || info.key == "HOIKYE_C"  ||  info.key == "SIGUMGO_AC_NM"){
        rpt.dataChangeSearch("SGG_ACNO", scsObj.dataIn, $p);//계좌Combo 재조회
    
    //보고영업점 변경 시 
    }else if(info.key == "APRV_BRNO"){ 
        scsObj.dataIn.set(info.key, info.newValue);//값변동이 delay 발생하여 강제SET 처리
        rpt.dataChangeSearch("ORG_G", scsObj.dataIn, $p);//기관구분Combo 재조회

        //보고서 직인(必)
	    rpt.getBranchStamp(scsObj);

        rpt.dataChangeSearch("SGG_ACNO", scsObj.dataIn, $p);//계좌Combo 재조회
        
    //조회대상 변경 시 
    }else if(info.key == "AC_SEARCH_G"){
        scsObj.dataIn.set(info.key, info.newValue);//값변동이 delay 발생하여 강제SET 처리
        rpt.dataChangeSearch("APRV_BRNO", scsObj.dataIn, $p);//보고영업점Combo 서비스 호출
        rpt.dataChangeSearch("ORG_G", scsObj.dataIn, $p);//기관구분Combo 재조회
        rpt.dataChangeSearch("ORG_C", scsObj.dataIn, $p);//부서Combo 재조회
        rpt.dataChangeSearch("DEPT_C", scsObj.dataIn, $p);//부서Combo 재조회
    }
    
    if(scsObj.gunC == "all") scsObj.gunC = "";

};

//날짜변경
scsObj.cal_TrnxYmd_onchange = function() {
    MICH030306R01In.set("HOIKYE_YEAR", cal_TrnxYmd.getValue().substring(0,4));
};

//날짜 체크 START ========================================================================
scsObj.cal_TrnxYmd_onviewchange = function(info) {    
    //날짜 형식 체크
    if(!dateLib.isDate(info.newValue)){
        com.message("ICTM0007", "날짜 형식이 잘못 되었습니다.", ""); // ICTM0007 : {0} {1}
        cal_TrnxYmd.setValue(info.oldValue);
        cal_TrnxYmd.focus();
        return false;
    }
};
//날짜 체크 END ========================================================================


//기관구분 검색 클릭
scsObj.btn_OrgG_onclick = function(e) {
    var popOps = rpt.orgG_popUp("scsObj.popOrgGCallBack");
	
	com.popup_open(popOps);
};

//기관구분 검색 클릭 콜백
scsObj.popOrgGCallBack = function(arg){
    //팝업 종료후 콜백 처리
    if ( arg != null ){
        sbx_OrgG.setValue(arg.ORG_G);
    }
};

//기관 검색 클릭
scsObj.btn_OrgC_onclick = function(e) {
    var gigwanGubun = sbx_OrgG.getValue(); //기관구분
    var popOps = rpt.orgC_popUp("scsObj.orgNmInqrPopCallBack", gigwanGubun);//param:기관구분
    
    com.popup_open(popOps);
};

//기관 검색 클릭 콜백
scsObj.orgNmInqrPopCallBack = function(arg){        
    if ( arg != null ){
        sbx_OrgC.setValue( arg.ORG_C ); // 부서명
    }        
};

//부서 검색 클릭
scsObj.btn_DeptC_onclick = function(e) {
    var gigwanCode = sbx_OrgC.getValue(); //기관코드
    var txioG = "1";
    
    var popOps = rpt.deptC_popUp("scsObj.deptInqrPopCallBack", gigwanCode, txioG); //param:기관구분코드,세입세출구분

    com.popup_open(popOps);		
};

//부서 검색 클릭 콜백
scsObj.deptInqrPopCallBack = function(arg){   
    if ( arg != null ){
        sbx_DeptC.setValue( arg.DEPT_C ); // 부서명
    }
};

//계좌번호 검색 클릭
scsObj.btn_sggAcno_onclick = function(e) {
    // 팝업 (윈도우 팝업 type:"window:레이어","browser:새창" 모달 :"modal:true" 모달리스:"modal:false")
    var popOps = rpt.sggAcnoC_popUp("scsObj.btn_sggAcno_popCallBack", MCommonComboR00In.getJSON());
    com.popup_open(popOps);		
};

//계좌번호 검색 콜백
scsObj.btn_sggAcno_popCallBack = function(arg){            
    if ( arg != null ){
        sbx_AcctNo.setValue( arg.SGG_ACNO );
    }
};


scsObj.validate = function() {
    if (!dateLib.isDate(cal_TrnxYmd.getValue(), false, false)) {
        com.message("ICTM0007", "기준일자를 확인하세요.", "");
        return false;
    }
    if (ibx_ConnAcct.getValue().length != 0 && ibx_ConnAcct.getValue().length != 12) {
        com.message("ICTM0007", "계좌번호는 12자리입니다.", "");
        return false;
    }
    return true;
};