package com.hodanet.yuma.constant;

public enum YumaOrderStatus {
	ORDER_NORMAL(0, "正常订单"), ORDER_FACKER(-1, "伪造订单");

	private int status;
	private String tip;

	private YumaOrderStatus(int status, String tip) {
		this.status = status;
		this.tip = tip;
	}

	public int getValue() {
		return status;
	}

	public String toString() {
		return tip;
	}

	public static YumaOrderStatus getYumaOrderStatus(int status) {
		switch (status) {
		case 0:
			return ORDER_NORMAL;
		case -1:
			return ORDER_FACKER;
		}
		return null;
	}
}
