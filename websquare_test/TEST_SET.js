
//테스트 셋팅 함수 
var util = {
    parseInt: function(value, defaultValue) {
        // 기본값 처리 (defaultValue 가 전달되지 않은 경우 0으로 설정)
        defaultValue = (typeof defaultValue !== 'undefined') ? defaultValue: 0;

        if(typeof value === 'number') {
            return Math.floor(value);
        }

        if(typeof value !== 'string') {
            return defaultValue;
        }

        // 공백 제거
        var trimmedValue = value.trim();

        // 숫자 형식인지 체크 (정수 형식 체크)
        if(/^[+-]?\d+$/.test(trimmedValue)) {
            return Number(trimmedValue);
        } else {
            return defaultValue;
        }
    }
};

var WebSquare = {
    util: util
};

const scsObj = {
    fromRow: 0,
    toRow: 0,
    pageMaxNum: 100,
    gunC: 0,
    isReport: "N"
};

const sbx_Hoigye = {
    hoigye: '',
    getText: function() {
        return this.hoigye;
    },
    setText: function(hoigye) {
        this.hoigye = hoigye;
    },
    getValue: function() {
        return this.hoigye;
    },
    setValue: function(hoigye) {
        this.hoigye = hoigye;
    },    
};

const ibx_ConnAcct = {
    connAcct: '',
    getText: function() {
        return this.connAcct;
    },
    setText: function(connAcct) {
        this.connAcct = connAcct;
    },
    getValue: function() {
        return this.connAcct;
    },
    setValue: function(connAcct) {
        this.connAcct = connAcct;
    },    
};

const sbx_Brno = {
    brno: '',
    getText: function() {
        return this.brno;
    },
    setText: function(brno) {
        this.brno = brno;
    },
    getValue: function() {
        return this.brno;
    },
    setValue: function(brno) {
        this.brno = brno;
    },    
};

const sbx_AcctBr = {
    acctBr: '',
    getText: function() {
        return this.acctBr;
    },
    setText: function(acctBr) {
        this.acctBr = acctBr;
    },
    getValue: function() {
        return this.acctBr;
    },
    setValue: function(acctBr) {
        this.acctBr = acctBr;
    },    
};

const sbx_Report = {
    report: '2',
    getText: function() {
        return this.report;
    },
    setText: function(report) {
        this.report = report;
    },
    getValue: function() {
        return this.report;
    },
    setValue: function(report) {
        this.report = report;
    },    
};

const tbx_SubTotal = {
    subTotal: '',
    getText: function() {
        return this.subTotal;
    },
    setText: function(subTotal) {
        this.subTotal = subTotal;
    },
    getValue: function() {
        return this.subTotal;
    },
    setValue: function(subTotal) {
        this.subTotal = subTotal;
    },    
};

const sbx_AcctNo = {
    acctNo: '',
    getText: function() {
        return this.acctNo;
    },
    setText: function(acctNo) {
        this.acctNo = acctNo;
    },
    getValue: function() {
        return this.acctNo;
    },
    setValue: function(acctNo) {
        this.acctNo = acctNo;
    },    
};

const cal_TrnxYmd = {
    trnxYmd: '20250312',
    getText: function() {
        return this.trnxYmd;
    },
    setText: function(trnxYmd) {
        this.trnxYmd = trnxYmd;
    },
    getValue: function() {
        return this.trnxYmd;
    },
    setValue: function(trnxYmd) {
        this.trnxYmd = trnxYmd;
    },    
};

const cal_FisYear = {
    fisYear: '2025',
    getText: function() {
        return this.fisYear;
    },
    setText: function(fisYear) {
        this.fisYear = fisYear;
    },
    getValue: function() {
        return this.fisYear;
    },
    setValue: function(fisYear) {
        this.fisYear = fisYear;
    },    
};

const sbx_OrgG = {
    orgG: '6280000',
    getText: function() {
        return this.orgG;
    },
    setText: function(orgG) {
        this.orgG = orgG;
    },
    getValue: function() {
        return this.orgG;
    },
    setValue: function(orgG) {
        this.orgG = orgG;
    },    
};

const sbx_OrgC = {
    orgC: '6280000',
    getText: function() {
        return this.orgC;
    },
    setText: function(orgC) {
        this.orgC = orgC;
    },
    getValue: function() {
        return this.orgC;
    },
    setValue: function(orgC) {
        this.orgC = orgC;
    },    
};

const sbx_DeptC = {
    deptC: '',
    getText: function() {
        return this.deptC;
    },
    setText: function(deptC) {
        this.deptC = deptC;
    },
    getValue: function() {
        return this.deptC;
    },
    setValue: function(deptC) {
        this.deptC = deptC;
    },    
};

const MICH030102R08Out = {
    get: function(target) {
        return target;
    }
}

// 전송 파라미터 유효 처리 및 기본값 셋팅
var checkValidateParam = function(value, defaultVal = "all") {
    return value == null || value.trim() === "" ? defaultVal : value;
};

const MessageSimpleR01In = {
    data: {},
    set: function(key, value){
        this.data[key] = value;
    },
    get: function(key){
        return this.data[key];
    }
};