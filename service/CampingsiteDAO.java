package gocamping.service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import gocamping.entity.Campingsite;
import gocamping.entity.CampingsiteType;
import gocamping.exception.GCException;

public class CampingsiteDAO {

	
	private static final String SELECT_ALL_CAMPINGSITE=
			"SELECT campsiteid, name, address, hight, "
			+ "officialholiday, photourl, county, "
			+ "township, category FROM campingsite";
	

	List<Campingsite> selectAllCampingsite() throws GCException{
		List<Campingsite> list = new ArrayList<Campingsite>();		
		
		try (
				Connection connection = MySQLConnection.getConnection(); //1,2. 取得連線
				PreparedStatement pstmt = connection.prepareStatement(SELECT_ALL_CAMPINGSITE);				
			){			
			try(
					ResultSet rs = pstmt.executeQuery(); //4.執行指令
				){
				//5. 處理rs
				while(rs.next()) {
				Campingsite	c= new Campingsite();
				c.setCampsiteid(rs.getInt("campsiteid"));
				c.setName(rs.getString("name"));
				c.setAddress(rs.getString("address"));
				c.setHight(rs.getString("hight"));
				c.setOfficialholiday(rs.getString("officialholiday"));
				c.setPhotourl(rs.getString("photourl"));
				c.setCategory(rs.getString("category"));
				c.setCounty(rs.getString("county"));
				c.setTownship(rs.getString("township"));
				list.add(c);
				}
			}
		} catch (SQLException e) {
			throw new GCException("查詢全部產品失敗", e);
		}
		return list;
	}
	
	
	
	
	private static final String SELECT_ALL_CAMPINGSITETYPE=
			"SELECT type, stock, price, photourl, campingsiteid_id, size"
			+"FROM campingsite_type";
	

	List<CampingsiteType> selectAllCampingsitetype() throws GCException{
		List<CampingsiteType> list = new ArrayList<CampingsiteType>();		
		
		try (
				Connection connection = MySQLConnection.getConnection(); //1,2. 取得連線
				PreparedStatement pstmt = connection.prepareStatement(SELECT_ALL_CAMPINGSITETYPE);				
			){			
			try(
					ResultSet rs = pstmt.executeQuery(); //4.執行指令
				){
				//5. 處理rs
				while(rs.next()) {
				CampingsiteType	c= new CampingsiteType();
				c.setType(rs.getString("type"));
				c.setStock(rs.getInt("stock"));
				c.setPrice(rs.getDouble("price"));
				c.setPhotourl(rs.getString("photourl"));
				c.setSize(rs.getString("size"));
				}
			}
		} catch (SQLException e) {
			throw new GCException("查詢全部產品失敗", e);
		}
		return list;
	}
	
	
	
}
