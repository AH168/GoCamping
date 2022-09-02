package gocamping.entity;

public enum ShippingType {
	SHOP("門市取貨"),
	HOME("送貨到府", 100),
	STORE("超商取貨", 65);
	
	private final String description;
	private final double fee;
	
	private ShippingType(String description) {
		this(description, 0);		
	}
	
	private ShippingType(String description, double fee) {
		this.description = description;
		this.fee = fee;
	}
	
	public String getDescription() {
		return description;
	}
	public double getFee() {
		return fee;
	}

	@Override
	public String toString() {		
		return this.getDescription() 
		 + (fee>0?new StringBuilder(",").append(fee).append("元"):"");
	}
}

