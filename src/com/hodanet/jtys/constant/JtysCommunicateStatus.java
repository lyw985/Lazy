package com.hodanet.jtys.constant;

public enum JtysCommunicateStatus {
    INIT(0, "��ʼ��"), SEND(1, "�ѷ���");

    private int    status;
    private String tip;

    private JtysCommunicateStatus(int status, String tip){
        this.status = status;
        this.tip = tip;
    }

    public int getValue() {
        return status;
    }

    public String toString() {
        return tip;
    }

    public static JtysCommunicateStatus getJtysCommunicateStatus(int status) {
        switch (status) {
            case 0:
                return INIT;
            case 1:
                return SEND;
        }
        return null;
    }
}
