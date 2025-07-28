package org.example;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

public class ApprovalDocument {
    // documentId, currentStep, lastStatus, lastEditor, completed

    private String documentId;
    private ApprovalStep currentStep;
    private ApprovalStatus lastStatus;
    private String lastEditor;
    private boolean completed;

    SimpleDateFormat formatter = new SimpleDateFormat("yyyyMMddHHmmss");

    public ApprovalDocument(String documentId, String drafterId) {
        this.documentId = documentId;
        this.currentStep = ApprovalStep.DRAFTER;
        this.lastStatus = ApprovalStatus.DRAFTING;
        this.lastEditor = drafterId;
        this.completed = false;
    }

    public List<Approver> performAction(Approver actor, ApprovalAction action, List<Approver> approvalLine) {
        currentStep = actor.getStep();

        if (isCompleted() == false) {
            System.out.println("현재 결재 단계: " + currentStep.getLabel());
        }

        switch (action) {
            case SUBMIT:
                if (currentStep == ApprovalStep.DRAFTER) {
                    lastStatus = ApprovalStatus.IN_PROGRESS;
                    actor.setStatus(ApprovalStatus.APPROVED);
                    actor.setTimestamp(formatter.format(new Date()));
                    approvalLineStatusChange(approvalLine, currentStep.next(), ApprovalStatus.PENDING);
                } else if (currentStep == ApprovalStep.APPROVER1) {
                    lastStatus = ApprovalStatus.IN_PROGRESS;
                    actor.setStatus(ApprovalStatus.APPROVED);
                    actor.setTimestamp(formatter.format(new Date()));

                    if (approvalLine.size() < 1) {
                        Approver drafter = new Approver(actor.getUserId(), actor.getUserNm(), ApprovalStep.DRAFTER,
                                ApprovalStatus.APPROVED, formatter.format(new Date()));

                        addHistory(drafter, approvalLine);
                    }

                    approvalLineStatusChange(approvalLine, currentStep.next(), ApprovalStatus.PENDING);
                }

                break;
            case RESUBMIT:

                break;
            case REJECT:
                if (currentStep == ApprovalStep.DRAFTER) {
                    throw new IllegalArgumentException("기안자는 반려할 수 없습니다.");
                } else {
                    lastStatus = ApprovalStatus.REJECTED;

                    // 결재자는 반려
                    actor.setStatus(ApprovalStatus.REJECTED);
                    actor.setTimestamp(formatter.format(new Date()));

                    // 전단계 결재자 대기상태로 변경
                    approvalLineStatusChange(approvalLine, currentStep.previous(), ApprovalStatus.PENDING);

                    // 전단계가 2단계 결재자이면서 1단계가 2단계 결재자와 동일한 경우
                    if (currentStep.previous() == ApprovalStep.APPROVER1
                            && approvalLine.get(0).getUserId().equals(approvalLine.get(1).getUserId())) {
                        approvalLineStatusChange(approvalLine, currentStep.previous().previous(),
                                ApprovalStatus.PENDING);
                    }

                    addHistory(actor, approvalLine);
                }

                break;
            case APPROVE:
                if (actor.getStep() != currentStep) {
                    throw new IllegalArgumentException("결재 단계가 일치하지 않습니다.");
                }

                if (approvalLine.size() == 0 && actor.getStep() == ApprovalStep.APPROVER1) {
                    Approver drafter = new Approver(actor.getUserId(), actor.getUserNm(), ApprovalStep.DRAFTER,
                            ApprovalStatus.APPROVED, formatter.format(new Date()));
                    addHistory(drafter, approvalLine);
                }

                if (actor.isFinalApprover()) {
                    lastStatus = ApprovalStatus.APPROVED;
                    actor.setStatus(ApprovalStatus.APPROVED);
                    actor.setTimestamp(formatter.format(new Date()));
                    completed = true;
                    addHistory(actor, approvalLine);
                } else {
                    lastStatus = ApprovalStatus.IN_PROGRESS;
                    actor.setStatus(ApprovalStatus.APPROVED);
                    actor.setTimestamp(formatter.format(new Date()));

                    if (approvalLine.size() < currentStep.getLevel()) {
                        addHistory(actor, approvalLine);
                    } else {
                        approvalLine.get(currentStep.getLevel() - 1).setStatus(ApprovalStatus.APPROVED);
                        approvalLine.get(currentStep.getLevel() - 1).setTimestamp(formatter.format(new Date()));
                    }
                }

                // 반력의 경우 대기상태로 바꿔야 하나 결재로직 단순화를 위해서 상위 결재자 삭제
                if (approvalLine.size() > currentStep.getLevel()) {
                    approvalLine.remove(currentStep.next().getLevel() - 1);
                }

                break;
            case WITHDRAW:
                // 최종 결재상태는 회수됨으로 변경
                lastStatus = ApprovalStatus.WITHDRAWED;

                // 최종 결재자 상태는 대기로 변경
                actor.setStatus(ApprovalStatus.PENDING);
                actor.setTimestamp(formatter.format(new Date()));

                // 전단계 결재자의 정보 변경하기
                Approver previousApprover = approvalLine.get(actor.getStep().previous().getLevel() - 1);
                previousApprover.setStatus(ApprovalStatus.PENDING);
                previousApprover.setTimestamp(formatter.format(new Date()));
                approvalLine.set(actor.getStep().previous().getLevel() - 1, previousApprover);

                // 결재자가 2단계결재자인 경우(은행원이면서 4급이상) 기안과 결재가 한번에 가능하기에 해당 결재의 회수는 기안단계로 바로 넘어가도록 처리
                if (actor.getStep() == ApprovalStep.APPROVER1) {
                    if (approvalLine.get(0).getUserId().equals(actor.getUserId())) {
                        approvalLine.get(0).setStatus(ApprovalStatus.PENDING);
                        approvalLine.get(0).setTimestamp(formatter.format(new Date()));
                        approvalLine.remove(1);
                        currentStep = ApprovalStep.DRAFTER;
                        lastStatus = ApprovalStatus.WITHDRAWED;
                    }
                }
                break;
            case DELETE:
                if (currentStep == ApprovalStep.DRAFTER) {
                    lastStatus = ApprovalStatus.DELETED;
                    actor.setStatus(ApprovalStatus.DELETED);
                    actor.setTimestamp(formatter.format(new Date()));
                } else {
                    throw new IllegalArgumentException("삭제는 기안자만 가능합니다.");
                }

                break;
            default:
                break;
        }

        return approvalLine;

    }

    // addHistory approvalLine
    public void addHistory(Approver actor, List<Approver> approvalLine) {
        actor.setTimestamp(formatter.format(new Date()));

        for (Approver approver : approvalLine) {
            if (approver.getStep() == actor.getStep() && approver.getUserId() == actor.getUserId()) {
                approver.setStatus(actor.getStatus());
                approver.setTimestamp(actor.getTimestamp());

                return;
            }
        }
    }

    // getStatus
    public ApprovalStatus getStatus() {
        return lastStatus;
    }

    // getCurrentStep
    public ApprovalStep getCurrentStep() {
        return currentStep;
    }

    // getCompleted
    public boolean isCompleted() {
        return completed;
    }

    // approvalLineStatusChange
    public void approvalLineStatusChange(List<Approver> approvalLine, ApprovalStep step, ApprovalStatus status) {
        for (Approver approver : approvalLine) {
            if (approver.getStep() == step) {
                approver.setStatus(status);
                approver.setTimestamp(formatter.format(new Date()));
            }
        }
    }

    // toString
    @Override
    public String toString() {
        return "ApprovalDocument [documentId=" + documentId + ", currentStep=" + currentStep + ", lastStatus="
                + lastStatus + ", lastEditor=" + lastEditor + ", completed=" + completed + "]";
    }

}
