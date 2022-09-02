<%@page import="gocamping.entity.Customer"%>
<%@ page pageEncoding="UTF-8"%>

<style>
	@import url('https://fonts.googleapis.com/css2?family=Noto+Sans+TC:wght@300&display=swap');
	body {
		margin: 0;
		background: #FFFFFF;
		font-family: 'Work Sans', sans-serif;
		font-weight: 800;
	}
	.container {
		width: 90%;
		margin: auto;
	}

	header {
	  background:white;
	}

	header::after {
	  content: '';
	  display: table;
	  clear: both;
	}

	.logo {
	  float: left;
	  padding: 10px 0;
	}

	nav {
	  float: right;
	}

	nav ul {
	  margin: 0;
	  padding: 10px 30px ;
	  list-style: none;
	}

	nav li {
	  display: inline-block;
	  margin-left: 60px;
	  padding-top: 23px;

	  position: relative;
	}

	nav a {
	  color: #444;
	  text-decoration: none;
	  text-transform: uppercase;
	  font-size: 14px;
	}

	nav a:hover {
	  color: #000;
	}

	nav a::before {
	  content: '';
	  display: block;
	  height: 5px;
	  background-color: #FFED97;

	  position: absolute;
	  top: 0;
	  width: 0%;

	  transition: all ease-in-out 250ms;
	}

	nav a:hover::before {
	  width: 100%;
	}

	.cartIcon{width:22px;vertical-align: middle;}
	.totalQtySpan{color:red}

</style>

	
	
	
<header>

	<% //取得登入的會員
			Customer member = (Customer)session.getAttribute("member");		
		%>
		
    <div class="container">
       <a class="logo" href="<%= request.getContextPath()%>/index.jsp"><img src="<%= request.getContextPath() %>/images/logo/headerlogo.png" width="190" height="55" alt=""></a>

      <nav>
        <ul>
          <li><a href="<%= request.getContextPath()%>/index.jsp">首頁</a></li>
          <li><a href="<%= request.getContextPath()%>/products_list.jsp">商店</a></li>
          <li><a href="<%= request.getContextPath()%>/campsite_list.jsp">營區訂位</a></li>
           <% if(member==null) {%>
          <li><a href='<%= request.getContextPath()%>/register.jsp'>註冊</a></li>
          <li><a href="<%= request.getContextPath()%>/login.jsp" class="in">登入</a></li>
           <% }else{%>
          <li><a href="<%= request.getContextPath()%>/member/update.jsp">修改會員</a></li>
          <li><a href="<%= request.getContextPath()%>/member/order_history.jsp">歷史訂單</a></li>
          <li><a href='logout.do'>登出</a></li>
            <% }%>
             <li ><a href='<%= request.getContextPath()%>/member/cart.jsp'>
					<image class='cartIcon' src='<%=request.getContextPath()%>/images/cart_icon.png'></a></li>
					<span class='totalQtySpan'>${sessionScope.cart.totalQuantity}</span>

        </ul>

      </nav>
    </div>
  </header>
		
		
		
	<!-- nav.jsp end -->