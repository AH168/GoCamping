package gocamping.entity;

public enum PaymentType {
	SHOP("門市付款", ShippingType.SHOP),
	ATM("ATM轉帳", ShippingType.HOME, ShippingType.STORE),
	HOME("貨到府款", 50, ShippingType.HOME),
	STORE("超商付款", ShippingType.STORE),
	CARD("信用卡",ShippingType.HOME, ShippingType.STORE);
	
	private final String description;
	private final double fee;
	private final ShippingType[] shippingTypeArray;
	
	private PaymentType(String description,
			ShippingType... shippingTypeArray) {
		this(description, 0, shippingTypeArray);		
	}
	
	private PaymentType(String description, double fee,
			ShippingType... shippingTypeArray) {
		this.description = description;
		this.fee = fee;
		this.shippingTypeArray = shippingTypeArray; 
	}
	
	public String getDescription() {
		return description;
	}
	
	public double getFee() {
		return fee;
	}
	
	public String getShippingTypes() {
		StringBuilder dataString=new StringBuilder();
		if(shippingTypeArray!=null && shippingTypeArray.length>0) {
			for(ShippingType shType:shippingTypeArray) {
				if(dataString.length()>0) dataString.append(",");
				dataString.append(shType.name());				
			}
		}
		return dataString.toString();
	}

	@Override
	public String toString() {		
		return this.getDescription() + (fee>0?new StringBuilder(",").append(fee).append("元"):"");
	}	
}
