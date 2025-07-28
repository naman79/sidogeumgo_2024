package org.example;

public enum ApprovalAction {
    SUBMITALL("0", "기관별일괄상신"),
    SUBMIT("1", "상신"),
    RESUBMIT("2", "재상신"),
    REJECT("3", "반려"),
    APPROVE("4", "승인"),
    WITHDRAW("5", "회수"),
    DELETE("6", "삭제");

    private final String code;
    private final String description;

    ApprovalAction(String code, String description) {
        this.code = code;
        this.description = description;
    }

    public String getCode() {
        return code;
    }

    public String getDescription() {
        return description;
    }

    public static ApprovalAction fromCode(String code) {
        if (code == null) {
            return null;
        }

        for (ApprovalAction action : values()) {
            if (action.getCode().equals(code)) {
                return action;
            }
        }
        return null;
    }

}
