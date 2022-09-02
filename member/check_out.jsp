<%@page import="gocamping.service.ProductService"%>
<%@page import="gocamping.entity.ShippingType"%>
<%@page import="gocamping.entity.PaymentType"%>
<%@page import="gocamping.entity.ShoppingCart"%>
<%@page import="gocamping.entity.CartItem"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link href="<%= request.getContextPath() %>/style/vgb.css" rel="stylesheet">
<title>我要結帳</title>
	<style>
			#cartTable {border-collapse: collapse;width: 80%;margin: auto}

			#cartTable caption {padding-top: 12px;padding-bottom: 12px;background-color: orange;color: white;}
						
			#cartTable th {background-color: #e2e2e2;}			
			#cartTable th,#cartTable td{border: 1px solid #d2d2d2;padding: 8px;}
			
			#cartTable tbody img{width:48px;vertical-align: middle;}
			#cartTable tr:nth-child(even){background-color:#f2f2f2;}			
			#cartTable tr:hover {background-color: beige;}
			#cartTable tbody{font-size: smaller;}
			
			#cartTable tfoot tr{border: 1px solid #d2d2d2;}
			#cartTable tfoot td{border: none;}
			#cartTable tfoot td.listprice {text-decoration:line-through;color:#d57676;font-size: smaller}
			#cartTable tfoot tr.amount, #cartTable td.amount,#cartTable tfoot tr td:last-child{text-align: right}
			#totalAmountSpan{color:blue;font-size: larger}	
			input[type='number'].quantity{width:3em;}
			#cartForm fieldset {text-align: left}
			#cartForm fieldset label{display:inline-block;min-width:3em}
			#cartForm fieldset input[type='text']{width:70%;}					
		</style>
		<script src="https://code.jquery.com/jquery-3.6.0.js" 
			integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" 
			crossorigin="anonymous"></script>
		<script>				
			$(window).on("resize",resizeAddressInput);
			
			function disableShippingType(){
				var shippingString = $("select[name='paymentType'] option:selected").attr('data-shipping');
				if(shippingString){
					var shippingArray=shippingString.split(",");
					console.log("disableShippingType() say: This is: "+shippingArray);
					var prevData = $("select[name='shippingType']").val();
					$("select[name='shippingType']").val('');
					$("select[name='shippingType'] option:NOT([value=''])").prop('disabled', true);
					for(i=0;i<shippingArray.length;i++){
						$("select[name='shippingType'] option[value='"+shippingArray[i]+"']").prop('disabled', false);
						console.log(prevData, shippingArray[i]);						
						if(prevData==shippingArray[i]){
							$("select[name='shippingType']").val(prevData);
						}
					}
				}
				calculateTotalAmount();
			}
			
			function calculateTotalAmount(){
				var paymentFee = 0;
				var shippingFee = 0;
				var totalAmount = Number($("#totalAmountSpan").html());
				if($("select[name='paymentType']").val() != ""){
					paymentFee = Number($("select[name='paymentType'] option:selected").attr("data-fee"));
				}
				if($("select[name='shippingType']").val() != ""){
					shippingFee = Number($("select[name='shippingType'] option:selected").attr("data-fee"));
				}
				//console.log(paymentFee, shippingFee, totalAmount);
				$("#totalAmountWithFeeSpan").html(totalAmount+paymentFee+shippingFee);
			}
			
			function changeAddressInput(){
				calculateTotalAmount();
				
				var shippingOption = $("select[name='shippingType']").val(); //取得shippingType的value
				console.log('changeAddressInput():'+shippingOption);
				$("#chooseStore").hide();				
				$("input[name='shippingAddress']").attr('autocomplete', 'off');
				$("input[name='shippingAddress']").prop('readonly', false);
				$("input[name='shippingAddress']").css('width', '');
				$("input[name='shippingAddress']").removeAttr('list');
				$("input[name='shippingAddress']").val('');
				if(shippingOption=='<%=ShippingType.SHOP.name()%>'){					
					$("input[name='shippingAddress']").attr('list', 'shoplist');					
				}else if(shippingOption=='<%=ShippingType.STORE.name()%>'){					
					$("input[name='shippingAddress']").prop('readonly', true);
					$("#chooseStore").show();
					resizeAddressInput();
				}else{					
					$("input[name='shippingAddress']").attr('autocomplete', 'on');	
				}
			}
			
			function resizeAddressInput(){
				//console.log($("#chooseStore").css('display'));
				if($("#chooseStore").css('display')!='none'){
					var phoneWidth = $("input[name='recipientPhone']").css('width');
					phoneWidth = Number(phoneWidth.substring(0,phoneWidth.length-2));
					$("input[name='shippingAddress']").css('width', phoneWidth-75);
				}
			}
			
			function copyMember(){
				$("input[name='recipientName']").val('${sessionScope.member.name}');
				$("input[name='recipientEmail']").val('${sessionScope.member.email}');
				$("input[name='recipientPhone']").val('${sessionScope.member.phone}');
				if($("select[name='shippingType']").val()=="HOME"){
					$("input[name='shippingAddress']").val('${sessionScope.member.address}');
				}
			}			
			
			function init(){
				<% if("POST".equals(request.getMethod() )) {%>repopulateForm();<% } %>
				$("select[name='paymentType']").on("change", disableShippingType);
				$("select[name='shippingType']").on("change", changeAddressInput);
			}
			$(init);
			
			<% if("POST".equals(request.getMethod() )) {%>
			function repopulateForm(){
				$("select[name='paymentType']").val('${param.paymentType}');
				disableShippingType();
				$("select[name='shippingType']").val('${param.shippingType}');
				changeAddressInput();
				$("input[name='recipientName']").val('${param.recipientName}');
				$("input[name='recipientEmail']").val('${param.recipientEmail}');
				$("input[name='recipientPhone']").val('${param.recipientPhone}');
				$("input[name='shippingAddress']").val('${param.shippingAddress}');				
			}
			<%}%>
		</script>
	</head>
	<body>
		<jsp:include page="/subviews/header.jsp" >
			<jsp:param value="我要結帳" name="subheader"/>
		</jsp:include> 
			
			
		<%@ include file="/subviews/nav.jsp" %>		
		<article>
			${sessionScope.error}
			<%
				ShoppingCart cart = (ShoppingCart)session.getAttribute("cart");
				if(cart==null || cart.isEmpty()){
			%>	
				<h3>購物車是空的!</h3>		
			<%  }else{ %>
			${error}
			<div style="padding-top: 50px;padding-bottom: 35px;">
			<form method='POST' action='check_out.do' id='cartForm'>
				<table id='cartTable'>
					<caption>購物車明細</caption>
					<thead>
						<tr>
							<th>名稱</th>						
							<th>顏色/Size</th>
							<th>定價</th>
							<th>折扣</th>
							<th>售價</th>
							<th>數量</th>
							<th>小計</th>							
						</tr>
					</thead>
					<tbody>
						<% 	ProductService pService = new ProductService();
							for(CartItem item:cart.getCartItemsSet()){
							int stock=pService.getStockByCartItem(item);
						%>
						<tr>
							<td>
								<img src='../<%= item.getPhotoUrl() %>'>
								<%= item.getProductName() %>
								<span style='font-size: smaller'>,庫存: <%= stock %></span>
							</td>	
							<td><%= item.getColorName() %> <%= item.getSizeName() %></td>					
							<td><%= cart.PRICE_FORMAT.format(item.getListPrice()) %>元</td>
							<td><%= cart.getDiscountString(item) %></td>
							<td><%=  cart.PRICE_FORMAT.format(cart.getUnitPrice(item)) %>元</td>
							<td><%= cart.getQuantity(item) %></td>
							<td class='amount'><%=  cart.PRICE_FORMAT.format(cart.getAmount(item)) %>元</td>							
						</tr>
						<% } %>										
					</tbody>
					<tfoot>
						<tr>										
							<td class='amount' colspan="1">共<%= cart.size() %>項, <%= cart.getTotalQuantity() %>件</td>
							<td class='amount listprice' colspan="3">原價總額為: 
								<%= cart.AMOUNT_FORMAT.format(cart.getTotalListAmount()) %>元</td>
							</td>
							<td class='amount' colspan="3">總金額為: 
								<span id='totalAmountSpan'><%= cart.AMOUNT_FORMAT.format(cart.getTotalAmount()) %></span>元</td>
						</tr>	
						<tr>
							<td colspan='3'>
								<span>
									<label>付款方式:</label>
									<select name='paymentType'><!-- onchange='disableShippingType()' -->
										<option value=''>請選擇...</option>
										<% for(PaymentType pType:PaymentType.values()) {%>
										<option value='<%=pType.name() %>' data-fee='<%= pType.getFee()%>'
											data-shipping='<%=pType.getShippingTypes()%>'><%=pType%></option>
										<% } %>
									</select>   
								</span>
								<span>
								<label>取貨方式:</label>
									<select name='shippingType' required><!--  onchange='changeAddressInput()' -->
										<option value=''>請選擇...</option>
										<% for(ShippingType shType:ShippingType.values()) {%>
										<option value='<%=shType.name() %>' data-fee='<%= shType.getFee()%>'><%=shType%></option>
										<% } %>
										
									</select> 
								</span>
							</td>
							<td colspan='4'>
								<span>含物流手續費總金額為: <span id='totalAmountWithFeeSpan'><%= cart.AMOUNT_FORMAT.format(cart.getTotalAmount()) %></span>元</span>
							</td>
						</tr>
						<tr>
							<td colspan='9'>
								<fieldset>
									<legend>收件人資訊 <a href='javascript:copyMember()'>同訂購人</a></legend>
									<label>姓名: </label><input type='text' name='recipientName' required"><br>
									<label>email: </label><input type='text' name='recipientEmail' required><br>
									<label>電話: </label><input type='text' name='recipientPhone' required><br>
									<label>地址: </label><input type='text' name='shippingAddress' required>
									<button type='button' id='chooseStore' style='display:none' onclick='goEZShip()'>選擇超商</button>
								</fieldset>
									<datalist id='shoplist''>
										<option value='復北門市 台北市松山區復興北路99號14樓'>復北門市</option>
										<option value='新竹門市 新竹市東區光復路二段295號3樓之2'>新竹門市</option>
										<option value='台中門市 台中市西區臺灣大道二段309號2樓'>台中門市</option>
									</datalist>
							</td>
						</tr>
						<tr>										
							<td colspan="1"><input type='button' value='回購物車' ></td>
							<td colspan="7">
								<input type='submit' value='送出訂單'>
							</td>
						</tr>													
					</tfoot>
				</table>
			</form>
			</div>
			<script>                         

			  function goEZShip() {//前往EZShip選擇門市
	             if (confirm("Go EZ前，你的網址已經改用ip Address了嗎?")) {			
	                  alert("出發");			
	             } else {			
	                  alert("快改網址!");			
	                  return;			
	             }
			
				$("input[name='recipientName']").val($("input[name='recipientName']").val().trim());			
				$("input[name='recipientEmail']").val($("input[name='recipientEmail']").val().trim());			
				$("input[name='recipientPhone']").val($("input[name='recipientPhone']").val().trim());			
				$("input[name='shippingAddress']").val($("input[name='shippingAddress']").val().trim());			
			
				var protocol = "<%= request.getProtocol().toLowerCase().substring(0, request.getProtocol().indexOf("/")) %>";		
				var ipAddress = "<%= java.net.InetAddress.getLocalHost().getHostAddress()%>";			
				var url = "https://" + ipAddress + ":" + location.port + "<%=request.getContextPath()%>/member/ezship_callback.jsp";                 
			
				$("#rtURL").val(url);
			
				//$("#webPara").val($("form[action='check_out.do']").serialize());			
				$("#webPara").val($("#cartForm").serialize());
			
				//alert('現在網址不得為locolhost: '+url); //測試用，測試完畢後請將此行comment			
				//alert($("#webPara").val()) //測試用，測試完畢後請將此行comment			 
			
				$("#ezForm").submit();			
			  }
			
			</script>
			
			<form id="ezForm" method="post" name="simulation_from" action="https://map.ezship.com.tw/ezship_map_web_2014.jsp" >			
				<input type="hidden" name="suID"  value="test@gc.com"> <!-- 業主在 ezShip 使用的帳號, 隨便寫 -->			
				<input type="hidden" name="processID" value="GC202107050000005"> <!-- 購物網站自行產生之訂單編號, 隨便寫 -->			
				<input type="hidden" name="stCate"  value=""> <!-- 取件門市通路代號 -->			
				<input type="hidden" name="stCode"  value=""> <!-- 取件門市代號 -->			
				<input type="hidden" name="rtURL" id="rtURL" value=""> <!-- 回傳路徑及程式名稱 -->			
				<input type="hidden" id="webPara" name="webPara" value=""> <!-- 結帳網頁中cartForm中的輸入欄位資料。ezShip將原值回傳，才能帶回結帳網頁 -->			
			</form>
			<% } %>				
		</article>
		<%@ include file="/subviews/footer.jsp" %>
</body>
</html>


		
		