<%@ page pageEncoding="UTF-8"%>
<%@ page import="java.io.*,java.util.*" %>
<!DOCTYPE html>
<html>
<head>
   <meta charset="UTF-8">
   <meta name="viewport" content="width=device-width, initial-scale=1" >
   <link rel="stylesheet" type="text/css" href="<%= request.getContextPath() %>/style/vgb.css">
   <title>EZShip Call Back</title>
</head>

<body>
      <jsp:include page="/subviews/header.jsp" />
      <article style='opacity: 0.3'>
          <%         

              //================================ 接收購物網站所需的各項參數 ==================================

              String processID = request.getParameter("processID") == null ? "" : request.getParameter("processID");  // 訂單編號

              String stCate = request.getParameter("stCate") == null ? "" : request.getParameter("stCate");  // 超商別

              String stCode = request.getParameter("stCode") == null ? "" : request.getParameter("stCode");  // 門市代碼

              String stName = request.getParameter("stName") == null ? "" : request.getParameter("stName");  // 門市名稱

              String stAddr = request.getParameter("stAddr") == null ? "" : request.getParameter("stAddr");  // 門市地址

              String stTel = request.getParameter("stTel") == null ? "" : request.getParameter("stTel");    // 門市電話

              String webPara = request.getParameter("webPara") == null ? "" : request.getParameter("webPara");  //選擇門市前check_out網頁中的輸入項內容

              String params[] = webPara.split("&");//取回原來結帳畫面的欄位值

              System.out.println(Arrays.toString(params));

              HashMap<String, String> paramsMap = new HashMap<>();

              if (params != null && params.length > 0) {

                  for (String data : params) {

                      int index = data.indexOf('=');

                      if(index>0){

                          String name = data.substring(0, index);

                          String value = java.net.URLDecoder.decode(data.substring(index + 1), "UTF-8");

                          paramsMap.put(name, value);

                      }

                  }

              }

              System.out.println("paramsMap = " + paramsMap);
          %>

          <form action="check_out.jsp" method="post" id="myForm">
              <input name="processID" type="text" value="<%=processID%>">
              <input name="stCate" type="text" value="<%=stCate%>">
              <input name="stCode" type="text" value="<%=stCode%>">
              <input name="stName" type="text" value="<%=stName%>">
              <input name="stAddr" type="text" value="<%=stAddr%>">
              <input name="stTel" type="text" value="<%=stTel%>">
              <input name="shippingAddress" type="text" value="<%=stName%>,<%=stAddr%>,店號:<%=stCode%>"> <!--shippingAddr必須與check_out.jsp中要帶入超商資料的欄位name一樣 -->
              <% for (String name : paramsMap.keySet()) {%>
              <input name="<%=name%>" type="text" value="<%= paramsMap.get(name)%>">
              <%}%>
              <input type='submit' value='回結帳畫面'>
              <script>
                 document.getElementById("myForm").submit();<!-- 測試完畢後，請將此行uncomment，讓資料立刻submit回check+out.jsp  -->
              </script>
          </form>
      </article>
      <%@include file="/subviews/footer.jsp" %>
</body>
</html>