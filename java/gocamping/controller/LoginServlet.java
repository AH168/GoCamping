package gocamping.controller;

import java.io.IOException;
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
import gocamping.exception.GCException;
import gocamping.service.CustomerService;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet(urlPatterns="/login.do")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, 
			HttpServletResponse response) throws ServletException, IOException {
		List<String> errorsList = new ArrayList<>();
		HttpSession session = request.getSession();
		//request.setCharacterEncoding("utf-8");
		
		//1.取得request的Form data(mod10),並檢查之
		String id=request.getParameter("id");
		String password=request.getParameter("password");
		String captcha=request.getParameter("captcha");
		//System.out.println(captcha); //for test
		
		if(id==null || (id=id.trim()).length()==0) {
			errorsList.add("必須輸入帳號");
		}
		
		if(password==null || password.length()==0) {
			errorsList.add("必須輸入密碼");
		}
		
		if(captcha==null || (captcha=captcha.trim()).length()==0) {
			errorsList.add("必須輸入驗證碼");
		}else {
			String oldCaptcha = (String)session.getAttribute("LoginCaptchaServlet");
			if(!captcha.equalsIgnoreCase(oldCaptcha)){
				errorsList.add("驗證碼不正確");
			}
		}
		session.removeAttribute("LoginCaptchaServlet");
		
		//2. 若無誤呼叫商業邏輯
		if(errorsList.isEmpty()) {
			CustomerService service = new CustomerService();
			try {
				Customer c = service.login(id, password);
				
				session.setAttribute("member", c);
				
				//3.1 內部轉交(forward)登入成功網頁(login_ok.jsp), for user,		
				request.getRequestDispatcher("/login_ok.jsp").forward(request, response);
				
				//3.1 外部轉址(redirect)首頁, for user, 		
				//response.sendRedirect(request.getContextPath());				
				return;
			} catch (LoginFailedException e) {
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
		
		//3.2 內部轉交(forward)登入網頁(login.jsp)將錯誤顯示在網頁上,for user
		request.setAttribute("error", errorsList);
		RequestDispatcher dispatcher = request.getRequestDispatcher("login.jsp");
		dispatcher.forward(request, response);		
	}
}

