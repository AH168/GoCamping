<%@page import="java.util.Map"%>
<%@page import="java.util.Set"%>
<%@page import="gocamping.entity.Color"%>
<%@page import="gocamping.entity.Outlet"%>
<%@page import="gocamping.entity.Product"%>
<%@page import="gocamping.service.ProductService"%>
<%@ page pageEncoding="UTF-8"%>	
<!-- product_ajax.jsp start -->
	<style>	
		.productDiv{width: 800px;height: 500px;margin: auto}
		.productDiv>img{width:50%;display:inline-block;float:left;
			min-width:150px;max-width:280px;margin:.8ex}
		.productDesc{clear:both}
		.productDesc{margin: 2ex 1ex;max-width: 85em;min-width:20em;width:85%}
		.productDesc p{white-space: pre-wrap;}
		
		.colorDiv{line-height: 4em;white-space:nowrap;}
		.colorDiv .iconImg{width:36px;vertical-align: middle;box-shadow:gray 0 0 3px}
		/* HIDE color RADIO */
		.colorDiv [type=radio] { 
		  position: relative;top:2px;opacity: 0;width: 1px;height: 1px;
		}
		
		/* IMAGE STYLES */
		.colorDiv [type=radio] + img {
		  cursor: pointer;
		}
		
		/* CHECKED STYLES */
		.colorDiv [type=radio]:checked + img {
		  outline: 2px solid #f00;
		}	
		
		input[type="image"]{width:30px;vertical-align: middle;}
	</style>
	<script>
		function changeImage(theIcon, hasSize){
			console.log(photo.src);
			console.log(theIcon.dataset.photo);
			photo.src=theIcon.dataset.photo;//改圖片
			
			stockSpan.innerHTML="," + theIcon.title + " " +theIcon.dataset.stock;//改庫存	
			setQuantityMaxStock(theIcon.dataset.stock)
			//alert(hasSize); //for test
			if(hasSize){
				getSizeData(theIcon.title);				
			}
		}
		
		function setQuantityMaxStock(stock){
			if(Number(stock)>0){
				quantity.max=stock;//改數量input的max
				quantity.min=1;//改數量input的max
			}else{
				quantity.max=0;//改數量input的max
				quantity.min=0;//改數量input的max
			}
			$("#addCartButton").prop("disabled", Number(stock)<=0);			
		}		
		
		function getSizeData(colorName){
			var productId = $("input[name='productId']").val();
			//alert(productId + ", " + colorName);
			$.ajax({
				url: 'product_size_json.jsp?productId=' + productId + "&color="+colorName,
				method:'GET'				
			}).done(getSizeDataDoneHandler);
		}		

		//function getSizeDataDoneHandler(result){	
		//	$("select[name='size']").html(result);
		//}
		
		function getSizeDataDoneHandler(sizeJsonArray){
			//console.log(sizeJsonArray); //for test
			//alert(sizeJsonArray.length);//for test
			$("select[name='size']").empty()
								.append("<option value='' >請先選擇顏色</option>");
			for(i in sizeJsonArray){
				var sizeObj = sizeJsonArray[i];
// 				for(attrName in sizeObj){  //for test
// 					console.log(attrName, $(sizeObj).attr(attrName));
// 				}
				var option = "<option value='"+sizeObj.sizeName +"'" 
		  	    		+ " data-color='" + sizeObj.colorName +"'"
		  	    		+ " data-stock='" + sizeObj.stock +"'"
		  	    		+ " data-listPrice='" + sizeObj.listPrice +"'"
		  	    		+ " data-price='" + sizeObj.price +"'>"
							+ sizeObj.sizeName + ",庫存:" + sizeObj.stock + "個" 
						+ "</option>";
// 				console.log(option); //for test
				$("select[name='size']").append(option);				
			}
			
		}
		
		function changeSize(){
			//alert($("select[name='size'] option:selected").val());
			var stock = $("select[name='size'] option:selected").attr("data-stock");
			var listPrice = $("select[name='size'] option:selected").attr("data-listPrice");
			var price = $("select[name='size'] option:selected").attr("data-price");
			var colorName = $("select[name='size'] option:selected").attr("data-color");
			console.log(stock, listPrice, price, colorName);
			$("#listPriceSpan").html(listPrice);
			$("#priceSpan").html(price);
			$("#sizeStockSpan").html("(" + $("select[name='size']").val()+":" + stock+"個)");
		}
		
		function addCart(){
			//console.log('action:' + $("#addCartForm").attr("action"));			
			//console.log('method:' + $("#addCartForm").attr("method"));
			//console.log('Form Data:' + $("#addCartForm").serialize());
			
			//改成非同步請求
			$.ajax({
				url: $("#addCartForm").attr("action")+"?ajax=",
				method: $("#addCartForm").attr("method"),
				data: $("#addCartForm").serialize()
			}).done(addCartDoneHandler);
			return false; //取消同步的submit請求
		}
		
		function addCartDoneHandler(result){
			console.log(result);
			alert("加入購物車成功，共" +result.totalQty+"件");
			$(".totalQtySpan").html(result.totalQty)
			//$("html").html(result);
		}
		
	</script>
		<div>
			<a href='<%= request.getContextPath()%>/member/cart.jsp'>
				<image class='cartIcon' src='<%=request.getContextPath()%>/images/cart_icon.png'>
			</a><span class='totalQtySpan'>${sessionScope.cart.totalQuantity}</span>
		</div>
		<%
			String productId = request.getParameter("productId");
			ProductService service = new ProductService();
			Product p = null;
			if(productId!=null){
				p = service.getProductById(productId);
			}		
		%>			
			<% if(p==null) {%>
				<p>查無此產品(<%= productId %>)</p>
			<%}else{ %>
			<div class='productDiv' >
				<img id='photo' src='<%=p.getPhotoUrl()%>'>
				<h3><%=p.getName()%></h3>
				<% if(p instanceof Outlet){%>
				<div>定價：<span id='listPriceSpan'><%= ((Outlet)p).getListPrice() %></span>元</div>
				<div>折扣: <%= ((Outlet)p).getDiscountString() %> </div>
				<%} %>
				<div>優惠價: <span id='priceSpan'><%=p.getUnitPrice()%></span>元</div>
				<div>庫存: <%=p.getStock()%><span id='stockSpan'></span><span id='sizeStockSpan'></span></div>	
				<form id='addCartForm' method='POST' action='add_cart.do' onsubmit='return addCart()'>
					<input type="hidden" name='productId' value='${param.productId}'>
					<% if(p.isColorful()) {%>
				    <div class='colorDiv'>
					    <label>顏色:</label>
					    <% 
					    	Map<String, Color> map = p.getColorsMap();
							Set<String> colorNameSet = map.keySet();							
							for(String colorName:colorNameSet){
								Color color = map.get(colorName);
					    %>
					    <label>
							<input type='radio' name='color' required value="<%= colorName %>" required>
							<img class='iconImg' onclick='changeImage(this, <%=p.getSizeCount()>0 %>)' data-stock='<%= color.getStock() %>' title='<%= color.getColorName() %>'
								 src='<%= color.getIconUrl() %>'
								 data-photo='<%= color.getPhotoUrl() %>'
								>
						</label>
						<% } %>						
					</div>					
					<% } %>
					<% if(p.getSizeCount()>0) {%>
					<div>
						<label>Size:</label>
						<select name='size'  required onchange='changeSize()'>
							<option value='' >請先選擇顏色</option>
						</select>
					</div>
					<% } %>			
					<div>
					    <label>數量: </label>
						<input type='number' id='quantity' name='quantity' required min='1' max='<%=p.getStock()%>'>
						<input id='addCartButton' type="image" src="images/add_cart.png" alt="加入購物車" title='加入購物車'>
					</div>					
				</form>	
				<div class='productDesc'>
				<% if(p.getDescription()!=null && p.getDescription().length()>0) {%>
				<hr>
				<% }%>
					<p><%=p.getDescription() %></p>
				</div>				
			</div>
			<script>
			<% 	if(!p.isColorful() && p.getSizeCount()>0){%>
				getSizeData('');
			<%	}%>
			setQuantityMaxStock(<%= p.getStock() %>);
			</script>
			<%}%>		
<!-- product_ajax.jsp end -->								