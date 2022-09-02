<%@ page pageEncoding="UTF-8"%>
	<!-- header.jsp start -->
		<header>
			<form style='padding-top:15px;float:right;padding-right:50px'  method='GET' action='<%= request.getContextPath()%>/products_list.jsp'>
				<input type='search' name='keyword' value='${param.keyword}' placeholder="請輸入查詢條件...">
				<input type='submit' value='查詢'>
			</form>	
		</header>	
	<!-- header.jsp end -->	