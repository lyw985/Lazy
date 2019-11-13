package com.hodanet.jtys.constant;

public enum JtysUserStatus {
    GUEST(0, "�ο�"), WEIXIN_USER(1, "΢�Ű����û�"), CNET_USER(2, "���Ű����û�");

    private int    status;
    private String tip;

    private JtysUserStatus(int status, String tip){
        this.status = status;
        this.tip = tip;
    }

    public int getValue() {
        return status;
    }

    public String toString() {
        return tip;
    }

    public static JtysUserStatus getJtysUserStatus(int status) {
        switch (status) {
            case 0:
                return GUEST;
            case 1:
                return WEIXIN_USER;
            case 2:
                return CNET_USER;
        }
        return null;
    }
}
