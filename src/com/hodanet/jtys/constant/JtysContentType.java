package com.hodanet.jtys.constant;

public enum JtysContentType {
    RICHANG(1, "�ճ���"), JIEJIARI(2, "�ڼ�����"), JIEQI(3, "������");

    private int    type;
    private String tip;

    private JtysContentType(int type, String tip){
        this.type = type;
        this.tip = tip;
    }

    public int getType() {
        return type;
    }

    public String getTip() {
        return tip;
    }

    public static JtysContentType getJtysContentType(int type) {
        switch (type) {
            case 1:
                return RICHANG;
            case 2:
                return JIEJIARI;
            case 3:
                return JIEQI;
        }
        return null;
    }
}
