<%@page import="gocamping.entity.Customer"%>
<%@page import="gocamping.entity.Outlet"%>
<%@page import="gocamping.entity.Product"%>
<%@page import="java.util.List"%>
<%@page import="gocamping.service.ProductService"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link href="<%= request.getContextPath() %>/style/index.css" rel="stylesheet">
	
		
		<title>露營趣 GoCamping</title>
		
		
	
	</head>
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
		
		
	
	
	

	.productItem{display: inline-block;width:275px;height: 280px; 
				vertical-align: top;box-shadow: lightgray 1px 2px 5px;padding:1ex;text-align: center }
			.productItem img{width:150px;display: block;margin: auto;}
	</style>
	
	
	<script>
	$('.owl-carousel').owlCarousel({
		  loop: true,
		  margin: 10,
		  nav: true,
		  navText: [
		    "<i class='fa fa-caret-left'></i>",
		    "<i class='fa fa-caret-right'></i>"
		  ],
		  autoplay: true,
		  autoplayHoverPause: true,
		  responsive: {
		    0: {
		      items: 1
		    },
		    600: {
		      items: 3
		    },
		    1000: {
		      items: 5
		    }
		  }
		})
	</script>
	
	
	
	
	<body>
		<jsp:include page="/subviews/header.jsp" >
			<jsp:param value="露營趣" name="subheader"/>
		</jsp:include> 
		<%@ include file="/subviews/nav.jsp" %>		
		
		<article>
		<div style="padding-top:60px;padding-bottom:120px;">
			<%@ include file="/indexsilder.jsp" %>		
    	</div>
		<div class="section-2-1">
		<div  style='padding-top:20px;'>
		<div id="section2-text" style=' text-align: center;font-size:30px;'>露營趣每月最新產品</div>    
        <div >  
       		
      	<%
			String launchDate = request.getParameter("launchDate");
			ProductService service = new ProductService();
			List<Product> list = null;
			
				list = service.getNewestProducts();			
		%>
		
		<%if(list==null || list.size()==0) {%>
				<p>查無產品資料!</p>
			<%}else{%>		
			
			<div class="wrapper" >
			
				 <div class="content" >
					<div class="product-grid product-grid--flexbox" >
                    <div class="product-grid__wrapper" >
										
				<% for(int i=0;i<list.size();i++){
					Product p = list.get(i);
				%>	
							<div class="product-grid__product-wrapper" >
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
                                        <a href='product.jsp?productId=<%= p.getId() %>' class="product-grid__btn product-grid__view"style='text-decoration: none;'><i class="fa fa-eye" ></i> 了解更多</a>
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
			
		</div>  

		</article>
   
		
		<%@ include file="/subviews/footer.jsp" %>
	</body>
</html>