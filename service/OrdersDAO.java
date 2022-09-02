package gocamping.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

import gocamping.entity.Color;
import gocamping.entity.Order;
import gocamping.entity.OrderItem;
import gocamping.entity.OrderStatusLog;
import gocamping.entity.PaymentType;
import gocamping.entity.Product;
import gocamping.entity.ShippingType;
import gocamping.exception.StockShortageException;
import gocamping.exception.GCException;

class OrdersDAO {

	private static final String UPDATE_PRODUCTS_STOCK = "UPDATE products " + "SET stock=stock-? WHERE stock>=?"
			+ " AND id=?";
	private static final String UPDATE_PRODUCT_COLORS_STOCK = "UPDATE product_colors "
			+ "SET stock=stock-? WHERE stock>=?" + " AND product_id=? AND color_name=?";
	private static final String UPDATE_PRODUCT_COLOR_SIZES_STOCK = "UPDATE product_color_sizes "
			+ "SET stock=stock-? WHERE stock>=?" + "	AND product_id=? AND color_name=? AND size_name=?";

	private static final String INSERT_ORDERS = "INSERT INTO orders "
			+ " (id, customer_id, created_date, created_time, "
			+ "		payment_type, payment_fee, shipping_type, shipping_fee,  "
			+ "        recipient_name, recipient_email, recipient_phone, shipping_address," + "		status) "
			+ "	VALUES(?,?,?,?,?,?,?,?,?,?,?,?,0)";
	private static final String INSERT_ORDER_ITEMS = "INSERT INTO order_items "
			+ "	(order_id, product_id, color_name, size_name, price, quantity) " + "    VALUES(?,?,?,?,?,?)";

	void insert(Order order) throws GCException {
		try (Connection connection = MySQLConnection.getConnection(); // 1,2 取得連線
				PreparedStatement pstmt01 = connection.prepareStatement(UPDATE_PRODUCTS_STOCK); // 3.準備指令01
				PreparedStatement pstmt02 = connection.prepareStatement(UPDATE_PRODUCT_COLORS_STOCK); // 3.準備指令02
				PreparedStatement pstmt03 = connection.prepareStatement(UPDATE_PRODUCT_COLOR_SIZES_STOCK); // 3.準備指令03
				PreparedStatement pstmt1 = connection.prepareStatement(INSERT_ORDERS, Statement.RETURN_GENERATED_KEYS); // 3.準備指令1
				PreparedStatement pstmt2 = connection.prepareStatement(INSERT_ORDER_ITEMS); // 3.準備指令2
		) {

			connection.setAutoCommit(false);
			try {
				// 修改庫存
				for (OrderItem item : order.getOrderItemsSet()) {
					PreparedStatement pstmt;
					if (item.getSizeName() != null && item.getSizeName().length() > 0) {
						pstmt = pstmt03;
						pstmt.setString(4, item.getColorName());
						pstmt.setString(5, item.getSizeName());
					} else if (item.getColor() != null) {
						pstmt = pstmt02;
						pstmt.setString(4, item.getColorName());
					} else {
						pstmt = pstmt01;
					}
					// 3.1傳入pstmt?的值
					pstmt.setInt(1, item.getQuantity());
					pstmt.setInt(2, item.getQuantity());
					pstmt.setInt(3, item.getProductId());

					// 4.執行指令
					int rows = pstmt.executeUpdate();
					if (rows == 0) {
						throw new StockShortageException(item);
					}
				}

				// 3.1 (新增訂單)傳入pstmt1的?的值
				pstmt1.setInt(1, order.getId());
				pstmt1.setString(2, order.getMember().getId());
				pstmt1.setString(3, String.valueOf(order.getCreatedDate()));
				pstmt1.setString(4, String.valueOf(order.getCreatedTime()));
				pstmt1.setString(5, order.getPaymentType().name());
				pstmt1.setDouble(6, order.getPaymentType().getFee());
				pstmt1.setString(7, order.getShippingType().name());
				pstmt1.setDouble(8, order.getShippingType().getFee());
				pstmt1.setString(9, order.getRecipientName());
				pstmt1.setString(10, order.getRecipientEmail());
				pstmt1.setString(11, order.getRecipientPhone());
				pstmt1.setString(12, order.getShippingAddress());
				pstmt1.executeUpdate(); // 4.執行pstmt1(新增訂單)

				// 讀取(新增訂單的)自動給號
				try (ResultSet rs = pstmt1.getGeneratedKeys();) {
					while (rs.next()) { // 5.讀取rs
						int orderId = rs.getInt(1);
						order.setId(orderId);
					}
				}

				// 3.1 傳入pstmt2(新增訂單明細)的?的值
				for (OrderItem orderItem : order.getOrderItemsSet()) {
					pstmt2.setInt(1, order.getId());
					pstmt2.setInt(2, orderItem.getProductId());
					pstmt2.setString(3, orderItem.getColorName());
					pstmt2.setString(4, orderItem.getSizeName());
					pstmt2.setDouble(5, orderItem.getPrice());
					pstmt2.setInt(6, orderItem.getQuantity());
					pstmt2.executeUpdate(); // 4.執行pstmt2(新增訂單明細)
				}
				connection.commit();
			} catch (Exception e) {
				connection.rollback();
				throw e;
			} finally {
				connection.setAutoCommit(true);
			}
		} catch (SQLException e) {
			throw new GCException("新增訂單失敗", e);
		}
	}

	private static final String SELECT_ORDERS_BY_CUSTOMER_ID = "SELECT id, customer_id, created_date, created_time, status,"
			+ "	payment_type, payment_fee, shipping_type, shipping_fee,"
			+ "    CAST(SUM(price*quantity) AS DECIMAL(9,0)) as total_amount  " + "    FROM orders  "
			+ "	JOIN order_items ON orders.id=order_items.order_id " + "    WHERE customer_id=? GROUP BY orders.id"
			+ " ORDER BY created_date DESC, created_time DESC";

	List<Order> selectOrdersHistory(String customerId) throws GCException {
		List<Order> list = new ArrayList<Order>();
		try (Connection connection = MySQLConnection.getConnection(); // 1,2 取得連線
				PreparedStatement pstmt = connection.prepareStatement(SELECT_ORDERS_BY_CUSTOMER_ID); // 3.準備指令
		) {
			// 3.1傳入?的值
			pstmt.setString(1, customerId);

			try (ResultSet rs = pstmt.executeQuery();// 4.執行指令
			) {
				// 5.處理rs
				while (rs.next()) {
					Order order = new Order();
					order.setId(rs.getInt("id"));
					order.setCreatedDate(LocalDate.parse(rs.getString("created_date")));
					order.setCreatedTime(LocalTime.parse(rs.getString("created_time")));
					order.setStatus(rs.getInt("status"));

					order.setPaymentType(PaymentType.valueOf(rs.getString("payment_type")));
					order.setPaymentFee(rs.getDouble("payment_fee"));
					order.setShippingType(ShippingType.valueOf(rs.getString("shipping_type")));
					order.setShippingFee(rs.getDouble("shipping_fee"));
					order.setTotalAmount(rs.getDouble("total_amount"));
					list.add(order);
				}
			}
		} catch (SQLException e) {
			throw new GCException("查詢歷史訂單失敗", e);
		}

		return list;
	}

	private static final String SELECT_ORDER_BY_ID = "SELECT orders.id, customer_id, created_date, created_time, status, "
			+ "	payment_type, payment_fee, payment_note," + " shipping_type, shipping_fee,shipping_note,"
			+ " recipient_name, recipient_email, recipient_phone, shipping_address,"
			+ "	order_items.product_id, products.name as product_name, "
			+ "		order_items.color_name, order_items.size_name," + "     price, quantity,"
			+ " 	products.photo_url, IFNULL(product_colors.photo_url, products.photo_url) as color_photo"
			+ " FROM orders " + "	   JOIN order_items ON orders.id=order_items.order_id   "
			+ "    JOIN products ON order_items.product_id=products.id   "
			+ "    LEFT JOIN product_colors ON order_items.product_id=products.id"
			+ "		AND (order_items.color_name=product_colors.color_name OR "
			+ "			(order_items.color_name='' AND product_colors.color_name IS NULL))"
			+ "    WHERE customer_id=? AND orders.id=?";

	Order selectOrderById(String customerId, String orderId) throws GCException {
		Order order = null;
		try (Connection connection = MySQLConnection.getConnection(); // 1,2 取得連線
				PreparedStatement pstmt = connection.prepareStatement(SELECT_ORDER_BY_ID); // 3.準備指令
		) {
			// 3.1傳入?的值
			pstmt.setString(1, customerId);
			pstmt.setString(2, orderId);

			try (ResultSet rs = pstmt.executeQuery();// 4.執行指令
			) {
				// 5.處理rs
				while (rs.next()) {
					if (order == null) {
						order = new Order();
						order.setId(rs.getInt("id"));
						order.setCreatedDate(LocalDate.parse(rs.getString("created_date")));
						order.setCreatedTime(LocalTime.parse(rs.getString("created_time")));
						order.setStatus(rs.getInt("status"));

						order.setPaymentType(PaymentType.valueOf(rs.getString("payment_type")));
						order.setPaymentFee(rs.getDouble("payment_fee"));
						order.setPaymentNote(rs.getString("payment_note"));
						order.setShippingType(ShippingType.valueOf(rs.getString("shipping_type")));
						order.setShippingFee(rs.getDouble("shipping_fee"));
						order.setShippingNote(rs.getString("shipping_note"));

						order.setRecipientName(rs.getString("recipient_name"));
						order.setRecipientEmail(rs.getString("recipient_email"));
						order.setRecipientPhone(rs.getString("recipient_phone"));
						order.setShippingAddress(rs.getString("shipping_address"));
					}

					OrderItem item = new OrderItem();
					item.setOrderId(order.getId());
					Product p = new Product();
					p.setId(rs.getInt("product_id"));
					p.setName(rs.getString("product_name"));
					p.setPhotoUrl(rs.getString("photo_url"));
					item.setProduct(p);
					Color color = new Color();
					color.setColorName(rs.getString("color_name"));
					color.setPhotoUrl(rs.getString("color_photo"));
					item.setColor(color);
					item.setSizeName(rs.getString("size_name"));
					item.setPrice(rs.getDouble("price"));
					item.setQuantity(rs.getInt("quantity"));
					order.add(item);
				}
			}
		} catch (SQLException e) {
			throw new GCException("查詢訂單明細失敗", e);
		}
		return order;
	}

	private static final String UPDATE_STATUS_TO_TRANSFERED = "UPDATE orders SET status=1" // 狀態設定為已轉帳
			+ ", payment_note=? WHERE status=0 AND payment_type='" + PaymentType.ATM.name()
			+ "' AND id=? AND customer_id=?";

	void updateStatusToTransfered(int orderId, String memberId, String paymentNote) throws GCException {
		try (Connection connection = MySQLConnection.getConnection(); // 2. 建立連線
				PreparedStatement pstmt = connection.prepareStatement(UPDATE_STATUS_TO_TRANSFERED) // 3. 準備指令
		) {
			// 3.1 傳入?的值
			pstmt.setString(1, paymentNote);
			pstmt.setInt(2, orderId);
			pstmt.setString(3, memberId);

			// 4. 執行指令
			pstmt.executeUpdate();
		} catch (SQLException ex) {
			throw new GCException("通知已轉帳失敗!", ex);
		}
	}

	private static final String SELECT_ORDER_STATUS_LOG = "SELECT order_id, update_time, old_status, new_status "

			+ " FROM vgb.order_logs WHERE order_id=?";

	List<OrderStatusLog> selectOrderStatusLog(String orderId) throws GCException {
		List<OrderStatusLog> list = new ArrayList<>();
		try (Connection connection = MySQLConnection.getConnection();
				PreparedStatement pstmt = connection.prepareStatement(SELECT_ORDER_STATUS_LOG);
		) {
			// 3.1 傳入?的值
			pstmt.setString(1, orderId);

			// 4. 執行指令
			try (ResultSet rs = pstmt.executeQuery()) {
				while (rs.next()) {

					OrderStatusLog log = new OrderStatusLog(); // 記得要import OrderStatusLog
					log.setId(rs.getInt("order_id"));
					log.setOldStatus(rs.getInt("old_status"));
					log.setStatus(rs.getInt("new_status"));
					log.setLogTime(rs.getString("update_time"));
					list.add(log);
				}
			}
			return list;

		} catch (SQLException ex) {
			throw new GCException("查詢訂單狀態Log失敗", ex);
		}
	}
	
	private static final String UPDATE_STATUS_TO_PAID = "UPDATE orders SET status=2" //狀態設定為已付款
            + ", payment_note=? WHERE status=0 AND payment_type='" + PaymentType.CARD.name() 
            + "' AND id=? AND customer_id=?"; 
    void updateOrderStatusToPAID(int orderId,String memberId, String paymentNote) throws GCException {
        try (Connection connection = MySQLConnection.getConnection(); //2. 建立連線
             PreparedStatement pstmt = connection.prepareStatement(UPDATE_STATUS_TO_PAID) //3. 準備指令
        ) {
            //3.1 傳入?的值
            pstmt.setString(1, paymentNote);
            pstmt.setInt(2, orderId);
            pstmt.setString(3, memberId); 

            //4. 執行指令
            pstmt.executeUpdate();
        } catch (SQLException ex) {
            System.out.println("修改信用卡付款入帳狀態失敗-" + ex);
            throw new GCException("修改信用卡付款入帳狀態失敗!", ex);
        }
    }

}
