package gocamping.entity;

import java.time.LocalDate;

public class CampingsiteType {
	
	private String type;
	private int stock;
	private double price;
	private String photourl;
	private String size;

	public CampingsiteType() {}

	public CampingsiteType(String type, int stock,String size, double price, String photourl) {
		super();
		this.setType(type);
		this.setStock(stock);
		this.setSize(size);
		this.setPrice(price);
		this.setPhotourl(photourl);
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	public String getSize() {
		return size;
	}

	public void setSize(String size) {
		this.size = size;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public String getPhotourl() {
		return photourl;
	}

	public void setPhotourl(String photourl) {
		this.photourl = photourl;
	}

	@Override
	public String toString() {
		return getClass().getName()
				+",區域" + type 
				+ ", 數量" + stock 
				+ ", 價格" + price 
				+ ", 照片網址" + photourl
				+ ", 尺寸" + size ;
	}
	
	




}



