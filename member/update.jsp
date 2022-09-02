<%@page import="gocamping.entity.VIP"%>
<%@page import="gocamping.entity.Customer"%>
<%@ page pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" href="<%= request.getContextPath() %>/style/lrpage/graindashboard.css" type="text/css">
		<title>露營趣GoCamping 會員修改</title>		
		<style>
			#captchaImg{vertical-align: middle;}
			#refreshIcon{width: 22px;vertical-align: middle}
			
			footer{text-align:center;}			
			.memberForm label{display:inline-block;min-width:5.5ex}
			.errors{color:red}
		</style>
		<script src="https://code.jquery.com/jquery-3.0.0.js" 
			integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" 
			crossorigin="anonymous"></script>
		<script>
			function changePwdDisplay() {
				//alert(displayPwd.checked);
				if (displayPwd.checked){
					pwd1.type="text";
					pwd2.type="text";
				}else{
					pwd1.type="password";
					pwd2.type="password";
				}
			}
			
			function changePasswordOrNot(theCheckbox){				
					$("#pwd1").prop("disabled", !$(theCheckbox).prop("checked"));
					$("#pwd2").prop("disabled", !$(theCheckbox).prop("checked"));					
					$("#pwd1").prop("required", $(theCheckbox).prop("checked"));
					$("#pwd2").prop("required", $(theCheckbox).prop("checked"));
			}
			
			function refreshCaptcha(){
				//alert("refresh captcha"); //for test
				captchaImg.src="../images/captcha.png?test=" + parseInt(new Date().getTime()/1000);
			}	
			
			$(document).ready(init);
			
			function init(){
				repopulateForm();
			}
			
			function repopulateForm(){
				<% if("POST".equals(request.getMethod())){%>
					//alert("POST");					
					$("input[name='userid']").val('${param.userid}');					
					$("input[name='name']").val('<%= request.getParameter("name")%>');
					$("input[name='changePassword']").prop('checked',<%= request.getParameter("changePassword")!=null%>);
					<% if( request.getParameter("changePassword")!=null) {%>
						changePasswordOrNot(changePwd);
					<%}%>
					$("input[name='password1']").val('<%= request.getParameter("password1")%>');
					$("input[name='password2']").val('<%= request.getParameter("password2")%>');
					$("input[name='email']").val('<%= request.getParameter("email")%>');
					$("input[name='birthday']").val('<%= request.getParameter("birthday")%>');
					$("textarea[name='address']").val('<%= request.getParameter("address")%>');
					$(".gender[value='<%= request.getParameter("gender")%>']").prop('checked', true);
					$("input[name='phone']").val('<%= request.getParameter("phone")%>');					
					$("select[name='bloodType']").val('<%= request.getParameter("bloodType")%>');
					$("input[name='subscribed']").prop('checked', <%= request.getParameter("subscribed")!=null%>);					
				<%}else{
					Customer member = (Customer)session.getAttribute("member");
					if(member!=null){
				%>
		
					$("input[name='userid']").val('${sessionScope.member.id}');
					
					$("input[name='name']").val('<%= member.getName()%>');
					$("input[name='password1']").val('');
					$("input[name='password2']").val('');
					$("input[name='email']").val('${sessionScope.member.email}');
					$("input[name='birthday']").val('${sessionScope.member.birthday}');
					$("textarea[name='address']").val('${sessionScope.member.address}');
					$(".gender[value='<%= member.getGender()%>']").prop('checked', true);
					$("input[name='phone']").val('<%= member.getPhone()%>');					
					<%-- $("select[name='bloodType']").val('${sessionScope.member.bloodType}'); --%>
					$("input[name='subscribed']").prop('checked', <%= member.isSubscribed() %>);
					<%
					if(member instanceof VIP){
					%>
					$("#discountSpan").html("<input type='checkbox' disabled checked><label>"
								+	"VIP 享有<%= ((VIP)member).getDiscountString() %>"
								+	"</label>")
					<%}%>
				<%}else{%>
					alert('請先登入!');
				<%}}%>
			}
		</script>
	</head>
		<%
		List<String> errors = (List<String>)request.getAttribute("error");
	%>
<body>
	
	
	<article>		
	
		
	<main class="main" style="background-color: #fefdfb">
        <div class="content"> 
              <div class="container-fluid pb-5">
                  <div class="row justify-content-md-center">
                      <div class="card-wrapper col-12 col-md-4 mt-5">
                          <div class="brand text-center mb-3">
                          <a href="<%= request.getContextPath()%>/index.jsp"><img src="<%= request.getContextPath() %>/	images/logo/headerlogo.png" width="200" height="60" alt=""></a>
                          </div>
		
						<div class="card">
                              <div class="card-body">
                                  <h4 class="card-title">會員修改</h4>
                                 
                                  	<form class='memberForm' method="POST" action="update.do">
									<p class='errors'><%= errors!=null?errors:"" %></p>
							
							<div class="form-group">
                                          <label>帳號</label>
                                          <input class="form-control" name='userid' maxlength="10" readonly>
                                          <span id='discountSpan'></span>
                            </div>
                             <hr>
                            <div class="form-group">
                                          <label>姓名</label>
                                          <input class="form-control"name='name' placeholder="輸入姓名" minlength='<%= Customer.MIN_NAME_LENGTH%>' maxlength="<%= Customer.MAX_NAME_LENGTH %>" required>
                            </div>
                             <hr>
                            <div class="form-group">
                                          <label>密碼</label>
                                          <input class="form-control" type='password' name='password' placeholder="輸入現在的密碼" required>
                            </div>
                             <hr>
                             
                             
                             <div class="form-group">
                             <legend><input type='checkbox' id='changePwd' name='changePassword' onchange='changePasswordOrNot(this)'>我要改密碼</legend>
                                          <label>新密碼</label>
                                          <input class="form-control" type='password' id='pwd1' name='password1' placeholder="輸入新密碼" disabled 	 
					maxlength="<%= Customer.MAX_PASSWORD_LENGTH %>" minlength="<%= Customer.MIN_PASSWORD_LENGTH %>">
                            </div>
                            <hr>
                              <div class="form-group">
                                          <label>確認</label>
                                          <input class="form-control" type='password' id='pwd2' name='password2' placeholder="輸入確認密碼" disabled 
											maxlength="<%= Customer.MAX_PASSWORD_LENGTH %>" minlength="<%= Customer.MIN_PASSWORD_LENGTH %>">
											<input type='checkbox' id='displayPwd' onchange="changePwdDisplay()"><lable>顯示密碼</lable>
                            </div>
                            <hr>
                            
                           <div class="form-group">
                                          <label>email</label>
                                          <input class="form-control" type='email' name='email' required>
                            </div>
                             
                               <hr>
                            
                           <div class="form-group">
                                          <label>生日</label>
                                          <input class="form-control" type='date' name='birthday' required>
                            </div>
                            
                             <hr>
                            <div class="form-group">
                                          <label>性別</label>
                                         <input type="radio" name='gender' id='male' value="M" required><label for='male' required >男</label>
                                         <input type="radio" name='gender' id='female' value="F" required><label for='female' required>女</label>
                                         <input type="radio" name='gender' id='unknown' value="U" required><label for='unknow' required>不想透漏</label>
                            </div>
                            
                            
                            <hr>
                            
                           <div class="form-group">
                                          <label>地址</label>
                                          <textarea class="form-control" name='address'></textarea>
                            </div>
                            
                            
                              <hr>
                            
                           <div class="form-group">
                                          <label>電話</label>
                                          <input class="form-control" type='tel' name='phone' >
                            </div>
                            
                        
                       
							
							 <hr>
							<div class="form-group">
							<label>血型</label>
							<select name='bloodType'>
	                        <option value=''>請選擇...</option>
	                        <option value='O'>O型</option>
	                        <option value='A'>A型</option>
	                        <option value='B'>B型</option>
	                        <option value='AB'>AB型</option>
		                    </select> 
		                    <input type='checkbox' name='subscribed'><label>訂閱電子報</label>
							</div>
							
							
							 <hr>
							<div class="form-group no-margin">
							 <input class="btn btn-primary btn-block" style="background-color: #ffda85;border-color: #ffda85;" type='submit' value="確定修改"> 
							</div>
						
						</form>
						</div>
						</div>
						<footer class="footer mt-3">
							<div class="container-fluid">
								<div class="footer-content text-center small">
									<span class="text-muted">&copy; 2022 露營趣 GoCamping All Rights Reserved.</span>
								</div>
							</div>

	</article>
</body>
</html>