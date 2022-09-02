<%@page import="java.util.Set"%>
<%@page import="gocamping.entity.Color"%>
<%@page import="java.util.Map"%>
<%@page import="gocamping.entity.Outlet"%>
<%@page import="gocamping.entity.Product"%>
<%@page import="gocamping.service.ProductService"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link href="<%= request.getContextPath() %>/style/vgb.css" rel="stylesheet">
		<title>產品介紹</title>
		<script src="https://code.jquery.com/jquery-3.0.0.js" 
					integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" 
					crossorigin="anonymous"></script>
	</head>
	<body>
			<jsp:include page="/subviews/header.jsp" >
				<jsp:param value="產品介紹" name="subheader"/>
			</jsp:include>			
			<%@ include file="/subviews/nav.jsp" %>
			<article style="padding-top:80px;">		
				<%@ include file="product_ajax.jsp" %>
			</article>
			<%@ include file="/subviews/footer.jsp" %>
	</body>
</html>


