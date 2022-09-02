<%@page import="java.util.List"%>
<%@ page pageEncoding="utf-8"	contentType="text/html; charset=big5" %>
<!DOCTYPE html>
<html>
	<head>
		<link href="style/vgb.css" rel="stylesheet">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta charset="UTF-8">
		<link rel="stylesheet" href="<%= request.getContextPath() %>/style/lrpage/graindashboard.css" type="text/css">
		<title>會員登入</title>
		<style>
			.errorMsg{color:darkred}		
		</style>
		<script>
			function displayPassword(thisCheckBox){
				console.log(thisCheckBox.checked); //for test
				if(thisCheckBox.checked){
					pwd.type='text';
				}else{
					pwd.type='password';
				}				
			}
			
			function refreshCaptcha(){				
				console.log(captchaImage.src);				
				captchaImage.src = 'images/captcha.png?xyz=' + new Date();
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
                                  <h4 class="card-title">Login</h4>
                                 
                                  <form  method='post' action='login.do'>
                                  <div  class='errorMsg'><%= errorsList!=null?errorsList:"" %></div>
                                  
                                      <div class="form-group">
                                          <label for='id'>帳號</label>
                                          <input id='id' type="text" class="form-control" name='id' placeholder="請輸入id或email" required>
                                      </div>
                                      
                                      <hr>
                                      
                                      <div class="form-group">
                                          <label for='pwd'>密碼
                                          </label>
                                          <input id='pwd' type='password' class="form-control" name='password' placeholder="請輸入密碼" required>
                                          <input type='checkbox' id='changePwdStatus' onchange="displayPassword(this)"><label>顯示密碼</label>
                                     
                                     </div>
                                     <hr>
                                         
                                       <div class="form-group">
                                          <label for='captcha'>驗證碼
                                          </label>
                                          <input id='captcha' type='text' class="form-control" name='captcha' placeholder="請輸入密碼" required autocomplete="off">
                                          <a href='javascript:refreshCaptcha()' >
										<img id='captchaImage' src='images/captcha.png' style='vertical-align:middle;' title='點選即可更新圖片'></a>   
                                          
                                          </div>
                                     <hr>
                                          
                                          
                                          <div class="text-right">
                                              <a href="password-reset.html" class="small">
                                                  Forgot Your Password?
                                              </a>
                                          </div>
                                      </div>
  
  
                                      <div class="form-group no-margin">
                                         
                                       <button class="btn btn-primary btn-block" style="background-color: #ffda85;border-color: #ffda85;"type='submit'>登入</button>
                                       
                                      </div>
                                      <div class="text-center mt-3 small">
                                          還沒有加入露營趣嗎? <a href="<%= request.getContextPath()%>/register.jsp">Sign Up</a>
                                     
                                      </div>
                                     <div>
                                     <footer class="footer mt-3">
                                     <div class="container-fluid">
                                     <div class="footer-content text-center small">
                                     <span class="text-muted">&copy; 2022 露營趣 GoCamping All Rights Reserved.</span>
                           
                                     </div>
                                      
                                  </form>
                                  
                              </div>
                          </div>
               
                          </div>
                          </div>
                          </div>

	</body>
</html>