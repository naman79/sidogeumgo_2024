package org.example;

import java.util.List;
import java.util.ArrayList;
import java.util.Map;
import java.util.stream.Collectors;
import java.text.SimpleDateFormat;
import java.util.Date;

public class ApprovalProcessor {
    // 결재단계 숫자형 문자
    private String approvalStepStr;
    // 직전 결재상태 숫자형 문자
    private String lastApprovalStatusStr;
    // 결재선 정보 요소로 S1_CONFJ_ID(결재자ID), S1_CONFJ_NM(결재자명), S1_GYLJ_S_G(결재상태),
    // S1_CONF_DT(결재일시) 이런식으로 S1 ~ S4까지 있고 데이터 형태는 JSON String
    private List<Map<String, String>> approvalLine;
    private String userId;
    private String userName;
    private Approver actor;
    private ApprovalAction action;
    private ApprovalDocument approvalDocument;
    private ApprovalStatus lastApprovalStatus;
    private ApprovalStep approvalStep;
    private List<Approver> approvalLineList;

    SimpleDateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmm");

    // 결재단계, 직전 결재상태, 결재선 정보를 요소로 하는 생성자
    // 결재선은 문자열을 받아서 ArrayList로 변환
    public ApprovalProcessor(String userId, String userName, String approvalStepStr, String lastApprovalStatusStr,
            List<Map<String, String>> approvalLine) {
        this.userId = userId;
        this.userName = userName;
        this.approvalStepStr = approvalStepStr;
        this.lastApprovalStatusStr = lastApprovalStatusStr;
        this.approvalLine = approvalLine;
        approvalLineToList(approvalLine);
        this.approvalStep = ApprovalStep.fromLevel(Integer.parseInt(approvalStepStr));
        this.lastApprovalStatus = ApprovalStatus.fromCode(lastApprovalStatusStr);
        this.actor = new Approver(userId, userName, approvalStep, lastApprovalStatus, dateFormat.format(new Date()));
        this.approvalDocument = new ApprovalDocument(userId, userName);
        this.approvalDocument.setCurrentStep(ApprovalStep.fromLevel(Integer.parseInt(approvalStepStr)));
        this.approvalDocument.setLastStatus(ApprovalStatus.fromCode(lastApprovalStatusStr));
    }

    // 결재선을 ArrayList로 변환
    // ex) [{"S1_CONFJ_ID":"1",
    // "S1_CONFJ_NM":"drafter",
    // "S1_GYLJ_S_G":"0",
    // "S1_CONF_DT":"202507311606"
    // },
    // {"S2_CONFJ_ID":"",
    // "S2_CONFJ_NM":"",
    // "S2_GYLJ_S_G":"",
    // "S2_CONF_DT":""
    // },
    // {"S3_CONFJ_ID":"",
    // "S3_CONFJ_NM":"",
    // "S3_GYLJ_S_G":"",
    // "S3_CONF_DT":""
    // },
    // {"S4_CONFJ_ID":"",
    // "S4_CONFJ_NM":"",
    // "S4_GYLJ_S_G":"",
    // "S4_CONF_DT":""
    // }]
    // List<Map<String, String>> approvalLine 을 ArrayList<Approver>로 변환
    // 키에 해당하는 값이 빈값일때에는 리스트에 추가하지 않음
    public void approvalLineToList(List<Map<String, String>> approvalLine) {
        approvalLineList = new ArrayList<Approver>();

        // S1 ~ S4 까지의 결재자 정보를 ArrayList<Approver>로 변환
        // S1
        approvalLine.forEach(approver -> {
            if (approver.get("S1_CONFJ_ID") != null && !approver.get("S1_CONFJ_ID").isBlank()) {
                approvalLineList.add(new Approver(approver.get("S1_CONFJ_ID"), approver.get("S1_CONFJ_NM"),
                        ApprovalStep.fromLevel(1),
                        ApprovalStatus.fromCode(approver.get("S2_GYLJ_S_G")), approver.get("S2_CONF_DT")));
            }
        });
        // S2
        approvalLine.forEach(approver -> {
            if (approver.get("S2_CONFJ_ID") != null && !approver.get("S2_CONFJ_ID").isBlank()) {
                approvalLineList.add(new Approver(approver.get("S2_CONFJ_ID"), approver.get("S2_CONFJ_NM"),
                        ApprovalStep.fromLevel(2),
                        ApprovalStatus.fromCode(approver.get("S2_GYLJ_S_G")), approver.get("S2_CONF_DT")));
            }
        });
        // S3
        approvalLine.forEach(approver -> {
            if (approver.get("S3_CONFJ_ID") != null && !approver.get("S3_CONFJ_ID").isBlank()) {
                approvalLineList.add(new Approver(approver.get("S3_CONFJ_ID"), approver.get("S3_CONFJ_NM"),
                        ApprovalStep.fromLevel(3),
                        ApprovalStatus.fromCode(approver.get("S3_GYLJ_S_G")), approver.get("S3_CONF_DT")));
            }
        });
        // S4
        approvalLine.forEach(approver -> {
            if (approver.get("S4_CONFJ_ID") != null && !approver.get("S4_CONFJ_ID").isBlank()) {
                approvalLineList.add(new Approver(approver.get("S4_CONFJ_ID"), approver.get("S4_CONFJ_NM"),
                        ApprovalStep.fromLevel(4),
                        ApprovalStatus.fromCode(approver.get("S4_GYLJ_S_G")), approver.get("S4_CONF_DT")));
            }
        });

    }

    // action 은 문자열 코드를 받아서 수행
    public void performAction(ApprovalAction action) {
        approvalDocument.performAction(actor, action, approvalLineList);
    }

    // getApprovalLineList
    public List<Approver> getApprovalLineList() {
        return approvalLineList;
    }

    // getDocument
    public ApprovalDocument getDocument() {
        return approvalDocument;
    }
}
