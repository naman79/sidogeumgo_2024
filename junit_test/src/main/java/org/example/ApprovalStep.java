package org.example;

public enum ApprovalStep {
    DRAFTER(1, "기안", false, false),
    APPROVER1(2, "2단계 결재자", false, false),
    APPROVER2(3, "3단계 결재자", false, false),
    APPROVER3(4, "4단계 결재자", false, false);

    private final int level;
    private final String label;
    private final boolean isFinal;
    private final boolean isPublicOfficial;

    ApprovalStep(int level, String label, boolean isFinal, boolean isPublicOfficial) {
        this.level = level;
        this.label = label;
        this.isFinal = isFinal;
        this.isPublicOfficial = isPublicOfficial;
    }

    public int getLevel() {
        return level;
    }

    public String getLabel() {
        return label;
    }

    public boolean isFinalStep() {
        return isFinal;
    }

    public boolean isPublicOfficial() {
        return isPublicOfficial;
    }

    public static ApprovalStep fromLevel(int level) {
        for (ApprovalStep step : values()) {
            if (step.getLevel() == level) {
                return step;
            }
        }
        return null;
    }

    // next
    public ApprovalStep next() {
        for (ApprovalStep step : values()) {
            if (step.level == this.level + 1) {
                return step;
            }
        }
        return null;
    }

    // previous
    public ApprovalStep previous() {
        for (ApprovalStep step : values()) {
            if (step.level == this.level - 1) {
                return step;
            }
        }
        return null;
    }

}
