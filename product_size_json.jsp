<%@page import="gocamping.service.ProductService"%>
<%@page import="gocamping.entity.Size"%>
<%@page import="java.util.List"%>
<%@ page pageEncoding="UTF-8" contentType="application/json"%>

	<%
		String productId = request.getParameter("productId");
		String color = request.getParameter("color");
		List<Size> sizeList = null;
		if(productId!=null && color!=null){
			ProductService pService = new ProductService();
			sizeList = pService.getSizeList(productId, color);
		}
	%>
		[
		<%  if(sizeList!=null && sizeList.size()>0){
				for(int i=0;i<sizeList.size();i++){
					Size size = sizeList.get(i);
		%>
  	    <%= i==0?"":","%>{
  	    	"sizeName": 	"<%=size.getSizeName()%>", 
  	    	"colorName": 	"<%=size.getColorName() %>", 
  	    	"stock": 		<%=size.getStock() %>, 
  	    	"listPrice": 	<%=size.getListPrice() %>, 
  	    	"price": 		<%=size.getUnitPrice()%>  	    	
  	   	}
  	    <% 		}
			}	%>	
		]	