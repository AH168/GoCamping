package gocamping.exception;

import gocamping.entity.OrderItem;

public class StockShortageException extends GCException {
	private final OrderItem orderItem;
	
	public StockShortageException(OrderItem orderItem) {
		this("購買產品庫存不足", orderItem);	
	}

	public StockShortageException(String message, OrderItem orderItem) {
		super(message);	
		this.orderItem = orderItem;
	}
	
	public String toString() {
		return this.getClass().getName() + "-" + getMessage() + ":" 
				+ orderItem.getProductId() + "-" 
				+ orderItem.getColorName() + "-"
				+ orderItem.getSizeName();
	}
	
}
