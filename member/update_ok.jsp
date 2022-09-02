<%@page import="gocamping.entity.Customer"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet"  href="<%= request.getContextPath() %>/style/updateok/bootstrap.min.css" type="text/css">
		<link rel="stylesheet" 	href="<%= request.getContextPath() %>/style/updateok/style.css" type="text/css">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta http-equiv='refresh' content="5;url=<%= request.getContextPath()%>/">
		<title>修改成功</title>
	</head>
<body>
		
		<header>	
	<%@ include file="/subviews/nav.jsp" %>	
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
			          <h2 class="display-3 text-black"><%= c!=null?c.getName():"" %>修改成功!</h2>
			          <p class="lead mb-5"></p>
			          <p><a href='<%= request.getContextPath() %>/' class="btn btn-sm btn-primary">自動跳轉回首頁</a></p>
			        </div>
			      </div>
			    </div>
			</div>
		</article>
		<%@ include file="/subviews/footer.jsp" %>
</body>
</html>