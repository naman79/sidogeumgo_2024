function loadScript(src, callback) {
    var script = document.createElement('script');
    script.type = 'text/javascript';
    script.src = src;
    script.onload = callback;
    document.head.appendChild(script);
}

// 사용 예시
loadScript('test_framework.js', function(){
    console.log('test_framework.js 로드 완료');
    // 다음 스크립트 로드 (순차 로드)
    loadScript('common.js', function(){
        console.log('common.js 로드 완료');
        loadScript('rptcommon.js', function(){
            console.log('rptcommon.js 로드 완료');
            loadScript('test_frameset.js', function(){
                console.log('test_frameset.js 로드 완료');
                loadScript('ICH030319M01_TEST.js', function(){
                    console.log('ICH030319M01_TEST.js 로드 완료');
                    // 마지막 실행부
                    if(scsObj && typeof scsObj.onpageload === 'function'){
                        scsObj.onpageload();
                    }
                });
            });
        });
    });
});

// verticalReport 변수를 중복 방지 설정
window.verticalReport = window.verticalReport || [];

// 테스트 대상 업무 로딩 (테스트 대상 ICH030319M01_TEST.js)
loadScript('ICH030319M01_TEST.js', function(){
    console.log('ICH030319M01_TEST.js loaded');

    // 실제 테스트할 함수 호출
    scsObj.onpageload();  // onpageload 함수 호출 예시
    scsObj.btn_Search_onclick(); // 조회버튼 클릭 이벤트 테스트
    scsObj.btn_Print_onclick();  // 인쇄버튼 클릭 이벤트 테스트
});
