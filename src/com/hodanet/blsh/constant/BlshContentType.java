package com.hodanet.blsh.constant;

public enum BlshContentType {
    YULE_XINWENTOUTIAO(1, "����_����ͷ��"), YULE_LVYOU(2, "����_����"), YULE_DIANYING(3, "����_��Ӱ"), YULE_MEISHI(4, "����_��ʳ"),
    YULE_QITA(5, "����_����"), YOUHUIZHEKOU(6, "�Ż��ۿ�");

    private int    type;
    private String tip;

    private BlshContentType(int type, String tip){
        this.type = type;
        this.tip = tip;
    }

    public int getType() {
        return type;
    }

    public String getTip() {
        return tip;
    }

    public static BlshContentType getBlshContentType(int type) {
        switch (type) {
            case 1:
                return YULE_XINWENTOUTIAO;
            case 2:
                return YULE_LVYOU;
            case 3:
                return YULE_DIANYING;
            case 4:
                return YULE_MEISHI;
            case 5:
                return YULE_QITA;
            case 6:
                return YOUHUIZHEKOU;
        }
        return null;
    }
}
