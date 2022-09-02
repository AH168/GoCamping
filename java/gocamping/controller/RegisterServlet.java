package gocamping.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import gocamping.entity.Customer;
import gocamping.exception.LoginFailedException;
import gocamping.exception.GCDataInvalidException;
import gocamping.exception.GCException;
import gocamping.service.CustomerService;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet(urlPatterns="/register.do")
public class RegisterServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public RegisterServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
    @Override
	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		List<String> errorsList = new ArrayList<>();
		HttpSession session = request.getSession();
		request.setCharacterEncoding("utf-8");
		//1.取得request的Form data(mod10),並檢查之
		String userid=request.getParameter("userid");
		String name=request.getParameter("name");
		String password1=request.getParameter("password1");
		String password2=request.getParameter("password2");
		String gender=request.getParameter("gender");
		String email=request.getParameter("email");
		String birthday=request.getParameter("birthday");
		String address=request.getParameter("address");
		String phone=request.getParameter("phone");
		String subscribed=request.getParameter("subscribed");
		String bloodType=request.getParameter("bloodType"); 
		
		
		
		if(userid==null || (userid=userid.trim()).length()==0) {
			errorsList.add("必須輸入帳號");
		}
		
		if(password1==null || password1.length()==0) {
			errorsList.add("必須輸入密碼與確認密碼");
		} 
		
		if (password2==null || !password2.equals(password1)) {
			errorsList.add("必須輸入一致的密碼與確認密碼");
		}
		
		if(name==null || (name=name.trim()).length()==0) {
			errorsList.add("必須輸入姓名");
		}
		
		if(gender==null || (gender=gender.trim()).length()==0) {
			errorsList.add("必須選擇性別");
		}
		
		if(email==null || (email=email.trim()).length()==0) {
			errorsList.add("必須輸入email");
		}

		if(birthday==null || (birthday=birthday.trim()).length()==0) {
			errorsList.add("必須輸入出生日期");
		}
		

		
		//2. 若無誤呼叫商業邏輯
		if(errorsList.isEmpty()) {			
			try {
				Customer c = new Customer();				
				c.setId(userid);
				c.setName(name);
				c.setPassword(password1);
				c.setEmail(email);
				c.setBirthday(birthday);
				c.setGender(gender.charAt(0));
				c.setAddress(address);
				c.setPhone(phone);
				c.setSubscribed(subscribed!=null);
				
				CustomerService service = new CustomerService();
				service.register(c);
				
				request.setAttribute("customer", c);
				//3.1 內部轉交(forward)登入成功網頁(register_ok.jsp), for user\			
				RequestDispatcher dispatcher = request.getRequestDispatcher("register_ok.jsp");
				dispatcher.forward(request, response);
				
				return;
			} catch (GCDataInvalidException e) {
				errorsList.add(e.getMessage());    //for user
			} catch (GCException e) {			
				//將商業邏輯log在console
				this.log(e.getMessage(), e);		//for admin				
				errorsList.add(e.getMessage()+",請聯絡管理人員"); //for user, 
			} catch(Exception e) {
				this.log("系統發生錯誤", e);		//for admin
				errorsList.add("系統發生錯誤:" + e.toString());	  //for user		
			}
		}
		
		//3.2 內部轉交(forward)登入網頁(register.jsp)將錯誤顯示在網頁上,for user
		request.setAttribute("error", errorsList);
		RequestDispatcher dispatcher = request.getRequestDispatcher("register.jsp");
		dispatcher.forward(request, response);
		
	}
}
