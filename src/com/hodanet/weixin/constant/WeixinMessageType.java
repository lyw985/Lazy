package com.hodanet.weixin.constant;

public enum WeixinMessageType {
    TEXT("text", "�ı���Ϣ"), IMAGE("image", "ͼƬ��Ϣ"), VOICE("voice", "������Ϣ"), VIDEO("video", "��Ƶ��Ϣ"), LOCATION("location",
                                                                                                           "����λ����Ϣ"),
    LINK("link", "������Ϣ"), EVENT("event", "�¼���Ϣ"), TUWEN("tuwen", "ͼ����Ϣ");

    private String type;
    private String tip;

    private WeixinMessageType(String type, String tip){
        this.type = type;
        this.tip = tip;
    }

    public String getType() {
        return type;
    }

    public String getTip() {
        return tip;
    }

    public static WeixinMessageType getWeixinMessageType(String type) {
        for (WeixinMessageType messageType : WeixinMessageType.values()) {
            if (messageType.getType().equals(type)) {
                return messageType;
            }
        }
        return null;
    }
}
