package gocamping.entity;

public class OrderItem {
	private int orderId; //PKey
	private Product product; //PKey
	private Color color; //PKey
	private String sizeName; //PKey
	private double price;
	private int quantity;
	
	public int getOrderId() {
		return orderId;
	}
	public void setOrderId(int orderId) {
		this.orderId = orderId;
	}
	public Product getProduct() {
		return product;
	}
	
	public int getProductId() {
		return product!=null?product.getId():0;
	}
	public String getProductName() {
		return product!=null?product.getName():"";
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public Color getColor() {
		return color;
	}
	
	public String getColorName() {
		return color!=null?color.getColorName():"";
	}
	
	public String getPhotoUrl() {
		if(color!=null) {
			return color.getPhotoUrl();
		}
		return product.getPhotoUrl();		
	}	
	
	public void setColor(Color color) {
		this.color = color;
	}
	public String getSizeName() {		
		return sizeName==null?"":sizeName;
	}
	public void setSizeName(String sizeName) {
		this.sizeName = sizeName;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public int getQuantity() {
		return quantity;
	}
	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}
	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((color == null) ? 0 : color.hashCode());
		result = prime * result + orderId;
		result = prime * result + ((product == null) ? 0 : product.hashCode());
		result = prime * result + ((sizeName == null) ? 0 : sizeName.hashCode());
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
		OrderItem other = (OrderItem) obj;
		if (color == null) {
			if (other.color != null)
				return false;
		} else if (!color.equals(other.color))
			return false;
		if (orderId != other.orderId)
			return false;
		if (product == null) {
			if (other.product != null)
				return false;
		} else if (!product.equals(other.product))
			return false;
		if (sizeName == null) {
			if (other.sizeName != null)
				return false;
		} else if (!sizeName.equals(other.sizeName))
			return false;
		return true;
	}
	
	@Override
	public String toString() {
		return "訂購明細 [訂單編號=" + orderId 
				+ ", 購買產品=" + product.getName() 
				+ ",\n 購買顏色=" + color 
				+ ",\n 購買size=" + sizeName
				+ ", 交易價=" + price + ", 交易數量=" + quantity + "\n";
	}
}