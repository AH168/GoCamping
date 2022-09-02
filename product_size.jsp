<%@page import="gocamping.service.ProductService"%>
<%@page import="gocamping.entity.Size"%>
<%@page import="java.util.List"%>
<%@ page pageEncoding="UTF-8"%>
	<%
		String productId = request.getParameter("productId");
		String color = request.getParameter("color");
		List<Size> sizeList = null;
		if(productId!=null && color!=null){
			ProductService pService = new ProductService();
			sizeList = pService.getSizeList(productId, color);
		}
	%>
		<option value='' >請選擇</option>
		<%  if(sizeList!=null && sizeList.size()>0){
				for(Size size:sizeList){
		%>
  	    <option value='<%=size.getSizeName() %>' 
  	    		data-color='<%=size.getColorName() %>' 
  	    		data-stock='<%=size.getStock() %>' 
  	    		data-listPrice='<%=size.getListPrice() %>' 
  	    		data-price='<%=size.getUnitPrice()%>'>
  	    	<%=size.getSizeName() %>, 庫存:<%= size.getStock() %>
  	   	</option>
  	    <% 		}
			}	%>		