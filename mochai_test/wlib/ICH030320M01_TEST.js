
const sbm_Report_submitdone_test = function() {

    //업무별 설정 Start=================================================================================
    var trnx_ymd = cal_TrnxYmd.getValue();
    var acct_nm = sbx_AcctNo.getText();
    var acct_no = sbx_AcctNo.getValue();

    var param1 = "세출 일계표";
    var param2 = trnx_ymd.substring(0, 4) + "년 " + trnx_ymd.substring(4, 6) + "월 " + trnx_ymd.substring(6, 8) + "일";
    var param3 = cal_FisYear.getValue();
    var param4 = "";
    var param5 = sbx_OrgC.getText();
    var param6 = "";
    var param7 = "";
    var param8 = "1";

    if(checkValidateParam(sbx_AcctNo.getValue()) === "all") {
        param4 = "전체";
        param6 = "전체";
        param7 = "전체";
        param8 = "2";
    } else {
        var matches = acct_nm.match(/\[(.*?)\]/);
        var result =  matches ? matches[1] : acct_nm;
        param4 = encodeURIComponent(result);
        param6 = acct_no.substring(0, 3) + "-" + acct_no.substring(3, 6) + "-" + acct_no.substring(6, 8) + "-" + acct_no.substring(8, 10) + "-" + acct_no.substring(10, 15) + "-" + acct_no.substring(15);
        param7 = sbx_AcctNo.getText();

        if(acct_no.substring(6, 10) == '0110') {
        param8 = "0";
        }
    }

    // if (!fn_validate()) return;  // 필수값 체크

    //보고서에 전달하는 Parameter
    var paramStrVal = param1 + ',' + param2 + ',' + param3 + ',' + param4 + ',' + param5 + ',' + param6 + ',' + param7 + ',' + param8;

    var reportCrf = "crRPTICH030320M01";     //Report 파일명
    var reportCmd = "ICH030320M01CMD";      //Report 반복노드명(*Report 파일 내 확인 필요)
    var titleTxt = param1;
    //업무별 설정 End=================================================================================
    let filePath = MICH030102R08Out.get("SVR_FILE_PATH")+"/"+MICH030102R08Out.get("SVR_FILE_NM");

    //Clip Report 공통 팝업 호출
    var popOps = rpt.clipReportPopUp(reportCrf, titleTxt, reportCmd, paramStrVal, false, "950", "1200", filePath);
    com.popup_open(popOps);
};

//테스트 실행
sbm_Report_submitdone_test();