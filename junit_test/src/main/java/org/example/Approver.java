package org.example;

public class Approver {
    // userId, userNm, step, status, timestamp

    private String userId;
    private String userNm;
    private ApprovalStep step;
    private ApprovalStatus status;
    private String timestamp;

    public Approver(String userId, String userNm, ApprovalStep step, ApprovalStatus status, String timestamp) {
        this.userId = userId;
        this.userNm = userNm;
        this.step = step;
        this.status = status;
        this.timestamp = timestamp;
    }

    // getter
    public String getUserId() {
        return userId;
    }

    public String getUserNm() {
        return userNm;
    }

    public ApprovalStep getStep() {
        return step;
    }

    public ApprovalStatus getStatus() {
        return status;
    }

    public String getTimestamp() {
        return timestamp;
    }

    public void setStep(ApprovalStep step) {
        this.step = step;
    }

    // setter Status
    public void setStatus(ApprovalStatus status) {
        this.status = status;
    }

    // setter Timestamp
    public void setTimestamp(String timestamp) {
        this.timestamp = timestamp;
    }

    public boolean isFinalApprover() {
        return step.isFinalStep();
    }

    // toString
    @Override
    public String toString() {
        return "Approver [userId=" + userId + ", userNm=" + userNm + ", step=" + step + ", status=" + status
                + ", timestamp=" + timestamp + "]";
    }

}
