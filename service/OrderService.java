package gocamping.service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

import gocamping.entity.Customer;
import gocamping.entity.Order;
import gocamping.entity.OrderStatusLog;
import gocamping.exception.GCException;

public class OrderService {
	private OrdersDAO dao = new OrdersDAO();
	public void createOrder(Order order) throws GCException{
		if(order==null) {
			throw new IllegalArgumentException("建立訂單時order物件不得為null");
		}
		dao.insert(order);
	}
	
	public List<Order> getOrderHistory(String customerId)  throws GCException{
		return dao.selectOrdersHistory(customerId);
	}
	
	public Order getOrderDetail(String customerId, String orderId)  throws GCException{
		return dao.selectOrderById(customerId, orderId);
	}
	
	public void updateStatusToTransfered(Customer member, String orderId,
    		String bank, String last5, double amount,LocalDate TransferedDate, String TransferedTime) throws GCException {
    	if(member==null || orderId==null || !orderId.matches("\\d+")) {
    		throw new IllegalArgumentException("通知轉帳時，member|orderId不得為null");
    	}
    	
    	StringBuilder paymentNote = new StringBuilder();
        paymentNote.append(bank).append(", ").append(last5);
        paymentNote.append(",轉帳金額:").append(amount);
        paymentNote.append(",轉帳時間約:").append(TransferedDate).append(" ").append(TransferedTime);

        dao.updateStatusToTransfered(Integer.parseInt(orderId), member.getId(), paymentNote.toString());
	}
	
	public void updateOrderStatusToPAID(Customer member,String orderId, String cardF6, String cardL4,
            String auth, String paymentDate, String amount) throws GCException {
        StringBuilder paymentNote = new StringBuilder("信用卡號:");
       paymentNote.append(cardF6==null?"4311-95":cardF6).append("**-****").append(cardL4==null?2222:cardL4);
       paymentNote.append(",授權碼:").append(auth==null?"777777":auth);
       paymentNote.append(",交易時間:").append(paymentDate==null?LocalDateTime.now():paymentDate); 


       System.out.println("orderId = " + orderId);
       System.out.println("memberId = " + member.getId());
       System.out.println("paymentNote = " + paymentNote);
       dao.updateOrderStatusToPAID(Integer.parseInt(orderId), member.getId(), paymentNote.toString());
    }
	
	public List<OrderStatusLog> getOrderStatusLog(String orderId)
			throws GCException{ 
    	return dao.selectOrderStatusLog(orderId);
	}

}