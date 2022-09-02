package gocamping.entity;

import java.time.LocalDateTime;


public class CartItem implements Comparable<CartItem>{ //
	
	private Product product; //Pkey
	private Color color;	//Pkey
	private Size size;	//Pkey
	private LocalDateTime createdTime = LocalDateTime.now();
	
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public Color getColor() {
		return color;
	}
	public void setColor(Color color) {
		this.color = color;
	}
	public Size getSize() {
		return size;
	}
	public void setSize(Size size) {
		this.size = size;
	}
	
	
	public int getProductId() {
		if(product!=null) {
			return product.getId();
		}else  return -1;		
	}
	
	public String getProductName() {
		if(product!=null) {
			return product.getName();
		}else return "無產品資料";		
	}
	
	public String getPhotoUrl() {
		if(color!=null && color.getPhotoUrl()!=null) {
			return color.getPhotoUrl();
		}else if(product!=null){
			return product.getPhotoUrl();
		}else return null;
	}
	
	public String getColorName() {
		if(color!=null) {
			return color.getColorName();
		}else return "";		
	}
	
	public String getSizeName() {
		if(size!=null) {
			return size.getSizeName();
		}else return "";
	}
	
	public double getListPrice() {
		//從size取得價錢
		if(size!=null) 
			return size.getListPrice();
		
		if(product instanceof Outlet) {
			return ((Outlet)product).getListPrice();
		}else return product.getUnitPrice();		
	}
	
	public String getDiscountString() {
		if(product instanceof Outlet) {
			return ((Outlet)product).getDiscountString();
		}else return "";		
	}
	
	public int getDiscount() {
		if(product instanceof Outlet) {
			return ((Outlet)product).getDiscount();
		}else return 0;		
	}
	
	public double getUnitPrice() {
		//TODO:從size取得價錢
		if(size!=null) 
			return size.getUnitPrice();
		if(product!=null) {
			return product.getUnitPrice();
		}else return 0;		
	}
	
	public int getStock() {
		if(size!=null) 
			return size.getStock();
		
		if(color!=null) 
			return color.getStock();
		
		if(product!=null) {
			return product.getStock();
		}else return 0;	
	}
	
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((product == null) ? 0 : product.hashCode());
		result = prime * result + ((color == null) ? 0 : color.hashCode());
		result = prime * result + ((size == null) ? 0 : size.hashCode());
		return result;
	}
	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		CartItem other = (CartItem) obj;
		if (color == null) {
			if (other.color != null)
				return false;
		} else if (!color.equals(other.color))
			return false;
		if (product == null) {
			if (other.product != null)
				return false;
		} else if (!product.equals(other.product))
			return false;
		if (size == null) {
			if (other.size != null)
				return false;
		} else if (!size.equals(other.size))
			return false;
		return true;
	}
	
	@Override
	public String toString() {
		return "編號=" + getProductId() + ", 名稱=" + getProductName()
				+ ",\n PhotoUrl=" + getPhotoUrl() 
				+ ",\n 購買顏色=" + getColorName() + ", 購買size=" + getSizeName() 
				+ ",\n 定價=" + getListPrice() 
				  + ", 折扣=" + getDiscountString() 
				  + ", 售價=" + getUnitPrice();
	}
	

	
	@Override
	public int compareTo(CartItem anotherItem) {
		int result = this.createdTime.compareTo(anotherItem.createdTime);
		if(result==0) {
			result = this.hashCode() - anotherItem.hashCode();
		}
		return result;
	}
	
	
}