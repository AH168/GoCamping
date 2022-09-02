<%@page import="gocamping.entity.Customer"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<link href="style/vgb.css" rel="stylesheet">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta http-equiv="refresh" content="20;url=<%= request.getContextPath() %>/">
		<link rel="stylesheet"  href="<%= request.getContextPath() %>/style/registerok/bootstrap.min.css" type="text/css">
		<link rel="stylesheet" 	href="<%= request.getContextPath() %>/style/registerok/style.css" type="text/css">
		
		
		
		<title>註冊成功</title>
	</head>
<body>
	<header>
		<jsp:include page="/subviews/header.jsp" >
			<jsp:param value="首頁" name="subheader"/>
		</jsp:include> 
	</header>

		<%
			Customer c = (Customer)request.getAttribute("customer");
		%>
		<article>
		

			<div class="site-section">
			    <div class="container">
			      <div class="row">
			        <div class="col-md-12 text-center">
			          <span class="icon-check_circle display-3 text-success"></span>
			          <h2 class="display-3 text-black"><%= c!=null?c.getName():"" %>註冊成功!</h2>
			          <p class="lead mb-5">You order was successfuly completed.</p>
			          <p><a href='<%= request.getContextPath() %>' class="btn btn-sm btn-primary">自動跳轉回首頁</a></p>
			        </div>
			      </div>
			    </div>
			  </div>
		
		
		</article>
		<%@ include file="/subviews/footer.jsp" %>
</body>
</html>