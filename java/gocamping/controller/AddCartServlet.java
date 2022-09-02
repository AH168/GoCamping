package gocamping.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import gocamping.entity.Product;
import gocamping.entity.ShoppingCart;
import gocamping.entity.Size;
import gocamping.exception.GCException;
import gocamping.service.ProductService;

/**
 * Servlet implementation class AddCartServlet
 */
@WebServlet("/add_cart.do")
public class AddCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddCartServlet() {
        super();
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<String> errorsList = new ArrayList<>();
		HttpSession session = request.getSession();
		//1.讀取request的Form Data: productId, [color, size], quantity
		String productId = request.getParameter("productId");
		String color = request.getParameter("color");
		String size = request.getParameter("size");
		String quantity = request.getParameter("quantity");
		
		System.out.printf("id:%s, color:%s, size:%s, quantity:%s\n", 
				productId, color, size, quantity); //for test
		
		if(productId==null) 
			errorsList.add("沒有productId無法加入購物車");		
		
		if(quantity==null || !quantity.matches("\\d+")) 
			errorsList.add("quantity必須為整數樣式:" + quantity);	
		
		//2.若無誤執行商業邏輯
		if(errorsList.isEmpty()) {
			ProductService pService = new ProductService();			
			try {
				Product p = pService.getProductById(productId);
				Size sizeObj = null;
				if(p.getSizeCount()>0 && size!=null) {
					List<Size> sizeList= pService.getSizeList(productId, color==null?"":color);
					for(Size theSize:sizeList) {
						if(size.equals(theSize.getSizeName())) {
							sizeObj = theSize;
							break;
						}
					}
					if(sizeObj==null) errorsList.add("加入購物車時此產品查無該尺寸:" + productId + "-" + color + "-" + size);	 
				}
				if(p!=null) {
					int qty = Integer.parseInt(quantity);					
					if(qty>0) {
						ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
						if(cart==null) {
							cart = new ShoppingCart();
							session.setAttribute("cart", cart);
						}						
						cart.add(p, color, sizeObj, qty);						
					}else {
						errorsList.add("加入購物車時qty必須>0: " + qty);	
					}					
				}else {
					errorsList.add("加入購物車時查無此產品:" + productId);					
				}				
			} catch (GCException e) {
				this.log(e.getMessage(), e);				
			} catch (Exception e) {
				this.log("發生非預期錯誤!", e);				
			}			
		}		
		
		if(errorsList.size()>0) {
			this.log("加入購物車發生錯誤:\n" + errorsList.toString());
		}
		
		String ajax = request.getParameter("ajax");
		if (ajax!=null) {
			//3.收到[非同步]請求forward到/small_cart.jsp
			request.getRequestDispatcher("/small_cart.jsp").forward(request, response);
		}else {
			//3.收到[同步]請求redirect到/member/cart.jsp
			response.sendRedirect(request.getContextPath()+"/member/cart.jsp");
		}
	}
}