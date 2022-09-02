<%@page import="gocamping.entity.Customer"%>
<%@ page pageEncoding="utf-8" %>
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet"  href="<%= request.getContextPath() %>/style/loginok/bootstrap.min.css" type="text/css">
		<link rel="stylesheet" 	href="<%= request.getContextPath() %>/style/loginok/style.css" type="text/css">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta http-equiv='refresh' content="5;url=<%= request.getContextPath()%>/">
		<meta charset="UTF-8">
		<title>登入成功</title>
	</head>
	<body>
		<header>	
		<jsp:include page="/subviews/nav.jsp" >
			<jsp:param value="首頁" name="subheader"/>
		</jsp:include>
		
		</header>
		<%
			Customer member = (Customer)session.getAttribute("member");			
		%>
		<article>
			<div class="site-section">
			    <div class="container">
			      <div class="row">
			        <div class="col-md-12 text-center">
			          <span class="icon-check_circle display-3 text-success"></span>
			          <h2 class="display-3 text-black">登入成功!</h2>
			          <p class="lead mb-5"><%= member!=null?member.getName():"XXX" %>歡迎回來.</p>
			          <p><a href='<%= request.getContextPath()%>/' class="btn btn-sm btn-primary">自動跳轉回首頁</a></p>
			        </div>
			      </div>
			    </div>
			</div>
		</article>
		<%@ include file="/subviews/footer.jsp" %>
</body>
</html>