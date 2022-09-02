<%@page import="gocamping.entity.OrderStatusLog"%>
<%@page import="java.util.List"%>
<%@page import="gocamping.entity.PaymentType"%>
<%@page import="gocamping.entity.OrderItem"%>
<%@page import="gocamping.entity.Order"%>
<%@page import="gocamping.service.OrderService"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link href="<%= request.getContextPath() %>/style/vgb.css" rel="stylesheet">
		<title>訂單明細</title>
		<style type="text/css">
		#orderMaster fieldset label{display: inline-block;min-width: 3em}
		#orderMaster fieldset input[readonly]{width: 80%;color:blue;}
		
		#cartTable {border-collapse: collapse;width: 80%;margin: auto;clear: both;font-size: smaller}

		#cartTable caption {padding-top: 6px;padding-bottom: 6px;background-color: orange;color: white;}
						
		#cartTable th {background-color: #e2e2e2;}			
		#cartTable th,#cartTable td{border: 1px solid #d2d2d2;padding: 2px;}
			
		#cartTable tbody img{width:42px;vertical-align: middle;}
		#cartTable tr:nth-child(even){background-color:#f2f2f2;}			
		#cartTable tr:hover {background-color: beige;}
			
		#cartTable tfoot tr{border: 1px solid #d2d2d2;}
		#cartTable tfoot td{border: none;}
		#cartTable tfoot tr.amount, #cartTable td.amount,#cartTable tfoot tr td:last-child{text-align: right}	
		input[type='number'].quantity{width:3em}
			
		#cartForm fieldset input[type='text']{width:70%}
	</style>
	</head>
		<body>
		<jsp:include page="/subviews/header.jsp" >
			<jsp:param value="訂單明細" name="subheader"/>
		</jsp:include>
			
		<%@ include file="/subviews/nav.jsp" %>
		
		<%			
			String orderId = request.getParameter("orderId");
			OrderService  oService = new OrderService();
			Order order = null;
			if(member!=null && orderId!=null){
				order = oService.getOrderDetail(member.getId(),orderId);
			}
		%>		
		<article>
			<%if( order==null) { %>
				<p>查無此訂單</p>
			<%}else{ %>
			<div id='orderMaster' style='min-height:30vh;width:85%;margin: auto;padding-top:80px;'>
				<div style='float:left;width:50%;min-width: 265px'>
					<div>訂單編號: <%= order.getIdString()%>, 狀態: <%=order.getStatusDescription() %></div>
					<div>日期時間: <%= order.getCreatedDateTime()%></div>
					<div>付款方式: <%=order.getPaymentType().getDescription() %> <%= order.getPaymentFee()>0?order.getPaymentFee():""%>
						<%if(order.getPaymentType()==PaymentType.ATM && order.getStatus()==0){%>
							<a href='paid.jsp'>通知已付款</a>
						<%} %>
					</div>
					<div>取貨方式: <%=order.getShippingType().getDescription() %> <%= order.getShippingFee()>0?order.getShippingFee():""%></div>
					<div>總金額(含物流費): <%=order.getTotalAmountWithFee() %></div>
				</div>
				<fieldset style='float:left;width:75%;min-width: 255px'>
					<legend>收件資訊</legend>
					<label>姓名: </label><input readonly value='<%= order.getRecipientName()%>'><br>
					<label>email: </label><input readonly value='<%= order.getRecipientEmail()%>'><br>
					<label>電話: </label><input readonly value='<%= order.getRecipientPhone()%>'><br>
					<label>地址: </label><input readonly value='<%= order.getShippingAddress()%>'><br>
				</fieldset>
			</div>
			<div style='padding-top:100px;'>
			<table id='cartTable'>
				<caption>訂單明細</caption>
				<thead>
					<tr>						
						<th>名稱</th>						
						<th>顏色</th>						
						<th>Size</th>
						<th>售價</th>
						<th>數量</th>
						<th>小計</th>							
					</tr>
				</thead>
				<tbody>		
					<% for(OrderItem item:order.getOrderItemsSet()) {%>			
					<tr>						
						<td>
							<img src='../<%= item.getPhotoUrl() %>'>
							<%= item.getProduct().getName() %>							
						</td>	
						<td><%= item.getColorName() %></td>
						<td><%= item.getSizeName() %></td>					
						<td><%= item.getPrice() %>元</td>
						<td><%= item.getQuantity()%></td>
						<td class='amount'><%= item.getPrice() * item.getQuantity() %></td>							
					</tr>				
					<% } %>						
				</tbody>
				<tfoot>
					<tr>										
						<td class='amount' colspan="3">共<%= order.size() %>項, <%= order.getTotalQuantity() %>件</td>
						<td class='amount' colspan="3">總金額為: <span id='totalAmountSpan'><%= order.getTotalAmount() %></span>元</td>					
					</tr>
				</tfoot>
			</table>
			<% } %>	
			</div>	
		</article>
		<%@ include file="/subviews/footer.jsp" %>
	</body>
</html>


		