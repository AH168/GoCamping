package gocamping.service;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

import gocamping.exception.GCException;

class MySQLConnection {
	private static final String driver = System.getProperty("driver", "com.mysql.cj.jdbc.Driver");
	private static final String url = System.getProperty("url", "jdbc:mysql:xxx");//視自己情況
	private static final String userid = System.getProperty("userid", "xxx");//視自己情況
	private static final String pwd = System.getProperty("pwd", "xxx");//視自己情況
	
	static Connection getConnection() throws GCException{
		try {
			Class.forName(driver); //1.載入Driver			
			try {
				Connection connection = 
					DriverManager.getConnection(url, userid, pwd);//2.建立連線
				return connection;
			} catch (SQLException e) {				
				throw new GCException("建立連線失敗", e);
			}
		} catch (ClassNotFoundException e) {

			throw new GCException("載入JDBC Driver失敗", e);
		}
	}	
}