package gocamping.entity;

public class Size {
	private String colorName=""; //PKey
	private String sizeName=""; //PKey
	private int stock;
	private double listPrice;
	private double unitPrice;
	private int ordinal;
	
	public String getColorName() {
		return colorName;
	}
	public void setColorName(String colorName) {
		this.colorName = colorName;
	}
	public String getSizeName() {
		return sizeName;
	}
	public void setSizeName(String sizeName) {
		this.sizeName = sizeName;
	}
	public int getStock() {
		return stock;
	}
	public void setStock(int stock) {
		this.stock = stock;
	}
	public double getListPrice() {
		return listPrice;
	}
	public void setListPrice(double listPrice) {
		this.listPrice = listPrice;
	}
	public double getUnitPrice() {
		return unitPrice;
	}
	public void setUnitPrice(double unitPrice) {
		this.unitPrice = unitPrice;
	}
	public int getOrdinal() {
		return ordinal;
	}
	public void setOrdinal(int ordinal) {
		this.ordinal = ordinal;
	}
	@Override
	public String toString() {
		return "sizeColor=" + colorName + ", size名稱=" + sizeName + ", size庫存=" + stock 
				+ ",\n 定價=" + listPrice + ", 售價=" + unitPrice 
				+ ",\n 順序=" + ordinal;
	}
	
	
	
}
