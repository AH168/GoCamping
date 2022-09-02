package gocamping.service;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

import gocamping.entity.Color;
import gocamping.entity.Outlet;
import gocamping.entity.Product;
import gocamping.entity.Size;
import gocamping.exception.GCException;

import java.sql.*;

class ProductsDAO {

	
	private static final String SELECT_ALL_PRODUCTS=
			"SELECT id, name, unit_price, stock, photo_url, category, discount,description"
			+ "	FROM products_list_view";
	List<Product> selectAllProducts() throws GCException{
		List<Product> list = new ArrayList<Product>();		
		
		try (
				Connection connection = MySQLConnection.getConnection(); //1,2. 取得連線
				PreparedStatement pstmt = connection.prepareStatement(SELECT_ALL_PRODUCTS);				
			){			
			try(
					ResultSet rs = pstmt.executeQuery(); //4.執行指令
				){
				//5. 處理rs
				while(rs.next()) {
					Product p;
					int discount = rs.getInt("discount");
					if(discount>0) {
						p = new Outlet();
						((Outlet)p).setDiscount(discount);
					}else {
						p = new Product();
					}
					
					p.setId(rs.getInt("id"));
					p.setName(rs.getString("name"));
					p.setUnitPrice(rs.getDouble("unit_price"));
					p.setStock(rs.getInt("stock"));
					p.setPhotoUrl(rs.getString("photo_url"));
					p.setCategory(rs.getString("category"));
					p.setDescription(rs.getString("description"));
					list.add(p);
				}
			}
		} catch (SQLException e) {
			throw new GCException("查詢全部產品失敗", e);
		}
		return list;
	}
	

	private static final String SELECT_PRODUCTS_BY_NAME=
			"SELECT id, name, unit_price, stock, photo_url, category, discount,description"
			+ "	FROM products_list_view "
			+ "    WHERE name LIKE ?";
	List<Product> selectProductsByName(String keyword) throws GCException{
		List<Product> list = new ArrayList<Product>();		
		
		try (
				Connection connection = MySQLConnection.getConnection(); //1,2. 取得連線
				PreparedStatement pstmt = connection.prepareStatement(SELECT_PRODUCTS_BY_NAME);				
			){
			//3.1傳入?的值
			pstmt.setString(1, '%'+keyword+'%');
			try(
					ResultSet rs = pstmt.executeQuery(); //4.執行指令
				){
				//5. 處理rs
				while(rs.next()) {
					Product p;
					int discount = rs.getInt("discount");
					if(discount>0) {
						p = new Outlet();
						((Outlet)p).setDiscount(discount);
					}else p = new Product();
								
					p.setId(rs.getInt("id"));
					p.setName(rs.getString("name"));
					p.setUnitPrice(rs.getDouble("unit_price"));
					p.setStock(rs.getInt("stock"));
					p.setPhotoUrl(rs.getString("photo_url"));
					p.setCategory(rs.getString("category"));
					p.setDescription(rs.getString("description"));
					list.add(p);
				}
			}
		} catch (SQLException e) {
			throw new GCException("用關鍵字查詢產品失敗:" + keyword, e);
		}		
		return list;
	}


	private static final String SELECT_PRODUCTS_BY_CATEGORY =
			"SELECT id, name, unit_price, stock, photo_url, category, discount,description"
			+ "	FROM products_list_view"
			+ "    WHERE category=?";
	
	List<Product> selectProductsByCategory(String category) throws GCException{
		List<Product> list = new ArrayList<Product>();		
		
		try (
				Connection connection = MySQLConnection.getConnection(); //1,2. 取得連線
				PreparedStatement pstmt = connection.prepareStatement(SELECT_PRODUCTS_BY_CATEGORY);				
			){
			//3.1傳入?的值
			pstmt.setString(1, category);
			try(
					ResultSet rs = pstmt.executeQuery(); //4.執行指令
				){
				//5. 處理rs
				while(rs.next()) {
					Product p;
					int discount = rs.getInt("discount");
					if(discount>0) {
						p = new Outlet();
						((Outlet)p).setDiscount(discount);
					}else p = new Product();
								
					p.setId(rs.getInt("id"));
					p.setName(rs.getString("name"));
					p.setUnitPrice(rs.getDouble("unit_price"));
					p.setStock(rs.getInt("stock"));
					p.setPhotoUrl(rs.getString("photo_url"));
					p.setCategory(rs.getString("category"));	
					p.setDescription(rs.getString("description"));
					list.add(p);
				}
			}
		} catch (SQLException e) {
			throw new GCException("用分類查詢產品失敗:" + category, e);
		}		
		return list;
	}
	
	private static final String SELECT_NEWEST_PRODUCTS=
			"SELECT id, name, unit_price, stock, photo_url, category, discount,launch_date,description "
			+ "	FROM products_list_view "
			+ "    WHERE launch_date<=DATE_ADD(curdate(), INTERVAL 1 DAY)"
			+ "    ORDER BY launch_date DESC, id DESC LIMIT 10";
	List<Product> selectNewestProducts() throws GCException{
		List<Product> list = new ArrayList<Product>();		
		
		try (
				Connection connection = MySQLConnection.getConnection(); //1,2. 取得連線
				PreparedStatement pstmt = connection.prepareStatement(SELECT_NEWEST_PRODUCTS);				
			){			
			try(
					ResultSet rs = pstmt.executeQuery(); //4.執行指令
				){
				//5. 處理rs
				while(rs.next()) {
					Product p;
					int discount = rs.getInt("discount");
					if(discount>0) {
						p = new Outlet();
						((Outlet)p).setDiscount(discount);
					}else {
						p = new Product();
					}
					
					p.setId(rs.getInt("id"));
					p.setName(rs.getString("name"));
					p.setUnitPrice(rs.getDouble("unit_price"));
					p.setStock(rs.getInt("stock"));
					p.setPhotoUrl(rs.getString("photo_url"));
					p.setCategory(rs.getString("category"));		
					p.setLaunchDate(rs.getString("launch_date"));
					p.setDescription(rs.getString("description"));
					list.add(p);
				}
			}
		} catch (SQLException e) {
			throw new GCException("查詢最新產品失敗", e);
		}
		return list;
	}
	

	
	private static final String select_Product_By_Id = "SELECT id, product_id, name, color_name, size_color,"
			+ "     size_count, unit_price,"
			+ "		stock, color_stock, photo_url, description, launch_date, category, discount,"
			+ "		color_photo, icon_url FROM product_detail_view"
			+ "        WHERE id=?";
	Product selectProductById(String productId) throws GCException{
		Product p = null;		
		try (	Connection connection = MySQLConnection.getConnection(); //1,2. 取得連線
				PreparedStatement pstmt = connection.prepareStatement(select_Product_By_Id);//3.準備指令				
			){
			//3.1 傳入?的值
			pstmt.setString(1, productId);
			
			try(ResultSet rs = pstmt.executeQuery(); //4.執行指令
				){
				//5.處理rs
				while(rs.next()) {
					if(p==null) {
						int discount = rs.getInt("discount");
						if(discount>0) {
							p = new Outlet();
							((Outlet)p).setDiscount(discount);
						}else p = new Product();					
						
						p.setId(rs.getInt("id"));
						p.setName(rs.getString("name"));
						p.setUnitPrice(rs.getDouble("unit_price"));
						p.setStock(rs.getInt("stock"));
						p.setPhotoUrl(rs.getString("photo_url"));
						p.setDescription(rs.getString("description"));
						p.setLaunchDate(rs.getString("launch_date"));
						p.setCategory(rs.getString("category"));		
						p.setLaunchDate(rs.getString("launch_date"));
						p.setSizeCount(rs.getInt("size_count"));
						//Logger.getLogger("顯示讀到的產品").log(Level.INFO, String.valueOf(p)); //for test
					}					
					
					//讀取顏色
					String colorName = rs.getString("color_name");
					if(colorName!=null) {
						Color color = new Color();
						color.setColorName(colorName);
						color.setStock(rs.getInt("color_stock"));
						color.setPhotoUrl(rs.getString("color_photo"));
						color.setIconUrl(rs.getString("icon_url"));
						
						p.addColor(color);
					}
				}
			}			
		} catch (SQLException e) {
			throw new GCException("用代號查詢產品失敗",e);
		}		
		return p;
	}
	
	private static final String SELECT_SIZE_LIST="SELECT product_id, color_name, size_name, "
			+ "	product_color_sizes.stock, "
			+ "    product_color_sizes.unit_price AS list_price,"
			+ "    product_color_sizes.unit_price * (100-discount)/100 AS price,"
			+ "    ordinal, discount"
			+ "	FROM product_color_sizes"
			+ "		INNER JOIN products ON product_color_sizes.product_id = products.id"
			+ "    WHERE product_id=? AND color_name=? ORDER BY ordinal";
	
	List<Size> selectSizeList(String productId, String colorName)throws GCException {
		List<Size> sizeList = new ArrayList<>();		
		try (   Connection connection = MySQLConnection.getConnection(); //1,2. 取得連線
				PreparedStatement pstmt = connection.prepareStatement(SELECT_SIZE_LIST); //3.準備指令
				){
			//3.1 傳入?的值
			pstmt.setString(1, productId);
			pstmt.setString(2, colorName);
			try(
					ResultSet rs = pstmt.executeQuery(); //4.執行指令
				){
				//5.處理rs
				while(rs.next()) {
					Size size = new Size();					
					size.setColorName(rs.getString("color_name"));
					size.setSizeName(rs.getString("size_name"));
					size.setStock(rs.getInt("stock"));
					size.setListPrice(rs.getDouble("list_price"));
					size.setUnitPrice(rs.getDouble("price"));
					size.setOrdinal(rs.getInt("ordinal"));
					
					sizeList.add(size);
				}				
			}
		} catch (SQLException e) {
			throw new GCException("查詢sizeList失敗", e);
		}
		return sizeList;
	}

	private static final String SELECT_PRODUCT_COLOR_SIZE_STOCK="SELECT product_id, color_name,size_name,"
			+ " stock FROM product_color_sizes "
			+ " WHERE product_id=? AND color_name=? AND size_name=?";
	int selectProductColorSizeStock(int productId, String colorName, String sizeName) throws GCException{
		System.out.println(SELECT_PRODUCT_COLOR_SIZE_STOCK);
		int stock = 0;
		try (   Connection connection = MySQLConnection.getConnection(); //1,2. 取得連線
				PreparedStatement pstmt = connection.prepareStatement(SELECT_PRODUCT_COLOR_SIZE_STOCK); //3.準備指令
				){
			//3.1傳入?的值
			pstmt.setInt(1, productId);
			pstmt.setString(2, colorName);
			pstmt.setString(3, sizeName);
			
			try(ResultSet rs = pstmt.executeQuery()){
				while(rs.next()) {
					stock = rs.getInt("stock");
				}
			}
		} catch (SQLException e) {
			throw new GCException("查詢庫存[產品顏色尺寸]失敗:" + productId +"-"+colorName+"-"+sizeName, e);
		}
		return stock;
	}

	private static final String SELECT_PRODUCT_COLOR_STOCK="SELECT product_id, color_name,"
			+ " stock FROM product_colors "
			+ " WHERE product_id=? AND color_name=?";
	int selectProductColorStock(int productId, String colorName)throws GCException {
		System.out.println(SELECT_PRODUCT_COLOR_STOCK);
		int stock = 0;
		try (   Connection connection = MySQLConnection.getConnection(); //1,2. 取得連線
				PreparedStatement pstmt = connection.prepareStatement(SELECT_PRODUCT_COLOR_STOCK); //3.準備指令
				){
			//3.1傳入?的值
			pstmt.setInt(1, productId);
			pstmt.setString(2, colorName);
			
			try(ResultSet rs = pstmt.executeQuery()){
				while(rs.next()) {
					stock = rs.getInt("stock");
				}
			}
		} catch (SQLException e) {
			throw new GCException("查詢庫存[產品顏色]失敗:" + productId +"-"+colorName+"-", e);
		}
		return stock;
	}
	
	private static final String SELECT_PRODUCT_STOCK="SELECT id,"
			+ "stock FROM products WHERE id=?";
	int selectProductStock(int productId)throws GCException {
		System.out.println(SELECT_PRODUCT_STOCK);
		int stock = 0;
		try (   Connection connection = MySQLConnection.getConnection(); //1,2. 取得連線
				PreparedStatement pstmt = connection.prepareStatement(SELECT_PRODUCT_STOCK); //3.準備指令
				){
			//3.1傳入?的值
			pstmt.setInt(1, productId);
			
			try(ResultSet rs = pstmt.executeQuery()){
				while(rs.next()) {
					stock = rs.getInt("stock");
				}
			}
		} catch (SQLException e) {
			throw new GCException("查詢庫存[產品]失敗:" + productId, e);
		}
		return stock;
	}
}