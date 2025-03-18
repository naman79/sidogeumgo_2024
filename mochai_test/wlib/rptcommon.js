var rpt = {};

/**
*
*
* 사용자 금고코드 
*
* @date 2023. 06. 29.
* @memberOf rpt
* @author 김태호
* @return 금고코드
*/
rpt.getSigumgoC = function() {
	var sigumgoC = com.getSessionData("SIGUMGO_C");
	
	if(sigumgoC == "0"){sigumgoC = "28";}
	
	return sigumgoC;
};


/**
*
* GCC_DEPT_CD
*
* @date 2023. 08. 24.
* @memberOf rpt
* @author 김태호
* @return GCC_DEPT_CD
*/
rpt.getGccDeptCd = function() {
	var gccDeptCd = com.getSessionData("GCC_DEPT_CD");
	
	return gccDeptCd;
};



/**
 * 사용자권한 6자리
 */
rpt.getUserUC = function() {
	var userUC = JSON.parse(com.getSessionData("USER_INFO"));
	
	return userUC.USER_U_C;
};
/**
*
* 사용자 구분
* BANK:은행직원 
* SIGU:공무원 
*
* @date 2023. 08. 04.
* @memberOf rpt
* @author 김태호
* @return 사용자구분코드
*/
rpt.getUserGubun = function() {
	var userGubun = com.getSessionData("USER_GUBUN");
	
	return userGubun;
};


/**
*
* 사용자 권한 구분
* 0:은행직원, 1:담당자, 2:사용자 
* @date 2023. 09. 07.
* @memberOf rpt
* @author 김태호
* @return 사용자권한구분코드
*/
rpt.getUserAuthGubun = function() {
	var userAuthGubun = com.getSessionData("USER_AUTH_GUBUN");
	
	return userAuthGubun;
};

/**
*
* 사용자 전화번호
*
* @date 2023. 10. 10.
* @memberOf rpt
* @author 김태호
* @return 전화번호
*/
rpt.getTelNo = function() {
	var telNo = com.getSessionData("USER_TELNO");
	
	return telNo;
};


/**
*
* 최초화면 메시지
*
* @date 2023. 07. 13.
* @memberOf rpt
* @author 김태호
* @return 메시지
*/
rpt.initMsg = function() {
	var msg = "조회 조건을 선택하신 후 [조회] 버튼을 눌러주세요.";
	
	
	return msg;
};

/**
*
* 조회된 데이터가 없을시
*
* @date 2023. 07. 13.
* @memberOf rpt
* @author 김태호
* @return 메시지
*/
rpt.NoResultMsg = function() {
	var msg = "조회된 데이터가 없습니다.";
	
	
	return msg;
};

/**
*
* 계좌번호 포맷 
*
* @date 2023. 07. 20.
* @memberOf rpt
* @author 박용준
* @return 메시지
*/	
rpt.setAcctFormat = function (acct) {
	var acctFmt = acct.trim();
	if(acctFmt.length == 12) {
		acctFmt = acctFmt.substring(0,3) + "-" + acctFmt.substring(3,6) + "-" + acctFmt.substring(6,12);
	} else if(acctFmt.length == 17) {
		acctFmt = acctFmt.substring(0,3) + "-" + acctFmt.substring(3,6) + "-" + acctFmt.substring(6,8)
		          + "-" + acctFmt.substring(8,10) + "-" + acctFmt.substring(10,15) + "-" + acctFmt.substring(15,17);
	}
	return acctFmt;
}



/**
*
* 그리드 Footer Show/Hide
*
* @date 2023. 07. 21.
* @memberOf rpt
* @author 김태호
* @return show/hide
* @ex 
* rpt.setGridFooterRowDisplay("footer_rowId","show"); //footer 보임 
* rpt.setGridFooterRowDisplay("footer_rowId","hide"); //footer 숨김
*/
rpt.setGridFooterRowDisplay = function(footerRowId, flag) {
	
	var setRowId = document.getElementById(footerRowId);
	var dispalyValue = "";
	
	if(flag == "show"){dispalyValue = "contents";}
	else if(flag == "hide"){dispalyValue = "none";}
	
	setRowId.style.display = dispalyValue;
};

/**
*
* 날짜 포맷(yyyymmdd)
*
* @date 2023. 07. 21.
* @memberOf rpt
* @author 김태호
* @return 날짜
*/
rpt.setDateFormat = function(dateStr) {
	var dateStr = dateStr.trim();
	
	if(dateStr.length == 8) {
		dateStr = dateStr.substring(0,4) + "-" + dateStr.substring(4,6) + "-" + dateStr.substring(6,8);
	} else if(dateStr.length == 14) {
		dateStr = dateStr.substring(0,4) + "-" + dateStr.substring(4,6) + "-" + dateStr.substring(6,8);
	}
	
	return dateStr;
};


/**
*
* 날짜형식 체크
*
* @date 2023. 07. 25.
* @memberOf rpt
* @author 박용준
* @return 날짜
*/
rpt.isValidDate = function (param) {
    try {
        param = param.replace(/-/g,'');

        // 자리수가 맞지않을때
        if( isNaN(param) || param.length != 8 ) {
            return false;
        }

        var year = Number(param.substring(0, 4));
        var month = Number(param.substring(4, 6));
        var day = Number(param.substring(6, 8));

        var dd = day / 0;


        if( month < 1 || month > 12 ) {
            return false;
        }

        var maxDaysInMonth = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];
        var maxDay = maxDaysInMonth[month - 1];

        // 윤년 체크
        if( month == 2 && ( year % 4 == 0 && year % 100 != 0 || year % 400 == 0 ) ) {
            maxDay = 29;
        }

        if( day <= 0 || day > maxDay ) {
            return false;
        }
        return true;

    } catch (err) {
        return false;
    }
}



//클립리포트 팝업창 호출 (공통)
rpt.clipReportPopUp = function(clipId, popupName, jsonNm, paramStr, newGbn, popupHeight, popupWidth, filePath) {

	rpt.reportView("pop",clipId, jsonNm, paramStr, "", newGbn, "","", filePath);
	
	if(com.isEmpty(popupHeight)) popupHeight = "1024";
	//if (com.isEmpty(popupWidth)) popupWidth = "950";
	if (com.isEmpty(popupWidth)) popupWidth = "1200";
	
	var popOps = { 
		    //url:"/ui/tom/sfi/sfi/xml/SFI100402P01.xml"
			url:"/uicom/common/ReportView_popup.xml"
		    ,width:popupWidth
			,height:popupHeight
		    ,useHeader:true
		    ,type:"browser"
		    ,modal:false
		    ,popup_name:popupName
		    ,callbackFn:"scsObj.popCallBack"
		};
	 
	return popOps;
};

//클립리포트 iframe화면 호출 (공통)
rpt.clipReportView = function(clipId,jsonNm, paramStr,ifmClRpt, newGbn,filePath) {	
	
	rpt.reportView("ifr",clipId, jsonNm, paramStr,ifmClRpt, newGbn, "","", filePath);
};


//클립리포트 iframe화면 호출 (보고서 일괄 출력)
rpt.clipReportTotalView = function(clipId,jsonNm, paramStr,ifmClRpt, newGbn, clipIdArray, doubleSidePrtChk, filePath) {	
	
	rpt.reportView("ifr",clipId, jsonNm, paramStr,ifmClRpt, newGbn,clipIdArray, doubleSidePrtChk, filePath);
};



//클립리포트 결재용 iframe화면 호출 (공통)
rpt.clipReportAppView = function(clipId,jsonNm, paramStr,ifmClRpt, newGbn, filePath) {	
	
	rpt.reportView("app_ifr",clipId, jsonNm, paramStr,ifmClRpt, newGbn, "","", filePath);
};


//클립리포트 공통 처리 함수
rpt.reportView = function(gubun,clipId,jsonNm, paramStr,ifmClRpt, newGbn , clipIdArray, doubleSidePrtChk ,filePath){
	if (typeof newGbn == 'undefined') newGbn = false;
	if (typeof clipIdArray == 'undefined') clipIdArray = "";
	if (typeof doubleSidePrtChk == 'undefined') doubleSidePrtChk = "";
	if (typeof filePath == 'undefined') filePath = "";
	
	var sigumgoC = rpt.getSigumgoC();
	var userGubun = rpt.getUserGubun();
	
	var vertical = verticalReport.indexOf(clipId) > -1 ? "vertical" : "horizon";
  	if(vertical != "vertical") {
  		vertical = verticalReport2.indexOf(clipId) > -1 ? "vertical2" : "horizon";
  	}
	var nobarcode = nobarcodeReport.indexOf(clipId) > -1 ? "Y" : "N";
	
	debugger;
  	if(sigumgoC != "28"){
  		nobarcode = "Y";
  	}

	var btnUse = "YYYYY";
	var reportInfo = {};
	
	reportInfo.BTN_USE = btnUse;
	reportInfo.PG_SIZE = "2";							// defaultRatio: 0:50%, 1:75%, 2:100%, 3:125%, ...(2020.08.24 ??????)
	reportInfo.MOD_ID = "rpt";
	reportInfo.CLIP_ID = clipId;
	reportInfo.DB_NAME = "ictcon";
	reportInfo.LOGIN_USER_NM = gcm.LOGIN.USER_NM;		//로그인 사용자명
	reportInfo.LOGIN_ORG_CD = gcm.LOGIN.PADM_STD_ORG_C;	//로그인 기관코드
	reportInfo.LOGIN_ORG_NM = gcm.LOGIN.ORG_NM;			//로그인 기관명
	reportInfo.LOGIN_DEPT_CD = gcm.LOGIN.SL_GMGO_DEPT_C;//로그인 부서 코드(공무원)
	reportInfo.LOGIN_DEPT_NM = gcm.LOGIN.DEPT_NM;		//로그인 부서명(공무원)
	reportInfo.LOGIN_BR_C = gcm.LOGIN.BR_C;				//로그인 영업점번호(은행직원)
	reportInfo.LOGIN_BR_NM = gcm.LOGIN.BR_NM;			//로그인 영업점명(은행직원)
	reportInfo.CMD = jsonNm;
	reportInfo.SEAL_SRC = filePath;
	reportInfo.VERTICAL = vertical;
	reportInfo.NOBARCODE = nobarcode;
	
	//reportInfo.UPLOAD_YN = uploadYn;
	//reportInfo.UPLOAD_BASE_FILE_NM = uploadBaseFileNm;
	//reportInfo.UPLOAD_SIGN_FILE_NM = uploadSignFileNm;
	
	if(userGubun == "BANK"){
		reportInfo.PARAM0 = gcm.LOGIN.BR_NM;
	}
	
	//리포트 전달 동적 file .cfr
	var crfSpVal = clipIdArray.split(",");
	var crfName = "CLIP_ID_ARR";
	
	if(clipIdArray == "") {
		reportInfo.CLIP_ID_LENGTH = "0";
	}else{
		reportInfo.CLIP_ID_LENGTH = crfSpVal.length;
		reportInfo.NOBARCODE = "Y";
	}
	
	for(var k=1; k<= crfSpVal.length; k++){
		crfName = "CLIP_ID_ARR";
		crfName = crfName+k;
		reportInfo[crfName] = crfSpVal[k-1];
	}
	
	//리포트 전달 동적 파라미터 생성 및 값 설정
	var spVal = paramStr.split(",");
	var paramName = "PARAM";
	
	for(var i=1; i<= spVal.length; i++) {		
		paramName = "PARAM";
		paramName = paramName+i;
		reportInfo[paramName] = spVal[i-1];		
		
		if (spVal[i-1].indexOf("#") > -1) {
			delete reportInfo[paramName]; 
			
			fieldInfo = spVal[i-1].split("#");
			
			reportInfo[fieldInfo[0]] = fieldInfo[1];
		}
	}	
	
	// 일괄출력 구분 코드 세팅 - 보고서 일괄출력에서 사용
	if("Y" == doubleSidePrtChk) {	//양면인쇄일 경우
		reportInfo["ISBUNDLE"] = "O";
	} else if ("N" == doubleSidePrtChk) {
		reportInfo["ISBUNDLE"] = "Y";
	} else {
		reportInfo["ISBUNDLE"] = "";
	}
	
	var locGovCd = reportInfo.LOGIN_ORG_CD;
	var locGovNm = reportInfo.LOGIN_ORG_NM;
	var deptCd = reportInfo.LOGIN_DEPT_CD;
	var deptNm = reportInfo.LOGIN_DEPT_NM;
	var brCd = reportInfo.LOGIN_BR_C;
	var brNm = reportInfo.LOGIN_BR_NM;
	
	var gunguCd = "";
	
	if(sigumgoC == "28"){		
		if(locGovNm != null && locGovNm != "") locGovNm = locGovNm.replace("인천", "").replace("광역시", "").trim();
		if(deptNm != null && deptNm != null) deptNm = deptNm.replace("인천", "").trim();
		
		// 직인에 들어갈 금고명 setting
		// 영업점이면서 구청지점일 경우
		if("BANK"== userGubun && (deptNm.indexOf("구청") >= 0 || deptNm.indexOf("강화") >= 0)) {
			deptNm = deptNm.replace("청","");
			
			if(deptNm.indexOf("강화") >= 0) {
				SEAL_VALUE = "인천광역시 " + deptNm + "군" + "금고";
			} else {
				SEAL_VALUE = "인천광역시 " + deptNm + "금고";
			}
			
			reportInfo.SEAL_SIGN =  SEAL_VALUE;
			
			
		// 공무원이면서 인천시청 직원이 아닌 경우
		} else if("SIGU" == userGubun && locGovNm != "시청") {
			SEAL_VALUE = "인천광역시 " + locGovNm + "금고";
			reportInfo.SEAL_SIGN =  SEAL_VALUE;
		} else {
			SEAL_VALUE = "인천광역시금고";
			reportInfo.SEAL_SIGN =  SEAL_VALUE;
		}
	}
	
	
	/*
	//AS-IS
	//인천시청
	if(sigumgoC == "28"){
		if(locGovNm != null && locGovNm != "") locGovNm = locGovNm.replace("인천", "").replace("광역시", "").trim();
		if(deptNm != null && deptNm != null) deptNm = deptNm.replace("인천", "").trim();
		
		// 직인에 들어갈 금고명 setting
		// 영업점이면서 구청지점일 경우
		if("BANK"== userGubun && (deptNm.indexOf("구청") >= 0 || deptNm.indexOf("강화") >= 0)) {
			deptNm = deptNm.replace("청","");
			
			if(deptNm.indexOf("강화") >= 0) {
				SEAL_VALUE = "인천광역시 " + deptNm + "군" + "금고";
			} else {
				SEAL_VALUE = "인천광역시 " + deptNm + "금고";
			}
			
			reportInfo.SEAL_SIGN =  SEAL_VALUE;
			
			if("7131" == brCd) gunguCd = "100";
			else if("7132" == brCd) gunguCd = "110";
			else if("7172" == brCd) gunguCd = "140";
			else if("7128" == brCd) gunguCd = "170";
			else if("7168" == brCd) gunguCd = "185";
			else if("7169" == brCd) gunguCd = "200";
			else if("7130" == brCd) gunguCd = "237";
			else if("1770" == brCd) gunguCd = "245";
			else if("7129" == brCd) gunguCd = "260";
			else if("1795" == brCd) gunguCd = "710";
			
		// 공무원이면서 인천시청 직원이 아닌 경우
		} else if("SIGU" == userGubun && locGovNm != "시청") {
			SEAL_VALUE = "인천광역시 " + locGovNm + "금고";
			reportInfo.SEAL_SIGN =  SEAL_VALUE;
		} else {
			SEAL_VALUE = "인천광역시금고";
			reportInfo.SEAL_SIGN =  SEAL_VALUE;
			gunguCd = "000";
		}
		
		if(gunguCd == "") gunguCd = "000";
		
		reportInfo.SEAL_SRC = "/shbweb/tomapp/rpt/img/seal/"+sigumgoC+"_"+gunguCd+".png";
	
	//충청북도	
	}else if(sigumgoC == "43"){
		gunguCd = "000";
		reportInfo.SEAL_SRC = "/shbweb/tomapp/rpt/img/seal/"+sigumgoC+"_"+gunguCd+".png";
	
	//경기도	
	}else if(sigumgoC == "41"){
		gunguCd = "000";
		reportInfo.SEAL_SRC = "/shbweb/tomapp/rpt/img/seal/"+sigumgoC+"_"+gunguCd+".png";
	
	//춘천시	
	}else if(sigumgoC == "110"){
		gunguCd = "000";
		reportInfo.SEAL_SRC = "/shbweb/tomapp/rpt/img/seal/"+sigumgoC+"_"+gunguCd+".png";
	}
	*/
	
	
	reportInfo.IC_CONN_ACCT = "전체";
	
	//출력 시간 설정
	var today = new Date();
	var year = today.getFullYear();
	var month = today.getMonth()+1;
	if(month < 10){month = "0"+month;}
	var day = today.getDate();
	if(day < 10){day = "0"+day;}
	var dateString = year+"-"+month+"-"+day;
	
	
	var hours = today.getHours()+1;
	if(hours < 10){hours = "0"+hours;}
	var minutes = today.getMinutes()+1;
	if(minutes < 10){minutes = "0"+minutes;}
	var seconds = today.getSeconds()+1;
	if(seconds < 10){seconds = "0"+seconds;}
	var timeString = hours+":"+minutes+":"+seconds;
	
	reportInfo.PRINT_DATE = "출력일시 : " +dateString+" "+timeString;
	reportInfo.PRINT_MAN = "출력자 : " + gcm.LOGIN.USER_NM + "(아이디 : " + gcm.LOGIN.USER_ID +  ")";
	
	
	com.setSessionData("reportInfo",JSON.stringify(reportInfo));
	
	
	if(gubun == "pop"){
		
		
	}else{
		//ifmClRpt.setSrc("/ui/tom/sfi/sfi/xml/SFI100402P01.xml");
		ifmClRpt.setSrc("/uicom/common/ReportView_popup.xml");
		
		// 리포트 높이 조절
		rpt.ifmReSizeHeight(ifmClRpt);
	}
};



//iframe (클립 리포트 height 수정 )
rpt.ifmReSizeHeight = function(ifmObj) {
	
	// height 자동설정 제외인 경우 height를 변경하지 않는다.(2019-04-18 설성윤) 
	if (ifmObj.hasClass("noResizeHeight") == true){ return;}
	else if (ifmObj.hasClass("popResizeHeight") == true) {
		ifmObj.setStyle("height", "470px");
		ifmObj.setStyle("margin-top","30px");
	}else{
		var ifmHeight = window.innerHeight - ifmObj.getAbsolutePosition("top") - 52;
		ifmObj.setStyle("height", ifmHeight+"px");
	}
};



//ReportJson 데이터를 String으로 변환
//reportCmd : 리포트 반복 노드명
//dCollection : DataCollection ID
//String 형태 반환
rpt.setReportJsonToString = function(reportCmd, reportJson) {
	
	var reportList = {};
    reportList[reportCmd] = reportJson;//DataCollection의 모든 데이터를 JSON으로 가져옴
    var result = JSON.stringify(reportList);//String 변환
    
    return result;
};


/**
 * 메뉴정보중 레벨별 메뉴명 제공
 *
 * @date 2023.08.08.
 * @memberOf rpt
 * @author 김태호
 * @return 메뉴명
 * @example rpt.getMenuNm
 */
rpt.getMenuLvNm = function(inMenuId) {
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
    return scrinfo;
};



var setGridHeight={
	mainW:$(window).innerWidth(),
	mainH:$(window).innerHeight(),
	init:function(p){
		
		setGridHeight.resizeHandler(); // Resize
		$(window).on('resize',function(){
			setGridHeight.resizeHandler();
		});
	},

	resizeHandler:function(){
		setGridHeight.mainW=$(window).innerWidth();
		setGridHeight.mainH=$(window).innerHeight();
		var firstGridScroll=$('.grid-scroll');
		
		if($('.grid-scroll2').length){
			
			var gridScroll=$('.grid-scroll2');
			for(var a=0;a<$('.grid-scroll2').length;a++){
				var gridTop=firstGridScroll.eq(a).offset().top;
				var calcNum=Math.floor(setGridHeight.mainH-gridTop-40);
				
				gridScroll.eq(a).css('height',calcNum);
			}
		}
		
		if($('.grid-scroll3').length){
			var gridScroll=$('.grid-scroll3');
			for(var a=0;a<$('.grid-scroll3').length;a++){
				var gridTop=firstGridScroll.eq(a).offset().top;
				var calcNum=Math.floor(setGridHeight.mainH-gridTop-40);
				gridScroll.eq(a).css('height',calcNum);
			}
		}
		
		if($('.grid-scroll4').length){
			var gridScroll=$('.grid-scroll4');
			for(var a=0;a<$('.grid-scroll4').length;a++){
				var gridTop=firstGridScroll.eq(a).offset().top;
				var calcNum=Math.floor(setGridHeight.mainH-gridTop-40);
				gridScroll.eq(a).css('height',calcNum);
			}
		}
		
		if($('.grid-scroll5').length){
			var gridScroll=$('.grid-scroll5');
			for(var a=0;a<$('.grid-scroll5').length;a++){
				var gridTop=firstGridScroll.eq(a).offset().top;
				var calcNum=Math.floor(setGridHeight.mainH-gridTop-40);
				gridScroll.eq(a).css('height',calcNum);
			}
		}
		
		if($('.grid-scroll-footer').length){
			var gridScroll=$('.grid-scroll-footer');
			for(var a=0;a<$('.grid-scroll-footer').length;a++){
				var gridTop=gridScroll.eq(a).offset().top;
				var calcNum=Math.floor(setGridHeight.mainH-gridTop);
				gridScroll.eq(a).css('height',calcNum);
			}
			
		
		}
		
		if($('.grid-scroll-app').length){
			var gridScroll=$('.grid-scroll-app');
			for(var a=0;a<$('.grid-scroll-app').length;a++){
				var gridTop=gridScroll.eq(a).offset().top;
				var calcNum=Math.floor(setGridHeight.mainH-gridTop-50);
				gridScroll.eq(a).css('height',calcNum);
			}
		}
	}
};


//현재일자 시분초
rpt.getSysDateTime = function(){
	var now = new Date();
	var dateTime = now.getFullYear() + rpt.padZero(now.getMonth() + 1) + rpt.padZero(now.getDate()) + rpt.padZero(now.getHours()) + rpt.padZero(now.getMinutes()) + rpt.padZero(now.getSeconds());
	
	return dateTime;
};


rpt.padZero = function(num){
	
	return (num < 10 ? "0":"") + num;
};




/**
 * 파일다운로드 호출
 * @param {String} grp 유형-필수
 * @param {String} fileNm 파일명-필수
 * @param {String} orgFileNm 파일명(원본파일명)
 * @date 2023. 08. 23.
 * @memberOf rpt
 * @author 김태호
*/
rpt.fileDownload = function(grp, fileNm, orgFileNm) {
    if(com.isEmpty(fileNm) || com.isEmpty(grp)){
    	alert("필수정보가 없습니다.");
        return false;
    }
    var $form = $("<form></form>");
   	$form.attr("action", "/jsp/FileDownload.jsp");
   	
    var $input = $("<input></input>");
    $input.attr({type:"hidden",  name:"grp",  id:"grp",  value:grp});
    $input.appendTo($form);
    debugger;
    $input = $("<input></input>");
    $input.attr({type:"hidden",  name:"fileNm",  id:"fileNm",  value:fileNm});
    $input.appendTo($form);
    
    if(!com.isEmpty(orgFileNm)) {
	    $input = $("<input></input>");
	    $input.attr({type:"hidden",  name:"orgFileNm",  id:"orgFileNm",  value:orgFileNm});
	    $input.appendTo($form);
    }

    $form.attr("method", "post");
    //$form.attr("enctype", "application/x-www-form-urlencoded");
    $form.attr("charset", "UTF-8");
    $form.attr("target", "_blank");
    $form.appendTo('body');
    
    $form.submit(); // 전송
};



/* Excel Download 조회조건 간편입력함수 */
rpt.searchText = function(title, obj1, type, obj2) {
	
	/* title	: 조회조건명
	 * obj1		: 조회조건 object 
	 * type		: object Type (sbx - select Box, ica - calendar)
	 * obj2		: 조회조건 object (from - to 달력에서 사용)
	 * */
	
	
	/* 조회 조건 입력 */
	var text = "";
	
	/* Select Box 또는 Radio */
	if(type == "sbx" || type == "rad" || type == "rdo") 
	{
		if(obj1.getValue() == "all" && (com.isEmpty(obj1.getText()) || obj1.getText() == "all")) 
			text = title + " : " + "전체";
		else 
			text = title + " : " + obj1.getText();
	} 
	
	/* Calendar */
	else if(type == "ica" || type == "cal") 
	{
		if(obj1.getValue().length == 0)
			text = title + " : " + "전체";
		/* From ~ To 달력 */
		else if(obj2 != null && obj2.getValue().length == 8)
			text = title + " : "+ obj1.getFormattedValue("yyyy-MM-dd") + " ~ " + obj2.getFormattedValue("yyyy-MM-dd");
		/* YYYY-MM-DD달력 */ 
		else if(obj1.getValue().length == 8) 
			text = title + " : "+ obj1.getFormattedValue("yyyy-MM-dd");
		/* From ~ To 달력 */
		else if(obj2 != null && obj2.getValue().length == 6)
			text = title + " : "+ obj1.getFormattedValue("yyyy-MM") + " ~ " + obj2.getFormattedValue("yyyy-MM");
		/* YYYY.MM 달력 */
		else if(obj1.getValue().length == 6) 
			text = title + " : "+ obj1.getFormattedValue("yyyy-MM");
		/* YYYY달력 */
		else if(obj1.getValue().length == 4)
			text = title + " : "+ obj1.getFormattedValue("yyyy");
	}
	/* Checkbox */
	else if(type == "chk") 
	{
		if(obj1.getText() != "")
			text = title + " : " + obj1.getText();
		else if(obj1.getValue() == "all" || obj1.getValue() == "" || obj1.getValue() == "0") 
			text = title + " : " + "전체";
		else if(obj1.getValue() == "1")
			text = title + " : " + "Y";
		else 
			text = title + " : " + obj1.getValue();
		
	}
	/* UDC From ~ To Calendar */
	else if(type == "udc") 
	{		
        var tmp1 = $p.comp[obj1.id +"_"+ "ipt_cal1"];
        var tmp2 = $p.comp[obj1.id +"_"+ "ipt_cal2"];
        
        var dt1 = tmp1.getFormattedValue("yyyy-MM-dd");
        var dt2 = tmp2.getFormattedValue("yyyy-MM-dd");
		
		text = title + " : "+ dt1; 		//dt1.substr(0,4) + "-" + dt1.substr(4,2) + "-" + dt1.substr(6,2);
		text = text + " ~ " + dt2; 		//dt2.substr(0,4) + "-" + dt2.substr(4,2) + "-" + dt2.substr(6,2);
	}
	else 
	{
		if(obj1.getValue().length == 0)
			text = title + " : 전체";
		else
			text = title + " : " + obj1.getValue();
	}
	
	return text + "  ";

};


/* Excel Download 조회조건 간편입력함수 */
rpt.searchTextExcel = function(title, obj, col, type) {
	
	/* title	: 조회조건명
	 * obj		: In DataCollection  
	 * col		: column id
	 * type		: column type
	 * */
	
	
	/* 조회 조건 입력 */
	var text = "";
	
	/* Select Box */
	if(type == undefined || type == "") {
		text = title + " : " + obj.get(col);
	} 
	/* Calendar */
	else if(type == "cal") {
		if ( obj.get(col) == undefined || obj.get(col) == "" ) {
			text = title + " : " + "전체";
		} else {
			var dt = obj.get(col);
			if(dt.length == 8) {
				dt = dt.substr(0,4) + "-" + dt.substr(4,2) + "-" + dt.substr(6,2);
			} else if(dt.length == 6) {
				dt = dt.substr(0,4) + "-" + dt.substr(4,2) ;
			} else if(dt.length == 4) {
				dt = dt.substr(0,4) ;
			}
			text = title + " : " + dt;
		}
	}
	/* From ~ To Calendar */
	else if(type == "cal1" || type == "cal2") {		
		var dt = obj.get(col);
		if(dt.length == 8) {
			dt = dt.substr(0,4) + "-" + dt.substr(4,2) + "-" + dt.substr(6,2);
		}
		if(type == "cal1" ) {
			text = title + " : " + dt;
			if ( dt == "" ) {
				text = title + " : " + "전체";
			} else {
				text = title + " : " + dt + " ~" ;
			}
		} else {
			text = dt;
		}
	}
	
	return text + "  ";

};

rpt.createDataObj = function(type, id, columnArr) {
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


/* 공통코드 데이터 컬렉션 생성 ( 기관구분, 기관명, 부서명, 계좌번호)
 * 데이터 컬렉션이 늘어 나면 서브미션 수정이 필요 함.(각 화면마다 해야 함.)
 * 기관구분, 기관명, 부서명, 계좌
 * "SCommonComboR41",
 * 기관명, 부서명, 계좌
 * "SCommonComboR41",
 * 부서명, 계좌
 * "SSFI100403R01",
 * 계좌
 * "SSFI100404R01"
 *  */
rpt.comboList_createDataObj = function(page_p) {

	
	// 공금예금계좌 연동 In 컬렉션 생성 (기관구분, 기관명, 부서명, 계좌번호, 징수기관, 수납기관, 기관번호)
	com.createDataObj_page("dataMap", "MCommonComboR00In", [ 
		  "SIGUMGO_C"				//금고코드
		, "GOV_G"                     // 행정기관구분(all.전체, gov.행정기관, 900.서울물재생공단) 2020.12.18 설성윤
        , "ORG_G"                     // 기관구분코드
        , "ORG_C"                     // 기관코드
        , "DEPT_C"                    // 부서코드
        , "PADM_STD_ORG_C"            // 행정표준기관CODE
        , "ALL_ORGNM"                 // 전체기관명
        , "SGG_ACNO"                  // 계좌번호
        , "SIGUMGO_AC_NM"             // 계좌명
        , "HOIKYE_YEAR"               // 회계연도
        , "TXIO_G"                    // 계좌구분
        , "TXIO_G1"                   // 계좌구분1
        , "TXIO_G2"                   // 계좌구분2
        , "SITAX_GUTAX_G"             // 시구세구분
        , "SUNAPGIGWANID"             // 수납기관코드
        , "BANKGUBUN"                 // 은행카드구분코드
        , "JINGSU_ORG_C"              // 징수기관코드
        , "JINGSU_GUCHEONG"           // 징수기관 본청+상수도+사용자구청
        , "JINGSU_ORG_G"              // 징수기관상하수도구분
        , "HOIKYE_C"			      // 회계코드
        , "HOIKYE_NM"			      // 회계명
        , "DTL_HOIKYE_C"			  // 상세회계코드(2020.09.21 설성윤: HOIKYE_C 에서 변경)
        , "DTL_HOIKYE_L"              // 상세회계코드리스트(2021.02.17 설성윤: 환경개선부담금 화면에서 사용)
        , "OCR_HOIKYE_G"			  // 회계구분
        , "OCR_HOIKYE_G1"			  // 시작회계구분
        , "OCR_HOIKYE_G2"			  // 종료회계구분
        , "AGE_AC_G"				  // (신)대행계좌구분(변수명을 AC_G에서 AGE_AC_G로 변경: 2020.05.25 설성윤)
        , "AGE_AC_G2"				  // (신)대행계좌구분(변수명을 AC_G에서 AGE_AC_G로 변경: 2020.05.25 설성윤)
        , "AC_G"				  	  // (구)대행계좌구분(모든 화면에서 (신)변수명으로 변경적용하면 정리 필요: 2020.05.25 설성윤)
        , "SIGUMGO_AC_B"			  // 시금고계좌분류
        , "SIGUMGO_AC_B_OUT"		  // 시금고계좌분류(세입제외)
        , "CHNGS_C"					  // 청소코드
        , "RPT_ID"					  // 보고서ID(2020.10.15 설성윤: 특정 보고서ID가 등록된 부서만 조회)
        , "RPT_AC_G"				  // 보고구분(2020.11.05 설성윤)
        , "RPT_GBN"					  // 보고서구분
        , "AC_SEARCH_G"               // 계좌조회구분 (2020.11.10 설성윤, all:전체계좌, R:보고서등록계좌, I:이자입금계좌)
        , "APRV_BRNO"			      // 보고영업점번호(2020.11.10 설성윤)
        , "END_NUM"                    // 마지막 행
        , "START_NUM"                  // 시작 행       
        , "BIZNO"                     // 사업자번호-카드
        , "ACNO"                      // 계좌번호
        , "KJAC_NO"                   // 2020.04.24 설성윤: 결제계좌번호
        , "CDPAY_G"                   // 2020.04.24 설성윤: 카드페이 구분(1.카드, 2.제로페이)
        , "USER_ID"                   // 사용자ID-카드
        , "SEARCH_GB"                 // 조회구분
        , "TOT_G"                     // 집계구분(1.일별, 2.주별, 3.월별)
        , "SL_JIBANG_G"               // 서울,지방 구분(A.서울, C.지방 )
        , "REF_M_C"                   //AS-IS 공통메인코드
        , "REF_S_C"                   //AS-IS 공통상세세부코드
        , "GU_TGYEJWANO"              //구 계좌번호
        
        //인천외 지역
        , "GEUMGO_CD"                 // 금고코드
        , "HOIGYE_YEAR"               // 회계년도
        , "GUNGU_CD"                  // 군구코드
        , "GYEJWA_CD"                 // 계좌코드
        , "GYEJWA_NM"                 // 계좌명
        , "BRNO"                 	  // 영업점번호
        , "HOIGYE_CODE"               // 회계코드
        
        
        ],page_p);
	page_p.getFrame().getObj("MCommonComboR00In").reset();
	
    //OutList 컬렉션 생성
	
	
	
	//호출 명 : ORG_G 
	com.createDataObj_page("dataList", "MCommonComboR51OutList", [ 
          "ORG_G"                       // 기관구분코드
        , "ORG_G_NM"                    // 기관구분명
        , "CT_GU_C"                     // 시구CODE
        , "CT_GUSANG_TAX_C"             // 시구상세CODE
        , "CHNGS_C"                     // 청소코드
        ],page_p);
	page_p.getFrame().getObj("MCommonComboR51OutList").reset();
	
	
	//호출 명 : ORG_C
	com.createDataObj_page("dataList", "MCommonComboR41OutList", [ 
          "ORG_C"                     // 기관코드
        , "ORG_C_NM"                  // 기관명
        , "CT_GU_C"                   // 시구CODE
        , "CT_GUSANG_TAX_C"           // 시구상세CODE
        , "OCR_C"                     // OCR코드
        , "CHNGS_C"                   // 청소코드
        , "REP_ORG_C"                 // 기관구분
        , "OBNK_TBNK_YN"              // 금고은행(1.신한, 2.우리, 3.국민)
        , "SITAX_GUTAX_G"             // 시구세구분
        ],page_p);
	page_p.getFrame().getObj("MCommonComboR41OutList").reset();
	
	//호출 명 : DEPT_C 부서코드
	com.createDataObj_page("dataList", "MCommonComboR47OutList", [ 
        "ORG_C"                     // 기관코드
        , "ORG_C_NM"                  // 기관명
        , "DEPT_C"                    // 부서코드
        , "DEPT_C_NM"                 // 부서명
        , "ALL_ORGNM"                 // 전체부서명
        , "MG_DT"                     // 부서폐쇄일
        ],page_p);
	page_p.getFrame().getObj("MCommonComboR47OutList").reset();
	
	
	//호출 명 : GOV_G 
	com.createDataObj_page("dataList", "MCommonComboR04OutList", [ 
          "SEQ"                     // 군구코드(3자리)
        , "SMPL_CD"                 // 군구코드
        , "SMPL_CD_TYPE_NM"         // 군구명
        , "SORT_SNO"             	// 정렬번호
        ],page_p);
	page_p.getFrame().getObj("MCommonComboR04OutList").reset();
	
	
	//호출 명 : GOV_G_09 
	com.createDataObj_page("dataList", "MCommonComboR09OutList", [ 
          "SMPL_CD"                  // 군구코드
        , "SMPL_CD2"                 // 군구코드(3자리)
        , "SMPL_CD_TYPE_NM"         // 군구명(+코드)
        , "SMPL_CD_TYPE_NM2"         // 군구명
        ],page_p);
	page_p.getFrame().getObj("MCommonComboR09OutList").reset();
	
	
	//호출 명 : SGG_ACNO 계좌번호
	com.createDataObj_page("dataList", "MCommonComboR49OutList", [ 
          "SGG_ACNO"                  // 계좌번호
        , "SGG_ACNO_NM"               // 계좌명
        , "SGG_ACNO_VIEW"             // 계좌번호명
        , "SIGUMGO_AC_NM"             // 계좌명(계좌번호 제외)
        , "GU_TGYEJWANO"              // (구)계좌번호
        , "HOIKYE_C"                  // 회계번호
        , "HOIKYE_NM"                 // 회계명
        , "AC_G"                      // 세입세출구분
        , "AGE_AC_G"                  // 대행계좌구분
        , "ORG_C"                     // 기관코드
        , "ORG_C_NM"                  // 기관명
        ],page_p);
	page_p.getFrame().getObj("MCommonComboR49OutList").reset();
	
	
	//호출 명 : SGG_ACNO_05 계좌번호
	com.createDataObj_page("dataList", "MCommonComboR05OutList", [ 
          "CODE"                 // 계좌번호
        , "NAME"                // 계좌명
        , "SIGUMGO_HOIKYE_C"    // 계좌번호명
        ],page_p);
	page_p.getFrame().getObj("MCommonComboR05OutList").reset();
	
	
	
	//호출 명 : HOIKYE_C 회계코드
	com.createDataObj_page("dataList", "MCommonComboR10OutList", [ 
          "HOIKYE_C"                    // 회계코드
        , "HOIKYE_NM"                 	// 회계명
        , "HOIKYE_VIEW"					// 회계코드 + 회계명
        , "SMPL_CD"
        , "SMPL_CD_TYPE_NM"
        , "SMPL_CD_TYPE_NM2"
        ],page_p);
	page_p.getFrame().getObj("MCommonComboR10OutList").reset();
	
	
	//호출 명 : APRV_BRNO (전자보고서 등록된 보고영업점)
	com.createDataObj_page("dataList", "MCommonComboR56OutList", [ 
	      "BRNO"                        // 영업점번호
        , "BRNM"                 		// 영업점명
        , "ORG_G"                       // 기관구분코드
        , "ORG_C"                       // 기관코드
        , "DEPT_C"                    	// 부서코드
        , "SITAX_GUTAX_G"             	// 시구세구분
        ],page_p);
	page_p.getFrame().getObj("MCommonComboR56OutList").reset();
	
	//호출 명 : ORG_G_BONGU 
	com.createDataObj_page("dataList", "MCommonComboR59OutList", [ 
          "ORG_C"                       // 기관구분코드
        , "ORG_C_NM"                    // 기관구분명
        , "CT_GU_C"                     // 시구CODE
        , "CT_GUSANG_TAX_C"             // 시구상세CODE
        , "CHNGS_C"                     // 청소코드
        ],page_p);
	page_p.getFrame().getObj("MCommonComboR59OutList").reset();
	
	
    //초기값 지정    
    var _dma = page_p.getFrame().getObj("MCommonComboR00In");
    _dma.set("TXIO_G",'all');
    _dma.set("SITAX_GUTAX_G",'all');
    _dma.set("AC_SEARCH_G",'all');
    _dma.set("SUNP_ORG_C", 'all');
    _dma.set("BANKGUBUN", "all");
    _dma.set("AGE_AC_G", "-1");
    _dma.set("AGE_AC_G2", "-1");
    _dma.set("APRV_BRNO", "-1");
    _dma.set("SIGUMGO_AC_B", "-1");
    _dma.set("SIGUMGO_AC_B_OUT", "-1");
    _dma.reform();
};
 
/**
 * svc_id 조회
 */
rpt.svcIdSearch = function (initlCNm){
	
	var svc_id = "";
	if(initlCNm == "ORG_G"){//기관구분
		svc_id = "SCommonComboR51";
	}else if(initlCNm == "ORG_C"){//기관명
		svc_id = "SCommonComboR41";
	}else if(initlCNm == "DEPT_C"){//부서
		svc_id = "SCommonComboR47";	
	}else if(initlCNm == "GOV_G"){//군구(TO-BE 군구+사업소)
		svc_id = "SCommonComboR04";		
	}else if(initlCNm == "GOV_G_09"){//군구(AS-IS GUNGU_CD_LIST)
		svc_id = "SCommonComboR09";	
	}else if(initlCNm == "SGG_ACNO"){//계좌번호
		svc_id = "SCommonComboR49";	
	}else if(initlCNm == "SGG_ACNO_05"){//계좌번호 (타지역)
		svc_id = "SCommonComboR05";	
	}else if(initlCNm == "HOIKYE_C"){//회계명
		svc_id = "SCommonComboR10";	
	}else if (initlCNm == "APRV_BRNO"){//보고영업점
		svc_id = "SCommonComboR56";
	}else if (initlCNm == "ORG_G_BONGU"){//인천 본청, 구청
		svc_id = "SCommonComboR59";
	}
	
	return svc_id;
};

/**
 * 페이지 필요한 데이터 호출
 * @date 2018.08.30
 * 
 * initlCNm 초기화 코드 명
 */
rpt.pageLoadSearch = function(initlCNm, dataIn, page_p) {

	//var msgId = (initlCNm == "ALL_DEPT_C") ? "MCTM010801R02In" : "MCommonComboR00In";
	var msgId = "MCommonComboR00In";
    var pageFrame = page_p.getFrame();
    var _dma = pageFrame.getObj(msgId);
    
    if ( dataIn != undefined) 
    { 
    	if ( dataIn.getKey("SIGUMGO_C") != null && dataIn.get("SIGUMGO_C") != "" ) {
			_dma.set("SIGUMGO_C", dataIn.get("SIGUMGO_C"));
		}
    	
    	if ( dataIn.getKey("REF_M_C") != null && dataIn.get("REF_M_C") != "" ) {
			_dma.set("REF_M_C", dataIn.get("REF_M_C"));
		}
    	
    	if ( dataIn.getKey("REF_S_C") != null && dataIn.get("REF_S_C") != "" ) {
			_dma.set("REF_S_C", dataIn.get("REF_S_C"));
		}
    	
    	if ( dataIn.getKey("SEARCH_GB") != null && dataIn.get("SEARCH_GB") != "" ) {
			_dma.set("SEARCH_GB", dataIn.get("SEARCH_GB"));
		}
    	
    	_dma.set("ORG_G", dataIn.get("ORG_G"));
    	_dma.set("ORG_C", dataIn.get("ORG_C"));
    	_dma.set("AC_SEARCH_G", dataIn.get("AC_SEARCH_G"));
    	_dma.set("DEPT_C", dataIn.get("DEPT_C"));
    	_dma.set("HOIKYE_YEAR", dataIn.get("HOIKYE_YEAR"));
		_dma.set("HOIKYE_C", dataIn.get("HOIKYE_C"));
		_dma.set("APRV_BRNO", dataIn.get("APRV_BRNO"));
		_dma.set("SIGUMGO_AC_B", dataIn.get("SIGUMGO_AC_B"));
		_dma.set("SIGUMGO_AC_B_OUT", dataIn.get("SIGUMGO_AC_B_OUT"));
		_dma.set("GOV_G", dataIn.get("GOV_G"));
		_dma.set("SIGUMGO_AC_NM", dataIn.get("SIGUMGO_AC_NM"));
		
		
		if ( dataIn.getKey("HOIKYE_NM") != null && dataIn.get("HOIKYE_NM") != "" ) {
			_dma.set("HOIKYE_NM", dataIn.get("HOIKYE_NM"));
		}else{
			_dma.set("HOIKYE_NM", 'all');
		}
		
		
		if ( dataIn.getKey("GU_TGYEJWANO") != null && dataIn.get("GU_TGYEJWANO") != "" ) {
			_dma.set("GU_TGYEJWANO", dataIn.get("GU_TGYEJWANO"));
		}else{
			_dma.set("GU_TGYEJWANO", 'all');
		}
		
		//인천외
		_dma.set("GEUMGO_CD", dataIn.get("GEUMGO_CD"));
		_dma.set("HOIGYE_YEAR", dataIn.get("HOIGYE_YEAR"));
		_dma.set("GUNGU_CD", dataIn.get("GUNGU_CD"));
		_dma.set("GYEJWA_CD", dataIn.get("GYEJWA_CD"));
		_dma.set("GYEJWA_NM", dataIn.get("GYEJWA_NM"));
		_dma.set("BRNO", dataIn.get("BRNO"));
		_dma.set("HOIGYE_CODE", dataIn.get("HOIGYE_CODE"));
		
				
		if (initlCNm == "DEPT_C") 
		{
			_dma.set("FROM_NUM", "0");
			_dma.set("TO_NUM", "2000");
		}
    }
    
    
	
	/*
	 * 미리 정의되어 있는 서비스 ID를 추출한다.
	 */
	var svcNm= rpt.svcIdSearch(initlCNm);
	
	// 처음 초기화 위한 서브미션 
	if (svcNm != undefined && svcNm != ""){
		rpt.dySubmission (page_p, svcNm, msgId, initlCNm);
	}
	
	dataIn.setJSON(_dma);

};


/**
 * 데이터 변경시 콤보박스 데이터를 다시 추출한다.
 */
rpt.dataChangeSearch = function(initlCNm, dataIn, page_p){
	
	//var msgId = (initlCNm == "ALL_DEPT_C") ? "MCTM010801R02In" : "MCommonComboR00In";
	var msgId = "MCommonComboR00In";
    var _dma = page_p.getFrame().getObj(msgId);
    
    let orgGList = page_p.getFrame().getObj("MCommonComboR51OutList");//기관구분
    let orgCList = page_p.getFrame().getObj("MCommonComboR41OutList");//기관명
    let gunC = "";
    let _sbx_GunC = page_p.getFrame().getObj('sbx_GunC');
    
    

    /*
    if(initlCNm == "SGG_ACNO"){
		var _dmaList = page_p.getFrame().getObj("MSFI100404R01OutList");
		if(_dmaList != null && _dmaList != ''){ //계좌 존재시
			_dmaList.reset();
			dataIn.set("SGG_ACNO", "");
		}
	}
	*/
    
    if ( dataIn != undefined) 
    { 
    	if ( dataIn.getKey("SIGUMGO_C") != null && dataIn.get("SIGUMGO_C") != "" ) {
			_dma.set("SIGUMGO_C", dataIn.get("SIGUMGO_C"));
		}
    	
    	if ( dataIn.getKey("REF_M_C") != null && dataIn.get("REF_M_C") != "" ) {
			_dma.set("REF_M_C", dataIn.get("REF_M_C"));
		}
    	
    	if ( dataIn.getKey("REF_S_C") != null && dataIn.get("REF_S_C") != "" ) {
			_dma.set("REF_S_C", dataIn.get("REF_S_C"));
		}
    	
    	if ( dataIn.getKey("SEARCH_GB") != null && dataIn.get("SEARCH_GB") != "" ) {
			_dma.set("SEARCH_GB", dataIn.get("SEARCH_GB"));
		}
    	
    	
    	
    	if ( dataIn.getKey("ORG_G") != null && dataIn.get("ORG_G") != "" ){
			_dma.set("ORG_G", dataIn.get("ORG_G"));
			
			if(typeof orgGList != "undefined"){
				let tmpRsData = orgGList.getMatchedJSON("ORG_G", dataIn.get("ORG_G"));
				
				if(tmpRsData != "" && tmpRsData != null ){
					gunC = tmpRsData[0].CT_GU_C; //군구코드 자동 설정
				}
			}
		}else{
			_dma.set("ORG_G", "all");
		}
    	
    	
    	if ( dataIn.getKey("ORG_C") != null && dataIn.get("ORG_C") != "" ) {
    		/*
			if ( initlCNm == "ORG_G" || initlCNm == "ORG_C" || initlCNm == "ORG_C_BONGU") {
				_dma.set("ORG_C", "all");
			}else{
				_dma.set("ORG_C", dataIn.get("ORG_C"));
				
				if(typeof orgCList != "undefined"){
					let tmpRsData = orgCList.getMatchedJSON("ORG_C", dataIn.get("ORG_C"));
					
					if(tmpRsData != "" && tmpRsData != null ){
						gunC = tmpRsData[0].CT_GU_C;
					}
				}
			}
			*/
			_dma.set("ORG_C", dataIn.get("ORG_C"));
			
			if(typeof orgCList != "undefined"){
				let tmpRsData = orgCList.getMatchedJSON("ORG_C", dataIn.get("ORG_C"));
				
				if(tmpRsData != "" && tmpRsData != null ){
					gunC = tmpRsData[0].CT_GU_C;//군구코드 자동 설정
				}
			} 
			
		}else{
			_dma.set("ORG_C", "all");
		}
    	
		
		if(gunC != "" && gunC != null){
			
			/*
			if ( typeof _sbx_GunC != "undefined" && initlCNm != "SGG_ACNO" ){
				_sbx_GunC.setValue(gunC);
			}
			*/
			
			//화면에 군구명이 없을때 공통 GOV_G 에 설정한다.
			if ( typeof _sbx_GunC == "undefined"){
				_dma.set("GOV_G", gunC);
			}
			
		}else{
			// 행정기관구분(all.전체, gov.행정기관, 900.서울물재생공단) 2020.12.18 설성윤
			if ( dataIn.getKey("GOV_G") != null && dataIn.get("GOV_G") != "" ) {
				_dma.set("GOV_G", dataIn.get("GOV_G"));
			}else{
				_dma.set("GOV_G", "all");
			}
		}
		
				
		if ( dataIn.getKey("DEPT_C") != null && dataIn.get("DEPT_C") != "" ) {
			if (gcm.LOGIN.USER_RIGHT_G == '1' && dataIn.get("DEPT_C") == 'all'){
				_dma.set("DEPT_C", "");
			}else{
				_dma.set("DEPT_C", dataIn.get("DEPT_C"));
			}
		}else if (gcm.LOGIN.USER_RIGHT_G != '1'){
			_dma.set("DEPT_C", 'all');
		}else if (dataIn.get("DEPT_C") == undefined){
			_dma.set("DEPT_C", gcm.LOGIN.SL_GMGO_DEPT_C);
		}else{
			_dma.set("DEPT_C", "all");
		}
		
		if ( dataIn.getKey("PADM_STD_ORG_C") != null && dataIn.get("PADM_STD_ORG_C") != "" ) {
			if (gcm.LOGIN.USER_RIGHT_G == '1' && dataIn.get("PADM_STD_ORG_C") == 'all'){
				_dma.set("PADM_STD_ORG_C", "");
			}else{
				_dma.set("PADM_STD_ORG_C", dataIn.get("PADM_STD_ORG_C"));
			}
		}else if (gcm.LOGIN.USER_RIGHT_G != '1'){
			_dma.set("PADM_STD_ORG_C", 'all');
		}else if (dataIn.get("PADM_STD_ORG_C") == undefined){
			_dma.set("PADM_STD_ORG_C", gcm.LOGIN.SL_GMGO_DEPT_C);
		}
		
		// 공금계좌중 보고서등록계좌만 조회 및 보고영업점 보고대상 기관명, 부서명 조회(2020.11.10 설성윤) 
		if ( dataIn.getKey("RPT_ID") != null && dataIn.get("RPT_ID") != "" ) {
			_dma.set("RPT_ID", dataIn.get("RPT_ID"));
		}

		// 공금계좌중 보고서등록계좌만 조회 및 보고영업점 보고대상 기관명, 부서명 조회(2020.11.10 설성윤) 
		if ( dataIn.getKey("RPT_AC_G") != null && dataIn.get("RPT_AC_G") != "" ) {
			_dma.set("RPT_AC_G", dataIn.get("RPT_AC_G"));
		}
		
		// 공금계좌중 보고서등록계좌만 조회 및 보고영업점 보고대상 기관명, 부서명 조회(2020.11.10 설성윤) 
		if ( dataIn.getKey("APRV_BRNO") != null && dataIn.get("APRV_BRNO") != "" ) {
			_dma.set("APRV_BRNO", dataIn.get("APRV_BRNO"));
		}
		
		// 공금계좌중 특정계좌만 조회(R.보고서등록계좌, I.이자입금계좌)
		if ( dataIn.getKey("AC_SEARCH_G") != null && dataIn.get("AC_SEARCH_G") != "" ) {
			_dma.set("AC_SEARCH_G", dataIn.get("AC_SEARCH_G"));
		}
		
		
		_dma.set("HOIKYE_YEAR", dataIn.get("HOIKYE_YEAR"));
		_dma.set("HOIKYE_C", dataIn.get("HOIKYE_C"));
		_dma.set("APRV_BRNO", dataIn.get("APRV_BRNO"));
		_dma.set("AGE_AC_G", dataIn.get("AGE_AC_G"));
		_dma.set("AGE_AC_G2", dataIn.get("AGE_AC_G2"));
		_dma.set("SIGUMGO_AC_B", dataIn.get("SIGUMGO_AC_B"));
		_dma.set("SIGUMGO_AC_B_OUT", dataIn.get("SIGUMGO_AC_B_OUT"));
		_dma.set("SIGUMGO_AC_NM", dataIn.get("SIGUMGO_AC_NM"));
		
		if (initlCNm == "DEPT_C") 
		{
			_dma.set("START_NUM", "0");
			_dma.set("END_NUM", "2000");
		}
    	
		
		if ( dataIn.getKey("HOIKYE_NM") != null && dataIn.get("HOIKYE_NM") != "" ) {
			_dma.set("HOIKYE_NM", dataIn.get("HOIKYE_NM"));
		}else{
			_dma.set("HOIKYE_NM", 'all');
		}
		
		
		if ( dataIn.getKey("GU_TGYEJWANO") != null && dataIn.get("GU_TGYEJWANO") != "" ) {
			_dma.set("GU_TGYEJWANO", dataIn.get("GU_TGYEJWANO"));
		}else{
			_dma.set("GU_TGYEJWANO", 'all');
		}
		
		
		//인천외
		_dma.set("GEUMGO_CD", dataIn.get("GEUMGO_CD"));
		_dma.set("HOIGYE_YEAR", dataIn.get("HOIGYE_YEAR"));
		_dma.set("GUNGU_CD", dataIn.get("GUNGU_CD"));
		_dma.set("GYEJWA_CD", dataIn.get("GYEJWA_CD"));
		_dma.set("GYEJWA_NM", dataIn.get("GYEJWA_NM"));
		_dma.set("BRNO", dataIn.get("BRNO"));
		_dma.set("HOIGYE_CODE", dataIn.get("HOIGYE_CODE"));
		
		var svcNm = rpt.svcIdSearch(initlCNm);
		if (svcNm != undefined && svcNm!= "")
		{
			rpt.dySubmission (page_p, svcNm, msgId, initlCNm, dataIn);
		}
    }
};

/**
 * 동적으로 생성된 콤보박스의 내용을 추출한다.
 * 
 * parameter
 * 		page_p : 해당 function 동작시점에 websquare에서 관리하는 프로세스정보?? $w 와 다름.
 * 		svcNm : initlCNm 별 서비스 ID
 * 		msgId : MCommonComboR00In (입력 파라메터 정보 - rpt.comboList_createDataObj 에서 생성한 정보)
 * 		initlCNm : 대상항목(회계번호,기관명,부서..)
 * 		dataIn : 입력 데이터 Collection Map
 */
rpt.dySubmission = function(page_p, svcNm, msgId, initlCNm, dataIn){
	
    var sbmId = "rpt_selectbox_nm_List";
	var sbm_selectboxNmListOption = {
	    mode : "synchronous", 
	    id : sbmId,
	    ref : 'data:json,["'+msgId+'"]',
	    target : 'data:json,["MCommonComboR41OutList",'+
	    					'"MCommonComboR47OutList",'+ 	
	    					'"MCommonComboR04OutList",'+
	    					'"MCommonComboR09OutList",'+
	    					'"MCommonComboR05OutList",'+
	    					'"MCommonComboR51OutList",'+
	    					'"MCommonComboR10OutList",'+
	    					'"MCommonComboR56OutList",'+
	    					'"MCommonComboR49OutList",'+
	                        '"MCommonComboR59OutList"]',	                        
	    mediatype : "application/json" ,
	    userData1 : [{svc_id : svcNm, msg_id: msgId, sbm_id : sbmId}]
	};
	
	sbm_selectboxNmListOption.submitDoneHandler = function(e) {
		
		var _pageFrame = page_p.getFrame();
		var _sbx_OrgC = _pageFrame.getObj('sbx_OrgC');
		var _sbx_GunC = _pageFrame.getObj('sbx_GunC');
		var _sbx_AcctNo = _pageFrame.getObj('sbx_AcctNo');
	    var _btn_sggAcno = _pageFrame.getObj('btn_sggAcno');
	    var _AccNo_OutList = _pageFrame.getObj('MCommonComboR49OutList');
	    var _OrgC_OutList = _pageFrame.getObj('MCommonComboR41OutList');
	    var _scsObj = _pageFrame.getObj('scsObj');
	    
	    if(typeof _AccNo_OutList != "undefined")
		{
	    	if(typeof _sbx_AcctNo != "undefined"){
	  			if(_AccNo_OutList.getTotalRow() == 0){
	  				
	  				if(typeof _sbx_AcctNo != "undefined") _sbx_AcctNo.changeChooseOption("","없음");
	  				if(typeof _sbx_AcctNo != "undefined") _sbx_AcctNo.setDisabled(true);
	    			if(typeof _btn_sggAcno != "undefined") _btn_sggAcno.setDisabled(true);
	    			
	  			}else{
	  				
	  				if(typeof _scsObj.chooseOptionTxt != "undefined" ){
	  					_sbx_AcctNo.changeChooseOption("",_scsObj.chooseOptionTxt);
	  				}else{
	  					_sbx_AcctNo.changeChooseOption("","선택");
	  				}
	  				
	  				
	  				
	  				if(typeof _sbx_AcctNo != "undefined") _sbx_AcctNo.setDisabled(false);
	  				if(typeof _btn_sggAcno != "undefined") _btn_sggAcno.setDisabled(false);
	    			
	    			
	    			if(_AccNo_OutList.getTotalRow() > 0){
	    				
	    				if(_AccNo_OutList.getTotalRow() == 1){
	    					var sggAcno = _AccNo_OutList.getCellData(0, "SGG_ACNO");
		    				_sbx_AcctNo.setValue(sggAcno);
	    				}
	    			}
	    		}
			}
		}
	    
	    if(typeof _OrgC_OutList != "undefined")
		{
	    	if(typeof _scsObj.sbx_OrgC_SelectedYn != "undefined" ){
	    		if(_scsObj.sbx_OrgC_SelectedYn == "Y"){
	    			if(typeof _sbx_OrgC  != "undefined"){
	    				_sbx_OrgC.setSelectedIndex(1);
	    			}
	    		}
	    	}
		}
	    
		// 공무원 계정 군구코드 셋팅 관련 - 시점상 
		if(typeof _sbx_GunC != "undefined")
		{
			//if(rpt.getUserGubun() === "SIGU") {
				// 공무원일 경우 세션의 ASIS 기관코드 기본 셋팅
			//	_sbx_GunC.setValue( com.getCtGuC() );
			//}
		}
	    
	};
	gcm.IS_TR = true;
	
	rpt.executeSubmission_dynamic(sbm_selectboxNmListOption, page_p);        
	
};


//서브미션 동적 생성 실행
rpt.executeSubmission_dynamic = function(options, page_p, requestData, obj) {
	var submissionObj = page_p.getSubmission(options.id);
	
	if (submissionObj === null) 
	{
	 	page_p.createSubmission(options);
	    submissionObj = page_p.getSubmission(options.id);
	} 
	else 
	{
	 	page_p.deleteSubmission(options.id);
	 	page_p.createSubmission(options);
	    submissionObj = page_p.getSubmission(options.id);
	}
	
	page_p.executeSubmission(submissionObj, requestData, obj);
};

rpt.setGridReHeight= function(inch){
	
	if(inch == null || inch == ""){inch = -40;}
	
	var incH = Number(inch);
	var innerHeight = $(window).innerHeight();
    var offsetTop = $('.grid-group').eq(0).offset().top;
    var gridHeight = Math.floor(innerHeight - offsetTop + incH);
    
    $('.grid-group').css("height",gridHeight);
};


/**
 * 사용자 소속 및 권한한에 따른 onpageload 시 UI 초기 설정 공통함수
 * @date 2020.05.19 설성윤
 */
rpt.pageLoadInit = function(_$p, dataIn) {
    var _pageFrame = _$p.getFrame();
    var _ui_orgG_g = _pageFrame.getObj('ui_orgG_g');
    var _sbx_OrgG = _pageFrame.getObj('sbx_OrgG');
    var _sbx_OrgC = _pageFrame.getObj('sbx_OrgC');
    var _sbx_GunC = _pageFrame.getObj('sbx_GunC');
    var _sbx_DeptC = _pageFrame.getObj('sbx_DeptC');
    var _btn_OrgG = _pageFrame.getObj('btn_OrgG');
    var _btn_OrgC = _pageFrame.getObj('btn_OrgC');
    var _btn_DeptC = _pageFrame.getObj('btn_DeptC');
    var _sbx_Brno = _pageFrame.getObj('sbx_Brno');
     
    
    var userGubun = rpt.getUserGubun(); 
    
    if(typeof _sbx_OrgG != "undefined") {_sbx_OrgG.options.allOption = false;_sbx_OrgG.showChooseOption(true);_sbx_OrgG.changeChooseOption("", "전체");}
	if(typeof _sbx_OrgC != "undefined") {_sbx_OrgC.options.allOption = false;_sbx_OrgC.showChooseOption(true);_sbx_OrgC.changeChooseOption("", "전체");}
	if(typeof _sbx_DeptC != "undefined") {_sbx_DeptC.options.allOption = false;_sbx_DeptC.showChooseOption(true);_sbx_DeptC.changeChooseOption("", "전체");}
	if(typeof _sbx_Brno != "undefined") {_sbx_Brno.options.allOption = false;_sbx_Brno.showChooseOption(true);_sbx_Brno.changeChooseOption("", "전체");}
	
    
	// 공무원 사용자 : 각 서비스에서 사용자권한에 따라 소속 기관구분/기관명/부서명 데이터가 필터링 됨(2020.05.18 설성윤)
	if(userGubun == "SIGU")
	{
		// 사용자 권한
		switch (gcm.LOGIN.USER_RIGHT_G)
		{
			case '1' : // 1.소속부서 '전체' 조회조건 삭제
						if(typeof _sbx_DeptC != "undefined") {_sbx_DeptC.options.allOption = false;_sbx_DeptC.setDisabled(true);}
						if(typeof _sbx_OrgC != "undefined") {_sbx_OrgC.options.allOption = false;_sbx_OrgC.setDisabled(true);}
						if(typeof _sbx_OrgG != "undefined") {_sbx_OrgG.options.allOption = false;_sbx_OrgG.options.chooseOption = false;_sbx_OrgG.setDisabled(true);}
						if(typeof _btn_DeptC != "undefined") {_btn_DeptC.setDisabled(true);}
						if(typeof _btn_OrgC != "undefined") {_btn_OrgC.setDisabled(true);}
						if(typeof _btn_OrgG != "undefined") {_btn_OrgG.setDisabled(true);}
						if(typeof _sbx_GunC != "undefined") {_sbx_GunC.options.allOption = false;_sbx_GunC.setDisabled(true);}
						break;
						
			case '2' : // 2.소속기관 '전체' 조회조건 삭제
						if(typeof _sbx_OrgC != "undefined") {_sbx_OrgC.options.allOption = false;_sbx_OrgC.setDisabled(true);}
						if(typeof _sbx_OrgG != "undefined") {_sbx_OrgG.options.allOption = false;_sbx_OrgG.options.chooseOption = false;_sbx_OrgG.setDisabled(true);}
						if(typeof _btn_OrgC != "undefined") {_btn_OrgC.setDisabled(true);}
						if(typeof _btn_OrgG != "undefined") {_btn_OrgG.setDisabled(true);}
						if(typeof _sbx_GunC != "undefined") {_sbx_GunC.options.allOption = false;_sbx_GunC.setDisabled(true);}
						break;
						
			case '3' : // 3.소속기관 및 사업소
						if(typeof _sbx_OrgG != "undefined") {_sbx_OrgG.options.allOption = false;_sbx_OrgG.options.chooseOption = false;_sbx_OrgG.setDisabled(true);}
						if(typeof _btn_OrgG != "undefined") {_btn_OrgG.setDisabled(true);}
						break;
		}
		
		if(typeof _ui_orgG_g != "undefined") _ui_orgG_g.hide();			// 기관구분 UI HIDE
		if(typeof _sbx_Brno != "undefined") _sbx_Brno.setDisabled(true);	// 보고영업점번호 변경 불가
	}
};



/**
 * 사용자 소속 및 권한한에 따른 onpageload 시 UI 초기 설정 공통함수
 * @date 2020.06.19 설성윤
 */
rpt.pageLoadDefault = function(_$p) {
    var _pageFrame = _$p.getFrame();
    var _sbx_OrgG = _pageFrame.getObj('sbx_OrgG');
    var _sbx_OrgC = _pageFrame.getObj('sbx_OrgC');
    var _sbx_GunC = _pageFrame.getObj('sbx_GunC');
    var _sbx_DeptC = _pageFrame.getObj('sbx_DeptC');
    var _sbx_SitaxGuTaxG = _pageFrame.getObj('sbx_SitaxGutaxG');
    var _sbx_AcSearchG = _pageFrame.getObj('sbx_AcSearchG');
    
    
    var userGubun = rpt.getUserGubun();
    
    
    
    // 기관 사용자
    if(userGubun == "SIGU")
	{
    	if(gcm.LOGIN.ORG_G != ''          && typeof _sbx_OrgG  != "undefined") _sbx_OrgG.setValue(gcm.LOGIN.ORG_G);
		if(gcm.LOGIN.PADM_STD_ORG_C != '' && typeof _sbx_OrgC  != "undefined") _sbx_OrgC.setValue(gcm.LOGIN.PADM_STD_ORG_C);
		if(gcm.LOGIN.SL_GMGO_DEPT_C != '' && typeof _sbx_DeptC  != "undefined") _sbx_DeptC.setValue(gcm.LOGIN.SL_GMGO_DEPT_C);
		if(gcm.LOGIN.CT_GU_C != ''        && typeof _sbx_GunC  != "undefined") _sbx_GunC.setValue(gcm.LOGIN.CT_GU_C);
		
	}
    // 은행 사용자 중 담당기관이 있	`3는 경우 담당 기관으로 default 설정(2020.05.18 설성윤)
	else
	{
		if(typeof _sbx_AcSearchG == "undefined" || _sbx_AcSearchG.getValue() == 'all')
		{
			if(gcm.LOGIN.ORG_G != ''          && typeof _sbx_OrgG != "undefined") _sbx_OrgG.setValue(gcm.LOGIN.ORG_G);
			if(gcm.LOGIN.PADM_STD_ORG_C != '' && typeof _sbx_OrgC != "undefined") _sbx_OrgC.setValue(gcm.LOGIN.PADM_STD_ORG_C);
			if(gcm.LOGIN.CT_GU_C != ''        && typeof _sbx_GunC != "undefined") _sbx_GunC.setValue(gcm.LOGIN.CT_GU_C);
		}
	}

	// 소속기관기 본청 및 그 산하사업소 이거나 당행금고담당 기관이 아닌 경우 또는 소속영업점이 본청 및 그산하사업소 담당 영업점인 경우 1.시세 설정(2021.01.20 설성윤)
	if(typeof _sbx_SitaxGuTaxG != "undefined" && gcm.LOGIN.PADM_STD_ORG_C != '')
	{
		var _OrgC_OutList = _pageFrame.getObj('MCommonComboR41OutList'); 
		if(typeof _OrgC_OutList != "undefined")
		{
			var tmpData = com.getMatchedFirstJSON(_OrgC_OutList, "ORG_C", gcm.LOGIN.PADM_STD_ORG_C);
			if (tmpData != undefined) _sbx_SitaxGuTaxG.setValue(tmpData.SITAX_GUTAX_G);
			
			
		}
	}
	
	
};


//공통콤보 값 세팅
rpt.setComboValue = function(_$p) {
    var _pageFrame = _$p.getFrame();
    var _sbx_OrgC = _pageFrame.getObj('sbx_OrgC');
    var _sbx_GunC = _pageFrame.getObj('sbx_GunC');
    var _OrgC_OutList = _pageFrame.getObj('MCommonComboR41OutList');
    
    
    if(typeof _OrgC_OutList != "undefined")
	{
    	if(typeof _sbx_OrgC != "undefined"){
    		var tmpData = com.getMatchedFirstJSON(_OrgC_OutList, "ORG_C", _sbx_OrgC.getValue());
    		if (tmpData != undefined){
    			if (typeof _sbx_GunC != "undefined"){
    				//_sbx_GunC.setValue(tmpData.CT_GU_C);
    				//_sbx_GunC.setDisabled(true);
    			}
    		}
		}
    }
    
};




//************************
//데이터 0 으로 채우는 함수
//************************
rpt.fn_Lpad = function (str,maxlength)
{
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


//기관구분조회 팝업
rpt.orgG_popUp = function(callBackNm) {

	// 팝업 (윈도우 팝업 type:"window:레이어","browser:새창" 모달 :"modal:true" 모달리스:"modal:false")
	var popOps = { 
		url:"/ui/tom/rpt/etc/xml/RPT050401P06.xml"
		,width:"480"
		,height:"805"
		,useHeader:true
		,popup_name:"기관구분조회"
		,callbackFn:callBackNm
	};
	
	return popOps;
};

//기관명 팝업
rpt.orgGNm_popUp = function(callBackNm, orgNm, sigumgoC) {
	
	//팝업 파라메터 전달
	var param = {
		"orgNm":orgNm,
		"sigumgoC":sigumgoC
	};
	
	// 팝업 (윈도우 팝업 type:"window:레이어","browser:새창" 모달 :"modal:true" 모달리스:"modal:false")
	var popOps = { 
		url:"/ui/tom/rpt/etc/xml/RPT050401P04.xml"
		,width:"480"
		,height:"805"
		,useHeader:true
		,data:param
		,popup_name:"기관명조회"
		,callbackFn:callBackNm
	};
	
	return popOps;
};


//기관코드조회 팝업
rpt.orgC_popUp = function(callBackNm, orgG) {

	//팝업 파라메터 전달
	var param = {
		"orgG":orgG
	};
	
	// 팝업 (윈도우 팝업 type:"window:레이어","browser:새창" 모달 :"modal:true" 모달리스:"modal:false")
	var popOps = { 
		//url:"/ui/sim/sfi/ctm/xml/SFI100112P01.xml"
		url:"/ui/tom/rpt/etc/xml/RPT050401P03.xml"
		,width:"720"
		,height:"849"
		,useHeader:true
		,data:param
		,popup_name:"기관코드조회"
		,callbackFn:callBackNm
	};
	
	return popOps;
};


//부서 팝업
rpt.deptC_popUp = function(callBackNm, orgC, txioG, ageAcG, ocrHoikyeG, sigumgoAcB, schYn) {
	
	//팝업 파라메터 전달
	var param = {
		"orgC":orgC
		,"txioG":txioG
		,"ageAcG":ageAcG
		,"ocrHoikyeG":ocrHoikyeG
		,"sigumgoAcB":sigumgoAcB
		,"schYn":schYn
	};
	
	// 팝업 (윈도우 팝업 type:"window:레이어","browser:새창" 모달 :"modal:true" 모달리스:"modal:false")
	var popOps = { 
		//url:"/ui/sim/sfi/ctm/xml/SFI100111P01.xml"
		url:"/ui/tom/rpt/etc/xml/RPT050401P02.xml"
		,width:"720"
		,height:"849"
		,useHeader:true
		,data:param
		,popup_name:"부서코드조회"
		,callbackFn:callBackNm
	};
	
	return popOps;
};



//보고영업점정보조회 팝업
rpt.brNo_popUp = function(callBackNm, sigumgoC) {
	//팝업 파라메터 전달
	var param = {
		"sigumgoC":sigumgoC
	};
	
	// 팝업 (윈도우 팝업 type:"window:레이어","browser:새창" 모달 :"modal:true" 모달리스:"modal:false")
	var popOps = { 
		url:"/ui/tom/rpt/etc/xml/RPT050401P08.xml"
		,useHeader:true
		,width:"480"
		,height:"849"
		,data:param
		,popup_name:"영업점정보조회"
		,callbackFn:callBackNm
	};
	
	return popOps;
};


//계좌번호조회 팝업(대행계좌구분 변수명을 acG에서 ageAcG로 변경: 2020.05.25 설성윤)
rpt.sggAcnoC_popUp = function(callBackNm, param) { 
	
	// 팝업 (윈도우 팝업 type:"window:레이어","browser:새창" 모달 :"modal:true" 모달리스:"modal:false")
	var popOps = { 
		//url:"/ui/sim/sfi/ctm/xml/SFI100110P01.xml"
		url:"/ui/tom/rpt/etc/xml/RPT050401P01.xml"
		,width:"1120"
		,height:"849"
		,data:param
		,useHeader:true
		,popup_name:"계좌번호조회"
		,callbackFn:callBackNm
	};
	
	return popOps;
};

//클립리포트 팝업창 호출 (공통)
rpt.clipReportPopUp2 = function(clipId, popupName, jsonNm, paramStr, newGbn,width,height,dataIn ,filePath) {
	
	rpt.reportView2("pop",clipId, jsonNm, paramStr, "", newGbn,"N","","","","",dataIn ,filePath);
	
	var popOps = { 
		    //url:"/ui/tom/sfi/sfi/xml/SFI100402P01.xml"
			url:"/uicom/common/ReportView_popup.xml"
		    ,width:com.isEmpty(width)?"1024":width
			,height:com.isEmpty(height)?"950":height
		    ,useHeader:true
		    ,type:"browser"
		    ,modal:false
		    ,popup_name:popupName
		    ,callbackFn:"scsObj.popCallBack"
		};
	
	return popOps;
};

//클립리포트 공통 처리 함수
rpt.reportView2 = function(gubun,clipId,jsonNm, paramStr,ifmClRpt, newGbn , uploadYn, uploadBaseFileNm, uploadSignFileNm, clipIdArray, doubleSidePrtChk ,filePath){
	if (typeof newGbn == 'undefined') newGbn = false;
	if (typeof filePath == 'undefined') filePath = "";

	var btnUse = "YYYYY";
	
	var reportInfo = {};
	
	var sigumgoC = rpt.getSigumgoC();
	var userGubun = rpt.getUserGubun();
	
	reportInfo.BTN_USE = btnUse;
	reportInfo.PG_SIZE = "2";							// defaultRatio: 0:50%, 1:75%, 2:100%, 3:125%, ...(2020.08.24 ??????)
	reportInfo.MOD_ID = "rpt";
	reportInfo.CLIP_ID = clipId;
	reportInfo.DB_NAME = "ictcon";
	reportInfo.LOGIN_USER_NM = gcm.LOGIN.USER_NM;		//로그인 사용자명
	reportInfo.LOGIN_ORG_CD = gcm.LOGIN.PADM_STD_ORG_C;	//로그인 기관코드
	reportInfo.LOGIN_ORG_NM = gcm.LOGIN.ORG_NM;			//로그인 기관명
	reportInfo.LOGIN_DEPT_CD = gcm.LOGIN.SL_GMGO_DEPT_C;//로그인 부서 코드(공무원)
	reportInfo.LOGIN_DEPT_NM = gcm.LOGIN.DEPT_NM;		//로그인 부서명(공무원)
	reportInfo.LOGIN_BR_C = gcm.LOGIN.BR_C;				//로그인 영업점번호(은행직원)
	reportInfo.LOGIN_BR_NM = gcm.LOGIN.BR_NM;			//로그인 영업점명(은행직원)
	reportInfo.UPLOAD_YN = uploadYn;
	reportInfo.UPLOAD_BASE_FILE_NM = uploadBaseFileNm;
	reportInfo.UPLOAD_SIGN_FILE_NM = uploadSignFileNm;
	reportInfo.SEAL_SRC = filePath;
	
	if(userGubun == "BANK"){
		reportInfo.PARAM0 = gcm.LOGIN.BR_NM;
	}
	
	//리포트 전달 동적 file .cfr
	var crfSpVal = clipIdArray.split(",");
	var crfName = "CLIP_ID_ARR";
	
	if(clipIdArray == "") {
		reportInfo.CLIP_ID_LENGTH = "0";
	}else{
		reportInfo.CLIP_ID_LENGTH = crfSpVal.length;
	}
	
	for(var k=1; k<= crfSpVal.length; k++){
		crfName = "CLIP_ID_ARR";
		crfName = crfName+k;
		reportInfo[crfName] = crfSpVal[k-1];
	}
	
	//리포트 전달 동적 파라미터 생성 및 값 설정
	var spVal = paramStr.split(",");
	var paramName = "PARAM";
	
	for(var i=1; i<= spVal.length; i++) {
		paramName = "PARAM";
		paramName = paramName+i;
		reportInfo[paramName] = spVal[i-1];
		
		if (spVal[i-1].indexOf("#") > -1) {
			delete reportInfo[paramName]; 
			
			fieldInfo = spVal[i-1].split("#");
			
			reportInfo[fieldInfo[0]] = fieldInfo[1];
		}
	}
	
	if(!com.isEmpty(dataIn)){
		if(dataIn.initializeType == "dataMap"){
			for(var i=0;i<dataIn.cellIdList;i++){
				paramName = dataIn.cellIdList[i];
				reportInfo[paramName] = dataIn.get(dataIn.cellIdList[i]);
			}
		}
	}
	
	// 일괄출력 구분 코드 세팅 - 보고서 일괄출력에서 사용
	if("Y" == doubleSidePrtChk) {	//양면인쇄일 경우
		reportInfo["ISBUNDLE"] = "O";
	} else if ("N" == doubleSidePrtChk) {
		reportInfo["ISBUNDLE"] = "Y";
	} else {
		reportInfo["ISBUNDLE"] = "";
	}
	
	var locGovCd = reportInfo.LOGIN_ORG_CD;
	var locGovNm = reportInfo.LOGIN_ORG_NM;
	var deptCd = reportInfo.LOGIN_DEPT_CD;
	var deptNm = reportInfo.LOGIN_DEPT_NM;
	var brCd = reportInfo.LOGIN_BR_C;
	var brNm = reportInfo.LOGIN_BR_NM;
	
	var gunguCd = "";
	
	
	//인천시청
	if(sigumgoC == "28"){
		if(locGovNm != null && locGovNm != "") locGovNm = locGovNm.replace("인천", "").replace("광역시", "").trim();
		if(deptNm != null && deptNm != null) deptNm = deptNm.replace("인천", "").trim();
		
		// 직인에 들어갈 금고명 setting
		// 영업점이면서 구청지점일 경우
		if("BANK"== userGubun && (deptNm.indexOf("구청") >= 0 || deptNm.indexOf("강화") >= 0)) {
			deptNm = deptNm.replace("청","");
			
			if(deptNm.indexOf("강화") >= 0) {
				SEAL_VALUE = "인천광역시 " + deptNm + "군" + "금고";
			} else {
				SEAL_VALUE = "인천광역시 " + deptNm + "금고";
			}
			
			reportInfo.SEAL_SIGN =  SEAL_VALUE;
			
			if("7131" == brCd) gunguCd = "100";
			else if("7132" == brCd) gunguCd = "110";
			else if("7172" == brCd) gunguCd = "140";
			else if("7128" == brCd) gunguCd = "170";
			else if("7168" == brCd) gunguCd = "185";
			else if("7169" == brCd) gunguCd = "200";
			else if("7130" == brCd) gunguCd = "237";
			else if("1770" == brCd) gunguCd = "245";
			else if("7129" == brCd) gunguCd = "260";
			else if("1795" == brCd) gunguCd = "710";
			
		// 공무원이면서 인천시청 직원이 아닌 경우
		} else if("SIGU" == userGubun && locGovNm != "시청") {
			SEAL_VALUE = "인천광역시 " + locGovNm + "금고";
			reportInfo.SEAL_SIGN =  SEAL_VALUE;
		} else {
			SEAL_VALUE = "인천광역시금고";
			reportInfo.SEAL_SIGN =  SEAL_VALUE;
			gunguCd = "000";
		}
		
		if(gunguCd == "") gunguCd = "000";
		
		//reportInfo.SEAL_SRC = "/shbweb/tomapp/rpt/img/seal/"+sigumgoC+"_"+gunguCd+".png";
	
	//충청북도	
	}else if(sigumgoC == "43"){
		gunguCd = "000";
		//reportInfo.SEAL_SRC = "/shbweb/tomapp/rpt/img/seal/"+sigumgoC+"_"+gunguCd+".png";
	
	//경기도	
	}else if(sigumgoC == "41"){
		gunguCd = "000";
		//reportInfo.SEAL_SRC = "/shbweb/tomapp/rpt/img/seal/"+sigumgoC+"_"+gunguCd+".png";
	
	//춘천시	
	}else if(sigumgoC == "110"){
		gunguCd = "000";
		//reportInfo.SEAL_SRC = "/shbweb/tomapp/rpt/img/seal/"+sigumgoC+"_"+gunguCd+".png";
	}
	
	
	reportInfo.IC_CONN_ACCT = "전체";
	
	//출력 시간 설정
	var today = new Date();
	var year = today.getFullYear();
	var month = today.getMonth()+1;
	if(month < 10){month = "0"+month;}
	var day = today.getDate();
	if(day < 10){day = "0"+day;}
	var dateString = year+"-"+month+"-"+day;
	
	
	var hours = today.getHours()+1;
	if(hours < 10){hours = "0"+hours;}
	var minutes = today.getMinutes()+1;
	if(minutes < 10){minutes = "0"+minutes;}
	var seconds = today.getSeconds()+1;
	if(seconds < 10){seconds = "0"+seconds;}
	var timeString = hours+":"+minutes+":"+seconds;
	
	reportInfo.PRINT_DATE = "출력일시 : " +dateString+" "+timeString;
	reportInfo.PRINT_MAN = "출력자 : " + gcm.LOGIN.USER_NM + "(아이디 : " + gcm.LOGIN.USER_ID +  ")";
	/*
	var arrList = null;
	var arrType = "key";

	if( dataIn["_dataList"] !== undefined ) {
		
		arrList = dataIn.commandList;
		if (dataIn.commandList.length < dataIn._dataList.commandList.length) {
			arrList = dataIn._dataList.commandList;
			var arrType = "col";
		}
	} else {
		arrList = dataIn;
		arrType = "obj";
	}
	
	//IN
	if ("key" == arrType) {
		console.log("arrType ==============================="+arrType);
		for(var i = 0 ; i < arrList.length ;i++){
			var loopKey = arrList[i].key;
			var loopVal = arrList[i].value;
			console.log("loopKey="+loopKey +" loopVal="+JSON.stringify(loopVal));
			reportInfo[loopKey] = loopVal;
		}
	//OUT 단건만
	} else if ("obj" === arrType) {
		console.log("arrType ==============================="+arrType);
		const keyList = Object.keys(arrList);
		for(const key of keyList){
			var loopKey = key;
			var loopVal = arrList[key];			
			console.log("loopKey="+loopKey +" loopVal="+JSON.stringify(loopVal));			
			reportInfo[loopKey] = loopVal;
		}
	} else {
		console.log("arrType ==============================="+arrType);
		for(var i = 0 ; i < arrList.length ;i++){
			var loopKey = arrList[i].col;
			var loopVal = arrList[i].value;
			console.log("loopKey="+loopKey +" loopVal="+JSON.stringify(loopVal));
			reportInfo[loopKey] = loopVal;
		}
	}
	*/
	com.setSessionData("reportInfo",JSON.stringify(reportInfo));
	
	if(gubun == "pop"){
		
	}else{
		//ifmClRpt.setSrc("/ui/tom/sfi/sfi/xml/SFI100402P01.xml");
		ifmClRpt.setSrc("/uicom/common/ReportView_popup.xml");
		
		// 리포트 높이 조절
		rpt.ifmReSizeHeight(ifmClRpt);
	}
};

//클립리포트 팝업창 호출 (공통)
rpt.clipReportPopUp3 = function(clipId, popupName, jsonNm, paramStr, newGbn, popupHeight, popupWidth,filePath) {
	
	rpt.reportView3("pop",clipId, jsonNm, paramStr, "", newGbn,"N","","","","",filePath);
	
	if (com.isEmpty(popupHeight)) popupHeight = "1024";
	if (com.isEmpty(popupWidth)) popupWidth = "950";
	
	var popOps = { 
		    //url:"/ui/tom/sfi/sfi/xml/SFI100402P01.xml"
			url:"/uicom/common/ReportView_popup.xml"
		    ,width:popupWidth
			,height:popupHeight
		    ,useHeader:true
		    ,type:"browser"
		    ,modal:false
		    ,popup_name:popupName
		    ,callbackFn:"scsObj.popCallBack"
		};
	
	return popOps;
};


// [인천-2] 세로로 출력되는 보고서 파일 명을 여기에 추가하세요. 위변조 좌표가 세로모드로 적용되어 출력됩니다. (일반 사이즈)
var verticalReport = ["crRPT011030504_print_1", "crRPT031020702", "crRPT031020704", "crRPT031020704_1",
	"crRPT031030804", "crRPT011030501_1", "crRPT031030811", "crRPT031030813", "crRPT031030812", "crRPT031031001",
	"crRPT031040901", "crRPT031040903", "crRPT031040905", "crRPT031040907", "crRPT031020507", "crRPT031040913",
	"crRPT011105005", "SFI010104R01", "SFI020102R01"];
var verticalReport2 = ["crRPT031020505", "crRPT031030814", "crRPT031031003", "crRPT031031004", "crRPT031031005",
	"crRPT031031006"];

var nobarcodeReport = [ "crRPT031010203_print", "crRPT031020603_2", "crRPT031040906", "crRPT031040908", "crRPT031040918"
//----------------------------------------------------------- 
//24.06.07: 바코드 출력필요하나, 구보고서부터 문제가 있어 수정할 때까지 임시로 제외
	//24.06.10:  "crRPT031020501" 제외
	,"crRPT031010101_print", "crRPT031020509",  "crRPT031020510",
	"crRPT031040916", "crRPT031030816_1", "crRPT031030814_1", "crRPT031030815_1",
	// 24.06.25: 계좌별 세입세출 자금일계표, 자금배정내역, 일괄출력 - 지급/송금증명서 제외 (운영에서 직인 가림)
	"crRPT031020508", "crRPT012020305", "crRPT031040901",
	// 24.06.25: 보고서 조회/전자결재,  주요보고서 보고현황, 공금예금 거래내역, 재정건전성 제외 (이름 살짝 잘림)
	"crRPT031041102", "crRPT031041103", "crRPT011010207_1", "crRPT031040915"
	];

//-----------------------------------------------------------

//클립리포트 공통 처리 함수
rpt.reportView3 = function(gubun,clipId,jsonNm, paramStr,ifmClRpt, newGbn , uploadYn, uploadBaseFileNm, uploadSignFileNm, clipIdArray, doubleSidePrtChk,filePath){
	if (typeof newGbn == 'undefined') newGbn = false;
	if (typeof filePath == 'undefined') filePath = "";
	var sigumgoC = rpt.getSigumgoC();
	var userGubun = rpt.getUserGubun();
	
  	var vertical = verticalReport.indexOf(clipId) > -1 ? "vertical" : "horizon";
  	if(vertical != "vertical") {
  		vertical = verticalReport2.indexOf(clipId) > -1 ? "vertical2" : "horizon";
  	}
  	var nobarcode = nobarcodeReport.indexOf(clipId) > -1 ? "Y" : "N";
  	debugger;
  	
  	if(sigumgoC != "28"){
  		nobarcode = "Y";
  	}
	
	var btnUse = "YYYYY";
	var reportInfo = {};
	
	reportInfo.BTN_USE = btnUse;
	reportInfo.PG_SIZE = "2";							// defaultRatio: 0:50%, 1:75%, 2:100%, 3:125%, ...(2020.08.24 ??????)
	reportInfo.MOD_ID = "rpt";
	reportInfo.CLIP_ID = clipId;
	reportInfo.DB_NAME = "ictcon";
	reportInfo.LOGIN_USER_NM = gcm.LOGIN.USER_NM;		//로그인 사용자명
	reportInfo.LOGIN_ORG_CD = gcm.LOGIN.PADM_STD_ORG_C;	//로그인 기관코드
	reportInfo.LOGIN_ORG_NM = gcm.LOGIN.ORG_NM;			//로그인 기관명
	reportInfo.LOGIN_DEPT_CD = gcm.LOGIN.SL_GMGO_DEPT_C;//로그인 부서 코드(공무원)
	reportInfo.LOGIN_DEPT_NM = gcm.LOGIN.DEPT_NM;		//로그인 부서명(공무원)
	reportInfo.LOGIN_BR_C = gcm.LOGIN.BR_C;				//로그인 영업점번호(은행직원)
	reportInfo.LOGIN_BR_NM = gcm.LOGIN.BR_NM;			//로그인 영업점명(은행직원)
	reportInfo.UPLOAD_YN = uploadYn;
	reportInfo.UPLOAD_BASE_FILE_NM = uploadBaseFileNm;
	reportInfo.UPLOAD_SIGN_FILE_NM = uploadSignFileNm;
	reportInfo.SEAL_SRC = filePath;
	reportInfo.VERTICAL = vertical;
	reportInfo.NOBARCODE = nobarcode;
	
	if(userGubun == "BANK"){
		reportInfo.PARAM0 = gcm.LOGIN.BR_NM;
	}
	
	//리포트 전달 동적 file .cfr
	var crfSpVal = clipIdArray.split(",");
	var crfName = "CLIP_ID_ARR";
	
	if (clipIdArray == "") {
		reportInfo.CLIP_ID_LENGTH = "0";
	} else {
		reportInfo.CLIP_ID_LENGTH = crfSpVal.length;
		reportInfo.NOBARCODE = "Y";
	}
	
	for(var k=1; k <= crfSpVal.length; k++) {
		crfName = "CLIP_ID_ARR";
		crfName = crfName+k;
		reportInfo[crfName] = crfSpVal[k-1];
	}
	
	//리포트 전달 동적 파라미터 생성 및 값 설정
	var spVal = paramStr.split(",");
	var paramName = "PARAM";
	
	for(var i=1; i<= spVal.length; i++) {
		//param명 존재
		if (spVal[i-1].indexOf(":") > -1) {
			paramName = spVal[i-1].substring(0, spVal[i-1].indexOf(':'));
			reportInfo[paramName] = spVal[i-1].substring(spVal[i-1].indexOf(':')+1, spVal[i-1].length);
		} else {
			paramName = "PARAM";
			paramName = paramName+i;
			reportInfo[paramName] = spVal[i-1];
		}
		
		if (spVal[i-1].indexOf("#") > -1) {
			delete reportInfo[paramName]; 
			
			fieldInfo = spVal[i-1].split("#");
			
			reportInfo[fieldInfo[0]] = fieldInfo[1];
		}
	}	
	
	// 일괄출력 구분 코드 세팅 - 보고서 일괄출력에서 사용
	if("Y" == doubleSidePrtChk) {	//양면인쇄일 경우
		reportInfo["ISBUNDLE"] = "O";
	} else if ("N" == doubleSidePrtChk) {
		reportInfo["ISBUNDLE"] = "Y";
	} else {
		reportInfo["ISBUNDLE"] = "";
	}
	
	var locGovCd = reportInfo.LOGIN_ORG_CD;
	var locGovNm = reportInfo.LOGIN_ORG_NM;
	var deptCd = reportInfo.LOGIN_DEPT_CD;
	var deptNm = reportInfo.LOGIN_DEPT_NM;
	var brCd = reportInfo.LOGIN_BR_C;
	var brNm = reportInfo.LOGIN_BR_NM;
	
	var gunguCd = "";
	
	
	//인천시청
	if(sigumgoC == "28"){
		if(locGovNm != null && locGovNm != "") locGovNm = locGovNm.replace("인천", "").replace("광역시", "").trim();
		if(deptNm != null && deptNm != null) deptNm = deptNm.replace("인천", "").trim();
		
		// 직인에 들어갈 금고명 setting
		// 영업점이면서 구청지점일 경우
		if("BANK"== userGubun && (deptNm.indexOf("구청") >= 0 || deptNm.indexOf("강화") >= 0)) {
			deptNm = deptNm.replace("청","");
			
			if(deptNm.indexOf("강화") >= 0) {
				SEAL_VALUE = "인천광역시 " + deptNm + "군" + "금고";
			} else {
				SEAL_VALUE = "인천광역시 " + deptNm + "금고";
			}
			
			reportInfo.SEAL_SIGN =  SEAL_VALUE;
			
			if("7131" == brCd) gunguCd = "100";
			else if("7132" == brCd) gunguCd = "110";
			else if("7172" == brCd) gunguCd = "140";
			else if("7128" == brCd) gunguCd = "170";
			else if("7168" == brCd) gunguCd = "185";
			else if("7169" == brCd) gunguCd = "200";
			else if("7130" == brCd) gunguCd = "237";
			else if("1770" == brCd) gunguCd = "245";
			else if("7129" == brCd) gunguCd = "260";
			else if("1795" == brCd) gunguCd = "710";
			
		// 공무원이면서 인천시청 직원이 아닌 경우
		} else if("SIGU" == userGubun && locGovNm != "시청") {
			SEAL_VALUE = "인천광역시 " + locGovNm + "금고";
			reportInfo.SEAL_SIGN =  SEAL_VALUE;
		} else {
			SEAL_VALUE = "인천광역시금고";
			reportInfo.SEAL_SIGN =  SEAL_VALUE;
			gunguCd = "000";
		}
		
		if(gunguCd == "") gunguCd = "000";
		
		//reportInfo.SEAL_SRC = "/shbweb/tomapp/rpt/img/seal/"+sigumgoC+"_"+gunguCd+".png";
	
	//충청북도	
	}else if(sigumgoC == "43"){
		gunguCd = "000";
		//reportInfo.SEAL_SRC = "/shbweb/tomapp/rpt/img/seal/"+sigumgoC+"_"+gunguCd+".png";
	
	//경기도	
	}else if(sigumgoC == "41"){
		gunguCd = "000";
		//reportInfo.SEAL_SRC = "/shbweb/tomapp/rpt/img/seal/"+sigumgoC+"_"+gunguCd+".png";
	
	//춘천시	
	}else if(sigumgoC == "110"){
		gunguCd = "000";
		//reportInfo.SEAL_SRC = "/shbweb/tomapp/rpt/img/seal/"+sigumgoC+"_"+gunguCd+".png";
	}
	
	
	reportInfo.IC_CONN_ACCT = "전체";
	
	//출력 시간 설정
	var today = new Date();
	var year = today.getFullYear();
	var month = today.getMonth()+1;
	if(month < 10){month = "0"+month;}
	var day = today.getDate();
	if(day < 10){day = "0"+day;}
	var dateString = year+"-"+month+"-"+day;
	
	
	var hours = today.getHours()+1;
	if(hours < 10){hours = "0"+hours;}
	var minutes = today.getMinutes()+1;
	if(minutes < 10){minutes = "0"+minutes;}
	var seconds = today.getSeconds()+1;
	if(seconds < 10){seconds = "0"+seconds;}
	var timeString = hours+":"+minutes+":"+seconds;
	
	reportInfo.PRINT_DATE = "출력일시 : " +dateString+" "+timeString;
	reportInfo.PRINT_MAN = "출력자 : " + gcm.LOGIN.USER_NM + "(아이디 : " + gcm.LOGIN.USER_ID +  ")";

	com.setSessionData("reportInfo",JSON.stringify(reportInfo));
	
	if(gubun == "pop"){
		
	}else{
		//ifmClRpt.setSrc("/ui/tom/sfi/sfi/xml/SFI100402P01.xml");
		ifmClRpt.setSrc("/uicom/common/ReportView_popup.xml");
		
		// 리포트 높이 조절
		rpt.ifmReSizeHeight(ifmClRpt);
	}
};


//전자보고서 조회조건 기관구분/기관명/부서명/계좌번호 등 콤보리스트 dataChange 로직 rptCommon.js에 공동함수화(2021.01.29 설성윤)
rpt.onModelChangeCommon = function(scsObj, info) {
	
	if(info.key == "RPT_ID")															// 보고서ID 변경시
	{
		scsObj.RptID_OldValue = info.oldValue;
	}
	
	if (scsObj.dataIn == undefined || info.newValue == null || scsObj.isInitiated == undefined) return;
	
	//console.log(info);
	
	if (scsObj.dataIn.get("skipRunOnModelChange") == "Y") return;
	
	if(info.key == "RPT_AC_G")															// 보고구분 변경시
	{
		scsObj.dataIn.set(info.key, info.newValue);											// 값변동이 delay 발생하여 강제SET 처리(2021.01.21 설성윤)
		scsObj.sbx_RptAcG_onchange("sbx_RptAcG_onchange"); 
	}		
	else if(info.key == "AC_SEARCH_G")													// 조회대상구분 변경시
	{
		scsObj.AcSearchG_OldValue = info.oldValue;
		scsObj.dataIn.set(info.key, info.newValue);											// 값변동이 delay 발생하여 강제SET 처리(2021.01.21 설성윤)
		scsObj.sbx_AcSearchG_onchange("sbx_AcSearchG_onchange"); 
	}
	else if(info.key == "ORG_G")														// 기관구분 변경시
	{
		scsObj.OrgG_OldValue = info.oldValue;
		scsObj.dataIn.set(info.key, info.newValue);											// 값변동이 delay 발생하여 강제SET 처리(2021.01.21 설성윤)
		scsObj.sbx_OrgG_onchange("sbx_OrgG_onchange");
	}
	else if(info.key == "ORG_C")														// 기관명 변경시
	{ 
		scsObj.OrgC_OldValue = info.oldValue;
		scsObj.dataIn.set(info.key, info.newValue);											// 값변동이 delay 발생하여 강제SET 처리(2021.01.21 설성윤)
		scsObj.sbx_OrgC_onchange("sbx_OrgC_onchange");
	}
	else if(info.key == "DEPT_C")														// 부서명 변경시 
	{ 
		scsObj.DeptC_OldValue = info.oldValue;
		scsObj.dataIn.set(info.key, info.newValue);											// 값변동이 delay 발생하여 강제SET 처리(2021.01.21 설성윤)
		scsObj.sbx_DeptC_onchange("sbx_DeptC_onchange");
	}
	else if(info.key == "SITAX_GUTAX_G")												// 시구세 변경시
	{
		scsObj.dataIn.set(info.key, info.newValue);											// 값변동이 delay 발생하여 강제SET 처리(2021.01.21 설성윤)
		if(scsObj._sbx_SitaxGutaxG != undefined && scsObj.dataIn.getKey("SITAX_GUTAX_NM") != null)
		{
			scsObj.dataIn.set("SITAX_GUTAX_NM", scsObj._sbx_SitaxGutaxG.getText());
		}
		
		scsObj.sbx_DeptC_onchange("sbx_SitaxGutaxG_onchange");
	}
	else if(info.key == "HOIKYE_YEAR")													// 회계년도 변경시
	{ 
		scsObj.dataIn.set(info.key, info.newValue);											// 값변동이 delay 발생하여 강제SET 처리(2021.01.21 설성윤)
		scsObj.sbx_DeptC_onchange("ica_HoikyeYear_onchange");
	}
	else if(info.key == "AGE_AC_G")														// 대행계좌구분 변경시
	{
		scsObj.dataIn.set(info.key, info.newValue);											// 값변동이 delay 발생하여 강제SET 처리(2021.01.21 설성윤)
		if(scsObj._sbx_AgeACG != undefined && scsObj.dataIn.getKey("AGE_AC_NM") != null) 
			scsObj.dataIn.set("AGE_AC_NM", scsObj._sbx_AgeACG.getText());
		
		scsObj.sbx_DeptC_onchange("sbx_AgeACG_onchange");
	}
	else if(info.key == "DTL_HOIKYE_C")													// 회계번호 변경시
	{ 
		scsObj.dtlHoikeyC_OldValue = info.oldValue;
		scsObj.dataIn.set(info.key, info.newValue);											// 값변동이 delay 발생하여 강제SET 처리(2021.01.21 설성윤)
		scsObj.sbx_DtlHoikyeC_onchange("sbx_DtlHoikyeC_onchange");		
	}
	else if(info.key == "SGG_ACNO")														// 계좌번호 변경시
	{ 
		scsObj.SggAcno_OldValue = info.oldValue;
		scsObj.dataIn.set(info.key, info.newValue);											// 값변동이 delay 발생하여 강제SET 처리(2021.01.21 설성윤)
		scsObj.sbx_SggAcno_onchange("sbx_SggAcno_onchange");		
	}

	if(info.key != "FROM_NUM" && info.key != "TO_NUM" && info.key != "JIPGYE_G" && info.key != "JIPGYE_I")
	{
		rpt.clearAprvInfo(scsObj);				// 조회조건 변경시 결재버튼 및 결재정보 Clear	
	}
	
};



//Footer txt-red 일괄 초기화
rpt.removeClassTxtRed = function(){
	let parentObj = document.getElementsByClassName("txt-red");
    let objId = "";
    
    if (parentObj.length == 0) return;
    
    for(let j=0; j < parentObj.length; j++){
        let itemObj = parentObj.item(j);

        if(j == 0){
            objId = itemObj.id;
        }else{
            objId += ","+itemObj.id;
        }
    }

    let objArr = objId.split(',');
    let objArrId = "";
    for(let k=0; k < objArr.length; k++){
         objArrId = String(objArr[k]).trim();
        $("#"+objArrId).removeClass("txt-red");
    }
};





/**
 * dataList에서 복수 컬럼의 값이 일치하는 행들의 index를 반환
 *
 * @date 2020.07.21 설성윤
 * @memberOf rpt
 * @param {Array}
 *            str 사업자번호 문자열
 * @returns {Array} 일치하는 index를 담은 1차원 배열
 */
rpt.getMultiMatchedIndex = function(dataList, valInfoArr) {
	
	var tmpRsData = new Array();
	
	for(var i = 0; i < dataList.getTotalRow(); i++)
	{
		var rowData = dataList.getRowJSON(i);
		var isMatched = true;
		
        for (var validx in valInfoArr) 
        {
        	var valInfo = valInfoArr[validx];
        	
            if(rowData[valInfo.id] != valInfo.value)
            {
            	isMatched = false;
            	break;
            }
        }
        
        if(isMatched == true)
        {
        	tmpRsData.push(i);
        }
	}
	
	return tmpRsData;
}





//보고서 초기 세팅
rpt.initRpt  = function(scsObj) {
	scsObj.isClipReportView = true;		// clipReportView 호출 여부(일괄결제인 경우에 해당화면 일괄결재처리 함수에서 false 설정 2020.09.22 설성윤)
	scsObj.GYLJK = "";					// 보고서 조회 화면으로 결재처리구분 값 RETURN
	scsObj.isFirstRun = (scsObj.$w.getFrame().getObj("MCommonRPTAPPR00In") != undefined);
	
	
	
	var userGubun = rpt.getUserGubun();//사용자구분
	
	// 필수로 정의되어야 할 object 체크(2020.10.30 설성윤)
	if(scsObj.dataIn == undefined)
	{
		alert("조회조건 입력 DataCollection\n'scsObj.dataIn'이 초기화되지 않았습니다.");
	}
	
	scsObj.dataIn.set("skipRunOnModelChange", "N");		// 사용자가 보고영업점 변경직후 기관/부서 변동시 보고영업점을 다시 가져오지 않게 하기 위함(2020.11.13 설성윤)

	//scsObj.dataIn.set("GIGM_RIGHT_G"  , com.getSessionData("sfiCommData").gigmRightG);
	scsObj.dataIn.set("USER_ID"       , com.getUserId()     ); // 사용자ID
	
	
	if (scsObj.isFirstRun == false)
	{
		scsObj.AprvBrno_Value = "-1";
		
		// 데이터 컬렉션 생성: 보고서 통합 In
		com.createDataObj_page("dataMap", "MCommonRPTAPPR00In", [ 
	   	      "ORG_G"                   // 기관구분
	   	    , "ORG_C"                   // 기관코드
	   	    , "DEPT_C"                  // 부서코드
	   	    , "RPT_ID"                  // 보고서ID 
	   	    , "RPT_AC_G"                // 보고서 보고구분 
	   	    , "AC_SEARCH_G"             // 조회대상 
	   	    , "TXIO_G"      		    // 계좌구분(1.세입,2.세출,3.일상경비)
	   	    , "HOIKYE_YEAR"      		// 회계년도
	   	    , "SITAX_GUTAX_G"      		// 시구세구분(1.시세,2.구세,3.기타, 세입보고서의 경우 시구세구분에 따라 보고영업점이 달라져 필수(2020.11.18 설성윤))
	   	    , "DTL_HOIKYE_C"      		// 상세회계코드
	   	    , "SGG_ACNO"          		// 계좌번호
            , "APRV_BRNO"               // 현 보고영업점번호
            , "SIGUMGO_C"             // 금고코드 
	        ],scsObj.$w);
		
		// 데이터 컬렉션 생성: 전자결재용 보고서 정보 조회 Out
		com.createDataObj_page("dataMap", "MICH030102R06Out", [
               "RPT_ID"					// 보고서ID
             , "RPT_AC_G"				// 보고계좌구분
             , "RPT_AC_G_NM"			// 보고계좌구분명
             , "RPT_G"					// 보고서구분
             , "RPT_NM"					// 보고서명
             , "RPT_CYCL_G"				// 보고주기구분
             , "TXIO_G"					// 계좌구분
             , "AC_B"					// 계좌분류
             , "GOV_G"					// 산하기관구분
             , "DEPT_C_USE_YN"			// 전자보고용 보고서여부
             , "INQR_ID"				// 조회ID
             , "MENU_ID"				// MENUID
            ],scsObj.$w);
		
		
		// 데이터 컬렉션 생성: 결재진행상태 조회 In
		com.createDataObj_page("dataMap", "MICH030102R07In", [ 
			"RPT_ORG_C"             	// 보고서 수신 기관코드
		    , "RPT_ORG_NM"             	// 보고서 수신 기관명
		    , "RPT_DEPT_C"            	// 보고서 수신 부서코드
		    , "RPT_DEPT_NM"            	// 보고서 수신 부서명
		    , "RPT_BRNO"                // 보고영업점
		    , "RPT_BRNM"                // 보고영업점명
		    , "GEUMGO_CODE"            	// 금고코드
		    , "RPT_ID"                  // 보고서 ID
		    , "RPT_AC_G"                // 보고서 보고구분
		    , "RPT_DTTM"                // 보고기준일자
		    , "HOIKYE_YEAR"          	// 조회조건 회계연도
	   	    , "SITAX_GUTAX_G"      		// 시구세구분(1.시세,2.구세,3.기타, 세입보고서의 경우 시구세구분에 따라 보고영업점이 달라져 필수(2020.11.18 설성윤))
		    , "DTL_HOIKYE_C"        	// 조회조건 상세회계코드
		    , "SGG_ACNO"             	// 조회조건 계좌번호
		    , "RPT_DISTG_C"            	// 조회조건 기타(과오납환급일보의 환급구분, 특별징수정산 (세무과용)의 조회구분 등)
		    , "BAS_DT"                  // 기준일자
		    , "BAYM"                    // 기준년월
		    , "BAS_QTR_G"             	// 기준분기
		    , "RPT_NM"                 // 보고서명
		    , "RPT_G"                  // 보고서구분
		    , "SNO"                    // 보고서번호
		    , "TXIO_G"                 // 계좌구분
		    , "RPT_CYCL_G"             // 보고기한
		    , "INQR_NM"                 // 조회명
		    , "IS_POPUP"			    // 팝업여부
			],scsObj.$w);
		
		// 데이터 컬렉션 생성: 결재진행상태 조회 Out
		com.createDataObj_page("dataMap", "MICH030102R07Out", [
               "GYLJK"                  // 결재처리결상태(opener에 return value)
			, "CHK_GRADE"            // 결재등급 
			, "GEUMGO_CODE"            // 금고코드 
			 , "HOIKYE_YEAR"            // 회계년도
			 , "DAESANG_YN"             // 결재대상구분
			 , "SGG_ACNO"              // 계좌번호
			 , "INQR_NM"               // 보고서명
			 , "LIST_CYCL_G"           // 보고주기
			 , "DTL_HOIKYE_C"          // 결재대상구분
			 , "COND_BAS_DT"           // 기준일
			 , "COND_BAYM"             // 기준년월
			 , "COND_BAS_QTR_G"        // 기준분기
			 , "ORG_G"                	// 보고서 수신 기관코드
             , "ORG_G_NM"               // 보고서 수신 기관명
			 , "ORG_C"                	// 보고서 수신 기관코드
             , "ORG_C_NM"               // 보고서 수신 기관명
     	     , "DEPT_C"               	// 보고서 수신 부서코드
     	     , "DEPT_NM"               	// 보고서 수신 부서명
             , "BRNO"                 	// 보고 영업점
             , "BR_NM"                 	// 보고 영업점명
             , "RPT_ID"                 // 보고서 ID
             , "RPT_NM"                 // 보고서명
             , "RPT_AC_G"               // 보고서 보고구분
             , "RPT_AC_G_NM"            // 보고서 보고구분명
             , "TXIO_G"                 // 계좌구분
             , "TXIO_G_NM"              // 계좌구분명
             , "SNO"                    // 순번
             , "RPT_TRN"                // 보고회차
             , "RPT_PRC"                // 보고서프로세스단계 (0:대기, 1:상신, 2:담당자회수, 3:책임자승인, 4:책임자반려, 5:책임자회수, 6주무관승인, 7주무관반려
             , "RPT_DTTM"               // 보고기준일자
             , "RPT_DT"                 // 보고일자
             , "RPT_G"                  // 보고서구분
             , "RPT_G_NM"               // 보고서구분명
             , "RPT_CYCL_G"             // 보고주기
             , "RPT_CYCL_G_NM"          // 보고주기명
             , "RPT_STEP_G"				// 보고단계구분
             , "RPT_STEP_G_NM"			// 보고단계구분명
             , "LST_GYLJ_S_G"           // 최종결재상태구분
             , "LST_GYLJ_S_NM"          // 최종결재상태명
             , "RQST_DTTM"              // 요청일시
             , "RQST_CTNT"				// 요청내용
             , "SANGSIN_YN"             // 상신여부
             , "RE_SANGSIN_YN"          // 재상신여부
             , "RTRN_YN"                // 반려여부
             , "GYLJ_YN"                // 결재여부
             , "WTHD_YN"                // 회수여부
             , "DEL_YN"					// 삭제여부
             , "IS_POPUP"			    // 팝업여부
             , "INQR_NM"			    // 조회명
             , "S1_GYLJ_S_G"            // 1단계결재상태
             , "S1_GYLJ_S_NM"        	// 1단계결재상태명 
             , "S1_CONFJ_ID"            // 1단계확인자ID
             , "S1_CONFJ_NM"            // 1단계확인자명
             , "S1_CONF_DT"             // 1단계확인일자
             , "S1_CONF_RST_DTL_NM"     // 1단계확인결과상세내용
             , "S2_GYLJ_S_G"            // 2단계결재상태
             , "S2_GYLJ_S_NM"        	// 2단계결재상태명 
             , "S2_CONFJ_ID"            // 2단계확인자ID
             , "S2_CONFJ_NM"            // 2단계확인자명
             , "S2_CONF_DT"             // 2단계확인일자
             , "S2_CONF_RST_DTL_NM"     // 2단계확인결과상세내용
             , "S3_GYLJ_S_G"            // 3단계결재상태
             , "S3_GYLJ_S_NM"        	// 3단계결재상태명 
             , "S3_CONFJ_ID"            // 3단계확인자ID
             , "S3_CONFJ_NM"            // 3단계확인자명
             , "S3_CONF_DT"             // 3단계확인일자
             , "S3_CONF_RST_DTL_NM"     // 3단계확인결과상세내용
             , "S4_GYLJ_S_G"            // 4단계결재상태
             , "S4_GYLJ_S_NM"        	// 4단계결재상태명 
             , "S4_CONFJ_ID"            // 4단계확인자ID
             , "S4_CONFJ_NM"            // 4단계확인자명
             , "S4_CONF_DT"             // 4단계확인일자
             , "S4_CONF_RST_DTL_NM"     // 4단계확인결과상세내용
             ],scsObj.$w);
		
		
		// 데이터 컬렉션 생성: 영업점 직인파일 WAS서버 다운로드 및 FILEPATH 조회 In(2020.10.05 설성윤)
		com.createDataObj_page("dataMap", "MICH030102R08In", [ 
       	      "BRNO"                    // 점번호
			  ,"SL_GMGO_MODL_C"         // 모듈코드
            ],scsObj.$w);
		
		// 데이터 컬렉션 생성: 영업점 직인파일 WAS서버 다운로드 및 FILEPATH 조회 Out(2020.10.05 설성윤)
		com.createDataObj_page("dataMap", "MICH030102R08Out", [
	           "BRNO"					// 점번호
	         , "BRNM"					// 점명
	         , "ATTCH_FILE_MNG_NO"		// 파일관리번호
	         , "ATTCH_FILE_SER"			// 파일일련번호
	         , "SVR_FILE_PATH"			// 파일경로
	         , "SVR_FILE_NM"			// 파일명
	         , "CLNT_FILE_NM"			// 파일명
	         , "ATTCH_FILE_SIZE"		// 파일사이즈
	         , "BIGO_CTNT"				// 비고
	        ],scsObj.$w);
		
		scsObj._sbx_RptG = scsObj.$w.getFrame().getObj("sbx_RptG");
		scsObj._sbx_RptAcG = scsObj.$w.getFrame().getObj("sbx_RptAcG");
		scsObj._sbx_AcSearchG = scsObj.$w.getFrame().getObj("sbx_AcSearchG");
		scsObj._sbx_OrgG = scsObj.$w.getFrame().getObj("sbx_OrgG");
		scsObj._sbx_OrgC = scsObj.$w.getFrame().getObj("sbx_OrgC");
		scsObj._sbx_DeptC = scsObj.$w.getFrame().getObj("sbx_DeptC");
		scsObj._sbx_Brno = scsObj.$w.getFrame().getObj("sbx_Brno");
		scsObj._sbx_SitaxGutaxG = scsObj.$w.getFrame().getObj("sbx_SitaxGutaxG");
		scsObj._sbx_DtlHoikyeC = scsObj.$w.getFrame().getObj("sbx_DtlHoikyeC");
		scsObj._sbx_SggAcno = scsObj.$w.getFrame().getObj("sbx_AcctNo");
		scsObj._sbx_AgeACG = scsObj.$w.getFrame().getObj("sbx_AgeACG");
		
		scsObj._dataList_OrgG = (scsObj._sbx_OrgG != undefined && scsObj._sbx_OrgG.getDataListInfo().id != undefined) ? scsObj.$w.getFrame().getObj(scsObj._sbx_OrgG.getDataListInfo().id) : undefined;
		scsObj._dataList_OrgC = (scsObj._sbx_OrgC != undefined && scsObj._sbx_OrgC.getDataListInfo().id != undefined) ? scsObj.$w.getFrame().getObj(scsObj._sbx_OrgC.getDataListInfo().id) : undefined;
		scsObj._dataList_DeptC = (scsObj._sbx_DeptC != undefined && scsObj._sbx_DeptC.getDataListInfo().id != undefined) ? scsObj.$w.getFrame().getObj(scsObj._sbx_DeptC.getDataListInfo().id) : undefined;
		scsObj._dataList_SggAcno = (scsObj._sbx_SggAcno != undefined && scsObj._sbx_SggAcno.getDataListInfo().id != undefined) ? scsObj.$w.getFrame().getObj(scsObj._sbx_SggAcno.getDataListInfo().id) : undefined;
		scsObj._dataList_DtlHoikeyC = (scsObj._sbx_DtlHoikyeC != undefined && scsObj._sbx_DtlHoikyeC.getDataListInfo().id != undefined) ? scsObj.$w.getFrame().getObj(scsObj._sbx_DtlHoikyeC.getDataListInfo().id) : undefined;
		scsObj._dataList_AprvBrno = (scsObj._sbx_Brno != undefined && scsObj._sbx_Brno.getDataListInfo().id != undefined) ? scsObj.$w.getFrame().getObj(scsObj._sbx_Brno.getDataListInfo().id) : undefined;
		
	}
	
	
	
	if(scsObj.gyljYn == undefined || (scsObj.$w.getFrame().getObj("MCommonRPTAPPR00In").get("RPT_ID") != "" && scsObj.dataIn.get("RPT_ID") != scsObj.$w.getFrame().getObj("MCommonRPTAPPR00In").get("RPT_ID")))
	{
		scsObj.rptAprvStatIn  = scsObj.$w.getFrame().getObj("MICH030102R07In");
		scsObj.rptAprvStatOut = scsObj.$w.getFrame().getObj("MICH030102R07Out");	// 결재상태정보 조회결과
		
		scsObj.rptAprvStatIn.reset();
		scsObj.rptAprvStatOut.reset();
		
		scsObj.$w.getFrame().getObj("MICH030102R08In").reset();
		scsObj.$w.getFrame().getObj("MICH030102R08Out").reset();		// 영업점직인정보 조회결과
		
		scsObj.$w.getFrame().getObj("MICH030102R06Out").reset();		// 보고서정보 조회결과
		
		scsObj.$w.getFrame().getObj("MCommonRPTAPPR00In").set("RPT_ID", scsObj.dataIn.get("RPT_ID"));
		scsObj.$w.getFrame().getObj("MCommonRPTAPPR00In").reform();
		
		// 전자보고서 보고서 정보 조회(전자보고 대상여부 체크 및 전자결재 UI 표출 처리)
		rpt.dySubmissionRpt(scsObj, "sbm_rptinf_inq", "SICH030102R06", "MCommonRPTAPPR00In", "MICH030102R06Out");
	}
	else
	{
		scsObj.gyljYn = "N";	// 전자결재 보고서 여부
	}
	
	
	
	if(scsObj.gyljYn == "Y"){
		
	}
	
	
	// 보고서 조회에서 팝업 오픈시
	if(!com.isEmpty(scsObj.param_data))
	{
		// 모든 사용자는 팝업오픈시 보고구분, 조회대상, 보고영업점, 시구세구분을 변경할 수 없어야 한다.(2020.11.06 설성윤)
		if(scsObj._sbx_RptAcG != undefined) scsObj._sbx_RptAcG.setDisabled(true);
		//if(scsObj._sbx_AcSearchG != undefined) scsObj._sbx_AcSearchG.setDisabled(true);
		if(scsObj._sbx_Brno != undefined) scsObj._sbx_Brno.setDisabled(true);
		
		
		if(userGubun == "SIGU"){
			if(scsObj._sbx_OrgG != undefined) scsObj._sbx_OrgG.setDisabled(true);
			if(scsObj._sbx_OrgC != undefined) scsObj._sbx_OrgC.setDisabled(true);
			if(scsObj._sbx_DeptC != undefined) scsObj._sbx_DeptC.setDisabled(true);
			if(scsObj._btn_OrgG != undefined) scsObj._btn_OrgG.setDisabled(true);
			if(scsObj._btn_OrgC != undefined) scsObj._btn_OrgC.setDisabled(true);
			if(scsObj._btn_DeptC != undefined) scsObj._btn_DeptC.setDisabled(true);
		}
	}
	
};
 


//영업점 직인 조회
rpt.getBranchStamp = function(scsObj) {
	
	var brNo = "";
	var brNoFlag = "";
	
	
	if(typeof scsObj.dataIn.get("APRV_BRNO") != "undefined"){
		brNo = scsObj.dataIn.get("APRV_BRNO");
	}
	
	
	//화면상 영업점 코드 안쓰고 세션 영업점 코드 사용
	if(typeof scsObj.apprBrNoFlag != "undefined"){
		
		if(scsObj.apprBrNoFlag == "N"){
			brNo = com.getBrC();
		}
	}
	
	var sigumgoC  = rpt.getSigumgoC();
	

	if(brNo == ""){brNo = com.getBrC();}

	//영업점 번호를 못받아오면 강제 설정
	if(brNo == "" || brNo.length < 4){
		
		//인천
		if(sigumgoC == "28"){
			brNo = "7127";//인천광역시청
		
		//충청북도	
		}else if(sigumgoC == "43"){
			brNo = "7173";//충북도청(출)
		
		//춘천시	
		}else if(sigumgoC == "110"){
			brNo = "7081";//춘천시청
		//춘천시	
		}else if(sigumgoC == "42"){
			brNo = "7051";//강원도청
		}
	}
	
	var _MICH030102R08In = scsObj.$w.getFrame().getObj("MICH030102R08In"); 
	_MICH030102R08In.set("BRNO", brNo);
	_MICH030102R08In.set("SL_GMGO_MODL_C", com.getSlGmgoModlC());
	
	// 전자보고서 직인파일 정보 조회
	rpt.dySubmissionRpt(scsObj, "sbm_branchstamp_inq", "SICH030102R08", "MICH030102R08In", "MICH030102R08Out");

	return scsObj.$w.getFrame().getObj("MICH030102R08Out").getJSON();
	
};


//전자보고서 조회
rpt.searchRpt = function (scsObj) {
	
	var userGubun = rpt.getUserGubun();//사용자구분
	
	if(scsObj._sbx_RptAcG != undefined)      scsObj.dataIn.set("RPT_AC_G_NM", scsObj._sbx_RptAcG.getText());
	if(scsObj._sbx_SitaxGutaxG != undefined) scsObj.dataIn.set("SITAX_GUTAX_NM", scsObj._sbx_SitaxGutaxG.getText());
	
	scsObj.dataIn.reform();
	

	scsObj.rptAprvStatOut.reset();
	

	// 전자결재 보고서인 경우 결재진행상태 정보 출력
	
	var rptId = scsObj.dataIn.get("RPT_ID");
	var rptAcG = scsObj.dataIn.get("RPT_AC_G");
	var sigumgoC = scsObj.dataIn.get("SIGUMGO_C");
	var isPopup = scsObj.dataIn.get("IS_POPUP");
	
	scsObj.rptInqrNm = "";
	
	
	// 회계구분 컴퍼넌트로 회계명을 가지고 온다(2020.08.06 설성윤)
	var rptJogn_DtlHoikyeC = "all";
	//if(scsObj._sbx_DtlHoikyeC != undefined && scsObj._uig_dtlHoikyeC.getStyle("display") != "none")
	if(scsObj._sbx_DtlHoikyeC != undefined)
	{
		var dataValue = scsObj.dataIn.get("DTL_HOIKYE_C");
		if(dataValue != "" && dataValue != "all")
		{
			rptJogn_DtlHoikyeC = dataValue;
			scsObj.rptInqrNm = scsObj._sbx_DtlHoikyeC.getText();
		}
	}
	
	// 계좌번호 컴퍼넌트로 계좌명을 가지고 온다(2020.08.06 설성윤)
	var rptJogn_SggAcno = "all";
	//if (scsObj._sbx_SggAcno != undefined && scsObj._uig_SggAcno.getStyle("display") != "none")
	
	if (scsObj._sbx_SggAcno != undefined)
	{
		var dataValue = scsObj.dataIn.get("SGG_ACNO");
		
		if(dataValue != "" && dataValue != "all")
		{
			rptJogn_DtlHoikyeC = "all";				// 계좌단위 조회시 상세회계번호 조회조건은 제외(2020.08.06 설성윤)
			rptJogn_SggAcno = dataValue;
			
			if (scsObj._dataList_SggAcno != undefined && scsObj._dataList_SggAcno.getRowCount() > 0)
			{
				var matchData = scsObj._dataList_SggAcno.getMatchedColumnData("SGG_ACNO", dataValue, "SIGUMGO_AC_NM", true);
				if(matchData.length > 0) scsObj.rptInqrNm = matchData[0];
			}
		}
	}
	
	
	/** 
	 * 기타조회조건(2020.09.09 설성윤 추가: 과오납환급일보의 환급구분, 특별징수정산 (세무과용)의 조회구분 등 필요시 개별 화면에서 JSON Array type으로 정의)
	 * sample: scsObj.rptEtcJochoiG = [{name:"환급구분", id:"TOUT_G", value:sbx_refundG.getValue(), text:sbx_refundG.getText()}];
	 */
	if (scsObj.rptEtcJochoiG == undefined) scsObj.rptEtcJochoiG = [];
	
	var rptDistGC = {};
	if (scsObj.rptEtcJochoiG.length != 0)
	{
		for(var i in scsObj.rptEtcJochoiG)
		{
			scsObj.rptInqrNm = scsObj.rptInqrNm + ", " + scsObj.rptEtcJochoiG[i].name + "=" + scsObj.rptEtcJochoiG[i].text;
			rptDistGC[scsObj.rptEtcJochoiG[i].id] = scsObj.rptEtcJochoiG[i].value;
		}
	}
	
	// DB 컬럼 SIZE가 VARCHAR 200 이라서 에러방지를 위해 제한(2020.09.09 설성윤) 
	//scsObj.rptInqrNm = com.getStringtoNByte(scsObj.rptInqrNm, 200);
	
	var rptRecv_OrgC = scsObj.dataIn.get("ORG_C");								// 보고서 수신 기관명 코드
	var rptRecv_OrgNm = scsObj._sbx_OrgC.getText();		// 보고서 수신 기관명
	var rptRecv_DeptC = scsObj.dataIn.get("DEPT_C");							// 보고서 수신 부서코드
	var rptRecv_DeptNm = scsObj._sbx_DeptC.getText();	// 보고서 수신 부서명

	var rptJogn_SiGuTaxG = (com.isEmpty(scsObj.dataIn.get("SITAX_GUTAX_G"))) ? "all" : scsObj.dataIn.get("SITAX_GUTAX_G");
	var rptJogn_HoikyeYr = (com.isEmpty(scsObj.dataIn.get("HOIKYE_YEAR"))) ? "all" : scsObj.dataIn.get("HOIKYE_YEAR");
	var rptJogn_BasDt = (com.isEmpty(scsObj.dataIn.get("BAS_DT"))) ? "all" : scsObj.dataIn.get("BAS_DT");
	var rptJogn_BasYM = (com.isEmpty(scsObj.dataIn.get("BAYM"))) ? "all" : scsObj.dataIn.get("BAYM");
	var rptJogn_BasQG = (com.isEmpty(scsObj.dataIn.get("BAS_QTR_G"))) ? "all" : scsObj.dataIn.get("BAS_QTR_G");
	var rptJogn_Sno = (com.isEmpty(scsObj.dataIn.get("SNO"))) ? "" : scsObj.dataIn.get("SNO");
	
	
	var rptNm = scsObj.$w.getFrame().getObj("MICH030102R06Out").get("RPT_NM");
	var rptG = scsObj.$w.getFrame().getObj("MICH030102R06Out").get("RPT_G");
	var txioG = scsObj.$w.getFrame().getObj("MICH030102R06Out").get("TXIO_G");
	var rptCyclG = scsObj.$w.getFrame().getObj("MICH030102R06Out").get("RPT_CYCL_G");
	
	
	
	var rptBas_Dttm;					// 보고서 보고기준일자

	//RPT_DTTM(보고기준일자)에 분기 또는 년월 또는 기준일자를 입력 한다.
	if(rptJogn_BasDt != 'all')					// 일일보고 또는 연간보고      
	{
		rptBas_Dttm = rptJogn_BasDt;
	}
	else if(rptJogn_BasYM != 'all')				// 월보고
	{
		var tmpYear = rptJogn_BasYM.substr(0,4);
		var tmpMonth =rptJogn_BasYM.substr(4,2);
		var tmpDay = ("00" + String((new Date(tmpYear, tmpMonth, "")).getDate())).slice(-2);	// 월말일
		rptBas_Dttm = tmpYear + tmpMonth + tmpDay;
	}
	else if(rptJogn_BasQG != 'all')				// 분기보고
	{
		var tmpYear = scsObj.dataIn.get("HOIKYE_YEAR");
		var tmpMonth = "";
		switch (rptJogn_BasQG) 
		{
			case "1" : tmpMonth = "03"; break;
			case "2" : tmpMonth = "06"; break;
			case "3" : tmpMonth = "09"; break;
			case "4" : tmpMonth = "12"; break;
			default  : tmpYear = ("0000" + String(WebSquare.util.parseInt(tmpYear,0) + 1)).slice(-4);		// 5분기인 경우 익년도
						tmpMonth = "03"; break;
		}
		var tmpDay = ("00" + String((new Date(tmpYear, tmpMonth, "")).getDate())).slice(-2);	// 월말일
		rptBas_Dttm = tmpYear + tmpMonth + tmpDay;
	}
	else rptBas_Dttm = "";
	
	// 전자보고서 결재진행상태 조회 In 데이터 셋팅
	
	scsObj.rptAprvStatIn.set("GEUMGO_CODE",  sigumgoC);											// 금고코드
	scsObj.rptAprvStatIn.set("RPT_ORG_C",  rptRecv_OrgC);										// 보고서 수신 기관명코드
	scsObj.rptAprvStatIn.set("RPT_ORG_NM",  rptRecv_OrgNm);										// 보고서 수신 기관명
	scsObj.rptAprvStatIn.set("RPT_DEPT_C",  rptRecv_DeptC);										// 보고서 수신 부서코드
	scsObj.rptAprvStatIn.set("RPT_DEPT_NM",  rptRecv_DeptNm);									// 보고서 수신 부서명
	scsObj.rptAprvStatIn.set("RPT_BRNO",  scsObj.dataIn.get("APRV_BRNO"));						// 보고서 보고 영업점번호
	scsObj.rptAprvStatIn.set("RPT_BRNM",  scsObj._sbx_Brno.getText());	                        // 보고서 보고 영업점명
	scsObj.rptAprvStatIn.set("RPT_ID" , rptId);													// 보고서ID
	scsObj.rptAprvStatIn.set("RPT_AC_G" ,  rptAcG);												// 보고서 보고구분
	scsObj.rptAprvStatIn.set("RPT_DTTM",  rptBas_Dttm);											// 보고기준일자
	scsObj.rptAprvStatIn.set("HOIKYE_YEAR",  rptJogn_HoikyeYr);									// 조회조건 회계년도
	scsObj.rptAprvStatIn.set("SITAX_GUTAX_G",  rptJogn_SiGuTaxG);								// 조회조건 시구세구분
	scsObj.rptAprvStatIn.set("DTL_HOIKYE_C",  rptJogn_DtlHoikyeC);								// 조회조건 상세회계코드
	scsObj.rptAprvStatIn.set("SGG_ACNO",  rptJogn_SggAcno);										// 조회조건 계좌번호
	scsObj.rptAprvStatIn.set("RPT_DISTG_C",  JSON.stringify(rptDistGC));						// 조회조건 기타(기타조회조건(2020.09.09 설성윤 추가)
	scsObj.rptAprvStatIn.set("BAS_DT",  rptJogn_BasDt);											// 조회조건 기준일자
	scsObj.rptAprvStatIn.set("BAYM",  rptJogn_BasYM);											// 조회조건 기준년월
	scsObj.rptAprvStatIn.set("BAS_QTR_G",  rptJogn_BasQG);										// 조회조건 기준분기
	scsObj.rptAprvStatIn.set("RPT_NM",  rptNm);													// 보고서명
	scsObj.rptAprvStatIn.set("RPT_G",  rptG);													// 보고서구분
	scsObj.rptAprvStatIn.set("TXIO_G",  txioG);													// 계좌구분
	scsObj.rptAprvStatIn.set("RPT_CYCL_G",  rptCyclG);											// 보고기한
	scsObj.rptAprvStatIn.set("INQR_NM",  scsObj.rptInqrNm);										// 조회명
	scsObj.rptAprvStatIn.set("SNO",  rptJogn_Sno);												// 보고서번호
	scsObj.rptAprvStatIn.set("IS_POPUP",  isPopup);												// 결재팝업여부
	
	

	rpt.dySubmissionRpt(scsObj, "sbm_aprv_inq", "SICH030102R07", "MICH030102R07In", "MICH030102R07Out");		// 전자보고서 결재진행상태 조회
	
};


//동적 서브미션 (sbmId:서브미션ID, svcNm:서비스이름, msgId:데이터컬렉션IN, msgOut:데이터컬렉션OUT)
rpt.dySubmissionRpt = function(scsObj, sbmId, svcNm, msgId, msgOut){
	
	//동적서브미션 옵션 설정(기관별일괄상신 기능을 위해 asynchronous에서 synchronous로 변경: 2020.05.29 설성윤)
	var sbm_option = {
	    mode : "synchronous", 
	    id : sbmId,
	    ref : 'data:json,["'+msgId+'"]',
	    target : 'data:json,["'+msgOut+'"]',
	    mediatype : "application/json" ,
	    processMsg : "해당 작업을 처리중입니다",
        action : "",
	    userData1 : [{svc_id : svcNm, msg_id: msgId, sbm_id : sbmId, isshowMsg:true}]
	};
	
	//동적 서브미션 핸들러 함수(콜백) : 호출순서: 기관담당 영업점번호 조회->최종 집계일자 조회->보고서 수신기관 리스트 조회->보고서 수신부서 리스트 조회->결재진행상태 조회->클립보고서뷰
	sbm_option.submitDoneHandler = function(e) {
		// 보고서 정보 조회(전자보고 대상여부 체크 및 전자결재 UI 표출 처리) 
		if (sbmId == "sbm_rptinf_inq")
		{	
			
			// 보고서정보 테이블에 전자보고용여부가 N 이면 전자보고대상 아닌것으로 처리(2020.12.15 설성윤)
			if (scsObj.$w.getFrame().getObj("MICH030102R06Out").get("RPT_ID") == "" || scsObj.$w.getFrame().getObj("MICH030102R06Out").get("DEPT_C_USE_YN") == "N") 
			{
				scsObj.gyljYn = "N";
			} 
			else 
			{
				scsObj.gyljYn = "Y";
			}
		}
		/*
		// 결재진행상태 조회 콜백
		else if(sbmId == "sbm_aprv_inq")
		{
			// 일괄결제가 아닌경우 데이터 컬렉션 셋팅, 결재진행정보 화면출력 및 버튼 설정, 클립리포트 생성
			if(scsObj.isClipReportView)
			{
				rpt.setValueAprvInfo(scsObj);
				rpt.clipReportView(scsObj, "YYYYY", scsObj.$w.getFrame().getObj("ifm_ErpRpt"));
				
				//선택결제 자동 처리
			    if (scsObj.param_data != undefined && scsObj.param_data.CHK_GYULJE_YN == "Y") {
			    	var gyljK = "";
			    	if (scsObj.rptAprvStatOut.get("SANGSIN_YN") == "Y")	gyljK = "1";
			    	else if (scsObj.rptAprvStatOut.get("RE_SANGSIN_YN") == "Y")	gyljK = "2";
			    	else if (scsObj.rptAprvStatOut.get("GYLJ_YN") == "Y")	gyljK = "4";
			    	
			    	if (gyljK != "")
			    		scsObj.$w.getFrame().getObj("com").popup_open(rpt.RptGylj_popUp(scsObj, gyljK, "scsObj.chkGyuljeYN_callback"));
			    	else
			    		scsObj.chkGyuljeYN_callback();
			    }				
			}
		}
		*/
		
	};
	
	gcm.IS_TR = true;
	
	//동적 서비스 미션 실행
	scsObj.$w.getFrame().getObj("com").executeSubmission_dynamic(sbm_option);
};




//Output DataList ID로 호출 구분코드명을 구한다
rpt.getInitlCNm = function (dataListID){
	var initlCNm = "";
	
	switch (dataListID)
	{
		case "MCommonComboR56OutList" :  initlCNm = "APRV_BRNO"; break;
		case "MCommonComboR51OutList" :  initlCNm = "ORG_G"; break;
		case "MCommonComboR41OutList" :  initlCNm = "ORG_C"; break;
		case "MCommonComboR47OutList" :  initlCNm = "DEPT_C"; break;
		case "MCommonComboR04OutList" :  initlCNm = "GOV_G"; break;
		case "MCommonComboR09OutList" :  initlCNm = "GOV_G_09"; break;
		case "MCommonComboR49OutList" :  initlCNm = "SGG_ACNO"; break;
		case "MCommonComboR10OutList" :  initlCNm = "HOIKYE_C"; break;
	}
	
	return initlCNm;
};





rpt.changeSearchComboList = function (callFuncName, scsObj) {

	if (scsObj.dataIn.get("RPT_AC_G") == "" || scsObj.dataIn.get("AC_SEARCH_G") == "")
	{
		scsObj.dataIn.set("skipRunOnModelChange", "N");
		return;
	}

	scsObj.dataIn.set("skipRunOnModelChange", "Y");

	var isAprvBrnoSetted = false;
	if(callFuncName == 'sbx_Brno_onviewchange') isAprvBrnoSetted = true;
	else if(scsObj._dataList_AprvBrno != undefined)
	{
		// 최초 로딩 또는 조회대상구분이 변경(공무원 제외)된 경우
		if(scsObj._dataList_AprvBrno.getTotalRow() == 0 || 
			(gcm.LOGIN.BR_C != '0' && (scsObj.AcSearchG_OldValue != scsObj.dataIn.get("AC_SEARCH_G") || 
			(scsObj.dataIn.get("AC_SEARCH_G") == 'R' && (scsObj.RptID_OldValue != scsObj.dataIn.get("RPT_ID") || callFuncName == 'sbx_RptAcG_onchange')))))
		{
			// 조회대상이 보고대상인 경우 보고영업점 콤보 -미지정- ITEM 삭제(공무원 제외)
			if(gcm.LOGIN.BR_C != '0')
			{
				if(scsObj.dataIn.get("AC_SEARCH_G") == 'R') scsObj._sbx_Brno.options.chooseOption = false;
				else scsObj._sbx_Brno.options.chooseOption = true;
			}
			
			var initlCNm = rpt.getInitlCNm(scsObj._sbx_Brno.getDataListInfo().id);
			rpt.dataChangeSearch(initlCNm, scsObj.dataIn, scsObj.$w);
			scsObj.dataIn.set("APRV_BRNO",scsObj._sbx_Brno.getValue());
			console.log("["+callFuncName+"] dataChangeSearch('"+initlCNm+"'), RPT_ID="+scsObj.dataIn.get("RPT_ID")+", RPT_AC_G="+scsObj.dataIn.get("RPT_AC_G")+", AcSearchG_OldValue="+scsObj.AcSearchG_OldValue+", AC_SEARCH_G="+scsObj.dataIn.get("AC_SEARCH_G"));

			// 사용자가 보고영업점 변경시 처리
			if(!com.isEmpty(scsObj.param_data))
			{
				console.log("    => ["+callFuncName+"] param_data scsObj.dataIn.set('APRV_BRNO', "+scsObj.param_data.RPT_BRNO+")");
				scsObj.dataIn.set("APRV_BRNO", scsObj.param_data.RPT_BRNO);
				isAprvBrnoSetted = true;
			}
			else if(gcm.LOGIN.BR_C > 1000)		// 은행 영업점 사용자: 소속 영업점
			{
				console.log("    => ["+callFuncName+"] gcm.LOGIN scsObj.dataIn.set('APRV_BRNO', "+gcm.LOGIN.BR_C+")");
				scsObj.dataIn.set("APRV_BRNO", gcm.LOGIN.BR_C);
				isAprvBrnoSetted = true;
			}
			else if(gcm.LOGIN.BR_C != '0')		// 은행 본부 사용자: 서소문청사(출)
			{
				console.log("    => ["+callFuncName+"] gcm.LOGIN scsObj.dataIn.set('APRV_BRNO', '7302')");
				scsObj.dataIn.set("APRV_BRNO", '7302');
				isAprvBrnoSetted = true;
			}
			else 								// 기관 사용자: 보고영업점 -미지정- 으로 변경하여 아래 전체 기관,부서,계좌 가져오도록
			{
				scsObj.dataIn.set("APRV_BRNO", "-1");							
			}
		}
	}

	var _BrnoJSON = undefined;
	
	scsObj.OrgG_OldValue = scsObj.dataIn.get("ORG_G");									// 변경전 기관구분
	scsObj.OrgC_OldValue = scsObj.dataIn.get("ORG_C");									// 변경전 기관명
	scsObj.DeptC_OldValue = scsObj.dataIn.get("DEPT_C");								// 변경전 부서명
	scsObj.AprvBrno_OldValue = scsObj.dataIn.get("APRV_BRNO");                          // 변경전 보고영업점
	scsObj.dtlHoikeyC_OldValue = scsObj.dataIn.get("DTL_HOIKYE_C");						// 변경전 상세회계번호
	scsObj.SggAcno_OldValue = scsObj.dataIn.get("SGG_ACNO");							// 변경전 계좌번호
	scsObj.AprvBrno_Value = scsObj.dataIn.get("APRV_BRNO");
	
	if(isAprvBrnoSetted == true)
	{
		if(callFuncName != 'sbx_Brno_onviewchange' && !com.isEmpty(scsObj.param_data))
		{
			// 시구세구분을 기관/부서/회계/계좌 RELOAD전에 가장먼저 설정 필요 
			if(scsObj.dataIn.getKey("SITAX_GUTAX_G") != null && scsObj.param_data.SITAX_GUTAX_G != scsObj.dataIn.get("SITAX_GUTAX_G"))
			{
				console.log("    => ["+callFuncName+"] param_data scsObj.dataIn.set('SITAX_GUTAX_G', '"+scsObj.param_data.SITAX_GUTAX_G+"')");
				scsObj.dataIn.set("SITAX_GUTAX_G", scsObj.param_data.SITAX_GUTAX_G);
			}
		}
		else if(scsObj._dataList_AprvBrno != undefined && scsObj._dataList_AprvBrno.getTotalRow() != 0 && isAprvBrnoSetted == true)
		{
			_BrnoJSON = com.getMatchedFirstJSON(scsObj._dataList_AprvBrno, "BRNO", scsObj.dataIn.get("APRV_BRNO"));
			
			// 시구세구분을 기관/부서/회계/계좌 RELOAD전에 가장먼저 설정 필요 
			if(scsObj.dataIn.getKey("SITAX_GUTAX_G") != null && scsObj.dataIn.get("SITAX_GUTAX_G") != "all" && _BrnoJSON.SITAX_GUTAX_G != scsObj.dataIn.get("SITAX_GUTAX_G"))
			{
				console.log("    => ["+callFuncName+"] _BrnoJSON scsObj.dataIn.set('SITAX_GUTAX_G', '"+_BrnoJSON.SITAX_GUTAX_G+"')");
				scsObj.dataIn.set("SITAX_GUTAX_G", _BrnoJSON.SITAX_GUTAX_G);
			}
		}
	}

	if(scsObj._dataList_OrgG != undefined)
	{
		// 초기 로딩 또는 기관구분콤보 활성화 상태
		if(scsObj._dataList_OrgG.getTotalRow() == 0 || scsObj._sbx_OrgG.getDisabled() == false)
		{
			// 최초 로딩 또는 조회대상구분이 변경(공무원 제외)된 경우
			if(scsObj._dataList_OrgG.getTotalRow() == 0 || (callFuncName != 'sbx_OrgG_onchange' && !(gcm.LOGIN.BR_C == '0' && callFuncName == "sbx_AcSearchG_onchange")))
			{
				var initlCNm = rpt.getInitlCNm(scsObj._sbx_OrgG.getDataListInfo().id);
				rpt.dataChangeSearch(initlCNm, scsObj.dataIn, scsObj.$w);
				scsObj.dataIn.set("ORG_G",scsObj._sbx_OrgG.getValue());
				console.log("["+callFuncName+"] dataChangeSearch('"+initlCNm+"'), ORG_G="+scsObj.dataIn.get("ORG_G")+", OLD_ORG_G="+scsObj.OrgG_OldValue+", APRV_BRNO="+scsObj.dataIn.get("APRV_BRNO"));
			}

			// 보고영업점을 변경한 경우 
			if(callFuncName == 'sbx_Brno_onviewchange')
			{
				// 조회대상 all 일때
				if(scsObj.dataIn.get("AC_SEARCH_G") == 'all')
				{
					if(_BrnoJSON != undefined && _BrnoJSON.ORG_G != scsObj.dataIn.get("ORG_G"))
					{
						console.log("    => ["+callFuncName+"] _BrnoJSON scsObj.dataIn.set('ORG_G', '"+_BrnoJSON.ORG_G+"')");
						scsObj.dataIn.set("ORG_G", _BrnoJSON.ORG_G);
					}
				}
			}
			// 최초 호출(OLD 기관구분값 없는)인 경우
			else if(scsObj.OrgG_OldValue == '')
			{
				// 보고서조회에서 호출한 경우
				if(!com.isEmpty(scsObj.param_data))
				{
					if(scsObj.param_data.ORG_G != scsObj.dataIn.get("ORG_G"))
					{
						console.log("    => ["+callFuncName+"] param_data scsObj.dataIn.set('ORG_G', '"+scsObj.param_data.ORG_G+"')");
						scsObj.dataIn.set("ORG_G", scsObj.param_data.ORG_G);
					}
				}
				// 사용자 소속 또는 담당 기관이 있는 경우
				else if(gcm.LOGIN.ORG_G != '')
				{
					if(gcm.LOGIN.ORG_G != scsObj.dataIn.get("ORG_G"))
					{
						console.log("    => ["+callFuncName+"] gcm.LOGIN scsObj.dataIn.set('ORG_G', '"+gcm.LOGIN.ORG_G+"')");
						scsObj.dataIn.set("ORG_G", gcm.LOGIN.ORG_G);
					}
				}
			}
			// 조회대상 all 일때
			else if(scsObj.dataIn.get("AC_SEARCH_G") == 'all')
			{
				if(_BrnoJSON != undefined && _BrnoJSON.ORG_G != scsObj.dataIn.get("ORG_G"))
				{
					console.log("    => ["+callFuncName+"] _BrnoJSON scsObj.dataIn.set('ORG_G', '"+_BrnoJSON.ORG_G+"')");
					scsObj.dataIn.set("ORG_G", _BrnoJSON.ORG_G);
				}
			}
		}
	}

	if(scsObj._dataList_OrgC != undefined)
	{
		// 초기 로딩 또는 기관명콤보 활성화 상태
		if(scsObj._dataList_OrgC.getTotalRow() == 0 || scsObj._sbx_OrgC.getDisabled() == false)
		{
			// 최초 로딩 또는 공무원이 조회대상구분이 변경(공무원 제외)된 경우
			if(scsObj._dataList_OrgC.getTotalRow() == 0 || (callFuncName != 'sbx_OrgC_onchange' && !(gcm.LOGIN.BR_C == '0' && callFuncName == "sbx_AcSearchG_onchange")))
			{
				var initlCNm = rpt.getInitlCNm(scsObj._sbx_OrgC.getDataListInfo().id);
				rpt.dataChangeSearch(initlCNm, scsObj.dataIn, scsObj.$w);
				scsObj.dataIn.set("ORG_C",scsObj._sbx_OrgC.getValue());
				console.log("["+callFuncName+"] dataChangeSearch('"+initlCNm+"'), ORG_C="+scsObj.dataIn.get("ORG_C")+", OLD_ORG_C="+scsObj.OrgC_OldValue+", APRV_BRNO="+scsObj.dataIn.get("APRV_BRNO"));
			}
			
			// 기관구분이 없거나 기관명이 전체가 아닌 경우 해당 기관으로 초기 설정
			if(scsObj._sbx_OrgG == undefined || scsObj._uig_OrgG.getStyle("display") == "none" || scsObj._sbx_OrgC.getValue() != "all" || !com.isEmpty(scsObj.param_data))
			{
				// 보고영업점을 변경한 경우 
				if(callFuncName == 'sbx_Brno_onviewchange')
				{
					// 조회대상 all 일때
					if(scsObj.dataIn.get("AC_SEARCH_G") == 'all')
					{
						if(_BrnoJSON != undefined && _BrnoJSON.ORG_C != scsObj.dataIn.get("ORG_C"))
						{
							console.log("    => ["+callFuncName+"] _BrnoJSON scsObj.dataIn.set('ORG_C', '"+_BrnoJSON.ORG_C+"')");
							scsObj.dataIn.set("ORG_C", _BrnoJSON.ORG_C);
						}
					}
				}
				// 최초 호출(OLD 기관구분값 없는)인 경우
				else if(scsObj.OrgC_OldValue == '')
				{
					// 보고서조회에서 호출한 경우
					if(!com.isEmpty(scsObj.param_data))
					{
						if(scsObj.param_data.ORG_C != scsObj.dataIn.get("ORG_C"))
						{
							console.log("    => ["+callFuncName+"] param_data scsObj.dataIn.set('ORG_C', '"+scsObj.param_data.ORG_C+"')");
							scsObj.dataIn.set("ORG_C", scsObj.param_data.ORG_C);
						}
					}
					// 사용자 소속 또는 담당 기관이 있는 경우
					else if(gcm.LOGIN.PADM_STD_ORG_C != '')
					{
						if(gcm.LOGIN.PADM_STD_ORG_C != scsObj.dataIn.get("ORG_C"))
						{
							console.log("    => ["+callFuncName+"] gcm.LOGIN scsObj.dataIn.set('ORG_C', '"+gcm.LOGIN.PADM_STD_ORG_C+"')");
							scsObj.dataIn.set("ORG_C", gcm.LOGIN.PADM_STD_ORG_C);
						}
					}
				}
				// 조회대상 all 일때
				else if(scsObj.dataIn.get("AC_SEARCH_G") == 'all')
				{
					if(_BrnoJSON != undefined && _BrnoJSON.ORG_C != scsObj.dataIn.get("ORG_C"))
					{
						console.log("    => ["+callFuncName+"] _BrnoJSON scsObj.dataIn.set('ORG_C', '"+_BrnoJSON.ORG_C+"')");
						scsObj.dataIn.set("ORG_C", _BrnoJSON.ORG_C);
					}
				}
			}
		}
	}

	if(scsObj._dataList_DeptC != undefined)
	{
		if((scsObj.OrgC_OldValue != 'all' || scsObj.dataIn.get("ORG_C") != 'all') && (scsObj._dataList_DeptC.getTotalRow() == 0 || scsObj._sbx_DeptC.getDisabled() == false))	// 공무원의 경우 초기 로딩외, 비활성화된 부서콤보 변경불필요
		{
			if(scsObj._dataList_DeptC.getTotalRow() == 0 || callFuncName == "sbx_AcSearchG_onchange" || scsObj.OrgC_OldValue != scsObj.dataIn.get("ORG_C") || scsObj.dataIn.get("AC_SEARCH_G") == 'R')
			{
				var initlCNm = rpt.getInitlCNm(scsObj._sbx_DeptC.getDataListInfo().id);
				rpt.dataChangeSearch(initlCNm, scsObj.dataIn, scsObj.$w);
				scsObj.dataIn.set("DEPT_C",scsObj._sbx_DeptC.getValue());
				console.log("["+callFuncName+"] dataChangeSearch('"+initlCNm+"'), DEPT_C="+scsObj.dataIn.get("DEPT_C")+", OLD_DEPT_C="+scsObj.DeptC_OldValue+", APRV_BRNO="+scsObj.dataIn.get("APRV_BRNO"));
			}
			
			if(callFuncName != 'sbx_Brno_onviewchange' && !com.isEmpty(scsObj.param_data))
			{
				if(scsObj.param_data.DEPT_C != scsObj.dataIn.get("DEPT_C"))
				{
					console.log("    => ["+callFuncName+"] scsObj.param_data scsObj.dataIn.set('DEPT_C', '"+scsObj.param_data.DEPT_C+"')");
					scsObj.dataIn.set("DEPT_C", scsObj.param_data.DEPT_C);
				}
			}
		}
	}
	
	if(scsObj._dataList_DtlHoikeyC != undefined && scsObj._uig_dtlHoikyeC.getStyle("display") != "none")
	{
		if(scsObj.OrgC_OldValue != 'all' || scsObj.dataIn.get("ORG_C") != 'all')
		{
			var initlCNm = rpt.getInitlCNm(scsObj._sbx_DtlHoikyeC.getDataListInfo().id);
			rpt.dataChangeSearch(initlCNm, scsObj.dataIn, scsObj.$w);
			console.log("["+callFuncName+"] dataChangeSearch('"+initlCNm+"'), DTL_HOIKYE_C="+scsObj.dataIn.get("DTL_HOIKYE_C")+", OLD_DTL_HOIKYE_C="+scsObj.dtlHoikeyC_OldValue+", SITAX_GUTAX_G="+scsObj.dataIn.get("SITAX_GUTAX_G")+", APRV_BRNO="+scsObj.dataIn.get("APRV_BRNO"));
		}
		
		if(callFuncName != 'sbx_Brno_onviewchange' && !com.isEmpty(scsObj.param_data))
		{
			if(scsObj.dtlHoikeyC_OldValue == 'all' && scsObj.dtlHoikeyC_OldValue != scsObj.param_data.DTL_HOIKYE_C)
			{
				console.log("    => ["+callFuncName+"] param_data scsObj.dataIn.set('DTL_HOIKYE_C', '"+scsObj.param_data.DTL_HOIKYE_C+"')");
				scsObj.dataIn.set("DTL_HOIKYE_C", scsObj.param_data.DTL_HOIKYE_C);
			}
		}
	}
	
	if(scsObj._dataList_SggAcno != undefined && scsObj._uig_SggAcno.getStyle("display") != "none")
	{ 
		if(scsObj.OrgC_OldValue != 'all' || scsObj.dataIn.get("ORG_C") != 'all')
		{
			var initlCNm = rpt.getInitlCNm(scsObj._sbx_SggAcno.getDataListInfo().id);
			rpt.dataChangeSearch(initlCNm, scsObj.dataIn, scsObj.$w);
			console.log("["+callFuncName+"] dataChangeSearch('"+initlCNm+"'), SGG_ACNO="+scsObj.dataIn.get("SGG_ACNO")+", OLD_SGG_ACNO="+scsObj.SggAcno_OldValue+", SITAX_GUTAX_G="+scsObj.dataIn.get("SITAX_GUTAX_G")+", APRV_BRNO="+scsObj.dataIn.get("APRV_BRNO"));
		}
		
		if(callFuncName != 'sbx_Brno_onviewchange' && !com.isEmpty(scsObj.param_data))
		{
			if(scsObj.SggAcno_OldValue == 'all' && scsObj.SggAcno_OldValue != scsObj.param_data.SGG_ACNO)
			{
				console.log("    => ["+callFuncName+"] param_data scsObj.dataIn.set('SGG_ACNO', '"+scsObj.param_data.SGG_ACNO+"')");
				scsObj.dataIn.set("SGG_ACNO", scsObj.param_data.SGG_ACNO);
			}
		}
	}
	
	if(callFuncName != 'sbx_Brno_onviewchange' && scsObj._dataList_AprvBrno != undefined)
	{
		if(isAprvBrnoSetted == false && ((scsObj._sbx_OrgG != undefined && scsObj.dataIn.get("ORG_G") != "-1") || scsObj.dataIn.get("ORG_C") != "all"))
		{
			console.log("["+callFuncName+"] rpt.searchAprvBrno, SITAX_GUTAX_G="+scsObj.dataIn.get("SITAX_GUTAX_G")+", DTL_HOIKYE_C="+scsObj.dataIn.get("DTL_HOIKYE_C")+", SGG_ACNO="+scsObj.dataIn.get("SGG_ACNO")+", APRV_BRNO="+scsObj.dataIn.get("APRV_BRNO"));
			rpt.searchAprvBrno(scsObj);
		}
		else
		{
			rpt.resetAprvBrno(scsObj);	// 보고영업점 검색용 조회조건 초기화해야 보고구분 변경시 보고영업점 검색한다.
		}
	}
	
	rpt.inputCheckCommon(scsObj, callFuncName);

	scsObj.RptID_OldValue = scsObj.dataIn.get("RPT_ID");
	scsObj.AcSearchG_OldValue = scsObj.dataIn.get("AC_SEARCH_G");
	
	scsObj.dataIn.set("skipRunOnModelChange", "N"); 

};



//기타조회조건 SET(2020.09.09 설성윤 추가: 과오납환급일보의 환급구분, 특별징수정산 (세무과용)의 조회구분 등)
rpt.setEtcJohoiG = function (scsObj) {
	
	var rptDistGC = JSON.parse(scsObj.param_data.RPT_DISTG_C, "{}");
	
	var _keys = Object.keys(rptDistGC);
	for(var i in _keys)
	{
		scsObj.dataIn.set(_keys[i], rptDistGC[_keys[i]]);
	}
	
};
 



//보고서 결재 공통 팝업 호출
rpt.app_popUp = function(menuUrl, menuNm, dataParam, closeActionNm, callBackNm) { 
	
	if(closeActionNm == ""){closeActionNm = callBackNm;}
	
	// 팝업 (윈도우 팝업 type:"window:레이어","browser:새창" 모달 :"modal:true" 모달리스:"modal:false")
	var popOps = { 
		url:menuUrl
		,width:"1300"
		,height:"910"
		,data:dataParam
		,useHeader:true
		,popup_name:menuNm
		,closeAction:closeActionNm
		,callbackFn:callBackNm
	};
	
	return popOps;
};


//클립리포트 iframe화면 호출 (공통)
rpt.sfiClipReportView = function(dataIn, clipId, btnUse, ifmClRpt, newGbn) {	
	if(dataIn.reform != undefined) dataIn.reform();
	if (typeof newGbn == 'undefined') newGbn = false;	
						
	var reportInfo = {};
	
	var paramJson = dataIn
	if(dataIn.initializeType == 'dataMap') {
		paramJson = dataIn.getJSON();
	}
	
	for(const key in paramJson){
		reportInfo[key] = paramJson[key];
	}
	
	reportInfo.BTN_USE = btnUse.substr(0,5);
	reportInfo.PG_SIZE = "2";							// defaultRatio: 0:50%, 1:75%, 2:100%, 3:125%, ...(2020.06.12 ??????)
	reportInfo.MOD_ID = "rpt";
	reportInfo.CLIP_ID = clipId;
	reportInfo.DB_NAME = "ictcon";

	reportInfo.LOGIN_USER_NM = gcm.LOGIN.USER_NM;		//로그인 사용자명
	reportInfo.LOGIN_ORG_CD = gcm.LOGIN.PADM_STD_ORG_C;	//로그인 기관코드
	reportInfo.LOGIN_ORG_NM = gcm.LOGIN.ORG_NM;			//로그인 기관명
	reportInfo.LOGIN_DEPT_CD = gcm.LOGIN.SL_GMGO_DEPT_C;//로그인 부서 코드(공무원)
	reportInfo.LOGIN_DEPT_NM = gcm.LOGIN.DEPT_NM;		//로그인 부서명(공무원)
	reportInfo.LOGIN_BR_C = gcm.LOGIN.BR_C;				//로그인 영업점번호(은행직원)
	reportInfo.LOGIN_BR_NM = gcm.LOGIN.BR_NM;			//로그인 영업점명(은행직원)
	reportInfo.CMD = "";
	reportInfo.SEAL_SRC = "";
	reportInfo.VERTICAL = "horizon";
	reportInfo.NOBARCODE = "Y";
	
	var userGubun = rpt.getUserGubun();
	if(userGubun == "BANK"){
		reportInfo.PARAM0 = gcm.LOGIN.BR_NM;
	}
	
	//리포트 전달 동적 file .cfr
	reportInfo.CLIP_ID_LENGTH = "0";
	
	// 일괄출력 구분 코드 세팅 - 보고서 일괄출력에서 사용
	reportInfo.ISBUNDLE = "";
	
	console.log("JSON.stringify(reportInfo)="+JSON.stringify(reportInfo));
	
	com.setSessionData("reportInfo",JSON.stringify(reportInfo));
	
	ifmClRpt.setSrc("/ui/tom/sfi/sfi/xml/SFI100402P01.xml");
	
	// 리포트 높이 조절
	rpt.ifmReSizeHeight(ifmClRpt);
};


//클립리포트 팝업창 호출 (공통)
rpt.sfiClipReportPopUp = function(dataIn, clipId, popupName, jsonNm, paramStr, newGbn) {
	
	if(dataIn.reform != undefined) dataIn.reform();
	if (typeof newGbn == 'undefined') newGbn = false;

	var btnUse = "YYYYY";
	var reportInfo = {};
	var reportJsonInfo = {};
	
	var paramJson = dataIn
	if(dataIn.initializeType == 'dataMap') {
		paramJson = dataIn.getJSON();
	}
	
	for(const key in paramJson){
		reportInfo[key] = paramJson[key];
	}
	
	reportInfo.BTN_USE = btnUse;
	reportInfo.PG_SIZE = "2";							// defaultRatio: 0:50%, 1:75%, 2:100%, 3:125%, ...(2020.08.24 ??????)
	reportInfo.MOD_ID = "rpt";
	reportInfo.CLIP_ID = clipId;
	reportInfo.DB_NAME = "ictcon";

	reportInfo.LOGIN_USER_NM = gcm.LOGIN.USER_NM;		//로그인 사용자명
	reportInfo.LOGIN_ORG_CD = gcm.LOGIN.PADM_STD_ORG_C;	//로그인 기관코드
	reportInfo.LOGIN_ORG_NM = gcm.LOGIN.ORG_NM;			//로그인 기관명
	reportInfo.LOGIN_DEPT_CD = gcm.LOGIN.SL_GMGO_DEPT_C;//로그인 부서 코드(공무원)
	reportInfo.LOGIN_DEPT_NM = gcm.LOGIN.DEPT_NM;		//로그인 부서명(공무원)
	reportInfo.LOGIN_BR_C = gcm.LOGIN.BR_C;				//로그인 영업점번호(은행직원)
	reportInfo.LOGIN_BR_NM = gcm.LOGIN.BR_NM;			//로그인 영업점명(은행직원)
	reportInfo.CMD = jsonNm;
	reportInfo.SEAL_SRC = "";
	reportInfo.VERTICAL = "horizon";
	reportInfo.NOBARCODE = "Y";
	reportInfo.SEAL_SIGN = "";
	reportInfo.IC_CONN_ACCT = "";
	//reportJsonInfo.RESULT = dataIn;

	
	//리포트 전달 동적 파라미터 생성 및 값 설정
	reportInfo.PARAM0 = gcm.LOGIN.DEPT_NM;

	//리포트 전달 동적 file .cfr
	reportInfo.CLIP_ID_LENGTH = "0";
	
	// 일괄출력 구분 코드 세팅 - 보고서 일괄출력에서 사용
	reportInfo.ISBUNDLE = "";
	
	var spVal = (!com.isEmpty(paramStr)) ? paramStr.split(",") : [];
	var paramName = "PARAM";
	
	for(var i=1; i<= spVal.length; i++){
		paramName = "PARAM";
		paramName = paramName+i;
		reportInfo[paramName] = spVal[i-1];
	}
					
	//출력 시간 설정
	var today = new Date();
	var year = today.getFullYear();
	var month = today.getMonth()+1;
	if(month < 10){month = "0"+month;}
	var day = today.getDate();
	if(day < 10){day = "0"+day;}
	var dateString = year+"-"+month+"-"+day;
	
	
	var hours = today.getHours()+1;
	if(hours < 10){hours = "0"+hours;}
	var minutes = today.getMinutes()+1;
	if(minutes < 10){minutes = "0"+minutes;}
	var seconds = today.getSeconds()+1;
	if(seconds < 10){seconds = "0"+seconds;}
	var timeString = hours+":"+minutes+":"+seconds;
	
	reportInfo.PRINT_DATE = "출력일시 : " +dateString+" "+timeString;
	reportInfo.PRINT_MAN = "출력자 : " + gcm.LOGIN.USER_NM + "(아이디 : " + gcm.LOGIN.USER_ID +  ")";
	
	console.log("JSON.stringify(reportInfo)="+JSON.stringify(reportInfo));
	console.log("JSON.stringify(reportJsonInfo)="+JSON.stringify(reportJsonInfo));

	com.setSessionData("reportInfo",JSON.stringify(reportInfo));
	com.setSessionData("reportJsonInfo",JSON.stringify(reportJsonInfo));
	
	var popOps = { 
			url:"/ui/tom/sfi/sfi/xml/SFI100402P01.xml"
			,width:"1024"
			,height:"950"
			,useHeader:true
			,type:"browser"
			,modal:false
			,popup_name:popupName
			,callbackFn:"scsObj.popCallBack"
		};
	
	return popOps;

};