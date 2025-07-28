package org.example;

public enum ApprovalStatus {
    DRAFTING("0", "기안전"),
    PENDING("1", "대기"),
    IN_PROGRESS("2", "결재진행중"),
    APPROVED("3", "승인"),
    REJECTED("4", "반려됨"),
    WITHDRAWED("5", "회수됨"),
    DELETED("6", "삭제됨");

    private final String code;
    private final String label;

    ApprovalStatus(String code, String label) {
        this.code = code;
        this.label = label;
    }

    public String getCode() {
        return code;
    }

    public String getLabel() {
        return label;
    }

    public static ApprovalStatus fromCode(String code) {
        for (ApprovalStatus status : values()) {
            if (status.getCode().equals(code)) {
                return status;
            }
        }
        return null;
    }

}
