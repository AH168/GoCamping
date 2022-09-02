//將資料庫分開來
package gocamping.service;

//import java.util.logging.Level;
//import java.util.logging.Logger;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;

import gocamping.entity.Customer;
import gocamping.entity.VIP;
import gocamping.exception.GCDataInvalidException;
import gocamping.exception.GCException;
class CustomersDAO {
	
	private final static String SELECT_CUSTOMER_BY_ID_OR_EMAIL = 
			"SELECT id,password,name,gender,email,birthday,"
			+ "address,phone,subscribed,discount "
			+ "FROM customers WHERE (id=? OR email=?)";	
	Customer selectCustomerByIdOrEmail(String idOrEmail) throws GCException{
		Customer c = null;
		
		try(
			Connection connection = MySQLConnection.getConnection(); //1, 2. 取得連線
			PreparedStatement pstmt = connection.prepareStatement(
						 SELECT_CUSTOMER_BY_ID_OR_EMAIL);//3.準備指令
		  ) {
			//3.1 傳入?的值
			pstmt.setString(1, idOrEmail);
			pstmt.setString(2, idOrEmail);
			try(
					ResultSet rs = pstmt.executeQuery(); //4.執行指令
			){
				//5.處理rs
				while(rs.next()) {
					
					int discount = rs.getInt("discount");
					if(discount>0) {
						c = new VIP();
						((VIP)c).setDiscount(discount);
					}else {
						c = new Customer();
					}
					c.setId(rs.getString("id"));
					c.setPassword(rs.getString("password"));
					c.setName(rs.getString("name"));
					c.setGender(rs.getString("gender").charAt(0));
					c.setEmail(rs.getString("email"));
					c.setBirthday(rs.getString("birthday"));
					
					c.setAddress(rs.getString("address"));					
					c.setPhone(rs.getString("phone"));
					c.setSubscribed(rs.getBoolean("subscribed"));					
				}
			}
			
		} catch (SQLException e) {

			throw new GCException("查詢客戶失敗", e);
		} 
		return c;		
	}
	
	
	private static final String INSERT_CUSTOMER="INSERT INTO customers"
			+ "(id,name, password, gender, email, birthday,"
			+ "		address, phone, subscribed)"
			+ "	VALUES(?,?,?,?,?,?,?,?,?)";
	void insert(Customer c) throws GCException{	
		try (
				Connection connection = MySQLConnection.getConnection(); //1,2 取得連線
				PreparedStatement pstmt = connection.prepareStatement(INSERT_CUSTOMER); //3.準備指令
		){
			//3.1 傳入?的值
			pstmt.setString(1, c.getId());
			pstmt.setString(2, c.getName());
			pstmt.setString(3, c.getPassword());
			pstmt.setString(4, String.valueOf(c.getGender()));
			pstmt.setString(5, c.getEmail());
			pstmt.setString(6, String.valueOf(c.getBirthday()));
			
			pstmt.setString(7, c.getAddress());
			pstmt.setString(8, c.getPhone());
			pstmt.setBoolean(9, c.isSubscribed());
			
			pstmt.executeUpdate(); //4.執行指令
		} catch (SQLIntegrityConstraintViolationException e) {
		
			if(e.getMessage().indexOf("customers.PRIMARY")>=0) {
				throw new GCDataInvalidException("帳號已重複註冊", e);
			}else if(e.getMessage().indexOf("customers.email_UNIQUE")>=0) {
				throw new GCDataInvalidException("email已重複註冊", e);
			}else {
				throw new GCException("新增客戶失敗", e);
			}
		} catch (SQLException e) {
			//SQLException: 1406:MysqlDataTruncation
			throw new GCException("新增客戶失敗", e);
		}
	}
	
	private static final String UPDATE_CUSTOMER="UPDATE customers "
			+ " SET name=?, password=?, gender=?, email=?, birthday=?,"
			+ "	    address=?, phone=?, subscribed=?"
			+ "    WHERE id=?";
	void update(Customer c) throws GCException{
		try (
				Connection connection = MySQLConnection.getConnection(); //1,2 取得連線
				PreparedStatement pstmt = connection.prepareStatement(UPDATE_CUSTOMER); //3.準備指令
			){
			//3.1 傳入?的值
			pstmt.setString(9, c.getId());
			pstmt.setString(1, c.getName());
			pstmt.setString(2, c.getPassword());
			pstmt.setString(3, String.valueOf(c.getGender()));
			pstmt.setString(4, c.getEmail());
			pstmt.setString(5, String.valueOf(c.getBirthday()));
			
			pstmt.setString(6, c.getAddress());
			pstmt.setString(7, c.getPhone());
			pstmt.setBoolean(8, c.isSubscribed());
			
			pstmt.executeUpdate(); //4.執行指令
		} catch (SQLIntegrityConstraintViolationException e) {
			//1048, 1062:SQLIntegrityConstraintViolationException
			if(e.getMessage().indexOf("customers.email_UNIQUE")>=0) {
				throw new GCDataInvalidException("email已重複註冊", e);
			}else {
				throw new GCException("修改客戶失敗", e);
			}
		} catch (SQLException e) {
			//SQLException: 1406:MysqlDataTruncation
			throw new GCException("修改客戶失敗", e);
		}
		
	}
}