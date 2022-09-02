<%@page import="gocamping.entity.Customer"%>
<%@page import="java.util.List"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<link rel="stylesheet" href="<%= request.getContextPath() %>/style/lrpage/graindashboard.css" type="text/css">
		<title>會員註冊</title>
		<style>
				#captchaImage{cursor: pointer;vertical-align: middle;}
		</style>
		<script src="https://code.jquery.com/jquery-3.0.0.js" 
				integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" 
				crossorigin="anonymous"></script>
		<script>
			
			
			$(init);
			function init(){
				//alert('init');
				repopulateForm();
			}
			
			function repopulateForm(){
				<% if("POST".equals(request.getMethod())) {%>				
				$("input[name='userid']").val('<%= request.getParameter("userid")%>');
				$("input[name='name']").val('<%= request.getParameter("name")%>');
				$("input[name='email']").val('<%= request.getParameter("email")%>');
				$("input[name='birthday']").val('<%= request.getParameter("birthday")%>');
				$("input[name='gender'][value='<%=request.getParameter("gender")%>']").prop("checked", true);
					
				$("textarea[name='address']").val('<%= request.getParameter("address")%>');
				$("input[name='phone']").val('<%= request.getParameter("phone")%>');
				$("input[name='subscribed']").prop("checked", <%= request.getParameter("subscribed")!=null%>);
				
				$("select[name='bloodType']").val('<%= request.getParameter("bloodType")%>');
				<%}%>
			}
			
			function displayPassword(thisCheckBox){
				console.log(thisCheckBox.checked); //for test
				if(thisCheckBox.checked){
					$("input[name='password1']").attr('type','text');
					$("input[name='password2']").attr('type','text');
				}else{
					$("input[name='password1']").attr('type','password');
					$("input[name='password2']").attr('type','password');
				}				
			}
			
		</script>	
	</head>
	<%
		List<String> errorsList = (List<String>)request.getAttribute("error");
		%>
	<body>

		
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
                                  <h4 class="card-title">會員註冊</h4>
                                 
                                  <form  method='post' action='register.do'>
                        		    <div><%= errorsList==null?"":errorsList %></div>
							
							<div class="form-group">
                                          <label>帳號</label>
                                          <input class="form-control" type="text" name='userid'
                                           required pattern="[A-Z][12][0-9]{8}"placeholder="請輸入id或email" required>
                            </div>
                             <hr>
                            <div class="form-group">
                                          <label>姓名</label>
                                          <input class="form-control" type="text" name='name'
                                           placeholder="請輸入姓名" required>
                            </div>
                             <hr>
                            <div class="form-group">
                                          <label>密碼</label>
                                          <input class="form-control" type="password" name='password1'
                                          minlength="6" maxlength="20" placeholder="請輸入密碼(6~20個字)" required>
                            </div>
                             <hr>
                            <div class="form-group">
                                          <label>確認</label>
                                          <input class="form-control" type="password" name='password2'
                                          minlength="6" maxlength="20" placeholder="請再確認密碼(6~20個字)" required>
                                          <input type='checkbox' id='changePwdStatus' onchange="displayPassword(this)"><label>顯示密碼</label>
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
                                          <label>Email</label>
                                          <input class="form-control" type="email" name='email'
                                          equired placeholder='請輸入Email' required>
                            </div>
                             <hr>
                             <div class="form-group">
                                          <label>生日</label>
                                          <input class="form-control" type="date" name='birthday'
                                          required max='2010-07-14' value='2000-02-05'>
                            </div>
                             <hr>
                            <div class="form-group">
                                          <label>地址</label>
                                         <textarea name='address'></textarea>
                            </div>
                             <hr>
                             <div class="form-group">
                                          <label>電話</label>
                                          <input type='tel' name='phone'>
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
										 <input class="btn btn-primary btn-block" style="background-color: #ffda85;border-color: #ffda85;" 
										 type='submit' value="確定"> 
										 
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
				
	</body>
</html>



