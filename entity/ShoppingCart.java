package gocamping.entity;


import java.text.DecimalFormat;
import java.text.NumberFormat;
import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

import gocamping.exception.GCDataInvalidException;

public class ShoppingCart {
	public static final NumberFormat PRICE_FORMAT = new DecimalFormat("######0.00");
	public static final NumberFormat AMOUNT_FORMAT = new DecimalFormat("########0");

	private Customer member;
	private Map<CartItem, Integer> cart = new HashMap<>();

	public Customer getMember() {
		return member;
	}

	public void setMember(Customer member) {
		this.member = member;
	}

	
	public void add(Product product, String colorName, Size size, int quantity) {
		if(product==null) {
			throw new IllegalArgumentException("加入購物車時Product物件不得為null");
		}
		
		if(quantity<=0) {
			throw new IllegalArgumentException("加入購物車時quantity必須>0");
		}
		
		Color color= null;
		if(product.isColorful() && colorName!=null) {
			color = product.findColor(colorName);
			if(color==null) {
				throw new GCDataInvalidException(
						"加入購物車時顏色不符合產品的顏色清單:" + product.getId() +"-" + colorName);
			}
		} else if(product.isColorful() && (colorName==null || colorName.length()==0 )) {
			throw new GCDataInvalidException("加入購物車時顏色不符合產品的顏色清單:" + colorName);
		}
		
		CartItem item = new CartItem();
		item.setProduct(product);
		item.setColor(color);
		item.setSize(size);
		
		Integer oldQty = cart.get(item); 
		if(oldQty!=null) { 
			quantity += oldQty;
		}
				
		cart.put(item, quantity);		
	}

	public void update(CartItem item, int quantity) {
		if (cart.get(item) != null) {
			cart.put(item, quantity);
		}
	}

	public Integer remove(CartItem item) {
		return cart.remove(item);
	}

	
	public int size() {
		return cart.size();
	}

	public boolean isEmpty() {
		return cart.isEmpty();
	}

	public int getQuantity(CartItem key) {
		Integer qty = cart.get(key);
		return qty == null ? 0 : qty;
	}
	
	public double getUnitPrice(CartItem key) {
		if(!(key.getProduct() instanceof Outlet) && 
				member instanceof VIP) {
			return key.getListPrice() * (100-((VIP)member).getDiscount())/100;
		}
		
		return key.getUnitPrice();
	}
	
	public String getDiscountString(CartItem key) {
		if(!(key.getProduct() instanceof Outlet) && 
				member instanceof VIP) {
			return "VIP"+((VIP)member).getDiscountString();
		}
		
		return key.getDiscountString();
	}



	public Set<CartItem> getCartItemsSet() {
		

		return new HashSet<>(cart.keySet()); 

		
	}


	public double getAmount(CartItem item) {
		int qty = this.getQuantity(item);
		double amount = this.getUnitPrice(item) * qty;
		return amount;
	}
	
	public double getListAmount(CartItem item) {
		int qty = this.getQuantity(item);
		double amount = item.getListPrice() * qty;
		return amount;
	}


	public int getTotalQuantity() {
		int sum = 0;
		for (Integer qty : cart.values()) {
			if (qty != null)
				sum += qty;
		}
		return sum;
	}

	public double getTotalListAmount() {
		double sum = 0;
		for (CartItem item : cart.keySet()) {
			sum += this.getListAmount(item);
		}
		return sum;
	}
	

	public double getTotalAmount() {
		double sum = 0;
		for (CartItem item : cart.keySet()) {
			sum += this.getAmount(item);
		}
		return sum;
	}

	@Override
	public String toString() {
		String cartItemContent = "";
		for (CartItem item : getCartItemsSet()) {
			cartItemContent += item + ", 數量:" + getQuantity(item) + ", 小計:" + getAmount(item) + "\n";
		}

		return "購物車[會員=" + (member != null ? member.getName() : "") + ", 購物明細:\n" + cartItemContent + ",\n 共" + size()
				+ "項, " + getTotalQuantity() + "件, 總金額=" + getTotalAmount() + "元";
	}
}