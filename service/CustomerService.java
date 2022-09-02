package gocamping.service;

import gocamping.entity.Customer;
import gocamping.exception.GCException;
import gocamping.exception.LoginFailedException;

public class CustomerService {
	private CustomersDAO  dao = new CustomersDAO();

	public Customer login(String idOrEmail, String password) 
			throws GCException  {
		if(idOrEmail==null  || password==null) {
			throw new IllegalArgumentException("會員登入必須輸入帳號密碼");
		}
		
		Customer c = null;
		c = dao.selectCustomerByIdOrEmail(idOrEmail);
		if(c!=null) {
			if(!c.getPassword().equals(password)) {
				c=null;
			}
		}
		
		if(c!=null) {
			return c;	
		}else {
			throw new LoginFailedException("登入失敗，帳號或密碼不正確");
		}
	}
	
	public void register(Customer c) throws GCException{
		if(c==null) {
			throw new IllegalArgumentException("會員註冊客戶物件不得為null");
		}		
		dao.insert(c);
	}
	
	public void update(Customer c) throws GCException{
		if(c==null) {
			throw new IllegalArgumentException("修改會員時客戶物件不得為null");
		}		
		dao.update(c);
	}
}
