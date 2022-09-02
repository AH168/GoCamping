package gocamping.controller;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import gocamping.entity.Customer;
import gocamping.exception.GCException;
import gocamping.service.OrderService;

/**
 * Servlet implementation class AtmTransferedServlet
 */
@WebServlet("/member/atm_transfered.do")
public class AtmTransferedServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AtmTransferedServlet() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession();
        Customer member = (Customer) session.getAttribute("member");

        //1.讀取request中form的輸入項: paymentType, shippingType, receiverName, receiverEmail, receiverPhone,receiverAddress 
        String bank = request.getParameter("bank");
        String orderId = request.getParameter("orderId");
        String last5Code = request.getParameter("last5Code");
        String amount = request.getParameter("amount");
        String transDate = request.getParameter("date");
        String transTime = request.getParameter("time");
        List<String> errMsgs = new ArrayList<>();
        if(bank==null || bank.length()==0){
            errMsgs.add("必須bank");
        }
        if(orderId==null || !orderId.matches("\\d+")){
            errMsgs.add("必須orderId");
        }
        
        if(last5Code==null || !last5Code.matches("\\d{5}")){
            errMsgs.add("必須輸入帳號後5碼");
        }
        if(amount==null || amount.length()==0){
            errMsgs.add("必須輸入轉帳金額");
        }
        if(transDate==null || transDate.length()==0){
            errMsgs.add("必須輸入transDate");
        }
        if(transTime==null || transTime.length()==0){
            errMsgs.add("必須輸入transTime");
        }
        
      //2. 若無誤，則呼叫商業邏輯
        if(errMsgs.isEmpty()){
        	OrderService oService = new OrderService();
        	try {
				oService.updateStatusToTransfered(member, orderId, 
						bank, last5Code, Double.parseDouble(amount), LocalDate.parse(transDate), transTime);
				//3.1
				response.sendRedirect("order.jsp?orderId="+orderId);
				return;
			} catch (NumberFormatException e) {
				errMsgs.add("轉帳金額不正確" + amount);
			} catch (DateTimeParseException e) {
				errMsgs.add("transDate不正確" + transDate);
			} catch (GCException e) {				
				this.log("通知轉帳失敗:" + e.getMessage(), e);
				errMsgs.add("通知轉帳失敗:" + e.getMessage());
			} catch(Exception e) {
				this.log("通知轉帳發生錯誤:" + e.getMessage(), e);
				errMsgs.add("通知轉帳發生錯誤:" + e);
			}
        }
        
        System.out.println(errMsgs);
        
      //3.2
        request.setAttribute("errors", errMsgs);
        request.getRequestDispatcher("atm_transfered.jsp").forward(request, response);
	}
}
