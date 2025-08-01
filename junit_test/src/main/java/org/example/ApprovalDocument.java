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

    // 결재진행전 상태와 결재단계가 실제 프로그램에서는 다른 방식으로 전달됨
    // ex) document.setStatus(ApprovalStatus.fromLevel(rpt_last_status));
    // ex) document.setStep(ApprovalStep.fromLevel(rpt_step));
    // 승인상태 결재의 경우 currentStep.getLevel() + 1
    // 반려상태 결재의 경우 currentStep.getLevel() - 1
    // 회수상태 결재의 경우 currentStep.getLevel() +0
    public List<Approver> performAction(Approver actor, ApprovalAction action, List<Approver> approvalLine) {

        if (isCompleted() == false) {
            System.out.println("현재 결재 단계: " + currentStep.getLabel());
        }

        switch (action) {
            case SUBMIT:

                actor.setStep(ApprovalStep.DRAFTER);
                lastStatus = ApprovalStatus.IN_PROGRESS;
                actor.setStatus(ApprovalStatus.APPROVED);
                actor.setTimestamp(formatter.format(new Date()));
                addHistory(actor, approvalLine);

                if (currentStep == ApprovalStep.APPROVER1) {

                    Approver approver1 = new Approver(actor.getUserId(), actor.getUserNm(), ApprovalStep.APPROVER1,
                            ApprovalStatus.APPROVED, formatter.format(new Date()));

                    addHistory(approver1, approvalLine);

                }

                break;

            case APPROVE:

                if (lastStatus == ApprovalStatus.IN_PROGRESS) {
                    currentStep = currentStep.next();
                } else if (lastStatus == ApprovalStatus.REJECTED) {
                    currentStep = currentStep.previous();
                } else if (lastStatus == ApprovalStatus.WITHDRAWED) {

                }

                actor.setStep(currentStep);
                actor.setStatus(ApprovalStatus.APPROVED);
                actor.setTimestamp(formatter.format(new Date()));

                if (approvalLine.size() == 0 && actor.getStep() == ApprovalStep.APPROVER1) {
                    Approver drafter = new Approver(actor.getUserId(), actor.getUserNm(), ApprovalStep.DRAFTER,
                            ApprovalStatus.APPROVED, formatter.format(new Date()));
                    addHistory(drafter, approvalLine);
                }

                // 2단계 결재자가 기안자와 동일할때 기안자의 상태 정보도 없데이트
                if (approvalLine.size() > 0 && actor.getStep() == ApprovalStep.APPROVER1) {
                    if (approvalLine.get(0).getUserId().equals(actor.getUserId())) {
                        approvalLineStatusChange(approvalLine, ApprovalStep.DRAFTER, ApprovalStatus.APPROVED);
                    }
                }

                // 반력의 경우 대기상태로 바꿔야 하나 결재로직 단순화를 위해서 상위 결재자 삭제
                if (approvalLine.size() > currentStep.getLevel()
                        && approvalLine.get(currentStep.getLevel()).getStatus() == ApprovalStatus.REJECTED) {
                    approvalLine.remove(currentStep.getLevel());
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

                    if (lastStatus == ApprovalStatus.WITHDRAWED) {
                        approvalLineStatusChange(approvalLine, currentStep, ApprovalStatus.APPROVED);
                    } else if (lastStatus == ApprovalStatus.REJECTED) {
                        approvalLineStatusChange(approvalLine, currentStep, ApprovalStatus.APPROVED);
                        approvalLineClearFromIndex(approvalLine, currentStep.getLevel());
                    } else if (lastStatus == ApprovalStatus.IN_PROGRESS) {
                        addHistory(actor, approvalLine);
                    }
                }

                break;

            case REJECT:

                if (lastStatus == ApprovalStatus.IN_PROGRESS) {
                    currentStep = currentStep.next();
                } else if (lastStatus == ApprovalStatus.REJECTED) {
                    currentStep = currentStep.previous();
                } else if (lastStatus == ApprovalStatus.WITHDRAWED) {

                }

                actor.setStep(currentStep);
                actor.setTimestamp(formatter.format(new Date()));

                if (currentStep == ApprovalStep.DRAFTER) {
                    throw new IllegalArgumentException("기안자는 반려할 수 없습니다.");
                } else {
                    lastStatus = ApprovalStatus.REJECTED;

                    // 결재자는 반려
                    actor.setStatus(ApprovalStatus.REJECTED);

                    // 전단계 결재자 대기상태로 변경
                    approvalLineStatusChange(approvalLine, currentStep.previous(), ApprovalStatus.PENDING);

                    // 전단계가 2단계 결재자이면서 1단계가 2단계 결재자와 동일한 경우
                    if (currentStep.previous() == ApprovalStep.APPROVER1
                            && approvalLine.get(ApprovalStep.DRAFTER.getLevel() - 1).getUserId()
                                    .equals(actor.getUserId())) {
                        approvalLineStatusChange(approvalLine, currentStep.previous().previous(),
                                ApprovalStatus.PENDING);

                        // 2단계 결재자 이상 삭제
                        approvalLineClearFromIndex(approvalLine, 1);
                        currentStep = ApprovalStep.DRAFTER;
                    }

                    addHistory(actor, approvalLine);
                }

                break;

            case WITHDRAW:
                // 최종 결재상태는 회수됨으로 변경
                lastStatus = ApprovalStatus.WITHDRAWED;

                // 최종 결재자 상태는 대기로 변경
                approvalLineStatusChange(approvalLine, currentStep, ApprovalStatus.PENDING);

                // 결재자가 2단계결재자인 경우(은행원이면서 4급이상) 기안과 결재가 한번에 가능하기에 해당 결재의 회수는 기안단계로 바로 넘어가도록 처리
                if (actor.getStep() == ApprovalStep.APPROVER1) {
                    if (approvalLine.get(0).getUserId().equals(actor.getUserId())) {
                        approvalLineStatusChange(approvalLine, ApprovalStep.DRAFTER, ApprovalStatus.PENDING);
                        approvalLine.remove(1);
                        currentStep = ApprovalStep.DRAFTER;
                        lastStatus = ApprovalStatus.WITHDRAWED;
                    }
                }
                break;
            case RESUBMIT:

                break;
            case DELETE:
                if (currentStep == ApprovalStep.DRAFTER) {
                    lastStatus = ApprovalStatus.DELETED;

                    if (approvalLine.get(ApprovalStep.DRAFTER.getLevel() - 1).getStatus() == ApprovalStatus.PENDING) {
                        approvalLineStatusChange(approvalLine, ApprovalStep.DRAFTER, ApprovalStatus.DELETED);
                    } else {
                        throw new IllegalArgumentException("삭제는 대기상태에서만 가능합니다.");
                    }

                } else {
                    throw new IllegalArgumentException("삭제는 기안자만 가능합니다.");
                }

                break;
            default:
                break;
        }

        System.out.println("approvalLine : " + approvalLine.toString());
        return approvalLine;

    }

    // 기존 결재선 데이터면 업데이트하고 아니면 결재선 신규하기
    public void addHistory(Approver actor, List<Approver> approvalLine) {

        for (Approver approver : approvalLine) {
            if (approver.getStep() == actor.getStep() && approver.getUserId() == actor.getUserId()) {
                approver.setStatus(actor.getStatus());
                approver.setTimestamp(actor.getTimestamp());

                return;
            }
        }

        approvalLine.add(actor);
    }

    // getStatus
    public ApprovalStatus getStatus() {
        return lastStatus;
    }

    // getCurrentStep
    public ApprovalStep getCurrentStep() {
        return currentStep;
    }

    // setStatus
    public void setLastStatus(ApprovalStatus lastStatus) {
        this.lastStatus = lastStatus;
    }

    // setCurrentStep
    public void setCurrentStep(ApprovalStep step) {
        this.currentStep = step;
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

    // 특정 인덱스 이상의 결재선 제거하기
    public void approvalLineClearFromIndex(List<Approver> approvalLine, int index) {
        approvalLine.subList(index, approvalLine.size()).clear();
    }

    // toString
    @Override
    public String toString() {
        return "ApprovalDocument [documentId=" + documentId + ", currentStep=" + currentStep + ", lastStatus="
                + lastStatus + ", lastEditor=" + lastEditor + ", completed=" + completed + "]";
    }

}
