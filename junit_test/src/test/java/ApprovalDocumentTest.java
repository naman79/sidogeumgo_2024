import org.example.ApprovalAction;
import org.example.ApprovalDocument;
import org.example.ApprovalStatus;
import org.example.ApprovalStep;
import org.example.Approver;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.util.ArrayList;
import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

public class ApprovalDocumentTest {
    private ApprovalDocument document;
    private List<Approver> approvalLine;
    private Approver drafter;
    private Approver approver1;
    private Approver approver2;

    @BeforeEach
    void setUp() {
        drafter = new Approver("drafter1", "기안자", ApprovalStep.DRAFTER, ApprovalStatus.DRAFTING, null);
        approver1 = new Approver("approver1", "1차결재자", ApprovalStep.APPROVER1, ApprovalStatus.PENDING, null);
        approver2 = new Approver("approver2", "2차결재자", ApprovalStep.APPROVER2, ApprovalStatus.PENDING, null);
        approvalLine = new ArrayList<>();
        approvalLine.add(approver1);
        approvalLine.add(approver2);
        document = new ApprovalDocument("doc1", drafter.getUserId());
    }

    @Test
    void testDraftSubmit() {
        // 기안자가 상신
        document.performAction(drafter, ApprovalAction.SUBMIT, approvalLine);
        assertEquals(ApprovalStatus.IN_PROGRESS, document.getStatus());
        assertEquals(ApprovalStatus.APPROVED, drafter.getStatus());
        assertEquals(ApprovalStatus.PENDING, approver1.getStatus());
        System.out.println("testDraftSubmit success");
    }

    @Test
    void testFirstApproverApprove() {
        // 기안자가 상신
        document.performAction(drafter, ApprovalAction.SUBMIT, approvalLine);
        // 1차 결재자가 승인
        document.performAction(approver1, ApprovalAction.APPROVE, approvalLine);
        assertEquals(ApprovalStatus.IN_PROGRESS, document.getStatus());
        assertEquals(ApprovalStatus.APPROVED, approver1.getStatus());
        assertEquals(ApprovalStatus.PENDING, approver2.getStatus());
    }

    @Test
    void testFirstApproverReject() {
        // 기안자가 상신
        document.performAction(drafter, ApprovalAction.SUBMIT, approvalLine);
        // 1차 결재자가 반려
        document.performAction(approver1, ApprovalAction.REJECT, approvalLine);
        assertEquals(ApprovalStatus.REJECTED, document.getStatus());
        assertEquals(ApprovalStatus.REJECTED, approver1.getStatus());
    }

    @Test
    void testSecondApproverApprove() {
        // 기안자가 상신
        document.performAction(drafter, ApprovalAction.SUBMIT, approvalLine);
        // 1차 결재자가 승인
        document.performAction(approver1, ApprovalAction.APPROVE, approvalLine);
        // 2차 결재자가 승인
        document.performAction(approver2, ApprovalAction.APPROVE, approvalLine);
        assertEquals(ApprovalStatus.APPROVED, document.getStatus());
        assertEquals(ApprovalStatus.APPROVED, approver2.getStatus());
        assertTrue(document.isCompleted());
    }

    @Test
    void testWithdrawByApprover() {
        // 기안자가 상신
        document.performAction(drafter, ApprovalAction.SUBMIT, approvalLine);
        // 1차 결재자가 승인
        document.performAction(approver1, ApprovalAction.APPROVE, approvalLine);
        // 2차 결재자가 승인
        document.performAction(approver2, ApprovalAction.APPROVE, approvalLine);
        // 2차 결재자가 회수
        document.performAction(approver2, ApprovalAction.WITHDRAW, approvalLine);
        assertEquals(ApprovalStatus.WITHDRAWED, document.getStatus());
        assertEquals(ApprovalStatus.PENDING, approver2.getStatus());
    }

    @Test
    void testDeleteByDrafter() {
        // 기안자가 상신
        document.performAction(drafter, ApprovalAction.SUBMIT, approvalLine);
        // 기안자가 삭제
        document.performAction(drafter, ApprovalAction.DELETE, approvalLine);
        assertEquals(ApprovalStatus.DELETED, document.getStatus());
        assertEquals(ApprovalStatus.DELETED, drafter.getStatus());
    }
}
