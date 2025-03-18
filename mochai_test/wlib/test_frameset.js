// 테스트 환경 설정용 JS 파일

// Mock 데이터 설정
$.mock('getFrameId', 'set', 'testFrame001');

// 전역 함수 등록 예시
registerGlobal('uiplugin.popup', function(){
    console.log('Mock Popup plugin activated for testing.');
});

// com.executeSvc Mock 설정 추가 (indexOf 오류 해결)
window.com = window.com || {};

// scsObj 객체 생성 및 초기화
var scsObj = {};

scsObj.sigumgoC = '28';
scsObj.slGmgoModlC = 'MOD123';
scsObj.gunC = 'GUNGU001';
scsObj.fromRow = 0;
scsObj.toRow = 100;
scsObj.pageMaxNum = 100;
scsObj.isFirstSearch = true;
scsObj.isReport = "N";

// 필요한 함수 Mock 설정
scsObj.getSysJunDate = function(){
    console.log('Mock getSysJunDate executed.');
};

scsObj.searchCombo01 = function(){
    console.log('Mock searchCombo01 executed.');
};

scsObj.setCommonCombo = function(){
    console.log('Mock setCommonCombo executed.');
};

scsObj.validate = function(){
    console.log('Mock validate executed.');
    return true;
};

scsObj.setScrollPaging = function(sbmId){
    console.log('Mock setScrollPaging executed with:', sbmId);
};

scsObj.grdColor = function(){
    console.log('Mock grdColor executed.');
};

// 더미 콜백 함수 설정
scsObj.popOrgGCallBack = function(arg){
    console.log('Mock popOrgGCallBack:', arg);
};

scsObj.orgNmInqrPopCallBack = function(arg){
    console.log('Mock orgNmInqrPopCallBack:', arg);
};

scsObj.deptInqrPopCallBack = function(arg){
    console.log('Mock deptInqrPopCallBack:', arg);
};

scsObj.btn_sggAcno_popCallBack = function(arg){
    console.log('Mock btn_sggAcno_popCallBack:', arg);
};


scsObj.dataIn = {
    removeAll: () => {},
    reform: () => {},
    setJSON: () => {},
    getTotalRow: () => {},
    getAllJSON: () => {return []},
    get: () => {},
    set: () => {}
};

scsObj.rptAprvStatIn = {
    reset: function(){ console.log('rptAprvStatIn reset executed.'); },
    set: function(key, val){ console.log('rptAprvStatIn set', key, val); }
};

scsObj.rptAprvStatOut = {
    reset: function(){ console.log('rptAprvStatOut reset executed.'); },
    set: function(key, val){ console.log('rptAprvStatOut set', key, val); }
};

scsObj._sbx_OrgC = {
    get: function(){ console.log('_sbx_OrgC get executed.'); },
    getText: function(){ console.log('_sbx_OrgC get executed.'); },
    set: function(key, val){ console.log('_sbx_OrgC set', key, val); }
};

scsObj._sbx_DeptC = {
    get: function(){ console.log('_sbx_DeptC get executed.'); },
    getText: function(){ console.log('_sbx_DeptC get executed.'); },
    set: function(key, val){ console.log('_sbx_DeptC set', key, val); }
};

scsObj._sbx_Brno = {
    get: function(){ console.log('_sbx_Brno get executed.'); },
    getText: function(){ console.log('_sbx_Brno get executed.'); },
    set: function(key, val){ console.log('_sbx_Brno set', key, val); }
};


window.scsObj = scsObj;


// 테스트용 전역 데이터 및 UI 컴포넌트 설정
window.MessageSimpleR01In = new Map();
window.MessageSimpleR01In.getKey = () => {};
window.MessageSimpleR01In.getJSON = (data) => {console.log(data)};
window.MessageSimpleR01In.setJSON = (data) => {console.log(data)};

window.cal_TrnxYmd = {
    getValue: () => "20250101",
    setValue: val => console.log("cal_TrnxYmd set to", val),
    focus: () => {}
};
window.cal_FisYear = { getValue: () => "2025" };
window.sbx_OrgG = { getValue: () => "ORG_G_TEST", setValue: val => console.log("ORG_G set to", val), setNodeSet: () => {} };
window.sbx_OrgC = { getValue: () => "ORG_C_TEST", setValue: val => console.log("ORG_C set to", val), setNodeSet: () => {} };
window.sbx_DeptC = { getValue: () => "DEPT_C_TEST", setValue: val => console.log("DEPT_C set to", val), setNodeSet: () => {} };
window.sbx_AcctNo = { getValue: () => "ACCT_TEST", setValue: val => console.log("ACCT_NO set to", val), setNodeSet: () => {} };
window.sbx_Hoigye = { getValue: () => "ACCT_TEST", setValue: val => console.log("ACCT_NO set to", val), setNodeSet: () => {} };
window.sbx_AcctBr = { getValue: () => "ACCT_TEST", setValue: val => console.log("ACCT_NO set to", val), setNodeSet: () => {} };
window.sbx_Hoigye = { getValue: () => "ACCT_TEST", setValue: val => console.log("ACCT_NO set to", val), setNodeSet: () => {} };
window.sbx_Brno = { getValue: () => "BRNO_TEST" };
window.sbx_Report = { getValue: () => "1" };
window.ibx_ConnAcct = { getValue: () => "123456789012" };
window.tbx_SubTotal = { getValue: () => "0", setValue: val => console.log("SubTotal set to", val) };
window.tbx_Total = { getValue: () => "0", setValue: val => console.log("Total set to", val) };
window.grd_Main = { setNoResultMessage: msg => console.log("NoResultMessage:", msg) };
window.sbx_YearGubun = { getValue: () => "sbx_YearGubun_TEST" };


// 데이터 오브젝트 Mock 설정
window.MICH030102R08Out = {
    get: function(key) {
        var mockData = {"SVR_FILE_PATH": "/mock/path", "SVR_FILE_NM": "mock_file.pdf"};
        return mockData[key];
    }
};

window.MCommonUtilR01Out = { get: key => "20241231" };

// bmObj Mock 객체 추가
window.sbmObj = {
    action: "/mock/action"
};

// 추가 Mock 객체 설정 (gcm 객체 추가)
window.gcm = window.gcm || {};

window.gcm.CONTEXT_PATH = "/mock";
window.gcm.COMMON_CODE_INFO = {
    FILED_ARR: [],
    FILED_ALL: []
};



// $p 객체 및 서브미션 처리 Mock 설정 (com.executeSvc 오류 수정)
window.$p = {
    id: "testPage",
    getSubmission: function(sbmId){
        console.log("getSubmission called with", sbmId);
        return { submit: () => console.log(sbmId + " submission executed.") , action: "/mock/action" };
    },
    data: { remove: () => {}, create: () => {}, set: function(){}, allOption: null },
    comp: {},
    getFrame: function() { return this; },
    getObj: function() { return { reset: () => {}, set: () => {}, reform: () => {}, setNodeSet: () => {} , getValue: () => {} ,showChooseOption: () => {} ,changeChooseOption: () => {},  options: () => { return{ allOption: false}}}; },
    deleteSubmission: function(submissionId){ console.log("deleteSubmission called with", submissionId); },
    createSubmission: function(submissionId) {
        console.log("createSubmission called with", submissionId);
        return {
            submit: () => console.log(submissionId + " submission executed."),
            setRequestHeader: () => {
            },
            setAction: () => {
            },
            setMethod: () => {
            },
            setParam: () => {
            }
        }
    },
    executeSubmission: function(submissionId){
        console.log("Mock executeSubmission 호출됨:", submissionId);
    },
    getFrameId: () => {return this.id;},
    openPopup: (url, options) => {console.log(url, options)},
    getCurrentServerDate: (date) => {return date;},
    isWFramePopup: () => {},
    isPopup: () => {},
    getParameter: () => {}
};

window.com.$p = $p;

window.scsObj.$w = {
    id: "",
    getFrame: function() {
        return {
            getObj: function(id) {
                console.log("Mock getObj 호출됨:", id);
                return {
                    get: () => console.log('Mock get executed for', id),
                    reset: () => console.log('Mock reset executed for', id),
                    set: function(key, val){ console.log(id + ' set', key, val); },
                    reform: function(){ console.log(id + ' reform executed'); },
                    executeSubmission_dynamic: function(){ console.log(id + ' executeSubmission_dynamic executed'); },
                    getJSON: function() { console.log("getJSON")}
                };
            }
        };
    },
    getFrameId: () => {return this.id;}
};



// dma_CommonIn Mock 객체 추가
window.dma_CommonIn = {
    reform: function(){ console.log('dma_CommonIn reform executed.'); },
    set: function(key, val){ console.log('dma_CommonIn set', key, val); }
};

// MSFI020101R99In Mock 객체 추가
window.MSFI020101R99In = {
    set: function(key, val){ console.log('MSFI020101R99In set', key, val); }
};

// MICH030306R01In Mock 객체 추가
window.MICH030306R01In = {
    reform: function(){ console.log('dma_CommonIn reform executed.'); },
    set: function(key, val){ console.log('dma_CommonIn set', key, val); }
};

window.MCommonComboR00In = {
    set: function(key, val){ console.log('MCommonComboR00In set', key, val); },
    getJSON: function() {}
};


window.com.executeSvc = function(svcObj){
    console.log("Mock executeSvc 호출됨:", svcObj);
    if (typeof window[svcObj.sbm_id + "_submitdone"] === 'function') {
        window[svcObj.sbm_id + "_submitdone"]({responseJSON: {}});
    } else {
        console.log("서브미션 콜백이 정의되지 않음:", svcObj.sbm_id + "_submitdone");
    }
};

window.grd_Main = {
    setColumnVisible: () => {},
    setNoResultMessage: () => {},
    getFooterData: () => {}
};

window.dlt_Main = {
    removeAll: () => {},
    reform: () => {},
    setJSON: () => {},
    getTotalRow: () => {},
    getAllJSON: () => {return []}
};


window.report_result = {
    removeAll: () => {},
    reform: () => {}
};

window.appin = {
    hide: () => {},
    show: () => {},
    setSize: () => {},
    setSrc: () => {}
};

window.tr_App1 = {
    hide: () => {},
    show: () => {},
    setSize: () => {},
    setSrc: () => {}
};  

// dateLib 객체 추가
window.dateLib = window.dateLib || {};

window.dateLib.isDate = function(dateStr, allowEmpty, formatCheck){
    console.log('Mock isDate executed with:', dateStr, allowEmpty, formatCheck);
    if (allowEmpty && dateStr.trim() === "") return true;
    return /^\d{8}$/.test(dateStr);
};

// document.getElementById Mock 설정 추가
// document.getElementById = (id) => {
//     console.log(`getElementById 호출됨: ${id}`);
//     return {
//         style: {},
//         set styleDisplay(value) { console.log(`Display style set to: ${value}`); },
//         get style() {
//             return {
//                 set display(value) { console.log(`style.display set to ${value}`); }
//             };
//         }
//     };
// };

// WebSquare.util 객체 추가
window.WebSquare = window.WebSquare || {};
window.WebSquare.util = window.WebSquare.util || {};
window.WebSquare.date = window.WebSquare.date || {};

window.WebSquare.util.parseInt = function(val, defaultValue){
    var parsed = parseInt(val, 10);
    return isNaN(parsed) ? defaultValue : parsed;
};

window.WebSquare.util.isArray = function(obj){
    return Object.prototype.toString.call(obj) === '[object Array]' ;
};

window.WebSquare.date.toTimestampString = function(date) {
    if(!(date instanceof Date)) {
        throw new Error("Parameter must be a Date object");
    }

    var year = date.getFullYear();
    var month = ("0" + (date.getMonth() + 1)).slice(-2);
    var day = ("0" + (date.getDate())).slice(-2);
    var hours = ("0" + (date.getHours())).slice(-2);
    var minutes = ("0" + (date.getMinutes())).slice(-2);
    var seconds = ("0" + (date.getSeconds())).slice(-2);
    
    return year + "-" + month + "-" + day + " " + hours + ":" + minutes + ":" +seconds
}

window.test_param = {
    responseJSON:  {
            MessageSimpleR01OutList: {},
            MessageSimpleR01Out : {
                TOT_CNT: 100
            }
    }
}
