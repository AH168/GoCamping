<%@page import="gocamping.entity.ShoppingCart"%>
<%@page import="gocamping.entity.CartItem"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="widtd=device-widtd, initial-scale=1.0">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style/header/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style/header/header.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style/footer/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style/footer/footer.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style/cart/bootstrap.min.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/style/cart/cart.css">
    

<title>購物車</title>
	<style>
			
			
			
			
			
			
			
			/* #cartTable {border-collapse: collapse;width: 80%;margin: auto}

			#cartTable caption {padding-top: 12px;padding-bottom: 12px;background-color: #04AA6D;color: white;}
						
			#cartTable th {background-color: #e2e2e2;}			
			#cartTable th,#cartTable td{border: 1px solid #d2d2d2;padding: 8px;}
			
			#cartTable tbody img{width:48px;vertical-align: middle;}
			#cartTable tr:nth-child(even){background-color:#f2f2f2;}			
			#cartTable tr:hover {background-color: beige;}
			
			#cartTable tfoot tr{border: 1px solid #d2d2d2;}
			#cartTable tfoot td{border: none;}
			#cartTable tfoot tr.amount, #cartTable td.amount,#cartTable tfoot tr td:last-child{text-align: right}	
			input[type='number'].quantity{width:3em} */
						
		</style>
</head>
<body>
		<jsp:include page="/subviews/nav.jsp" >
			<jsp:param value="購物車" name="subheader"/>
		</jsp:include>	
		<article>
			<%-- ${sessionScope.cart} --%>
			<%
				ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
				if(cart==null || cart.isEmpty()){
			%>	
				<h3>購物車是空的!</h3>		
			<%  }else{ %>
			<form method='POST' action='update_cart.do' id='cartForm'>
			
			
			<div class="cart-page" style="padding:60px 0px 60px 0px;">
        		<div class="container">
          			  <div class="cart-table">
                <table>
                    <thead>
                    
                        <tr>
							<th>名稱</th>						
							<th>顏色</th>						
							<th>Size</th>
							<th>定價</th>
							<th>折扣</th>
							<th>數量</th>
							<th>小計</th>
							<th>刪除</th>
                        </tr>
                        
                    </thead>
                   
                    <tbody>
                    <% for(CartItem item:cart.getCartItemsSet()){
							int stock=item.getStock();
							%>
						
                        <tr>
                        	
                            <td class="product-col">
                                <img src='../<%= item.getPhotoUrl() %>' alt="">
                                <div class="p-title">
                                   <%= item.getProductName() %>
								<span style='font-size: smaller'>,庫存: <%= stock %></span>
                                </div>
                            </td>
                            
                            <td><%= item.getColorName() %></td>
							<td><%= item.getSizeName() %></td>					
							<td class="price-col"><%= cart.PRICE_FORMAT.format(item.getListPrice()) %>元</td>
							<td	><%= item.getDiscountString() %></td>
							<td><input class="pro-qty" type='number' name='quantity<%= item.hashCode() %>' value='<%= cart.getQuantity(item) %>'"
									 required min='1' max='<%= stock %>'>								
							</td>
							
                            <td class='total'><%=  cart.PRICE_FORMAT.format(cart.getAmount(item)) %>元</td>
							<td>
								<input class="product-close" type='checkbox' name='delete<%= item.hashCode() %>'>
							</td>
                           
                        </tr>
                      
                        <% } %>	
                    </tbody>
         			</table>
         			
         			
         			<div style="padding-top:60px;">
         			<tfoot>
						<tr>										
							<td>共<%= cart.size() %>項, <%= cart.getTotalQuantity() %>件</td>
							<td>總金額為: <%= cart.AMOUNT_FORMAT.format(cart.getTotalAmount()) %>元</td><td></td>					
						</tr>
							
						<div style="float:right;">
						<tr >										
					
                     		<input class='buttons' type='button' value='回商城繼續購物' onclick='location.href="../products_list.jsp"'>
								
                       		<input class='buttons' type='submit' name='submit' value='修改購物車'>
                      		<button class='buttons' name='submit' value='checkout'>去結帳</button>
               
						</tr>
						</div>								
					</tfoot>
         			</div>
         			
           		 </div>
           
            </div>
        </div>
	
					
				</table>
			</form>
			<% } %>
		</article>
		<%@ include file="/subviews/footer.jsp" %>
</body>
</html>

