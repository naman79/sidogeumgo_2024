import org.example.ApprovalAction;
import org.example.ApprovalDocument;
import org.example.ApprovalStatus;
import org.example.ApprovalStep;
import org.example.Approver;
import org.example.ApprovalProcessor;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.HashMap;

import static org.junit.jupiter.api.Assertions.*;

public class ApprovalDocumentTest {
    private ApprovalDocument document;
    private List<Approver> approvalLine;
    private Approver drafter;
    private Approver approver1;
    private Approver approver2;
    private Approver approver3;

    @BeforeEach
    void setUp() {
        drafter = new Approver("drafter1", "기안자", ApprovalStep.DRAFTER, ApprovalStatus.DRAFTING, null);
        approver1 = new Approver("approver1", "1차결재자", ApprovalStep.APPROVER1, ApprovalStatus.PENDING, null);
        approver2 = new Approver("approver2", "2차결재자", ApprovalStep.APPROVER2, ApprovalStatus.PENDING, null);
        approver3 = new Approver("approver3", "3차결재자", ApprovalStep.APPROVER3, ApprovalStatus.PENDING, null);
        approvalLine = new ArrayList<>();
        document = new ApprovalDocument("doc1", drafter.getUserId());
    }

    @Test
    void testDraftSubmit() {

        // 기안자가 상신
        approvalLine = document.performAction(drafter, ApprovalAction.SUBMIT, approvalLine);
        assertEquals(ApprovalStatus.IN_PROGRESS, document.getStatus());
        assertEquals(ApprovalStatus.APPROVED, drafter.getStatus());
        System.out.println("testDraftSubmit success");
    }

    @Test
    void testFirstApproverApprove() {

        // 기안자가 상신
        approvalLine = document.performAction(drafter, ApprovalAction.SUBMIT, approvalLine);
        // 1차 결재자가 승인
        approvalLine = document.performAction(approver1, ApprovalAction.APPROVE, approvalLine);
        assertEquals(ApprovalStatus.IN_PROGRESS, document.getStatus());
        assertEquals(ApprovalStatus.APPROVED, approver1.getStatus());
        // assertEquals(ApprovalStatus.PENDING, approver2.getStatus());
        System.out.println("testFirstApproverApprove success");
    }

    @Test
    void testFirstApproverReject() {
        // 기안자가 상신
        approvalLine = document.performAction(drafter, ApprovalAction.SUBMIT, approvalLine);

        // 1차 결재자가 승인
        int apprStep = document.getCurrentStep().getLevel();

        // 1차 결재자가 반려
        // 반려의 결재는 보통 이전단계 승인 처리후 발생함
        approver1.setStep(ApprovalStep.fromLevel(apprStep));

        System.out.println("approvalLine : " + approvalLine.toString());
        approvalLine = document.performAction(approver1, ApprovalAction.REJECT, approvalLine);
        assertEquals(ApprovalStatus.REJECTED, document.getStatus());
        assertEquals(ApprovalStatus.REJECTED, approver1.getStatus());

        System.out.println("approvalLine size: " + approvalLine.size());
        // System.out.println("approvalLine 0: " +
        // approvalLine.get(0).getStatus().getLabel());
        // 기안자 상태는 대기로 변경
        assertEquals(ApprovalStatus.PENDING, approvalLine.get(0).getStatus());
    }

    @Test
    void testSecondApproverApprove() {
        // 기안자가 상신
        approvalLine = document.performAction(drafter, ApprovalAction.SUBMIT, approvalLine);

        // 기안자가 상신결과
        int apprStep = document.getCurrentStep().getLevel();
        approver1.setStep(ApprovalStep.fromLevel(apprStep));

        // 1차 결재자가 승인
        approvalLine = document.performAction(approver1, ApprovalAction.APPROVE, approvalLine);

        // 1차 결재자가 승인결과
        // apprStep = document.getCurrentStep().getLevel();
        // approver2.setStep(ApprovalStep.fromLevel(apprStep));

        // 2차 결재자가 승인
        approvalLine = document.performAction(approver2, ApprovalAction.APPROVE, approvalLine);

        // 최종결재상태는 진행중
        assertEquals(ApprovalStatus.IN_PROGRESS, document.getStatus());

        // 2차결재자 상태는 승인
        assertEquals(ApprovalStatus.APPROVED, approver2.getStatus());

        // 최종결재가 완료되지 않았음
        assertTrue(!document.isCompleted());
    }

    @Test
    void testWithdrawByApprover() {
        // 기안자가 상신
        approvalLine = document.performAction(drafter, ApprovalAction.SUBMIT, approvalLine);

        System.out.println("approvalLine 1: " + approvalLine.toString());
        // 기안자가 상신결과
        // int apprStep = document.getCurrentStep().getLevel();
        // approver1.setStep(ApprovalStep.fromLevel(apprStep));

        // 1차 결재자가 승인
        approvalLine = document.performAction(approver1, ApprovalAction.APPROVE, approvalLine);

        // System.out.println("approvalLine 2: " + approvalLine.toString());
        // 1차 결재자가 승인결과
        // apprStep = document.getCurrentStep().getLevel();
        // approver2.setStep(ApprovalStep.fromLevel(apprStep));

        // System.out.println("approvalLine 3: " + approvalLine.toString());
        // 2차 결재자가 승인
        approvalLine = document.performAction(approver2, ApprovalAction.APPROVE, approvalLine);

        System.out.println("approvalLine 4: " + approvalLine.toString());
        // 2차 결재자가 승인결과
        // apprStep = document.getCurrentStep().getLevel();
        // approver2.setStep(ApprovalStep.fromLevel(apprStep));

        // 2차 결재자가 회수
        document.performAction(approver2, ApprovalAction.WITHDRAW, approvalLine);

        // 최종결재상태는 회수됨
        assertEquals(ApprovalStatus.WITHDRAWED, document.getStatus());

        // 2차결재자 상태는 대기
        assertEquals(ApprovalStatus.PENDING, approvalLine.get(2).getStatus());

        // 최종결재가 완료되지 않았음
        assertTrue(!document.isCompleted());
    }

    @Test
    void testDeleteByDrafter() {
        // 기안자가 상신
        approvalLine = document.performAction(drafter, ApprovalAction.SUBMIT, approvalLine);

        // 기안자가 회수
        approvalLine = document.performAction(drafter, ApprovalAction.WITHDRAW, approvalLine);

        // 기안자가 삭제
        approvalLine = document.performAction(drafter, ApprovalAction.DELETE, approvalLine);
        assertEquals(ApprovalStatus.DELETED, document.getStatus());
        assertEquals(ApprovalStatus.DELETED, drafter.getStatus());
    }

    // ApprovalProcessor 테스트 상신
    @Test
    void testApprovalProcessor() {
        List<Map<String, String>> approvalLine = new ArrayList<>();
        Map<String, String> drafter = new HashMap<>();
        drafter.put("S1_CONFJ_ID", "");
        drafter.put("S1_CONFJ_NM", "");
        drafter.put("S1_GYLJ_S_G", "");
        drafter.put("S1_CONF_DT", "");
        approvalLine.add(drafter);
        Map<String, String> approver1 = new HashMap<>();
        approver1.put("S2_CONFJ_ID", "");
        approver1.put("S2_CONFJ_NM", "");
        approver1.put("S2_GYLJ_S_G", "");
        approver1.put("S2_CONF_DT", "");
        approvalLine.add(approver1);
        Map<String, String> approver2 = new HashMap<>();
        approver2.put("S3_CONFJ_ID", "");
        approver2.put("S3_CONFJ_NM", "");
        approver2.put("S3_GYLJ_S_G", "");
        approver2.put("S3_CONF_DT", "");
        approvalLine.add(approver2);
        Map<String, String> approver3 = new HashMap<>();
        approver3.put("S4_CONFJ_ID", "");
        approver3.put("S4_CONFJ_NM", "");
        approver3.put("S4_GYLJ_S_G", "");
        approver3.put("S4_CONF_DT", "");
        approvalLine.add(approver3);

        ApprovalProcessor processor = new ApprovalProcessor("drafter", "drafter", "1", "0", approvalLine);
        processor.performAction(ApprovalAction.SUBMIT);
        assertEquals(ApprovalStatus.IN_PROGRESS, processor.getDocument().getStatus());
    }
}
