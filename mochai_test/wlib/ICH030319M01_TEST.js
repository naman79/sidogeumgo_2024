/***************************************************************
 * 파일명 : ICH030319M01.xml
 * 프로그램명 : 세출월계표 개선
 * 설 명 : 세출월계표 을 조회하고 인쇄물을 출력하는 화면이다.
 * 작성자 :
 * 작성일 :
 
 * 수정일자			수정자					수정내용
   =====================================================================

	
 ****************************************************************/

// 전역변수 선언
scsObj.userInfo = JSON.parse(com.getSessionData("USER_INFO"));
scsObj.slGmgoModlC = com.getSlGmgoModlC(); // "RPT"
scsObj.sigumgoC = rpt.getSigumgoC();       // 인천 28
scsObj.today = $p.getCurrentServerDate("yyyyMMdd");
scsObj.isReport = "N";
scsObj.gunC = "";//군구코드

scsObj.pageMaxNum = 2000;      // 조회시 2000
scsObj.reportMaxNum = 2000;     // 출력시 XDA의 한계치인 2000

scsObj.fromRow = 0;                     // 초기값은 조회모드로 설정
scsObj.toRow = scsObj.pageMaxNum;     // 초기값은 조회모드로 설정

scsObj.totalCnt = 0;

scsObj.isFirstSearch = true;

scsObj.dataIn = null;

// ******************************************************
// 초기화 함수
// ******************************************************

// onpageload
scsObj.onpageload = function () {
    
    setGridHeight.init();
    grd_Main.setNoResultMessage(rpt.NoResultMsg());
    scsObj.getSysJunDate();
    scsObj.searchCombo01();     // 영업점
    
    var codeObjArr = [{ "code": "RPT계좌분류코드", "compID": "sbx_AcctBr" }];
    com.setCommCodeNm(codeObjArr, null);
    //scsObj.changeAcctNo();
    scsObj.setCommonCombo();//공통Combo

    rpt.setGridFooterRowDisplay("ICH030319_footer_row", "hide");
};


//공통Combo 설정
scsObj.setCommonCombo = function(){
    
    //Data Object 정의
    rpt.comboList_createDataObj($p);// 공통코드용 RPT 데이터 컬렉션 생성 함수 및 조회
    
    //DataMap 설정
    scsObj.dataIn = MessageSimpleR01In;//해당 화면 In Data 기본 설정

    //값 별도 세팅 시 추가
    scsObj.dataIn.set("SIGUMGO_C", rpt.getSigumgoC());
    //scsObj.dataIn.set("HOIKYE_YEAR", cal_TrnxYmd.getValue().substring(0,4));
    scsObj.dataIn.set("HOIKYE_YEAR", cal_FisYear.getValue());
    scsObj.dataIn.set("REF_M_C", rpt.getSigumgoC());

    //Combo NodeSet
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
    rpt.pageLoadSearch("ORG_G", scsObj.dataIn, $p);//기관구분Combo 서비스 호출
    rpt.pageLoadSearch("GOV_G_09", scsObj.dataIn, $p);//군구(AS-IS GUNGU_CD_LIST) 서비스 호출
    
    // 사용자 소속 및 권한한에 따른 onpageload 시 UI 초기 설정 공통함수 호출
    // rpt.pageLoadSearch 호출 후에 처리되어야 함
    rpt.pageLoadDefault($p);
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

//영업점 콤보박스 출력
scsObj.searchCombo01 = function (e) {
    dma_CommonIn.reform();
    dma_CommonIn.set("SIGUMGO_C", scsObj.sigumgoC);  //시금고기관 코드
    var svcObj = { svc_id: "SCommonComboR01", msg_id: "dma_CommonIn", sbm_id: "sbm_CommonCode01" };
    com.executeSvc(svcObj);
};

// ******************************************************
// 이벤트 처리 함수
// ******************************************************

// 검색버턴 클릭 이벤트
scsObj.btn_Search_onclick = function (e) { 
    if(!scsObj.validate()) return false;

    scsObj.isReport = "N"

    tbx_SubTotal.setValue("0");
    tbx_Total.setValue("0");

    dlt_Main.removeAll();
    dlt_Main.reform();
    
    scsObj.isFirstSearch = true;
    scsObj.setScrollPaging("sbm_Search");
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

    setParamData();

    var svcObj = {
        svc_id: "ServiceSimpleR01",
        msg_id: "MessageSimpleR01In",
        sbm_id: sbmId
    };

    com.executeSvc(svcObj);
};

// 조회 서브 미션 호출 후 처리 함수
scsObj.sbm_Search_submitdone = function (e) {
	 
    dlt_Main.setJSON(e.responseJSON.MessageSimpleR01OutList, true);
    
    tbx_SubTotal.setValue(dlt_Main.getTotalRow());          // 현재건수 저장

    // 첫 조회시 전체 건수 저장 - 이후 스크롤엔드시 발생하는 이벤트에 대해서는 건수 조회 안함
    if (scsObj.isFirstSearch == true) {
        tbx_Total.setValue(e.responseJSON.MessageSimpleR01Out.TOT_CNT); 	// 총건수 저장
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
        rpt.setGridFooterRowDisplay("ICH030319_footer_row", "hide");
    } else {
        rpt.setGridFooterRowDisplay("ICH030319_footer_row", "show");
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
        tbx_Total.setValue(e.responseJSON.MessageSimpleR01Out.TOT_CNT); 	// 총건수 저장
        scsObj.totalCnt = parseInt(tbx_Total.getValue(), 10);
        scsObj.isFirstSearch = false;
    }

    // 전체건수보다 적으면 다시 조회(2000건)
    if (scsObj.totalCnt > report_result.getTotalRow()) {
        // scsObj.fromRow = parseInt(scsObj.toRow, 10) + 1;  //다음 시작 페이지 세팅
        // scsObj.toRow = parseInt(scsObj.toRow, 10) + parseInt(scsObj.reportMaxNum, 10); //다음 끝페이지 세팅
        scsObj.setScrollPaging("sbm_Report"); //함수 호출
    } else {
        //JSON SET 및 형변환
        var cmdNm = "ICH030319CMD";                              //Report 반복노드명(*Report 파일 내 확인 필요)
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
    //if (sbx_Report.getValue() == '3' && sbx_YearGubun.getValue() != '9') {
        //alert("최종분은 구년도일 경우에만 인쇄 가능합니다.");
        //$('#year_gubun').focus();
        //sbx_YearGubun.focus();
    //} else {
        var trnx_ymd = cal_TrnxYmd.getValue();

        var param1 = "";
        //보고서 회계구분
        if (sbx_Report.getValue() == 1) {
            param1 = "기준월 : " + trnx_ymd.substring(0, 4) + "년 " + trnx_ymd.substring(4, 6) + "월 분";
        } else if (sbx_Report.getValue() == 2) {
            if (parseInt(trnx_ymd.substring(4, 6)) < 4) {
                param1 = "기준분기 : " + trnx_ymd.substring(0, 4) + "년 1분기분";
            } else if (parseInt(trnx_ymd.substring(4, 6)) < 7) {
                param1 = "기준분기 : " + trnx_ymd.substring(0, 4) + "년 2분기분";
            } else if (parseInt(trnx_ymd.substring(4, 6)) <= 9) {
                param1 = "기준분기 : " + trnx_ymd.substring(0, 4) + "년 3분기분";
            } else if (parseInt(trnx_ymd.substring(4, 6)) <= 12) {
                param1 = "기준분기 : " + trnx_ymd.substring(0, 4) + "년 4분기분";
            }
        } else if (sbx_Report.getValue() == 3) {
            param1 = "기준최종 : " + trnx_ymd.substring(0, 4) + "년 최종분";
        }

        var param2 = trnx_ymd.substring(0, 4) + "년 " + trnx_ymd.substring(4, 6) + "월 " + trnx_ymd.substring(6, 8) + "일";
        var param3 = cal_FisYear.getValue();
        var param4 = sbx_Hoigye.getText().substring(3);
        var param5 = sbx_OrgC.getText();
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

        //보고서에 전달하는 Parameter
        var paramStrVal = param1 + ',' + param2 + ',' + param3 + ',' + param4 + ',' + param5 + ',' + param6 + ',' + param7;

        var reportCrf = "crRPTICH030319M01";     //Report 파일명
        var reportCmd = "ICH030319CMD";      //Report 반복노드명(*Report 파일 내 확인 필요)
        var titleTxt = param1;
        //업무별 설정 End=================================================================================

        let filePath = MICH030102R08Out.get("SVR_FILE_PATH")+"/"+MICH030102R08Out.get("SVR_FILE_NM");

        //Clip Report 공통 팝업 호출
        var popOps = rpt.clipReportPopUp(reportCrf, titleTxt, reportCmd, paramStrVal, false, "950", "1200", filePath);
        com.popup_open(popOps);
    //}
};

// 다건 조회 페이징1방식 ScrollEnd 이벤트 
scsObj.grd_scrollEnd_onscrollend = function () {
    // 조회한 내용이 없는 경우        
    if (tbx_Total.getValue() == "0") {
        return false;
    }

    if (scsObj.totalCnt <= dlt_Main.getTotalRow()) {   // 추가 조회 내용이 없는 경우
        return false;
    }
    
    // scsObj.fromRow = parseInt(scsObj.toRow, 10) + 1;  //다음 시작 페이지 세팅
    // scsObj.toRow = parseInt(scsObj.toRow, 10) + parseInt(scsObj.pageNum, 10); //다음 끝페이지 세팅
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
        scsObj.setScrollPaging("sbm_Search"); //함수 호출
    }
};

// ******************************************************
// 유틸리티 함수
// ******************************************************


//공통Combo 데이터 변경 이벤트
scsObj.MessageSimpleR01In_onmodelchange = function(info) {
    if(scsObj.dataIn == undefined) return;
    
    //DataMap 재설정 필요시
    scsObj.dataIn.set("SIGUMGO_C", rpt.getSigumgoC());
    //scsObj.dataIn.set("HOIKYE_YEAR", cal_TrnxYmd.getValue().substring(0,4));
    scsObj.dataIn.set("HOIKYE_YEAR", cal_FisYear.getValue());
    scsObj.dataIn.set("REF_M_C", rpt.getSigumgoC());

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
    }else if(info.key == "DEPT_C" || info.key == "GOV_G" || info.key == "HOIKYE_YEAR" || info.key == "SIGUMGO_AC_B" || info.key == "HOIKYE_C" ||  info.key == "SIGUMGO_AC_NM"){
        rpt.dataChangeSearch("SGG_ACNO", scsObj.dataIn, $p);//계좌Combo 재조회
    }else if(info.key == "APRV_BRNO"){
        //보고서 직인(必)
	    rpt.getBranchStamp(scsObj);

        rpt.dataChangeSearch("SGG_ACNO", scsObj.dataIn, $p);//계좌Combo 재조회
    }
     if(scsObj.gunC == "all") scsObj.gunC = "";
};


//부서명 변경
scsObj.sbx_DeptC_onchange = function(info) {
    
};


//날짜변경
scsObj.cal_TrnxYmd_onchange = function() {
    //MessageSimpleR01In.set("HOIKYE_YEAR", cal_TrnxYmd.getValue().substring(0,4));
    MessageSimpleR01In.set("HOIKYE_YEAR", cal_FisYear.getValue());
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


//계좌번호 포맷
scsObj.setAcctFormat = function(data) {
  var acctFmt = data.trim();

  if(acctFmt.length == 12){
    acctFmt = data.substring(0,3) + "-" + data.substring(3,6) + "-" + data.substring(6,12);
  }else if(acctFmt.length == 17){
    acctFmt = acctFmt.substring(0,3) + "-" + acctFmt.substring(3,6) + "-" + acctFmt.substring(6,8)
		          + "-" + acctFmt.substring(8,10) + "-" + acctFmt.substring(10,15) + "-" + acctFmt.substring(15,17);
  }
  return acctFmt;
};

//구분명 포맷
scsObj.setGubunNm = function(data) {
  var gubun = data.trim();
  var gubunNm = "자계좌";
  
  if(gubun == "1") {
      gubunNm = "본청"
  } else if(gubun == "2") {
      gubunNm = "본청외"
  } else if(gubun == "3") {
      gubunNm = "자금계좌"
  } else if(gubun == "99") {
      gubunNm = "합계"
  }

  
  return gubunNm;
};

//합계열 추가
var addTotal = function() {
            
        var ds = MessageSimpleR01OutList;
        ds.insertRow(0);

        if(checkValidateParam(sbx_AcctNo.getValue()) === "all") {
            ds.setCellData(0, "GYEJWA_NM", "합계");
        } else {
            ds.setCellData(0, "GUBUN_NM", "99");
        }
        
        var columns = [
                        "JEONHANDO_BAEJEONG",
                        "JEONHANDO_HWANSU",
                        "DANGHANDO_BAEJEONG",
                        "DANGHANDO_HWANSU",
                        "JEONSECHUL_JICHUL",
                        "JEONSECHUL_BANNAB",
                        "DANGSECHUL_JICHUL",
                        "DANGSECHUL_BANNAB"
                        ];

        columns.forEach(function(colId){
            var sum = 0;
            for (var j = 1; j < ds.getRowCount(); j++) {
                var val = Number(ds.getCellData(j, colId));
                sum += isNaN(val) ? 0: val ;
            }
            ds.setCellData(0, colId, sum);
        });
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

//전송파라미터 셋팅
var setParamData = function() {
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

    //fis_year = cal_TrnxYmd.getValue().substring(0, 4); //신년,총괄인경우
    fis_year = cal_FisYear.getValue();

/*     if ("9" == sbx_YearGubun.getValue()) {
        fis_year = String(Number(cal_TrnxYmd.getValue().substring(0, 4)) - 1);
    } */

    MessageSimpleR01In.set("LOCALCODE", "ich");
    MessageSimpleR01In.set("REPORTCODE", "rpt");
    MessageSimpleR01In.set("MENUCODE", "ICH030319");
    MessageSimpleR01In.set("SL_GMGO_MODL_C", scsObj.slGmgoModlC);  //모듈코드 세션정보 세팅
    MessageSimpleR01In.set("GEUMGO_CD", scsObj.sigumgoC);          //금고코드 : 인천 "28"
    MessageSimpleR01In.set("TRNX_YMD", cal_TrnxYmd.getValue());    
    //MessageSimpleR01In.set("YEAR_GUBUN", sbx_YearGubun.getValue());
    MessageSimpleR01In.set("YEAR_GUBUN", 1);
    MessageSimpleR01In.set("BRNO", sbx_Brno.getValue());
    MessageSimpleR01In.set("REPORT", sbx_Report.getValue());
    MessageSimpleR01In.set("GUNGU_CD", scsObj.gunC);
    MessageSimpleR01In.set("HOIGYE", sbx_Hoigye.getValue());
    MessageSimpleR01In.set("ACCT_BR", sbx_AcctBr.getValue());
    MessageSimpleR01In.set("ACCT_NO", sbx_AcctNo.getValue());
    MessageSimpleR01In.set("CONN_ACCT", ibx_ConnAcct.getValue());
    MessageSimpleR01In.set("MONTH_ST", month_st);
    MessageSimpleR01In.set("TRNX_YMD_ST", fis_year + "0101");
    MessageSimpleR01In.set("FROM_ROW", scsObj.fromRow);
    MessageSimpleR01In.set("TO_ROW", scsObj.toRow);
    MessageSimpleR01In.set("IS_REPORT", scsObj.isReport);
    MessageSimpleR01In.set("ORGAN_GB", checkValidateParam(sbx_OrgG.getValue()));
    MessageSimpleR01In.set("ORGAN_CD", checkValidateParam(sbx_OrgC.getValue()));
    MessageSimpleR01In.set("DEPT_CD", checkValidateParam(sbx_DeptC.getValue()));
    MessageSimpleR01In.set("ACNO", checkValidateParam(sbx_AcctNo.getValue()));

};

// 전송 파라미터 유효 처리 및 기본값 셋팅
var checkValidateParam = function(value, defaultVal = "all") {
    return value == null || value.trim() === "" ? defaultVal : value;
};

//그리드 셀컬러 변경 (customFormatter)                           
scsObj.setGrdColor = function (data, formattedData, rowIndex, colIndex) {
    if (Number(data) < 0) {
        grd_Main.setCellClass(rowIndex, colIndex, "txt-red");
    }
    return formattedData;
}