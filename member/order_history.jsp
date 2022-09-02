<%@page import="java.util.List"%>
<%@page import="gocamping.service.OrderService"%>
<%@page import="gocamping.entity.Order"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link href="<%= request.getContextPath() %>/style/vgb.css" rel="stylesheet">
		<title>歷史訂單</title>
		<style>
			#ordersTable {border-collapse: collapse;width: 80%;margin: auto;}
		
			#ordersTable caption {padding-top: 12px;padding-bottom: 12px;background-color: gray;color: white;}
			
			#ordersTable th {background-color: #e2e2e2;}			
			#ordersTable th,#cartTable td{border: 1px solid #d2d2d2;padding: 8px;}
			
			#ordersTable tbody img{width:48px;vertical-align: middle;}
			#ordersTable tbody tr td{padding:1ex}
			#ordersTable tr:nth-child(even){background-color:#f2f2f2;}			
			#ordersTable tr:hover {background-color: Lavender;}
		</style>
	</head>
	<body>
		<jsp:include page="/subviews/header.jsp" >
			<jsp:param value="歷史訂單" name="subheader"/>
		</jsp:include>
		<%@ include file="/subviews/nav.jsp" %>
		
		<%			
			OrderService  oService = new OrderService();
			List<Order> list = null;
			if(member!=null){
				list = oService.getOrderHistory(member.getId());
			}
		%>		
		<article>				
			<%if(list==null || list.isEmpty()) {%>
				<p>查無歷史訂單</p>
			<%}else{ %>		
			<div style='padding-top:100px;padding-bottom:100px;'>
				<table id='ordersTable' >
					<caption>歷史訂單</caption>
					<!-- <colgroup>
    					<col span="4" style="text-align: center">
    					<col style="text-align: right">
    					<col style="text-align: center">
  					</colgroup> -->
					<thead>
						<tr>
							<th>No.</th><th>訂購日期時間</th>
							<th>付款方式</th><th>取貨方式</th><th>總金額</th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<% for(Order order:list) {%>
						<tr>
							<td><%=order.getIdString() %></td><td><%= order.getCreatedDateTime() %></td>
							<td><%= order.getPaymentType().getDescription()%></td>
							<td><%= order.getShippingType().getDescription()%></td>
							<td><%= order.getTotalAmountWithFee() %></td>
							<td><a href='order.jsp?orderId=<%=order.getId() %>'>檢視明細</a></td>
						</tr>
						<% } %>
					</tbody>
					</li>
				</table>
			<% } %>
			</div>
		</article>
		<%@ include file="/subviews/footer.jsp" %>
</body>
</html>




		
		