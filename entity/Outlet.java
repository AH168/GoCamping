package gocamping.entity;

public class Outlet extends Product {
	private int discount; //0, 1-90% off
	
	public Outlet() {}

	public Outlet(int id, String name, double unitPrice) {		
		super(id, name, unitPrice);
	}
	
	public Outlet(int id, String name, double unitPrice, int discount) {
		super(id,name,unitPrice);
		this.setDiscount(discount);
	}

	/**
	 * @return int的Outlet優惠折扣 
	 */
	public int getDiscount() {
		return discount;
	}

	/**
	 * 設定Outlet優惠折扣
	 * @param discount 1-90% off
	 */
	public void setDiscount(int discount) {
		if(discount>0 && discount<=90) {
			this.discount = discount;
		}else {

			System.err.println("Outlet discount必須在1-90之間");
		}
	}
	
	/**
	 * @return String型態的Outlet優惠折扣,如5% off->95折
	 */	
	public String getDiscountString() {
		int discount = 100-this.discount;
		if(discount%10==0) {
			return discount/10 + "折";
		}
		
		return discount + "折";
	}

	/**
	 * 取得售價(已打折)
	 * @return unitPrice屬性折扣後的售價
	 */	
	@Override
	public double getUnitPrice() {
		return super.getUnitPrice() * (100-this.discount)/100;
	}
	
	/**
	 * 取得定價
	 * @return super物件unitPrice屬性的原價
	 */
	public double getListPrice() {
		return super.getUnitPrice();
	}

	@Override
	public String toString() {
		return super.toString() 
				+ "\n折扣=" + discount + "% off, " 
				+ getDiscountString()				
				+ ", 售價=" + getUnitPrice();										
			
	}
	
}