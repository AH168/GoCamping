<%@page import="gocamping.entity.Outlet"%>
<%@page import="gocamping.entity.Product"%>
<%@page import="java.util.List"%>
<%@page import="gocamping.service.ProductService"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link href="<%= request.getContextPath() %>/style/vgb.css" rel="stylesheet">
		<link rel='stylesheet' type='text/css' 
			href='<%= request.getContextPath() %>/fancybox3/jquery.fancybox.css'>
	
		<title>露營趣 GoCamping</title>
	
		<style>
		body {
		  box-sizing: border-box;
		  font-family: "Open Sans", sans-serif;
		  background: #f8f8f8;
		  -webkit-font-smoothing: antialiased;
		  -moz-osx-font-smoothing: grayscale;
		  text-rendering: optimizeLegibility;
		}
		body * {
		  box-sizing: inherit;
		}

		.wrapper {
		  width: 40em;
		  margin: 4em auto;
		  background: #fff;
		  padding: 4em;
		  border-radius: 8px;
		  border: 1px solid #f5f5f5;
		}
		.wrapper > :first-child {
		  margin-top: 0;
		}
		.wrapper > :last-child {
		  margin-bottom: 0;
		}


		footer {
		  margin: 4em auto;
		  text-align: center;
		  font-size: 0.9em;
		}

		a {
		  text-decoration: none;
		  color: #2196F3;
		}
		a:hover {
		  text-decoration: underline;
		}

		.emoticon-face {
		  background: #FFEB3B;
		  border-radius: 100%;
		  width: 1.7em;
		  height: 1.7em;
		  transform: rotate(90deg);
		  display: inline-block;
		  vertical-align: middle;
		  line-heigh: 1;
		  margin: -0.4em 0.2em 0;
		  text-align: center;
		  border: 1px solid #FDD835;
		  padding-left: 0.1em;
		  -webkit-font-smoothing: antialiased;
		}
		.emoticon-face--no-rotation {
		  transform: rotate(0deg);
		}

		code {
		  padding: 0.2em 0.3em;
		  background: #f5f5f5;
		  margin: 0 0.2em;
		  border-radius: 4px;
		  font-size: 0.95em;
		  font-family: "Source Code Pro";
		}

		.tac {
		  text-align: center;
		}

		.wrapper {
		  width: 68em;
		}

		* {
		  box-sizing: border-box;
		}

		body {
		  color: #777;
		  font-family: "Open Sans", Arial, sans-serif;
		}

		.product-grid {
		  width: 60em;
		  margin: 2rem auto;
		}
		.product-grid.product-grid--flexbox .product-grid__wrapper {
		  display: flex;
		  flex-wrap: wrap;
		}
		.product-grid.product-grid--flexbox .product-grid__title {
		  height: auto;
		}
		.product-grid.product-grid--flexbox .product-grid__title:after {
		  display: none;
		}
		.product-grid__wrapper {
		  margin-left: -1rem;
		  margin-right: -1rem;
		}
		.product-grid__product-wrapper {
		  padding: 1rem;
		  float: left;
		  width: 33.33333%;
		}
		.product-grid__product {
		  padding: 1rem;
		  position: relative;
		  cursor: pointer;
		  background: #fff;
		  border-radius: 4px;
		}
		.product-grid__product:hover {
		  box-shadow: 0px 0px 0px 1px #eee;
		  z-index: 50;
		}
		.product-grid__product:hover .product-grid__extend {
		  display: block;
		}
		.product-grid__img-wrapper {
		  width: 250px;
		  text-align: center;
		  padding-top: 1rem;
		  padding-bottom: 1rem;
		  height: 250px;
		}
		.product-grid__img {
		  max-width: 100%;
		  height: auto;
		  max-height: 100%;
		}
		.product-grid__title {
		  margin-top: 0.875rem;
		  display: block;
		  font-size: 1.125em;
		  color: #222;
		  height: 3em;
		  overflow: hidden;
		  position: relative;
		}
		.product-grid__title:after {
		  content: "";
		  display: block;
		  position: absolute;
		  bottom: 0;
		  right: 0;
		  width: 2.4em;
		  height: 1.5em;
		  background: linear-gradient(to right, rgba(255, 255, 255, 0), white 50%);
		}
		.product-grid__price {
		  color: #FACA00;
		  font-weight: bold;
		  letter-spacing: 0.4px;
		}
		.product-grid__extend-wrapper {
		  position: relative;
		}
		.product-grid__extend {
		  display: none;
		  position: absolute;
		  padding: 0 1rem 1rem 1rem;
		  margin: 0.4375rem -1rem 0;
		  box-shadow: 0px 0px 0px 1px #eee;
		  background: #fff;
		  border-radius: 0 0 4px 4px;
		}
		.product-grid__extend:before {
		  content: "";
		  height: 0.875rem;
		  width: 100%;
		  position: absolute;
		  top: -0.4375rem;
		  left: 0;
		  background: #fff;
		}
		.product-grid__description {
		  font-size: 0.875em;
		  margin-top: 0.4375rem;
		  margin-bottom: 0;
		}
		.product-grid__btn {
		  display: inline-block;
		  font-size: 0.875em;
		  color: #777;
		  background: #eee;
		  padding: 0.5em 0.625em;
		  margin-top: 0.875rem;
		  margin-right: 0.625rem;
		  cursor: pointer;
		  border-radius: 4px;
		}
		.product-grid__btn i.fa {
		  margin-right: 0.3125rem;
		}
		.product-grid__add-to-cart {
		  color: #fff;
		  background: #FACA00;
		}
		.product-grid__add-to-cart:hover {
		  background:#FAEA9F;
		}
		.product-grid__view {
		  color: #777;
		  background: #eee;
		}
		.product-grid__view:hover {
		  background: white;
		  color:#777;
		}
		.fancybox-is-open .fancybox-bg {opacity: .7;}

		#productDetail{
		width: 120vh;height:80vh;
		display:none;
		}

		.category{
		color:#ADADAD;
		}

		.category:hover{
		color:#6C6C6C;
		}


		</style>
	
		<script src="https://code.jquery.com/jquery-3.0.0.js" 
			integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" 
			crossorigin="anonymous"></script>		
		<script src='<%= request.getContextPath() %>/fancybox3/jquery.fancybox.js'></script>
	
		<script>		
			function getProductJSP(productId, cat){
				//作法1: 同步請求:
// 				var urlPath = 'product.jsp?productId=' + productId;
// 				alert(urlPath); //for test				
// 				location.href=urlPath;								
				
				//作法2: 非同步請求:
				var urlPath = 'product_ajax.jsp?productId=' + productId; // + "&cat=" + cat;
				$.ajax({
					url: urlPath,
					method:'GET'					
				}).done(getProductJSPDoneHandler);
			}
			
			function getProductJSPDoneHandler(response){
				//console.log(response);				
				//用fancybox3顯示
				$('#productDetail').html(response);
				$.fancybox.open({
				    src  : '#productDetail',
				    type : 'inline',
				    opts : {
				      afterShow : function( instance, current ) {
				        console.info('done!');
			      	  }
			    	}
			  	});
			}
			
			function getBookImage(theImage){
				$(theImage).attr('src', '<%= request.getContextPath() %>/images/book.png')
			}
			
			function addCart(){
				//console.log('action:' + $("#addCartForm").attr("action"));			
				//console.log('method:' + $("#addCartForm").attr("method"));
				//console.log('Form Data:' + $("#addCartForm").serialize());
				
				//改成非同步請求
				if(useAjax){
					$.ajax({
						url: $("#addCartForm").attr("action")+"?ajax=",
						method: $("#addCartForm").attr("method"),
						data: $("#addCartForm").serialize()
					}).done(addCartDoneHandler);
					return false; //取消同步的submit請求
				}
			}
			
			
			
			
		</script>
	</head>
	
	<body>		
		<div id='productDetail'></div>
		<jsp:include page="/subviews/header.jsp" >
			<jsp:param value="GoCamping" name="subheader"/>
		</jsp:include> 
		<%@ include file="/subviews/nav.jsp" %>	
		
		<div>

		</div>	
	
		<%
			String category = request.getParameter("category");
			String keyword = request.getParameter("keyword");
			ProductService service = new ProductService();
			List<Product> list = null;
			if(category!=null){
				list = service.getProductsByCategory(category);
			}else if(keyword!=null && keyword.length()>0){
				list = service.getProductsByName(keyword);
			}else{
				list = service.getAllProducts();
			}
		%>	
		
		<article>
			<%if(list==null || list.size()==0) {%>
				<p>查無產品資料!</p>
			<%}else{%>			
			
			<div class="wrapper">
			
				 <div class="content">
					<a class="category" style="text-decoration:none;" href="<%= request.getContextPath()%>/products_list.jsp">| 所有產品 |</a>
		 			<a class="category" style="text-decoration:none;" href="<%= request.getContextPath()%>/products_list.jsp?category=帳篷">帳篷 |</a>
					<a class="category" style="text-decoration:none;" href="<%= request.getContextPath()%>/products_list.jsp?category=天幕">天幕 |</a>
					<a class="category" style="text-decoration:none;" href="<%= request.getContextPath()%>/products_list.jsp?category=野餐墊">野餐墊 |</a>
					<a class="category" style="text-decoration:none;" href="<%= request.getContextPath()%>/products_list.jsp?category=露營桌">露營桌 |</a>
					<a class="category" style="text-decoration:none;" href="<%= request.getContextPath()%>/products_list.jsp?category=露營燈">露營燈 |</a>
					<a class="category" style="text-decoration:none;" href="<%= request.getContextPath()%>/products_list.jsp?category=睡袋">睡袋 |</a>
					<a class="category" style="text-decoration:none;" href="<%= request.getContextPath()%>/products_list.jsp?category=保冷箱">保冷箱 |</a>
					<a class="category" style="text-decoration:none;" href="<%= request.getContextPath()%>/products_list.jsp?category=地墊">地墊 |</a>
					<a class="category" style="text-decoration:none;" href="<%= request.getContextPath()%>/products_list.jsp?category=餐具">餐具 |</a>
				
					<div class="product-grid product-grid--flexbox">
                    <div class="product-grid__wrapper">
										
				<% for(int i=0;i<list.size();i++){
					Product p = list.get(i);
				%>	
							<div class="product-grid__product-wrapper">
                            <div class="product-grid__product">
  									<div>
  									<a href='javascript:getProductJSP("<%= p.getId() %>", "<%= p.getCategory()%>")'>
									<img class="product-grid__img-wrapper" src='<%= p.getPhotoUrl() %>' onerror='getBookImage(this)'>
									</a>
								</div>
  								<a href='product.jsp?productId=<%= p.getId() %>'>
                                <a class="product-grid__title"> <%= p.getName() %></a>
                               </a>
                                <span class="product-grid__price">價格:<%= p.getUnitPrice() %>元</span>
                                <div class="product-grid__extend-wrapper">
                                    <div class="product-grid__extend">
                                        <p class="product-grid__description"><%= p.getDescription()%></p>
                                        <span class="product-grid__btn product-grid__add-to-cart"><i class="fa fa-cart-arrow-down"></i> Add to cart</span>				
                                        <a href='product.jsp?productId=<%= p.getId() %>' class="product-grid__btn product-grid__view"style='text-decoration: none;'><i class="fa fa-eye"></i> 了解更多</a>
                                    </div>
                                </div>
                            </div>
                        </div>
				<% } %>
				
				</div>
				</div>				
				</div>
			</div>
			<% } %>
			
		</article>
		<%@ include file="/subviews/footer.jsp" %>		
	</body>
	
</html>


